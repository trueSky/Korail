CREATE OR REPLACE PACKAGE BODY KORAIL.PK_MEMBER_RESVE AS
    /**********************************************************
    * 이름        : SP_IST_DEATIL_RESVE
    * 설명        : 상세예약 등록
    * 관련테이블  : RESVE, DETAIL_RESVE
    **********************************************************/
    PROCEDURE SP_IST_DEATIL_RESVE(
    	I_ROOM_KND		IN	VARCHAR2	/*객실유형*/,
      I_SEAT_NO			IN	VARCHAR2  /*좌석번호*/,
      I_PSNGR_KND		IN	VARCHAR2	/*승객유형*/,
      I_DSPSN_GRAD	IN	VARCHAR2	/*장애인등급*/,
      I_ROOM				IN	VARCHAR2	/*호실*/,
      I_FR_AMOUNT		IN	VARCHAR2  /*운임금액*/,

      O_RESVE_CODE	OUT	VARCHAR2	/* 리턴할 예약 코드 */,

      ER_CODE		 		OUT VARCHAR2	/*에러 코드(0 : 성공, 1 : 에러)*/,
      ER_MSG 				OUT VARCHAR2	/*에러 메세지*/
    )IS
    	V_RESVE_CODE		VARCHAR2(30);	/* 등록할 RESVE_CODE */
      V_COUNT					NUMBER(10);		/*COUNT*/
    	V_DSCNT_AMOUNT	NUMBER(10);		/* 변수 할인요금 */
    	V_RCPT_AMOUNT		NUMBER(10);		/* 변수 영수금액 */
    BEGIN
    	/*****************************
      	  		할인 여부 확인
      ******************************/

    	/* 경로우대 21% 할인 */
      IF I_PSNGR_KND = 'PSNGR_1' THEN
      	V_DSCNT_AMOUNT := I_FR_AMOUNT * 21 / 100;
        V_RCPT_AMOUNT  := I_FR_AMOUNT - V_DSCNT_AMOUNT;
      /* 어린이 50% 할인 */
      ELSIF I_PSNGR_KND = 'PSNGR_4' THEN
      	V_DSCNT_AMOUNT := I_FR_AMOUNT * 50 / 100;
        V_RCPT_AMOUNT  := I_FR_AMOUNT - V_DSCNT_AMOUNT;
      /* 장애인 등급 1~3급 33% 할인 */
      ELSIF I_DSPSN_GRAD = 'DSPSN_GRAD_1' THEN
      	V_DSCNT_AMOUNT := I_FR_AMOUNT * 33 / 100;
        V_RCPT_AMOUNT  := I_FR_AMOUNT - V_DSCNT_AMOUNT;
      /* 장애인 등급 4~6급 15% 할인 */
      ELSIF I_DSPSN_GRAD = 'DSPSN_GRAD_2' THEN
      	V_DSCNT_AMOUNT := I_FR_AMOUNT * 15 / 100;
        V_RCPT_AMOUNT  := I_FR_AMOUNT - V_DSCNT_AMOUNT;
      /* 일반 0% 할인 */
      ELSE
      	V_RCPT_AMOUNT := I_FR_AMOUNT;
      END IF
      ;

			/* 객실유형이 특실인 경우 23,500원의 추가요금 발생 */
			IF I_ROOM_KND = 'Y' THEN
      	V_RCPT_AMOUNT := V_RCPT_AMOUNT + 23500;
      END IF
      ;

      /**********************
      			상세예약 등록
      **********************/

      /* RESVE_CODE 검색 */
      SELECT	'RESVE_CODE_'||
      				NVL(
              	MAX(
                	TO_NUMBER(
                  	REGEXP_SUBSTR(
                    	RESVE_CODE, '[^_]+', 1, 3
                    )
                  )
                ), 1
              )
      INTO V_RESVE_CODE
      FROM RESVE
      ;

      /* 등록 */
      INSERT INTO DETAIL_RESVE(
      	DETAIL_RESVE_CODE	/*상세예약코드*/,
        RESVE_CODE				/*예약코드*/,
        ROOM_KND					/*객실유형*/,
        SEAT_NO						/*좌석번호*/,
        PSNGR_KND					/*승객유형*/,
        DSPSN_GRAD				/*장애인등급*/,
        ROOM							/*호실*/,
        FR_AMOUNT					/*운임금액*/,
        DSCNT_AMOUNT			/*할인금액*/,
        RCPT_AMOUNT				/*영수금액*/
      )VALUES(
      	(
        	SELECT	'DETAIL_RESVE_CODE_'||
          				NVL(
                  	MAX(
                    	REGEXP_SUBSTR(
                      	DETAIL_RESVE_CODE,
                        '[^_]+', 1, 4)+1
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

      /* 등록성공 시 */
      IF SQL%FOUND THEN
      	/*호실의 예약된 좌석 수 증가*/
      	UPDATE ROOM SET
        	RESVE_SEAT_CO = NVL(RESVE_SEAT_CO, 0)+1
        WHERE OPRAT_CODE = (
        											SELECT OPRAT_CODE
                              FROM RESVE
                              WHERE RESVE_CODE = V_RESVE_CODE
                              GROUP BY OPRAT_CODE
        										)
        ;

        /* 총 운임금액 및 총 할인금액 수정 */
        UPDATE RESVE SET
        	ALL_DSCNT_AMOUNT = NVL(ALL_DSCNT_AMOUNT, 0)+V_DSCNT_AMOUNT,
          ALL_RCPT_AMOUNT = NVL(ALL_RCPT_AMOUNT, 0)+V_RCPT_AMOUNT
        WHERE RESVE_CODE = V_RESVE_CODE
        ;

        /* 총 운임금액 및 총 할인금액 수정 성공 시 결제상태 설정 */
        IF SQL%FOUND THEN
        	/* 결제코드 검색 */
          SELECT	COUNT(*)
          INTO		V_COUNT
          FROM		SETLE
          WHERE		RESVE_CODE = V_RESVE_CODE
          ;

        	/* 결제 상태 등록 */
        	IF V_COUNT = 0 THEN
        		/*포인트 코드 등록*/
          	INSERT INTO PINT(
          		PINT_CODE
          	)VALUES(
          		(
            		SELECT 'PINT_CODE_' || NVL( MAX( REGEXP_SUBSTR( PINT_CODE, '[^_]+', 1, 3)+1 ), 1)
              	FROM PINT
            	)
          	);

            /*포인트코드가 등록되었다면*/
            IF SQL%FOUND THEN
              INSERT INTO SETLE(
                RESVE_CODE,
                PINT_CODE,
                ID,
                SETLE_STTUS
              )VALUES(
                V_RESVE_CODE,
                (
                  SELECT	'PINT_CODE_' ||
                          NVL(
                            MAX(
                              TO_NUMBER(
                                REGEXP_SUBSTR(
                                  PINT_CODE,
                                  '[^_]+', 1, 3
                                )
                              )
                            ), 1
                          )
                  FROM PINT
                ),
                (SELECT ID FROM RESVE WHERE RESVE_CODE = V_RESVE_CODE),
                'SETLE_STTUS_N'
              )
              ;
              /* 결제상태 등록 실패 시 */
              IF SQL%NOTFOUND THEN
              	ER_CODE := '1';
                ER_MSG := '결제상태 등록 실패';
                ROLLBACK;
                RETURN;
                END IF
                ;
            ELSE
							ER_CODE := '1';
              ER_MSG := '포인트 등록 실패';
              ROLLBACK;
              RETURN;
            END IF
            ;
          END IF
          ;
        /* 총 운임금액 및 총 할인금액 수정 실패 시 */
        ELSE
        	ER_CODE := '1';
          ER_MSG := '총 운임금액 및 총 할인금액 수정 실패';
          ROLLBACK;
          RETURN;
        END IF
        ;

        ER_CODE	:= '0';
        ER_MSG	:= '등록 성공';
        O_RESVE_CODE := V_RESVE_CODE;
        COMMIT;
      /* 등록된 행이 없을 경우 */
      ELSIF SQL%NOTFOUND THEN
      	ER_CODE := '1';
        ER_MSG := '등록 실패';
        ROLLBACK;
        RETURN;
      END IF
      ;

      /* 기타 에러 */
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
    * 이름        : FN_SLT_RESVE
    * 설명        : 승차권 예매 조회
    * 관련테이블  : TRAIN A, RESVE, DETAIL_RESVE, OPRAT, DETAIL_OPRAT
    *********************************************************************/
	FUNCTION FN_SLT_RESVE
    	(
        	I_RESVR_CODE IN VARCHAR2 /*예약코드*/
        )
    RETURN T_RESVE PIPELINED
    IS
    	/*예약조회*/
    	CURSOR C_RESVE IS(
			SELECT	B.RESVE_CODE													/*예약코드*/,
                    A.TRAIN_NO														/*열차번호*/,
                    PK_CMMN.TO_CODE_VALUE('CMMN_CODE', A.TRAIN_KND) AS TRAIN_KND	/*열차종류*/,
                    PK_CMMN.TO_CODE_VALUE('STATN', D.START_STATN) AS START_STATN	/*출발역*/,
                    D.START_TM														/*출발시각*/,
                    PK_CMMN.TO_CODE_VALUE('STATN', D.ARVL_STATN) AS ARVL_STATN		/*도착역*/,
                    D.ARVL_TM														/*도착시각*/,
                    B.RESVE_CO														/*좌석번호*/,
                    B.ALL_FR_AMOUNT													/*총운임금액*/,
                    B.ALL_DSCNT_AMOUNT												/*총할인금액*/,
                    B.ALL_RCPT_AMOUNT												/*총영수금액*/
            FROM	TRAIN A,
            		RESVE B,
                    DETAIL_RESVE C,
                    OPRAT D
            WHERE	D.OPRAT_CODE = B.OPRAT_CODE
            AND		B.RESVE_CODE = C.RESVE_CODE
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

        /*리턴할 값을 저장시킬 테이블 TYPE 선언*/
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
    * 이름        : FN_SLT_RESVE_RCRD
    * 설명        : 승차권 예매 현황
    * 관련테이블  : RESVE, TRAIN, OPRAT, SETLE
    *********************************************************************/
	FUNCTION FN_SLT_RESVE_RCRD
    	(
        	I_ID IN VARCHAR2 /*아아디*/

        )
    RETURN T_RESVE_RCRD PIPELINED
    IS
    	/*승차권 예매 현황 조회*/
    	CURSOR C_RESVE_RCRD IS(
        	SELECT  A.RESVE_CODE															/*예약코드*/,
            		B.TRAIN_NO																/*열차번호*/,
                    PK_CMMN.TO_CODE_VALUE('CMMN_CODE', B.TRAIN_KND) AS TRAIN_KND			/*열차종류*/,
                    PK_CMMN.TO_CODE_VALUE('STATN', C.START_STATN) AS START_STATN			/*출발역*/,
                    C.START_TM																/*출발시각*/,
                    PK_CMMN.TO_CODE_VALUE('STATN', C.ARVL_STATN) AS ARVL_STATN				/*도착역*/,
                    C.ARVL_TM																/*도착시각*/,
                    A.RESVE_CO																/*예약 매 수*/,
                    D.SETLE_STTUS AS SETLE_STTUS_CODE										/*결제상태 코드*/,
                    PK_CMMN.TO_CODE_VALUE('CMMN_CODE', D.SETLE_STTUS) AS  SETLE_STTUS_VALUE	/*결제상태 값*/,
                    D.SETLE_AMOUNT															/*결제금액*/
            FROM	RESVE A																	/*예약*/,
            		TRAIN B																	/*열차*/,
                    OPRAT C																	/*운행*/,
                    SETLE D																	/*결제*/
            WHERE	C.OPRAT_CODE = A.OPRAT_CODE
        	AND		B.TRAIN_CODE = C.TRAIN_CODE
            AND		A.RESVE_CODE = D.RESVE_CODE
            AND		D.ID = I_ID
        );

        /*리턴할 값을 저장시킬 테이블 TYPE 선언*/
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
    * 이름        : SP_DEL_RESVE
    * 설명        : 예매 취소
    * 관련테이블  : RESVE, DETAIL_RESVE, SETLE, PINT
    **********************************************************/
    PROCEDURE SP_DEL_RESVE(
    	I_RESVE_CODE	IN VARCHAR2		/*예약코드*/,
        I_ID			IN VARCHAR2		/*아이디*/,

    	ER_CODE		 	OUT VARCHAR2	/*에러 코드(0 : 성공, 1 : 에러)*/,
    	ER_MSG 			OUT VARCHAR2	/*에러 메세지*/
    )
    IS
    	V_CODE VARCHAR2(30); /*임시저장코드*/
        V_COUNT NUMBER(10);	 /*행수*/

        /*예약코드 조회*/
        CURSOR C_RESVE IS(
        	SELECT RESVE_CODE FROM RESVE WHERE ID = I_ID
        );
    BEGIN
    	IF I_ID IS NULL THEN
            /*포인트 내역 수정*/
             UPDATE PINT
             SET	TDY_PINT = (USE_PINT+TDY_PINT-SV_PINT),
                    ALL_USE_PINT =	CASE
                                        WHEN (ALL_USE_PINT-USE_PINT) > 0 THEN 0
                                        ELSE (ALL_USE_PINT)
                                    END
             WHERE	PINT_CODE = (SELECT PINT_CODE FROM SETLE WHERE RESVE_CODE = I_RESVE_CODE)
             ;
            /*포인트 내역 수정 성공 시*/
            IF SQL%FOUND THEN
                /*삭제 전 삭제된 포인트 저장*/
                SELECT PINT_CODE
                INTO V_CODE
                FROM SETLE
                WHERE RESVE_CODE = I_RESVE_CODE
                ;
                /*결제삭제*/
                DELETE FROM SETLE WHERE RESVE_CODE = I_RESVE_CODE;

                /*결제삭제 성공 시*/
                IF SQL%FOUND THEN
                    /*예매에 대한 포인트 정보 삭제*/
                    DELETE FROM PINT
                    WHERE PINT_CODE = V_CODE
                    ;
                    /*예매에 대한 포인트 정보 삭제 실패 시*/
                    IF SQL%NOTFOUND THEN
                        ER_CODE := '1';
                        ER_MSG := '예메취소 실패';
                        ROLLBACK;
                        RETURN;
                    END IF;

                    /*상세예매 정보 삭제*/
                    DELETE FROM DETAIL_RESVE WHERE RESVE_CODE = I_RESVE_CODE;
                    /*상세예매 정보 삭제 실패 시*/
                    IF SQL%FOUND THEN
                    	/*삭제된 ROW 수*/
                    	V_COUNT := SQL%ROWCOUNT;
                    	/*예약된좌석수 변경*/
                    	UPDATE ROOM SET
                        RESVE_SEAT_CO = CASE
                                        	WHEN NVL(RESVE_SEAT_CO, 0) > 0 THEN 0
                                        	ELSE TO_NUMBER(NVL(RESVE_SEAT_CO, 0))-V_COUNT
                        				 END
                        WHERE OPRAT_CODE = (
                        					 SELECT OPRAT_CODE
                                             FROM	RESVE
                                             WHERE	RESVE_CODE = I_RESVE_CODE
                                             GROUP BY OPRAT_CODE
                        					)
                    	;

                        DELETE FROM RESVE WHERE RESVE_CODE = I_RESVE_CODE;
                        /*예매 정보 삭제 실패 시*/
                        IF SQL%NOTFOUND THEN
                            ER_CODE := '1';
                            ER_MSG := '예메취소 실패';
                            ROLLBACK;
                            RETURN;
                    END IF
                    ;
                    /*상세예매 정보 삭제 실패 시*/
                    ELSE
                        ER_CODE := '1';
                        ER_MSG := '예메취소 실패';
                        ROLLBACK;
                        RETURN;
                    END IF
                    ;
                ELSE
                    ER_CODE := '1';
                    ER_MSG := '예메취소 실패';
                    ROLLBACK;
                    RETURN;
                END IF
                ;
            ELSE
                ER_CODE := '1';
                ER_MSG := '포인트 내역 수정 실패';
                ROLLBACK;
                RETURN;
            END IF
            ;
        ELSE
        	/*결제삭제*/
            DELETE FROM SETLE WHERE ID = I_ID;
            IF SQL%FOUND THEN
            	/*포인트 정보 삭제*/
                DELETE FROM PINT WHERE ID = I_ID;
                IF SQL%NOTFOUND THEN
                	ER_CODE := '1';
                    ER_MSG := '예메취소 실패';
                    ROLLBACK;
                    RETURN;
                END IF
                ;
            ELSE
            	ER_CODE := '1';
                ER_MSG := '예메취소 실패';
                ROLLBACK;
                RETURN;
            END IF
            ;

            /*상세예약 삭제*/
            FOR DATA IN C_RESVE LOOP
            	DELETE FROM DETAIL_RESVE
            	WHERE RESVE_CODE = DATA.RESVE_CODE;
                /*행수저장*/
                V_COUNT := C_RESVE%ROWCOUNT;
            END LOOP;

            IF V_COUNT > 0 THEN
            	/*예약된좌석수 변경*/
                UPDATE ROOM SET
                RESVE_SEAT_CO = CASE
                                    WHEN NVL(RESVE_SEAT_CO, 0) > 0 THEN 0
                                    ELSE TO_NUMBER(NVL(RESVE_SEAT_CO, 0))-V_COUNT
                                 END
                WHERE OPRAT_CODE = (
                                     SELECT OPRAT_CODE
                                     FROM	RESVE
                                     WHERE	RESVE_CODE = I_RESVE_CODE
                                     GROUP BY OPRAT_CODE
                                    )
                ;

            	/*예약삭제*/
            	DELETE FROM RESVE WHERE ID = I_ID AND RESVE_CODE = I_RESVE_CODE;
                IF SQL%NOTFOUND THEN
                	ER_CODE := '1';
                    ER_MSG := '예메취소 실패';
                    ROLLBACK;
                    RETURN;
                END IF
                ;
            ELSE
            	ER_CODE := '1';
                ER_MSG := '예메취소 실패';
                ROLLBACK;
                RETURN;
            END IF
            ;
        END IF
        ;

    	ER_CODE := '0';
    	ER_MSG := '예매취소 성공';

        EXCEPTION
    		WHEN OTHERS THEN
            	ER_CODE := '1';
              	ER_MSG := SQLCODE || '-' || SQLERRM;
                ROLLBACK;
                RETURN;
    END SP_DEL_RESVE
    ;
END PK_MEMBER_RESVE;


