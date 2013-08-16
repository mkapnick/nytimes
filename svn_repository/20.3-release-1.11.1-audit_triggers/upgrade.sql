whenever sqlerror exit failure

CREATE or REPLACE TRIGGER TR_OFFER_CHAIN_AUD
    AFTER INSERT or UPDATE or DELETE
ON OFFER_CHAIN
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
        insert into change_log(id,combined_id,change_time,action,item)
        values(:old.id,null,systimestamp,v_action,'OFFER_CHAIN');
    END IF;

    if (v_action <> 'D') then
            insert into change_log(id,combined_id,change_time,action,item)
            values(:new.id,null,systimestamp,v_action,'OFFER_CHAIN');
    end if;
END;
/

CREATE or REPLACE TRIGGER TR_OFFER_OFFER_CHAIN_AUD
    AFTER INSERT or UPDATE or DELETE
ON OFFER_OFFER_CHAIN
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
        insert into change_log(id,combined_id,change_time,action,item)
        values(0,:old.offer_id||'~'||:old.offer_chain_id,systimestamp,v_action,'OFFER_OFFER_CHAIN');
    END IF;

    if (v_action <> 'D') then
            insert into change_log(id,combined_id,change_time,action,item)
            values(0,:new.offer_id||'~'||:new.offer_chain_id,systimestamp,v_action,'OFFER_OFFER_CHAIN');
    end if;
END;
/

CREATE or REPLACE TRIGGER TR_OFFER_CHAIN_ELIGIBILITY_AUD
    AFTER INSERT or UPDATE or DELETE
ON OFFER_CHAIN_ELIGIBILITY
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
        insert into change_log(id,combined_id,change_time,action,item)
        values(:old.id,null,systimestamp,v_action,'OFFER_CHAIN_ELIGIBILITY');
    END IF;

    if (v_action <> 'D') then
            insert into change_log(id,combined_id,change_time,action,item)
            values(:new.id,null,systimestamp,v_action,'OFFER_CHAIN_ELIGIBILITY');
    end if;
END;
/

CREATE or REPLACE TRIGGER TR_OFFER_AUD
    AFTER INSERT or UPDATE or DELETE
ON OFFER
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
        insert into change_log(id,combined_id,change_time,action,item)
        values(:old.id,null,systimestamp,v_action,'OFFER');
    END IF;

    if (v_action <> 'D') then
            insert into change_log(id,combined_id,change_time,action,item)
            values(:new.id,null,systimestamp,v_action,'OFFER');
    end if;
END;
/

CREATE or REPLACE TRIGGER TR_PRODUCT_OFFERING_AUD
    AFTER INSERT or UPDATE or DELETE
ON PRODUCT_OFFERING
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
        insert into change_log(id,combined_id,change_time,action,item)
        values(:old.id,null,systimestamp,v_action,'PRODUCT_OFFERING');
    END IF;

    if (v_action <> 'D') then
            insert into change_log(id,combined_id,change_time,action,item)
            values(:new.id,null,systimestamp,v_action,'PRODUCT_OFFERING');
    end if;
END;
/

CREATE or REPLACE TRIGGER TR_PRODUCT_AUD
    AFTER INSERT or UPDATE or DELETE
ON PRODUCT
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
        insert into change_log(id,combined_id,change_time,action,item)
        values(:old.id,null,systimestamp,v_action,'PRODUCT');
    END IF;

    if (v_action <> 'D') then
            insert into change_log(id,combined_id,change_time,action,item)
            values(:new.id,null,systimestamp,v_action,'PRODUCT');
    end if;
END;
/

CREATE or REPLACE TRIGGER TR_PRODUCT_ELIGIBILITY_AUD
    AFTER INSERT or UPDATE or DELETE
ON PRODUCT_ELIGIBILITY
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
        insert into change_log(id,combined_id,change_time,action,item)
        values(:old.id,null,systimestamp,v_action,'PRODUCT_ELIGIBILITY');
    END IF;

    if (v_action <> 'D') then
            insert into change_log(id,combined_id,change_time,action,item)
            values(:new.id,null,systimestamp,v_action,'PRODUCT_ELIGIBILITY');
    end if;
END;
/

CREATE or REPLACE TRIGGER TR_OFFER_PRODUCT_OFFERING_AUD
    AFTER INSERT or UPDATE or DELETE
