/*------------------------------------------------------------------------------
-- 개체 이름 : KORAIL.PK_MEMBER_SETLE
-- 만든 날짜 : 2015-01-07 오전 10:54:04
-- 마지막으로 수정한 날짜 : 2015-01-11 오전 11:07:04
-- 상태 : VALID
------------------------------------------------------------------------------*/
CREATE OR REPLACE PACKAGE KORAIL.PK_MEMBER_SETLE
AS
	/**********************************************************
    * 이름        : SP_IST_SETLE
    * 설명        : 결제
    * 관련테이블  : PINT, OPRAT, RESVE, TRAIN
    **********************************************************/
	PROCEDURE SP_IST_SETLE(
    	I_RESVE_CODE	IN	VARCHAR2	/*예약코드*/,
		I_ID			IN	VARCHAR2	/*아이디*/,
		I_CARD_SE		IN	VARCHAR2	/*카드구분*/,
		I_CARD_KND		IN	VARCHAR2	/*카드종류*/,
        I_CARD_NO		IN	VARCHAR2	/*카드번호*/,
        I_VALID_PD		IN	VARCHAR2	/*유효기간*/,
        I_INSTLMT		IN	VARCHAR2	/*할부*/,
        I_SCRTY_CARD_NO	IN	VARCHAR2	/*보안카드번호*/,
        I_IHIDNUM		IN	VARCHAR2	/*주민등록번호*/,
        I_USE_PINT		IN	VARCHAR2	/*사용포인트*/,
        I_PINT_USE_YN	IN	VARCHAR2	/*포인트사용여부*/,
        I_FR_AMOUNT		IN	NUMBER		/*운임금액*/,
        I_DSCNT_AMOUNT	IN	NUMBER		/*할인금액*/,
        I_SETLE_AMOUNT	IN	NUMBER		/*결제금액*/,
        I_REGISTER		IN	VARCHAR2	/*등록자*/,

		ER_CODE OUT VARCHAR2	/*에러 코드(0 : 성공, 1 : 에러)*/,
    	ER_MSG 	OUT VARCHAR2	/*에러 메세지*/
    );
END ;


