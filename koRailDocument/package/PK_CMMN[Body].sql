/*------------------------------------------------------------------------------
-- 개체 이름 : KORAIL.PK_CMMN
-- 만든 날짜 : 2014-11-10 오후 6:55:18
-- 마지막으로 수정한 날짜 : 2014-12-19 오전 2:56:52
-- 상태 : VALID
------------------------------------------------------------------------------*/
CREATE OR REPLACE PACKAGE BODY KORAIL.PK_CMMN AS
   /**********************************************************
    * 이름	   : SP_LOGIN
    * 설명	   : 로그인 프로시져
    * 관련테이블 : ADMIN, MEMBER
    **********************************************************/
	PROCEDURE SP_LOGIN(
   		I_TYPE	IN	VARCHAR2 	/*로그인 타입*/,
        I_ID	IN	VARCHAR2	/*아이디*/,
        I_PW 	IN	VARCHAR2	/*비밀번호*/,

        O_NAME	OUT VARCHAR2	/*로그인한 회원 명*/,

        ER_CODE OUT VARCHAR2	/*에러 코드(0 : 성공, 1 : 에러)*/,
        ER_MSG 	OUT VARCHAR2	/*에러 메세지*/
	)
    IS

    BEGIN
    	IF I_TYPE = 'admin' THEN
        	BEGIN
            	SELECT	MNGR_NM /*관리자 명*/
                INTO	O_NAME
                FROM	ADMIN	/*관리자*/
                WHERE	MNGR_ID = I_ID
                AND		MNGR_PASSWORD = I_PW
                ;
                EXCEPTION
                  WHEN NO_DATA_FOUND THEN
                      ER_CODE := '1';
                      ER_MSG := '로그인 실패';
                      ROLLBACK;
                      RETURN;
            END;
        ELSE
        	BEGIN
            	SELECT	NM		/*성명*/
                INTO	O_NAME
                FROM	MEMBER	/*회원*/
                WHERE	ID = I_ID
                AND		PASSWORD = I_PW
                ;
                EXCEPTION
                  WHEN NO_DATA_FOUND THEN
                      ER_CODE := '1';
                      ER_MSG := '로그인 실패';
                      ROLLBACK;
                      RETURN;
            END;
    	END IF;

        ER_CODE := '0';
        ER_MSG := '로그인 성공';

        EXCEPTION
    		WHEN OTHERS THEN
            	ER_CODE := '1';
              	ER_MSG := SQLCODE || '-' || SQLERRM;
                ROLLBACK;
                RETURN;
    END SP_LOGIN;

    /**********************************************************
    * 이름	   : SP_ID_CHECK
    * 설명	   : 로그인 프로시져
    * 관련테이블 : MEMBER
    **********************************************************/
	PROCEDURE SP_ID_CHECK(
    	I_ID	IN	VARCHAR2	/*아이디*/,

       	O_ID	OUT	VARCHAR2	/* 리턴 아이디 */,

        ER_CODE OUT VARCHAR2	/*에러 코드(0 : 성공, 1 : 에러)*/,
        ER_MSG 	OUT VARCHAR2	/*에러 메세지*/
    )
    IS

    BEGIN
    	/**************************
                  ID CHECK
        ***************************/
    	BEGIN
          SELECT	ID
          INTO	O_ID
          FROM	MEMBER
          WHERE	ID = I_ID;

          EXCEPTION
        	WHEN NO_DATA_FOUND THEN
            	ER_CODE := '0';
       			ER_MSG	:= '사용가능한 아이디 입니다.';
                RETURN;
        END;

        ER_CODE := '1';
        ER_MSG	:= '이미 사용중인 아이디 입니다.';
        RETURN;

        EXCEPTION
        	WHEN OTHERS THEN
            	ER_CODE := '1';
        		ER_MSG	:= '서버에러';
                RETURN;
    END SP_ID_CHECK;

   /**********************************************************
    * 이름	    : FN_SLT_CMMN
    * 설명	   : 공통코드 조회 함수
    * 관련테이블 : CMMN_CODE_SE, CMMN_CODE
    **********************************************************/
    FUNCTION FN_SLT_CMMN(
    	I_SE_CODE		  IN VARCHAR2 /*구분코드*/,
        I_CMMN_CODE_VALUE IN VARCHAR2 /*코드값*/
    )
    RETURN T_CMMN_CODE PIPELINED
    IS
    	/*공통코드 검색 구분코드 사용*/
    	CURSOR C_SE_CODE IS(
      		SELECT	CMMN_CODE			/*공통코드*/,
        			CMMN_CODE_VALUE 	/*값*/
          	FROM	CMMN_CODE
        	WHERE	SE_CODE = I_SE_CODE
      	);

        /*공통코드 검색 코드값 사용*/
    	CURSOR C_CMMN_CODE_VLAUE IS(
      		SELECT	CMMN_CODE			/*공통코드*/,
        			CMMN_CODE_VALUE 	/*값*/
          	FROM	CMMN_CODE
        	WHERE	CMMN_CODE_VALUE = I_CMMN_CODE_VALUE
      	);

    	/*리턴할 값을 저장시킬 테이블 TYPE 선언*/
   		SET_CMMN_CODE T_CMMN_CODE := T_CMMN_CODE();
    BEGIN
    	/*구분코드로 검색*/
    	IF I_CMMN_CODE_VALUE IS NULL THEN
        	BEGIN
            	FOR DATA IN C_SE_CODE LOOP
                  SET_CMMN_CODE.EXTEND;
                  SET_CMMN_CODE(SET_CMMN_CODE.COUNT).CMMN_CODE := DATA.CMMN_CODE;
                  SET_CMMN_CODE(SET_CMMN_CODE.COUNT).CMMN_CODE_VALUE := DATA.CMMN_CODE_VALUE;

                  PIPE ROW(SET_CMMN_CODE(SET_CMMN_CODE.COUNT));
                END LOOP
                ;
            END
            ;
        /*코드 값으로 검색*/
        ELSE
        	BEGIN
            	FOR DATA IN C_CMMN_CODE_VLAUE LOOP
                  SET_CMMN_CODE.EXTEND;
                  SET_CMMN_CODE(SET_CMMN_CODE.COUNT).CMMN_CODE := DATA.CMMN_CODE;
                  SET_CMMN_CODE(SET_CMMN_CODE.COUNT).CMMN_CODE_VALUE := DATA.CMMN_CODE_VALUE;

                  PIPE ROW(SET_CMMN_CODE(SET_CMMN_CODE.COUNT));
                END LOOP
                ;
            END
            ;
        END IF
        ;
	END FN_SLT_CMMN;

    /**********************************************************
    * 이름	   : TO_CODE_VALUE
    * 설명	   : 공통코드를 코드 값으로 변환하는 함수
    * 관련테이블 : CMMN_CODE, STATN
    **********************************************************/
    FUNCTION TO_CODE_VALUE(
    	I_TABLE IN VARCHAR2 /*검색 테이블*/,
    	I_CODE	IN VARCHAR2 /*변환할 코드*/
    )
    RETURN VARCHAR2
    IS
    	V_CODE_VALUE VARCHAR2(30); /*코드의 값*/
    BEGIN
    	IF I_TABLE = 'CMMN_CODE' THEN
        	SELECT	CMMN_CODE_VALUE
        	INTO	V_CODE_VALUE
        	FROM	CMMN_CODE
        	WHERE	CMMN_CODE = I_CODE
        	;
        ELSIF I_TABLE = 'STATN' THEN
        	SELECT	STATN_NM
        	INTO	V_CODE_VALUE
        	FROM	STATN
        	WHERE	STATN_CODE = I_CODE
            ;
        END IF;

        RETURN V_CODE_VALUE;
    END TO_CODE_VALUE
    ;
END PK_CMMN;


