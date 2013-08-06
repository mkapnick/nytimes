/*
  There is a 10(ish) month duration offer that had an incorrect number of articles assigned to it (100).
  Updating it to match the current logic which will set article quantity = duration in days / 28 * 100.
*/

WHENEVER SQLERROR EXIT ROLLBACK;

UPDATE
    PRODUCT_OFFERING
SET
    QUANTITY = 1039,
    CREATED_BY = 'CASE_49245',
    CREATE_DATE = SYSDATE
WHERE
    PRODUCT_ID IN
    (
        SELECT
            ID
        FROM
            PRODUCT
        WHERE
            NAME = 'Archive Article'
        AND product_status_id = 1
    )
AND quantity = 100
AND id IN
    (
        SELECT
            product_offering_id
        FROM
            offer_product_offering
        WHERE
            offer_id IN
            (
                SELECT
                    id
                FROM
                    offer
                WHERE
                    entitlement_duration = 'P0Y0M291DT0H0M'
            )
    ) ;

COMMIT;
