CREATE OR REPLACE PACKAGE KORAIL.PK_ADMIN_STATN
AS
	/*STATN 테이블을 가진 테이블 TYPE*/
	TYPE T_STATN IS TABLE OF STATN%ROWTYPE;

	/**********************************************************
    * 이름	   : FN_SLT_STATN
    * 설명	   : 역 조회 함수
    * 관련테이블 : STATN
    **********************************************************/
	FUNCTION FN_SLT_STATN
    	(
           	I_AREA_CODE	IN	VARCHAR2 	/*지역코드*/,
		   	I_STATN_NM	IN	VARCHAR2	/*검색어*/
		)
        RETURN T_STATN PIPELINED
        ;
END PK_ADMIN_STATN;


