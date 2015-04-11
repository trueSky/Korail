/*------------------------------------------------------------------------------
-- ��ü �̸� : KORAIL.PK_MEMBER_TCKT
-- ���� ��¥ : 2015-01-13 ���� 12:15:02
-- ���������� ������ ��¥ : 2015-01-14 ���� 4:41:40
-- ���� : VALID
------------------------------------------------------------------------------*/
CREATE OR REPLACE PACKAGE BODY KORAIL.PK_MEMBER_TCKT
AS
	/**********************************************************
    * �̸�        : FN_SLT_TCKT
    * ����        : ������ ���Ÿ� ���� �������� ��ȸ
    * �������̺�  : OPRAT, DETAIL_OPRAT, TRAIN
    **********************************************************/
	FUNCTION FN_SLT_TCKT
    	(
        	I_SEAT_CO 			IN VARCHAR2 /*�¼���*/,
            I_TRAIN_KND_CODE	IN VARCHAR2 /*��������*/,
            I_START_STATN_CODE 	IN VARCHAR2 /*��߿�*/,
            I_ARVL_STATN_CODE 	IN VARCHAR2 /*������*/,
            I_START_TM 			IN VARCHAR2 /*��߽ð�*/

        )
    RETURN T_TCKT PIPELINED
    IS
    	/* ������ ���Ÿ� ���� �������� ��ȸ (�˻����� �������� ����) */
    	CURSOR C_KND IS(
        	SELECT	E.OPRAT_CODE		/*�����ڵ�*/,
            		E.TRAIN_NO			/*������ȣ*/,
                    E.TRAIN_KND_CODE	/*���������ڵ�*/,
                    E.TRAIN_KND_VALUE	/*����������*/,
                    E.START_STATN_CODE 	/*��߿��ڵ�*/,
                    E.START_STATN_VALUE	/*��߿���*/,
                    E.START_TM			/*��߽ð�*/,
                    E.ARVL_STATN_CODE 	/*�������ڵ�*/,
                    E.ARVL_STATN_VALUE	/*��������*/,
                    E.ARVL_TM			/*�����ð�*/,
                    PRTCLR_SEAT_Y_CO	/*Ư�� �¼���*/,
                    E.PRTCLR_ROOM_Y_CO	/*����� Ư�� �¼���*/,
                    PRTCLR_SEAT_N_CO	/*�Ϲݽ� �¼���*/,
                    E.PRTCLR_ROOM_N_CO	/*����� �Ϲݽ� �¼���*/,
                    E.FARE				/*���*/
  			FROM
       			(
                	SELECT	A.OPRAT_CODE,
                    		D.TRAIN_NO,
                    		D.TRAIN_KND AS TRAIN_KND_CODE,
              				PK_CMMN.TO_CODE_VALUE('CMMN_CODE', D.TRAIN_KND) AS TRAIN_KND_VALUE,
              				A.START_STATN AS START_STATN_CODE,
                            PK_CMMN.TO_CODE_VALUE('STATN', A.START_STATN) AS START_STATN_VALUE,
                            A.START_TM,
                            A.ARVL_STATN AS ARVL_STATN_CODE,
                            PK_CMMN.TO_CODE_VALUE('STATN', A.ARVL_STATN) AS ARVL_STATN_VALUE,
                            A.ARVL_TM,
                            (
                              SELECT	SUM(SEAT_CO)
                              FROM		ROOM
                              WHERE 	OPRAT_CODE = A.OPRAT_CODE
                              AND		PRTCLR_ROOM_YN = 'Y'
                            ) AS PRTCLR_SEAT_Y_CO,
                            (
                            	SELECT	SUM(RESVE_SEAT_CO)
                                FROM	ROOM
                                WHERE 	OPRAT_CODE = A.OPRAT_CODE
                                AND		PRTCLR_ROOM_YN = 'Y'
                            ) AS PRTCLR_ROOM_Y_CO,
                            (
                              SELECT	SUM(SEAT_CO)
                              FROM		ROOM
                              WHERE 	OPRAT_CODE = A.OPRAT_CODE
                              AND		PRTCLR_ROOM_YN = 'N'
                            ) AS PRTCLR_SEAT_N_CO,
                            (
                            	SELECT	SUM(RESVE_SEAT_CO)
                                FROM	ROOM
                                WHERE 	OPRAT_CODE = A.OPRAT_CODE
                                AND		PRTCLR_ROOM_YN = 'N'
                            ) AS PRTCLR_ROOM_N_CO,
              				A.FARE
         			FROM	OPRAT A,
              				DETAIL_OPRAT B,
              				ROOM C,
              				TRAIN D
        			WHERE	A.OPRAT_CODE = B.OPRAT_CODE
            		AND		A.OPRAT_CODE = C.OPRAT_CODE
            		AND		D.TRAIN_CODE = A.TRAIN_CODE
                    AND		D.TRAIN_KND = I_TRAIN_KND_CODE
                    AND 	A.START_STATN = I_START_STATN_CODE
                    AND 	A.ARVL_STATN = I_ARVL_STATN_CODE
                    AND 	A.START_TM >= TO_DATE(I_START_TM, 'YYYY-MM-DD HH24')
       			) E
 			GROUP BY	E.OPRAT_CODE,
            			E.TRAIN_NO,
       					E.TRAIN_KND_CODE,
       					E.TRAIN_KND_VALUE,
                        E.START_STATN_CODE,
       					E.START_STATN_VALUE,
      					E.START_TM,
       					E.ARVL_STATN_CODE,
       					E.ARVL_STATN_VALUE,
      	 				E.ARVL_TM,
                        E.PRTCLR_SEAT_Y_CO,
                        E.PRTCLR_ROOM_Y_CO,
                        E.PRTCLR_SEAT_N_CO,
                        E.PRTCLR_ROOM_N_CO,
       					E.FARE
			HAVING	E.PRTCLR_SEAT_Y_CO >= I_SEAT_CO
            OR		E.PRTCLR_SEAT_N_CO >= I_SEAT_CO
        );

        /* ������ ���Ÿ� ���� �������� ��ȸ (�˻����� �������� ����) */
    	CURSOR C_NOT_KND IS(
        	SELECT	E.OPRAT_CODE		/*�����ڵ�*/,
            		E.TRAIN_NO			/*������ȣ*/,
                    E.TRAIN_KND_CODE	/*���������ڵ�*/,
                    E.TRAIN_KND_VALUE	/*����������*/,
                    E.START_STATN_CODE 	/*��߿��ڵ�*/,
                    E.START_STATN_VALUE	/*��߿���*/,
                    E.START_TM			/*��߽ð�*/,
                    E.ARVL_STATN_CODE 	/*�������ڵ�*/,
                    E.ARVL_STATN_VALUE	/*��������*/,
                    E.ARVL_TM			/*�����ð�*/,
                    PRTCLR_SEAT_Y_CO	/*Ư�� �¼���*/,
                    E.PRTCLR_ROOM_Y_CO	/*����� Ư�� �¼���*/,
                    PRTCLR_SEAT_N_CO	/*�Ϲݽ� �¼���*/,
                    E.PRTCLR_ROOM_N_CO	/*����� �Ϲݽ� �¼���*/,
                    E.FARE				/*���*/
  			FROM
       			(
                	SELECT	A.OPRAT_CODE,
                    		D.TRAIN_NO,
                    		D.TRAIN_KND AS TRAIN_KND_CODE,
              				PK_CMMN.TO_CODE_VALUE('CMMN_CODE', D.TRAIN_KND) AS TRAIN_KND_VALUE,
              				A.START_STATN AS START_STATN_CODE,
                            PK_CMMN.TO_CODE_VALUE('STATN', A.START_STATN) AS START_STATN_VALUE,
                            A.START_TM,
                            A.ARVL_STATN AS ARVL_STATN_CODE,
                            PK_CMMN.TO_CODE_VALUE('STATN', A.ARVL_STATN) AS ARVL_STATN_VALUE,
                            A.ARVL_TM,
                            (
                              SELECT	SUM(SEAT_CO)
                              FROM		ROOM
                              WHERE 	OPRAT_CODE = A.OPRAT_CODE
                              AND		PRTCLR_ROOM_YN = 'Y'
                            ) AS PRTCLR_SEAT_Y_CO,
                            (
                            	SELECT	SUM(RESVE_SEAT_CO)
                                FROM	ROOM
                                WHERE 	OPRAT_CODE = A.OPRAT_CODE
                                AND		PRTCLR_ROOM_YN = 'Y'
                            ) AS PRTCLR_ROOM_Y_CO,
                            (
                              SELECT	SUM(SEAT_CO)
                              FROM		ROOM
                              WHERE 	OPRAT_CODE = A.OPRAT_CODE
                              AND		PRTCLR_ROOM_YN = 'N'
                            ) AS PRTCLR_SEAT_N_CO,
                            (
                            	SELECT	SUM(RESVE_SEAT_CO)
                                FROM	ROOM
                                WHERE 	OPRAT_CODE = A.OPRAT_CODE
                                AND		PRTCLR_ROOM_YN = 'N'
                            ) AS PRTCLR_ROOM_N_CO,
              				A.FARE
         			FROM	OPRAT A,
              				DETAIL_OPRAT B,
              				ROOM C,
              				TRAIN D
        			WHERE	A.OPRAT_CODE = B.OPRAT_CODE
            		AND		A.OPRAT_CODE = C.OPRAT_CODE
            		AND		D.TRAIN_CODE = A.TRAIN_CODE
                    AND 	A.START_STATN = I_START_STATN_CODE
                    AND 	A.ARVL_STATN = I_ARVL_STATN_CODE
                    AND 	A.START_TM >= TO_DATE(I_START_TM, 'YYYY-MM-DD HH24')
       			) E
 			GROUP BY	E.OPRAT_CODE,
            			E.TRAIN_NO,
       					E.TRAIN_KND_CODE,
       					E.TRAIN_KND_VALUE,
                        E.START_STATN_CODE,
       					E.START_STATN_VALUE,
      					E.START_TM,
       					E.ARVL_STATN_CODE,
       					E.ARVL_STATN_VALUE,
      	 				E.ARVL_TM,
                        E.PRTCLR_SEAT_Y_CO,
                        E.PRTCLR_ROOM_Y_CO,
                        E.PRTCLR_SEAT_N_CO,
                        E.PRTCLR_ROOM_N_CO,
       					E.FARE
			HAVING	E.PRTCLR_SEAT_Y_CO >= I_SEAT_CO
            OR		E.PRTCLR_SEAT_N_CO >= I_SEAT_CO
        );

        /*������ ���� �����ų ���̺� TYPE ����*/
        SET_TCKT T_TCKT := T_TCKT();
	BEGIN
    	IF I_TRAIN_KND_CODE = 'ALL' THEN
        	FOR DATA IN C_NOT_KND LOOP
    			SET_TCKT.EXTEND;
            	SET_TCKT(SET_TCKT.COUNT).OPRAT_CODE := DATA.OPRAT_CODE;
              	SET_TCKT(SET_TCKT.COUNT).TRAIN_NO := DATA.TRAIN_NO;
              	SET_TCKT(SET_TCKT.COUNT).TRAIN_KND_CODE := DATA.TRAIN_KND_CODE;
              	SET_TCKT(SET_TCKT.COUNT).TRAIN_KND_VALUE := DATA.TRAIN_KND_VALUE;
              	SET_TCKT(SET_TCKT.COUNT).START_STATN_CODE := DATA.START_STATN_CODE;
             	SET_TCKT(SET_TCKT.COUNT).START_STATN_VALUE := DATA.START_STATN_VALUE;
              	SET_TCKT(SET_TCKT.COUNT).ARVL_STATN_CODE := DATA.ARVL_STATN_CODE;
              	SET_TCKT(SET_TCKT.COUNT).ARVL_STATN_VALUE := DATA.ARVL_STATN_VALUE;
              	SET_TCKT(SET_TCKT.COUNT).START_TM := DATA.START_TM;
              	SET_TCKT(SET_TCKT.COUNT).ARVL_TM := DATA.ARVL_TM;
              	SET_TCKT(SET_TCKT.COUNT).PRTCLR_SEAT_Y_CO := DATA.PRTCLR_SEAT_Y_CO;
              	SET_TCKT(SET_TCKT.COUNT).PRTCLR_ROOM_Y_CO := DATA.PRTCLR_ROOM_Y_CO;
              	SET_TCKT(SET_TCKT.COUNT).PRTCLR_SEAT_N_CO := DATA.PRTCLR_SEAT_N_CO;
                SET_TCKT(SET_TCKT.COUNT).PRTCLR_ROOM_N_CO := DATA.PRTCLR_ROOM_N_CO;
              	SET_TCKT(SET_TCKT.COUNT).FARE := DATA.FARE;
              	PIPE ROW(SET_TCKT(SET_TCKT.COUNT));
          	END LOOP
          	;
        ELSE
        	FOR DATA IN C_KND LOOP
    			SET_TCKT.EXTEND;
            	SET_TCKT(SET_TCKT.COUNT).OPRAT_CODE := DATA.OPRAT_CODE;
              	SET_TCKT(SET_TCKT.COUNT).TRAIN_NO := DATA.TRAIN_NO;
              	SET_TCKT(SET_TCKT.COUNT).TRAIN_KND_CODE := DATA.TRAIN_KND_CODE;
              	SET_TCKT(SET_TCKT.COUNT).TRAIN_KND_VALUE := DATA.TRAIN_KND_VALUE;
              	SET_TCKT(SET_TCKT.COUNT).START_STATN_CODE := DATA.START_STATN_CODE;
             	SET_TCKT(SET_TCKT.COUNT).START_STATN_VALUE := DATA.START_STATN_VALUE;
              	SET_TCKT(SET_TCKT.COUNT).ARVL_STATN_CODE := DATA.ARVL_STATN_CODE;
              	SET_TCKT(SET_TCKT.COUNT).ARVL_STATN_VALUE := DATA.ARVL_STATN_VALUE;
              	SET_TCKT(SET_TCKT.COUNT).START_TM := DATA.START_TM;
              	SET_TCKT(SET_TCKT.COUNT).ARVL_TM := DATA.ARVL_TM;
              	SET_TCKT(SET_TCKT.COUNT).PRTCLR_SEAT_Y_CO := DATA.PRTCLR_SEAT_Y_CO;
              	SET_TCKT(SET_TCKT.COUNT).PRTCLR_ROOM_Y_CO := DATA.PRTCLR_ROOM_Y_CO;
              	SET_TCKT(SET_TCKT.COUNT).PRTCLR_SEAT_N_CO := DATA.PRTCLR_SEAT_N_CO;
                SET_TCKT(SET_TCKT.COUNT).PRTCLR_ROOM_N_CO := DATA.PRTCLR_ROOM_N_CO;
              	SET_TCKT(SET_TCKT.COUNT).FARE := DATA.FARE;
              	PIPE ROW(SET_TCKT(SET_TCKT.COUNT));
          	END LOOP
          	;
        END IF
        ;
    END FN_SLT_TCKT
    ;

    /**********************************************************
    * �̸�        : FN_SLT_DETAIL_TCKT_RCRD_1
    * ����        : ������ �Ϸ�� �󼼽����� ���� ��ȸ
    * �������̺�  : RESVE, SETLE
    **********************************************************/
	FUNCTION FN_SLT_DETAIL_TCKT_RCRD_1
    	(
        	I_RESVE_CODE IN VARCHAR2 /*�����ڵ�*/
        )
    RETURN T_DETAIL_TCKT_RCRD_1 PIPELINED
    IS
    	/* ������ �ʹ��� �󼼽����� ���� */
    	CURSOR C_DETAIL_TCKT_RCRD IS(
        	SELECT	A.RESVE_CODE	/*�����ڵ�*/,
            		A.ID			/*���̵�*/,
       				B.RGSDE			/*������*/,
       				A.RESVE_CO		/*����ż�*/,
       				B.FR_AMOUNT		/*���ӱݾ�*/,
       				B.USE_PINT		/*�������Ʈ*/,
       				B.DSCNT_AMOUNT	/*���αݾ�*/,
       				B.SETLE_AMOUNT	/*�����ݾ�*/
  			FROM 	RESVE A			/*����*/,
       				SETLE B			/*����*/
 			WHERE	A.RESVE_CODE = B.RESVE_CODE
       		AND		A.RESVE_CODE = I_RESVE_CODE
        );

        /*������ ���� �����ų ���̺� TYPE ����*/
        SET_DETAIL_TCKT_RCRD T_DETAIL_TCKT_RCRD_1 := T_DETAIL_TCKT_RCRD_1();
	BEGIN
    	FOR DATA IN C_DETAIL_TCKT_RCRD LOOP
            SET_DETAIL_TCKT_RCRD.EXTEND;
            SET_DETAIL_TCKT_RCRD(SET_DETAIL_TCKT_RCRD.COUNT).RESVE_CODE := DATA.RESVE_CODE;
            SET_DETAIL_TCKT_RCRD(SET_DETAIL_TCKT_RCRD.COUNT).ID := DATA.ID;
            SET_DETAIL_TCKT_RCRD(SET_DETAIL_TCKT_RCRD.COUNT).RGSDE := DATA.RGSDE;
            SET_DETAIL_TCKT_RCRD(SET_DETAIL_TCKT_RCRD.COUNT).RESVE_CO := DATA.RESVE_CO;
            SET_DETAIL_TCKT_RCRD(SET_DETAIL_TCKT_RCRD.COUNT).FR_AMOUNT := DATA.FR_AMOUNT;
            SET_DETAIL_TCKT_RCRD(SET_DETAIL_TCKT_RCRD.COUNT).USE_PINT := DATA.USE_PINT;
            SET_DETAIL_TCKT_RCRD(SET_DETAIL_TCKT_RCRD.COUNT).DSCNT_AMOUNT := DATA.DSCNT_AMOUNT;
            SET_DETAIL_TCKT_RCRD(SET_DETAIL_TCKT_RCRD.COUNT).SETLE_AMOUNT := DATA.SETLE_AMOUNT;
            PIPE ROW(SET_DETAIL_TCKT_RCRD(SET_DETAIL_TCKT_RCRD.COUNT));
        END LOOP
        ;
    END FN_SLT_DETAIL_TCKT_RCRD_1
    ;

    /*****************************************************************
    * �̸�        : FN_SLT_DETAIL_TCKT_RCRD_2
    * ����        : ������ �Ϸ�� �󼼽������� �¼� ��ȸ
    * �������̺�  : RESVE, DETAIL_RESVE, TRAIN, SETLE, OPRAT
    ******************************************************************/
	FUNCTION FN_SLT_DETAIL_TCKT_RCRD_2
    	(
        	I_RESVE_CODE IN VARCHAR2 /*�����ڵ�*/
        )
    RETURN T_DETAIL_TCKT_RCRD_2 PIPELINED
    IS
    	/* ������ �ʹ��� �󼼽����� ���� */
    	CURSOR C_DETAIL_TCKT_RCRD IS(
        	SELECT	C.TRAIN_NO													 /*������ȣ*/,
            		PK_CMMN.TO_CODE_VALUE('CMMN_CODE', C.TRAIN_KND) AS TRAIN_KND /*��������*/,
                    PK_CMMN.TO_CODE_VALUE('STATN', E.START_STATN) AS START_STATN /*��߿�*/,
                    E.START_TM													 /*��߽İ�*/,
                    PK_CMMN.TO_CODE_VALUE('STATN', E.ARVL_STATN) AS ARVL_STATN	 /*������*/,
                    E.ARVL_TM													 /*�����ð�*/,
                    PK_CMMN.TO_CODE_VALUE('CMMN_CODE', B.ROOM_KND) AS ROOM_KND	 /*���ǵ��*/,
                    B.ROOM														 /*ȣ��*/,
                    CASE B.PSNGR_KND
						WHEN 'PSNGR_3' THEN PK_CMMN.TO_CODE_VALUE('CMMN_CODE', B.DSPSN_GRAD)
                    	ELSE PK_CMMN.TO_CODE_VALUE('CMMN_CODE', B.PSNGR_KND)
                	END	AS PSNGR_KND											 /*�°����� : �����(�޼�), �Ϲ�, ���, ���*/,
                    B.PSNGR_NM													 /*�����ڸ�*/,
                    B.SEAT_NO													 /*�¼���ȣ*/,
                    B.FR_AMOUNT													 /*���ӱݾ�*/,
                    B.DSCNT_AMOUNT												 /*���αݾ�*/,
                    B.RCPT_AMOUNT												 /*�����ݾ�*/
            FROM	RESVE A														 /*����*/,
            		DETAIL_RESVE B												 /*�󼼿���*/,
                    TRAIN C														 /*����*/,
                    SETLE D														 /*����*/,
                    OPRAT E														 /*����*/
            WHERE	A.RESVE_CODE = B.RESVE_CODE
        	AND		C.TRAIN_CODE = E.TRAIN_CODE
        	AND		A.RESVE_CODE = D.RESVE_CODE
        	AND		E.OPRAT_CODE = A.OPRAT_CODE
            GROUP BY	A.RESVE_CODE	/*�����ڵ�*/,
                     	A.ID			/*���̵�*/,
                     	C.TRAIN_NO		/*������ȣ*/,
                     	C.TRAIN_KND		/*��������*/,
                     	E.START_STATN	/*��߿�*/,
                     	E.START_TM		/*��߽ð�*/,
                     	E.ARVL_STATN	/*������*/,
                     	E.ARVL_TM		/*�����ð�*/,
                     	B.ROOM_KND		/*��������*/,
                     	B.ROOM			/*ȣ��*/,
                     	B.PSNGR_NM		/*�����ڸ�*/,
                     	B.SEAT_NO		/*�¼���ȣ*/,
                     	B.FR_AMOUNT		/*���ӱݾ�*/,
                     	B.DSCNT_AMOUNT	/*���αݾ�*/,
                        B.RCPT_AMOUNT	/*�����ݾ�*/,
                        B.PSNGR_KND		/*�°�����*/,
                        B.DSPSN_GRAD	/*����ε��*/
        	HAVING	A.RESVE_CODE = I_RESVE_CODE
        );

        /*������ ���� �����ų ���̺� TYPE ����*/
        SET_DETAIL_TCKT_RCRD T_DETAIL_TCKT_RCRD_2 := T_DETAIL_TCKT_RCRD_2();
	BEGIN
    	FOR DATA IN C_DETAIL_TCKT_RCRD LOOP
            SET_DETAIL_TCKT_RCRD.EXTEND;
            SET_DETAIL_TCKT_RCRD(SET_DETAIL_TCKT_RCRD.COUNT).TRAIN_NO := DATA.TRAIN_NO;
            SET_DETAIL_TCKT_RCRD(SET_DETAIL_TCKT_RCRD.COUNT).TRAIN_KND := DATA.TRAIN_KND;
            SET_DETAIL_TCKT_RCRD(SET_DETAIL_TCKT_RCRD.COUNT).START_STATN := DATA.START_STATN;
            SET_DETAIL_TCKT_RCRD(SET_DETAIL_TCKT_RCRD.COUNT).START_TM := DATA.START_TM;
            SET_DETAIL_TCKT_RCRD(SET_DETAIL_TCKT_RCRD.COUNT).ARVL_STATN := DATA.ARVL_STATN;
            SET_DETAIL_TCKT_RCRD(SET_DETAIL_TCKT_RCRD.COUNT).ARVL_TM := DATA.ARVL_TM;
            SET_DETAIL_TCKT_RCRD(SET_DETAIL_TCKT_RCRD.COUNT).ROOM_KND := DATA.ROOM_KND;
            SET_DETAIL_TCKT_RCRD(SET_DETAIL_TCKT_RCRD.COUNT).ROOM := DATA.ROOM;
            SET_DETAIL_TCKT_RCRD(SET_DETAIL_TCKT_RCRD.COUNT).PSNGR_KND := DATA.PSNGR_KND;
            SET_DETAIL_TCKT_RCRD(SET_DETAIL_TCKT_RCRD.COUNT).PSNGR_NM := DATA.PSNGR_NM;
            SET_DETAIL_TCKT_RCRD(SET_DETAIL_TCKT_RCRD.COUNT).SEAT_NO := DATA.SEAT_NO;
            SET_DETAIL_TCKT_RCRD(SET_DETAIL_TCKT_RCRD.COUNT).FR_AMOUNT := DATA.FR_AMOUNT;
            SET_DETAIL_TCKT_RCRD(SET_DETAIL_TCKT_RCRD.COUNT).DSCNT_AMOUNT := DATA.DSCNT_AMOUNT;
            SET_DETAIL_TCKT_RCRD(SET_DETAIL_TCKT_RCRD.COUNT).RCPT_AMOUNT := DATA.RCPT_AMOUNT;
            PIPE ROW(SET_DETAIL_TCKT_RCRD(SET_DETAIL_TCKT_RCRD.COUNT));
        END LOOP
        ;
    END FN_SLT_DETAIL_TCKT_RCRD_2
    ;
END ;