ON OFFER_PRODUCT_OFFERING
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
        insert into change_log(id,combined_id,change_time,action,item)
        values(0,:old.product_offering_id||'~'||:old.offer_id,systimestamp,v_action,'OFFER_PRODUCT_OFFERING');
    END IF;

    if (v_action <> 'D') then
            insert into change_log(id,combined_id,change_time,action,item)
            values(0,:new.product_offering_id||'~'||:new.offer_id,systimestamp,v_action,'OFFER_PRODUCT_OFFERING');
    end if;
END;
/

CREATE or REPLACE TRIGGER TR_DISCOUNT_PROD_OFFER_AUD
    AFTER INSERT or UPDATE or DELETE
ON DISCOUNT_PRODUCT_OFFERING
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
        insert into change_log(id,combined_id,change_time,action,item)
        values(0,:old.discount_id||'~'||:old.product_offering_id,systimestamp,v_action,'DISCOUNT_PRODUCT_OFFERING');
    END IF;

    if (v_action <> 'D') then
            insert into change_log(id,combined_id,change_time,action,item)
            values(0,:new.discount_id||'~'||:new.product_offering_id,systimestamp,v_action,'DISCOUNT_PRODUCT_OFFERING');
    end if;
END;
/

CREATE or REPLACE TRIGGER TR_DISCOUNT_AUD
    AFTER INSERT or UPDATE or DELETE
ON DISCOUNT
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
        insert into change_log(id,combined_id,change_time,action,item)
        values(:old.id,null,systimestamp,v_action,'DISCOUNT');
    END IF;

    if (v_action <> 'D') then
            insert into change_log(id,combined_id,change_time,action,item)
            values(:new.id,null,systimestamp,v_action,'DISCOUNT');
    end if;
END;
/

CREATE or REPLACE TRIGGER TR_OFFER_CHAIN_META_DATA_AUD
    AFTER INSERT or UPDATE or DELETE
ON OFFER_CHAIN_META_DATA
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
        insert into change_log(id,combined_id,change_time,action,item)
        values(:old.id,null,systimestamp,v_action,'OFFER_CHAIN_META_DATA');
    END IF;

    if (v_action <> 'D') then
            insert into change_log(id,combined_id,change_time,action,item)
            values(:new.id,null,systimestamp,v_action,'OFFER_CHAIN_META_DATA');
    end if;
END;
/

CREATE or REPLACE TRIGGER TR_PROD_OFFER_META_DATA_AUD
    AFTER INSERT or UPDATE or DELETE
ON PRODUCT_OFFERING_META_DATA
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
        insert into change_log(id,combined_id,change_time,action,item)
        values(:old.id,null,systimestamp,v_action,'PRODUCT_OFFERING_META_DATA');
    END IF;

    if (v_action <> 'D') then
            insert into change_log(id,combined_id,change_time,action,item)
            values(:new.id,null,systimestamp,v_action,'PRODUCT_OFFERING_META_DATA');
    end if;
END;
/

CREATE or REPLACE TRIGGER TR_INVOICE_AUD
    AFTER INSERT or UPDATE or DELETE
ON INVOICE
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
        insert into change_log(id,combined_id,change_time,action,item)
        values(:old.id,null,systimestamp,v_action,'INVOICE');
    END IF;

    if (v_action <> 'D') then
            insert into change_log(id,combined_id,change_time,action,item)
            values(:new.id,null,systimestamp,v_action,'INVOICE');
    end if;
END;
/

CREATE or REPLACE TRIGGER TR_LICENSE_AUD
    AFTER INSERT or UPDATE or DELETE
ON LICENSE
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
        insert into change_log(id,combined_id,change_time,action,item)
        values(:old.id,null,systimestamp,v_action,'LICENSE');
    END IF;

    if (v_action <> 'D') then
            insert into change_log(id,combined_id,change_time,action,item)
            values(:new.id,null,systimestamp,v_action,'LICENSE');
    end if;
END;
/

CREATE or REPLACE TRIGGER TR_LINE_ITEM_AUD
    AFTER INSERT or UPDATE or DELETE
ON LINE_ITEM
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
        insert into change_log(id,combined_id,change_time,action,item)
        values(:old.id,null,systimestamp,v_action,'LINE_ITEM');
    END IF;

    if (v_action <> 'D') then
            insert into change_log(id,combined_id,change_time,action,item)
            values(:new.id,null,systimestamp,v_action,'LINE_ITEM');
    end if;
END;
/

CREATE or REPLACE TRIGGER TR_SUBSCRIPTION_AUD
    AFTER INSERT or UPDATE or DELETE
