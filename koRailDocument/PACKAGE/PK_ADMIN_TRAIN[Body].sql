CREATE OR REPLACE PACKAGE BODY KORAIL.PK_ADMIN_TRAIN AS
    /**********************************************************
    * 이름	   : FN_SLT_TRAIN
    * 설명	   : 열차 조회 함수
    * 관련테이블	: TRAIN
	**********************************************************/
	FUNCTION FN_SLT_TRAIN(
    	I_TRAIN_KND	IN	VARCHAR2 	/*열차종류*/,
		I_TRAIN_NO	IN	VARCHAR2	/*열차번호*/
    )
    RETURN T_TRAIN PIPELINED
    IS
    	/*전체 검색*/
    	CURSOR C_TRAIN_ALL IS(
			SELECT	TRAIN_CODE	/*열차코드*/,
        			TRAIN_KND	/*열차종류*/,
  					TRAIN_NO	/*열차번호*/,
                	REGISTER	/*등록자*/,
                	UPDUSR		/*수정자*/,
		        	RGSDE 	 	/*수정일*/,
	        		UPDDE		/*수정일*/
            FROM	TRAIN		/*열차*/
        );

    	/*열차번호로 검색*/
    	CURSOR C_TRAIN_KND IS(
			SELECT	TRAIN_CODE	/*열차코드*/,
        			TRAIN_KND	/*열차종류*/,
  					TRAIN_NO	/*열차번호*/,
                	REGISTER	/*등록자*/,
                	UPDUSR		/*수정자*/,
		        	RGSDE 	 	/*수정일*/,
	        		UPDDE		/*수정일*/
            FROM	TRAIN		/*열차*/
            WHERE	TRAIN_KND = I_TRAIN_KND
        );

		/*열차번호로 검색*/
        CURSOR C_TRAIN_NO IS(
        	SELECT	TRAIN_CODE	/*열차코드*/,
        			TRAIN_KND	/*열차종류*/,
  					TRAIN_NO	/*열차번호*/,
                	REGISTER	/*등록자*/,
                	UPDUSR		/*수정자*/,
		        	RGSDE 	 	/*수정일*/,
	        		UPDDE		/*수정일*/
            FROM	TRAIN		/*열차*/
            WHERE	TRAIN_NO LIKE '%'|| I_TRAIN_NO || '%'
        );

        /*리턴할 값을 저장시킬 테이블 TYPE 선언*/
        SET_TRAIN T_TRAIN := T_TRAIN();
	BEGIN
    	/*SET_TRAIN에 C_TRAIN_ALL의 데이터를 설정*/
    	IF I_TRAIN_KND = 'ALL' THEN
        	FOR DATA IN C_TRAIN_ALL LOOP
            	SET_TRAIN.EXTEND;
                SET_TRAIN(SET_TRAIN.COUNT).TRAIN_CODE := DATA.TRAIN_CODE;
                SET_TRAIN(SET_TRAIN.COUNT).TRAIN_KND := DATA.TRAIN_KND;
                SET_TRAIN(SET_TRAIN.COUNT).TRAIN_NO := DATA.TRAIN_NO;
                SET_TRAIN(SET_TRAIN.COUNT).REGISTER := DATA.REGISTER;
                SET_TRAIN(SET_TRAIN.COUNT).UPDUSR := DATA.UPDUSR;
                SET_TRAIN(SET_TRAIN.COUNT).RGSDE := DATA.RGSDE;
                SET_TRAIN(SET_TRAIN.COUNT).UPDDE := DATA.UPDDE;

            	PIPE ROW(SET_TRAIN(SET_TRAIN.COUNT));
          	END LOOP
          	;
        /*SET_TRAIN에 C_TRAIN_KND의 데이터를 설정*/
        ELSIF I_TRAIN_NO IS NULL THEN
        	FOR DATA IN C_TRAIN_KND LOOP
            	SET_TRAIN.EXTEND;
                SET_TRAIN(SET_TRAIN.COUNT).TRAIN_CODE := DATA.TRAIN_CODE;
                SET_TRAIN(SET_TRAIN.COUNT).TRAIN_KND := DATA.TRAIN_KND;
                SET_TRAIN(SET_TRAIN.COUNT).TRAIN_NO := DATA.TRAIN_NO;
                SET_TRAIN(SET_TRAIN.COUNT).REGISTER := DATA.REGISTER;
                SET_TRAIN(SET_TRAIN.COUNT).UPDUSR := DATA.UPDUSR;
                SET_TRAIN(SET_TRAIN.COUNT).RGSDE := DATA.RGSDE;
                SET_TRAIN(SET_TRAIN.COUNT).UPDDE := DATA.UPDDE;

            	PIPE ROW(SET_TRAIN(SET_TRAIN.COUNT));
          	END LOOP
          	;
          /*SET_TRAIN에 C_TRAIN_NO의 데이터를 설정*/
          ELSE
          	FOR DATA IN C_TRAIN_NO LOOP
            	SET_TRAIN.EXTEND;
                SET_TRAIN(SET_TRAIN.COUNT).TRAIN_CODE := DATA.TRAIN_CODE;
                SET_TRAIN(SET_TRAIN.COUNT).TRAIN_KND := DATA.TRAIN_KND;
                SET_TRAIN(SET_TRAIN.COUNT).TRAIN_NO := DATA.TRAIN_NO;
                SET_TRAIN(SET_TRAIN.COUNT).REGISTER := DATA.REGISTER;
                SET_TRAIN(SET_TRAIN.COUNT).UPDUSR := DATA.UPDUSR;
                SET_TRAIN(SET_TRAIN.COUNT).RGSDE := DATA.RGSDE;
                SET_TRAIN(SET_TRAIN.COUNT).UPDDE := DATA.UPDDE;

            	PIPE ROW(SET_TRAIN(SET_TRAIN.COUNT));
          	END LOOP
          	;
        END IF;
    END FN_SLT_TRAIN
    ;
END PK_ADMIN_TRAIN;


