/*------------------------------------------------------------------------------
-- ��ü �̸� : KORAIL.PK_MEMBER_RESVE
-- ���� ��¥ : 2014-12-19 ���� 4:35:32
-- ���������� ������ ��¥ : 2015-01-14 ���� 7:19:15
-- ���� : VALID
------------------------------------------------------------------------------*/
CREATE OR REPLACE PACKAGE KORAIL.PK_MEMBER_RESVE
AS
    /*TABLE TYPE�� �� RECORD*/
	TYPE R_RESVE IS RECORD(
		RESVE_CODE		 VARCHAR2(30)	/*�����ڵ�*/,
		TRAIN_NO		 VARCHAR2(30)	/*������ȣ*/,
		TRAIN_KND		 VARCHAR2(30)	/*��������*/,
		START_STATN		 VARCHAR2(30)	/*��߿�*/,
		START_TM		 DATE			/*��߽ð�*/,
		ARVL_STATN		 VARCHAR2(30)	/*������*/,
		ARVL_TM			 DATE			/*�����ð�*/,
		RESVE_CO		 NUMBER(1)		/*����ż�*/,
        ALL_FR_AMOUNT	 NUMBER(10)		/*�ѿ��ӱݾ�*/,
        ALL_DSCNT_AMOUNT NUMBER(10)		/*�����αݾ�*/,
		ALL_RCPT_AMOUNT  NUMBER(10)		/*�ѿ����ݾ�*/
    );
	/*R_RESVE�� ���� TABLE TYPE*/
	TYPE T_RESVE IS TABLE OF R_RESVE;

    /*TABLE TYPE�� �� RECORD*/
	TYPE R_RESVE_RCRD IS RECORD(
		RESVE_CODE		 	VARCHAR2(30)	/*�����ڵ�*/,
		TRAIN_NO		 	VARCHAR2(30)	/*������ȣ*/,
		TRAIN_KND		 	VARCHAR2(30)	/*��������*/,
		START_STATN		 	VARCHAR2(30)	/*��߿�*/,
		START_TM		 	DATE			/*��߽ð�*/,
		ARVL_STATN		 	VARCHAR2(30)	/*������*/,
		ARVL_TM			 	DATE			/*�����ð�*/,
		RESVE_CO		 	NUMBER(1)		/*����ż�*/,
        SETLE_STTUS_CODE	VARCHAR2(30)	/*�������� �ڵ�*/,
        SETLE_STTUS_VALUE	VARCHAR2(30)	/*�������� ��*/,
       	SETLE_AMOUNT	 	NUMBER(10)		/*�����ݾ�*/
    );
	/*R_RESVE_RCRD ���� TABLE TYPE*/
	TYPE T_RESVE_RCRD IS TABLE OF R_RESVE_RCRD;

    /**********************************************************
    * �̸�        : SP_IST_DEATIL_RESVE
    * ����        : �󼼿��� ���
    * �������̺�  : RESVE, DETAIL_RESVE
    **********************************************************/
    PROCEDURE SP_IST_DEATIL_RESVE(
    	I_ROOM_KND		IN	VARCHAR2	/*��������*/,
        I_SEAT_NO		IN	VARCHAR2	/*�¼���ȣ*/,
        I_PSNGR_KND		IN	VARCHAR2	/*�°�����*/,
        I_DSPSN_GRAD	IN	VARCHAR2	/*����ε��*/,
        I_ROOM			IN	VARCHAR2	/*ȣ��*/,
        I_FR_AMOUNT		IN	VARCHAR2	/*���ӱݾ�*/,

        O_RESVE_CODE	OUT	VARCHAR2	/* ������ ���� �ڵ� */,

        ER_CODE		 	OUT VARCHAR2	/*���� �ڵ�(0 : ����, 1 : ����)*/,
        ER_MSG 			OUT VARCHAR2	/*���� �޼���*/
    );

    /*********************************************************************
    * �̸�        : FN_SLT_RESVE
    * ����        : ������ ���� ��ȸ
    * �������̺�  : TRAIN A, RESVE, DETAIL_RESVE, OPRAT, DETAIL_OPRAT
    *********************************************************************/
	FUNCTION FN_SLT_RESVE
    	(
        	I_RESVR_CODE IN VARCHAR2 /*�����ڵ�*/

        )
    RETURN T_RESVE PIPELINED
    ;

    /*********************************************************************
    * �̸�        : FN_SLT_RESVE_RCRD
    * ����        : ������ ���� ��Ȳ
    * �������̺�  : RESVE, TRAIN, OPRAT, SETLE
    *********************************************************************/
	FUNCTION FN_SLT_RESVE_RCRD
    	(
        	I_ID IN VARCHAR2 /*�ƾƵ�*/

        )
    RETURN T_RESVE_RCRD PIPELINED
    ;

    /**********************************************************
    * �̸�        : SP_DEL_RESVE
    * ����        : ���� ���
    * �������̺�  : RESVE, DETAIL_RESVE, SETLE, PINT
    **********************************************************/
    PROCEDURE SP_DEL_RESVE(
    	I_RESVE_CODE	IN VARCHAR2		/*�����ڵ�*/,

    	ER_CODE		 	OUT VARCHAR2	/*���� �ڵ�(0 : ����, 1 : ����)*/,
    	ER_MSG 			OUT VARCHAR2	/*���� �޼���*/
    );
END PK_MEMBER_RESVE;


