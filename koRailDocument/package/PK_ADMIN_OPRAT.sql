/*------------------------------------------------------------------------------
-- ��ü �̸� : KORAIL.PK_ADMIN_OPRAT
-- ���� ��¥ : 2014-11-15 ���� 6:30:05
-- ���������� ������ ��¥ : 2014-12-19 ���� 2:41:51
-- ���� : VALID
------------------------------------------------------------------------------*/
CREATE OR REPLACE PACKAGE KORAIL.PK_ADMIN_OPRAT
AS
    /*TABLE TYPE�� �� RECORD*/
	TYPE R_OPRAT IS RECORD(
    	OPRAT_CODE	        VARCHAR2(30),	/*�����ڵ�*/
        TRAIN_CODE      	VARCHAR2(30),	/*�����ڵ�*/
        TRAIN_NO            VARCHAR2(30),   /*������ȣ*/
        TRAIN_KND_CODE      VARCHAR2(30),   /*�������� �ڵ�*/
        TRAIN_KND_VALUE     VARCHAR2(30),   /*�������� ��*/
        START_STATN_CODE    VARCHAR2(30),   /*��߿� �ڵ�*/
        START_STATN_VALUE   VARCHAR2(30),   /*��߿� ��*/
        ARVL_STATN_CODE     VARCHAR2(30),   /*������ �ڵ�*/
        ARVL_STATN_VALUE    VARCHAR2(30),   /*������ ��*/
        START_TM	        DATE,	        /*��߽ð�*/
        ARVL_TM	            DATE,	        /*�����ð�*/
        ROUTE_CODE	        VARCHAR2(30),	/*�뼱�ڵ�*/
        ROUTE_VALUE			VARCHAR2(30),   /*�뼱�ڵ� ��*/
        DISTNC	            NUMBER(4,1),	/*�Ÿ�*/
        FARE	            NUMBER(10),	    /*���*/
        REGISTER	        VARCHAR2(30),	/*�����*/
        UPDUSR	            VARCHAR2(30),	/*������*/
        RGSDE	            DATE,	        /*�����*/
        UPDDE	            DATE	        /*������*/
    );
	/*R_OPRAT�� ���� TABLE TYPE*/
	TYPE T_OPRAT IS TABLE OF R_OPRAT;

    /*TABLE TYPE�� �� RECORD*/
	TYPE R_DETAIL_OPRAT IS RECORD(
    	DETAIL_OPRAT_CODE	VARCHAR2(30),	/*�󼼿����ڵ�*/
	    OPRAT_CODE			VARCHAR2(30),	/*�����ڵ�*/
	    TRAIN_KND_VALUE     VARCHAR2(30),   /*�������� ��*/
        START_STATN_CODE    VARCHAR2(30),   /*��߿� �ڵ�*/
        START_STATN_VALUE   VARCHAR2(30),   /*��߿� ��*/
        ARVL_STATN_CODE     VARCHAR2(30),   /*������ �ڵ�*/
        ARVL_STATN_VALUE    VARCHAR2(30),   /*������ ��*/
        START_TM	        DATE,	        /*��߽ð�*/
        ARVL_TM	            DATE,	        /*�����ð�*/
	    PRV_STATN_CODE		VARCHAR2(30),	/*�������ڵ�*/
	    PRV_STATN_VALUE		VARCHAR2(30),	/*�������ڵ� ��*/
	    NXT_STATN_CODE		VARCHAR2(30),	/*�������ڵ�*/
	    NXT_STATN_VALUE		VARCHAR2(30),	/*�������ڵ� ��*/
	    PRV_DISTNC			NUMBER(4,1),	/*�������Ÿ�*/
	    NXT_DISTNC			NUMBER(4,1),	/*�������Ÿ�*/
	    REGISTER			VARCHAR2(30),	/*�����*/
		UPDUSR				VARCHAR2(30),	/*������*/
		RGSDE				DATE,			/*�����*/
		UPDDE				DATE			/*������*/
    );
    /*R_OPRAT�� ���� TABLE TYPE*/
	TYPE T_DETAIL_OPRAT IS TABLE OF R_DETAIL_OPRAT;

    /**********************************************************
    * �̸�        : FN_SLT_OPRAT
    * ����        : �������� ��ȸ �Լ�
    * �������̺�  : OPRAT, TARIN
    **********************************************************/
	FUNCTION FN_SLT_OPRAT
    	(
           	I_TRAIN_KND		IN	VARCHAR2 	/*��������*/,
			I_TRAIN_NO		IN	VARCHAR2	/*������ȣ*/,
       	 	I_OPRAT_CODE	IN	VARCHAR2	/*�����ڵ�*/
		)
        RETURN T_OPRAT PIPELINED
    ;

    /**********************************************************
    * �̸�        : FN_SLT_DETAIL_OPRAT
    * ����        : �󼼿������� ��ȸ �Լ�
    * �������̺�  : DETAIL_OPRAT
    **********************************************************/
	FUNCTION FN_SLT_DETAIL_OPRAT
    	(
        	I_OPRAT_CODE IN VARCHAR2 /*�����ڵ�*/
        )
        RETURN T_DETAIL_OPRAT PIPELINED
    ;
END PK_ADMIN_OPRAT;


