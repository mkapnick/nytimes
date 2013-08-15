WHENEVER SQLERROR EXIT SQL.SQLCODE ROLLBACK

UPDATE
  Gift_Certificate
SET
  Expiration_Date = Add_Months(Create_Date, 60),
  Updated_By      = 'JIRA-SAR-692',
  Update_Date     = SYSDATE
WHERE
  ID IN
  (
    SELECT
      gc.id
    FROM
      core_owner.gift_certificate gc
    WHERE
      gift_certificate_status_id = 1
    AND purchase_date            > '01-NOV-11'
    AND expiration_date          < SYSDATE + 7
    AND expiration_date          > purchase_date
    AND expiration_date          < add_months(purchase_date, 12 * 5)
    AND finalized_invoice_id    IS NULL
    AND offer_chain_id          IN(1001513, 1001523, 1001533, 1001543, 1001553,
      1001563, 1005710, 1005720, 1005730, 1005740, 1005750, 1005760, 100001)
  );

COMMIT;