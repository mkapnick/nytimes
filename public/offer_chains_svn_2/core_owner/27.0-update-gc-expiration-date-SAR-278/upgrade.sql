WHENEVER SQLERROR EXIT SQL.SQLCODE ROLLBACK

DECLARE
cnt  NUMBER(1,-2);
today DATE :=sysdate;
BEGIN
   cnt := 0;

   FOR f_row IN (
      SELECT code as "CODE"
      FROM
         GIFT_CERTIFICATE
      WHERE
         offer_chain_id = 5801360120
	 AND PURCHASER_GROUP_ID=67310183 
	 AND gift_certificate_status_id = 1
	)
   LOOP
      UPDATE GIFT_CERTIFICATE
      SET EXPIRATION_DATE = add_months(create_date,60),
         UPDATE_DATE = today,
         UPDATED_BY = 'JIRA-SAR-278'
      WHERE OFFER_CHAIN_ID = 5801360120 
         AND CODE = f_row.CODE
	 AND gift_certificate_status_id = 1
	 AND PURCHASER_GROUP_ID=67310183;

      cnt := cnt + 1;
      IF mod(cnt, 2000) = 0 THEN
         COMMIT;
      END IF;
   END LOOP;
   COMMIT;
END;
/

