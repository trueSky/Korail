CREATE OR REPLACE PACKAGE KORAIL.PK_MEMBER_RESVE
AS
    /*TABLE TYPE에 들어갈 RECORD*/
	TYPE R_RESVE IS RECORD(
		RESVE_CODE		 VARCHAR2(30)	/*예약코드*/,
		TRAIN_NO		 VARCHAR2(30)	/*열차번호*/,
		TRAIN_KND		 VARCHAR2(30)	/*열차종류*/,
		START_STATN		 VARCHAR2(30)	/*출발역*/,
		START_TM		 DATE			/*출발시각*/,
		ARVL_STATN		 VARCHAR2(30)	/*도착역*/,
		ARVL_TM			 DATE			/*도착시각*/,
		RESVE_CO		 NUMBER(1)		/*예약매수*/,
        ALL_FR_AMOUNT	 NUMBER(10)		/*총운임금액*/,
        ALL_DSCNT_AMOUNT NUMBER(10)		/*총할인금액*/,
		ALL_RCPT_AMOUNT  NUMBER(10)		/*총영수금액*/
    );
	/*R_RESVE를 가진 TABLE TYPE*/
	TYPE T_RESVE IS TABLE OF R_RESVE;

    /*TABLE TYPE에 들어갈 RECORD*/
	TYPE R_RESVE_RCRD IS RECORD(
		RESVE_CODE		 	VARCHAR2(30)	/*예약코드*/,
		TRAIN_NO		 	VARCHAR2(30)	/*열차번호*/,
		TRAIN_KND		 	VARCHAR2(30)	/*열차종류*/,
		START_STATN		 	VARCHAR2(30)	/*출발역*/,
		START_TM		 	DATE			/*출발시각*/,
		ARVL_STATN		 	VARCHAR2(30)	/*도착역*/,
		ARVL_TM			 	DATE			/*도착시각*/,
		RESVE_CO		 	NUMBER(1)		/*예약매수*/,
        SETLE_STTUS_CODE	VARCHAR2(30)	/*결제상태 코드*/,
        SETLE_STTUS_VALUE	VARCHAR2(30)	/*결제상태 값*/,
       	SETLE_AMOUNT	 	NUMBER(10)		/*결제금액*/
    );
	/*R_RESVE_RCRD 가진 TABLE TYPE*/
	TYPE T_RESVE_RCRD IS TABLE OF R_RESVE_RCRD;

    /**********************************************************
    * 이름        : SP_IST_DEATIL_RESVE
    * 설명        : 상세예약 등록
    * 관련테이블  : RESVE, DETAIL_RESVE
    **********************************************************/
    PROCEDURE SP_IST_DEATIL_RESVE(
    	I_ROOM_KND		IN	VARCHAR2	/*객실유형*/,
        I_SEAT_NO		IN	VARCHAR2	/*좌석번호*/,
        I_PSNGR_KND		IN	VARCHAR2	/*승객유형*/,
        I_DSPSN_GRAD	IN	VARCHAR2	/*장애인등급*/,
        I_ROOM			IN	VARCHAR2	/*호실*/,
        I_FR_AMOUNT		IN	VARCHAR2	/*운임금액*/,

        O_RESVE_CODE	OUT	VARCHAR2	/* 리턴할 예약 코드 */,

        ER_CODE		 	OUT VARCHAR2	/*에러 코드(0 : 성공, 1 : 에러)*/,
        ER_MSG 			OUT VARCHAR2	/*에러 메세지*/
    );

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
    ;

    /*********************************************************************
    * 이름        : FN_SLT_RESVE_RCRD
    * 설명        : 승차권 예매 현황
    * 관련테이블  : RESVE, TRAIN, OPRAT, SETLE
    *********************************************************************/
	FUNCTION FN_SLT_RESVE_RCRD
    	(
        	I_ID 		IN VARCHAR2 /*아아디*/
        )
    RETURN T_RESVE_RCRD PIPELINED
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
    );
END PK_MEMBER_RESVE;


