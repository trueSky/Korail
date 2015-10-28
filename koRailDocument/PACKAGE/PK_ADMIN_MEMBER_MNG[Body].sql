CREATE OR REPLACE PACKAGE BODY KORAIL.PK_ADMIN_MEMBER_MNG
AS
    /**********************************************************
    * 이름        : SP_DLT_MEMBER
    * 설명        : 회원 삭제
    * 관련테이블  : RESVE, DETAIL_RESVE, SETLE, PINT, MEMBER
    **********************************************************/
    PROCEDURE SP_DLT_MEMBER(
    	I_ID	IN	VARCHAR2	/*아이디*/,

        ER_CODE	OUT VARCHAR2	/*에러 코드(0 : 성공, 1 : 에러)*/,
        ER_MSG 	OUT VARCHAR2	/*에러 메세지*/
    )
    IS
    	V_COUNT NUMBER(10);		/*임시데이터 수*/
    BEGIN
    	/*승차일자가 만료되지않은 승차권 조회*/
    	SELECT COUNT(*)
        INTO V_COUNT
        FROM RESVE A, OPRAT B
        WHERE B.OPRAT_CODE = A.OPRAT_CODE
        AND A.ID = I_ID
        AND	B.START_TM >= SYSDATE
        ;

        /*만료되지 않은 승차권이 존재할 경우 회원 삭제 불가*/
        IF V_COUNT = 0 THEN
            /*포인트 정보 삭제*/
            DELETE FROM PINT WHERE ID = I_ID
            ;
            /*결제 삭제*/
            DELETE FROM SETLE WHERE ID = I_ID
            ;
            /*상세예약 삭제*/
            FOR DATA IN (SELECT RESVE_CODE FROM RESVE WHERE ID = I_ID) LOOP
                DELETE FROM DETAIL_RESVE WHERE RESVE_CODE = DATA.RESVE_CODE;
            END LOOP
            ;
            /*예약 삭제*/
            DELETE FROM RESVE WHERE ID = I_ID
            ;
            /*회원 삭제*/
            DELETE FROM MEMBER WHERE ID = I_ID
            ;

            ER_CODE := '0';
            ER_MSG := '삭제완료';
        ELSE
        	ER_CODE := '1';
            ER_MSG := '만료되지 않은 승차권이 존재합니다.';
            ROLLBACK;
            RETURN;
        END IF
        ;

		EXCEPTION
    		WHEN OTHERS THEN
            	ER_CODE := '1';
              	ER_MSG := SQLCODE || '-' || SQLERRM;
                ROLLBACK;
                RETURN;
    END SP_DLT_MEMBER;
END PK_ADMIN_MEMBER_MNG;