/*------------------------------------------------------------------------------
-- ��ü �̸� : KORAIL.PK_ADMIN_STATN
-- ���� ��¥ : 2014-11-09 ���� 7:02:26
-- ���������� ������ ��¥ : 2014-11-15 ���� 10:29:27
-- ���� : VALID
------------------------------------------------------------------------------*/
CREATE OR REPLACE PACKAGE KORAIL.PK_ADMIN_STATN
AS
	/*STATN ���̺��� ���� ���̺� TYPE*/
	TYPE T_STATN IS TABLE OF STATN%ROWTYPE;

	/**********************************************************
    * �̸�	   : FN_SLT_STATN
    * ����	   : �� ��ȸ �Լ�
    * �������̺� : STATN
    **********************************************************/
	FUNCTION FN_SLT_STATN
    	(
           	I_AREA_CODE	IN	VARCHAR2 	/*�����ڵ�*/,
		   	I_STATN_NM	IN	VARCHAR2	/*�˻���*/
		)
        RETURN T_STATN PIPELINED
        ;
END PK_ADMIN_STATN;


