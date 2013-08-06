--------------------------------------------------------------------------------
-- DDL for package PROCS_HISTORY
--------------------------------------------------------------------------------

CREATE OR REPLACE PACKAGE "PROCS_HISTORY_V19" AS 

PROCEDURE CREATE_ADDRESS_HISTORY (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V19.UNKNOWN_ERROR
*/
  in_address_id                 IN ADDRESS_HISTORY.ADDRESS_ID%TYPE,
  in_system_activity_reason_id  IN ADDRESS_HISTORY.SYSTEM_ACTIVITY_REASON_ID%TYPE,
  in_address1                   IN ADDRESS_HISTORY.ADDRESS1%TYPE,
  in_address2                   IN ADDRESS_HISTORY.ADDRESS2%TYPE,
  in_city                       IN ADDRESS_HISTORY.CITY%TYPE,
  in_state                      IN ADDRESS_HISTORY.STATE%TYPE,
  in_postal_code                IN ADDRESS_HISTORY.POSTAL_CODE%TYPE,
  in_country                    IN ADDRESS_HISTORY.COUNTRY%TYPE,
  in_created_by                 IN ADDRESS_HISTORY.CREATED_BY%TYPE,
  in_create_date                IN ADDRESS_HISTORY.CREATE_DATE%TYPE,
  in_updated_by                 IN ADDRESS_HISTORY.UPDATED_BY%TYPE,
  in_update_date                IN ADDRESS_HISTORY.UPDATE_DATE%TYPE
);

PROCEDURE CREATE_ACCOUNT_HISTORY (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V19.UNKNOWN_ERROR
*/
  in_account_id                 IN NUMBER,
  in_suspend_date               IN DATE,
  in_group_id                   IN NUMBER,
  in_created_by                 IN VARCHAR2,
  in_create_date                IN DATE,
  in_system_activity_reason_id  IN NUMBER,
  in_account_status_id          IN NUMBER,
  in_instrument_type_id         IN NUMBER,
  in_instrument_id              IN NUMBER
);

PROCEDURE CREATE_SUBSCRIPTION_HISTORY (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V19.UNKNOWN_ERROR
*/
  in_subscription_id           IN  NUMBER,
  in_account_id                IN NUMBER,
  in_purchase_date             IN DATE,
  in_offer_chain_id            IN NUMBER,
  in_suspend_date              IN DATE,
  in_termination_date          IN DATE,
  in_days_remaining_adjustment IN NUMBER,
  in_cancellation_type_id      IN NUMBER,
  in_created_by                IN  VARCHAR2,
  in_create_date               IN DATE,
  in_system_activity_reason_id IN  NUMBER
);

PROCEDURE CREATE_CREDIT_CARD_HISTORY (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V19.UNKNOWN_ERROR
*/
  in_credit_card_id             IN  NUMBER,
  in_account_id                 IN NUMBER,
  in_instrument_name            IN VARCHAR2,
  in_private_card_holder_name   IN VARCHAR2,
  in_private_street_address     IN VARCHAR2,
  in_private_street_address2    IN VARCHAR2,
  in_state                      IN VARCHAR2,
  in_city                       IN VARCHAR2,
  in_postal_code                IN VARCHAR2,
  in_country                    IN CHAR,
  in_last_four_cc               IN VARCHAR2,
  in_expiration_date            IN DATE,
  in_credit_card_type_id        IN NUMBER,
  in_secret_token               IN VARCHAR2,
  in_chase_profile_id           IN VARCHAR2,
  in_credit_card_status_id      IN NUMBER,
  in_created_by                 IN  VARCHAR2,
  in_create_date                IN DATE,
  in_system_activity_reason_id  IN  NUMBER
);

PROCEDURE CREATE_PAYPAL_HISTORY (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V19.UNKNOWN_ERROR
*/
  in_paypal_id                    IN NUMBER,
  in_account_id                   IN NUMBER,
  in_instrument_name              IN VARCHAR2,
  in_private_email_address        IN VARCHAR2,
  in_created_by                   IN VARCHAR2,
  in_create_date                  IN DATE,
  in_paypal_status_id             IN NUMBER,
  in_paypal_prvt_street_address   IN VARCHAR2,
  in_paypal_prvt_street_address2  IN VARCHAR2,
  in_state                        IN VARCHAR2,
  in_city                         IN VARCHAR2,
  in_postal_code                  IN VARCHAR2,
  in_country                      IN CHAR,
  in_expiration_date              IN DATE,
  in_system_activity_reason_id    IN NUMBER,
  in_secret_token                 IN VARCHAR2
);

PROCEDURE CREATE_TRANSACTION_HISTORY (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V19.UNKNOWN_ERROR
*/
  in_transaction_id            IN TRANSACTION_HISTORY.TRANSACTION_ID%TYPE,
  in_transaction_status_id     IN TRANSACTION_HISTORY.TRANSACTION_STATUS_ID%TYPE,
  in_transaction_amount        IN TRANSACTION_HISTORY.TRANSACTION_AMOUNT%TYPE,
  in_created_by                IN TRANSACTION_HISTORY.CREATED_BY%TYPE,
  in_create_date               IN TRANSACTION_HISTORY.CREATE_DATE%TYPE,
  in_system_activity_reason_id IN TRANSACTION_HISTORY.SYSTEM_ACTIVITY_REASON_ID%TYPE,
  in_order_id                  IN TRANSACTION_HISTORY.ORDER_ID%TYPE DEFAULT NULL,
  in_charge_id                 IN TRANSACTION_HISTORY.CHARGE_ID%TYPE DEFAULT NULL,
  in_is_refund                 IN TRANSACTION_HISTORY.IS_REFUND%TYPE DEFAULT NULL,
  in_is_settled                IN TRANSACTION_HISTORY.IS_SETTLED%TYPE DEFAULT NULL,
  in_transaction_type_code     IN TRANSACTION_HISTORY.TRANSACTION_TYPE_CODE%TYPE DEFAULT NULL
);

PROCEDURE CREATE_GIFT_CERT_HISTORY (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V19.UNKNOWN_ERROR
*/
  in_gift_certificate_id        IN NUMBER,
  in_purchaser_group_id         IN NUMBER,
  in_purchase_invoice_id        IN NUMBER,
  in_offer_chain_id             IN NUMBER,
  in_expiration_date            IN DATE,
  in_purchase_date              IN DATE,
  in_gift_certificate_status_id IN NUMBER,
  in_code                       IN VARCHAR2,
  in_created_by                 IN VARCHAR2,
  in_create_date                IN DATE,
  in_system_activity_reason_id  IN NUMBER,
  in_recipient_name             IN VARCHAR2,
  in_gift_message               IN VARCHAR2,
  in_recipient_email            IN VARCHAR2,
  in_finalized_invoice_id       IN NUMBER,
  in_sender_email               IN VARCHAR2,
  in_sender_name                IN VARCHAR2,
  in_redemption_date            IN DATE,
  in_redeemer_group_id          IN NUMBER,
  in_cancelation_date           IN DATE,
  in_recipient_address_id       IN NUMBER,
  in_redeemer_address_id        IN NUMBER,
  in_recipient_notify_date      IN DATE
);

PROCEDURE CREATE_INVOICE_HISTORY (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V19.UNKNOWN_ERROR
*/
  in_invoice_id                IN NUMBER,
  in_invoice_status_id         IN NUMBER,
  in_created_by                IN VARCHAR2,
  in_create_date               IN DATE,
  in_system_activity_reason_id IN NUMBER
);

PROCEDURE CREATE_LICENSE_HISTORY (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V19.UNKNOWN_ERROR
*/
  in_license_id                IN NUMBER,
  in_license_status_id         IN NUMBER,
  in_needs_entitlements        IN NUMBER,
  in_start_date                IN DATE,
  in_offer_id                  IN NUMBER,
  in_subscription_id           IN NUMBER,
  in_invoice_id                IN NUMBER,
  in_end_date                  IN DATE,
  in_created_by                IN VARCHAR2,
  in_create_date               IN DATE,
  in_is_extension              IN NUMBER,
  in_current_offer_index       IN NUMBER,
  in_current_offer_recurr_num  IN NUMBER,
  in_system_activity_reason_id IN NUMBER,
  in_entitlement_end_date      IN DATE,
  in_grace_start_date          IN DATE,
  in_grace_end_date            IN DATE
);

PROCEDURE CREATE_CHARGE_HISTORY (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V19.UNKNOWN_ERROR
*/
  in_charge_id                 IN NUMBER,
  in_invoice_id                IN NUMBER,
  in_transaction_id            IN NUMBER,
  in_instrument_type_id        IN NUMBER,
  in_instrument_id             IN NUMBER,
  in_charge_amount             IN NUMBER,
  in_created_by                IN VARCHAR2,
  in_create_date               IN DATE,
  in_charge_status_id          IN NUMBER,
  in_system_activity_reason_id IN NUMBER
);

PROCEDURE CREATE_ITUNES_RECEIPT_HISTORY (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V19.UNKNOWN_ERROR
*/
/*
CREATE TABLE ITUNES_RECEIPT (
  id NUMBER NOT NULL ENABLE,
  subscription_id NUMBER NOT NULL ENABLE,
  receipt VARCHAR(1024) NOT NULL ENABLE,
  status NUMBER,
  quantity NUMBER,
  product_id VARCHAR(1024),
  transaction_id VARCHAR(1024),
  purchase_date TIMESTAMP,
  original_transaction_id VARCHAR(1024),
  original_purchase_date TIMESTAMP,
  app_item_id VARCHAR(1024),
  version_external_id NUMBER,
  bid VARCHAR(1024),
  bvrs VARCHAR(255),
  expires_date TIMESTAMP,
  create_date DATE NOT NULL,
  created_by VARCHAR(255) NOT NULL,
  update_date DATE NOT NULL,
  updated_by VARCHAR(255) NOT NULL,
  last_check_date DATE NOT NULL,
  CONSTRAINT "ITUNESRECEIPT_PK" PRIMARY KEY ("ID") USING INDEX TABLESPACE "CORE_IDX" ENABLE,
  CONSTRAINT "ITUNESRECEIPT_SUBID_FK" FOREIGN KEY ("SUBSCRIPTION_ID") REFERENCES SUBSCRIPTION(ID) USING INDEX TABLESPACE "CORE_IDX" ENABLE,
  CONSTRAINT "ITUNESRECEIPT_RECEIPT_UK" UNIQUE(receipt) USING INDEX TABLESPACE "CORE_IDX" ENABLE,
  CONSTRAINT "ITUNESRECEIPT_SUBID_UK" UNIQUE(subscription_id) USING INDEX TABLESPACE "CORE_IDX" ENABLE
)
TABLESPACE CORE;
*/
  in_id               IN CORE_HIST_OWNER.ITUNES_RECEIPT_HISTORY.ID%TYPE,
  in_subscription_id  IN CORE_HIST_OWNER.ITUNES_RECEIPT_HISTORY.SUBSCRIPTION_ID%TYPE,
  in_receipt          IN CORE_HIST_OWNER.ITUNES_RECEIPT_HISTORY.RECEIPT%TYPE,
  in_status           IN CORE_HIST_OWNER.ITUNES_RECEIPT_HISTORY.STATUS%TYPE,
  in_quantity         IN CORE_HIST_OWNER.ITUNES_RECEIPT_HISTORY.QUANTITY%TYPE,
  in_product_id       IN CORE_HIST_OWNER.ITUNES_RECEIPT_HISTORY.PRODUCT_ID%TYPE,
  in_transaction_id   IN CORE_HIST_OWNER.ITUNES_RECEIPT_HISTORY.TRANSACTION_ID%TYPE,
  in_purchase_date    IN CORE_HIST_OWNER.ITUNES_RECEIPT_HISTORY.PURCHASE_DATE%TYPE,
  in_original_transaction_id IN CORE_HIST_OWNER.ITUNES_RECEIPT_HISTORY.ORIGINAL_TRANSACTION_ID%TYPE,
  in_original_purchase_date IN CORE_HIST_OWNER.ITUNES_RECEIPT_HISTORY.ORIGINAL_PURCHASE_DATE%TYPE,
  in_app_item_id      IN CORE_HIST_OWNER.ITUNES_RECEIPT_HISTORY.APP_ITEM_ID%TYPE,
  in_version_external_id IN CORE_HIST_OWNER.ITUNES_RECEIPT_HISTORY.VERSION_EXTERNAL_ID%TYPE,
  in_bid              IN CORE_HIST_OWNER.ITUNES_RECEIPT_HISTORY.BID%TYPE,
  in_bvrs             IN CORE_HIST_OWNER.ITUNES_RECEIPT_HISTORY.BVRS%TYPE,
  in_expires_date     IN CORE_HIST_OWNER.ITUNES_RECEIPT_HISTORY.EXPIRES_DATE%TYPE,
  in_create_date      IN CORE_HIST_OWNER.ITUNES_RECEIPT_HISTORY.CREATE_DATE%TYPE,
  in_created_by       IN CORE_HIST_OWNER.ITUNES_RECEIPT_HISTORY.CREATED_BY%TYPE,
  in_update_date      IN CORE_HIST_OWNER.ITUNES_RECEIPT_HISTORY.UPDATE_DATE%TYPE,
  in_updated_by       IN CORE_HIST_OWNER.ITUNES_RECEIPT_HISTORY.UPDATED_BY%TYPE,
  in_last_check_date  IN CORE_HIST_OWNER.ITUNES_RECEIPT_HISTORY.LAST_CHECK_DATE%TYPE,
  in_cancel_date      IN CORE_HIST_OWNER.ITUNES_RECEIPT_HISTORY.CANCEL_DATE%TYPE
);

