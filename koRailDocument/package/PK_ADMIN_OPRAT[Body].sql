/*------------------------------------------------------------------------------
-- 개체 이름 : KORAIL.PK_ADMIN_OPRAT
-- 만든 날짜 : 2014-11-15 오후 8:20:17
-- 마지막으로 수정한 날짜 : 2014-12-23 오전 4:26:44
-- 상태 : VALID
------------------------------------------------------------------------------*/
CREATE OR REPLACE PACKAGE BODY KORAIL.PK_ADMIN_OPRAT AS
	/**********************************************************
    * 이름        : FN_SLT_OPRAT
    * 설명        : 운행일정 조회 함수
    * 관련테이블  : OPRAT, TARIN
    **********************************************************/
	FUNCTION FN_SLT_OPRAT(
    	I_TRAIN_KND		IN	VARCHAR2 	/*열차종류*/,
		I_TRAIN_NO		IN	VARCHAR2	/*열차번호*/,
        I_OPRAT_CODE	IN	VARCHAR2	/*운행코드*/
    )
    RETURN T_OPRAT PIPELINED
    IS
    	/*열차번호로 검색*/
    	CURSOR C_TRAIN_NO IS(
			SELECT	B.OPRAT_CODE	/*운행코드*/,
            		A.TRAIN_CODE	/*열차코드*/,
       				A.TRAIN_NO		/*열차번호*/,

                    /*열차유형 코드, 열차유형코드 값*/
       				A.TRAIN_KND AS TRAIN_KND_CODE,
       				PK_CMMN.TO_CODE_VALUE('CMMN_CODE', A.TRAIN_KND) AS TRAIN_KND_VALUE,

                    /*출발역 코드, 출발역코드 값*/
       				B.START_STATN AS START_STATN_CODE,
       				 PK_CMMN.TO_CODE_VALUE('STATN', B.START_STATN) AS START_STATN_VALUE,

                    /*도착역 코드, 도착역코드 값*/
       				B.ARVL_STATN AS ARVL_STATN_CODE,
       				 PK_CMMN.TO_CODE_VALUE('STATN', B.ARVL_STATN) AS ARVL_STATN_VALUE,

                	B.START_TM	/*출발시각*/,
       				B.ARVL_TM	/*도착시각*/,

                    /*노선코드, 노선코드 값*/
       				B.ROUTE_CODE,
       				PK_CMMN.TO_CODE_VALUE('CMMN_CODE', B.ROUTE_CODE) AS ROUTE_VALUE,

       				B.DISTNC	/*거리*/,
       				B.FARE		/*요금*/,
       				B.REGISTER	/*등록자*/,
       				B.RGSDE		/*등록일*/,
       				B.UPDUSR	/*수정자*/,
       				B.UPDDE		/*수정일*/
  			FROM	TRAIN A		/*열차*/,
       				OPRAT B		/*일정*/
 			WHERE	A.TRAIN_CODE = B.TRAIN_CODE
 			AND  	A.TRAIN_NO LIKE I_TRAIN_NO || '%'
        );

        /*열차종류로 검색*/
    	CURSOR C_TRAIN_KND IS(
			SELECT	B.OPRAT_CODE	/*운행코드*/,
            		A.TRAIN_CODE	/*열차코드*/,
       				A.TRAIN_NO		/*열차번호*/,

                    /*열차유형 코드, 열차유형코드 값*/
       				A.TRAIN_KND AS TRAIN_KND_CODE,
       				PK_CMMN.TO_CODE_VALUE('CMMN_CODE', A.TRAIN_KND) AS TRAIN_KND_VALUE,

                    /*출발역 코드, 출발역코드 값*/
       				B.START_STATN AS START_STATN_CODE,
       				 PK_CMMN.TO_CODE_VALUE('STATN', B.START_STATN) AS START_STATN_VALUE,

                    /*도착역 코드, 도착역코드 값*/
       				B.ARVL_STATN AS ARVL_STATN_CODE,
       				 PK_CMMN.TO_CODE_VALUE('STATN', B.ARVL_STATN) AS ARVL_STATN_VALUE,

                	B.START_TM	/*출발시각*/,
       				B.ARVL_TM	/*도착시각*/,

                    /*노선코드, 노선코드 값*/
       				B.ROUTE_CODE,
       				PK_CMMN.TO_CODE_VALUE('CMMN_CODE', B.ROUTE_CODE) AS ROUTE_VALUE,

       				B.DISTNC	/*거리*/,
       				B.FARE		/*요금*/,
       				B.REGISTER	/*등록자*/,
       				B.RGSDE		/*등록일*/,
       				B.UPDUSR	/*수정자*/,
       				B.UPDDE		/*수정일*/
  			FROM	TRAIN A		/*열차*/,
       				OPRAT B		/*일정*/
 			WHERE	A.TRAIN_CODE = B.TRAIN_CODE
 			AND  	A.TRAIN_KND = I_TRAIN_KND
        );

    	/*운행코드로 검색*/
    	CURSOR C_OPRAT_CODE IS(
			SELECT	B.OPRAT_CODE	/*운행코드*/,
            		A.TRAIN_CODE	/*열차코드*/,
       				A.TRAIN_NO		/*열차번호*/,

                    /*열차유형 코드, 열차유형코드 값*/
       				A.TRAIN_KND AS TRAIN_KND_CODE,
       				PK_CMMN.TO_CODE_VALUE('CMMN_CODE', A.TRAIN_KND) AS TRAIN_KND_VALUE,

                    /*출발역 코드, 출발역코드 값*/
       				B.START_STATN AS START_STATN_CODE,
       				 PK_CMMN.TO_CODE_VALUE('STATN', B.START_STATN) AS START_STATN_VALUE,

                    /*도착역 코드, 도착역코드 값*/
       				B.ARVL_STATN AS ARVL_STATN_CODE,
       				 PK_CMMN.TO_CODE_VALUE('STATN', B.ARVL_STATN) AS ARVL_STATN_VALUE,

                	B.START_TM	/*출발시각*/,
       				B.ARVL_TM	/*도착시각*/,

                    /*노선코드, 노선코드 값*/
       				B.ROUTE_CODE,
       				PK_CMMN.TO_CODE_VALUE('CMMN_CODE', B.ROUTE_CODE) AS ROUTE_VALUE,

       				B.DISTNC	/*거리*/,
       				B.FARE		/*요금*/,
       				B.REGISTER	/*등록자*/,
       				B.RGSDE		/*등록일*/,
       				B.UPDUSR	/*수정자*/,
       				B.UPDDE		/*수정일*/
  			FROM	TRAIN A		/*열차*/,
       				OPRAT B		/*일정*/
 			WHERE	A.TRAIN_CODE = B.TRAIN_CODE
 			AND  	OPRAT_CODE = I_OPRAT_CODE
        );

        /*리턴할 값을 저장시킬 테이블 TYPE 선언*/
        SET_OPRAT T_OPRAT := T_OPRAT();
	BEGIN
    	/*SET_OPRAT에 C_TRAIN_KND의 데이터를 설정*/
    	IF I_TRAIN_NO IS NOT NULL THEN
        	FOR DATA IN C_TRAIN_NO LOOP
            	SET_OPRAT.EXTEND;
                SET_OPRAT(SET_OPRAT.COUNT).OPRAT_CODE := DATA.OPRAT_CODE;
                SET_OPRAT(SET_OPRAT.COUNT).TRAIN_CODE := DATA.TRAIN_CODE;
                SET_OPRAT(SET_OPRAT.COUNT).TRAIN_NO := DATA.TRAIN_NO;
                SET_OPRAT(SET_OPRAT.COUNT).TRAIN_KND_CODE := DATA.TRAIN_KND_CODE;
                SET_OPRAT(SET_OPRAT.COUNT).TRAIN_KND_VALUE := DATA.TRAIN_KND_VALUE;
                SET_OPRAT(SET_OPRAT.COUNT).START_STATN_CODE := DATA.START_STATN_CODE;
                SET_OPRAT(SET_OPRAT.COUNT).START_STATN_VALUE := DATA.START_STATN_VALUE;
                SET_OPRAT(SET_OPRAT.COUNT).ARVL_STATN_CODE := DATA.ARVL_STATN_CODE;
				SET_OPRAT(SET_OPRAT.COUNT).ARVL_STATN_VALUE := DATA.ARVL_STATN_VALUE;
				SET_OPRAT(SET_OPRAT.COUNT).START_TM := DATA.START_TM;
				SET_OPRAT(SET_OPRAT.COUNT).ARVL_TM := DATA.ARVL_TM;
				SET_OPRAT(SET_OPRAT.COUNT).ROUTE_CODE := DATA.ROUTE_CODE;
				SET_OPRAT(SET_OPRAT.COUNT).ROUTE_VALUE := DATA.ROUTE_VALUE;
				SET_OPRAT(SET_OPRAT.COUNT).DISTNC := DATA.DISTNC;
				SET_OPRAT(SET_OPRAT.COUNT).FARE := DATA.FARE;
				SET_OPRAT(SET_OPRAT.COUNT).REGISTER := DATA.REGISTER;
				SET_OPRAT(SET_OPRAT.COUNT).RGSDE := DATA.RGSDE;
				SET_OPRAT(SET_OPRAT.COUNT).UPDUSR := DATA.UPDUSR;
				SET_OPRAT(SET_OPRAT.COUNT).UPDDE := DATA.UPDDE;
                PIPE ROW(SET_OPRAT(SET_OPRAT.COUNT));
          	END LOOP
          	;
          /*SET_OPRAT에 C_OPRAT_CODE의 데이터를 설정*/
          ELSIF I_OPRAT_CODE IS NOT NULL THEN
          	FOR DATA IN C_OPRAT_CODE LOOP
            	SET_OPRAT.EXTEND;
                SET_OPRAT(SET_OPRAT.COUNT).OPRAT_CODE := DATA.OPRAT_CODE;
                SET_OPRAT(SET_OPRAT.COUNT).TRAIN_CODE := DATA.TRAIN_CODE;
                SET_OPRAT(SET_OPRAT.COUNT).TRAIN_NO := DATA.TRAIN_NO;
                SET_OPRAT(SET_OPRAT.COUNT).TRAIN_KND_CODE := DATA.TRAIN_KND_CODE;
                SET_OPRAT(SET_OPRAT.COUNT).TRAIN_KND_VALUE := DATA.TRAIN_KND_VALUE;
                SET_OPRAT(SET_OPRAT.COUNT).START_STATN_CODE := DATA.START_STATN_CODE;
                SET_OPRAT(SET_OPRAT.COUNT).START_STATN_VALUE := DATA.START_STATN_VALUE;
                SET_OPRAT(SET_OPRAT.COUNT).ARVL_STATN_CODE := DATA.ARVL_STATN_CODE;
				SET_OPRAT(SET_OPRAT.COUNT).ARVL_STATN_VALUE := DATA.ARVL_STATN_VALUE;
				SET_OPRAT(SET_OPRAT.COUNT).START_TM := DATA.START_TM;
				SET_OPRAT(SET_OPRAT.COUNT).ARVL_TM := DATA.ARVL_TM;
				SET_OPRAT(SET_OPRAT.COUNT).ROUTE_CODE := DATA.ROUTE_CODE;
				SET_OPRAT(SET_OPRAT.COUNT).ROUTE_VALUE := DATA.ROUTE_VALUE;
				SET_OPRAT(SET_OPRAT.COUNT).DISTNC := DATA.DISTNC;
				SET_OPRAT(SET_OPRAT.COUNT).FARE := DATA.FARE;
				SET_OPRAT(SET_OPRAT.COUNT).REGISTER := DATA.REGISTER;
				SET_OPRAT(SET_OPRAT.COUNT).RGSDE := DATA.RGSDE;
				SET_OPRAT(SET_OPRAT.COUNT).UPDUSR := DATA.UPDUSR;
				SET_OPRAT(SET_OPRAT.COUNT).UPDDE := DATA.UPDDE;
                PIPE ROW(SET_OPRAT(SET_OPRAT.COUNT));
          	END LOOP
          	;
          /*SET_OPRAT에 C_TRAIN_KND의 데이터를 설정*/
          ELSE
          	FOR DATA IN C_TRAIN_KND LOOP
            	SET_OPRAT.EXTEND;
                SET_OPRAT(SET_OPRAT.COUNT).OPRAT_CODE := DATA.OPRAT_CODE;
                SET_OPRAT(SET_OPRAT.COUNT).TRAIN_CODE := DATA.TRAIN_CODE;
                SET_OPRAT(SET_OPRAT.COUNT).TRAIN_NO := DATA.TRAIN_NO;
                SET_OPRAT(SET_OPRAT.COUNT).TRAIN_KND_CODE := DATA.TRAIN_KND_CODE;
                SET_OPRAT(SET_OPRAT.COUNT).TRAIN_KND_VALUE := DATA.TRAIN_KND_VALUE;
                SET_OPRAT(SET_OPRAT.COUNT).START_STATN_CODE := DATA.START_STATN_CODE;
                SET_OPRAT(SET_OPRAT.COUNT).START_STATN_VALUE := DATA.START_STATN_VALUE;
                SET_OPRAT(SET_OPRAT.COUNT).ARVL_STATN_CODE := DATA.ARVL_STATN_CODE;
				SET_OPRAT(SET_OPRAT.COUNT).ARVL_STATN_VALUE := DATA.ARVL_STATN_VALUE;
				SET_OPRAT(SET_OPRAT.COUNT).START_TM := DATA.START_TM;
				SET_OPRAT(SET_OPRAT.COUNT).ARVL_TM := DATA.ARVL_TM;
				SET_OPRAT(SET_OPRAT.COUNT).ROUTE_CODE := DATA.ROUTE_CODE;
				SET_OPRAT(SET_OPRAT.COUNT).ROUTE_VALUE := DATA.ROUTE_VALUE;
				SET_OPRAT(SET_OPRAT.COUNT).DISTNC := DATA.DISTNC;
				SET_OPRAT(SET_OPRAT.COUNT).FARE := DATA.FARE;
				SET_OPRAT(SET_OPRAT.COUNT).REGISTER := DATA.REGISTER;
				SET_OPRAT(SET_OPRAT.COUNT).RGSDE := DATA.RGSDE;
				SET_OPRAT(SET_OPRAT.COUNT).UPDUSR := DATA.UPDUSR;
				SET_OPRAT(SET_OPRAT.COUNT).UPDDE := DATA.UPDDE;
                PIPE ROW(SET_OPRAT(SET_OPRAT.COUNT));
          	END LOOP
          	;
        END IF;
    END FN_SLT_OPRAT
    ;

    /**********************************************************
    * 이름        : FN_SLT_DETAIL_OPRAT
    * 설명        : 상세운행일정 조회 함수
    * 관련테이블  : DETAIL_OPRAT
    **********************************************************/
	FUNCTION FN_SLT_DETAIL_OPRAT(
		I_OPRAT_CODE IN	VARCHAR2	/*운행코드*/
    )
    RETURN T_DETAIL_OPRAT PIPELINED
    IS
    	/*운행정보의 상세운행정보 검색*/
    	CURSOR C_OPRAT_CODE IS(
			SELECT	DETAIL_OPRAT_CODE	/*상세운행코드*/,
                    OPRAT_CODE			/*운행코드*/,

                    /*출발역 코드, 출발역코드 값*/
                    START_STATN AS START_STATN_CODE,
                    PK_CMMN.TO_CODE_VALUE('STATN', START_STATN) AS START_STATN_VALUE,

                    /*도착역 코드, 도착역코드 값*/
                    ARVL_STATN AS ARVL_STATN_CODE,
                    PK_CMMN.TO_CODE_VALUE('STATN', ARVL_STATN) AS ARVL_STATN_VALUE,

                    START_TM	/*출발시각*/,
                    ARVL_TM		/*도착시각*/,

                    /*이전역 코드, 이전역코드 값*/
                    PRV_STATN AS PRV_STATN_CODE,
            		PK_CMMN.TO_CODE_VALUE('STATN', PRV_STATN) AS PRV_STATN_VALUE,

                    /*다음역 코드, 다음역코드 값*/
                    NXT_STATN AS NXT_STATN_CODE,
                    PK_CMMN.TO_CODE_VALUE('STATN', NXT_STATN) AS NXT_STATN_VALUE,

                    PRV_DISTNC			/*이전역거리*/,
                    NXT_DISTNC			/*다음역거리*/,
                    REGISTER			/*등록자*/,
                    UPDUSR				/*수정자*/,
                    RGSDE				/*등록일*/,
                    UPDDE				/*수정일*/
            FROM	DETAIL_OPRAT		/*상세운행*/
			WHERE	OPRAT_CODE = I_OPRAT_CODE
        );

        /*리턴할 값을 저장시킬 테이블 TYPE 선언*/
        SET_DETAIL_OPRAT T_DETAIL_OPRAT := T_DETAIL_OPRAT();
	BEGIN
    	/*SET_DETAIL_OPRAT에 C_OPRAT_CODE의 데이터를 설정*/
        FOR DATA IN C_OPRAT_CODE LOOP
            SET_DETAIL_OPRAT.EXTEND;
            SET_DETAIL_OPRAT(SET_DETAIL_OPRAT.COUNT).DETAIL_OPRAT_CODE := DATA.DETAIL_OPRAT_CODE;
            SET_DETAIL_OPRAT(SET_DETAIL_OPRAT.COUNT).OPRAT_CODE := DATA.OPRAT_CODE;
            SET_DETAIL_OPRAT(SET_DETAIL_OPRAT.COUNT).START_STATN_CODE := DATA.START_STATN_CODE;
            SET_DETAIL_OPRAT(SET_DETAIL_OPRAT.COUNT).START_STATN_VALUE := DATA.START_STATN_VALUE;
            SET_DETAIL_OPRAT(SET_DETAIL_OPRAT.COUNT).ARVL_STATN_CODE := DATA.ARVL_STATN_CODE;
            SET_DETAIL_OPRAT(SET_DETAIL_OPRAT.COUNT).ARVL_STATN_VALUE := DATA.ARVL_STATN_VALUE;
            SET_DETAIL_OPRAT(SET_DETAIL_OPRAT.COUNT).START_TM := DATA.START_TM;
            SET_DETAIL_OPRAT(SET_DETAIL_OPRAT.COUNT).ARVL_TM := DATA.ARVL_TM;
        	SET_DETAIL_OPRAT(SET_DETAIL_OPRAT.COUNT).PRV_STATN_CODE := DATA.PRV_STATN_CODE;
            SET_DETAIL_OPRAT(SET_DETAIL_OPRAT.COUNT).PRV_STATN_VALUE := DATA.PRV_STATN_VALUE;
            SET_DETAIL_OPRAT(SET_DETAIL_OPRAT.COUNT).NXT_STATN_CODE := DATA.NXT_STATN_CODE;
            SET_DETAIL_OPRAT(SET_DETAIL_OPRAT.COUNT).NXT_STATN_VALUE := DATA.NXT_STATN_VALUE;
            SET_DETAIL_OPRAT(SET_DETAIL_OPRAT.COUNT).PRV_DISTNC := DATA.PRV_DISTNC;
            SET_DETAIL_OPRAT(SET_DETAIL_OPRAT.COUNT).NXT_DISTNC := DATA.NXT_DISTNC;
            SET_DETAIL_OPRAT(SET_DETAIL_OPRAT.COUNT).REGISTER := DATA.REGISTER;
            SET_DETAIL_OPRAT(SET_DETAIL_OPRAT.COUNT).RGSDE := DATA.RGSDE;
            SET_DETAIL_OPRAT(SET_DETAIL_OPRAT.COUNT).UPDUSR := DATA.UPDUSR;
            SET_DETAIL_OPRAT(SET_DETAIL_OPRAT.COUNT).UPDDE := DATA.UPDDE;
            PIPE ROW(SET_DETAIL_OPRAT(SET_DETAIL_OPRAT.COUNT));
        END LOOP
        ;
    END FN_SLT_DETAIL_OPRAT
    ;
END PK_ADMIN_OPRAT;


