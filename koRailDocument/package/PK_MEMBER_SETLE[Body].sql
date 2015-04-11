/*------------------------------------------------------------------------------
-- ��ü �̸� : KORAIL.PK_MEMBER_SETLE
-- ���� ��¥ : 2015-01-07 ���� 11:06:32
-- ���������� ������ ��¥ : 2015-01-14 ���� 5:29:37
-- ���� : VALID
------------------------------------------------------------------------------*/
CREATE OR REPLACE PACKAGE BODY KORAIL.PK_MEMBER_SETLE
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
    )
    IS
    	V_PINT_CODE VARCHAR2(30);	/*����Ʈ�ڵ�*/
    BEGIN
    	/* ���� */
    	UPDATE SETLE SET
        	ID = I_ID									/*���̵�*/,
            CARD_SE = I_CARD_SE		    				/*ī�屸��*/,
            CARD_KND = I_CARD_KND						/*ī������*/,
            CARD_NO	= I_CARD_NO							/*ī���ȣ*/,
            VALID_PD = TO_DATE(I_VALID_PD, 'YYYY-MM')	/*��ȿ�Ⱓ*/,
            INSTLMT = I_INSTLMT							/*�Һ�*/,
            SCRTY_CARD_NO = I_SCRTY_CARD_NO				/*����ī���ȣ*/,
            IHIDNUM = I_IHIDNUM							/*�ֹε�Ϲ�ȣ*/,
            USE_PINT = I_USE_PINT						/*�������Ʈ*/,
            PINT_USE_YN = I_PINT_USE_YN	    			/*����Ʈ��뿩��*/,
            SETLE_STTUS = 'SETLE_STTUS_Y'     			/*��������*/,
            FR_AMOUNT = TO_NUMBER(I_FR_AMOUNT)			/*���ӱݾ�*/,
            DSCNT_AMOUNT = TO_NUMBER(I_DSCNT_AMOUNT)	/*���αݾ�*/,
            SETLE_AMOUNT = TO_NUMBER(I_SETLE_AMOUNT)	/*�����ݾ�*/,
            REGISTER = I_REGISTER						/*�����*/,
            RGSDE = SYSDATE          					/*�����*/
        WHERE RESVE_CODE = I_RESVE_CODE
        ;

        /* ����Ʈ ���� �� ���� */
        IF SQL%FOUND THEN
        	/*PINT_CODE SEARCH*/
            SELECT 'PINT_CODE_' || NVL( MAX( REGEXP_SUBSTR( PINT_CODE, '[^_]+', 1, 3) ), 1)
        	INTO V_PINT_CODE
            FROM PINT
            ;

            /* �� ������ ���� ����Ʈ ���� ���*/
            UPDATE PINT
                SET	ID = I_ID,
                    USE_PINT = I_USE_PINT,
                    SV_PINT = (I_SETLE_AMOUNT / 1000),
                    USE_HISTR = (
                                    SELECT	C.TRAIN_NO || ' ' || PK_CMMN.TO_CODE_VALUE('STATN', A.START_STATN)
                                            || ' �� ' || PK_CMMN.TO_CODE_VALUE('STATN', A.ARVL_STATN)
                                    FROM	OPRAT A,
                                            RESVE B,
                                            TRAIN C
                                    WHERE	A.OPRAT_CODE = B.OPRAT_CODE
                                    AND 	A.TRAIN_CODE = C.TRAIN_CODE
                                    AND 	B.RESVE_CODE = I_RESVE_CODE
                                ),
                    SETLE_AMOUNT = I_SETLE_AMOUNT,
                    USE_DE = SYSDATE
            WHERE PINT_CODE = V_PINT_CODE
            ;

            /* ����Ʈ ��뿩�ο� ���� �� �������Ʈ �� ��������Ʈ ���� */
            IF SQL%FOUND AND I_PINT_USE_YN = 'Y' THEN
                UPDATE PINT SET
                    TDY_PINT = TO_NUMBER((
                                    SELECT MAX(TDY_PINT)
                                    FROM PINT
                                    WHERE PINT_CODE = V_PINT_CODE
                                    AND	ID = I_ID
                                ))-I_USE_PINT+(I_SETLE_AMOUNT / 1000),
                    ALL_USE_PINT = TO_NUMBER((
                                        SELECT NVL(MAX(ALL_USE_PINT), 0)
                                        FROM PINT
                                        WHERE PINT_CODE = V_PINT_CODE
                                    	AND	ID = I_ID
                                    ))+I_USE_PINT
                WHERE ID = I_ID
                ;
            ELSIF SQL%FOUND AND I_PINT_USE_YN = 'N' THEN
            	UPDATE PINT SET
                    TDY_PINT = TO_NUMBER((
                                    SELECT NVL(MAX(TDY_PINT), 0)
                                    FROM PINT
                                    WHERE PINT_CODE = V_PINT_CODE
                                	AND	ID = I_ID
                                ))+(I_SETLE_AMOUNT / 1000),
                    ALL_USE_PINT = TO_NUMBER((
                                        SELECT NVL(MAX(ALL_USE_PINT), 0)
                                        FROM PINT
                                        WHERE PINT_CODE = V_PINT_CODE
                                    	AND	ID = I_ID
                                    ))
                WHERE ID = I_ID
                ;
            ELSE
                ER_CODE := '1';
                ER_MSG := '���� ����';
                ROLLBACK;
                RETURN;
            END IF;
        ELSE
        	ER_CODE := '1';
            ER_MSG := '���� ����';
            ROLLBACK;
            RETURN;
        END IF;

        ER_CODE := '0';
    	ER_MSG := '���� ����';

        EXCEPTION
        	WHEN OTHERS THEN
            	ER_CODE := '1';
                ER_MSG := SQLCODE || '' || SQLERRM;
                ROLLBACK;
                RETURN;
    END SP_IST_SETLE;
END PK_MEMBER_SETLE;