ON SUBSCRIPTION
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
        insert into change_log(id,combined_id,change_time,action,item)
        values(:old.id,null,systimestamp,v_action,'SUBSCRIPTION');
    END IF;

    if (v_action <> 'D') then
            insert into change_log(id,combined_id,change_time,action,item)
            values(:new.id,null,systimestamp,v_action,'SUBSCRIPTION');
    end if;
END;
/

CREATE or REPLACE TRIGGER TR_TRANSACTION_AUD
    AFTER INSERT or UPDATE or DELETE
ON TRANSACTION
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
        insert into change_log(id,combined_id,change_time,action,item)
        values(:old.id,null,systimestamp,v_action,'TRANSACTION');
    END IF;

    if (v_action <> 'D') then
            insert into change_log(id,combined_id,change_time,action,item)
            values(:new.id,null,systimestamp,v_action,'TRANSACTION');
    end if;
END;
/

CREATE or REPLACE TRIGGER TR_GIFT_CERTIFICATE_AUD
    AFTER INSERT or UPDATE or DELETE
ON GIFT_CERTIFICATE
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
        insert into change_log(id,combined_id,change_time,action,item)
        values(:old.id,null,systimestamp,v_action,'GIFT_CERTIFICATE');
    END IF;

    if (v_action <> 'D') then
            insert into change_log(id,combined_id,change_time,action,item)
            values(:new.id,null,systimestamp,v_action,'GIFT_CERTIFICATE');
    end if;
END;
/

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
        insert into change_log(id,combined_id,change_time,action,item)
        values(:old.id,null,systimestamp,v_action,'CHARGE');
    END IF;

    if (v_action <> 'D') then
            insert into change_log(id,combined_id,change_time,action,item)
            values(:new.id,null,systimestamp,v_action,'CHARGE');
    end if;
END;
/

CREATE or REPLACE TRIGGER TR_ACCOUNT_AUD
    AFTER INSERT or UPDATE or DELETE
ON ACCOUNT
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
        insert into change_log(id,combined_id,change_time,action,item)
        values(:old.id,null,systimestamp,v_action,'ACCOUNT');
    END IF;

    if (v_action <> 'D') then
            insert into change_log(id,combined_id,change_time,action,item)
            values(:new.id,null,systimestamp,v_action,'ACCOUNT');
    end if;
END;
/

CREATE or REPLACE TRIGGER TR_SUBSCRIPTION_META_DATA_AUD
    AFTER INSERT or UPDATE or DELETE
ON SUBSCRIPTION_META_DATA
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
        insert into change_log(id,combined_id,change_time,action,item)
        values(:old.id,null,systimestamp,v_action,'SUBSCRIPTION_META_DATA');
    END IF;

    if (v_action <> 'D') then
            insert into change_log(id,combined_id,change_time,action,item)
            values(:new.id,null,systimestamp,v_action,'SUBSCRIPTION_META_DATA');
    end if;
END;
/

CREATE or REPLACE TRIGGER TR_CREDIT_CARD_AUD
    AFTER INSERT or UPDATE or DELETE
ON CREDIT_CARD
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
        insert into change_log(id,combined_id,change_time,action,item)
        values(:old.id,null,systimestamp,v_action,'CREDIT_CARD');
    END IF;

    if (v_action <> 'D') then
            insert into change_log(id,combined_id,change_time,action,item)
            values(:new.id,null,systimestamp,v_action,'CREDIT_CARD');
    end if;
END;
/

CREATE or REPLACE TRIGGER TR_TRANSACTION_ATTEMPT_AUD
    AFTER INSERT or UPDATE or DELETE
ON TRANSACTION_ATTEMPT
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
        insert into change_log(id,combined_id,change_time,action,item)
        values(:old.id,null,systimestamp,v_action,'TRANSACTION_ATTEMPT');
    END IF;

    if (v_action <> 'D') then
            insert into change_log(id,combined_id,change_time,action,item)
            values(:new.id,null,systimestamp,v_action,'TRANSACTION_ATTEMPT');
    end if;
END;
/

CREATE or REPLACE TRIGGER TR_INVOICE_ADJUSTMENT_AUD
    AFTER INSERT or UPDATE or DELETE
ON INVOICE_ADJUSTMENT
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
        insert into change_log(id,combined_id,change_time,action,item)
        values(:old.id,null,systimestamp,v_action,'INVOICE_ADJUSTMENT');
    END IF;

    if (v_action <> 'D') then
            insert into change_log(id,combined_id,change_time,action,item)
            values(:new.id,null,systimestamp,v_action,'INVOICE_ADJUSTMENT');
    end if;
