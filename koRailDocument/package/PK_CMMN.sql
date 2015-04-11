/*------------------------------------------------------------------------------
-- ��ü �̸� : KORAIL.PK_CMMN
-- ���� ��¥ : 2014-11-10 ���� 6:54:41
-- ���������� ������ ��¥ : 2014-12-19 ���� 2:51:46
-- ���� : VALID
------------------------------------------------------------------------------*/
CREATE OR REPLACE PACKAGE KORAIL.PK_CMMN
AS
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
	);

    /**********************************************************
    * �̸�	   : SP_ID_CHECK
    * ����	   : �α��� ���ν���
    * �������̺� : MEMBER
    **********************************************************/
	PROCEDURE SP_ID_CHECK(
    	I_ID	IN	VARCHAR2	/*���̵�*/,

       	O_ID	OUT	VARCHAR2	/*���� ���̵�*/,

        ER_CODE OUT VARCHAR2	/*���� �ڵ�(0 : ����, 1 : ����)*/,
        ER_MSG 	OUT VARCHAR2	/*���� �޼���*/
    );

    /*CMMN_CODE ���̺��� ���� ���̺� TYPE*/
	TYPE T_CMMN_CODE IS TABLE OF CMMN_CODE%ROWTYPE;

    /**********************************************************
    * �̸�	   : FN_SLT_CMMN
    * ����	   : �����ڵ� ��ȸ �Լ�
    * �������̺� : CMMN_CODE_SE, CMMN_CODE
    **********************************************************/
    FUNCTION FN_SLT_CMMN(
    	I_SE_CODE		  IN VARCHAR2 /*�����ڵ�*/,
        I_CMMN_CODE_VALUE IN VARCHAR2 /*�ڵ尪*/
	)
    RETURN T_CMMN_CODE PIPELINED
    ;

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
    ;
END PK_CMMN;