PROCEDURE CREATE_INVOICE_ADJ_HISTORY (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V19.UNKNOWN_ERROR
*/
  in_invoice_adjustment_id     IN CORE_HIST_OWNER.INVOICE_ADJUSTMENT_HISTORY.INVOICE_ADJUSTMENT_ID%TYPE,
  in_invoice_id                IN CORE_HIST_OWNER.INVOICE_ADJUSTMENT_HISTORY.INVOICE_ID%TYPE,
  in_is_credit                 IN CORE_HIST_OWNER.INVOICE_ADJUSTMENT_HISTORY.IS_CREDIT%TYPE,
  in_charge_id                 IN CORE_HIST_OWNER.INVOICE_ADJUSTMENT_HISTORY.CHARGE_ID%TYPE,
  in_adjustment_date           IN CORE_HIST_OWNER.INVOICE_ADJUSTMENT_HISTORY.ADJUSTMENT_DATE%TYPE,
  in_create_date               IN CORE_HIST_OWNER.INVOICE_ADJUSTMENT_HISTORY.CREATE_DATE%TYPE,
  in_created_by                IN CORE_HIST_OWNER.INVOICE_ADJUSTMENT_HISTORY.CREATED_BY%TYPE,
  in_invoice_adj_reason_id     IN CORE_HIST_OWNER.INVOICE_ADJUSTMENT_HISTORY.INVOICE_ADJUSTMENT_REASON_ID%TYPE,
  in_update_date                IN CORE_HIST_OWNER.INVOICE_ADJUSTMENT_HISTORY.UPDATE_DATE%TYPE,
  in_updated_by                IN CORE_HIST_OWNER.INVOICE_ADJUSTMENT_HISTORY.UPDATED_BY%TYPE
);

PROCEDURE CREATE_NOTIFICATION_HISTORY (
  /*
  Throws exceptions:
  APP_EXCEPTION_CODES_V19.UNKNOWN_ERROR
  */
  in_notification_id            IN NUMBER,
  in_account_id                 IN NUMBER,
  in_group_id                   IN NUMBER,
  notification_reason_type_id   IN NUMBER,
  notification_status_id        IN NUMBER,
  email_template_params         IN CLOB,
  in_create_date                IN DATE,
  in_date_to_notify             IN DATE
);

PROCEDURE CREATE_NOTIF_FAILURE_HISTORY (
  /*
  Throws exceptions:
  APP_EXCEPTION_CODES_V19.UNKNOWN_ERROR
  */
  in_error_messgae         IN VARCHAR2,
  in_notification_id       IN NUMBER,
  in_create_date           IN DATE
);

END PROCS_HISTORY_V19;
.
/

CREATE OR REPLACE PACKAGE BODY "PROCS_HISTORY_V19" AS

PROCEDURE CREATE_ADDRESS_HISTORY (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V19.UNKNOWN_ERROR
*/
  in_address_id                 IN ADDRESS_HISTORY.ADDRESS_ID%TYPE,
  in_system_activity_reason_id  IN ADDRESS_HISTORY.SYSTEM_ACTIVITY_REASON_ID%TYPE,
  in_address1                   IN ADDRESS_HISTORY.ADDRESS1%TYPE,
  in_address2                   IN ADDRESS_HISTORY.ADDRESS2%TYPE,
  in_city                       IN ADDRESS_HISTORY.CITY%TYPE,
  in_state                      IN ADDRESS_HISTORY.STATE%TYPE,
  in_postal_code                IN ADDRESS_HISTORY.POSTAL_CODE%TYPE,
  in_country                    IN ADDRESS_HISTORY.COUNTRY%TYPE,
  in_created_by                 IN ADDRESS_HISTORY.CREATED_BY%TYPE,
  in_create_date                IN ADDRESS_HISTORY.CREATE_DATE%TYPE,
  in_updated_by                 IN ADDRESS_HISTORY.UPDATED_BY%TYPE,
  in_update_date                IN ADDRESS_HISTORY.UPDATE_DATE%TYPE
) AS
SPROC_NAME CONSTANT VARCHAR2(22) := 'CREATE_ADDRESS_HISTORY';
BEGIN

  INSERT INTO
    ADDRESS_HISTORY (
    ADDRESS_ID,
    SYSTEM_ACTIVITY_REASON_ID,
    ADDRESS1,
    ADDRESS2,
    CITY,
    STATE,
    POSTAL_CODE,
    COUNTRY,
    CREATED_BY,
    CREATE_DATE,
    UPDATED_BY,
    UPDATE_DATE
  ) VALUES (
    in_address_id,
    in_system_activity_reason_id,
    in_address1,
    in_address2,
    in_city,
    in_state,
    in_postal_code,
    in_country,
    in_created_by,
    in_create_date,
    in_updated_by,
    in_update_date
  );

EXCEPTION
WHEN OTHERS THEN
  RAISE_APPLICATION_ERROR(CORE_OWNER.APP_EXCEPTION_CODES_V19.UNKNOWN_ERROR,
    SPROC_NAME||': Unknown error: '||SQLERRM);
END CREATE_ADDRESS_HISTORY;

/******************************************************************************/

PROCEDURE CREATE_ACCOUNT_HISTORY (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V19.UNKNOWN_ERROR
*/
  in_account_id                 IN NUMBER,
  in_suspend_date               IN DATE,
  in_group_id                   IN NUMBER,
  in_created_by                 IN VARCHAR2,
  in_create_date                IN DATE,
  in_system_activity_reason_id  IN NUMBER,
  in_account_status_id          IN NUMBER,
  in_instrument_type_id         IN NUMBER,
  in_instrument_id              IN NUMBER
) AS
SPROC_NAME CONSTANT VARCHAR2(22) := 'CREATE_ACCOUNT_HISTORY';
BEGIN

  INSERT INTO
    ACCOUNT_HISTORY (
    ACCOUNT_ID,
    SUSPEND_DATE,
    GROUP_ID,
    CREATE_DATE,
    CREATED_BY,
    SYSTEM_ACTIVITY_REASON_ID,
    ACCOUNT_STATUS_ID,
    INSTRUMENT_TYPE_ID,
    INSTRUMENT_ID
  ) VALUES (
    in_account_id,
    in_suspend_date,
    in_group_id,
    in_create_date,
    in_created_by,
    in_system_activity_reason_id,
    in_account_status_id,
    in_instrument_type_id,
    in_instrument_id
  );
  
EXCEPTION
WHEN OTHERS THEN
  RAISE_APPLICATION_ERROR(CORE_OWNER.APP_EXCEPTION_CODES_V19.UNKNOWN_ERROR,
    SPROC_NAME||': Unknown error: '||SQLERRM);
END CREATE_ACCOUNT_HISTORY;

/******************************************************************************/

PROCEDURE CREATE_SUBSCRIPTION_HISTORY (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V19.UNKNOWN_ERROR
*/
  in_subscription_id           IN  NUMBER,
  in_account_id                IN NUMBER,
  in_purchase_date             IN DATE,
  in_offer_chain_id            IN NUMBER,
  in_suspend_date              IN DATE,
  in_termination_date          IN DATE,
  in_days_remaining_adjustment IN NUMBER,
  in_cancellation_type_id      IN NUMBER,
  in_created_by                IN  VARCHAR2,
  in_create_date               IN DATE,
  in_system_activity_reason_id IN  NUMBER
) AS
SPROC_NAME CONSTANT VARCHAR2(27) := 'CREATE_SUBSCRIPTION_HISTORY';
BEGIN

  INSERT INTO SUBSCRIPTION_HISTORY (
    SUBSCRIPTION_ID,
    ACCOUNT_ID,
    PURCHASE_DATE,
    OFFER_CHAIN_ID,
    SUSPEND_DATE,
    TERMINATION_DATE,
    DAYS_REMAINING_ADJUSTMENT,
    CANCELLATION_TYPE_ID,
    CREATE_DATE,
    CREATED_BY,
    SYSTEM_ACTIVITY_REASON_ID
  ) VALUES (
    in_subscription_id,
    in_account_id,
    in_purchase_date,
    in_offer_chain_id,
    in_suspend_date,
    in_termination_date,
    in_days_remaining_adjustment,
    in_cancellation_type_id,
    in_create_date,
    in_created_by,
    in_system_activity_reason_id
  );

EXCEPTION
WHEN OTHERS THEN
  RAISE_APPLICATION_ERROR(CORE_OWNER.APP_EXCEPTION_CODES_V19.UNKNOWN_ERROR,
    SPROC_NAME||': Unknown error: '||SQLERRM);
END CREATE_SUBSCRIPTION_HISTORY;

/******************************************************************************/

PROCEDURE CREATE_CREDIT_CARD_HISTORY (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V19.UNKNOWN_ERROR
*/
  in_credit_card_id             IN  NUMBER,
  in_account_id                 IN NUMBER,
  in_instrument_name            IN VARCHAR2,
  in_private_card_holder_name   IN VARCHAR2,
  in_private_street_address     IN VARCHAR2,
  in_private_street_address2    IN VARCHAR2,
  in_state                      IN VARCHAR2,
  in_city                       IN VARCHAR2,
  in_postal_code                IN VARCHAR2,
  in_country                    IN CHAR,
  in_last_four_cc               IN VARCHAR2,
  in_expiration_date            IN DATE,
  in_credit_card_type_id        IN NUMBER,
  in_secret_token               IN VARCHAR2,
  in_chase_profile_id           IN VARCHAR2,
  in_credit_card_status_id      IN NUMBER,
  in_created_by                 IN  VARCHAR2,
  in_create_date                IN DATE,
  in_system_activity_reason_id  IN  NUMBER
) AS
SPROC_NAME CONSTANT VARCHAR2(26) := 'CREATE_CREDIT_CARD_HISTORY';
BEGIN

  INSERT INTO CREDIT_CARD_HISTORY (
    CREDIT_CARD_ID,
    ACCOUNT_ID,
    INSTRUMENT_NAME,
    PRIVATE_CARD_HOLDER_NAME,
    PRIVATE_STREET_ADDRESS,
    PRIVATE_STREET_ADDRESS2,
    STATE,
    CITY,
    POSTAL_CODE,
    COUNTRY,
    LAST_FOUR_CC,
    EXPIRATION_DATE,
    CREDIT_CARD_TYPE_ID,
    SECRET_TOKEN,
    CHASE_PROFILE_ID,
    CREATE_DATE,
    CREATED_BY,
    SYSTEM_ACTIVITY_REASON_ID,
    CREDIT_CARD_STATUS_ID
  ) VALUES (
    in_credit_card_id,
    in_account_id,
    in_instrument_name,
    in_private_card_holder_name,
    in_private_street_address,
    in_private_street_address2,
    in_state,
    in_city,
    in_postal_code,
    in_country,
    in_last_four_cc,
    in_expiration_date,
    in_credit_card_type_id,
    in_secret_token,
    in_chase_profile_id,
    in_create_date,
    in_created_by,
    in_system_activity_reason_id,
    in_credit_card_status_id
  );

EXCEPTION
WHEN OTHERS THEN
  RAISE_APPLICATION_ERROR(CORE_OWNER.APP_EXCEPTION_CODES_V19.UNKNOWN_ERROR,
    SPROC_NAME||': Unknown error: '||SQLERRM);
END CREATE_CREDIT_CARD_HISTORY;

/******************************************************************************/

