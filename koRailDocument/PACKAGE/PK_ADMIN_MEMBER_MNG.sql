CREATE OR REPLACE PACKAGE KORAIL.PK_ADMIN_MEMBER_MNG
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
    );
END PK_ADMIN_MEMBER_MNG;