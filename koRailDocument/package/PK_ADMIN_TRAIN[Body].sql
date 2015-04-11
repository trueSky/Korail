/*------------------------------------------------------------------------------
-- ��ü �̸� : KORAIL.PK_ADMIN_TRAIN
-- ���� ��¥ : 2014-11-13 ���� 7:55:58
-- ���������� ������ ��¥ : 2014-11-16 ���� 10:45:06
-- ���� : VALID
------------------------------------------------------------------------------*/
CREATE OR REPLACE PACKAGE BODY KORAIL.PK_ADMIN_TRAIN AS
    /**********************************************************
    * �̸�	   : FN_SLT_TRAIN
    * ����	   : ���� ��ȸ �Լ�
    * �������̺�	: TRAIN
	**********************************************************/
	FUNCTION FN_SLT_TRAIN(
    	I_TRAIN_KND	IN	VARCHAR2 	/*��������*/,
		I_TRAIN_NO	IN	VARCHAR2	/*������ȣ*/
    )
    RETURN T_TRAIN PIPELINED
    IS
    	/*������ȣ�� �˻�*/
    	CURSOR C_TRAIN_KND IS(
			SELECT	TRAIN_CODE	/*�����ڵ�*/,
        			TRAIN_KND	/*��������*/,
  					TRAIN_NO	/*������ȣ*/,
                	REGISTER	/*�����*/,
                	UPDUSR		/*������*/,
		        	RGSDE 	 	/*������*/,
	        		UPDDE		/*������*/
            FROM	TRAIN		/*����*/
            WHERE	TRAIN_KND = I_TRAIN_KND
        );

		/*������ȣ�� �˻�*/
        CURSOR C_TRAIN_NO IS(
        	SELECT	TRAIN_CODE	/*�����ڵ�*/,
        			TRAIN_KND	/*��������*/,
  					TRAIN_NO	/*������ȣ*/,
                	REGISTER	/*�����*/,
                	UPDUSR		/*������*/,
		        	RGSDE 	 	/*������*/,
	        		UPDDE		/*������*/
            FROM	TRAIN		/*����*/
            WHERE	TRAIN_NO LIKE '%'|| I_TRAIN_NO || '%'
        );

        /*������ ���� �����ų ���̺� TYPE ����*/
        SET_TRAIN T_TRAIN := T_TRAIN();
	BEGIN
    	/*SET_TRAIN�� C_TRAIN_KND�� �����͸� ����*/
    	IF I_TRAIN_NO IS NULL THEN
        	FOR DATA IN C_TRAIN_KND LOOP
            	SET_TRAIN.EXTEND;
                SET_TRAIN(SET_TRAIN.COUNT).TRAIN_CODE := DATA.TRAIN_CODE;
                SET_TRAIN(SET_TRAIN.COUNT).TRAIN_KND := DATA.TRAIN_KND;
                SET_TRAIN(SET_TRAIN.COUNT).TRAIN_NO := DATA.TRAIN_NO;
                SET_TRAIN(SET_TRAIN.COUNT).REGISTER := DATA.REGISTER;
                SET_TRAIN(SET_TRAIN.COUNT).UPDUSR := DATA.UPDUSR;
                SET_TRAIN(SET_TRAIN.COUNT).RGSDE := DATA.RGSDE;
                SET_TRAIN(SET_TRAIN.COUNT).UPDDE := DATA.UPDDE;

            	PIPE ROW(SET_TRAIN(SET_TRAIN.COUNT));
          	END LOOP
          	;
          /*SET_TRAIN�� C_TRAIN_NO�� �����͸� ����*/
          ELSE
          	FOR DATA IN C_TRAIN_NO LOOP
            	SET_TRAIN.EXTEND;
                SET_TRAIN(SET_TRAIN.COUNT).TRAIN_CODE := DATA.TRAIN_CODE;
                SET_TRAIN(SET_TRAIN.COUNT).TRAIN_KND := DATA.TRAIN_KND;
                SET_TRAIN(SET_TRAIN.COUNT).TRAIN_NO := DATA.TRAIN_NO;
                SET_TRAIN(SET_TRAIN.COUNT).REGISTER := DATA.REGISTER;
                SET_TRAIN(SET_TRAIN.COUNT).UPDUSR := DATA.UPDUSR;
                SET_TRAIN(SET_TRAIN.COUNT).RGSDE := DATA.RGSDE;
                SET_TRAIN(SET_TRAIN.COUNT).UPDDE := DATA.UPDDE;

            	PIPE ROW(SET_TRAIN(SET_TRAIN.COUNT));
          	END LOOP
          	;
        END IF;
    END FN_SLT_TRAIN
    ;
END PK_ADMIN_TRAIN;


