BEGIN
  /*
    FOR cons_rec IN
    (
        SELECT
            table_name,
            constraint_name
        FROM
            user_constraints
        WHERE
            constraint_type = 'R'
    )
    LOOP
        EXECUTE immediate 'alter table '|| cons_rec.table_name ||' disable constraint '|| cons_rec.constraint_name ;
    END LOOP;
    */

DELETE
    FROM
        DISCOUNT
    WHERE
        ID IN
        (
            SELECT
                discount_id
            FROM
                discount_product_offering
            WHERE
                product_offering_id IN
                (
                    SELECT
                        producT_offering_id
                    FROM
                        offeR_product_offering
                    WHERE
                        offer_id IN
                        (
                            SELECT
                                offer_id
                            FROM
                                offer_offer_chain
                            WHERE
                                offer_chain_id IN
                                (
                                    SELECT
                                        id
                                    FROM
                                        offer_chain
                                    WHERE
                                        adoptability_window_start_date >= '01-JAN-2011'
                                    AND id > 100000
                                    AND not exists ( select 1 from subscription where subscription.offer_chain_id = offer_chain.id )
                                    AND created_by = 'chris'
                                )
                        )
                )
        );
DELETE
FROM
    discount_product_offering
WHERE
    product_offering_id IN
    (
        SELECT
            producT_offering_id
        FROM
            offeR_product_offering
        WHERE
            offer_id IN
            (
                SELECT
                    offer_id
                FROM
                    offer_offer_chain
                WHERE
                    offer_chain_id IN
                    (
                        SELECT
                            id
                        FROM
                            offer_chain
                        WHERE
                            adoptability_window_start_date >= '01-JAN-2011'
                        AND id > 100000
                                    AND not exists ( select 1 from subscription where subscription.offer_chain_id = offer_chain.id )
                        AND created_by = 'chris'
                    )
            )
    );
DELETE
FROM
    producT_offering_meta_data
WHERE
    product_offering_id IN
    (
        SELECT
            producT_offering_id
        FROM
            offeR_product_offering
        WHERE
            offer_id IN
            (
                SELECT
                    offer_id
                FROM
                    offer_offer_chain
                WHERE
                    offer_chain_id IN
                    (
                        SELECT
                            id
                        FROM
                            offer_chain
                        WHERE
                            adoptability_window_start_date >= '01-JAN-2011'
                        AND id > 100000
                                    AND not exists ( select 1 from subscription where subscription.offer_chain_id = offer_chain.id )
                        AND created_by = 'chris'
                    )
            )
    );
DELETE
FROM
    product_offering
WHERE
    id IN
    (
        SELECT
            producT_offering_id
        FROM
            offeR_product_offering
        WHERE
            offer_id IN
            (
                SELECT
                    offer_id
                FROM
                    offer_offer_chain
                WHERE
                    offer_chain_id IN
                    (
                        SELECT
                            id
                        FROM
                            offer_chain
                        WHERE
                            adoptability_window_start_date >= '01-JAN-2011'
                        AND id > 100000
                                    AND not exists ( select 1 from subscription where subscription.offer_chain_id = offer_chain.id )
                        AND created_by = 'chris'
                    )
            )
    );
DELETE
FROM
    offer_product_offering
WHERE
    offer_id IN
    (
        SELECT
            offer_id
        FROM
            offer_offer_chain
        WHERE
            offer_chain_id IN
            (
                SELECT
                    id
                FROM
                    offer_chain
                WHERE
                    adoptability_window_start_date >= '01-JAN-2011'
                AND id > 100000
                                    AND not exists ( select 1 from subscription where subscription.offer_chain_id = offer_chain.id )
                AND created_by = 'chris'
            )
    );
DELETE
FROM
    OFFER_OFFER_CHAIN
WHERE
    offer_id IN
    (
        SELECT
            offer_id
        FROM
            offer_offer_chain
        WHERE
            offer_chain_id IN
            (
                SELECT
                    id
                FROM
                    offer_chain
                WHERE
                    adoptability_window_start_date >= '01-JAN-2011'
                AND id > 100000
                                    AND not exists ( select 1 from subscription where subscription.offer_chain_id = offer_chain.id )
                AND created_by = 'chris'
            )
    ) ;

DELETE
FROM
    OFFER
WHERE
    id IN
    (
        SELECT
            offer_id
        FROM
            offer_offer_chain
        WHERE
            offer_chain_id IN
            (
                SELECT
                    id
                FROM
                    offer_chain
                WHERE
                    adoptability_window_start_date >= '01-JAN-2011'
                AND id > 100000
                                    AND not exists ( select 1 from subscription where subscription.offer_chain_id = offer_chain.id )
                AND created_by = 'chris'
            )
    );
DELETE
FROM
    OFFER_CHAIN_META_DATA
WHERE
    offer_chain_id IN
    (
        SELECT
            id
        FROM
            offer_chain
        WHERE
            adoptability_window_start_date >= '01-JAN-2011'
        AND id > 100000
                                    AND not exists ( select 1 from subscription where subscription.offer_chain_id = offer_chain.id )
        AND created_by = 'chris'
    );
DELETE
FROM
    OFFER_CHAIN_ELIGIBILITY
WHERE
    offer_chain_id IN
    (
        SELECT
            id
        FROM
            offer_chain
        WHERE
            adoptability_window_start_date >= '01-JAN-2011'
        AND id > 100000
                                    AND not exists ( select 1 from subscription where subscription.offer_chain_id = offer_chain.id )
        AND created_by = 'chris'
    );
DELETE
FROM
    OFFER_CHAIN
WHERE
    id IN
    (
        SELECT
            id
        FROM
            offer_chain
        WHERE
            adoptability_window_start_date >= '01-JAN-2011'
        AND id > 100000
                                    AND not exists ( select 1 from subscription where subscription.offer_chain_id = offer_chain.id )
        AND created_by = 'chris'
    );
END;
/
exit
