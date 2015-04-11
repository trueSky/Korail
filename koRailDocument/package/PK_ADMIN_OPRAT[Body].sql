/*------------------------------------------------------------------------------
-- ��ü �̸� : KORAIL.PK_ADMIN_OPRAT
-- ���� ��¥ : 2014-11-15 ���� 8:20:17
-- ���������� ������ ��¥ : 2014-12-23 ���� 4:26:44
-- ���� : VALID
------------------------------------------------------------------------------*/
CREATE OR REPLACE PACKAGE BODY KORAIL.PK_ADMIN_OPRAT AS
	/**********************************************************
    * �̸�        : FN_SLT_OPRAT
    * ����        : �������� ��ȸ �Լ�
    * �������̺�  : OPRAT, TARIN
    **********************************************************/
	FUNCTION FN_SLT_OPRAT(
    	I_TRAIN_KND		IN	VARCHAR2 	/*��������*/,
		I_TRAIN_NO		IN	VARCHAR2	/*������ȣ*/,
        I_OPRAT_CODE	IN	VARCHAR2	/*�����ڵ�*/
    )
    RETURN T_OPRAT PIPELINED
    IS
    	/*������ȣ�� �˻�*/
    	CURSOR C_TRAIN_NO IS(
			SELECT	B.OPRAT_CODE	/*�����ڵ�*/,
            		A.TRAIN_CODE	/*�����ڵ�*/,
       				A.TRAIN_NO		/*������ȣ*/,

                    /*�������� �ڵ�, ���������ڵ� ��*/
       				A.TRAIN_KND AS TRAIN_KND_CODE,
       				PK_CMMN.TO_CODE_VALUE('CMMN_CODE', A.TRAIN_KND) AS TRAIN_KND_VALUE,

                    /*��߿� �ڵ�, ��߿��ڵ� ��*/
       				B.START_STATN AS START_STATN_CODE,
       				 PK_CMMN.TO_CODE_VALUE('STATN', B.START_STATN) AS START_STATN_VALUE,

                    /*������ �ڵ�, �������ڵ� ��*/
       				B.ARVL_STATN AS ARVL_STATN_CODE,
       				 PK_CMMN.TO_CODE_VALUE('STATN', B.ARVL_STATN) AS ARVL_STATN_VALUE,

                	B.START_TM	/*��߽ð�*/,
       				B.ARVL_TM	/*�����ð�*/,

                    /*�뼱�ڵ�, �뼱�ڵ� ��*/
       				B.ROUTE_CODE,
       				PK_CMMN.TO_CODE_VALUE('CMMN_CODE', B.ROUTE_CODE) AS ROUTE_VALUE,

       				B.DISTNC	/*�Ÿ�*/,
       				B.FARE		/*���*/,
       				B.REGISTER	/*�����*/,
       				B.RGSDE		/*�����*/,
       				B.UPDUSR	/*������*/,
       				B.UPDDE		/*������*/
  			FROM	TRAIN A		/*����*/,
       				OPRAT B		/*����*/
 			WHERE	A.TRAIN_CODE = B.TRAIN_CODE
 			AND  	A.TRAIN_NO LIKE I_TRAIN_NO || '%'
        );

        /*���������� �˻�*/
    	CURSOR C_TRAIN_KND IS(
			SELECT	B.OPRAT_CODE	/*�����ڵ�*/,
            		A.TRAIN_CODE	/*�����ڵ�*/,
       				A.TRAIN_NO		/*������ȣ*/,

                    /*�������� �ڵ�, ���������ڵ� ��*/
       				A.TRAIN_KND AS TRAIN_KND_CODE,
       				PK_CMMN.TO_CODE_VALUE('CMMN_CODE', A.TRAIN_KND) AS TRAIN_KND_VALUE,

                    /*��߿� �ڵ�, ��߿��ڵ� ��*/
       				B.START_STATN AS START_STATN_CODE,
       				 PK_CMMN.TO_CODE_VALUE('STATN', B.START_STATN) AS START_STATN_VALUE,

                    /*������ �ڵ�, �������ڵ� ��*/
       				B.ARVL_STATN AS ARVL_STATN_CODE,
       				 PK_CMMN.TO_CODE_VALUE('STATN', B.ARVL_STATN) AS ARVL_STATN_VALUE,

                	B.START_TM	/*��߽ð�*/,
       				B.ARVL_TM	/*�����ð�*/,

                    /*�뼱�ڵ�, �뼱�ڵ� ��*/
       				B.ROUTE_CODE,
       				PK_CMMN.TO_CODE_VALUE('CMMN_CODE', B.ROUTE_CODE) AS ROUTE_VALUE,

       				B.DISTNC	/*�Ÿ�*/,
       				B.FARE		/*���*/,
       				B.REGISTER	/*�����*/,
       				B.RGSDE		/*�����*/,
       				B.UPDUSR	/*������*/,
       				B.UPDDE		/*������*/
  			FROM	TRAIN A		/*����*/,
       				OPRAT B		/*����*/
 			WHERE	A.TRAIN_CODE = B.TRAIN_CODE
 			AND  	A.TRAIN_KND = I_TRAIN_KND
        );

    	/*�����ڵ�� �˻�*/
    	CURSOR C_OPRAT_CODE IS(
			SELECT	B.OPRAT_CODE	/*�����ڵ�*/,
            		A.TRAIN_CODE	/*�����ڵ�*/,
       				A.TRAIN_NO		/*������ȣ*/,

                    /*�������� �ڵ�, ���������ڵ� ��*/
       				A.TRAIN_KND AS TRAIN_KND_CODE,
       				PK_CMMN.TO_CODE_VALUE('CMMN_CODE', A.TRAIN_KND) AS TRAIN_KND_VALUE,

                    /*��߿� �ڵ�, ��߿��ڵ� ��*/
       				B.START_STATN AS START_STATN_CODE,
       				 PK_CMMN.TO_CODE_VALUE('STATN', B.START_STATN) AS START_STATN_VALUE,

                    /*������ �ڵ�, �������ڵ� ��*/
       				B.ARVL_STATN AS ARVL_STATN_CODE,
       				 PK_CMMN.TO_CODE_VALUE('STATN', B.ARVL_STATN) AS ARVL_STATN_VALUE,

                	B.START_TM	/*��߽ð�*/,
       				B.ARVL_TM	/*�����ð�*/,

                    /*�뼱�ڵ�, �뼱�ڵ� ��*/
       				B.ROUTE_CODE,
       				PK_CMMN.TO_CODE_VALUE('CMMN_CODE', B.ROUTE_CODE) AS ROUTE_VALUE,

       				B.DISTNC	/*�Ÿ�*/,
       				B.FARE		/*���*/,
       				B.REGISTER	/*�����*/,
       				B.RGSDE		/*�����*/,
       				B.UPDUSR	/*������*/,
       				B.UPDDE		/*������*/
  			FROM	TRAIN A		/*����*/,
       				OPRAT B		/*����*/
 			WHERE	A.TRAIN_CODE = B.TRAIN_CODE
 			AND  	OPRAT_CODE = I_OPRAT_CODE
        );

        /*������ ���� �����ų ���̺� TYPE ����*/
        SET_OPRAT T_OPRAT := T_OPRAT();
	BEGIN
    	/*SET_OPRAT�� C_TRAIN_KND�� �����͸� ����*/
    	IF I_TRAIN_NO IS NOT NULL THEN
        	FOR DATA IN C_TRAIN_NO LOOP
            	SET_OPRAT.EXTEND;
                SET_OPRAT(SET_OPRAT.COUNT).OPRAT_CODE := DATA.OPRAT_CODE;
                SET_OPRAT(SET_OPRAT.COUNT).TRAIN_CODE := DATA.TRAIN_CODE;
                SET_OPRAT(SET_OPRAT.COUNT).TRAIN_NO := DATA.TRAIN_NO;
                SET_OPRAT(SET_OPRAT.COUNT).TRAIN_KND_CODE := DATA.TRAIN_KND_CODE;
                SET_OPRAT(SET_OPRAT.COUNT).TRAIN_KND_VALUE := DATA.TRAIN_KND_VALUE;
                SET_OPRAT(SET_OPRAT.COUNT).START_STATN_CODE := DATA.START_STATN_CODE;
                SET_OPRAT(SET_OPRAT.COUNT).START_STATN_VALUE := DATA.START_STATN_VALUE;
                SET_OPRAT(SET_OPRAT.COUNT).ARVL_STATN_CODE := DATA.ARVL_STATN_CODE;
				SET_OPRAT(SET_OPRAT.COUNT).ARVL_STATN_VALUE := DATA.ARVL_STATN_VALUE;
				SET_OPRAT(SET_OPRAT.COUNT).START_TM := DATA.START_TM;
				SET_OPRAT(SET_OPRAT.COUNT).ARVL_TM := DATA.ARVL_TM;
				SET_OPRAT(SET_OPRAT.COUNT).ROUTE_CODE := DATA.ROUTE_CODE;
				SET_OPRAT(SET_OPRAT.COUNT).ROUTE_VALUE := DATA.ROUTE_VALUE;
				SET_OPRAT(SET_OPRAT.COUNT).DISTNC := DATA.DISTNC;
				SET_OPRAT(SET_OPRAT.COUNT).FARE := DATA.FARE;
				SET_OPRAT(SET_OPRAT.COUNT).REGISTER := DATA.REGISTER;
				SET_OPRAT(SET_OPRAT.COUNT).RGSDE := DATA.RGSDE;
				SET_OPRAT(SET_OPRAT.COUNT).UPDUSR := DATA.UPDUSR;
				SET_OPRAT(SET_OPRAT.COUNT).UPDDE := DATA.UPDDE;
                PIPE ROW(SET_OPRAT(SET_OPRAT.COUNT));
          	END LOOP
          	;
          /*SET_OPRAT�� C_OPRAT_CODE�� �����͸� ����*/
          ELSIF I_OPRAT_CODE IS NOT NULL THEN
          	FOR DATA IN C_OPRAT_CODE LOOP
            	SET_OPRAT.EXTEND;
                SET_OPRAT(SET_OPRAT.COUNT).OPRAT_CODE := DATA.OPRAT_CODE;
                SET_OPRAT(SET_OPRAT.COUNT).TRAIN_CODE := DATA.TRAIN_CODE;
                SET_OPRAT(SET_OPRAT.COUNT).TRAIN_NO := DATA.TRAIN_NO;
                SET_OPRAT(SET_OPRAT.COUNT).TRAIN_KND_CODE := DATA.TRAIN_KND_CODE;
                SET_OPRAT(SET_OPRAT.COUNT).TRAIN_KND_VALUE := DATA.TRAIN_KND_VALUE;
                SET_OPRAT(SET_OPRAT.COUNT).START_STATN_CODE := DATA.START_STATN_CODE;
                SET_OPRAT(SET_OPRAT.COUNT).START_STATN_VALUE := DATA.START_STATN_VALUE;
                SET_OPRAT(SET_OPRAT.COUNT).ARVL_STATN_CODE := DATA.ARVL_STATN_CODE;
				SET_OPRAT(SET_OPRAT.COUNT).ARVL_STATN_VALUE := DATA.ARVL_STATN_VALUE;
				SET_OPRAT(SET_OPRAT.COUNT).START_TM := DATA.START_TM;
				SET_OPRAT(SET_OPRAT.COUNT).ARVL_TM := DATA.ARVL_TM;
				SET_OPRAT(SET_OPRAT.COUNT).ROUTE_CODE := DATA.ROUTE_CODE;
				SET_OPRAT(SET_OPRAT.COUNT).ROUTE_VALUE := DATA.ROUTE_VALUE;
				SET_OPRAT(SET_OPRAT.COUNT).DISTNC := DATA.DISTNC;
				SET_OPRAT(SET_OPRAT.COUNT).FARE := DATA.FARE;
				SET_OPRAT(SET_OPRAT.COUNT).REGISTER := DATA.REGISTER;
				SET_OPRAT(SET_OPRAT.COUNT).RGSDE := DATA.RGSDE;
				SET_OPRAT(SET_OPRAT.COUNT).UPDUSR := DATA.UPDUSR;
				SET_OPRAT(SET_OPRAT.COUNT).UPDDE := DATA.UPDDE;
                PIPE ROW(SET_OPRAT(SET_OPRAT.COUNT));
          	END LOOP
          	;
          /*SET_OPRAT�� C_TRAIN_KND�� �����͸� ����*/
          ELSE
          	FOR DATA IN C_TRAIN_KND LOOP
            	SET_OPRAT.EXTEND;
                SET_OPRAT(SET_OPRAT.COUNT).OPRAT_CODE := DATA.OPRAT_CODE;
                SET_OPRAT(SET_OPRAT.COUNT).TRAIN_CODE := DATA.TRAIN_CODE;
                SET_OPRAT(SET_OPRAT.COUNT).TRAIN_NO := DATA.TRAIN_NO;
                SET_OPRAT(SET_OPRAT.COUNT).TRAIN_KND_CODE := DATA.TRAIN_KND_CODE;
                SET_OPRAT(SET_OPRAT.COUNT).TRAIN_KND_VALUE := DATA.TRAIN_KND_VALUE;
                SET_OPRAT(SET_OPRAT.COUNT).START_STATN_CODE := DATA.START_STATN_CODE;
                SET_OPRAT(SET_OPRAT.COUNT).START_STATN_VALUE := DATA.START_STATN_VALUE;
                SET_OPRAT(SET_OPRAT.COUNT).ARVL_STATN_CODE := DATA.ARVL_STATN_CODE;
				SET_OPRAT(SET_OPRAT.COUNT).ARVL_STATN_VALUE := DATA.ARVL_STATN_VALUE;
				SET_OPRAT(SET_OPRAT.COUNT).START_TM := DATA.START_TM;
				SET_OPRAT(SET_OPRAT.COUNT).ARVL_TM := DATA.ARVL_TM;
				SET_OPRAT(SET_OPRAT.COUNT).ROUTE_CODE := DATA.ROUTE_CODE;
				SET_OPRAT(SET_OPRAT.COUNT).ROUTE_VALUE := DATA.ROUTE_VALUE;
				SET_OPRAT(SET_OPRAT.COUNT).DISTNC := DATA.DISTNC;
				SET_OPRAT(SET_OPRAT.COUNT).FARE := DATA.FARE;
				SET_OPRAT(SET_OPRAT.COUNT).REGISTER := DATA.REGISTER;
				SET_OPRAT(SET_OPRAT.COUNT).RGSDE := DATA.RGSDE;
				SET_OPRAT(SET_OPRAT.COUNT).UPDUSR := DATA.UPDUSR;
				SET_OPRAT(SET_OPRAT.COUNT).UPDDE := DATA.UPDDE;
                PIPE ROW(SET_OPRAT(SET_OPRAT.COUNT));
          	END LOOP
          	;
        END IF;
    END FN_SLT_OPRAT
    ;

    /**********************************************************
    * �̸�        : FN_SLT_DETAIL_OPRAT
    * ����        : �󼼿������� ��ȸ �Լ�
    * �������̺�  : DETAIL_OPRAT
    **********************************************************/
	FUNCTION FN_SLT_DETAIL_OPRAT(
		I_OPRAT_CODE IN	VARCHAR2	/*�����ڵ�*/
    )
    RETURN T_DETAIL_OPRAT PIPELINED
    IS
    	/*���������� �󼼿������� �˻�*/
    	CURSOR C_OPRAT_CODE IS(
			SELECT	DETAIL_OPRAT_CODE	/*�󼼿����ڵ�*/,
                    OPRAT_CODE			/*�����ڵ�*/,

                    /*��߿� �ڵ�, ��߿��ڵ� ��*/
                    START_STATN AS START_STATN_CODE,
                    PK_CMMN.TO_CODE_VALUE('STATN', START_STATN) AS START_STATN_VALUE,

                    /*������ �ڵ�, �������ڵ� ��*/
                    ARVL_STATN AS ARVL_STATN_CODE,
                    PK_CMMN.TO_CODE_VALUE('STATN', ARVL_STATN) AS ARVL_STATN_VALUE,

                    START_TM	/*��߽ð�*/,
                    ARVL_TM		/*�����ð�*/,

                    /*������ �ڵ�, �������ڵ� ��*/
                    PRV_STATN AS PRV_STATN_CODE,
            		PK_CMMN.TO_CODE_VALUE('STATN', PRV_STATN) AS PRV_STATN_VALUE,

                    /*������ �ڵ�, �������ڵ� ��*/
                    NXT_STATN AS NXT_STATN_CODE,
                    PK_CMMN.TO_CODE_VALUE('STATN', NXT_STATN) AS NXT_STATN_VALUE,

                    PRV_DISTNC			/*�������Ÿ�*/,
                    NXT_DISTNC			/*�������Ÿ�*/,
                    REGISTER			/*�����*/,
                    UPDUSR				/*������*/,
                    RGSDE				/*�����*/,
                    UPDDE				/*������*/
            FROM	DETAIL_OPRAT		/*�󼼿���*/
			WHERE	OPRAT_CODE = I_OPRAT_CODE
        );

        /*������ ���� �����ų ���̺� TYPE ����*/
        SET_DETAIL_OPRAT T_DETAIL_OPRAT := T_DETAIL_OPRAT();
	BEGIN
    	/*SET_DETAIL_OPRAT�� C_OPRAT_CODE�� �����͸� ����*/
        FOR DATA IN C_OPRAT_CODE LOOP
            SET_DETAIL_OPRAT.EXTEND;
            SET_DETAIL_OPRAT(SET_DETAIL_OPRAT.COUNT).DETAIL_OPRAT_CODE := DATA.DETAIL_OPRAT_CODE;
            SET_DETAIL_OPRAT(SET_DETAIL_OPRAT.COUNT).OPRAT_CODE := DATA.OPRAT_CODE;
            SET_DETAIL_OPRAT(SET_DETAIL_OPRAT.COUNT).START_STATN_CODE := DATA.START_STATN_CODE;
            SET_DETAIL_OPRAT(SET_DETAIL_OPRAT.COUNT).START_STATN_VALUE := DATA.START_STATN_VALUE;
            SET_DETAIL_OPRAT(SET_DETAIL_OPRAT.COUNT).ARVL_STATN_CODE := DATA.ARVL_STATN_CODE;
            SET_DETAIL_OPRAT(SET_DETAIL_OPRAT.COUNT).ARVL_STATN_VALUE := DATA.ARVL_STATN_VALUE;
            SET_DETAIL_OPRAT(SET_DETAIL_OPRAT.COUNT).START_TM := DATA.START_TM;
            SET_DETAIL_OPRAT(SET_DETAIL_OPRAT.COUNT).ARVL_TM := DATA.ARVL_TM;
        	SET_DETAIL_OPRAT(SET_DETAIL_OPRAT.COUNT).PRV_STATN_CODE := DATA.PRV_STATN_CODE;
            SET_DETAIL_OPRAT(SET_DETAIL_OPRAT.COUNT).PRV_STATN_VALUE := DATA.PRV_STATN_VALUE;
            SET_DETAIL_OPRAT(SET_DETAIL_OPRAT.COUNT).NXT_STATN_CODE := DATA.NXT_STATN_CODE;
            SET_DETAIL_OPRAT(SET_DETAIL_OPRAT.COUNT).NXT_STATN_VALUE := DATA.NXT_STATN_VALUE;
            SET_DETAIL_OPRAT(SET_DETAIL_OPRAT.COUNT).PRV_DISTNC := DATA.PRV_DISTNC;
            SET_DETAIL_OPRAT(SET_DETAIL_OPRAT.COUNT).NXT_DISTNC := DATA.NXT_DISTNC;
            SET_DETAIL_OPRAT(SET_DETAIL_OPRAT.COUNT).REGISTER := DATA.REGISTER;
            SET_DETAIL_OPRAT(SET_DETAIL_OPRAT.COUNT).RGSDE := DATA.RGSDE;
            SET_DETAIL_OPRAT(SET_DETAIL_OPRAT.COUNT).UPDUSR := DATA.UPDUSR;
            SET_DETAIL_OPRAT(SET_DETAIL_OPRAT.COUNT).UPDDE := DATA.UPDDE;
            PIPE ROW(SET_DETAIL_OPRAT(SET_DETAIL_OPRAT.COUNT));
        END LOOP
        ;
    END FN_SLT_DETAIL_OPRAT
    ;
END PK_ADMIN_OPRAT;