PROCEDURE CREATE_PAYPAL_HISTORY (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V19.UNKNOWN_ERROR
*/
  in_paypal_id                    IN NUMBER,
  in_account_id                   IN NUMBER,
  in_instrument_name              IN VARCHAR2,
  in_private_email_address        IN VARCHAR2,
  in_created_by                   IN VARCHAR2,
  in_create_date                  IN DATE,
  in_paypal_status_id             IN NUMBER,
  in_paypal_prvt_street_address   IN VARCHAR2,
  in_paypal_prvt_street_address2  IN VARCHAR2,
  in_state                        IN VARCHAR2,
  in_city                         IN VARCHAR2,
  in_postal_code                  IN VARCHAR2,
  in_country                      IN CHAR,
  in_expiration_date              IN DATE,
  in_system_activity_reason_id    IN NUMBER,
  in_secret_token                 IN VARCHAR2
) AS
SPROC_NAME CONSTANT VARCHAR2(21) := 'CREATE_PAYPAL_HISTORY';
BEGIN
  
  INSERT INTO PAYPAL_HISTORY(
      PAYPAL_ID,
      ACCOUNT_ID,
      INSTRUMENT_NAME,
      PRIVATE_EMAIL_ADDRESS,
      CREATE_DATE,
      CREATED_BY,
      PAYPAL_STATUS_ID,
      PRIVATE_STREET_ADDRESS,
      PRIVATE_STREET_ADDRESS2,
      STATE,
      CITY,
      POSTAL_CODE,
      COUNTRY,
      EXPIRATION_DATE,
      SYSTEM_ACTIVITY_REASON_ID,
      SECRET_TOKEN
    ) VALUES (
      in_paypal_id,
      in_account_id,
      in_instrument_name,
      in_private_email_address,
      in_create_date,
      in_created_by,
      in_paypal_status_id,
      in_paypal_prvt_street_address,
      in_paypal_prvt_street_address2,
      in_state,
      in_city,
      in_postal_code,
      in_country,
      in_expiration_date,
      in_system_activity_reason_id,
      in_secret_token
    );
  
EXCEPTION
WHEN OTHERS THEN
  RAISE_APPLICATION_ERROR(CORE_OWNER.APP_EXCEPTION_CODES_V19.UNKNOWN_ERROR,
    SPROC_NAME||': Unknown error: '||SQLERRM);
END;

/******************************************************************************/

PROCEDURE CREATE_TRANSACTION_HISTORY (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V19.UNKNOWN_ERROR
*/
  in_transaction_id            IN TRANSACTION_HISTORY.TRANSACTION_ID%TYPE,
  in_transaction_status_id     IN TRANSACTION_HISTORY.TRANSACTION_STATUS_ID%TYPE,
  in_transaction_amount        IN TRANSACTION_HISTORY.TRANSACTION_AMOUNT%TYPE,
  in_created_by                IN TRANSACTION_HISTORY.CREATED_BY%TYPE,
  in_create_date               IN TRANSACTION_HISTORY.CREATE_DATE%TYPE,
  in_system_activity_reason_id IN TRANSACTION_HISTORY.SYSTEM_ACTIVITY_REASON_ID%TYPE,
  in_order_id                  IN TRANSACTION_HISTORY.ORDER_ID%TYPE DEFAULT NULL,
  in_charge_id                 IN TRANSACTION_HISTORY.CHARGE_ID%TYPE DEFAULT NULL,
  in_is_refund                 IN TRANSACTION_HISTORY.IS_REFUND%TYPE DEFAULT NULL,
  in_is_settled                IN TRANSACTION_HISTORY.IS_SETTLED%TYPE DEFAULT NULL,
  in_transaction_type_code     IN TRANSACTION_HISTORY.TRANSACTION_TYPE_CODE%TYPE DEFAULT NULL
) AS
SPROC_NAME CONSTANT VARCHAR2(26) := 'CREATE_TRANSACTION_HISTORY';
BEGIN

  INSERT INTO TRANSACTION_HISTORY (
    TRANSACTION_ID,
    TRANSACTION_STATUS_ID,
    TRANSACTION_AMOUNT,
    CREATE_DATE,
    CREATED_BY,
    ORDER_ID,
    CHARGE_ID,
    IS_REFUND,
    IS_SETTLED,
    TRANSACTION_TYPE_CODE,
    SYSTEM_ACTIVITY_REASON_ID
  ) VALUES (
    in_transaction_id,
    in_transaction_status_id,
    in_transaction_amount,
    in_create_date,
    in_created_by,
    in_order_id,
    in_charge_id,
    in_is_refund,
    in_is_settled,
    in_transaction_type_code,
    in_system_activity_reason_id
  );

EXCEPTION
WHEN OTHERS THEN
  RAISE_APPLICATION_ERROR(CORE_OWNER.APP_EXCEPTION_CODES_V19.UNKNOWN_ERROR,
    SPROC_NAME||': Unknown error: '||SQLERRM);
END CREATE_TRANSACTION_HISTORY;

/******************************************************************************/

PROCEDURE CREATE_GIFT_CERT_HISTORY (
  in_gift_certificate_id        IN NUMBER,
  in_purchaser_group_id         IN NUMBER,
  in_purchase_invoice_id        IN NUMBER,
  in_offer_chain_id             IN NUMBER,
  in_expiration_date            IN DATE,
  in_purchase_date              IN DATE,
  in_gift_certificate_status_id IN NUMBER,
  in_code                       IN VARCHAR2,
  in_created_by                 IN VARCHAR2,
  in_create_date                IN DATE,
  in_system_activity_reason_id  IN NUMBER,
  in_recipient_name             IN VARCHAR2,
  in_gift_message               IN VARCHAR2,
  in_recipient_email            IN VARCHAR2,
  in_finalized_invoice_id       IN NUMBER,
  in_sender_email               IN VARCHAR2,
  in_sender_name                IN VARCHAR2,
  in_redemption_date            IN DATE,
  in_redeemer_group_id          IN NUMBER,
  in_cancelation_date           IN DATE,
  in_recipient_address_id       IN NUMBER,
  in_redeemer_address_id        IN NUMBER,
  in_recipient_notify_date      IN DATE
) AS
SPROC_NAME CONSTANT VARCHAR2(24) := 'CREATE_GIFT_CERT_HISTORY';
BEGIN
  
  INSERT INTO GIFT_CERTIFICATE_HISTORY (
    GIFT_CERTIFICATE_ID,
    PURCHASER_GROUP_ID,
    PURCHASE_INVOICE_ID,
    OFFER_CHAIN_ID,
    EXPIRATION_DATE,
    PURCHASE_DATE,
    GIFT_CERTIFICATE_STATUS_ID,
    CODE,
    CREATE_DATE,
    CREATED_BY,
    SYSTEM_ACTIVITY_REASON_ID,
    RECIPIENT_NAME,
    GIFT_MESSAGE,
    RECIPIENT_EMAIL,
    FINALIZED_INVOICE_ID,
    SENDER_EMAIL,
    SENDER_NAME,
    REDEMPTION_DATE,
    REDEEMER_GROUP_ID,
    CANCELATION_DATE,
    RECIPIENT_ADDRESS_ID,
    REDEEMER_ADDRESS_ID,
    RECIPIENT_NOTIFY_DATE
  ) VALUES (
    in_gift_certificate_id,
    in_purchaser_group_id,
    in_purchase_invoice_id,
    in_offer_chain_id,
    in_expiration_date,
    in_purchase_date,
    in_gift_certificate_status_id,
    in_code,
    in_create_date,
    in_created_by,
    in_system_activity_reason_id,
    in_recipient_name,
    in_gift_message,
    in_recipient_email,
    in_finalized_invoice_id,
    in_sender_email,
    in_sender_name,
    in_redemption_date,
    in_redeemer_group_id,
    in_cancelation_date,
    in_recipient_address_id,
    in_redeemer_address_id,
    in_recipient_notify_date
  );
  
EXCEPTION
WHEN OTHERS THEN
  RAISE_APPLICATION_ERROR(CORE_OWNER.APP_EXCEPTION_CODES_V19.UNKNOWN_ERROR,
    SPROC_NAME||': Unknown error: '||SQLERRM);
END CREATE_GIFT_CERT_HISTORY;

/******************************************************************************/

PROCEDURE CREATE_INVOICE_HISTORY (
  in_invoice_id                IN NUMBER,
  in_invoice_status_id         IN NUMBER,
  in_created_by                IN VARCHAR2,
  in_create_date               IN DATE,
  in_system_activity_reason_id IN NUMBER
) AS
SPROC_NAME CONSTANT VARCHAR2(22) := 'CREATE_INVOICE_HISTORY';
BEGIN
  
  INSERT INTO INVOICE_HISTORY (
    INVOICE_ID,
    INVOICE_STATUS_ID,
    CREATE_DATE,
    CREATED_BY,
    SYSTEM_ACTIVITY_REASON_ID
  ) VALUES (
    in_invoice_id,
    in_invoice_status_id,
    in_create_date,
    in_created_by,
    in_system_activity_reason_id
  );
  
EXCEPTION
WHEN OTHERS THEN
  RAISE_APPLICATION_ERROR(CORE_OWNER.APP_EXCEPTION_CODES_V19.UNKNOWN_ERROR,
    SPROC_NAME||': Unknown error: '||SQLERRM);
END CREATE_INVOICE_HISTORY;

/******************************************************************************/

PROCEDURE CREATE_LICENSE_HISTORY (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V19.UNKNOWN_ERROR
*/
  in_license_id                IN NUMBER,
  in_license_status_id         IN NUMBER,
  in_needs_entitlements        IN NUMBER,
  in_start_date                IN DATE,
  in_offer_id                  IN NUMBER,
  in_subscription_id           IN NUMBER,
  in_invoice_id                IN NUMBER,
  in_end_date                  IN DATE,
  in_created_by                IN VARCHAR2,
  in_create_date               IN DATE,
  in_is_extension              IN NUMBER,
  in_current_offer_index       IN NUMBER,
  in_current_offer_recurr_num  IN NUMBER,
  in_system_activity_reason_id IN NUMBER,
  in_entitlement_end_date      IN DATE,
  in_grace_start_date          IN DATE,
  in_grace_end_date            IN DATE
) AS
SPROC_NAME CONSTANT VARCHAR2(22) := 'CREATE_LICENSE_HISTORY';
BEGIN
  
  INSERT INTO LICENSE_HISTORY (
    LICENSE_ID,
    LICENSE_STATUS_ID,
    START_DATE,
    OFFER_ID,
    SUBSCRIPTION_ID,
    INVOICE_ID,
    END_DATE,
    CREATE_DATE,
    CREATED_BY,
    IS_EXTENSION,
    CURRENT_OFFER_INDEX,
    CURRENT_OFFER_RECURR_NUM,
    SYSTEM_ACTIVITY_REASON_ID,
    NEEDS_ENTITLEMENTS,
    ENTITLEMENT_END_DATE,
    GRACE_START_DATE,
    GRACE_END_DATE
  ) VALUES (
    in_license_id,
    in_license_status_id,
    in_start_date,
    in_offer_id,
    in_subscription_id,
    in_invoice_id,
    in_end_date,
    in_create_date,
    in_created_by,
    in_is_extension,
    in_current_offer_index,
    in_current_offer_recurr_num,
    in_system_activity_reason_id,
    in_needs_entitlements,
    in_entitlement_end_date,
    in_grace_start_date,
    in_grace_end_date
  );
  
EXCEPTION
WHEN OTHERS THEN
  RAISE_APPLICATION_ERROR(CORE_OWNER.APP_EXCEPTION_CODES_V19.UNKNOWN_ERROR,
    SPROC_NAME||': Unknown error: '||SQLERRM);
END CREATE_LICENSE_HISTORY;

/******************************************************************************/

PROCEDURE CREATE_CHARGE_HISTORY (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V19.UNKNOWN_ERROR
*/
  in_charge_id                 IN NUMBER,
  in_invoice_id                IN NUMBER,
  in_transaction_id            IN NUMBER,
  in_instrument_type_id        IN NUMBER,
  in_instrument_id             IN NUMBER,
  in_charge_amount             IN NUMBER,
  in_created_by                IN VARCHAR2,
  in_create_date               IN DATE,
  in_charge_status_id          IN NUMBER,
  in_system_activity_reason_id IN NUMBER
) AS
SPROC_NAME CONSTANT VARCHAR2(21) := 'CREATE_CHARGE_HISTORY';
BEGIN

  INSERT INTO CHARGE_HISTORY (
    CHARGE_ID,
    INVOICE_ID,
    TRANSACTION_ID,
    INSTRUMENT_TYPE_ID,
    INSTRUMENT_ID,
    CHARGE_AMOUNT,
    CREATE_DATE,
    CREATED_BY,
    CHARGE_STATUS_ID,
    SYSTEM_ACTIVITY_REASON_ID
  ) VALUES (
    in_charge_id,
    in_invoice_id,
    in_transaction_id,
    in_instrument_type_id,
    in_instrument_id,
    in_charge_amount,
    in_create_date,
    in_created_by,
    in_charge_status_id,
    in_system_activity_reason_id
  );

EXCEPTION
WHEN OTHERS THEN
  RAISE_APPLICATION_ERROR(CORE_OWNER.APP_EXCEPTION_CODES_V19.UNKNOWN_ERROR,
    SPROC_NAME||': Unknown error: '||SQLERRM);
END;


