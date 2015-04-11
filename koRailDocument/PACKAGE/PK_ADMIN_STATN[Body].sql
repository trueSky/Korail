CREATE OR REPLACE PACKAGE BODY KORAIL.PK_ADMIN_STATN AS
    /**********************************************************
    * 이름	   : FN_SLT_STATN
    * 설명	   : 역 조회 함수
    * 관련테이블	: STATN
    **********************************************************/
	FUNCTION FN_SLT_STATN(
    	I_AREA_CODE	IN	VARCHAR2 	/*지역코드*/,
		I_STATN_NM	IN	VARCHAR2	/*검색어*/
    )
    RETURN T_STATN PIPELINED
    IS
    	/*전체 검색*/
        CURSOR C_ALL IS(
          SELECT	B.STATN_CODE 				/*역코드*/,
                    A.CMMN_CODE AS AREA			/*지역코드*/,
                	B.STATN_NM	 				/*역 명*/,
                	B.REGISTER	 				/*등록자*/,
                	B.UPD_USER	 				/*수정자*/,
		        	B.RGSDE 	 				/*수정일*/,
	        		B.UPDDE		 				/*수정일*/
            FROM	CMMN_CODE A  				/*공통코드*/,
            		STATN B		 				/*역*/
            WHERE	A.CMMN_CODE = B.AREA_CODE
        );

    	/*지역으로 검색*/
    	CURSOR C_AREA IS(
          SELECT	B.STATN_CODE 				/*역코드*/,
                    A.CMMN_CODE AS AREA			/*지역코드*/,
                	B.STATN_NM	 				/*역 명*/,
                	B.REGISTER	 				/*등록자*/,
                	B.UPD_USER	 				/*수정자*/,
		        	B.RGSDE 	 				/*수정일*/,
	        		B.UPDDE		 				/*수정일*/
            FROM	CMMN_CODE A  				/*공통코드*/,
            		STATN B		 				/*역*/
            WHERE	A.CMMN_CODE = B.AREA_CODE
            AND		B.AREA_CODE = I_AREA_CODE
        );

		/*역 명으로 검색*/
        CURSOR C_STATN_MN IS(
        	SELECT	B.STATN_CODE 				/*역코드*/,
            		A.CMMN_CODE AS AREA			/*지역코드*/,
                	B.STATN_NM	 				/*역 명*/,
                	B.REGISTER	 				/*등록자*/,
                	B.UPD_USER	 				/*수정자*/,
		        	B.RGSDE 	 				/*수정일*/,
	        		B.UPDDE		 				/*수정일*/
            FROM	CMMN_CODE A  				/*공통코드*/,
            		STATN B		 				/*역*/
            WHERE	A.CMMN_CODE = B.AREA_CODE
            AND		B.STATN_NM LIKE '%'|| I_STATN_NM || '%'
        );

        /*리턴할 값을 저장시킬 테이블 TYPE 선언*/
        SET_STATN T_STATN := T_STATN();
	BEGIN
    	/*SET_STATN에 C_ALL의 데이터를 설정*/
    	IF I_AREA_CODE = 'ALL' THEN
        	FOR DATA IN C_ALL LOOP
            	SET_STATN.EXTEND;
                SET_STATN(SET_STATN.COUNT).STATN_CODE := DATA.STATN_CODE;
                SET_STATN(SET_STATN.COUNT).AREA_CODE := DATA.AREA;
                SET_STATN(SET_STATN.COUNT).STATN_NM := DATA.STATN_NM;
                SET_STATN(SET_STATN.COUNT).REGISTER := DATA.REGISTER;
                SET_STATN(SET_STATN.COUNT).UPD_USER := DATA.UPD_USER;
                SET_STATN(SET_STATN.COUNT).RGSDE := DATA.RGSDE;
                SET_STATN(SET_STATN.COUNT).UPDDE := DATA.UPDDE;

            	PIPE ROW(SET_STATN(SET_STATN.COUNT));
          	END LOOP
          	;
    	/*SET_STATN에 C_AREA의 데이터를 설정*/
    	ELSIF I_STATN_NM IS NULL THEN
        	FOR DATA IN C_AREA LOOP
            	SET_STATN.EXTEND;
                SET_STATN(SET_STATN.COUNT).STATN_CODE := DATA.STATN_CODE;
                SET_STATN(SET_STATN.COUNT).AREA_CODE := DATA.AREA;
                SET_STATN(SET_STATN.COUNT).STATN_NM := DATA.STATN_NM;
                SET_STATN(SET_STATN.COUNT).REGISTER := DATA.REGISTER;
                SET_STATN(SET_STATN.COUNT).UPD_USER := DATA.UPD_USER;
                SET_STATN(SET_STATN.COUNT).RGSDE := DATA.RGSDE;
                SET_STATN(SET_STATN.COUNT).UPDDE := DATA.UPDDE;

            	PIPE ROW(SET_STATN(SET_STATN.COUNT));
          	END LOOP
          	;
          /*SET_STATN에 C_STATN_MN의 데이터를 설정*/
          ELSE
          	FOR DATA IN C_STATN_MN LOOP
                SET_STATN.EXTEND;
                SET_STATN(SET_STATN.COUNT).STATN_CODE := DATA.STATN_CODE;
                SET_STATN(SET_STATN.COUNT).AREA_CODE := DATA.AREA;
                SET_STATN(SET_STATN.COUNT).STATN_NM := DATA.STATN_NM;
                SET_STATN(SET_STATN.COUNT).REGISTER := DATA.REGISTER;
                SET_STATN(SET_STATN.COUNT).UPD_USER := DATA.UPD_USER;
                SET_STATN(SET_STATN.COUNT).RGSDE := DATA.RGSDE;
                SET_STATN(SET_STATN.COUNT).UPDDE := DATA.UPDDE;

                PIPE ROW(SET_STATN(SET_STATN.COUNT));
            END LOOP
            ;
        END IF;
    END FN_SLT_STATN
    ;
END PK_ADMIN_STATN;


