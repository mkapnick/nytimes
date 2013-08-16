set SERVEROUTPUT on;
whenever SQLERROR EXIT rollback;

CREATE or REPLACE TRIGGER TR_CHARGE_AUD
    AFTER INSERT or UPDATE or DELETE
ON CHARGE
    REFERENCING NEW as new old as old
    FOR EACH ROW
DECLARE
    v_action char(1);
BEGIN
    IF INSERTING THEN
        v_action := 'I';
    ELSIF UPDATING THEN
        v_action := 'U';
    ELSE
        v_action := 'D';
        insert into change_log(id,change_time,action,item)
        values(:old.id,systimestamp,v_action,'CHARGE');
    END IF;

    if (v_action <> 'D' AND :new.updated_by <> 'SAR-786') then
        insert into change_log(id,change_time,action,item)
        values(:new.id,systimestamp,v_action,'CHARGE');
    end if;
END;
/

DECLARE
VAR_COUNT number := 0;
VAR_LAST_STATUS_ID NUMBER := 1;
VAR_PENDING_STATUS number := 1;
VAR_CANCELED_STATUS number := 3;
VAR_CAPTURED_STATUS number := 4;
VAR_FAILED_STATUS number := 5;
VAR_SETTLED_STATUS number := 6;
VAR_CHARGEBACK_STATUS number := 8;
VAR_JIRA VARCHAR2(40) := 'SAR-786';
VAR_START_DATE date := to_date('01-Apr-2013', 'DD-Mon-YYYY');
VAR_END_DATE date := to_date('15-Aug-2013', 'DD-Mon-YYYY');
begin


  UPDATE CHARGE SET
      CHARGE_STATUS_ID = VAR_FAILED_STATUS ,
      UPDATED_BY = VAR_JIRA
  WHERE
      UPDATED_BY != VAR_JIRA
      AND ID IN (
        SELECT C.ID
        FROM
          CHARGE C,
          TRANSACTION_ATTEMPT TA
        WHERE
          C.TRANSACTION_ID = TA.TRANSACTION_ID
          AND C.CHARGE_STATUS_ID = VAR_CANCELED_STATUS
          AND TA.EXTERNAL_STATUS_CODE = 'cancelled due to realtime auth capture fail'
          AND C.CREATE_DATE >= VAR_START_DATE 
          AND C.CREATE_DATE < VAR_END_DATE
      ) ;
  COMMIT;

  INSERT INTO CHARGE_STATUS_LOG (ID,CHARGE_ID,CHARGE_STATUS_ID,CREATE_DATE,CREATED_BY) 
  (
        SELECT CHARGE_STATUS_LOG_ID_SEQ.NEXTVAL,ID, VAR_PENDING_STATUS, C.CREATE_DATE,VAR_JIRA
        FROM CHARGE C
        WHERE C.CHARGE_STATUS_ID = 3
        AND C.UPDATED_BY != VAR_JIRA
        AND C.CREATE_DATE >= VAR_START_DATE 
        AND C.CREATE_DATE < VAR_END_DATE
  ) ;

  INSERT INTO CHARGE_STATUS_LOG (ID,CHARGE_ID,CHARGE_STATUS_ID,CREATE_DATE,CREATED_BY) 
  (
      SELECT CHARGE_STATUS_LOG_ID_SEQ.NEXTVAL,ID, VAR_CANCELED_STATUS, C.UPDATE_DATE,VAR_JIRA
      FROM CHARGE C
      WHERE C.CHARGE_STATUS_ID = 3
      AND C.CREATE_DATE >= VAR_START_DATE 
      AND C.CREATE_DATE < VAR_END_DATE
      AND C.UPDATED_BY != VAR_JIRA
  ) ;
  
  UPDATE CHARGE SET 
    UPDATED_BY = VAR_JIRA
  WHERE CHARGE_STATUS_ID = 3
    AND CREATE_DATE >= VAR_START_DATE
    AND CREATE_DATE < VAR_END_DATE
    AND UPDATED_BY != VAR_JIRA;
   
  COMMIT;
  
  
  FOR REC IN
  (
      SELECT
          C.ID AS CHARGE_ID
        , C.INVOICE_ID AS INVOICE_ID
        , C.CHARGE_AMOUNT as CHARGE_AMOUNT
        , T.ID AS TRANSACTION_ID
        , T.ORDER_ID AS ORDER_ID
        , t.create_date as create_date
        ,  MIN(success.create_date) as capture_date
        , CASE
               WHEN MIN(success.create_date) is not NULL then NULL
               WHEN c.charge_status_id IN (5) THEN COALESCE(MAX(failed.create_date), c.create_date)
               WHEN t.transaction_status_id = 2 THEN MAX(failed.create_date)
               ELSE NULL
          END failed_date
        , COALESCE(MIN(cpt_s.create_date), MIN(pp_s.create_date)) settled_date
        , COALESCE(MIN(cpt_c.create_date), MIN(pp_c.create_date), MIN(amx_c.create_date) ) chargeback_date
      FROM transaction t
      JOIN charge c ON t.id = c.transaction_id
      LEFT JOIN transaction_attempt success ON t.id = success.transaction_id AND success.transaction_attempt_status_id = 2 
      LEFT JOIN transaction_attempt failed ON t.id = failed.transaction_id AND failed.transaction_attempt_status_id = 3 AND t.transaction_status_id = 2 
      LEFT JOIN rcn_cpt_deposit_detail cpt_s ON t.order_id = cpt_s.merchant_order_number 
      LEFT JOIN rcn_pp_trans_detail pp_s ON t.order_id = pp_s.invoice_id AND pp_s.trans_status = 'S' 
      LEFT JOIN rcn_cpt_chargeback_act_detail cpt_c ON t.order_id = cpt_c.merchant_order_number AND cpt_c.chargeback_category = 'RECD' 
      LEFT JOIN rcn_pp_trans_detail pp_c ON t.order_id = pp_c.invoice_id AND pp_c.trans_status IN ('D', 'V') 
      LEFT JOIN RCN_AMEX_CHARGEBACK AMX_C ON T.ORDER_ID = LOWER(AMX_C.IND_REF_NUMBER) 
      WHERE 
      C.CREATE_DATE >= VAR_START_DATE 
      AND C.CREATE_DATE < VAR_END_DATE
      AND C.CHARGE_STATUS_ID NOT IN (VAR_CANCELED_STATUS,VAR_PENDING_STATUS)
      AND C.UPDATED_BY != VAR_JIRA
      GROUP BY C.ID,C.INVOICE_ID,C.CHARGE_AMOUNT,T.ID, T.ORDER_ID, T.IS_REFUND, T.TRANSACTION_AMOUNT, T.CREATE_DATE, C.CREATE_DATE, C.CHARGE_STATUS_ID, T.TRANSACTION_STATUS_ID  
  )
  LOOP
    --DBMS_OUTPUT.PUT_LINE('Charge ID '||REC.CHARGE_ID ||' Transaction ID '||REC.TRANSACTION_ID|| ' Open Date '|| REC.CREATE_DATE);
    IF (REC.CREATE_DATE IS NOT NULL) THEN
      --DBMS_OUTPUT.PUT_LINE('Open!');
      VAR_LAST_STATUS_ID := VAR_PENDING_STATUS;
      INSERT INTO CHARGE_STATUS_LOG (ID,CHARGE_ID,CHARGE_STATUS_ID,CREATE_DATE,CREATED_BY) VALUES (CHARGE_STATUS_LOG_ID_SEQ.nextval,REC.CHARGE_ID,var_last_status_id,REC.CREATE_DATE,VAR_JIRA);      
    END IF;

    --should not have failed date
    IF (REC.failed_date IS NOT NULL) THEN
      --DBMS_OUTPUT.PUT_LINE('Failed!');
      VAR_LAST_STATUS_ID := VAR_FAILED_STATUS;
      INSERT INTO CHARGE_STATUS_LOG (ID,CHARGE_ID,CHARGE_STATUS_ID,CREATE_DATE,CREATED_BY) VALUES (CHARGE_STATUS_LOG_ID_SEQ.nextval,REC.CHARGE_ID,var_last_status_id,REC.failed_date,VAR_JIRA); 
    END IF;
    
    IF (REC.capture_date IS NOT NULL) THEN
      --DBMS_OUTPUT.PUT_LINE('Captured!');
      VAR_LAST_STATUS_ID := VAR_CAPTURED_STATUS;
      INSERT INTO CHARGE_STATUS_LOG (ID,CHARGE_ID,CHARGE_STATUS_ID,CREATE_DATE,CREATED_BY) VALUES (CHARGE_STATUS_LOG_ID_SEQ.nextval,REC.CHARGE_ID,var_last_status_id,REC.capture_date,VAR_JIRA); 
    END IF;

    IF (REC.settled_date IS NOT NULL) THEN
      --DBMS_OUTPUT.PUT_LINE('Settled!');
      VAR_LAST_STATUS_ID := VAR_SETTLED_STATUS;
      INSERT  INTO CHARGE_STATUS_LOG (ID,CHARGE_ID,CHARGE_STATUS_ID,CREATE_DATE,CREATED_BY) VALUES (CHARGE_STATUS_LOG_ID_SEQ.NEXTVAL,REC.CHARGE_ID,VAR_LAST_STATUS_ID,REC.settled_date,VAR_JIRA); 
    END IF;
    
    IF (REC.CHARGEBACK_DATE IS NOT NULL) THEN
      --DBMS_OUTPUT.PUT_LINE('Chargeback!');
      VAR_LAST_STATUS_ID := VAR_CHARGEBACK_STATUS;
      INSERT  INTO CHARGE_STATUS_LOG (ID,CHARGE_ID,CHARGE_STATUS_ID,CREATE_DATE,CREATED_BY) VALUES (CHARGE_STATUS_LOG_ID_SEQ.NEXTVAL,REC.CHARGE_ID,VAR_LAST_STATUS_ID,REC.CHARGEBACK_DATE,VAR_JIRA); 
    END IF;
  
    --DBMS_OUTPUT.PUT_LINE('Last Charge Status ID '||VAR_LAST_STATUS_ID);
    UPDATE CHARGE SET 
      CHARGE_STATUS_ID = VAR_LAST_STATUS_ID,
      UPDATED_BY = VAR_JIRA
    WHERE ID = REC.CHARGE_ID;
    
    IF (REC.capture_date is not NULL) THEN
      INSERT  /*+ ignore_row_on_dupkey_index(AR_BALANCE_APPLIES,AR_APPLIES_PK) */ INTO AR_BALANCE_APPLIES (CHARGE_ID,INVOICE_ID,AMOUNT,CREATE_DATE,CREATED_BY) VALUES (REC.CHARGE_ID,REC.INVOICE_ID,REC.CHARGE_AMOUNT,COALESCE(REC.capture_date,REC.create_date),VAR_JIRA);
    END IF;
    
    VAR_COUNT := VAR_COUNT + 1;
    IF( MOD(VAR_COUNT,1000) = 0 ) THEN
      commit;
      DBMS_OUTPUT.PUT_LINE('VAR_COUNT = '||VAR_COUNT);
    END IF;
    
  END LOOP;
  commit;
  
END;
/
commit;

delete from 
   charge_status_log a
where 
   a.rowid > 
   any (select b.rowid
	   from 
	      charge_status_log b
	   where 
	      a.charge_id = b.charge_id
	   and 
	      a.CHARGE_STATUS_ID = B.CHARGE_STATUS_ID
	   )
	;
commit;

CREATE or REPLACE TRIGGER TR_CHARGE_AUD
    AFTER INSERT or UPDATE or DELETE
ON CHARGE
    REFERENCING NEW as new old as old
    FOR EACH ROW
DECLARE
    v_action char(1);
BEGIN
    IF INSERTING THEN
        v_action := 'I';
    ELSIF UPDATING THEN
        v_action := 'U';
    ELSE
        v_action := 'D';
        insert into change_log(id,change_time,action,item)
        values(:old.id,systimestamp,v_action,'CHARGE');
    END IF;

    if (v_action <> 'D') then
        insert into change_log(id,change_time,action,item)
        values(:new.id,systimestamp,v_action,'CHARGE');
    end if;
END;
/