PROCEDURE CREATE_ITUNES_RECEIPT_HISTORY (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V19.UNKNOWN_ERROR
*/
/*
CREATE TABLE ITUNES_RECEIPT (
  id NUMBER NOT NULL ENABLE,
  subscription_id NUMBER NOT NULL ENABLE,
  receipt VARCHAR(1024) NOT NULL ENABLE,
  status NUMBER,
  quantity NUMBER,
  product_id VARCHAR(1024),
  transaction_id VARCHAR(1024),
  purchase_date TIMESTAMP,
  original_transaction_id VARCHAR(1024),
  app_item_id VARCHAR(1024),
  version_external_id NUMBER,
  bid VARCHAR(1024),
  bvrs VARCHAR(255),
  expires_date TIMESTAMP,
  create_date DATE NOT NULL,
  created_by VARCHAR(255) NOT NULL,
  update_date DATE NOT NULL,
  updated_by VARCHAR(255) NOT NULL,
  last_check_date DATE NOT NULL,
  CONSTRAINT "ITUNESRECEIPT_PK" PRIMARY KEY ("ID") USING INDEX TABLESPACE "CORE_IDX" ENABLE,
  CONSTRAINT "ITUNESRECEIPT_SUBID_FK" FOREIGN KEY ("SUBSCRIPTION_ID") REFERENCES SUBSCRIPTION(ID) USING INDEX TABLESPACE "CORE_IDX" ENABLE,
  CONSTRAINT "ITUNESRECEIPT_RECEIPT_UK" UNIQUE(receipt) USING INDEX TABLESPACE "CORE_IDX" ENABLE,
  CONSTRAINT "ITUNESRECEIPT_SUBID_UK" UNIQUE(subscription_id) USING INDEX TABLESPACE "CORE_IDX" ENABLE
)
TABLESPACE CORE;
*/
  in_id               IN CORE_HIST_OWNER.ITUNES_RECEIPT_HISTORY.ID%TYPE,
  in_subscription_id  IN CORE_HIST_OWNER.ITUNES_RECEIPT_HISTORY.SUBSCRIPTION_ID%TYPE,
  in_receipt          IN CORE_HIST_OWNER.ITUNES_RECEIPT_HISTORY.RECEIPT%TYPE,
  in_status           IN CORE_HIST_OWNER.ITUNES_RECEIPT_HISTORY.STATUS%TYPE,
  in_quantity         IN CORE_HIST_OWNER.ITUNES_RECEIPT_HISTORY.QUANTITY%TYPE,
  in_product_id       IN CORE_HIST_OWNER.ITUNES_RECEIPT_HISTORY.PRODUCT_ID%TYPE,
  in_transaction_id   IN CORE_HIST_OWNER.ITUNES_RECEIPT_HISTORY.TRANSACTION_ID%TYPE,
  in_purchase_date    IN CORE_HIST_OWNER.ITUNES_RECEIPT_HISTORY.PURCHASE_DATE%TYPE,
  in_original_transaction_id IN CORE_HIST_OWNER.ITUNES_RECEIPT_HISTORY.ORIGINAL_TRANSACTION_ID%TYPE,
  in_original_purchase_date IN CORE_HIST_OWNER.ITUNES_RECEIPT_HISTORY.ORIGINAL_PURCHASE_DATE%TYPE,
  in_app_item_id      IN CORE_HIST_OWNER.ITUNES_RECEIPT_HISTORY.APP_ITEM_ID%TYPE,
  in_version_external_id IN CORE_HIST_OWNER.ITUNES_RECEIPT_HISTORY.VERSION_EXTERNAL_ID%TYPE,
  in_bid              IN CORE_HIST_OWNER.ITUNES_RECEIPT_HISTORY.BID%TYPE,
  in_bvrs             IN CORE_HIST_OWNER.ITUNES_RECEIPT_HISTORY.BVRS%TYPE,
  in_expires_date     IN CORE_HIST_OWNER.ITUNES_RECEIPT_HISTORY.EXPIRES_DATE%TYPE,
  in_create_date      IN CORE_HIST_OWNER.ITUNES_RECEIPT_HISTORY.CREATE_DATE%TYPE,
  in_created_by       IN CORE_HIST_OWNER.ITUNES_RECEIPT_HISTORY.CREATED_BY%TYPE,
  in_update_date      IN CORE_HIST_OWNER.ITUNES_RECEIPT_HISTORY.UPDATE_DATE%TYPE,
  in_updated_by       IN CORE_HIST_OWNER.ITUNES_RECEIPT_HISTORY.UPDATED_BY%TYPE,
  in_last_check_date  IN CORE_HIST_OWNER.ITUNES_RECEIPT_HISTORY.LAST_CHECK_DATE%TYPE,
  in_cancel_date      IN CORE_HIST_OWNER.ITUNES_RECEIPT_HISTORY.CANCEL_DATE%TYPE
) AS
BEGIN
  INSERT INTO CORE_HIST_OWNER.ITUNES_RECEIPT_HISTORY
  (
        id,
        subscription_id,
        receipt,
        status,
        quantity,
        product_id,
        transaction_id,
        purchase_date,
        original_transaction_id,
        original_purchase_date,
        app_item_id,
        version_external_id,
        bid,
        bvrs,
        expires_date,
        create_date,
        created_by,
        update_date,
        updated_by,
        last_check_date,
        cancel_date,
        history_date
  )
  VALUES
  (
        in_id,
        in_subscription_id,
        in_receipt,
        in_status,
        in_quantity,
        in_product_id,
        in_transaction_id,
        in_purchase_date,
        in_original_transaction_id,
        in_original_purchase_date,
        in_app_item_id,
        in_version_external_id,
        in_bid,
        in_bvrs,
        in_expires_date,
        in_create_date,
        in_created_by,
        in_update_date,
        in_updated_by,
        in_last_check_date,
        in_cancel_date,
        sysdate
  );
END CREATE_ITUNES_RECEIPT_HISTORY;

PROCEDURE CREATE_NOTIFICATION_HISTORY (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V19.UNKNOWN_ERROR
*/
  in_notification_id            IN NUMBER,
  in_account_id                 IN NUMBER,
  in_group_id                   IN NUMBER,
  notification_reason_type_id   IN NUMBER,
  notification_status_id        IN NUMBER,
  email_template_params         IN CLOB,
  in_create_date                IN DATE,
  in_date_to_notify             IN DATE
) AS
  SPROC_NAME CONSTANT VARCHAR2(27) := 'CREATE_NOTIFICATION_HISTORY';
BEGIN

   INSERT INTO NOTIFICATION_HISTORY (
          ID,
          NOTIFICATION_ID,
          ACCOUNT_ID,
          GROUP_ID,
          NOTIFICATION_REASON_TYPE_ID,
          NOTIFICATION_STATUS_ID,
          EMAIL_TEMPLATE_PARAMS,
          CREATE_DATE,
          UPDATE_DATE,
          DATE_TO_NOTIFY
  ) VALUES (
          not_hist_pk_seq.nextval,
          in_notification_id,
          in_account_id,
          in_group_id,
          notification_reason_type_id,
          notification_status_id,
          email_template_params,
          in_create_date,
          sysdate,
          in_date_to_notify
  );

EXCEPTION
WHEN OTHERS THEN
  RAISE_APPLICATION_ERROR(CORE_OWNER.APP_EXCEPTION_CODES_V19.UNKNOWN_ERROR,
          SPROC_NAME||': Unknown error: '||SQLERRM);
END CREATE_NOTIFICATION_HISTORY;

/******************************************************************************/

PROCEDURE CREATE_NOTIF_FAILURE_HISTORY (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V19.UNKNOWN_ERROR
*/
  in_error_messgae         IN VARCHAR2,
  in_notification_id IN NUMBER,
  in_create_date           IN DATE
) AS
  SPROC_NAME CONSTANT VARCHAR2(28) := 'CREATE_NOTIF_FAILURE_HISTORY';
BEGIN

  INSERT INTO NOTIFICATION_FAILURE_HISTORY (
          ERROR_MESSAGE,
          NOTIFICATION_ID,
          CREATE_DATE,
          UPDATE_DATE
  ) VALUES (
          in_error_messgae,
          in_notification_id,
          in_create_date,
          sysdate
  );

EXCEPTION
WHEN OTHERS THEN
  RAISE_APPLICATION_ERROR(CORE_OWNER.APP_EXCEPTION_CODES_V19.UNKNOWN_ERROR,
          SPROC_NAME||': Unknown error: '||SQLERRM);
END CREATE_NOTIF_FAILURE_HISTORY;

PROCEDURE CREATE_INVOICE_ADJ_HISTORY (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V19.UNKNOWN_ERROR
*/
  in_invoice_adjustment_id     IN CORE_HIST_OWNER.INVOICE_ADJUSTMENT_HISTORY.INVOICE_ADJUSTMENT_ID%TYPE,
  in_invoice_id                IN CORE_HIST_OWNER.INVOICE_ADJUSTMENT_HISTORY.INVOICE_ID%TYPE,
  in_is_credit                 IN CORE_HIST_OWNER.INVOICE_ADJUSTMENT_HISTORY.IS_CREDIT%TYPE,
  in_charge_id                 IN CORE_HIST_OWNER.INVOICE_ADJUSTMENT_HISTORY.CHARGE_ID%TYPE,
  in_adjustment_date           IN CORE_HIST_OWNER.INVOICE_ADJUSTMENT_HISTORY.ADJUSTMENT_DATE%TYPE,
  in_create_date               IN CORE_HIST_OWNER.INVOICE_ADJUSTMENT_HISTORY.CREATE_DATE%TYPE,
  in_created_by                IN CORE_HIST_OWNER.INVOICE_ADJUSTMENT_HISTORY.CREATED_BY%TYPE,
  in_invoice_adj_reason_id               IN CORE_HIST_OWNER.INVOICE_ADJUSTMENT_HISTORY.INVOICE_ADJUSTMENT_REASON_ID%TYPE,
  in_update_date                IN CORE_HIST_OWNER.INVOICE_ADJUSTMENT_HISTORY.UPDATE_DATE%TYPE,
  in_updated_by                IN CORE_HIST_OWNER.INVOICE_ADJUSTMENT_HISTORY.UPDATED_BY%TYPE
)
AS
SPROC_NAME CONSTANT VARCHAR2(32) := 'CREATE_INVOICE_ADJ_HISTORY';
BEGIN
  INSERT INTO CORE_HIST_OWNER.INVOICE_ADJUSTMENT_HISTORY
  (
     INVOICE_ADJUSTMENT_ID,
     INVOICE_ID,
     IS_CREDIT,
     CHARGE_ID,
     ADJUSTMENT_DATE,
     CREATE_DATE,
     CREATED_BY,
     INVOICE_ADJUSTMENT_REASON_ID,
     UPDATE_DATE,
     UPDATED_BY  
  ) 
  VALUES
  (
      in_invoice_adjustment_id,
      in_invoice_id,
      in_is_credit,
      in_charge_id,
      in_adjustment_date,
      in_create_date,
      in_created_by,
      in_invoice_adj_reason_id,
      in_update_date,
      in_updated_by
  );
  
EXCEPTION
  WHEN OTHERS THEN
    RAISE_APPLICATION_ERROR(CORE_OWNER.APP_EXCEPTION_CODES_V19.UNKNOWN_ERROR,
      SPROC_NAME||': Unknown error: '||SQLERRM);
END CREATE_INVOICE_ADJ_HISTORY;

END PROCS_HISTORY_V19;
.
/

--------------------------------------------------------------------------------
-- DDL for package PUBLIC_PROCS_CORE
--------------------------------------------------------------------------------

CREATE OR REPLACE PACKAGE "PUBLIC_PROCS_CORE_V19" AS 

PROCEDURE CREATE_ADDRESS_HISTORY (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V19.UNKNOWN_ERROR
*/
  in_address_id                 IN ADDRESS_HISTORY.ADDRESS_ID%TYPE,
  in_system_activity_reason_id  IN ADDRESS_HISTORY.SYSTEM_ACTIVITY_REASON_ID%TYPE,
  in_address1                   IN ADDRESS_HISTORY.ADDRESS1%TYPE,
  in_address2                   IN ADDRESS_HISTORY.ADDRESS2%TYPE,
  in_city                       IN ADDRESS_HISTORY.CITY%TYPE,
  in_state                      IN ADDRESS_HISTORY.STATE%TYPE,
  in_postal_code                IN ADDRESS_HISTORY.POSTAL_CODE%TYPE,
  in_country                    IN ADDRESS_HISTORY.COUNTRY%TYPE,
  in_created_by                 IN ADDRESS_HISTORY.CREATED_BY%TYPE,
  in_create_date                IN ADDRESS_HISTORY.CREATE_DATE%TYPE,
  in_updated_by                 IN ADDRESS_HISTORY.UPDATED_BY%TYPE,
  in_update_date                IN ADDRESS_HISTORY.UPDATE_DATE%TYPE
);

PROCEDURE CREATE_ACCOUNT_HISTORY (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V19.UNKNOWN_ERROR
*/
  in_account_id                 IN NUMBER,
  in_suspend_date               IN DATE,
  in_group_id                   IN NUMBER,
  in_created_by                 IN VARCHAR2,
  in_create_date                IN DATE,
  in_system_activity_reason_id  IN NUMBER,
  in_account_status_id          IN NUMBER,
  in_instrument_type_id         IN NUMBER,
  in_instrument_id              IN NUMBER
);

