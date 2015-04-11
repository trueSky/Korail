/*------------------------------------------------------------------------------
-- ��ü �̸� : KORAIL.PK_MEMBER_SETLE
-- ���� ��¥ : 2015-01-07 ���� 10:54:04
-- ���������� ������ ��¥ : 2015-01-11 ���� 11:07:04
-- ���� : VALID
------------------------------------------------------------------------------*/
CREATE OR REPLACE PACKAGE KORAIL.PK_MEMBER_SETLE
AS
	/**********************************************************
    * �̸�        : SP_IST_SETLE
    * ����        : ����
    * �������̺�  : PINT, OPRAT, RESVE, TRAIN
    **********************************************************/
	PROCEDURE SP_IST_SETLE(
    	I_RESVE_CODE	IN	VARCHAR2	/*�����ڵ�*/,
		I_ID			IN	VARCHAR2	/*���̵�*/,
		I_CARD_SE		IN	VARCHAR2	/*ī�屸��*/,
		I_CARD_KND		IN	VARCHAR2	/*ī������*/,
        I_CARD_NO		IN	VARCHAR2	/*ī���ȣ*/,
        I_VALID_PD		IN	VARCHAR2	/*��ȿ�Ⱓ*/,
        I_INSTLMT		IN	VARCHAR2	/*�Һ�*/,
        I_SCRTY_CARD_NO	IN	VARCHAR2	/*����ī���ȣ*/,
        I_IHIDNUM		IN	VARCHAR2	/*�ֹε�Ϲ�ȣ*/,
        I_USE_PINT		IN	VARCHAR2	/*�������Ʈ*/,
        I_PINT_USE_YN	IN	VARCHAR2	/*����Ʈ��뿩��*/,
        I_FR_AMOUNT		IN	NUMBER		/*���ӱݾ�*/,
        I_DSCNT_AMOUNT	IN	NUMBER		/*���αݾ�*/,
        I_SETLE_AMOUNT	IN	NUMBER		/*�����ݾ�*/,
        I_REGISTER		IN	VARCHAR2	/*�����*/,

		ER_CODE OUT VARCHAR2	/*���� �ڵ�(0 : ����, 1 : ����)*/,
    	ER_MSG 	OUT VARCHAR2	/*���� �޼���*/
    );
END ;


