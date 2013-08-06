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
         offer_chain_id = 1188880)
   LOOP
      UPDATE GIFT_CERTIFICATE
      SET EXPIRATION_DATE = to_date('06/08/13', 'MM/DD/YY'),
         UPDATE_DATE = today,
         UPDATED_BY = 'JIRA-SAR-287'
      WHERE OFFER_CHAIN_ID = 1188880
         AND CODE = f_row.CODE;

      cnt := cnt + 1;
      IF mod(cnt, 2000) = 0 THEN
         COMMIT;
      END IF;
   END LOOP;
   COMMIT;
END;
/