PROCEDURE CREATE_SUBSCRIPTION_HISTORY (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V19.UNKNOWN_ERROR
*/
  in_subscription_id           IN  NUMBER,
  in_account_id                IN NUMBER,
  in_purchase_date             IN DATE,
  in_offer_chain_id            IN NUMBER,
  in_suspend_date              IN DATE,
  in_termination_date          IN DATE,
  in_days_remaining_adjustment IN NUMBER,
  in_cancellation_type_id      IN NUMBER,
  in_created_by                IN  VARCHAR2,
  in_create_date               IN DATE,
  in_system_activity_reason_id IN  NUMBER
);

PROCEDURE CREATE_CREDIT_CARD_HISTORY (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V19.UNKNOWN_ERROR
*/
  in_credit_card_id             IN  NUMBER,
  in_account_id                 IN NUMBER,
  in_instrument_name            IN VARCHAR2,
  in_private_card_holder_name   IN VARCHAR2,
  in_private_street_address     IN VARCHAR2,
  in_private_street_address2    IN VARCHAR2,
  in_state                      IN VARCHAR2,
  in_city                       IN VARCHAR2,
  in_postal_code                IN VARCHAR2,
  in_country                    IN CHAR,
  in_last_four_cc               IN VARCHAR2,
  in_expiration_date            IN DATE,
  in_credit_card_type_id        IN NUMBER,
  in_secret_token               IN VARCHAR2,
  in_chase_profile_id           IN VARCHAR2,
  in_credit_card_status_id      IN NUMBER,
  in_created_by                 IN  VARCHAR2,
  in_create_date                IN DATE,
  in_system_activity_reason_id  IN  NUMBER
);

PROCEDURE CREATE_PAYPAL_HISTORY (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V19.UNKNOWN_ERROR
*/
  in_paypal_id                    IN NUMBER,
  in_account_id                   IN NUMBER,
  in_instrument_name              IN VARCHAR2,
  in_private_email_address        IN VARCHAR2,
  in_created_by                   IN VARCHAR2,
  in_create_date                  IN DATE,
  in_paypal_status_id             IN NUMBER,
  in_paypal_prvt_street_address   IN VARCHAR2,
  in_paypal_prvt_street_address2  IN VARCHAR2,
  in_state                        IN VARCHAR2,
  in_city                         IN VARCHAR2,
  in_postal_code                  IN VARCHAR2,
  in_country                      IN CHAR,
  in_expiration_date              IN DATE,
  in_system_activity_reason_id    IN NUMBER,
  in_secret_token                 IN VARCHAR2
);

PROCEDURE CREATE_TRANSACTION_HISTORY (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V19.UNKNOWN_ERROR
*/
  in_transaction_id            IN TRANSACTION_HISTORY.TRANSACTION_ID%TYPE,
  in_transaction_status_id     IN TRANSACTION_HISTORY.TRANSACTION_STATUS_ID%TYPE,
  in_transaction_amount        IN TRANSACTION_HISTORY.TRANSACTION_AMOUNT%TYPE,
  in_created_by                IN TRANSACTION_HISTORY.CREATED_BY%TYPE,
  in_create_date               IN TRANSACTION_HISTORY.CREATE_DATE%TYPE,
  in_order_id                  IN TRANSACTION_HISTORY.ORDER_ID%TYPE,
  in_charge_id                 IN TRANSACTION_HISTORY.CHARGE_ID%TYPE,
  in_is_refund                 IN TRANSACTION_HISTORY.IS_REFUND%TYPE,
  in_is_settled                IN TRANSACTION_HISTORY.IS_SETTLED%TYPE,
  in_transaction_type_code     IN TRANSACTION_HISTORY.TRANSACTION_TYPE_CODE%TYPE,
  in_system_activity_reason_id IN NUMBER
);

PROCEDURE CREATE_GIFT_CERT_HISTORY (
  in_gift_certificate_id        IN NUMBER,
  in_purchaser_group_id         IN NUMBER,
  in_purchase_invoice_id        IN NUMBER,
  in_offer_chain_id             IN NUMBER,
  in_expiration_date            IN DATE,
  in_purchase_date              IN DATE,
  in_gift_certificate_status_id IN NUMBER,
  in_code                       IN VARCHAR2,
  in_created_by                 IN VARCHAR2,
  in_create_date                IN DATE,
  in_system_activity_reason_id  IN NUMBER,
  in_recipient_name             IN VARCHAR2,
  in_gift_message               IN VARCHAR2,
  in_recipient_email            IN VARCHAR2,
  in_finalized_invoice_id       IN NUMBER,
  in_sender_email               IN VARCHAR2,
  in_sender_name                IN VARCHAR2,
  in_redemption_date            IN DATE,
  in_redeemer_group_id          IN NUMBER,
  in_cancelation_date           IN DATE,
  in_recipient_address_id       IN NUMBER,
  in_redeemer_address_id        IN NUMBER,
  in_recipient_notify_date      IN DATE
);

PROCEDURE CREATE_INVOICE_HISTORY (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V19.UNKNOWN_ERROR
*/
  in_invoice_id                IN NUMBER,
  in_invoice_status_id         IN NUMBER,
  in_created_by                IN VARCHAR2,
  in_create_date               IN DATE,
  in_system_activity_reason_id IN NUMBER
);

PROCEDURE CREATE_LICENSE_HISTORY (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V19.UNKNOWN_ERROR
*/
  in_license_id               IN NUMBER,
  in_license_status_id        IN NUMBER,
  in_needs_entitlements       IN NUMBER,
  in_start_date               IN DATE,
  in_offer_id                 IN NUMBER,
  in_subscription_id          IN NUMBER,
  in_invoice_id               IN NUMBER,
  in_end_date                 IN DATE,
  in_created_by               IN VARCHAR2,
  in_create_date              IN DATE,
  in_is_extension             IN NUMBER,
  in_current_offer_index      IN NUMBER,
  in_current_offer_recurr_num IN NUMBER,
  in_system_activity_reason_id IN NUMBER,
  in_entitlement_end_date      IN DATE,
  in_grace_start_date         IN DATE,
  in_grace_end_date           IN DATE
);

PROCEDURE CREATE_CHARGE_HISTORY (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V19.UNKNOWN_ERROR
*/
  in_charge_id                 IN NUMBER,
  in_invoice_id                IN NUMBER,
  in_transaction_id            IN NUMBER,
  in_instrument_type_id        IN NUMBER,
  in_instrument_id             IN NUMBER,
  in_charge_amount             IN NUMBER,
  in_created_by                IN VARCHAR2,
  in_create_date               IN DATE,
  in_charge_status_id          IN NUMBER,
  in_system_activity_reason_id IN NUMBER
);

PROCEDURE CREATE_ITUNES_RECEIPT_HISTORY (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V19.UNKNOWN_ERROR
*/
/*
CREATE TABLE ITUNES_RECEIPT (
  id NUMBER NOT NULL ENABLE,
  subscription_id NUMBER NOT NULL ENABLE,
  receipt VARCHAR(1024) NOT NULL ENABLE,
  status NUMBER,
  quantity NUMBER,
  product_id VARCHAR(1024),
  transaction_id VARCHAR(1024),
  purchase_date TIMESTAMP,
  original_transaction_id VARCHAR(1024),
  original_purchase_date TIMESTAMP,
  app_item_id VARCHAR(1024),
  version_external_id NUMBER,
  bid VARCHAR(1024),
  bvrs VARCHAR(255),
  expires_date TIMESTAMP,
  create_date DATE NOT NULL,
  created_by VARCHAR(255) NOT NULL,
  update_date DATE NOT NULL,
  updated_by VARCHAR(255) NOT NULL,
  last_check_date DATE NOT NULL,
  CONSTRAINT "ITUNESRECEIPT_PK" PRIMARY KEY ("ID") USING INDEX TABLESPACE "CORE_IDX" ENABLE,
  CONSTRAINT "ITUNESRECEIPT_SUBID_FK" FOREIGN KEY ("SUBSCRIPTION_ID") REFERENCES SUBSCRIPTION(ID) USING INDEX TABLESPACE "CORE_IDX" ENABLE,
  CONSTRAINT "ITUNESRECEIPT_RECEIPT_UK" UNIQUE(receipt) USING INDEX TABLESPACE "CORE_IDX" ENABLE,
  CONSTRAINT "ITUNESRECEIPT_SUBID_UK" UNIQUE(subscription_id) USING INDEX TABLESPACE "CORE_IDX" ENABLE
)
TABLESPACE CORE;
*/
  in_id               IN CORE_HIST_OWNER.ITUNES_RECEIPT_HISTORY.ID%TYPE,
  in_subscription_id  IN CORE_HIST_OWNER.ITUNES_RECEIPT_HISTORY.SUBSCRIPTION_ID%TYPE,
  in_receipt          IN CORE_HIST_OWNER.ITUNES_RECEIPT_HISTORY.RECEIPT%TYPE,
  in_status           IN CORE_HIST_OWNER.ITUNES_RECEIPT_HISTORY.STATUS%TYPE,
  in_quantity         IN CORE_HIST_OWNER.ITUNES_RECEIPT_HISTORY.QUANTITY%TYPE,
  in_product_id       IN CORE_HIST_OWNER.ITUNES_RECEIPT_HISTORY.PRODUCT_ID%TYPE,
  in_transaction_id   IN CORE_HIST_OWNER.ITUNES_RECEIPT_HISTORY.TRANSACTION_ID%TYPE,
  in_purchase_date    IN CORE_HIST_OWNER.ITUNES_RECEIPT_HISTORY.PURCHASE_DATE%TYPE,
  in_original_transaction_id IN CORE_HIST_OWNER.ITUNES_RECEIPT_HISTORY.ORIGINAL_TRANSACTION_ID%TYPE,
  in_original_purchase_date IN CORE_HIST_OWNER.ITUNES_RECEIPT_HISTORY.ORIGINAL_PURCHASE_DATE%TYPE,
  in_app_item_id      IN CORE_HIST_OWNER.ITUNES_RECEIPT_HISTORY.APP_ITEM_ID%TYPE,
  in_version_external_id IN CORE_HIST_OWNER.ITUNES_RECEIPT_HISTORY.VERSION_EXTERNAL_ID%TYPE,
  in_bid              IN CORE_HIST_OWNER.ITUNES_RECEIPT_HISTORY.BID%TYPE,
  in_bvrs             IN CORE_HIST_OWNER.ITUNES_RECEIPT_HISTORY.BVRS%TYPE,
  in_expires_date     IN CORE_HIST_OWNER.ITUNES_RECEIPT_HISTORY.EXPIRES_DATE%TYPE,
  in_create_date      IN CORE_HIST_OWNER.ITUNES_RECEIPT_HISTORY.CREATE_DATE%TYPE,
  in_created_by       IN CORE_HIST_OWNER.ITUNES_RECEIPT_HISTORY.CREATED_BY%TYPE,
  in_update_date      IN CORE_HIST_OWNER.ITUNES_RECEIPT_HISTORY.UPDATE_DATE%TYPE,
  in_updated_by       IN CORE_HIST_OWNER.ITUNES_RECEIPT_HISTORY.UPDATED_BY%TYPE,
  in_last_check_date  IN CORE_HIST_OWNER.ITUNES_RECEIPT_HISTORY.LAST_CHECK_DATE%TYPE,
  in_cancel_date      IN CORE_HIST_OWNER.ITUNES_RECEIPT_HISTORY.CANCEL_DATE%TYPE
);

PROCEDURE CREATE_INVOICE_ADJ_HISTORY (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V19.UNKNOWN_ERROR
*/
  in_invoice_adjustment_id     IN CORE_HIST_OWNER.INVOICE_ADJUSTMENT_HISTORY.INVOICE_ADJUSTMENT_ID%TYPE,
  in_invoice_id                IN CORE_HIST_OWNER.INVOICE_ADJUSTMENT_HISTORY.INVOICE_ID%TYPE,
  in_is_credit                 IN CORE_HIST_OWNER.INVOICE_ADJUSTMENT_HISTORY.IS_CREDIT%TYPE,
  in_charge_id                 IN CORE_HIST_OWNER.INVOICE_ADJUSTMENT_HISTORY.CHARGE_ID%TYPE,
  in_adjustment_date           IN CORE_HIST_OWNER.INVOICE_ADJUSTMENT_HISTORY.ADJUSTMENT_DATE%TYPE,
  in_create_date               IN CORE_HIST_OWNER.INVOICE_ADJUSTMENT_HISTORY.CREATE_DATE%TYPE,
  in_created_by                IN CORE_HIST_OWNER.INVOICE_ADJUSTMENT_HISTORY.CREATED_BY%TYPE,
  in_invoice_adj_reason_id     IN CORE_HIST_OWNER.INVOICE_ADJUSTMENT_HISTORY.INVOICE_ADJUSTMENT_REASON_ID%TYPE,
  in_update_date               IN CORE_HIST_OWNER.INVOICE_ADJUSTMENT_HISTORY.UPDATE_DATE%TYPE,
  in_updated_by                IN CORE_HIST_OWNER.INVOICE_ADJUSTMENT_HISTORY.UPDATED_BY%TYPE
);

