WHENEVER SQLERROR EXIT ROLLBACK;

-- User Start Subscription Transaction type (8)
UPDATE
    transaction
SET
    transaction_type_code = 'START_SUBSCRIPTION'
WHERE
    created_by <> 'LICENSING' AND
    transaction_type_code IS NULL AND
    is_refund = 0 AND
    rownum <= 100 AND
    id IN
    (
        SELECT
            MIN(t.id)
        FROM
            transaction t,
            transaction_attempt ta,
            license l,
            charge c
        WHERE
            ta.transaction_id = t.id AND
            l.invoice_id = c.invoice_id AND
            c.transaction_id = t.id AND
            t.transaction_status_id = 1 AND
            t.create_date > SYSDATE - 3
        GROUP BY
            l.subscription_id) ;
COMMIT;

-- Refund Transaction types (38)
UPDATE
    transaction
SET
    transaction_type_code = 'REFUND'
WHERE
    is_refund = 1 AND
    created_by <> 'LICENSING' AND
    transaction_type_code IS NULL AND
    transaction_status_id = 1 AND
    create_date > SYSDATE - 3 AND
    rownum <= 500;
COMMIT;

-- Everything else not created by the licensing job must be a User Update Recurring Billing Transaction (100)
UPDATE
    transaction
SET
    transaction_type_code = 'RECURRING_BILLING_USER_UPDATE'
WHERE
    created_by <> 'LICENSING' AND
    transaction_type_code IS NULL AND
    transaction_status_id = 1 AND
    create_date > SYSDATE - 3 AND 
    rownum <= 1000;
COMMIT;

-- Everything else created by licensing is a Recurring Billing Transaction (577)
UPDATE
    transaction
SET
    transaction_type_code = 'RECURRING_BILLING'
WHERE
    created_by = 'LICENSING' AND
    transaction_type_code IS NULL AND
    transaction_status_id = 1 AND
    create_date > SYSDATE - 3 AND 
    rownum <= 5000;
COMMIT;

