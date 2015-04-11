CREATE OR REPLACE PACKAGE BODY KORAIL.PK_MEMBER_SETLE
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
    )
    IS
    	V_PINT_CODE VARCHAR2(30);	/*포인트코드*/
    BEGIN
    	/* 결제 */
    	UPDATE SETLE SET
        	ID = I_ID									/*아이디*/,
            CARD_SE = I_CARD_SE		    				/*카드구분*/,
            CARD_KND = I_CARD_KND						/*카드종류*/,
            CARD_NO	= I_CARD_NO							/*카드번호*/,
            VALID_PD = TO_DATE(I_VALID_PD, 'YYYY-MM')	/*유효기간*/,
            INSTLMT = I_INSTLMT							/*할부*/,
            SCRTY_CARD_NO = I_SCRTY_CARD_NO				/*보안카드번호*/,
            IHIDNUM = I_IHIDNUM							/*주민등록번호*/,
            USE_PINT = I_USE_PINT						/*사용포인트*/,
            PINT_USE_YN = I_PINT_USE_YN	    			/*포인트사용여부*/,
            SETLE_STTUS = 'SETLE_STTUS_Y'     			/*결제여부*/,
            FR_AMOUNT = TO_NUMBER(I_FR_AMOUNT)			/*운임금액*/,
            DSCNT_AMOUNT = TO_NUMBER(I_DSCNT_AMOUNT)	/*할인금액*/,
            SETLE_AMOUNT = TO_NUMBER(I_SETLE_AMOUNT)	/*결제금액*/,
            REGISTER = I_REGISTER						/*등록자*/,
            RGSDE = SYSDATE          					/*등록일*/
        WHERE RESVE_CODE = I_RESVE_CODE
        ;

        /* 포인트 정립 및 차감 */
        IF SQL%FOUND THEN
        	/*PINT_CODE SEARCH*/
            SELECT 'PINT_CODE_' || NVL( MAX( TO_NUMBER( REGEXP_SUBSTR( PINT_CODE, '[^_]+', 1, 3)) ), 1)
        	INTO V_PINT_CODE
            FROM PINT
            ;

            /* 이 결제에 대한 포인트 내역 등록*/
            UPDATE PINT
                SET	ID = I_ID,
                    USE_PINT = I_USE_PINT,
                    SV_PINT = (I_SETLE_AMOUNT / 1000),
                    USE_HISTR = (
                                    SELECT	C.TRAIN_NO || ' ' || PK_CMMN.TO_CODE_VALUE('STATN', A.START_STATN)
                                            || ' ▶ ' || PK_CMMN.TO_CODE_VALUE('STATN', A.ARVL_STATN)
                                    FROM	OPRAT A,
                                            RESVE B,
                                            TRAIN C
                                    WHERE	A.OPRAT_CODE = B.OPRAT_CODE
                                    AND 	A.TRAIN_CODE = C.TRAIN_CODE
                                    AND 	B.RESVE_CODE = I_RESVE_CODE
                                ),
                    SETLE_AMOUNT = I_SETLE_AMOUNT,
                    USE_DE = SYSDATE
            WHERE PINT_CODE = V_PINT_CODE
            ;

            /* 포인트 사용여부에 따른 총 사용포인트 및 현재포인트 수정 */
            IF SQL%FOUND AND I_PINT_USE_YN = 'Y' THEN
                UPDATE PINT SET
                    TDY_PINT = TO_NUMBER((
                                    SELECT MAX(TDY_PINT)
                                    FROM PINT
                                    WHERE ID = I_ID
                                ))-I_USE_PINT+(I_SETLE_AMOUNT / 1000),
                    ALL_USE_PINT = TO_NUMBER((
                                        SELECT NVL(MAX(ALL_USE_PINT), 0)
                                        FROM PINT
                                        WHERE ID = I_ID
                                    ))+I_USE_PINT
                WHERE ID = I_ID
                ;
            ELSIF SQL%FOUND AND I_PINT_USE_YN = 'N' THEN
            	UPDATE PINT SET
                    TDY_PINT = TO_NUMBER((
                                    SELECT NVL(MAX(TDY_PINT), 0)
                                    FROM PINT
                                    WHERE ID = I_ID
                                ))+(I_SETLE_AMOUNT / 1000),
                    ALL_USE_PINT = TO_NUMBER((
                                        SELECT NVL(MAX(ALL_USE_PINT), 0)
                                        FROM PINT
                                        WHERE ID = I_ID
                                    ))
                WHERE ID = I_ID
                ;
            ELSE
                ER_CODE := '1';
                ER_MSG := '결제 실패';
                ROLLBACK;
                RETURN;
            END IF;
        ELSE
        	ER_CODE := '1';
            ER_MSG := '결제 실패';
            ROLLBACK;
            RETURN;
        END IF;

        ER_CODE := '0';
    	ER_MSG := '결제 성공';

        EXCEPTION
        	WHEN OTHERS THEN
            	ER_CODE := '1';
                ER_MSG := SQLCODE || '' || SQLERRM;
                ROLLBACK;
                RETURN;
    END SP_IST_SETLE;
END PK_MEMBER_SETLE;


