/*------------------------------------------------------------------------------
-- 개체 이름 : KORAIL.PK_MEMBER_TCKT
-- 만든 날짜 : 2015-01-13 오후 12:15:02
-- 마지막으로 수정한 날짜 : 2015-01-14 오후 4:41:40
-- 상태 : VALID
------------------------------------------------------------------------------*/
CREATE OR REPLACE PACKAGE BODY KORAIL.PK_MEMBER_TCKT
AS
	/**********************************************************
    * 이름        : FN_SLT_TCKT
    * 설명        : 승차권 예매를 위한 운행정보 조회
    * 관련테이블  : OPRAT, DETAIL_OPRAT, TRAIN
    **********************************************************/
	FUNCTION FN_SLT_TCKT
    	(
        	I_SEAT_CO 			IN VARCHAR2 /*좌석수*/,
            I_TRAIN_KND_CODE	IN VARCHAR2 /*열차종류*/,
            I_START_STATN_CODE 	IN VARCHAR2 /*출발역*/,
            I_ARVL_STATN_CODE 	IN VARCHAR2 /*도착역*/,
            I_START_TM 			IN VARCHAR2 /*출발시각*/

        )
    RETURN T_TCKT PIPELINED
    IS
    	/* 승차권 예매를 위한 운행정보 조회 (검색조건 열차종류 있음) */
    	CURSOR C_KND IS(
        	SELECT	E.OPRAT_CODE		/*운행코드*/,
            		E.TRAIN_NO			/*열차번호*/,
                    E.TRAIN_KND_CODE	/*열차종류코드*/,
                    E.TRAIN_KND_VALUE	/*열차종류값*/,
                    E.START_STATN_CODE 	/*출발역코드*/,
                    E.START_STATN_VALUE	/*출발역값*/,
                    E.START_TM			/*출발시각*/,
                    E.ARVL_STATN_CODE 	/*도착역코드*/,
                    E.ARVL_STATN_VALUE	/*도착역값*/,
                    E.ARVL_TM			/*도착시각*/,
                    PRTCLR_SEAT_Y_CO	/*특실 좌석수*/,
                    E.PRTCLR_ROOM_Y_CO	/*예약된 특실 좌석수*/,
                    PRTCLR_SEAT_N_CO	/*일반실 좌석수*/,
                    E.PRTCLR_ROOM_N_CO	/*예약된 일반실 좌석수*/,
                    E.FARE				/*요금*/
  			FROM
       			(
                	SELECT	A.OPRAT_CODE,
                    		D.TRAIN_NO,
                    		D.TRAIN_KND AS TRAIN_KND_CODE,
              				PK_CMMN.TO_CODE_VALUE('CMMN_CODE', D.TRAIN_KND) AS TRAIN_KND_VALUE,
              				A.START_STATN AS START_STATN_CODE,
                            PK_CMMN.TO_CODE_VALUE('STATN', A.START_STATN) AS START_STATN_VALUE,
                            A.START_TM,
                            A.ARVL_STATN AS ARVL_STATN_CODE,
                            PK_CMMN.TO_CODE_VALUE('STATN', A.ARVL_STATN) AS ARVL_STATN_VALUE,
                            A.ARVL_TM,
                            (
                              SELECT	SUM(SEAT_CO)
                              FROM		ROOM
                              WHERE 	OPRAT_CODE = A.OPRAT_CODE
                              AND		PRTCLR_ROOM_YN = 'Y'
                            ) AS PRTCLR_SEAT_Y_CO,
                            (
                            	SELECT	SUM(RESVE_SEAT_CO)
                                FROM	ROOM
                                WHERE 	OPRAT_CODE = A.OPRAT_CODE
                                AND		PRTCLR_ROOM_YN = 'Y'
                            ) AS PRTCLR_ROOM_Y_CO,
                            (
                              SELECT	SUM(SEAT_CO)
                              FROM		ROOM
                              WHERE 	OPRAT_CODE = A.OPRAT_CODE
                              AND		PRTCLR_ROOM_YN = 'N'
                            ) AS PRTCLR_SEAT_N_CO,
                            (
                            	SELECT	SUM(RESVE_SEAT_CO)
                                FROM	ROOM
                                WHERE 	OPRAT_CODE = A.OPRAT_CODE
                                AND		PRTCLR_ROOM_YN = 'N'
                            ) AS PRTCLR_ROOM_N_CO,
              				A.FARE
         			FROM	OPRAT A,
              				DETAIL_OPRAT B,
              				ROOM C,
              				TRAIN D
        			WHERE	A.OPRAT_CODE = B.OPRAT_CODE
            		AND		A.OPRAT_CODE = C.OPRAT_CODE
            		AND		D.TRAIN_CODE = A.TRAIN_CODE
                    AND		D.TRAIN_KND = I_TRAIN_KND_CODE
                    AND 	A.START_STATN = I_START_STATN_CODE
                    AND 	A.ARVL_STATN = I_ARVL_STATN_CODE
                    AND 	A.START_TM >= TO_DATE(I_START_TM, 'YYYY-MM-DD HH24')
       			) E
 			GROUP BY	E.OPRAT_CODE,
            			E.TRAIN_NO,
       					E.TRAIN_KND_CODE,
       					E.TRAIN_KND_VALUE,
                        E.START_STATN_CODE,
       					E.START_STATN_VALUE,
      					E.START_TM,
       					E.ARVL_STATN_CODE,
       					E.ARVL_STATN_VALUE,
      	 				E.ARVL_TM,
                        E.PRTCLR_SEAT_Y_CO,
                        E.PRTCLR_ROOM_Y_CO,
                        E.PRTCLR_SEAT_N_CO,
                        E.PRTCLR_ROOM_N_CO,
       					E.FARE
			HAVING	E.PRTCLR_SEAT_Y_CO >= I_SEAT_CO
            OR		E.PRTCLR_SEAT_N_CO >= I_SEAT_CO
        );

        /* 승차권 예매를 위한 운행정보 조회 (검색조건 열차종류 없음) */
    	CURSOR C_NOT_KND IS(
        	SELECT	E.OPRAT_CODE		/*운행코드*/,
            		E.TRAIN_NO			/*열차번호*/,
                    E.TRAIN_KND_CODE	/*열차종류코드*/,
                    E.TRAIN_KND_VALUE	/*열차종류값*/,
                    E.START_STATN_CODE 	/*출발역코드*/,
                    E.START_STATN_VALUE	/*출발역값*/,
                    E.START_TM			/*출발시각*/,
                    E.ARVL_STATN_CODE 	/*도착역코드*/,
                    E.ARVL_STATN_VALUE	/*도착역값*/,
                    E.ARVL_TM			/*도착시각*/,
                    PRTCLR_SEAT_Y_CO	/*특실 좌석수*/,
                    E.PRTCLR_ROOM_Y_CO	/*예약된 특실 좌석수*/,
                    PRTCLR_SEAT_N_CO	/*일반실 좌석수*/,
                    E.PRTCLR_ROOM_N_CO	/*예약된 일반실 좌석수*/,
                    E.FARE				/*요금*/
  			FROM
       			(
                	SELECT	A.OPRAT_CODE,
                    		D.TRAIN_NO,
                    		D.TRAIN_KND AS TRAIN_KND_CODE,
              				PK_CMMN.TO_CODE_VALUE('CMMN_CODE', D.TRAIN_KND) AS TRAIN_KND_VALUE,
              				A.START_STATN AS START_STATN_CODE,
                            PK_CMMN.TO_CODE_VALUE('STATN', A.START_STATN) AS START_STATN_VALUE,
                            A.START_TM,
                            A.ARVL_STATN AS ARVL_STATN_CODE,
                            PK_CMMN.TO_CODE_VALUE('STATN', A.ARVL_STATN) AS ARVL_STATN_VALUE,
                            A.ARVL_TM,
                            (
                              SELECT	SUM(SEAT_CO)
                              FROM		ROOM
                              WHERE 	OPRAT_CODE = A.OPRAT_CODE
                              AND		PRTCLR_ROOM_YN = 'Y'
                            ) AS PRTCLR_SEAT_Y_CO,
                            (
                            	SELECT	SUM(RESVE_SEAT_CO)
                                FROM	ROOM
                                WHERE 	OPRAT_CODE = A.OPRAT_CODE
                                AND		PRTCLR_ROOM_YN = 'Y'
                            ) AS PRTCLR_ROOM_Y_CO,
                            (
                              SELECT	SUM(SEAT_CO)
                              FROM		ROOM
                              WHERE 	OPRAT_CODE = A.OPRAT_CODE
                              AND		PRTCLR_ROOM_YN = 'N'
                            ) AS PRTCLR_SEAT_N_CO,
                            (
                            	SELECT	SUM(RESVE_SEAT_CO)
                                FROM	ROOM
                                WHERE 	OPRAT_CODE = A.OPRAT_CODE
                                AND		PRTCLR_ROOM_YN = 'N'
                            ) AS PRTCLR_ROOM_N_CO,
              				A.FARE
         			FROM	OPRAT A,
              				DETAIL_OPRAT B,
              				ROOM C,
              				TRAIN D
        			WHERE	A.OPRAT_CODE = B.OPRAT_CODE
            		AND		A.OPRAT_CODE = C.OPRAT_CODE
            		AND		D.TRAIN_CODE = A.TRAIN_CODE
                    AND 	A.START_STATN = I_START_STATN_CODE
                    AND 	A.ARVL_STATN = I_ARVL_STATN_CODE
                    AND 	A.START_TM >= TO_DATE(I_START_TM, 'YYYY-MM-DD HH24')
       			) E
 			GROUP BY	E.OPRAT_CODE,
            			E.TRAIN_NO,
       					E.TRAIN_KND_CODE,
       					E.TRAIN_KND_VALUE,
                        E.START_STATN_CODE,
       					E.START_STATN_VALUE,
      					E.START_TM,
       					E.ARVL_STATN_CODE,
       					E.ARVL_STATN_VALUE,
      	 				E.ARVL_TM,
                        E.PRTCLR_SEAT_Y_CO,
                        E.PRTCLR_ROOM_Y_CO,
                        E.PRTCLR_SEAT_N_CO,
                        E.PRTCLR_ROOM_N_CO,
       					E.FARE
			HAVING	E.PRTCLR_SEAT_Y_CO >= I_SEAT_CO
            OR		E.PRTCLR_SEAT_N_CO >= I_SEAT_CO
        );

        /*리턴할 값을 저장시킬 테이블 TYPE 선언*/
        SET_TCKT T_TCKT := T_TCKT();
	BEGIN
    	IF I_TRAIN_KND_CODE = 'ALL' THEN
        	FOR DATA IN C_NOT_KND LOOP
    			SET_TCKT.EXTEND;
            	SET_TCKT(SET_TCKT.COUNT).OPRAT_CODE := DATA.OPRAT_CODE;
              	SET_TCKT(SET_TCKT.COUNT).TRAIN_NO := DATA.TRAIN_NO;
              	SET_TCKT(SET_TCKT.COUNT).TRAIN_KND_CODE := DATA.TRAIN_KND_CODE;
              	SET_TCKT(SET_TCKT.COUNT).TRAIN_KND_VALUE := DATA.TRAIN_KND_VALUE;
              	SET_TCKT(SET_TCKT.COUNT).START_STATN_CODE := DATA.START_STATN_CODE;
             	SET_TCKT(SET_TCKT.COUNT).START_STATN_VALUE := DATA.START_STATN_VALUE;
              	SET_TCKT(SET_TCKT.COUNT).ARVL_STATN_CODE := DATA.ARVL_STATN_CODE;
              	SET_TCKT(SET_TCKT.COUNT).ARVL_STATN_VALUE := DATA.ARVL_STATN_VALUE;
              	SET_TCKT(SET_TCKT.COUNT).START_TM := DATA.START_TM;
              	SET_TCKT(SET_TCKT.COUNT).ARVL_TM := DATA.ARVL_TM;
              	SET_TCKT(SET_TCKT.COUNT).PRTCLR_SEAT_Y_CO := DATA.PRTCLR_SEAT_Y_CO;
              	SET_TCKT(SET_TCKT.COUNT).PRTCLR_ROOM_Y_CO := DATA.PRTCLR_ROOM_Y_CO;
              	SET_TCKT(SET_TCKT.COUNT).PRTCLR_SEAT_N_CO := DATA.PRTCLR_SEAT_N_CO;
                SET_TCKT(SET_TCKT.COUNT).PRTCLR_ROOM_N_CO := DATA.PRTCLR_ROOM_N_CO;
              	SET_TCKT(SET_TCKT.COUNT).FARE := DATA.FARE;
              	PIPE ROW(SET_TCKT(SET_TCKT.COUNT));
          	END LOOP
          	;
        ELSE
        	FOR DATA IN C_KND LOOP
    			SET_TCKT.EXTEND;
            	SET_TCKT(SET_TCKT.COUNT).OPRAT_CODE := DATA.OPRAT_CODE;
              	SET_TCKT(SET_TCKT.COUNT).TRAIN_NO := DATA.TRAIN_NO;
              	SET_TCKT(SET_TCKT.COUNT).TRAIN_KND_CODE := DATA.TRAIN_KND_CODE;
              	SET_TCKT(SET_TCKT.COUNT).TRAIN_KND_VALUE := DATA.TRAIN_KND_VALUE;
              	SET_TCKT(SET_TCKT.COUNT).START_STATN_CODE := DATA.START_STATN_CODE;
             	SET_TCKT(SET_TCKT.COUNT).START_STATN_VALUE := DATA.START_STATN_VALUE;
              	SET_TCKT(SET_TCKT.COUNT).ARVL_STATN_CODE := DATA.ARVL_STATN_CODE;
              	SET_TCKT(SET_TCKT.COUNT).ARVL_STATN_VALUE := DATA.ARVL_STATN_VALUE;
              	SET_TCKT(SET_TCKT.COUNT).START_TM := DATA.START_TM;
              	SET_TCKT(SET_TCKT.COUNT).ARVL_TM := DATA.ARVL_TM;
              	SET_TCKT(SET_TCKT.COUNT).PRTCLR_SEAT_Y_CO := DATA.PRTCLR_SEAT_Y_CO;
              	SET_TCKT(SET_TCKT.COUNT).PRTCLR_ROOM_Y_CO := DATA.PRTCLR_ROOM_Y_CO;
              	SET_TCKT(SET_TCKT.COUNT).PRTCLR_SEAT_N_CO := DATA.PRTCLR_SEAT_N_CO;
                SET_TCKT(SET_TCKT.COUNT).PRTCLR_ROOM_N_CO := DATA.PRTCLR_ROOM_N_CO;
              	SET_TCKT(SET_TCKT.COUNT).FARE := DATA.FARE;
              	PIPE ROW(SET_TCKT(SET_TCKT.COUNT));
          	END LOOP
          	;
        END IF
        ;
    END FN_SLT_TCKT
    ;

    /**********************************************************
    * 이름        : FN_SLT_DETAIL_TCKT_RCRD_1
    * 설명        : 결제가 완료된 상세승차권 내역 조회
    * 관련테이블  : RESVE, SETLE
    **********************************************************/
	FUNCTION FN_SLT_DETAIL_TCKT_RCRD_1
    	(
        	I_RESVE_CODE IN VARCHAR2 /*예약코드*/
        )
    RETURN T_DETAIL_TCKT_RCRD_1 PIPELINED
    IS
    	/* 결제가 와뇨된 상세승차권 내역 */
    	CURSOR C_DETAIL_TCKT_RCRD IS(
        	SELECT	A.RESVE_CODE	/*예약코드*/,
            		A.ID			/*아이디*/,
       				B.RGSDE			/*결제일*/,
       				A.RESVE_CO		/*예약매수*/,
       				B.FR_AMOUNT		/*운임금액*/,
       				B.USE_PINT		/*사용포인트*/,
       				B.DSCNT_AMOUNT	/*헐인금액*/,
       				B.SETLE_AMOUNT	/*결제금액*/
  			FROM 	RESVE A			/*예약*/,
       				SETLE B			/*결제*/
 			WHERE	A.RESVE_CODE = B.RESVE_CODE
       		AND		A.RESVE_CODE = I_RESVE_CODE
        );

        /*리턴할 값을 저장시킬 테이블 TYPE 선언*/
        SET_DETAIL_TCKT_RCRD T_DETAIL_TCKT_RCRD_1 := T_DETAIL_TCKT_RCRD_1();
	BEGIN
    	FOR DATA IN C_DETAIL_TCKT_RCRD LOOP
            SET_DETAIL_TCKT_RCRD.EXTEND;
            SET_DETAIL_TCKT_RCRD(SET_DETAIL_TCKT_RCRD.COUNT).RESVE_CODE := DATA.RESVE_CODE;
            SET_DETAIL_TCKT_RCRD(SET_DETAIL_TCKT_RCRD.COUNT).ID := DATA.ID;
            SET_DETAIL_TCKT_RCRD(SET_DETAIL_TCKT_RCRD.COUNT).RGSDE := DATA.RGSDE;
            SET_DETAIL_TCKT_RCRD(SET_DETAIL_TCKT_RCRD.COUNT).RESVE_CO := DATA.RESVE_CO;
            SET_DETAIL_TCKT_RCRD(SET_DETAIL_TCKT_RCRD.COUNT).FR_AMOUNT := DATA.FR_AMOUNT;
            SET_DETAIL_TCKT_RCRD(SET_DETAIL_TCKT_RCRD.COUNT).USE_PINT := DATA.USE_PINT;
            SET_DETAIL_TCKT_RCRD(SET_DETAIL_TCKT_RCRD.COUNT).DSCNT_AMOUNT := DATA.DSCNT_AMOUNT;
            SET_DETAIL_TCKT_RCRD(SET_DETAIL_TCKT_RCRD.COUNT).SETLE_AMOUNT := DATA.SETLE_AMOUNT;
            PIPE ROW(SET_DETAIL_TCKT_RCRD(SET_DETAIL_TCKT_RCRD.COUNT));
        END LOOP
        ;
    END FN_SLT_DETAIL_TCKT_RCRD_1
    ;

    /*****************************************************************
    * 이름        : FN_SLT_DETAIL_TCKT_RCRD_2
    * 설명        : 결제가 완료된 상세승차권의 좌석 조회
    * 관련테이블  : RESVE, DETAIL_RESVE, TRAIN, SETLE, OPRAT
    ******************************************************************/
	FUNCTION FN_SLT_DETAIL_TCKT_RCRD_2
    	(
        	I_RESVE_CODE IN VARCHAR2 /*예약코드*/
        )
    RETURN T_DETAIL_TCKT_RCRD_2 PIPELINED
    IS
    	/* 결제가 와뇨된 상세승차권 내역 */
    	CURSOR C_DETAIL_TCKT_RCRD IS(
        	SELECT	C.TRAIN_NO													 /*열차번호*/,
            		PK_CMMN.TO_CODE_VALUE('CMMN_CODE', C.TRAIN_KND) AS TRAIN_KND /*열차종류*/,
                    PK_CMMN.TO_CODE_VALUE('STATN', E.START_STATN) AS START_STATN /*출발역*/,
                    E.START_TM													 /*출발식각*/,
                    PK_CMMN.TO_CODE_VALUE('STATN', E.ARVL_STATN) AS ARVL_STATN	 /*도착역*/,
                    E.ARVL_TM													 /*도착시각*/,
                    PK_CMMN.TO_CODE_VALUE('CMMN_CODE', B.ROOM_KND) AS ROOM_KND	 /*객실등급*/,
                    B.ROOM														 /*호실*/,
                    CASE B.PSNGR_KND
						WHEN 'PSNGR_3' THEN PK_CMMN.TO_CODE_VALUE('CMMN_CODE', B.DSPSN_GRAD)
                    	ELSE PK_CMMN.TO_CODE_VALUE('CMMN_CODE', B.PSNGR_KND)
                	END	AS PSNGR_KND											 /*승객유형 : 장애인(급수), 일반, 경로, 어린이*/,
                    B.PSNGR_NM													 /*승차자명*/,
                    B.SEAT_NO													 /*좌석번호*/,
                    B.FR_AMOUNT													 /*운임금액*/,
                    B.DSCNT_AMOUNT												 /*할인금액*/,
                    B.RCPT_AMOUNT												 /*영수금액*/
            FROM	RESVE A														 /*예약*/,
            		DETAIL_RESVE B												 /*상세예약*/,
                    TRAIN C														 /*열차*/,
                    SETLE D														 /*결제*/,
                    OPRAT E														 /*운행*/
            WHERE	A.RESVE_CODE = B.RESVE_CODE
        	AND		C.TRAIN_CODE = E.TRAIN_CODE
        	AND		A.RESVE_CODE = D.RESVE_CODE
        	AND		E.OPRAT_CODE = A.OPRAT_CODE
            GROUP BY	A.RESVE_CODE	/*예약코드*/,
                     	A.ID			/*아이디*/,
                     	C.TRAIN_NO		/*열차번호*/,
                     	C.TRAIN_KND		/*열차종류*/,
                     	E.START_STATN	/*출발역*/,
                     	E.START_TM		/*출발시각*/,
                     	E.ARVL_STATN	/*도착역*/,
                     	E.ARVL_TM		/*도착시각*/,
                     	B.ROOM_KND		/*객실유형*/,
                     	B.ROOM			/*호실*/,
                     	B.PSNGR_NM		/*승차자명*/,
                     	B.SEAT_NO		/*좌석번호*/,
                     	B.FR_AMOUNT		/*운임금액*/,
                     	B.DSCNT_AMOUNT	/*할인금액*/,
                        B.RCPT_AMOUNT	/*영수금액*/,
                        B.PSNGR_KND		/*승객유형*/,
                        B.DSPSN_GRAD	/*장애인등급*/
        	HAVING	A.RESVE_CODE = I_RESVE_CODE
        );

        /*리턴할 값을 저장시킬 테이블 TYPE 선언*/
        SET_DETAIL_TCKT_RCRD T_DETAIL_TCKT_RCRD_2 := T_DETAIL_TCKT_RCRD_2();
	BEGIN
    	FOR DATA IN C_DETAIL_TCKT_RCRD LOOP
            SET_DETAIL_TCKT_RCRD.EXTEND;
            SET_DETAIL_TCKT_RCRD(SET_DETAIL_TCKT_RCRD.COUNT).TRAIN_NO := DATA.TRAIN_NO;
            SET_DETAIL_TCKT_RCRD(SET_DETAIL_TCKT_RCRD.COUNT).TRAIN_KND := DATA.TRAIN_KND;
            SET_DETAIL_TCKT_RCRD(SET_DETAIL_TCKT_RCRD.COUNT).START_STATN := DATA.START_STATN;
            SET_DETAIL_TCKT_RCRD(SET_DETAIL_TCKT_RCRD.COUNT).START_TM := DATA.START_TM;
            SET_DETAIL_TCKT_RCRD(SET_DETAIL_TCKT_RCRD.COUNT).ARVL_STATN := DATA.ARVL_STATN;
            SET_DETAIL_TCKT_RCRD(SET_DETAIL_TCKT_RCRD.COUNT).ARVL_TM := DATA.ARVL_TM;
            SET_DETAIL_TCKT_RCRD(SET_DETAIL_TCKT_RCRD.COUNT).ROOM_KND := DATA.ROOM_KND;
            SET_DETAIL_TCKT_RCRD(SET_DETAIL_TCKT_RCRD.COUNT).ROOM := DATA.ROOM;
            SET_DETAIL_TCKT_RCRD(SET_DETAIL_TCKT_RCRD.COUNT).PSNGR_KND := DATA.PSNGR_KND;
            SET_DETAIL_TCKT_RCRD(SET_DETAIL_TCKT_RCRD.COUNT).PSNGR_NM := DATA.PSNGR_NM;
            SET_DETAIL_TCKT_RCRD(SET_DETAIL_TCKT_RCRD.COUNT).SEAT_NO := DATA.SEAT_NO;
            SET_DETAIL_TCKT_RCRD(SET_DETAIL_TCKT_RCRD.COUNT).FR_AMOUNT := DATA.FR_AMOUNT;
            SET_DETAIL_TCKT_RCRD(SET_DETAIL_TCKT_RCRD.COUNT).DSCNT_AMOUNT := DATA.DSCNT_AMOUNT;
            SET_DETAIL_TCKT_RCRD(SET_DETAIL_TCKT_RCRD.COUNT).RCPT_AMOUNT := DATA.RCPT_AMOUNT;
            PIPE ROW(SET_DETAIL_TCKT_RCRD(SET_DETAIL_TCKT_RCRD.COUNT));
        END LOOP
        ;
    END FN_SLT_DETAIL_TCKT_RCRD_2
    ;
END ;


