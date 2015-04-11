CREATE OR REPLACE PACKAGE KORAIL.PK_ADMIN_RCRD
AS
    /*TABLE TYPE에 들어갈 RECORD*/
	TYPE R_TCKT_RCRD IS RECORD(
    	OPRAT_CODE	        VARCHAR2(30),	/*운행코드*/
        TCKT_TM				DATE,			/*승차일자*/
        TRAIN_NO            VARCHAR2(30),   /*열차번호*/
        TRAIN_KND_VALUE     VARCHAR2(30),   /*열차종류 값*/
        START_STATN_VALUE   VARCHAR2(30),   /*출발역 값*/
        ARVL_STATN_VALUE    VARCHAR2(30),   /*도착역 값*/
        START_TM	        DATE,	        /*출발시각*/
        ARVL_TM	            DATE,	        /*도착시각*/
    	PRTCLR_SEAT_Y_CO	NUMBER(3)		/*특실 좌석수*/,
    	PRTCLR_ROOM_Y_CO	NUMBER(3)		/*예약된 특실 좌석수*/,
    	PRTCLR_SEAT_N_CO	NUMBER(3)		/*일반실 좌석수*/,
    	PRTCLR_ROOM_N_CO	NUMBER(3)		/*예약된 일반실 좌석수*/
    );
	/*R_TCKT_RCRD를 가진 TABLE TYPE*/
	TYPE T_TCKT_RCRD IS TABLE OF R_TCKT_RCRD;

    /*TABLE TYPE에 들어갈 RECORD*/
	TYPE R_TRAIN_RCRD IS RECORD(
		RESVE_CODE			VARCHAR2(30)	/*예약코드*/,
        TRAIN_KND			VARCHAR2(30)	/*열차종류*/,
        RGSDE				DATE			/*예매일자*/,
		REGISTER			VARCHAR2(30)	/*예약자명*/,
		RESVE_CO			NUMBER(1)		/*총 인원수*/,
        ELDRLY_CO			NUMBER(1)		/*경로대상자 수*/,
        DSPSN_CO			NUMBER(1)		/*장애인 수*/,
		CHLD_CO				NUMBER(1)		/*어린이 수*/,
        ALL_FR_AMOUNT		NUMBER(10)		/*영수금액*/,
		SETLE_STTUS			VARCHAR2(20)	/*결제금여부*/,
		USE_PINT			VARCHAR2(7)		/*사용포인트*/,
		DSCNT_AMOUNT		NUMBER(10)		/*할인금엑*/,
		SETLE_AMOUNT		NUMBER(10)		/*결제금액*/
    );
    /*R_TRAIN_RCRD를 가진 TABLE TYPE*/
	TYPE T_TRAIN_RCRD IS TABLE OF R_TRAIN_RCRD;

    /**********************************************************
    * 이름        : FN_SLT_TCKT_RCRD
    * 설명        : 승차권 발권 현황
    * 관련테이블  : OPRAT, TARIN, ROOM
    **********************************************************/
	FUNCTION FN_SLT_TCKT_RCRD(
		I_TRAIN_KND_CODE	IN	VARCHAR2 	/*열차종류*/
	)
    RETURN T_TCKT_RCRD PIPELINED
    ;

    /**********************************************************
    * 이름        : FN_SLT_TRAIN_RCRD
    * 설명        : 열차별 승객 현황
    * 관련테이블  : RESVE, DETAIL_RESVE, SETLE, OPRAT
    **********************************************************/
	FUNCTION FN_SLT_TRAIN_RCRD(
		I_TRAIN_KND_CODE	IN	VARCHAR2 	/*열차종류*/
	)
    RETURN T_TRAIN_RCRD PIPELINED
    ;
END PK_ADMIN_RCRD;


