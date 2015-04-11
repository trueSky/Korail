/*------------------------------------------------------------------------------
-- 개체 이름 : KORAIL.PK_CMMN
-- 만든 날짜 : 2014-11-10 오후 6:54:41
-- 마지막으로 수정한 날짜 : 2014-12-19 오전 2:51:46
-- 상태 : VALID
------------------------------------------------------------------------------*/
CREATE OR REPLACE PACKAGE KORAIL.PK_CMMN
AS
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
	);

    /**********************************************************
    * 이름	   : SP_ID_CHECK
    * 설명	   : 로그인 프로시져
    * 관련테이블 : MEMBER
    **********************************************************/
	PROCEDURE SP_ID_CHECK(
    	I_ID	IN	VARCHAR2	/*아이디*/,

       	O_ID	OUT	VARCHAR2	/*리턴 아이디*/,

        ER_CODE OUT VARCHAR2	/*에러 코드(0 : 성공, 1 : 에러)*/,
        ER_MSG 	OUT VARCHAR2	/*에러 메세지*/
    );

    /*CMMN_CODE 테이블을 가진 테이블 TYPE*/
	TYPE T_CMMN_CODE IS TABLE OF CMMN_CODE%ROWTYPE;

    /**********************************************************
    * 이름	   : FN_SLT_CMMN
    * 설명	   : 공통코드 조회 함수
    * 관련테이블 : CMMN_CODE_SE, CMMN_CODE
    **********************************************************/
    FUNCTION FN_SLT_CMMN(
    	I_SE_CODE		  IN VARCHAR2 /*구분코드*/,
        I_CMMN_CODE_VALUE IN VARCHAR2 /*코드값*/
	)
    RETURN T_CMMN_CODE PIPELINED
    ;

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
    ;
END PK_CMMN;


