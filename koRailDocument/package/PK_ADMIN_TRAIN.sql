/*------------------------------------------------------------------------------
-- 개체 이름 : KORAIL.PK_ADMIN_TRAIN
-- 만든 날짜 : 2014-11-13 오전 7:38:27
-- 마지막으로 수정한 날짜 : 2014-11-15 오후 10:30:22
-- 상태 : VALID
------------------------------------------------------------------------------*/
CREATE OR REPLACE PACKAGE KORAIL.PK_ADMIN_TRAIN
AS
	/*TRAIN 테이블을 가진 테이블 TYPE*/
	TYPE T_TRAIN IS TABLE OF TRAIN%ROWTYPE;

	/**********************************************************
    * 이름	   : FN_SLT_TRAIN
    * 설명	   : 열차 조회 함수
    * 관련테이블	: TRAIN
    **********************************************************/
	FUNCTION FN_SLT_TRAIN
    	(
           	I_TRAIN_KND	IN	VARCHAR2 	/*열차종류*/,
		   	I_TRAIN_NO	IN	VARCHAR2	/*열차번호*/
		)
        RETURN T_TRAIN PIPELINED
        ;
END PK_ADMIN_TRAIN;


