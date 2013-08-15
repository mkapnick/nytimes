set serveroutput on;
--https://svn.prvt.nytimes.com/svn/db/trunk/oracle/migrations/EC
WHENEVER SQLERROR EXIT ROLLBACK;
DECLARE
temp_count NUMBER;
BEGIN
  BEGIN
    FOR REC IN
    (
	SELECT DISTINCT c.id AS charge_id, c.invoice_id AS invoice_id
	FROM invoice_adjustment ia
	JOIN charge c ON c.invoice_id = ia.invoice_id
	JOIN TRANSACTION t ON t.ID = c.transaction_id AND t.is_refund = 1
	WHERE c.id NOT IN (SELECT charge_id FROM invoice_adjustment)      
   )
   LOOP
      SELECT COUNT(1) INTO temp_count FROM INVOICE_ADJUSTMENT where INVOICE_ID =  REC.INVOICE_ID;
      IF temp_count = 1 THEN
         --DBMS_OUTPUT.PUT_LINE('update invoice_adjustment set charge_id='||REC.CHARGE_ID||' where invoice_id='||REC.INVOICE_ID);
         --set updated_by and update_date
         update invoice_adjustment set charge_id=REC.CHARGE_ID,update_date=sysdate, updated_by='SR-413' where invoice_id=REC.INVOICE_ID and updated_by != 'SR-413';
         --to look at csv report billing t_type is none
      ELSE
         DBMS_OUTPUT.PUT_LINE('Skipping because only dealing with 1 invoice adjustment invoice_id = '||REC.INVOICE_ID);
      END IF;
      
    END LOOP;
    
  END;
END;
/
--other manual updates here
-- for invoice_id=23733913
UPDATE invoice_adjustment SET charge_id=9771771,update_date=sysdate, updated_by='SR-413' WHERE ID=46257 and updated_by != 'SR-413'; 
-- for invoice_id=17014610
UPDATE invoice_adjustment SET charge_id=6693820,update_date=sysdate, updated_by='SR-413' WHERE ID=19367 and updated_by != 'SR-413'; 
-- for invoice_id=24316646
UPDATE invoice_adjustment SET charge_id=11469538,update_date=sysdate, updated_by='SR-413' WHERE ID=62626 and updated_by != 'SR-413'; 
UPDATE invoice_adjustment SET charge_id=11469537,update_date=sysdate, updated_by='SR-413' WHERE ID=62615 and updated_by != 'SR-413'; 
commit;
EXIT;