END;
/

CREATE or REPLACE TRIGGER TR_LINE_ITEM_ADJUSTMENT_AUD
    AFTER INSERT or UPDATE or DELETE
ON LINE_ITEM_ADJUSTMENT
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
        insert into change_log(id,combined_id,change_time,action,item)
        values(:old.id,null,systimestamp,v_action,'LINE_ITEM_ADJUSTMENT');
    END IF;

    if (v_action <> 'D') then
            insert into change_log(id,combined_id,change_time,action,item)
            values(:new.id,null,systimestamp,v_action,'LINE_ITEM_ADJUSTMENT');
    end if;
END;
/

CREATE or REPLACE TRIGGER TR_TAX_ADJUSTMENT_AUD
    AFTER INSERT or UPDATE or DELETE
ON TAX_ADJUSTMENT
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
        insert into change_log(id,combined_id,change_time,action,item)
        values(:old.id,null,systimestamp,v_action,'TAX_ADJUSTMENT');
    END IF;

    if (v_action <> 'D') then
            insert into change_log(id,combined_id,change_time,action,item)
            values(:new.id,null,systimestamp,v_action,'TAX_ADJUSTMENT');
    end if;
END;
/

CREATE or REPLACE TRIGGER TR_DISCOUNT_LINEITEM_ADJ_AUD
    AFTER INSERT or UPDATE or DELETE
ON DISCOUNT_LINEITEM_ADJUSTMENT
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
        insert into change_log(id,combined_id,change_time,action,item)
        values(:old.id,null,systimestamp,v_action,'DISCOUNT_LINEITEM_ADJUSTMENT');
    END IF;

    if (v_action <> 'D') then
            insert into change_log(id,combined_id,change_time,action,item)
            values(:new.id,null,systimestamp,v_action,'DISCOUNT_LINEITEM_ADJUSTMENT');
    end if;
END;
/

CREATE or REPLACE TRIGGER TR_TAX_AUD
    AFTER INSERT or UPDATE or DELETE
ON TAX
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
        insert into change_log(id,combined_id,change_time,action,item)
        values(:old.id,null,systimestamp,v_action,'TAX');
    END IF;

    if (v_action <> 'D') then
            insert into change_log(id,combined_id,change_time,action,item)
            values(:new.id,null,systimestamp,v_action,'TAX');
    end if;
END;
/

CREATE or REPLACE TRIGGER TR_PAYPAL_AUD
    AFTER INSERT or UPDATE or DELETE
ON PAYPAL
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
        insert into change_log(id,combined_id,change_time,action,item)
        values(:old.id,null,systimestamp,v_action,'PAYPAL');
    END IF;

    if (v_action <> 'D') then
            insert into change_log(id,combined_id,change_time,action,item)
            values(:new.id,null,systimestamp,v_action,'PAYPAL');
    end if;
END;
/

CREATE or REPLACE TRIGGER TR_RCN_EXT_SOURCE_LOG_AUD
    AFTER INSERT or UPDATE or DELETE
ON RCN_EXT_SOURCE_LOG
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
        insert into change_log(id,combined_id,change_time,action,item)
        values(:old.id,null,systimestamp,v_action,'RCN_EXT_SOURCE_LOG');
    END IF;

    if (v_action <> 'D') then
            insert into change_log(id,combined_id,change_time,action,item)
            values(:new.id,null,systimestamp,v_action,'RCN_EXT_SOURCE_LOG');
    end if;
END;
/

CREATE or REPLACE TRIGGER TR_RCN_CPT_SVC_CHG_DTL_AUD
    AFTER INSERT or UPDATE or DELETE
ON RCN_CPT_SERVICE_CHARGE_DETAIL
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
        insert into change_log(id,combined_id,change_time,action,item)
        values(:old.id,null,systimestamp,v_action,'RCN_CPT_SERVICE_CHARGE_DETAIL');
    END IF;

    if (v_action <> 'D') then
            insert into change_log(id,combined_id,change_time,action,item)
            values(:new.id,null,systimestamp,v_action,'RCN_CPT_SERVICE_CHARGE_DETAIL');
    end if;
END;
/

CREATE or REPLACE TRIGGER TR_RCN_CPT_EXCP_DTL_AUD
    AFTER INSERT or UPDATE or DELETE
