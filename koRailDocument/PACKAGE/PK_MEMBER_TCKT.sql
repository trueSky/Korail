CREATE OR REPLACE PACKAGE KORAIL.PK_MEMBER_TCKT
AS
	/*TABLE TYPE에 들어갈 RECORD*/
	TYPE R_TCKT IS RECORD(
		OPRAT_CODE					VARCHAR2(30) /*운행코드*/,
        TRAIN_NO					VARCHAR2(30) /*열차번호*/,
    	TRAIN_KND_CODE				VARCHAR2(30) /*열차종류코드*/,
        TRAIN_KND_VALUE				VARCHAR2(30) /*열차종류값*/,
		START_STATN_CODE 			VARCHAR2(30) /*출발역코드*/,
		START_STATN_VALUE		 	VARCHAR2(30) /*출발역값*/,
		START_TM					DATE		 /*출발시각*/,
        ARVL_STATN_CODE 			VARCHAR2(30) /*도착역코드*/,
		ARVL_STATN_VALUE			VARCHAR2(30) /*도착역값*/,
  		ARVL_TM						DATE		 /*도착시각*/,
        PRTCLR_SEAT_Y_CO			NUMBER(3)	/*특실 좌석수*/,
    	PRTCLR_ROOM_Y_CO			NUMBER(3)	/*예약된 특실 좌석수*/,
        PRTCLR_SEAT_N_CO			NUMBER(3)	/*일반실 좌석수*/,
        PRTCLR_ROOM_N_CO			NUMBER(3)	/*예약된 일반실 좌석수*/,
        FARE						NUMBER(10)	/*요금*/
    );
	/*R_TCKT를 가진 TABLE TYPE*/
	TYPE T_TCKT IS TABLE OF R_TCKT;

    /*TABLE TYPE에 들어갈 RECORD*/
	TYPE R_DETAIL_TCKT_RCRD_1 IS RECORD(
    	RESVE_CODE		VARCHAR2(30) /*예약코드*/,
		ID				VARCHAR2(30) /*아이디*/,
        RGSDE			DATE		 /*결제일*/,
        RESVE_CO		NUMBER(1)	 /*예약매수*/,
        FR_AMOUNT		NUMBER(10)	 /*운임금액*/,
        USE_PINT		VARCHAR2(7)	 /*사용포인트*/,
        DSCNT_AMOUNT	NUMBER(10)	 /*헐인금액*/,
        SETLE_AMOUNT	NUMBER(10)	 /*결제금액*/
    );
	/*R_DETAIL_TCKT_RCRD_1을 가진 TABLE TYPE*/
	TYPE T_DETAIL_TCKT_RCRD_1 IS TABLE OF R_DETAIL_TCKT_RCRD_1;

    /*TABLE TYPE에 들어갈 RECORD*/
	TYPE R_DETAIL_TCKT_RCRD_2 IS RECORD(
    	TRAIN_NO		VARCHAR2(30) /*열차번호*/,
    	TRAIN_KND		VARCHAR2(30) /*열차종류값*/,
		START_STATN		VARCHAR2(30) /*출발역값*/,
		START_TM		DATE		 /*출발시각*/,
        ARVL_STATN		VARCHAR2(30) /*도착역값*/,
  		ARVL_TM			DATE		 /*도착시각*/,
        ROOM_KND		VARCHAR2(30) /*객실유형*/,
        ROOM			VARCHAR2(5)	 /*호실*/,
        PSNGR_KND		VARCHAR2(30) /*승객유형 : 장애인(급수), 일반, 경로, 어린이*/,
        PSNGR_NM		VARCHAR2(30) /*승차자명*/,
        SEAT_NO			VARCHAR2(20) /*좌석번호*/,
        FR_AMOUNT		NUMBER(10)	 /*운임금액*/,
        DSCNT_AMOUNT	NUMBER(10)	 /*헐인금액*/,
        RCPT_AMOUNT		NUMBER(10)	/*영수금액*/
    );
	/*R_DETAIL_TCKT_RCRD_2를 가진 TABLE TYPE*/
	TYPE T_DETAIL_TCKT_RCRD_2 IS TABLE OF R_DETAIL_TCKT_RCRD_2;

    /**********************************************************
    * 이름        : FN_SLT_TCKT
    * 설명        : 승차권 예매를 위한 운행정보 조회
    * 관련테이블  : OPRAT, DETAIL_OPRAT, TRAIN
    **********************************************************/
	FUNCTION FN_SLT_TCKT
    	(
        	I_SEAT_CO 			IN VARCHAR2 /*좌석수*/,
            I_TRAIN_KND_CODE	IN VARCHAR2 /*열차종류*/,
            I_START_STATN_CODE 	IN VARCHAR2 /*출발역*/,
            I_ARVL_STATN_CODE 	IN VARCHAR2 /*도착역*/,
            I_START_TM 			IN VARCHAR2 /*출발시각*/

        )
    RETURN T_TCKT PIPELINED
    ;

   /**********************************************************
    * 이름        : FN_SLT_DETAIL_TCKT_RCRD_1
    * 설명        : 결제가 완료된 상세승차권 내역 조회
    * 관련테이블  : RESVE, SETLE
    **********************************************************/
	FUNCTION FN_SLT_DETAIL_TCKT_RCRD_1
    	(
        	I_RESVE_CODE IN VARCHAR2 /*예약코드*/
        )
    RETURN T_DETAIL_TCKT_RCRD_1 PIPELINED
    ;

    /*****************************************************************
    * 이름        : FN_SLT_DETAIL_TCKT_RCRD_2
    * 설명        : 결제가 완료된 상세승차권의 좌석 조회
    * 관련테이블  : RESVE, DETAIL_RESVE, TRAIN, SETLE, OPRAT
    ******************************************************************/
	FUNCTION FN_SLT_DETAIL_TCKT_RCRD_2
    	(
        	I_RESVE_CODE IN VARCHAR2 /*예약코드*/
        )
    RETURN T_DETAIL_TCKT_RCRD_2 PIPELINED
    ;
END ;


