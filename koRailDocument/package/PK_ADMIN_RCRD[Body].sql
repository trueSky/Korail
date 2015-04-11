/*------------------------------------------------------------------------------
-- 개체 이름 : KORAIL.PK_ADMIN_RCRD
-- 만든 날짜 : 2014-12-23 오전 4:27:08
-- 마지막으로 수정한 날짜 : 2015-01-14 오후 7:08:28
-- 상태 : VALID
------------------------------------------------------------------------------*/
CREATE OR REPLACE PACKAGE BODY KORAIL.PK_ADMIN_RCRD AS
	/**********************************************************
    * 이름        : FN_SLT_TCKT_RCRD
    * 설명        : 승차권 발권 현황
    * 관련테이블  : OPRAT, TARIN, ROOM
    **********************************************************/
	FUNCTION FN_SLT_TCKT_RCRD(
		I_TRAIN_KND_CODE	IN	VARCHAR2 	/*열차종류*/,
        I_TCKT_TM			IN	VARCHAR2 	/*승차일자*/
	)
    RETURN T_TCKT_RCRD PIPELINED
    IS
    	/* 승차권 발권 현황 */
    	CURSOR C_TCKT_RCRD IS(
        	SELECT	OPRAT_CODE	      /*운행코드*/,
                    TCKT_TM			  /*승차일자*/,
                    TRAIN_NO          /*열차번호*/,
                    TRAIN_KND_VALUE   /*열차종류 값*/,
                    START_STATN_VALUE /*출발역 값*/,
                    ARVL_STATN_VALUE  /*도착역 값*/,
                    START_TM	      /*출발시각*/,
                    ARVL_TM	          /*도착시각*/,
                    PRTCLR_SEAT_Y_CO  /*특실 좌석수*/,
                    PRTCLR_ROOM_Y_CO  /*예약된 특실 좌석수*/,
                    PRTCLR_SEAT_N_CO  /*일반실 좌석수*/,
                    PRTCLR_ROOM_N_CO  /*예약된 일반실 좌석수*/
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

        /*리턴할 값을 저장시킬 테이블 TYPE 선언*/
        SET_TCKT_RCRD T_TCKT_RCRD := T_TCKT_RCRD();
	BEGIN
    	/*SE_TCKT_RCRD에 C_TCKT_RCRD의 데이터를 설정*/
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
    * 이름        : FN_SLT_TRAIN_RCRD
    * 설명        : 열차별 승객 현황
    * 관련테이블  : RESVE, DETAIL_RESVE, SETLE, OPRAT, TRAIN
    **********************************************************/
	FUNCTION FN_SLT_TRAIN_RCRD(
		I_TRAIN_KND_CODE	IN	VARCHAR2 	/*열차종류*/,
        I_TCKT_TM			IN	VARCHAR2 	/*승차일자*/
	)
    RETURN T_TRAIN_RCRD PIPELINED
	IS
    	/* 열차별 승객 현황 */
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

        /*리턴할 값을 저장시킬 테이블 TYPE 선언*/
        SET_TRAIN_RCRD T_TRAIN_RCRD := T_TRAIN_RCRD();
    BEGIN
    	/*SE_TRAIN_RCRD에 C_TRAIN_RCRD의 데이터를 설정*/
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