ON RCN_CPT_EXCEPTION_DETAIL
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
        insert into change_log(id,combined_id,change_time,action,item)
        values(:old.id,null,systimestamp,v_action,'RCN_CPT_EXCEPTION_DETAIL');
    END IF;

    if (v_action <> 'D') then
            insert into change_log(id,combined_id,change_time,action,item)
            values(:new.id,null,systimestamp,v_action,'RCN_CPT_EXCEPTION_DETAIL');
    end if;
END;
/

CREATE or REPLACE TRIGGER TR_RCN_CPT_DEPOSIT_DTL_AUD
    AFTER INSERT or UPDATE or DELETE
ON RCN_CPT_DEPOSIT_DETAIL
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
        insert into change_log(id,combined_id,change_time,action,item)
        values(:old.id,null,systimestamp,v_action,'RCN_CPT_DEPOSIT_DETAIL');
    END IF;

    if (v_action <> 'D') then
            insert into change_log(id,combined_id,change_time,action,item)
            values(:new.id,null,systimestamp,v_action,'RCN_CPT_DEPOSIT_DETAIL');
    end if;
END;
/

CREATE or REPLACE TRIGGER TR_RCN_CPT_CHBK_ACT_DTL_AUD
    AFTER INSERT or UPDATE or DELETE
ON RCN_CPT_CHARGEBACK_ACT_DETAIL
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
        insert into change_log(id,combined_id,change_time,action,item)
        values(:old.id,null,systimestamp,v_action,'RCN_CPT_CHARGEBACK_ACT_DETAIL');
    END IF;

    if (v_action <> 'D') then
            insert into change_log(id,combined_id,change_time,action,item)
            values(:new.id,null,systimestamp,v_action,'RCN_CPT_CHARGEBACK_ACT_DETAIL');
    end if;
END;
/

CREATE or REPLACE TRIGGER TR_RCN_PP_SETTLEMENT_AUD
    AFTER INSERT or UPDATE or DELETE
ON RCN_PP_SETTLEMENT
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
        insert into change_log(id,combined_id,change_time,action,item)
        values(:old.id,null,systimestamp,v_action,'RCN_PP_SETTLEMENT');
    END IF;

    if (v_action <> 'D') then
            insert into change_log(id,combined_id,change_time,action,item)
            values(:new.id,null,systimestamp,v_action,'RCN_PP_SETTLEMENT');
    end if;
END;
/

CREATE or REPLACE TRIGGER TR_RCN_PP_DISPUTE_AUD
    AFTER INSERT or UPDATE or DELETE
ON RCN_PP_DISPUTE
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
        insert into change_log(id,combined_id,change_time,action,item)
        values(:old.id,null,systimestamp,v_action,'RCN_PP_DISPUTE');
    END IF;

    if (v_action <> 'D') then
            insert into change_log(id,combined_id,change_time,action,item)
            values(:new.id,null,systimestamp,v_action,'RCN_PP_DISPUTE');
    end if;
END;
/

CREATE or REPLACE TRIGGER TR_RCN_PP_TRANS_DTL_AUD
    AFTER INSERT or UPDATE or DELETE
ON RCN_PP_TRANS_DETAIL
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
        insert into change_log(id,combined_id,change_time,action,item)
        values(:old.id,null,systimestamp,v_action,'RCN_PP_TRANS_DETAIL');
    END IF;

    if (v_action <> 'D') then
            insert into change_log(id,combined_id,change_time,action,item)
            values(:new.id,null,systimestamp,v_action,'RCN_PP_TRANS_DETAIL');
    end if;
END;
/

CREATE or REPLACE TRIGGER TR_RCN_AMEX_CHARGEBACK_AUD
    AFTER INSERT or UPDATE or DELETE
ON RCN_AMEX_CHARGEBACK
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
        insert into change_log(id,combined_id,change_time,action,item)
        values(:old.id,null,systimestamp,v_action,'RCN_AMEX_CHARGEBACK');
    END IF;

    if (v_action <> 'D') then
            insert into change_log(id,combined_id,change_time,action,item)
            values(:new.id,null,systimestamp,v_action,'RCN_AMEX_CHARGEBACK');
    end if;
END;
/

CREATE or REPLACE TRIGGER TR_ADDRESS_AUD
    AFTER INSERT or UPDATE or DELETE
ON ADDRESS
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
        insert into change_log(id,combined_id,change_time,action,item)
        values(:old.id,null,systimestamp,v_action,'ADDRESS');
    END IF;

    if (v_action <> 'D') then
            insert into change_log(id,combined_id,change_time,action,item)
            values(:new.id,null,systimestamp,v_action,'ADDRESS');
    end if;
END;
/
