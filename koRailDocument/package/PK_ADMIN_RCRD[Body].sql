/*------------------------------------------------------------------------------
-- ��ü �̸� : KORAIL.PK_ADMIN_RCRD
-- ���� ��¥ : 2014-12-23 ���� 4:27:08
-- ���������� ������ ��¥ : 2015-01-14 ���� 7:08:28
-- ���� : VALID
------------------------------------------------------------------------------*/
CREATE OR REPLACE PACKAGE BODY KORAIL.PK_ADMIN_RCRD AS
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
    IS
    	/* ������ �߱� ��Ȳ */
    	CURSOR C_TCKT_RCRD IS(
        	SELECT	OPRAT_CODE	      /*�����ڵ�*/,
                    TCKT_TM			  /*��������*/,
                    TRAIN_NO          /*������ȣ*/,
                    TRAIN_KND_VALUE   /*�������� ��*/,
                    START_STATN_VALUE /*��߿� ��*/,
                    ARVL_STATN_VALUE  /*������ ��*/,
                    START_TM	      /*��߽ð�*/,
                    ARVL_TM	          /*�����ð�*/,
                    PRTCLR_SEAT_Y_CO  /*Ư�� �¼���*/,
                    PRTCLR_ROOM_Y_CO  /*����� Ư�� �¼���*/,
                    PRTCLR_SEAT_N_CO  /*�Ϲݽ� �¼���*/,
                    PRTCLR_ROOM_N_CO  /*����� �Ϲݽ� �¼���*/
            FROM
            	(
                	SELECT	A.OPRAT_CODE,
                          	A.START_TM AS TCKT_TM,
                          	B.TRAIN_NO,
                          	PK_CMMN.TO_CODE_VALUE('CMMN_CODE', B.TRAIN_KND) AS TRAIN_KND_VALUE,
                          	PK_CMMN.TO_CODE_VALUE('STATN', A.START_STATN) AS START_STATN_VALUE,
                          	A.START_TM,
                          	PK_CMMN.TO_CODE_VALUE('STATN', A.ARVL_STATN) AS ARVL_STATN_VALUE,
                          	A.ARVL_TM,
                          	(
                            	SELECT	SUM(SEAT_CO)
                            	FROM	ROOM
                           		WHERE	OPRAT_CODE = A.OPRAT_CODE
                            	AND		PRTCLR_ROOM_YN = 'Y'
                          	) AS PRTCLR_SEAT_Y_CO,
                          	(
                            	SELECT	SUM(RESVE_SEAT_CO)
                            	FROM	ROOM
                           		WHERE	OPRAT_CODE = A.OPRAT_CODE
                            	AND		PRTCLR_ROOM_YN = 'Y'
                    		) AS PRTCLR_ROOM_Y_CO,
                          	(
                            	SELECT	SUM(SEAT_CO)
                            	FROM	ROOM
                           		WHERE	OPRAT_CODE = A.OPRAT_CODE
                            	AND		PRTCLR_ROOM_YN = 'N'
                          	) AS PRTCLR_SEAT_N_CO,
                          	(
                    			SELECT	SUM(RESVE_SEAT_CO)
                            	FROM	ROOM
                           		WHERE	OPRAT_CODE = A.OPRAT_CODE
                                AND		PRTCLR_ROOM_YN = 'N'
                          	) AS PRTCLR_ROOM_N_CO
                    FROM	OPRAT A,
                			TRAIN B,
                    		ROOM C
                    WHERE	B.TRAIN_CODE = A.TRAIN_CODE
                	AND		A.OPRAT_CODE = C.OPRAT_CODE
                	AND		A.START_TM = TO_DATE(I_TCKT_TM, 'YYYY-MM-DD')
                    AND		B.TRAIN_KND = I_TRAIN_KND_CODE
            	) D
             GROUP BY 	OPRAT_CODE,
             			TCKT_TM,
                   		TRAIN_NO,
                   		TRAIN_KND_VALUE,
                   		START_STATN_VALUE,
                   		START_TM,
                   		ARVL_STATN_VALUE,
                   		ARVL_TM,
                   		PRTCLR_SEAT_Y_CO,
                   		PRTCLR_ROOM_Y_CO,
                   		PRTCLR_SEAT_N_CO,
                   		PRTCLR_ROOM_N_CO
        );

        /*������ ���� �����ų ���̺� TYPE ����*/
        SET_TCKT_RCRD T_TCKT_RCRD := T_TCKT_RCRD();
	BEGIN
    	/*SE_TCKT_RCRD�� C_TCKT_RCRD�� �����͸� ����*/
        FOR DATA IN C_TCKT_RCRD LOOP
            SET_TCKT_RCRD.EXTEND;
            SET_TCKT_RCRD(SET_TCKT_RCRD.COUNT).OPRAT_CODE := DATA.OPRAT_CODE;
            SET_TCKT_RCRD(SET_TCKT_RCRD.COUNT).TCKT_TM := DATA.TCKT_TM;
            SET_TCKT_RCRD(SET_TCKT_RCRD.COUNT).TRAIN_NO := DATA.TRAIN_NO;
            SET_TCKT_RCRD(SET_TCKT_RCRD.COUNT).TRAIN_KND_VALUE := DATA.TRAIN_KND_VALUE;
            SET_TCKT_RCRD(SET_TCKT_RCRD.COUNT).START_STATN_VALUE := DATA.START_STATN_VALUE;
            SET_TCKT_RCRD(SET_TCKT_RCRD.COUNT).ARVL_STATN_VALUE := DATA.ARVL_STATN_VALUE;
            SET_TCKT_RCRD(SET_TCKT_RCRD.COUNT).START_TM := DATA.START_TM;
            SET_TCKT_RCRD(SET_TCKT_RCRD.COUNT).ARVL_TM := DATA.ARVL_TM;
            SET_TCKT_RCRD(SET_TCKT_RCRD.COUNT).PRTCLR_SEAT_Y_CO := DATA.PRTCLR_SEAT_Y_CO;
            SET_TCKT_RCRD(SET_TCKT_RCRD.COUNT).PRTCLR_ROOM_Y_CO := DATA.PRTCLR_ROOM_Y_CO;
            SET_TCKT_RCRD(SET_TCKT_RCRD.COUNT).PRTCLR_SEAT_N_CO := DATA.PRTCLR_SEAT_N_CO;
            SET_TCKT_RCRD(SET_TCKT_RCRD.COUNT).PRTCLR_ROOM_N_CO := DATA.PRTCLR_ROOM_N_CO;
           	PIPE ROW(SET_TCKT_RCRD(SET_TCKT_RCRD.COUNT));
        END LOOP
        ;
    END FN_SLT_TCKT_RCRD
    ;

    /**********************************************************
    * �̸�        : FN_SLT_TRAIN_RCRD
    * ����        : ������ �°� ��Ȳ
    * �������̺�  : RESVE, DETAIL_RESVE, SETLE, OPRAT, TRAIN
    **********************************************************/
	FUNCTION FN_SLT_TRAIN_RCRD(
		I_TRAIN_KND_CODE	IN	VARCHAR2 	/*��������*/,
        I_TCKT_TM			IN	VARCHAR2 	/*��������*/
	)
    RETURN T_TRAIN_RCRD PIPELINED
	IS
    	/* ������ �°� ��Ȳ */
    	CURSOR C_TRAIN_RCRD IS(
        	 SELECT	A.RESVE_CODE,
                    A.REGISTER,
                    (
                        SELECT 	COUNT(PSNGR_KND)
                        FROM 	DETAIL_RESVE
                        WHERE	RESVE_CODE = A.RESVE_CODE
                        AND		PSNGR_KND = 'PSNGR_1'
                    ) AS ELDRLY_CO,
                    (
                        SELECT	COUNT(PSNGR_KND)
                        FROM	DETAIL_RESVE
                        WHERE	RESVE_CODE = A.RESVE_CODE
                        AND		PSNGR_KND = 'PSNGR_3'
                    ) AS DSPSN_CO,
                    (
                        SELECT	COUNT(PSNGR_KND)
                        FROM	DETAIL_RESVE
                        WHERE	RESVE_CODE = A.RESVE_CODE
                        AND		PSNGR_KND = 'PSNGR_4'
                    ) AS CHLD_CO,
                    A.RESVE_CO,
                    A.ALL_RCPT_AMOUNT,
                    C.SETLE_STTUS,
                    C.USE_PINT,
                    C.DSCNT_AMOUNT,
                    C.SETLE_AMOUNT
            FROM	RESVE A,
                    DETAIL_RESVE B,
                    SETLE C,
                    OPRAT D,
                    TRAIN E
			WHERE	A.RESVE_CODE = B.RESVE_CODE
        	AND		A.RESVE_CODE = C.RESVE_CODE
        	AND		D.OPRAT_CODE = A.OPRAT_CODE
            AND		E.TRAIN_CODE = D.TRAIN_CODE
        	GROUP BY	A.RESVE_CODE,
                        A.REGISTER,
                        A.RESVE_CO,
                        A.ALL_RCPT_AMOUNT,
                        C.SETLE_STTUS,
                        C.USE_PINT,
                        C.DSCNT_AMOUNT,
                        C.SETLE_AMOUNT,
                        D.START_TM,
                        E.TRAIN_KND
            HAVING	D.START_TM = TO_DATE(I_TCKT_TM, 'YYYY-MM')
            AND		E.TRAIN_KND = I_TRAIN_KND_CODE
        );

        /*������ ���� �����ų ���̺� TYPE ����*/
        SET_TRAIN_RCRD T_TRAIN_RCRD := T_TRAIN_RCRD();
    BEGIN
    	/*SE_TRAIN_RCRD�� C_TRAIN_RCRD�� �����͸� ����*/
        FOR DATA IN C_TRAIN_RCRD LOOP
            SET_TRAIN_RCRD.EXTEND;
            SET_TRAIN_RCRD(SET_TRAIN_RCRD.COUNT).RESVE_CODE := DATA.RESVE_CODE;
            SET_TRAIN_RCRD(SET_TRAIN_RCRD.COUNT).REGISTER := DATA.REGISTER;
            SET_TRAIN_RCRD(SET_TRAIN_RCRD.COUNT).ELDRLY_CO := DATA.ELDRLY_CO;
            SET_TRAIN_RCRD(SET_TRAIN_RCRD.COUNT).DSPSN_CO := DATA.DSPSN_CO;
			SET_TRAIN_RCRD(SET_TRAIN_RCRD.COUNT).CHLD_CO := DATA.CHLD_CO;
            SET_TRAIN_RCRD(SET_TRAIN_RCRD.COUNT).RESVE_CO := DATA.RESVE_CO;
            SET_TRAIN_RCRD(SET_TRAIN_RCRD.COUNT).ALL_RCPT_AMOUNT := DATA.ALL_RCPT_AMOUNT;
            SET_TRAIN_RCRD(SET_TRAIN_RCRD.COUNT).SETLE_STTUS := DATA.SETLE_STTUS;
            SET_TRAIN_RCRD(SET_TRAIN_RCRD.COUNT).USE_PINT := DATA.USE_PINT;
            SET_TRAIN_RCRD(SET_TRAIN_RCRD.COUNT).DSCNT_AMOUNT := DATA.DSCNT_AMOUNT;
            SET_TRAIN_RCRD(SET_TRAIN_RCRD.COUNT).SETLE_AMOUNT := DATA.SETLE_AMOUNT;

            PIPE ROW(SET_TRAIN_RCRD(SET_TRAIN_RCRD.COUNT));
        END LOOP
        ;
    END FN_SLT_TRAIN_RCRD
    ;
END PK_ADMIN_RCRD;