PROCEDURE CREATE_NOTIFICATION_HISTORY (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V19.UNKNOWN_ERROR
*/
  in_notification_id            IN NUMBER,
  in_account_id                 IN NUMBER,
  in_group_id                   IN NUMBER,
  notification_reason_type_id   IN NUMBER,
  notification_status_id        IN NUMBER,
  email_template_params         IN CLOB,
  in_create_date                IN DATE,
  in_date_to_notify             IN DATE
);

PROCEDURE CREATE_NOTIF_FAILURE_HISTORY (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V19.UNKNOWN_ERROR
*/
  in_error_message         IN VARCHAR2,
  in_notification_id       IN NUMBER,
  in_create_date           IN DATE
);

END PUBLIC_PROCS_CORE_V19;
.
/

CREATE OR REPLACE PACKAGE BODY "PUBLIC_PROCS_CORE_V19" AS

PROCEDURE CREATE_ADDRESS_HISTORY (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V19.NOT_FOUND
APP_EXCEPTION_CODES_V19.UNKNOWN_ERROR
*/
  in_address_id                 IN ADDRESS_HISTORY.ADDRESS_ID%TYPE,
  in_system_activity_reason_id  IN ADDRESS_HISTORY.SYSTEM_ACTIVITY_REASON_ID%TYPE,
  in_address1                   IN ADDRESS_HISTORY.ADDRESS1%TYPE,
  in_address2                   IN ADDRESS_HISTORY.ADDRESS2%TYPE,
  in_city                       IN ADDRESS_HISTORY.CITY%TYPE,
  in_state                      IN ADDRESS_HISTORY.STATE%TYPE,
  in_postal_code                IN ADDRESS_HISTORY.POSTAL_CODE%TYPE,
  in_country                    IN ADDRESS_HISTORY.COUNTRY%TYPE,
  in_created_by                 IN ADDRESS_HISTORY.CREATED_BY%TYPE,
  in_create_date                IN ADDRESS_HISTORY.CREATE_DATE%TYPE,
  in_updated_by                 IN ADDRESS_HISTORY.UPDATED_BY%TYPE,
  in_update_date                IN ADDRESS_HISTORY.UPDATE_DATE%TYPE
) AS
BEGIN
  PROCS_HISTORY_V19.CREATE_ADDRESS_HISTORY(
  in_address_id,
  in_system_activity_reason_id,
  in_address1,
  in_address2,
  in_city,
  in_state,
  in_postal_code,
  in_country,
  in_created_by,
  in_create_date,
  in_updated_by,
  in_update_date
  );
END CREATE_ADDRESS_HISTORY;

PROCEDURE CREATE_ACCOUNT_HISTORY (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V19.NOT_FOUND
APP_EXCEPTION_CODES_V19.UNKNOWN_ERROR
*/
  in_account_id                 IN NUMBER,
  in_suspend_date               IN DATE,
  in_group_id                   IN NUMBER,
  in_created_by                 IN VARCHAR2,
  in_create_date                IN DATE,
  in_system_activity_reason_id  IN NUMBER,
  in_account_status_id          IN NUMBER,
  in_instrument_type_id         IN NUMBER,
  in_instrument_id              IN NUMBER
) AS
BEGIN
  PROCS_HISTORY_V19.CREATE_ACCOUNT_HISTORY(
    in_account_id,
    in_suspend_date,
    in_group_id,
    in_created_by,
    in_create_date,
    in_system_activity_reason_id,
    in_account_status_id,
    in_instrument_type_id,
    in_instrument_id
  );
END CREATE_ACCOUNT_HISTORY;

PROCEDURE CREATE_SUBSCRIPTION_HISTORY (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V19.UNKNOWN_ERROR
*/
  in_subscription_id           IN  NUMBER,
  in_account_id                IN NUMBER,
  in_purchase_date             IN DATE,
  in_offer_chain_id            IN NUMBER,
  in_suspend_date              IN DATE,
  in_termination_date          IN DATE,
  in_days_remaining_adjustment IN NUMBER,
  in_cancellation_type_id      IN NUMBER,
  in_created_by                IN  VARCHAR2,
  in_create_date               IN DATE,
  in_system_activity_reason_id IN  NUMBER
) AS
BEGIN
  PROCS_HISTORY_V19.CREATE_SUBSCRIPTION_HISTORY(
    in_subscription_id,
    in_account_id,
    in_purchase_date,
    in_offer_chain_id,
    in_suspend_date,
    in_termination_date,
    in_days_remaining_adjustment,
    in_cancellation_type_id,
    in_created_by,
    in_create_date,
    in_system_activity_reason_id
  );
END CREATE_SUBSCRIPTION_HISTORY;

PROCEDURE CREATE_CREDIT_CARD_HISTORY (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V19.UNKNOWN_ERROR
*/
  in_credit_card_id             IN  NUMBER,
  in_account_id                 IN NUMBER,
  in_instrument_name            IN VARCHAR2,
  in_private_card_holder_name   IN VARCHAR2,
  in_private_street_address     IN VARCHAR2,
  in_private_street_address2    IN VARCHAR2,
  in_state                      IN VARCHAR2,
  in_city                       IN VARCHAR2,
  in_postal_code                IN VARCHAR2,
  in_country                    IN CHAR,
  in_last_four_cc               IN VARCHAR2,
  in_expiration_date            IN DATE,
  in_credit_card_type_id        IN NUMBER,
  in_secret_token               IN VARCHAR2,
  in_chase_profile_id           IN VARCHAR2,
  in_credit_card_status_id      IN NUMBER,
  in_created_by                 IN  VARCHAR2,
  in_create_date                IN DATE,
  in_system_activity_reason_id  IN  NUMBER
) AS
BEGIN
  PROCS_HISTORY_V19.CREATE_CREDIT_CARD_HISTORY(
    in_credit_card_id,
    in_account_id,
    in_instrument_name,
    in_private_card_holder_name,
    in_private_street_address,
    in_private_street_address2,
    in_state,
    in_city,
    in_postal_code,
    in_country,
    in_last_four_cc,
    in_expiration_date,
    in_credit_card_type_id,
    in_secret_token,
    in_chase_profile_id,
    in_credit_card_status_id,
    in_created_by,
    in_create_date,
    in_system_activity_reason_id
);
END CREATE_CREDIT_CARD_HISTORY;

/***************************************************************/

PROCEDURE CREATE_PAYPAL_HISTORY (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V19.UNKNOWN_ERROR
*/
  in_paypal_id                    IN NUMBER,
  in_account_id                   IN NUMBER,
  in_instrument_name              IN VARCHAR2,
  in_private_email_address        IN VARCHAR2,
  in_created_by                   IN VARCHAR2,
  in_create_date                  IN DATE,
  in_paypal_status_id             IN NUMBER,
  in_paypal_prvt_street_address   IN VARCHAR2,
  in_paypal_prvt_street_address2  IN VARCHAR2,
  in_state                        IN VARCHAR2,
  in_city                         IN VARCHAR2,
  in_postal_code                  IN VARCHAR2,
  in_country                      IN CHAR,
  in_expiration_date              IN DATE,
  in_system_activity_reason_id    IN NUMBER,
  in_secret_token                 IN VARCHAR2
) AS
BEGIN
  PROCS_HISTORY_V19.CREATE_PAYPAL_HISTORY(
    in_paypal_id,
    in_account_id,
    in_instrument_name,
    in_private_email_address,
    in_created_by,
    in_create_date,
    in_paypal_status_id,
    in_paypal_prvt_street_address,
    in_paypal_prvt_street_address2,
    in_state,
    in_city,
    in_postal_code,
    in_country,
    in_expiration_date,
    in_system_activity_reason_id,
    in_secret_token
  );
END;

/***************************************************************/

PROCEDURE CREATE_TRANSACTION_HISTORY (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V19.UNKNOWN_ERROR
*/
  in_transaction_id            IN TRANSACTION_HISTORY.TRANSACTION_ID%TYPE,
  in_transaction_status_id     IN TRANSACTION_HISTORY.TRANSACTION_STATUS_ID%TYPE,
  in_transaction_amount        IN TRANSACTION_HISTORY.TRANSACTION_AMOUNT%TYPE,
  in_created_by                IN TRANSACTION_HISTORY.CREATED_BY%TYPE,
  in_create_date               IN TRANSACTION_HISTORY.CREATE_DATE%TYPE,
  in_order_id                  IN TRANSACTION_HISTORY.ORDER_ID%TYPE,
  in_charge_id                 IN TRANSACTION_HISTORY.CHARGE_ID%TYPE,
  in_is_refund                 IN TRANSACTION_HISTORY.IS_REFUND%TYPE,
  in_is_settled                IN TRANSACTION_HISTORY.IS_SETTLED%TYPE,
  in_transaction_type_code     IN TRANSACTION_HISTORY.TRANSACTION_TYPE_CODE%TYPE,
  in_system_activity_reason_id IN NUMBER
) AS
BEGIN
  PROCS_HISTORY_V19.CREATE_TRANSACTION_HISTORY(
    in_transaction_id,
    in_transaction_status_id,
    in_transaction_amount,
    in_created_by,
    in_create_date,
    in_system_activity_reason_id,
    in_order_id,
    in_charge_id,
    in_is_refund,
    in_is_settled,
    in_transaction_type_code
  );
END CREATE_TRANSACTION_HISTORY;

/***************************************************************/

PROCEDURE CREATE_GIFT_CERT_HISTORY (
  in_gift_certificate_id        IN NUMBER,
  in_purchaser_group_id         IN NUMBER,
  in_purchase_invoice_id        IN NUMBER,
  in_offer_chain_id             IN NUMBER,
  in_expiration_date            IN DATE,
  in_purchase_date              IN DATE,
  in_gift_certificate_status_id IN NUMBER,
  in_code                       IN VARCHAR2,
  in_created_by                 IN VARCHAR2,
  in_create_date                IN DATE,
  in_system_activity_reason_id  IN NUMBER,
  in_recipient_name             IN VARCHAR2,
  in_gift_message               IN VARCHAR2,
  in_recipient_email            IN VARCHAR2,
  in_finalized_invoice_id       IN NUMBER,
  in_sender_email               IN VARCHAR2,
  in_sender_name                IN VARCHAR2,
  in_redemption_date            IN DATE,
  in_redeemer_group_id          IN NUMBER,
  in_cancelation_date           IN DATE,
  in_recipient_address_id       IN NUMBER,
  in_redeemer_address_id        IN NUMBER,
  in_recipient_notify_date      IN DATE
) AS
BEGIN
  PROCS_HISTORY_V19.CREATE_GIFT_CERT_HISTORY(
    in_gift_certificate_id,
    in_purchaser_group_id,
    in_purchase_invoice_id,
    in_offer_chain_id,
    in_expiration_date,
    in_purchase_date,
    in_gift_certificate_status_id,
    in_code,
    in_created_by,
    in_create_date,
    in_system_activity_reason_id,
    in_recipient_name,
    in_gift_message,
    in_recipient_email,
    in_finalized_invoice_id,
    in_sender_email,
    in_sender_name,
    in_redemption_date,
    in_redeemer_group_id,
    in_cancelation_date,
    in_recipient_address_id,
    in_redeemer_address_id,
    in_recipient_notify_date
  );
END CREATE_GIFT_CERT_HISTORY;

/***************************************************************/

PROCEDURE CREATE_INVOICE_HISTORY (
  in_invoice_id                IN NUMBER,
  in_invoice_status_id         IN NUMBER,
  in_created_by                IN VARCHAR2,
  in_create_date               IN DATE,
  in_system_activity_reason_id IN NUMBER
) AS
BEGIN
  PROCS_HISTORY_V19.CREATE_INVOICE_HISTORY (
    in_invoice_id,
    in_invoice_status_id,
    in_created_by,
    in_create_date,
    in_system_activity_reason_id
  );
END CREATE_INVOICE_HISTORY;

/***************************************************************/

PROCEDURE CREATE_LICENSE_HISTORY (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V19.UNKNOWN_ERROR
*/
  in_license_id               IN NUMBER,
  in_license_status_id        IN NUMBER,
  in_needs_entitlements       IN NUMBER,
  in_start_date               IN DATE,
  in_offer_id                 IN NUMBER,
  in_subscription_id          IN NUMBER,
  in_invoice_id               IN NUMBER,
  in_end_date                 IN DATE,
  in_created_by               IN VARCHAR2,
  in_create_date              IN DATE,
  in_is_extension             IN NUMBER,
  in_current_offer_index      IN NUMBER,
  in_current_offer_recurr_num IN NUMBER,
  in_system_activity_reason_id IN NUMBER,
  in_entitlement_end_date      IN DATE,
  in_grace_start_date         IN DATE,
  in_grace_end_date           IN DATE
) AS
BEGIN
  PROCS_HISTORY_V19.CREATE_LICENSE_HISTORY (
    in_license_id,
    in_license_status_id,
    in_needs_entitlements,
    in_start_date,
    in_offer_id,
    in_subscription_id,
    in_invoice_id,
    in_end_date,
    in_created_by,
    in_create_date,
    in_is_extension,
    in_current_offer_index,
    in_current_offer_recurr_num,
    in_system_activity_reason_id,
    in_entitlement_end_date,
    in_grace_start_date,
    in_grace_end_date
  );
