/*------------------------------------------------------------------------------
-- ��ü �̸� : KORAIL.PK_MEMBER_TCKT
-- ���� ��¥ : 2015-01-13 ���� 12:13:43
-- ���������� ������ ��¥ : 2015-01-13 ���� 4:54:21
-- ���� : VALID
------------------------------------------------------------------------------*/
CREATE OR REPLACE PACKAGE KORAIL.PK_MEMBER_TCKT
AS
	/*TABLE TYPE�� �� RECORD*/
	TYPE R_TCKT IS RECORD(
		OPRAT_CODE					VARCHAR2(30) /*�����ڵ�*/,
        TRAIN_NO					VARCHAR2(30) /*������ȣ*/,
    	TRAIN_KND_CODE				VARCHAR2(30) /*���������ڵ�*/,
        TRAIN_KND_VALUE				VARCHAR2(30) /*����������*/,
		START_STATN_CODE 			VARCHAR2(30) /*��߿��ڵ�*/,
		START_STATN_VALUE		 	VARCHAR2(30) /*��߿���*/,
		START_TM					DATE		 /*��߽ð�*/,
        ARVL_STATN_CODE 			VARCHAR2(30) /*�������ڵ�*/,
		ARVL_STATN_VALUE			VARCHAR2(30) /*��������*/,
  		ARVL_TM						DATE		 /*�����ð�*/,
        PRTCLR_SEAT_Y_CO			NUMBER(3)	/*Ư�� �¼���*/,
    	PRTCLR_ROOM_Y_CO			NUMBER(3)	/*����� Ư�� �¼���*/,
        PRTCLR_SEAT_N_CO			NUMBER(3)	/*�Ϲݽ� �¼���*/,
        PRTCLR_ROOM_N_CO			NUMBER(3)	/*����� �Ϲݽ� �¼���*/,
        FARE						NUMBER(10)	/*���*/
    );
	/*R_TCKT�� ���� TABLE TYPE*/
	TYPE T_TCKT IS TABLE OF R_TCKT;

    /*TABLE TYPE�� �� RECORD*/
	TYPE R_DETAIL_TCKT_RCRD_1 IS RECORD(
    	RESVE_CODE		VARCHAR2(30) /*�����ڵ�*/,
		ID				VARCHAR2(30) /*���̵�*/,
        RGSDE			DATE		 /*������*/,
        RESVE_CO		NUMBER(1)	 /*����ż�*/,
        FR_AMOUNT		NUMBER(10)	 /*���ӱݾ�*/,
        USE_PINT		VARCHAR2(7)	 /*�������Ʈ*/,
        DSCNT_AMOUNT	NUMBER(10)	 /*���αݾ�*/,
        SETLE_AMOUNT	NUMBER(10)	 /*�����ݾ�*/
    );
	/*R_DETAIL_TCKT_RCRD_1�� ���� TABLE TYPE*/
	TYPE T_DETAIL_TCKT_RCRD_1 IS TABLE OF R_DETAIL_TCKT_RCRD_1;

    /*TABLE TYPE�� �� RECORD*/
	TYPE R_DETAIL_TCKT_RCRD_2 IS RECORD(
    	TRAIN_NO		VARCHAR2(30) /*������ȣ*/,
    	TRAIN_KND		VARCHAR2(30) /*����������*/,
		START_STATN		VARCHAR2(30) /*��߿���*/,
		START_TM		DATE		 /*��߽ð�*/,
        ARVL_STATN		VARCHAR2(30) /*��������*/,
  		ARVL_TM			DATE		 /*�����ð�*/,
        ROOM_KND		VARCHAR2(30) /*��������*/,
        ROOM			VARCHAR2(5)	 /*ȣ��*/,
        PSNGR_KND		VARCHAR2(30) /*�°����� : �����(�޼�), �Ϲ�, ���, ���*/,
        PSNGR_NM		VARCHAR2(30) /*�����ڸ�*/,
        SEAT_NO			VARCHAR2(20) /*�¼���ȣ*/,
        FR_AMOUNT		NUMBER(10)	 /*���ӱݾ�*/,
        DSCNT_AMOUNT	NUMBER(10)	 /*���αݾ�*/,
        RCPT_AMOUNT		NUMBER(10)	/*�����ݾ�*/
    );
	/*R_DETAIL_TCKT_RCRD_2�� ���� TABLE TYPE*/
	TYPE T_DETAIL_TCKT_RCRD_2 IS TABLE OF R_DETAIL_TCKT_RCRD_2;

    /**********************************************************
    * �̸�        : FN_SLT_TCKT
    * ����        : ������ ���Ÿ� ���� �������� ��ȸ
    * �������̺�  : OPRAT, DETAIL_OPRAT, TRAIN
    **********************************************************/
	FUNCTION FN_SLT_TCKT
    	(
        	I_SEAT_CO 			IN VARCHAR2 /*�¼���*/,
            I_TRAIN_KND_CODE	IN VARCHAR2 /*��������*/,
            I_START_STATN_CODE 	IN VARCHAR2 /*��߿�*/,
            I_ARVL_STATN_CODE 	IN VARCHAR2 /*������*/,
            I_START_TM 			IN VARCHAR2 /*��߽ð�*/

        )
    RETURN T_TCKT PIPELINED
    ;

   /**********************************************************
    * �̸�        : FN_SLT_DETAIL_TCKT_RCRD_1
    * ����        : ������ �Ϸ�� �󼼽����� ���� ��ȸ
    * �������̺�  : RESVE, SETLE
    **********************************************************/
	FUNCTION FN_SLT_DETAIL_TCKT_RCRD_1
    	(
        	I_RESVE_CODE IN VARCHAR2 /*�����ڵ�*/
        )
    RETURN T_DETAIL_TCKT_RCRD_1 PIPELINED
    ;

    /*****************************************************************
    * �̸�        : FN_SLT_DETAIL_TCKT_RCRD_2
    * ����        : ������ �Ϸ�� �󼼽������� �¼� ��ȸ
    * �������̺�  : RESVE, DETAIL_RESVE, TRAIN, SETLE, OPRAT
    ******************************************************************/
	FUNCTION FN_SLT_DETAIL_TCKT_RCRD_2
    	(
        	I_RESVE_CODE IN VARCHAR2 /*�����ڵ�*/
        )
    RETURN T_DETAIL_TCKT_RCRD_2 PIPELINED
    ;
END ;


