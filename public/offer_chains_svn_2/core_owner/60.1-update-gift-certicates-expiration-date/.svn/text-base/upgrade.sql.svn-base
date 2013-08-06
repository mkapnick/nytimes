WHENEVER SQLERROR EXIT SQL.SQLCODE ROLLBACK

-- 322 updates are expected in PROD
UPDATE
    gift_certificate gc
SET
    gc.expiration_date = add_months(purchase_date, 12 * 5),
    updated_by = 'jira_SAR-705',
    update_date = SYSDATE
WHERE
    gift_certificate_status_id = 1
AND purchase_date > '01-NOV-11'
AND expiration_date < SYSDATE + 90
AND expiration_date > purchase_date
AND expiration_date < add_months(purchase_date, 12 * 5)
AND finalized_invoice_id IS NULL
AND gc.offer_chain_id IN(1001513,
                         1001523,
                         1001533,
                         1001543,
                         1001553,
                         1001563,
                         1005710,
                         1005720,
                         1005730,
                         1005740,
                         1005750,
                         1005760,
                         100001);

COMMIT;