END CREATE_LICENSE_HISTORY;

/***************************************************************/

PROCEDURE CREATE_CHARGE_HISTORY (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V19.UNKNOWN_ERROR
*/
  in_charge_id                 IN NUMBER,
  in_invoice_id                IN NUMBER,
  in_transaction_id            IN NUMBER,
  in_instrument_type_id        IN NUMBER,
  in_instrument_id             IN NUMBER,
  in_charge_amount             IN NUMBER,
  in_created_by                IN VARCHAR2,
  in_create_date               IN DATE,
  in_charge_status_id          IN NUMBER,
  in_system_activity_reason_id IN NUMBER
) AS
BEGIN
  PROCS_HISTORY_V19.CREATE_CHARGE_HISTORY (
    in_charge_id,
    in_invoice_id,
    in_transaction_id,
    in_instrument_type_id,
    in_instrument_id,
    in_charge_amount,
    in_created_by,
    in_create_date,
    in_charge_status_id,
    in_system_activity_reason_id
  );
END;

PROCEDURE CREATE_ITUNES_RECEIPT_HISTORY (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V19.UNKNOWN_ERROR
*/
/*
CREATE TABLE ITUNES_RECEIPT (
  id NUMBER NOT NULL ENABLE,
  subscription_id NUMBER NOT NULL ENABLE,
  receipt VARCHAR(1024) NOT NULL ENABLE,
  status NUMBER,
  quantity NUMBER,
  product_id VARCHAR(1024),
  transaction_id VARCHAR(1024),
  purchase_date TIMESTAMP,
  original_transaction_id VARCHAR(1024),
  original_purchase_date TIMESTAMP,
  app_item_id VARCHAR(1024),
  version_external_id NUMBER,
  bid VARCHAR(1024),
  bvrs VARCHAR(255),
  expires_date TIMESTAMP,
  create_date DATE NOT NULL,
  created_by VARCHAR(255) NOT NULL,
  update_date DATE NOT NULL,
  updated_by VARCHAR(255) NOT NULL,
  last_check_date DATE NOT NULL,
  CONSTRAINT "ITUNESRECEIPT_PK" PRIMARY KEY ("ID") USING INDEX TABLESPACE "CORE_IDX" ENABLE,
  CONSTRAINT "ITUNESRECEIPT_SUBID_FK" FOREIGN KEY ("SUBSCRIPTION_ID") REFERENCES SUBSCRIPTION(ID) USING INDEX TABLESPACE "CORE_IDX" ENABLE,
  CONSTRAINT "ITUNESRECEIPT_RECEIPT_UK" UNIQUE(receipt) USING INDEX TABLESPACE "CORE_IDX" ENABLE,
  CONSTRAINT "ITUNESRECEIPT_SUBID_UK" UNIQUE(subscription_id) USING INDEX TABLESPACE "CORE_IDX" ENABLE
)
TABLESPACE CORE;
*/
  in_id               IN CORE_HIST_OWNER.ITUNES_RECEIPT_HISTORY.ID%TYPE,
  in_subscription_id  IN CORE_HIST_OWNER.ITUNES_RECEIPT_HISTORY.SUBSCRIPTION_ID%TYPE,
  in_receipt          IN CORE_HIST_OWNER.ITUNES_RECEIPT_HISTORY.RECEIPT%TYPE,
  in_status           IN CORE_HIST_OWNER.ITUNES_RECEIPT_HISTORY.STATUS%TYPE,
  in_quantity         IN CORE_HIST_OWNER.ITUNES_RECEIPT_HISTORY.QUANTITY%TYPE,
  in_product_id       IN CORE_HIST_OWNER.ITUNES_RECEIPT_HISTORY.PRODUCT_ID%TYPE,
  in_transaction_id   IN CORE_HIST_OWNER.ITUNES_RECEIPT_HISTORY.TRANSACTION_ID%TYPE,
  in_purchase_date    IN CORE_HIST_OWNER.ITUNES_RECEIPT_HISTORY.PURCHASE_DATE%TYPE,
  in_original_transaction_id IN CORE_HIST_OWNER.ITUNES_RECEIPT_HISTORY.ORIGINAL_TRANSACTION_ID%TYPE,
  in_original_purchase_date IN CORE_HIST_OWNER.ITUNES_RECEIPT_HISTORY.ORIGINAL_PURCHASE_DATE%TYPE,
  in_app_item_id      IN CORE_HIST_OWNER.ITUNES_RECEIPT_HISTORY.APP_ITEM_ID%TYPE,
  in_version_external_id IN CORE_HIST_OWNER.ITUNES_RECEIPT_HISTORY.VERSION_EXTERNAL_ID%TYPE,
  in_bid              IN CORE_HIST_OWNER.ITUNES_RECEIPT_HISTORY.BID%TYPE,
  in_bvrs             IN CORE_HIST_OWNER.ITUNES_RECEIPT_HISTORY.BVRS%TYPE,
  in_expires_date     IN CORE_HIST_OWNER.ITUNES_RECEIPT_HISTORY.EXPIRES_DATE%TYPE,
  in_create_date      IN CORE_HIST_OWNER.ITUNES_RECEIPT_HISTORY.CREATE_DATE%TYPE,
  in_created_by       IN CORE_HIST_OWNER.ITUNES_RECEIPT_HISTORY.CREATED_BY%TYPE,
  in_update_date      IN CORE_HIST_OWNER.ITUNES_RECEIPT_HISTORY.UPDATE_DATE%TYPE,
  in_updated_by       IN CORE_HIST_OWNER.ITUNES_RECEIPT_HISTORY.UPDATED_BY%TYPE,
  in_last_check_date  IN CORE_HIST_OWNER.ITUNES_RECEIPT_HISTORY.LAST_CHECK_DATE%TYPE,
  in_cancel_date      IN CORE_HIST_OWNER.ITUNES_RECEIPT_HISTORY.CANCEL_DATE%TYPE
) AS
BEGIN
  PROCS_HISTORY_V19.CREATE_ITUNES_RECEIPT_HISTORY (
    in_id => in_id,
    in_subscription_id => in_subscription_id,
    in_receipt => in_receipt,
    in_status => in_status,
    in_quantity => in_quantity,
    in_product_id => in_product_id,
    in_transaction_id => in_transaction_id,
    in_purchase_date => in_purchase_date,
    in_original_transaction_id => in_original_transaction_id,
    in_original_purchase_date => in_original_purchase_date,
    in_app_item_id => in_app_item_id,
    in_version_external_id => in_version_external_id,
    in_bid => in_bid,
    in_bvrs => in_bvrs,
    in_expires_date => in_expires_date,
    in_create_date => in_create_date,
    in_created_by => in_created_by,
    in_update_date => in_update_date,
    in_updated_by => in_updated_by,
    in_last_check_date => in_last_check_date,
    in_cancel_date => in_cancel_date
  );
END;

PROCEDURE CREATE_INVOICE_ADJ_HISTORY (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V19.UNKNOWN_ERROR
*/
  in_invoice_adjustment_id     IN CORE_HIST_OWNER.INVOICE_ADJUSTMENT_HISTORY.INVOICE_ADJUSTMENT_ID%TYPE,
  in_invoice_id                IN CORE_HIST_OWNER.INVOICE_ADJUSTMENT_HISTORY.INVOICE_ID%TYPE,
  in_is_credit                 IN CORE_HIST_OWNER.INVOICE_ADJUSTMENT_HISTORY.IS_CREDIT%TYPE,
  in_charge_id                 IN CORE_HIST_OWNER.INVOICE_ADJUSTMENT_HISTORY.CHARGE_ID%TYPE,
  in_adjustment_date           IN CORE_HIST_OWNER.INVOICE_ADJUSTMENT_HISTORY.ADJUSTMENT_DATE%TYPE,
  in_create_date               IN CORE_HIST_OWNER.INVOICE_ADJUSTMENT_HISTORY.CREATE_DATE%TYPE,
  in_created_by                IN CORE_HIST_OWNER.INVOICE_ADJUSTMENT_HISTORY.CREATED_BY%TYPE,
  in_invoice_adj_reason_id               IN CORE_HIST_OWNER.INVOICE_ADJUSTMENT_HISTORY.INVOICE_ADJUSTMENT_REASON_ID%TYPE,
  in_update_date                IN CORE_HIST_OWNER.INVOICE_ADJUSTMENT_HISTORY.UPDATE_DATE%TYPE,
  in_updated_by                IN CORE_HIST_OWNER.INVOICE_ADJUSTMENT_HISTORY.UPDATED_BY%TYPE
)  AS
  BEGIN
    PROCS_HISTORY_V19.CREATE_INVOICE_ADJ_HISTORY(
      in_invoice_adjustment_id => in_invoice_adjustment_id,
      in_invoice_id => in_invoice_id,
      in_is_credit => in_is_credit, 
      in_charge_id => in_charge_id,
      in_adjustment_date => in_adjustment_date,
      in_create_date => in_create_date,
      in_created_by => in_created_by,
      in_invoice_adj_reason_id => in_invoice_adj_reason_id, 
      in_update_date => in_update_date, 
      in_updated_by => in_updated_by
    );    
END;    

PROCEDURE CREATE_NOTIFICATION_HISTORY (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V19.UNKNOWN_ERROR
*/
  in_notification_id            IN NUMBER,
  in_account_id                 IN NUMBER,
  in_group_id                   IN NUMBER,
  notification_reason_type_id   IN NUMBER,
  notification_status_id        IN NUMBER,
  email_template_params         IN CLOB,
  in_create_date                IN DATE,
  in_date_to_notify             IN DATE
) AS
BEGIN
  PROCS_HISTORY_V19.CREATE_NOTIFICATION_HISTORY(
    in_notification_id,
    in_account_id,
    in_group_id,
    notification_reason_type_id,
    notification_status_id,
    email_template_params,
    in_create_date,
    in_date_to_notify
);
END CREATE_NOTIFICATION_HISTORY;

/******************************************************/

PROCEDURE CREATE_NOTIF_FAILURE_HISTORY (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V19.UNKNOWN_ERROR
*/
  in_error_message         IN VARCHAR2,
  in_notification_id       IN NUMBER,
  in_create_date           IN DATE
) AS
BEGIN
  PROCS_HISTORY_V19.CREATE_NOTIF_FAILURE_HISTORY(
    in_error_message,
    in_notification_id,
    in_create_date
);
END CREATE_NOTIF_FAILURE_HISTORY;

END PUBLIC_PROCS_CORE_V19;
.
/

--------------------------------------------------------------------------------
-- DDL for package PROCS_PARTITIONS
--------------------------------------------------------------------------------

CREATE OR REPLACE PACKAGE "PROCS_PARTITIONS_V19" AS 

PROCEDURE GET_PARTITION_YEAR_MONTH (
  in_year   IN NUMBER,
  in_month  IN NUMBER,
  out_year  OUT NUMBER,
  out_month OUT NUMBER
);

PROCEDURE ADD_TABLE_PARTITION (
  in_tablename       IN VARCHAR2,
  in_partitionprefix IN VARCHAR2,
  in_year            IN NUMBER,
  in_month           IN NUMBER
);

PROCEDURE ADD_ACCOUNT_PARTITION(
  in_year  IN NUMBER,
  in_month IN NUMBER
);

PROCEDURE ADD_BILLING_LOG_PARTITION(
  in_year  IN NUMBER,
  in_month IN NUMBER
);

PROCEDURE ADD_CREDIT_CARD_PARTITION(
  in_year  IN NUMBER,
  in_month IN NUMBER
);

PROCEDURE ADD_GCERTIFICATE_PARTITION(
  in_year  IN NUMBER,
  in_month IN NUMBER
);

PROCEDURE ADD_OFFER_CHAIN_PARTITION(
  in_year  IN NUMBER,
  in_month IN NUMBER
);

PROCEDURE ADD_OFF_OFFER_CHAIN_PARTITION(
  in_year  IN NUMBER,
  in_month IN NUMBER
);

PROCEDURE ADD_PAYPAL_PARTITION(
  in_year  IN NUMBER,
  in_month IN NUMBER
);

PROCEDURE ADD_SUBSCRIPTION_PARTITION(
  in_year  IN NUMBER,
  in_month IN NUMBER
);

PROCEDURE ADD_TRANSACTION_PARTITION(
  in_year  IN NUMBER,
  in_month IN NUMBER
);

