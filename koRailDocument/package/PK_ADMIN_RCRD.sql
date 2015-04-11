/*------------------------------------------------------------------------------
-- ��ü �̸� : KORAIL.PK_ADMIN_RCRD
-- ���� ��¥ : 2014-12-23 ���� 3:46:14
-- ���������� ������ ��¥ : 2015-01-14 ���� 11:16:37
-- ���� : VALID
------------------------------------------------------------------------------*/
CREATE OR REPLACE PACKAGE KORAIL.PK_ADMIN_RCRD
AS
    /*TABLE TYPE�� �� RECORD*/
	TYPE R_TCKT_RCRD IS RECORD(
    	OPRAT_CODE	        VARCHAR2(30),	/*�����ڵ�*/
        TCKT_TM				DATE,			/*��������*/
        TRAIN_NO            VARCHAR2(30),   /*������ȣ*/
        TRAIN_KND_VALUE     VARCHAR2(30),   /*�������� ��*/
        START_STATN_VALUE   VARCHAR2(30),   /*��߿� ��*/
        ARVL_STATN_VALUE    VARCHAR2(30),   /*������ ��*/
        START_TM	        DATE,	        /*��߽ð�*/
        ARVL_TM	            DATE,	        /*�����ð�*/
    	PRTCLR_SEAT_Y_CO	NUMBER(3)		/*Ư�� �¼���*/,
    	PRTCLR_ROOM_Y_CO	NUMBER(3)		/*����� Ư�� �¼���*/,
    	PRTCLR_SEAT_N_CO	NUMBER(3)		/*�Ϲݽ� �¼���*/,
    	PRTCLR_ROOM_N_CO	NUMBER(3)		/*����� �Ϲݽ� �¼���*/
    );
	/*R_TCKT_RCRD�� ���� TABLE TYPE*/
	TYPE T_TCKT_RCRD IS TABLE OF R_TCKT_RCRD;

    /*TABLE TYPE�� �� RECORD*/
	TYPE R_TRAIN_RCRD IS RECORD(
		RESVE_CODE			VARCHAR2(30)	/*�����ڵ�*/,
		REGISTER			VARCHAR2(30)	/*�����ڸ�*/,
		RESVE_CO			NUMBER(1)		/*�� �ο���*/,
        ELDRLY_CO			NUMBER(1)		/*��δ���� ��*/,
        DSPSN_CO			NUMBER(1)		/*����� ��*/,
		CHLD_CO				NUMBER(1)		/*��� ��*/,
        ALL_RCPT_AMOUNT		NUMBER(10)		/*�����ݾ�*/,
		SETLE_STTUS			VARCHAR2(20)	/*�����ݿ���*/,
		USE_PINT			VARCHAR2(7)		/*�������Ʈ*/,
		DSCNT_AMOUNT		NUMBER(10)		/*���αݿ�*/,
		SETLE_AMOUNT		NUMBER(10)		/*�����ݾ�*/
    );
    /*R_TRAIN_RCRD�� ���� TABLE TYPE*/
	TYPE T_TRAIN_RCRD IS TABLE OF R_TRAIN_RCRD;

    /**********************************************************
    * �̸�        : FN_SLT_TCKT_RCRD
    * ����        : ������ �߱� ��Ȳ
    * �������̺�  : OPRAT, TARIN, ROOM
    **********************************************************/
	FUNCTION FN_SLT_TCKT_RCRD(
		I_TRAIN_KND_CODE	IN	VARCHAR2 	/*��������*/,
        I_TCKT_TM			IN	VARCHAR2 	/*��������*/
	)
    RETURN T_TCKT_RCRD PIPELINED
    ;

    /**********************************************************
    * �̸�        : FN_SLT_TRAIN_RCRD
    * ����        : ������ �°� ��Ȳ
    * �������̺�  : RESVE, DETAIL_RESVE, SETLE, OPRAT
    **********************************************************/
	FUNCTION FN_SLT_TRAIN_RCRD(
		I_TRAIN_KND_CODE	IN	VARCHAR2 	/*��������*/,
        I_TCKT_TM			IN	VARCHAR2 	/*��������*/
	)
    RETURN T_TRAIN_RCRD PIPELINED
    ;
END PK_ADMIN_RCRD;


