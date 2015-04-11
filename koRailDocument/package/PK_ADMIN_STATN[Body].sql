/*------------------------------------------------------------------------------
-- ��ü �̸� : KORAIL.PK_ADMIN_STATN
-- ���� ��¥ : 2014-11-09 ���� 7:22:45
-- ���������� ������ ��¥ : 2014-11-16 ���� 10:44:33
-- ���� : VALID
------------------------------------------------------------------------------*/
CREATE OR REPLACE PACKAGE BODY KORAIL.PK_ADMIN_STATN AS
    /**********************************************************
    * �̸�	   : FN_SLT_STATN
    * ����	   : �� ��ȸ �Լ�
    * �������̺�	: STATN
    **********************************************************/
	FUNCTION FN_SLT_STATN(
    	I_AREA_CODE	IN	VARCHAR2 	/*�����ڵ�*/,
		I_STATN_NM	IN	VARCHAR2	/*�˻���*/
    )
    RETURN T_STATN PIPELINED
    IS
    	/*�������� �˻�*/
    	CURSOR C_AREA IS(
          SELECT	B.STATN_CODE 				/*���ڵ�*/,
                    A.CMMN_CODE AS AREA			/*�����ڵ�*/,
                	B.STATN_NM	 				/*�� ��*/,
                	B.REGISTER	 				/*�����*/,
                	B.UPD_USER	 				/*������*/,
		        	B.RGSDE 	 				/*������*/,
	        		B.UPDDE		 				/*������*/
            FROM	CMMN_CODE A  				/*�����ڵ�*/,
            		STATN B		 				/*��*/
            WHERE	A.CMMN_CODE = B.AREA_CODE
            AND		B.AREA_CODE = I_AREA_CODE
        );

		/*�� ������ �˻�*/
        CURSOR C_STATN_MN IS(
        	SELECT	B.STATN_CODE 				/*���ڵ�*/,
            		A.CMMN_CODE AS AREA			/*�����ڵ�*/,
                	B.STATN_NM	 				/*�� ��*/,
                	B.REGISTER	 				/*�����*/,
                	B.UPD_USER	 				/*������*/,
		        	B.RGSDE 	 				/*������*/,
	        		B.UPDDE		 				/*������*/
            FROM	CMMN_CODE A  				/*�����ڵ�*/,
            		STATN B		 				/*��*/
            WHERE	A.CMMN_CODE = B.AREA_CODE
            AND		B.STATN_NM LIKE '%'|| I_STATN_NM || '%'
        );

        /*������ ���� �����ų ���̺� TYPE ����*/
        SET_STATN T_STATN := T_STATN();
	BEGIN
    	/*SET_STATN�� C_AREA�� �����͸� ����*/
    	IF I_STATN_NM IS NULL THEN
        	FOR DATA IN C_AREA LOOP
            	SET_STATN.EXTEND;
                SET_STATN(SET_STATN.COUNT).STATN_CODE := DATA.STATN_CODE;
                SET_STATN(SET_STATN.COUNT).AREA_CODE := DATA.AREA;
                SET_STATN(SET_STATN.COUNT).STATN_NM := DATA.STATN_NM;
                SET_STATN(SET_STATN.COUNT).REGISTER := DATA.REGISTER;
                SET_STATN(SET_STATN.COUNT).UPD_USER := DATA.UPD_USER;
                SET_STATN(SET_STATN.COUNT).RGSDE := DATA.RGSDE;
                SET_STATN(SET_STATN.COUNT).UPDDE := DATA.UPDDE;

            	PIPE ROW(SET_STATN(SET_STATN.COUNT));
          	END LOOP
          	;
          /*SET_STATN�� C_STATN_MN�� �����͸� ����*/
          ELSE
          	FOR DATA IN C_STATN_MN LOOP
                SET_STATN.EXTEND;
                SET_STATN(SET_STATN.COUNT).STATN_CODE := DATA.STATN_CODE;
                SET_STATN(SET_STATN.COUNT).AREA_CODE := DATA.AREA;
                SET_STATN(SET_STATN.COUNT).STATN_NM := DATA.STATN_NM;
                SET_STATN(SET_STATN.COUNT).REGISTER := DATA.REGISTER;
                SET_STATN(SET_STATN.COUNT).UPD_USER := DATA.UPD_USER;
                SET_STATN(SET_STATN.COUNT).RGSDE := DATA.RGSDE;
                SET_STATN(SET_STATN.COUNT).UPDDE := DATA.UPDDE;

                PIPE ROW(SET_STATN(SET_STATN.COUNT));
            END LOOP
            ;
        END IF;
    END FN_SLT_STATN
    ;
END PK_ADMIN_STATN;


