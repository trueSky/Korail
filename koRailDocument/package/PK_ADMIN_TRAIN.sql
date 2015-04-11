/*------------------------------------------------------------------------------
-- ��ü �̸� : KORAIL.PK_ADMIN_TRAIN
-- ���� ��¥ : 2014-11-13 ���� 7:38:27
-- ���������� ������ ��¥ : 2014-11-15 ���� 10:30:22
-- ���� : VALID
------------------------------------------------------------------------------*/
CREATE OR REPLACE PACKAGE KORAIL.PK_ADMIN_TRAIN
AS
	/*TRAIN ���̺��� ���� ���̺� TYPE*/
	TYPE T_TRAIN IS TABLE OF TRAIN%ROWTYPE;

	/**********************************************************
    * �̸�	   : FN_SLT_TRAIN
    * ����	   : ���� ��ȸ �Լ�
    * �������̺�	: TRAIN
    **********************************************************/
	FUNCTION FN_SLT_TRAIN
    	(
           	I_TRAIN_KND	IN	VARCHAR2 	/*��������*/,
		   	I_TRAIN_NO	IN	VARCHAR2	/*������ȣ*/
		)
        RETURN T_TRAIN PIPELINED
        ;
END PK_ADMIN_TRAIN;