PROCEDURE ADD_INVOICE_PARTITION(
  in_year  IN NUMBER,
  in_month IN NUMBER
);

PROCEDURE ADD_LICENSE_PARTITION(
  in_year  IN NUMBER,
  in_month IN NUMBER
);

PROCEDURE ADD_CHARGE_PARTITION(
  in_year  IN NUMBER,
  in_month IN NUMBER
);

PROCEDURE ADD_NOTIFICATION_PARTITION(
  in_year  IN NUMBER,
  in_month IN NUMBER
);

PROCEDURE ADD_NOTIF_FAILURE_PARTITION(
  in_year  IN NUMBER,
  in_month IN NUMBER
);

END PROCS_PARTITIONS_V19;
.
/

CREATE OR REPLACE PACKAGE BODY "PROCS_PARTITIONS_V19" AS

PROCEDURE GET_PARTITION_YEAR_MONTH (
  in_year   IN NUMBER,
  in_month  IN NUMBER,
  out_year  OUT NUMBER,
  out_month OUT NUMBER
) AS
BEGIN
  IF in_month < 12 THEN
    out_month := in_month + 1;
    out_year  := in_year;
  ELSIF in_month = 12 THEN
    out_month := 1;
    out_year  := in_year + 1;
  ELSE
    out_month := in_month;
    out_year  := in_year;
  END IF;
END;

/**************************************************************/

PROCEDURE ADD_TABLE_PARTITION (
  in_tablename       IN VARCHAR2,
  in_partitionprefix IN VARCHAR2,
  in_year            IN NUMBER,
  in_month           IN NUMBER
) AS
-- VARIABLES
partision_year  NUMBER;
partision_month NUMBER;
-- CONSTANTS
const_max_prefix CONSTANT VARCHAR(3) := 'max';
BEGIN
  GET_PARTITION_YEAR_MONTH(in_year, in_month, partision_year, partision_month);
  EXECUTE IMMEDIATE 'ALTER TABLE '||in_tablename||' SPLIT PARTITION '||in_partitionprefix||'_'||const_max_prefix||' AT (date '''||partision_year||'-'||partision_month||'-01'') INTO (PARTITION '||in_partitionprefix||'_y'||in_year||'m'||in_month||', PARTITION '||in_partitionprefix||'_'||const_max_prefix||')';
END;

/**************************************************************/

PROCEDURE ADD_ACCOUNT_PARTITION(
  in_year  IN NUMBER,
  in_month IN NUMBER
) AS
-- CONSTANTS
CONST_TABLE_NAME       CONSTANT VARCHAR2(15) := 'ACCOUNT_HISTORY';
CONST_PARTITION_PREFIX CONSTANT VARCHAR2(7)  := 'account';
BEGIN
  ADD_TABLE_PARTITION(CONST_TABLE_NAME, CONST_PARTITION_PREFIX, in_year, in_month);
END ADD_ACCOUNT_PARTITION;

/**************************************************************/

PROCEDURE ADD_BILLING_LOG_PARTITION(
  in_year  IN NUMBER,
  in_month IN NUMBER
) AS
-- CONSTANTS
CONST_TABLE_NAME       CONSTANT VARCHAR2(28) := 'BILLING_ACTIVITY_LOG_HISTORY';
CONST_PARTITION_PREFIX CONSTANT VARCHAR2(15) := 'billing_act_log';
BEGIN
  ADD_TABLE_PARTITION(CONST_TABLE_NAME, CONST_PARTITION_PREFIX, in_year, in_month);
END ADD_BILLING_LOG_PARTITION;

/**************************************************************/

PROCEDURE ADD_CREDIT_CARD_PARTITION(
  in_year  IN NUMBER,
  in_month IN NUMBER
) AS
-- CONSTANTS
CONST_TABLE_NAME       CONSTANT VARCHAR2(19) := 'CREDIT_CARD_HISTORY';
CONST_PARTITION_PREFIX CONSTANT VARCHAR2(11) := 'credit_card';
BEGIN
  ADD_TABLE_PARTITION(CONST_TABLE_NAME, CONST_PARTITION_PREFIX, in_year, in_month);
END ADD_CREDIT_CARD_PARTITION;

/**************************************************************/

PROCEDURE ADD_GCERTIFICATE_PARTITION(
  in_year  IN NUMBER,
  in_month IN NUMBER
) AS
-- CONSTANTS
CONST_TABLE_NAME       CONSTANT VARCHAR2(24) := 'GIFT_CERTIFICATE_HISTORY';
CONST_PARTITION_PREFIX CONSTANT VARCHAR2(16) := 'gift_certificate';
BEGIN
  ADD_TABLE_PARTITION(CONST_TABLE_NAME, CONST_PARTITION_PREFIX, in_year, in_month);
END ADD_GCERTIFICATE_PARTITION;

/**************************************************************/

PROCEDURE ADD_OFFER_CHAIN_PARTITION(
  in_year  IN NUMBER,
  in_month IN NUMBER
) AS
-- CONSTANTS
CONST_TABLE_NAME       CONSTANT VARCHAR2(19) := 'OFFER_CHAIN_HISTORY';
CONST_PARTITION_PREFIX CONSTANT VARCHAR2(11) := 'offer_chain';
BEGIN
  ADD_TABLE_PARTITION(CONST_TABLE_NAME, CONST_PARTITION_PREFIX, in_year, in_month);
END ADD_OFFER_CHAIN_PARTITION;

/**************************************************************/

PROCEDURE ADD_OFF_OFFER_CHAIN_PARTITION(
  in_year  IN NUMBER,
  in_month IN NUMBER
) AS
-- CONSTANTS
CONST_TABLE_NAME       CONSTANT VARCHAR2(25) := 'OFFER_OFFER_CHAIN_HISTORY';
CONST_PARTITION_PREFIX CONSTANT VARCHAR2(17) := 'offer_offer_chain';
BEGIN
  ADD_TABLE_PARTITION(CONST_TABLE_NAME, CONST_PARTITION_PREFIX, in_year, in_month);
END ADD_OFF_OFFER_CHAIN_PARTITION;

/**************************************************************/

PROCEDURE ADD_PAYPAL_PARTITION(
  in_year  IN NUMBER,
  in_month IN NUMBER
) AS
-- CONSTANTS
CONST_TABLE_NAME       CONSTANT VARCHAR2(14) := 'PAYPAL_HISTORY';
CONST_PARTITION_PREFIX CONSTANT VARCHAR2(6)  := 'paypal';
BEGIN
  ADD_TABLE_PARTITION(CONST_TABLE_NAME, CONST_PARTITION_PREFIX, in_year, in_month);
END ADD_PAYPAL_PARTITION;

/**************************************************************/

PROCEDURE ADD_SUBSCRIPTION_PARTITION(
  in_year  IN NUMBER,
  in_month IN NUMBER
) AS
-- CONSTANTS
CONST_TABLE_NAME       CONSTANT VARCHAR2(20) := 'SUBSCRIPTION_HISTORY';
CONST_PARTITION_PREFIX CONSTANT VARCHAR2(12) := 'subscription';
BEGIN
  ADD_TABLE_PARTITION(CONST_TABLE_NAME, CONST_PARTITION_PREFIX, in_year, in_month);
END ADD_SUBSCRIPTION_PARTITION;

/**************************************************************/

PROCEDURE ADD_TRANSACTION_PARTITION(
  in_year  IN NUMBER,
  in_month IN NUMBER
) AS
-- CONSTANTS
CONST_TABLE_NAME       CONSTANT VARCHAR2(19) := 'TRANSACTION_HISTORY';
CONST_PARTITION_PREFIX CONSTANT VARCHAR2(11) := 'transaction';
BEGIN
  ADD_TABLE_PARTITION(CONST_TABLE_NAME, CONST_PARTITION_PREFIX, in_year, in_month);
END ADD_TRANSACTION_PARTITION;

/**************************************************************/

PROCEDURE ADD_INVOICE_PARTITION(
  in_year  IN NUMBER,
  in_month IN NUMBER
) AS
-- CONSTANTS
CONST_TABLE_NAME       CONSTANT VARCHAR2(15) := 'INVOICE_HISTORY';
CONST_PARTITION_PREFIX CONSTANT VARCHAR2(7) := 'invoice';
BEGIN
  ADD_TABLE_PARTITION(CONST_TABLE_NAME, CONST_PARTITION_PREFIX, in_year, in_month);
END ADD_INVOICE_PARTITION;

/**************************************************************/

PROCEDURE ADD_LICENSE_PARTITION(
  in_year  IN NUMBER,
  in_month IN NUMBER
) AS
-- CONSTANTS
CONST_TABLE_NAME       CONSTANT VARCHAR2(15) := 'LICENSE_HISTORY';
CONST_PARTITION_PREFIX CONSTANT VARCHAR2(7) := 'license';
BEGIN
  ADD_TABLE_PARTITION(CONST_TABLE_NAME, CONST_PARTITION_PREFIX, in_year, in_month);
END ADD_LICENSE_PARTITION;

/**************************************************************/

PROCEDURE ADD_CHARGE_PARTITION(
  in_year  IN NUMBER,
  in_month IN NUMBER
) AS
-- CONSTANTS
CONST_TABLE_NAME       CONSTANT VARCHAR2(15) := 'CHARGE_HISTORY';
CONST_PARTITION_PREFIX CONSTANT VARCHAR2(7) := 'charge';
BEGIN
  ADD_TABLE_PARTITION(CONST_TABLE_NAME, CONST_PARTITION_PREFIX, in_year, in_month);
END ADD_CHARGE_PARTITION;

/**************************************************************/

PROCEDURE ADD_NOTIFICATION_PARTITION(
  in_year  IN NUMBER,
  in_month IN NUMBER
) AS
-- CONSTANTS
  CONST_TABLE_NAME       CONSTANT VARCHAR2(20) := 'NOTIFICATION_HISTORY';
  CONST_PARTITION_PREFIX CONSTANT VARCHAR2(12)  := 'notification';
BEGIN
  ADD_TABLE_PARTITION(CONST_TABLE_NAME, CONST_PARTITION_PREFIX, in_year, in_month);
END ADD_NOTIFICATION_PARTITION;

/**************************************************************/

PROCEDURE ADD_NOTIF_FAILURE_PARTITION(
  in_year  IN NUMBER,
  in_month IN NUMBER
) AS
-- CONSTANTS
  CONST_TABLE_NAME       CONSTANT VARCHAR2(28) := 'NOTIFICATION_FAILURE_HISTORY';
  CONST_PARTITION_PREFIX CONSTANT VARCHAR2(20) := 'notification_failure';
BEGIN
  ADD_TABLE_PARTITION(CONST_TABLE_NAME, CONST_PARTITION_PREFIX, in_year, in_month);
END ADD_NOTIF_FAILURE_PARTITION;

END PROCS_PARTITIONS_V19;
.
/

--------------------------------------------------------------------------------
-- DDL for package PROCS_SYSTEM
--------------------------------------------------------------------------------

CREATE OR REPLACE PACKAGE "PROCS_SYSTEM_V19" AS 

PROCEDURE INCREMENT_VERSION;

PROCEDURE CHECK_VERSION(
    in_vers    IN NUMBER,
    out_result OUT NUMBER
);

END PROCS_SYSTEM_V19;
.
/

CREATE OR REPLACE PACKAGE BODY "PROCS_SYSTEM_V19" AS

PROCEDURE INCREMENT_VERSION
/*
Throws exceptions:
CORE_OWNER.APP_EXCEPTION_CODES_V19.UNKNOWN_ERROR
*/
AS
BEGIN

  UPDATE SYS_VERSION SET version=version+1;
  
EXCEPTION
WHEN OTHERS THEN
  RAISE_APPLICATION_ERROR(CORE_OWNER.APP_EXCEPTION_CODES_V19.UNKNOWN_ERROR,
    'Unknown error');
END INCREMENT_VERSION;

/*************************************************************/

PROCEDURE CHECK_VERSION(
    in_vers    IN NUMBER,
    out_result OUT NUMBER
) AS
  current_version NUMBER;
BEGIN
  SELECT version INTO current_version FROM SYS_VERSION;
  IF(current_version != in_vers) THEN
    out_result := 1;
  ELSE
    out_result := 0;
  END IF;
  EXCEPTION
	WHEN OTHERS THEN
	NULL;
END CHECK_VERSION;

END PROCS_SYSTEM_V19;
.
/

grant execute on PUBLIC_PROCS_CORE_V19 to core_owner;
grant execute on PUBLIC_PROCS_CORE_V19 to core_app;
GRANT EXECUTE ON PUBLIC_PROCS_CORE_V19 TO ops_owner;
GRANT EXECUTE ON PUBLIC_PROCS_CORE_V19 TO ops_aaa_app;
GRANT EXECUTE ON PUBLIC_PROCS_CORE_V19 TO ops_payment_app;
GRANT EXECUTE ON PUBLIC_PROCS_CORE_V19 TO ops_notif_app;