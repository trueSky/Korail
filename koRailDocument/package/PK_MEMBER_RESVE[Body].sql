/*------------------------------------------------------------------------------
-- ��ü �̸� : KORAIL.PK_MEMBER_RESVE
-- ���� ��¥ : 2014-12-19 ���� 4:55:05
-- ���������� ������ ��¥ : 2015-01-14 ���� 7:48:33
-- ���� : VALID
------------------------------------------------------------------------------*/
CREATE OR REPLACE PACKAGE BODY KORAIL.PK_MEMBER_RESVE AS
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
    )IS
    	V_RESVE_CODE	VARCHAR2(30);	/* ����� RESVE_CODE */
        V_COUNT			NUMBER(10);		/*COUNT*/
    	V_DSCNT_AMOUNT	NUMBER(10);		/* ���� ���ο�� */
    	V_RCPT_AMOUNT	NUMBER(10);		/* ���� �����ݾ� */
    BEGIN
    	/*****************************
        		���� ���� Ȯ��
        ******************************/

    	/* ��ο�� 21% ���� */
        IF I_PSNGR_KND = 'PSNGR_1' THEN
    		V_DSCNT_AMOUNT := I_FR_AMOUNT * 21 / 100;
        	V_RCPT_AMOUNT  := I_FR_AMOUNT - (I_FR_AMOUNT * 21 / 100);
        /* ��� 50% ���� */
        ELSIF I_PSNGR_KND = 'PSNGR_4' THEN
        	V_DSCNT_AMOUNT := I_FR_AMOUNT * 50 / 100;
        	V_RCPT_AMOUNT  := I_FR_AMOUNT - (I_FR_AMOUNT * 50 / 100);
        /* ����� ��� 1~3�� 33% ���� */
        ELSIF I_DSPSN_GRAD = 'DSPSN_GRAD_1' THEN
        	V_DSCNT_AMOUNT := I_FR_AMOUNT * 33 / 100;
        	V_RCPT_AMOUNT  := I_FR_AMOUNT - (I_FR_AMOUNT * 33 / 100);
        /* ����� ��� 4~6�� 15% ���� */
        ELSIF I_DSPSN_GRAD = 'DSPSN_GRAD_2' THEN
        	V_DSCNT_AMOUNT := I_FR_AMOUNT * 15 / 100;
        	V_RCPT_AMOUNT  := I_FR_AMOUNT - (I_FR_AMOUNT * 15 / 100);
        /* �Ϲ� 0% ���� */
        ELSE
        	V_RCPT_AMOUNT := I_FR_AMOUNT;
        END IF
        ;

        /* ���������� Ư���� ��� 23,500���� �߰���� �߻� */
		IF I_ROOM_KND = 'Y' THEN
    		V_RCPT_AMOUNT := V_RCPT_AMOUNT + 23500;
        END IF
        ;

        /**********************
         	�󼼿��� ���
         **********************/

         /* RESVE_CODE �˻� */
         SELECT 'RESVE_CODE_'|| NVL(
					MAX(
  						TO_NUMBER(REGEXP_SUBSTR(RESVE_CODE, '[^_]+', 1, 3))
					),
                    1
         		)
        INTO V_RESVE_CODE
		FROM RESVE
        ;

         /* ��� */
        INSERT INTO DETAIL_RESVE(
    		DETAIL_RESVE_CODE	/*�󼼿����ڵ�*/,
            RESVE_CODE			/*�����ڵ�*/,
            ROOM_KND			/*��������*/,
            SEAT_NO				/*�¼���ȣ*/,
            PSNGR_KND			/*�°�����*/,
            DSPSN_GRAD			/*����ε��*/,
            ROOM				/*ȣ��*/,
            FR_AMOUNT			/*���ӱݾ�*/,
            DSCNT_AMOUNT		/*���αݾ�*/,
            RCPT_AMOUNT			/*�����ݾ�*/
        )VALUES(
    		(
				SELECT 'DETAIL_RESVE_CODE_'|| NVL(
							MAX(
								REGEXP_SUBSTR(DETAIL_RESVE_CODE, '[^_]+', 1, 4)+1
							),
                       		1
						)
				FROM DETAIL_RESVE
			),
            V_RESVE_CODE,
            I_ROOM_KND,
            I_SEAT_NO,
            I_PSNGR_KND,
            I_DSPSN_GRAD,
            I_ROOM,
            I_FR_AMOUNT,
            V_DSCNT_AMOUNT,
            V_RCPT_AMOUNT
        );

        /* ��ϼ��� �� */
        IF SQL%FOUND THEN
        	/* �� ���ӱݾ� �� �� ���αݾ� ���� */
        	UPDATE RESVE SET
				ALL_DSCNT_AMOUNT = NVL(ALL_DSCNT_AMOUNT, 0)+V_DSCNT_AMOUNT,
				ALL_RCPT_AMOUNT = NVL(ALL_RCPT_AMOUNT, 0)+V_RCPT_AMOUNT
            WHERE RESVE_CODE = V_RESVE_CODE
            ;

            /* �� ���ӱݾ� �� �� ���αݾ� ���� ���� �� �������� ���� */
            IF SQL%FOUND THEN
            	/* �����ڵ� �˻� */
            	SELECT COUNT(*)
                INTO V_COUNT
  				FROM SETLE
 				WHERE RESVE_CODE = V_RESVE_CODE
                ;

            	/* ���� ���� ��� */
            	IF V_COUNT = 0 THEN
                	/*����Ʈ �ڵ� ���*/
                	INSERT INTO PINT(
                    	PINT_CODE
                    )VALUES(
                    	(
                        	SELECT 'PINT_CODE_' || NVL( MAX( REGEXP_SUBSTR( PINT_CODE, '[^_]+', 1, 3)+1 ), 1)
                            FROM PINT
                        )
                    );

                    /*����Ʈ�ڵ尡 ��ϵǾ��ٸ�*/
                    IF SQL%FOUND THEN
                    	INSERT INTO SETLE(
                        	RESVE_CODE,
                            PINT_CODE,
                        	ID,
                        	SETLE_STTUS
                    	)VALUES(
                        	V_RESVE_CODE,
                            (
                            	SELECT 'PINT_CODE_' || NVL( MAX( REGEXP_SUBSTR( PINT_CODE, '[^_]+', 1, 3) ), 1)
                            	FROM PINT
                            ),
                        	(SELECT ID FROM RESVE WHERE RESVE_CODE = V_RESVE_CODE),
                        	'SETLE_STTUS_N'
                    	)
                    	;

                    	/* �������� ��� ���� �� */
                   		IF SQL%NOTFOUND THEN
                    		ER_CODE := '1';
                			ER_MSG := '�������� ��� ����';
                			ROLLBACK;
                			RETURN
                			;
                    	END IF
                    	;
                    ELSE
                    	ER_CODE := '1';
                    	ER_MSG := '����Ʈ ��� ����';
                		ROLLBACK;
                		RETURN;
                		END IF
                		;
                END IF
                ;
            /* �� ���ӱݾ� �� �� ���αݾ� ���� ���� �� */
            ELSE
            	ER_CODE := '1';
                ER_MSG := '�� ���ӱݾ� �� �� ���αݾ� ���� ����';
                ROLLBACK;
                RETURN
                ;
        	END IF
        	;

        	ER_CODE	:= '0';
        	ER_MSG	:= '��� ����';
            O_RESVE_CODE := V_RESVE_CODE;
            COMMIT;
        /* ��ϵ� ���� ���� ��� */
        ELSIF SQL%NOTFOUND THEN
        		ER_CODE := '1';
                ER_MSG := '��� ����';
                ROLLBACK;
                RETURN
                ;
        END IF
        ;

        /* ��Ÿ ���� */
    	EXCEPTION
    		WHEN OTHERS THEN
            	ER_CODE := '1';
              	ER_MSG := SQLCODE || '-' || SQLERRM;
                ROLLBACK;
                RETURN
                ;
    END SP_IST_DEATIL_RESVE
    ;

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
    IS
    	/*������ȸ*/
    	CURSOR C_RESVE IS(
			SELECT	B.RESVE_CODE													/*�����ڵ�*/,
                    A.TRAIN_NO														/*������ȣ*/,
                    PK_CMMN.TO_CODE_VALUE('CMMN_CODE', A.TRAIN_KND) AS TRAIN_KND	/*��������*/,
                    PK_CMMN.TO_CODE_VALUE('STATN', D.START_STATN) AS START_STATN	/*��߿�*/,
                    D.START_TM														/*��߽ð�*/,
                    PK_CMMN.TO_CODE_VALUE('STATN', D.ARVL_STATN) AS ARVL_STATN		/*������*/,
                    D.ARVL_TM														/*�����ð�*/,
                    B.RESVE_CO														/*�¼���ȣ*/,
                    B.ALL_FR_AMOUNT													/*�ѿ��ӱݾ�*/,
                    B.ALL_DSCNT_AMOUNT												/*�����αݾ�*/,
                    B.ALL_RCPT_AMOUNT												/*�ѿ����ݾ�*/
            FROM	TRAIN A,
            		RESVE B,
                    DETAIL_RESVE C,
                    OPRAT D,
                    DETAIL_OPRAT E
            WHERE	D.OPRAT_CODE = B.OPRAT_CODE
            AND		B.RESVE_CODE = C.RESVE_CODE
            AND		D.OPRAT_CODE = E.OPRAT_CODE
            AND		A.TRAIN_CODE = D.TRAIN_CODE
            GROUP BY
            	A.TRAIN_NO,
                A.TRAIN_KND,
                D.START_STATN,
                D.START_TM,
                D.ARVL_STATN,
                D.ARVL_TM,
                B.RESVE_CO,
                B.ALL_FR_AMOUNT,
                B.ALL_DSCNT_AMOUNT,
                B.ALL_RCPT_AMOUNT,
                B.RESVE_CODE
            HAVING B.RESVE_CODE = I_RESVR_CODE
        );

        /*������ ���� �����ų ���̺� TYPE ����*/
        SET_RESVE T_RESVE := T_RESVE();
    BEGIN
    	FOR DATA IN C_RESVE LOOP
        	SET_RESVE.EXTEND;
            SET_RESVE(SET_RESVE.COUNT).RESVE_CODE := DATA.RESVE_CODE;
            SET_RESVE(SET_RESVE.COUNT).TRAIN_NO := DATA.TRAIN_NO;
            SET_RESVE(SET_RESVE.COUNT).TRAIN_KND := DATA.TRAIN_KND;
            SET_RESVE(SET_RESVE.COUNT).START_STATN := DATA.START_STATN;
            SET_RESVE(SET_RESVE.COUNT).START_TM := DATA.START_TM;
            SET_RESVE(SET_RESVE.COUNT).ARVL_STATN := DATA.ARVL_STATN;
            SET_RESVE(SET_RESVE.COUNT).ARVL_TM := DATA.ARVL_TM;
            SET_RESVE(SET_RESVE.COUNT).RESVE_CO := DATA.RESVE_CO;
            SET_RESVE(SET_RESVE.COUNT).ALL_FR_AMOUNT := DATA.ALL_FR_AMOUNT;
            SET_RESVE(SET_RESVE.COUNT).ALL_DSCNT_AMOUNT := DATA.ALL_DSCNT_AMOUNT;
            SET_RESVE(SET_RESVE.COUNT).ALL_RCPT_AMOUNT := DATA.ALL_RCPT_AMOUNT;
            PIPE ROW(SET_RESVE(SET_RESVE.COUNT));
        END LOOP
        ;
    END FN_SLT_RESVE
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
    IS
    	/*������ ���� ��Ȳ ��ȸ*/
    	CURSOR C_RESVE_RCRD IS(
        	SELECT  A.RESVE_CODE															/*�����ڵ�*/,
            		B.TRAIN_NO																/*������ȣ*/,
                    PK_CMMN.TO_CODE_VALUE('CMMN_CODE', B.TRAIN_KND) AS TRAIN_KND			/*��������*/,
                    PK_CMMN.TO_CODE_VALUE('STATN', C.START_STATN) AS START_STATN			/*��߿�*/,
                    C.START_TM																/*��߽ð�*/,
                    PK_CMMN.TO_CODE_VALUE('STATN', C.ARVL_STATN) AS ARVL_STATN				/*������*/,
                    C.ARVL_TM																/*�����ð�*/,
                    A.RESVE_CO																/*���� �� ��*/,
                    D.SETLE_STTUS AS SETLE_STTUS_CODE										/*�������� �ڵ�*/,
                    PK_CMMN.TO_CODE_VALUE('CMMN_CODE', D.SETLE_STTUS) AS  SETLE_STTUS_VALUE	/*�������� ��*/,
                    D.SETLE_AMOUNT															/*�����ݾ�*/
            FROM	RESVE A																	/*����*/,
            		TRAIN B																	/*����*/,
                    OPRAT C																	/*����*/,
                    SETLE D																	/*����*/
            WHERE	C.OPRAT_CODE = A.OPRAT_CODE
        	AND		B.TRAIN_CODE = C.TRAIN_CODE
            AND		A.RESVE_CODE = D.RESVE_CODE
            AND		D.ID = I_ID
        );

        /*������ ���� �����ų ���̺� TYPE ����*/
        SET_RESVE_RCRD T_RESVE_RCRD := T_RESVE_RCRD();
    BEGIN
    	FOR DATA IN C_RESVE_RCRD LOOP
        	SET_RESVE_RCRD.EXTEND;
            SET_RESVE_RCRD(SET_RESVE_RCRD.COUNT).RESVE_CODE := DATA.RESVE_CODE;
            SET_RESVE_RCRD(SET_RESVE_RCRD.COUNT).TRAIN_NO := DATA.TRAIN_NO;
            SET_RESVE_RCRD(SET_RESVE_RCRD.COUNT).TRAIN_KND := DATA.TRAIN_KND;
            SET_RESVE_RCRD(SET_RESVE_RCRD.COUNT).START_STATN := DATA.START_STATN;
            SET_RESVE_RCRD(SET_RESVE_RCRD.COUNT).START_TM := DATA.START_TM;
            SET_RESVE_RCRD(SET_RESVE_RCRD.COUNT).ARVL_STATN := DATA.ARVL_STATN;
            SET_RESVE_RCRD(SET_RESVE_RCRD.COUNT).ARVL_TM := DATA.ARVL_TM;
            SET_RESVE_RCRD(SET_RESVE_RCRD.COUNT).RESVE_CO := DATA.RESVE_CO;

            SET_RESVE_RCRD(SET_RESVE_RCRD.COUNT).SETLE_STTUS_CODE := DATA.SETLE_STTUS_CODE;
            SET_RESVE_RCRD(SET_RESVE_RCRD.COUNT).SETLE_STTUS_VALUE := DATA.SETLE_STTUS_VALUE;
            SET_RESVE_RCRD(SET_RESVE_RCRD.COUNT).SETLE_AMOUNT := DATA.SETLE_AMOUNT;
            PIPE ROW(SET_RESVE_RCRD(SET_RESVE_RCRD.COUNT));
        END LOOP
        ;
    END FN_SLT_RESVE_RCRD
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
    )
    IS
    	V_CODE VARCHAR2(30); /*�ӽ������ڵ�*/
    BEGIN
    	/*����Ʈ ���� ����*/
    	 UPDATE PINT
         SET	TDY_PINT = (USE_PINT+TDY_PINT-SV_PINT),
         		ALL_USE_PINT =	CASE
                					WHEN (ALL_USE_PINT-USE_PINT) > 0 THEN 0
                                    ELSE (ALL_USE_PINT)
                				END
         WHERE	PINT_CODE = (SELECT PINT_CODE FROM SETLE WHERE RESVE_CODE = I_RESVE_CODE)
         ;
    	/*����Ʈ ���� ���� ���� ��*/
    	IF SQL%FOUND THEN
        	/*���� �� ������ ����Ʈ ����*/
        	SELECT PINT_CODE
            INTO V_CODE
            FROM SETLE
            WHERE RESVE_CODE = I_RESVE_CODE
            ;
        	/*��������*/
        	DELETE FROM SETLE WHERE RESVE_CODE = I_RESVE_CODE;

            /*�������� ���� ��*/
            IF SQL%FOUND THEN
            	/*���ſ� ���� ����Ʈ ���� ����*/
                DELETE FROM PINT
                WHERE PINT_CODE = V_CODE
            	;
                /*���ſ� ���� ����Ʈ ���� ���� ���� ��*/
                IF SQL%NOTFOUND THEN
                	ER_CODE := '1';
            		ER_MSG := '������� ����';
            		ROLLBACK;
            		RETURN;
                END IF;

                /*�󼼿��� ���� ����*/
                DELETE FROM DETAIL_RESVE WHERE RESVE_CODE = I_RESVE_CODE;
                /*�󼼿��� ���� ���� ���� ��*/
                IF SQL%FOUND THEN
                	DELETE FROM RESVE WHERE RESVE_CODE = I_RESVE_CODE;
                    /*���� ���� ���� ���� ��*/
                    IF SQL%NOTFOUND THEN
                		ER_CODE := '1';
            			ER_MSG := '������� ����';
            			ROLLBACK;
            			RETURN;
                END IF
                ;
                /*�󼼿��� ���� ���� ���� ��*/
                ELSE
                	ER_CODE := '1';
            		ER_MSG := '������� ����';
            		ROLLBACK;
            		RETURN;
                END IF
                ;
            ELSE
            	ER_CODE := '1';
            	ER_MSG := '������� ����';
            	ROLLBACK;
            	RETURN;
            END IF
            ;
        ELSE
        	ER_CODE := '1';
            ER_MSG := '����Ʈ ���� ���� ����';
            ROLLBACK;
            RETURN;
        END IF
        ;

    	ER_CODE := '0';
        ER_MSG := '������� ����';

        EXCEPTION
    		WHEN OTHERS THEN
            	ER_CODE := '1';
              	ER_MSG := SQLCODE || '-' || SQLERRM;
                ROLLBACK;
                RETURN;
    END SP_DEL_RESVE
    ;
END PK_MEMBER_RESVE;


