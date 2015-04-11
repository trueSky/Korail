/*------------------------------------------------------------------------------
-- ��ü �̸� : KORAIL.PK_CMMN
-- ���� ��¥ : 2014-11-10 ���� 6:55:18
-- ���������� ������ ��¥ : 2014-12-19 ���� 2:56:52
-- ���� : VALID
------------------------------------------------------------------------------*/
CREATE OR REPLACE PACKAGE BODY KORAIL.PK_CMMN AS
   /**********************************************************
    * �̸�	   : SP_LOGIN
    * ����	   : �α��� ���ν���
    * �������̺� : ADMIN, MEMBER
    **********************************************************/
	PROCEDURE SP_LOGIN(
   		I_TYPE	IN	VARCHAR2 	/*�α��� Ÿ��*/,
        I_ID	IN	VARCHAR2	/*���̵�*/,
        I_PW 	IN	VARCHAR2	/*��й�ȣ*/,

        O_NAME	OUT VARCHAR2	/*�α����� ȸ�� ��*/,

        ER_CODE OUT VARCHAR2	/*���� �ڵ�(0 : ����, 1 : ����)*/,
        ER_MSG 	OUT VARCHAR2	/*���� �޼���*/
	)
    IS

    BEGIN
    	IF I_TYPE = 'admin' THEN
        	BEGIN
            	SELECT	MNGR_NM /*������ ��*/
                INTO	O_NAME
                FROM	ADMIN	/*������*/
                WHERE	MNGR_ID = I_ID
                AND		MNGR_PASSWORD = I_PW
                ;
                EXCEPTION
                  WHEN NO_DATA_FOUND THEN
                      ER_CODE := '1';
                      ER_MSG := '�α��� ����';
                      ROLLBACK;
                      RETURN;
            END;
        ELSE
        	BEGIN
            	SELECT	NM		/*����*/
                INTO	O_NAME
                FROM	MEMBER	/*ȸ��*/
                WHERE	ID = I_ID
                AND		PASSWORD = I_PW
                ;
                EXCEPTION
                  WHEN NO_DATA_FOUND THEN
                      ER_CODE := '1';
                      ER_MSG := '�α��� ����';
                      ROLLBACK;
                      RETURN;
            END;
    	END IF;

        ER_CODE := '0';
        ER_MSG := '�α��� ����';

        EXCEPTION
    		WHEN OTHERS THEN
            	ER_CODE := '1';
              	ER_MSG := SQLCODE || '-' || SQLERRM;
                ROLLBACK;
                RETURN;
    END SP_LOGIN;

    /**********************************************************
    * �̸�	   : SP_ID_CHECK
    * ����	   : �α��� ���ν���
    * �������̺� : MEMBER
    **********************************************************/
	PROCEDURE SP_ID_CHECK(
    	I_ID	IN	VARCHAR2	/*���̵�*/,

       	O_ID	OUT	VARCHAR2	/* ���� ���̵� */,

        ER_CODE OUT VARCHAR2	/*���� �ڵ�(0 : ����, 1 : ����)*/,
        ER_MSG 	OUT VARCHAR2	/*���� �޼���*/
    )
    IS

    BEGIN
    	/**************************
                  ID CHECK
        ***************************/
    	BEGIN
          SELECT	ID
          INTO	O_ID
          FROM	MEMBER
          WHERE	ID = I_ID;

          EXCEPTION
        	WHEN NO_DATA_FOUND THEN
            	ER_CODE := '0';
       			ER_MSG	:= '��밡���� ���̵� �Դϴ�.';
                RETURN;
        END;

        ER_CODE := '1';
        ER_MSG	:= '�̹� ������� ���̵� �Դϴ�.';
        RETURN;

        EXCEPTION
        	WHEN OTHERS THEN
            	ER_CODE := '1';
        		ER_MSG	:= '��������';
                RETURN;
    END SP_ID_CHECK;

   /**********************************************************
    * �̸�	    : FN_SLT_CMMN
    * ����	   : �����ڵ� ��ȸ �Լ�
    * �������̺� : CMMN_CODE_SE, CMMN_CODE
    **********************************************************/
    FUNCTION FN_SLT_CMMN(
    	I_SE_CODE		  IN VARCHAR2 /*�����ڵ�*/,
        I_CMMN_CODE_VALUE IN VARCHAR2 /*�ڵ尪*/
    )
    RETURN T_CMMN_CODE PIPELINED
    IS
    	/*�����ڵ� �˻� �����ڵ� ���*/
    	CURSOR C_SE_CODE IS(
      		SELECT	CMMN_CODE			/*�����ڵ�*/,
        			CMMN_CODE_VALUE 	/*��*/
          	FROM	CMMN_CODE
        	WHERE	SE_CODE = I_SE_CODE
      	);

        /*�����ڵ� �˻� �ڵ尪 ���*/
    	CURSOR C_CMMN_CODE_VLAUE IS(
      		SELECT	CMMN_CODE			/*�����ڵ�*/,
        			CMMN_CODE_VALUE 	/*��*/
          	FROM	CMMN_CODE
        	WHERE	CMMN_CODE_VALUE = I_CMMN_CODE_VALUE
      	);

    	/*������ ���� �����ų ���̺� TYPE ����*/
   		SET_CMMN_CODE T_CMMN_CODE := T_CMMN_CODE();
    BEGIN
    	/*�����ڵ�� �˻�*/
    	IF I_CMMN_CODE_VALUE IS NULL THEN
        	BEGIN
            	FOR DATA IN C_SE_CODE LOOP
                  SET_CMMN_CODE.EXTEND;
                  SET_CMMN_CODE(SET_CMMN_CODE.COUNT).CMMN_CODE := DATA.CMMN_CODE;
                  SET_CMMN_CODE(SET_CMMN_CODE.COUNT).CMMN_CODE_VALUE := DATA.CMMN_CODE_VALUE;

                  PIPE ROW(SET_CMMN_CODE(SET_CMMN_CODE.COUNT));
                END LOOP
                ;
            END
            ;
        /*�ڵ� ������ �˻�*/
        ELSE
        	BEGIN
            	FOR DATA IN C_CMMN_CODE_VLAUE LOOP
                  SET_CMMN_CODE.EXTEND;
                  SET_CMMN_CODE(SET_CMMN_CODE.COUNT).CMMN_CODE := DATA.CMMN_CODE;
                  SET_CMMN_CODE(SET_CMMN_CODE.COUNT).CMMN_CODE_VALUE := DATA.CMMN_CODE_VALUE;

                  PIPE ROW(SET_CMMN_CODE(SET_CMMN_CODE.COUNT));
                END LOOP
                ;
            END
            ;
        END IF
        ;
	END FN_SLT_CMMN;

    /**********************************************************
    * �̸�	   : TO_CODE_VALUE
    * ����	   : �����ڵ带 �ڵ� ������ ��ȯ�ϴ� �Լ�
    * �������̺� : CMMN_CODE, STATN
    **********************************************************/
    FUNCTION TO_CODE_VALUE(
    	I_TABLE IN VARCHAR2 /*�˻� ���̺�*/,
    	I_CODE	IN VARCHAR2 /*��ȯ�� �ڵ�*/
    )
    RETURN VARCHAR2
    IS
    	V_CODE_VALUE VARCHAR2(30); /*�ڵ��� ��*/
    BEGIN
    	IF I_TABLE = 'CMMN_CODE' THEN
        	SELECT	CMMN_CODE_VALUE
        	INTO	V_CODE_VALUE
        	FROM	CMMN_CODE
        	WHERE	CMMN_CODE = I_CODE
        	;
        ELSIF I_TABLE = 'STATN' THEN
        	SELECT	STATN_NM
        	INTO	V_CODE_VALUE
        	FROM	STATN
        	WHERE	STATN_CODE = I_CODE
            ;
        END IF;

        RETURN V_CODE_VALUE;
    END TO_CODE_VALUE
    ;
END PK_CMMN;


