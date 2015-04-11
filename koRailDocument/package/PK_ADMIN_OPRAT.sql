/*------------------------------------------------------------------------------
-- 개체 이름 : KORAIL.PK_ADMIN_OPRAT
-- 만든 날짜 : 2014-11-15 오후 6:30:05
-- 마지막으로 수정한 날짜 : 2014-12-19 오전 2:41:51
-- 상태 : VALID
------------------------------------------------------------------------------*/
CREATE OR REPLACE PACKAGE KORAIL.PK_ADMIN_OPRAT
AS
    /*TABLE TYPE에 들어갈 RECORD*/
	TYPE R_OPRAT IS RECORD(
    	OPRAT_CODE	        VARCHAR2(30),	/*운행코드*/
        TRAIN_CODE      	VARCHAR2(30),	/*열차코드*/
        TRAIN_NO            VARCHAR2(30),   /*열차번호*/
        TRAIN_KND_CODE      VARCHAR2(30),   /*열차종류 코드*/
        TRAIN_KND_VALUE     VARCHAR2(30),   /*열차종류 값*/
        START_STATN_CODE    VARCHAR2(30),   /*출발역 코드*/
        START_STATN_VALUE   VARCHAR2(30),   /*출발역 값*/
        ARVL_STATN_CODE     VARCHAR2(30),   /*도착역 코드*/
        ARVL_STATN_VALUE    VARCHAR2(30),   /*도착역 값*/
        START_TM	        DATE,	        /*출발시각*/
        ARVL_TM	            DATE,	        /*도착시각*/
        ROUTE_CODE	        VARCHAR2(30),	/*노선코드*/
        ROUTE_VALUE			VARCHAR2(30),   /*노선코드 값*/
        DISTNC	            NUMBER(4,1),	/*거리*/
        FARE	            NUMBER(10),	    /*요금*/
        REGISTER	        VARCHAR2(30),	/*등록자*/
        UPDUSR	            VARCHAR2(30),	/*수정자*/
        RGSDE	            DATE,	        /*등록일*/
        UPDDE	            DATE	        /*수정일*/
    );
	/*R_OPRAT를 가진 TABLE TYPE*/
	TYPE T_OPRAT IS TABLE OF R_OPRAT;

    /*TABLE TYPE에 들어갈 RECORD*/
	TYPE R_DETAIL_OPRAT IS RECORD(
    	DETAIL_OPRAT_CODE	VARCHAR2(30),	/*상세운행코드*/
	    OPRAT_CODE			VARCHAR2(30),	/*운행코드*/
	    TRAIN_KND_VALUE     VARCHAR2(30),   /*열차종류 값*/
        START_STATN_CODE    VARCHAR2(30),   /*출발역 코드*/
        START_STATN_VALUE   VARCHAR2(30),   /*출발역 값*/
        ARVL_STATN_CODE     VARCHAR2(30),   /*도착역 코드*/
        ARVL_STATN_VALUE    VARCHAR2(30),   /*도착역 값*/
        START_TM	        DATE,	        /*출발시각*/
        ARVL_TM	            DATE,	        /*도착시각*/
	    PRV_STATN_CODE		VARCHAR2(30),	/*이전역코드*/
	    PRV_STATN_VALUE		VARCHAR2(30),	/*이전역코드 값*/
	    NXT_STATN_CODE		VARCHAR2(30),	/*다음역코드*/
	    NXT_STATN_VALUE		VARCHAR2(30),	/*다음역코드 값*/
	    PRV_DISTNC			NUMBER(4,1),	/*이전역거리*/
	    NXT_DISTNC			NUMBER(4,1),	/*다음역거리*/
	    REGISTER			VARCHAR2(30),	/*등록자*/
		UPDUSR				VARCHAR2(30),	/*수정자*/
		RGSDE				DATE,			/*등록일*/
		UPDDE				DATE			/*수정일*/
    );
    /*R_OPRAT를 가진 TABLE TYPE*/
	TYPE T_DETAIL_OPRAT IS TABLE OF R_DETAIL_OPRAT;

    /**********************************************************
    * 이름        : FN_SLT_OPRAT
    * 설명        : 운행일정 조회 함수
    * 관련테이블  : OPRAT, TARIN
    **********************************************************/
	FUNCTION FN_SLT_OPRAT
    	(
           	I_TRAIN_KND		IN	VARCHAR2 	/*열차종류*/,
			I_TRAIN_NO		IN	VARCHAR2	/*열차번호*/,
       	 	I_OPRAT_CODE	IN	VARCHAR2	/*운행코드*/
		)
        RETURN T_OPRAT PIPELINED
    ;

    /**********************************************************
    * 이름        : FN_SLT_DETAIL_OPRAT
    * 설명        : 상세운행일정 조회 함수
    * 관련테이블  : DETAIL_OPRAT
    **********************************************************/
	FUNCTION FN_SLT_DETAIL_OPRAT
    	(
        	I_OPRAT_CODE IN VARCHAR2 /*운행코드*/
        )
        RETURN T_DETAIL_OPRAT PIPELINED
    ;
END PK_ADMIN_OPRAT;


