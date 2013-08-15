
.
/

--------------------------------------------------------------------------------
-- DDL for package PROCS_ACCOUNT
--------------------------------------------------------------------------------

CREATE OR REPLACE PACKAGE "PROCS_ACCOUNT_V18" AS 

FUNCTION GET_GRACE_START_DATE(
  in_subscription_id IN NUMBER
) RETURN DATE;

FUNCTION GET_GRACE_END_DATE(
  in_subscription_id IN NUMBER
) RETURN DATE;

PROCEDURE INVOICE_IDS_BY_GROUP_ID (
  in_group_id    IN  NUMBER,
  out_result_set OUT SYS_REFCURSOR
);

PROCEDURE ANNOTATE_ACCOUNT (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_group_id   IN  NUMBER,
  in_agent_id   IN  NUMBER,
  in_note       IN  VARCHAR2,
  in_created_by IN  VARCHAR2
);

PROCEDURE ASSERT_ACCOUNT_EXISTS (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_group_id IN  NUMBER,
  out_exists  OUT NUMBER
);

PROCEDURE DISABLE_ACCOUNT (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.INTERNAL_ERROR,
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
*/
  in_group_id   IN NUMBER,
  in_updated_by IN VARCHAR2,
  in_note       IN VARCHAR2,
  in_agent_id   IN NUMBER
);

PROCEDURE CREATE_ACTIVE_ACCOUNT(
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.INTERNAL_ERROR,
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_created_by          IN VARCHAR2,
  in_group_id            IN NUMBER
);

PROCEDURE REACTIVATE_ACCOUNT (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.INTERNAL_ERROR,
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
*/
  in_group_id       IN NUMBER,
  in_updated_by     IN VARCHAR2,
  in_note           IN VARCHAR2,
  in_agent_id       IN NUMBER
);

/*

THERE ARE NO ACCOUNT STATUS "SUSPENDED"
Waiting for new instructions.

PROCEDURE SUSPEND_ACCOUNT (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.INTERNAL_ERROR,
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,

    in_group_id    IN  NUMBER,
    in_updated_by  IN  VARCHAR2
)
*/

PROCEDURE GET_ACCOUNT_CREDIT_CARDS (
  in_group_id    IN ACCOUNT.GROUP_ID%TYPE,
  in_status_id   IN CREDIT_CARD.CREDIT_CARD_STATUS_ID%TYPE DEFAULT GLOBAL_STATUSES_V18.CREDIT_CARD_ACTIVE,
  out_result_set OUT SYS_REFCURSOR
);

PROCEDURE GET_ACCOUNT_GIFT_CERTIFICATES (
/*
IN:
instr_status:
GLOBAL_CONSTANTS_V18.TRUE - get active instruments only (default)
GLOBAL_CONSTANTS_V18.FALSE - get inactive instruments only

Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND,
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_group_id       IN NUMBER,
  out_result_gc_set OUT SYS_REFCURSOR,
  in_instr_status   IN NUMBER DEFAULT GLOBAL_CONSTANTS_V18.TRUE
);

PROCEDURE GET_ACCOUNT_INFO  (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND,
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
    in_group_id       IN  NUMBER,
    out_account_info  OUT SYS_REFCURSOR
);

PROCEDURE GET_ACCOUNT_NOTES (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
APP_EXCEPTION_CODES_V18.NOT_FOUND
*/
    in_group_id    IN  NUMBER,
    out_result_set OUT SYS_REFCURSOR  
);

PROCEDURE GET_ACCOUNT_PAYPALS(
  in_group_id    IN  ACCOUNT.GROUP_ID%TYPE,
  in_status_id   IN  PAYPAL.PAYPAL_STATUS_ID%TYPE DEFAULT GLOBAL_STATUSES_V18.PAYPAL_ACTIVE,
  out_result_set OUT SYS_REFCURSOR
);

PROCEDURE GET_ACCOUNT_SUBSCRIPTIONS (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND,
APP_EXCEPTION_CODES_V18.INTERNAL_ERROR,
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
    in_group_id    IN  NUMBER,
    in_start_date  IN DATE,
    in_end_date    IN DATE,
    in_status      IN NUMBER,
    in_group_account_type IN VARCHAR2,
    out_result_set  OUT SYS_REFCURSOR
);

PROCEDURE FREEZE_ACCOUNT (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND,
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_group_id   IN NUMBER,
  in_updated_by IN VARCHAR2,
  in_note       IN VARCHAR2,
  in_agent_id   IN NUMBER
);

PROCEDURE GET_ACCOUNT_SUBSCR_INVOICES (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND,
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_group_id        IN  NUMBER,
  in_subscription_id IN NUMBER,
  out_result_set     OUT SYS_REFCURSOR
);

PROCEDURE GET_ACCOUNT_GC_INVOICES (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND,
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_group_id    IN  NUMBER,
  out_result_set OUT SYS_REFCURSOR
);

PROCEDURE GET_GC_INVOICE (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND,
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_group_id    IN  NUMBER,
  in_gc_code     IN  VARCHAR2,
  out_result_set OUT SYS_REFCURSOR
);

PROCEDURE GET_ACCOUNT_PRODUCTS (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND,
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_group_id    IN  NUMBER,
  out_result_set OUT SYS_REFCURSOR
);

PROCEDURE GET_ACCOUNT_PROD_OFFERRINGS (
/*
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_group_id IN NUMBER,
  out_result_set     OUT SYS_REFCURSOR
);

PROCEDURE UPDATE_ACCOUNT_STATUS (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND,
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_account_id        IN ACCOUNT.ID%TYPE,
  in_account_status_id IN ACCOUNT.ACCOUNT_STATUS_ID%TYPE,
  in_updated_by        IN ACCOUNT.UPDATED_BY%TYPE
);

PROCEDURE GET_NEEDS_ENTTL_LICENSES_NUM (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND,
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_group_id      IN ACCOUNT.GROUP_ID%TYPE,
  out_licenses_num OUT NUMBER
);

PROCEDURE SET_TAX_EXEMPT (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND,
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_group_id  IN NUMBER,
  in_exempt_id IN VARCHAR2
);

PROCEDURE IS_TAX_EXEMPT (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND,
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
Return:
  GLOBAL_CONSTANTS_V18.TRUE if ACCOUNT.EXEMPT_ID is not null
  GLOBAL_CONSTANTS_V18.FALSE else
*/
  in_group_id       IN NUMBER,
  out_is_tax_exempt OUT NUMBER
);

PROCEDURE GET_GROUP_ID_BY_ACCOUNT_ID (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND,
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_account_id IN NUMBER,
  out_group_id  OUT NUMBER
);

PROCEDURE GET_ACCOUNT_ID_BY_GROUP_ID (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND,
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_group_id IN NUMBER,
  out_account_id  OUT NUMBER
);

PROCEDURE GET_GROUPS_ID_BY_INVOICE_ID (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND,
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_invoice_id IN NUMBER,
  out_group_ids OUT SYS_REFCURSOR
);

PROCEDURE GET_ACCOUNT_TAX_EXEMPT_ID (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND,
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_group_id       IN NUMBER,
  out_tax_exempt_id OUT VARCHAR2
);

PROCEDURE GET_UPGRADABLE_SUBSCRIPTIONS (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND,
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR

Result has two columns:
subscription_id and offer_chain_id
*/
  in_group_id    IN NUMBER,
  out_result_set OUT SYS_REFCURSOR
);

PROCEDURE GET_USR_ALL_SBSCR_IDS (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND,
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR

Result has two columns:
subscription_id and offer_chain_id
*/
  in_group_id        IN NUMBER,
  out_result_set     OUT SYS_REFCURSOR
);

PROCEDURE GET_USR_SBSCR_IDS_BY_OFFCH_IDS (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND,
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
APP_EXCEPTION_CODES_V18.INVALID_PARAMETER

Result has two columns:
subscription_id and offer_chain_id
*/
  in_group_id        IN NUMBER,
  in_offer_chain_ids IN core_owner.NUMBER_TABLE,
  out_result_set     OUT SYS_REFCURSOR
);

PROCEDURE GET_GROUP_IDS_BY_CC_INFO (
  in_last_four_cc IN CREDIT_CARD.LAST_FOUR_CC%TYPE,
  in_expiration_date IN DATE,
  in_country IN CREDIT_CARD.COUNTRY%TYPE DEFAULT NULL,
  in_postal_code IN CREDIT_CARD.POSTAL_CODE%TYPE DEFAULT NULL,
  in_city IN CREDIT_CARD.CITY%TYPE DEFAULT NULL,
  in_state IN CREDIT_CARD.STATE%TYPE DEFAULT NULL,
  in_credit_card_type_id IN CREDIT_CARD.CREDIT_CARD_TYPE_ID%TYPE DEFAULT NULL,
  in_credit_card_status_id IN CREDIT_CARD.CREDIT_CARD_STATUS_ID%TYPE DEFAULT NULL,
  in_lower_bound IN NUMBER DEFAULT 1,
  in_upper_bound IN NUMBER DEFAULT 11,
  out_result_set OUT SYS_REFCURSOR
);

END PROCS_ACCOUNT_V18;
.
/

--------------------------------------------------------------------------------
-- DDL for package PROCS_ACCOUNT_CRU
--------------------------------------------------------------------------------

CREATE OR REPLACE PACKAGE "PROCS_ACCOUNT_CRU_V18" AS 

PROCEDURE CREATE_ACCOUNT (
  out_account_id        OUT ACCOUNT.ID%TYPE,
  in_account_status_id  IN ACCOUNT.ACCOUNT_STATUS_ID%TYPE,
  in_suspend_date       IN ACCOUNT.SUSPEND_DATE%TYPE DEFAULT NULL,
  in_group_id           IN ACCOUNT.GROUP_ID%TYPE,
  in_created_by         IN ACCOUNT.CREATED_BY%TYPE,
  in_system_category_id IN ACCOUNT.SYSTEM_CATEGORY_ID%TYPE,
  in_instrument_type_id IN ACCOUNT.INSTRUMENT_TYPE_ID%TYPE DEFAULT NULL,
  in_instrument_id      IN ACCOUNT.INSTRUMENT_ID%TYPE DEFAULT NULL
);

PROCEDURE UPDATE_ACCOUNT (
  in_account_id         IN ACCOUNT.ID%TYPE,
  in_account_status_id  IN ACCOUNT.ACCOUNT_STATUS_ID%TYPE DEFAULT NULL,
  in_suspend_date       IN ACCOUNT.SUSPEND_DATE%TYPE DEFAULT NULL,
  in_updated_by         IN ACCOUNT.UPDATED_BY%TYPE,
  in_system_category_id IN ACCOUNT.SYSTEM_CATEGORY_ID%TYPE DEFAULT NULL,
  in_instrument_type_id IN ACCOUNT.INSTRUMENT_TYPE_ID%TYPE DEFAULT NULL,
  in_instrument_id      IN ACCOUNT.INSTRUMENT_ID%TYPE DEFAULT NULL
);

PROCEDURE UPDATE_DEF_FIN_INSTRUMENT(
  in_account_id         IN ACCOUNT.ID%TYPE,
  in_instrument_type_id IN ACCOUNT.INSTRUMENT_TYPE_ID%TYPE,
  in_instrument_id      IN ACCOUNT.INSTRUMENT_ID%TYPE,
  in_updated_by         IN ACCOUNT.UPDATED_BY%TYPE
);

PROCEDURE READ_ACCOUNT (
  in_account_id  IN ACCOUNT.ID%TYPE,
  out_result_set OUT SYS_REFCURSOR
);

PROCEDURE CREATE_ACCOUNT_NOTE (
  inout_account_note_id IN OUT ACCOUNT_NOTE.ID%TYPE,
  in_agent_id           IN ACCOUNT_NOTE.AGENT_ID%TYPE,
  in_account_id         IN ACCOUNT_NOTE.ACCOUNT_ID%TYPE,
  in_note               IN ACCOUNT_NOTE.NOTE%TYPE,
  in_created_by         IN ACCOUNT_NOTE.CREATED_BY%TYPE
);

END PROCS_ACCOUNT_CRU_V18;
.
/

CREATE OR REPLACE PACKAGE "PROCS_ADDRESS_V18" AS

PROCEDURE CREATE_ADDRESS(
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
    out_address_id        OUT NUMBER,
    in_address1           IN ADDRESS.ADDRESS1%TYPE DEFAULT NULL,
    in_address2           IN ADDRESS.ADDRESS2%TYPE DEFAULT NULL,
    in_city               IN ADDRESS.CITY%TYPE DEFAULT NULL,
    in_state              IN ADDRESS.STATE%TYPE DEFAULT NULL,
    in_postal_code        IN ADDRESS.POSTAL_CODE%TYPE DEFAULT NULL,
    in_country            IN ADDRESS.COUNTRY%TYPE DEFAULT NULL,
    in_created_by         IN ADDRESS.CREATED_BY%TYPE
);

PROCEDURE UPDATE_ADDRESS(
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
    in_address_id         IN ADDRESS.ID%TYPE,
    in_address1           IN ADDRESS.ADDRESS1%TYPE DEFAULT NULL,
    in_address2           IN ADDRESS.ADDRESS2%TYPE DEFAULT NULL,
    in_city               IN ADDRESS.CITY%TYPE DEFAULT NULL,
    in_state              IN ADDRESS.STATE%TYPE DEFAULT NULL,
    in_postal_code        IN ADDRESS.POSTAL_CODE%TYPE DEFAULT NULL,
    in_country            IN ADDRESS.COUNTRY%TYPE DEFAULT NULL,
    in_updated_by         IN ADDRESS.UPDATED_BY%TYPE
);

PROCEDURE GET_ADDRESS (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
    in_id                 IN ADDRESS.ID%TYPE,
    out_result_set        OUT SYS_REFCURSOR
);

END PROCS_ADDRESS_V18;
.
/

--------------------------------------------------------------------------------
-- DDL for package PROCS_ADDRESS_CRU
--------------------------------------------------------------------------------

CREATE OR REPLACE PACKAGE "PROCS_ADDRESS_CRU_V18" AS 

PROCEDURE CREATE_ADDRESS(
  out_address_id        OUT ADDRESS.ID%TYPE,
  in_address_id         IN ADDRESS.ID%TYPE DEFAULT NULL,
  in_address1           IN ADDRESS.ADDRESS1%TYPE DEFAULT NULL,
  in_address2           IN ADDRESS.ADDRESS2%TYPE DEFAULT NULL,
  in_city               IN ADDRESS.CITY%TYPE DEFAULT NULL,
  in_state              IN ADDRESS.STATE%TYPE DEFAULT NULL,
  in_postal_code        IN ADDRESS.POSTAL_CODE%TYPE DEFAULT NULL,
  in_country            IN ADDRESS.COUNTRY%TYPE DEFAULT NULL,
  in_created_by         IN ADDRESS.CREATED_BY%TYPE
);

PROCEDURE UPDATE_ADDRESS(
  in_address_id         IN ADDRESS.ID%TYPE,
  in_address1           IN ADDRESS.ADDRESS1%TYPE DEFAULT NULL,
  in_address2           IN ADDRESS.ADDRESS2%TYPE DEFAULT NULL,
  in_city               IN ADDRESS.CITY%TYPE DEFAULT NULL,
  in_state              IN ADDRESS.STATE%TYPE DEFAULT NULL,
  in_postal_code        IN ADDRESS.POSTAL_CODE%TYPE DEFAULT NULL,
  in_country            IN ADDRESS.COUNTRY%TYPE DEFAULT NULL,
  in_updated_by         IN ADDRESS.UPDATED_BY%TYPE
);

END PROCS_ADDRESS_CRU_V18;
.
/

--------------------------------------------------------------------------------
-- DDL for package PROCS_ADJUSTMENTS
--------------------------------------------------------------------------------

CREATE OR REPLACE PACKAGE "PROCS_ADJUSTMENTS_V18" AS 

PROCEDURE CREATE_INVOICE_ADJUSTMENT (
  in_invoice_id             IN NUMBER,
  in_adjustment_reason      IN VARCHAR2,
  in_is_credit              IN NUMBER,
  in_charge_id              IN NUMBER,
  in_business_date          IN DATE,
  in_created_by             IN VARCHAR2,
  out_invoice_adjustment_id OUT NUMBER
);

PROCEDURE UPDATE_INVOICE_ADJUSTMENT (
  in_invoice_id             IN NUMBER,
  in_original_charge_id     IN NUMBER,
  in_charge_id              IN NUMBER,
  in_updated_by             IN VARCHAR2
);

PROCEDURE CREATE_LINE_ITEM_ADJUSTMENT (
  in_line_item_id             IN NUMBER,
  in_invoice_adjustment_id    IN NUMBER,
  in_amount                   IN NUMBER,
  in_tax                      IN NUMBER,
  in_discount                 IN NUMBER,
  in_created_by               IN VARCHAR2,
  out_line_item_adjustment_id OUT NUMBER
);

PROCEDURE CREATE_TAX_ADJUSTMENT (
  in_tax_id                  IN NUMBER,
  in_line_item_adjustment_id IN NUMBER,
  in_amount                  IN NUMBER,
  in_created_by              IN VARCHAR2,
  out_tax_adjustment_id      OUT NUMBER
);

PROCEDURE CREATE_DISCOUNT_LI_ADJUSTMENT (
  in_discount_id             NUMBER,
  in_line_item_id            NUMBER,
  in_line_item_adjustment_id IN NUMBER,
  in_amount                  IN NUMBER,
  in_created_by              IN VARCHAR2,
  out_discount_li_id         OUT NUMBER
);

END PROCS_ADJUSTMENTS_V18;
.
/

CREATE OR REPLACE PACKAGE "PROCS_ADX_V18" AS

PROCEDURE GET_SUB_ADX_INFO (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  out_result_set      OUT SYS_REFCURSOR,
  in_group_id    IN ACCOUNT.GROUP_ID%TYPE
);

END PROCS_ADX_V18;
.
/

CREATE OR REPLACE PACKAGE "PROCS_AMAZON_V18" AS

PROCEDURE CREATE_AMAZON_SUB(
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
    out_id              OUT NUMBER,
    in_subscription_id  IN AMAZON_SUB.SUBSCRIPTION_ID%TYPE,
    in_amazon_id        IN AMAZON_SUB.AMAZON_ID%TYPE,
    in_created_by       IN AMAZON_SUB.CREATED_BY%TYPE
);

PROCEDURE GET_ACTIVE_SUB_IDS (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  out_result_set      OUT SYS_REFCURSOR,
  in_amazon_id    IN AMAZON_SUB.AMAZON_ID%TYPE
);

PROCEDURE GET_ACTIVE_GROUP_IDS (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  out_result_set      OUT SYS_REFCURSOR,
  in_amazon_id    IN AMAZON_SUB.AMAZON_ID%TYPE
);

END PROCS_AMAZON_V18;
.
/

CREATE OR REPLACE PACKAGE "PROCS_AMAZON_CRU_V18" AS

PROCEDURE CREATE_AMAZON_SUB(
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
    out_id              OUT NUMBER,
    in_subscription_id  IN AMAZON_SUB.SUBSCRIPTION_ID%TYPE,
    in_amazon_id        IN AMAZON_SUB.AMAZON_ID%TYPE,
    in_created_by       IN AMAZON_SUB.CREATED_BY%TYPE
);

END PROCS_AMAZON_CRU_V18;
.
/

--------------------------------------------------------------------------------
-- DDL for package PROCS_CHARGE
--------------------------------------------------------------------------------

CREATE OR REPLACE PACKAGE "PROCS_CHARGE_V18" AS 

PROCEDURE CREATE_CHARGE(
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_invoice_id         IN NUMBER,
  in_transaction_id     IN NUMBER,
  in_instrument_type_id IN NUMBER,
  in_instrument_id      IN NUMBER,
  in_charge_amount      IN NUMBER,
  in_created_by         IN VARCHAR2,
  in_charge_status_id   IN NUMBER,
  out_charge_id         OUT NUMBER
);

PROCEDURE GET_PENDING_REFUND_CHARGES (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  out_result_set      OUT SYS_REFCURSOR,
  in_row_number       IN NUMBER DEFAULT NULL
);

PROCEDURE GET_UNPROCESSED_CHARGES (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_invoice_id  IN NUMBER,
  out_result_set OUT SYS_REFCURSOR
);

PROCEDURE GET_PROCESSED_CHARGES (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_invoice_id  IN NUMBER,
  out_result_set OUT SYS_REFCURSOR
);

PROCEDURE GET_SUBSCR_ID_BY_CHARGE_ID (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_charge_id        IN NUMBER,
  out_subscription_id OUT NUMBER
);

PROCEDURE UPDATE_CHARGE_STATUS (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_charge_id        IN CHARGE.ID%TYPE,
  in_charge_status_id IN CHARGE.CHARGE_STATUS_ID%TYPE,
  in_updated_by       IN CHARGE.UPDATED_BY%TYPE
);

FUNCTION IS_CHARGE_COLLECTED (
/*
Throws:
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
Returns:
GLOBAL_CONST.TRUE if transaction collected,
GLOBAL_CONST.FALSE else
*/
  in_charge_id IN NUMBER
) RETURN NUMBER;

PROCEDURE GET_COLLECTED_CHARGES (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_invoice_id  IN NUMBER,
  out_result_set OUT SYS_REFCURSOR
);

END PROCS_CHARGE_V18;
.
/

--------------------------------------------------------------------------------
-- DDL for package PROCS_CHARGE_CRU
--------------------------------------------------------------------------------

CREATE OR REPLACE PACKAGE "PROCS_CHARGE_CRU_V18" AS 

PROCEDURE CREATE_CHARGE(
  out_charge_id         OUT CHARGE.ID%TYPE,
  in_charge_id          IN CHARGE.ID%TYPE DEFAULT NULL,
  in_invoice_id         IN CHARGE.INVOICE_ID%TYPE,
  in_transaction_id     IN CHARGE.TRANSACTION_ID%TYPE DEFAULT NULL,
  in_instrument_type_id IN CHARGE.INSTRUMENT_TYPE_ID%TYPE,
  in_instrument_id      IN CHARGE.INSTRUMENT_ID%TYPE,
  in_charge_amount      IN CHARGE.CHARGE_AMOUNT%TYPE,
  in_charge_status_id   IN CHARGE.CHARGE_STATUS_ID%TYPE,
  in_created_by         IN CHARGE.CREATED_BY%TYPE
);

PROCEDURE UPDATE_CHARGE(
  in_charge_id          IN CHARGE.ID%TYPE,
  in_instrument_type_id IN CHARGE.INSTRUMENT_TYPE_ID%TYPE DEFAULT NULL,
  in_instrument_id      IN CHARGE.INSTRUMENT_ID%TYPE DEFAULT NULL,
  in_charge_amount      IN CHARGE.CHARGE_AMOUNT%TYPE DEFAULT NULL,
  in_charge_status_id   IN CHARGE.CHARGE_STATUS_ID%TYPE DEFAULT NULL,
  in_updated_by         IN CHARGE.UPDATED_BY%TYPE
);

END PROCS_CHARGE_CRU_V18;
.
/

CREATE OR REPLACE PACKAGE "PROCS_CUPY" AS

  PROCEDURE POPULATE_REQUEST_INFO(
    in_hours_prior    IN  NUMBER,
    in_filename       IN  CC_REQUEST_FILE.FILE_NAME%TYPE,
    in_creator        IN  CC_REQUEST_FILE.UPDATED_BY%TYPE
  );

  PROCEDURE CHASE_PROFILE_BY_REQ_FILE_ID(
    in_request_file_id IN CC_UPDATE.CC_REQUEST_FILE_ID%TYPE,
    in_start           IN NUMBER,
    in_end             IN NUMBER,
    out_result_set     OUT SYS_REFCURSOR
  );

  PROCEDURE UPDATE_REQUEST_FILE_STATUS(
    in_request_file_id IN CC_REQUEST_FILE.ID%TYPE,
    in_status          IN CC_REQUEST_FILE.CC_REQUEST_FILE_STATUS%TYPE,
    in_updated_by      IN CC_REQUEST_FILE.UPDATED_BY%TYPE
  );

  PROCEDURE UPDATE_CC_REQUEST_STATUS(
    in_request_file_id IN CC_UPDATE.CC_REQUEST_FILE_ID%TYPE,
    in_status          IN CC_UPDATE.CC_UPDATE_STATUS%TYPE,
    in_updated_by      IN CC_UPDATE.UPDATED_BY%TYPE
  );

  PROCEDURE REQUEST_FILES_BY_STATUS (
    in_status           IN  CC_REQUEST_FILE.CC_REQUEST_FILE_STATUS%TYPE,
    in_older_than_hours IN  NUMBER DEFAULT -288,
    out_request_files   OUT SYS_REFCURSOR
  );

  PROCEDURE COUNT_BY_REQUEST_FILE_ID (
    in_id     IN  CC_UPDATE.CC_REQUEST_FILE_ID%TYPE,
    out_count OUT NUMBER
  );

  PROCEDURE GET_CREDIT_CARD_LICENSE (
    in_chase_profile_id  IN  CREDIT_CARD.CHASE_PROFILE_ID%TYPE,
    in_request_filename  IN  CC_REQUEST_FILE.FILE_NAME%TYPE DEFAULT NULL,
    out_card_license     OUT SYS_REFCURSOR
  );

  PROCEDURE UPDATE_CC_UPDATE(
    in_id              IN CC_UPDATE.ID%TYPE,
    in_status          IN CC_UPDATE.CC_UPDATE_STATUS%TYPE,
    in_action          IN CC_UPDATE.CC_UPDATE_ACTION%TYPE DEFAULT NULL,
    in_reason          IN CC_UPDATE.CC_UPDATE_REASON%TYPE DEFAULT NULL,
    in_response_proc_status_code IN CC_UPDATE.RESPONSE_PROC_STATUS_CODE%TYPE DEFAULT NULL,
    in_response_proc_status_msg  IN CC_UPDATE.RESPONSE_PROC_STATUS_MESSAGE%TYPE DEFAULT NULL,
    in_updated_by      IN CC_UPDATE.UPDATED_BY%TYPE
  );

  PROCEDURE UPDATE_CC_UPDATE_STATUS(
    in_id         IN CC_UPDATE.ID%TYPE,
    in_status     IN CC_UPDATE.CC_UPDATE_STATUS%TYPE,
    in_updated_by IN CC_UPDATE.UPDATED_BY%TYPE
  );

  PROCEDURE GET_REQUEST_FILE_BY_FILENAME (
    in_request_filename  IN  CC_REQUEST_FILE.FILE_NAME%TYPE,
    out_request_file     OUT SYS_REFCURSOR
  );

  PROCEDURE SUSPEND_CREDIT_CARD (
    in_credit_card_id  IN CREDIT_CARD.ID%TYPE,
    in_updated_by      IN CREDIT_CARD.UPDATED_BY%TYPE
  );

  PROCEDURE UPDATE_CREDIT_CARD (
    in_credit_card_id   IN CREDIT_CARD.ID%TYPE,
    in_last_four_cc     IN CREDIT_CARD.LAST_FOUR_CC%TYPE,
    in_expiration_date  IN CREDIT_CARD.EXPIRATION_DATE%TYPE,
    in_updated_by       IN CREDIT_CARD.UPDATED_BY%TYPE
  );

  PROCEDURE COMPLETABLE_REQUESTS (
    out_request_files OUT SYS_REFCURSOR
  );

  PROCEDURE COMPLETABLE_REQUESTS_W_FAILS (
    in_max_hours_before_report IN  NUMBER,
    out_request_files          OUT SYS_REFCURSOR
  );

END PROCS_CUPY;
.
/

CREATE OR REPLACE
PACKAGE PROCS_ENTITLEMENT_V18 AS

PROCEDURE GET_ALL_ENTITLEMENTS(
  in_group_id IN NUMBER,
  out_result_set OUT SYS_REFCURSOR);

PROCEDURE GET_ITUNES_ENTITLEMENTS(
  in_product_id IN CORE_OWNER.ITUNES_RECEIPT.PRODUCT_ID%TYPE,
  out_result_set OUT SYS_REFCURSOR);

PROCEDURE GET_ARCHIVE_ENTITLEMENT_URI(
  in_subscription_id IN NUMBER,
  out_uri OUT VARCHAR2);

END PROCS_ENTITLEMENT_V18;
.
/

--------------------------------------------------------------------------------
-- DDL for package PROCS_FIN_INSTRUMENTS
--------------------------------------------------------------------------------

CREATE OR REPLACE PACKAGE "PROCS_FIN_INSTRUMENTS_V18" AS

PROCEDURE UPDATE_GC_STATUS_BY_INVOICE (
    in_invoice_id IN GIFT_CERTIFICATE.PURCHASE_INVOICE_ID%TYPE,
    in_status_id  IN GIFT_CERTIFICATE_STATUS.ID%TYPE,
    in_updater    IN GIFT_CERTIFICATE.UPDATED_BY%TYPE
);

PROCEDURE IS_INVOICE_FOR_REDEEMED_GC (
  in_invoice_id                IN NUMBER,
  out_is_invoice_for_redeem_gc OUT NUMBER
);

PROCEDURE GET_UNREDEEMED_GCS (
  out_result_set          OUT SYS_REFCURSOR,
  in_hours_number         IN NUMBER DEFAULT 14*24,
  in_num_rows             IN NUMBER DEFAULT 10000,
  in_process_name         IN PROCESS_RETRY_THROTTLE.PROCESS_NAME%TYPE
);

PROCEDURE GET_GC_ID_BY_PURCH_INVOICE_ID (
in_invoice_id IN GIFT_CERTIFICATE.PURCHASE_INVOICE_ID%TYPE,
out_gift_certificate_id OUT GIFT_CERTIFICATE.ID%TYPE
);

PROCEDURE ADD_CREDIT_CARD (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_group_id               IN NUMBER,
  in_updated_by             IN VARCHAR2,
  in_instrument_name        IN VARCHAR2,
  in_card_holder_name       IN VARCHAR2,
  in_street_address         IN VARCHAR2,
  in_street_address2        IN VARCHAR2,
  in_state                  IN VARCHAR2,
  in_city                   IN VARCHAR2,
  in_postal_code            IN VARCHAR2,
  in_country                IN CHAR,
  in_last_four_cc           IN VARCHAR2,
  in_expiration_date        IN DATE,
  in_credit_card_type_id    IN NUMBER,
  in_token                  IN VARCHAR2,
  in_chase_profile_id       IN VARCHAR2,
  in_credit_card_status_id  IN NUMBER,
  in_private_first_name     IN VARCHAR2,
  in_private_last_name      IN VARCHAR2,
  out_credit_card_id        OUT NUMBER
);

/******************************************************************************/

PROCEDURE ADD_PAYPAL (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_group_id                     IN NUMBER,
  in_instrument_name              IN VARCHAR2,
  in_private_email_address        IN VARCHAR2,
  in_created_by                   IN VARCHAR2,
  in_paypal_status_id             IN NUMBER,
  in_paypal_prvt_street_address   IN VARCHAR2,
  in_paypal_prvt_street_address2  IN VARCHAR2,
  in_state                        IN VARCHAR2,
  in_city                         IN VARCHAR2,
  in_postal_code                  IN VARCHAR2,
  in_country                      IN CHAR,
  in_expiration_date              IN DATE,
  in_secret_token                 IN VARCHAR2,
  out_paypal_id                   OUT NUMBER
);

/********************************************/

PROCEDURE GET_GIFT_CERTIFICATE_BY_CODE (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND,
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_code       IN VARCHAR,
  out_result_set OUT SYS_REFCURSOR
);

/********************************************/

PROCEDURE GET_GIFT_CERTIFICATE_BY_ID (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND,
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_gift_certificate_id IN NUMBER,
  out_result_set         OUT SYS_REFCURSOR
);

/********************************************/

PROCEDURE DISABLE_CREDIT_CARD (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
APP_EXCEPTION_CODES_V18.INTERNAL_ERROR
*/
  in_credit_card_id IN NUMBER,
  in_updated_by     IN VARCHAR2
);

/********************************************/

PROCEDURE DISABLE_PAYPAL (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
APP_EXCEPTION_CODES_V18.INTERNAL_ERROR
*/
  in_paypal_id  IN NUMBER,
  in_updated_by IN VARCHAR2
);

/********************************************/

PROCEDURE UPDATE_CREDIT_CARD (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_credit_card_id         IN NUMBER,
  in_updated_by             IN VARCHAR2,
  in_instrument_name        IN VARCHAR2,
  in_is_default             IN NUMBER
);

/********************************************/

PROCEDURE START_GC_PURCHASING (
  in_group_id               IN NUMBER,
  in_offer_chain_id         IN VARCHAR2,
  in_gift_certificate_code  IN  VARCHAR2,
  in_created_by             IN  VARCHAR2,
  in_recipient_name         IN  VARCHAR2,
  in_recipient_email        IN  VARCHAR2,
  in_recipient_address_id   IN NUMBER,
  in_recipient_notify_date  IN DATE,
  in_sender_name            IN VARCHAR2,
  in_sender_email           IN VARCHAR2,
  in_gift_message           IN  VARCHAR2,
  in_expiration_date        IN DATE,
  out_gift_certificate_id   OUT NUMBER,
  out_invoice_id            OUT NUMBER
);

PROCEDURE FINALIZE_GC_PURCHASING (
  in_invoice_id         IN NUMBER,
  in_created_by         IN VARCHAR2,
  in_instrument_id      IN NUMBER,
  in_instrument_type_id IN NUMBER,
  in_order_id           IN VARCHAR2,
  in_transaction_id     IN NUMBER,
  out_charge_amount     OUT NUMBER
);

PROCEDURE PURCHASE_GIFT_CERTIFICATE (
  in_group_id       IN NUMBER,
  in_offer_chain_id IN VARCHAR2,
  in_gift_certificate_code  IN  VARCHAR2,
  in_created_by IN  VARCHAR2,
  in_recipient_name IN  VARCHAR2,
  in_recipient_email IN  VARCHAR2,
  in_sender_name IN VARCHAR2,
  in_sender_email IN VARCHAR2,
  in_gift_message IN  VARCHAR2,
  in_instrument_id  IN  NUMBER,
  in_instrument_type_id IN NUMBER,
  in_expiration_date IN DATE,
  in_order_id IN VARCHAR2,
  in_transaction_id IN NUMBER
);

/*********************************************/

PROCEDURE REDEEM_GIFT_CERTIFICATE (
  in_group_id                     IN NUMBER,
  in_gift_certificate_code        IN VARCHAR2,
  in_created_by                   IN VARCHAR2,
  in_redeemer_address_id          IN NUMBER,
  in_fin_instrument_id            IN NUMBER,
  in_fin_instrument_type_id       IN NUMBER,
  in_redemption_offer_chain_id    IN NUMBER,
  out_subscription_id             OUT NUMBER,
  out_license_id                  OUT NUMBER
);

/********************************************/

PROCEDURE GET_DEF_FINANCIAL_INSTRUMENT (
  in_group_id            IN  NUMBER,
  out_instrument_type_id OUT NUMBER,
  out_instrument_id      OUT NUMBER
);

/************************************************/

PROCEDURE SET_DEF_FINANCIAL_INSTRUMENT (
  in_group_id           IN NUMBER,
  in_instrument_type_id IN NUMBER,
  in_instrument_id      IN NUMBER,
  in_updated_by         IN VARCHAR2
);

/***************************************************/

PROCEDURE DEL_DEF_FINANCIAL_INSTRUMENT (
  in_group_id           IN NUMBER
);

/****************************************************/

PROCEDURE GET_CREDIT_CARD_BY_ID (
  in_credit_card_id IN  NUMBER,
  out_result_set    OUT SYS_REFCURSOR
);

/****************************************************/

PROCEDURE GET_PAYPAL_BY_ID (
  in_paypal_id   IN  NUMBER,
  out_result_set OUT SYS_REFCURSOR
);

/***********************************************/

FUNCTION F_CAN_DISABLE_CREDIT_CARD (
  in_credit_card_id NUMBER
) RETURN NUMBER;

/*************************************************/

PROCEDURE GET_PURCHASED_GCERTIFICATES (
  in_group_id    IN NUMBER,
  out_result_set OUT SYS_REFCURSOR
);

/*************************************************/

-- isGiftCertificateForProperOffer

PROCEDURE IS_GCERT_FOR_PROPER_OFFER (
  in_gift_certificate_id IN NUMBER,
  in_charge_id           IN NUMBER,
  out_result             OUT NUMBER
);

FUNCTION IS_CREDIT_CARD_EXISTS (
/*
1 - if instrument exists
0 - else
*/
  in_credit_card_id IN NUMBER
) RETURN NUMBER;

FUNCTION IS_PAYPAL_EXISTS (
/*
1 - if instrument exists
0 - else
*/
  in_paypal_id IN NUMBER
) RETURN NUMBER;

FUNCTION IS_GIFT_CERTIFICATE_EXISTS (
/*
1 - if instrument exists
0 - else
*/
  in_gift_certificate_id IN NUMBER
) RETURN NUMBER;

PROCEDURE GET_GROUP_ID_BY_CREDIT_CARD_ID (
  in_credit_card_id IN NUMBER,
  out_group_id      OUT NUMBER
);

PROCEDURE GET_GROUP_ID_BY_PAYPAL_ID (
  in_paypal_id IN NUMBER,
  out_group_id      OUT NUMBER
);

PROCEDURE UPDATE_CREDIT_CARD_STATUS (
  in_credit_card_id        IN CREDIT_CARD.ID%TYPE,
  in_credit_card_status_id IN CREDIT_CARD.CREDIT_CARD_STATUS_ID%TYPE,
  in_updated_by            IN CREDIT_CARD.UPDATED_BY%TYPE
);

PROCEDURE UPDATE_PAYPAL_STATUS (
  in_paypal_id        IN PAYPAL.ID%TYPE,
  in_paypal_status_id IN PAYPAL.PAYPAL_STATUS_ID%TYPE,
  in_updated_by       IN PAYPAL.UPDATED_BY%TYPE
);

PROCEDURE UPDATE_GIFT_CERTIFICATE_STATUS (
  in_gift_certificate_id        IN GIFT_CERTIFICATE.ID%TYPE,
  in_gift_certificate_status_id IN GIFT_CERTIFICATE.GIFT_CERTIFICATE_STATUS_ID%TYPE,
  in_updated_by                 IN GIFT_CERTIFICATE.UPDATED_BY%TYPE
);

PROCEDURE GET_GC_BY_PURCH_INVOICE_ID (
  in_invoice_id           IN GIFT_CERTIFICATE.PURCHASE_INVOICE_ID%TYPE,
  out_result_set OUT SYS_REFCURSOR
);

PROCEDURE SWITCH_FINANCIAL_INSTRUMENT (
  /*in_group_id                IN NUMBER  -- TODO: should we pass group_id here?*/
  in_old_fin_instrument_id   IN NUMBER,
  in_old_fin_instrument_type IN NUMBER,
  in_new_fin_instrument_id   IN NUMBER,
  in_new_fin_instrument_type IN NUMBER,
  in_updated_by              IN VARCHAR2
);

END PROCS_FIN_INSTRUMENTS_V18;
.
/

--------------------------------------------------------------------------------
-- DDL for package PROCS_FIN_INSTRUMENTS_CRU
--------------------------------------------------------------------------------

CREATE OR REPLACE PACKAGE "PROCS_FIN_INSTRUMENTS_CRU_V18" AS 

PROCEDURE CREATE_CREDIT_CARD(
  out_credit_card_id          OUT CREDIT_CARD.ID%TYPE,
  in_credit_card_id           IN CREDIT_CARD.ID%TYPE DEFAULT NULL,
  in_account_id               IN CREDIT_CARD.ACCOUNT_ID%TYPE,
  in_instrument_name          IN CREDIT_CARD.INSTRUMENT_NAME%TYPE,
  in_private_card_holder_name IN CREDIT_CARD.PRIVATE_CARD_HOLDER_NAME%TYPE,
  in_private_street_address   IN CREDIT_CARD.PRIVATE_STREET_ADDRESS%TYPE,
  in_private_street_address2  IN CREDIT_CARD.PRIVATE_STREET_ADDRESS2%TYPE DEFAULT NULL,
  in_state                    IN CREDIT_CARD.STATE%TYPE,
  in_city                     IN CREDIT_CARD.CITY%TYPE,
  in_postal_code              IN CREDIT_CARD.POSTAL_CODE%TYPE,
  in_country                  IN CREDIT_CARD.COUNTRY%TYPE,
  in_last_four_cc             IN CREDIT_CARD.LAST_FOUR_CC%TYPE,
  in_expiration_date          IN CREDIT_CARD.EXPIRATION_DATE%TYPE,
  in_credit_card_type_id      IN CREDIT_CARD.CREDIT_CARD_TYPE_ID%TYPE,
  in_secret_token             IN CREDIT_CARD.SECRET_TOKEN%TYPE,
  in_chase_profile_id         IN CREDIT_CARD.CHASE_PROFILE_ID%TYPE,
  in_created_by               IN CREDIT_CARD.CREATED_BY%TYPE,
  in_credit_card_status_id    IN CREDIT_CARD.CREDIT_CARD_STATUS_ID%TYPE,
  in_private_first_name       IN CREDIT_CARD.PRIVATE_FIRST_NAME%TYPE,
  in_private_last_name        IN CREDIT_CARD.PRIVATE_LAST_NAME%TYPE
);

PROCEDURE UPDATE_CREDIT_CARD(
  in_credit_card_id           IN CREDIT_CARD.ID%TYPE,
  in_instrument_name          IN CREDIT_CARD.INSTRUMENT_NAME%TYPE DEFAULT NULL,
  in_private_card_holder_name IN CREDIT_CARD.PRIVATE_CARD_HOLDER_NAME%TYPE DEFAULT NULL,
  in_private_street_address   IN CREDIT_CARD.PRIVATE_STREET_ADDRESS%TYPE DEFAULT NULL,
  in_private_street_address2  IN CREDIT_CARD.PRIVATE_STREET_ADDRESS2%TYPE DEFAULT NULL,
  in_state                    IN CREDIT_CARD.STATE%TYPE DEFAULT NULL,
  in_city                     IN CREDIT_CARD.CITY%TYPE DEFAULT NULL,
  in_postal_code              IN CREDIT_CARD.POSTAL_CODE%TYPE DEFAULT NULL,
  in_country                  IN CREDIT_CARD.COUNTRY%TYPE DEFAULT NULL,
  in_last_four_cc             IN CREDIT_CARD.LAST_FOUR_CC%TYPE DEFAULT NULL,
  in_expiration_date          IN CREDIT_CARD.EXPIRATION_DATE%TYPE DEFAULT NULL,
  in_credit_card_type_id      IN CREDIT_CARD.CREDIT_CARD_TYPE_ID%TYPE DEFAULT NULL,
  in_secret_token             IN CREDIT_CARD.SECRET_TOKEN%TYPE DEFAULT NULL,
  in_chase_profile_id         IN CREDIT_CARD.CHASE_PROFILE_ID%TYPE DEFAULT NULL,
  in_updated_by               IN CREDIT_CARD.UPDATED_BY%TYPE,
  in_credit_card_status_id    IN CREDIT_CARD.CREDIT_CARD_STATUS_ID%TYPE DEFAULT NULL,
  in_private_first_name       IN CREDIT_CARD.PRIVATE_FIRST_NAME%TYPE DEFAULT NULL,
  in_private_last_name        IN CREDIT_CARD.PRIVATE_LAST_NAME%TYPE DEFAULT NULL
);

PROCEDURE CREATE_PAYPAL(
  out_paypal_id                   OUT PAYPAL.ID%TYPE,
  in_paypal_id                    IN PAYPAL.ID%TYPE DEFAULT NULL,
  in_account_id                   IN PAYPAL.ACCOUNT_ID%TYPE,
  in_instrument_name              IN PAYPAL.INSTRUMENT_NAME%TYPE DEFAULT NULL,
  in_private_email_address        IN PAYPAL.PRIVATE_EMAIL_ADDRESS%TYPE DEFAULT NULL,
  in_created_by                   IN PAYPAL.CREATED_BY%TYPE,
  in_paypal_status_id             IN PAYPAL.PAYPAL_STATUS_ID%TYPE,
  in_paypal_prvt_street_address   IN PAYPAL.PRIVATE_STREET_ADDRESS%TYPE,
  in_paypal_prvt_street_address2  IN PAYPAL.PRIVATE_STREET_ADDRESS%TYPE,
  in_state                        IN PAYPAL.STATE%TYPE,
  in_city                         IN PAYPAL.CITY%TYPE,
  in_postal_code                  IN PAYPAL.POSTAL_CODE%TYPE,
  in_country                      IN PAYPAL.COUNTRY%TYPE,
  in_expiration_date              IN PAYPAL.EXPIRATION_DATE%TYPE,
  in_secret_token                 IN PAYPAL.SECRET_TOKEN%TYPE
);

PROCEDURE UPDATE_PAYPAL(
  in_paypal_id                    IN PAYPAL.ID%TYPE,
  in_instrument_name              IN PAYPAL.INSTRUMENT_NAME%TYPE DEFAULT NULL,
  in_private_email_address        IN PAYPAL.PRIVATE_EMAIL_ADDRESS%TYPE DEFAULT NULL,
  in_updated_by                   IN PAYPAL.UPDATED_BY%TYPE,
  in_paypal_status_id             IN PAYPAL.PAYPAL_STATUS_ID%TYPE DEFAULT NULL,
  in_paypal_prvt_street_address   IN PAYPAL.PRIVATE_STREET_ADDRESS%TYPE DEFAULT NULL,
  in_paypal_prvt_street_address2  IN PAYPAL.PRIVATE_STREET_ADDRESS%TYPE DEFAULT NULL,
  in_state                        IN PAYPAL.STATE%TYPE DEFAULT NULL,
  in_city                         IN PAYPAL.CITY%TYPE DEFAULT NULL,
  in_postal_code                  IN PAYPAL.POSTAL_CODE%TYPE DEFAULT NULL,
  in_country                      IN PAYPAL.COUNTRY%TYPE DEFAULT NULL,
  in_expiration_date              IN PAYPAL.EXPIRATION_DATE%TYPE DEFAULT NULL,
  in_secret_token                 IN PAYPAL.SECRET_TOKEN%TYPE DEFAULT NULL
);

PROCEDURE CREATE_GIFT_CERTIFICATE(
  out_gift_certificate_id       OUT GIFT_CERTIFICATE.ID%TYPE,
  in_gift_certificate_id        IN GIFT_CERTIFICATE.ID%TYPE DEFAULT NULL,
  in_purchaser_group_id         IN GIFT_CERTIFICATE.PURCHASER_GROUP_ID%TYPE,
  in_purchaser_invoice_id       IN GIFT_CERTIFICATE.PURCHASE_INVOICE_ID%TYPE,
  in_offer_chain_id             IN GIFT_CERTIFICATE.OFFER_CHAIN_ID%TYPE,
  in_expiration_date            IN GIFT_CERTIFICATE.EXPIRATION_DATE%TYPE DEFAULT NULL,
  in_purchase_date              IN GIFT_CERTIFICATE.PURCHASE_DATE%TYPE,
  in_gift_certificate_status_id IN GIFT_CERTIFICATE.GIFT_CERTIFICATE_STATUS_ID%TYPE,
  in_code                       IN GIFT_CERTIFICATE.CODE%TYPE,
  in_created_by                 IN GIFT_CERTIFICATE.CREATED_BY%TYPE,
  in_recipient_name             IN GIFT_CERTIFICATE.RECIPIENT_NAME%TYPE DEFAULT NULL,
  in_gift_message               IN GIFT_CERTIFICATE.GIFT_MESSAGE%TYPE DEFAULT NULL,
  in_recipient_email            IN GIFT_CERTIFICATE.RECIPIENT_EMAIL%TYPE DEFAULT NULL,
  in_finalized_invoice_id       IN GIFT_CERTIFICATE.FINALIZED_INVOICE_ID%TYPE DEFAULT NULL,
  in_sender_email               IN GIFT_CERTIFICATE.SENDER_EMAIL%TYPE,
  in_sender_name                IN GIFT_CERTIFICATE.SENDER_NAME%TYPE,
  in_redemption_date            IN GIFT_CERTIFICATE.REDEMPTION_DATE%TYPE DEFAULT NULL,
  in_cancelation_date           IN GIFT_CERTIFICATE.CANCELATION_DATE%TYPE DEFAULT NULL,
  in_redeemer_group_id          IN GIFT_CERTIFICATE.REDEEMER_GROUP_ID%TYPE DEFAULT NULL,
  in_recipient_address_id       IN GIFT_CERTIFICATE.RECIPIENT_ADDRESS_ID%TYPE DEFAULT NULL,
  in_recipient_notify_date      IN GIFT_CERTIFICATE.RECIPIENT_NOTIFY_DATE%TYPE DEFAULT NULL
);

PROCEDURE UPDATE_GIFT_CERTIFICATE(
  in_gift_certificate_id        IN GIFT_CERTIFICATE.ID%TYPE,
  in_expiration_date            IN GIFT_CERTIFICATE.EXPIRATION_DATE%TYPE DEFAULT NULL,
  in_gift_certificate_status_id IN GIFT_CERTIFICATE.GIFT_CERTIFICATE_STATUS_ID%TYPE DEFAULT NULL,
  in_code                       IN GIFT_CERTIFICATE.CODE%TYPE DEFAULT NULL,
  in_updated_by                 IN GIFT_CERTIFICATE.UPDATED_BY%TYPE,
  in_recipient_name             IN GIFT_CERTIFICATE.RECIPIENT_NAME%TYPE DEFAULT NULL,
  in_gift_message               IN GIFT_CERTIFICATE.GIFT_MESSAGE%TYPE DEFAULT NULL,
  in_recipient_email            IN GIFT_CERTIFICATE.RECIPIENT_EMAIL%TYPE DEFAULT NULL,
  in_finalized_invoice_id       IN GIFT_CERTIFICATE.FINALIZED_INVOICE_ID%TYPE DEFAULT NULL,
  in_sender_email               IN GIFT_CERTIFICATE.SENDER_EMAIL%TYPE DEFAULT NULL,
  in_sender_name                IN GIFT_CERTIFICATE.SENDER_NAME%TYPE DEFAULT NULL,
  in_redemption_date            IN GIFT_CERTIFICATE.REDEMPTION_DATE%TYPE DEFAULT NULL,
  in_cancelation_date           IN GIFT_CERTIFICATE.CANCELATION_DATE%TYPE DEFAULT NULL,
  in_redeemer_group_id          IN GIFT_CERTIFICATE.REDEEMER_GROUP_ID%TYPE DEFAULT NULL,
  in_recipient_address_id       IN GIFT_CERTIFICATE.RECIPIENT_ADDRESS_ID%TYPE DEFAULT NULL,
  in_redeemer_address_id        IN GIFT_CERTIFICATE.REDEEMER_ADDRESS_ID%TYPE DEFAULT NULL,
  in_recipient_notify_date      IN GIFT_CERTIFICATE.RECIPIENT_NOTIFY_DATE%TYPE DEFAULT NULL
);

END PROCS_FIN_INSTRUMENTS_CRU_V18;
.
/

--------------------------------------------------------------------------------
-- DDL for package PROCS_GROUP_ACCOUNT
--------------------------------------------------------------------------------

CREATE OR REPLACE PACKAGE "PROCS_GROUP_ACCOUNT_V18" As

PROCEDURE UPDATE_SS_NEED_ENTITLEMENTS (
  in_sub_share_id      IN SUBSCRIPTION_SHARE.ID%TYPE,
  in_need_entitlements IN SUBSCRIPTION_SHARE.NEEDS_ENTITLEMENTS%TYPE,
  in_updater           IN SUBSCRIPTION_SHARE.UPDATED_BY%TYPE
);

PROCEDURE SUB_EXPIRES_NEED_ENTITLEMENTS (
  out_result_set OUT SYS_REFCURSOR
);

PROCEDURE EXPIRE_SUB_SHARE (
  in_sub_share_id IN SUBSCRIPTION_SHARE.ID%TYPE,
  in_updater      IN SUBSCRIPTION_SHARE.UPDATED_BY%TYPE
);

PROCEDURE EXPIRE_ALL_SHARES (
  in_group_account_id IN SUBSCRIPTION_SHARE.GROUP_ACCOUNT_ID%TYPE,
  in_updated_by       IN SUBSCRIPTION_SHARE.UPDATED_BY%TYPE
);

PROCEDURE SUB_SHARE_BY_GROUP_ID (
  in_group_id      IN  ACCOUNT.GROUP_ID%TYPE,
  in_start         IN  NUMBER,
  in_end           IN  NUMBER,
  in_expired       IN  NUMBER,
  out_result_set   OUT SYS_REFCURSOR,
  out_shares_count OUT NUMBER  
);

PROCEDURE IS_VALID_IP_ADDRESS (
  in_group_account_id IN GROUP_ACCOUNT_IP_RANGE.GROUP_ACCOUNT_ID%TYPE,
  in_ip_low           IN GROUP_ACCOUNT_IP_RANGE.MINIMUM_IP_LOW%TYPE,
  in_ip_high          IN GROUP_ACCOUNT_IP_RANGE.MINIMUM_IP_HIGH%TYPE,
  out_is_valid        OUT NUMBER
);

PROCEDURE IS_VALID_EMAIL_DOMAIN (
  in_group_account_id IN GROUP_ACCOUNT_EMAIL_DOMAIN.GROUP_ACCOUNT_ID%TYPE,
  in_email_domain     IN GROUP_ACCOUNT_EMAIL_DOMAIN.EMAIL_DOMAIN%TYPE,
  out_is_valid        OUT NUMBER
);

PROCEDURE GET_SUBSCRIPTION_SHARE (
  in_group_account_id    IN SUBSCRIPTION_SHARE.GROUP_ACCOUNT_ID%TYPE,
  in_borrower_account_id IN SUBSCRIPTION_SHARE.BORROWER_ACCOUNT_ID%TYPE,
  Out_Result_Set         Out Sys_Refcursor
);

PROCEDURE GET_SUBSCRIPTION_SHARES (
  in_group_account_id IN NUMBER,
  in_start            IN NUMBER,
  in_end              IN NUMBER,
  Out_Result_Set      OUT Sys_Refcursor
);

PROCEDURE GET_GROUP_ACCOUNT_BY_SUB_ID (
  in_subscription_id IN Group_Account.SUBSCRIPTION_ID%TYPE,
  Out_Result_Set     Out Sys_Refcursor
);

PROCEDURE CREATE_GROUP_ACCOUNT (
  in_subscription_id       IN NUMBER,
  in_group_name            IN VARCHAR2,
  in_first_name            IN VARCHAR2,
  in_last_name             IN VARCHAR2,
  in_email                 IN VARCHAR2,
  in_phone                 IN VARCHAR2,
  in_organization_type     IN VARCHAR2,
  in_seats                 IN NUMBER,
  in_seat_ttl_in_hours     IN NUMBER,
  in_ip                    IN NUMBER,
  in_created_by            IN VARCHAR2
);

PROCEDURE GET_GROUP_ACCOUNT_BY_EMAIL (
  in_email_domain     IN GROUP_ACCOUNT_EMAIL_DOMAIN.EMAIL_DOMAIN%TYPE,
  out_result_set      OUT SYS_REFCURSOR
);

PROCEDURE GET_GROUP_ACCOUNT_BY_IP (
  in_ip_low           IN GROUP_ACCOUNT_IP_RANGE.MINIMUM_IP_LOW%TYPE,
  in_ip_high          IN GROUP_ACCOUNT_IP_RANGE.MINIMUM_IP_HIGH%TYPE,
  out_result_set      OUT SYS_REFCURSOR
);

PROCEDURE GET_GROUP_ACCOUNT_IP_RANGES (
  in_group_account_id   IN NUMBER,
  in_start              IN NUMBER,
  in_end                IN NUMBER,
  in_status             IN NUMBER,
  out_record_count      OUT NUMBER,
  out_result_set        OUT SYS_REFCURSOR
);

PROCEDURE GET_GRP_ACCNT_EMAIL_DOMAINS (
  in_group_account_id   IN GROUP_ACCOUNT_EMAIL_DOMAIN.GROUP_ACCOUNT_ID%TYPE, 
  in_start              IN NUMBER,
  in_end                IN NUMBER,
  in_status             IN GROUP_ACCOUNT_EMAIL_DOMAIN.IS_ACTIVE%TYPE,
  out_record_count      OUT NUMBER,
  out_result_set        OUT SYS_REFCURSOR
);

PROCEDURE ADD_EMAIL_DOMAIN (
  in_group_account_id IN GROUP_ACCOUNT_EMAIL_DOMAIN.GROUP_ACCOUNT_ID%TYPE,
  in_email_domain IN GROUP_ACCOUNT_EMAIL_DOMAIN.EMAIL_DOMAIN%TYPE,	
  in_created_by IN GROUP_ACCOUNT_EMAIL_DOMAIN.CREATED_BY%TYPE
);

PROCEDURE DISABLE_EMAIL_DOMAIN_BY_GA_ID(
  in_group_account_id IN GROUP_ACCOUNT_EMAIL_DOMAIN.GROUP_ACCOUNT_ID%TYPE,
  in_updated_by IN GROUP_ACCOUNT_EMAIL_DOMAIN.UPDATED_BY%TYPE
);

PROCEDURE DISABLE_EMAIL_DOMAIN_BY_ID(
  in_id IN GROUP_ACCOUNT_EMAIL_DOMAIN.ID%TYPE,
  in_updated_by IN GROUP_ACCOUNT_EMAIL_DOMAIN.UPDATED_BY%TYPE
);

PROCEDURE CREATE_SUBSCRIPTION_SHARE (
  in_group_account_id    IN NUMBER,
  in_borrower_account_id IN NUMBER,
  in_ip_address          IN VARCHAR2,
  in_email_domain        IN VARCHAR2,
  in_created_by          IN VARCHAR2
);

PROCEDURE GET_NUM_OCCUPIED_GROUP_SEATS (
  in_group_account_id   IN NUMBER,
  out_occupied_seats   OUT NUMBER
);

FUNCTION F_GET_NUM_OCCUPIED_GROUP_SEATS (
  in_group_account_id   IN NUMBER
) RETURN NUMBER;

PROCEDURE DISABLE_IP_RANGES_BY_GA_ID(
  in_group_account_id IN GROUP_ACCOUNT_IP_RANGE.GROUP_ACCOUNT_ID%TYPE,
  in_updated_by IN GROUP_ACCOUNT_IP_RANGE.UPDATED_BY%TYPE
);

PROCEDURE DISABLE_IP_RANGE_BY_ID(
  in_id IN GROUP_ACCOUNT_IP_RANGE.ID%TYPE,
  in_updated_by IN GROUP_ACCOUNT_IP_RANGE.UPDATED_BY%TYPE
);

PROCEDURE ADD_IP_RANGE (
  in_group_account_id IN GROUP_ACCOUNT_IP_RANGE.GROUP_ACCOUNT_ID%TYPE,
  in_minimum_ip_string IN GROUP_ACCOUNT_IP_RANGE.MINIMUM_IP_STRING%TYPE,
  in_minimum_ip_low IN GROUP_ACCOUNT_IP_RANGE.MINIMUM_IP_LOW%TYPE,
  in_minimum_ip_high IN GROUP_ACCOUNT_IP_RANGE.MINIMUM_IP_HIGH%TYPE,
  in_maximum_ip_string IN GROUP_ACCOUNT_IP_RANGE.MAXIMUM_IP_STRING%TYPE,
  in_maximum_ip_low IN GROUP_ACCOUNT_IP_RANGE.MAXIMUM_IP_LOW%TYPE,
  in_maximum_ip_high IN GROUP_ACCOUNT_IP_RANGE.MAXIMUM_IP_HIGH%TYPE,
  in_created_by IN GROUP_ACCOUNT_IP_RANGE.CREATED_BY%TYPE
);

PROCEDURE GET_GRP_ID_BY_GRP_ACCOUNT_ID (
  in_group_account_id IN NUMBER,
  out_group_id OUT NUMBER
);

PROCEDURE GET_GRP_ID_BY_GRPACCIPRNG_ID (
  in_group_account_ip_range_id IN NUMBER,
  out_group_id OUT NUMBER
);

PROCEDURE GET_GRP_ID_BY_EMAIL_DOM_ID (
  in_group_account_email_dom_id IN NUMBER,
  out_group_id OUT NUMBER
);

PROCEDURE UPDATE_GROUP_ACCOUNT (
  in_group_account_id      IN GROUP_ACCOUNT.ID%TYPE,
  in_group_name            IN GROUP_ACCOUNT.GROUP_NAME%TYPE,
  in_first_name            IN GROUP_ACCOUNT.FIRST_NAME%TYPE,
  in_last_name             IN GROUP_ACCOUNT.LAST_NAME%TYPE,
  in_email                 IN GROUP_ACCOUNT.EMAIL%TYPE,
  in_phone                 IN GROUP_ACCOUNT.PHONE%TYPE,
  in_updated_by            IN GROUP_ACCOUNT.UPDATED_BY%TYPE
);

PROCEDURE UPDATE_GROUP_ACCOUNT_SEATS (
  in_group_account_id      IN GROUP_ACCOUNT.ID%TYPE,
  in_seats                 IN GROUP_ACCOUNT.SEATS%TYPE,
  in_updated_by            IN GROUP_ACCOUNT.UPDATED_BY%TYPE
);

END PROCS_GROUP_ACCOUNT_V18;
.
/

--------------------------------------------------------------------------------
-- DDL for package PROCS_GROUP_ACCOUNT
--------------------------------------------------------------------------------

CREATE OR REPLACE PACKAGE "PROCS_GROUP_ACCOUNT_CRU_V18" AS

PROCEDURE UPDATE_SUBSCRIPTION_SHARE (
  in_id                  IN SUBSCRIPTION_SHARE.ID%TYPE,
  in_group_account_id    IN SUBSCRIPTION_SHARE.GROUP_ACCOUNT_ID%TYPE DEFAULT NULL,
  in_borrower_account_id IN SUBSCRIPTION_SHARE.BORROWER_ACCOUNT_ID%TYPE DEFAULT NULL,
  in_ip_address          IN SUBSCRIPTION_SHARE.IP_ADDRESS%TYPE DEFAULT NULL,
  in_start_date          IN SUBSCRIPTION_SHARE.START_DATE%TYPE DEFAULT NULL,
  in_end_date            IN SUBSCRIPTION_SHARE.END_DATE%TYPE DEFAULT NULL,
  in_needs_entitlements  IN SUBSCRIPTION_SHARE.NEEDS_ENTITLEMENTS%TYPE DEFAULT NULL,
  in_updated_by          IN SUBSCRIPTION_SHARE.UPDATED_BY%TYPE
);

PROCEDURE CREATE_GROUP_ACCOUNT (
  in_subscription_id       IN NUMBER,
  in_group_name            IN VARCHAR2,
  in_first_name            IN VARCHAR2,
  in_last_name             IN VARCHAR2,
  in_email                 IN VARCHAR2,
  in_phone                 IN VARCHAR2,
  in_organization_type     IN VARCHAR2,
  in_seats                 IN NUMBER,
  in_seat_ttl_in_hours     IN NUMBER,
  in_ip                    IN NUMBER,
  in_created_by            IN VARCHAR2
);

PROCEDURE CREATE_SUBSCRIPTION_SHARE (
  in_group_account_id    IN NUMBER,
  in_borrower_account_id IN NUMBER,
  in_ip_address          IN VARCHAR2,
  in_email_domain        IN VARCHAR2,
  in_start_date          IN DATE,
  in_end_date            IN DATE,
  in_created_by          IN VARCHAR2
);

PROCEDURE DISABLE_IP_RANGES_BY_GA_ID(
  in_group_account_id IN GROUP_ACCOUNT_IP_RANGE.GROUP_ACCOUNT_ID%TYPE,
  in_updated_by IN GROUP_ACCOUNT_IP_RANGE.UPDATED_BY%TYPE
);

PROCEDURE DISABLE_IP_RANGE_BY_ID(
  in_id IN GROUP_ACCOUNT_IP_RANGE.ID%TYPE,
  in_updated_by IN GROUP_ACCOUNT_IP_RANGE.UPDATED_BY%TYPE
);

PROCEDURE ADD_IP_RANGE (
  in_group_account_id IN GROUP_ACCOUNT_IP_RANGE.GROUP_ACCOUNT_ID%TYPE,
  in_minimum_ip_string IN GROUP_ACCOUNT_IP_RANGE.MINIMUM_IP_STRING%TYPE,
  in_minimum_ip_low IN GROUP_ACCOUNT_IP_RANGE.MINIMUM_IP_LOW%TYPE,
  in_minimum_ip_high IN GROUP_ACCOUNT_IP_RANGE.MINIMUM_IP_HIGH%TYPE,
  in_maximum_ip_string IN GROUP_ACCOUNT_IP_RANGE.MAXIMUM_IP_STRING%TYPE,
  in_maximum_ip_low IN GROUP_ACCOUNT_IP_RANGE.MAXIMUM_IP_LOW%TYPE,
  in_maximum_ip_high IN GROUP_ACCOUNT_IP_RANGE.MAXIMUM_IP_HIGH%TYPE,
  in_created_by IN GROUP_ACCOUNT_IP_RANGE.CREATED_BY%TYPE
);

PROCEDURE DISABLE_EMAIL_DOMAIN_BY_GA_ID(
  in_group_account_id IN GROUP_ACCOUNT_EMAIL_DOMAIN.GROUP_ACCOUNT_ID%TYPE,
  in_updated_by IN GROUP_ACCOUNT_EMAIL_DOMAIN.UPDATED_BY%TYPE
);

PROCEDURE DISABLE_EMAIL_DOMAIN_BY_ID(
  in_id IN GROUP_ACCOUNT_EMAIL_DOMAIN.ID%TYPE,
  in_updated_by IN GROUP_ACCOUNT_EMAIL_DOMAIN.UPDATED_BY%TYPE
);

PROCEDURE ENABLE_EMAIL_DOMAIN_BY_ID(
  in_id IN GROUP_ACCOUNT_EMAIL_DOMAIN.ID%TYPE,
  in_updated_by IN GROUP_ACCOUNT_EMAIL_DOMAIN.UPDATED_BY%TYPE
);

PROCEDURE ADD_EMAIL_DOMAIN (
  in_group_account_id IN GROUP_ACCOUNT_EMAIL_DOMAIN.GROUP_ACCOUNT_ID%TYPE,
  in_email_domain IN GROUP_ACCOUNT_EMAIL_DOMAIN.EMAIL_DOMAIN%TYPE,
  in_is_active IN  GROUP_ACCOUNT_EMAIL_DOMAIN.IS_ACTIVE%TYPE,
  in_created_by IN GROUP_ACCOUNT_EMAIL_DOMAIN.CREATED_BY%TYPE
);

PROCEDURE UPDATE_GROUP_ACCOUNT (
  in_group_account_id      IN GROUP_ACCOUNT.ID%TYPE,
  in_group_name            IN GROUP_ACCOUNT.GROUP_NAME%TYPE,
  in_first_name            IN GROUP_ACCOUNT.FIRST_NAME%TYPE,
  in_last_name             IN GROUP_ACCOUNT.LAST_NAME%TYPE,
  in_email                 IN GROUP_ACCOUNT.EMAIL%TYPE,
  in_phone                 IN GROUP_ACCOUNT.PHONE%TYPE,
  in_updated_by            IN GROUP_ACCOUNT.UPDATED_BY%TYPE
);

PROCEDURE UPDATE_GROUP_ACCOUNT_SEATS (
  in_group_account_id      IN GROUP_ACCOUNT.ID%TYPE,
  in_seats                 IN GROUP_ACCOUNT.SEATS%TYPE,
  in_updated_by            IN GROUP_ACCOUNT.UPDATED_BY%TYPE
);
END PROCS_GROUP_ACCOUNT_CRU_V18;
.
/

--------------------------------------------------------------------------------
-- DDL for package PROCS_HISTORY
--------------------------------------------------------------------------------

CREATE OR REPLACE PACKAGE "PROCS_HISTORY_V18" AS 

PROCEDURE CREATE_ADDRESS_HISTORY(
/*
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
APP_EXCEPTION_CODES_V18.INTERNAL_ERROR
*/
  in_address_id                IN NUMBER,
  in_system_activity_reason_id IN NUMBER
);

PROCEDURE CREATE_ACCOUNT_HISTORY(
/*
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
APP_EXCEPTION_CODES_V18.INTERNAL_ERROR
*/
  in_account_id                IN NUMBER,
  in_system_activity_reason_id IN NUMBER
);

PROCEDURE CREATE_SUBSCRIPTION_HISTORY (
/*
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
APP_EXCEPTION_CODES_V18.INTERNAL_ERROR
*/
  in_subscription_id           IN NUMBER,
  in_system_activity_reason_id IN NUMBER
);

PROCEDURE CREATE_CREDIT_CARD_HISTORY(
/*
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
APP_EXCEPTION_CODES_V18.INTERNAL_ERROR
*/
  in_credit_card_id             IN NUMBER,
  in_system_activity_reason_id  IN  NUMBER
);

PROCEDURE CREATE_PAYPAL_HISTORY(
/*
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
APP_EXCEPTION_CODES_V18.INTERNAL_ERROR
*/
  in_paypal_id                  IN NUMBER,
  in_system_activity_reason_id  IN NUMBER
);

PROCEDURE CREATE_GIFT_CERT_HISTORY(
/*
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
APP_EXCEPTION_CODES_V18.INTERNAL_ERROR
*/
  in_gift_certificate_id        IN NUMBER,
  in_system_activity_reason_id  IN  NUMBER
);

PROCEDURE CREATE_TRANSACTION_HISTORY (
/*
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
APP_EXCEPTION_CODES_V18.INTERNAL_ERROR
*/
  in_transaction_id            IN NUMBER,
  in_system_activity_reason_id IN NUMBER
);

PROCEDURE CREATE_INVOICE_HISTORY (
/*
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
APP_EXCEPTION_CODES_V18.INTERNAL_ERROR
*/
  in_invoice_id                IN NUMBER,
  in_system_activity_reason_id IN NUMBER
);

PROCEDURE CREATE_LICENSE_HISTORY (
/*
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
APP_EXCEPTION_CODES_V18.INTERNAL_ERROR
*/
  in_license_id                IN NUMBER,
  in_system_activity_reason_id IN NUMBER
);

PROCEDURE CREATE_CHARGE_HISTORY (
/*
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
APP_EXCEPTION_CODES_V18.INTERNAL_ERROR
*/
  in_charge_id                IN NUMBER,
  in_system_activity_reason_id IN NUMBER
);

PROCEDURE CREATE_INVOICE_ADJ_HISTORY (
/*
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
APP_EXCEPTION_CODES_V18.INTERNAL_ERROR
*/
  in_invoice_adjustment_id     IN NUMBER,
  in_system_activity_reason_id IN NUMBER
);


END PROCS_HISTORY_V18;
.
/

--------------------------------------------------------------------------------
-- DDL for package PROCS_INVOICE
--------------------------------------------------------------------------------

CREATE OR REPLACE PACKAGE "PROCS_INVOICE_V18" AS

PROCEDURE GET_INVOICE_IDS(
  in_group_id    IN ACCOUNT.GROUP_ID%TYPE,
  in_fin_id      IN SUBSCRIPTION.INSTRUMENT_ID%TYPE,
  out_result_set OUT SYS_REFCURSOR
);

PROCEDURE IS_INVOICE_FOR_GC (
  in_invoice_id  IN NUMBER,
  out_result     OUT NUMBER
);

PROCEDURE CREATE_INVOICE(
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
    in_invoice_status IN NUMBER,
    in_created_by     IN VARCHAR2,
    in_tax_exempt_id  IN VARCHAR2,
    out_invoice_id    OUT NUMBER
);

PROCEDURE GET_PENDING_INVOICES (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  out_result_set1      OUT SYS_REFCURSOR,
  out_result_set2      OUT SYS_REFCURSOR,
  out_result_set3      OUT SYS_REFCURSOR,
  in_row_number        IN NUMBER DEFAULT NULL
);

PROCEDURE CALCULATE_INVOICE_AMOUNT (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_invoice_id IN  NUMBER,
  out_amount    OUT NUMBER
);

FUNCTION F_CALCULATE_INVOICE_AMOUNT(
  in_invoice_id IN  NUMBER
) RETURN NUMBER;

PROCEDURE GET_ACCOUNT_BY_INVOICE_ID (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_invoice_id  IN  NUMBER,
  out_account_id OUT NUMBER
);

PROCEDURE GET_INVOICE_DETAILS (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_invoice_id      IN  NUMBER,
  out_group_id       OUT NUMBER,
  out_status_id      OUT NUMBER,
  out_line_items_set OUT SYS_REFCURSOR,
  out_pp_charges_set OUT SYS_REFCURSOR,
  out_cc_charges_set OUT SYS_REFCURSOR,
  out_gc_charges_set OUT SYS_REFCURSOR
);
-- norlov: #38796
PROCEDURE GET_TRANSACTION_INVOICE (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_transaction_id  IN  NUMBER,
  out_result_set        OUT SYS_REFCURSOR
);  

PROCEDURE UPDATE_INVOICE_STATUS (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_invoice_id                  IN NUMBER,
  in_invoice_status_id           IN NUMBER,
  in_updated_by                  IN VARCHAR2
);

FUNCTION IS_INVOICE_PAYING_STARTED (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_invoice_id IN NUMBER
) RETURN NUMBER;

PROCEDURE P_IS_INVOICE_PAYING_STARTED (
  in_invoice_id  IN NUMBER,
  out_is_started OUT NUMBER
);

PROCEDURE CALCULATE_INVOICE_CHARGEBACK (
  in_invoice_id         IN NUMBER,
  in_chargeback_date    IN DATE,
  out_chargeback_amount OUT NUMBER
);

PROCEDURE APPLY_REFUND (
  in_invoice_id        IN NUMBER,
  in_chargeback_amount IN NUMBER,
  in_created_by        IN VARCHAR2,
  out_charge_id        OUT NUMBER
);

PROCEDURE GET_MAX_REFUND (
  in_invoice_id IN NUMBER,
  out_amount    OUT NUMBER
);

PROCEDURE GET_INVOICE_DAYS_USED_NUMBER (
  in_invoice_id       IN NUMBER,
  in_chargeback_date  IN DATE DEFAULT SYSDATE,
  out_days_num        OUT NUMBER
);

PROCEDURE GET_INVOICE_LINE_ITEMS (
  in_invoice_id  IN NUMBER,
  out_result_set OUT SYS_REFCURSOR
);

PROCEDURE GET_INVOICE_LICENSES (
  in_invoice_id  IN NUMBER,
  out_result_set OUT SYS_REFCURSOR
);

PROCEDURE GET_OFFER_CH_ID_BY_INVOICE_ID (
  in_invoice_id      IN NUMBER,
  out_offer_chain_id OUT NUMBER
);

PROCEDURE CLOSE_INVOICE_AS_NOT_COLLECTED (
-- Closing invoice without refund
  in_invoice_id IN NUMBER,
  in_updated_by IN VARCHAR2
);

PROCEDURE GET_SUBSCR_ID_BY_INVOICE_ID (
  in_invoice_id       IN NUMBER,
  out_subscription_id OUT NUMBER
);

PROCEDURE IS_INVOICE_TAX_EXEMPT (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND,
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
Return:
  GLOBAL_CONSTANTS_V18.TRUE if ACCOUNT.EXEMPT_ID is not null
  GLOBAL_CONSTANTS_V18.FALSE else
*/
  in_invoice_id     IN NUMBER,
  out_is_tax_exempt OUT NUMBER
);

PROCEDURE GET_INVOICE_BY_ID (
  in_invoice_id  IN NUMBER,
  out_result_set OUT SYS_REFCURSOR
);

PROCEDURE GET_IS_TAX_CALCULATION_NEEDED (
  in_invoice_id                 IN NUMBER,
  out_is_tax_calculation_needed OUT NUMBER
);

PROCEDURE SET_IS_TAX_CALCULATION_NEEDED (
  in_invoice_id                IN NUMBER,
  in_updated_by                IN VARCHAR2,
  in_is_tax_calculation_needed IN NUMBER
);

PROCEDURE REFUND_INVOICE (
  in_invoice_id      IN NUMBER,
  in_refund_amount   IN NUMBER,
  in_note            IN VARCHAR2,
  in_created_by      IN VARCHAR2,
  out_charge_id      OUT NUMBER
);

PROCEDURE GET_PAYMENT_INFO_BY_INVOICE_ID (
  in_invoice_id               IN NUMBER,
  out_order_id                OUT VARCHAR2,
  out_external_transaction_id OUT VARCHAR2
);

PROCEDURE GET_INVOICE_BY_TRNS_ORDER_ID (
  in_order_id  IN TRANSACTION.ORDER_ID%TYPE,
  out_result_set OUT SYS_REFCURSOR
);

PROCEDURE IS_REVOKE_ENTITLEMENTS(
  in_invoice_id IN NUMBER,
  out_is_revoke OUT NUMBER
);

END PROCS_INVOICE_V18;
.
/

--------------------------------------------------------------------------------
-- DDL for package PROCS_INVOICE_CRU
--------------------------------------------------------------------------------

CREATE OR REPLACE PACKAGE "PROCS_INVOICE_CRU_V18" AS 

PROCEDURE CREATE_INVOICE (
  out_invoice_id                 OUT INVOICE.ID%TYPE,
  in_invoice_id                  IN INVOICE.ID%TYPE DEFAULT NULL,
  in_invoice_status_id           IN INVOICE.INVOICE_STATUS_ID%TYPE,
  in_tax_exempt_id               IN INVOICE.TAX_EXEMPT_ID%TYPE,
  in_created_by                  IN INVOICE.CREATED_BY%TYPE
);

PROCEDURE UPDATE_INVOICE (
  in_invoice_id                  IN INVOICE.ID%TYPE,
  in_updated_by                  IN INVOICE.UPDATED_BY%TYPE,
  in_invoice_status_id           IN INVOICE.INVOICE_STATUS_ID%TYPE DEFAULT NULL,
  in_is_tax_calculation_needed   IN INVOICE.IS_TAX_CALCULATION_NEEDED%TYPE DEFAULT NULL
);

END PROCS_INVOICE_CRU_V18;
.
/

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


CREATE OR REPLACE PACKAGE "PROCS_ITUNES_RECEIPT_V18" AS

PROCEDURE ITUNES_RECEIPT_SUBSCRIPTION(
	/*
	Throws exceptions:
	APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
	*/
	in_original_transaction_id IN ITUNES_RECEIPT.ORIGINAL_TRANSACTION_ID%TYPE,
	out_result_set      OUT SYS_REFCURSOR
);
	
PROCEDURE CREATE_RECEIPT(
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
    out_id              OUT NUMBER,
    in_subscription_id  IN ITUNES_RECEIPT.SUBSCRIPTION_ID%TYPE,
    in_receipt          IN ITUNES_RECEIPT.RECEIPT%TYPE,
    in_status           IN ITUNES_RECEIPT.STATUS%TYPE,
    in_quantity         IN ITUNES_RECEIPT.QUANTITY%TYPE,
    in_product_id       IN ITUNES_RECEIPT.PRODUCT_ID%TYPE,
    in_transaction_id   IN ITUNES_RECEIPT.TRANSACTION_ID%TYPE,
    in_purchase_date    IN ITUNES_RECEIPT.PURCHASE_DATE%TYPE,
    in_original_transaction_id IN ITUNES_RECEIPT.ORIGINAL_TRANSACTION_ID%TYPE,
    in_original_purchase_date IN ITUNES_RECEIPT.ORIGINAL_PURCHASE_DATE%TYPE,
    in_app_item_id      IN ITUNES_RECEIPT.APP_ITEM_ID%TYPE,
    in_version_external_id IN ITUNES_RECEIPT.VERSION_EXTERNAL_ID%TYPE,
    in_bid              IN ITUNES_RECEIPT.BID%TYPE,
    in_bvrs             IN ITUNES_RECEIPT.BVRS%TYPE,
    in_expires_date     IN ITUNES_RECEIPT.EXPIRES_DATE%TYPE,
    in_created_by       IN ITUNES_RECEIPT.CREATED_BY%TYPE
);

PROCEDURE UPDATE_RECEIPT(
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
    in_id               IN ITUNES_RECEIPT.ID%TYPE,
    in_receipt          IN ITUNES_RECEIPT.RECEIPT%TYPE,
    in_status           IN ITUNES_RECEIPT.STATUS%TYPE,
    in_quantity         IN ITUNES_RECEIPT.QUANTITY%TYPE,
    in_product_id       IN ITUNES_RECEIPT.PRODUCT_ID%TYPE,
    in_transaction_id   IN ITUNES_RECEIPT.TRANSACTION_ID%TYPE,
    in_purchase_date    IN ITUNES_RECEIPT.PURCHASE_DATE%TYPE,
    in_original_transaction_id IN ITUNES_RECEIPT.ORIGINAL_TRANSACTION_ID%TYPE,
    in_original_purchase_date IN ITUNES_RECEIPT.ORIGINAL_PURCHASE_DATE%TYPE,
    in_app_item_id      IN ITUNES_RECEIPT.APP_ITEM_ID%TYPE,
    in_version_external_id IN ITUNES_RECEIPT.VERSION_EXTERNAL_ID%TYPE,
    in_bid              IN ITUNES_RECEIPT.BID%TYPE,
    in_bvrs             IN ITUNES_RECEIPT.BVRS%TYPE,
    in_expires_date     IN ITUNES_RECEIPT.EXPIRES_DATE%TYPE,
    in_updated_by       IN ITUNES_RECEIPT.UPDATED_BY%TYPE,
    in_is_expired       IN NUMBER
);

PROCEDURE LINK_ITUNES_RECEIPT(
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
    in_id               IN ITUNES_RECEIPT.ID%TYPE,
    in_subscription_id  IN ITUNES_RECEIPT.SUBSCRIPTION_ID%TYPE,
    in_updated_by       IN ITUNES_RECEIPT.UPDATED_BY%TYPE
);

PROCEDURE MARK_RECEIPT_CHECKED(
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
    in_id       IN ITUNES_RECEIPT.ID%TYPE
);

PROCEDURE GET_ITUNES_RECEIPTS (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  out_result_set      OUT SYS_REFCURSOR,
  in_row_number       IN NUMBER DEFAULT 500
);

PROCEDURE GET_VENDOR_FROM_ITUNES_PID(
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
    out_vendor_source_id OUT OFFER_CHAIN.VENDOR_SOURCE_ID%TYPE,
    in_itunes_pid        IN ITUNES_RECEIPT.PRODUCT_ID%TYPE
);

END PROCS_ITUNES_RECEIPT_V18;
.
/

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


CREATE OR REPLACE PACKAGE "PROCS_ITUNES_RECEIPT_CRU_V18" AS

PROCEDURE CREATE_RECEIPT(
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
    out_id              OUT NUMBER,
    in_subscription_id  IN CORE_OWNER.ITUNES_RECEIPT.SUBSCRIPTION_ID%TYPE,
    in_receipt          IN CORE_OWNER.ITUNES_RECEIPT.RECEIPT%TYPE,
    in_status           IN CORE_OWNER.ITUNES_RECEIPT.STATUS%TYPE,
    in_quantity         IN CORE_OWNER.ITUNES_RECEIPT.QUANTITY%TYPE,
    in_product_id       IN CORE_OWNER.ITUNES_RECEIPT.PRODUCT_ID%TYPE,
    in_transaction_id   IN CORE_OWNER.ITUNES_RECEIPT.TRANSACTION_ID%TYPE,
    in_purchase_date    IN CORE_OWNER.ITUNES_RECEIPT.PURCHASE_DATE%TYPE,
    in_original_transaction_id IN CORE_OWNER.ITUNES_RECEIPT.ORIGINAL_TRANSACTION_ID%TYPE,
    in_original_purchase_date IN CORE_OWNER.ITUNES_RECEIPT.ORIGINAL_PURCHASE_DATE%TYPE,
    in_app_item_id      IN CORE_OWNER.ITUNES_RECEIPT.APP_ITEM_ID%TYPE,
    in_version_external_id IN CORE_OWNER.ITUNES_RECEIPT.VERSION_EXTERNAL_ID%TYPE,
    in_bid              IN CORE_OWNER.ITUNES_RECEIPT.BID%TYPE,
    in_bvrs             IN CORE_OWNER.ITUNES_RECEIPT.BVRS%TYPE,
    in_expires_date     IN CORE_OWNER.ITUNES_RECEIPT.EXPIRES_DATE%TYPE,
    in_created_by       IN CORE_OWNER.ITUNES_RECEIPT.CREATED_BY%TYPE
);

PROCEDURE UPDATE_RECEIPT(
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
    in_id               IN CORE_OWNER.ITUNES_RECEIPT.ID%TYPE,
    in_receipt          IN CORE_OWNER.ITUNES_RECEIPT.RECEIPT%TYPE,
    in_status           IN CORE_OWNER.ITUNES_RECEIPT.STATUS%TYPE,
    in_quantity         IN CORE_OWNER.ITUNES_RECEIPT.QUANTITY%TYPE,
    in_product_id       IN CORE_OWNER.ITUNES_RECEIPT.PRODUCT_ID%TYPE,
    in_transaction_id   IN CORE_OWNER.ITUNES_RECEIPT.TRANSACTION_ID%TYPE,
    in_purchase_date    IN CORE_OWNER.ITUNES_RECEIPT.PURCHASE_DATE%TYPE,
    in_original_transaction_id IN CORE_OWNER.ITUNES_RECEIPT.ORIGINAL_TRANSACTION_ID%TYPE,
    in_original_purchase_date IN CORE_OWNER.ITUNES_RECEIPT.ORIGINAL_PURCHASE_DATE%TYPE,
    in_app_item_id      IN CORE_OWNER.ITUNES_RECEIPT.APP_ITEM_ID%TYPE,
    in_version_external_id IN CORE_OWNER.ITUNES_RECEIPT.VERSION_EXTERNAL_ID%TYPE,
    in_bid              IN CORE_OWNER.ITUNES_RECEIPT.BID%TYPE,
    in_bvrs             IN CORE_OWNER.ITUNES_RECEIPT.BVRS%TYPE,
    in_expires_date     IN CORE_OWNER.ITUNES_RECEIPT.EXPIRES_DATE%TYPE,
    in_updated_by       IN CORE_OWNER.ITUNES_RECEIPT.UPDATED_BY%TYPE,
    in_cancel_date      IN CORE_OWNER.ITUNES_RECEIPT.CANCEL_DATE%TYPE
);

PROCEDURE LINK_ITUNES_RECEIPT(
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
    in_id               IN CORE_OWNER.ITUNES_RECEIPT.ID%TYPE,
    in_subscription_id  IN CORE_OWNER.ITUNES_RECEIPT.SUBSCRIPTION_ID%TYPE,
    in_updated_by       IN CORE_OWNER.ITUNES_RECEIPT.UPDATED_BY%TYPE
);

PROCEDURE MARK_RECEIPT_CHECKED(
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
    in_id               IN CORE_OWNER.ITUNES_RECEIPT.ID%TYPE
);

END PROCS_ITUNES_RECEIPT_CRU_V18;
.
/

--------------------------------------------------------------------------------
-- DDL for package PROCS_LICENSE
--------------------------------------------------------------------------------

CREATE OR REPLACE PACKAGE "PROCS_LICENSE_V18" AS 

PROCEDURE CREATE_LICENSE(
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
APP_EXCEPTION_CODES_V18.INTERNAL_ERROR
*/
  in_status_id                IN NUMBER,
  in_needs_entitlements       IN NUMBER,
  in_start_date               IN DATE,
  in_end_date                 IN DATE,
  in_offer_id                 IN NUMBER,
  in_subscription_id          IN NUMBER,
  in_invoice_id               IN NUMBER,
  in_created_by               IN VARCHAR2,
  in_is_extension             IN NUMBER,
  in_current_offer_index      IN NUMBER,
  in_current_offer_recurr_num IN NUMBER,
  out_license_id              OUT NUMBER
);

/*********************************************/

PROCEDURE UPDATE_LICENSE_STATUS(
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
    in_license_id     IN NUMBER,
    in_license_status IN NUMBER,
    in_updated_by     IN VARCHAR2,
    in_ent_end        IN NUMBER DEFAULT GLOBAL_CONSTANTS_V18.FALSE
);

/*********************************************/

PROCEDURE GET_ENDING_LICENSES (
  in_hours_number IN NUMBER,
  out_result_set OUT SYS_REFCURSOR
);

/*********************************************/

PROCEDURE GET_ENDING_LICENSES_CC (
  in_hours_number IN NUMBER,
  out_result_set OUT SYS_REFCURSOR,
  in_process_name IN PROCESS_RETRY_THROTTLE.PROCESS_NAME%TYPE
);

/**********************************************/

PROCEDURE GET_RECURRING_OFFER (
  in_license_id  IN NUMBER,
  out_result_set OUT SYS_REFCURSOR
);

/**********************************************/

PROCEDURE GET_NEXT_OFFER (
  in_license_id  IN NUMBER,
  out_result_set OUT SYS_REFCURSOR
);

/**********************************************/

PROCEDURE GET_GROUP_ID_BY_LICENSE_ID (
  in_license_id IN NUMBER,
  out_group_id  OUT NUMBER
);

/**************************************************/

PROCEDURE GET_NEED_ENTITLEMENTS_LICENSES (
  out_result_set OUT SYS_REFCURSOR
);

/**************************************************/

PROCEDURE UPDATE_NEED_ENTITLEMENTS_FLAG (
  in_license_id         IN NUMBER,
  in_needs_entitlements IN NUMBER,
  in_updated_by         IN VARCHAR2
);

PROCEDURE GET_ENDED_GC_LICENSES (
  out_result_set          OUT SYS_REFCURSOR,
  in_hours_number         IN NUMBER DEFAULT 14*24,
  in_num_rows             IN NUMBER DEFAULT 10000,
  in_process_name         IN PROCESS_RETRY_THROTTLE.PROCESS_NAME%TYPE
);

PROCEDURE GET_LICENSE_BY_ID (

  in_license_id  IN NUMBER,

  out_result_set OUT SYS_REFCURSOR

);
PROCEDURE UP_LATEST_LICE_END_BY_SUBID (
  in_subscription_id IN NUMBER,
  in_end_date IN DATE,
  in_updated_by IN VARCHAR2
);

PROCEDURE GET_GRACE_LICE_FOR_FINAL_TRANS (
  in_days_before_close     IN NUMBER,
  in_num_licenses_to_fetch IN NUMBER,
  out_result_set           OUT SYS_REFCURSOR
);

END PROCS_LICENSE_V18;
.
/

--------------------------------------------------------------------------------
-- DDL for package PROCS_LICENSE_CRU
--------------------------------------------------------------------------------

CREATE OR REPLACE PACKAGE "PROCS_LICENSE_CRU_V18" AS 

PROCEDURE CREATE_LICENSE(
  out_license_id              OUT LICENSE.ID%TYPE,
  in_license_id               IN LICENSE.ID%TYPE DEFAULT NULL,
  in_license_status_id        IN LICENSE.LICENSE_STATUS_ID%TYPE,
  in_needs_entitlements       IN LICENSE.NEEDS_ENTITLEMENTS%TYPE,
  in_start_date               IN LICENSE.START_DATE%TYPE,
  in_offer_id                 IN LICENSE.OFFER_ID%TYPE,
  in_subscription_id          IN LICENSE.SUBSCRIPTION_ID%TYPE,
  in_invoice_id               IN LICENSE.INVOICE_ID%TYPE,
  in_end_date                 IN LICENSE.END_DATE%TYPE,
  in_created_by               IN LICENSE.CREATED_BY%TYPE,
  in_is_extension             IN LICENSE.IS_EXTENSION%TYPE,
  in_current_offer_index      IN LICENSE.CURRENT_OFFER_INDEX%TYPE,
  in_current_offer_recurr_num IN LICENSE.CURRENT_OFFER_RECURR_NUM%TYPE
);

PROCEDURE UPDATE_LICENSE (
  in_license_id               IN LICENSE.ID%TYPE,
  in_license_status_id        IN LICENSE.LICENSE_STATUS_ID%TYPE DEFAULT NULL,
  in_needs_entitlements       IN LICENSE.NEEDS_ENTITLEMENTS%TYPE DEFAULT NULL,
  in_start_date               IN LICENSE.START_DATE%TYPE DEFAULT NULL,
  in_end_date                 IN LICENSE.END_DATE%TYPE DEFAULT NULL,
  in_updated_by               IN LICENSE.CREATED_BY%TYPE,
  in_is_extension             IN LICENSE.IS_EXTENSION%TYPE DEFAULT NULL,
  in_current_offer_index      IN LICENSE.CURRENT_OFFER_INDEX%TYPE DEFAULT NULL,
  in_current_offer_recurr_num IN LICENSE.CURRENT_OFFER_RECURR_NUM%TYPE DEFAULT NULL,
  in_entitlement_end_date     IN LICENSE.ENTITLEMENT_END_DATE%TYPE DEFAULT NULL,
  in_grace_start_date         IN LICENSE.GRACE_START_DATE%TYPE DEFAULT NULL,
  in_grace_end_date           IN LICENSE.GRACE_END_DATE%TYPE DEFAULT NULL
);

END PROCS_LICENSE_CRU_V18;
.
/

--------------------------------------------------------------------------------
-- DDL for package PROCS_LINE_ITEMS
--------------------------------------------------------------------------------

CREATE OR REPLACE PACKAGE "PROCS_LINE_ITEMS_V18" AS 

PROCEDURE ADD_LINE_ITEMS(
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_invoice_id IN NUMBER,
  in_offer_id   IN NUMBER,
  in_created_by IN VARCHAR2
);

/****************************************************/

PROCEDURE UPDATE_LINE_ITEM_AMOUNT (
  in_line_item_id    IN NUMBER,
  in_amount          IN NUMBER,
  in_discount_amount IN NUMBER,
  in_taxes_amount    IN NUMBER
);

/****************************************************/

PROCEDURE GET_INVOICE_LINE_ITEMS (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_invoice_id  IN NUMBER,
  out_result_set OUT SYS_REFCURSOR
);

/****************************************************/

PROCEDURE GET_LINE_ITEM_TAXES (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_line_item_id IN  NUMBER,
  out_result_set  OUT SYS_REFCURSOR
);
/****************************************************/

PROCEDURE GET_LINE_ITEM_DISCOUNTS (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_line_item_id IN  NUMBER,
  out_result_set  OUT SYS_REFCURSOR
);

/****************************************************/

PROCEDURE CALCULATE_LINE_ITEM_AMOUNT (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_line_item_id     IN  NUMBER,
  out_amount          OUT NUMBER
);

/****************************************************/

FUNCTION F_CALCULATE_LINE_ITEM_AMOUNT (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_line_item_id     IN  NUMBER
) RETURN NUMBER;

END PROCS_LINE_ITEMS_V18;
.
/

--------------------------------------------------------------------------------
-- DDL for package PROCS_LINE_ITEMS_CRU
--------------------------------------------------------------------------------

CREATE OR REPLACE PACKAGE "PROCS_LINE_ITEMS_CRU_V18" AS 

PROCEDURE CREATE_LINE_ITEM (
  inout_line_item_id  IN OUT LINE_ITEM.ID%TYPE,
  in_product_offer_id IN LINE_ITEM.PRODUCT_OFFER_ID%TYPE,
  in_invoice_id       IN LINE_ITEM.INVOICE_ID%TYPE,
  in_amount           IN LINE_ITEM.AMOUNT%TYPE,
  in_created_by       IN LINE_ITEM.CREATED_BY%TYPE,
  in_discount_amount  IN LINE_ITEM.DISCOUNT_AMOUNT%TYPE,
  in_taxes_amount     IN LINE_ITEM.TAXES_AMOUNT%TYPE
);

PROCEDURE UPDATE_LINE_ITEM (
  in_line_item_id     IN LINE_ITEM.ID%TYPE,
  in_amount           IN LINE_ITEM.AMOUNT%TYPE DEFAULT NULL,
  in_discount_amount  IN LINE_ITEM.DISCOUNT_AMOUNT%TYPE  DEFAULT NULL,
  in_taxes_amount     IN LINE_ITEM.TAXES_AMOUNT%TYPE DEFAULT NULL
);

PROCEDURE CREATE_DISCOUNT_LINE_ITEM (
  in_discount_id  IN DISCOUNT.ID%TYPE,
  in_line_item_id IN LINE_ITEM.ID%TYPE
);

END PROCS_LINE_ITEMS_CRU_V18;
.
/

--------------------------------------------------------------------------------
-- DDL for package PROCS_LOCKING
--------------------------------------------------------------------------------

CREATE OR REPLACE PACKAGE "PROCS_LOCKING_V18" AS 

/*
Removed by Sergey
10.12.2010
PROCEDURE INITIALIZE_SYSTEM;

PROCEDURE INITIALIZE_ACCOUNT (
  in_account_id IN NUMBER
);

PROCEDURE INITIALIZE_GROUP (
  in_group_id IN NUMBER
);
*/

PROCEDURE LOCK_ACCOUNT (
  in_group_id    IN NUMBER,
  in_lock_key    IN VARCHAR2,
  in_seconds_num IN NUMBER,
  in_created_by  IN VARCHAR2,
  in_reason      IN VARCHAR2
);

PROCEDURE RELEASE_LOCK (
  in_group_id IN NUMBER,
  in_lock_key IN VARCHAR2
);

END PROCS_LOCKING_V18;
.
/

--------------------------------------------------------------------------------
-- DDL for package PROCS_NOTIFICATION
--------------------------------------------------------------------------------

CREATE OR REPLACE PACKAGE "PROCS_NOTIFICATION_V18" AS 

PROCEDURE GET_NOTIFICATION_TYPE_BY_NAME (
/*
Throws exceptions:
CORE_OWNER.APP_EXCEPTION_CODES_V18.NOT_FOUND
CORE_OWNER.APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_notification_type_name IN VARCHAR2,
  out_notification_type_id  OUT NUMBER
);

PROCEDURE ADD_NOTIFICATION (
/*
Throws exceptions:
CORE_OWNER.APP_EXCEPTION_CODES_V18.NOT_FOUND
CORE_OWNER.APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_sender_account_id     IN NUMBER DEFAULT 0,
  in_recipient_group_id    IN NUMBER,
  in_notification_type_id  IN NUMBER,
  in_date_to_notify        IN DATE,
  in_email_template_params IN CLOB
);

PROCEDURE GET_PENDING_NOTIFICATIONS (
/*
Throws exceptions:
CORE_OWNER.APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  out_result_set OUT SYS_REFCURSOR
);

PROCEDURE UPDATE_NOTIFICATION_TIMESTAMP (
/*
Throws exceptions:
CORE_OWNER.APP_EXCEPTION_CODES_V18.NOT_FOUND
CORE_OWNER.APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_notification_id IN NUMBER
);

PROCEDURE SET_NOTIFICATION_STATUS (
/*
Throws exceptions:
CORE_OWNER.APP_EXCEPTION_CODES_V18.NOT_FOUND
CORE_OWNER.APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_notification_id        IN NUMBER,
  in_notification_status_id IN NUMBER,
  in_error_message          IN VARCHAR2
);

PROCEDURE ADD_NOTIFICATION_FAILURE (
/*
Throws exceptions:
CORE_OWNER.APP_EXCEPTION_CODES_V18.NOT_FOUND
CORE_OWNER.APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_notification_id IN NUMBER,
  in_error_message   IN VARCHAR2
);

PROCEDURE LOCK_PENDING_NOTIFICATION (
/*
Result: 1 if notification locked
2 - else
*/
  in_notification_id IN NUMBER,
  out_lock_status    OUT NUMBER
);

PROCEDURE GET_NOTIFICATION_DATA (
  in_notification_id IN NUMBER,
  out_result_set     OUT SYS_REFCURSOR
);

END PROCS_NOTIFICATION_V18;
.
/

--------------------------------------------------------------------------------
-- DDL for package PROCS_OFFER_CHAIN
--------------------------------------------------------------------------------

CREATE OR REPLACE PACKAGE "PROCS_OFFER_CHAIN_V18" AS

PROCEDURE GET_OFFER_CHAIN_BY_ID (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
    in_offer_chain_id IN   NUMBER,
    out_result_set    OUT  SYS_REFCURSOR
);

PROCEDURE GET_OFFER_CHAINS_BY_IDS (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
APP_EXCEPTION_CODES_V18.INVALID_PARAMETER
*/
  in_offer_chain_ids IN core_owner.NUMBER_TABLE,
  out_result_set     OUT SYS_REFCURSOR
);

PROCEDURE GET_OFFER_CHAINS_PRODUCTS (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
APP_EXCEPTION_CODES_V18.INVALID_PARAMETER
*/
  in_offer_chain_ids IN core_owner.NUMBER_TABLE,
  out_result_set     OUT SYS_REFCURSOR
);

PROCEDURE GET_OFFER_CHAINS_OFFERS (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
APP_EXCEPTION_CODES_V18.INVALID_PARAMETER
*/
  in_offer_chain_ids IN core_owner.NUMBER_TABLE,
  out_result_set     OUT SYS_REFCURSOR
);

PROCEDURE GET_OFFER_CHAINS_BY_PRODUCT (
/*
Throws exceptions (codes):
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_product_id  IN  NUMBER,
  out_result_set OUT SYS_REFCURSOR
);

PROCEDURE GET_OFFER_CHAIN_PRICE (
/*
Throws exceptions (codes):
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_offer_chain_id IN NUMBER,
  out_price         OUT NUMBER
);

PROCEDURE GET_FIRST_OFFER(
/*
Throws exceptions (codes):
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_offer_chain_id IN  NUMBER,
  out_offer_id      OUT NUMBER
);

PROCEDURE GET_ACTIVE_OFFER_CHAINS (
/*
Throws exceptions (codes):
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  out_result_set OUT SYS_REFCURSOR
);

PROCEDURE GET_OFFER_CHAIN_PRODUCTS (
/*
Throws exceptions (codes):
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_offer_chain_id IN NUMBER,
  out_result_set    OUT SYS_REFCURSOR
);

FUNCTION CALCULATE_OFFER_CHAIN_END_DATE (
/*
Throws exceptions (codes):
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_offer_chain_id         IN NUMBER,
  in_offer_chain_start_date IN DATE
) RETURN DATE;

FUNCTION CALCULATE_OFFER_AMOUNT (
  in_offer_id IN NUMBER
) RETURN NUMBER;

FUNCTION CALCULATE_OFFER_CHAIN_AMOUNT (
  in_offer_chain_id IN NUMBER
) RETURN NUMBER;

FUNCTION GET_FIRST_OFFER_INDEX (
  in_offer_chain_id IN NUMBER
) RETURN NUMBER;

FUNCTION GET_NEXT_OFFER_INDEX (
/*
NULL, if not exists
*/
  in_offer_chain_id            IN NUMBER,
  in_offer_chain_current_index IN NUMBER
) RETURN NUMBER;

PROCEDURE P_GET_NEXT_OFFER_INDEX (
  in_offer_chain_id            IN NUMBER,
  in_offer_chain_current_index IN NUMBER,
  out_next_offer_index         OUT NUMBER
);

PROCEDURE GET_NEXT_OFFER_INDEX_BY_LCNS (
  in_license_id                IN NUMBER,
  in_offer_chain_current_index IN NUMBER,
  out_next_offer_index         OUT NUMBER
);

FUNCTION IS_OFFER_INDEX_EXISTS (
/*
1 - exists
0 - not exists
*/
  in_offer_chain_id          IN NUMBER,
  in_offer_chain_offer_index IN NUMBER
) RETURN NUMBER;

PROCEDURE GET_OFFER_LENGTH (
  in_offer_id IN NUMBER,
  out_years   OUT NUMBER,
  out_months  OUT NUMBER,
  out_days    OUT NUMBER
);

PROCEDURE GET_OFFER_LENGTH_IN_DAYS (
  in_offer_id   IN NUMBER,
  in_start_date IN DATE DEFAULT SYSDATE,
  out_days      OUT NUMBER
);

PROCEDURE GET_OFFER_PRODUCTS (
/*
Throws exceptions (codes):
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_offer_id    IN NUMBER,
  out_result_set OUT SYS_REFCURSOR
);

PROCEDURE GET_OFFER_CHAIN_PROD_OFFERINGS (
/*
Throws exceptions (codes):
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_offer_chain_id IN NUMBER,
  out_result_set    OUT SYS_REFCURSOR
);

FUNCTION CHECK_FOR_SAME_PRODUCTS (
/*
Throws exceptions (codes):
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
Returns:
GLOBAL_CONSTANTS_V18.TRUE if there are at least one same product
GLOBAL_CONSTANTS_V18.FALSE else
*/
  in_offer_chain_1         IN OFFER_CHAIN.ID%TYPE,
  in_offer_chain_2         IN OFFER_CHAIN.ID%TYPE,
  in_use_eligibility_rules IN NUMBER DEFAULT GLOBAL_CONSTANTS_V18.FALSE
) RETURN NUMBER;

FUNCTION IS_OFFER_CHAIN_CANCELABLE (
/*
Throws exceptions (codes):
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
Returns:
GLOBAL_CONSTANTS_V18.TRUE cancelation key is 1 (in OFFER_CHAIN_META_DATA)
GLOBAL_CONSTANTS_V18.FALSE else
*/
  in_offer_chain_id IN NUMBER
) RETURN NUMBER;

FUNCTION GET_OFFER_CHAIN_MAX_CONC_SUBSC (
/*
Throws exceptions (codes):
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_offer_chain_id IN NUMBER
) RETURN NUMBER;

PROCEDURE GET_OFFER_CHAIN_ELIGIBILITY (
/*
Throws exceptions (codes):
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_offer_chain_id   IN NUMBER,
  in_eligibility_name IN VARCHAR2,
  out_result_set      OUT SYS_REFCURSOR
);

PROCEDURE GET_OFFER_CHAINS_ELIGIBILITY (
/*
Throws exceptions (codes):
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_offer_chain_ids  IN VARCHAR2,
  in_eligibility_name IN VARCHAR2,
  out_result_set      OUT SYS_REFCURSOR
);

PROCEDURE GET_OFFER_CHAIN_META_DATA (
/*
Throws exceptions (codes):
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_offer_chain_id IN NUMBER,
  in_meta_data_name IN VARCHAR2,
  out_result_set    OUT SYS_REFCURSOR
);

PROCEDURE GET_OFFER_CHAINS_META_DATA (
/*
Throws exceptions (codes):
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_offer_chain_ids IN VARCHAR2,
  in_meta_data_name  IN VARCHAR2,
  out_result_set     OUT SYS_REFCURSOR
);

PROCEDURE GET_PROD_OFFERINGS_BY_OFFER_ID (
/*
Throws exceptions (codes):
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_offer_id    IN NUMBER,
  out_result_set OUT SYS_REFCURSOR
);

PROCEDURE GET_PRODUCT_OFFERING_META_DATA (
/*
Throws exceptions (codes):
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_product_offering_id IN NUMBER,
  in_meta_data_name      IN VARCHAR2 DEFAULT NULL,
  out_result_set         OUT SYS_REFCURSOR
);

PROCEDURE GET_OFF_CHAINS_SAME_PRODUCTS (
/*
Throws exceptions (codes):
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_offer_chain_1 IN NUMBER,
  in_offer_chain_2 IN NUMBER,
  out_result_set  OUT SYS_REFCURSOR
);

PROCEDURE GET_OFFER_CHAIN_MD_VALUE (
  in_offer_chain_id IN NUMBER,
  in_meta_data_name IN VARCHAR2,
  out_value         OUT VARCHAR2
);

PROCEDURE GET_OFFER_CHAIN_EL_VALUE (
  in_offer_chain_id   IN NUMBER,
  in_eligibility_name IN VARCHAR2,
  out_value           OUT VARCHAR2
);

PROCEDURE GET_OFFER_PRODUCT_OFFERINGS (
  in_offer_id    IN NUMBER,
  out_result_set OUT SYS_REFCURSOR
);

PROCEDURE GET_OFFER_CHAINS_BY_META_DATA (
  in_meta_data_name  IN VARCHAR2,
  in_meta_data_value IN VARCHAR2,
  out_result_set     OUT SYS_REFCURSOR
);

PROCEDURE GET_ALL_META_DATA (
  in_offer_chain_id IN NUMBER,
  out_result_set    OUT SYS_REFCURSOR
);

PROCEDURE CHECK_PRODUCT_ELIGIBILITY (
  in_group_id       IN NUMBER,
  in_offer_chain_id IN NUMBER,
  out_is_eligible   OUT NUMBER,
  out_concurrent_subscription_id OUT NUMBER
);

PROCEDURE GET_NOTIFICATION_TYPE_ID (
  in_offer_chain_id        IN NUMBER,
  in_action_name           IN VARCHAR2,
  out_notification_type_id OUT NUMBER
);

END PROCS_OFFER_CHAIN_V18;
.
/

CREATE OR REPLACE PACKAGE                   "PROCS_POLLING_SYNC"
AS

----
--------------------------------------------------------------------------------
----
    /* Call the Gather Events on a timer. Pass in the timestamp
        returned from the previous call and store the result for the
        next call.
       This method will identify and create new Sync Events from trigger activity data */
    procedure GATHER_SYNC_EVENTS(in_last_timestamp timestamp, out_new_timestamp out timestamp);
----
--------------------------------------------------------------------------------
----
    /* Internal logic call may need to be used to fix poller data */
    procedure GATHER_SYNC_EVENTS_RANGE(in_start_ts timestamp, in_end_ts timestamp, in_offset number);
----
--------------------------------------------------------------------------------
----
    /* User request for sync events. Params should be hard-coded in the application
        layer. Unconfirmed transfer sets will be resent up to maximum before being
        skipped. Last read time is logged.
       Params:
            set_maximum: Size of each transfer set
            max_retries: Number of times to resend unconfirmed sets before skipping
       Returns:
            set_id: Transfer set id, duplicated for all entries
            group_id: regi_id value
            event_type: Financial (I)nstrument, (S)ubscription, (G)ift Cert
    */
    procedure GET_TRANSFER_SET(in_set_maximum number, in_max_retries number, out_refcursor out sys_refcursor);
----
--------------------------------------------------------------------------------
----
    /* Confirmation from user of receipt of sync transfer set. Will only allow a
        single confirmation per transfer set.
    */
    procedure CONFIRM_TRANSFER_SET(in_set_id core_owner.polling_sync.set_id%type);
----
--------------------------------------------------------------------------------
----
    procedure SET_LAST_RUN(ts in timestamp);
    procedure GET_LAST_RUN(ts out timestamp);
END PROCS_POLLING_SYNC;
.
/

--------------------------------------------------------------------------------
-- DDL for package PROCS_PROCESS_RETRY_THROTTLE
--------------------------------------------------------------------------------

CREATE OR REPLACE PACKAGE "PROCS_PROCESS_RETRY_V18" AS

PROCEDURE LOG_RETRY(
    in_process_name IN VARCHAR2,
    in_generic_id   IN NUMBER,
    in_date         IN VARCHAR2,
    out_success      OUT NUMBER
);

PROCEDURE LOG_RETRY_DATE(
    in_process_name IN VARCHAR2,
    in_generic_id   IN NUMBER,
    in_date         IN DATE,
    out_success      OUT NUMBER
);

PROCEDURE DELETE_RETRY(
    in_process_name IN VARCHAR2,
    in_remove_minutes  IN NUMBER
);

PROCEDURE GET_SYSDATE (
    out_date OUT VARCHAR2
);

END PROCS_PROCESS_RETRY_V18;
.
/

--------------------------------------------------------------------------------
-- DDL for package PROCS_PRODUCT
--------------------------------------------------------------------------------

CREATE OR REPLACE PACKAGE "PROCS_PRODUCT_V18" AS 

PROCEDURE GET_PRODUCTS (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_status_id   IN  NUMBER,
  out_result_set OUT SYS_REFCURSOR
);

PROCEDURE GET_PRODUCT_OFFERING_META_DATA (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_product_offering_id  IN NUMBER,
  out_result_set OUT SYS_REFCURSOR
);

PROCEDURE GET_PRODUCT_ELIGIBIL_BY_NAME (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_product_id       IN NUMBER,
  in_eligibility_name IN VARCHAR2 DEFAULT NULL,
  out_result_set      OUT SYS_REFCURSOR
);

PROCEDURE GET_PRODUCT_BY_ID (
  in_product_id  IN NUMBER,
  out_result_set OUT SYS_REFCURSOR
);

PROCEDURE GET_PRD_OFFERING_BY_LINE_IT_ID (
  in_line_item_id IN NUMBER,
  out_result_set  OUT SYS_REFCURSOR
);

PROCEDURE GET_PRD_OFFERING_BY_ID (
  in_product_offering_id IN NUMBER,
  out_result_set  OUT SYS_REFCURSOR
);

PROCEDURE GET_PRODUCT_OFFERING_DISCOUNTS(
  in_product_offering_id IN NUMBER,
  out_result_set         OUT SYS_REFCURSOR
);

END PROCS_PRODUCT_V18;
.
/

--------------------------------------------------------------------------------
-- DDL for package PROCS_RECONCILIATION_CRU
--------------------------------------------------------------------------------

CREATE OR REPLACE PACKAGE "PROCS_RECONCILIATION_CRU_V18" AS 

PROCEDURE CREATE_CPT_CHARGEBACK_ACT (
  out_cpt_chargeback_act_id   OUT RCN_CPT_CHARGEBACK_ACT_DETAIL.ID%TYPE,
  in_cpt_chargeback_act_id    IN RCN_CPT_CHARGEBACK_ACT_DETAIL.ID%TYPE DEFAULT NULL,
  in_ext_source_log_id        IN RCN_CPT_CHARGEBACK_ACT_DETAIL.RCN_EXT_SOURCE_LOG_ID%TYPE,
  in_record_type              IN RCN_CPT_CHARGEBACK_ACT_DETAIL.RECORD_TYPE%TYPE,
  in_entity_type              IN RCN_CPT_CHARGEBACK_ACT_DETAIL.ENTITY_TYPE%TYPE,
  in_entity_number            IN RCN_CPT_CHARGEBACK_ACT_DETAIL.ENTITY_NUMBER%TYPE,
  in_chargeback_amount_issuer IN RCN_CPT_CHARGEBACK_ACT_DETAIL.CHARGEBACK_AMOUNT_ISSUER%TYPE,
  in_prev_partial_repres      IN RCN_CPT_CHARGEBACK_ACT_DETAIL.PREV_PARTIAL_REPRESENTMENT%TYPE,
  in_presentment_currency     IN RCN_CPT_CHARGEBACK_ACT_DETAIL.PRESENTMENT_CURRENCY%TYPE,
  in_chargeback_category      IN RCN_CPT_CHARGEBACK_ACT_DETAIL.CHARGEBACK_CATEGORY%TYPE,
  in_status_flag              IN RCN_CPT_CHARGEBACK_ACT_DETAIL.STATUS_FLAG%TYPE,
  in_sequence_number          IN RCN_CPT_CHARGEBACK_ACT_DETAIL.SEQUENCE_NUMBER%TYPE,
  in_merchant_order_number    IN RCN_CPT_CHARGEBACK_ACT_DETAIL.MERCHANT_ORDER_NUMBER%TYPE,
  in_account_number           IN RCN_CPT_CHARGEBACK_ACT_DETAIL.ACCOUNT_NUMBER%TYPE,
  in_reason_code              IN RCN_CPT_CHARGEBACK_ACT_DETAIL.REASON_CODE%TYPE,
  in_transaction_date         IN RCN_CPT_CHARGEBACK_ACT_DETAIL.TRANSACTION_DATE%TYPE,
  in_chargeback_date          IN RCN_CPT_CHARGEBACK_ACT_DETAIL.CHARGEBACK_DATE%TYPE,
  in_activity_date            IN RCN_CPT_CHARGEBACK_ACT_DETAIL.ACTIVITY_DATE%TYPE,
  in_chargeback_amount_action IN RCN_CPT_CHARGEBACK_ACT_DETAIL.CHARGEBACK_AMOUNT_ACTION%TYPE,
  in_fee_amount               IN RCN_CPT_CHARGEBACK_ACT_DETAIL.FEE_AMOUNT%TYPE,
  in_usage_code               IN RCN_CPT_CHARGEBACK_ACT_DETAIL.USAGE_CODE%TYPE,
  in_mop_code                 IN RCN_CPT_CHARGEBACK_ACT_DETAIL.MOP_CODE%TYPE,
  in_authorization_date       IN RCN_CPT_CHARGEBACK_ACT_DETAIL.AUTHORIZATION_DATE%TYPE,
  in_chargeback_due_date      IN RCN_CPT_CHARGEBACK_ACT_DETAIL.CHARGEBACK_DUE_DATE%TYPE,
  in_created_by               IN RCN_CPT_CHARGEBACK_ACT_DETAIL.CREATED_BY%TYPE
);

PROCEDURE CREATE_EXT_SOURCE_LOG (
  out_ext_source_log_id       OUT RCN_EXT_SOURCE_LOG.ID%TYPE,
  in_ext_source_log_id        IN RCN_EXT_SOURCE_LOG.ID%TYPE DEFAULT NULL,
  in_extraction_timestamp     IN RCN_EXT_SOURCE_LOG.EXTRACTION_TIMESTAMP%TYPE,
  in_report_date              IN RCN_EXT_SOURCE_LOG.REPORT_DATE%TYPE,
  in_report_gen_datetime      IN RCN_EXT_SOURCE_LOG.REPORT_GENERATION_DATETIME%TYPE,
  in_record_type              IN RCN_EXT_SOURCE_LOG.RECORD_TYPE%TYPE,
  in_report_file_name         IN RCN_EXT_SOURCE_LOG.REPORT_FILE_NAME%TYPE,
  in_created_by               IN RCN_EXT_SOURCE_LOG.CREATED_BY%TYPE
);

PROCEDURE CREATE_CPT_SERVICE_CHARGE (
  out_cpt_service_charge_id   OUT RCN_CPT_SERVICE_CHARGE_DETAIL.ID%TYPE,
  in_cpt_service_charge_id    IN RCN_CPT_SERVICE_CHARGE_DETAIL.ID%TYPE DEFAULT NULL,
  in_ext_source_log_id        IN RCN_CPT_SERVICE_CHARGE_DETAIL.RCN_EXT_SOURCE_LOG_ID%TYPE,
  in_record_type              IN RCN_CPT_SERVICE_CHARGE_DETAIL.RECORD_TYPE%TYPE,
  in_category                 IN RCN_CPT_SERVICE_CHARGE_DETAIL.CATEGORY%TYPE,
  in_sub_category             IN RCN_CPT_SERVICE_CHARGE_DETAIL.SUB_CATEGORY%TYPE,
  in_entity_type              IN RCN_CPT_SERVICE_CHARGE_DETAIL.ENTITY_TYPE%TYPE,
  in_entity_number            IN RCN_CPT_SERVICE_CHARGE_DETAIL.ENTITY_NUMBER%TYPE,
  in_funds_trans_inst_number  IN RCN_CPT_SERVICE_CHARGE_DETAIL.FUNDS_TRANSFER_INST_NUMBER%TYPE,
  in_secure_ba_number         IN RCN_CPT_SERVICE_CHARGE_DETAIL.SECURE_BA_NUMBER%TYPE,
  in_settlement_currency      IN RCN_CPT_SERVICE_CHARGE_DETAIL.SETTLEMENT_CURRENCY%TYPE,
  in_fee_schedule             IN RCN_CPT_SERVICE_CHARGE_DETAIL.FEE_SCHEDULE%TYPE,
  in_mop                      IN RCN_CPT_SERVICE_CHARGE_DETAIL.MOP%TYPE,
  in_interchange_qual         IN RCN_CPT_SERVICE_CHARGE_DETAIL.INTERCHANGE_QUALIFICATION%TYPE,
  in_fee_type_description     IN RCN_CPT_SERVICE_CHARGE_DETAIL.FEE_TYPE_DESCRIPTION%TYPE,
  in_action_type              IN RCN_CPT_SERVICE_CHARGE_DETAIL.ACTION_TYPE%TYPE,
  in_unit_quantity            IN RCN_CPT_SERVICE_CHARGE_DETAIL.UNIT_QUANTITY%TYPE,
  in_unit_fee                 IN RCN_CPT_SERVICE_CHARGE_DETAIL.UNIT_FEE%TYPE,
  in_amount                   IN RCN_CPT_SERVICE_CHARGE_DETAIL.AMOUNT%TYPE,
  in_percentage_rate          IN RCN_CPT_SERVICE_CHARGE_DETAIL.PERCENTAGE_RATE%TYPE,
  in_total_charge             IN RCN_CPT_SERVICE_CHARGE_DETAIL.TOTAL_CHARGE%TYPE,
  in_created_by               IN RCN_CPT_SERVICE_CHARGE_DETAIL.CREATED_BY%TYPE
);

PROCEDURE CREATE_CPT_EXCEPTION (
  out_cpt_exception_id     OUT RCN_CPT_EXCEPTION_DETAIL.ID%TYPE,
  in_cpt_exception_id      IN RCN_CPT_EXCEPTION_DETAIL.ID%TYPE DEFAULT NULL,
  in_ext_source_log_id     IN RCN_CPT_EXCEPTION_DETAIL.RCN_EXT_SOURCE_LOG_ID%TYPE,
  in_record_type           IN RCN_CPT_EXCEPTION_DETAIL.RECORD_TYPE%TYPE,
  in_submission_date       IN RCN_CPT_EXCEPTION_DETAIL.SUBMISSION_DATE%TYPE,
  in_pid_number            IN RCN_CPT_EXCEPTION_DETAIL.PID_NUMBER%TYPE,
  in_pid_short_name        IN RCN_CPT_EXCEPTION_DETAIL.PID_SHORT_NAME%TYPE,
  in_submission_number     IN RCN_CPT_EXCEPTION_DETAIL.SUBMISSION_NUMBER%TYPE,
  in_record_number         IN RCN_CPT_EXCEPTION_DETAIL.RECORD_NUMBER%TYPE,
  in_entity_type           IN RCN_CPT_EXCEPTION_DETAIL.ENTITY_TYPE%TYPE,
  in_entity_number         IN RCN_CPT_EXCEPTION_DETAIL.ENTITY_NUMBER%TYPE,
  in_presentment_currency  IN RCN_CPT_EXCEPTION_DETAIL.PRESENTMENT_CURRENCY%TYPE,
  in_merchant_order_number IN RCN_CPT_EXCEPTION_DETAIL.MERCHANT_ORDER_NUMBER%TYPE,
  in_rdfi_number           IN RCN_CPT_EXCEPTION_DETAIL.RDFI_NUMBER%TYPE,
  in_account_number        IN RCN_CPT_EXCEPTION_DETAIL.ACCOUNT_NUMBER%TYPE,
  in_expiration_date       IN RCN_CPT_EXCEPTION_DETAIL.EXPIRATION_DATE%TYPE,
  in_amount                IN RCN_CPT_EXCEPTION_DETAIL.AMOUNT%TYPE,
  in_mop                   IN RCN_CPT_EXCEPTION_DETAIL.MOP%TYPE,
  in_action_code           IN RCN_CPT_EXCEPTION_DETAIL.ACTION_CODE%TYPE,
  in_auth_date             IN RCN_CPT_EXCEPTION_DETAIL.AUTH_DATE%TYPE,
  in_auth_code             IN RCN_CPT_EXCEPTION_DETAIL.AUTH_CODE%TYPE,
  in_auth_response_code    IN RCN_CPT_EXCEPTION_DETAIL.AUTH_RESPONSE_CODE%TYPE,
  in_trace_number          IN RCN_CPT_EXCEPTION_DETAIL.TRACE_NUMBER%TYPE,
  in_consumer_country_code IN RCN_CPT_EXCEPTION_DETAIL.CONSUMER_COUNTRY_CODE%TYPE,
  in_category              IN RCN_CPT_EXCEPTION_DETAIL.CATEGORY%TYPE,
  in_mcc                   IN RCN_CPT_EXCEPTION_DETAIL.MCC%TYPE,
  in_reject_code           IN RCN_CPT_EXCEPTION_DETAIL.REJECT_CODE%TYPE,
  in_submission_status     IN RCN_CPT_EXCEPTION_DETAIL.SUBMISSION_STATUS%TYPE,
  in_created_by            IN RCN_CPT_EXCEPTION_DETAIL.CREATED_BY%TYPE
);

PROCEDURE CREATE_CPT_DEPOSIT (
  out_cpt_deposit_id        OUT RCN_CPT_DEPOSIT_DETAIL.ID%TYPE,
  in_cpt_deposit_id         IN RCN_CPT_DEPOSIT_DETAIL.ID%TYPE DEFAULT NULL,
  in_ext_source_log_id      IN RCN_CPT_DEPOSIT_DETAIL.RCN_EXT_SOURCE_LOG_ID%TYPE,
  in_record_type            IN RCN_CPT_DEPOSIT_DETAIL.RECORD_TYPE%TYPE,
  in_submission_date        IN RCN_CPT_DEPOSIT_DETAIL.SUBMISSION_DATE%TYPE,
  in_pid_number             IN RCN_CPT_DEPOSIT_DETAIL.PID_NUMBER%TYPE,
  in_pid_short_name         IN RCN_CPT_DEPOSIT_DETAIL.PID_SHORT_NAME%TYPE,
  in_submission_number      IN RCN_CPT_DEPOSIT_DETAIL.SUBMISSION_NUMBER%TYPE,
  in_record_number          IN RCN_CPT_DEPOSIT_DETAIL.RECORD_NUMBER%TYPE,
  in_entity_type            IN RCN_CPT_DEPOSIT_DETAIL.ENTITY_TYPE%TYPE,
  in_entity_number          IN RCN_CPT_DEPOSIT_DETAIL.ENTITY_NUMBER%TYPE,
  in_presentment_currency   IN RCN_CPT_DEPOSIT_DETAIL.PRESENTMENT_CURRENCY%TYPE,
  in_merchant_order_number  IN RCN_CPT_DEPOSIT_DETAIL.MERCHANT_ORDER_NUMBER%TYPE,
  in_rdfi_number            IN RCN_CPT_DEPOSIT_DETAIL.RDFI_NUMBER%TYPE,
  in_account_number         IN RCN_CPT_DEPOSIT_DETAIL.ACCOUNT_NUMBER%TYPE,
  in_expiration_date        IN RCN_CPT_DEPOSIT_DETAIL.EXPIRATION_DATE%TYPE,
  in_amount                 IN RCN_CPT_DEPOSIT_DETAIL.AMOUNT%TYPE,
  in_mop                    IN RCN_CPT_DEPOSIT_DETAIL.MOP%TYPE,
  in_action_code            IN RCN_CPT_DEPOSIT_DETAIL.ACTION_CODE%TYPE,
  in_auth_date              IN RCN_CPT_DEPOSIT_DETAIL.AUTH_DATE%TYPE,
  in_auth_code              IN RCN_CPT_DEPOSIT_DETAIL.AUTH_CODE%TYPE,
  in_auth_response_code     IN RCN_CPT_DEPOSIT_DETAIL.AUTH_RESPONSE_CODE%TYPE,
  in_trace_number           IN RCN_CPT_DEPOSIT_DETAIL.TRACE_NUMBER%TYPE,
  in_consumer_country_code  IN RCN_CPT_DEPOSIT_DETAIL.CONSUMER_COUNTRY_CODE%TYPE,
  in_mcc                    IN RCN_CPT_DEPOSIT_DETAIL.MCC%TYPE,
  in_fee_code               IN RCN_CPT_DEPOSIT_DETAIL.FEE_CODE%TYPE,
  in_unit_fee               IN RCN_CPT_DEPOSIT_DETAIL.UNIT_FEE%TYPE,
  in_percent_fee            IN RCN_CPT_DEPOSIT_DETAIL.PERCENT_FEE%TYPE,
  in_total_interchange_fee  IN RCN_CPT_DEPOSIT_DETAIL.TOTAL_INTERCHANGE_FEE%TYPE,
  in_total_assessment_fee   IN RCN_CPT_DEPOSIT_DETAIL.TOTAL_ASSESSMENT_FEE%TYPE,
  in_other_fee              IN RCN_CPT_DEPOSIT_DETAIL.OTHER_FEE%TYPE,
  in_created_by             IN RCN_CPT_DEPOSIT_DETAIL.CREATED_BY%TYPE
);

PROCEDURE CREATE_PP_SETTLEMENT (
  out_pp_settlement_id       OUT RCN_PP_SETTLEMENT.ID%TYPE,
  in_pp_settlement_id        IN RCN_PP_SETTLEMENT.ID%TYPE DEFAULT NULL,
  in_ext_source_log_id       IN RCN_PP_SETTLEMENT.RCN_EXT_SOURCE_LOG_ID%TYPE,
  in_transaction_id          IN RCN_PP_SETTLEMENT.TRANSACTION_ID%TYPE,
  in_invoice_id              IN RCN_PP_SETTLEMENT.INVOICE_ID%TYPE,
  in_pp_ref_id               IN RCN_PP_SETTLEMENT.PP_REF_ID%TYPE,
  in_pp_ref_id_type          IN RCN_PP_SETTLEMENT.PP_REF_ID_TYPE%TYPE,
  in_trans_event_code        IN RCN_PP_SETTLEMENT.TRANS_EVENT_CODE%TYPE,
  in_trans_init_date         IN RCN_PP_SETTLEMENT.TRANS_INIT_DATE%TYPE,
  in_trans_comp_date         IN RCN_PP_SETTLEMENT.TRANS_COMP_DATE%TYPE,
  in_trans_deb_or_cred       IN RCN_PP_SETTLEMENT.TRANS_DEB_OR_CRED%TYPE,
  in_gross_trans_amount      IN RCN_PP_SETTLEMENT.GROSS_TRANS_AMOUNT%TYPE,
  in_gross_trans_currency    IN RCN_PP_SETTLEMENT.GROSS_TRANS_CURRENCY%TYPE,
  in_fee_deb_or_cred         IN RCN_PP_SETTLEMENT.FEE_DEB_OR_CRED%TYPE,
  in_fee_amount              IN RCN_PP_SETTLEMENT.FEE_AMOUNT%TYPE,
  in_fee_currency            IN RCN_PP_SETTLEMENT.FEE_CURRENCY%TYPE,
  in_custom_field            IN RCN_PP_SETTLEMENT.CUSTOM_FIELD%TYPE,
  in_created_by              IN RCN_PP_SETTLEMENT.CREATED_BY%TYPE
);

PROCEDURE CREATE_PP_DISPUTE (
  out_pp_dispute_id            OUT RCN_PP_DISPUTE.ID%TYPE,
  in_pp_dispute_id             IN RCN_PP_DISPUTE.ID%TYPE DEFAULT NULL,
  in_ext_source_log_id         IN RCN_PP_DISPUTE.RCN_EXT_SOURCE_LOG_ID%TYPE,
  in_dispute_type              IN RCN_PP_DISPUTE.DISPUTE_TYPE%TYPE,
  in_claimant_name             IN RCN_PP_DISPUTE.CLAIMANT_NAME%TYPE,
  in_claimant_email            IN RCN_PP_DISPUTE.CLAIMANT_EMAIL%TYPE,
  in_transaction_id            IN RCN_PP_DISPUTE.TRANSACTION_ID%TYPE,
  in_trans_date                IN RCN_PP_DISPUTE.TRANS_DATE%TYPE,
  in_disputed_amount           IN RCN_PP_DISPUTE.DISPUTED_AMOUNT%TYPE,
  in_disputed_amount_currency  IN RCN_PP_DISPUTE.DISPUTED_AMOUNT_CURRENCY%TYPE,
  in_dispute_reason            IN RCN_PP_DISPUTE.DISPUTE_REASON%TYPE,
  in_dispute_filing_date       IN RCN_PP_DISPUTE.DISPUTE_FILING_DATE%TYPE,
  in_dispute_status            IN RCN_PP_DISPUTE.DISPUTE_STATUS%TYPE,
  in_dispute_case_id           IN RCN_PP_DISPUTE.DISPUTE_CASE_ID%TYPE,
  in_invoice_id                IN RCN_PP_DISPUTE.INVOICE_ID%TYPE,
  in_created_by                IN RCN_PP_DISPUTE.CREATED_BY%TYPE
);

PROCEDURE CREATE_PP_TRANS_DETAIL (
  out_pp_trans_detail_id       OUT RCN_PP_TRANS_DETAIL.ID%TYPE,
  in_pp_trans_detail_id        IN RCN_PP_TRANS_DETAIL.ID%TYPE DEFAULT NULL,
  in_ext_source_log_id         IN RCN_PP_TRANS_DETAIL.RCN_EXT_SOURCE_LOG_ID%TYPE,
  in_invoice_id                IN RCN_PP_TRANS_DETAIL.INVOICE_ID%TYPE,
  in_transaction_id            IN RCN_PP_TRANS_DETAIL.TRANSACTION_ID%TYPE,
  in_pp_ref_id                 IN RCN_PP_TRANS_DETAIL.PP_REF_ID%TYPE,
  in_trans_deb_or_cred         IN RCN_PP_TRANS_DETAIL.TRANS_DEB_OR_CRED%TYPE,
  in_trans_init_date           IN RCN_PP_TRANS_DETAIL.TRANS_INIT_DATE%TYPE,
  in_trans_comp_date           IN RCN_PP_TRANS_DETAIL.TRANS_COMP_DATE%TYPE,
  in_gross_trans_amount        IN RCN_PP_TRANS_DETAIL.GROSS_TRANS_AMOUNT%TYPE,
  in_gross_trans_currency      IN RCN_PP_TRANS_DETAIL.GROSS_TRANS_CURRENCY%TYPE,
  in_fee_amount                IN RCN_PP_TRANS_DETAIL.FEE_AMOUNT%TYPE,
  in_fee_currency              IN RCN_PP_TRANS_DETAIL.FEE_CURRENCY%TYPE,
  in_fee_deb_or_cred           IN RCN_PP_TRANS_DETAIL.FEE_DEB_OR_CRED%TYPE,
  in_trans_event_code          IN RCN_PP_TRANS_DETAIL.TRANS_EVENT_CODE%TYPE,
  in_trans_status              IN RCN_PP_TRANS_DETAIL.TRANS_STATUS%TYPE,
  in_insurance_amount          IN RCN_PP_TRANS_DETAIL.INSURANCE_AMOUNT%TYPE,
  in_sales_tax_amount          IN RCN_PP_TRANS_DETAIL.SALES_TAX_AMOUNT%TYPE,
  in_shipping_amount           IN RCN_PP_TRANS_DETAIL.SHIPPING_AMOUNT%TYPE,
  in_trans_subject             IN RCN_PP_TRANS_DETAIL.TRANS_SUBJECT%TYPE,
  in_trans_note                IN RCN_PP_TRANS_DETAIL.TRANS_NOTE%TYPE,
  in_payer_acct_id             IN RCN_PP_TRANS_DETAIL.PAYER_ACCT_ID%TYPE,
  in_payer_addr_status         IN RCN_PP_TRANS_DETAIL.PAYER_ADDR_STATUS%TYPE,
  in_item_name                 IN RCN_PP_TRANS_DETAIL.ITEM_NAME%TYPE,
  in_item_id                   IN RCN_PP_TRANS_DETAIL.ITEM_ID%TYPE,
  in_option_1_name             IN RCN_PP_TRANS_DETAIL.OPTION_1_NAME%TYPE,
  in_option_1_value            IN RCN_PP_TRANS_DETAIL.OPTION_1_VALUE%TYPE,
  in_option_2_name             IN RCN_PP_TRANS_DETAIL.OPTION_2_NAME%TYPE,
  in_option_2_value            IN RCN_PP_TRANS_DETAIL.OPTION_2_VALUE%TYPE,
  in_auction_site              IN RCN_PP_TRANS_DETAIL.AUCTION_SITE%TYPE,
  in_auction_buyer_id          IN RCN_PP_TRANS_DETAIL.AUCTION_BUYER_ID%TYPE,
  in_auction_closing_date      IN RCN_PP_TRANS_DETAIL.AUCTION_CLOSING_DATE%TYPE,
  in_shipping_addr_line_1      IN RCN_PP_TRANS_DETAIL.SHIPPING_ADDR_LINE_1%TYPE,
  in_shipping_addr_line_2      IN RCN_PP_TRANS_DETAIL.SHIPPING_ADDR_LINE_2%TYPE,
  in_shipping_addr_city        IN RCN_PP_TRANS_DETAIL.SHIPPING_ADDR_CITY%TYPE,
  in_shipping_addr_state       IN RCN_PP_TRANS_DETAIL.SHIPPING_ADDR_STATE%TYPE,
  in_shipping_addr_zip         IN RCN_PP_TRANS_DETAIL.SHIPPING_ADDR_ZIP%TYPE,
  in_shipping_addr_country     IN RCN_PP_TRANS_DETAIL.SHIPPING_ADDR_COUNTRY%TYPE,
  in_custom_field              IN RCN_PP_TRANS_DETAIL.CUSTOM_FIELD%TYPE,
  in_created_by                IN RCN_PP_TRANS_DETAIL.CREATED_BY%TYPE
);

PROCEDURE GET_EXT_SOURCE_LOG (
  in_record_type           IN RCN_EXT_SOURCE_LOG.RECORD_TYPE%TYPE,
  in_report_file_name      IN RCN_EXT_SOURCE_LOG.REPORT_FILE_NAME%TYPE,
  out_result_set           OUT SYS_REFCURSOR
);

FUNCTION CHECK_EXT_SOURCE_LOG (
  in_record_type           IN RCN_EXT_SOURCE_LOG.RECORD_TYPE%TYPE,
  in_report_file_name      IN RCN_EXT_SOURCE_LOG.REPORT_FILE_NAME%TYPE
) RETURN NUMBER;

PROCEDURE CREATE_AMEX_CHARGEBACK (
    in_rcn_ext_source_log_id IN RCN_EXT_SOURCE_LOG.ID%TYPE,
    in_resolution IN RCN_AMEX_CHARGEBACK.RESOLUTION%TYPE,
    in_from_system IN RCN_AMEX_CHARGEBACK.FROM_SYSTEM%TYPE,
    in_rejects_to_system IN RCN_AMEX_CHARGEBACK.REJECTS_TO_SYSTEM%TYPE,
    in_disputes_to_system IN RCN_AMEX_CHARGEBACK.DISPUTES_TO_SYSTEM%TYPE,
    in_date_of_adjustment IN RCN_AMEX_CHARGEBACK.DATE_OF_ADJUSTMENT%TYPE,
    in_date_of_charge IN RCN_AMEX_CHARGEBACK.DATE_OF_CHARGE%TYPE,
    in_case_type IN RCN_AMEX_CHARGEBACK.CASE_TYPE%TYPE,
    in_cb_reas_code IN RCN_AMEX_CHARGEBACK.CB_REAS_CODE%TYPE,
    in_cb_amount IN RCN_AMEX_CHARGEBACK.CB_AMOUNT%TYPE,
    in_cb_adjustment_number IN RCN_AMEX_CHARGEBACK.CB_ADJUSTMENT_NUMBER%TYPE,
    in_billed_amount IN RCN_AMEX_CHARGEBACK.BILLED_AMOUNT%TYPE,
    in_soc_amount IN RCN_AMEX_CHARGEBACK.SOC_AMOUNT%TYPE,
    in_foreign_amount IN RCN_AMEX_CHARGEBACK.FOREIGN_AMOUNT%TYPE,
    in_currency IN RCN_AMEX_CHARGEBACK.CURRENCY%TYPE,
    in_note1 IN RCN_AMEX_CHARGEBACK.NOTE1%TYPE,
    in_note2 IN RCN_AMEX_CHARGEBACK.NOTE2%TYPE,
    in_note3 IN RCN_AMEX_CHARGEBACK.NOTE3%TYPE,
    in_note4 IN RCN_AMEX_CHARGEBACK.NOTE4%TYPE,
    in_note5 IN RCN_AMEX_CHARGEBACK.NOTE5%TYPE,
    in_note6 IN RCN_AMEX_CHARGEBACK.NOTE6%TYPE,
    in_note7 IN RCN_AMEX_CHARGEBACK.NOTE7%TYPE,
    in_ind_ref_number IN RCN_AMEX_CHARGEBACK.IND_REF_NUMBER%TYPE,
    in_created_by IN RCN_AMEX_CHARGEBACK.CREATED_BY%TYPE
);

END PROCS_RECONCILIATION_CRU_V18;
.
/

CREATE OR REPLACE PACKAGE "CORE_OWNER"."PROCS_REPORTING" AS

----
--------------------------------------------------------------------------------
----
    procedure ext_charge(in_start_date date, in_end_date date, out_cursor out sys_refcursor);
----
--------------------------------------------------------------------------------
----
    procedure ext_license(in_start_date date, in_end_date date, out_cursor out sys_refcursor);
----
--------------------------------------------------------------------------------
----
    procedure ext_invoice(in_start_date date, in_end_date date, out_cursor out sys_refcursor);
----
--------------------------------------------------------------------------------
----
    procedure ext_line_item(in_start_date date, in_end_date date, out_cursor out sys_refcursor);
----
--------------------------------------------------------------------------------
----
    procedure ext_account(in_start_date date, in_end_date date, out_cursor out sys_refcursor);
----
--------------------------------------------------------------------------------
----
    procedure ext_subscription(in_start_date date, in_end_date date, out_cursor out sys_refcursor);
----
--------------------------------------------------------------------------------
----
    procedure ext_transaction(in_start_date date, in_end_date date, out_cursor out sys_refcursor);
----
--------------------------------------------------------------------------------
----
    procedure ext_offer_chain(in_start_date date, in_end_date date, out_cursor out sys_refcursor);
----
--------------------------------------------------------------------------------
----
    procedure ext_offer_offer_chain(in_start_date date, in_end_date date, out_cursor out sys_refcursor);
----
--------------------------------------------------------------------------------
----
    procedure ext_offer(in_start_date date, in_end_date date, out_cursor out sys_refcursor);
----
--------------------------------------------------------------------------------
----
    procedure ext_gift_certificate(in_start_date date, in_end_date date, out_cursor out sys_refcursor);
----
--------------------------------------------------------------------------------
----
    procedure ext_product_offering(in_start_date date, in_end_date date, out_cursor out sys_refcursor);
----
--------------------------------------------------------------------------------
----
    procedure ext_product(in_start_date date, in_end_date date, out_cursor out sys_refcursor);
----
--------------------------------------------------------------------------------
----
    procedure ext_offer_product_offering(in_start_date date, in_end_date date, out_cursor out sys_refcursor);
----
--------------------------------------------------------------------------------
----
    procedure ext_discount_product_offering(in_start_date date, in_end_date date, out_cursor out sys_refcursor);
----
--------------------------------------------------------------------------------
----
    procedure ext_discount(in_start_date date, in_end_date date, out_cursor out sys_refcursor);
----
--------------------------------------------------------------------------------
----
    procedure ext_offer_chain_metadata(in_start_date date, in_end_date date, out_cursor out sys_refcursor);
----
--------------------------------------------------------------------------------
----
    procedure ext_product_offering_metadata(in_start_date date, in_end_date date, out_cursor out sys_refcursor);
----
--------------------------------------------------------------------------------
----
    procedure ext_subscription_metadata(in_start_date date, in_end_date date, out_cursor out sys_refcursor);
----
--------------------------------------------------------------------------------
----
    procedure ext_credit_card(in_start_date date, in_end_date date, out_cursor out sys_refcursor);
----
--------------------------------------------------------------------------------
----
    procedure ext_transaction_attempt(in_start_date date, in_end_date date, out_cursor out sys_refcursor);
----
--------------------------------------------------------------------------------
----
    procedure ext_invoice_adjustment(in_start_date date, in_end_date date, out_cursor out sys_refcursor);
----
--------------------------------------------------------------------------------
----
    procedure ext_line_item_adjustment(in_start_date date, in_end_date date, out_cursor out sys_refcursor);
----
--------------------------------------------------------------------------------
----
    procedure ext_product_eligibility(in_start_date date, in_end_date date, out_cursor out sys_refcursor);
----
--------------------------------------------------------------------------------
----
    procedure ext_offer_chain_eligibility(in_start_date date, in_end_date date, out_cursor out sys_refcursor);
----
--------------------------------------------------------------------------------
----
    procedure ext_tax(in_start_date date, in_end_date date, out_cursor out sys_refcursor);
----
--------------------------------------------------------------------------------
----
    procedure ext_tax_adjustment(in_start_date date, in_end_date date, out_cursor out sys_refcursor);
----
--------------------------------------------------------------------------------
----
/**/
    procedure ext_rcn_ext_source_log(in_start_date date, in_end_date date, out_cursor out sys_refcursor);
----
--------------------------------------------------------------------------------
----
    procedure ext_rcn_cpt_svc_chg_dtl(in_start_date date, in_end_date date, out_cursor out sys_refcursor);
----
--------------------------------------------------------------------------------
----
    procedure ext_rcn_cpt_excpt_dtl(in_start_date date, in_end_date date, out_cursor out sys_refcursor);
----
--------------------------------------------------------------------------------
----
    procedure ext_rcn_cpt_dpst_dtl(in_start_date date, in_end_date date, out_cursor out sys_refcursor);
----
--------------------------------------------------------------------------------
----
    procedure ext_rcn_cpt_chgbk_act_dtl(in_start_date date, in_end_date date, out_cursor out sys_refcursor);
----
--------------------------------------------------------------------------------
----
    procedure ext_rcn_pp_sttlmnt(in_start_date date, in_end_date date, out_cursor out sys_refcursor);
----
--------------------------------------------------------------------------------
----
    procedure ext_rcn_pp_dispute(in_start_date date, in_end_date date, out_cursor out sys_refcursor);
----
--------------------------------------------------------------------------------
----
    procedure ext_rcn_pp_trns_dtl(in_start_date date, in_end_date date, out_cursor out sys_refcursor);
----
--------------------------------------------------------------------------------
----
    procedure ext_rcn_amex_chargeback(in_start_date date, in_end_date date, out_cursor out sys_refcursor);
----
--------------------------------------------------------------------------------
----
    procedure ext_paypal(in_start_date date, in_end_date date, out_cursor out sys_refcursor);
----
--------------------------------------------------------------------------------
----
    procedure ext_address(in_start_date date, in_end_date date, out_cursor out sys_refcursor);
----
--------------------------------------------------------------------------------
----
/**/
END PROCS_REPORTING;
.
/

prompt Compiling Package PROCS_REPORTING_1A

whenever sqlerror exit failure

create or replace PACKAGE              "PROCS_REPORTING_1A" AS

----
--------------------------------------------------------------------------------
----
    function getDiscountAmount(in_line_item_id line_item.id%type)
        return line_item.amount%type;
----
--------------------------------------------------------------------------------
----
    function getRefundAmount(in_line_item_id line_item.id%type)
        return line_item.amount%type;
----
--------------------------------------------------------------------------------
----
    PROCEDURE EXTRACT_LINE_ITEMS(
        in_lower_date_bound DATE,
        in_upper_date_bound DATE,
        out_lic_cur OUT sys_refcursor
    );
----
--------------------------------------------------------------------------------
----
END PROCS_REPORTING_1A;
.
/

--------------------------------------------------------------------------------
-- DDL for package PROCS_REPORTS
--------------------------------------------------------------------------------

CREATE OR REPLACE PACKAGE "PROCS_REPORTS_V5" AS 

FUNCTION GET_PRODUCT_NAMES(
  in_offer_id IN NUMBER
) RETURN VARCHAR2;

PROCEDURE GET_FULL_FLASH_REPORT_PURCH (
  in_start_date  IN DATE,
  in_end_date    IN DATE,
  out_result_set OUT SYS_REFCURSOR
);

PROCEDURE GET_FLASH_REPORT_PURCHASES (
  in_offer_id            IN NUMBER,
  in_start_date          IN DATE,
  in_end_date            IN DATE,
  out_new_purchasers_num OUT NUMBER,
  out_renewals_num       OUT NUMBER,
  out_product_names      OUT VARCHAR2,
  out_total_dollar_value OUT NUMBER,
  out_unique_purchasers  OUT NUMBER
);

/*
FUNCTIONS FOR THE FLASH REPORT
*/

FUNCTION FLR_NEW_PURCHASERS_NUM (
  in_offer_id            IN NUMBER,
  in_start_date          IN DATE,
  in_end_date            IN DATE
) RETURN NUMBER;

FUNCTION FLR_RENEWALS_NUM (
  in_offer_id            IN NUMBER,
  in_start_date          IN DATE,
  in_end_date            IN DATE
) RETURN NUMBER;

FUNCTION FLR_TOTAL_DOLLAR_VALUE (
  in_offer_id            IN NUMBER,
  in_start_date          IN DATE,
  in_end_date            IN DATE
) RETURN NUMBER;

FUNCTION FLR_UNIQUE_PURCHASERS (
  in_offer_id            IN NUMBER,
  in_start_date          IN DATE,
  in_end_date            IN DATE
) RETURN NUMBER;

END PROCS_REPORTS_V5;
.
/

--------------------------------------------------------------------------------
-- DDL for package PROCS_SUBSCRIPTION
--------------------------------------------------------------------------------

CREATE OR REPLACE PACKAGE "PROCS_SUBSCRIPTION_V18" AS

PROCEDURE START_GRACE_BY_INVOICE_ID(
  in_invoice_id        IN LICENSE.INVOICE_ID%TYPE,
  in_updater           IN VARCHAR2,
  in_duration_in_hours IN NUMBER
);

PROCEDURE STOP_GRACE_BY_INVOICE_ID(
  in_invoice_id IN LICENSE.INVOICE_ID%TYPE,
  in_updater    IN VARCHAR2
);

PROCEDURE START_SUBSCRIPTION_CREATION (
  in_group_id           IN NUMBER,
  in_created_by         IN VARCHAR2,
  in_offer_chain_id     IN NUMBER,
  in_instrument_type_id IN NUMBER,
  in_instrument_id      IN NUMBER,
  in_agent_id           IN NUMBER,
  in_note               IN VARCHAR2,
  out_subscription_id   OUT NUMBER,
  out_invoice_id        OUT NUMBER,
  out_new_license_id    OUT NUMBER,
  in_check_dupe_products   IN NUMBER DEFAULT GLOBAL_CONSTANTS_V18.TRUE
);

PROCEDURE FINALIZE_SUBSCRIPTION_CREATION (
  in_subscription_id    IN NUMBER,
  in_invoice_id         IN NUMBER,
  in_instrument_type_id IN NUMBER,
  in_instrument_id      IN NUMBER,
  in_created_by         IN VARCHAR2
);

PROCEDURE SUSPEND_SUBSCRIPTION(
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.INTERNAL_ERROR
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
    in_subs_id    IN NUMBER ,
    in_updated_by IN VARCHAR2
);

PROCEDURE REACTIVATE_SUBSCRIPTION (
  in_subscription_id IN  NUMBER,
  in_updated_by      IN  VARCHAR2
);

PROCEDURE GET_SUBSCRIPTION_INFO (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
    in_subscription_id IN  NUMBER,
    out_result_set      OUT SYS_REFCURSOR
);

PROCEDURE GET_SUBSCRIPTION_INVOICES (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND,
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_subscription_id  IN  NUMBER,
  out_result_set      OUT SYS_REFCURSOR
);

PROCEDURE GET_SUBSCRIPTION_NOTES (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_subscription_id  IN  NUMBER,
  out_result_set      OUT SYS_REFCURSOR
);

PROCEDURE ANNOTATE_SUBSCRIPTION (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND,
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_subscription_id IN  NUMBER,
  in_agent_id        IN  NUMBER,
  in_note            IN  VARCHAR2,
  in_created_by      IN  VARCHAR2
);

PROCEDURE GET_CANCEL_REASONS (
  out_result_set OUT    SYS_REFCURSOR
);

FUNCTION GET_RENEWAL_DATE (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_subscription_id in NUMBER
) RETURN DATE;

FUNCTION GET_RECENT_CHARGE (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_subscription_id IN NUMBER
) RETURN NUMBER;

FUNCTION GET_BILLING_CYCLE (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_subscription_id IN NUMBER
) RETURN VARCHAR2;

PROCEDURE REFUND_SUBSCRIPTION (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_subscription_id IN NUMBER,
  in_invoice_id      IN NUMBER,
  in_refund_amount   IN NUMBER,
  in_note            IN VARCHAR2,
  in_created_by      IN VARCHAR2,
  out_charge_id      OUT NUMBER
);

PROCEDURE ADD_SUBSCRIPTION_EXTENSION (
/*
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.INTERNAL_ERROR
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_subscription_id      IN NUMBER,
  in_effective_start_date IN DATE,
  in_effective_end_date   IN DATE,
  in_note                 IN VARCHAR2,
  in_updated_by           IN VARCHAR2
);

FUNCTION CALC_SUBSCRIPTION_END_DATE (
/*
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.INTERNAL_ERROR
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
Returns:
NULL if it is impossible to calculate end date (for example,
  offer chain includes offer with infinity recurrences number)
DATE else
*/
  in_subscription_id IN NUMBER
) RETURN DATE;

PROCEDURE HAS_FUTURE_LICENSE (
/*
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_license_id IN  NUMBER,
  out_result    OUT NUMBER
);

PROCEDURE CLOSE_SUBSCRIPTION (
  in_subscription_id IN NUMBER,
  in_updated_by      IN VARCHAR2
);

PROCEDURE GET_GROUP_ID_BY_SBSCRPTN_ID (
  in_subscription_id IN NUMBER,
  out_group_id       OUT NUMBER
);

PROCEDURE GET_SUBSCRIPTION_PRODUCTS (
/*
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_subscription_id IN NUMBER,
  out_result_set     OUT SYS_REFCURSOR
);

PROCEDURE UPDATE_SUBSCRIPTION_STATUS (
/*
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_subscription_id        IN SUBSCRIPTION.ID%TYPE,
  in_subscription_status_id IN SUBSCRIPTION.SUBSCRIPTION_STATUS_ID%TYPE,
  in_updated_by             IN SUBSCRIPTION.UPDATED_BY%TYPE
);

PROCEDURE GET_ACTIVE_INVOICES_IDS (
/*
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
--  in_subscription_id IN SUBSCRIPTION.ID%TYPE,
  in_subscription_id IN NUMBER,
  out_result_set     OUT SYS_REFCURSOR
);

PROCEDURE CANCEL_SUBSCRIPTION_INVOICE (
/*
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
APP_EXCEPTION_CODES_V18.INTERNAL_ERROR
*/
  in_invoice_id        IN NUMBER,
  in_updated_by        IN VARCHAR2,
  in_refundable        IN NUMBER DEFAULT GLOBAL_CONSTANTS_V18.FALSE
);

PROCEDURE FINALIZE_CANCELATION (
/*
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
APP_EXCEPTION_CODES_V18.INTERNAL_ERROR
*/
--  in_subscription_id    IN SUBSCRIPTION.ID%TYPE,
--  in_cancelation_reason IN SUBSCRIPTION_CANCEL_REASON.VALUE%TYPE,
--  in_cancelation_date   IN SUBSCRIPTION.CANCELLATION_DATE%TYPE,
--  in_note               IN SUBSCRIPTION_NOTE.NOTE%TYPE,
--  in_agent_id           IN SUBSCRIPTION_NOTE.AGENT_ID%TYPE,
--  in_updated_by         IN SUBSCRIPTION.UPDATED_BY%TYPE
  in_subscription_id    IN NUMBER,
  in_cancelation_reason IN VARCHAR2,
  in_cancelation_date   IN DATE,
  in_note               IN VARCHAR2,
  in_agent_id           IN NUMBER,
  in_updated_by         IN VARCHAR2
);

PROCEDURE FINALIZE_FALSE_START (
/*
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
APP_EXCEPTION_CODES_V18.INTERNAL_ERROR
*/
--  in_subscription_id    IN SUBSCRIPTION.ID%TYPE,
--  in_cancelation_date   IN SUBSCRIPTION.CANCELLATION_DATE%TYPE,
--  in_note               IN SUBSCRIPTION_NOTE.NOTE%TYPE,
--  in_agent_id           IN SUBSCRIPTION_NOTE.AGENT_ID%TYPE,
--  in_updated_by         IN SUBSCRIPTION.UPDATED_BY%TYPE
  in_subscription_id    IN NUMBER,
  in_cancelation_date   IN DATE,
  in_note               IN VARCHAR2,
  in_agent_id           IN NUMBER,
  in_updated_by         IN VARCHAR2
);

FUNCTION IS_SUBSCRIPTION_CANCELABLE (
  in_subscription_id IN NUMBER
) RETURN NUMBER;

PROCEDURE GET_SUBSCR_PROD_OFFERRINGS (
/*
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_subscription_id IN NUMBER,
  out_result_set     OUT SYS_REFCURSOR
);

PROCEDURE RETRIEVE_SUB_PROD_OFFER (
/*
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_subscription_id IN NUMBER,
  out_result_set     OUT SYS_REFCURSOR
);

PROCEDURE GET_SUBSCR_LIC_OFFER (
/*
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_subscription_id IN NUMBER,
  out_result_set     OUT SYS_REFCURSOR
);

PROCEDURE ARE_REFUNDS_PENDING_FOR_SUBSCR (
/*
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_subscription_id IN NUMBER,
  out_result         OUT NUMBER
);

PROCEDURE GET_EXISTING_SUBSCR_NUMBER (
/*
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_group_id        IN NUMBER,
  in_offer_chain_id  IN NUMBER,
  out_result         out number
);

PROCEDURE GET_EXISTING_SUBSCR_IDS (
/*
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_group_id        IN NUMBER,
  in_offer_chain_id  IN NUMBER,
  out_result_set     OUT SYS_REFCURSOR
);

PROCEDURE ADD_META_DATA (
/*
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_subscription_id IN NUMBER,
  in_name            IN VARCHAR2,
  in_value           IN VARCHAR2,
  in_created_by      IN VARCHAR2
);

PROCEDURE GET_SUBSCRIPTIONS_META_DATA (
/*
APP_EXCEPTION_CODES_V18.INVALID_PARAMETER
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_subscriptions_ids IN core_owner.NUMBER_TABLE,
  out_result_set       OUT SYS_REFCURSOR
);

PROCEDURE GET_SUBS_BY_TRNS_ORDER_ID (
/*
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_order_id        IN TRANSACTION.ORDER_ID%TYPE,
  out_result_set     OUT SYS_REFCURSOR
);

PROCEDURE GET_OPEN_CHARGES_BY_SUBID
 (
/*
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_subscription_id  IN SUBSCRIPTION.ID%TYPE,
  out_result_set      OUT SYS_REFCURSOR
);

FUNCTION GET_GIFT_CERT_ID_BY_SUB_ID (
  in_subscription_id IN SUBSCRIPTION.ID%TYPE
) RETURN NUMBER;

FUNCTION GET_GIFT_CERT_CODE_BY_SUB_ID (
  in_subscription_id IN SUBSCRIPTION.ID%TYPE
) RETURN VARCHAR2;



PROCEDURE GET_ACTIVE_MEU_SUBS (
  out_result_set      OUT SYS_REFCURSOR
);

PROCEDURE GET_EARLIEST_ACTIVE_OFFER_ID (
  in_subscription_id  IN SUBSCRIPTION.ID%TYPE,
  out_offer_id        OUT LICENSE.ID%TYPE
);

PROCEDURE GET_EARLIEST_ACTIVE_LICENSE_ID (
  in_subscription_id  IN SUBSCRIPTION.ID%TYPE,
  out_license_id      OUT LICENSE.ID%TYPE
);

PROCEDURE GET_ACT_SUBS_W_CPT_CHARGEBACKS (
  out_result_set      OUT SYS_REFCURSOR
);

PROCEDURE GET_ACT_SUBS_W_PP_CHARGEBACKS (
  out_result_set      OUT SYS_REFCURSOR
);

PROCEDURE GET_ACT_SUBS_W_AMEX_CB (
  out_result_set      OUT SYS_REFCURSOR
);

PROCEDURE GET_GRACE_PERIOD_SUB_REGIS (
  in_max_days_until_close IN NUMBER,
  in_num_subs_to_fetch    IN NUMBER,
  out_result_set          OUT SYS_REFCURSOR
);


END PROCS_SUBSCRIPTION_V18;
.
/

--------------------------------------------------------------------------------
-- DDL for package PROCS_SUBSCRIPTION_CRU
--------------------------------------------------------------------------------

CREATE OR REPLACE PACKAGE "PROCS_SUBSCRIPTION_CRU_V18" AS 

PROCEDURE CREATE_SUBSCRIPTION(
  out_subscription_id          OUT SUBSCRIPTION.ID%TYPE,
  in_subscription_id           IN SUBSCRIPTION.ID%TYPE DEFAULT NULL,
  in_suspend_date              IN SUBSCRIPTION.SUSPEND_DATE%TYPE DEFAULT NULL,
  in_account_id                IN SUBSCRIPTION.ACCOUNT_ID%TYPE,
  in_purchase_date             IN SUBSCRIPTION.PURCHASE_DATE%TYPE,
  in_offer_chain_id            IN SUBSCRIPTION.OFFER_CHAIN_ID%TYPE,
  in_termination_date          IN SUBSCRIPTION.TERMINATION_DATE%TYPE DEFAULT NULL,
  in_days_remainning_ajustment IN SUBSCRIPTION.DAYS_REMAINING_ADJUSTMENT%TYPE DEFAULT NULL,
  in_sct_id                    IN SUBSCRIPTION.SCT_ID%TYPE DEFAULT NULL,
  in_created_by                IN SUBSCRIPTION.CREATED_BY%TYPE,
  in_instrument_type_id        IN SUBSCRIPTION.INSTRUMENT_TYPE_ID%TYPE,
  in_instrument_id             IN SUBSCRIPTION.INSTRUMENT_ID%TYPE,
  in_subscription_status_id    IN SUBSCRIPTION.SUBSCRIPTION_STATUS_ID%TYPE,
  in_cancelation_date          IN SUBSCRIPTION.CANCELLATION_DATE%TYPE DEFAULT NULL,
  in_reactivation_date         IN SUBSCRIPTION.REACTIVATION_DATE%TYPE DEFAULT NULL
);

PROCEDURE UPDATE_SUBSCRIPTION(
  in_subscription_id           IN SUBSCRIPTION.ID%TYPE,
  in_suspend_date              IN SUBSCRIPTION.SUSPEND_DATE%TYPE DEFAULT NULL,
  in_purchase_date             IN SUBSCRIPTION.PURCHASE_DATE%TYPE DEFAULT NULL,
  in_termination_date          IN SUBSCRIPTION.TERMINATION_DATE%TYPE DEFAULT NULL,
  in_days_remainning_ajustment IN SUBSCRIPTION.DAYS_REMAINING_ADJUSTMENT%TYPE DEFAULT NULL,
  in_sct_id                    IN SUBSCRIPTION.SCT_ID%TYPE DEFAULT NULL,
  in_updated_by                IN SUBSCRIPTION.CREATED_BY%TYPE DEFAULT NULL,
  in_instrument_type_id        IN SUBSCRIPTION.INSTRUMENT_TYPE_ID%TYPE DEFAULT NULL,
  in_instrument_id             IN SUBSCRIPTION.INSTRUMENT_ID%TYPE DEFAULT NULL,
  in_subscription_status_id    IN SUBSCRIPTION.SUBSCRIPTION_STATUS_ID%TYPE DEFAULT NULL,
  in_cancelation_date          IN SUBSCRIPTION.CANCELLATION_DATE%TYPE DEFAULT NULL,
  in_reactivation_date         IN SUBSCRIPTION.REACTIVATION_DATE%TYPE DEFAULT NULL
);

PROCEDURE CREATE_SUBSCRIPTION_NOTE (
  inout_subscription_note_id IN OUT SUBSCRIPTION_NOTE.ID%TYPE,
  in_agent_id                IN SUBSCRIPTION_NOTE.AGENT_ID%TYPE,
  in_subscription_id         IN SUBSCRIPTION_NOTE.ID%TYPE,
  in_note                    IN SUBSCRIPTION_NOTE.NOTE%TYPE,
  in_created_by              IN SUBSCRIPTION_NOTE.CREATED_BY%TYPE
);

END PROCS_SUBSCRIPTION_CRU_V18;
.
/

--------------------------------------------------------------------------------
-- DDL for package PROCS_SYSTEM
--------------------------------------------------------------------------------

CREATE OR REPLACE PACKAGE "PROCS_SYSTEM_V18" AS 

PROCEDURE INCREMENT_VERSION;

PROCEDURE CHECK_VERSION(
    in_vers    IN NUMBER,
    out_result OUT NUMBER
);

END PROCS_SYSTEM_V18;
.
/

--------------------------------------------------------------------------------
-- DDL for package PROCS_TAXES
--------------------------------------------------------------------------------

CREATE OR REPLACE PACKAGE "PROCS_TAXES_V18" AS 

PROCEDURE ADD_TAX (
  in_tax_type_id           IN NUMBER,
  in_calculated_amount     IN NUMBER,
  in_created_by            IN VARCHAR2,
  in_line_item_id          IN NUMBER,
  in_effective_rate        IN VARCHAR2,
  in_taxable_amount        IN NUMBER,
  in_tax_rule_id           IN NUMBER,
  in_jurisdiction_level_id IN NUMBER,
  in_jurisdiction_name     IN VARCHAR2,
  in_jurisdiction_id       IN VARCHAR2,
  in_ext_tax_type          IN VARCHAR2,
  in_ext_result            IN VARCHAR2,
  in_imposition_type       IN VARCHAR2,
  in_imposition            IN VARCHAR2
);

PROCEDURE CHECK_COUNTRY_FOR_EXCLUSION (
  in_country_code IN CHAR,
  in_check_date IN DATE,
  out_is_founded  OUT NUMBER -- GLOBAL_CONSTANT.TRUE of GLOBAL_CONSTANTS_V18.FALSE
);

PROCEDURE GET_TAX_CATEGORY (
  in_tax_category_id IN NUMBER,
  out_result_set     OUT SYS_REFCURSOR
);

END PROCS_TAXES_V18;
.
/

--------------------------------------------------------------------------------
-- DDL for package PROCS_TAXES_CRU
--------------------------------------------------------------------------------

CREATE OR REPLACE PACKAGE "PROCS_TAXES_CRU_V18" AS 

PROCEDURE CREATE_TAX (
  inout_tax_id             IN OUT NUMBER,
  in_tax_type_id           IN NUMBER,
  in_calculated_amount     IN NUMBER,
  in_created_by            IN VARCHAR2,
  in_line_item_id          IN NUMBER,
  in_effective_rate        IN VARCHAR2,
  in_taxable_amount        IN NUMBER,
  in_tax_rule_id           IN NUMBER,
  in_jurisdiction_level_id IN NUMBER,
  in_jurisdiction_name     IN VARCHAR2,
  in_jurisdiction_id       IN VARCHAR2,
  in_ext_tax_type          IN VARCHAR2,
  in_ext_result            IN VARCHAR2,
  in_imposition_type       IN VARCHAR2,
  in_imposition            IN VARCHAR2
);

END PROCS_TAXES_CRU_V18;
.
/

--------------------------------------------------------------------------------
-- DDL for package PROCS_TEST
--------------------------------------------------------------------------------

CREATE OR REPLACE PACKAGE "PROCS_TEST_V18" AS 

PROCEDURE TEST_CLEAR_ALL;
PROCEDURE TEST_CLEAR_PRODUCTS;

/********************************************/

PROCEDURE TEST_GET_ACCOUNT (
  in_group_id     IN NUMBER,
  out_result_set  OUT SYS_REFCURSOR
);

/********************************************/

PROCEDURE TEST_GET_SUBSCRIPTION (
  in_subscription_id IN NUMBER,
  out_result_set     OUT SYS_REFCURSOR
);

/*********************************************/

PROCEDURE TEST_DELETE_INVOICE (
  in_invoice_id IN NUMBER
);

PROCEDURE TEST_DELETE_USER_ACCOUNT (
  in_group_id IN NUMBER
);

PROCEDURE TEST_DELETE_USER_ACCOUNTS  (
  in_start_group_id IN NUMBER,
  in_end_group_id   IN NUMBER
);

/**********************************************/

FUNCTION TEST_IS_INVOICE_EXISTS(
/*
1 - exists
0 - not exists
*/
  in_invoice_id IN NUMBER
) RETURN NUMBER;

PROCEDURE TEST_GET_INVOICE_INFO (
  in_invoice_id  IN NUMBER,
  out_result_set OUT SYS_REFCURSOR
);

/******************************************************************************/

PROCEDURE TEST_DELETE_OFFER_CHAIN(
  in_offer_chain_id in number
);

END PROCS_TEST_V18;
.
/

--------------------------------------------------------------------------------
-- DDL for package PROCS_TRANSACTION
--------------------------------------------------------------------------------

CREATE OR REPLACE PACKAGE "PROCS_TRANSACTION_V18" AS 

PROCEDURE CREATE_TRANSACTION (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_transaction_id         IN NUMBER,
  in_status_id              IN NUMBER,
  in_amount                 IN NUMBER,
  in_created_by             IN VARCHAR2,
  in_order_id               IN VARCHAR2,
  in_is_refund              IN NUMBER DEFAULT GLOBAL_CONSTANTS_V18.FALSE,
  in_transaction_type_code  IN VARCHAR2 DEFAULT NULL,
  out_transaction_id        OUT NUMBER
);

PROCEDURE CREATE_TRANSACTION_ATTEMPT (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_transaction_id          IN NUMBER,
  in_trans_attempt_status    IN NUMBER,
  in_external_status_code    IN VARCHAR2,
  in_external_status_message IN VARCHAR2,
  in_created_by              IN VARCHAR2,
  in_ext_transaction_id      IN VARCHAR2,
  out_transaction_attempt_id OUT NUMBER
);

PROCEDURE UPDATE_TRANSACTION_STATUS (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_transaction_id        IN NUMBER,
  in_updated_by            IN VARCHAR2,
  in_transaction_status_id IN NUMBER
);

PROCEDURE UPDATE_TRANSACTION_SETTLED (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_transaction_id        IN NUMBER,
  in_updated_by            IN VARCHAR2,
  in_is_settled            IN NUMBER
);

PROCEDURE UPDATE_TRNSCTN_ATTEMPT_TIME (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_transaction_attempt_id IN NUMBER,
  in_updated_by             IN VARCHAR2
);

PROCEDURE UPDATE_TRNSCTN_ATTEMPT_STATUS (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_transaction_attempt_id     IN NUMBER,
  in_transaction_attempt_status IN NUMBER
);

PROCEDURE GET_TRNSCTN_ATTEMPTS_BY_STATUS (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_transaction_id             IN NUMBER,
  in_transaction_attempt_status IN NUMBER,
  out_result_set                OUT SYS_REFCURSOR
);

PROCEDURE UPDATE_TRANSACTION_ATTEMPT_INF (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_transaction_attempt_id IN NUMBER,
  in_ext_status_code        IN VARCHAR2,
  in_ext_status_message     IN VARCHAR2,
  in_ext_transaction_id     IN VARCHAR2
);

PROCEDURE GET_FAILED_ATTEMPTS_NUMBER (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_transaction_id IN  NUMBER,
  out_attempts_num  OUT NUMBER
);

PROCEDURE GET_TRANSACTION_AMOUNT (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_transaction_id      IN  NUMBER,
  out_transaction_amount OUT NUMBER
);

PROCEDURE GET_TRANSACTIONS_BY_CHARGE_ID (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_charge_id   IN  NUMBER,
  out_result_set OUT SYS_REFCURSOR
);

PROCEDURE GET_TRANSACTION_BY_ORDER_ID (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_order_id   IN  TRANSACTION.ORDER_ID%TYPE,
  out_result_set OUT SYS_REFCURSOR
);

PROCEDURE GET_TRANSACTIONS_BY_ORDER_ID (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_order_id   IN  TRANSACTION.ORDER_ID%TYPE,
  out_result_set OUT SYS_REFCURSOR
);

PROCEDURE GET_TRANSACTION_ATTEMPTS (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_transaction_id IN  NUMBER,
  out_result_set    OUT SYS_REFCURSOR
);

PROCEDURE RESERVE_TRANSACTION_ID (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  out_transaction_id OUT NUMBER
);

PROCEDURE GET_TRANSACTION_BY_ID (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_transaction_id IN NUMBER,
  out_result_set    OUT SYS_REFCURSOR
);

PROCEDURE UPDATE_TRANSACTION_ORDER_ID (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.INTRNAL_ERROR
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_transaction_id IN TRANSACTION.ID%TYPE,
  in_order_id       IN TRANSACTION.ORDER_ID%TYPE,
  in_updated_by     IN TRANSACTION.UPDATED_BY%TYPE
);

PROCEDURE GET_CLOSED_REFUNDS_BY_INVOICE (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_invoice_id   IN  NUMBER,
  out_result_set OUT SYS_REFCURSOR
);
PROCEDURE IS_TRANSACTION_SUCCESSFULL (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_transaction_id IN  NUMBER,
  out_is_successfull  OUT NUMBER
);

FUNCTION GET_TRANSACTION_TAX_AMOUNT (
  in_transaction_id IN NUMBER
) RETURN NUMBER;

FUNCTION GET_TRANSACTION_INTRL_TAXES (
  in_transaction_id IN NUMBER
) RETURN NUMBER;

-- norlov: #38796
PROCEDURE GET_TRANSACTIONS (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_group_id           IN  NUMBER,
  in_invoice_id         IN NUMBER DEFAULT NULL,
  in_subscription_id    IN NUMBER DEFAULT NULL,
  in_start_date         IN TRANSACTION.CREATE_DATE%TYPE DEFAULT NULL,
  in_end_date           IN TRANSACTION.CREATE_DATE%TYPE DEFAULT NULL,
  in_transaction_status IN NUMBER DEFAULT NULL,
  out_result_set        OUT SYS_REFCURSOR
);

FUNCTION IS_TRANSACTION_COLLECTED (
/*
Throws:
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
Returns:
GLOBAL_CONST.TRUE if transaction collected,
GLOBAL_CONST.FALSE else
*/
  in_transaction_id IN NUMBER
) RETURN NUMBER;

PROCEDURE GET_NEXT_ATTEMPT_NUMBER (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_charge_id   in  number,
  out_attempt_count out number
);

END PROCS_TRANSACTION_V18;
.
/

--------------------------------------------------------------------------------
-- DDL for package PROCS_TRANSACTION_CRU
--------------------------------------------------------------------------------

CREATE OR REPLACE PACKAGE "PROCS_TRANSACTION_CRU_V18" AS 

PROCEDURE CREATE_TRANSACTION (
  out_transaction_id       OUT TRANSACTION.ID%TYPE,
  in_transaction_id        IN TRANSACTION.ID%TYPE DEFAULT NULL,
  in_transaction_status_id IN TRANSACTION.TRANSACTION_STATUS_ID%TYPE,
  in_transaction_amount    IN TRANSACTION.TRANSACTION_AMOUNT%TYPE,
  in_created_by            IN TRANSACTION.CREATED_BY%TYPE,
  in_order_id              IN TRANSACTION.ORDER_ID%TYPE,
  in_is_refund             IN TRANSACTION.IS_REFUND%TYPE DEFAULT GLOBAL_CONSTANTS_V18.FALSE,
  in_transaction_type_code IN TRANSACTION.TRANSACTION_TYPE_CODE%TYPE DEFAULT NULL
);

PROCEDURE UPDATE_TRANSACTION (
  in_transaction_id        IN TRANSACTION.ID%TYPE,
  in_transaction_status_id IN TRANSACTION.TRANSACTION_STATUS_ID%TYPE DEFAULT NULL,
  in_transaction_amount    IN TRANSACTION.TRANSACTION_AMOUNT%TYPE DEFAULT NULL,
  in_updated_by            IN TRANSACTION.CREATED_BY%TYPE,
  in_order_id              IN TRANSACTION.ORDER_ID%TYPE DEFAULT NULL,
  in_is_settled            IN TRANSACTION.IS_SETTLED%TYPE DEFAULT NULL
);

PROCEDURE READ_TRANSACTION (
  in_transaction_id IN TRANSACTION.ID%TYPE,
  out_result_set    OUT SYS_REFCURSOR
);

PROCEDURE CREATE_TRANSACTION_ATTEMPT(
  inout_transaction_attempt_id IN OUT TRANSACTION_ATTEMPT.ID%TYPE,
  in_transaction_id            IN TRANSACTION_ATTEMPT.TRANSACTION_ID%TYPE,
  in_external_status_code      IN TRANSACTION_ATTEMPT.EXTERNAL_STATUS_CODE%TYPE DEFAULT NULL,
  in_external_status_message   IN TRANSACTION_ATTEMPT.EXTERNAL_STATUS_MESSAGE%TYPE DEFAULT NULL,
  in_created_by                IN TRANSACTION_ATTEMPT.CREATED_BY%TYPE,
  in_external_transaction_id   IN TRANSACTION_ATTEMPT.EXTERNAL_TRANSACTION_ID%TYPE DEFAULT NULL,
  in_transaction_start_time    IN TRANSACTION_ATTEMPT.TRANSACTION_START_TIME%TYPE DEFAULT NULL,
  in_status_id                 IN TRANSACTION_ATTEMPT.TRANSACTION_ATTEMPT_STATUS_ID%TYPE
);

PROCEDURE UPDATE_TRANSACTION_ORDER_ID (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.INTRNAL_ERROR
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_transaction_id IN TRANSACTION.ID%TYPE,
  in_order_id       IN TRANSACTION.ORDER_ID%TYPE,
  in_updated_by     IN TRANSACTION.UPDATED_BY%TYPE
);

PROCEDURE UPDATE_TRANSACTION_ATTEMPT (
  in_transaction_attempt_id  IN TRANSACTION_ATTEMPT.ID%TYPE,
  in_external_status_code    IN TRANSACTION_ATTEMPT.EXTERNAL_STATUS_CODE%TYPE DEFAULT NULL,
  in_external_status_message IN TRANSACTION_ATTEMPT.EXTERNAL_STATUS_MESSAGE%TYPE DEFAULT NULL,
  in_external_transaction_id IN TRANSACTION_ATTEMPT.EXTERNAL_TRANSACTION_ID%TYPE DEFAULT NULL,
  in_transaction_start_time  IN TRANSACTION_ATTEMPT.TRANSACTION_START_TIME%TYPE DEFAULT NULL,
  in_status_id               IN TRANSACTION_ATTEMPT.TRANSACTION_ATTEMPT_STATUS_ID%TYPE DEFAULT NULL
);

END PROCS_TRANSACTION_CRU_V18;
.
/

--------------------------------------------------------------------------------
-- DDL for package PUBLIC_PROCS_BILLING
--------------------------------------------------------------------------------

CREATE OR REPLACE PACKAGE "PUBLIC_PROCS_BILLING_V18" AS 

PROCEDURE GET_OFFER_CHAIN_BY_ID (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
    in_offer_chain_id IN   NUMBER,
    out_result_set    OUT  SYS_REFCURSOR
);

PROCEDURE GET_GC_ID_BY_PURCH_INVOICE_ID (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
in_invoice_id IN GIFT_CERTIFICATE.PURCHASE_INVOICE_ID%TYPE,
out_gift_certificate_id OUT GIFT_CERTIFICATE.ID%TYPE
);

PROCEDURE GET_PENDING_INVOICES (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  out_result_set1      OUT SYS_REFCURSOR,
  out_result_set2      OUT SYS_REFCURSOR,
  out_result_set3      OUT SYS_REFCURSOR,
  in_row_number        IN NUMBER DEFAULT NULL
);

PROCEDURE GET_PENDING_REFUND_CHARGES (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  out_result_set      OUT SYS_REFCURSOR,
  in_row_number       IN NUMBER DEFAULT NULL
);

PROCEDURE GET_UNPROCESSED_CHARGES (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_invoice_id  IN NUMBER,
  out_result_set OUT SYS_REFCURSOR
);

PROCEDURE GET_PROCESSED_CHARGES (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_invoice_id  IN NUMBER,
  out_result_set OUT SYS_REFCURSOR
);

PROCEDURE GET_TRNSCTN_ATTEMPTS_BY_STATUS (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_transaction_id             IN NUMBER,
  in_transaction_attempt_status IN NUMBER,
  out_result_set                OUT SYS_REFCURSOR
);

PROCEDURE UPDATE_TRNSCTN_ATTEMPT_STATUS (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_transaction_attempt_id     IN NUMBER,
  in_transaction_attempt_status IN NUMBER
);

PROCEDURE UPDATE_TRNSCTN_ATTEMPT_TIME (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_transaction_attempt_id IN NUMBER,
  in_updated_by             IN VARCHAR2
);

PROCEDURE CREATE_TRANSACTION_ATTEMPT (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_transaction_id          IN NUMBER,
  in_trans_attempt_status    IN NUMBER,
  in_external_status_code    IN VARCHAR2,
  in_external_status_message IN VARCHAR2,
  in_created_by              IN VARCHAR2,
  in_ext_transaction_id      IN VARCHAR2,
  out_transaction_attempt_id OUT NUMBER
);

PROCEDURE UPDATE_TRANSACTION_ATTEMPT_INF (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_transaction_attempt_id IN NUMBER,
  in_ext_status_code        IN VARCHAR2,
  in_ext_status_message     IN VARCHAR2,
  in_ext_transaction_id     IN VARCHAR2
);

PROCEDURE UPDATE_TRANSACTION_STATUS (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_transaction_id        IN NUMBER,
  in_updated_by            IN VARCHAR2,
  in_transaction_status_id IN NUMBER
);

PROCEDURE GET_FAILED_ATTEMPTS_NUMBER (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND
*/
  in_transaction_id IN  NUMBER,
  out_attempts_num  OUT NUMBER
);

PROCEDURE IS_TRANSACTION_SUCCESSFULL (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_transaction_id IN  NUMBER,
  out_is_successfull  OUT NUMBER
);

PROCEDURE UPDATE_INVOICE_STATUS (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_invoice_id                  IN NUMBER,
  in_invoice_status_id           IN NUMBER,
  in_updated_by                  IN VARCHAR2
);

PROCEDURE SUSPEND_SUBSCRIPTION(
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.INTERNAL_ERROR
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
    in_subs_id    IN NUMBER ,
    in_updated_by IN VARCHAR2
);

PROCEDURE GET_CREDIT_CARD_BY_ID (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_credit_card_id IN  NUMBER,
  out_result_set    OUT SYS_REFCURSOR
);

PROCEDURE GET_TRANSACTION_AMOUNT (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_transaction_id      IN  NUMBER,
  out_transaction_amount OUT NUMBER
);

PROCEDURE GET_ACCOUNT_BY_INVOICE_ID (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_invoice_id  IN  NUMBER,
  out_account_id OUT NUMBER
);

PROCEDURE GET_GIFT_CERTIFICATE_BY_ID (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND,
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_gift_certificate_id IN NUMBER,
  out_result_set         OUT SYS_REFCURSOR
);

PROCEDURE GET_SUBSCR_ID_BY_CHARGE_ID (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_charge_id        IN NUMBER,
  out_subscription_id OUT NUMBER
);

PROCEDURE IS_GCERT_FOR_PROPER_OFFER (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_gift_certificate_id IN NUMBER,
  in_charge_id           IN NUMBER,
  out_result             OUT NUMBER
);

PROCEDURE GET_SUBSCRIPTION_INFO (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
    in_subscription_id IN  NUMBER,
    out_result_set      OUT SYS_REFCURSOR
);

PROCEDURE CALCULATE_INVOICE_AMOUNT (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_invoice_id IN  NUMBER,
  out_amount    OUT NUMBER
);

PROCEDURE GET_TRANSACTION_BY_ID (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_transaction_id IN NUMBER,
  out_result_set    OUT SYS_REFCURSOR
);

PROCEDURE UPDATE_CHARGE_STATUS (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_charge_id        IN CHARGE.ID%TYPE,
  in_charge_status_id IN CHARGE.CHARGE_STATUS_ID%TYPE,
  in_updated_by       IN CHARGE.UPDATED_BY%TYPE
);

PROCEDURE GET_GC_BY_PURCH_INVOICE_ID (
  in_invoice_id           IN GIFT_CERTIFICATE.PURCHASE_INVOICE_ID%TYPE,
  out_result_set OUT SYS_REFCURSOR
);

PROCEDURE UPDATE_TRANSACTION_ORDER_ID (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.INTRNAL_ERROR
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_transaction_id IN TRANSACTION.ID%TYPE,
  in_order_id       IN TRANSACTION.ORDER_ID%TYPE,
  in_updated_by     IN TRANSACTION.UPDATED_BY%TYPE
);
PROCEDURE GET_CLOSED_REFUNDS_BY_INVOICE (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_invoice_id   IN  NUMBER,
  out_result_set OUT SYS_REFCURSOR
);
PROCEDURE GET_ACTIVE_INVOICES_IDS (
/*
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
--  in_subscription_id IN SUBSCRIPTION.ID%TYPE,
  in_subscription_id IN NUMBER,
  out_result_set     OUT SYS_REFCURSOR
);
PROCEDURE CANCEL_SUBSCRIPTION_INVOICE (
/*
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
APP_EXCEPTION_CODES_V18.INTERNAL_ERROR
*/
--  in_invoice_id        IN INVOICE.ID%TYPE,
--  in_updated_by        IN INVOICE.UPDATED_BY%TYPE,
-- norlov: in_refundable        IN refund enabled
  in_invoice_id        IN NUMBER,
  in_updated_by        IN VARCHAR2,
  in_refundable        IN NUMBER DEFAULT GLOBAL_CONSTANTS_V18.FALSE
--  in_cancellation_date IN DATE DEFAULT current_timestamp
);

PROCEDURE FINALIZE_CANCELATION (
/*
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
APP_EXCEPTION_CODES_V18.INTERNAL_ERROR
*/
--  in_subscription_id    IN SUBSCRIPTION.ID%TYPE,
--  in_cancelation_reason IN SUBSCRIPTION_CANCEL_REASON.VALUE%TYPE,
--  in_cancelation_date   IN SUBSCRIPTION.CANCELLATION_DATE%TYPE,
--  in_note               IN SUBSCRIPTION_NOTE.NOTE%TYPE,
--  in_agent_id           IN SUBSCRIPTION_NOTE.AGENT_ID%TYPE,
--  in_updated_by         IN SUBSCRIPTION.UPDATED_BY%TYPE
  in_subscription_id    IN NUMBER,
  in_cancelation_reason IN VARCHAR2,
  in_cancelation_date   IN DATE,
  in_note               IN VARCHAR2,
  in_agent_id           IN NUMBER,
  in_updated_by         IN VARCHAR2
);
PROCEDURE GET_SUBSCR_PROD_OFFERRINGS (
/*
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_subscription_id IN NUMBER,
  out_result_set     OUT SYS_REFCURSOR
);
PROCEDURE GET_OFFER_CHAIN_META_DATA (
/*
Throws exceptions (codes):
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_offer_chain_id IN NUMBER,
  in_meta_data_name IN VARCHAR2,
  out_result_set    OUT SYS_REFCURSOR
);
PROCEDURE GET_PRODUCT_OFFERING_META_DATA (
/*
Throws exceptions (codes):
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_product_offering_id IN NUMBER,
  in_meta_data_name      IN VARCHAR2 DEFAULT NULL,
  out_result_set         OUT SYS_REFCURSOR
);
PROCEDURE READ_ACCOUNT (
  in_account_id  IN ACCOUNT.ID%TYPE,
  out_result_set OUT SYS_REFCURSOR
);

PROCEDURE GET_COLLECTED_CHARGES (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_invoice_id  IN NUMBER,
  out_result_set OUT SYS_REFCURSOR
);

PROCEDURE GET_GROUPS_ID_BY_INVOICE_ID (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND,
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_invoice_id IN NUMBER,
  out_group_ids OUT SYS_REFCURSOR
);

PROCEDURE GET_ACCOUNT_ID_BY_GROUP_ID (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND,
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_group_id IN NUMBER,
  out_account_id  OUT NUMBER
);

PROCEDURE LOCK_ACCOUNT (
  in_group_id    IN NUMBER,
  in_lock_key    IN VARCHAR2,
  in_seconds_num IN NUMBER,
  in_created_by  IN VARCHAR2,
  in_reason      IN VARCHAR2
);

PROCEDURE RELEASE_LOCK (
  in_group_id IN NUMBER,
  in_lock_key IN VARCHAR2
);

PROCEDURE GET_PAYMENT_INFO_BY_INVOICE_ID (
  in_invoice_id               IN NUMBER,
  out_order_id                OUT VARCHAR2,
  out_external_transaction_id OUT VARCHAR2
);

PROCEDURE GET_PAYPAL_BY_ID (
  in_paypal_id   IN  NUMBER,
  out_result_set OUT SYS_REFCURSOR
);

PROCEDURE GET_NEXT_ATTEMPT_NUMBER (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_charge_id   in  number,
  out_attempt_count out number
);

PROCEDURE GET_NOTIFICATION_TYPE_ID (
  in_offer_chain_id        IN NUMBER,
  in_action_name           IN VARCHAR2,
  out_notification_type_id out number
);

PROCEDURE SHOULD_MOVE_TO_GRACE(
  in_invoice_id  IN INVOICE.ID%TYPE,
  out_result     OUT NUMBER
);

PROCEDURE MOVE_TO_GRACE(
  in_invoice_id                 IN INVOICE.ID%TYPE,
  in_updated_by                 IN LICENSE.UPDATED_BY%TYPE,
  in_grace_period_length_hours  IN NUMBER
);

PROCEDURE MOVE_OUT_OF_GRACE(
  in_invoice_id   IN INVOICE.ID%TYPE,
  in_updated_by   IN LICENSE.UPDATED_BY%TYPE
);

END PUBLIC_PROCS_BILLING_V18;
.
/

--------------------------------------------------------------------------------
-- DDL for package PUBLIC_PROCS_CLIENT
--------------------------------------------------------------------------------

CREATE OR REPLACE PACKAGE "PUBLIC_PROCS_CLIENT_V18" AS 

PROCEDURE GET_NOTIFICATION_TYPE_BY_NAME (
/*
Throws exceptions:
CORE_OWNER.APP_EXCEPTION_CODES_V18.NOT_FOUND
CORE_OWNER.APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_notification_type_name IN VARCHAR2,
  out_notification_type_id  OUT NUMBER
);

PROCEDURE ADD_NOTIFICATION (
/*
Throws exceptions:
CORE_OWNER.APP_EXCEPTION_CODES_V18.NOT_FOUND
CORE_OWNER.APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_sender_account_id     IN NUMBER DEFAULT 0,
  in_recipient_group_id    IN NUMBER,
  in_notification_type_id  IN NUMBER,
  in_date_to_notify        IN DATE,
  in_email_template_params IN CLOB
);

END PUBLIC_PROCS_CLIENT_V18;
.
/

--------------------------------------------------------------------------------
-- DDL for package PUBLIC_PROCS_NOTIFICATION
--------------------------------------------------------------------------------

CREATE OR REPLACE PACKAGE "PUBLIC_PROCS_NOTIFICATION_V18" AS 

PROCEDURE LOCK_ACCOUNT (
  in_group_id    IN NUMBER,
  in_lock_key    IN VARCHAR2,
  in_seconds_num IN NUMBER,
  in_created_by  IN VARCHAR2,
  in_reason      IN VARCHAR2
);

PROCEDURE RELEASE_LOCK (
  in_group_id IN NUMBER,
  in_lock_key IN VARCHAR2
);

END PUBLIC_PROCS_NOTIFICATION_V18;
.
/

--------------------------------------------------------------------------------
-- DDL for package PUBLIC_PROCS_RENEWAL
--------------------------------------------------------------------------------

CREATE OR REPLACE PACKAGE "PUBLIC_PROCS_RENEWAL_V18" AS 

PROCEDURE SUB_EXPIRES_NEED_ENTITLEMENTS (
  out_result_set OUT SYS_REFCURSOR
);

PROCEDURE UPDATE_SS_NEED_ENTITLEMENTS (
  in_sub_share_id      IN SUBSCRIPTION_SHARE.ID%TYPE,
  in_need_entitlements IN SUBSCRIPTION_SHARE.NEEDS_ENTITLEMENTS%TYPE,
  in_updater           IN SUBSCRIPTION_SHARE.UPDATED_BY%TYPE
);

PROCEDURE GET_OFFER_CHAIN_BY_ID (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
    in_offer_chain_id IN   NUMBER,
    out_result_set    OUT  SYS_REFCURSOR
);

PROCEDURE GET_UNREDEEMED_GCS (
  out_result_set          OUT SYS_REFCURSOR,
  in_hours_number         IN NUMBER DEFAULT 14*24,
  in_num_rows             IN NUMBER DEFAULT 10000,
  in_process_name         IN PROCESS_RETRY_THROTTLE.PROCESS_NAME%TYPE
);

PROCEDURE GET_SUBSCRIPTIONS_META_DATA (
/*
APP_EXCEPTION_CODES_V18.INVALID_PARAMETER
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_subscriptions_ids IN core_owner.NUMBER_TABLE,
  out_result_set       OUT SYS_REFCURSOR
);

PROCEDURE GET_ALL_OCH_META_DATA (
  in_offer_chain_id IN NUMBER,
  out_result_set    OUT SYS_REFCURSOR
);

PROCEDURE GET_OFFER_CHAIN_META_DATA (
/*
Throws exceptions (codes):
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_offer_chain_id IN NUMBER,
  in_meta_data_name IN VARCHAR2,
  out_result_set    OUT SYS_REFCURSOR
);

PROCEDURE GET_ENDING_LICENSES (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_hours_number IN NUMBER,
  out_result_set OUT SYS_REFCURSOR
);

PROCEDURE GET_ENDING_LICENSES_CC (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_hours_number IN NUMBER,
  out_result_set OUT SYS_REFCURSOR,
  in_process_name         IN PROCESS_RETRY_THROTTLE.PROCESS_NAME%TYPE
);

/************************************************/

PROCEDURE GET_RECURRING_OFFER (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_license_id  IN NUMBER,
  out_result_set OUT SYS_REFCURSOR
);

/*************************************************/

PROCEDURE GET_NEXT_OFFER (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.INTERNAL_ERROR
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_license_id  IN NUMBER,
  out_result_set OUT SYS_REFCURSOR
);

/**************************************************/

PROCEDURE UPDATE_LICENSE_STATUS(
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
    in_license_id     IN NUMBER,
    in_license_status IN NUMBER,
    in_updated_by     IN VARCHAR2
);

/***************************************************/

PROCEDURE UPDATE_INVOICE_STATUS (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_invoice_id                  IN NUMBER,
  in_invoice_status_id           IN NUMBER,
  in_updated_by                  IN VARCHAR2
);

/***************************************************/

PROCEDURE CREATE_LICENSE(
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
APP_EXCEPTION_CODES_V18.INTERNAL_ERROR
*/
  in_status_id                IN NUMBER,
  in_needs_entitlements       IN NUMBER,
  in_start_date               IN DATE,
  in_end_date                 IN DATE,
  in_offer_id                 IN NUMBER,
  in_subscription_id          IN NUMBER,
  in_invoice_id               IN NUMBER,
  in_created_by               IN VARCHAR2,
  in_is_extension             IN NUMBER,
  in_current_offer_index      IN NUMBER,
  in_current_offer_recurr_num IN NUMBER,
  out_license_id              OUT NUMBER
);

/**************************************************/

PROCEDURE CREATE_INVOICE(
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
    in_invoice_status IN NUMBER,
    in_created_by     IN VARCHAR2,
    in_tax_exempt_id  IN VARCHAR2,
    out_invoice_id    OUT NUMBER
);

/*****************************************************/

PROCEDURE CREATE_CHARGE(
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_invoice_id         IN NUMBER,
  in_transaction_id     IN NUMBER,
  in_instrument_type_id IN NUMBER,
  in_instrument_id      IN NUMBER,
  in_charge_amount      IN NUMBER,
  in_created_by         IN VARCHAR2,
  in_charge_status_id   IN NUMBER,
  out_charge_id         OUT NUMBER
);

/*****************************************************/

PROCEDURE HAS_FUTURE_LICENSE (
/*
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
--
RETURNS:
1 - if has,
0 - else
*/
  in_license_id IN NUMBER,
  out_result         OUT NUMBER
);

/*****************************************************/

PROCEDURE GET_GROUP_ID_BY_LICENSE_ID (
/*
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_license_id IN NUMBER,
  out_group_id  OUT NUMBER
);

/*****************************************************/

PROCEDURE GET_OFFER_PRODUCTS (
/*
Throws exceptions (codes):
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_offer_id    IN NUMBER,
  out_result_set OUT SYS_REFCURSOR
);

/*******************************************************/

PROCEDURE CREATE_TRANSACTION (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_transaction_id         IN NUMBER,
  in_status_id              IN NUMBER,
  in_amount                 IN NUMBER,
  in_created_by             IN VARCHAR2,
  in_order_id               IN VARCHAR2,
  in_transaction_type_code  IN VARCHAR2 DEFAULT NULL,
  out_transaction_id        OUT NUMBER
);

/*********************************************************/

PROCEDURE ADD_LINE_ITEMS(
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_invoice_id IN NUMBER,
  in_offer_id   IN NUMBER,
  in_created_by IN VARCHAR2
);

/**********************************************************/

PROCEDURE CALCULATE_INVOICE_AMOUNT (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_invoice_id IN  NUMBER,
  out_amount    OUT NUMBER
);

/*********************************************************/

PROCEDURE RESERVE_TRANSACTION_ID (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  out_transaction_id OUT NUMBER
);

/**********************************************************/

PROCEDURE P_GET_NEXT_OFFER_INDEX (
  in_offer_chain_id            IN NUMBER,
  in_offer_chain_current_index IN NUMBER,
  out_next_offer_index         OUT NUMBER
);

/***********************************************************/

PROCEDURE GET_NEXT_OFFER_INDEX_BY_LCNS (
  in_license_id                IN NUMBER,
  in_offer_chain_current_index IN NUMBER,
  out_next_offer_index         OUT NUMBER
);

/**********************************************************/

PROCEDURE GET_SUBSCRIPTION_INFO (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
    in_subscription_id IN  NUMBER,
    out_result_set      OUT SYS_REFCURSOR
);

/***********************************************************/

PROCEDURE CLOSE_SUBSCRIPTION (
  in_subscription_id IN NUMBER,
  in_updated_by      IN VARCHAR2
);

/***********************************************************/

PROCEDURE GET_NEED_ENTITLEMENTS_LICENSES (
  out_result_set OUT SYS_REFCURSOR
);

/***********************************************************/

PROCEDURE UPDATE_NEED_ENTITLEMENTS_FLAG (
  in_license_id         IN NUMBER,
  in_needs_entitlements IN NUMBER,
  in_updated_by         IN VARCHAR2
);
/***********************************************************/
PROCEDURE GET_PROD_OFFERINGS_BY_OFFER_ID (
  in_offer_id    IN NUMBER,
  out_result_set OUT SYS_REFCURSOR
);
/***********************************************************/
PROCEDURE GET_PRODUCT_OFFERING_META_DATA (
  in_product_offering_id IN NUMBER,
  in_meta_data_name      IN VARCHAR2 DEFAULT NULL,
  out_result_set         OUT SYS_REFCURSOR
);

PROCEDURE LOCK_ACCOUNT (
  in_group_id    IN NUMBER,
  in_lock_key    IN VARCHAR2,
  in_seconds_num IN NUMBER,
  in_created_by  IN VARCHAR2,
  in_reason      IN VARCHAR2
);

PROCEDURE RELEASE_LOCK (
  in_group_id IN NUMBER,
  in_lock_key IN VARCHAR2
);

PROCEDURE GET_INVOICE_LINE_ITEMS (
  in_invoice_id  IN NUMBER,
  out_result_set OUT SYS_REFCURSOR
);

PROCEDURE ADD_TAX (
  in_tax_type_id           IN NUMBER,
  in_calculated_amount     IN NUMBER,
  in_created_by            IN VARCHAR2,
  in_line_item_id          IN NUMBER,
  in_effective_rate        IN VARCHAR2,
  in_taxable_amount        IN NUMBER,
  in_tax_rule_id           IN NUMBER,
  in_jurisdiction_level_id IN NUMBER,
  in_jurisdiction_name     IN VARCHAR2,
  in_jurisdiction_id       IN VARCHAR2,
  in_ext_tax_type          IN VARCHAR2,
  in_ext_result            IN VARCHAR2,
  in_imposition_type       IN VARCHAR2,
  in_imposition            IN VARCHAR2
);

PROCEDURE GET_CREDIT_CARD_BY_ID (
  in_credit_card_id IN  NUMBER,
  out_result_set    OUT SYS_REFCURSOR
);

PROCEDURE GET_PRD_OFFERING_BY_LINE_IT_ID (
  in_line_item_id IN NUMBER,
  out_result_set  OUT SYS_REFCURSOR
);

PROCEDURE GET_ACCOUNT_ID_BY_GROUP_ID (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND,
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_group_id IN NUMBER,
  out_account_id  OUT NUMBER
);

PROCEDURE GET_LINE_ITEM_DISCOUNTS (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_line_item_id IN  NUMBER,
  out_result_set  OUT SYS_REFCURSOR
);

PROCEDURE UPDATE_LINE_ITEM_AMOUNT (
  in_line_item_id    IN NUMBER,
  in_amount          IN NUMBER,
  in_discount_amount IN NUMBER,
  in_taxes_amount    IN NUMBER
);

PROCEDURE GET_PAYPAL_BY_ID (
  in_paypal_id   IN  NUMBER,
  out_result_set OUT SYS_REFCURSOR
);

PROCEDURE GET_GC_BY_PURCH_INVOICE_ID (
  in_invoice_id           IN GIFT_CERTIFICATE.PURCHASE_INVOICE_ID%TYPE,
  out_result_set OUT SYS_REFCURSOR
);

PROCEDURE GET_LICENSE_BY_ID (
  in_license_id  IN NUMBER,
  out_result_set OUT SYS_REFCURSOR
);

PROCEDURE GET_NOTIFICATION_TYPE_ID (
  in_offer_chain_id        IN NUMBER,
  in_action_name           IN VARCHAR2,
  out_notification_type_id OUT NUMBER
);

PROCEDURE GET_OFFER_CHAIN_MD_VALUE (
  in_offer_chain_id IN NUMBER,
  in_meta_data_name IN VARCHAR2,
  out_value         OUT VARCHAR2
);

PROCEDURE GET_ACT_SUBS_W_CPT_CHARGEBACKS (
  out_result_set      OUT SYS_REFCURSOR
);

PROCEDURE GET_ACT_SUBS_W_PP_CHARGEBACKS (
  out_result_set      OUT SYS_REFCURSOR
);

PROCEDURE GET_ACT_SUBS_W_AMEX_CB (
  out_result_set      OUT SYS_REFCURSOR
);

PROCEDURE GET_GRACE_PERIOD_SUB_REGIS (
  in_max_days_until_close IN NUMBER,
  in_num_subs_to_fetch    IN NUMBER,
  out_result_set          OUT SYS_REFCURSOR
);

PROCEDURE GET_GRACE_LICE_FOR_FINAL_TRANS (
  in_days_before_close     IN NUMBER,
  in_num_licenses_to_fetch IN NUMBER,
  out_result_set           OUT SYS_REFCURSOR
);

END PUBLIC_PROCS_RENEWAL_V18;
.
/

CREATE OR REPLACE PACKAGE BODY "PROCS_ACCOUNT_CRU_V18" AS

PROCEDURE CREATE_ACCOUNT (
  out_account_id        OUT ACCOUNT.ID%TYPE,
  in_account_status_id  IN ACCOUNT.ACCOUNT_STATUS_ID%TYPE,
  in_suspend_date       IN ACCOUNT.SUSPEND_DATE%TYPE DEFAULT NULL,
  in_group_id           IN ACCOUNT.GROUP_ID%TYPE,
  in_created_by         IN ACCOUNT.CREATED_BY%TYPE,
  in_system_category_id IN ACCOUNT.SYSTEM_CATEGORY_ID%TYPE,
  in_instrument_type_id IN ACCOUNT.INSTRUMENT_TYPE_ID%TYPE DEFAULT NULL,
  in_instrument_id      IN ACCOUNT.INSTRUMENT_ID%TYPE DEFAULT NULL
) AS
-- VARIABLES
var_new_account_id ACCOUNT.ID%TYPE;
-- arosolovskiy: using data variable instead of direct get data calls (#38860)
var_date DATE := SYSDATE;
BEGIN
  SELECT
    ACC_ID_SEQ.nextVal into var_new_account_id
  FROM DUAL;
  INSERT INTO ACCOUNT (
    ID,
    ACCOUNT_STATUS_ID,
    SUSPEND_DATE,
    GROUP_ID,
    CREATE_DATE,
    CREATED_BY,
    UPDATE_DATE,
    UPDATED_BY,
    SYSTEM_CATEGORY_ID,
    INSTRUMENT_TYPE_ID,
    INSTRUMENT_ID,
    TAX_EXEMPT_ID
  ) VALUES (
    var_new_account_id,
    in_account_status_id,
    in_suspend_date,
    in_group_id,
    var_date,
    in_created_by,
    var_date,
    in_created_by,
    in_system_category_id,
    in_instrument_type_id,
    in_instrument_id,
    NULL
  );

  out_account_id := var_new_account_id;
END CREATE_ACCOUNT;

/*************************************************************/

PROCEDURE UPDATE_ACCOUNT (
  in_account_id         IN ACCOUNT.ID%TYPE,
  in_account_status_id  IN ACCOUNT.ACCOUNT_STATUS_ID%TYPE DEFAULT NULL,
  in_suspend_date       IN ACCOUNT.SUSPEND_DATE%TYPE DEFAULT NULL,
  in_updated_by         IN ACCOUNT.UPDATED_BY%TYPE,
  in_system_category_id IN ACCOUNT.SYSTEM_CATEGORY_ID%TYPE DEFAULT NULL,
  in_instrument_type_id IN ACCOUNT.INSTRUMENT_TYPE_ID%TYPE DEFAULT NULL,
  in_instrument_id      IN ACCOUNT.INSTRUMENT_ID%TYPE DEFAULT NULL
) AS
BEGIN

  -- CREATE HISTORY
  PROCS_HISTORY_V18.CREATE_ACCOUNT_HISTORY(
    in_account_id                => in_account_id,
    in_system_activity_reason_id => GLOBAL_ENUMS_V18.SAC_SYSTEM_APPLIED_RULE
  );

  UPDATE ACCOUNT SET
    ACCOUNT_STATUS_ID  = NVL(in_account_status_id, ACCOUNT_STATUS_ID),
    SUSPEND_DATE       = NVL(in_suspend_date, SUSPEND_DATE),
    UPDATED_BY         = in_updated_by,
    UPDATE_DATE        = SYSDATE,
    SYSTEM_CATEGORY_ID = NVL(in_system_category_id, SYSTEM_CATEGORY_ID),
    INSTRUMENT_TYPE_ID = NVL(in_instrument_type_id, INSTRUMENT_TYPE_ID),
    INSTRUMENT_ID      = NVL(in_instrument_id, INSTRUMENT_ID)
  WHERE
    ACCOUNT.ID = in_account_id;

END UPDATE_ACCOUNT;

/*************************************************************/

PROCEDURE UPDATE_DEF_FIN_INSTRUMENT(
  in_account_id         IN ACCOUNT.ID%TYPE,
  in_instrument_type_id IN ACCOUNT.INSTRUMENT_TYPE_ID%TYPE,
  in_instrument_id      IN ACCOUNT.INSTRUMENT_ID%TYPE,
  in_updated_by         IN ACCOUNT.UPDATED_BY%TYPE
) AS
BEGIN

  -- CREATE HISTORY
  PROCS_HISTORY_V18.CREATE_ACCOUNT_HISTORY(
    in_account_id                => in_account_id,
    in_system_activity_reason_id => GLOBAL_ENUMS_V18.SAC_SYSTEM_APPLIED_RULE
  );

  UPDATE ACCOUNT SET
    INSTRUMENT_TYPE_ID = in_instrument_type_id,
    INSTRUMENT_ID      = in_instrument_id
  WHERE
    ACCOUNT.ID = in_account_id;

END;

/*************************************************************/

PROCEDURE READ_ACCOUNT (
  in_account_id  IN ACCOUNT.ID%TYPE,
  out_result_set OUT SYS_REFCURSOR
) AS
BEGIN
  OPEN out_result_set FOR
  SELECT
    ACCOUNT_STATUS_ID,
    SUSPEND_DATE,
    GROUP_ID
  FROM
    ACCOUNT
  WHERE
    ID = in_account_id;
END READ_ACCOUNT;

/*************************************************************/

PROCEDURE CREATE_ACCOUNT_NOTE (
  inout_account_note_id IN OUT ACCOUNT_NOTE.ID%TYPE,
  in_agent_id           IN ACCOUNT_NOTE.AGENT_ID%TYPE,
  in_account_id         IN ACCOUNT_NOTE.ACCOUNT_ID%TYPE,
  in_note               IN ACCOUNT_NOTE.NOTE%TYPE,
  in_created_by         IN ACCOUNT_NOTE.CREATED_BY%TYPE
) AS
BEGIN
  IF inout_account_note_id IS NULL THEN
    SELECT
      ACCN_ID_SEQ.nextVal into inout_account_note_id
    FROM DUAL;
  END IF;
  INSERT INTO ACCOUNT_NOTE(
    ID,
    AGENT_ID,
    ACCOUNT_ID,
    NOTE,
    CREATE_DATE,
    CREATED_BY
  ) VALUES (
    inout_account_note_id,
    in_agent_id,
    in_account_id,
    in_note,
    SYSDATE,
    in_created_by
  );
END CREATE_ACCOUNT_NOTE;

END PROCS_ACCOUNT_CRU_V18;
.
/

CREATE OR REPLACE PACKAGE BODY "PROCS_ADDRESS_CRU_V18" AS

PROCEDURE CREATE_ADDRESS(
  out_address_id        OUT ADDRESS.ID%TYPE,
  in_address_id         IN ADDRESS.ID%TYPE DEFAULT NULL,
  in_address1           IN ADDRESS.ADDRESS1%TYPE DEFAULT NULL,
  in_address2           IN ADDRESS.ADDRESS2%TYPE DEFAULT NULL,
  in_city               IN ADDRESS.CITY%TYPE DEFAULT NULL,
  in_state              IN ADDRESS.STATE%TYPE DEFAULT NULL,
  in_postal_code        IN ADDRESS.POSTAL_CODE%TYPE DEFAULT NULL,
  in_country            IN ADDRESS.COUNTRY%TYPE DEFAULT NULL,
  in_created_by         IN ADDRESS.CREATED_BY%TYPE
) AS
-- VARIABLES
var_address_id ADDRESS.ID%TYPE;
var_date DATE := SYSDATE;
BEGIN
  IF in_address_id IS NULL THEN
    SELECT
      ADDRESS_ID_SEQ.nextVal into var_address_id
    FROM DUAL;
  ELSE
    var_address_id := in_address_id;
  END IF;
  INSERT INTO
    ADDRESS (
      ID,
      ADDRESS1,
      ADDRESS2,
      CITY,
      STATE,
      POSTAL_CODE,
      COUNTRY,
      CREATE_DATE,
      CREATED_BY,
      UPDATE_DATE,
      UPDATED_BY
    ) VALUES (
      var_address_id,
      in_address1,
      in_address2,
      in_city,
      in_state,
      in_postal_code,
      in_country,
      var_date,
      in_created_by,
      var_date,
      in_created_by
    );

  out_address_id := var_address_id;
END CREATE_ADDRESS;

PROCEDURE UPDATE_ADDRESS(
  in_address_id         IN ADDRESS.ID%TYPE,
  in_address1           IN ADDRESS.ADDRESS1%TYPE DEFAULT NULL,
  in_address2           IN ADDRESS.ADDRESS2%TYPE DEFAULT NULL,
  in_city               IN ADDRESS.CITY%TYPE DEFAULT NULL,
  in_state              IN ADDRESS.STATE%TYPE DEFAULT NULL,
  in_postal_code        IN ADDRESS.POSTAL_CODE%TYPE DEFAULT NULL,
  in_country            IN ADDRESS.COUNTRY%TYPE DEFAULT NULL,
  in_updated_by         IN ADDRESS.UPDATED_BY%TYPE
) AS
BEGIN

  -- Create history
  PROCS_HISTORY_V18.CREATE_ADDRESS_HISTORY(
    in_address_id                 => in_address_id,
    in_system_activity_reason_id => GLOBAL_ENUMS_V18.SAC_SYSTEM_APPLIED_RULE
  );

  UPDATE
    ADDRESS
  SET
    ADDRESS1 = NVL(in_address1, ADDRESS1),
    ADDRESS2 = NVL(in_address2, ADDRESS2),
    CITY = NVL(in_city, CITY),
    STATE = NVL(in_state, STATE),
    POSTAL_CODE = NVL(in_postal_code, POSTAL_CODE),
    COUNTRY = NVL(in_country, COUNTRY),
    UPDATE_DATE = SYSDATE,
    UPDATED_BY = in_updated_by
  WHERE
    ID = in_address_id;

END UPDATE_ADDRESS;

END PROCS_ADDRESS_CRU_V18;
.
/

CREATE OR REPLACE PACKAGE BODY "PROCS_AMAZON_CRU_V18" AS

PROCEDURE CREATE_AMAZON_SUB(
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
    out_id              OUT NUMBER,
    in_subscription_id  IN AMAZON_SUB.SUBSCRIPTION_ID%TYPE,
    in_amazon_id        IN AMAZON_SUB.AMAZON_ID%TYPE,
    in_created_by       IN AMAZON_SUB.CREATED_BY%TYPE
) AS
-- VARIABLES
SPROC_NAME        CONSTANT VARCHAR2(32) := 'CREATE_AMAZON_SUB';
var_current_date  DATE;
var_count         NUMBER;
AMAZON_SUB_USED   EXCEPTION;
BEGIN

  SELECT COUNT(1) INTO var_count
  FROM SUBSCRIPTION s, AMAZON_SUB am
  WHERE
    am.AMAZON_ID = in_amazon_id
    and am.subscription_id = s.id
    and s.subscription_status_id = GLOBAL_STATUSES_V18.SUBSCRIPTION_ACTIVE;

  if var_count > 0 then
    raise AMAZON_SUB_USED;
  end if;

  SELECT
    CORE_OWNER.AMAZON_SUB_ID_SEQ.NEXTVAL
  INTO
    out_id
  FROM
    dual
  ;

  SELECT
    sysdate
  INTO
    var_current_date
  FROM
    dual
  ;

  INSERT INTO CORE_OWNER.AMAZON_SUB
  (
    id,
    subscription_id,
    amazon_id,
    create_date,
    created_by,
    update_date,
    updated_by
  )
  VALUES
  (
    out_id,
    in_subscription_id,
    in_amazon_id,
    var_current_date,
    in_created_by,
    var_current_date,
    in_created_by
  );

EXCEPTION
WHEN AMAZON_SUB_USED THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.DUPLICATE_ERROR,
    SPROC_NAME, 'Amazon sub already used', SQLERRM);
WHEN DUP_VAL_ON_INDEX THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.DUPLICATE_ERROR,
    SPROC_NAME, 'Duplicate value', SQLERRM);
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END CREATE_AMAZON_SUB;

END PROCS_AMAZON_CRU_V18;
.
/

CREATE OR REPLACE PACKAGE BODY "PROCS_CHARGE_CRU_V18" AS

PROCEDURE CREATE_CHARGE(
  out_charge_id         OUT CHARGE.ID%TYPE,
  in_charge_id          IN CHARGE.ID%TYPE DEFAULT NULL,
  in_invoice_id         IN CHARGE.INVOICE_ID%TYPE,
  in_transaction_id     IN CHARGE.TRANSACTION_ID%TYPE DEFAULT NULL,
  in_instrument_type_id IN CHARGE.INSTRUMENT_TYPE_ID%TYPE,
  in_instrument_id      IN CHARGE.INSTRUMENT_ID%TYPE,
  in_charge_amount      IN CHARGE.CHARGE_AMOUNT%TYPE,
  in_charge_status_id   IN CHARGE.CHARGE_STATUS_ID%TYPE,
  in_created_by         IN CHARGE.CREATED_BY%TYPE
) AS
-- VARIABLES
var_charge_id CHARGE.ID%TYPE;
-- arosolovskiy: using data variable instead of direct get data calls (#38860)
var_date DATE := SYSDATE;
BEGIN
  IF in_charge_id IS NULL THEN
    SELECT
      CRG_ID_SEQ.nextVal into var_charge_id
    FROM DUAL;
  ELSE
    var_charge_id := in_charge_id;
  END IF;
  INSERT INTO
    CHARGE (
      ID,
      INVOICE_ID,
      TRANSACTION_ID,
      INSTRUMENT_TYPE_ID,
      INSTRUMENT_ID,
      CHARGE_AMOUNT,
      CHARGE_STATUS_ID,
      CREATE_DATE,
      CREATED_BY,
      UPDATE_DATE,
      UPDATED_BY
    ) VALUES (
      var_charge_id,
      in_invoice_id,
      in_transaction_id,
      in_instrument_type_id,
      in_instrument_id,
      in_charge_amount,
      in_charge_status_id,
      var_date,
      in_created_by,
      var_date,
      in_created_by
    );

  out_charge_id := var_charge_id;
END CREATE_CHARGE;

PROCEDURE UPDATE_CHARGE(
  in_charge_id          IN CHARGE.ID%TYPE,
  in_instrument_type_id IN CHARGE.INSTRUMENT_TYPE_ID%TYPE DEFAULT NULL,
  in_instrument_id      IN CHARGE.INSTRUMENT_ID%TYPE DEFAULT NULL,
  in_charge_amount      IN CHARGE.CHARGE_AMOUNT%TYPE DEFAULT NULL,
  in_charge_status_id   IN CHARGE.CHARGE_STATUS_ID%TYPE DEFAULT NULL,
  in_updated_by         IN CHARGE.UPDATED_BY%TYPE
) AS
BEGIN

  -- Create history
  PROCS_HISTORY_V18.CREATE_CHARGE_HISTORY(
    in_charge_id                 => in_charge_id,
    in_system_activity_reason_id => GLOBAL_ENUMS_V18.SAC_SYSTEM_APPLIED_RULE
  );

  UPDATE
    CHARGE
  SET
    INSTRUMENT_TYPE_ID = NVL(in_instrument_type_id, INSTRUMENT_TYPE_ID),
    INSTRUMENT_ID      = NVL(in_instrument_id, INSTRUMENT_ID),
    CHARGE_AMOUNT      = NVL(in_charge_amount, CHARGE_AMOUNT),
    CHARGE_STATUS_ID   = NVL(in_charge_status_id, CHARGE_STATUS_ID),
    UPDATE_DATE        = SYSDATE,
    UPDATED_BY         = in_updated_by
  WHERE
    ID = in_charge_id;

END UPDATE_CHARGE;

END PROCS_CHARGE_CRU_V18;
.
/

CREATE OR REPLACE PACKAGE BODY "PROCS_FIN_INSTRUMENTS_CRU_V18" AS

PROCEDURE CREATE_CREDIT_CARD(
  out_credit_card_id          OUT CREDIT_CARD.ID%TYPE,
  in_credit_card_id           IN CREDIT_CARD.ID%TYPE DEFAULT NULL,
  in_account_id               IN CREDIT_CARD.ACCOUNT_ID%TYPE,
  in_instrument_name          IN CREDIT_CARD.INSTRUMENT_NAME%TYPE,
  in_private_card_holder_name IN CREDIT_CARD.PRIVATE_CARD_HOLDER_NAME%TYPE,
  in_private_street_address   IN CREDIT_CARD.PRIVATE_STREET_ADDRESS%TYPE,
  in_private_street_address2  IN CREDIT_CARD.PRIVATE_STREET_ADDRESS2%TYPE DEFAULT NULL,
  in_state                    IN CREDIT_CARD.STATE%TYPE,
  in_city                     IN CREDIT_CARD.CITY%TYPE,
  in_postal_code              IN CREDIT_CARD.POSTAL_CODE%TYPE,
  in_country                  IN CREDIT_CARD.COUNTRY%TYPE,
  in_last_four_cc             IN CREDIT_CARD.LAST_FOUR_CC%TYPE,
  in_expiration_date          IN CREDIT_CARD.EXPIRATION_DATE%TYPE,
  in_credit_card_type_id      IN CREDIT_CARD.CREDIT_CARD_TYPE_ID%TYPE,
  in_secret_token             IN CREDIT_CARD.SECRET_TOKEN%TYPE,
  in_chase_profile_id		  in CREDIT_CARD.CHASE_PROFILE_ID%TYPE,
  in_created_by               IN CREDIT_CARD.CREATED_BY%TYPE,
  in_credit_card_status_id    IN CREDIT_CARD.CREDIT_CARD_STATUS_ID%TYPE,
  in_private_first_name       IN CREDIT_CARD.PRIVATE_FIRST_NAME%TYPE,
  in_private_last_name        IN CREDIT_CARD.PRIVATE_LAST_NAME%TYPE
) AS
-- VARIABLES
var_credit_card_id CREDIT_CARD.ID%TYPE;
-- arosolovskiy: using data variable instead of direct get data calls (#38860)
var_date DATE := SYSDATE;
BEGIN
  IF in_credit_card_id IS NULL THEN
    SELECT
      CC_ID_SEQ.nextVal into var_credit_card_id
    FROM DUAL;
  ELSE
    var_credit_card_id := in_credit_card_id;
  END IF;
  INSERT INTO CREDIT_CARD(
      ID,
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
      UPDATE_DATE,
      UPDATED_BY,
      CREDIT_CARD_STATUS_ID,
      PRIVATE_FIRST_NAME,
      PRIVATE_LAST_NAME
    ) VALUES (
      var_credit_card_id,
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
      var_date,
      in_created_by,
      var_date,
      in_created_by,
      in_credit_card_status_id,
      in_private_first_name,
      in_private_last_name
    );

  out_credit_card_id := var_credit_card_id;
END CREATE_CREDIT_CARD;

/******************************************************************************/

PROCEDURE UPDATE_CREDIT_CARD(
  in_credit_card_id           IN CREDIT_CARD.ID%TYPE,
  in_instrument_name          IN CREDIT_CARD.INSTRUMENT_NAME%TYPE DEFAULT NULL,
  in_private_card_holder_name IN CREDIT_CARD.PRIVATE_CARD_HOLDER_NAME%TYPE DEFAULT NULL,
  in_private_street_address   IN CREDIT_CARD.PRIVATE_STREET_ADDRESS%TYPE DEFAULT NULL,
  in_private_street_address2  IN CREDIT_CARD.PRIVATE_STREET_ADDRESS2%TYPE DEFAULT NULL,
  in_state                    IN CREDIT_CARD.STATE%TYPE DEFAULT NULL,
  in_city                     IN CREDIT_CARD.CITY%TYPE DEFAULT NULL,
  in_postal_code              IN CREDIT_CARD.POSTAL_CODE%TYPE DEFAULT NULL,
  in_country                  IN CREDIT_CARD.COUNTRY%TYPE DEFAULT NULL,
  in_last_four_cc             IN CREDIT_CARD.LAST_FOUR_CC%TYPE DEFAULT NULL,
  in_expiration_date          IN CREDIT_CARD.EXPIRATION_DATE%TYPE DEFAULT NULL,
  in_credit_card_type_id      IN CREDIT_CARD.CREDIT_CARD_TYPE_ID%TYPE DEFAULT NULL,
  in_secret_token             IN CREDIT_CARD.SECRET_TOKEN%TYPE DEFAULT NULL,
  in_chase_profile_id         IN CREDIT_CARD.CHASE_PROFILE_ID%TYPE DEFAULT NULL,
  in_updated_by               IN CREDIT_CARD.UPDATED_BY%TYPE,
  in_credit_card_status_id    IN CREDIT_CARD.CREDIT_CARD_STATUS_ID%TYPE DEFAULT NULL,
  in_private_first_name       IN CREDIT_CARD.PRIVATE_FIRST_NAME%TYPE DEFAULT NULL,
  in_private_last_name        IN CREDIT_CARD.PRIVATE_LAST_NAME%TYPE DEFAULT NULL
) AS
BEGIN

  -- Create history
  PROCS_HISTORY_V18.CREATE_CREDIT_CARD_HISTORY(
    in_credit_card_id            => in_credit_card_id,
    in_system_activity_reason_id => GLOBAL_ENUMS_V18.SAC_SYSTEM_APPLIED_RULE
  );

  UPDATE CREDIT_CARD SET
    INSTRUMENT_NAME          = NVL(in_instrument_name, INSTRUMENT_NAME),
    PRIVATE_CARD_HOLDER_NAME = NVL(in_private_card_holder_name, PRIVATE_CARD_HOLDER_NAME),
    PRIVATE_STREET_ADDRESS   = NVL(in_private_street_address, PRIVATE_STREET_ADDRESS),
    PRIVATE_STREET_ADDRESS2  = NVL(in_private_street_address, PRIVATE_STREET_ADDRESS2),
    STATE                    = NVL(in_state, STATE),
    CITY                     = NVL(in_city, CITY),
    POSTAL_CODE              = NVL(in_postal_code, POSTAL_CODE),
    COUNTRY                  = NVL(in_country, COUNTRY),
    LAST_FOUR_CC             = NVL(in_last_four_cc, LAST_FOUR_CC),
    EXPIRATION_DATE          = NVL(in_expiration_date, EXPIRATION_DATE),
    CREDIT_CARD_TYPE_ID      = NVL(in_credit_card_type_id, CREDIT_CARD_TYPE_ID),
    SECRET_TOKEN             = NVL(in_secret_token, SECRET_TOKEN),
    CHASE_PROFILE_ID         = NVL(in_chase_profile_id, CHASE_PROFILE_ID),
    UPDATE_DATE              = SYSDATE,
    UPDATED_BY               = in_updated_by,
    CREDIT_CARD_STATUS_ID    = NVL(in_credit_card_status_id, CREDIT_CARD_STATUS_ID),
    PRIVATE_FIRST_NAME       = NVL(in_private_first_name, PRIVATE_FIRST_NAME),
    PRIVATE_LAST_NAME        = NVL(in_private_last_name, PRIVATE_LAST_NAME)
  WHERE
    ID = in_credit_card_id;

END UPDATE_CREDIT_CARD;

/******************************************************************************/

PROCEDURE CREATE_PAYPAL(
  out_paypal_id                   OUT PAYPAL.ID%TYPE,
  in_paypal_id                    IN PAYPAL.ID%TYPE DEFAULT NULL,
  in_account_id                   IN PAYPAL.ACCOUNT_ID%TYPE,
  in_instrument_name              IN PAYPAL.INSTRUMENT_NAME%TYPE DEFAULT NULL,
  in_private_email_address        IN PAYPAL.PRIVATE_EMAIL_ADDRESS%TYPE DEFAULT NULL,
  in_created_by                   IN PAYPAL.CREATED_BY%TYPE,
  in_paypal_status_id             IN PAYPAL.PAYPAL_STATUS_ID%TYPE,
  in_paypal_prvt_street_address   IN PAYPAL.PRIVATE_STREET_ADDRESS%TYPE,
  in_paypal_prvt_street_address2  IN PAYPAL.PRIVATE_STREET_ADDRESS%TYPE,
  in_state                        IN PAYPAL.STATE%TYPE,
  in_city                         IN PAYPAL.CITY%TYPE,
  in_postal_code                  IN PAYPAL.POSTAL_CODE%TYPE,
  in_country                      IN PAYPAL.COUNTRY%TYPE,
  in_expiration_date              IN PAYPAL.EXPIRATION_DATE%TYPE,
  in_secret_token                 IN PAYPAL.SECRET_TOKEN%TYPE
) AS
-- VARIABLES
var_paypal_id PAYPAL.ID%TYPE;
-- arosolovskiy: using data variable instead of direct get data calls (#38860)
var_date DATE := SYSDATE;
BEGIN
  IF in_paypal_id IS NULL THEN
    SELECT
      PP_ID_SEQ.nextVal into var_paypal_id
    FROM DUAL;
  ELSE
    var_paypal_id := in_paypal_id;
  END IF;
  INSERT INTO PAYPAL(
      ID,
      ACCOUNT_ID,
      INSTRUMENT_NAME,
      PRIVATE_EMAIL_ADDRESS,
      CREATE_DATE,
      CREATED_BY,
      UPDATE_DATE,
      UPDATED_BY,
      PAYPAL_STATUS_ID,
      PRIVATE_STREET_ADDRESS,
      PRIVATE_STREET_ADDRESS2,
      STATE,
      CITY,
      POSTAL_CODE,
      COUNTRY,
      EXPIRATION_DATE,
      SECRET_TOKEN
    ) VALUES (
      var_paypal_id,
      in_account_id,
      in_instrument_name,
      in_private_email_address,
      var_date,
      in_created_by,
      var_date,
      in_created_by,
      in_paypal_status_id,
      in_paypal_prvt_street_address,
      in_paypal_prvt_street_address2,
      in_state,
      in_city,
      in_postal_code,
      in_country,
      in_expiration_date,
      in_secret_token
    );
  out_paypal_id := var_paypal_id;
END CREATE_PAYPAL;

/******************************************************************************/

PROCEDURE UPDATE_PAYPAL(
  in_paypal_id                    IN PAYPAL.ID%TYPE,
  in_instrument_name              IN PAYPAL.INSTRUMENT_NAME%TYPE DEFAULT NULL,
  in_private_email_address        IN PAYPAL.PRIVATE_EMAIL_ADDRESS%TYPE DEFAULT NULL,
  in_updated_by                   IN PAYPAL.UPDATED_BY%TYPE,
  in_paypal_status_id             IN PAYPAL.PAYPAL_STATUS_ID%TYPE DEFAULT NULL,
  in_paypal_prvt_street_address   IN PAYPAL.PRIVATE_STREET_ADDRESS%TYPE DEFAULT NULL,
  in_paypal_prvt_street_address2  IN PAYPAL.PRIVATE_STREET_ADDRESS%TYPE DEFAULT NULL,
  in_state                        IN PAYPAL.STATE%TYPE DEFAULT NULL,
  in_city                         IN PAYPAL.CITY%TYPE DEFAULT NULL,
  in_postal_code                  IN PAYPAL.POSTAL_CODE%TYPE DEFAULT NULL,
  in_country                      IN PAYPAL.COUNTRY%TYPE DEFAULT NULL,
  in_expiration_date              IN PAYPAL.EXPIRATION_DATE%TYPE DEFAULT NULL,
  in_secret_token                 IN PAYPAL.SECRET_TOKEN%TYPE
) AS
BEGIN
  -- Create history
  PROCS_HISTORY_V18.CREATE_PAYPAL_HISTORY(
    in_paypal_id                 => in_paypal_id,
    in_system_activity_reason_id => GLOBAL_ENUMS_V18.SAC_SYSTEM_APPLIED_RULE
  );

  UPDATE PAYPAL SET
    INSTRUMENT_NAME  = NVL(in_instrument_name, INSTRUMENT_NAME),
    PRIVATE_EMAIL_ADDRESS    = NVL(in_private_email_address, PRIVATE_EMAIL_ADDRESS),
    UPDATE_DATE      = SYSDATE,
    UPDATED_BY       = in_updated_by,
    PAYPAL_STATUS_ID = NVL(in_paypal_status_id, PAYPAL_STATUS_ID),
    PRIVATE_STREET_ADDRESS  = NVL(in_paypal_prvt_street_address, PRIVATE_STREET_ADDRESS),
    PRIVATE_STREET_ADDRESS2 = NVL(in_paypal_prvt_street_address2, PRIVATE_STREET_ADDRESS2),
    STATE                   = NVL(in_state, STATE),
    CITY                    = NVL(in_city, CITY),
    POSTAL_CODE             = NVL(in_postal_code, POSTAL_CODE),
    COUNTRY                 = NVL(in_country, COUNTRY),
    EXPIRATION_DATE         = NVL(in_expiration_date, EXPIRATION_DATE),
    SECRET_TOKEN            = NVL(in_secret_token, SECRET_TOKEN)
  WHERE
    ID = in_paypal_id;
END UPDATE_PAYPAL;

/******************************************************************************/

PROCEDURE CREATE_GIFT_CERTIFICATE(
  out_gift_certificate_id       OUT GIFT_CERTIFICATE.ID%TYPE,
  in_gift_certificate_id        IN GIFT_CERTIFICATE.ID%TYPE DEFAULT NULL,
  in_purchaser_group_id         IN GIFT_CERTIFICATE.PURCHASER_GROUP_ID%TYPE,
  in_purchaser_invoice_id       IN GIFT_CERTIFICATE.PURCHASE_INVOICE_ID%TYPE,
  in_offer_chain_id             IN GIFT_CERTIFICATE.OFFER_CHAIN_ID%TYPE,
  in_expiration_date            IN GIFT_CERTIFICATE.EXPIRATION_DATE%TYPE DEFAULT NULL,
  in_purchase_date              IN GIFT_CERTIFICATE.PURCHASE_DATE%TYPE,
  in_gift_certificate_status_id IN GIFT_CERTIFICATE.GIFT_CERTIFICATE_STATUS_ID%TYPE,
  in_code                       IN GIFT_CERTIFICATE.CODE%TYPE,
  in_created_by                 IN GIFT_CERTIFICATE.CREATED_BY%TYPE,
  in_recipient_name             IN GIFT_CERTIFICATE.RECIPIENT_NAME%TYPE DEFAULT NULL,
  in_gift_message               IN GIFT_CERTIFICATE.GIFT_MESSAGE%TYPE DEFAULT NULL,
  in_recipient_email            IN GIFT_CERTIFICATE.RECIPIENT_EMAIL%TYPE DEFAULT NULL,
  in_finalized_invoice_id       IN GIFT_CERTIFICATE.FINALIZED_INVOICE_ID%TYPE DEFAULT NULL,
  in_sender_email               IN GIFT_CERTIFICATE.SENDER_EMAIL%TYPE,
  in_sender_name                IN GIFT_CERTIFICATE.SENDER_NAME%TYPE,
  in_redemption_date            IN GIFT_CERTIFICATE.REDEMPTION_DATE%TYPE DEFAULT NULL,
  in_cancelation_date           IN GIFT_CERTIFICATE.CANCELATION_DATE%TYPE DEFAULT NULL,
  in_redeemer_group_id          IN GIFT_CERTIFICATE.REDEEMER_GROUP_ID%TYPE DEFAULT NULL,
  in_recipient_address_id       IN GIFT_CERTIFICATE.RECIPIENT_ADDRESS_ID%TYPE DEFAULT NULL,
  in_recipient_notify_date      IN GIFT_CERTIFICATE.RECIPIENT_NOTIFY_DATE%TYPE DEFAULT NULL
) AS
-- VARIABLES
var_gift_certificate_id GIFT_CERTIFICATE.ID%TYPE;
-- arosolovskiy: using data variable instead of direct get data calls (#38860)
var_date DATE := SYSDATE;
BEGIN
  IF in_gift_certificate_id IS NULL THEN
    SELECT
      GC_ID_SEQ.nextVal into var_gift_certificate_id
    FROM DUAL;
  ELSE
    var_gift_certificate_id := in_gift_certificate_id;
  END IF;
  INSERT INTO GIFT_CERTIFICATE (
      ID,
      PURCHASER_GROUP_ID,
      PURCHASE_INVOICE_ID,
      OFFER_CHAIN_ID,
      EXPIRATION_DATE,
      PURCHASE_DATE,
      GIFT_CERTIFICATE_STATUS_ID,
      CODE,
      CREATE_DATE,
      CREATED_BY,
      UPDATE_DATE,
      UPDATED_BY,
      RECIPIENT_NAME,
      GIFT_MESSAGE,
      RECIPIENT_EMAIL,
      FINALIZED_INVOICE_ID,
      SENDER_EMAIL,
      SENDER_NAME,
      REDEMPTION_DATE,
      CANCELATION_DATE,
      REDEEMER_GROUP_ID,
      RECIPIENT_ADDRESS_ID,
      RECIPIENT_NOTIFY_DATE
    ) VALUES(
      var_gift_certificate_id,
      in_purchaser_group_id,
      in_purchaser_invoice_id,
      in_offer_chain_id,
      in_expiration_date,
      in_purchase_date,
      in_gift_certificate_status_id,
      in_code,
      var_date,
      in_created_by,
      var_date,
      in_created_by,
      in_recipient_name,
      in_gift_message,
      in_recipient_email,
      in_finalized_invoice_id,
      in_sender_email,
      in_sender_name,
      in_redemption_date,
      in_cancelation_date,
      in_redeemer_group_id,
      in_recipient_address_id,
      in_recipient_notify_date
    );

  out_gift_certificate_id := var_gift_certificate_id;
END CREATE_GIFT_CERTIFICATE;

/******************************************************************************/

PROCEDURE UPDATE_GIFT_CERTIFICATE(
  in_gift_certificate_id        IN GIFT_CERTIFICATE.ID%TYPE,
  in_expiration_date            IN GIFT_CERTIFICATE.EXPIRATION_DATE%TYPE DEFAULT NULL,
  in_gift_certificate_status_id IN GIFT_CERTIFICATE.GIFT_CERTIFICATE_STATUS_ID%TYPE DEFAULT NULL,
  in_code                       IN GIFT_CERTIFICATE.CODE%TYPE DEFAULT NULL,
  in_updated_by                 IN GIFT_CERTIFICATE.UPDATED_BY%TYPE,
  in_recipient_name             IN GIFT_CERTIFICATE.RECIPIENT_NAME%TYPE DEFAULT NULL,
  in_gift_message               IN GIFT_CERTIFICATE.GIFT_MESSAGE%TYPE DEFAULT NULL,
  in_recipient_email            IN GIFT_CERTIFICATE.RECIPIENT_EMAIL%TYPE DEFAULT NULL,
  in_finalized_invoice_id       IN GIFT_CERTIFICATE.FINALIZED_INVOICE_ID%TYPE DEFAULT NULL,
  in_sender_email               IN GIFT_CERTIFICATE.SENDER_EMAIL%TYPE DEFAULT NULL,
  in_sender_name                IN GIFT_CERTIFICATE.SENDER_NAME%TYPE DEFAULT NULL,
  in_redemption_date            IN GIFT_CERTIFICATE.REDEMPTION_DATE%TYPE DEFAULT NULL,
  in_cancelation_date           IN GIFT_CERTIFICATE.CANCELATION_DATE%TYPE DEFAULT NULL,
  in_redeemer_group_id          IN GIFT_CERTIFICATE.REDEEMER_GROUP_ID%TYPE DEFAULT NULL,
  in_recipient_address_id       IN GIFT_CERTIFICATE.RECIPIENT_ADDRESS_ID%TYPE DEFAULT NULL,
  in_redeemer_address_id        IN GIFT_CERTIFICATE.REDEEMER_ADDRESS_ID%TYPE DEFAULT NULL,
  in_recipient_notify_date      IN GIFT_CERTIFICATE.RECIPIENT_NOTIFY_DATE%TYPE DEFAULT NULL
) AS
BEGIN

  -- Create history
  PROCS_HISTORY_V18.CREATE_GIFT_CERT_HISTORY(
    in_gift_certificate_id       => in_gift_certificate_id,
    in_system_activity_reason_id => GLOBAL_ENUMS_V18.SAC_SYSTEM_APPLIED_RULE
  );

  UPDATE GIFT_CERTIFICATE SET
    EXPIRATION_DATE            = NVL(in_expiration_date, EXPIRATION_DATE),
    GIFT_CERTIFICATE_STATUS_ID = NVL(in_gift_certificate_status_id, GIFT_CERTIFICATE_STATUS_ID),
    CODE                       = NVL(in_code, CODE),
    UPDATE_DATE                = SYSDATE,
    UPDATED_BY                 = in_updated_by,
    RECIPIENT_NAME             = NVL(in_recipient_name, RECIPIENT_NAME),
    GIFT_MESSAGE               = NVL(in_gift_message, GIFT_MESSAGE),
    RECIPIENT_EMAIL            = NVL(in_recipient_email, RECIPIENT_EMAIL),
    FINALIZED_INVOICE_ID       = NVL(in_finalized_invoice_id, FINALIZED_INVOICE_ID),
    SENDER_EMAIL               = NVL(in_sender_email, SENDER_EMAIL),
    SENDER_NAME                = NVL(in_sender_name, SENDER_NAME),
    REDEMPTION_DATE            = NVL(in_redemption_date, REDEMPTION_DATE),
    CANCELATION_DATE           = NVL(in_cancelation_date, CANCELATION_DATE),
    REDEEMER_GROUP_ID          = NVL(in_redeemer_group_id, REDEEMER_GROUP_ID),
    RECIPIENT_ADDRESS_ID       = NVL(in_recipient_address_id, RECIPIENT_ADDRESS_ID),
    REDEEMER_ADDRESS_ID        = NVL(in_redeemer_address_id, REDEEMER_ADDRESS_ID),
    RECIPIENT_NOTIFY_DATE      = NVL(in_recipient_notify_date, RECIPIENT_NOTIFY_DATE)
  WHERE
    ID = in_gift_certificate_id;

END UPDATE_GIFT_CERTIFICATE;

END PROCS_FIN_INSTRUMENTS_CRU_V18;
.
/

CREATE OR REPLACE PACKAGE BODY "PROCS_GROUP_ACCOUNT_CRU_V18" AS

PROCEDURE UPDATE_SUBSCRIPTION_SHARE (
  in_id                  IN SUBSCRIPTION_SHARE.ID%TYPE,
  in_group_account_id    IN SUBSCRIPTION_SHARE.GROUP_ACCOUNT_ID%TYPE DEFAULT NULL,
  in_borrower_account_id IN SUBSCRIPTION_SHARE.BORROWER_ACCOUNT_ID%TYPE DEFAULT NULL,
  in_ip_address          IN SUBSCRIPTION_SHARE.IP_ADDRESS%TYPE DEFAULT NULL,
  in_start_date          IN SUBSCRIPTION_SHARE.START_DATE%TYPE DEFAULT NULL,
  in_end_date            IN SUBSCRIPTION_SHARE.END_DATE%TYPE DEFAULT NULL,
  in_needs_entitlements  IN SUBSCRIPTION_SHARE.NEEDS_ENTITLEMENTS%TYPE DEFAULT NULL,
  in_updated_by          IN SUBSCRIPTION_SHARE.UPDATED_BY%TYPE
) AS
SPROC_NAME CONSTANT VARCHAR2(32) := 'UPDATE_SUBSCRIPTION_SHARE';
BEGIN
  UPDATE SUBSCRIPTION_SHARE SET
    GROUP_ACCOUNT_ID     = NVL(in_group_account_id,GROUP_ACCOUNT_ID),
    BORROWER_ACCOUNT_ID  = NVL(in_borrower_account_id,BORROWER_ACCOUNT_ID),
    IP_ADDRESS           = NVL(in_ip_address,IP_ADDRESS),
    START_DATE           = NVL(in_start_date,START_DATE),
    END_DATE             = NVL(in_end_date,END_DATE),
    NEEDS_ENTITLEMENTS   = NVL(in_needs_entitlements,NEEDS_ENTITLEMENTS),
    UPDATED_BY           = in_updated_by,
    UPDATE_DATE          = SYSDATE
  WHERE
    SUBSCRIPTION_SHARE.ID = in_id;
EXCEPTION
  WHEN OTHERS THEN
    Procs_Common_V18.Throw_Exception(APP_EXCEPTION_CODES_V18.Internal_Error,
      SPROC_NAME, 'Error while updating subscription share', SQLERRM);
END UPDATE_SUBSCRIPTION_SHARE;

PROCEDURE CREATE_GROUP_ACCOUNT (
  in_subscription_id       IN NUMBER,
  in_group_name            IN VARCHAR2,
  in_first_name            IN VARCHAR2,
  in_last_name             IN VARCHAR2,
  in_email                 IN VARCHAR2,
  in_phone                 IN VARCHAR2,
  in_organization_type     IN VARCHAR2,
  in_seats                 IN NUMBER,
  in_seat_ttl_in_hours     IN NUMBER,
  in_ip                    IN NUMBER,
  in_created_by            IN VARCHAR2
) AS
SPROC_NAME CONSTANT VARCHAR2(32) := 'CREATE_GROUP_ACCOUNT';
var_now DATE;
BEGIN

  SELECT
    SYSDATE INTO var_now
  FROM dual;

  INSERT INTO GROUP_ACCOUNT (
    id,
    subscription_id,
    group_name,
    first_name,
    last_name,
    email,
    phone,
    organization_type,
    seats,
    seat_ttl_in_hours,
    ip,
    create_date,
    created_by,
    update_date,
    updated_by
  ) VALUES (
    core_owner.GRPACCNT_ID_SEQ.NEXTVAL,
    in_subscription_id,
    in_group_name,
    in_first_name,
    in_last_name,
    in_email,
    in_phone,   
    in_organization_type,
    in_seats,
    in_seat_ttl_in_hours,
    in_ip,
    var_now,
    in_created_by,
    var_now,
    in_created_by
  );

EXCEPTION
  WHEN PROGRAM_ERROR THEN
    PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.INTERNAL_ERROR,
      SPROC_NAME, 'Program error when inserting group account', SQLERRM);
  WHEN OTHERS THEN
    PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
      SPROC_NAME, 'Unknown error when inserting group account', SQLERRM);
END CREATE_GROUP_ACCOUNT;


PROCEDURE CREATE_SUBSCRIPTION_SHARE (
  in_group_account_id    IN NUMBER,
  in_borrower_account_id IN NUMBER,
  in_ip_address          IN VARCHAR2,
  in_email_domain        IN VARCHAR2,
  in_start_date          IN DATE,
  in_end_date            IN DATE,
  in_created_by          IN VARCHAR2
) AS
SPROC_NAME CONSTANT VARCHAR2(32) := 'CREATE_SUBSCRIPTION_SHARE';
var_now DATE;
BEGIN

  SELECT
    SYSDATE INTO var_now
  FROM dual;

  INSERT INTO SUBSCRIPTION_SHARE (
    id,
    group_account_id,
    borrower_account_id,
    ip_address,
    email_domain,
    start_date,
    end_date,
    create_date,
    created_by,
    update_date,
    updated_by
  ) VALUES (
    core_owner.SUBSCRIPTIONSHARE_ID_SEQ.NEXTVAL,
    in_group_account_id,
    in_borrower_account_id,
    in_ip_address,
    in_email_domain,
    in_start_date,
    in_end_date,
    var_now,
    in_created_by,
    var_now,
    in_created_by
  );

EXCEPTION
  WHEN PROGRAM_ERROR THEN
    PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.INTERNAL_ERROR,
      SPROC_NAME, 'Program error when inserting subscription share', SQLERRM);
END CREATE_SUBSCRIPTION_SHARE;

-- Eh, I don't like the cru packages at all
-- the idea of code reuse in PL/SQL is still lost on me
PROCEDURE DISABLE_IP_RANGES_BY_GA_ID(
  in_group_account_id IN GROUP_ACCOUNT_IP_RANGE.GROUP_ACCOUNT_ID%TYPE,
  in_updated_by IN GROUP_ACCOUNT_IP_RANGE.UPDATED_BY%TYPE
) AS
SPROC_NAME CONSTANT VARCHAR2(32) := 'DISABLE_IP_RANGES_BY_GA_ID';
BEGIN
  update
    GROUP_ACCOUNT_IP_RANGE IR
  set
    IR.GROUP_ACC_IP_RNG_STATUS_ID = GLOBAL_STATUSES_V18.GROUP_ACC_IP_RNG_INACTIVE,
    IR.UPDATED_BY = in_updated_by,
    IR.UPDATE_DATE = sysdate
  where
    IR.GROUP_ACCOUNT_ID = in_group_account_id and
    IR.GROUP_ACC_IP_RNG_STATUS_ID = GLOBAL_STATUSES_V18.GROUP_ACC_IP_RNG_ACTIVE
  ;
EXCEPTION
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END DISABLE_IP_RANGES_BY_GA_ID;

PROCEDURE DISABLE_IP_RANGE_BY_ID(
  in_id   IN GROUP_ACCOUNT_IP_RANGE.ID%TYPE,
  in_updated_by IN GROUP_ACCOUNT_IP_RANGE.UPDATED_BY%TYPE
) AS
SPROC_NAME CONSTANT VARCHAR2(32) := 'DISABLE_IP_RANGE_BY_ID';
BEGIN
  update
    GROUP_ACCOUNT_IP_RANGE IR
  set
    IR.GROUP_ACC_IP_RNG_STATUS_ID = GLOBAL_STATUSES_V18.GROUP_ACC_IP_RNG_INACTIVE,
    IR.UPDATED_BY = in_updated_by,
    IR.UPDATE_DATE = sysdate
  where
    IR.ID = in_id and
    IR.GROUP_ACC_IP_RNG_STATUS_ID = GLOBAL_STATUSES_V18.GROUP_ACC_IP_RNG_ACTIVE
  ;
raise no_data_found;
EXCEPTION
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error '||in_id, SQLERRM);
END DISABLE_IP_RANGE_BY_ID;

PROCEDURE ADD_IP_RANGE (
  in_group_account_id IN GROUP_ACCOUNT_IP_RANGE.GROUP_ACCOUNT_ID%TYPE,
  in_minimum_ip_string IN GROUP_ACCOUNT_IP_RANGE.MINIMUM_IP_STRING%TYPE,
  in_minimum_ip_low IN GROUP_ACCOUNT_IP_RANGE.MINIMUM_IP_LOW%TYPE,
  in_minimum_ip_high IN GROUP_ACCOUNT_IP_RANGE.MINIMUM_IP_HIGH%TYPE,
  in_maximum_ip_string IN GROUP_ACCOUNT_IP_RANGE.MAXIMUM_IP_STRING%TYPE,
  in_maximum_ip_low IN GROUP_ACCOUNT_IP_RANGE.MAXIMUM_IP_LOW%TYPE,
  in_maximum_ip_high IN GROUP_ACCOUNT_IP_RANGE.MAXIMUM_IP_HIGH%TYPE,
  in_created_by IN GROUP_ACCOUNT_IP_RANGE.CREATED_BY%TYPE
) AS
SPROC_NAME CONSTANT VARCHAR2(32) := 'ADD_IP_RANGE';
BEGIN
    INSERT INTO GROUP_ACCOUNT_IP_RANGE (
      ID,
      GROUP_ACCOUNT_ID,
      MINIMUM_IP_STRING,
      MINIMUM_IP_LOW,
      MINIMUM_IP_HIGH,
      MAXIMUM_IP_STRING,
      MAXIMUM_IP_LOW,
      MAXIMUM_IP_HIGH,
      CREATED_BY,
      CREATE_DATE,
      UPDATED_BY,
      UPDATE_DATE,
      GROUP_ACC_IP_RNG_STATUS_ID
    )
    VALUES (
      GROUPACCOUNTIPRANGE_ID_SEQ.nextval,
      in_group_account_id,
      in_minimum_ip_string,
      in_minimum_ip_low,
      in_minimum_ip_high,
      in_maximum_ip_string,
      in_maximum_ip_low,
      in_maximum_ip_high,
      in_created_by,
      sysdate,
      in_created_by,
      sysdate,
      GLOBAL_STATUSES_V18.GROUP_ACC_IP_RNG_ACTIVE
    );
EXCEPTION
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END ADD_IP_RANGE;

PROCEDURE DISABLE_EMAIL_DOMAIN_BY_GA_ID(
  in_group_account_id IN GROUP_ACCOUNT_EMAIL_DOMAIN.GROUP_ACCOUNT_ID%TYPE,
  in_updated_by IN GROUP_ACCOUNT_EMAIL_DOMAIN.UPDATED_BY%TYPE
) AS
SPROC_NAME CONSTANT VARCHAR2(32) := 'DISABLE_EMAIL_DOMAIN_BY_GA_ID';
BEGIN
  update
    GROUP_ACCOUNT_EMAIL_DOMAIN ED
  set
    ED.IS_ACTIVE = GLOBAL_STATUSES_V18.GROUP_ACC_EMAIL_DOMAIN_INACT,
    ED.UPDATED_BY = in_updated_by,
    ED.UPDATE_DATE = sysdate
  where
    ED.GROUP_ACCOUNT_ID = in_group_account_id and
    ED.IS_ACTIVE = GLOBAL_STATUSES_V18.GROUP_ACC_EMAIL_DOMAIN_ACT
  ;
EXCEPTION
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END DISABLE_EMAIL_DOMAIN_BY_GA_ID;

PROCEDURE DISABLE_EMAIL_DOMAIN_BY_ID(
  in_id   IN GROUP_ACCOUNT_EMAIL_DOMAIN.ID%TYPE,
  in_updated_by IN GROUP_ACCOUNT_EMAIL_DOMAIN.UPDATED_BY%TYPE
) AS
SPROC_NAME CONSTANT VARCHAR2(32) := 'DISABLE_EMAIL_DOMAIN_BY_ID';
BEGIN
  update
    GROUP_ACCOUNT_EMAIL_DOMAIN ED
  set
    ED.IS_ACTIVE = GLOBAL_STATUSES_V18.GROUP_ACC_EMAIL_DOMAIN_INACT,
    ED.UPDATED_BY = in_updated_by,
    ED.UPDATE_DATE = sysdate
  where
    ED.ID = in_id and
    ED.IS_ACTIVE = GLOBAL_STATUSES_V18.GROUP_ACC_EMAIL_DOMAIN_ACT
  ;
EXCEPTION
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error '||in_id, SQLERRM);
END DISABLE_EMAIL_DOMAIN_BY_ID;


PROCEDURE ENABLE_EMAIL_DOMAIN_BY_ID(
  in_id   IN GROUP_ACCOUNT_EMAIL_DOMAIN.ID%TYPE,
  in_updated_by IN GROUP_ACCOUNT_EMAIL_DOMAIN.UPDATED_BY%TYPE
) AS
SPROC_NAME CONSTANT VARCHAR2(32) := 'ENABLE_EMAIL_DOMAIN_BY_ID';
BEGIN
  update
    GROUP_ACCOUNT_EMAIL_DOMAIN ED
  set
    ED.IS_ACTIVE = GLOBAL_STATUSES_V18.GROUP_ACC_EMAIL_DOMAIN_ACT,
    ED.UPDATED_BY = in_updated_by,
    ED.UPDATE_DATE = sysdate
  where
    ED.ID = in_id and
    ED.IS_ACTIVE = GLOBAL_STATUSES_V18.GROUP_ACC_EMAIL_DOMAIN_INACT
  ;
EXCEPTION
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error '||in_id, SQLERRM);
END ENABLE_EMAIL_DOMAIN_BY_ID;


PROCEDURE ADD_EMAIL_DOMAIN (
  in_group_account_id IN GROUP_ACCOUNT_EMAIL_DOMAIN.GROUP_ACCOUNT_ID%TYPE,
  in_email_domain IN GROUP_ACCOUNT_EMAIL_DOMAIN.EMAIL_DOMAIN%TYPE,
  in_is_active IN  GROUP_ACCOUNT_EMAIL_DOMAIN.IS_ACTIVE%TYPE,
  in_created_by IN GROUP_ACCOUNT_EMAIL_DOMAIN.CREATED_BY%TYPE
) AS
SPROC_NAME CONSTANT VARCHAR2(32) := 'ADD_EMAIL_DOMAIN';
BEGIN
    INSERT INTO GROUP_ACCOUNT_EMAIL_DOMAIN (
      ID,
      GROUP_ACCOUNT_ID,
      EMAIL_DOMAIN,
	  IS_ACTIVE,
      CREATED_BY,
      CREATE_DATE,
      UPDATED_BY,
      UPDATE_DATE
    )
    VALUES (
      GROUPACCOUNTEMAILDOMAIN_SEQ.nextval,
      in_group_account_id,      
 	  in_email_domain,
	  in_is_active,
	  in_created_by,
      sysdate,
      in_created_by,
      sysdate
    );
EXCEPTION
WHEN DUP_VAL_ON_INDEX THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.INVALID_PARAMETER,
    SPROC_NAME, 'Unique Constraint Violated', SQLERRM);
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error 1', SQLERRM);
END ADD_EMAIL_DOMAIN;

PROCEDURE UPDATE_GROUP_ACCOUNT (
  in_group_account_id      IN GROUP_ACCOUNT.ID%TYPE,
  in_group_name            IN GROUP_ACCOUNT.GROUP_NAME%TYPE,
  in_first_name            IN GROUP_ACCOUNT.FIRST_NAME%TYPE,
  in_last_name             IN GROUP_ACCOUNT.LAST_NAME%TYPE,
  in_email                 IN GROUP_ACCOUNT.EMAIL%TYPE,
  in_phone                 IN GROUP_ACCOUNT.PHONE%TYPE,
  in_updated_by            IN GROUP_ACCOUNT.UPDATED_BY%TYPE
) AS
SPROC_NAME CONSTANT VARCHAR2(32) := 'UPDATE_GROUP_ACCOUNT';
BEGIN
  update
    group_account
  set
    group_name = nvl(in_group_name, group_name),
    first_name = nvl(in_first_name, first_name),
    last_name = nvl(in_last_name, last_name),
    email = nvl(in_email, email),
    phone = nvl(in_phone, phone),
    updated_by = in_updated_by,
    update_date = sysdate
  where
    id = in_group_account_id;

  if(sql%rowcount = 0) then
    PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'Group Account not found', SQLERRM);
  end if;
EXCEPTION
  WHEN OTHERS THEN
    PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.INTERNAL_ERROR,
      SPROC_NAME, 'Error while updating group account', SQLERRM);
END UPDATE_GROUP_ACCOUNT;

PROCEDURE UPDATE_GROUP_ACCOUNT_SEATS (
  in_group_account_id      IN GROUP_ACCOUNT.ID%TYPE,
  in_seats                 IN GROUP_ACCOUNT.SEATS%TYPE,
  in_updated_by            IN GROUP_ACCOUNT.UPDATED_BY%TYPE
) AS
SPROC_NAME CONSTANT VARCHAR2(32) := 'UPDATE_GROUP_ACCOUNT_SEATS';
var_subscription_id NUMBER;
var_seats NUMBER;
BEGIN
  select subscription_id, seats into var_subscription_id, var_seats
  from group_account
  where id = in_group_account_id;

  update
    group_account
  set
    seats = in_seats,
    updated_by = in_updated_by,
    update_date = sysdate
  where
    id = in_group_account_id;
  
  if(sql%rowcount = 0) then
    PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'Group Account not found', SQLERRM);
  end if;

  PROCS_SUBSCRIPTION_V18.ANNOTATE_SUBSCRIPTION(
    in_subscription_id => var_subscription_id,
    in_agent_id        => 0,
    in_note            => 'seats updated from '||var_seats||' to '||in_seats,
    in_created_by      => in_updated_by 
  );
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'Group Account not found', SQLERRM);
  WHEN OTHERS THEN
    PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.INTERNAL_ERROR,
      SPROC_NAME, 'Error while updating group account seats', SQLERRM);
END UPDATE_GROUP_ACCOUNT_SEATS;

END PROCS_GROUP_ACCOUNT_CRU_V18;
.
/

CREATE OR REPLACE PACKAGE BODY "PROCS_INVOICE_CRU_V18" AS

PROCEDURE CREATE_INVOICE (
  out_invoice_id                 OUT INVOICE.ID%TYPE,
  in_invoice_id                  IN INVOICE.ID%TYPE DEFAULT NULL,
  in_invoice_status_id           IN INVOICE.INVOICE_STATUS_ID%TYPE,
  in_tax_exempt_id               IN INVOICE.TAX_EXEMPT_ID%TYPE,
  in_created_by                  IN INVOICE.CREATED_BY%TYPE
) AS
-- VARIABLES
var_invoice_id INVOICE.ID%TYPE;
-- arosolovskiy: using data variable instead of direct get data calls (#38860)
var_date DATE := SYSDATE;
BEGIN
  IF in_invoice_id IS NULL THEN
    SELECT
      INV_ID_SEQ.nextVal into var_invoice_id
    FROM DUAL;
  ELSE
    var_invoice_id := in_invoice_id;
  END IF;
  INSERT INTO
    INVOICE (
      ID,
      INVOICE_STATUS_ID,
      CREATE_DATE,
      CREATED_BY,
      UPDATE_DATE,
      UPDATED_BY,
      TAX_EXEMPT_ID,
      IS_TAX_CALCULATION_NEEDED
    ) VALUES (
      var_invoice_id,
      in_invoice_status_id,
      var_date,
      in_created_by,
      var_date,
      in_created_by,
      in_tax_exempt_id,
      0 -- DEFAULT VALUE
    );

  out_invoice_id := var_invoice_id;
END;

/*****************************************************************/

PROCEDURE UPDATE_INVOICE (
  in_invoice_id                  IN INVOICE.ID%TYPE,
  in_updated_by                  IN INVOICE.UPDATED_BY%TYPE,
  in_invoice_status_id           IN INVOICE.INVOICE_STATUS_ID%TYPE DEFAULT NULL,
  in_is_tax_calculation_needed   IN INVOICE.IS_TAX_CALCULATION_NEEDED%TYPE DEFAULT NULL
) AS
BEGIN
  -- Create history
  PROCS_HISTORY_V18.CREATE_INVOICE_HISTORY(
    in_invoice_id                => in_invoice_id,
    in_system_activity_reason_id => GLOBAL_ENUMS_V18.SAC_SYSTEM_APPLIED_RULE
  );

  UPDATE
    INVOICE
  SET
    INVOICE_STATUS_ID         = NVL(in_invoice_status_id, INVOICE_STATUS_ID),
    UPDATE_DATE               = SYSDATE,
    UPDATED_BY                = in_updated_by,
    IS_TAX_CALCULATION_NEEDED = NVL(in_is_tax_calculation_needed, IS_TAX_CALCULATION_NEEDED)
  WHERE
    ID = in_invoice_id;
END;

END PROCS_INVOICE_CRU_V18;
.
/

CREATE OR REPLACE PACKAGE BODY "PROCS_ITUNES_RECEIPT_CRU_V18" AS

PROCEDURE CREATE_RECEIPT(
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
    out_id              OUT NUMBER,
    in_subscription_id  IN CORE_OWNER.ITUNES_RECEIPT.SUBSCRIPTION_ID%TYPE,
    in_receipt          IN CORE_OWNER.ITUNES_RECEIPT.RECEIPT%TYPE,
    in_status           IN CORE_OWNER.ITUNES_RECEIPT.STATUS%TYPE,
    in_quantity         IN CORE_OWNER.ITUNES_RECEIPT.QUANTITY%TYPE,
    in_product_id       IN CORE_OWNER.ITUNES_RECEIPT.PRODUCT_ID%TYPE,
    in_transaction_id   IN CORE_OWNER.ITUNES_RECEIPT.TRANSACTION_ID%TYPE,
    in_purchase_date    IN CORE_OWNER.ITUNES_RECEIPT.PURCHASE_DATE%TYPE,
    in_original_transaction_id IN CORE_OWNER.ITUNES_RECEIPT.ORIGINAL_TRANSACTION_ID%TYPE,
    in_original_purchase_date IN CORE_OWNER.ITUNES_RECEIPT.ORIGINAL_PURCHASE_DATE%TYPE,
    in_app_item_id      IN CORE_OWNER.ITUNES_RECEIPT.APP_ITEM_ID%TYPE,
    in_version_external_id IN CORE_OWNER.ITUNES_RECEIPT.VERSION_EXTERNAL_ID%TYPE,
    in_bid              IN CORE_OWNER.ITUNES_RECEIPT.BID%TYPE,
    in_bvrs             IN CORE_OWNER.ITUNES_RECEIPT.BVRS%TYPE,
    in_expires_date     IN CORE_OWNER.ITUNES_RECEIPT.EXPIRES_DATE%TYPE,
    in_created_by       IN CORE_OWNER.ITUNES_RECEIPT.CREATED_BY%TYPE
) AS
-- VARIABLES
SPROC_NAME        CONSTANT VARCHAR2(32) := 'CREATE_RECEIPT';
var_current_date      DATE;
var_count             NUMBER;
ITUNES_ORG_TNX_USED   EXCEPTION;
BEGIN
  SELECT COUNT(1) into var_count
  FROM
    ITUNES_RECEIPT IR, SUBSCRIPTION S
  WHERE
    IR.ORIGINAL_TRANSACTION_ID = in_original_transaction_id AND
    IR.SUBSCRIPTION_ID = S.ID AND
    S.SUBSCRIPTION_STATUS_ID = GLOBAL_STATUSES_V18.SUBSCRIPTION_ACTIVE;
    
  if var_count > 0 then
    raise ITUNES_ORG_TNX_USED;
  end if;

  SELECT
    CORE_OWNER.ITUNES_RECEIPT_ID_SEQ.NEXTVAL
  INTO
    out_id
  FROM
    dual
  ;

  SELECT
    sysdate
  INTO
    var_current_date
  FROM
    dual
  ;

  INSERT INTO CORE_OWNER.ITUNES_RECEIPT
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
    last_check_date
  )
  VALUES
  (
    out_id,
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
    var_current_date,
    in_created_by,
    var_current_date,
    in_created_by,
    var_current_date
  );

EXCEPTION
WHEN ITUNES_ORG_TNX_USED THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.DUPLICATE_ERROR,
    SPROC_NAME, 'iTunes orginal transaction id already in use', SQLERRM);
WHEN DUP_VAL_ON_INDEX THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.DUPLICATE_ERROR,
    SPROC_NAME, 'Duplicate value', SQLERRM);
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END CREATE_RECEIPT;

PROCEDURE UPDATE_RECEIPT(
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
    in_id               IN CORE_OWNER.ITUNES_RECEIPT.ID%TYPE,
    in_receipt          IN CORE_OWNER.ITUNES_RECEIPT.RECEIPT%TYPE,
    in_status           IN CORE_OWNER.ITUNES_RECEIPT.STATUS%TYPE,
    in_quantity         IN CORE_OWNER.ITUNES_RECEIPT.QUANTITY%TYPE,
    in_product_id       IN CORE_OWNER.ITUNES_RECEIPT.PRODUCT_ID%TYPE,
    in_transaction_id   IN CORE_OWNER.ITUNES_RECEIPT.TRANSACTION_ID%TYPE,
    in_purchase_date    IN CORE_OWNER.ITUNES_RECEIPT.PURCHASE_DATE%TYPE,
    in_original_transaction_id IN CORE_OWNER.ITUNES_RECEIPT.ORIGINAL_TRANSACTION_ID%TYPE,
    in_original_purchase_date IN CORE_OWNER.ITUNES_RECEIPT.ORIGINAL_PURCHASE_DATE%TYPE,
    in_app_item_id      IN CORE_OWNER.ITUNES_RECEIPT.APP_ITEM_ID%TYPE,
    in_version_external_id IN CORE_OWNER.ITUNES_RECEIPT.VERSION_EXTERNAL_ID%TYPE,
    in_bid              IN CORE_OWNER.ITUNES_RECEIPT.BID%TYPE,
    in_bvrs             IN CORE_OWNER.ITUNES_RECEIPT.BVRS%TYPE,
    in_expires_date     IN CORE_OWNER.ITUNES_RECEIPT.EXPIRES_DATE%TYPE,
    in_updated_by       IN CORE_OWNER.ITUNES_RECEIPT.UPDATED_BY%TYPE,
    in_cancel_date      IN CORE_OWNER.ITUNES_RECEIPT.CANCEL_DATE%TYPE
) AS
-- VARIABLES
SPROC_NAME        CONSTANT VARCHAR2(32) := 'UPDATE_RECEIPT';
var_current_date      DATE;
BEGIN

  SELECT
    sysdate
  INTO
    var_current_date
  FROM
    dual
  ;
  
  FOR REC IN (SELECT * FROM CORE_OWNER.ITUNES_RECEIPT WHERE ID = in_id) LOOP
    CORE_HIST_OWNER.PUBLIC_PROCS_CORE_V18.CREATE_ITUNES_RECEIPT_HISTORY
    (
        rec.id,
        rec.subscription_id,
        rec.receipt,
        rec.status,
        rec.quantity,
        rec.product_id,
        rec.transaction_id,
        rec.purchase_date,
        rec.original_transaction_id,
        rec.original_purchase_date,
        rec.app_item_id,
        rec.version_external_id,
        rec.bid,
        rec.bvrs,
        rec.expires_date,
        rec.create_date,
        rec.created_by,
        rec.update_date,
        rec.updated_by,
        rec.last_check_date,
        rec.cancel_date
    );
  END LOOP;

  UPDATE CORE_OWNER.ITUNES_RECEIPT
  SET
    receipt = in_receipt,
    status = in_status,
    quantity = in_quantity,
    product_id = in_product_id,
    transaction_id = in_transaction_id,
    purchase_date = in_purchase_date,
    original_transaction_id = in_original_transaction_id,
    original_purchase_date = in_original_purchase_date,
    app_item_id = in_app_item_id,
    version_external_id = in_version_external_id,
    bid = in_bid,
    bvrs = in_bvrs,
    expires_date = in_expires_date,
    update_date = var_current_date,
    updated_by = in_updated_by,
    last_check_date = var_current_date,
    cancel_date = in_cancel_date
  WHERE
    id = in_id
  ;

EXCEPTION
WHEN DUP_VAL_ON_INDEX THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.DUPLICATE_ERROR,
    SPROC_NAME, 'Duplicate value', SQLERRM);
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);

END UPDATE_RECEIPT;

PROCEDURE LINK_ITUNES_RECEIPT(
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
    in_id               IN CORE_OWNER.ITUNES_RECEIPT.ID%TYPE,
    in_subscription_id  IN CORE_OWNER.ITUNES_RECEIPT.SUBSCRIPTION_ID%TYPE,
    in_updated_by       IN CORE_OWNER.ITUNES_RECEIPT.UPDATED_BY%TYPE
) AS
-- VARIABLES
SPROC_NAME        CONSTANT VARCHAR2(32) := 'LINK_ITUNES_RECEIPT';
var_current_date      DATE;
BEGIN

	SELECT
    sysdate
	INTO
    var_current_date
	FROM
    dual
  	;

	FOR REC IN (SELECT * FROM CORE_OWNER.ITUNES_RECEIPT WHERE ID = in_id) LOOP
  	CORE_HIST_OWNER.PUBLIC_PROCS_CORE_V18.CREATE_ITUNES_RECEIPT_HISTORY
  	(
      rec.id,
      rec.subscription_id,
      rec.receipt,
      rec.status,
      rec.quantity,
      rec.product_id,
      rec.transaction_id,
      rec.purchase_date,
      rec.original_transaction_id,
      rec.original_purchase_date,
      rec.app_item_id,
      rec.version_external_id,
      rec.bid,
      rec.bvrs,
      rec.expires_date,
      rec.create_date,
      rec.created_by,
      rec.update_date,
      rec.updated_by,
      rec.last_check_date,
      rec.cancel_date
  	);
	END LOOP;

	UPDATE CORE_OWNER.ITUNES_RECEIPT
	  SET
		subscription_id = in_subscription_id,
		update_date = var_current_date,
    	updated_by = in_updated_by,
    	last_check_date = var_current_date
	WHERE
	    id = in_id
	;
		
	EXCEPTION
	WHEN DUP_VAL_ON_INDEX THEN
	  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.DUPLICATE_ERROR,
	    SPROC_NAME, 'Duplicate value', SQLERRM);
	WHEN OTHERS THEN
	  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
	    SPROC_NAME, 'Unknown error', SQLERRM);
END LINK_ITUNES_RECEIPT;


PROCEDURE MARK_RECEIPT_CHECKED(
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
    in_id       IN CORE_OWNER.ITUNES_RECEIPT.ID%TYPE
) AS
SPROC_NAME        CONSTANT VARCHAR2(32) := 'MARK_RECEIPT_CHECKED';
BEGIN
  UPDATE
    CORE_OWNER.ITUNES_RECEIPT
  SET
    last_check_date = sysdate
  WHERE
    id = in_id
  ;
EXCEPTION
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END MARK_RECEIPT_CHECKED;

END PROCS_ITUNES_RECEIPT_CRU_V18;
.
/

CREATE OR REPLACE PACKAGE BODY "PROCS_LICENSE_CRU_V18" AS

PROCEDURE CREATE_LICENSE(
  out_license_id              OUT LICENSE.ID%TYPE,
  in_license_id               IN LICENSE.ID%TYPE DEFAULT NULL,
  in_license_status_id        IN LICENSE.LICENSE_STATUS_ID%TYPE,
  in_needs_entitlements       IN LICENSE.NEEDS_ENTITLEMENTS%TYPE,
  in_start_date               IN LICENSE.START_DATE%TYPE,
  in_offer_id                 IN LICENSE.OFFER_ID%TYPE,
  in_subscription_id          IN LICENSE.SUBSCRIPTION_ID%TYPE,
  in_invoice_id               IN LICENSE.INVOICE_ID%TYPE,
  in_end_date                 IN LICENSE.END_DATE%TYPE,
  in_created_by               IN LICENSE.CREATED_BY%TYPE,
  in_is_extension             IN LICENSE.IS_EXTENSION%TYPE,
  in_current_offer_index      IN LICENSE.CURRENT_OFFER_INDEX%TYPE,
  in_current_offer_recurr_num IN LICENSE.CURRENT_OFFER_RECURR_NUM%TYPE
) AS
-- VARIABLES
var_license_id LICENSE.ID%TYPE;
-- arosolovskiy: using data variable instead of direct get data calls (#38860)
var_date DATE := SYSDATE;
BEGIN
  IF in_license_id IS NULL THEN
    SELECT
      LCN_ID_SEQ.nextVal into var_license_id
    FROM DUAL;
  ELSE
    var_license_id := in_license_id;
  END IF;
  INSERT INTO
    LICENSE (
      ID,
      LICENSE_STATUS_ID,
      NEEDS_ENTITLEMENTS,
      START_DATE,
      OFFER_ID,
      SUBSCRIPTION_ID,
      INVOICE_ID,
      END_DATE,
      CREATE_DATE,
      CREATED_BY,
      UPDATE_DATE,
      UPDATED_BY,
      IS_EXTENSION,
      CURRENT_OFFER_INDEX,
      CURRENT_OFFER_RECURR_NUM,
      ENTITLEMENT_END_DATE
    ) VALUES (
      var_license_id,
      in_license_status_id,
      in_needs_entitlements,
      in_start_date,
      in_offer_id,
      in_subscription_id,
      in_invoice_id,
      in_end_date,
      var_date,
      in_created_by,
      var_date,
      in_created_by,
      in_is_extension,
      in_current_offer_index,
      in_current_offer_recurr_num,
      in_end_date
    );

  out_license_id := var_license_id;
END CREATE_LICENSE;

/********************************************************************/

PROCEDURE UPDATE_LICENSE (
  in_license_id               IN LICENSE.ID%TYPE,
  in_license_status_id        IN LICENSE.LICENSE_STATUS_ID%TYPE DEFAULT NULL,
  in_needs_entitlements       IN LICENSE.NEEDS_ENTITLEMENTS%TYPE DEFAULT NULL,
  in_start_date               IN LICENSE.START_DATE%TYPE DEFAULT NULL,
  in_end_date                 IN LICENSE.END_DATE%TYPE DEFAULT NULL,
  in_updated_by               IN LICENSE.CREATED_BY%TYPE,
  in_is_extension             IN LICENSE.IS_EXTENSION%TYPE DEFAULT NULL,
  in_current_offer_index      IN LICENSE.CURRENT_OFFER_INDEX%TYPE DEFAULT NULL,
  in_current_offer_recurr_num IN LICENSE.CURRENT_OFFER_RECURR_NUM%TYPE DEFAULT NULL,
  in_entitlement_end_date     IN LICENSE.ENTITLEMENT_END_DATE%TYPE DEFAULT NULL,
  in_grace_start_date         IN LICENSE.GRACE_START_DATE%TYPE DEFAULT NULL,
  in_grace_end_date           IN LICENSE.GRACE_END_DATE%TYPE DEFAULT NULL
) AS
BEGIN
  -- Create history
  PROCS_HISTORY_V18.CREATE_LICENSE_HISTORY(
    in_license_id                => in_license_id,
    in_system_activity_reason_id => GLOBAL_ENUMS_V18.SAC_SYSTEM_APPLIED_RULE
  );

  UPDATE
    LICENSE
  SET
    LICENSE_STATUS_ID        = NVL(in_license_status_id, LICENSE_STATUS_ID),
    NEEDS_ENTITLEMENTS       = NVL(in_needs_entitlements, NEEDS_ENTITLEMENTS),
    START_DATE               = NVL(in_start_date, START_DATE),
    END_DATE                 = NVL(in_end_date, END_DATE),
    UPDATE_DATE              = SYSDATE,
    UPDATED_BY               = in_updated_by,
    IS_EXTENSION             = NVL(in_is_extension, IS_EXTENSION),
    CURRENT_OFFER_INDEX      = NVL(in_current_offer_index, CURRENT_OFFER_INDEX),
    CURRENT_OFFER_RECURR_NUM = NVL(in_current_offer_recurr_num, CURRENT_OFFER_RECURR_NUM),
    ENTITLEMENT_END_DATE     = NVL(in_entitlement_end_date, ENTITLEMENT_END_DATE),
    GRACE_START_DATE         = NVL(in_grace_start_date, GRACE_START_DATE),
    GRACE_END_DATE           = NVL(in_grace_end_date, GRACE_END_DATE)
  WHERE
    LICENSE.ID = in_license_id;
END UPDATE_LICENSE;

END PROCS_LICENSE_CRU_V18;
.
/

CREATE OR REPLACE PACKAGE BODY "PROCS_LINE_ITEMS_CRU_V18" AS

PROCEDURE CREATE_LINE_ITEM (
  inout_line_item_id  IN OUT LINE_ITEM.ID%TYPE,
  in_product_offer_id IN LINE_ITEM.PRODUCT_OFFER_ID%TYPE,
  in_invoice_id       IN LINE_ITEM.INVOICE_ID%TYPE,
  in_amount           IN LINE_ITEM.AMOUNT%TYPE,
  in_created_by       IN LINE_ITEM.CREATED_BY%TYPE,
  in_discount_amount  IN LINE_ITEM.DISCOUNT_AMOUNT%TYPE,
  in_taxes_amount     IN LINE_ITEM.TAXES_AMOUNT%TYPE
) AS
BEGIN
  IF inout_line_item_id IS NULL THEN
    SELECT
      LI_ID_SEQ.nextVal into inout_line_item_id
    FROM DUAL;
  END IF;
  INSERT INTO LINE_ITEM (
    ID,
    PRODUCT_OFFER_ID,
    INVOICE_ID,
    AMOUNT,
    QUANTITY,
    CREATE_DATE,
    CREATED_BY,
    DISCOUNT_AMOUNT,
    TAXES_AMOUNT
  ) VALUES (
    inout_line_item_id,
    in_product_offer_id,
    in_invoice_id,
    in_amount,
    1, -- [REVU]: Deprecated. Ignore this field
    SYSDATE,
    in_created_by,
    in_discount_amount,
    in_taxes_amount
  );
END CREATE_LINE_ITEM;

/******************************************************************************/

PROCEDURE UPDATE_LINE_ITEM (
  in_line_item_id     IN LINE_ITEM.ID%TYPE,
  in_amount           IN LINE_ITEM.AMOUNT%TYPE DEFAULT NULL,
  in_discount_amount  IN LINE_ITEM.DISCOUNT_AMOUNT%TYPE  DEFAULT NULL,
  in_taxes_amount     IN LINE_ITEM.TAXES_AMOUNT%TYPE DEFAULT NULL
) AS
BEGIN
  UPDATE
    LINE_ITEM
  SET
    LINE_ITEM.AMOUNT          = NVL(in_amount, LINE_ITEM.AMOUNT),
    LINE_ITEM.DISCOUNT_AMOUNT = NVL(in_discount_amount, LINE_ITEM.DISCOUNT_AMOUNT),
    LINE_ITEM.TAXES_AMOUNT    = NVL(in_taxes_amount, LINE_ITEM.TAXES_AMOUNT)
  WHERE
    LINE_ITEM.ID = in_line_item_id;
END UPDATE_LINE_ITEM;

/******************************************************************************/

PROCEDURE CREATE_DISCOUNT_LINE_ITEM (
  in_discount_id  IN DISCOUNT.ID%TYPE,
  in_line_item_id IN LINE_ITEM.ID%TYPE
) AS
BEGIN
  INSERT INTO DISCOUNT_LINE_ITEM(
    DISCOUNT_ID,
    LINE_ITEM_ID
  ) VALUES (
    in_discount_id,
    in_line_item_id
  );
END CREATE_DISCOUNT_LINE_ITEM;

END PROCS_LINE_ITEMS_CRU_V18;
.
/

CREATE OR REPLACE PACKAGE BODY "PROCS_RECONCILIATION_CRU_V18" AS

PROCEDURE CREATE_CPT_CHARGEBACK_ACT (
  out_cpt_chargeback_act_id   OUT RCN_CPT_CHARGEBACK_ACT_DETAIL.ID%TYPE,
  in_cpt_chargeback_act_id    IN RCN_CPT_CHARGEBACK_ACT_DETAIL.ID%TYPE DEFAULT NULL,
  in_ext_source_log_id        IN RCN_CPT_CHARGEBACK_ACT_DETAIL.RCN_EXT_SOURCE_LOG_ID%TYPE,
  in_record_type              IN RCN_CPT_CHARGEBACK_ACT_DETAIL.RECORD_TYPE%TYPE,
  in_entity_type              IN RCN_CPT_CHARGEBACK_ACT_DETAIL.ENTITY_TYPE%TYPE,
  in_entity_number            IN RCN_CPT_CHARGEBACK_ACT_DETAIL.ENTITY_NUMBER%TYPE,
  in_chargeback_amount_issuer IN RCN_CPT_CHARGEBACK_ACT_DETAIL.CHARGEBACK_AMOUNT_ISSUER%TYPE,
  in_prev_partial_repres      IN RCN_CPT_CHARGEBACK_ACT_DETAIL.PREV_PARTIAL_REPRESENTMENT%TYPE,
  in_presentment_currency     IN RCN_CPT_CHARGEBACK_ACT_DETAIL.PRESENTMENT_CURRENCY%TYPE,
  in_chargeback_category      IN RCN_CPT_CHARGEBACK_ACT_DETAIL.CHARGEBACK_CATEGORY%TYPE,
  in_status_flag              IN RCN_CPT_CHARGEBACK_ACT_DETAIL.STATUS_FLAG%TYPE,
  in_sequence_number          IN RCN_CPT_CHARGEBACK_ACT_DETAIL.SEQUENCE_NUMBER%TYPE,
  in_merchant_order_number    IN RCN_CPT_CHARGEBACK_ACT_DETAIL.MERCHANT_ORDER_NUMBER%TYPE,
  in_account_number           IN RCN_CPT_CHARGEBACK_ACT_DETAIL.ACCOUNT_NUMBER%TYPE,
  in_reason_code              IN RCN_CPT_CHARGEBACK_ACT_DETAIL.REASON_CODE%TYPE,
  in_transaction_date         IN RCN_CPT_CHARGEBACK_ACT_DETAIL.TRANSACTION_DATE%TYPE,
  in_chargeback_date          IN RCN_CPT_CHARGEBACK_ACT_DETAIL.CHARGEBACK_DATE%TYPE,
  in_activity_date            IN RCN_CPT_CHARGEBACK_ACT_DETAIL.ACTIVITY_DATE%TYPE,
  in_chargeback_amount_action IN RCN_CPT_CHARGEBACK_ACT_DETAIL.CHARGEBACK_AMOUNT_ACTION%TYPE,
  in_fee_amount               IN RCN_CPT_CHARGEBACK_ACT_DETAIL.FEE_AMOUNT%TYPE,
  in_usage_code               IN RCN_CPT_CHARGEBACK_ACT_DETAIL.USAGE_CODE%TYPE,
  in_mop_code                 IN RCN_CPT_CHARGEBACK_ACT_DETAIL.MOP_CODE%TYPE,
  in_authorization_date       IN RCN_CPT_CHARGEBACK_ACT_DETAIL.AUTHORIZATION_DATE%TYPE,
  in_chargeback_due_date      IN RCN_CPT_CHARGEBACK_ACT_DETAIL.CHARGEBACK_DUE_DATE%TYPE,
  in_created_by               IN RCN_CPT_CHARGEBACK_ACT_DETAIL.CREATED_BY%TYPE
) AS
-- VARIABLES
var_cpt_chargeback_act_id RCN_CPT_CHARGEBACK_ACT_DETAIL.ID%TYPE;
var_date DATE := SYSDATE;
BEGIN
  IF in_cpt_chargeback_act_id IS NULL THEN
    SELECT
      RCN_CPT_CHRGBK_ACT_DETAIL_SEQ.nextVal into var_cpt_chargeback_act_id
    FROM DUAL;
  ELSE
    var_cpt_chargeback_act_id := in_cpt_chargeback_act_id;
  END IF;
  INSERT INTO
    RCN_CPT_CHARGEBACK_ACT_DETAIL (
      id,
      rcn_ext_source_log_id,
      record_type,
      entity_type,
      entity_number,
      chargeback_amount_issuer,
      prev_partial_representment,
      presentment_currency,
      chargeback_category,
      status_flag,
      sequence_number,
      merchant_order_number,
      account_number,
      reason_code,
      transaction_date,
      chargeback_date,
      activity_date,
      chargeback_amount_action,
      fee_amount,
      usage_code,
      mop_code,
      authorization_date,
      chargeback_due_date,
      create_date,
      created_by
    ) VALUES (
      var_cpt_chargeback_act_id,
      in_ext_source_log_id,
      in_record_type,
      in_entity_type,
      in_entity_number,
      in_chargeback_amount_issuer,
      in_prev_partial_repres,
      in_presentment_currency,
      in_chargeback_category,
      in_status_flag,
      in_sequence_number,
      in_merchant_order_number,
      in_account_number,
      in_reason_code,
      in_transaction_date,
      in_chargeback_date,
      in_activity_date,
      in_chargeback_amount_action,
      in_fee_amount,
      in_usage_code,
      in_mop_code,
      in_authorization_date,
      in_chargeback_due_date,
      var_date,
      in_created_by
    );

  out_cpt_chargeback_act_id := var_cpt_chargeback_act_id;
END CREATE_CPT_CHARGEBACK_ACT;

PROCEDURE CREATE_EXT_SOURCE_LOG (
  out_ext_source_log_id       OUT RCN_EXT_SOURCE_LOG.ID%TYPE,
  in_ext_source_log_id        IN RCN_EXT_SOURCE_LOG.ID%TYPE DEFAULT NULL,
  in_extraction_timestamp     IN RCN_EXT_SOURCE_LOG.EXTRACTION_TIMESTAMP%TYPE,
  in_report_date              IN RCN_EXT_SOURCE_LOG.REPORT_DATE%TYPE,
  in_report_gen_datetime      IN RCN_EXT_SOURCE_LOG.REPORT_GENERATION_DATETIME%TYPE,
  in_record_type              IN RCN_EXT_SOURCE_LOG.RECORD_TYPE%TYPE,
  in_report_file_name         IN RCN_EXT_SOURCE_LOG.REPORT_FILE_NAME%TYPE,
  in_created_by               IN RCN_EXT_SOURCE_LOG.CREATED_BY%TYPE
) AS
-- VARIABLES
var_ext_source_log_id RCN_EXT_SOURCE_LOG.ID%TYPE;
var_date DATE := SYSDATE;
BEGIN
  IF in_ext_source_log_id IS NULL THEN
    SELECT
      RCN_EXT_SOURCE_LOG_SEQ.nextVal into var_ext_source_log_id
    FROM DUAL;
  ELSE
    var_ext_source_log_id := in_ext_source_log_id;
  END IF;
  INSERT INTO
    RCN_EXT_SOURCE_LOG (
      id,
      extraction_timestamp,
      report_date,
      report_generation_datetime,
      record_type,
      report_file_name,
      create_date,
      created_by
    ) VALUES (
      var_ext_source_log_id,
      in_extraction_timestamp,
      in_report_date,
      in_report_gen_datetime,
      in_record_type,
      in_report_file_name,
      var_date,
      in_created_by
    );

  out_ext_source_log_id := var_ext_source_log_id;
END CREATE_EXT_SOURCE_LOG;

PROCEDURE CREATE_CPT_SERVICE_CHARGE (
  out_cpt_service_charge_id   OUT RCN_CPT_SERVICE_CHARGE_DETAIL.ID%TYPE,
  in_cpt_service_charge_id    IN RCN_CPT_SERVICE_CHARGE_DETAIL.ID%TYPE DEFAULT NULL,
  in_ext_source_log_id        IN RCN_CPT_SERVICE_CHARGE_DETAIL.RCN_EXT_SOURCE_LOG_ID%TYPE,
  in_record_type              IN RCN_CPT_SERVICE_CHARGE_DETAIL.RECORD_TYPE%TYPE,
  in_category                 IN RCN_CPT_SERVICE_CHARGE_DETAIL.CATEGORY%TYPE,
  in_sub_category             IN RCN_CPT_SERVICE_CHARGE_DETAIL.SUB_CATEGORY%TYPE,
  in_entity_type              IN RCN_CPT_SERVICE_CHARGE_DETAIL.ENTITY_TYPE%TYPE,
  in_entity_number            IN RCN_CPT_SERVICE_CHARGE_DETAIL.ENTITY_NUMBER%TYPE,
  in_funds_trans_inst_number  IN RCN_CPT_SERVICE_CHARGE_DETAIL.FUNDS_TRANSFER_INST_NUMBER%TYPE,
  in_secure_ba_number         IN RCN_CPT_SERVICE_CHARGE_DETAIL.SECURE_BA_NUMBER%TYPE,
  in_settlement_currency      IN RCN_CPT_SERVICE_CHARGE_DETAIL.SETTLEMENT_CURRENCY%TYPE,
  in_fee_schedule             IN RCN_CPT_SERVICE_CHARGE_DETAIL.FEE_SCHEDULE%TYPE,
  in_mop                      IN RCN_CPT_SERVICE_CHARGE_DETAIL.MOP%TYPE,
  in_interchange_qual         IN RCN_CPT_SERVICE_CHARGE_DETAIL.INTERCHANGE_QUALIFICATION%TYPE,
  in_fee_type_description     IN RCN_CPT_SERVICE_CHARGE_DETAIL.FEE_TYPE_DESCRIPTION%TYPE,
  in_action_type              IN RCN_CPT_SERVICE_CHARGE_DETAIL.ACTION_TYPE%TYPE,
  in_unit_quantity            IN RCN_CPT_SERVICE_CHARGE_DETAIL.UNIT_QUANTITY%TYPE,
  in_unit_fee                 IN RCN_CPT_SERVICE_CHARGE_DETAIL.UNIT_FEE%TYPE,
  in_amount                   IN RCN_CPT_SERVICE_CHARGE_DETAIL.AMOUNT%TYPE,
  in_percentage_rate          IN RCN_CPT_SERVICE_CHARGE_DETAIL.PERCENTAGE_RATE%TYPE,
  in_total_charge             IN RCN_CPT_SERVICE_CHARGE_DETAIL.TOTAL_CHARGE%TYPE,
  in_created_by               IN RCN_CPT_SERVICE_CHARGE_DETAIL.CREATED_BY%TYPE
) AS
-- VARIABLES
var_cpt_service_charge_id RCN_CPT_SERVICE_CHARGE_DETAIL.ID%TYPE;
var_date DATE := SYSDATE;
BEGIN
  IF in_cpt_service_charge_id IS NULL THEN
    SELECT
      RCN_CPT_SERV_CHARGE_DETAIL_SEQ.nextVal into var_cpt_service_charge_id
    FROM DUAL;
  ELSE
    var_cpt_service_charge_id := in_cpt_service_charge_id;
  END IF;
  INSERT INTO
    RCN_CPT_SERVICE_CHARGE_DETAIL (
      id,
      rcn_ext_source_log_id,
      record_type,
      category,
      sub_category,
      entity_type,
      entity_number,
      funds_transfer_inst_number,
      secure_ba_number,
      settlement_currency,
      fee_schedule,
      mop,
      interchange_qualification,
      fee_type_description,
      action_type,
      unit_quantity,
      unit_fee,
      amount,
      percentage_rate,
      total_charge,
      create_date,
      created_by
    ) VALUES (
      var_cpt_service_charge_id,
      in_ext_source_log_id,
      in_record_type,
      in_category,
      in_sub_category,
      in_entity_type,
      in_entity_number,
      in_funds_trans_inst_number,
      in_secure_ba_number,
      in_settlement_currency,
      in_fee_schedule,
      in_mop,
      in_interchange_qual,
      in_fee_type_description,
      in_action_type,
      in_unit_quantity,
      in_unit_fee,
      in_amount,
      in_percentage_rate,
      in_total_charge,
      var_date,
      in_created_by
    );

  out_cpt_service_charge_id := var_cpt_service_charge_id;
END CREATE_CPT_SERVICE_CHARGE;

PROCEDURE CREATE_CPT_EXCEPTION (
  out_cpt_exception_id     OUT RCN_CPT_EXCEPTION_DETAIL.ID%TYPE,
  in_cpt_exception_id      IN RCN_CPT_EXCEPTION_DETAIL.ID%TYPE DEFAULT NULL,
  in_ext_source_log_id     IN RCN_CPT_EXCEPTION_DETAIL.RCN_EXT_SOURCE_LOG_ID%TYPE,
  in_record_type           IN RCN_CPT_EXCEPTION_DETAIL.RECORD_TYPE%TYPE,
  in_submission_date       IN RCN_CPT_EXCEPTION_DETAIL.SUBMISSION_DATE%TYPE,
  in_pid_number            IN RCN_CPT_EXCEPTION_DETAIL.PID_NUMBER%TYPE,
  in_pid_short_name        IN RCN_CPT_EXCEPTION_DETAIL.PID_SHORT_NAME%TYPE,
  in_submission_number     IN RCN_CPT_EXCEPTION_DETAIL.SUBMISSION_NUMBER%TYPE,
  in_record_number         IN RCN_CPT_EXCEPTION_DETAIL.RECORD_NUMBER%TYPE,
  in_entity_type           IN RCN_CPT_EXCEPTION_DETAIL.ENTITY_TYPE%TYPE,
  in_entity_number         IN RCN_CPT_EXCEPTION_DETAIL.ENTITY_NUMBER%TYPE,
  in_presentment_currency  IN RCN_CPT_EXCEPTION_DETAIL.PRESENTMENT_CURRENCY%TYPE,
  in_merchant_order_number IN RCN_CPT_EXCEPTION_DETAIL.MERCHANT_ORDER_NUMBER%TYPE,
  in_rdfi_number           IN RCN_CPT_EXCEPTION_DETAIL.RDFI_NUMBER%TYPE,
  in_account_number        IN RCN_CPT_EXCEPTION_DETAIL.ACCOUNT_NUMBER%TYPE,
  in_expiration_date       IN RCN_CPT_EXCEPTION_DETAIL.EXPIRATION_DATE%TYPE,
  in_amount                IN RCN_CPT_EXCEPTION_DETAIL.AMOUNT%TYPE,
  in_mop                   IN RCN_CPT_EXCEPTION_DETAIL.MOP%TYPE,
  in_action_code           IN RCN_CPT_EXCEPTION_DETAIL.ACTION_CODE%TYPE,
  in_auth_date             IN RCN_CPT_EXCEPTION_DETAIL.AUTH_DATE%TYPE,
  in_auth_code             IN RCN_CPT_EXCEPTION_DETAIL.AUTH_CODE%TYPE,
  in_auth_response_code    IN RCN_CPT_EXCEPTION_DETAIL.AUTH_RESPONSE_CODE%TYPE,
  in_trace_number          IN RCN_CPT_EXCEPTION_DETAIL.TRACE_NUMBER%TYPE,
  in_consumer_country_code IN RCN_CPT_EXCEPTION_DETAIL.CONSUMER_COUNTRY_CODE%TYPE,
  in_category              IN RCN_CPT_EXCEPTION_DETAIL.CATEGORY%TYPE,
  in_mcc                   IN RCN_CPT_EXCEPTION_DETAIL.MCC%TYPE,
  in_reject_code           IN RCN_CPT_EXCEPTION_DETAIL.REJECT_CODE%TYPE,
  in_submission_status     IN RCN_CPT_EXCEPTION_DETAIL.SUBMISSION_STATUS%TYPE,
  in_created_by            IN RCN_CPT_EXCEPTION_DETAIL.CREATED_BY%TYPE
) AS
-- VARIABLES
var_cpt_exception_id RCN_CPT_EXCEPTION_DETAIL.ID%TYPE;
var_date DATE := SYSDATE;
BEGIN
  IF in_cpt_exception_id IS NULL THEN
    SELECT
      RCN_CPT_EXCEPTION_DETAIL_SEQ.nextVal into var_cpt_exception_id
    FROM DUAL;
  ELSE
    var_cpt_exception_id := in_cpt_exception_id;
  END IF;
  INSERT INTO
    RCN_CPT_EXCEPTION_DETAIL (
      id,
      rcn_ext_source_log_id,
      record_type,
      submission_date,
      pid_number,
      pid_short_name,
      submission_number,
      record_number,
      entity_type,
      entity_number,
      presentment_currency,
      merchant_order_number,
      rdfi_number,
      account_number,
      expiration_date,
      amount,
      mop,
      action_code,
      auth_date,
      auth_code,
      auth_response_code,
      trace_number,
      consumer_country_code,
      category,
      mcc,
      reject_code,
      submission_status,
      create_date,
      created_by
    ) VALUES (
      var_cpt_exception_id,
      in_ext_source_log_id,
      in_record_type,
      in_submission_date,
      in_pid_number,
      in_pid_short_name,
      in_submission_number,
      in_record_number,
      in_entity_type,
      in_entity_number,
      in_presentment_currency,
      in_merchant_order_number,
      in_rdfi_number,
      in_account_number,
      in_expiration_date,
      in_amount,
      in_mop,
      in_action_code,
      in_auth_date,
      in_auth_code,
      in_auth_response_code,
      in_trace_number,
      in_consumer_country_code,
      in_category,
      in_mcc,
      in_reject_code,
      in_submission_status,
      var_date,
      in_created_by
    );

  out_cpt_exception_id := var_cpt_exception_id;
END CREATE_CPT_EXCEPTION;

PROCEDURE CREATE_CPT_DEPOSIT (
  out_cpt_deposit_id        OUT RCN_CPT_DEPOSIT_DETAIL.ID%TYPE,
  in_cpt_deposit_id         IN RCN_CPT_DEPOSIT_DETAIL.ID%TYPE DEFAULT NULL,
  in_ext_source_log_id      IN RCN_CPT_DEPOSIT_DETAIL.RCN_EXT_SOURCE_LOG_ID%TYPE,
  in_record_type            IN RCN_CPT_DEPOSIT_DETAIL.RECORD_TYPE%TYPE,
  in_submission_date        IN RCN_CPT_DEPOSIT_DETAIL.SUBMISSION_DATE%TYPE,
  in_pid_number             IN RCN_CPT_DEPOSIT_DETAIL.PID_NUMBER%TYPE,
  in_pid_short_name         IN RCN_CPT_DEPOSIT_DETAIL.PID_SHORT_NAME%TYPE,
  in_submission_number      IN RCN_CPT_DEPOSIT_DETAIL.SUBMISSION_NUMBER%TYPE,
  in_record_number          IN RCN_CPT_DEPOSIT_DETAIL.RECORD_NUMBER%TYPE,
  in_entity_type            IN RCN_CPT_DEPOSIT_DETAIL.ENTITY_TYPE%TYPE,
  in_entity_number          IN RCN_CPT_DEPOSIT_DETAIL.ENTITY_NUMBER%TYPE,
  in_presentment_currency   IN RCN_CPT_DEPOSIT_DETAIL.PRESENTMENT_CURRENCY%TYPE,
  in_merchant_order_number  IN RCN_CPT_DEPOSIT_DETAIL.MERCHANT_ORDER_NUMBER%TYPE,
  in_rdfi_number            IN RCN_CPT_DEPOSIT_DETAIL.RDFI_NUMBER%TYPE,
  in_account_number         IN RCN_CPT_DEPOSIT_DETAIL.ACCOUNT_NUMBER%TYPE,
  in_expiration_date        IN RCN_CPT_DEPOSIT_DETAIL.EXPIRATION_DATE%TYPE,
  in_amount                 IN RCN_CPT_DEPOSIT_DETAIL.AMOUNT%TYPE,
  in_mop                    IN RCN_CPT_DEPOSIT_DETAIL.MOP%TYPE,
  in_action_code            IN RCN_CPT_DEPOSIT_DETAIL.ACTION_CODE%TYPE,
  in_auth_date              IN RCN_CPT_DEPOSIT_DETAIL.AUTH_DATE%TYPE,
  in_auth_code              IN RCN_CPT_DEPOSIT_DETAIL.AUTH_CODE%TYPE,
  in_auth_response_code     IN RCN_CPT_DEPOSIT_DETAIL.AUTH_RESPONSE_CODE%TYPE,
  in_trace_number           IN RCN_CPT_DEPOSIT_DETAIL.TRACE_NUMBER%TYPE,
  in_consumer_country_code  IN RCN_CPT_DEPOSIT_DETAIL.CONSUMER_COUNTRY_CODE%TYPE,
  in_mcc                    IN RCN_CPT_DEPOSIT_DETAIL.MCC%TYPE,
  in_fee_code               IN RCN_CPT_DEPOSIT_DETAIL.FEE_CODE%TYPE,
  in_unit_fee               IN RCN_CPT_DEPOSIT_DETAIL.UNIT_FEE%TYPE,
  in_percent_fee            IN RCN_CPT_DEPOSIT_DETAIL.PERCENT_FEE%TYPE,
  in_total_interchange_fee  IN RCN_CPT_DEPOSIT_DETAIL.TOTAL_INTERCHANGE_FEE%TYPE,
  in_total_assessment_fee   IN RCN_CPT_DEPOSIT_DETAIL.TOTAL_ASSESSMENT_FEE%TYPE,
  in_other_fee              IN RCN_CPT_DEPOSIT_DETAIL.OTHER_FEE%TYPE,
  in_created_by             IN RCN_CPT_DEPOSIT_DETAIL.CREATED_BY%TYPE
) AS
-- VARIABLES
var_cpt_deposit_id RCN_CPT_DEPOSIT_DETAIL.ID%TYPE;
var_date DATE := SYSDATE;
BEGIN
  IF in_cpt_deposit_id IS NULL THEN
    SELECT
      RCN_CPT_DEPOSIT_DETAIL_SEQ.nextVal into var_cpt_deposit_id
    FROM DUAL;
  ELSE
    var_cpt_deposit_id := in_cpt_deposit_id;
  END IF;
  INSERT INTO
    RCN_CPT_DEPOSIT_DETAIL (
      id,
      rcn_ext_source_log_id,
      record_type,
      submission_date,
      pid_number,
      pid_short_name,
      submission_number,
      record_number,
      entity_type,
      entity_number,
      presentment_currency,
      merchant_order_number,
      rdfi_number,
      account_number,
      expiration_date,
      amount,
      mop,
      action_code,
      auth_date,
      auth_code,
      auth_response_code,
      trace_number,
      consumer_country_code,
      mcc,
      fee_code,
      unit_fee,
      percent_fee,
      total_interchange_fee,
      total_assessment_fee,
      other_fee,
      create_date,
      created_by
    ) VALUES (
      var_cpt_deposit_id,
      in_ext_source_log_id,
      in_record_type,
      in_submission_date,
      in_pid_number,
      in_pid_short_name,
      in_submission_number,
      in_record_number,
      in_entity_type,
      in_entity_number,
      in_presentment_currency,
      in_merchant_order_number,
      in_rdfi_number,
      in_account_number,
      in_expiration_date,
      in_amount,
      in_mop,
      in_action_code,
      in_auth_date,
      in_auth_code,
      in_auth_response_code,
      in_trace_number,
      in_consumer_country_code,
      in_mcc,
      in_fee_code,
      in_unit_fee,
      in_percent_fee,
      in_total_interchange_fee,
      in_total_assessment_fee,
      in_other_fee,
      var_date,
      in_created_by
    );

  out_cpt_deposit_id := var_cpt_deposit_id;
END CREATE_CPT_DEPOSIT;

PROCEDURE CREATE_PP_SETTLEMENT (
  out_pp_settlement_id       OUT RCN_PP_SETTLEMENT.ID%TYPE,
  in_pp_settlement_id        IN RCN_PP_SETTLEMENT.ID%TYPE DEFAULT NULL,
  in_ext_source_log_id       IN RCN_PP_SETTLEMENT.RCN_EXT_SOURCE_LOG_ID%TYPE,
  in_transaction_id          IN RCN_PP_SETTLEMENT.TRANSACTION_ID%TYPE,
  in_invoice_id              IN RCN_PP_SETTLEMENT.INVOICE_ID%TYPE,
  in_pp_ref_id               IN RCN_PP_SETTLEMENT.PP_REF_ID%TYPE,
  in_pp_ref_id_type          IN RCN_PP_SETTLEMENT.PP_REF_ID_TYPE%TYPE,
  in_trans_event_code        IN RCN_PP_SETTLEMENT.TRANS_EVENT_CODE%TYPE,
  in_trans_init_date         IN RCN_PP_SETTLEMENT.TRANS_INIT_DATE%TYPE,
  in_trans_comp_date         IN RCN_PP_SETTLEMENT.TRANS_COMP_DATE%TYPE,
  in_trans_deb_or_cred       IN RCN_PP_SETTLEMENT.TRANS_DEB_OR_CRED%TYPE,
  in_gross_trans_amount      IN RCN_PP_SETTLEMENT.GROSS_TRANS_AMOUNT%TYPE,
  in_gross_trans_currency    IN RCN_PP_SETTLEMENT.GROSS_TRANS_CURRENCY%TYPE,
  in_fee_deb_or_cred         IN RCN_PP_SETTLEMENT.FEE_DEB_OR_CRED%TYPE,
  in_fee_amount              IN RCN_PP_SETTLEMENT.FEE_AMOUNT%TYPE,
  in_fee_currency            IN RCN_PP_SETTLEMENT.FEE_CURRENCY%TYPE,
  in_custom_field            IN RCN_PP_SETTLEMENT.CUSTOM_FIELD%TYPE,
  in_created_by              IN RCN_PP_SETTLEMENT.CREATED_BY%TYPE
) AS
-- VARIABLES
var_pp_settlement_id RCN_PP_SETTLEMENT.ID%TYPE;
var_date DATE := SYSDATE;
BEGIN
  IF in_pp_settlement_id IS NULL THEN
    SELECT
      RCN_PP_SETTLEMENT_SEQ.nextVal into var_pp_settlement_id
    FROM DUAL;
  ELSE
    var_pp_settlement_id := in_pp_settlement_id;
  END IF;
  INSERT INTO
    RCN_PP_SETTLEMENT (
      id,
      rcn_ext_source_log_id,
      transaction_id,
      invoice_id,
      pp_ref_id,
      pp_ref_id_type,
      trans_event_code,
      trans_init_date,
      trans_comp_date,
      trans_deb_or_cred,
      gross_trans_amount,
      gross_trans_currency,
      fee_deb_or_cred,
      fee_amount,
      fee_currency,
      custom_field,
      create_date,
      created_by
    ) VALUES (
      var_pp_settlement_id,
      in_ext_source_log_id,
      in_transaction_id,
      in_invoice_id,
      in_pp_ref_id,
      in_pp_ref_id_type,
      in_trans_event_code,
      in_trans_init_date,
      in_trans_comp_date,
      in_trans_deb_or_cred,
      in_gross_trans_amount,
      in_gross_trans_currency,
      in_fee_deb_or_cred,
      in_fee_amount,
      in_fee_currency,
      in_custom_field,
      var_date,
      in_created_by
    );

  out_pp_settlement_id := var_pp_settlement_id;
END CREATE_PP_SETTLEMENT;

PROCEDURE CREATE_PP_DISPUTE (
  out_pp_dispute_id            OUT RCN_PP_DISPUTE.ID%TYPE,
  in_pp_dispute_id             IN RCN_PP_DISPUTE.ID%TYPE DEFAULT NULL,
  in_ext_source_log_id         IN RCN_PP_DISPUTE.RCN_EXT_SOURCE_LOG_ID%TYPE,
  in_dispute_type              IN RCN_PP_DISPUTE.DISPUTE_TYPE%TYPE,
  in_claimant_name             IN RCN_PP_DISPUTE.CLAIMANT_NAME%TYPE,
  in_claimant_email            IN RCN_PP_DISPUTE.CLAIMANT_EMAIL%TYPE,
  in_transaction_id            IN RCN_PP_DISPUTE.TRANSACTION_ID%TYPE,
  in_trans_date                IN RCN_PP_DISPUTE.TRANS_DATE%TYPE,
  in_disputed_amount           IN RCN_PP_DISPUTE.DISPUTED_AMOUNT%TYPE,
  in_disputed_amount_currency  IN RCN_PP_DISPUTE.DISPUTED_AMOUNT_CURRENCY%TYPE,
  in_dispute_reason            IN RCN_PP_DISPUTE.DISPUTE_REASON%TYPE,
  in_dispute_filing_date       IN RCN_PP_DISPUTE.DISPUTE_FILING_DATE%TYPE,
  in_dispute_status            IN RCN_PP_DISPUTE.DISPUTE_STATUS%TYPE,
  in_dispute_case_id           IN RCN_PP_DISPUTE.DISPUTE_CASE_ID%TYPE,
  in_invoice_id                IN RCN_PP_DISPUTE.INVOICE_ID%TYPE,
  in_created_by                IN RCN_PP_DISPUTE.CREATED_BY%TYPE
) AS
-- VARIABLES
var_pp_dispute_id RCN_PP_DISPUTE.ID%TYPE;
var_date DATE := SYSDATE;
BEGIN
  IF in_pp_dispute_id IS NULL THEN
    SELECT
      RCN_PP_DISPUTE_SEQ.nextVal into var_pp_dispute_id
    FROM DUAL;
  ELSE
    var_pp_dispute_id := in_pp_dispute_id;
  END IF;
  INSERT INTO
    RCN_PP_DISPUTE (
      id,
      rcn_ext_source_log_id,
      dispute_type,
      claimant_name,
      claimant_email,
      transaction_id,
      trans_date,
      disputed_amount,
      disputed_amount_currency,
      dispute_reason,
      dispute_filing_date,
      dispute_status,
      dispute_case_id,
      invoice_id,
      create_date,
      created_by
    ) VALUES (
      var_pp_dispute_id,
      in_ext_source_log_id,
      in_dispute_type,
      in_claimant_name,
      in_claimant_email,
      in_transaction_id,
      in_trans_date,
      in_disputed_amount,
      in_disputed_amount_currency,
      in_dispute_reason,
      in_dispute_filing_date,
      in_dispute_status,
      in_dispute_case_id,
      in_invoice_id,
      var_date,
      in_created_by
    );

  out_pp_dispute_id := var_pp_dispute_id;
END CREATE_PP_DISPUTE;

PROCEDURE CREATE_PP_TRANS_DETAIL (
  out_pp_trans_detail_id       OUT RCN_PP_TRANS_DETAIL.ID%TYPE,
  in_pp_trans_detail_id        IN RCN_PP_TRANS_DETAIL.ID%TYPE DEFAULT NULL,
  in_ext_source_log_id         IN RCN_PP_TRANS_DETAIL.RCN_EXT_SOURCE_LOG_ID%TYPE,
  in_invoice_id                IN RCN_PP_TRANS_DETAIL.INVOICE_ID%TYPE,
  in_transaction_id            IN RCN_PP_TRANS_DETAIL.TRANSACTION_ID%TYPE,
  in_pp_ref_id                 IN RCN_PP_TRANS_DETAIL.PP_REF_ID%TYPE,
  in_trans_deb_or_cred         IN RCN_PP_TRANS_DETAIL.TRANS_DEB_OR_CRED%TYPE,
  in_trans_init_date           IN RCN_PP_TRANS_DETAIL.TRANS_INIT_DATE%TYPE,
  in_trans_comp_date           IN RCN_PP_TRANS_DETAIL.TRANS_COMP_DATE%TYPE,
  in_gross_trans_amount        IN RCN_PP_TRANS_DETAIL.GROSS_TRANS_AMOUNT%TYPE,
  in_gross_trans_currency      IN RCN_PP_TRANS_DETAIL.GROSS_TRANS_CURRENCY%TYPE,
  in_fee_amount                IN RCN_PP_TRANS_DETAIL.FEE_AMOUNT%TYPE,
  in_fee_currency              IN RCN_PP_TRANS_DETAIL.FEE_CURRENCY%TYPE,
  in_fee_deb_or_cred           IN RCN_PP_TRANS_DETAIL.FEE_DEB_OR_CRED%TYPE,
  in_trans_event_code          IN RCN_PP_TRANS_DETAIL.TRANS_EVENT_CODE%TYPE,
  in_trans_status              IN RCN_PP_TRANS_DETAIL.TRANS_STATUS%TYPE,
  in_insurance_amount          IN RCN_PP_TRANS_DETAIL.INSURANCE_AMOUNT%TYPE,
  in_sales_tax_amount          IN RCN_PP_TRANS_DETAIL.SALES_TAX_AMOUNT%TYPE,
  in_shipping_amount           IN RCN_PP_TRANS_DETAIL.SHIPPING_AMOUNT%TYPE,
  in_trans_subject             IN RCN_PP_TRANS_DETAIL.TRANS_SUBJECT%TYPE,
  in_trans_note                IN RCN_PP_TRANS_DETAIL.TRANS_NOTE%TYPE,
  in_payer_acct_id             IN RCN_PP_TRANS_DETAIL.PAYER_ACCT_ID%TYPE,
  in_payer_addr_status         IN RCN_PP_TRANS_DETAIL.PAYER_ADDR_STATUS%TYPE,
  in_item_name                 IN RCN_PP_TRANS_DETAIL.ITEM_NAME%TYPE,
  in_item_id                   IN RCN_PP_TRANS_DETAIL.ITEM_ID%TYPE,
  in_option_1_name             IN RCN_PP_TRANS_DETAIL.OPTION_1_NAME%TYPE,
  in_option_1_value            IN RCN_PP_TRANS_DETAIL.OPTION_1_VALUE%TYPE,
  in_option_2_name             IN RCN_PP_TRANS_DETAIL.OPTION_2_NAME%TYPE,
  in_option_2_value            IN RCN_PP_TRANS_DETAIL.OPTION_2_VALUE%TYPE,
  in_auction_site              IN RCN_PP_TRANS_DETAIL.AUCTION_SITE%TYPE,
  in_auction_buyer_id          IN RCN_PP_TRANS_DETAIL.AUCTION_BUYER_ID%TYPE,
  in_auction_closing_date      IN RCN_PP_TRANS_DETAIL.AUCTION_CLOSING_DATE%TYPE,
  in_shipping_addr_line_1      IN RCN_PP_TRANS_DETAIL.SHIPPING_ADDR_LINE_1%TYPE,
  in_shipping_addr_line_2      IN RCN_PP_TRANS_DETAIL.SHIPPING_ADDR_LINE_2%TYPE,
  in_shipping_addr_city        IN RCN_PP_TRANS_DETAIL.SHIPPING_ADDR_CITY%TYPE,
  in_shipping_addr_state       IN RCN_PP_TRANS_DETAIL.SHIPPING_ADDR_STATE%TYPE,
  in_shipping_addr_zip         IN RCN_PP_TRANS_DETAIL.SHIPPING_ADDR_ZIP%TYPE,
  in_shipping_addr_country     IN RCN_PP_TRANS_DETAIL.SHIPPING_ADDR_COUNTRY%TYPE,
  in_custom_field              IN RCN_PP_TRANS_DETAIL.CUSTOM_FIELD%TYPE,
  in_created_by                IN RCN_PP_TRANS_DETAIL.CREATED_BY%TYPE
) AS
-- VARIABLES
var_pp_trans_detail_id RCN_PP_TRANS_DETAIL.ID%TYPE;
var_date DATE := SYSDATE;
BEGIN
  IF in_pp_trans_detail_id IS NULL THEN
    SELECT
      RCN_PP_TRANS_DETAIL_SEQ.nextVal into var_pp_trans_detail_id
    FROM DUAL;
  ELSE
    var_pp_trans_detail_id := in_pp_trans_detail_id;
  END IF;
  INSERT INTO
    RCN_PP_TRANS_DETAIL (
      id,
      rcn_ext_source_log_id,
      transaction_id,
      invoice_id,
      pp_ref_id,
      trans_event_code,
      trans_init_date,
      trans_comp_date,
      trans_deb_or_cred,
      gross_trans_amount,
      gross_trans_currency,
      fee_deb_or_cred,
      fee_amount,
      fee_currency,
      trans_status,
      insurance_amount,
      sales_tax_amount,
      shipping_amount,
      trans_subject,
      trans_note,
      payer_acct_id,
      payer_addr_status,
      item_name,
      item_id,
      option_1_name,
      option_1_value,
      option_2_name,
      option_2_value,
      auction_site,
      auction_buyer_id,
      auction_closing_date,
      shipping_addr_line_1,
      shipping_addr_line_2,
      shipping_addr_city,
      shipping_addr_state,
      shipping_addr_zip,
      shipping_addr_country,
      custom_field,
      create_date,
      created_by
    ) VALUES (
      var_pp_trans_detail_id,
      in_ext_source_log_id,
      in_transaction_id,
      in_invoice_id,
      in_pp_ref_id,
      in_trans_event_code,
      in_trans_init_date,
      in_trans_comp_date,
      in_trans_deb_or_cred,
      in_gross_trans_amount,
      in_gross_trans_currency,
      in_fee_deb_or_cred,
      in_fee_amount,
      in_fee_currency,
      in_trans_status,
      in_insurance_amount,
      in_sales_tax_amount,
      in_shipping_amount,
      in_trans_subject,
      in_trans_note,
      in_payer_acct_id,
      in_payer_addr_status,
      in_item_name,
      in_item_id,
      in_option_1_name,
      in_option_1_value,
      in_option_2_name,
      in_option_2_value,
      in_auction_site,
      in_auction_buyer_id,
      in_auction_closing_date,
      in_shipping_addr_line_1,
      in_shipping_addr_line_2,
      in_shipping_addr_city,
      in_shipping_addr_state,
      in_shipping_addr_zip,
      in_shipping_addr_country,
      in_custom_field,
      var_date,
      in_created_by
    );

  out_pp_trans_detail_id := var_pp_trans_detail_id;
END CREATE_PP_TRANS_DETAIL;

PROCEDURE DELETE_EXT_SOURCE_LOG (
  in_record_type           IN RCN_EXT_SOURCE_LOG.RECORD_TYPE%TYPE,
  in_report_file_name      IN RCN_EXT_SOURCE_LOG.REPORT_FILE_NAME%TYPE
) AS
BEGIN
  DELETE FROM
    RCN_EXT_SOURCE_LOG
  WHERE
    RCN_EXT_SOURCE_LOG.RECORD_TYPE = in_record_type AND
    RCN_EXT_SOURCE_LOG.REPORT_FILE_NAME = in_report_file_name;
END DELETE_EXT_SOURCE_LOG;

PROCEDURE GET_EXT_SOURCE_LOG (
  in_record_type           IN RCN_EXT_SOURCE_LOG.RECORD_TYPE%TYPE,
  in_report_file_name      IN RCN_EXT_SOURCE_LOG.REPORT_FILE_NAME%TYPE,
  out_result_set           OUT SYS_REFCURSOR
) AS
BEGIN
  OPEN out_result_set FOR
  SELECT * FROM
    RCN_EXT_SOURCE_LOG
  WHERE
    RCN_EXT_SOURCE_LOG.RECORD_TYPE = in_record_type AND
    RCN_EXT_SOURCE_LOG.REPORT_FILE_NAME = in_report_file_name;
END GET_EXT_SOURCE_LOG;

FUNCTION CHECK_EXT_SOURCE_LOG (
  in_record_type           IN RCN_EXT_SOURCE_LOG.RECORD_TYPE%TYPE,
  in_report_file_name      IN RCN_EXT_SOURCE_LOG.REPORT_FILE_NAME%TYPE
) RETURN NUMBER AS
var_exists NUMBER;
BEGIN
  SELECT count(1) INTO var_exists
  FROM
    RCN_EXT_SOURCE_LOG
  WHERE
    RCN_EXT_SOURCE_LOG.RECORD_TYPE = in_record_type AND
    RCN_EXT_SOURCE_LOG.REPORT_FILE_NAME = in_report_file_name;

  IF var_exists > 1 THEN
    var_exists := 1;
  END IF;

  RETURN var_exists;
END;

PROCEDURE CREATE_AMEX_CHARGEBACK (
    in_rcn_ext_source_log_id IN RCN_EXT_SOURCE_LOG.ID%TYPE,
    in_resolution IN RCN_AMEX_CHARGEBACK.RESOLUTION%TYPE,
    in_from_system IN RCN_AMEX_CHARGEBACK.FROM_SYSTEM%TYPE,
    in_rejects_to_system IN RCN_AMEX_CHARGEBACK.REJECTS_TO_SYSTEM%TYPE,
    in_disputes_to_system IN RCN_AMEX_CHARGEBACK.DISPUTES_TO_SYSTEM%TYPE,
    in_date_of_adjustment IN RCN_AMEX_CHARGEBACK.DATE_OF_ADJUSTMENT%TYPE,
    in_date_of_charge IN RCN_AMEX_CHARGEBACK.DATE_OF_CHARGE%TYPE,
    in_case_type IN RCN_AMEX_CHARGEBACK.CASE_TYPE%TYPE,
    in_cb_reas_code IN RCN_AMEX_CHARGEBACK.CB_REAS_CODE%TYPE,
    in_cb_amount IN RCN_AMEX_CHARGEBACK.CB_AMOUNT%TYPE,
    in_cb_adjustment_number IN RCN_AMEX_CHARGEBACK.CB_ADJUSTMENT_NUMBER%TYPE,
    in_billed_amount IN RCN_AMEX_CHARGEBACK.BILLED_AMOUNT%TYPE,
    in_soc_amount IN RCN_AMEX_CHARGEBACK.SOC_AMOUNT%TYPE,
    in_foreign_amount IN RCN_AMEX_CHARGEBACK.FOREIGN_AMOUNT%TYPE,
    in_currency IN RCN_AMEX_CHARGEBACK.CURRENCY%TYPE,
    in_note1 IN RCN_AMEX_CHARGEBACK.NOTE1%TYPE,
    in_note2 IN RCN_AMEX_CHARGEBACK.NOTE2%TYPE,
    in_note3 IN RCN_AMEX_CHARGEBACK.NOTE3%TYPE,
    in_note4 IN RCN_AMEX_CHARGEBACK.NOTE4%TYPE,
    in_note5 IN RCN_AMEX_CHARGEBACK.NOTE5%TYPE,
    in_note6 IN RCN_AMEX_CHARGEBACK.NOTE6%TYPE,
    in_note7 IN RCN_AMEX_CHARGEBACK.NOTE7%TYPE,
    in_ind_ref_number IN RCN_AMEX_CHARGEBACK.IND_REF_NUMBER%TYPE,
    in_created_by IN RCN_AMEX_CHARGEBACK.CREATED_BY%TYPE
) AS
var_amex_chargeback_id RCN_AMEX_CHARGEBACK.ID%TYPE;
var_date DATE := SYSDATE;
BEGIN
  SELECT
    RCNAMEXCB_ID_SEQ.nextVal into var_amex_chargeback_id
  FROM DUAL;

  INSERT INTO
    RCN_AMEX_CHARGEBACK (
      id,
      rcn_ext_source_log_id,
      resolution,
      from_system,
      rejects_to_system,
      disputes_to_system,
      date_of_adjustment,
      date_of_charge,
      case_type,
      cb_reas_code,
      cb_amount,
      cb_adjustment_number,
      billed_amount,
      soc_amount,
      foreign_amount,
      currency,
      note1,
      note2,
      note3,
      note4,
      note5,
      note6,
      note7,
      ind_ref_number,
      create_date,
      created_by,
      update_date,
      updated_by
    ) VALUES (
      var_amex_chargeback_id,
      in_rcn_ext_source_log_id,
      in_resolution,
      in_from_system,
      in_rejects_to_system,
      in_disputes_to_system,
      in_date_of_adjustment,
      in_date_of_charge,
      in_case_type,
      in_cb_reas_code,
      in_cb_amount,
      in_cb_adjustment_number,
      in_billed_amount,
      in_soc_amount,
      in_foreign_amount,
      in_currency,
      in_note1,
      in_note2,
      in_note3,
      in_note4,
      in_note5,
      in_note6,
      in_note7,
      in_ind_ref_number,
      var_date,
      in_created_by,
      var_date,
      in_created_by
    );

END CREATE_AMEX_CHARGEBACK;

END PROCS_RECONCILIATION_CRU_V18;
.
/

CREATE OR REPLACE PACKAGE BODY "PROCS_SUBSCRIPTION_CRU_V18" AS

PROCEDURE CREATE_SUBSCRIPTION(
  out_subscription_id          OUT SUBSCRIPTION.ID%TYPE,
  in_subscription_id           IN SUBSCRIPTION.ID%TYPE DEFAULT NULL,
  in_suspend_date              IN SUBSCRIPTION.SUSPEND_DATE%TYPE DEFAULT NULL,
  in_account_id                IN SUBSCRIPTION.ACCOUNT_ID%TYPE,
  in_purchase_date             IN SUBSCRIPTION.PURCHASE_DATE%TYPE,
  in_offer_chain_id            IN SUBSCRIPTION.OFFER_CHAIN_ID%TYPE,
  in_termination_date          IN SUBSCRIPTION.TERMINATION_DATE%TYPE DEFAULT NULL,
  in_days_remainning_ajustment IN SUBSCRIPTION.DAYS_REMAINING_ADJUSTMENT%TYPE DEFAULT NULL,
  in_sct_id                    IN SUBSCRIPTION.SCT_ID%TYPE DEFAULT NULL,
  in_created_by                IN SUBSCRIPTION.CREATED_BY%TYPE,
  in_instrument_type_id        IN SUBSCRIPTION.INSTRUMENT_TYPE_ID%TYPE,
  in_instrument_id             IN SUBSCRIPTION.INSTRUMENT_ID%TYPE,
  in_subscription_status_id    IN SUBSCRIPTION.SUBSCRIPTION_STATUS_ID%TYPE,
  in_cancelation_date          IN SUBSCRIPTION.CANCELLATION_DATE%TYPE DEFAULT NULL,
  in_reactivation_date         IN SUBSCRIPTION.REACTIVATION_DATE%TYPE DEFAULT NULL
) AS
-- VARIABLES
var_new_subscription_id SUBSCRIPTION.ID%TYPE;
-- arosolovskiy: using data variable instead of direct get data calls (#38860)
var_date DATE := SYSDATE;
BEGIN
  IF in_subscription_id IS NULL THEN
    SELECT
      SUB_ID_SEQ.nextVal into var_new_subscription_id
    FROM DUAL;
  ELSE
    var_new_subscription_id := in_subscription_id;
  END IF;
  INSERT INTO SUBSCRIPTION (
    ID,
    SUSPEND_DATE,
    ACCOUNT_ID,
    PURCHASE_DATE,
    OFFER_CHAIN_ID,
    TERMINATION_DATE,
    DAYS_REMAINING_ADJUSTMENT,
    SCT_ID,
    CREATE_DATE,
    CREATED_BY,
    UPDATE_DATE,
    UPDATED_BY,
    INSTRUMENT_TYPE_ID,
    INSTRUMENT_ID,
    SUBSCRIPTION_STATUS_ID,
    CANCELLATION_DATE,
    REACTIVATION_DATE
  ) VALUES (
    var_new_subscription_id,
    in_suspend_date,
    in_account_id,
    in_purchase_date,
    in_offer_chain_id,
    in_termination_date,
    in_days_remainning_ajustment,
    in_sct_id,
    var_date,
    in_created_by,
    var_date,
    in_created_by,
    in_instrument_type_id,
    in_instrument_id,
    in_subscription_status_id,
    in_cancelation_date,
    in_reactivation_date
  );

  out_subscription_id := var_new_subscription_id;
END CREATE_SUBSCRIPTION;

/******************************************************************************/

PROCEDURE UPDATE_SUBSCRIPTION(
  in_subscription_id           IN SUBSCRIPTION.ID%TYPE,
  in_suspend_date              IN SUBSCRIPTION.SUSPEND_DATE%TYPE DEFAULT NULL,
  in_purchase_date             IN SUBSCRIPTION.PURCHASE_DATE%TYPE DEFAULT NULL,
  in_termination_date          IN SUBSCRIPTION.TERMINATION_DATE%TYPE DEFAULT NULL,
  in_days_remainning_ajustment IN SUBSCRIPTION.DAYS_REMAINING_ADJUSTMENT%TYPE DEFAULT NULL,
  in_sct_id                    IN SUBSCRIPTION.SCT_ID%TYPE DEFAULT NULL,
  in_updated_by                IN SUBSCRIPTION.CREATED_BY%TYPE,
  in_instrument_type_id        IN SUBSCRIPTION.INSTRUMENT_TYPE_ID%TYPE DEFAULT NULL,
  in_instrument_id             IN SUBSCRIPTION.INSTRUMENT_ID%TYPE DEFAULT NULL,
  in_subscription_status_id    IN SUBSCRIPTION.SUBSCRIPTION_STATUS_ID%TYPE DEFAULT NULL,
  in_cancelation_date          IN SUBSCRIPTION.CANCELLATION_DATE%TYPE DEFAULT NULL,
  in_reactivation_date         IN SUBSCRIPTION.REACTIVATION_DATE%TYPE DEFAULT NULL
) AS
BEGIN
  -- Create history
  PROCS_HISTORY_V18.CREATE_SUBSCRIPTION_HISTORY(
    in_subscription_id           => in_subscription_id,
    in_system_activity_reason_id => GLOBAL_ENUMS_V18.SAC_SYSTEM_APPLIED_RULE
  );

  UPDATE SUBSCRIPTION SET
    SUSPEND_DATE              = NVL(in_suspend_date, SUSPEND_DATE),
    PURCHASE_DATE             = NVL(in_purchase_date, PURCHASE_DATE),
    TERMINATION_DATE          = NVL(in_termination_date, TERMINATION_DATE),
    DAYS_REMAINING_ADJUSTMENT = NVL(days_remaining_adjustment, DAYS_REMAINING_ADJUSTMENT),
    SCT_ID                    = NVL(in_sct_id, SCT_ID),
    UPDATE_DATE               = SYSDATE,
    UPDATED_BY                = in_updated_by,
    INSTRUMENT_TYPE_ID        = NVL(in_instrument_type_id, INSTRUMENT_TYPE_ID),
    INSTRUMENT_ID             = NVL(in_instrument_id, INSTRUMENT_ID),
    SUBSCRIPTION_STATUS_ID    = NVL(in_subscription_status_id, SUBSCRIPTION_STATUS_ID),
    CANCELLATION_DATE         = NVL(in_cancelation_date, CANCELLATION_DATE),
    REACTIVATION_DATE         = NVL(in_reactivation_date, REACTIVATION_DATE)
  WHERE
    ID = in_subscription_id;
END UPDATE_SUBSCRIPTION;

/******************************************************************************/

PROCEDURE CREATE_SUBSCRIPTION_NOTE (
  inout_subscription_note_id IN OUT SUBSCRIPTION_NOTE.ID%TYPE,
  in_agent_id                IN SUBSCRIPTION_NOTE.AGENT_ID%TYPE,
  in_subscription_id         IN SUBSCRIPTION_NOTE.ID%TYPE,
  in_note                    IN SUBSCRIPTION_NOTE.NOTE%TYPE,
  in_created_by              IN SUBSCRIPTION_NOTE.CREATED_BY%TYPE
) AS
BEGIN
  IF inout_subscription_note_id IS NULL THEN
    SELECT
      SUBN_ID_SEQ.nextVal into inout_subscription_note_id
    FROM DUAL;
  END IF;
  INSERT INTO SUBSCRIPTION_NOTE (
    ID,
    AGENT_ID,
    SUBSCRIPTION_ID,
    NOTE,
    CREATE_DATE,
    CREATED_BY
  ) VALUES (
    inout_subscription_note_id,
    in_agent_id,
    in_subscription_id,
    in_note,
    SYSDATE,
    in_created_by
  );
END CREATE_SUBSCRIPTION_NOTE;

END PROCS_SUBSCRIPTION_CRU_V18;
.
/

CREATE OR REPLACE PACKAGE BODY "PROCS_TAXES_CRU_V18" AS

PROCEDURE CREATE_TAX (
  inout_tax_id             IN OUT NUMBER,
  in_tax_type_id           IN NUMBER,
  in_calculated_amount     IN NUMBER,
  in_created_by            IN VARCHAR2,
  in_line_item_id          IN NUMBER,
  in_effective_rate        IN VARCHAR2,
  in_taxable_amount        IN NUMBER,
  in_tax_rule_id           IN NUMBER,
  in_jurisdiction_level_id IN NUMBER,
  in_jurisdiction_name     IN VARCHAR2,
  in_jurisdiction_id       IN VARCHAR2,
  in_ext_tax_type          IN VARCHAR2,
  in_ext_result            IN VARCHAR2,
  in_imposition_type       IN VARCHAR2,
  in_imposition            IN VARCHAR2
) AS
var_date DATE := SYSDATE;
BEGIN

  IF inout_tax_id IS NULL THEN
    SELECT
      TAX_ID_SEQ.nextVal into inout_tax_id
    FROM DUAL;
  END IF;

  INSERT INTO TAX (
    ID,
    TAX_TYPE_ID,
    CALCULATED_AMOUNT,
    CREATE_DATE,
    CREATED_BY,
    LINE_ITEM_ID,
    EFFECTIVE_RATE,
    TAXABLE_AMOUNT,
    TAX_RULE_ID,
    JURISDICTION_LEVEL_ID,
    JURISDICTION_NAME,
    JURISDICTION_ID,
    EXT_TAX_TYPE,
    EXT_RESULT,
    IMPOSITION_TYPE,
    IMPOSITION
  ) VALUES (
    inout_tax_id,
    in_tax_type_id,
    in_calculated_amount,
    var_date,
    in_created_by,
    in_line_item_id,
    in_effective_rate,
    in_taxable_amount,
    in_tax_rule_id,
    in_jurisdiction_level_id,
    in_jurisdiction_name,
    in_jurisdiction_id,
    in_ext_tax_type,
    in_ext_result,
    in_imposition_type,
    in_imposition
  );
  
END CREATE_TAX;

END PROCS_TAXES_CRU_V18;
.
/

CREATE OR REPLACE PACKAGE BODY "PROCS_TRANSACTION_CRU_V18" AS

PROCEDURE CREATE_TRANSACTION (
  out_transaction_id       OUT TRANSACTION.ID%TYPE,
  in_transaction_id        IN TRANSACTION.ID%TYPE DEFAULT NULL,
  in_transaction_status_id IN TRANSACTION.TRANSACTION_STATUS_ID%TYPE,
  in_transaction_amount    IN TRANSACTION.TRANSACTION_AMOUNT%TYPE,
  in_created_by            IN TRANSACTION.CREATED_BY%TYPE,
  in_order_id              IN TRANSACTION.ORDER_ID%TYPE,
  in_is_refund             IN TRANSACTION.IS_REFUND%TYPE DEFAULT GLOBAL_CONSTANTS_V18.FALSE,
  in_transaction_type_code IN TRANSACTION.TRANSACTION_TYPE_CODE%TYPE DEFAULT NULL
) AS
-- VARIABLES
var_transaction_id TRANSACTION.ID%TYPE;
-- arosolovskiy: using data variable instead of direct get data calls (#38860)
var_date DATE := SYSDATE;
BEGIN
  IF in_transaction_id IS NULL THEN
    SELECT
      TRN_ID_SEQ.nextVal into var_transaction_id
    FROM DUAL;
  ELSE
    var_transaction_id := in_transaction_id;
  END IF;
  INSERT INTO
    TRANSACTION (
      ID,
      TRANSACTION_STATUS_ID,
      TRANSACTION_AMOUNT,
      CREATE_DATE,
      CREATED_BY,
      UPDATE_DATE,
      UPDATED_BY,
      ORDER_ID,
      IS_REFUND,
      TRANSACTION_TYPE_CODE
    ) VALUES (
      var_transaction_id,
      in_transaction_status_id,
      in_transaction_amount,
      var_date,
      in_created_by,
      var_date,
      in_created_by,
      in_order_id,
      in_is_refund,
      in_transaction_type_code
    );

  out_transaction_id := var_transaction_id;
END CREATE_TRANSACTION;

/*******************************************************************/

PROCEDURE UPDATE_TRANSACTION (
  in_transaction_id        IN TRANSACTION.ID%TYPE,
  in_transaction_status_id IN TRANSACTION.TRANSACTION_STATUS_ID%TYPE DEFAULT NULL,
  in_transaction_amount    IN TRANSACTION.TRANSACTION_AMOUNT%TYPE DEFAULT NULL,
  in_updated_by            IN TRANSACTION.CREATED_BY%TYPE,
  in_order_id              IN TRANSACTION.ORDER_ID%TYPE DEFAULT NULL,
  in_is_settled            IN TRANSACTION.IS_SETTLED%TYPE DEFAULT NULL
) AS
BEGIN
  -- Create history
  PROCS_HISTORY_V18.CREATE_TRANSACTION_HISTORY(
    in_transaction_id            => in_transaction_id,
    in_system_activity_reason_id => GLOBAL_ENUMS_V18.SAC_SYSTEM_APPLIED_RULE
  );
  UPDATE
    TRANSACTION
  SET
    TRANSACTION_STATUS_ID = NVL(in_transaction_status_id, TRANSACTION_STATUS_ID),
    TRANSACTION_AMOUNT    = NVL(in_transaction_amount, TRANSACTION_AMOUNT),
    UPDATE_DATE           = SYSDATE,
    UPDATED_BY            = in_updated_by,
    ORDER_ID              = NVL(in_order_id, ORDER_ID),
    IS_SETTLED            = NVL(in_is_settled, IS_SETTLED)
  WHERE
    ID = in_transaction_id;
END UPDATE_TRANSACTION;

/*******************************************************************/

PROCEDURE READ_TRANSACTION (
  in_transaction_id IN TRANSACTION.ID%TYPE,
  out_result_set    OUT SYS_REFCURSOR
) AS
BEGIN
  OPEN out_result_set FOR
  SELECT
    ID,
    TRANSACTION_STATUS_ID,
    TRANSACTION_TYPE_CODE,
    TRANSACTION_AMOUNT,
    CREATE_DATE,
    CREATED_BY,
    UPDATE_DATE,
    UPDATED_BY,
    ORDER_ID,
    IS_REFUND,
    IS_SETTLED,
    TRANSACTION_TYPE_CODE
  FROM
    TRANSACTION
  WHERE
    ID = in_transaction_id;
END READ_TRANSACTION;

/*******************************************************************/

PROCEDURE CREATE_TRANSACTION_ATTEMPT(
  inout_transaction_attempt_id IN OUT TRANSACTION_ATTEMPT.ID%TYPE,
  in_transaction_id            IN TRANSACTION_ATTEMPT.TRANSACTION_ID%TYPE,
  in_external_status_code      IN TRANSACTION_ATTEMPT.EXTERNAL_STATUS_CODE%TYPE DEFAULT NULL,
  in_external_status_message   IN TRANSACTION_ATTEMPT.EXTERNAL_STATUS_MESSAGE%TYPE DEFAULT NULL,
  in_created_by                IN TRANSACTION_ATTEMPT.CREATED_BY%TYPE,
  in_external_transaction_id   IN TRANSACTION_ATTEMPT.EXTERNAL_TRANSACTION_ID%TYPE DEFAULT NULL,
  in_transaction_start_time    IN TRANSACTION_ATTEMPT.TRANSACTION_START_TIME%TYPE DEFAULT NULL,
  in_status_id                 IN TRANSACTION_ATTEMPT.TRANSACTION_ATTEMPT_STATUS_ID%TYPE
) AS
BEGIN
  IF inout_transaction_attempt_id IS NULL THEN
    SELECT
      TRNA_ID_SEQ.nextVal into inout_transaction_attempt_id
    FROM DUAL;
  END IF;
  INSERT INTO TRANSACTION_ATTEMPT (
    ID,
    TRANSACTION_ID,
    EXTERNAL_STATUS_CODE,
    EXTERNAL_STATUS_MESSAGE,
    CREATE_DATE,
    CREATED_BY,
    EXTERNAL_TRANSACTION_ID,
    TRANSACTION_START_TIME,
    TRANSACTION_ATTEMPT_STATUS_ID
  ) VALUES (
    inout_transaction_attempt_id,
    in_transaction_id,
    in_external_status_code,
    in_external_status_message,
    SYSDATE,
    in_created_by,
    in_external_transaction_id,
    in_transaction_start_time,
    in_status_id
  );
END;

/*******************************************************************/

PROCEDURE UPDATE_TRANSACTION_ATTEMPT (
  in_transaction_attempt_id  IN TRANSACTION_ATTEMPT.ID%TYPE,
  in_external_status_code    IN TRANSACTION_ATTEMPT.EXTERNAL_STATUS_CODE%TYPE DEFAULT NULL,
  in_external_status_message IN TRANSACTION_ATTEMPT.EXTERNAL_STATUS_MESSAGE%TYPE DEFAULT NULL,
  in_external_transaction_id IN TRANSACTION_ATTEMPT.EXTERNAL_TRANSACTION_ID%TYPE DEFAULT NULL,
  in_transaction_start_time  IN TRANSACTION_ATTEMPT.TRANSACTION_START_TIME%TYPE DEFAULT NULL,
  in_status_id               IN TRANSACTION_ATTEMPT.TRANSACTION_ATTEMPT_STATUS_ID%TYPE
) AS
BEGIN
  UPDATE
    TRANSACTION_ATTEMPT
  SET
    EXTERNAL_STATUS_CODE          = NVL(in_external_status_code, EXTERNAL_STATUS_CODE),
    EXTERNAL_STATUS_MESSAGE       = NVL(in_external_status_message, EXTERNAL_STATUS_MESSAGE),
    EXTERNAL_TRANSACTION_ID       = NVL(in_external_transaction_id, EXTERNAL_TRANSACTION_ID),
    TRANSACTION_START_TIME        = NVL(in_transaction_start_time, TRANSACTION_START_TIME),
    TRANSACTION_ATTEMPT_STATUS_ID = NVL(in_status_id, TRANSACTION_ATTEMPT_STATUS_ID)
  WHERE
    ID = in_transaction_attempt_id;
END;

/*******************************************************************/

PROCEDURE UPDATE_TRANSACTION_ORDER_ID (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.INTRNAL_ERROR
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_transaction_id IN TRANSACTION.ID%TYPE,
  in_order_id       IN TRANSACTION.ORDER_ID%TYPE,
  in_updated_by     IN TRANSACTION.UPDATED_BY%TYPE
) AS
SPROC_NAME CONSTANT VARCHAR2(27) := 'UPDATE_TRANSACTION_ORDER_ID';
-- EXCEPTIONS
BAD_TRANSACTION_ID EXCEPTION;
BEGIN

  PROCS_HISTORY_V18.CREATE_TRANSACTION_HISTORY(
    in_transaction_id            => in_transaction_id,
    in_system_activity_reason_id => GLOBAL_ENUMS_V18.SAC_SYSTEM_APPLIED_RULE
  );

  UPDATE
    TRANSACTION
  SET
    TRANSACTION.ORDER_ID   = in_order_id,
    TRANSACTION.UPDATED_BY = in_updated_by,
    TRANSACTION.UPDATE_DATE= SYSDATE
  WHERE
    TRANSACTION.ID = in_transaction_id
    AND TRANSACTION.ORDER_ID IS NULL;
    
  IF SQL%ROWCOUNT = 0 THEN
    RAISE BAD_TRANSACTION_ID;
  END IF;
EXCEPTION
WHEN BAD_TRANSACTION_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'No such transaction');
END UPDATE_TRANSACTION_ORDER_ID;

END PROCS_TRANSACTION_CRU_V18;
.
/

CREATE OR REPLACE PACKAGE BODY "PROCS_ADDRESS_V18" AS

PROCEDURE CREATE_ADDRESS(
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
    out_address_id        OUT NUMBER,
    in_address1           IN ADDRESS.ADDRESS1%TYPE DEFAULT NULL,
    in_address2           IN ADDRESS.ADDRESS2%TYPE DEFAULT NULL,
    in_city               IN ADDRESS.CITY%TYPE DEFAULT NULL,
    in_state              IN ADDRESS.STATE%TYPE DEFAULT NULL,
    in_postal_code        IN ADDRESS.POSTAL_CODE%TYPE DEFAULT NULL,
    in_country            IN ADDRESS.COUNTRY%TYPE DEFAULT NULL,
    in_created_by         IN ADDRESS.CREATED_BY%TYPE
) AS
-- VARIABLES
SPROC_NAME         CONSTANT VARCHAR2(14) := 'CREATE_ADDRESS';
-- EXCEPTIONS
EXCEPTION_MESSAGE      VARCHAR2(1024);
BEGIN

  CORE_OWNER.PROCS_ADDRESS_CRU_V18.CREATE_ADDRESS(
    out_address_id      => out_address_id,
    in_address_id       => null,
    in_address1         => in_address1,
    in_address2         => in_address2,
    in_city             => in_city,
    in_state            => in_state,
    in_postal_code      => in_postal_code,
    in_country          => in_country,
    in_created_by       => in_created_by
  );

END CREATE_ADDRESS;

PROCEDURE UPDATE_ADDRESS(
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
    in_address_id         IN ADDRESS.ID%TYPE,
    in_address1           IN ADDRESS.ADDRESS1%TYPE DEFAULT NULL,
    in_address2           IN ADDRESS.ADDRESS2%TYPE DEFAULT NULL,
    in_city               IN ADDRESS.CITY%TYPE DEFAULT NULL,
    in_state              IN ADDRESS.STATE%TYPE DEFAULT NULL,
    in_postal_code        IN ADDRESS.POSTAL_CODE%TYPE DEFAULT NULL,
    in_country            IN ADDRESS.COUNTRY%TYPE DEFAULT NULL,
    in_updated_by         IN ADDRESS.UPDATED_BY%TYPE
) AS
BEGIN
  CORE_OWNER.PROCS_ADDRESS_CRU_V18.UPDATE_ADDRESS(
    in_address_id         => in_address_id,
    in_address1           => in_address1,
    in_address2           => in_address2,
    in_city               => in_city,
    in_state              => in_state,
    in_postal_code        => in_postal_code,
    in_country            => in_country,
    in_updated_by         => in_updated_by
  );
END UPDATE_ADDRESS;

PROCEDURE GET_ADDRESS (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
    in_id                 IN ADDRESS.ID%TYPE,
    out_result_set        OUT SYS_REFCURSOR
) AS
SPROC_NAME CONSTANT VARCHAR2(11) := 'GET_ADDRESS';
BEGIN

OPEN out_result_set FOR
SELECT * FROM ADDRESS WHERE ADDRESS.ID = in_id;

END GET_ADDRESS;

END PROCS_ADDRESS_V18;
.
/

CREATE OR REPLACE PACKAGE BODY "PROCS_ADJUSTMENTS_V18" AS

PROCEDURE CREATE_INVOICE_ADJUSTMENT (
  in_invoice_id             IN NUMBER,
  in_adjustment_reason      IN VARCHAR2,
  in_is_credit              IN NUMBER,
  in_charge_id              IN NUMBER,
  in_business_date          IN DATE,
  in_created_by             IN VARCHAR2,
  out_invoice_adjustment_id OUT NUMBER
) AS
SPROC_NAME CONSTANT VARCHAR2(25) := 'CREATE_INVOICE_ADJUSTMENT';
-- VARIABLES
var_current_date      DATE := SYSDATE;
var_new_entity_id     NUMBER;
var_inv_adj_reason_id NUMBER;
-- EXCEPTIONS
BAD_IN_IS_CREDIT_VALUE EXCEPTION;
DAB_ADJUSTMENT_REASON  EXCEPTION;
BEGIN

  IF in_is_credit != GLOBAL_CONSTANTS_V18.TRUE AND in_is_credit != GLOBAL_CONSTANTS_V18.FALSE THEN
    RAISE BAD_IN_IS_CREDIT_VALUE;
  END IF;
  
  BEGIN
    SELECT
      ID into var_inv_adj_reason_id
    FROM
      INVOICE_ADJUSTMENT_REASON
    WHERE
      UPPER(VALUE) = UPPER(in_adjustment_reason);
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE DAB_ADJUSTMENT_REASON;
  END;

  SELECT
    INV_ADJ_ID_SEQ.nextVal into var_new_entity_id
  FROM
    DUAL;
    
  INSERT INTO INVOICE_ADJUSTMENT (
    ID,
    INVOICE_ID,
    INVOICE_ADJUSTMENT_REASON_ID,
    IS_CREDIT,
    CHARGE_ID,
    ADJUSTMENT_DATE,
    CREATE_DATE,
    CREATED_BY, 
    UPDATE_DATE,
    UPDATED_BY
  )
  VALUES (
    var_new_entity_id,
    in_invoice_id,
    var_inv_adj_reason_id,
    in_is_credit,
    in_charge_id,
    in_business_date,
    var_current_date,
    in_created_by,
    var_current_date,
    in_created_by
  );
  
  out_invoice_adjustment_id := var_new_entity_id;

EXCEPTION
WHEN BAD_IN_IS_CREDIT_VALUE THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.INVALID_PARAMETER,
    SPROC_NAME, 'Bad in_is_credit value');
WHEN DAB_ADJUSTMENT_REASON THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.INVALID_PARAMETER,
    SPROC_NAME, 'Bad adjustment reason');
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END CREATE_INVOICE_ADJUSTMENT;

/******************************************************************************/

PROCEDURE UPDATE_INVOICE_ADJUSTMENT (
    in_invoice_id             IN NUMBER,
    in_original_charge_id     IN NUMBER,
    in_charge_id              IN NUMBER,
    in_updated_by             IN VARCHAR2
) AS
SPROC_NAME CONSTANT VARCHAR2(32) := 'UPDATE_INVOICE_ADJUSTMENT';
var_invoice_adjustment_id NUMBER;
BEGIN
  SELECT
    id into var_invoice_adjustment_id
  FROM
    INVOICE_ADJUSTMENT
  WHERE INVOICE_ID = in_invoice_id
        AND CHARGE_ID = in_original_charge_id;
    
  --create history
  PROCS_HISTORY_V18.CREATE_INVOICE_ADJ_HISTORY(
    in_invoice_adjustment_id    => var_invoice_adjustment_id,
    in_system_activity_reason_id => GLOBAL_ENUMS_V18.SAC_SYSTEM_APPLIED_RULE
  );
  
  UPDATE INVOICE_ADJUSTMENT 
  SET CHARGE_ID = in_charge_id, UPDATE_DATE=sysdate, UPDATED_BY=in_updated_by  
  WHERE ID = var_invoice_adjustment_id;
    
EXCEPTION
WHEN NO_DATA_FOUND THEN
      NULL;
END UPDATE_INVOICE_ADJUSTMENT;

/******************************************************************************/

PROCEDURE CREATE_LINE_ITEM_ADJUSTMENT (
  in_line_item_id             IN NUMBER,
  in_invoice_adjustment_id    IN NUMBER,
  in_amount                   IN NUMBER,
  in_tax                      IN NUMBER,
  in_discount                 IN NUMBER,
  in_created_by               IN VARCHAR2,
  out_line_item_adjustment_id OUT NUMBER
) AS
SPROC_NAME CONSTANT VARCHAR2(30) := 'CREATE_LINE_ITEM_ADJUSTMENT';
-- VARIABLES
var_current_date DATE := SYSDATE;
var_new_entity_id NUMBER;
BEGIN

  SELECT
    LI_ADJ_ID_SEQ.nextVal into var_new_entity_id
  FROM
    DUAL;

  INSERT INTO LINE_ITEM_ADJUSTMENT (
    ID,
    LINE_ITEM_ID,
    INVOICE_ADJUSTMENT_ID,
    AMOUNT,
    TAX,
    DISCOUNT,
    CREATE_DATE,
    CREATED_BY
  )
  VALUES (
    var_new_entity_id,
    in_line_item_id,
    in_invoice_adjustment_id,
    in_amount,
    in_tax,
    in_discount,
    var_current_date,
    in_created_by
  );
  
  out_line_item_adjustment_id := var_new_entity_id;

EXCEPTION
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END CREATE_LINE_ITEM_ADJUSTMENT;

/******************************************************************************/

PROCEDURE CREATE_TAX_ADJUSTMENT (
  in_tax_id                  IN NUMBER,
  in_line_item_adjustment_id IN NUMBER,
  in_amount                  IN NUMBER,
  in_created_by              IN VARCHAR2,
  out_tax_adjustment_id      OUT NUMBER
) AS
SPROC_NAME CONSTANT VARCHAR2(30) := 'CREATE_TAX_ADJUSTMENT';
-- VARIABLES
var_current_date DATE := SYSDATE;
var_new_entity_id NUMBER;
BEGIN

  SELECT
    TAXADJ_ID_SEQ.nextVal into var_new_entity_id
  FROM
    DUAL;

  INSERT INTO TAX_ADJUSTMENT (
    ID,
    TAX_ID,
    LINE_ITEM_ADJUSTMENT_ID,
    AMOUNT,
    CREATE_DATE,
    CREATED_BY
  )
  VALUES (
    var_new_entity_id,
    in_tax_id,
    in_line_item_adjustment_id,
    in_amount,
    var_current_date,
    in_created_by
  );
  
  out_tax_adjustment_id := var_new_entity_id;

EXCEPTION
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END CREATE_TAX_ADJUSTMENT;

/******************************************************************************/

PROCEDURE CREATE_DISCOUNT_LI_ADJUSTMENT (
  in_discount_id             NUMBER,
  in_line_item_id            NUMBER,
  in_line_item_adjustment_id IN NUMBER,
  in_amount                  IN NUMBER,
  in_created_by              IN VARCHAR2,
  out_discount_li_id         OUT NUMBER
) AS
SPROC_NAME CONSTANT VARCHAR2(32) := 'CREATE_DISCOUNT_LI_ADJUSTMENT';
-- VARIABLES
var_current_date DATE := SYSDATE;
var_new_entity_id NUMBER;
BEGIN

  SELECT
    DLIADJ_ID_SEQ.nextVal into var_new_entity_id
  FROM
    DUAL;

  INSERT INTO DISCOUNT_LINEITEM_ADJUSTMENT (
    ID,
    DISCOUNT_ID,
    LINE_ITEM_ID,
    LINE_ITEM_ADJUSTMENT_ID,
    AMOUNT,
    CREATE_DATE,
    CREATED_BY
  )
  VALUES (
    var_new_entity_id,
    in_discount_id,
    in_line_item_id,
    in_line_item_adjustment_id,
    in_amount,
    var_current_date,
    in_created_by
  );
  
  out_discount_li_id := var_new_entity_id;

EXCEPTION
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END CREATE_DISCOUNT_LI_ADJUSTMENT;

END PROCS_ADJUSTMENTS_V18;
.
/

CREATE OR REPLACE PACKAGE BODY "PROCS_ADX_V18" AS

PROCEDURE GET_SUB_ADX_INFO (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  out_result_set      OUT SYS_REFCURSOR,
  in_group_id    IN ACCOUNT.GROUP_ID%TYPE
) AS
SPROC_NAME CONSTANT VARCHAR2(32) := 'GET_SUB_ADX_INFO';
BEGIN
OPEN out_result_set FOR
SELECT /*+ FIRST_ROWS(5) */
  s.offer_chain_id,
  s.create_date,
  decode(s.subscription_status_id, 1, 'a', 'c') status,
  ocmd.value,
  a.group_id,
  s.id subscription_id
FROM
  account a,
  subscription s,
  offer_chain_meta_data ocmd,
  group_account g,
  subscription_share ss,
  account a2
WHERE
  s.account_id = a.id and
  s.offer_chain_id = ocmd.offer_chain_id and
  g.id = ss.group_account_id and
  ss.borrower_account_id = a2.id and
  s.id = g.subscription_id and
  ocmd.name = 'ADX_BUNDLE' and
  a2.group_id = in_group_id and
  rownum < 5
union all
SELECT /*+ FIRST_ROWS(5) */
  s.offer_chain_id,
  s.create_date,
  decode(s.subscription_status_id, 1, 'a', 'c') status,
  ocmd.value,
  a.group_id,
  s.id subscription_id
FROM
  account a,
  subscription s, 
  offer_chain_meta_data ocmd
WHERE
  s.account_id = a.id and
  s.offer_chain_id = ocmd.offer_chain_id and
  ocmd.name = 'ADX_BUNDLE' and
  a.group_id = in_group_id and
  rownum < 5
;

END GET_SUB_ADX_INFO;

END PROCS_ADX_V18;
.
/

CREATE OR REPLACE PACKAGE BODY "PROCS_AMAZON_V18" AS

PROCEDURE CREATE_AMAZON_SUB(
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
    out_id              OUT NUMBER,
    in_subscription_id  IN AMAZON_SUB.SUBSCRIPTION_ID%TYPE,
    in_amazon_id        IN AMAZON_SUB.AMAZON_ID%TYPE,
    in_created_by       IN AMAZON_SUB.CREATED_BY%TYPE
) AS
-- VARIABLES
SPROC_NAME         CONSTANT VARCHAR2(32) := 'CREATE_AMAZON_SUB';
-- EXCEPTIONS
EXCEPTION_MESSAGE      VARCHAR2(1024);
BEGIN

  CORE_OWNER.PROCS_AMAZON_CRU_V18.CREATE_AMAZON_SUB(
    out_id              =>  out_id,
    in_subscription_id  =>  in_subscription_id,
    in_amazon_id        =>  in_amazon_id,
    in_created_by       =>  in_created_by
  );

END CREATE_AMAZON_SUB;

PROCEDURE GET_ACTIVE_SUB_IDS (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  out_result_set      OUT SYS_REFCURSOR,
  in_amazon_id    IN AMAZON_SUB.AMAZON_ID%TYPE
) AS
SPROC_NAME CONSTANT VARCHAR2(32) := 'GET_ACTIVE_SUB_IDS';
BEGIN
OPEN out_result_set FOR
SELECT s.id
FROM subscription s, amazon_sub am
WHERE
  s.id = am.subscription_id
  and s.subscription_status_id = GLOBAL_STATUSES_V18.SUBSCRIPTION_ACTIVE
  and am.amazon_id = in_amazon_id
;

END GET_ACTIVE_SUB_IDS;

PROCEDURE GET_ACTIVE_GROUP_IDS (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  out_result_set      OUT SYS_REFCURSOR,
  in_amazon_id    IN AMAZON_SUB.AMAZON_ID%TYPE
) AS
SPROC_NAME CONSTANT VARCHAR2(32) := 'GET_ACTIVE_GROUP_IDS';
BEGIN
OPEN out_result_set FOR
SELECT distinct a.group_id id
FROM subscription s, amazon_sub am, account a
WHERE
  s.id = am.subscription_id
  and a.id = s.account_id
  and s.subscription_status_id = GLOBAL_STATUSES_V18.SUBSCRIPTION_ACTIVE
  and am.amazon_id = in_amazon_id
;

END GET_ACTIVE_GROUP_IDS;

END PROCS_AMAZON_V18;
.
/

CREATE OR REPLACE PACKAGE BODY "PROCS_CUPY" AS

  /****************************************************************************/

  PROCEDURE POPULATE_REQUEST_INFO(
    in_hours_prior    IN  NUMBER,
    in_filename       IN  CC_REQUEST_FILE.FILE_NAME%TYPE,
    in_creator        IN  CC_REQUEST_FILE.UPDATED_BY%TYPE
  ) AS
  SPROC_NAME CONSTANT VARCHAR2(32) := 'POPULATE_REQUEST_INFO';
  var_start_date      DATE := SYSDATE;
  var_end_date        DATE := var_start_date + (in_hours_prior/24);
  var_request_file_id NUMBER := 0;
  var_license_count   NUMBER := 0;
  var_cc_update_count NUMBER := 0;
  BEGIN
      SELECT CC_REQUEST_FILE_ID_SEQ.NEXTVAL INTO var_request_file_id  FROM DUAL;
      INSERT INTO CC_REQUEST_FILE (ID,
                                   FILE_NAME,
                                   CC_REQUEST_FILE_STATUS,
                                   CREATE_DATE,
                                   CREATED_BY,
                                   UPDATE_DATE,
                                   UPDATED_BY)
                                   VALUES (
                                   var_request_file_id,
                                   in_filename,
                                   'NOT_CREATED',
                                   var_start_date,
                                   in_creator,
                                   var_start_date,
                                   in_creator);

     FOR record IN (SELECT
                      l.ID LICENSE_ID, cc.ID CREDIT_CARD_ID
                    FROM
                      LICENSE l INNER JOIN SUBSCRIPTION s ON L.SUBSCRIPTION_ID = s.ID
                                INNER JOIN CREDIT_CARD cc ON S.INSTRUMENT_ID   = cc.ID
                    WHERE
                      s.INSTRUMENT_TYPE_ID         = 1
                      AND cc.CREDIT_CARD_STATUS_ID = 1
                      AND s.SUBSCRIPTION_STATUS_ID = 1
                      AND l.LICENSE_STATUS_ID      = 2
                      AND cc.CREDIT_CARD_TYPE_ID IN (2,3)
                      AND l.END_DATE BETWEEN var_start_date AND var_end_date
                      AND l.ID NOT IN (SELECT LICENSE_ID FROM CC_UPDATE))
     LOOP
       var_license_count := 0;
       SELECT COUNT(1) INTO  var_license_count FROM CC_UPDATE WHERE LICENSE_ID = record.LICENSE_ID;

       IF var_license_count = 0 THEN
          INSERT INTO CC_UPDATE (ID,
                                 CREDIT_CARD_ID,
                                 LICENSE_ID,
                                 CC_UPDATE_STATUS,
                                 CC_REQUEST_FILE_ID,
                                 CREATE_DATE,
                                 UPDATE_DATE,
                                 CREATED_BY,
                                 UPDATED_BY
                                 ) VALUES (
                                 CC_UPDATE_SEQ.NEXTVAL,
                                 record.CREDIT_CARD_ID,
                                 record.LICENSE_ID,
                                 'NOT_ADDED_TO_FILE',
                                 var_request_file_id,
                                 var_start_date,
                                 var_start_date,
                                 in_creator,
                                 in_creator
                                 );
       END IF;
     END LOOP;

     SELECT COUNT(1) INTO var_cc_update_count
     FROM CC_UPDATE
     WHERE CC_REQUEST_FILE_ID = var_request_file_id;
     IF var_cc_update_count <= 0 THEN
       UPDATE CC_REQUEST_FILE
       SET CC_REQUEST_FILE_STATUS = 'EMPTY'
       WHERE ID = var_request_file_id;
     END IF;

  END POPULATE_REQUEST_INFO;

  /****************************************************************************/

  PROCEDURE CHASE_PROFILE_BY_REQ_FILE_ID(
    in_request_file_id IN CC_UPDATE.CC_REQUEST_FILE_ID%TYPE,
    in_start           IN NUMBER,
    in_end             IN NUMBER,
    out_result_set     OUT SYS_REFCURSOR
  ) AS
  SPROC_NAME CONSTANT VARCHAR2(32) := 'CHASE_PROFILE_BY_REQ_FILE_ID';
  var_range_diff      NUMBER := 0;
  var_upper_bond_diff NUMBER := 0;
  var_l_start         NUMBER := 0;
  var_l_end           NUMBER := 0;
  BEGIN
    --Normalize the end points [START]
    IF (in_start IS NULL OR in_start < 0) Then
      var_l_start := 0;
    ELSE
      var_l_start := in_start;
    END IF;

    IF (in_end IS NULL) Then
      var_l_end := 500;
    ELSE
      var_l_end := in_end;
    END IF;

    var_l_start := var_l_start + 1;
    var_l_end   := var_l_end   + 1;

    var_range_diff  := var_l_end - var_l_start;
    var_upper_bond_diff :=  var_range_diff - 1000;

    IF (var_upper_bond_diff > 0) Then
      var_l_end := var_l_end - var_upper_bond_diff;
    END IF;
    --Normalize the end points [END]

    OPEN out_result_set FOR
      SELECT CHASE_PROFILE_ID FROM
        (SELECT rownum rnum, q.* FROM
           (SELECT
              cc.CHASE_PROFILE_ID
            FROM
              CREDIT_CARD cc,
              CC_UPDATE ccu
            WHERE
              ccu.CC_REQUEST_FILE_ID = in_request_file_id
              AND ccu.CREDIT_CARD_ID = cc.id
          ) Q
        WHERE rownum <= var_l_end)
      WHERE rnum >= var_l_Start;
  END CHASE_PROFILE_BY_REQ_FILE_ID;

  /****************************************************************************/

  PROCEDURE UPDATE_REQUEST_FILE_STATUS(
    in_request_file_id IN CC_REQUEST_FILE.ID%TYPE,
    in_status          IN CC_REQUEST_FILE.CC_REQUEST_FILE_STATUS%TYPE,
    in_updated_by      IN CC_REQUEST_FILE.UPDATED_BY%TYPE
  )AS
  SPROC_NAME CONSTANT VARCHAR2(32) := 'UPDATE_REQUEST_FILE_STATUS';
  BEGIN
    UPDATE CC_REQUEST_FILE
    SET CC_REQUEST_FILE_STATUS = in_status,
        UPDATE_DATE = SYSDATE,
        UPDATED_BY  = in_updated_by
    WHERE ID = in_request_file_id;
  END UPDATE_REQUEST_FILE_STATUS;

  /****************************************************************************/

  PROCEDURE UPDATE_CC_REQUEST_STATUS(
    in_request_file_id IN CC_UPDATE.CC_REQUEST_FILE_ID%TYPE,
    in_status          IN CC_UPDATE.CC_UPDATE_STATUS%TYPE,
    in_updated_by      IN CC_UPDATE.UPDATED_BY%TYPE
  ) AS
  SPROC_NAME CONSTANT VARCHAR2(32) := 'UPDATE_CC_REQUEST_STATUS';
  BEGIN
    UPDATE CC_UPDATE
    SET CC_UPDATE_STATUS = in_status,
        UPDATE_DATE      = SYSDATE,
        UPDATED_BY       = in_updated_by
    WHERE
      CC_REQUEST_FILE_ID = in_request_file_id;
  END UPDATE_CC_REQUEST_STATUS;

  /****************************************************************************/

  PROCEDURE REQUEST_FILES_BY_STATUS (
    in_status           IN  CC_REQUEST_FILE.CC_REQUEST_FILE_STATUS%TYPE,
    in_older_than_hours IN  NUMBER DEFAULT -288,
    out_request_files   OUT SYS_REFCURSOR
  ) AS
  var_older_than_hours NUMBER := in_older_than_hours;
  BEGIN
   IF (var_older_than_hours IS NULL) THEN
     var_older_than_hours := -288;
   END IF;

   OPEN out_request_files FOR
   SELECT
     ID,
     FILE_NAME
   FROM
     CC_REQUEST_FILE
   WHERE
     CC_REQUEST_FILE_STATUS = in_status
   AND
     UPDATE_DATE < SYSDATE - (var_older_than_hours / 24);
  END REQUEST_FILES_BY_STATUS;

  /****************************************************************************/

  PROCEDURE COUNT_BY_REQUEST_FILE_ID (
    in_id     IN  CC_UPDATE.CC_REQUEST_FILE_ID%TYPE,
    out_count OUT NUMBER
  ) AS
  SPROC_NAME CONSTANT VARCHAR2(32) := 'COUNT_BY_REQUEST_FILE_ID';
  BEGIN
    SELECT COUNT(1) INTO out_count
    FROM CC_UPDATE
    WHERE CC_REQUEST_FILE_ID = in_id;
  END COUNT_BY_REQUEST_FILE_ID;

  /****************************************************************************/

  PROCEDURE GET_CREDIT_CARD_LICENSE (
    in_chase_profile_id  IN  CREDIT_CARD.CHASE_PROFILE_ID%TYPE,
    in_request_filename  IN  CC_REQUEST_FILE.FILE_NAME%TYPE DEFAULT NULL,
    out_card_license     OUT SYS_REFCURSOR
  ) AS
  BEGIN
    OPEN out_card_license FOR
    SELECT
      cc.ID CREDIT_CARD_ID,
      cc.CHASE_PROFILE_ID,
      cc.LAST_FOUR_CC CREDIT_CARD_LAST_DIGITS,
      cc.UPDATE_DATE CREDIT_CARD_UPDATE_DATE,
      cc.EXPIRATION_DATE CREDIT_CARD_EXPIRATION_DATE,
      cc.UPDATED_BY CREDIT_CARD_UPDATED_BY,
      a.GROUP_ID,
      u.LICENSE_ID,
      u.ID CC_UPDATE_ID,
      l.END_DATE LICENSE_END_DATE,
      DECODE(cc.CREDIT_CARD_STATUS_ID, 1, 1, 0) ACTIVE
    FROM CREDIT_CARD cc, CC_UPDATE u, CC_REQUEST_FILE rf, ACCOUNT a, LICENSE l
    WHERE cc.ID = u.CREDIT_CARD_ID
    AND u.CC_REQUEST_FILE_ID = rf.ID
    AND rf.CC_REQUEST_FILE_STATUS in ('SENT', 'RESPONSE_DOWNLOADED', 'REPORT_DOWNLOADED', 'RESPONSE_COMPLETE', 'NO_RESPONSE')
    AND rf.FILE_NAME = NVL(in_request_filename, rf.FILE_NAME)
    AND upper(cc.CHASE_PROFILE_ID) = in_chase_profile_id
    AND cc.ACCOUNT_ID = a.ID
    AND u.LICENSE_ID = l.ID
    AND u.CC_UPDATE_STATUS NOT IN ('NO_UPDATE', 'UPDATED')
    AND SYSDATE BETWEEN l.START_DATE and l.END_DATE
    ORDER BY cc.UPDATE_DATE DESC;
  END GET_CREDIT_CARD_LICENSE;

  /****************************************************************************/

  PROCEDURE UPDATE_CC_UPDATE(
    in_id              IN CC_UPDATE.ID%TYPE,
    in_status          IN CC_UPDATE.CC_UPDATE_STATUS%TYPE,
    in_action          IN CC_UPDATE.CC_UPDATE_ACTION%TYPE DEFAULT NULL,
    in_reason          IN CC_UPDATE.CC_UPDATE_REASON%TYPE DEFAULT NULL,
    in_response_proc_status_code IN CC_UPDATE.RESPONSE_PROC_STATUS_CODE%TYPE DEFAULT NULL,
    in_response_proc_status_msg  IN CC_UPDATE.RESPONSE_PROC_STATUS_MESSAGE%TYPE DEFAULT NULL,
    in_updated_by      IN CC_UPDATE.UPDATED_BY%TYPE
  ) AS
  BEGIN
    UPDATE CC_UPDATE
    SET CC_UPDATE_STATUS = in_status,
    CC_UPDATE_ACTION = NVL(in_action, CC_UPDATE_ACTION),
    CC_UPDATE_REASON = NVL(in_reason, CC_UPDATE_REASON),
    RESPONSE_PROC_STATUS_CODE = NVL(RESPONSE_PROC_STATUS_CODE, in_response_proc_status_code),
    RESPONSE_PROC_STATUS_MESSAGE = NVL(RESPONSE_PROC_STATUS_MESSAGE, in_response_proc_status_msg),
    UPDATE_DATE = SYSDATE,
    UPDATED_BY = in_updated_by
    WHERE ID = in_id;
  END UPDATE_CC_UPDATE;

  /****************************************************************************/

  PROCEDURE UPDATE_CC_UPDATE_STATUS(
    in_id         IN CC_UPDATE.ID%TYPE,
    in_status     IN CC_UPDATE.CC_UPDATE_STATUS%TYPE,
    in_updated_by IN CC_UPDATE.UPDATED_BY%TYPE
  ) AS
  BEGIN
    UPDATE CC_UPDATE
    SET CC_UPDATE_STATUS = in_status,
    UPDATE_DATE = SYSDATE,
    UPDATED_BY = in_updated_by
    WHERE ID = in_id;
  END UPDATE_CC_UPDATE_STATUS;

  /****************************************************************************/

  PROCEDURE GET_REQUEST_FILE_BY_FILENAME (
    in_request_filename  IN  CC_REQUEST_FILE.FILE_NAME%TYPE,
    out_request_file     OUT SYS_REFCURSOR
  ) AS
  BEGIN
    OPEN out_request_file FOR
    SELECT ID, FILE_NAME
    FROM CC_REQUEST_FILE
    WHERE FILE_NAME = in_request_filename;
  END GET_REQUEST_FILE_BY_FILENAME;

  /****************************************************************************/

  PROCEDURE SUSPEND_CREDIT_CARD (
    in_credit_card_id  IN CREDIT_CARD.ID%TYPE,
    in_updated_by      IN CREDIT_CARD.UPDATED_BY%TYPE
  ) AS
  BEGIN
    -- Create history
    PROCS_HISTORY_V18.CREATE_CREDIT_CARD_HISTORY(
        in_credit_card_id            => in_credit_card_id,
        in_system_activity_reason_id => GLOBAL_ENUMS_V18.SAC_SYSTEM_APPLIED_RULE
    );

    UPDATE CREDIT_CARD
    SET UPDATE_DATE = SYSDATE,
    UPDATED_BY = in_updated_by,
    CREDIT_CARD_STATUS_ID = GLOBAL_STATUSES_V18.CREDIT_CARD_DISABLED
    WHERE ID = in_credit_card_id;
  END SUSPEND_CREDIT_CARD;

  /****************************************************************************/

  PROCEDURE UPDATE_CREDIT_CARD (
    in_credit_card_id   IN CREDIT_CARD.ID%TYPE,
    in_last_four_cc     IN CREDIT_CARD.LAST_FOUR_CC%TYPE,
    in_expiration_date  IN CREDIT_CARD.EXPIRATION_DATE%TYPE,
    in_updated_by       IN CREDIT_CARD.UPDATED_BY%TYPE
  ) AS
  BEGIN
    -- Create history
    PROCS_HISTORY_V18.CREATE_CREDIT_CARD_HISTORY(
        in_credit_card_id            => in_credit_card_id,
        in_system_activity_reason_id => GLOBAL_ENUMS_V18.SAC_SYSTEM_APPLIED_RULE
    );

    UPDATE CREDIT_CARD
    SET UPDATE_DATE = SYSDATE,
    UPDATED_BY = in_updated_by,
    LAST_FOUR_CC = NVL(in_last_four_cc, LAST_FOUR_CC),
    EXPIRATION_DATE = NVL(in_expiration_date, EXPIRATION_DATE)
    WHERE ID = in_credit_card_id;
  END UPDATE_CREDIT_CARD;

  /****************************************************************************/

  PROCEDURE COMPLETABLE_REQUESTS (
    out_request_files OUT SYS_REFCURSOR
  ) AS
  BEGIN
    OPEN out_request_files FOR
    SELECT DISTINCT rf.ID, rf.FILE_NAME
    FROM CC_REQUEST_FILE rf, CC_UPDATE u
    WHERE CC_REQUEST_FILE_STATUS in ('SENT', 'RESPONSE_DOWNLOADED', 'REPORT_DOWNLOADED', 'RESPONSE_COMPLETE')
    AND rf.ID = u.CC_REQUEST_FILE_ID
    AND u.CC_UPDATE_STATUS IN ('UPDATED', 'NO_UPDATE')
    MINUS
    SELECT rf.ID, rf.FILE_NAME
    FROM CC_REQUEST_FILE rf, CC_UPDATE u
    WHERE CC_REQUEST_FILE_STATUS in ('SENT', 'RESPONSE_DOWNLOADED', 'REPORT_DOWNLOADED', 'RESPONSE_COMPLETE')
    AND rf.ID = u.CC_REQUEST_FILE_ID
    AND u.CC_UPDATE_STATUS NOT IN ('UPDATED', 'NO_UPDATE');
  END COMPLETABLE_REQUESTS;

  /****************************************************************************/

  PROCEDURE COMPLETABLE_REQUESTS_W_FAILS (
    in_max_hours_before_report IN  NUMBER,
    out_request_files          OUT SYS_REFCURSOR
  ) AS
  BEGIN
    OPEN out_request_files FOR
    SELECT DISTINCT rf.ID, rf.FILE_NAME
    FROM CC_REQUEST_FILE rf, CC_UPDATE u
    WHERE CC_REQUEST_FILE_STATUS in ('SENT', 'RESPONSE_DOWNLOADED', 'REPORT_DOWNLOADED', 'RESPONSE_COMPLETE')
    AND rf.ID = u.CC_REQUEST_FILE_ID
    AND u.CC_UPDATE_STATUS  = 'REQUEST_FAILED'
    AND u.UPDATE_DATE < SYSDATE - (in_max_hours_before_report / 24)
    MINUS
    SELECT rf.ID, rf.FILE_NAME
    FROM CC_REQUEST_FILE rf, CC_UPDATE u
    WHERE CC_REQUEST_FILE_STATUS in ('SENT', 'RESPONSE_DOWNLOADED', 'REPORT_DOWNLOADED', 'RESPONSE_COMPLETE')
    AND rf.ID = u.CC_REQUEST_FILE_ID
    AND u.UPDATE_DATE < SYSDATE - (in_max_hours_before_report / 24)
    AND u.CC_UPDATE_STATUS NOT IN ('UPDATED', 'NO_UPDATE', 'REQUEST_FAILED');
  END COMPLETABLE_REQUESTS_W_FAILS;

END PROCS_CUPY;
.
/

CREATE OR REPLACE
PACKAGE BODY PROCS_ENTITLEMENT_V18 AS

  PROCEDURE GET_ARCHIVE_ENTITLEMENT_URI(
    in_subscription_id IN NUMBER,
    out_uri OUT VARCHAR2)
  AS
    SPROC_NAME      CONSTANT VARCHAR2(30) := 'GET_ARCHIVE_ENTITLEMENT_URI';
    UNKNOWN_ERROR   EXCEPTION;
  BEGIN
    SELECT
      POMD.VALUE INTO out_uri
    FROM
       OFFER_PRODUCT_OFFERING OPO,
       PRODUCT_OFFERING PO,
       OFFER_OFFER_CHAIN OOC,
       SUBSCRIPTION S,
       LICENSE LL,
       PRODUCT_OFFERING_META_DATA POMD
    WHERE
       OPO.OFFER_ID = OOC.OFFER_ID AND
       OOC.OFFER_CHAIN_ID = S.OFFER_CHAIN_ID AND
       S.ID = in_subscription_id AND
       PO.ID = OPO.PRODUCT_OFFERING_ID AND
       PO.ID = POMD.PRODUCT_OFFERING_ID AND
       PO.CAPABILITY_ID = 1 AND
       S.ID = LL.SUBSCRIPTION_ID AND
       SYSDATE BETWEEN LL.START_DATE AND LL.ENTITLEMENT_END_DATE AND
       NAME = 'entitlement_uri' AND
       rownum < 2;
  EXCEPTION
    WHEN OTHERS THEN
      PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
        SPROC_NAME, 'Unknown error', SQLERRM);
  END GET_ARCHIVE_ENTITLEMENT_URI;

  PROCEDURE GET_ALL_ENTITLEMENTS(
    in_group_id    IN  NUMBER,
    out_result_set OUT SYS_REFCURSOR)
  AS
    -- CONSTANTS
    SPROC_NAME      CONSTANT VARCHAR2(20) := 'GET_ALL_ENTITLEMENTS';
    -- EXCEPTIONS
    NOT_FOUND       EXCEPTION;
    UNKNOWN_ERROR   EXCEPTION;
    -- VARIABLES
    var_subs        SYS_REFCURSOR;
  BEGIN
    OPEN out_result_set FOR

  SELECT
    C.CODE NAME,
    C.DESCRIPTION,
    0 INHERITED,
    C.SHAREABLE,
    MAX(LIC.ENTITLEMENT_END_DATE) EXPIRES
  FROM
    SUBSCRIPTION SB
    INNER JOIN ACCOUNT AC ON AC.ID = SB.ACCOUNT_ID
    INNER JOIN LICENSE LIC ON LIC.SUBSCRIPTION_ID = SB.ID
    INNER JOIN OFFER_PRODUCT_OFFERING OPO ON OPO.OFFER_ID = LIC.OFFER_ID
    INNER JOIN PRODUCT_OFFERING PO ON PO.ID = OPO.PRODUCT_OFFERING_ID
    INNER JOIN CAPABILITY C ON PO.CAPABILITY_ID = C.ID
  WHERE
    LIC.ENTITLEMENT_END_DATE >= TRUNC(SYSDATE)
    AND LIC.START_DATE <= SYSDATE
    AND AC.GROUP_ID = in_group_id
  GROUP BY
    C.CODE, 0, C.SHAREABLE, C.DESCRIPTION
UNION ALL
  SELECT
    C.CODE NAME,
    C.DESCRIPTION,
    1 INHERITED,
    C.SHAREABLE,
    MAX(LEAST(SS.END_DATE, LIC.ENTITLEMENT_END_DATE)) EXPIRES
  FROM
    ACCOUNT BORROWER,
    SUBSCRIPTION S,
    LICENSE LIC,
    OFFER_PRODUCT_OFFERING OPO,
    PRODUCT_OFFERING PO,
    CAPABILITY C,
    GROUP_ACCOUNT GA,
    SUBSCRIPTION_SHARE SS
  WHERE
    BORROWER.GROUP_ID = in_group_id
    AND LIC.SUBSCRIPTION_ID = S.ID
    AND OPO.OFFER_ID = LIC.OFFER_ID
    AND PO.ID = OPO.PRODUCT_OFFERING_ID
    AND PO.CAPABILITY_ID = C.ID
    AND GA.SUBSCRIPTION_ID = S.ID
    AND SS.BORROWER_ACCOUNT_ID = BORROWER.ID
    AND SS.GROUP_ACCOUNT_ID = GA.ID
    AND SYSDATE BETWEEN SS.START_DATE AND SS.END_DATE
    AND SYSDATE BETWEEN LIC.START_DATE AND LIC.ENTITLEMENT_END_DATE
    AND C.SHAREABLE = 1
  GROUP BY
    C.CODE, 0, C.SHAREABLE, C.DESCRIPTION;

  EXCEPTION
    WHEN OTHERS THEN
      PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
        SPROC_NAME, 'Unknown error', SQLERRM);
  END GET_ALL_ENTITLEMENTS;

  PROCEDURE GET_ITUNES_ENTITLEMENTS(
    in_product_id IN CORE_OWNER.ITUNES_RECEIPT.PRODUCT_ID%TYPE,
    out_result_set OUT SYS_REFCURSOR)
  AS
    -- CONSTANTS
    SPROC_NAME      CONSTANT VARCHAR2(25) := 'GET_ITUNES_ENTITLEMENTS';
    -- EXCEPTIONS
    NOT_FOUND       EXCEPTION;
    UNKNOWN_ERROR   EXCEPTION;
    -- VARIABLES
    var_subs        SYS_REFCURSOR;
  BEGIN
    OPEN out_result_set FOR

	SELECT 
	  c.code NAME,
	  C.DESCRIPTION,
	  0 INHERITED,
	  C.SHAREABLE, 
	  sysdate as EXPIRES
	FROM 
	  offer_offer_chain ooc,
	  offer o,
	  offer_product_offering opo,
	  product_offering po,
	  capability c
	WHERE
	  o.id = ooc.offer_id AND
	  opo.offer_id = o.id AND
	  po.id = opo.product_offering_id AND
	  c.id = po.capability_id AND
	  c.id !=0 AND
	  ooc.offer_chain_id = 
	  (SELECT
	      ocmd.offer_chain_id 
	    FROM
	        offer_chain_meta_data ocmd
	    WHERE
			ocmd.name = 'ITUNES_PRODUCT_ID' AND
	        ocmd.value = in_product_id AND
	        rownum < 2
	  ) 
	;

  EXCEPTION
    WHEN OTHERS THEN
      PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
        SPROC_NAME, 'Unknown error', SQLERRM);
  END GET_ITUNES_ENTITLEMENTS;

END PROCS_ENTITLEMENT_V18;
.
/

CREATE OR REPLACE PACKAGE BODY "PROCS_HISTORY_V18" AS

PROCEDURE CREATE_ADDRESS_HISTORY(
  in_address_id                IN NUMBER,
  in_system_activity_reason_id IN NUMBER
) AS
SPROC_NAME CONSTANT VARCHAR2(22) := 'CREATE_ADDRESS_HISTORY';
-- VARIABLES
var_address1    ADDRESS.ADDRESS1%TYPE;
var_address2    ADDRESS.ADDRESS2%TYPE;
var_city        ADDRESS.CITY%TYPE;
var_state       ADDRESS.STATE%TYPE;
var_postal_code ADDRESS.POSTAL_CODE%TYPE;
var_country     ADDRESS.COUNTRY%TYPE;
var_created_by  ADDRESS.CREATED_BY%TYPE;
var_create_date ADDRESS.CREATE_DATE%TYPE;
var_updated_by  ADDRESS.UPDATED_BY%TYPE;
var_update_date ADDRESS.UPDATE_DATE%TYPE;
-- EXCEPTIONS
BAD_ADDRESS_ID         EXCEPTION;
CAN_NOT_CREATE_HISTORY EXCEPTION;
EXCEPTION_MESSAGE      VARCHAR2(1024);
BEGIN

  BEGIN
    SELECT
      ADDRESS.ADDRESS1,
      ADDRESS.ADDRESS2,
      ADDRESS.CITY,
      ADDRESS.STATE,
      ADDRESS.POSTAL_CODE,
      ADDRESS.COUNTRY,
      ADDRESS.CREATED_BY,
      ADDRESS.CREATE_DATE,
      ADDRESS.UPDATED_BY,
      ADDRESS.UPDATE_DATE
      into
      var_address1,
      var_address2,
      var_city,
      var_state,
      var_postal_code,
      var_country,
      var_created_by,
      var_create_date,
      var_updated_by,
      var_update_date
    FROM
      ADDRESS
    WHERE
      ADDRESS.ID = in_address_id;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE BAD_ADDRESS_ID;
  END;

  BEGIN
    CORE_HIST_OWNER.PUBLIC_PROCS_CORE_V18.CREATE_ADDRESS_HISTORY(
      in_address_id,
      in_system_activity_reason_id,
      var_address1,
      var_address2,
      var_city,
      var_state,
      var_postal_code,
      var_country,
      var_created_by,
      var_create_date,
      var_updated_by,
      var_update_date
    );
    EXCEPTION
      WHEN OTHERS THEN
        EXCEPTION_MESSAGE := SQLERRM;
        RAISE CAN_NOT_CREATE_HISTORY;
  END;

EXCEPTION
WHEN BAD_ADDRESS_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'Bad recipientAddress id');
WHEN CAN_NOT_CREATE_HISTORY THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.INTERNAL_ERROR,
    SPROC_NAME, 'Could not create history', EXCEPTION_MESSAGE);
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END CREATE_ADDRESS_HISTORY;

/********************************************************************/

PROCEDURE CREATE_ACCOUNT_HISTORY(
  in_account_id                IN NUMBER,
  in_system_activity_reason_id IN NUMBER
) AS
SPROC_NAME CONSTANT VARCHAR2(22) := 'CREATE_ACCOUNT_HISTORY';
-- VARIABLES
var_account_status_id  NUMBER;
var_suspend_date       DATE;
var_group_id           NUMBER;
var_instrument_type_id NUMBER;
var_instrument_id      NUMBER;
var_updated_by         VARCHAR2(255);
var_update_date        DATE;
-- EXCEPTIONS
BAD_ACCOUNT_ID         EXCEPTION;
CAN_NOT_CREATE_HISTORY EXCEPTION;
EXCEPTION_MESSAGE      VARCHAR2(1024);
BEGIN

  BEGIN
    SELECT
      ACCOUNT.ACCOUNT_STATUS_ID,
      ACCOUNT.GROUP_ID,
      ACCOUNT.INSTRUMENT_TYPE_ID,
      ACCOUNT.INSTRUMENT_ID,
      ACCOUNT.UPDATED_BY,
      ACCOUNT.UPDATE_DATE
      into
      var_account_status_id,
      var_group_id,
      var_instrument_type_id,
      var_instrument_id,
      var_updated_by,
      var_update_date
    FROM
      ACCOUNT
    WHERE
      ACCOUNT.ID = in_account_id;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE BAD_ACCOUNT_ID;
  END;
  
  BEGIN
    CORE_HIST_OWNER.PUBLIC_PROCS_CORE_V18.CREATE_ACCOUNT_HISTORY(
      in_account_id,
      var_suspend_date,
      var_group_id,
      var_updated_by,
      var_update_date,
      in_system_activity_reason_id,
      var_account_status_id,
      var_instrument_type_id,
      var_instrument_id
    );
    EXCEPTION
      WHEN OTHERS THEN
        EXCEPTION_MESSAGE := SQLERRM;
        RAISE CAN_NOT_CREATE_HISTORY;
  END;

EXCEPTION
WHEN BAD_ACCOUNT_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'Bad account id');
WHEN CAN_NOT_CREATE_HISTORY THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.INTERNAL_ERROR,
    SPROC_NAME, 'Could not create history', EXCEPTION_MESSAGE);
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END CREATE_ACCOUNT_HISTORY;

/********************************************************************/

PROCEDURE CREATE_SUBSCRIPTION_HISTORY (
/*
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_subscription_id           IN NUMBER,
  in_system_activity_reason_id IN NUMBER
) AS
SPROC_NAME CONSTANT VARCHAR2(27) := 'CREATE_SUBSCRIPTION_HISTORY';
-- VARIABLES
var_account_id                NUMBER;
var_purchase_date             DATE;
var_offer_chain_id            NUMBER;
var_suspend_date              DATE;
var_termination_date          DATE;
var_days_ramaining_adjustment NUMBER;
var_sct_id                    NUMBER;
var_updated_by                VARCHAR2(255);
var_update_date               DATE;
-- EXCEPTIONS
BAD_SUBSCRIPTION_ID    EXCEPTION;
CAN_NOT_CREATE_HISTORY EXCEPTION;
EXCEPTION_MESSAGE      VARCHAR2(1024);
BEGIN

  BEGIN
    SELECT
      SUBSCRIPTION.account_id,
      SUBSCRIPTION.PURCHASE_DATE,
      SUBSCRIPTION.OFFER_CHAIN_ID,
      SUBSCRIPTION.SUSPEND_DATE,
      SUBSCRIPTION.TERMINATION_DATE,
      SUBSCRIPTION.DAYS_REMAINING_ADJUSTMENT,
      SUBSCRIPTION.SCT_ID,
      SUBSCRIPTION.UPDATED_BY,
      SUBSCRIPTION.UPDATE_DATE
      into
      var_account_id,
      var_purchase_date,
      var_offer_chain_id,
      var_suspend_date,
      var_termination_date,
      var_days_ramaining_adjustment,
      var_sct_id,
      var_updated_by,
      var_update_date
    FROM
      SUBSCRIPTION
    WHERE
      SUBSCRIPTION.ID = in_subscription_id;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE BAD_SUBSCRIPTION_ID;
  END;
  
  BEGIN
    CORE_HIST_OWNER.PUBLIC_PROCS_CORE_V18.CREATE_SUBSCRIPTION_HISTORY(
      in_subscription_id,
      var_account_id,
      var_purchase_date,
      var_offer_chain_id,
      var_suspend_date,
      var_termination_date,
      var_days_ramaining_adjustment,
      var_sct_id,
      var_updated_by,
      var_update_date,
      in_system_activity_reason_id
    );
    EXCEPTION
      WHEN OTHERS THEN
        EXCEPTION_MESSAGE := SQLERRM;
        RAISE CAN_NOT_CREATE_HISTORY;
  END;

EXCEPTION
WHEN BAD_SUBSCRIPTION_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'No such subscription');
WHEN CAN_NOT_CREATE_HISTORY THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.INTERNAL_ERROR,
    SPROC_NAME, 'Could not create history', EXCEPTION_MESSAGE);
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END CREATE_SUBSCRIPTION_HISTORY;

/********************************************************************/

PROCEDURE CREATE_CREDIT_CARD_HISTORY(
  in_credit_card_id             IN NUMBER,
  in_system_activity_reason_id  IN NUMBER
) AS
SPROC_NAME CONSTANT VARCHAR2(26) := 'CREATE_CREDIT_CARD_HISTORY';
-- VARIABLES
var_account_id                 NUMBER;
var_instrument_name            VARCHAR2(255);
var_private_card_holder_name   VARCHAR2(256);
var_private_street_address     VARCHAR2(256);
var_private_street_address2    VARCHAR2(256);
var_state                      VARCHAR2(50);
var_city                       VARCHAR2(50);
var_postal_code                VARCHAR2(20);
var_country                    CHAR(2);
var_last_four_cc               VARCHAR2(4);
var_expiration_date            DATE;
var_credit_card_type_id        NUMBER;
var_secret_token               VARCHAR2(255);
var_chase_profile_id           VARCHAR2(255);
var_credit_card_status_id      NUMBER;
var_updated_by                 VARCHAR2(255);
var_update_date                DATE;
-- EXCEPTIONS
BAD_CREDIT_CARD_ID     EXCEPTION;
CAN_NOT_CREATE_HISTORY EXCEPTION;
EXCEPTION_MESSAGE      VARCHAR2(1024);
BEGIN

  BEGIN
    SELECT
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
      CREDIT_CARD_STATUS_ID,
      UPDATED_BY,
      UPDATE_DATE
      into
      var_account_id,
      var_instrument_name,
      var_private_card_holder_name,
      var_private_street_address,
      var_private_street_address2,
      var_state,
      var_city,
      var_postal_code,
      var_country,
      var_last_four_cc,
      var_expiration_date,
      var_credit_card_type_id,
      var_secret_token,
      var_chase_profile_id,
      var_credit_card_status_id,
      var_updated_by,
      var_update_date
    FROM
      CREDIT_CARD
    WHERE
      CREDIT_CARD.ID = in_credit_card_id;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE BAD_CREDIT_CARD_ID;
  END;

  BEGIN    
    CORE_HIST_OWNER.PUBLIC_PROCS_CORE_V18.CREATE_CREDIT_CARD_HISTORY(
      in_credit_card_id,
      var_account_id,
      var_instrument_name,
      var_private_card_holder_name,
      var_private_street_address,
      var_private_street_address2,
      var_state,
      var_city,
      var_postal_code,
      var_country,
      var_last_four_cc,
      var_expiration_date,
      var_credit_card_type_id,
      var_secret_token,
      var_chase_profile_id,
      var_credit_card_status_id,
      var_updated_by,
      var_update_date,
      in_system_activity_reason_id
    );
    EXCEPTION
      WHEN OTHERS THEN
        EXCEPTION_MESSAGE := SQLERRM;
        RAISE CAN_NOT_CREATE_HISTORY;
  END;

EXCEPTION
WHEN BAD_CREDIT_CARD_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'No such credit card');
WHEN CAN_NOT_CREATE_HISTORY THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.INTERNAL_ERROR,
    SPROC_NAME, 'Could not create history', EXCEPTION_MESSAGE);
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END CREATE_CREDIT_CARD_HISTORY;

/********************************************************************/

PROCEDURE CREATE_PAYPAL_HISTORY(
/*
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
APP_EXCEPTION_CODES_V18.INTERNAL_ERROR
*/
  in_paypal_id                  IN NUMBER,
  in_system_activity_reason_id  IN NUMBER
) AS
SPROC_NAME CONSTANT VARCHAR(21) := 'CREATE_PAYPAL_HISTORY';
-- VARIABLES
var_account_id               PAYPAL.ACCOUNT_ID%TYPE;
var_instrument_name          PAYPAL.INSTRUMENT_NAME%TYPE DEFAULT NULL;
var_private_email_address    PAYPAL.PRIVATE_EMAIL_ADDRESS%TYPE DEFAULT NULL;
var_created_by               PAYPAL.CREATED_BY%TYPE;
var_paypal_status_id         PAYPAL.PAYPAL_STATUS_ID%TYPE;
var_paypal_prvt_street_addr  PAYPAL.PRIVATE_STREET_ADDRESS%TYPE;
var_paypal_prvt_street_addr2 PAYPAL.PRIVATE_STREET_ADDRESS2%TYPE;
var_state                    PAYPAL.STATE%TYPE;
var_city                     PAYPAL.CITY%TYPE;
var_postal_code              PAYPAL.POSTAL_CODE%TYPE;
var_country                  PAYPAL.COUNTRY%TYPE;
var_expiration_date          PAYPAL.EXPIRATION_DATE%TYPE;
var_update_date              PAYPAL.UPDATE_DATE%TYPE;
var_updated_by               PAYPAL.UPDATED_BY%TYPE;
var_secret_token             PAYPAL.SECRET_TOKEN%TYPE;
-- EXCEPTION
BAD_PAYPAL_ID       EXCEPTION;
CAN_NOT_ADD_HISTORY EXCEPTION;
EXCEPTION_MESSAGE   VARCHAR2(1024);
BEGIN
  
  BEGIN
    SELECT
      ACCOUNT_ID,
      INSTRUMENT_NAME,
      PRIVATE_EMAIL_ADDRESS,
      UPDATE_DATE,
      UPDATED_BY,
      PAYPAL_STATUS_ID,
      PRIVATE_STREET_ADDRESS,
      PRIVATE_STREET_ADDRESS2,
      STATE,
      CITY,
      POSTAL_CODE,
      COUNTRY,
      EXPIRATION_DATE,
      SECRET_TOKEN
    INTO
      var_account_id,
      var_instrument_name,
      var_private_email_address,
      var_update_date,
      var_updated_by,
      var_paypal_status_id,
      var_paypal_prvt_street_addr,
      var_paypal_prvt_street_addr2,
      var_state,
      var_city,
      var_postal_code,
      var_country,
      var_expiration_date,
      var_secret_token
    FROM
      PAYPAL
    WHERE
      ID = in_paypal_id;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE BAD_PAYPAL_ID;
  END;
  
  BEGIN
    CORE_HIST_OWNER.PUBLIC_PROCS_CORE_V18.CREATE_PAYPAL_HISTORY(
      in_paypal_id,
      var_account_id,
      var_instrument_name,
      var_private_email_address,
      var_updated_by,
      var_update_date,
      var_paypal_status_id,
      var_paypal_prvt_street_addr,
      var_paypal_prvt_street_addr2,
      var_state,
      var_city,
      var_postal_code,
      var_country,
      var_expiration_date,
      in_system_activity_reason_id,
      var_secret_token
    );
    EXCEPTION
      WHEN OTHERS THEN
        EXCEPTION_MESSAGE := SQLERRM;
        RAISE CAN_NOT_ADD_HISTORY;
  END;

EXCEPTION
WHEN BAD_PAYPAL_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'No such paypal');
WHEN CAN_NOT_ADD_HISTORY THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.INTERNAL_ERROR,
    SPROC_NAME, 'Could not add history', EXCEPTION_MESSAGE);
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END CREATE_PAYPAL_HISTORY;

/********************************************************************/

PROCEDURE CREATE_GIFT_CERT_HISTORY(
  in_gift_certificate_id        IN NUMBER,
  in_system_activity_reason_id  IN NUMBER
) AS
SPROC_NAME CONSTANT VARCHAR2(24) := 'CREATE_GIFT_CERT_HISTORY';
-- VARIABLES
var_purchaser_group_id         NUMBER;
var_purchase_invoice_id        NUMBER;
var_offer_chain_id             NUMBER;
var_expiration_date            DATE;
var_purchase_date              DATE;
var_gift_certificate_status_id NUMBER;
var_code                       VARCHAR2(255);
var_recipient_name             VARCHAR2(255);
var_gift_message               VARCHAR2(500);
var_recipient_email            VARCHAR2(255);
var_finalized_invoice_id       NUMBER;
var_sender_email               VARCHAR2(50);
var_sender_name                VARCHAR2(50);
var_redemption_date            DATE;
var_redeemer_group_id          NUMBER;
var_cancelation_date           DATE;
var_updated_by                 VARCHAR2(255);
var_update_date                DATE;
var_recipient_address_id       NUMBER;
var_redeemer_address_id        NUMBER;
var_recipient_notify_date      DATE;
-- EXCEPTIONS
BAD_GIFT_CERTIFICATE_ID EXCEPTION;
CAN_NOT_CREATE_HISTORY  EXCEPTION;
EXCEPTION_MESSAGE       VARCHAR2(1024);
BEGIN

  BEGIN
    SELECT
      GIFT_CERTIFICATE.PURCHASER_GROUP_ID,
      GIFT_CERTIFICATE.PURCHASE_INVOICE_ID,
      GIFT_CERTIFICATE.OFFER_CHAIN_ID,
      GIFT_CERTIFICATE.EXPIRATION_DATE,
      GIFT_CERTIFICATE.PURCHASE_DATE,
      GIFT_CERTIFICATE.GIFT_CERTIFICATE_STATUS_ID,
      GIFT_CERTIFICATE.CODE,
      GIFT_CERTIFICATE.RECIPIENT_NAME,
      GIFT_CERTIFICATE.GIFT_MESSAGE,
      GIFT_CERTIFICATE.RECIPIENT_EMAIL,
      GIFT_CERTIFICATE.FINALIZED_INVOICE_ID,
      GIFT_CERTIFICATE.SENDER_EMAIL,
      GIFT_CERTIFICATE.SENDER_NAME,
      GIFT_CERTIFICATE.REDEMPTION_DATE,
      GIFT_CERTIFICATE.REDEEMER_GROUP_ID,
      GIFT_CERTIFICATE.CANCELATION_DATE,
      GIFT_CERTIFICATE.UPDATED_BY,
      GIFT_CERTIFICATE.UPDATE_DATE,
      GIFT_CERTIFICATE.RECIPIENT_ADDRESS_ID,
      GIFT_CERTIFICATE.REDEEMER_ADDRESS_ID,
      GIFT_CERTIFICATE.RECIPIENT_NOTIFY_DATE
      into
      var_purchaser_group_id,
      var_purchase_invoice_id,
      var_offer_chain_id,
      var_expiration_date,
      var_purchase_date,
      var_gift_certificate_status_id,
      var_code,
      var_recipient_name,
      var_gift_message,
      var_recipient_email,
      var_finalized_invoice_id,
      var_sender_email,
      var_sender_name,
      var_redemption_date,
      var_redeemer_group_id,
      var_cancelation_date,
      var_updated_by,
      var_update_date,
      var_recipient_address_id,
      var_redeemer_address_id,
      var_recipient_notify_date
    FROM
      GIFT_CERTIFICATE
    WHERE
      GIFT_CERTIFICATE.ID = in_gift_certificate_id;
  END;
  
  BEGIN
    CORE_HIST_OWNER.PUBLIC_PROCS_CORE_V18.CREATE_GIFT_CERT_HISTORY(
      in_gift_certificate_id,
      var_purchaser_group_id,
      var_purchase_invoice_id,
      var_offer_chain_id,
      var_expiration_date,
      var_purchase_date,
      var_gift_certificate_status_id,
      var_code,
      var_updated_by,
      var_update_date,
      in_system_activity_reason_id,
      var_recipient_name,
      var_gift_message,
      var_recipient_email,
      var_finalized_invoice_id,
      var_sender_email,
      var_sender_name,
      var_redemption_date,
      var_redeemer_group_id,
      var_cancelation_date,
      var_recipient_address_id,
      var_redeemer_address_id,
      var_recipient_notify_date
    );
    EXCEPTION
      WHEN OTHERS THEN
        EXCEPTION_MESSAGE := SQLERRM;
        RAISE CAN_NOT_CREATE_HISTORY;
  END;

EXCEPTION
WHEN BAD_GIFT_CERTIFICATE_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'No such gift certificate');
WHEN CAN_NOT_CREATE_HISTORY THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.INTERNAL_ERROR,
    SPROC_NAME, 'Could not create history', EXCEPTION_MESSAGE);
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END CREATE_GIFT_CERT_HISTORY;

/********************************************************************/

PROCEDURE CREATE_TRANSACTION_HISTORY (
  in_transaction_id            IN NUMBER,
  in_system_activity_reason_id IN NUMBER
) AS
SPROC_NAME CONSTANT VARCHAR2(26) := 'CREATE_TRANSACTION_HISTORY';
-- VARIABLES
var_transaction_status_id  TRANSACTION.TRANSACTION_STATUS_ID%TYPE;
var_transaction_amount     TRANSACTION.TRANSACTION_AMOUNT%TYPE;
var_updated_by             TRANSACTION.UPDATED_BY%TYPE;
var_update_date            TRANSACTION.UPDATE_DATE%TYPE;
var_order_id               TRANSACTION.ORDER_ID%TYPE;
var_charge_id              TRANSACTION.CHARGE_ID%TYPE;
var_is_refund              TRANSACTION.IS_REFUND%TYPE;
var_is_settled             TRANSACTION.IS_SETTLED%TYPE;
var_transaction_type_code  TRANSACTION.TRANSACTION_TYPE_CODE%TYPE;
-- EXCEPTIONS
BAD_TRANSACTION_ID     EXCEPTION;
CAN_NOT_CREATE_HISTORY EXCEPTION;
EXCEPTION_MESSAGE      VARCHAR2(1024);
BEGIN
  
  BEGIN
    SELECT
      TRANSACTION.TRANSACTION_STATUS_ID,
      TRANSACTION.TRANSACTION_AMOUNT,
      TRANSACTION.UPDATED_BY,
      TRANSACTION.UPDATE_DATE,
      TRANSACTION.ORDER_ID,
      TRANSACTION.CHARGE_ID,
      TRANSACTION.IS_REFUND,
      TRANSACTION.IS_SETTLED,
      TRANSACTION.TRANSACTION_TYPE_CODE
      into
      var_transaction_status_id,
      var_transaction_amount,
      var_updated_by,
      var_update_date,
      var_order_id,
      var_charge_id,
      var_is_refund,
      var_is_settled,
      var_transaction_type_code
    FROM
      TRANSACTION
    WHERE
      TRANSACTION.ID = in_transaction_id;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE BAD_TRANSACTION_ID;
  END;
  
  BEGIN
    CORE_HIST_OWNER.PUBLIC_PROCS_CORE_V18.CREATE_TRANSACTION_HISTORY(
      in_transaction_id,
      var_transaction_status_id,
      var_transaction_amount,
      var_updated_by,
      var_update_date,
      var_order_id,
      var_charge_id,
      var_is_refund,
      var_is_settled,
      var_transaction_type_code,
      in_system_activity_reason_id
    );
    EXCEPTION
      WHEN OTHERS THEN
        EXCEPTION_MESSAGE := SQLERRM;
        RAISE CAN_NOT_CREATE_HISTORY;
  END;
  
EXCEPTION
WHEN BAD_TRANSACTION_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'No such transaction');
WHEN CAN_NOT_CREATE_HISTORY THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.INTERNAL_ERROR,
    SPROC_NAME, 'Could not create history', EXCEPTION_MESSAGE);
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END CREATE_TRANSACTION_HISTORY;

/********************************************************************/

PROCEDURE CREATE_INVOICE_HISTORY (
/*
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
APP_EXCEPTION_CODES_V18.INTERNAL_ERROR
*/
  in_invoice_id                IN NUMBER,
  in_system_activity_reason_id IN NUMBER
) AS
SPROC_NAME CONSTANT VARCHAR2(22) := 'CREATE_INVOICE_HISTORY';
-- VARIABLES
var_invoice_status_id NUMBER;
var_updated_by        VARCHAR2(255);
var_update_date       DATE;
-- EXCEPTIONS
BAD_INVOICE_ID         EXCEPTION;
CAN_NOT_CREATE_HISTORY EXCEPTION;
EXCEPTION_MESSAGE      VARCHAR2(1024);
BEGIN
  
  BEGIN
    SELECT
      INVOICE.INVOICE_STATUS_ID,
      INVOICE.UPDATED_BY,
      INVOICE.UPDATE_DATE
      into
      var_invoice_status_id,
      var_updated_by,
      var_update_date
    FROM
      INVOICE
    WHERE
      INVOICE.ID = in_invoice_id;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE BAD_INVOICE_ID;
  END;
  
  BEGIN
    CORE_HIST_OWNER.PUBLIC_PROCS_CORE_V18.CREATE_INVOICE_HISTORY(
      in_invoice_id,
      var_invoice_status_id,
      var_updated_by,
      var_update_date,
      in_system_activity_reason_id
    );
    EXCEPTION
      WHEN OTHERS THEN
        EXCEPTION_MESSAGE := SQLERRM;
        RAISE CAN_NOT_CREATE_HISTORY;
  END;
  
EXCEPTION
WHEN BAD_INVOICE_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'No such invoice');
WHEN CAN_NOT_CREATE_HISTORY THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.INTERNAL_ERROR,
    SPROC_NAME, 'Could not create history', EXCEPTION_MESSAGE);
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END CREATE_INVOICE_HISTORY;

/********************************************************************/

PROCEDURE CREATE_LICENSE_HISTORY (
/*
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
APP_EXCEPTION_CODES_V18.INTERNAL_ERROR
*/
  in_license_id                IN NUMBER,
  in_system_activity_reason_id IN NUMBER
) AS
SPROC_NAME CONSTANT VARCHAR2(22) := 'CREATE_LICENSE_HISTORY';
-- VARIABLES
var_license_status_id         NUMBER;
var_needs_entitlements        NUMBER;
var_start_date                DATE;
var_offer_id                  NUMBER;
var_subscription_id           NUMBER;
var_invoice_id                NUMBER;
var_end_date                  DATE;
var_is_extension              NUMBER;
var_current_offer_index       NUMBER;
var_current_offer_recurr_num  NUMBER;
var_updated_by                VARCHAR2(255);
var_update_date               DATE;
var_entitlement_end_date      DATE;
var_grace_start_date          DATE;
var_grace_end_date            DATE;
-- EXCEPTIONS
BAD_LICENSE_ID         EXCEPTION;
CAN_NOT_CREATE_HISTORY EXCEPTION;
EXCEPTION_MESSAGE      VARCHAR2(1024);
BEGIN
  
  BEGIN
    SELECT
      LICENSE.LICENSE_STATUS_ID,
      LICENSE.NEEDS_ENTITLEMENTS,
      LICENSE.START_DATE,
      LICENSE.OFFER_ID,
      LICENSE.SUBSCRIPTION_ID,
      LICENSE.INVOICE_ID,
      LICENSE.END_DATE,
      LICENSE.IS_EXTENSION,
      LICENSE.CURRENT_OFFER_INDEX,
      LICENSE.CURRENT_OFFER_RECURR_NUM,
      LICENSE.UPDATED_BY,
      LICENSE.UPDATE_DATE,
      LICENSE.ENTITLEMENT_END_DATE,
      LICENSE.GRACE_START_DATE,
      LICENSE.GRACE_END_DATE
      into
      var_license_status_id,
      var_needs_entitlements,
      var_start_date,
      var_offer_id,
      var_subscription_id,
      var_invoice_id,
      var_end_date,
      var_is_extension,
      var_current_offer_index,
      var_current_offer_recurr_num,
      var_updated_by,
      var_update_date,
      var_entitlement_end_date,
      var_grace_start_date,
      var_grace_end_date
    FROM
      LICENSE
    WHERE
      LICENSE.ID = in_license_id;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE BAD_LICENSE_ID;
  END;
  
  BEGIN
    CORE_HIST_OWNER.PUBLIC_PROCS_CORE_V18.CREATE_LICENSE_HISTORY(
      in_license_id,
      var_license_status_id,
      var_needs_entitlements,
      var_start_date,
      var_offer_id,
      var_subscription_id,
      var_invoice_id,
      var_end_date,
      var_updated_by,
      var_update_date,
      var_is_extension,
      var_current_offer_index,
      var_current_offer_recurr_num,
      in_system_activity_reason_id,
      var_entitlement_end_date,
      var_grace_start_date,
      var_grace_end_date
    );
    EXCEPTION
      WHEN OTHERS THEN
        EXCEPTION_MESSAGE := SQLERRM;
        RAISE CAN_NOT_CREATE_HISTORY;
  END;
  
EXCEPTION
WHEN BAD_LICENSE_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'No such license');
WHEN CAN_NOT_CREATE_HISTORY THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.INTERNAL_ERROR,
    SPROC_NAME, 'Could not create history', EXCEPTION_MESSAGE);
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END CREATE_LICENSE_HISTORY;

/********************************************************************/

PROCEDURE CREATE_CHARGE_HISTORY (
/*
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
APP_EXCEPTION_CODES_V18.INTERNAL_ERROR
*/
  in_charge_id                IN NUMBER,
  in_system_activity_reason_id IN NUMBER
) AS
SPROC_NAME CONSTANT VARCHAR2(21) := 'CREATE_CHARGE_HISTORY';
-- VARIABLES
var_invoice_id         NUMBER;
var_transaction_id     NUMBER;
var_instrument_type_id NUMBER;
var_instrument_id      NUMBER;
var_charge_amount      NUMBER;
var_charge_status_id   NUMBER;
var_updated_by         VARCHAR2(255);
var_update_date        DATE;
-- EXCEPTIONS
BAD_CHARGE_ID          EXCEPTION;
CAN_NOT_CREATE_HISTORY EXCEPTION;
EXCEPTION_MESSAGE      VARCHAR2(1024);
BEGIN
  
  BEGIN
    SELECT
      CHARGE.INVOICE_ID,
      CHARGE.TRANSACTION_ID,
      CHARGE.INSTRUMENT_TYPE_ID,
      CHARGE.INSTRUMENT_ID,
      CHARGE.CHARGE_AMOUNT,
      CHARGE.CHARGE_STATUS_ID,
      CHARGE.UPDATED_BY,
      CHARGE.UPDATE_DATE
      into
      var_invoice_id,
      var_transaction_id,
      var_instrument_type_id,
      var_instrument_id,
      var_charge_amount,
      var_charge_status_id,
      var_updated_by,
      var_update_date
    FROM
      CHARGE
    WHERE
      CHARGE.ID = in_charge_id;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE BAD_CHARGE_ID;
  END;
  
  BEGIN
    CORE_HIST_OWNER.PUBLIC_PROCS_CORE_V18.CREATE_CHARGE_HISTORY (
      in_charge_id,
      var_invoice_id,
      var_transaction_id,
      var_instrument_type_id,
      var_instrument_id,
      var_charge_amount,
      var_updated_by,
      var_update_date,
      var_charge_status_id,
      in_system_activity_reason_id
    );
    EXCEPTION
      WHEN OTHERS THEN
        EXCEPTION_MESSAGE := SQLERRM;
        RAISE CAN_NOT_CREATE_HISTORY;
  END;
  
EXCEPTION
WHEN BAD_CHARGE_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'No such license');
WHEN CAN_NOT_CREATE_HISTORY THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.INTERNAL_ERROR,
    SPROC_NAME, 'Could not create history', EXCEPTION_MESSAGE);
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END CREATE_CHARGE_HISTORY;

PROCEDURE CREATE_INVOICE_ADJ_HISTORY (
/*
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
APP_EXCEPTION_CODES_V18.INTERNAL_ERROR
*/
  in_invoice_adjustment_id  IN NUMBER,
  in_system_activity_reason_id IN NUMBER
) AS
SPROC_NAME CONSTANT VARCHAR(32) := 'CREATE_INVOICE_ADJ_HISTORY';
--VARIABLED
var_invoice_adj_id          INVOICE_ADJUSTMENT.ID%TYPE;
var_invoice_id              INVOICE_ADJUSTMENT.INVOICE_ID%TYPE;
var_is_credit               INVOICE_ADJUSTMENT.IS_CREDIT%TYPE;
var_charge_id               INVOICE_ADJUSTMENT.CHARGE_ID%TYPE;
var_adjustment_date         INVOICE_ADJUSTMENT.ADJUSTMENT_DATE%TYPE;
var_create_date             INVOICE_ADJUSTMENT.CREATE_DATE%TYPE;
var_created_by              INVOICE_ADJUSTMENT.CREATED_BY%TYPE;
var_invoice_adj_reason_id INVOICE_ADJUSTMENT.INVOICE_ADJUSTMENT_REASON_ID%TYPE;
var_update_date             INVOICE_ADJUSTMENT.UPDATE_DATE%TYPE;
var_updated_by              INVOICE_ADJUSTMENT.UPDATED_BY%TYPE;
BAD_INVOICE_ADJ_ID          EXCEPTION;
CAN_NOT_CREATE_HISTORY      EXCEPTION;
EXCEPTION_MESSAGE      VARCHAR2(1024);
BEGIN

  BEGIN
    SELECT
      INVOICE_ADJUSTMENT.ID,
      INVOICE_ADJUSTMENT.INVOICE_ID,
      INVOICE_ADJUSTMENT.IS_CREDIT,
      INVOICE_ADJUSTMENT.CHARGE_ID,
      INVOICE_ADJUSTMENT.ADJUSTMENT_DATE,
      INVOICE_ADJUSTMENT.CREATE_DATE,
      INVOICE_ADJUSTMENT.CREATED_BY,
      INVOICE_ADJUSTMENT.INVOICE_ADJUSTMENT_REASON_ID,
      INVOICE_ADJUSTMENT.UPDATE_DATE,
      INVOICE_ADJUSTMENT.UPDATED_BY 
      into
      var_invoice_adj_id,
      var_invoice_id,
      var_is_credit,
      var_charge_id,
      var_adjustment_date,
      var_create_date,
      var_created_by,
      var_invoice_adj_reason_id,
      var_update_date,
      var_updated_by
    FROM
      INVOICE_ADJUSTMENT
    WHERE
      INVOICE_ADJUSTMENT.ID = in_invoice_adjustment_id;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE BAD_INVOICE_ADJ_ID;
  END;

  BEGIN
    CORE_HIST_OWNER.PUBLIC_PROCS_CORE_V18.CREATE_INVOICE_ADJ_HISTORY (
      var_invoice_adj_id,
      var_invoice_id,
      var_is_credit,
      var_charge_id,
      var_adjustment_date,
      var_create_date,
      var_created_by,
      var_invoice_adj_reason_id,
      var_update_date,
      var_updated_by
    );
    EXCEPTION
      WHEN OTHERS THEN
        EXCEPTION_MESSAGE := SQLERRM;
        RAISE CAN_NOT_CREATE_HISTORY;
  END;

EXCEPTION
WHEN BAD_INVOICE_ADJ_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'No such invoice adjustment');
WHEN CAN_NOT_CREATE_HISTORY THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.INTERNAL_ERROR,
    SPROC_NAME, 'Could not create history', EXCEPTION_MESSAGE);
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END CREATE_INVOICE_ADJ_HISTORY;

END PROCS_HISTORY_V18;
.
/

CREATE OR REPLACE PACKAGE BODY "PROCS_ITUNES_RECEIPT_V18" AS

PROCEDURE ITUNES_RECEIPT_SUBSCRIPTION (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/ 
  in_original_transaction_id IN ITUNES_RECEIPT.ORIGINAL_TRANSACTION_ID%TYPE,
  out_result_set      OUT SYS_REFCURSOR
) AS
SPROC_NAME CONSTANT VARCHAR2(28) := 'ITUNES_RECEIPT_SUBSCRIPTION';
BEGIN
OPEN out_result_set FOR
	SELECT 
	i.id as ITUNES_RECEIPT_ID,
	s.id as SUBSCRIPTION_ID,
	s.SUBSCRIPTION_STATUS_ID, 
	i.STATUS, 
	a.GROUP_ID
	FROM ITUNES_RECEIPT i, SUBSCRIPTION s, ACCOUNT a
	WHERE i.ORIGINAL_TRANSACTION_ID = in_original_transaction_id
	AND s.ID(+) = i.SUBSCRIPTION_ID
	AND a.ID(+) = s.ACCOUNT_ID;
END ITUNES_RECEIPT_SUBSCRIPTION;


PROCEDURE CREATE_RECEIPT(
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
    out_id      OUT NUMBER,
    in_subscription_id  IN ITUNES_RECEIPT.SUBSCRIPTION_ID%TYPE,
    in_receipt          IN ITUNES_RECEIPT.RECEIPT%TYPE,
    in_status           IN ITUNES_RECEIPT.STATUS%TYPE,
    in_quantity         IN ITUNES_RECEIPT.QUANTITY%TYPE,
    in_product_id       IN ITUNES_RECEIPT.PRODUCT_ID%TYPE,
    in_transaction_id   IN ITUNES_RECEIPT.TRANSACTION_ID%TYPE,
    in_purchase_date    IN ITUNES_RECEIPT.PURCHASE_DATE%TYPE,
    in_original_transaction_id IN ITUNES_RECEIPT.ORIGINAL_TRANSACTION_ID%TYPE,
    in_original_purchase_date IN ITUNES_RECEIPT.ORIGINAL_PURCHASE_DATE%TYPE,
    in_app_item_id      IN ITUNES_RECEIPT.APP_ITEM_ID%TYPE,
    in_version_external_id IN ITUNES_RECEIPT.VERSION_EXTERNAL_ID%TYPE,
    in_bid              IN ITUNES_RECEIPT.BID%TYPE,
    in_bvrs             IN ITUNES_RECEIPT.BVRS%TYPE,
    in_expires_date     IN ITUNES_RECEIPT.EXPIRES_DATE%TYPE,
    in_created_by       IN ITUNES_RECEIPT.CREATED_BY%TYPE
) AS
-- VARIABLES
SPROC_NAME         CONSTANT VARCHAR2(14) := 'CREATE_RECEIPT';
-- EXCEPTIONS
EXCEPTION_MESSAGE      VARCHAR2(1024);
BEGIN

  CORE_OWNER.PROCS_ITUNES_RECEIPT_CRU_V18.CREATE_RECEIPT(
    out_id              =>  out_id,
    in_subscription_id  =>  in_subscription_id,
    in_receipt          =>  in_receipt,
    in_status           =>  in_status,
    in_quantity         =>  in_quantity,
    in_product_id       =>  in_product_id,
    in_transaction_id   =>  in_transaction_id,
    in_purchase_date    =>  in_purchase_date,
    in_original_transaction_id  =>  in_original_transaction_id,
    in_original_purchase_date => in_original_purchase_date,
    in_app_item_id      =>  in_app_item_id,
    in_version_external_id  =>  in_version_external_id,
    in_bid              =>  in_bid,
    in_bvrs             =>  in_bvrs,
    in_expires_date     =>  in_expires_date,
    in_created_by       =>  in_created_by
  );

END CREATE_RECEIPT;

PROCEDURE UPDATE_RECEIPT(
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
    in_id               IN ITUNES_RECEIPT.ID%TYPE,
    in_receipt          IN ITUNES_RECEIPT.RECEIPT%TYPE,
    in_status           IN ITUNES_RECEIPT.STATUS%TYPE,
    in_quantity         IN ITUNES_RECEIPT.QUANTITY%TYPE,
    in_product_id       IN ITUNES_RECEIPT.PRODUCT_ID%TYPE,
    in_transaction_id   IN ITUNES_RECEIPT.TRANSACTION_ID%TYPE,
    in_purchase_date    IN ITUNES_RECEIPT.PURCHASE_DATE%TYPE,
    in_original_transaction_id IN ITUNES_RECEIPT.ORIGINAL_TRANSACTION_ID%TYPE,
    in_original_purchase_date IN ITUNES_RECEIPT.ORIGINAL_PURCHASE_DATE%TYPE,
    in_app_item_id      IN ITUNES_RECEIPT.APP_ITEM_ID%TYPE,
    in_version_external_id IN ITUNES_RECEIPT.VERSION_EXTERNAL_ID%TYPE,
    in_bid              IN ITUNES_RECEIPT.BID%TYPE,
    in_bvrs             IN ITUNES_RECEIPT.BVRS%TYPE,
    in_expires_date     IN ITUNES_RECEIPT.EXPIRES_DATE%TYPE,
    in_updated_by       IN ITUNES_RECEIPT.UPDATED_BY%TYPE,
    in_is_expired       IN NUMBER
) AS
CANCEL_DATE DATE;
BEGIN
  -- see if cancel date is already set
  BEGIN
    SELECT
      IR.CANCEL_DATE INTO CANCEL_DATE
    FROM
      ITUNES_RECEIPT IR
    WHERE
      IR.ID = in_id;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      CANCEL_DATE := NULL;
  END;

  -- only update cancel date if it isn't already set and the receipt is expired
  IF in_is_expired = 1 THEN
    IF CANCEL_DATE IS NULL THEN
      CANCEL_DATE := SYSDATE;
    END IF;
  ELSE
    CANCEL_DATE := NULL;
  END IF;

  CORE_OWNER.PROCS_ITUNES_RECEIPT_CRU_V18.UPDATE_RECEIPT(
    in_id => in_id,
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
    in_updated_by => in_updated_by,
    in_cancel_date => CANCEL_DATE
  );
END UPDATE_RECEIPT;

PROCEDURE LINK_ITUNES_RECEIPT(
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
    in_id               IN ITUNES_RECEIPT.ID%TYPE,
    in_subscription_id  IN ITUNES_RECEIPT.SUBSCRIPTION_ID%TYPE,
    in_updated_by       IN ITUNES_RECEIPT.UPDATED_BY%TYPE
) AS
BEGIN
	CORE_OWNER.PROCS_ITUNES_RECEIPT_CRU_V18.LINK_ITUNES_RECEIPT(
		in_id => in_id,
		in_subscription_id => in_subscription_id,
		in_updated_by => in_updated_by
		);
END LINK_ITUNES_RECEIPT;

PROCEDURE MARK_RECEIPT_CHECKED(
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
    in_id       IN ITUNES_RECEIPT.ID%TYPE
) AS
BEGIN
  CORE_OWNER.PROCS_ITUNES_RECEIPT_CRU_V18.MARK_RECEIPT_CHECKED(
    in_id => in_id
  );
END MARK_RECEIPT_CHECKED;

PROCEDURE GET_ITUNES_RECEIPTS (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  out_result_set      OUT SYS_REFCURSOR,
  in_row_number       IN NUMBER DEFAULT 500
) AS
SPROC_NAME CONSTANT VARCHAR2(26) := 'GET_ITUNES_RECEIPTS';
BEGIN
OPEN out_result_set FOR
SELECT * FROM
(
  SELECT * FROM
  (
    SELECT
      IR.ID,
      IR.SUBSCRIPTION_ID,
      IR.RECEIPT,
      IR.STATUS,
      IR.QUANTITY,
      IR.PRODUCT_ID,
      IR.TRANSACTION_ID,
      IR.PURCHASE_DATE,
      IR.ORIGINAL_TRANSACTION_ID,
      IR.ORIGINAL_PURCHASE_DATE,
      IR.APP_ITEM_ID,
      IR.VERSION_EXTERNAL_ID,
      IR.BID,
      IR.BVRS,
      IR.EXPIRES_DATE,
      IR.CREATE_DATe,
      IR.CREATED_BY,
      IR.UPDATE_DATE,
      IR.UPDATED_BY,
      IR.LAST_CHECK_DATE,
      OC.VENDOR_SOURCE_ID
    FROM
      CORE_OWNER.ITUNES_RECEIPT IR
      LEFT JOIN CORE_OWNER.SUBSCRIPTION S ON IR.subscription_id = S.id
      LEFT JOIN CORE_OWNER.OFFER_CHAIN OC ON S.offer_chain_id = OC.id
    WHERE
      NOT EXISTS
      (
        SELECT NULL
        FROM PROCESS_RETRY_THROTTLE
        WHERE PROCESS_NAME = SPROC_NAME
          AND GENERIC_ID = IR.ID
      ) AND
      (S.subscription_status_id in (GLOBAL_STATUSES_V18.SUBSCRIPTION_SUSPENDED, GLOBAL_STATUSES_V18.SUBSCRIPTION_ACTIVE) or (S.subscription_status_id is null and IR.status != 21006)) AND
      ROWNUM <= in_row_number*10
  )
  ORDER BY dbms_random.value
) 
WHERE
  ROWNUM <= in_row_number;

END GET_ITUNES_RECEIPTS;

PROCEDURE GET_VENDOR_FROM_ITUNES_PID(
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
    out_vendor_source_id OUT OFFER_CHAIN.VENDOR_SOURCE_ID%TYPE,
    in_itunes_pid        IN ITUNES_RECEIPT.PRODUCT_ID%TYPE
) AS
BEGIN

SELECT
    oc.vendor_source_id
INTO
    out_vendor_source_id
FROM
    offer_chain_meta_data ocmd
JOIN
    offer_chain oc
ON
    ocmd.offer_chain_id = oc.id
WHERE
    ocmd.name = 'ITUNES_PRODUCT_ID'
AND ocmd.value = in_itunes_pid
AND rownum <= 1;

END GET_VENDOR_FROM_ITUNES_PID;

END PROCS_ITUNES_RECEIPT_V18;
.
/

CREATE OR REPLACE PACKAGE BODY "PROCS_LINE_ITEMS_V18" AS

PROCEDURE ADD_LINE_ITEMS(
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_invoice_id IN NUMBER,
  in_offer_id   IN NUMBER,
  in_created_by IN VARCHAR2
) AS
-- VARIABLES
SPROC_NAME      CONSTANT VARCHAR2(14) := 'ADD_LINE_ITEMS';
temp_invoice_id NUMBER;
temp_offer_id   NUMBER;

var_line_item_data SYS_REFCURSOR;
var_new_line_item_id NUMBER;
var_product_unit_price NUMBER (10,6);
var_product_offering_price NUMBER(10,6);
var_product_offering_oprice NUMBER(10,6);
var_product_quantity NUMBER;
var_product_offering_id NUMBER;

var_line_item_price         NUMBER(10,2);
var_discount_fixed_amount   NUMBER(10,6);
var_discount_percent_amount NUMBER(10,2);


-- EXCEPTIONS
BAD_INVOICE_ID EXCEPTION;
BAD_OFFER_ID EXCEPTION;
BAD_DISCOUNT EXCEPTION;
BEGIN

  -- Check that given invoice exists
  BEGIN
    SELECT
      INVOICE.ID into temp_invoice_id
    FROM
      INVOICE
    WHERE
      INVOICE.ID = in_invoice_id;
      
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE BAD_INVOICE_ID;
  END;
  
  -- Check that given offer exists
  BEGIN
    SELECT
      OFFER.ID into temp_offer_id
    FROM
      OFFER
    WHERE
      OFFER.ID = in_offer_id;
      
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE BAD_OFFER_ID;
  END;

  -- Get product_offering data  
  OPEN var_line_item_data FOR
  SELECT
    PRODUCT_OFFERING.ID,
    PRODUCT_OFFERING.UNIT_PRICE,
    PRODUCT_OFFERING.QUANTITY
  FROM
    OFFER_PRODUCT_OFFERING
    INNER JOIN PRODUCT_OFFERING ON OFFER_PRODUCT_OFFERING.PRODUCT_OFFERING_ID = PRODUCT_OFFERING.ID
  WHERE
    OFFER_PRODUCT_OFFERING.OFFER_ID = in_offer_id;
  
  -- insert line items
  -- add discounts to line items
  LOOP
    FETCH var_line_item_data INTO
      var_product_offering_id,
      var_product_unit_price,
      var_product_quantity;
    EXIT WHEN var_line_item_data%NOTFOUND;

    var_product_offering_oprice := var_product_unit_price * var_product_quantity;
    var_product_offering_price := var_product_offering_oprice;

    -- Apply discounts to line_item
    BEGIN
      SELECT
        SUM (DISCOUNT.FIXED_AMOUNT) into var_discount_fixed_amount
      FROM
        DISCOUNT_PRODUCT_OFFERING
        INNER JOIN DISCOUNT ON DISCOUNT_PRODUCT_OFFERING.DISCOUNT_ID = DISCOUNT.ID
      WHERE
        DISCOUNT_PRODUCT_OFFERING.PRODUCT_OFFERING_ID = var_product_offering_id
        AND DISCOUNT.FIXED_AMOUNT IS NOT NULL;
      EXCEPTION
      WHEN NO_DATA_FOUND THEN
        var_discount_fixed_amount := NULL;
    END;
      
    BEGIN
      SELECT
        SUM (DISCOUNT.PERCENT_AMOUNT) into var_discount_percent_amount
      FROM
        DISCOUNT_PRODUCT_OFFERING
        INNER JOIN DISCOUNT ON DISCOUNT_PRODUCT_OFFERING.DISCOUNT_ID = DISCOUNT.ID
      WHERE
        DISCOUNT_PRODUCT_OFFERING.PRODUCT_OFFERING_ID = var_product_offering_id
        AND DISCOUNT.PERCENT_AMOUNT IS NOT NULL;
      EXCEPTION
      WHEN NO_DATA_FOUND THEN
        var_discount_percent_amount := NULL;
    END;
      
    IF (var_discount_percent_amount IS NOT NULL) THEN
      var_product_offering_price := var_product_offering_price * ( 1 - var_discount_percent_amount / 100 );
    END IF;
    
    IF (var_discount_fixed_amount IS NOT NULL) THEN
      var_product_offering_price := var_product_offering_price - var_discount_fixed_amount;
    END IF;
    
    var_line_item_price := PROCS_COMMON_V18.ROUND_10_6_TO_10_2(var_product_offering_price);

    IF (var_line_item_price < 0) THEN
        RAISE BAD_DISCOUNT;
    END IF;

    var_new_line_item_id := NULL;
    PROCS_LINE_ITEMS_CRU_V18.CREATE_LINE_ITEM(
      inout_line_item_id  => var_new_line_item_id,
      in_product_offer_id => var_product_offering_id,
      in_invoice_id       => in_invoice_id,
      in_amount           => var_line_item_price,
      in_created_by       => in_created_by,
      in_discount_amount  => var_product_offering_oprice - var_line_item_price,
      in_taxes_amount     => NULL
    );

    FOR f_discount IN (
      SELECT
        DISCOUNT.ID
      FROM
        DISCOUNT_PRODUCT_OFFERING
        INNER JOIN DISCOUNT ON DISCOUNT_PRODUCT_OFFERING.DISCOUNT_ID = DISCOUNT.ID
      WHERE
        DISCOUNT_PRODUCT_OFFERING.PRODUCT_OFFERING_ID = var_product_offering_id
    )
    LOOP
      PROCS_LINE_ITEMS_CRU_V18.CREATE_DISCOUNT_LINE_ITEM(
        in_discount_id =>  f_discount.ID,
        in_line_item_id => var_new_line_item_id
      );
    END LOOP;
  END LOOP;

EXCEPTION
WHEN BAD_INVOICE_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'No such license');
WHEN BAD_OFFER_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'No such offer');
WHEN BAD_DISCOUNT THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Bad Discount');
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END ADD_LINE_ITEMS;

/******************************************************************************/

PROCEDURE UPDATE_LINE_ITEM_AMOUNT (
  in_line_item_id    IN NUMBER,
  in_amount          IN NUMBER,
  in_discount_amount IN NUMBER,
  in_taxes_amount    IN NUMBER
) AS
SPROC_NAME CONSTANT VARCHAR2(24) := 'UPDATE_LINE_ITEM_AMOUNTS';
-- VARIABLES
temp_line_item_id NUMBER;
-- EXCEPTIONS
BAD_LINE_ITEM_ID EXCEPTION;
BEGIN
  
  -- Check that line item exists
  BEGIN
    SELECT
      LINE_ITEM.ID into temp_line_item_id
    FROM
      LINE_ITEM
    WHERE
      LINE_ITEM.ID = in_line_item_id;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE BAD_LINE_ITEM_ID;
  END;
  
  -- Update line item
  PROCS_LINE_ITEMS_CRU_V18.UPDATE_LINE_ITEM(
    in_line_item_id    => in_line_item_id,
    in_amount          => in_amount,
    in_discount_amount => in_discount_amount,
    in_taxes_amount    => in_taxes_amount
  );
  
EXCEPTION
WHEN BAD_LINE_ITEM_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'No such line item');
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END UPDATE_LINE_ITEM_AMOUNT;

/******************************************************************************/

PROCEDURE GET_INVOICE_LINE_ITEMS (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_invoice_id  IN NUMBER,
  out_result_set OUT SYS_REFCURSOR
) AS
-- VARIABLES
SPROC_NAME      CONSTANT VARCHAR2(22) := 'GET_INVOICE_LINE_ITEMS';
temp_invoice_id NUMBER;

-- EXCEPTIONS
BAD_INVOICE_ID EXCEPTION;
BEGIN

  -- Check that given invoice exists
  BEGIN
    SELECT
      INVOICE.ID into temp_invoice_id
    FROM
      INVOICE
    WHERE
      INVOICE.ID = in_invoice_id;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE BAD_INVOICE_ID;
  END;

  -- Select line items
  OPEN out_result_set FOR
  SELECT
    LINE_ITEM.ID,
    LINE_ITEM.AMOUNT,
    LINE_ITEM.CREATE_DATE,
    LINE_ITEM.CREATED_BY,
    LINE_ITEM.INVOICE_ID,
    LINE_ITEM.DISCOUNT_AMOUNT,
    LINE_ITEM.TAXES_AMOUNT,
    LINE_ITEM.PRODUCT_OFFER_ID
  FROM
    LINE_ITEM
  WHERE
    LINE_ITEM.INVOICE_ID = in_invoice_id;

EXCEPTION
WHEN BAD_INVOICE_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'No such invoice');
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END GET_INVOICE_LINE_ITEMS;

/******************************************************************************/

PROCEDURE GET_LINE_ITEM_TAXES (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_line_item_id IN  NUMBER,
  out_result_set  OUT SYS_REFCURSOR
) AS
-- VARIABLES
SPROC_NAME        CONSTANT VARCHAR2(19) := 'GET_LINE_ITEM_TAXES';
temp_line_item_id NUMBER;
-- EXCEPTIONS
BAD_LINE_ITEM_ID EXCEPTION;
BEGIN
  
  -- Check that line item exists
  BEGIN
    SELECT
      LINE_ITEM.ID into temp_line_item_id
    FROM
      LINE_ITEM
    WHERE
      LINE_ITEM.ID = in_line_item_id;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE BAD_LINE_ITEM_ID;
  END;
  
  -- Get all taxes for given line item
  OPEN out_result_set FOR
  SELECT
    TAX.ID,
    TAX.CALCULATED_AMOUNT,
    TAX.CREATE_DATE,
    TAX.CREATED_BY,
    TAX.EFFECTIVE_RATE,
    TAX.EXT_RESULT,
    TAX.EXT_TAX_TYPE,
    TAX.IMPOSITION,
    TAX.IMPOSITION_TYPE,
    TAX.JURISDICTION_ID,
    TAX.JURISDICTION_LEVEL_ID,
    TAX.JURISDICTION_NAME,
    TAX.LINE_ITEM_ID,
    TAX.TAX_RULE_ID,
    TAX.TAX_TYPE_ID,
    TAX.TAXABLE_AMOUNT    
  FROM
    TAX
  WHERE
    TAX.LINE_ITEM_ID = in_line_item_id;

EXCEPTION
WHEN BAD_LINE_ITEM_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'No such line item');
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END GET_LINE_ITEM_TAXES;

-- norlov: #38770
PROCEDURE GET_LINE_ITEM_DISCOUNTS (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_line_item_id IN  NUMBER,
  out_result_set  OUT SYS_REFCURSOR
) AS
-- VARIABLES
SPROC_NAME        CONSTANT VARCHAR2(23) := 'GET_LINE_ITEM_DISCOUNTS';
temp_line_item_id NUMBER;
-- EXCEPTIONS
BAD_LINE_ITEM_ID EXCEPTION;
BEGIN
  
  -- Check that line item exists
  BEGIN
    SELECT
      LINE_ITEM.ID into temp_line_item_id
    FROM
      LINE_ITEM
    WHERE
      LINE_ITEM.ID = in_line_item_id;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE BAD_LINE_ITEM_ID;
  END;
  
  -- Get all discounts for given line item
  OPEN out_result_set FOR
  SELECT
    DISCOUNT.FIXED_AMOUNT,
    DISCOUNT.NAME,
    DISCOUNT.ID,
    DISCOUNT.PERCENT_AMOUNT
  FROM
    DISCOUNT_LINE_ITEM
    INNER JOIN DISCOUNT ON DISCOUNT_LINE_ITEM.DISCOUNT_ID = DISCOUNT.ID
  WHERE
    DISCOUNT_LINE_ITEM.LINE_ITEM_ID = in_line_item_id;

EXCEPTION
WHEN BAD_LINE_ITEM_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'No such line item');
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END GET_LINE_ITEM_DISCOUNTS;
/******************************************************************************/

PROCEDURE CALCULATE_LINE_ITEM_AMOUNT (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_line_item_id     IN  NUMBER,
  out_amount          OUT NUMBER
) AS
-- VARIABLES
SPROC_NAME CONSTANT VARCHAR2(26) := 'CALCULATE_LINE_ITEM_AMOUNT';
-- EXCEPTIONS
BAD_LINE_ITEM_ID EXCEPTION;
BEGIN

  BEGIN
    SELECT
      LINE_ITEM.AMOUNT into out_amount
    FROM
      LINE_ITEM
    WHERE
      LINE_ITEM.ID = in_line_item_id;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE BAD_LINE_ITEM_ID;
  END;

EXCEPTION
WHEN BAD_LINE_ITEM_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'No such line item');
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END CALCULATE_LINE_ITEM_AMOUNT;

/******************************************************************************/

FUNCTION F_CALCULATE_LINE_ITEM_AMOUNT (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_line_item_id     IN  NUMBER
) RETURN NUMBER AS
var_invoice_amount NUMBER(10, 2);
BEGIN
  PROCS_LINE_ITEMS_V18.CALCULATE_LINE_ITEM_AMOUNT(in_line_item_id, var_invoice_amount);
  RETURN var_invoice_amount;
END F_CALCULATE_LINE_ITEM_AMOUNT;

END PROCS_LINE_ITEMS_V18;
.
/

CREATE OR REPLACE PACKAGE BODY "PROCS_LOCKING_V18" AS

/*
PROCEDURE INITIALIZE_SYSTEM AS
SPROC_NAME CONSTANT VARCHAR2(17) := 'INITIALIZE_SYSTEM';
-- VARIABLES
var_account_ids SYS_REFCURSOR;
var_account_id  NUMBER;
BEGIN

  OPEN var_account_ids FOR
  SELECT
    ACCOUNT.ID
  FROM
    ACCOUNT;
    
  LOOP
    FETCH var_account_ids into var_account_id;
    EXIT WHEN var_account_ids%NOTFOUND;
    BEGIN
      INITIALIZE_ACCOUNT(var_account_id);
      EXCEPTION
        WHEN OTHERS THEN
          NULL;
    END;
  END LOOP;

END INITIALIZE_SYSTEM;

PROCEDURE INITIALIZE_ACCOUNT (
  in_account_id IN NUMBER
) AS
SPROC_NAME CONSTANT VARCHAR2(18) := 'INITIALIZE_ACCOUNT';
-- EXCEPTIONS
ACCOUNT_ALREADY_INITIALIZED EXCEPTION;
BEGIN

  BEGIN
    INSERT INTO ACCOUNT_LOCK(
      ACCOUNT_ID,
      LOCK_KEY,
      END_DATE,
      CREATED_BY,
      REASON
    ) VALUES (
      in_account_id,
      'initialization key',
      SYSDATE,
      'system',
      'initialization'
    );
    EXCEPTION
      WHEN DUP_VAL_ON_INDEX THEN
        RAISE ACCOUNT_ALREADY_INITIALIZED;
  END;

EXCEPTION
WHEN ACCOUNT_ALREADY_INITIALIZED THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.STATE_ERROR,
    SPROC_NAME, 'Account already initialized');
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'Unknown error', SQLERRM);
END;

PROCEDURE INITIALIZE_GROUP (
  in_group_id IN NUMBER
) AS
SPROC_NAME CONSTANT VARCHAR2(16) := 'INITIALIZE_GROUP';
-- VARIABLES
var_account_id NUMBER;
-- EXCEPTIONS
BAD_GROUP_ID              EXCEPTION;
GROUP_ALREADY_INITIALIZED EXCEPTION;
BEGIN
  
  BEGIN
    SELECT
      ACCOUNT.ID into var_account_id
    FROM
      ACCOUNT
    WHERE
      ACCOUNT.GROUP_ID = in_group_id;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
       RAISE BAD_GROUP_ID;
  END;
  
  BEGIN
    INSERT INTO ACCOUNT_LOCK (
      ACCOUNT_ID,
      LOCK_KEY,
      END_DATE,
      CREATED_BY,
      REASON
    ) VALUES (
      var_account_id,
      'initialization key',
      SYSDATE,
      'system',
      'initialization'
    );
    EXCEPTION
      WHEN DUP_VAL_ON_INDEX THEN
        RAISE GROUP_ALREADY_INITIALIZED;
  END;

EXCEPTION
WHEN BAD_GROUP_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'No such account with given group id');
WHEN GROUP_ALREADY_INITIALIZED THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.STATE_ERROR,
    SPROC_NAME, 'Group already initialized');
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'Unknown error', SQLERRM);
END INITIALIZE_GROUP;
*/

PROCEDURE LOCK_ACCOUNT (
  in_group_id    IN NUMBER,
  in_lock_key    IN VARCHAR2,
  in_seconds_num IN NUMBER,
  in_created_by  IN VARCHAR2,
  in_reason      IN VARCHAR2
) AS
SPROC_NAME CONSTANT VARCHAR2(12) := 'LOCK_ACCOUNT';
-- CONSTANTS
one_second_interval CONSTANT INTERVAL DAY TO SECOND := INTERVAL '0 00:00:01' DAY TO SECOND;
-- VARIABLES
var_account_id NUMBER;
-- arosolovskiy: using data variable instead of direct get data calls (#38860)
var_date          DATE := SYSDATE;
var_lock_end_date DATE;
-- EXCEPTIONS
BAD_GROUP_ID   EXCEPTION;
ALREADY_LOCKED EXCEPTION;
BEGIN

  BEGIN
    SELECT
      ACCOUNT.ID into var_account_id
    FROM
      ACCOUNT
    WHERE
      ACCOUNT.GROUP_ID = in_group_id;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE BAD_GROUP_ID;
  END;
  
  var_lock_end_date := var_date + ( in_seconds_num * one_second_interval );
  
  BEGIN
    
    INSERT INTO ACCOUNT_LOCK (
      ACCOUNT_ID,
      LOCK_KEY,
      END_DATE,
      CREATED_BY,
      REASON
    ) VALUES (
      var_account_id,
      in_lock_key,
      var_lock_end_date,
      in_created_by,
      in_reason
    );
    
    EXCEPTION
      WHEN DUP_VAL_ON_INDEX THEN
        -- This rows was created before... I will try to update it
        BEGIN
        
          UPDATE
            ACCOUNT_LOCK
          SET
            ACCOUNT_LOCK.LOCK_KEY = in_lock_key,
            ACCOUNT_LOCK.END_DATE = var_lock_end_date,
            ACCOUNT_LOCK.CREATED_BY = in_created_by,
            ACCOUNT_LOCK.REASON = in_reason
          WHERE
            ACCOUNT_LOCK.ACCOUNT_ID = var_account_id
            AND ACCOUNT_LOCK.END_DATE <= var_date;
            
          IF SQL%ROWCOUNT = 0 THEN
            RAISE ALREADY_LOCKED;
          END IF;
          
        END;
  END;

EXCEPTION
WHEN BAD_GROUP_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'No such group id');
WHEN ALREADY_LOCKED THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.STATE_ERROR,
    SPROC_NAME, 'Account already locked');
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END LOCK_ACCOUNT;

/******************************************************************************/

PROCEDURE RELEASE_LOCK (
  in_group_id IN NUMBER,
  in_lock_key IN VARCHAR2
) AS
SPROC_NAME CONSTANT VARCHAR2(12) := 'RELEASE_LOCK';
-- VARIABLES
var_account_id NUMBER;
-- arosolovskiy: using data variable instead of direct get data calls (#38860)
var_date DATE := SYSDATE;
-- EXCEPTIONS
BAD_GROUP_ID              EXCEPTION;
COULD_NOT_RELEASE_ACCOUNT EXCEPTION;
BEGIN

  BEGIN
    SELECT
      ACCOUNT.ID into var_account_id
    FROM
      ACCOUNT
    WHERE
      ACCOUNT.GROUP_ID = in_group_id;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE BAD_GROUP_ID;
  END;
  
  UPDATE
    ACCOUNT_LOCK
  SET
    ACCOUNT_LOCK.END_DATE = var_date
  WHERE
    ACCOUNT_LOCK.ACCOUNT_ID = var_account_id
    -- AND ACCOUNT_LOCK.END_DATE > var_date
    AND ACCOUNT_LOCK.LOCK_KEY = in_lock_key;
    
  IF SQL%ROWCOUNT = 0 THEN
    RAISE COULD_NOT_RELEASE_ACCOUNT;
  END IF;

EXCEPTION
WHEN BAD_GROUP_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'No such group id');
WHEN COULD_NOT_RELEASE_ACCOUNT THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.STATE_ERROR,
    SPROC_NAME, 'Could not release account. Maybe you are not owner of this lock, or lock is expired');
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error');
END RELEASE_LOCK;

END PROCS_LOCKING_V18;
.
/

CREATE OR REPLACE PACKAGE BODY "PROCS_OFFER_CHAIN_V18" AS

PROCEDURE GET_OFFER_CHAIN_BY_ID (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
    in_offer_chain_id IN   NUMBER,
    out_result_set    OUT  SYS_REFCURSOR
) AS
SPROC_NAME CONSTANT VARCHAR2(21) := 'GET_OFFER_CHAIN_BY_ID';
BEGIN

  -- Get offer chain informations
  OPEN out_result_set FOR
    SELECT
      OC.ID,
      OC.NAME,
      OC.ADOPTABILITY_WINDOW_START_DATE,
      OC.ADOPTABILITY_WINDOW_END_DATE,
      OC.DESCRIPTION,
      OC.IS_GIFT_CERTIFICATE,
      OC.OFFER_CHAIN_STATUS_ID,
      OC.PRODUCT_URI,
      OC.BILLING_SOURCE_ID,
      OC.VENDOR_SOURCE_ID,
      OC.GROUP_ACCOUNT_TYPE_ID,
      DECODE(OC.IS_ADDRESS_REQUIRED,1,'true','false') IS_ADDRESS_REQUIRED
    FROM 
      OFFER_CHAIN OC
    WHERE
      OC.ID = in_offer_chain_id
      AND ROWNUM <= 1;

EXCEPTION
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END GET_OFFER_CHAIN_BY_ID;

/******************************************************************************/

PROCEDURE GET_OFFER_CHAINS_BY_IDS (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
APP_EXCEPTION_CODES_V18.INVALID_PARAMETER
*/
  in_offer_chain_ids IN core_owner.NUMBER_TABLE,
  out_result_set     OUT SYS_REFCURSOR
) AS
SPROC_NAME CONSTANT VARCHAR2(23) := 'GET_OFFER_CHAINS_BY_IDS';
-- EXCEPTIONS
BAD_OFFER_CHAINS_IDS EXCEPTION;
BEGIN

  IF (in_offer_chain_ids IS NULL) THEN
    RAISE BAD_OFFER_CHAINS_IDS;
  END IF;

  OPEN out_result_set FOR
  SELECT
    OCH.ID,
    OCH.NAME,
    OCH.DESCRIPTION,
    OCH.OFFER_CHAIN_STATUS_ID,
    OCH.ADOPTABILITY_WINDOW_START_DATE,
    OCH.ADOPTABILITY_WINDOW_END_DATE,
    OCH.IS_GIFT_CERTIFICATE,
    PROCS_OFFER_CHAIN_V18.CALCULATE_OFFER_CHAIN_AMOUNT(OCH.ID) AS PRICE,
    PROCS_OFFER_CHAIN_V18.IS_OFFER_CHAIN_CANCELABLE(OCH.ID) AS IS_CANCELABLE,
    OCH.VENDOR_SOURCE_ID,
    DECODE(OCH.IS_ADDRESS_REQUIRED,1,'true','false') IS_ADDRESS_REQUIRED
  FROM
    OFFER_CHAIN OCH
  WHERE
    OCH.ID IN (SELECT * FROM TABLE(in_offer_chain_ids));

EXCEPTION
WHEN BAD_OFFER_CHAINS_IDS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.INVALID_PARAMETER,
    SPROC_NAME, 'Invalid offer chains ids');
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END GET_OFFER_CHAINS_BY_IDS;

/******************************************************************************/

PROCEDURE GET_OFFER_CHAINS_PRODUCTS (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
APP_EXCEPTION_CODES_V18.INVALID_PARAMETER
*/
  in_offer_chain_ids IN core_owner.NUMBER_TABLE,
  out_result_set     OUT SYS_REFCURSOR
) AS
SPROC_NAME CONSTANT VARCHAR2(25) := 'GET_OFFER_CHAINS_PRODUCTS';
-- EXCEPTIONS
BAD_OFFER_CHAINS_IDS EXCEPTION;
BEGIN

  IF (in_offer_chain_ids IS NULL) THEN
    RAISE BAD_OFFER_CHAINS_IDS;
  END IF;

  OPEN out_result_set FOR
  SELECT
    OOCH.OFFER_CHAIN_ID,
    PO.PRODUCT_ID
  FROM
    PRODUCT_OFFERING PO
    INNER JOIN OFFER_PRODUCT_OFFERING OPO ON OPO.PRODUCT_OFFERING_ID = PO.ID
    INNER JOIN OFFER_OFFER_CHAIN OOCH ON OOCH.OFFER_ID = OPO.OFFER_ID
  WHERE
    OOCH.OFFER_CHAIN_ID IN (SELECT * FROM TABLE (in_offer_chain_ids));

EXCEPTION
WHEN BAD_OFFER_CHAINS_IDS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.INVALID_PARAMETER,
    SPROC_NAME, 'Invalid offer chains ids');
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END GET_OFFER_CHAINS_PRODUCTS;

/******************************************************************************/

PROCEDURE GET_OFFER_CHAINS_OFFERS (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
APP_EXCEPTION_CODES_V18.INVALID_PARAMETER
*/
  in_offer_chain_ids IN core_owner.NUMBER_TABLE,
  out_result_set     OUT SYS_REFCURSOR
) AS
SPROC_NAME CONSTANT VARCHAR2(23) := 'GET_OFFER_CHAINS_OFFERS';
-- EXCEPTIONS
BAD_OFFER_CHAINS_IDS EXCEPTION;
BEGIN

  IF (in_offer_chain_ids IS NULL) THEN
    RAISE BAD_OFFER_CHAINS_IDS;
  END IF;

  OPEN out_result_set FOR
  SELECT
    OOCH.OFFER_CHAIN_ID,
    OOCH.OFFER_ID,
    OOCH.INDEX_VALUE,
    OOCH.NUM_RECURRENCES,
    O.ENTITLEMENT_DURATION,
    PROCS_OFFER_CHAIN_V18.CALCULATE_OFFER_AMOUNT(OOCH.OFFER_ID) AS PRICE
  FROM
    OFFER O
    INNER JOIN OFFER_OFFER_CHAIN OOCH ON OOCH.OFFER_ID = O.ID
  WHERE
    OOCH.OFFER_CHAIN_ID IN (SELECT * FROM TABLE (in_offer_chain_ids));

EXCEPTION
WHEN BAD_OFFER_CHAINS_IDS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.INVALID_PARAMETER,
    SPROC_NAME, 'Invalid offer chains ids');
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END GET_OFFER_CHAINS_OFFERS;

/******************************************************************************/

PROCEDURE GET_OFFER_CHAINS_BY_PRODUCT (
/*
Throws exceptions (codes):
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_product_id  IN  NUMBER,
  out_result_set OUT SYS_REFCURSOR
)AS
-- VARIBLES
SPROC_NAME      CONSTANT VARCHAR2(27) := 'GET_OFFER_CHAINS_BY_PRODUCT';
temp_product_id NUMBER;

-- EXCEPTIONS
BAD_PRODUCT_ID EXCEPTION;
BEGIN

  -- Check that given product exists
  BEGIN
    SELECT
      PRODUCT.ID into temp_product_id
    FROM
      PRODUCT
    WHERE
      PRODUCT.ID = in_product_id;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE BAD_PRODUCT_ID;
  END;

  -- Select all offer chains that contains given product
  OPEN out_result_set FOR
  SELECT
    OFFER_CHAIN.ID,
    OFFER_CHAIN.NAME,
    OFFER_CHAIN.DESCRIPTION,
    OFFER_CHAIN.ADOPTABILITY_WINDOW_START_DATE,
    OFFER_CHAIN.ADOPTABILITY_WINDOW_END_DATE,
    OFFER_CHAIN.OFFER_CHAIN_STATUS_ID,
    OFFER_CHAIN.IS_GIFT_CERTIFICATE
  FROM
    OFFER_CHAIN
  WHERE
    OFFER_CHAIN.ID IN (
      SELECT DISTINCT
        OFFER_OFFER_CHAIN.OFFER_CHAIN_ID
      FROM
        OFFER_OFFER_CHAIN
      WHERE
        OFFER_OFFER_CHAIN.OFFER_ID IN (
          SELECT DISTINCT
            OFFER_PRODUCT_OFFERING.OFFER_ID
          FROM
            OFFER_PRODUCT_OFFERING
          WHERE
            OFFER_PRODUCT_OFFERING.PRODUCT_OFFERING_ID = in_product_id
        )
    );

EXCEPTION
WHEN BAD_PRODUCT_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'No such product');
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END GET_OFFER_CHAINS_BY_PRODUCT;

/******************************************************************************/

PROCEDURE GET_OFFER_CHAIN_PRICE (
/*
Throws exceptions (codes):
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_offer_chain_id IN NUMBER,
  out_price         OUT NUMBER
) AS
-- VARIABLES
SPROC_NAME          CONSTANT VARCHAR2(21) := 'GET_OFFER_CHAIN_PRICE';
temp_offer_chain_id NUMBER;

-- EXCEPTION
BAD_OFFER_CHAIN_ID       EXCEPTION;
CAN_NOT_CALCULATE_AMOUNT EXCEPTION;
EXCEPTION_MESSAGE        VARCHAR2(1024);
BEGIN

  -- Check that given offer chain exists
  BEGIN
    SELECT
      OFFER_CHAIN.ID into temp_offer_chain_id
    FROM
      OFFER_CHAIN
    WHERE
      OFFER_CHAIN.ID = in_offer_chain_id;

    EXCEPTION
    WHEN NO_DATA_FOUND THEN
      RAISE BAD_OFFER_CHAIN_ID;
  END;

  BEGIN
    out_price := CALCULATE_OFFER_CHAIN_AMOUNT(in_offer_chain_id);
    EXCEPTION
      WHEN OTHERS THEN
        EXCEPTION_MESSAGE := SQLERRM;
        RAISE CAN_NOT_CALCULATE_AMOUNT;
  END;

EXCEPTION
WHEN BAD_OFFER_CHAIN_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'Bad offer chain id');
WHEN CAN_NOT_CALCULATE_AMOUNT THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.INTERNAL_ERROR,
    SPROC_NAME, 'Caould not calculate offer chain amount', EXCEPTION_MESSAGE);
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END GET_OFFER_CHAIN_PRICE;

/******************************************************************************/

PROCEDURE GET_FIRST_OFFER(
/*
Throws exceptions (codes):
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_offer_chain_id IN  NUMBER,
  out_offer_id      OUT NUMBER
) AS
SPROC_NAME CONSTANT VARCHAR2(15) := 'GET_FIRST_OFFER';
BEGIN
  -- Seect first offer in offer chain
  SELECT
    OFFER_ID into out_offer_id
  FROM (
    SELECT
      OFFER_OFFER_CHAIN.OFFER_ID
    FROM
      OFFER_OFFER_CHAIN
    WHERE
      OFFER_OFFER_CHAIN.OFFER_CHAIN_ID = in_offer_chain_id
    ORDER BY
      OFFER_OFFER_CHAIN.INDEX_VALUE ASC
  )
  WHERE
    ROWNUM <= 1;

EXCEPTION
WHEN NO_DATA_FOUND THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'No such offer chain');
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END GET_FIRST_OFFER;

/******************************************************************************/

PROCEDURE GET_ACTIVE_OFFER_CHAINS (
/*
Throws exceptions (codes):
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  out_result_set OUT SYS_REFCURSOR
) AS
SPROC_NAME CONSTANT VARCHAR2(23) := 'GET_ACTIVE_OFFER_CHAINS';
BEGIN
  OPEN out_result_set FOR
  SELECT
    OFFER_CHAIN.ID,
    OFFER_CHAIN.NAME,
    OFFER_CHAIN.DESCRIPTION,
    OFFER_CHAIN.ADOPTABILITY_WINDOW_START_DATE,
    OFFER_CHAIN.ADOPTABILITY_WINDOW_END_DATE,
    OFFER_CHAIN.OFFER_CHAIN_STATUS_ID,
    OFFER_CHAIN.IS_GIFT_CERTIFICATE,
    PROCS_OFFER_CHAIN_V18.IS_OFFER_CHAIN_CANCELABLE(OFFER_CHAIN.ID) AS "IS_CANCELABLE",
    PRODUCT_OFFERING.PRODUCT_ID
  FROM
    OFFER_CHAIN,
    OFFER_OFFER_CHAIN,
    OFFER_PRODUCT_OFFERING,
    PRODUCT_OFFERING
  WHERE
    OFFER_CHAIN.ID = OFFER_OFFER_CHAIN.OFFER_CHAIN_ID
    and OFFER_OFFER_CHAIN.OFFER_ID = OFFER_PRODUCT_OFFERING.OFFER_ID
    and OFFER_PRODUCT_OFFERING.PRODUCT_OFFERING_ID = PRODUCT_OFFERING.ID
    and OFFER_CHAIN.OFFER_CHAIN_STATUS_ID = GLOBAL_STATUSES_V18.OFFER_CHAIN_ACTIVE;

EXCEPTION
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END GET_ACTIVE_OFFER_CHAINS;

/******************************************************************************/

PROCEDURE GET_OFFER_CHAIN_PRODUCTS (
/*
Throws exceptions (codes):
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_offer_chain_id IN NUMBER,
  out_result_set    OUT SYS_REFCURSOR
) AS
-- VARIABLES
SPROC_NAME          CONSTANT VARCHAR2(24) := 'GET_OFFER_CHAIN_PRODUCTS';
temp_offer_chain_id NUMBER;

-- EXCEPTIONS
BAD_OFFER_CHAIN EXCEPTION;
BEGIN

  -- Check that offer chain exists
  BEGIN
    SELECT
      OFFER_CHAIN.ID into temp_offer_chain_id
    FROM
      OFFER_CHAIN
    WHERE
      OFFER_CHAIN.ID = in_offer_chain_id
      AND ROWNUM <= 1;

    EXCEPTION
      WHEN OTHERS THEN
        RAISE BAD_OFFER_CHAIN;
  END;

  -- Select all products for given offer chain
  OPEN out_result_set FOR
  SELECT DISTINCT
    PRODUCT_OFFERING.PRODUCT_ID
  FROM
    PRODUCT_OFFERING
  WHERE
    PRODUCT_OFFERING.ID IN (
      SELECT DISTINCT
        OFFER_PRODUCT_OFFERING.PRODUCT_OFFERING_ID
      FROM
        OFFER_PRODUCT_OFFERING
      WHERE
        OFFER_PRODUCT_OFFERING.OFFER_ID IN (
          SELECT
            OFFER_OFFER_CHAIN.OFFER_ID
          FROM
            OFFER_OFFER_CHAIN
          WHERE
            OFFER_OFFER_CHAIN.OFFER_CHAIN_ID = in_offer_chain_id
        )
    );

EXCEPTION
WHEN BAD_OFFER_CHAIN THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'No such offer chain');
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END GET_OFFER_CHAIN_PRODUCTS;

/******************************************************************************/

FUNCTION CALCULATE_OFFER_CHAIN_END_DATE (
/*
Throws exceptions (codes):
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_offer_chain_id         IN NUMBER,
  in_offer_chain_start_date IN DATE
) RETURN DATE AS
-- VARIABLES
SPROC_NAME             CONSTANT VARCHAR2(30) := 'CALCULATE_OFFER_CHAIN_END_DATE';
temp_offer_chain_id    NUMBER;
var_offer_chain_length NUMBER;
var_offer_duration     VARCHAR2(30);
var_offer_recurrences  NUMBER;
var_end_date           DATE;

var_offer_ym_interval INTERVAL YEAR TO MONTH;
var_offer_ds_interval INTERVAL DAY(3) TO SECOND;
var_offer_years       NUMBER;
var_offer_months      NUMBER;
var_offer_days        NUMBER;
var_infinity_offers_count NUMBER;

var_offers_set SYS_REFCURSOR;

-- EXCEPTIONS
BAD_OFFER_CHAIN_ID EXCEPTION;
BEGIN

  var_end_date := in_offer_chain_start_date;

  -- Check that offer chain exists
  BEGIN
    SELECT
      OFFER_CHAIN.ID into temp_offer_chain_id
    FROM
      OFFER_CHAIN
    WHERE
      OFFER_CHAIN.ID = in_offer_chain_id;
    EXCEPTION
      WHEN NO_DATA_FOUND
        THEN RAISE BAD_OFFER_CHAIN_ID;
  END;

  SELECT
    COUNT(*) into var_infinity_offers_count
  FROM
    OFFER_OFFER_CHAIN
  WHERE
    OFFER_OFFER_CHAIN.OFFER_CHAIN_ID = in_offer_chain_id
    AND OFFER_OFFER_CHAIN.NUM_RECURRENCES = GLOBAL_ENUMS_V18.OFFER_REC_INFINITY;

  IF var_infinity_offers_count > 0 THEN
    -- Offer chain contains offers with infinity num of recurrences
    RETURN NULL;
  END IF;

  -- Select offers durations
  OPEN var_offers_set FOR
  SELECT
    OFFER.ENTITLEMENT_DURATION,
    OFFER_OFFER_CHAIN.NUM_RECURRENCES
  FROM
    OFFER_OFFER_CHAIN
    INNER JOIN OFFER ON OFFER_OFFER_CHAIN.OFFER_ID = OFFER.ID
  WHERE
    OFFER_OFFER_CHAIN.OFFER_CHAIN_ID = in_offer_chain_id;

  -- Calculate sum of offers durations
  LOOP
    FETCH var_offers_set INTO var_offer_duration, var_offer_recurrences;
    EXIT WHEN var_offers_set%NOTFOUND;
    PROCS_COMMON_V18.ISO8601DURATION_TO_INTERVALS(var_offer_duration, var_offer_years, var_offer_months, var_offer_days);
    var_offer_ym_interval := var_offer_years||'-'||var_offer_months;
    var_offer_ds_interval := var_offer_days||' 0:0:0';
    var_end_date := var_end_date + ( var_offer_ym_interval * ( var_offer_recurrences + 1) ) + ( var_offer_ds_interval * ( var_offer_recurrences + 1) );
  END LOOP;

  RETURN var_end_date;

EXCEPTION
WHEN BAD_OFFER_CHAIN_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'No such offer chain');
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END CALCULATE_OFFER_CHAIN_END_DATE;

/******************************************************************************/

FUNCTION CALCULATE_OFFER_AMOUNT (
  in_offer_id IN NUMBER
) RETURN NUMBER AS
-- VARIABLES
SPROC_NAME    CONSTANT VARCHAR2(22) := 'CALCULATE_OFFER_AMOUNT';
temp_offer_id NUMBER;

var_product_offering_set      SYS_REFCURSOR;
var_product_offering_id       NUMBER;
var_product_offering_price    NUMBER(10,6);
var_product_offering_t_amount NUMBER(10,6);
var_product_offering_quantity NUMBER;

var_total_amount NUMBER(10,6);
var_final_amount NUMBER(10,2);

var_percent_discount NUMBER(10,2);
var_fixed_discount NUMBER(10,6);

-- EXCEPTIONS
BAD_OFFER_ID EXCEPTION;
BEGIN

  BEGIN
    SELECT
      OFFER.ID into temp_offer_id
    FROM
      OFFER
    WHERE
      OFFER.ID = in_offer_id;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE BAD_OFFER_ID;
  END;

  OPEN var_product_offering_set FOR
  SELECT
    OFFER_PRODUCT_OFFERING.PRODUCT_OFFERING_ID,
    PRODUCT_OFFERING.UNIT_PRICE,
    PRODUCT_OFFERING.QUANTITY
  FROM
    OFFER_PRODUCT_OFFERING
    INNER JOIN PRODUCT_OFFERING ON OFFER_PRODUCT_OFFERING.PRODUCT_OFFERING_ID = PRODUCT_OFFERING.ID
  WHERE
    OFFER_PRODUCT_OFFERING.OFFER_ID = in_offer_id;

  var_total_amount := 0;

  LOOP
    FETCH var_product_offering_set into
      var_product_offering_id,
      var_product_offering_price,
      var_product_offering_quantity;
    EXIT WHEN var_product_offering_set%NOTFOUND;

    SELECT
      SUM(DISCOUNT.FIXED_AMOUNT) into var_fixed_discount
    FROM
      DISCOUNT_PRODUCT_OFFERING
      INNER JOIN DISCOUNT ON DISCOUNT_PRODUCT_OFFERING.DISCOUNT_ID = DISCOUNT.ID
    WHERE
      DISCOUNT_PRODUCT_OFFERING.PRODUCT_OFFERING_ID = var_product_offering_id
      AND DISCOUNT.FIXED_AMOUNT IS NOT NULL;

    SELECT
      SUM(DISCOUNT.PERCENT_AMOUNT) into var_percent_discount
    FROM
      DISCOUNT_PRODUCT_OFFERING
      INNER JOIN DISCOUNT ON DISCOUNT_PRODUCT_OFFERING.DISCOUNT_ID = DISCOUNT.ID
    WHERE
      DISCOUNT_PRODUCT_OFFERING.PRODUCT_OFFERING_ID = var_product_offering_id
      AND DISCOUNT.PERCENT_AMOUNT IS NOT NULL;

    var_product_offering_t_amount := var_product_offering_price * var_product_offering_quantity;

    IF var_percent_discount IS NOT NULL THEN
      var_product_offering_t_amount := var_product_offering_t_amount - ( var_product_offering_t_amount * var_percent_discount / 100 );
    END IF;

    IF var_fixed_discount IS NOT NULL THEN
      var_product_offering_t_amount := var_product_offering_t_amount - var_fixed_discount;
    END IF;

    var_total_amount := var_total_amount + var_product_offering_t_amount;
  END LOOP;
  var_final_amount := var_total_amount;
  RETURN var_final_amount;

EXCEPTION
WHEN BAD_OFFER_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'No such offer');
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END CALCULATE_OFFER_AMOUNT;

/******************************************************************************/

FUNCTION CALCULATE_OFFER_CHAIN_AMOUNT (
  in_offer_chain_id IN NUMBER
) RETURN NUMBER AS
-- VARIABLES
SPROC_NAME             CONSTANT VARCHAR2(28) := 'CALCULATE_OFFER_CHAIN_AMOUNT';
temp_offer_chain_id    NUMBER;
var_first_offer_id     NUMBER;
-- EXCEPTIONS
BAD_OFFER_CHAIN_ID      EXCEPTION;
CAN_NOT_GET_FIRST_OFFER EXCEPTION;
EXCEPTION_MESSAGE       VARCHAR2(1024);
BEGIN

  BEGIN
    SELECT
      OFFER_CHAIN.ID into temp_offer_chain_id
    FROM
      OFFER_CHAIN
    WHERE
      OFFER_CHAIN.ID = in_offer_chain_id;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE BAD_OFFER_CHAIN_ID;
  END;

  BEGIN
    PROCS_OFFER_CHAIN_V18.GET_FIRST_OFFER(
      in_offer_chain_id => in_offer_chain_id,
      out_offer_id      => var_first_offer_id
    );
    EXCEPTION
      WHEN OTHERS THEN
        EXCEPTION_MESSAGE := SQLERRM;
        RAISE CAN_NOT_GET_FIRST_OFFER;
  END;

  RETURN CALCULATE_OFFER_AMOUNT(var_first_offer_id);

EXCEPTION
WHEN BAD_OFFER_CHAIN_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'No such offer chain');
WHEN CAN_NOT_GET_FIRST_OFFER THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'Could not find first offer', EXCEPTION_MESSAGE);
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END CALCULATE_OFFER_CHAIN_AMOUNT;

/******************************************************************************/

FUNCTION GET_FIRST_OFFER_INDEX (
  in_offer_chain_id IN NUMBER
) RETURN NUMBER AS
-- VARIABLES
SPROC_NAME            CONSTANT VARCHAR2(21) := 'GET_FIRST_OFFER_INDEX';
var_first_offer_index NUMBER;
BEGIN

  SELECT
    INDEX_VALUE into var_first_offer_index
  FROM (
    SELECT
      OFFER_OFFER_CHAIN.INDEX_VALUE
    FROM
      OFFER_OFFER_CHAIN
    WHERE
      OFFER_OFFER_CHAIN.OFFER_CHAIN_ID = in_offer_chain_id
    ORDER BY
      OFFER_OFFER_CHAIN.INDEX_VALUE ASC
  )
  WHERE
    ROWNUM <= 1;

  RETURN var_first_offer_index;

EXCEPTION
WHEN NO_DATA_FOUND THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'No such offer chain');
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END GET_FIRST_OFFER_INDEX;

/******************************************************************************/

FUNCTION GET_NEXT_OFFER_INDEX (
/*
NULL, if not exists
*/
  in_offer_chain_id            IN NUMBER,
  in_offer_chain_current_index IN NUMBER
) RETURN NUMBER AS
-- VARIABLES
SPROC_NAME                     CONSTANT VARCHAR2(20) := 'GET_NEXT_OFFER_INDEX';
temp_offer_chain_id            NUMBER;
temp_offer_chain_current_index NUMBER;
var_result                     NUMBER;
-- EXCEPTIONS
BAD_OFFER_CHAIN_ID      EXCEPTION;
BAD_CURRENT_INDEX_VALUE EXCEPTION;
BEGIN

  -- Check that offer chain exists
  BEGIN
    SELECT
      OFFER_CHAIN.ID into temp_offer_chain_id
    FROM
      OFFER_CHAIN
    WHERE
      OFFER_CHAIN.ID = in_offer_chain_id;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE BAD_OFFER_CHAIN_ID;
  END;

  -- Check that current offer index exists
  BEGIN
    SELECT
      OFFER_OFFER_CHAIN.INDEX_VALUE into temp_offer_chain_current_index
    FROM
      OFFER_OFFER_CHAIN
    WHERE
      OFFER_OFFER_CHAIN.OFFER_CHAIN_ID = in_offer_chain_id
      AND OFFER_OFFER_CHAIN.INDEX_VALUE = in_offer_chain_current_index
      -- TODO: delete next line
      AND ROWNUM <= 1;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE BAD_CURRENT_INDEX_VALUE;
  END;

  -- Get next offer index
  BEGIN
    SELECT
      INDEX_VALUE into var_result
    FROM (
      SELECT
        OFFER_OFFER_CHAIN.INDEX_VALUE
      FROM
        OFFER_OFFER_CHAIN
      WHERE
        OFFER_OFFER_CHAIN.OFFER_CHAIN_ID = in_offer_chain_id
        AND OFFER_OFFER_CHAIN.INDEX_VALUE > in_offer_chain_current_index
      ORDER BY
        OFFER_OFFER_CHAIN.INDEX_VALUE ASC
    )
    WHERE
      ROWNUM <= 1;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        var_result := NULL;
  END;

  RETURN var_result;

EXCEPTION
WHEN BAD_OFFER_CHAIN_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'No such offer chain');
WHEN BAD_CURRENT_INDEX_VALUE THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.INTERNAL_ERROR,
    SPROC_NAME, 'Bad current index value');
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END GET_NEXT_OFFER_INDEX;

/******************************************************************************/

PROCEDURE P_GET_NEXT_OFFER_INDEX (
  in_offer_chain_id            IN NUMBER,
  in_offer_chain_current_index IN NUMBER,
  out_next_offer_index         OUT NUMBER
) AS
BEGIN
  out_next_offer_index := GET_NEXT_OFFER_INDEX(
    in_offer_chain_id,
    in_offer_chain_current_index
  );
END P_GET_NEXT_OFFER_INDEX;

/******************************************************************************/

PROCEDURE GET_NEXT_OFFER_INDEX_BY_LCNS (
  in_license_id                IN NUMBER,
  in_offer_chain_current_index IN NUMBER,
  out_next_offer_index         OUT NUMBER
) AS
-- VARIABLES
SPROC_NAME         CONSTANT VARCHAR2(28) := 'GET_NEXT_OFFER_INDEX_BY_LCNS';
var_offer_chain_id NUMBER;
-- EXCEPTIONS
BAD_LICENSE_ID               EXCEPTION;
CAN_NOT_GET_NEXT_OFFER_INDEX EXCEPTION;
EXCEPTION_MESSAGE            VARCHAR2(1024);
BEGIN

  BEGIN
    SELECT
      SUBSCRIPTION.OFFER_CHAIN_ID into var_offer_chain_id
    FROM
      SUBSCRIPTION
    WHERE
      SUBSCRIPTION.ID = (
        SELECT
          LICENSE.SUBSCRIPTION_ID
        FROM
          LICENSE
        WHERE
          LICENSE.ID = in_license_id
      );
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE BAD_LICENSE_ID;
  END;

  BEGIN
    out_next_offer_index := GET_NEXT_OFFER_INDEX(
      var_offer_chain_id,
      in_offer_chain_current_index
    );
    EXCEPTION
      WHEN OTHERS THEN
        EXCEPTION_MESSAGE := SQLERRM;
        RAISE CAN_NOT_GET_NEXT_OFFER_INDEX;
  END;

EXCEPTION
WHEN BAD_LICENSE_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'No such license');
WHEN CAN_NOT_GET_NEXT_OFFER_INDEX THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.INTERNAL_ERROR,
    SPROC_NAME, 'Could not get next offer index', EXCEPTION_MESSAGE);
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END GET_NEXT_OFFER_INDEX_BY_LCNS;

/******************************************************************************/

FUNCTION IS_OFFER_INDEX_EXISTS (
/*
GLOBAL_CONSTANTS_V18.TRUE - exists
GLOBAL_CONSTANTS_V18.FALSE - not exists
*/
  in_offer_chain_id          IN NUMBER,
  in_offer_chain_offer_index IN NUMBER
) RETURN NUMBER AS
-- VARIABLES
SPROC_NAME CONSTANT VARCHAR2(21) := 'IS_OFFER_INDEX_EXISTS';
temp_count NUMBER;
BEGIN

  SELECT
    COUNT(*) into temp_count
  FROM
    OFFER_OFFER_CHAIN
  WHERE
    OFFER_OFFER_CHAIN.OFFER_CHAIN_ID = in_offer_chain_id
    AND OFFER_OFFER_CHAIN.INDEX_VALUE = in_offer_chain_offer_index;

  IF temp_count > 0 THEN
    RETURN GLOBAL_CONSTANTS_V18.TRUE;
  ELSE
    RETURN GLOBAL_CONSTANTS_V18.FALSE;
  END IF;

EXCEPTION
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END IS_OFFER_INDEX_EXISTS;

/******************************************************************************/

PROCEDURE GET_OFFER_LENGTH (
  in_offer_id IN NUMBER,
  out_years   OUT NUMBER,
  out_months  OUT NUMBER,
  out_days    OUT NUMBER
) AS
-- VARIABLES
var_offer_duration VARCHAR2(30);
SPROC_NAME         CONSTANT VARCHAR2(16) := 'GET_OFFER_LENGTH';
-- EXCEPTIONS
BAD_OFFER_ID           EXCEPTION;
CAN_NOT_PARSE_DURATION EXCEPTION;
EXCEPTION_MESSAGE       VARCHAR2(1024);
BEGIN

  BEGIN
    SELECT
      OFFER.ENTITLEMENT_DURATION into var_offer_duration
    FROM
      OFFER
    WHERE
      OFFER.ID = in_offer_id;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE BAD_OFFER_ID;
  END;

  BEGIN
    PROCS_COMMON_V18.ISO8601DURATION_TO_INTERVALS(
      var_offer_duration,
      out_years,
      out_months,
      out_days
    );
    EXCEPTION
      WHEN OTHERS THEN
        EXCEPTION_MESSAGE := SQLERRM;
        RAISE CAN_NOT_PARSE_DURATION;
  END;

EXCEPTION
WHEN BAD_OFFER_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'No such offer');
WHEN CAN_NOT_PARSE_DURATION THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.INTERNAL_ERROR,
    SPROC_NAME, 'Can not parse offer duration', EXCEPTION_MESSAGE);
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END GET_OFFER_LENGTH;

/******************************************************************************/

PROCEDURE GET_OFFER_LENGTH_IN_DAYS (
  in_offer_id   IN NUMBER,
  in_start_date IN DATE DEFAULT SYSDATE,
  out_days      OUT NUMBER
) AS
SPROC_NAME CONSTANT VARCHAR2(24) := 'GET_OFFER_LENGTH_IN_DAYS';
-- VARIABLES
var_offer_duration VARCHAR2(30);
var_offer_years    NUMBER;
var_offer_months   NUMBER;
var_offer_days     NUMBER;
var_offer_end_date DATE;
-- EXCEPTIONS
BAD_OFFER_ID EXCEPTION;
BEGIN

  BEGIN
    SELECT
      OFFER.ENTITLEMENT_DURATION into var_offer_duration
    FROM
      OFFER
    WHERE
      OFFER.ID = in_offer_id;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE BAD_OFFER_ID;
  END;

  PROCS_COMMON_V18.ISO8601DURATION_TO_INTERVALS (
    var_offer_duration,
    var_offer_years,
    var_offer_months,
    var_offer_days
  );

  var_offer_end_date := ( ( in_start_date
    + GLOBAL_CONSTANTS_V18.ONE_DAY_INTERVAL * var_offer_days )
    + GLOBAL_CONSTANTS_V18.ONE_MONTH_INTERVAL * var_offer_months )
    + GLOBAL_CONSTANTS_V18.ONE_YEAR_INTERVAL * var_offer_years;

  out_days := var_offer_end_date - in_start_date;

EXCEPTION
WHEN BAD_OFFER_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'No such offer');
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END GET_OFFER_LENGTH_IN_DAYS;

/******************************************************************************/

PROCEDURE GET_OFFER_PRODUCTS (
/*
Throws exceptions (codes):
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_offer_id    IN NUMBER,
  out_result_set OUT SYS_REFCURSOR
) AS
-- VARIABLES
SPROC_NAME     CONSTANT VARCHAR2(18) := 'GET_OFFER_PRODUCTS';
temp_offerr_id NUMBER;
-- EXCEPTIONS
BAD_OFFER_ID EXCEPTION;
BEGIN

  BEGIN
    SELECT
      OFFER.ID into temp_offerr_id
    FROM
      OFFER
    WHERE
      OFFER.ID = in_offer_id;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE BAD_OFFER_ID;
  END;

  OPEN out_result_set FOR
  SELECT DISTINCT
    PRODUCT.ID,
    PRODUCT.NAME
  FROM
    PRODUCT
  WHERE
    PRODUCT.ID IN (
        SELECT
          PRODUCT_OFFERING.PRODUCT_ID
        FROM
          OFFER_PRODUCT_OFFERING
          INNER JOIN PRODUCT_OFFERING ON OFFER_PRODUCT_OFFERING.PRODUCT_OFFERING_ID = PRODUCT_OFFERING.ID
        WHERE
          OFFER_PRODUCT_OFFERING.OFFER_ID = in_offer_id
      );

EXCEPTION
WHEN BAD_OFFER_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'No such offer');
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END GET_OFFER_PRODUCTS;

/******************************************************************************/

PROCEDURE GET_OFFER_CHAIN_PROD_OFFERINGS (
/*
Throws exceptions (codes):
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_offer_chain_id IN NUMBER,
  out_result_set    OUT SYS_REFCURSOR
) AS
SPROC_NAME CONSTANT VARCHAR2(30) := 'GET_OFFER_CHAIN_PROD_OFFERINGS';
-- VARIABLES
temp_offer_chain_id NUMBER;
-- EXCEPTIONS
BAD_OFFER_CHAIN_ID EXCEPTION;
BEGIN

  BEGIN
    SELECT
      OFFER_CHAIN.ID into temp_offer_chain_id
    FROM
      OFFER_CHAIN
    WHERE
      OFFER_CHAIN.ID = in_offer_chain_id;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE BAD_OFFER_CHAIN_ID;
  END;

  OPEN out_result_set FOR
  SELECT
    PRODUCT_OFFERING.ID,
    PRODUCT_OFFERING.PRODUCT_ID,
    PRODUCT_OFFERING.TAX_CATEGORY_ID,
    PRODUCT_OFFERING.UNIT_PRICE,
    PRODUCT_OFFERING.QUANTITY,
    PRODUCT_OFFERING.CREATE_DATE,
    PRODUCT_OFFERING.CREATED_BY,
    PRODUCT.NAME,
    PRODUCT.PRODUCT_URI,
    CAPABILITY.ID CAP_ID,
    CAPABILITY.CODE CAP_CODE,
    CAPABILITY.DESCRIPTION CAP_DESCRIPTION,
    CAPABILITY.SHAREABLE CAP_SHAREABLE
  FROM
    PRODUCT_OFFERING
    INNER JOIN PRODUCT ON PRODUCT_OFFERING.PRODUCT_ID = PRODUCT.ID
    INNER JOIN CAPABILITY ON PRODUCT_OFFERING.CAPABILITY_ID = CAPABILITY.ID
  WHERE
    PRODUCT_OFFERING.ID IN (
      SELECT DISTINCT
        PRODUCT_OFFERING_ID
      FROM
        OFFER_PRODUCT_OFFERING
      WHERE
        OFFER_PRODUCT_OFFERING.OFFER_ID IN (
          SELECT DISTINCT
            OFFER_ID
          FROM
            OFFER_OFFER_CHAIN
          WHERE
            OFFER_OFFER_CHAIN.OFFER_CHAIN_ID = in_offer_chain_id
        )
    );

EXCEPTION
WHEN BAD_OFFER_CHAIN_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'Bad offer chain id');
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END GET_OFFER_CHAIN_PROD_OFFERINGS;

/******************************************************************************/

FUNCTION CHECK_FOR_SAME_PRODUCTS (
/*
Throws exceptions (codes):
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
Returns:
GLOBAL_CONSTANTS_V18.TRUE if there are at least one same product
GLOBAL_CONSTANTS_V18.FALSE else
*/
  in_offer_chain_1         IN OFFER_CHAIN.ID%TYPE,
  in_offer_chain_2         IN OFFER_CHAIN.ID%TYPE,
  in_use_eligibility_rules IN NUMBER DEFAULT GLOBAL_CONSTANTS_V18.FALSE
) RETURN NUMBER AS
SPROC_NAME CONSTANT VARCHAR2(23) := 'CHECK_FOR_SAME_PRODUCTS';
-- CONSTANTS
PRODUCT_ELIGIBILITY_NAME CONSTANT VARCHAR2(19) := 'MAX_CONCURRENT_SUBS';
-- VARIABLES
temp_offer_chain_id      OFFER_CHAIN.ID%TYPE;
var_same_products        SYS_REFCURSOR;
var_same_product_id      NUMBER;
same_product_count       NUMBER;
var_product_eligibility_limit NUMBER;
s_product_eligibility_limit   VARCHAR2(100);
-- EXCEPTIONS
BAD_FIRST_OFFER_CHAIN          EXCEPTION;
BAD_SECOND_OFFER_CHAIN         EXCEPTION;
BEGIN

  -- Check that first offer chain exists
  BEGIN
    SELECT
      OFFER_CHAIN.ID into temp_offer_chain_id
    FROM
      OFFER_CHAIN
    WHERE
      OFFER_CHAIN.ID = in_offer_chain_1;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE BAD_FIRST_OFFER_CHAIN;
  END;

  -- Check that second offer chain exists
  BEGIN
    SELECT
      OFFER_CHAIN.ID into temp_offer_chain_id
    FROM
      OFFER_CHAIN
    WHERE
      OFFER_CHAIN.ID = in_offer_chain_2;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE BAD_SECOND_OFFER_CHAIN;
  END;

  PROCS_OFFER_CHAIN_V18.GET_OFF_CHAINS_SAME_PRODUCTS(
    in_offer_chain_1 => in_offer_chain_1,
    in_offer_chain_2 => in_offer_chain_2,
    out_result_set   => var_same_products
  );

  LOOP
    FETCH var_same_products INTO var_same_product_id, same_product_count;
    EXIT WHEN var_same_products%NOTFOUND;

    IF in_use_eligibility_rules = GLOBAL_CONSTANTS_V18.FALSE THEN
      -- Return false because this offer chains having same products
      RETURN GLOBAL_CONSTANTS_V18.TRUE;
    ELSE

      -- Get eligibility rule for given product
      BEGIN
        SELECT
          PRODUCT_ELIGIBILITY.VALUE into s_product_eligibility_limit
        FROM
          PRODUCT_ELIGIBILITY
        WHERE
          PRODUCT_ELIGIBILITY.PRODUCT_ID = var_same_product_id
          AND PRODUCT_ELIGIBILITY.NAME = PRODUCT_ELIGIBILITY_NAME;

        -- REVU: What should to be here? 1?
        EXCEPTION
          WHEN NO_DATA_FOUND THEN
            s_product_eligibility_limit := '1';
      END;

      IF UPPER(s_product_eligibility_limit) = GLOBAL_CONSTANTS_V18.MAX_CONSURRENT_PRD_UNLIM THEN
        RETURN GLOBAL_CONSTANTS_V18.FALSE;
      END IF;

      var_product_eligibility_limit := TO_NUMBER(s_product_eligibility_limit);

      -- Check for limit
      IF var_product_eligibility_limit < same_product_count THEN
        RETURN GLOBAL_CONSTANTS_V18.TRUE;
      END IF;

    END IF;
  END LOOP;

  RETURN GLOBAL_CONSTANTS_V18.FALSE;

EXCEPTION
WHEN BAD_FIRST_OFFER_CHAIN THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'First offer chain not found');
WHEN BAD_SECOND_OFFER_CHAIN THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'Second offer chain not found');
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END CHECK_FOR_SAME_PRODUCTS;

/******************************************************************************/

FUNCTION IS_OFFER_CHAIN_CANCELABLE (
/*
Throws exceptions (codes):
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
Returns:
GLOBAL_CONSTANTS_V18.TRUE cancelation key is 1 (in OFFER_CHAIN_META_DATA)
GLOBAL_CONSTANTS_V18.FALSE else
*/
  in_offer_chain_id IN NUMBER
) RETURN NUMBER AS
SPROC_NAME CONSTANT VARCHAR2(25) := 'IS_OFFER_CHAIN_CANCELABLE';
-- VARIABLES
var_is_cancelable_str VARCHAR2(1);
var_is_cancelable     NUMBER;
BEGIN

  BEGIN
    SELECT
      VALUE INTO var_is_cancelable_str
    FROM (
      SELECT
        VALUE, NAME
      FROM
        OFFER_CHAIN_META_DATA
      WHERE
        OFFER_CHAIN_ID = in_offer_chain_id
      )
    WHERE
      UPPER(NAME) = 'CANCELABLE';
    var_is_cancelable := TO_NUMBER(var_is_cancelable_str);
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        var_is_cancelable := GLOBAL_CONSTANTS_V18.FALSE;
  END;

  IF var_is_cancelable = GLOBAL_CONSTANTS_V18.FALSE THEN
    RETURN GLOBAL_CONSTANTS_V18.FALSE;
  END IF;

  RETURN GLOBAL_CONSTANTS_V18.TRUE;

EXCEPTION
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END IS_OFFER_CHAIN_CANCELABLE;

/******************************************************************************/

FUNCTION GET_OFFER_CHAIN_MAX_CONC_SUBSC (
/*
Throws exceptions (codes):
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_offer_chain_id IN NUMBER
) RETURN NUMBER AS
SPROC_NAME CONSTANT VARCHAR2(30) := 'GET_OFFER_CHAIN_MAX_CONC_SUBSC';
-- VARIABLES
var_max_concurrent_subs_str VARCHAR2(100);
var_max_concurrent_subs     NUMBER;
BEGIN

  BEGIN
    SELECT
      VALUE into var_max_concurrent_subs_str
    FROM
      (
        SELECT
          NAME,
          VALUE
        FROM
          OFFER_CHAIN_ELIGIBILITY
        WHERE
          OFFER_CHAIN_ID = in_offer_chain_id
      )
    WHERE
      NAME LIKE GLOBAL_CONSTANTS_V18.MAX_CONCURRENT_SUBS;

    IF var_max_concurrent_subs_str = GLOBAL_CONSTANTS_V18.MAX_CONCURRENT_SUBS_UNLIM THEN
      var_max_concurrent_subs := GLOBAL_CONSTANTS_V18.INFINITY;
    ELSE
      var_max_concurrent_subs := TO_NUMBER(var_max_concurrent_subs_str);
    END IF;

    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        var_max_concurrent_subs := 1;
  END;

  RETURN var_max_concurrent_subs;

EXCEPTION
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END GET_OFFER_CHAIN_MAX_CONC_SUBSC;

/******************************************************************************/

PROCEDURE GET_OFFER_CHAIN_ELIGIBILITY (
/*
Throws exceptions (codes):
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_offer_chain_id   IN NUMBER,
  in_eligibility_name IN VARCHAR2,
  out_result_set      OUT SYS_REFCURSOR
) AS
SPROC_NAME CONSTANT VARCHAR2(27) := 'GET_OFFER_CHAIN_ELIGIBILITY';
-- VARIABLES
temp_offer_chain_id NUMBER;
var_eligibility_name OFFER_CHAIN_ELIGIBILITY.NAME%TYPE;
-- EXCEPTIONS
BAD_OFFER_CHAIN_ID EXCEPTION;
BEGIN

  BEGIN
    SELECT
      OFFER_CHAIN.ID into temp_offer_chain_id
    FROM
      OFFER_CHAIN
    WHERE
      OFFER_CHAIN.ID = in_offer_chain_id;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE BAD_OFFER_CHAIN_ID;
  END;

  var_eligibility_name := UPPER(in_eligibility_name);

  OPEN out_result_set FOR
  SELECT
    OFFER_CHAIN_ELIGIBILITY.ID,
    OFFER_CHAIN_ELIGIBILITY.NAME,
    OFFER_CHAIN_ELIGIBILITY.VALUE,
    OFFER_CHAIN_ELIGIBILITY.OFFER_CHAIN_ID,
    OFFER_CHAIN_ELIGIBILITY.CREATE_DATE,
    OFFER_CHAIN_ELIGIBILITY.CREATED_BY
  FROM
    OFFER_CHAIN_ELIGIBILITY
  WHERE
    OFFER_CHAIN_ELIGIBILITY.OFFER_CHAIN_ID = in_offer_chain_id
    AND UPPER(OFFER_CHAIN_ELIGIBILITY.NAME) = var_eligibility_name;

EXCEPTION
WHEN BAD_OFFER_CHAIN_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'No such offer chain');
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END GET_OFFER_CHAIN_ELIGIBILITY;

/******************************************************************************/

PROCEDURE GET_OFFER_CHAINS_ELIGIBILITY (
/*
Throws exceptions (codes):
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_offer_chain_ids  IN VARCHAR2,
  in_eligibility_name IN VARCHAR2,
  out_result_set      OUT SYS_REFCURSOR
) AS
SPROC_NAME CONSTANT VARCHAR2(28) := 'GET_OFFER_CHAINS_ELIGIBILITY';
-- VARIABLES
var_eligibility_name OFFER_CHAIN_ELIGIBILITY.NAME%TYPE;
BEGIN

  var_eligibility_name := UPPER(in_eligibility_name);

  -- TODO: Reveiw this procedure and fine a normal way to implement this feature

  open out_result_set for
  'SELECT
    ID,
    NAME,
    VALUE,
    OFFER_CHAIN_ID,
    CREATE_DATE,
    CREATED_BY
  FROM
    OFFER_CHAIN_ELIGIBILITY
  WHERE
    OFFER_CHAIN_ID in ( '|| in_offer_chain_ids ||' )
    AND UPPER(NAME) = :1'
  using var_eligibility_name;

EXCEPTION
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END GET_OFFER_CHAINS_ELIGIBILITY;

/******************************************************************************/

PROCEDURE GET_OFFER_CHAINS_META_DATA (
  in_offer_chain_ids IN VARCHAR2,
  in_meta_data_name  IN VARCHAR2,
  out_result_set     OUT SYS_REFCURSOR
) AS
SPROC_NAME CONSTANT VARCHAR2(28) := 'GET_OFFER_CHAINS_META_DATA';
-- VARIABLES
var_meta_data_name  OFFER_CHAIN_META_DATA.NAME%TYPE;
BEGIN

  var_meta_data_name := UPPER(in_meta_data_name);

  open out_result_set for
  'select
    ID,
    NAME,
    VALUE,
    OFFER_CHAIN_ID,
    CREATED_BY,
    CREATE_DATE
  from
    OFFER_CHAIN_META_DATA
  where
    OFFER_CHAIN_ID in ( '||in_offer_chain_ids||' )
    and UPPER(OFFER_CHAIN_META_DATA.NAME) = :1'
  using var_meta_data_name;

EXCEPTION
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END GET_OFFER_CHAINS_META_DATA;

PROCEDURE GET_OFFER_CHAIN_META_DATA (
/*
Throws exceptions (codes):
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_offer_chain_id IN NUMBER,
  in_meta_data_name IN VARCHAR2,
  out_result_set    OUT SYS_REFCURSOR
) AS
SPROC_NAME CONSTANT VARCHAR2(27) := 'GET_OFFER_CHAIN_META_DATA';
-- VARIABLES
temp_offer_chain_id NUMBER;
var_meta_data_name  OFFER_CHAIN_META_DATA.NAME%TYPE;
-- EXCEPTIONS
BAD_OFFER_CHAIN_ID EXCEPTION;
BEGIN

  BEGIN
    SELECT
      OFFER_CHAIN.ID into temp_offer_chain_id
    FROM
      OFFER_CHAIN
    WHERE
      OFFER_CHAIN.ID = in_offer_chain_id;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE BAD_OFFER_CHAIN_ID;
  END;

  var_meta_data_name := UPPER(in_meta_data_name);

  OPEN out_result_set FOR
  SELECT
    OFFER_CHAIN_META_DATA.ID,
    OFFER_CHAIN_META_DATA.NAME,
    OFFER_CHAIN_META_DATA.VALUE,
    OFFER_CHAIN_META_DATA.OFFER_CHAIN_ID,
    OFFER_CHAIN_META_DATA.CREATED_BY,
    OFFER_CHAIN_META_DATA.CREATE_DATE
  FROM
    OFFER_CHAIN_META_DATA
  WHERE
    OFFER_CHAIN_META_DATA.OFFER_CHAIN_ID = in_offer_chain_id
    AND UPPER(OFFER_CHAIN_META_DATA.NAME) = var_meta_data_name;

EXCEPTION
WHEN BAD_OFFER_CHAIN_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'No such offer chain');
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END GET_OFFER_CHAIN_META_DATA;

PROCEDURE GET_PROD_OFFERINGS_BY_OFFER_ID (
/*
Throws exceptions (codes):
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_offer_id    IN NUMBER,
  out_result_set OUT SYS_REFCURSOR
) AS
SPROC_NAME CONSTANT VARCHAR2(30) := 'GET_PROD_OFFERINGS_BY_OFFER_ID';
-- VARIABLES
temp_offer_id NUMBER;
-- EXCEPTIONS
BAD_OFFER_ID EXCEPTION;
BEGIN

  BEGIN
    SELECT
      OFFER.ID into temp_offer_id
    FROM
      OFFER
    WHERE
      OFFER.ID = in_offer_id;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE BAD_OFFER_ID;
  END;

  OPEN out_result_set FOR
  SELECT DISTINCT
    PRODUCT_OFFERING.ID,
    PRODUCT_OFFERING.PRODUCT_ID,
    PRODUCT_OFFERING.TAX_CATEGORY_ID,
    PRODUCT_OFFERING.UNIT_PRICE,
    PRODUCT_OFFERING.QUANTITY,
    PRODUCT_OFFERING.CREATE_DATE,
    PRODUCT_OFFERING.CREATED_BY,
    CAPABILITY.ID CAP_ID,
    CAPABILITY.CODE CAP_CODE,
    CAPABILITY.DESCRIPTION CAP_DESCRIPTION,
    CAPABILITY.SHAREABLE CAP_SHAREABLE
  FROM
    OFFER_PRODUCT_OFFERING
    INNER JOIN PRODUCT_OFFERING ON PRODUCT_OFFERING.ID = OFFER_PRODUCT_OFFERING.PRODUCT_OFFERING_ID
    INNER JOIN CAPABILITY ON PRODUCT_OFFERING.CAPABILITY_ID = CAPABILITY.ID
  WHERE
    OFFER_PRODUCT_OFFERING.OFFER_ID = in_offer_id;

EXCEPTION
WHEN BAD_OFFER_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'No such offer');
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END GET_PROD_OFFERINGS_BY_OFFER_ID;

PROCEDURE GET_PRODUCT_OFFERING_META_DATA (
/*
Throws exceptions (codes):
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_product_offering_id IN NUMBER,
  in_meta_data_name      IN VARCHAR2 DEFAULT NULL,
  out_result_set         OUT SYS_REFCURSOR
) AS
SPROC_NAME CONSTANT VARCHAR2(30) := 'GET_PRODUCT_OFFERING_META_DATA';
-- VARIABLES
temp_product_offering_id NUMBER;
-- EXCEPTIONS
BAD_PRODUCT_OFFERING_ID EXCEPTION;
BEGIN

  BEGIN
    SELECT
      PRODUCT_OFFERING.ID into temp_product_offering_id
    FROM
      PRODUCT_OFFERING
    WHERE
      PRODUCT_OFFERING.ID = in_product_offering_id;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE BAD_PRODUCT_OFFERING_ID;
  END;

  OPEN out_result_set FOR
  SELECT
    PRODUCT_OFFERING_META_DATA.ID,
    PRODUCT_OFFERING_META_DATA.NAME,
    PRODUCT_OFFERING_META_DATA.VALUE,
    PRODUCT_OFFERING_META_DATA.PRODUCT_OFFERING_ID,
    PRODUCT_OFFERING_META_DATA.CREATE_DATE,
    PRODUCT_OFFERING_META_DATA.CREATED_BY
  FROM
    PRODUCT_OFFERING_META_DATA
  WHERE
    PRODUCT_OFFERING_META_DATA.PRODUCT_OFFERING_ID = in_product_offering_id
    AND UPPER(PRODUCT_OFFERING_META_DATA.NAME) = UPPER(NVL(in_meta_data_name, PRODUCT_OFFERING_META_DATA.NAME));

EXCEPTION
WHEN BAD_PRODUCT_OFFERING_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'No such product offering');
END GET_PRODUCT_OFFERING_META_DATA;

/******************************************************************************/

PROCEDURE GET_OFF_CHAINS_SAME_PRODUCTS (
/*
Throws exceptions (codes):
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_offer_chain_1 IN NUMBER,
  in_offer_chain_2 IN NUMBER,
  out_result_set   OUT SYS_REFCURSOR
) AS
BEGIN

  OPEN out_result_set FOR
  SELECT
    PRODUCT_ID_IN_OFFER_CH_1 AS "PRODUCT_ID",
    COUNT_1 + COUNT_2        AS "COUNT"
  FROM
    (
      SELECT
        PRODUCT_OFFERING.PRODUCT_ID as "PRODUCT_ID_IN_OFFER_CH_1",
        COUNT(*)                    as "COUNT_1"
      FROM
        (
          SELECT OFFER_ID as "OFFER_OFFER_CHAIN_OFFER_ID" FROM OFFER_OFFER_CHAIN WHERE OFFER_OFFER_CHAIN.OFFER_CHAIN_ID = in_offer_chain_1
        )
        INNER JOIN OFFER_PRODUCT_OFFERING ON OFFER_OFFER_CHAIN_OFFER_ID = OFFER_PRODUCT_OFFERING.OFFER_ID
        INNER JOIN PRODUCT_OFFERING ON OFFER_PRODUCT_OFFERING.PRODUCT_OFFERING_ID = PRODUCT_OFFERING.ID
      GROUP BY
        PRODUCT_OFFERING.PRODUCT_ID
    )
    INNER JOIN
    (
      SELECT
        PRODUCT_OFFERING.PRODUCT_ID as "PRODUCT_ID_IN_OFFER_CH_2",
        COUNT(*)                    as "COUNT_2"
      FROM
        (
          SELECT OFFER_ID as "OFFER_OFFER_CHAIN_OFFER_ID" FROM OFFER_OFFER_CHAIN WHERE OFFER_OFFER_CHAIN.OFFER_CHAIN_ID = in_offer_chain_2
        )
        INNER JOIN OFFER_PRODUCT_OFFERING ON OFFER_OFFER_CHAIN_OFFER_ID = OFFER_PRODUCT_OFFERING.OFFER_ID
        INNER JOIN PRODUCT_OFFERING ON OFFER_PRODUCT_OFFERING.PRODUCT_OFFERING_ID = PRODUCT_OFFERING.ID
      GROUP BY
        PRODUCT_OFFERING.PRODUCT_ID
    ) ON PRODUCT_ID_IN_OFFER_CH_1 = PRODUCT_ID_IN_OFFER_CH_2;

END GET_OFF_CHAINS_SAME_PRODUCTS;

/******************************************************************************/

PROCEDURE GET_OFFER_CHAIN_MD_VALUE (
  in_offer_chain_id IN NUMBER,
  in_meta_data_name IN VARCHAR2,
  out_value         OUT VARCHAR2
) AS
BEGIN
  BEGIN
    SELECT
      OFFER_CHAIN_META_DATA.VALUE into out_value
    FROM
      OFFER_CHAIN_META_DATA
    WHERE
      OFFER_CHAIN_META_DATA.OFFER_CHAIN_ID = in_offer_chain_id
      AND UPPER(OFFER_CHAIN_META_DATA.NAME) = UPPER(in_meta_data_name);

    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        out_value := NULL;
  END;
END GET_OFFER_CHAIN_MD_VALUE;

/******************************************************************************/

PROCEDURE GET_OFFER_CHAIN_EL_VALUE (
  in_offer_chain_id   IN NUMBER,
  in_eligibility_name IN VARCHAR2,
  out_value           OUT VARCHAR2
) AS
BEGIN
  BEGIN
    SELECT
      OFFER_CHAIN_ELIGIBILITY.VALUE into out_value
    FROM
      OFFER_CHAIN_ELIGIBILITY
    WHERE
      OFFER_CHAIN_ELIGIBILITY.OFFER_CHAIN_ID = in_offer_chain_id
      AND UPPER(OFFER_CHAIN_ELIGIBILITY.NAME) = UPPER(in_eligibility_name);

    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        out_value := NULL;
  END;
END GET_OFFER_CHAIN_EL_VALUE;

PROCEDURE GET_OFFER_PRODUCT_OFFERINGS (
  in_offer_id    IN NUMBER,
  out_result_set OUT SYS_REFCURSOR
) AS
SPROC_NAME CONSTANT VARCHAR2(27) := 'GET_OFFER_PRODUCT_OFFERINGS';
-- VARIABLES
temp_offer_id NUMBER;
-- EXCEPTIONS
BAD_OFFER_ID EXCEPTION;
BEGIN

  BEGIN
    SELECT
      OFFER.ID into temp_offer_id
    FROM
      OFFER
    WHERE
      OFFER.ID = in_offer_id;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE BAD_OFFER_ID;
  END;

  OPEN out_result_set FOR
  SELECT
    PRODUCT_OFFERING.ID,
    PRODUCT_OFFERING.PRODUCT_ID,
    PRODUCT_OFFERING.TAX_CATEGORY_ID,
    PRODUCT_OFFERING.UNIT_PRICE,
    PRODUCT_OFFERING.QUANTITY,
    PRODUCT_OFFERING.CREATE_DATE,
    PRODUCT_OFFERING.CREATED_BY,
    PRODUCT_OFFERING.TAX_POLICY_TYPE_ID
  FROM
    PRODUCT_OFFERING
    INNER JOIN OFFER_PRODUCT_OFFERING ON PRODUCT_OFFERING.ID = OFFER_PRODUCT_OFFERING.PRODUCT_OFFERING_ID
  WHERE
    OFFER_PRODUCT_OFFERING.OFFER_ID = in_offer_id;

EXCEPTION
WHEN BAD_OFFER_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'No such offer');
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END GET_OFFER_PRODUCT_OFFERINGS;

/******************************************************************************/

PROCEDURE GET_OFFER_CHAINS_BY_META_DATA (
  in_meta_data_name  IN VARCHAR2,
  in_meta_data_value IN VARCHAR2,
  out_result_set     OUT SYS_REFCURSOR
) AS
SPROC_NAME CONSTANT VARCHAR2(29) := 'GET_OFFER_CHAINS_BY_META_DATA';
-- VARIABLES
v_meta_data_name  CONSTANT OFFER_CHAIN_META_DATA.NAME%TYPE  := UPPER(in_meta_data_name);
v_meta_data_value CONSTANT OFFER_CHAIN_META_DATA.VALUE%TYPE := UPPER(in_meta_data_value);
BEGIN

  OPEN out_result_set FOR
  SELECT
    och.ID,
    och.NAME,
    och.DESCRIPTION,
    och.OFFER_CHAIN_STATUS_ID,
    PROCS_OFFER_CHAIN_V18.CALCULATE_OFFER_CHAIN_AMOUNT(och.id) as amount,
    och.ADOPTABILITY_WINDOW_START_DATE,
    och.ADOPTABILITY_WINDOW_END_DATE,
    PROCS_OFFER_CHAIN_V18.IS_OFFER_CHAIN_CANCELABLE(och.id) as is_cancelable,
    och.IS_GIFT_CERTIFICATE,
    'false' as comf_offer_chain, -- TODO
    po.PRODUCT_ID,
    och.GROUP_ACCOUNT_TYPE_ID
  FROM
    OFFER_CHAIN och,
    OFFER_OFFER_CHAIN ooch,
    OFFER_PRODUCT_OFFERING opo,
    PRODUCT_OFFERING po
  WHERE
    och.ID = ooch.OFFER_CHAIN_ID
    and ooch.OFFER_ID = opo.OFFER_ID
    and opo.PRODUCT_OFFERING_ID = po.ID
    and och.OFFER_CHAIN_STATUS_ID = GLOBAL_STATUSES_V18.OFFER_CHAIN_ACTIVE
    and och.id in (
      SELECT DISTINCT
        och2.id
      from
        offer_chain och2
        inner join offer_chain_meta_data ochmd on och2.id = ochmd.offer_chain_id
      where
        UPPER(ochmd.name) = v_meta_data_name
        AND UPPER(ochmd.value) = v_meta_data_value
    );

EXCEPTION
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END GET_OFFER_CHAINS_BY_META_DATA;

/******************************************************************************/

PROCEDURE GET_ALL_META_DATA (
  in_offer_chain_id IN NUMBER,
  out_result_set    OUT SYS_REFCURSOR
) AS
SPROC_NAME CONSTANT VARCHAR2(17) := 'GET_ALL_META_DATA';
-- Variables
temp_offer_chain_id NUMBER;
-- Exceptions
BAD_OFFER_CHAIN_ID EXCEPTION;
BEGIN

  BEGIN
    SELECT
      OCH.ID into temp_offer_chain_id
    FROM
      OFFER_CHAIN OCH
    WHERE
      OCH.ID = in_offer_chain_id;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE BAD_OFFER_CHAIN_ID;
  END;

  OPEN out_result_set FOR
  SELECT
    OCHMD.ID,
    OCHMD.OFFER_CHAIN_ID,
    OCHMD.NAME,
    OCHMD.VALUE,
    OCHMD.CREATE_DATE,
    OCHMD.CREATED_BY
  FROM
    OFFER_CHAIN_META_DATA OCHMD
  WHERE
    OCHMD.OFFER_CHAIN_ID = in_offer_chain_id;

EXCEPTION
WHEN BAD_OFFER_CHAIN_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'No such offer chain', SQLERRM);
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END GET_ALL_META_DATA;

PROCEDURE CHECK_PRODUCT_ELIGIBILITY (
  in_group_id       IN NUMBER,
  in_offer_chain_id IN NUMBER,
  out_is_eligible   OUT NUMBER,
  out_concurrent_subscription_id OUT NUMBER
) AS
SPROC_NAME CONSTANT VARCHAR2(25) := 'CHECK_PRODUCT_ELIGIBILITY';
-- Variables
var_account_id  NUMBER;
var_is_eligible NUMBER;
var_is_gc       NUMBER;
-- Exceptions
BAD_GROUP_ID                EXCEPTION;
CAN_NOT_CHECK_SAME_PRODUCTS EXCEPTION;
BAD_OC_ID                   EXCEPTION;
EXCEPTION_MESSAGE           VARCHAR(1024);
BEGIN

  var_is_eligible := GLOBAL_CONSTANTS_V18.TRUE;

  out_concurrent_subscription_id := NULL;

  BEGIN
    SELECT
      OC.IS_GIFT_CERTIFICATE into var_is_gc
    FROM
      OFFER_CHAIN OC
    WHERE
      OC.ID = in_offer_chain_id;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE BAD_OC_ID;
  END;

  -- only check eligibility if this is not a gift certificate
  IF (var_is_gc IS NULL OR var_is_gc != 1) THEN
    BEGIN
      SELECT
        A.ID into var_account_id
      FROM
        ACCOUNT A
      WHERE
        A.GROUP_ID = in_group_id;
      EXCEPTION
        WHEN NO_DATA_FOUND THEN
          RAISE BAD_GROUP_ID;
    END;


    FOR f_offer_chain IN (
        SELECT
          S.ID as SUBSCRIPTION_ID,
          S.OFFER_CHAIN_ID
        FROM
          SUBSCRIPTION S
        WHERE
          S.ACCOUNT_ID = var_account_id
          AND (S.SUBSCRIPTION_STATUS_ID = GLOBAL_STATUSES_V18.SUBSCRIPTION_ACTIVE
               OR S.SUBSCRIPTION_STATUS_ID = GLOBAL_STATUSES_V18.SUBSCRIPTION_IN_GRACE_PERIOD)
    )
    LOOP
      BEGIN
        IF (
          PROCS_OFFER_CHAIN_V18.CHECK_FOR_SAME_PRODUCTS(
            in_offer_chain_id,
            f_offer_chain.offer_chain_id,
            GLOBAL_CONSTANTS_V18.TRUE
          ) = GLOBAL_CONSTANTS_V18.TRUE
        ) THEN
          var_is_eligible := GLOBAL_CONSTANTS_V18.FALSE;
          out_concurrent_subscription_id := f_offer_chain.SUBSCRIPTION_ID;
        END IF;
        EXCEPTION
          WHEN OTHERS THEN
            EXCEPTION_MESSAGE := SQLERRM;
            RAISE CAN_NOT_CHECK_SAME_PRODUCTS;
      END;
    END LOOP;
  END IF;
  out_is_eligible := var_is_eligible;

EXCEPTION
WHEN BAD_GROUP_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'No such offer chain', SQLERRM);
WHEN BAD_OC_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'No such offer chain', SQLERRM);
WHEN CAN_NOT_CHECK_SAME_PRODUCTS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.INTERNAL_ERROR,
    SPROC_NAME, 'Could not check offers for same products', EXCEPTION_MESSAGE);
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END CHECK_PRODUCT_ELIGIBILITY;

PROCEDURE GET_NOTIFICATION_TYPE_ID (
  in_offer_chain_id        IN NUMBER,
  in_action_name           IN VARCHAR2,
  out_notification_type_id OUT NUMBER
) AS
SPROC_NAME CONSTANT VARCHAR2(28) := 'GET_NOTIFICATION_TEMPLATE_ID';
-- Variables
var_action_id NUMBER;
-- Exceptions
BAD_ACTION_NAME        EXCEPTION;
MULTIPLY_ACTIONS_FOUND EXCEPTION;
BEGIN

  BEGIN
    SELECT
      A.ID into var_action_id
    FROM
      ACTION A
    WHERE
      UPPER(A.NAME) = UPPER(in_action_name);
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE BAD_ACTION_NAME;
      WHEN TOO_MANY_ROWS THEN
        RAISE MULTIPLY_ACTIONS_FOUND;
  END;

  SELECT
    OCNT.NOTIFICATION_TYPE_ID into out_notification_type_id
  FROM
    OFFER_CHAIN_NOTIFICATION_TYPE OCNT
  WHERE
    OCNT.OFFER_CHAIN_ID = in_offer_chain_id
    AND OCNT.ACTION_ID = var_action_id;

EXCEPTION
WHEN NO_DATA_FOUND THEN
  out_notification_type_id := NULL;
WHEN BAD_ACTION_NAME THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.INVALID_PARAMETER,
    SPROC_NAME, 'Bad action name', SQLERRM);
WHEN MULTIPLY_ACTIONS_FOUND THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.INTERNAL_ERROR,
    SPROC_NAME, 'Found more then one action with given name', SQLERRM);
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END GET_NOTIFICATION_TYPE_ID;

END PROCS_OFFER_CHAIN_V18;
.
/

CREATE OR REPLACE PACKAGE BODY "PROCS_POLLING_SYNC"
AS
    --------------------------------------------------------------------------------
PROCEDURE GATHER_SYNC_EVENTS
    (
        in_last_timestamp TIMESTAMP,
        out_new_timestamp OUT TIMESTAMP)
IS
BEGIN
    out_new_timestamp := systimestamp;
    GATHER_SYNC_EVENTS_RANGE(in_last_timestamp, out_new_timestamp, (3 / 24 / 60));
END;
    --------------------------------------------------------------------------------
PROCEDURE GATHER_SYNC_EVENTS_RANGE(in_start_ts timestamp, in_end_ts timestamp, in_offset number)
IS
BEGIN
    INSERT
    INTO
        core_owner.polling_sync
        (
            account_id,
            group_id,
            event_type,
            event_date
        )
    select id, group_id, event_type, event_date from (
        SELECT
            a.id,
            a.group_id,
            'I' event_type,
            in_end_ts event_date,
            max(cl.change_time) last_change_time
        FROM
            core_hist_owner.change_log cl,
            core_owner.credit_card cc,
            core_owner.account a
        WHERE
            cl.change_time between in_start_ts-in_offset and in_end_ts
        AND cl.item = 'CREDIT_CARD'
        AND cl.id = cc.id
        AND cc.account_id = a.id
        GROUP BY a.id, a.group_id
        UNION ALL
        SELECT
            a.id,
            a.group_id,
            'I',
            in_end_ts,
            max(cl.change_time) last_change_time
        FROM
            core_hist_owner.change_log cl,
            core_owner.paypal p,
            core_owner.account a
        WHERE
            cl.change_time between in_start_ts-in_offset and in_end_ts
        AND cl.item = 'PAYPAL'
        AND cl.id = p.id
        AND p.account_id = a.id
        GROUP BY a.id, a.group_id
        UNION ALL
        SELECT
            a.id,
            a.group_id,
            'S',
            in_end_ts,
            max(cl.change_time) last_change_time
        FROM
            core_hist_owner.change_log cl,
            core_owner.subscription s,
            core_owner.account a
        WHERE
            cl.change_time between in_start_ts-in_offset and in_end_ts
        AND cl.item = 'SUBSCRIPTION'
        AND cl.id = s.id
        AND s.account_id = a.id
        GROUP BY a.id, a.group_id
        UNION ALL
        SELECT
            a.id,
            a.group_id,
            'G',
            in_end_ts,
            max(cl.change_time) last_change_time
        FROM
            core_hist_owner.change_log cl,
            core_owner.gift_certificate gc,
            core_owner.account a
        WHERE
            cl.change_time between in_start_ts-in_offset and in_end_ts
        AND cl.item = 'GIFT_CERTIFICATE'
        AND cl.id = gc.id
        AND gc.purchaser_group_id = a.group_id
        GROUP BY a.id, a.group_id
    ) t
    where not exists (
        select 1 --ps.account_id, ps.group_id, ps.event_type
        from polling_sync ps
        where ps.account_id = t.id
          and ps.group_id = t.group_id
          and ps.event_type = t.event_type
          and ps.event_date >= t.last_change_time
    )
    ;
END;
--------------------------------------------------------------------------------
FUNCTION CREATE_NEW_TRANSFER_SET
    (
        in_set_maximum NUMBER)
    RETURN core_owner.polling_sync.set_id%type
IS
    pragma autonomous_transaction;
    v_set_id core_owner.polling_sync.set_id%type;
BEGIN
    SELECT
        pollsync_setid_seq.nextval
    INTO
        v_set_id
    FROM
        dual;
    update
      core_owner.polling_sync ps
    set
      ps.set_id = v_set_id
    where
      ps.set_id IS NULL and
      rownum <= in_set_maximum
    ;
    COMMIT;
    RETURN v_set_id;
END;
--------------------------------------------------------------------------------
FUNCTION RETREIVE_TRANSFER_SET
    (
        in_set_id core_owner.polling_sync.set_id%type)
    RETURN sys_refcursor
IS
    v_refcursor sys_refcursor;
BEGIN
    UPDATE
        core_owner.polling_sync ps
    SET
        ps.last_send_date = sysdate,
        ps.num_calls = ps.num_calls + 1
    WHERE
        ps.set_id = in_set_id ;
    OPEN v_refcursor FOR
    SELECT
        ps.set_id,
        ps.group_id,
        ps.event_type,
        ps.event_date
    FROM
        core_owner.polling_sync ps
    WHERE
        ps.set_id = in_set_id
    AND ps.group_id IS NOT NULL ;
    RETURN v_refcursor;
END;
--------------------------------------------------------------------------------
PROCEDURE GET_TRANSFER_SET
    (
        in_set_maximum NUMBER,
        in_max_retries NUMBER,
        out_refcursor OUT sys_refcursor)
IS
    v_set_id core_owner.polling_sync.set_id%type;
BEGIN
    /* Look for previously sent but unconfirmed sets and
    send again until max_retries calls */
    FOR x IN
    (
        SELECT
            ps.set_id,
            COUNT( *) set_size
        FROM
            core_owner.polling_sync ps
        WHERE
            ps.event_date > sysdate - 14
        AND ps.confirm_date IS NULL
        AND ps.last_send_date IS NOT NULL
        AND ps.num_calls < in_max_retries
        GROUP BY
            ps.set_id
        ORDER BY
            ps.set_id
    )
    LOOP
        out_refcursor := Retreive_Transfer_Set(x.set_id) ;
        RETURN;
    END LOOP;
    v_set_id := Create_New_Transfer_Set(in_set_maximum) ;
    out_refcursor := Retreive_Transfer_Set(v_set_id) ;
    RETURN;
END;
--------------------------------------------------------------------------------
PROCEDURE CONFIRM_TRANSFER_SET
    (
        in_set_id core_owner.polling_sync.set_id%type)
IS
    v_unconfirmable EXCEPTION;
BEGIN
    UPDATE
        core_owner.polling_sync ps
    SET
        ps.confirm_date = systimestamp
    WHERE
        ps.set_id = in_set_id
    AND ps.confirm_date IS NULL ;
    IF(sql%rowcount < 1) THEN
        raise v_unconfirmable;
    END IF;
END;
PROCEDURE SET_LAST_RUN(ts in timestamp)
IS
BEGIN
    UPDATE POLLING_SYNC_LASTRUN
    SET last_run = current_timestamp;
    IF ( sql%rowcount = 0 )
    THEN
      INSERT INTO POLLING_SYNC_LASTRUN VALUES (ts);
    END if;
    COMMIT;
END;
PROCEDURE GET_LAST_RUN(ts out timestamp)
IS
BEGIN
    SELECT LAST_RUN INTO ts
    FROM POLLING_SYNC_LASTRUN
    WHERE ROWNUM < 2;
EXCEPTION
  WHEN NO_DATA_FOUND
  THEN
    ts := current_timestamp;
END;
END PROCS_POLLING_SYNC;
.
/

CREATE OR REPLACE PACKAGE BODY "PROCS_PRODUCT_V18" AS

PROCEDURE GET_PRODUCTS (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_status_id   IN  NUMBER,
  out_result_set OUT SYS_REFCURSOR
) AS
SPROC_NAME CONSTANT VARCHAR2(12) := 'GET_PRODUCTS';
BEGIN
  OPEN out_result_set FOR
  SELECT
    PRODUCT.ID,
    PRODUCT.NAME,
    PRODUCT.UNIT_PRICE,
    PRODUCT.PRODUCTION_COST,
    PRODUCT.CREATE_DATE,
    PRODUCT.CREATED_BY,
    PRODUCT.PRODUCT_STATUS_ID,
    PRODUCT.PRODUCT_URI
  FROM
    PRODUCT
 WHERE
    PRODUCT.PRODUCT_STATUS_ID = NVL(in_status_id, PRODUCT.PRODUCT_STATUS_ID);
EXCEPTION
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END GET_PRODUCTS;

/******************************************************************************/

PROCEDURE GET_PRODUCT_OFFERING_META_DATA (
  in_product_offering_id  IN NUMBER,
  out_result_set OUT SYS_REFCURSOR
) AS
SPROC_NAME CONSTANT VARCHAR2(30) := 'GET_PRODUCT_OFFERING_META_DATA';
-- VARIABLES
temp_product_offering_id NUMBER;
-- EXCEPTIONS
BAD_PRODUCT_OFFERING_ID EXCEPTION;
BEGIN
  
  -- Check that product offering exists
  BEGIN
    SELECT
      PRODUCT_OFFERING.ID into temp_product_offering_id
    FROM
      PRODUCT_OFFERING
    WHERE
      PRODUCT_OFFERING.ID = in_product_offering_id;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE BAD_PRODUCT_OFFERING_ID;
  END;
  
  OPEN out_result_set FOR
  SELECT
    PRODUCT_OFFERING_META_DATA.ID,
    PRODUCT_OFFERING_META_DATA.NAME,
    PRODUCT_OFFERING_META_DATA.VALUE,
    PRODUCT_OFFERING_META_DATA.CREATED_BY,
    PRODUCT_OFFERING_META_DATA.CREATE_DATE
  FROM
    PRODUCT_OFFERING_META_DATA
  WHERE
    PRODUCT_OFFERING_META_DATA.PRODUCT_OFFERING_ID = in_product_offering_id;

EXCEPTION
WHEN BAD_PRODUCT_OFFERING_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'No such product offering id');
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END GET_PRODUCT_OFFERING_META_DATA;

/******************************************************************************/

PROCEDURE GET_PRODUCT_ELIGIBIL_BY_NAME (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_product_id       IN NUMBER,
  in_eligibility_name IN VARCHAR2 DEFAULT NULL,
  out_result_set      OUT SYS_REFCURSOR
) AS
SPROC_NAME CONSTANT VARCHAR2(28) := 'GET_PRODUCT_ELIGIBIL_BY_NAME';
-- VARIABLES
temp_product_id NUMBER;
-- EXCEPTIONS
BAD_PRODUCT_ID EXCEPTION;
BEGIN
  
  BEGIN
    SELECT
      PRODUCT.ID into temp_product_id
    FROM
      PRODUCT
    WHERE
      PRODUCT.ID = in_product_id;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE BAD_PRODUCT_ID;
  END;
  
  OPEN out_result_set FOR
  SELECT
    PRODUCT_ELIGIBILITY.ID
  FROM
    PRODUCT_ELIGIBILITY
  WHERE
    PRODUCT_ELIGIBILITY.ID = in_product_id
    AND UPPER(PRODUCT_ELIGIBILITY.NAME) = UPPER(NVL(in_eligibility_name, PRODUCT_ELIGIBILITY.NAME));

EXCEPTION
WHEN BAD_PRODUCT_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'No such product');
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END GET_PRODUCT_ELIGIBIL_BY_NAME;

/******************************************************************************/

PROCEDURE GET_PRODUCT_BY_ID (
  in_product_id  IN NUMBER,
  out_result_set OUT SYS_REFCURSOR
) AS
SPROC_NAME CONSTANT VARCHAR2(17) := 'GET_PRODUCT_BY_ID';
-- VARIABLES
temp_product_id NUMBER;
-- EXCEPTIONS
BAD_PRODUCT_ID EXCEPTION;
BEGIN
  
  BEGIN
    SELECT
      PRODUCT.ID into temp_product_id
    FROM
      PRODUCT
    WHERE
      PRODUCT.ID = in_product_id;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE BAD_PRODUCT_ID;
  END;

  OPEN out_result_set FOR
  SELECT
    PRODUCT.ID,
    PRODUCT.NAME,
    PRODUCT.PRODUCT_STATUS_ID,
    PRODUCT.PRODUCT_URI,
    PRODUCT.PRODUCTION_COST,
    PRODUCT.UNIT_PRICE,
    PRODUCT.CREATE_DATE,
    PRODUCT.CREATED_BY
  FROM
    PRODUCT
  WHERE
    PRODUCT.ID = in_product_id;

EXCEPTION
WHEN BAD_PRODUCT_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'No such product');
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END GET_PRODUCT_BY_ID;

/******************************************************************************/

PROCEDURE GET_PRD_OFFERING_BY_LINE_IT_ID (
  in_line_item_id IN NUMBER,
  out_result_set  OUT SYS_REFCURSOR
) AS
SPROC_NAME CONSTANT VARCHAR2(30) := 'GET_PRD_OFFERING_BY_LINE_IT_ID';
-- VARIABLES
temp_line_item_id NUMBER;
-- EXCEPTIONS
BAD_LINE_ITEM_ID EXCEPTION;
BEGIN
  
  BEGIN
    SELECT
      LINE_ITEM.ID into temp_line_item_id
    FROM
      LINE_ITEM
    WHERE
      LINE_ITEM.ID = in_line_item_id;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE BAD_LINE_ITEM_ID;
  END;
  
  OPEN out_result_set FOR
  SELECT
    PRODUCT_OFFERING.ID,
    PRODUCT_OFFERING.PRODUCT_ID,
    PRODUCT_OFFERING.QUANTITY,
    PRODUCT_OFFERING.UNIT_PRICE,
    PRODUCT_OFFERING.TAX_CATEGORY_ID,
    PRODUCT_OFFERING.CREATE_DATE,
    PRODUCT_OFFERING.CREATED_BY,
    PRODUCT_OFFERING.TAX_POLICY_TYPE_ID,
    CAPABILITY.ID CAP_ID,
    CAPABILITY.CODE CAP_CODE,
    CAPABILITY.DESCRIPTION CAP_DESCRIPTION,
    CAPABILITY.SHAREABLE CAP_SHAREABLE
  FROM
    PRODUCT_OFFERING
    INNER JOIN LINE_ITEM ON LINE_ITEM.PRODUCT_OFFER_ID = PRODUCT_OFFERING.ID
    INNER JOIN CAPABILITY ON PRODUCT_OFFERING.CAPABILITY_ID = CAPABILITY.ID
  WHERE
    LINE_ITEM.ID = in_line_item_id;

EXCEPTION
WHEN BAD_LINE_ITEM_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'No such line item');
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'Unknown error', SQLERRM);
END GET_PRD_OFFERING_BY_LINE_IT_ID;

/******************************************************************************/

PROCEDURE GET_PRD_OFFERING_BY_ID (
  in_product_offering_id IN NUMBER,
  out_result_set  OUT SYS_REFCURSOR
) AS
SPROC_NAME CONSTANT VARCHAR2(30) := 'GET_PRD_OFFERING_BY_ID';
BEGIN
  OPEN out_result_set FOR
  SELECT
    PRODUCT_OFFERING.ID,
    PRODUCT_OFFERING.PRODUCT_ID,
    PRODUCT_OFFERING.QUANTITY,
    PRODUCT_OFFERING.UNIT_PRICE,
    PRODUCT_OFFERING.TAX_CATEGORY_ID,
    PRODUCT_OFFERING.CREATE_DATE,
    PRODUCT_OFFERING.CREATED_BY,
    CAPABILITY.ID CAP_ID,
    CAPABILITY.CODE CAP_CODE,
    CAPABILITY.DESCRIPTION CAP_DESCRIPTION,
    CAPABILITY.SHAREABLE CAP_SHAREABLE
  FROM
    PRODUCT_OFFERING
    INNER JOIN CAPABILITY ON PRODUCT_OFFERING.CAPABILITY_ID = CAPABILITY.ID
  WHERE
    PRODUCT_OFFERING.ID = in_product_offering_id;

EXCEPTION
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'Unknown error', SQLERRM);
END GET_PRD_OFFERING_BY_ID;

/******************************************************************************/

PROCEDURE GET_PRODUCT_OFFERING_DISCOUNTS(
  in_product_offering_id IN NUMBER,
  out_result_set         OUT SYS_REFCURSOR
) AS
SPROC_NAME CONSTANT VARCHAR2(30) := 'GET_PRODUCT_OFFERING_DISCOUNTS';
-- VARIABLES
temp_product_offering_id NUMBER;
-- EXCEPTIONS
BAD_PRODUCT_OFFERING_ID EXCEPTION;
BEGIN
  
  BEGIN
    SELECT
      PRODUCT_OFFERING.ID into temp_product_offering_id
    FROM
      PRODUCT_OFFERING
    WHERE
      PRODUCT_OFFERING.ID = in_product_offering_id;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE BAD_PRODUCT_OFFERING_ID;
  END;
  
  OPEN out_result_set FOR
  SELECT
    DISCOUNT.ID,
    DISCOUNT.NAME,
    DISCOUNT.FIXED_AMOUNT,
    DISCOUNT.PERCENT_AMOUNT,
    DISCOUNT.DISCOUNT_TYPE_ID,
    DISCOUNT.CREATE_DATE,
    DISCOUNT.CREATED_BY,
    DISCOUNT.DESCRIPTION
  FROM
    DISCOUNT
    INNER JOIN DISCOUNT_PRODUCT_OFFERING on DISCOUNT.ID = DISCOUNT_PRODUCT_OFFERING.DISCOUNT_ID
  WHERE
    DISCOUNT_PRODUCT_OFFERING.PRODUCT_OFFERING_ID = in_product_offering_id;

EXCEPTION
WHEN BAD_PRODUCT_OFFERING_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'No such product offering');
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END GET_PRODUCT_OFFERING_DISCOUNTS;

END PROCS_PRODUCT_V18;
.
/

CREATE OR REPLACE
PACKAGE BODY PROCS_REPORTING AS

----
--------------------------------------------------------------------------------
----
    procedure ext_charge(in_start_date date, in_end_date date, out_cursor out sys_refcursor)
    is
    begin
        open out_cursor for
            with ids as ( select id from change_log cl where cl.item = 'CHARGE' and cl.change_time between in_start_date and in_end_date group by id )
            select c.id charge_id, c.invoice_id, c.transaction_id, c.instrument_type_id, it.value instrument_type
                  ,c.instrument_id, c.charge_amount, c.charge_status_id, cs.value charge_status
                  ,c.create_date, c.update_date
            from charge c
                ,charge_status cs
                ,instrument_type it
                ,ids
            where c.id = ids.id
              and c.charge_status_id = cs.id
              and c.instrument_type_id = it.id
        ;
    end;
----
--------------------------------------------------------------------------------
----
    procedure ext_license(in_start_date date, in_end_date date, out_cursor out sys_refcursor)
    is
    begin
        open out_cursor for
            with ids as (select id from change_log cl where cl.item = 'LICENSE' and cl.change_time between in_start_date and in_end_date group by id)
            select l.id license_id, l.start_date, l.end_date, l.offer_id, l.subscription_id, l.invoice_id
                  ,l.license_status_id, ls.value license_status ,l.create_date, l.update_date
                  ,l.current_offer_index, l.current_offer_recurr_num, l.entitlement_end_date, l.grace_start_date, l.grace_end_date
            from license l
                ,license_status ls
                ,ids
            where l.id = ids.id
              and l.license_status_id = ls.id
        ;
    end;
----
--------------------------------------------------------------------------------
----
    procedure ext_invoice(in_start_date date, in_end_date date, out_cursor out sys_refcursor)
    is
    begin
        open out_cursor for
            with ids as ( select id from change_log cl where cl.item = 'INVOICE' and cl.change_time between in_start_date and in_end_date group by id )
            select
              i.id invoice_id,
              i.create_date,
              i.update_date,
              i.invoice_status_id,
              istat.value invoice_status,
              NVL(
                 (select offer_chain_id from gift_certificate g where g.purchase_invoice_id = i.id and rownum <= 1),
                 (select offer_chain_id from subscription s, license l where l.subscription_id = s.id and l.invoice_id = i.id and rownum <= 1)
              ) offer_chain_id
            from     invoice i
                join invoice_status istat ON istat.id = i.invoice_status_id
                join ids                  on ids.id = i.id
            where 1 = 1
        ;
    end;
----
--------------------------------------------------------------------------------
----
    procedure ext_line_item(in_start_date date, in_end_date date, out_cursor out sys_refcursor)
    is
    begin
        open out_cursor for
            with ids as ( select id from change_log cl where cl.item = 'LINE_ITEM' and cl.change_time between in_start_date and in_end_date group by id )
            select li.id line_item_id, li.invoice_id, li.product_offer_id, li.amount, li.quantity
              ,li.discount_amount, li.taxes_amount, li.create_date
            from line_item li
              , ids
            where li.id = ids.id
        ;
    end;
----
--------------------------------------------------------------------------------
----
    procedure ext_account(in_start_date date, in_end_date date, out_cursor out sys_refcursor)
    is
    begin
        open out_cursor for
            with ids as (select id from change_log cl where cl.item = 'ACCOUNT' and cl.change_time between in_start_date and in_end_date group by id)
            select a.id account_id, a.account_status_id, astat.value account_status, a.group_id, a.suspend_date
                  ,a.create_date, a.update_date, a.instrument_type_id, it.value instrument_type
                  ,a.instrument_id, a.tax_exempt_id
                  -- need system category??
            from account a
                ,account_status astat
                ,instrument_type it
                , ids
            where a.id = ids.id
              and astat.id = a.account_status_id
              and a.instrument_type_id = it.id(+)
        ;
    end;
----
--------------------------------------------------------------------------------
----
    procedure ext_subscription(in_start_date date, in_end_date date, out_cursor out sys_refcursor)
    is
    begin
        open out_cursor for
            with ids as (select id from change_log cl where cl.item = 'SUBSCRIPTION' and cl.change_time between in_start_date and in_end_date group by id)
            select s.id subscription_id, s.account_id, s.purchase_date, s.offer_chain_id
                  ,s.cancellation_date, sct.value cancellation_reason,0 cancellation_is_credit
                  ,s.create_date, s.update_date, s.subscription_status_id, ss.value subscription_status
                  ,s.instrument_type_id, it.value instrument_type, s.instrument_id, s.updated_by
            from subscription s
                ,subscription_status ss
                ,subscription_cancel_reason sct
                ,instrument_type it
                , ids
            where s.id = ids.id
              and ss.id = s.subscription_status_id
              and s.instrument_type_id = it.id
              and sct.id(+) = s.sct_id
        ;
    end;
----
--------------------------------------------------------------------------------
----
    procedure ext_transaction(in_start_date date, in_end_date date, out_cursor out sys_refcursor)
    is
    begin
        open out_cursor for
            with ids as (select id from change_log cl where cl.item = 'TRANSACTION' and cl.change_time between in_start_date and in_end_date group by id)
            select t.id transaction_id, t.transaction_amount
                  ,t.transaction_status_id, ts.value transaction_status, t.order_id
                  ,t.create_date, t.update_date, t.is_settled
            from transaction t
                ,transaction_status ts
                , ids
            where t.id = ids.id
              and t.transaction_status_id = ts.id
        ;
    end;
----
--------------------------------------------------------------------------------
----
    procedure ext_offer_chain(in_start_date date, in_end_date date, out_cursor out sys_refcursor)
    is
    begin
        open out_cursor for
            with ids as (select id from change_log cl where cl.item = 'OFFER_CHAIN' and cl.change_time between in_start_date and in_end_date group by id)
            select oc.id offer_chain_id, oc.name, oc.description, oc.offer_chain_status_id, ocs.value offer_chain_status
                  ,oc.adoptability_window_start_date adoptability_start_date, oc.adoptability_window_end_date adoptability_end_date
                  ,oc.is_gift_certificate, oc.product_uri, oc.create_date, oc.update_date, oc.vendor_source_id, vs.name vendor_source_name
                  ,oc.billing_source_id, bs.name billing_source_name
                  ,oc.is_seat_license,oc.group_account_type_id
            from offer_chain oc
                , offer_chain_status ocs
                , ids
                , vendor_source vs
                , billing_source bs
            where oc.id = ids.id
              and oc.offer_chain_status_id = ocs.id
              and oc.vendor_source_id = vs.id
              and oc.billing_source_id = bs.id
        ;
    end;
----
--------------------------------------------------------------------------------
----
    procedure ext_offer_offer_chain(in_start_date date, in_end_date date, out_cursor out sys_refcursor)
    is
    begin
        open out_cursor for
            with ids as (select combined_id id from change_log cl where cl.item = 'OFFER_OFFER_CHAIN' and cl.change_time between in_start_date and in_end_date group by combined_id)
            select ooc.offer_id||'~'||ooc.offer_chain_id offer_offer_chain_id, ooc.offer_id, ooc.offer_chain_id
                  ,ooc.index_value, ooc.num_recurrences, ooc.create_date, ooc.update_date
            from offer_offer_chain ooc
            , ids
            where ooc.offer_id||'~'||ooc.offer_chain_id = ids.id
        ;
    end;
----
--------------------------------------------------------------------------------
----
    procedure ext_offer(in_start_date date, in_end_date date, out_cursor out sys_refcursor)
    is
    begin
        open out_cursor for
            with ids as (select id from change_log cl where cl.item = 'OFFER' and cl.change_time between in_start_date and in_end_date group by id)
            select o.id offer_id, o.offer_status_id, os.value offer_status, o.entitlement_duration, o.create_date, o.update_date
            from offer o
                ,offer_status os
                , ids
            where o.id = ids.id
              and o.offer_status_id = os.id
        ;
    end;
----
--------------------------------------------------------------------------------
----
    procedure ext_gift_certificate(in_start_date date, in_end_date date, out_cursor out sys_refcursor)
    is
    begin
        open out_cursor for
            with ids as (select id from change_log cl where cl.item = 'GIFT_CERTIFICATE' and cl.change_time between in_start_date and in_end_date group by id)
            select  gc.id gift_certificate_id, gc.purchaser_group_id, gc.purchase_invoice_id, gc.offer_chain_id
                   ,gc.expiration_date, gc.purchase_date
                   ,gc.gift_certificate_status_id, gcs.value gift_certificate_status, gc.redeemer_group_id
                   ,gc.finalized_invoice_id, gc.create_date, gc.update_date
                   ,recipient_address_id
                   ,redeemer_address_id
                   ,recipient_notify_date
                   ,recipient_name
                   ,redemption_date
                   ,recipient_email
            from gift_certificate gc
                ,gift_certificate_status gcs
                , ids
            where gc.id = ids.id
              and gc.gift_certificate_status_id = gcs.id
        ;
    end;
----
--------------------------------------------------------------------------------
----
    procedure ext_product_offering(in_start_date date, in_end_date date, out_cursor out sys_refcursor)
    is
    begin
        open out_cursor for
            with ids as (select id from change_log cl where cl.item = 'PRODUCT_OFFERING' and cl.change_time between in_start_date and in_end_date group by id)
            select po.id product_offering_id, po.product_id, po.unit_price, po.quantity, po.create_date
            from product_offering po
            , ids
            where po.id = ids.id
        ;
    end;
----
--------------------------------------------------------------------------------
----
    procedure ext_product(in_start_date date, in_end_date date, out_cursor out sys_refcursor)
    is
    begin
        open out_cursor for
            with ids as (select id from change_log cl where cl.item = 'PRODUCT' and cl.change_time between in_start_date and in_end_date group by id)
            select p.id product_id, p.name, p.unit_price, p.production_cost, p.product_status_id, ps.value product_status
                  ,product_uri, p.create_date
            from product p
                ,product_status ps
                , ids
            where p.id = ids.id
              and p.product_status_id = ps.id
        ;
    end;
----
--------------------------------------------------------------------------------
----
    procedure ext_offer_product_offering(in_start_date date, in_end_date date, out_cursor out sys_refcursor)
    is
    begin
        open out_cursor for
            with ids as (select combined_id id from change_log cl where cl.item = 'OFFER_PRODUCT_OFFERING' and cl.change_time between in_start_date and in_end_date group by combined_id)
            select opo.product_offering_id||'~'||opo.offer_id, opo.product_offering_id, opo.offer_id, opo.create_date
            from offer_product_offering opo
            , ids
            where opo.product_offering_id||'~'||opo.offer_id = ids.id
        ;
    end;
----
--------------------------------------------------------------------------------
----
    procedure ext_discount_product_offering(in_start_date date, in_end_date date, out_cursor out sys_refcursor)
    is
    begin
        open out_cursor for
            with ids as (select combined_id id from change_log cl where cl.item = 'DISCOUNT_PRODUCT_OFFERING' and cl.change_time between in_start_date and in_end_date group by combined_id)
            select dpo.discount_id||'~'||dpo.product_offering_id, dpo.discount_id, dpo.product_offering_id, dpo.create_date
            from discount_product_offering dpo
            , ids
            where dpo.discount_id||'~'||dpo.product_offering_id = ids.id
        ;
    end;
----
--------------------------------------------------------------------------------
----
    procedure ext_discount(in_start_date date, in_end_date date, out_cursor out sys_refcursor)
    is
    begin
        open out_cursor for
            with ids as (select id from change_log cl where cl.item = 'DISCOUNT' and cl.change_time between in_start_date and in_end_date group by id)
            select d.id discount_id, d.name, d.description, d.fixed_amount, d.percent_amount
                  ,d.discount_type_id, dt.value discount_type, d.create_date
            from discount d
                ,discount_type dt
                , ids
            where d.id = ids.id
              and d.discount_type_id = dt.id
        ;
    end;
----
--------------------------------------------------------------------------------
----
    procedure ext_product_eligibility(in_start_date date, in_end_date date, out_cursor out sys_refcursor)
    is
    begin
        open out_cursor for
            with ids as (select id from change_log cl where cl.item = 'PRODUCT_ELIGIBILITY' and cl.change_time between in_start_date and in_end_date group by id)
            select pg.id product_eligibility_id, pg.product_id, pg.name, pg.value, pg.create_date
            from product_eligibility pg
            , ids
            where pg.id = ids.id
        ;
    end;
----
--------------------------------------------------------------------------------
----
    procedure ext_offer_chain_eligibility(in_start_date date, in_end_date date, out_cursor out sys_refcursor)
    is
    begin
        open out_cursor for
            with ids as (select id from change_log cl where cl.item = 'OFFER_CHAIN_ELIGIBILITY' and cl.change_time between in_start_date and in_end_date group by id)
            select oce.id offer_chain_eligibility_id, oce.offer_chain_id, oce.name, oce.value, oce.create_date
            from offer_chain_eligibility oce
            , ids
            where oce.id = ids.id
        ;
    end;
----
--------------------------------------------------------------------------------
----
    procedure ext_offer_chain_metadata(in_start_date date, in_end_date date, out_cursor out sys_refcursor)
    is
    begin
        open out_cursor for
            with ids as (select id from change_log cl where cl.item = 'OFFER_CHAIN_META_DATA' and cl.change_time between in_start_date and in_end_date group by id)
            select ocm.id offer_chain_meta_data_id, ocm.offer_chain_id, ocm.name, ocm.value, ocm.create_date
            from offer_chain_meta_data ocm
            , ids
            where ocm.id = ids.id
        ;
    end;
----
--------------------------------------------------------------------------------
----
    procedure ext_product_offering_metadata(in_start_date date, in_end_date date, out_cursor out sys_refcursor)
    is
    begin
        open out_cursor for
            with ids as (select id from change_log cl where cl.item = 'PRODUCT_OFFERING_META_DATA' and cl.change_time between in_start_date and in_end_date group by id)
            select pom.id prod_offer_meta_data_id, pom.product_offering_id, pom.name, pom.value, pom.create_date
            from product_offering_meta_data pom
            , ids
            where pom.id = ids.id
        ;
    end;
----
--------------------------------------------------------------------------------
----
    procedure ext_subscription_metadata(in_start_date date, in_end_date date, out_cursor out sys_refcursor)
    is
    begin
        open out_cursor for
            with ids as (select id from change_log cl where cl.item = 'SUBSCRIPTION_META_DATA' and cl.change_time between in_start_date and in_end_date group by id)
            select sm.id subscription_meta_data_id, sm.subscription_id, sm.name, sm.value, sm.create_date
            from subscription_meta_data sm
            , ids
            where sm.id = ids.id
        ;
    end;
----
--------------------------------------------------------------------------------
----
    procedure ext_credit_card(in_start_date date, in_end_date date, out_cursor out sys_refcursor)
    is
    begin
        open out_cursor for
            with ids as (select id from change_log cl where cl.item = 'CREDIT_CARD' and cl.change_time between in_start_date and in_end_date group by id)
            select cc.id credit_card_id, cc.account_id, cc.instrument_name, cc.state, cc.city, cc.postal_code
                  ,cc.country, cc.expiration_date, cc.credit_card_type_id, cct.value credit_card_type
                  ,cc.credit_card_status_id, ccs.value credit_card_status, cc.create_date, cc.update_date
            from credit_card cc
                ,credit_card_type cct
                ,credit_card_status ccs
                , ids
            where cc.id = ids.id
              and cc.credit_card_type_id = cct.id(+)
              and cc.credit_card_status_id = ccs.id
        ;
    end;
----
--------------------------------------------------------------------------------
----
    procedure ext_transaction_attempt(in_start_date date, in_end_date date, out_cursor out sys_refcursor)
    is
    begin
        open out_cursor for
            with ids as (select id from change_log cl where cl.item = 'TRANSACTION_ATTEMPT' and cl.change_time between in_start_date and in_end_date group by id)
            select ta.id transaction_attempt_id, ta.transaction_id, ta.external_transaction_id
                  ,ta.transaction_start_time, ta.external_status_code, ta.external_status_message
                  ,ta.transaction_attempt_status_id trans_attempt_status_id, tas.value transaction_attempt_status
                  ,ta.create_date
            from transaction_attempt ta
                ,transaction_attempt_status tas
                , ids
            where ta.id = ids.id
              and ta.transaction_attempt_status_id = tas.id
        ;
    end;
----
--------------------------------------------------------------------------------
----
    procedure ext_invoice_adjustment(in_start_date date, in_end_date date, out_cursor out sys_refcursor)
    is
    begin
        open out_cursor for
            with ids as (select id from change_log cl where cl.item = 'INVOICE_ADJUSTMENT' and cl.change_time between in_start_date and in_end_date group by id)
            select ia.id invoice_adjustment_id, ia.invoice_id, ia.is_credit, ir.value adjustment_reason, ia.charge_id
                  ,ia.adjustment_date, ia.create_date
            from invoice_adjustment ia, invoice_adjustment_reason ir
            , ids
            where ia.id = ids.id
            and ir.id = ia.invoice_adjustment_reason_id
        ;
    end;
----
--------------------------------------------------------------------------------
----

    procedure ext_line_item_adjustment(in_start_date date, in_end_date date, out_cursor out sys_refcursor)
    is
    begin
        open out_cursor for
            with ids as (select id from change_log cl where cl.item = 'LINE_ITEM_ADJUSTMENT' and cl.change_time between in_start_date and in_end_date group by id)
            select lia.id line_item_adjustment_id, lia.line_item_id, lia.invoice_adjustment_id, lia.amount, lia.tax, lia.discount, lia.create_date
            from line_item_adjustment lia
            , ids
            where lia.id = ids.id
        ;
    end;
----
--------------------------------------------------------------------------------
----

    procedure ext_tax(in_start_date date, in_end_date date, out_cursor out sys_refcursor)
    is
    begin
        open out_cursor for
            with ids as (select id from change_log cl where cl.item = 'TAX' and cl.change_time between in_start_date and in_end_date group by id)
            select
              tax.id tax_id,
              ttype.code tax_type,
              tax.calculated_amount,
              tax.create_date,
              tax.line_item_id,
              tax.effective_rate,
              tax.taxable_amount,
              tax.tax_rule_id,
              j.name jurisdiction_level,
              tax.jurisdiction_name,
              tax.jurisdiction_id,
              tax.ext_tax_type,
              tax.ext_result,
              tax.imposition_type,
              tax.imposition
            from tax
            , tax_type ttype
            , jurisdiction_level j
            , ids
            where tax.id = ids.id and ttype.id = tax.tax_type_id and j.id = tax.jurisdiction_level_id
        ;
    end;
----
--------------------------------------------------------------------------------
----
    procedure ext_tax_adjustment(in_start_date date, in_end_date date, out_cursor out sys_refcursor)
    is
    begin
        open out_cursor for
            with ids as (select id from change_log cl where cl.item = 'TAX_ADJUSTMENT' and cl.change_time between in_start_date and in_end_date group by id)
            select
              tax.id tad_adjustment_id,
              tax.tax_id tax_id,
              tax.line_item_adjustment_id line_item_adjustment_id,
              tax.amount tax_amount,
              tax.create_date create_date
            from tax_adjustment tax
            , ids
            where tax.id = ids.id
        ;
    end;
----
--------------------------------------------------------------------------------
----
/**/
    procedure ext_rcn_ext_source_log(in_start_date date, in_end_date date, out_cursor out sys_refcursor) IS
    BEGIN
      OPEN OUT_CURSOR FOR
      with ids As ( SELECT cl.id FROM change_log cl where cl.item = 'RCN_EXT_SOURCE_LOG' and change_time between in_start_date and in_end_date group by cl.id )
      SELECT
          t.id rcn_ext_source_log_id
        , t.extraction_timestamp
        , t.report_date
        , t.report_generation_datetime
        , t.record_type
        , t.report_file_name
        , t.create_date
        , t.created_by
      FROM rcn_ext_source_log t, ids
      WHERE ids.id = t.id;
    END;

    procedure ext_rcn_cpt_svc_chg_dtl(in_start_date date, in_end_date date, out_cursor out sys_refcursor) IS
    BEGIN
      OPEN OUT_CURSOR FOR
      with ids As ( SELECT cl.id FROM change_log cl where cl.item = 'RCN_CPT_SERVICE_CHARGE_DETAIL' and change_time between in_start_date and in_end_date group by cl.id )
      SELECT
          t.id rcn_cpt_svc_chg_dtl_id
        , t.rcn_ext_source_log_id
        , t.record_type
        , t.category
        , t.sub_category
        , t.entity_type
        , t.entity_number
        , t.funds_transfer_inst_number
        , t.secure_ba_number
        , t.settlement_currency
        , t.fee_schedule
        , t.mop
        , t.interchange_qualification
        , t.fee_type_description
        , t.action_type
        , t.unit_quantity
        , t.unit_fee
        , t.amount
        , t.percentage_rate
        , t.total_charge
        , t.create_date
        , t.created_by
      FROM rcn_cpt_service_charge_detail t, ids
      WHERE ids.id = t.id;
    END;
----
--------------------------------------------------------------------------------
----

    procedure ext_rcn_cpt_excpt_dtl(in_start_date date, in_end_date date, out_cursor out sys_refcursor) IS
    BEGIN
      OPEN OUT_CURSOR FOR
      with ids As ( SELECT cl.id FROM change_log cl where cl.item = 'RCN_CPT_EXCEPTION_DETAIL' and change_time between in_start_date and in_end_date group by cl.id )
      SELECT
          t.id rcn_cpt_excp_dtl_id
        , t.rcn_ext_source_log_id
        , t.record_type
        , t.submission_date
        , t.pid_number
        , t.pid_short_name
        , t.submission_number
        , t.record_number
        , t.entity_type
        , t.entity_number
        , t.presentment_currency
        , t.merchant_order_number
        , t.rdfi_number
        , t.account_number
        , t.expiration_date
        , t.amount
        , t.mop
        , t.action_code
        , t.auth_date
        , t.auth_code
        , t.auth_response_code
        , t.trace_number
        , t.consumer_country_code
        , t.category
        , t.mcc
        , t.reject_code
        , t.submission_status
        , t.create_date
        , t.created_by
      FROM rcn_cpt_exception_detail t, ids
      WHERE ids.id = t.id;
    END;
----
--------------------------------------------------------------------------------
----

    procedure ext_rcn_cpt_dpst_dtl(in_start_date date, in_end_date date, out_cursor out sys_refcursor) IS
    BEGIN
      OPEN OUT_CURSOR FOR
      with ids As ( SELECT cl.id FROM change_log cl where cl.item = 'RCN_CPT_DEPOSIT_DETAIL' and change_time between in_start_date and in_end_date group by cl.id )
        SELECT
          t.id rcn_cpt_deposit_dtl_id
        , t.rcn_ext_source_log_id
        , t.record_type
        , t.submission_date
        , t.pid_number
        , t.pid_short_name
        , t.submission_number
        , t.record_number
        , t.entity_type
        , t.entity_number
        , t.presentment_currency
        , t.merchant_order_number
        , t.rdfi_number
        , t.account_number
        , t.expiration_date
        , t.amount
        , t.mop
        , t.action_code
        , t.auth_date
        , t.auth_code
        , t.auth_response_code
        , t.trace_number
        , t.consumer_country_code
        , t.mcc
        , t.create_date
        , t.created_by
        , t.fee_code
        , t.unit_fee
        , t.percent_fee
        , t.total_interchange_fee
        , t.total_assessment_fee
        , t.other_fee
      FROM rcn_cpt_deposit_detail t, ids
      WHERE ids.id = t.id;
    END;
----
--------------------------------------------------------------------------------
----

    procedure ext_rcn_cpt_chgbk_act_dtl(in_start_date date, in_end_date date, out_cursor out sys_refcursor) IS
    BEGIN
      OPEN OUT_CURSOR FOR
      with ids As ( SELECT cl.id FROM change_log cl where cl.item = 'RCN_CPT_CHARGEBACK_ACT_DETAIL' and change_time between in_start_date and in_end_date group by cl.id )
      SELECT
          t.id rcn_cpt_chgbk_act_dtl_id
        , t.rcn_ext_source_log_id
        , t.record_type
        , t.entity_type
        , t.entity_number
        , t.chargeback_amount_issuer
        , t.prev_partial_representment
        , t.presentment_currency
        , t.chargeback_category
        , t.status_flag
        , t.sequence_number
        , t.merchant_order_number
        , t.account_number
        , t.reason_code
        , t.transaction_date
        , t.chargeback_date
        , t.activity_date
        , t.chargeback_amount_action
        , t.fee_amount
        , t.usage_code
        , t.mop_code
        , t.authorization_date
        , t.chargeback_due_date
        , t.create_date
        , t.created_by
      FROM rcn_cpt_chargeback_act_detail t, ids
      WHERE ids.id = t.id;
    END;
----
--------------------------------------------------------------------------------
----

    procedure ext_rcn_pp_sttlmnt(in_start_date date, in_end_date date, out_cursor out sys_refcursor) IS
    BEGIN
      OPEN OUT_CURSOR FOR
      with ids As ( SELECT cl.id FROM change_log cl where cl.item = 'RCN_PP_SETTLEMENT' and change_time between in_start_date and in_end_date group by cl.id )
      SELECT
          t.id rcn_pp_settlement_id
        , t.rcn_ext_source_log_id
        , t.transaction_id
        , t.invoice_id
        , t.pp_ref_id
        , t.pp_ref_id_type
        , t.trans_event_code
        , t.trans_init_date
        , t.trans_comp_date
        , t.trans_deb_or_cred
        , t.gross_trans_amount
        , t.gross_trans_currency
        , t.fee_deb_or_cred
        , t.fee_amount
        , t.fee_currency
        , t.custom_field
        , t.create_date
        , t.created_by
      FROM rcn_pp_settlement t, ids
      WHERE ids.id = t.id;
    END;
----
--------------------------------------------------------------------------------
----

    procedure ext_rcn_pp_dispute(in_start_date date, in_end_date date, out_cursor out sys_refcursor) IS
    BEGIN
      OPEN OUT_CURSOR FOR
      with ids As ( SELECT cl.id FROM change_log cl where cl.item = 'RCN_PP_DISPUTE' and change_time between in_start_date and in_end_date group by cl.id )
      SELECT
          t.id rcn_pp_dispute_id
        , t.rcn_ext_source_log_id
        , t.dispute_type
        , t.claimant_name
        , t.claimant_email
        , t.transaction_id
        , t.trans_date
        , t.disputed_amount
        , t.disputed_amount_currency
        , t.dispute_reason
        , t.dispute_filing_date
        , t.dispute_status
        , t.dispute_case_id
        , t.invoice_id
        , t.create_date
        , t.created_by
      FROM
      rcn_pp_dispute t, ids
      WHERE ids.id = t.id;
    END;
----
--------------------------------------------------------------------------------
----

    procedure ext_rcn_pp_trns_dtl(in_start_date date, in_end_date date, out_cursor out sys_refcursor) IS
    BEGIN
      OPEN OUT_CURSOR FOR
      with ids As ( SELECT cl.id FROM change_log cl where cl.item = 'RCN_PP_TRANS_DETAIL' and change_time between in_start_date and in_end_date group by cl.id )
      SELECT
          t.id rcn_pp_trans_dtl_id
        , t.rcn_ext_source_log_id
        , t.transaction_id
        , t.invoice_id
        , t.pp_ref_id
        , t.trans_event_code
        , t.trans_init_date
        , t.trans_comp_date
        , t.trans_deb_or_cred
        , t.gross_trans_amount
        , t.gross_trans_currency
        , t.fee_deb_or_cred
        , t.fee_amount
        , t.fee_currency
        , t.trans_status
        , t.insurance_amount
        , t.sales_tax_amount
        , t.shipping_amount
        , t.trans_subject
        , t.trans_note
        , t.payer_acct_id
        , t.payer_addr_status
        , t.item_name
        , t.item_id
        , t.option_1_name
        , t.option_1_value
        , t.option_2_name
        , t.option_2_value
        , t.auction_site
        , t.auction_buyer_id
        , t.auction_closing_date
        , t.shipping_addr_line_1
        , t.shipping_addr_line_2
        , t.shipping_addr_city
        , t.shipping_addr_state
        , t.shipping_addr_zip
        , t.shipping_addr_country
        , t.custom_field
        , t.create_date
        , t.created_by
      FROM rcn_pp_trans_detail t, ids
      WHERE ids.id = t.id;
    END;
----
--------------------------------------------------------------------------------
----
    procedure ext_rcn_amex_chargeback(in_start_date date, in_end_date date, out_cursor out sys_refcursor) IS
    BEGIN
      OPEN OUT_CURSOR FOR
      with ids As ( SELECT cl.id FROM change_log cl where cl.item = 'RCN_AMEX_CHARGEBACK' and change_time between in_start_date and in_end_date group by cl.id )
      SELECT
        rac.id
      , rac.rcn_ext_source_log_id
      , rac.resolution
      , rac.from_system
      , rac.rejects_to_system
      , rac.disputes_to_system
      , rac.date_of_adjustment
      , rac.date_of_charge
      , rac.case_type
      , rac.cb_reas_code
      , rac.cb_amount
      , rac.cb_adjustment_number
      , rac.billed_amount
      , rac.soc_amount
      , rac.foreign_amount
      , rac.currency
      , rac.note1
      , rac.note2
      , rac.note3
      , rac.note4
      , rac.note5
      , rac.note6
      , rac.note7
      , rac.ind_ref_number
      , rac.create_date
      , rac.created_by
      , rac.update_date
      , rac.updated_by
      FROM rcn_amex_chargeback rac, ids
      WHERE ids.id = rac.id;
    END;
----
--------------------------------------------------------------------------------
----
    procedure ext_paypal(in_start_date date, in_end_date date, out_cursor out sys_refcursor) IS
    BEGIN
      OPEN OUT_CURSOR FOR
      with ids as ( SELECT cl.id FROM change_log cl where cl.item = 'PAYPAL' and change_time between in_start_date and in_end_date group by cl.id )
      SELECT
          t.ID PAYPAL_ID
        , ACCOUNT_ID
        , INSTRUMENT_NAME
        , CREATE_DATE
        , CREATED_BY
        , UPDATE_DATE
        , UPDATED_BY
        , s.value PAYPAL_STATUS
        , STATE
        , CITY
        , POSTAL_CODE
        , COUNTRY
        , EXPIRATION_DATE
      FROM paypal t, paypal_status s, ids
      WHERE ids.id = t.id and t.paypal_status_id = s.id;
    END;
----
--------------------------------------------------------------------------------
----
    procedure ext_address(in_start_date date, in_end_date date, out_cursor out sys_refcursor) IS
    BEGIN
      OPEN OUT_CURSOR FOR
      with ids as ( SELECT cl.id FROM change_log cl where cl.item = 'ADDRESS' and change_time between in_start_date and in_end_date group by cl.id )
      SELECT
        a.id ADDRESS_ID,
        address1,
        address2,
        city,
        state,
        postal_code,
        country,
        create_date,
        created_by,
        update_date,
        updated_by
      FROM address a, ids
      WHERE ids.id = a.id;
    END;
----
--------------------------------------------------------------------------------
----
/**/
END PROCS_REPORTING;
.
/

create or replace PACKAGE BODY              "PROCS_REPORTING_1A" AS

----
--------------------------------------------------------------------------------
----
    function getDiscountAmount(in_line_item_id line_item.id%type)
        return line_item.amount%type
    is
        v_discount  line_item.amount%type := 0;
    begin
        for x in (
            select d.id discount_id
                  ,nvl(d.fixed_amount, d.percent_amount * (po.quantity * po.unit_price)) discount_amount
            from discount d
                join discount_line_item dli             on dli.discount_id = d.id
                join discount_product_offering dop      on dop.discount_id = d.id
                join product_offering po                on po.id = dop.product_offering_id
                join line_item li                       on li.id = dli.line_item_id and li.product_offer_id = po.id
            where dli.line_item_id = in_line_item_id
        )
        loop
            v_discount := v_discount + x.discount_amount;
        end loop;

        return v_discount;
    end;
----
--------------------------------------------------------------------------------
----
    function getRefundAmount(in_line_item_id line_item.id%type)
        return line_item.amount%type
    is
        v_li_total  line_item.amount%type;
        v_inv_total line_item.amount%type;
        v_ref_total line_item.amount%type;
    begin

        for li in (
            select li.invoice_id, po.*
            from line_item li
                    join core_owner.product_offering po on li.product_offer_id = po.id
            where li.id = in_line_item_id
        )
        loop
            v_li_total := (li.quantity * li.unit_price) - getDiscountAmount(in_line_item_id);

            v_inv_total := 0;
            v_ref_total := 0;
            for x in (
                select case when c.charge_amount < 0 then -1 else 1 end type, sum(c.charge_amount) total
                from charge c
                where c.invoice_id = li.invoice_id
                group by case when c.charge_amount < 0 then -1 else 1 end
            )
            loop
                if (x.type = 1) then
                    v_inv_total := x.total;
                else
                    v_ref_total := x.total;
                end if;
            end loop;

            if (v_inv_total > 0) then
                return (v_ref_total / v_inv_total) * v_li_total;
            else
                return 0;
            end if;

        end loop;

        return 0;
    end;
----
--------------------------------------------------------------------------------
----
  PROCEDURE EXTRACT_LINE_ITEMS(
    in_lower_date_bound DATE,
    in_upper_date_bound DATE,
    out_lic_cur OUT sys_refcursor
  ) AS
  BEGIN
    OPEN out_lic_cur FOR
    with liq as (
          SELECT li2.id
                FROM
                     line_item li2
                WHERE
                TRUNC(li2.create_date, 'HH') BETWEEN TRUNC(in_lower_date_bound,'HH') AND TRUNC(in_upper_date_bound,'HH')
          UNION
          SELECT li2.id
                FROM
                     line_item li2
                JOIN invoice i2 ON i2.id = li2.invoice_id
                WHERE
                TRUNC(i2.create_date, 'HH') BETWEEN TRUNC(in_lower_date_bound,'HH') AND TRUNC(in_upper_date_bound,'HH')
          UNION
          SELECT li2.id
                FROM
                     line_item li2
                JOIN license l2 ON li2.invoice_id = l2.invoice_id
                WHERE
                TRUNC(l2.create_date, 'HH') BETWEEN TRUNC(in_lower_date_bound,'HH') AND TRUNC(in_upper_date_bound,'HH')
          UNION
          SELECT li2.id
                FROM
                     line_item li2
                JOIN license l2 ON li2.invoice_id = l2.invoice_id
                JOIN subscription s2 ON s2.id = l2.subscription_id
                WHERE
                TRUNC(s2.create_date, 'HH') BETWEEN TRUNC(in_lower_date_bound,'HH') AND TRUNC(in_upper_date_bound,'HH')
          UNION
          SELECT li2.id
                FROM
                     line_item li2
                JOIN invoice i2 ON i2.id = li2.invoice_id
                JOIN charge c2 ON i2.id = c2.invoice_id
                WHERE
                TRUNC(c2.create_date, 'HH') BETWEEN TRUNC(in_lower_date_bound,'HH') AND TRUNC(in_upper_date_bound,'HH')
          UNION
          SELECT li2.id
                FROM
                     line_item li2
                JOIN invoice i2 ON i2.id = li2.invoice_id
                JOIN charge c2 ON i2.id = c2.invoice_id
                JOIN transaction t2 ON t2.id = c2.transaction_id
                WHERE
                TRUNC(t2.create_date, 'HH') BETWEEN TRUNC(in_lower_date_bound,'HH') AND TRUNC(in_upper_date_bound,'HH')
    )
    SELECT distinct
      line_item.id                                 line_item_id
    , product.name                                 product_name
    , product.unit_price                           product_unit_price
    , product.production_cost                      product_production_cost
    , offer_chain.name                             offer_chain_name
    , offer_chain_meta_data.value                  offer_chain_metadata
    , gclicense.purchase_date                      subscription_start_date
    , gclicense.start_date                         license_start_date
    , gclicense.end_date                           license_end_date
    , credit_card.city                             cc_city
    , credit_card.state                            cc_state
    , credit_card.postal_code                      cc_postal_code
    , line_item.create_date                        line_item_purchase_date
    , gclicense.account_regi_id
    , product_offering.quantity                    purchase_quantity
    , case when charge.charge_amount > 0 then charge.charge_amount else 0 end purchase_amount
    , PROCS_REPORTING_1A.getDiscountAmount(line_item.id) discount_amount
    , PROCS_REPORTING_1A.getRefundAmount(line_item.id) refund_amount
    , decode(gclicense.sct_id,null,0, 1)           is_refund_cancel
    , 0                                            purchase_tax_amount
    , transaction_attempt.external_transaction_id  external_transaction_id
    , invoice.id                                   invoice_number
    , NVL2(transaction.id, 1, 0)                   has_transaction
    , NVL2(credit_card.id, 1, 0)                   is_cc_transaction
    , NVL2(gift_certificate.id, 1, 0)              is_gc_transaction
    FROM
         line_item
    JOIN invoice                          ON invoice.id          = line_item.invoice_id
    JOIN product_offering                 ON product_offering.id = line_item.product_offer_id
    JOIN product                          ON product.id          = product_offering.product_id
    join (
          select license.invoice_id, subscription.offer_chain_id, subscription.purchase_date
                ,subscription.sct_id, license.start_date, license.end_date
                ,account.group_id account_regi_id
          from     license
              join subscription ON subscription.id = license.subscription_id
              join account      ON account.id      = subscription.account_id
          union all
          select gc.purchase_invoice_id invoice_id, gc.offer_chain_id, gc.purchase_date
                ,null sct_id, gc.purchase_date start_date, gc.expiration_date end_date
                ,gc.purchaser_group_id account_regi_id
          from     gift_certificate gc
          where
                TRUNC(gc.create_date, 'HH') between TRUNC(in_lower_date_bound,'HH') AND TRUNC(in_upper_date_bound,'HH')

    ) gclicense
                                          on gclicense.invoice_id = invoice.id
    JOIN offer_chain                      ON offer_chain.id      = gclicense.offer_chain_id
    JOIN charge                           ON invoice.id          = charge.invoice_id and charge.charge_status_id = 2
    JOIN transaction                      ON transaction.id      = charge.transaction_id and transaction.transaction_status_id = 2
    JOIN transaction_attempt              ON transaction.id       = transaction_attempt.transaction_id AND transaction_attempt.transaction_attempt_status_id = 2
    LEFT OUTER JOIN credit_card           ON charge.instrument_id = credit_card.id AND charge.instrument_type_id = 1
    LEFT OUTER JOIN gift_certificate      ON charge.instrument_id = gift_certificate.id AND charge.instrument_type_id = 3
    LEFT OUTER JOIN offer_chain_meta_data ON offer_chain.id       = offer_chain_meta_data.offer_chain_id
    join liq                              on line_item.id         = liq.id
      ;
  END EXTRACT_LINE_ITEMS;
----
--------------------------------------------------------------------------------
----
END PROCS_REPORTING_1A;
.
/

CREATE OR REPLACE PACKAGE BODY "PROCS_REPORTS_V5" AS

FUNCTION GET_PRODUCT_NAMES(
  in_offer_id IN NUMBER
) RETURN VARCHAR2 AS
var_result_names VARCHAR2(1024);
BEGIN
  
  var_result_names := NULL;
  
  FOR f_product IN (
    SELECT
      PRODUCT.NAME
    FROM
      PRODUCT
      INNER JOIN PRODUCT_OFFERING ON PRODUCT_OFFERING.PRODUCT_ID = PRODUCT.ID
      INNER JOIN OFFER_PRODUCT_OFFERING ON OFFER_PRODUCT_OFFERING.PRODUCT_OFFERING_ID = PRODUCT_OFFERING.ID
    WHERE
      OFFER_PRODUCT_OFFERING.OFFER_ID = in_offer_id
  )
  LOOP
    
    IF var_result_names IS NULL THEN
      var_result_names := f_product.NAME;
    ELSE
      var_result_names := var_result_names || ',' || CHR(13) || f_product.NAME;
    END IF;
    
  END LOOP;
  
  RETURN var_result_names;
  
END GET_PRODUCT_NAMES;

/******************************************************************************/

PROCEDURE GET_FULL_FLASH_REPORT_PURCH (
  in_start_date  IN DATE,
  in_end_date    IN DATE,
  out_result_set OUT SYS_REFCURSOR
) AS
-- CONSTANTS
const_license_process_name CONSTANT VARCHAR2(9) := 'LICENSING';
BEGIN
  
  OPEN out_result_set FOR
  SELECT
    GET_PRODUCT_NAMES("Offer_Id") as "Product_Names",
    "Offer_Id",
    "New_Purchases_Num",
    "Number_Of_renewals",
    FLR_TOTAL_DOLLAR_VALUE("Offer_Id", in_start_date, in_end_date) as "Total_Dollar_Value",
    FLR_UNIQUE_PURCHASERS("Offer_Id", in_start_date, in_end_date) as "Unique_Purchasers_num"
  FROM (
    SELECT
      "Offer_Id",
      "Number_Of_renewals",
      "New_Purchases_Num"
    FROM (
      SELECT
        OFFER.ID as "Offer_Id",
        FLR_RENEWALS_NUM(offer.id, in_start_date, in_end_date) as "Number_Of_renewals",
        FLR_NEW_PURCHASERS_NUM(offer.id, in_start_date, in_end_date) as "New_Purchases_Num"
      FROM
        OFFER
    )
    WHERE
      "New_Purchases_Num" > 0
      OR "Number_Of_renewals" > 0
  );
    
  /*
  OPEN out_result_set FOR
  SELECT
    "Product_Names",
    "Offer_Id",
    "New_Purchases_Num",
    "Number_Of_renewals",
    "Total_Dollar_Value",
    "Unique_Purchasers_num"
  FROM (
    SELECT
      GET_PRODUCT_NAMES(offer.id) as "Product_Names",
      offer.id as "Offer_Id",
      FLR_NEW_PURCHASERS_NUM(offer.id, in_start_date, in_end_date) as "New_Purchases_Num",
      FLR_RENEWALS_NUM(offer.id, in_start_date, in_end_date) as "Number_Of_renewals",
      FLR_TOTAL_DOLLAR_VALUE(offer.id, in_start_date, in_end_date) as "Total_Dollar_Value",
      FLR_UNIQUE_PURCHASERS(offer.id, in_start_date, in_end_date) as "Unique_Purchasers_num"
    FROM
      OFFER
  )
  WHERE
    "New_Purchases_Num" > 0
    OR "Number_Of_renewals" > 0
    OR "Total_Dollar_Value" > 0
    OR "Unique_Purchasers_num" > 0;
  */
  
END GET_FULL_FLASH_REPORT_PURCH;

/******************************************************************************/

PROCEDURE GET_FLASH_REPORT_PURCHASES (
  in_offer_id            IN NUMBER,
  in_start_date          IN DATE,
  in_end_date            IN DATE,
  out_new_purchasers_num OUT NUMBER,
  out_renewals_num       OUT NUMBER,
  out_product_names      OUT VARCHAR2,
  out_total_dollar_value OUT NUMBER,
  out_unique_purchasers  OUT NUMBER
) AS
-- CONSTANTS
const_license_process_name CONSTANT VARCHAR2(9) := 'LICENSING';
BEGIN
  
  out_product_names := GET_PRODUCT_NAMES(in_offer_id);
  
  out_total_dollar_value := FLR_TOTAL_DOLLAR_VALUE(
    in_offer_id,
    in_start_date,
    in_end_date
  );

  out_new_purchasers_num := FLR_NEW_PURCHASERS_NUM(
    in_offer_id,
    in_start_date,
    in_end_date
  );
  
  out_renewals_num := FLR_RENEWALS_NUM(
    in_offer_id,
    in_start_date,
    in_end_date
  );
  
  out_unique_purchasers := FLR_UNIQUE_PURCHASERS(
    in_offer_id,
    in_start_date,
    in_end_date
  );
  
END GET_FLASH_REPORT_PURCHASES;

/******************************************************************************/

FUNCTION FLR_NEW_PURCHASERS_NUM (
  in_offer_id            IN NUMBER,
  in_start_date          IN DATE,
  in_end_date            IN DATE
) RETURN NUMBER AS
-- CONSTANTS
const_license_process_name CONSTANT VARCHAR2(9) := 'LICENSING';
-- VARIABLES
var_new_purchases_num NUMBER;
BEGIN
  SELECT
    COUNT(LICENSE.ID)
    into
    var_new_purchases_num
  FROM
    LICENSE
    INNER JOIN CHARGE ON LICENSE.INVOICE_ID = CHARGE.INVOICE_ID
  WHERE
    LICENSE.CREATED_BY NOT LIKE const_license_process_name
    AND LICENSE.OFFER_ID = in_offer_id
    AND CHARGE.CHARGE_AMOUNT > 0
    AND PROCS_CHARGE_V5.IS_CHARGE_COLLECTED(CHARGE.ID) = 1 -- GLOBAL_CONSTANTS_V5.TRUE
    AND LICENSE.START_DATE BETWEEN in_start_date AND in_end_date;
    
  RETURN var_new_purchases_num;
END FLR_NEW_PURCHASERS_NUM;

/******************************************************************************/

FUNCTION FLR_RENEWALS_NUM (
  in_offer_id            IN NUMBER,
  in_start_date          IN DATE,
  in_end_date            IN DATE
) RETURN NUMBER AS
-- CONSTANTS
const_license_process_name CONSTANT VARCHAR2(9) := 'LICENSING';
-- VARIABLES
var_renewals_num NUMBER;
BEGIN
  SELECT
    COUNT(LICENSE.ID)
    into
    var_renewals_num
  FROM
    LICENSE
    INNER JOIN CHARGE ON LICENSE.INVOICE_ID = CHARGE.INVOICE_ID
  WHERE
    LICENSE.CREATED_BY LIKE const_license_process_name
    AND LICENSE.OFFER_ID = in_offer_id
    AND CHARGE.CHARGE_AMOUNT > 0
    AND PROCS_CHARGE_V5.IS_CHARGE_COLLECTED(CHARGE.ID) = 1 -- GLOBAL_CONSTANTS_V5.TRUE
    AND LICENSE.START_DATE BETWEEN in_start_date AND in_end_date;
    
  RETURN var_renewals_num;
END FLR_RENEWALS_NUM;

/******************************************************************************/

FUNCTION FLR_TOTAL_DOLLAR_VALUE (
  in_offer_id            IN NUMBER,
  in_start_date          IN DATE,
  in_end_date            IN DATE
) RETURN NUMBER AS
var_dollar_value NUMBER(10,2);
BEGIN
  SELECT
    SUM(CHARGE.CHARGE_AMOUNT)
    into
    var_dollar_value
  FROM
    LICENSE
    INNER JOIN CHARGE ON LICENSE.INVOICE_ID = CHARGE.INVOICE_ID
  WHERE
    LICENSE.OFFER_ID = in_offer_id
    AND CHARGE.CHARGE_AMOUNT > 0
    AND PROCS_CHARGE_V5.IS_CHARGE_COLLECTED(CHARGE.ID) = 1 -- GLOBAL_CONSTANTS_V5.TRUE
    AND LICENSE.START_DATE BETWEEN in_start_date AND in_end_date;
  
  RETURN var_dollar_value;
END FLR_TOTAL_DOLLAR_VALUE;

/******************************************************************************/

FUNCTION FLR_UNIQUE_PURCHASERS (
  in_offer_id            IN NUMBER,
  in_start_date          IN DATE,
  in_end_date            IN DATE
) RETURN NUMBER AS
-- CONSTANTS
const_license_process_name CONSTANT VARCHAR2(9) := 'LICENSING';
-- VARIABLES
var_unique_purchasers NUMBER;
BEGIN
  SELECT
    COUNT(DISTINCT SUBSCRIPTION.ACCOUNT_ID) into var_unique_purchasers
  FROM
    LICENSE
    INNER JOIN CHARGE ON LICENSE.INVOICE_ID = CHARGE.INVOICE_ID
    INNER JOIN SUBSCRIPTION ON LICENSE.SUBSCRIPTION_ID = SUBSCRIPTION.ID
  WHERE
    LICENSE.CREATED_BY NOT LIKE const_license_process_name
    AND LICENSE.OFFER_ID = in_offer_id
    AND CHARGE.CHARGE_AMOUNT > 0
    AND PROCS_CHARGE_V5.IS_CHARGE_COLLECTED(CHARGE.ID) = 1 -- GLOBAL_CONSTANTS_V5.TRUE
    AND LICENSE.START_DATE BETWEEN in_start_date AND in_end_date;
    
  RETURN var_unique_purchasers;
END;

END PROCS_REPORTS_V5;
.
/

CREATE OR REPLACE PACKAGE BODY "PROCS_SYSTEM_V18" AS

PROCEDURE INCREMENT_VERSION
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
AS
BEGIN

  UPDATE SYS_VERSION SET version=version+1;
  
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
END CHECK_VERSION;

END PROCS_SYSTEM_V18;
.
/

CREATE OR REPLACE PACKAGE BODY "PROCS_TAXES_V18" AS

PROCEDURE ADD_TAX (
  in_tax_type_id           IN NUMBER,
  in_calculated_amount     IN NUMBER,
  in_created_by            IN VARCHAR2,
  in_line_item_id          IN NUMBER,
  in_effective_rate        IN VARCHAR2,
  in_taxable_amount        IN NUMBER,
  in_tax_rule_id           IN NUMBER,
  in_jurisdiction_level_id IN NUMBER,
  in_jurisdiction_name     IN VARCHAR2,
  in_jurisdiction_id       IN VARCHAR2,
  in_ext_tax_type          IN VARCHAR2,
  in_ext_result            IN VARCHAR2,
  in_imposition_type       IN VARCHAR2,
  in_imposition            IN VARCHAR2
) AS
SPROC_NAME CONSTANT VARCHAR2(7) := 'ADD_TAX';
-- VARIABLES
var_new_tax_id    NUMBER;
temp_line_item_id NUMBER;
-- EXCEPTIONS
BAD_LINE_ITEM_ID EXCEPTION;
BEGIN

  BEGIN
    SELECT
      LINE_ITEM.ID into temp_line_item_id
    FROM
      LINE_ITEM
    WHERE
      LINE_ITEM.ID = in_line_item_id;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE BAD_LINE_ITEM_ID;
  END;
  
  var_new_tax_id := NULL;
  
  PROCS_TAXES_CRU_V18.CREATE_TAX(
    var_new_tax_id,
    in_tax_type_id,
    in_calculated_amount,
    in_created_by,
    in_line_item_id,
    in_effective_rate,
    in_taxable_amount,
    in_tax_rule_id,
    in_jurisdiction_level_id,
    in_jurisdiction_name,
    in_jurisdiction_id,
    in_ext_tax_type,
    in_ext_result,
    in_imposition_type,
    in_imposition
  );
  
EXCEPTION
WHEN BAD_LINE_ITEM_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'No such line item');
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END ADD_TAX;

/******************************************************************************/

PROCEDURE CHECK_COUNTRY_FOR_EXCLUSION (
  in_country_code IN CHAR,
  in_check_date IN DATE,
  out_is_founded  OUT NUMBER -- GLOBAL_CONSTANT.TRUE of GLOBAL_CONSTANTS_V18.FALSE
) AS
SPROC_NAME CONSTANT VARCHAR2(27) := 'CHECK_COUNTRY_FOR_EXCLUSION';
-- VARIABLES
var_countries_count NUMBER;
var_result          NUMBER;
BEGIN
  
  SELECT
    COUNT(1) into var_countries_count
  FROM
    TAX_COUNTRY_EXCLUSION_LIST
  WHERE
    country_code = in_country_code
    AND TRUNC(EFFECTIVE_DATE) <= TRUNC(in_check_date)
    AND (
      end_date is null
      OR TRUNC(END_DATE) >= TRUNC(in_check_date)
    );
    
  IF var_countries_count > 1 THEN
    -- [REVU] Should not happen. DB structure error
    var_result := GLOBAL_CONSTANTS_V18.TRUE;
  ELSIF var_countries_count = 1 THEN
    var_result := GLOBAL_CONSTANTS_V18.TRUE;
  ELSE
    var_result := GLOBAL_CONSTANTS_V18.FALSE;
  END IF;
  
  out_is_founded := var_result;

EXCEPTION
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END CHECK_COUNTRY_FOR_EXCLUSION;

/******************************************************************************/

PROCEDURE GET_TAX_CATEGORY (
  in_tax_category_id IN NUMBER,
  out_result_set     OUT SYS_REFCURSOR
) AS
SPROC_NAME CONSTANT VARCHAR2(16) := 'GET_TAX_CATEGORY';
BEGIN
  
  OPEN out_result_set FOR
  SELECT
    ID,
    CODE,
    DESCRIPTION
  FROM
    TAX_CATEGORY
  WHERE
    ID = in_tax_category_id;

EXCEPTION
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END GET_TAX_CATEGORY;

END PROCS_TAXES_V18;
.
/

CREATE OR REPLACE PACKAGE BODY "PROCS_TRANSACTION_V18" AS

PROCEDURE CREATE_TRANSACTION (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_transaction_id         IN NUMBER,
  in_status_id              IN NUMBER,
  in_amount                 IN NUMBER,
  in_created_by             IN VARCHAR2,
  in_order_id               IN VARCHAR2,
  in_is_refund              IN NUMBER DEFAULT GLOBAL_CONSTANTS_V18.FALSE,
  in_transaction_type_code  IN VARCHAR2 DEFAULT NULL,
  out_transaction_id        OUT NUMBER
) AS
-- VARIABLES
SPROC_NAME             CONSTANT VARCHAR2(18) := 'CREATE_TRANSACTION';
var_transaction_count  NUMBER;
-- EXCEPTIONS
BAD_TRANSACTION_ID     EXCEPTION;
EXCEPTION_MESSAGE      VARCHAR2(1024);
BEGIN

  IF in_transaction_id IS NOT NULL THEN
    SELECT
      COUNT(*) into var_transaction_count
    FROM
      TRANSACTION
    WHERE
      TRANSACTION.ID = in_transaction_id;
    IF var_transaction_count > 0 THEN
      RAISE BAD_TRANSACTION_ID;
    END IF;
  END IF;
  
  PROCS_TRANSACTION_CRU_V18.CREATE_TRANSACTION(
    out_transaction_id       => out_transaction_id,
    in_transaction_id        => in_transaction_id,
    in_transaction_status_id => in_status_id,
    in_transaction_amount    => in_amount,
    in_created_by            => in_created_by,
    in_order_id              => in_order_id,
    in_is_refund             => in_is_refund,
    in_transaction_type_code => in_transaction_type_code
  );
  
EXCEPTION
WHEN BAD_TRANSACTION_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.DUPLICATE_ERROR,
    SPROC_NAME, 'Transaction with given id already exists');
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END CREATE_TRANSACTION;

/******************************************************************************/

PROCEDURE CREATE_TRANSACTION_ATTEMPT (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_transaction_id          IN NUMBER,
  in_trans_attempt_status    IN NUMBER,
  in_external_status_code    IN VARCHAR2,
  in_external_status_message IN VARCHAR2,
  in_created_by              IN VARCHAR2,
  in_ext_transaction_id      IN VARCHAR2,
  out_transaction_attempt_id OUT NUMBER
) AS
-- VARIABLES
SPROC_NAME                 CONSTANT VARCHAR2(26) := 'CREATE_TRANSACTION_ATTEMPT';
var_transaction_create_date DATE;
var_transaction_attempt_id  NUMBER;

-- EXCEPTIONS
BAD_TRANS_ATTEMPT_STATUS EXCEPTION;
BAD_TRANSACTION_ID       EXCEPTION;
BEGIN
  
  -- Check that transaction exists
  BEGIN
    SELECT
      TRANSACTION.CREATE_DATE into var_transaction_create_date
    FROM
      TRANSACTION
    WHERE
      TRANSACTION.ID = in_transaction_id;
    EXCEPTION
      WHEN OTHERS THEN
        RAISE BAD_TRANSACTION_ID;
  END;
  
  -- Check that transaction status is correct
  IF in_trans_attempt_status != GLOBAL_STATUSES_V18.TRANS_ATTEMPT_IN_PROGRESS
    AND in_trans_attempt_status != GLOBAL_STATUSES_V18.TRANS_ATTEMPT_SUCCESS
    AND in_trans_attempt_status != GLOBAL_STATUSES_V18.TRANS_ATTEMPT_FAILED THEN
    RAISE BAD_TRANS_ATTEMPT_STATUS;
  END IF;
  
  var_transaction_attempt_id := NULL;
  PROCS_TRANSACTION_CRU_V18.CREATE_TRANSACTION_ATTEMPT(
    inout_transaction_attempt_id => var_transaction_attempt_id,
    in_transaction_id            => in_transaction_id,
    in_external_status_code      => in_external_status_code,
    in_external_status_message   => in_external_status_message,
    in_created_by                => in_created_by,
    in_external_transaction_id   => in_ext_transaction_id,
    in_transaction_start_time    => var_transaction_create_date,
    in_status_id                 => in_trans_attempt_status
  );
  
  PROCS_TRANSACTION_CRU_V18.UPDATE_TRANSACTION(
    in_transaction_id => in_transaction_id,
    in_updated_by     => in_created_by
  );

  out_transaction_attempt_id := var_transaction_attempt_id;

EXCEPTION
WHEN BAD_TRANSACTION_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'No such transaction');
WHEN BAD_TRANS_ATTEMPT_STATUS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.INVALID_PARAMETER,
    SPROC_NAME, 'Bad transaction attempt status');
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END CREATE_TRANSACTION_ATTEMPT;

/******************************************************************************/

PROCEDURE UPDATE_TRANSACTION_STATUS (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_transaction_id        IN NUMBER,
  in_updated_by            IN VARCHAR2,
  in_transaction_status_id IN NUMBER
) AS
-- VARIABLES
SPROC_NAME          CONSTANT VARCHAR2(25) := 'UPDATE_TRANSACTION_STATUS';
temp_transaction_id NUMBER;

-- EXCEPTIONS
BAD_TRANSACTION_ID     EXCEPTION;
BAD_TRANSACTION_STATUS EXCEPTION;
EXCEPTION_MESSAGE      VARCHAR2(1024);
BEGIN

  -- Check that transaction exists
  BEGIN
    SELECT
      TRANSACTION.ID into temp_transaction_id
    FROM
      TRANSACTION
    WHERE
      TRANSACTION.ID = in_transaction_id;
    EXCEPTION
      WHEN OTHERS THEN
        RAISE BAD_TRANSACTION_ID;
  END;

  -- Check that transaction status is correct
  IF    in_transaction_status_id != GLOBAL_STATUSES_V18.TRANSACTION_PENDING
    AND in_transaction_status_id != GLOBAL_STATUSES_V18.TRANSACTION_CLOSED
    AND in_transaction_status_id != GLOBAL_STATUSES_V18.TRANSACTION_CHARGEBACK
    AND in_transaction_status_id != GLOBAL_STATUSES_V18.TRANSACTION_DECLINED THEN
    RAISE BAD_TRANSACTION_STATUS;
  END IF;
  
  PROCS_TRANSACTION_CRU_V18.UPDATE_TRANSACTION(
    in_transaction_id        => in_transaction_id,
    in_updated_by            => in_updated_by,
    in_transaction_status_id => in_transaction_status_id
  );

EXCEPTION
WHEN BAD_TRANSACTION_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'No such transaction');
WHEN BAD_TRANSACTION_STATUS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.INVALID_PARAMETER,
    SPROC_NAME, 'Bad transaction status');
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END UPDATE_TRANSACTION_STATUS;

/******************************************************************************/

PROCEDURE UPDATE_TRANSACTION_SETTLED (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_transaction_id        IN NUMBER,
  in_updated_by            IN VARCHAR2,
  in_is_settled            IN NUMBER
) AS
-- VARIABLES
SPROC_NAME          CONSTANT VARCHAR2(26) := 'UPDATE_TRANSACTION_SETTLED';
temp_transaction_id NUMBER;

-- EXCEPTIONS
BAD_TRANSACTION_ID     EXCEPTION;
EXCEPTION_MESSAGE      VARCHAR2(1024);
BEGIN

  -- Check that transaction exists
  BEGIN
    SELECT
      TRANSACTION.ID into temp_transaction_id
    FROM
      TRANSACTION
    WHERE
      TRANSACTION.ID = in_transaction_id;
    EXCEPTION
      WHEN OTHERS THEN
        RAISE BAD_TRANSACTION_ID;
  END;
  
  PROCS_TRANSACTION_CRU_V18.UPDATE_TRANSACTION(
    in_transaction_id        => in_transaction_id,
    in_updated_by            => in_updated_by,
    in_is_settled            => in_is_settled
  );

EXCEPTION
WHEN BAD_TRANSACTION_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'No such transaction');
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END UPDATE_TRANSACTION_SETTLED;

/******************************************************************************/

PROCEDURE UPDATE_TRNSCTN_ATTEMPT_TIME (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_transaction_attempt_id IN NUMBER,
  in_updated_by             IN VARCHAR2
) AS
SPROC_NAME CONSTANT VARCHAR2(27) := 'UPDATE_TRNSCTN_ATTEMPT_TIME';
-- VARIABLES
var_transaction_id NUMBER;
-- EXCEPTION
BAD_TRANSACTION_ATTEMPT_ID EXCEPTION;
BEGIN

  BEGIN
    SELECT
      TRANSACTION_ATTEMPT.TRANSACTION_ID into var_transaction_id
    FROM
      TRANSACTION_ATTEMPT
    WHERE
      TRANSACTION_ATTEMPT.ID = in_transaction_attempt_id;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE BAD_TRANSACTION_ATTEMPT_ID;
  END;

  PROCS_TRANSACTION_CRU_V18.UPDATE_TRANSACTION(
    in_transaction_id => var_transaction_id,
    in_updated_by     => in_updated_by
  );

EXCEPTION
WHEN BAD_TRANSACTION_ATTEMPT_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'No such transaction attempt');
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END UPDATE_TRNSCTN_ATTEMPT_TIME;

/******************************************************************************/

PROCEDURE UPDATE_TRNSCTN_ATTEMPT_STATUS (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_transaction_attempt_id     IN NUMBER,
  in_transaction_attempt_status IN NUMBER
) AS
-- VARIABLES
SPROC_NAME                  CONSTANT VARCHAR2(29) := 'UPDATE_TRNSCTN_ATTEMPT_STATUS';
temp_transaction_attempt_id NUMBER;

-- EXCEPTION
BAD_TRANSACTION_ATTEMPT_ID EXCEPTION;
BAD_TRANS_ATTEMPT_STATUS   EXCEPTION;
BEGIN

  -- Check that transaction attempt exists
  BEGIN
    SELECT
      TRANSACTION_ATTEMPT.ID into temp_transaction_attempt_id
    FROM
      TRANSACTION_ATTEMPT
    WHERE
      TRANSACTION_ATTEMPT.ID = in_transaction_attempt_id;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE BAD_TRANSACTION_ATTEMPT_ID;
  END;

  -- Check that transaction attempt is correct
  IF in_transaction_attempt_status != GLOBAL_STATUSES_V18.TRANS_ATTEMPT_IN_PROGRESS
    AND in_transaction_attempt_status != GLOBAL_STATUSES_V18.TRANS_ATTEMPT_SUCCESS
    AND in_transaction_attempt_status != GLOBAL_STATUSES_V18.TRANS_ATTEMPT_FAILED THEN
    RAISE BAD_TRANS_ATTEMPT_STATUS;
  END IF;

  PROCS_TRANSACTION_CRU_V18.UPDATE_TRANSACTION_ATTEMPT(
    in_transaction_attempt_id => in_transaction_attempt_id,
    in_status_id              => in_transaction_attempt_status
  );

EXCEPTION
WHEN BAD_TRANSACTION_ATTEMPT_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'No such transaction attempt');
WHEN BAD_TRANS_ATTEMPT_STATUS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.INVALID_PARAMETER,
    SPROC_NAME, 'Bad transaction attempt status');
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END UPDATE_TRNSCTN_ATTEMPT_STATUS;

/******************************************************************************/

PROCEDURE GET_TRNSCTN_ATTEMPTS_BY_STATUS (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_transaction_id             IN NUMBER,
  in_transaction_attempt_status IN NUMBER,
  out_result_set                OUT SYS_REFCURSOR
) AS
-- VARIABLES
SPROC_NAME          CONSTANT VARCHAR2(30) := 'GET_TRNSCTN_ATTEMPTS_BY_STATUS';
temp_transaction_id NUMBER;
-- EXCEPTIONS
BAD_TRANSACTION_ID       EXCEPTION;
BAD_TRANS_ATTEMPT_STATUS EXCEPTION;
BEGIN

  -- Check that transaction exists
  BEGIN
    SELECT
      TRANSACTION.ID into temp_transaction_id
    FROM
      TRANSACTION
    WHERE
      TRANSACTION.ID = in_transaction_id;
    EXCEPTION
      WHEN OTHERS THEN
        RAISE BAD_TRANSACTION_ID;
  END;

  -- Check that transaction attempt status is correct
  IF in_transaction_attempt_status != GLOBAL_STATUSES_V18.TRANS_ATTEMPT_IN_PROGRESS
    AND in_transaction_attempt_status != GLOBAL_STATUSES_V18.TRANS_ATTEMPT_SUCCESS
    AND in_transaction_attempt_status != GLOBAL_STATUSES_V18.TRANS_ATTEMPT_FAILED THEN
    RAISE BAD_TRANS_ATTEMPT_STATUS;
  END IF;

  OPEN out_result_set FOR
  SELECT
    TRANSACTION_ATTEMPT.ID,
    TRANSACTION_ATTEMPT.EXTERNAL_STATUS_CODE,
    TRANSACTION_ATTEMPT.EXTERNAL_STATUS_MESSAGE,
    TRANSACTION_ATTEMPT.CREATE_DATE,
    TRANSACTION_ATTEMPT.CREATED_BY,
    TRANSACTION_ATTEMPT.EXTERNAL_TRANSACTION_ID,
    TRANSACTION_ATTEMPT.TRANSACTION_START_TIME,
    TRANSACTION.TRANSACTION_AMOUNT,
    TRANSACTION.ID as "TRANSACTION_ID",
    TRANSACTION.UPDATE_DATE as "TRANSACTION_UPDATE_TIME"
  FROM
    TRANSACTION_ATTEMPT
    INNER JOIN TRANSACTION ON TRANSACTION_ATTEMPT.TRANSACTION_ID = TRANSACTION.ID
  WHERE
    TRANSACTION_ATTEMPT.TRANSACTION_ID = in_transaction_id
    AND TRANSACTION_ATTEMPT.TRANSACTION_ATTEMPT_STATUS_ID = in_transaction_attempt_status;

EXCEPTION  
WHEN BAD_TRANSACTION_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'No such transaction');
WHEN BAD_TRANS_ATTEMPT_STATUS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.INVALID_PARAMETER,
    SPROC_NAME, 'Bad transaction attempt status');
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END GET_TRNSCTN_ATTEMPTS_BY_STATUS;

/******************************************************************************/

PROCEDURE UPDATE_TRANSACTION_ATTEMPT_INF (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_transaction_attempt_id IN NUMBER,
  in_ext_status_code        IN VARCHAR2,
  in_ext_status_message     IN VARCHAR2,
  in_ext_transaction_id     IN VARCHAR2
) AS
-- VARIABLES
SPROC_NAME               CONSTANT VARCHAR2(30) := 'UPDATE_TRANSACTION_ATTEMPT_INF';
temp_trans_attempt_count NUMBER;
-- EXCEPTIONS
BAD_ATTEMPT_ID EXCEPTION;
BEGIN

  SELECT
    COUNT(*) into temp_trans_attempt_count
  FROM
    TRANSACTION_ATTEMPT
  WHERE
    TRANSACTION_ATTEMPT.ID = in_transaction_attempt_id;
  
  IF temp_trans_attempt_count = 0 THEN
    RAISE BAD_ATTEMPT_ID;
  END IF;
  
  PROCS_TRANSACTION_CRU_V18.UPDATE_TRANSACTION_ATTEMPT(
    in_transaction_attempt_id  => in_transaction_attempt_id,
    in_external_status_code    => in_ext_status_code,
    in_external_status_message => in_ext_status_message,
    in_external_transaction_id => in_ext_transaction_id
  );

EXCEPTION
WHEN BAD_ATTEMPT_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'No such attempt');
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END UPDATE_TRANSACTION_ATTEMPT_INF;

/******************************************************************************/

PROCEDURE GET_FAILED_ATTEMPTS_NUMBER (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_transaction_id IN  NUMBER,
  out_attempts_num  OUT NUMBER
) AS
-- VARIABLES
SPROC_NAME             CONSTANT VARCHAR2(26) := 'GET_FAILED_ATTEMPTS_NUMBER';
temp_transaction_count NUMBER;

-- EXCEPTIONS
BAD_TRANSACTION_ID EXCEPTION;
BEGIN
  
  SELECT
    COUNT(*) into temp_transaction_count
  FROM
    TRANSACTION
  WHERE
    TRANSACTION.ID = in_transaction_id;
    
  IF temp_transaction_count = 0 THEN
    RAISE BAD_TRANSACTION_ID;
  END IF;
  
  SELECT
    COUNT(*) into out_attempts_num
  FROM
    TRANSACTION_ATTEMPT
  WHERE
    TRANSACTION_ATTEMPT.TRANSACTION_ID = in_transaction_id
    AND TRANSACTION_ATTEMPT.TRANSACTION_ATTEMPT_STATUS_ID = GLOBAL_STATUSES_V18.TRANS_ATTEMPT_FAILED;
  
EXCEPTION
WHEN BAD_TRANSACTION_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'No such transaction');
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END GET_FAILED_ATTEMPTS_NUMBER;
/******************************************************************************/

PROCEDURE IS_TRANSACTION_SUCCESSFULL (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_transaction_id IN  NUMBER,
  out_is_successfull  OUT NUMBER
) AS
-- VARIABLES
SPROC_NAME             CONSTANT VARCHAR2(26) := 'IS_TRANSACTION_SUCCESSFULL';
temp_transaction_count NUMBER;

-- EXCEPTIONS
BAD_TRANSACTION_ID EXCEPTION;
BEGIN
  
  SELECT
    COUNT(*) into temp_transaction_count
  FROM
    TRANSACTION
  WHERE
    TRANSACTION.ID = in_transaction_id;
    
  IF temp_transaction_count = 0 THEN
    RAISE BAD_TRANSACTION_ID;
  END IF;
  
  SELECT
    COUNT(*) into out_is_successfull
  FROM
    TRANSACTION_ATTEMPT
  WHERE
    TRANSACTION_ATTEMPT.TRANSACTION_ID = in_transaction_id
    AND TRANSACTION_ATTEMPT.TRANSACTION_ATTEMPT_STATUS_ID = GLOBAL_STATUSES_V18.TRANS_ATTEMPT_SUCCESS;
  
EXCEPTION
WHEN BAD_TRANSACTION_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'No such transaction');
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END IS_TRANSACTION_SUCCESSFULL;
/******************************************************************************/

PROCEDURE GET_TRANSACTION_AMOUNT (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_transaction_id      IN  NUMBER,
  out_transaction_amount OUT NUMBER
) AS
SPROC_NAME CONSTANT VARCHAR2(22) := 'GET_TRANSACTION_AMOUNT';
BEGIN

  SELECT
    TRANSACTION.TRANSACTION_AMOUNT into out_transaction_amount
  FROM
    TRANSACTION
  WHERE
    TRANSACTION.ID = in_transaction_id;
  
EXCEPTION
WHEN NO_DATA_FOUND THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'No such transaction');
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END GET_TRANSACTION_AMOUNT;

/******************************************************************************/

PROCEDURE GET_TRANSACTIONS_BY_CHARGE_ID (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_charge_id   IN  NUMBER,
  out_result_set OUT SYS_REFCURSOR
) AS
-- VARIABLES
SPROC_NAME     CONSTANT VARCHAR2(29) := 'GET_TRANSACTIONS_BY_CHARGE_ID';
temp_charge_id NUMBER;
-- EXCEPTIONS
BAD_CHARGE_ID EXCEPTION;
BEGIN
  
  BEGIN
    SELECT
      CHARGE.ID into temp_charge_id
    FROM
      CHARGE
    WHERE
      CHARGE.ID = in_charge_id;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE BAD_CHARGE_ID;
  END;
  
  OPEN out_result_set FOR
  SELECT DISTINCT
    TRANSACTION.ID,
    TRANSACTION.TRANSACTION_STATUS_ID,
    TRANSACTION.CREATE_DATE,
    TRANSACTION.TRANSACTION_AMOUNT,
    TRANSACTION.IS_REFUND,
    TRANSACTION.ORDER_ID
  FROM
    CHARGE INNER JOIN TRANSACTION ON
        CHARGE.TRANSACTION_ID = TRANSACTION.ID
  WHERE
    CHARGE.ID = in_charge_id;

EXCEPTION
WHEN BAD_CHARGE_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'No such charge');
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END GET_TRANSACTIONS_BY_CHARGE_ID;
/******************************************************************************/

PROCEDURE GET_TRANSACTION_BY_ORDER_ID (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_order_id   IN  TRANSACTION.ORDER_ID%TYPE,
  out_result_set OUT SYS_REFCURSOR
) AS
-- VARIABLES
SPROC_NAME     CONSTANT VARCHAR2(27) := 'GET_TRANSACTION_BY_ORDER_ID';
BEGIN
  OPEN out_result_set FOR
  SELECT DISTINCT
    TRANSACTION.ID
  FROM
    TRANSACTION
  WHERE
    TRANSACTION.ORDER_ID = in_order_id;

EXCEPTION
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END GET_TRANSACTION_BY_ORDER_ID;
/******************************************************************************/

PROCEDURE GET_TRANSACTIONS_BY_ORDER_ID (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_order_id   IN  TRANSACTION.ORDER_ID%TYPE,
  out_result_set OUT SYS_REFCURSOR
) AS
-- VARIABLES
SPROC_NAME     CONSTANT VARCHAR2(28) := 'GET_TRANSACTIONS_BY_ORDER_ID';
temp_order_id TRANSACTION.ORDER_ID%TYPE;
-- EXCEPTIONS
BAD_ORDER_ID EXCEPTION;
BEGIN

  --TODO BOO, REMOVE ME
  BEGIN
    SELECT 
      distinct TRANSACTION.ORDER_ID INTO temp_order_id
    FROM
      TRANSACTION
    WHERE
      TRANSACTION.ORDER_ID = in_order_id;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE BAD_ORDER_ID;
  END;

  OPEN out_result_set FOR
  SELECT c.ID CHARGE_ID, 
    c.CHARGE_AMOUNT, 
    c.CHARGE_STATUS_ID, 
    c.INSTRUMENT_ID, 
    c.INSTRUMENT_TYPE_ID, 
    c.INVOICE_ID, 
    t.ID TRANSACTION_ID, 
    t.IS_REFUND, 
    t.IS_SETTLED, 
    t.ORDER_ID, 
    t.TRANSACTION_AMOUNT, 
    t.TRANSACTION_STATUS_ID,
    t.CREATE_DATE TRANSACTION_CREATE_DATE, 
    t.CREATED_BY TRANSACTION_CREATED_BY, 
    t.UPDATE_DATE TRANSACTION_UPDATE_DATE, 
    t.UPDATED_BY TRANSACTION_UPDATED_BY
  FROM CHARGE c
  JOIN TRANSACTION t ON c.TRANSACTION_ID = t.ID
  WHERE TRANSACTION_ID IN (
    SELECT ID FROM TRANSACTION WHERE ORDER_ID = in_order_id
  );

EXCEPTION
WHEN BAD_ORDER_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'No such order');
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END GET_TRANSACTIONS_BY_ORDER_ID;
/******************************************************************************/

PROCEDURE GET_CLOSED_REFUNDS_BY_INVOICE (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_invoice_id   IN  NUMBER,
  out_result_set OUT SYS_REFCURSOR
) AS
-- VARIABLES
SPROC_NAME     CONSTANT VARCHAR2(29) := 'GET_CLOSED_REFUNDS_BY_INVOICE';
temp_invoice_id NUMBER;
-- EXCEPTIONS
BAD_INVOICE_ID EXCEPTION;
BEGIN
  
  BEGIN
    SELECT
      INVOICE.ID into temp_invoice_id
    FROM
      INVOICE
    WHERE
      INVOICE.ID = in_invoice_id;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE BAD_INVOICE_ID;
  END;
  
  OPEN out_result_set FOR
  SELECT DISTINCT
    TRANSACTION.ID,
    TRANSACTION.TRANSACTION_STATUS_ID,
    TRANSACTION.CREATE_DATE,
    TRANSACTION.UPDATE_DATE,
    TRANSACTION.ORDER_ID,
    TRANSACTION.TRANSACTION_AMOUNT
  FROM
    INVOICE INNER JOIN CHARGE ON  (INVOICE.ID = CHARGE.INVOICE_ID)
    INNER JOIN TRANSACTION ON (CHARGE.TRANSACTION_ID = TRANSACTION.ID)
  WHERE
    INVOICE.ID = in_invoice_id
    AND TRANSACTION.IS_REFUND = GLOBAL_CONSTANTS_V18.TRUE
    AND TRANSACTION.TRANSACTION_AMOUNT <= 0
    AND TRANSACTION.TRANSACTION_STATUS_ID = GLOBAL_STATUSES_V18.TRANSACTION_CLOSED;

EXCEPTION
WHEN BAD_INVOICE_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'No such invoice');
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END GET_CLOSED_REFUNDS_BY_INVOICE;

/******************************************************************************/

PROCEDURE GET_TRANSACTION_ATTEMPTS (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_transaction_id IN  NUMBER,
  out_result_set    OUT SYS_REFCURSOR
) AS
-- VARIABLES
SPROC_NAME          CONSTANT VARCHAR2(24) := 'GET_TRANSACTION_ATTEMPTS';
temp_transaction_id NUMBER;
-- EXCEPTIONS
BAD_TRANSACTION_ID EXCEPTION;
BEGIN
  
  BEGIN
    SELECT
      TRANSACTION.ID into temp_transaction_id
    FROM
      TRANSACTION
    WHERE
      TRANSACTION.ID = in_transaction_id;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE BAD_TRANSACTION_ID;
  END;
  
  OPEN out_result_set FOR
  SELECT
    TRANSACTION_ATTEMPT.TRANSACTION_ATTEMPT_STATUS_ID,
    TRANSACTION_ATTEMPT.EXTERNAL_STATUS_CODE,
    TRANSACTION_ATTEMPT.EXTERNAL_STATUS_MESSAGE,
    TRANSACTION_ATTEMPT.CREATE_DATE,
    TRANSACTION_ATTEMPT.EXTERNAL_TRANSACTION_ID
  FROM
    TRANSACTION_ATTEMPT
  WHERE
    TRANSACTION_ATTEMPT.TRANSACTION_ID = in_transaction_id;

EXCEPTION
WHEN BAD_TRANSACTION_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'No such transaction');
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END GET_TRANSACTION_ATTEMPTS;

/******************************************************************************/

PROCEDURE RESERVE_TRANSACTION_ID (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  out_transaction_id OUT NUMBER
) AS
SPROC_NAME CONSTANT VARCHAR2(22) := 'RESERVE_TRANSACTION_ID';
BEGIN
  SELECT
    TRN_ID_SEQ.nextVal into out_transaction_id
  FROM DUAL;
EXCEPTION
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END RESERVE_TRANSACTION_ID;

/******************************************************************************/

PROCEDURE GET_TRANSACTION_BY_ID (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_transaction_id IN NUMBER,
  out_result_set    OUT SYS_REFCURSOR
) AS
SPROC_NAME CONSTANT VARCHAR2(21) := 'GET_TRANSACTION_BY_ID';
-- VARIABLES
temp_transaction_id NUMBER;
-- EXCPTIONS
BAD_TRANSACTION_ID EXCEPTION;
BEGIN
  BEGIN
    SELECT
      TRANSACTION.ID into temp_transaction_id
    FROM
      TRANSACTION
    WHERE
      TRANSACTION.ID = in_transaction_id;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE BAD_TRANSACTION_ID;
  END;
  
  PROCS_TRANSACTION_CRU_V18.READ_TRANSACTION(
    in_transaction_id => in_transaction_id,
    out_result_set    => out_result_set
  );

EXCEPTION
WHEN NO_DATA_FOUND THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'No such transaction');
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END GET_TRANSACTION_BY_ID;

PROCEDURE UPDATE_TRANSACTION_ORDER_ID (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.INTRNAL_ERROR
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_transaction_id IN TRANSACTION.ID%TYPE,
  in_order_id       IN TRANSACTION.ORDER_ID%TYPE,
  in_updated_by     IN TRANSACTION.UPDATED_BY%TYPE
) AS
SPROC_NAME CONSTANT VARCHAR2(27) := 'UPDATE_TRANSACTION_ORDER_ID';
-- VARIABLES
temp_transaction_id TRANSACTION.ID%TYPE;
-- EXCEPTIONS
BAD_TRANSACTION_ID   EXCEPTION;
ORDER_ID_IS_NOT_NULL EXCEPTION;
CRU_UNKNOWN_ERROR    EXCEPTION;
EXCEPTION_MESSAGE VARCHAR2(1024);
BEGIN
  BEGIN
    SELECT
      TRANSACTION.ID into temp_transaction_id
    FROM
      TRANSACTION
    WHERE
      TRANSACTION.ID = in_transaction_id;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE BAD_TRANSACTION_ID;
  END;
  
  BEGIN
    PROCS_TRANSACTION_CRU_V18.UPDATE_TRANSACTION_ORDER_ID(
      in_transaction_id => in_transaction_id,
      in_order_id       => in_order_id,
      in_updated_by     => in_updated_by
    );
    EXCEPTION
      WHEN OTHERS THEN
        IF SQLCODE = APP_EXCEPTION_CODES_V18.NOT_FOUND THEN
          RAISE ORDER_ID_IS_NOT_NULL;
        ELSE
          EXCEPTION_MESSAGE := SQLERRM;
          RAISE CRU_UNKNOWN_ERROR;
        END IF;
  END;
  
EXCEPTION
WHEN BAD_TRANSACTION_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'No such transaction');
WHEN ORDER_ID_IS_NOT_NULL THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.INTERNAL_ERROR,
    SPROC_NAME, 'Order id is not null');
WHEN CRU_UNKNOWN_ERROR THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.STATE_ERROR,
    SPROC_NAME, 'Unknown error while updating order id', EXCEPTION_MESSAGE);
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END UPDATE_TRANSACTION_ORDER_ID;

/******************************************************************************/

FUNCTION GET_TRANSACTION_TAX_AMOUNT (
  in_transaction_id IN NUMBER
) RETURN NUMBER AS
SPROC_NAME CONSTANT VARCHAR2(26) := 'GET_TRANSACTION_TAX_AMOUNT';
-- Variables
var_tax_amount NUMBER(10,2);
BEGIN
  
  SELECT
    SUM(LI.TAXES_AMOUNT) into var_tax_amount
  FROM
    LINE_ITEM LI
    INNER JOIN INVOICE I ON LI.INVOICE_ID = I.ID
    INNER JOIN CHARGE CH ON CH.INVOICE_ID = I.ID
  WHERE
    CH.TRANSACTION_ID = in_transaction_id;
  
  IF var_tax_amount IS NULL THEN
    var_tax_amount := 0;
  END IF;
  
  RETURN var_tax_amount;
  
END GET_TRANSACTION_TAX_AMOUNT;

/******************************************************************************/

FUNCTION GET_TRANSACTION_INTRL_TAXES (
  in_transaction_id IN NUMBER
) RETURN NUMBER AS
SPROC_NAME CONSTANT VARCHAR2(27) := 'GET_TRANSACTION_INTRL_TAXES';
-- Variables
var_intrl_tax_amount NUMBER(10, 2);
BEGIN

  SELECT SUM(T.CALCULATED_AMOUNT) into var_intrl_tax_amount
  FROM
    LINE_ITEM LI
    INNER JOIN INVOICE I ON LI.INVOICE_ID = I.ID
    INNER JOIN CHARGE CH ON CH.INVOICE_ID=  I.ID
    INNER JOIN TAX T ON T.LINE_ITEM_ID = LI.ID
  WHERE
    CH.TRANSACTION_ID = in_transaction_id
    AND T.TAX_TYPE_ID IN (
      SELECT GLOBAL_ENUMS_V18.TAX_TYPE_VAT FROM DUAL
    );

  IF var_intrl_tax_amount IS NULL THEN
    var_intrl_tax_amount := 0;
  END IF;
  
  RETURN var_intrl_tax_amount;

END GET_TRANSACTION_INTRL_TAXES;

/******************************************************************************/
-- norlov: #38796
PROCEDURE GET_TRANSACTIONS (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_group_id           IN  NUMBER,
  in_invoice_id         IN NUMBER DEFAULT NULL,
  in_subscription_id    IN NUMBER DEFAULT NULL,
  in_start_date         IN TRANSACTION.CREATE_DATE%TYPE DEFAULT NULL,
  in_end_date           IN TRANSACTION.CREATE_DATE%TYPE DEFAULT NULL,
  in_transaction_status IN NUMBER DEFAULT NULL,
  out_result_set        OUT SYS_REFCURSOR
) AS
SPROC_NAME CONSTANT VARCHAR2(16) := 'GET_TRANSACTIONS';
-- VARIABLES
var_account_id ACCOUNT.ID%TYPE;
statement VARCHAR2(2000);
-- EXCEPTIONS
BAD_GROUP_ID   EXCEPTION;
BEGIN
 -- check group id
 BEGIN
    SELECT
      ACCOUNT.ID into var_account_id
    FROM
      ACCOUNT
    WHERE
      ACCOUNT.GROUP_ID = in_group_id;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE BAD_GROUP_ID;
  END;

  OPEN out_result_set FOR
  SELECT
    TRANSACTION.ID,
    TRANSACTION.TRANSACTION_STATUS_ID,
    TRANSACTION.TRANSACTION_AMOUNT,
    TRANSACTION.CREATE_DATE,
    TRANSACTION.CREATED_BY,
    TRANSACTION.IS_REFUND,
    GET_TRANSACTION_TAX_AMOUNT(TRANSACTION.ID) as TRANSACTION_TAX_AMOUNT,
    GET_TRANSACTION_INTRL_TAXES(TRANSACTION.ID) as INTERNATIONAL_TOTAL
  FROM
    TRANSACTION
    INNER JOIN CHARGE ON TRANSACTION.ID = CHARGE.TRANSACTION_ID
    INNER JOIN INVOICE ON INVOICE.ID = CHARGE.INVOICE_ID
  WHERE
    -- Filter by invoice ID
    (
      INVOICE.ID IN (
        -- Gift certificate invoices
        SELECT
          GIFT_CERTIFICATE.PURCHASE_INVOICE_ID
        FROM
          GIFT_CERTIFICATE
        WHERE
          GIFT_CERTIFICATE.PURCHASER_GROUP_ID = in_group_id
          -- If subscription_id is set then return nothing
          AND EXISTS (SELECT 1 FROM DUAL WHERE in_subscription_id IS NULL)
      )
      OR
      INVOICE.ID IN (
        SELECT
          LICENSE.INVOICE_ID
        FROM
          LICENSE
          INNER JOIN SUBSCRIPTION ON LICENSE.SUBSCRIPTION_ID = SUBSCRIPTION.ID
        WHERE
          SUBSCRIPTION.ACCOUNT_ID = var_account_id
          -- Filter by subscription id
          AND SUBSCRIPTION.ID = NVL(in_subscription_id, SUBSCRIPTION.ID)
      )
    )
    -- Filter by invoice id
    AND INVOICE.ID = NVL(in_invoice_id, INVOICE.ID)
    -- Filter by start date
    AND TRANSACTION.CREATE_DATE >= NVL(in_start_date, TRANSACTION.CREATE_DATE)
    -- Filter by end date
    AND TRANSACTION.CREATE_DATE <= NVL(in_end_date, TRANSACTION.CREATE_DATE)
    -- Filter by transaction status
    AND TRANSACTION.TRANSACTION_STATUS_ID IN ( SELECT NVL(in_transaction_status, TRANSACTION.TRANSACTION_STATUS_ID) FROM DUAL);

/*

statement :=  'select distinct '||CHR(10)
|| ' TRANSACTION.ID,'||CHR(10)
|| ' TRANSACTION.TRANSACTION_STATUS_ID, '||CHR(10)
|| ' TRANSACTION.TRANSACTION_AMOUNT, '||CHR(10)
|| ' TRANSACTION.CREATE_DATE, '||CHR(10)
|| ' TRANSACTION.CREATED_BY, '||CHR(10)
|| ' TRANSACTION.IS_REFUND from TRANSACTION '||CHR(10)
|| ' inner join CHARGE on (CHARGE.TRANSACTION_ID = TRANSACTION.ID)'||CHR(10)
|| ' inner join INVOICE on (INVOICE.ID = CHARGE.INVOICE_ID)'||CHR(10)
|| ' inner join LICENSE on (LICENSE.INVOICE_ID = INVOICE.ID)'||CHR(10)
|| ' inner join SUBSCRIPTION on (SUBSCRIPTION.ID = LICENSE.SUBSCRIPTION_ID)'||CHR(10)
|| ' inner join ACCOUNT on (ACCOUNT.ID = SUBSCRIPTION.ACCOUNT_ID)'||CHR(10)
|| ' where ACCOUNT.GROUP_ID = '||in_group_id;

IF (in_transaction_status IS NOT NULL) THEN
  statement := statement || CHR(10) || 'AND TRANSACTION.TRANSACTION_STATUS_ID=' || in_transaction_status;
END IF;

IF (in_invoice_id IS NOT NULL) THEN
  statement := statement || CHR(10) || 'AND INVOICE.ID=' || in_invoice_id;
END IF;

IF (in_subscription_id IS NOT NULL) THEN
  statement := statement || CHR(10) || 'AND SUBSCRIPTION.ID=' || in_subscription_id;
END IF;

IF (in_start_date IS NOT NULL) THEN
  statement := statement || CHR(10) || 'AND TRANSACTION.CREATE_DATE>= TO_DATE(''' || TO_CHAR(in_start_date,'yyyy/mm/dd:hh:mi:ss') || ''',''yyyy/mm/dd:hh:mi:ss'')';  -- norlov: ??
END IF;

IF (in_end_date IS NOT NULL) THEN
  statement := statement || CHR(10) || 'AND TRANSACTION.CREATE_DATE<= TO_DATE(''' || TO_CHAR(in_end_date,'yyyy/mm/dd:hh:mi:ss') || ''',''yyyy/mm/dd:hh:mi:ss'')'; -- norlov: ??
END IF;
dbms_output.put_line(statement);
OPEN out_result_set FOR statement;

*/

EXCEPTION
WHEN BAD_GROUP_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'No such group');
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END GET_TRANSACTIONS;

FUNCTION IS_TRANSACTION_COLLECTED (
/*
Throws:
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
Returns:
GLOBAL_CONST.TRUE if transaction collected,
GLOBAL_CONST.FALSE else
*/
  in_transaction_id IN NUMBER
) RETURN NUMBER AS
SPROC_NAME CONSTANT VARCHAR2(24) := 'IS_TRANSACTION_COLLECTED';
-- VARIABLES
temp_transaction_id     NUMBER;
var_success_attemps_num NUMBER;
-- EXCEPTIONS
BAD_TRANSACTION_ID EXCEPTION;
BEGIN

  BEGIN
    SELECT
      TRANSACTION.ID into temp_transaction_id
    FROM
      TRANSACTION
    WHERE
      TRANSACTION.ID = in_transaction_id;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE BAD_TRANSACTION_ID;
  END;
  
  SELECT
    COUNT(*) into var_success_attemps_num
  FROM
    TRANSACTION_ATTEMPT
  WHERE
    TRANSACTION_ATTEMPT.TRANSACTION_ID = in_transaction_id
    AND TRANSACTION_ATTEMPT.TRANSACTION_ATTEMPT_STATUS_ID IN ( SELECT GLOBAL_STATUSES_V18.TRANS_ATTEMPT_SUCCESS FROM DUAL );
    
  IF var_success_attemps_num > 0 THEN
    RETURN GLOBAL_CONSTANTS_V18.TRUE;
  ELSE
    RETURN GLOBAL_CONSTANTS_V18.FALSE;
  END IF;
  
EXCEPTION
WHEN BAD_TRANSACTION_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'No such transaction');
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END IS_TRANSACTION_COLLECTED;


/******************************************************************************/
PROCEDURE GET_NEXT_ATTEMPT_NUMBER (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_charge_id   in  number,
  out_attempt_count OUT NUMBER
) AS
-- VARIABLES
SPROC_NAME     CONSTANT VARCHAR2(29) := 'GET_NEXT_ATTEMPT_NUMBER';
temp_transaction_id NUMBER;
-- EXCEPTIONS
BAD_CHARGE_ID EXCEPTION;
BEGIN
  
  BEGIN
    SELECT
      TRANSACTION_ID into temp_transaction_id
    FROM
      CHARGE
    WHERE
      CHARGE.ID = in_charge_id;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE BAD_CHARGE_ID;
  END;
  
  select 
    count(1)
  into
    out_attempt_count
  from
    transaction tr
  inner join
    transaction_attempt ta
  on (tr.id = ta.transaction_id)
  where
    tr.ID = temp_transaction_id;

  out_attempt_count := out_attempt_count + 1;

EXCEPTION
WHEN BAD_CHARGE_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'No such charge');
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
end GET_NEXT_ATTEMPT_NUMBER;
/******************************************************************************/

END PROCS_TRANSACTION_V18;
.
/

CREATE OR REPLACE PACKAGE BODY "PROCS_LICENSE_V18" AS

PROCEDURE CREATE_LICENSE(
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
APP_EXCEPTION_CODES_V18.INTERNAL_ERROR
*/
  in_status_id                IN NUMBER,
  in_needs_entitlements       IN NUMBER,
  in_start_date               IN DATE,
  in_end_date                 IN DATE,
  in_offer_id                 IN NUMBER,
  in_subscription_id          IN NUMBER,
  in_invoice_id               IN NUMBER,
  in_created_by               IN VARCHAR2,
  in_is_extension             IN NUMBER,
  in_current_offer_index      IN NUMBER,
  in_current_offer_recurr_num IN NUMBER,
  out_license_id              OUT NUMBER
) AS
-- VARIABLES
SPROC_NAME           CONSTANT VARCHAR2(14) := 'CREATE_LICENSE';
temp_offer_id        NUMBER;
temp_subscription_id NUMBER;
temp_invoice_id      NUMBER;

var_new_license_id NUMBER;
var_offer_duration VARCHAR2(30);

var_offer_ym_interval INTERVAL YEAR TO MONTH;
var_offer_ds_interval INTERVAL DAY(3) TO SECOND;
var_offer_years       NUMBER;
var_offer_months      NUMBER;
var_offer_days        NUMBER;

-- EXCEPTIONS
BAD_OFFER_ID           EXCEPTION;
BAD_SUBSCRIPTION_ID    EXCEPTION;
BAD_INVOICE_ID         EXCEPTION;
BAD_OFFER_DURATION     EXCEPTION;
EXCEPTION_MESSAGE      VARCHAR2(1024);
BEGIN
  
  -- TODO:
  ---- check incoming data: in_current_offer_index, in_current_offer_recurr_num, in_is_extension
  
  out_license_id := NULL;
  
  -- get offer id and offer entitlement duration
  BEGIN
    SELECT
      OFFER.ID,
      OFFER.ENTITLEMENT_DURATION
      into
      temp_offer_id,
      var_offer_duration
    FROM
      OFFER
    WHERE
      OFFER.ID = in_offer_id;
    EXCEPTION
    WHEN NO_DATA_FOUND THEN
      RAISE BAD_OFFER_ID;
  END;

  -- Check that subscription exists
  BEGIN
    SELECT
      SUBSCRIPTION.ID into temp_subscription_id
    FROM
      SUBSCRIPTION
    WHERE
      SUBSCRIPTION.ID = in_subscription_id;
    EXCEPTION
    WHEN NO_DATA_FOUND THEN
      RAISE BAD_SUBSCRIPTION_ID;
  END;

  -- Check that invoice exists
  BEGIN
    SELECT
      INVOICE.ID into temp_invoice_id
    FROM
      INVOICE
    WHERE
      INVOICE.ID = in_invoice_id;
    EXCEPTION
    WHEN NO_DATA_FOUND THEN
      RAISE BAD_INVOICE_ID;
  END;

  -- convert offer duration into intervals
  BEGIN
    PROCS_COMMON_V18.ISO8601DURATION_TO_INTERVALS(
      var_offer_duration,
      var_offer_years,
      var_offer_months,
      var_offer_days);
    var_offer_ym_interval := var_offer_years||'-'||var_offer_months;
    var_offer_ds_interval := var_offer_days||' 0:0:0';
    EXCEPTION
      WHEN OTHERS THEN
        EXCEPTION_MESSAGE := SQLERRM;
        RAISE BAD_OFFER_DURATION;
  END;

  -- insert new row into license table
  PROCS_LICENSE_CRU_V18.CREATE_LICENSE(
    out_license_id              => var_new_license_id,
    in_license_status_id        => in_status_id,
    in_needs_entitlements       => in_needs_entitlements,
    in_start_date               => in_start_date,
    in_offer_id                 => in_offer_id,
    in_subscription_id          => in_subscription_id,
    in_invoice_id               => in_invoice_id,
    in_end_date                 => NVL(in_end_date, in_start_date + var_offer_ym_interval + var_offer_ds_interval),
    in_created_by               => in_created_by,
    in_is_extension             => in_is_extension,
    in_current_offer_index      => in_current_offer_index,
    in_current_offer_recurr_num => in_current_offer_recurr_num
  );
  
  out_license_id := var_new_license_id;

EXCEPTION
WHEN BAD_OFFER_DURATION THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.INTERNAL_ERROR,
    SPROC_NAME, 'Bad offer duration format', EXCEPTION_MESSAGE);
WHEN BAD_OFFER_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'No such offer');
WHEN BAD_SUBSCRIPTION_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'No such subscription');
WHEN BAD_INVOICE_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'No such invoice');
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END;

/******************************************************************************/

PROCEDURE UPDATE_LICENSE_STATUS(
    in_license_id     IN NUMBER,
    in_license_status IN NUMBER,
    in_updated_by     IN VARCHAR2,
    in_ent_end        IN NUMBER DEFAULT GLOBAL_CONSTANTS_V18.FALSE
) AS
SPROC_NAME CONSTANT VARCHAR2(21) := 'UPDATE_LICENSE_STATUS';
-- VARIABLES
temp_license_id NUMBER;
-- EXCEPTIONS
BAD_LICENSE_ID         EXCEPTION;
BAD_LICENSE_STATUS     EXCEPTION;
EXCEPTION_MESSAGE      VARCHAR2(1024);
BEGIN

  BEGIN
    SELECT
      ID into temp_license_id
    FROM
      LICENSE
    WHERE
      LICENSE.ID = in_license_id;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE BAD_LICENSE_ID;
  END;

  IF in_license_status != GLOBAL_STATUSES_V18.LICENSE_CLOSED
     AND in_license_status != GLOBAL_STATUSES_V18.LICENSE_ACTIVE
     AND in_license_status != GLOBAL_STATUSES_V18.LICENSE_IN_GRACE_PERIOD THEN
    RAISE BAD_LICENSE_STATUS;
  END IF;

  IF (in_ent_end is not null and in_ent_end = GLOBAL_CONSTANTS_V18.TRUE) then
    PROCS_LICENSE_CRU_V18.UPDATE_LICENSE(
      in_license_id        => in_license_id,
      in_updated_by        => in_updated_by,
      in_license_status_id => in_license_status,
      in_entitlement_end_date      => sysdate
    );
  ELSE
    PROCS_LICENSE_CRU_V18.UPDATE_LICENSE(
      in_license_id        => in_license_id,
      in_updated_by        => in_updated_by,
      in_license_status_id => in_license_status
    );
  END IF;
  
EXCEPTION
WHEN BAD_LICENSE_STATUS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.INVALID_PARAMETER,
    SPROC_NAME, 'Bad status id');
WHEN BAD_LICENSE_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'No such license');
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END UPDATE_LICENSE_STATUS;

/******************************************************************************/

PROCEDURE GET_ENDING_LICENSES (
  in_hours_number IN NUMBER,
  out_result_set  OUT SYS_REFCURSOR
) AS
SPROC_NAME CONSTANT VARCHAR2(32) := 'GET_ENDING_LICENSES';
-- VARIABLES
var_days          NUMBER;
var_hours         NUMBER;
var_time_interval INTERVAL DAY (3) TO SECOND;
BEGIN

  var_hours := mod(in_hours_number,24);
  var_days := (in_hours_number - var_hours) / 24;
  var_time_interval := var_days||' '||var_hours||':0:0';

  OPEN out_result_set FOR
SELECT * FROM
(
  SELECT
    LICENSE.ID,
    LICENSE.CREATE_DATE,
    LICENSE.CREATED_BY,
    LICENSE.CURRENT_OFFER_INDEX,
    LICENSE.CURRENT_OFFER_RECURR_NUM,
    LICENSE.END_DATE,
    LICENSE.ENTITLEMENT_END_DATE,
    LICENSE.INVOICE_ID,
    LICENSE.IS_EXTENSION,
    LICENSE.LICENSE_STATUS_ID,
    LICENSE.OFFER_ID,
    LICENSE.START_DATE,
    LICENSE.SUBSCRIPTION_ID,
    LICENSE.UPDATE_DATE,
    LICENSE.UPDATED_BY
  FROM
    LICENSE
  WHERE
    TO_DATE(LICENSE.END_DATE) <= (current_timestamp + var_time_interval)
    AND LICENSE.LICENSE_STATUS_ID = GLOBAL_STATUSES_V18.LICENSE_ACTIVE
    AND NOT EXISTS
    (
      SELECT NULL
      FROM PROCESS_RETRY_THROTTLE
      WHERE PROCESS_NAME = SPROC_NAME
        AND GENERIC_ID = LICENSE.ID
    )
    AND ROWNUM <= 10000
    ORDER BY dbms_random.value
) WHERE
    ROWNUM <= 1000
    ;
EXCEPTION
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END GET_ENDING_LICENSES;


/******************************************************************************/

PROCEDURE GET_ENDING_LICENSES_CC (
  in_hours_number IN NUMBER,
  out_result_set  OUT SYS_REFCURSOR,
  in_process_name IN PROCESS_RETRY_THROTTLE.PROCESS_NAME%TYPE
) AS
SPROC_NAME CONSTANT VARCHAR2(32) := 'GET_ENDING_LICENSES_CC';
-- VARIABLES
var_days          NUMBER;
var_hours         NUMBER;
var_time_interval INTERVAL DAY (3) TO SECOND;
BEGIN

  var_hours := mod(in_hours_number,24);
  var_days := (in_hours_number - var_hours) / 24;
  var_time_interval := var_days||' '||var_hours||':0:0';

  OPEN out_result_set FOR
SELECT * FROM
(
  SELECT
    LICENSE.ID,
    LICENSE.CREATE_DATE,
    LICENSE.CREATED_BY,
    LICENSE.CURRENT_OFFER_INDEX,
    LICENSE.CURRENT_OFFER_RECURR_NUM,
    LICENSE.END_DATE,
    LICENSE.ENTITLEMENT_END_DATE,
    LICENSE.INVOICE_ID,
    LICENSE.IS_EXTENSION,
    LICENSE.LICENSE_STATUS_ID,
    LICENSE.OFFER_ID,
    LICENSE.START_DATE,
    LICENSE.SUBSCRIPTION_ID,
    LICENSE.UPDATE_DATE,
    LICENSE.UPDATED_BY
  FROM
    LICENSE
  WHERE
    TO_DATE(LICENSE.END_DATE) <= (current_timestamp + var_time_interval)
    AND LICENSE.LICENSE_STATUS_ID = GLOBAL_STATUSES_V18.LICENSE_ACTIVE
    AND NOT EXISTS
    (
      SELECT NULL
      FROM PROCESS_RETRY_THROTTLE
      WHERE PROCESS_NAME = in_process_name
        AND GENERIC_ID = LICENSE.INVOICE_ID
    )
    AND ROWNUM <= 10000
    ORDER BY dbms_random.value
) WHERE
    ROWNUM <= 1000
    ;
EXCEPTION
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END GET_ENDING_LICENSES_CC;

/******************************************************************************/

PROCEDURE GET_RECURRING_OFFER (
  in_license_id  IN NUMBER,
  out_result_set OUT SYS_REFCURSOR
) AS
-- VARIABLES
SPROC_NAME                    CONSTANT VARCHAR2(19) := 'GET_RECURRING_OFFER';
var_offer_chain_id            NUMBER;
var_offer_id                  NUMBER;
var_offer_num_recurrences     NUMBER;
var_license_cur_offer_rec_num NUMBER;
var_offer_index               NUMBER;
-- EXCEPTIONS
BAD_LICENSE_ID         EXCEPTION;
CAN_NOT_GET_OFFER_INFO EXCEPTION;
BEGIN

  BEGIN
    SELECT
      SUBSCRIPTION.OFFER_CHAIN_ID,
      LICENSE.OFFER_ID,
      LICENSE.CURRENT_OFFER_RECURR_NUM
      into
      var_offer_chain_id,
      var_offer_id,
      var_license_cur_offer_rec_num
    FROM
      LICENSE
      INNER JOIN SUBSCRIPTION ON LICENSE.SUBSCRIPTION_ID = SUBSCRIPTION.ID
    WHERE
      LICENSE.ID = in_license_id;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE BAD_LICENSE_ID;
  END;
  
  BEGIN
    SELECT
      OFFER_OFFER_CHAIN.NUM_RECURRENCES,
      OFFER_OFFER_CHAIN.INDEX_VALUE
      into
      var_offer_num_recurrences,
      var_offer_index
    FROM
      OFFER_OFFER_CHAIN
      INNER JOIN OFFER ON OFFER_OFFER_CHAIN.OFFER_ID = OFFER.ID
    WHERE
      OFFER_OFFER_CHAIN.OFFER_CHAIN_ID = var_offer_chain_id
      AND OFFER_OFFER_CHAIN.OFFER_ID = var_offer_id;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE CAN_NOT_GET_OFFER_INFO;
  END;
  
  IF var_offer_num_recurrences = 0 THEN
    --out_result_set := NULL;
    -- TODO: Remove this hardcode
    OPEN out_result_set FOR
    SELECT
      OFFER.ID,
      OFFER.OFFER_STATUS_ID,
      OFFER.ENTITLEMENT_DURATION,
      OFFER.CREATED_BY,
      OFFER.CREATE_DATE,
      OFFER.UPDATED_BY,
      OFFER.UPDATE_DATE,
      var_offer_num_recurrences as "RECURRENCE_NUMBER",
      var_offer_index as "OFFER_INDEX"
    FROM
      OFFER_OFFER_CHAIN
      INNER JOIN OFFER ON OFFER_OFFER_CHAIN.OFFER_ID = OFFER.ID
    WHERE ROWNUM = 0;
  ELSIF var_license_cur_offer_rec_num = var_offer_num_recurrences THEN
    --out_result_set := NULL;
    -- TODO: Remove this hardcode
    OPEN out_result_set FOR
    SELECT
      OFFER.ID,
      OFFER.OFFER_STATUS_ID,
      OFFER.ENTITLEMENT_DURATION,
      OFFER.CREATED_BY,
      OFFER.CREATE_DATE,
      OFFER.UPDATED_BY,
      OFFER.UPDATE_DATE,
      var_offer_num_recurrences as "RECURRENCE_NUMBER",
      var_offer_index as "OFFER_INDEX"
    FROM
      OFFER_OFFER_CHAIN
      INNER JOIN OFFER ON OFFER_OFFER_CHAIN.OFFER_ID = OFFER.ID
    WHERE ROWNUM = 0;
  ELSE
    OPEN out_result_set FOR
    SELECT
      OFFER.ID,
      OFFER.OFFER_STATUS_ID,
      OFFER.ENTITLEMENT_DURATION,
      OFFER.CREATED_BY,
      OFFER.CREATE_DATE,
      OFFER.UPDATED_BY,
      OFFER.UPDATE_DATE,
      var_offer_num_recurrences as "RECURRENCE_NUMBER",
      var_offer_index as "OFFER_INDEX"
    FROM
      OFFER
    WHERE
      OFFER.ID = var_offer_id;
  END IF;

EXCEPTION
WHEN BAD_LICENSE_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'No such license');
WHEN CAN_NOT_GET_OFFER_INFO THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'Could not get offer information. Offer id = '||var_offer_id||', Offer chain id = '||var_offer_chain_id);
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END GET_RECURRING_OFFER;

/******************************************************************************/

PROCEDURE GET_NEXT_OFFER (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_license_id  IN NUMBER,
  out_result_set OUT SYS_REFCURSOR
) AS
-- VARIABLES
SPROC_NAME                CONSTANT VARCHAR2(14) := 'GET_NEXT_OFFER';
var_offer_chain_id        NUMBER;
var_offer_id              NUMBER;
var_license_current_index NUMBER;
var_next_offer_index      NUMBER;
-- EXCEPTIONS
BAD_LICENSE_ID          EXCEPTION;
CAN_NOT_FIND_NEXT_OFFER EXCEPTION;
EXCEPTION_MESSAGE       VARCHAR2(1024);
BEGIN

  BEGIN
    SELECT
      SUBSCRIPTION.OFFER_CHAIN_ID,
      LICENSE.OFFER_ID,
      LICENSE.CURRENT_OFFER_INDEX
      into
      var_offer_chain_id,
      var_offer_id,
      var_license_current_index
    FROM
      LICENSE
      INNER JOIN SUBSCRIPTION ON LICENSE.SUBSCRIPTION_ID = SUBSCRIPTION.ID
    WHERE
      LICENSE.ID = in_license_id;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE BAD_LICENSE_ID;
  END;

  BEGIN  
    var_next_offer_index := PROCS_OFFER_CHAIN_V18.GET_NEXT_OFFER_INDEX(
      var_offer_chain_id,
      var_license_current_index
    );
    EXCEPTION
      WHEN OTHERS THEN
        EXCEPTION_MESSAGE := SQLERRM;
        RAISE CAN_NOT_FIND_NEXT_OFFER;
  END;
  
  IF var_next_offer_index IS NULL THEN
    -- RETURN NULL;
    -- TODO: Remove this hardcode
    OPEN out_result_set FOR
    SELECT
      OFFER.ID,
      OFFER.OFFER_STATUS_ID,
      OFFER.ENTITLEMENT_DURATION,
      OFFER.CREATED_BY,
      OFFER.CREATE_DATE,
      OFFER.UPDATED_BY,
      OFFER.UPDATE_DATE,
      OFFER_OFFER_CHAIN.NUM_RECURRENCES as "RECURRENCE_NUMBER"
    FROM
      OFFER_OFFER_CHAIN
      INNER JOIN OFFER ON OFFER_OFFER_CHAIN.OFFER_ID = OFFER.ID
    WHERE
      1=2;
  ELSE
    OPEN out_result_set FOR
    SELECT
      OFFER.ID,
      OFFER.OFFER_STATUS_ID,
      OFFER.ENTITLEMENT_DURATION,
      OFFER.CREATED_BY,
      OFFER.CREATE_DATE,
      OFFER.UPDATED_BY,
      OFFER.UPDATE_DATE,
      OFFER_OFFER_CHAIN.NUM_RECURRENCES as "RECURRENCE_NUMBER"
    FROM
      OFFER_OFFER_CHAIN
      INNER JOIN OFFER ON OFFER_OFFER_CHAIN.OFFER_ID = OFFER.ID
    WHERE
      OFFER_OFFER_CHAIN.OFFER_CHAIN_ID = var_offer_chain_id
      AND OFFER_OFFER_CHAIN.INDEX_VALUE = var_next_offer_index;
  END IF;

EXCEPTION
WHEN BAD_LICENSE_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'No such license');
WHEN CAN_NOT_FIND_NEXT_OFFER THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.INTERNAL_ERROR,
    SPROC_NAME, 'Could not find next offer', EXCEPTION_MESSAGE);
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END GET_NEXT_OFFER;

/******************************************************************************/

PROCEDURE GET_GROUP_ID_BY_LICENSE_ID (
  in_license_id IN NUMBER,
  out_group_id  OUT NUMBER
) AS
-- VARIABLES
SPROC_NAME          CONSTANT VARCHAR2(26) := 'GET_GROUP_ID_BY_LICENSE_ID';
var_subscription_id NUMBER;
var_group_id        NUMBER;
-- EXCEPTIONS
BAD_LICENSE_ID       EXCEPTION;
CAN_NOT_GET_GROUP_ID EXCEPTION;
BEGIN

  -- Get subscription id
  BEGIN
    SELECT
      LICENSE.SUBSCRIPTION_ID into var_subscription_id
    FROM
      LICENSE
    WHERE
      LICENSE.ID = in_license_id;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE BAD_LICENSE_ID;
  END;
  
  -- Get group id
  BEGIN
    SELECT
      ACCOUNT.GROUP_ID into var_group_id
    FROM
      SUBSCRIPTION
      INNER JOIN ACCOUNT ON SUBSCRIPTION.ACCOUNT_ID = ACCOUNT.ID
    WHERE
      SUBSCRIPTION.ID = var_subscription_id;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE CAN_NOT_GET_GROUP_ID;
  END;
  
  out_group_id := var_group_id;

EXCEPTION
WHEN BAD_LICENSE_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'No such license');
WHEN CAN_NOT_GET_GROUP_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'Could not get group id');
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END GET_GROUP_ID_BY_LICENSE_ID;

/******************************************************************************/

PROCEDURE GET_NEED_ENTITLEMENTS_LICENSES (
  out_result_set OUT SYS_REFCURSOR
) AS
BEGIN
  OPEN out_result_set FOR
SELECT * FROM
(
  SELECT
    LICENSE.ID,
    LICENSE.INVOICE_ID,
    LICENSE.IS_EXTENSION,
    LICENSE.START_DATE,
    LICENSE.END_DATE,
    LICENSE.ENTITLEMENT_END_DATE,
    LICENSE.CURRENT_OFFER_INDEX,
    LICENSE.CURRENT_OFFER_RECURR_NUM,
    LICENSE.CREATE_DATE,
    LICENSE.CREATED_BY,
    LICENSE.LICENSE_STATUS_ID,
    LICENSE.OFFER_ID,
    LICENSE.SUBSCRIPTION_ID,
    LICENSE.UPDATE_DATE,
    LICENSE.UPDATED_BY,
    LICENSE.NEEDS_ENTITLEMENTS
  FROM
    LICENSE
  WHERE
    LICENSE.NEEDS_ENTITLEMENTS = GLOBAL_CONSTANTS_V18.TRUE
  AND ROWNUM <= 5000
  ORDER BY dbms_random.value
) WHERE
  ROWNUM <= 500;

END GET_NEED_ENTITLEMENTS_LICENSES;

/******************************************************************************/

PROCEDURE UPDATE_NEED_ENTITLEMENTS_FLAG (
  in_license_id         IN NUMBER,
  in_needs_entitlements IN NUMBER,
  in_updated_by         IN VARCHAR2
) AS
SPROC_NAME CONSTANT VARCHAR2(29) := 'UPDATE_NEED_ENTITLEMENTS_FLAG';
-- VARIABLES
temp_license_id NUMBER;
-- EXCEPTIONS
BAD_LICENSE_ID         EXCEPTION;
BAD_ENTITLEMENTS_FLAG  EXCEPTION;
EXCEPTION_MESSAGE      VARCHAR2(1024);
BEGIN
  
  IF in_needs_entitlements != GLOBAL_CONSTANTS_V18.TRUE
    AND in_needs_entitlements != GLOBAL_CONSTANTS_V18.FALSE THEN
    RAISE BAD_ENTITLEMENTS_FLAG;
  END IF;
  
  BEGIN
    SELECT
      LICENSE.ID into temp_license_id
    FROM
      LICENSE
    WHERE
      LICENSE.ID = in_license_id;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE BAD_LICENSE_ID;
  END;
  
  PROCS_LICENSE_CRU_V18.UPDATE_LICENSE(
    in_license_id         => in_license_id,
    in_needs_entitlements => in_needs_entitlements,
    in_updated_by         => in_updated_by
  );
  
EXCEPTION
WHEN BAD_ENTITLEMENTS_FLAG THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.INVALID_PARAMETER,
    SPROC_NAME, 'Bad entitlements flag value');
WHEN BAD_LICENSE_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'No such license');
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END UPDATE_NEED_ENTITLEMENTS_FLAG;


/******************************************************************************/

PROCEDURE GET_ENDED_GC_LICENSES (
  out_result_set          OUT SYS_REFCURSOR,
  in_hours_number         IN NUMBER DEFAULT 14*24,
  in_num_rows             IN NUMBER DEFAULT 10000,
  in_process_name IN PROCESS_RETRY_THROTTLE.PROCESS_NAME%TYPE
) AS
SPROC_NAME CONSTANT VARCHAR2(32) := 'GET_ENDED_GC_INVOICES';
var_days          NUMBER;
var_hours         NUMBER;
var_time_interval INTERVAL DAY (3) TO SECOND;
BEGIN
  var_hours := mod(in_hours_number,24);
  var_days := (in_hours_number - var_hours) / 24;
  var_time_interval := var_days||' '||var_hours||':0:0';
  OPEN out_result_set FOR
SELECT * FROM
(
  SELECT
    l.ID,
    l.CREATE_DATE,
    l.CREATED_BY,
    l.CURRENT_OFFER_INDEX,
    l.CURRENT_OFFER_RECURR_NUM,
    l.END_DATE,
    l.ENTITLEMENT_END_DATE,
    l.INVOICE_ID,
    l.IS_EXTENSION,
    l.LICENSE_STATUS_ID,
    l.OFFER_ID,
    l.START_DATE,
    l.SUBSCRIPTION_ID,
    l.UPDATE_DATE,
    l.UPDATED_BY
  FROM
    GIFT_CERTIFICATE gc
    INNER JOIN INVOICE i ON i.id = gc.PURCHASE_INVOICE_ID
    INNER JOIN LICENSE l ON l.invoice_id = i.id
    LEFT JOIN SUBSCRIPTION s ON s.id = l.subscription_id
  WHERE
    l.LICENSE_STATUS_ID != GLOBAL_STATUSES_V18.LICENSE_ACTIVE
    AND l.ENTITLEMENT_END_DATE <= (current_timestamp)
    AND l.ENTITLEMENT_END_DATE > (current_timestamp - var_time_interval)
    AND s.subscription_status_id = GLOBAL_STATUSES_V18.SUBSCRIPTION_CLOSED
    AND NOT EXISTS (
      SELECT NULL
      FROM PROCESS_RETRY_THROTTLE
      WHERE PROCESS_NAME = in_process_name
        AND GENERIC_ID = l.ID
    )
    AND ROWNUM <= in_num_rows*10
    ORDER BY dbms_random.value
) WHERE
    ROWNUM <= in_num_rows
    GROUP BY SUBSCRIPTION_ID;
EXCEPTION
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END GET_ENDED_GC_LICENSES;

PROCEDURE GET_LICENSE_BY_ID (
  in_license_id  IN NUMBER,
  out_result_set OUT SYS_REFCURSOR
) AS
SPROC_NAME CONSTANT VARCHAR2(17) := 'GET_LICENSE_BY_ID';
-- VARIABLES
temp_license_id NUMBER;
-- EXCEPTIONS
BAD_LICENSE_ID EXCEPTION;
BEGIN
  
  BEGIN
    SELECT
      l.id into temp_license_id
    FROM
      license l
    WHERE
      l.id = in_license_id;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE BAD_LICENSE_ID;
  END;
  
  OPEN out_result_set FOR
  SELECT
    l.id,
    l.license_status_id,
    l.subscription_id,
    l.invoice_id,
    l.offer_id,
    l.start_date,
    l.end_date,
    l.entitlement_end_date,
    l.is_extension,
    l.create_date,
    l.created_by,
    l.update_date,
    l.updated_by,
    l.current_offer_index,
    l.current_offer_recurr_num,
    l.needs_entitlements
  FROM
    LICENSE l
  WHERE
    l.id = in_license_id;

EXCEPTION
WHEN BAD_LICENSE_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'No such license');
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END GET_LICENSE_BY_ID;

PROCEDURE UP_LATEST_LICE_END_BY_SUBID (
  in_subscription_id IN NUMBER,
  in_end_date IN DATE,
  in_updated_by IN VARCHAR2
) AS
SPROC_NAME CONSTANT VARCHAR2(32) := 'UP_LATEST_LICE_END_BY_SUBID';
EXCEPTION_MESSAGE      VARCHAR2(1024);
var_latest_lice NUMBER;
BEGIN
  SELECT max(id)
  INTO  var_latest_lice
  FROM LICENSE
  WHERE
    subscription_id = in_subscription_id
  ;
  
  PROCS_LICENSE_CRU_V18.UPDATE_LICENSE(
    in_license_id        => var_latest_lice,
    in_updated_by        => in_updated_by,
    in_needs_entitlements => GLOBAL_CONSTANTS_V18.TRUE,
    in_end_date          => in_end_date,
    in_entitlement_end_date => in_end_date
  );

EXCEPTION
WHEN NO_DATA_FOUND THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'No licenses from subscription', SQLERRM);
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END UP_LATEST_LICE_END_BY_SUBID;

PROCEDURE GET_GRACE_LICE_FOR_FINAL_TRANS (
  in_days_before_close     IN NUMBER,
  in_num_licenses_to_fetch IN NUMBER,
  out_result_set           OUT SYS_REFCURSOR
) AS
SPROC_NAME CONSTANT VARCHAR2(32) := 'GET_GRACE_LICE_FOR_FINAL_TRANS';
BEGIN
  OPEN out_result_set FOR
  SELECT
      *
  FROM
      (
          SELECT
              l.id
          FROM
              license l
          JOIN
              invoice i
          ON
              l.invoice_id = i.id
          WHERE
              i.invoice_status_id = GLOBAL_STATUSES_V18.INVOICE_OPEN
          AND l.license_status_id = GLOBAL_STATUSES_V18.LICENSE_IN_GRACE_PERIOD
          AND SYSDATE + in_days_before_close >= l.grace_end_date
          AND NOT EXISTS
              (
                  SELECT
                      1
                  FROM
                      charge c
                  WHERE
                      c.invoice_id = i.id
                  AND c.charge_status_id = GLOBAL_STATUSES_V18.CHARGE_OPENED)
          AND rownum <= in_num_licenses_to_fetch * 10
          ORDER BY
              dbms_random.value)
  WHERE
      rownum <= in_num_licenses_to_fetch;
END GET_GRACE_LICE_FOR_FINAL_TRANS;

END PROCS_LICENSE_V18;
.
/

CREATE OR REPLACE PACKAGE BODY "PROCS_CHARGE_V18" AS

PROCEDURE CREATE_CHARGE(
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_invoice_id         IN NUMBER,
  in_transaction_id     IN NUMBER,
  in_instrument_type_id IN NUMBER,
  in_instrument_id      IN NUMBER,
  in_charge_amount      IN NUMBER,
  in_created_by         IN VARCHAR2,
  in_charge_status_id   IN NUMBER,
  out_charge_id         OUT NUMBER
) AS
PROCS_NAME          CONSTANT VARCHAR2(13) := 'CREATE_CHARGE';
-- VARIABLES
temp_invoice_id     NUMBER;
temp_transaction_id NUMBER;
var_new_charge_id   NUMBER;
-- EXCEPTIONS
BAD_INVOICE_ID         EXCEPTION;
BAD_TRANSACTION_ID     EXCEPTION;
BAD_PAYPAL_ID          EXCEPTION;
BAD_CREDIT_CARD_ID     EXCEPTION;
BAD_INSTRUMENT_TYPE    EXCEPTION;
BAD_CHARGE_STATUS_ID   EXCEPTION;
EXCEPTION_MESSAGE      VARCHAR2(1024);
BEGIN
  -- Check that incoming data is correct
  IF in_instrument_type_id != GLOBAL_ENUMS_V18.INSTRUMENT_CREDIT_CARD
    AND in_instrument_type_id != GLOBAL_ENUMS_V18.INSTRUMENT_PAYPAL THEN
    RAISE BAD_INSTRUMENT_TYPE;
  END IF;

  -- Check that status is correct
  IF in_charge_status_id != GLOBAL_STATUSES_V18.CHARGE_OPENED
    AND in_charge_status_id != GLOBAL_STATUSES_V18.CHARGE_PROCESSED
    AND in_charge_status_id != GLOBAL_STATUSES_V18.CHARGE_CANCELED THEN
    RAISE BAD_CHARGE_STATUS_ID;
  END IF;

  -- Check that invoice exists
  BEGIN
    SELECT
      INVOICE.ID into temp_invoice_id
    FROM
      INVOICE
    WHERE
      INVOICE.ID = in_invoice_id;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE BAD_INVOICE_ID;
  END;

  -- Check that transaction exists
  BEGIN
    SELECT
      TRANSACTION.ID into temp_transaction_id
    FROM
      TRANSACTION
    WHERE
      TRANSACTION.ID = in_transaction_id;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE BAD_TRANSACTION_ID;
  END;

  -- Check that instrument exists
  IF in_instrument_type_id = GLOBAL_ENUMS_V18.INSTRUMENT_CREDIT_CARD THEN
    IF PROCS_FIN_INSTRUMENTS_V18.IS_CREDIT_CARD_EXISTS(in_instrument_id) = GLOBAL_CONSTANTS_V18.FALSE THEN
      RAISE BAD_CREDIT_CARD_ID;
    END IF;
  ELSIF in_instrument_type_id = GLOBAL_ENUMS_V18.INSTRUMENT_PAYPAL THEN
    IF PROCS_FIN_INSTRUMENTS_V18.IS_PAYPAL_EXISTS(in_instrument_id) = GLOBAL_CONSTANTS_V18.FALSE THEN
      RAISE BAD_PAYPAL_ID;
    END IF;
  END IF;

  -- Create new charge
  PROCS_CHARGE_CRU_V18.CREATE_CHARGE(
    out_charge_id         => var_new_charge_id,
    in_invoice_id         => in_invoice_id,
    in_transaction_id     => in_transaction_id,
    in_instrument_type_id => in_instrument_type_id,
    in_instrument_id      => in_instrument_id,
    in_charge_amount      => in_charge_amount,
    in_charge_status_id   => in_charge_status_id,
    in_created_by         => in_created_by
  );

  out_charge_id := var_new_charge_id;

EXCEPTION
WHEN BAD_CHARGE_STATUS_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.INVALID_PARAMETER,
    PROCS_NAME, 'Bad charge status: '||in_charge_status_id);
WHEN BAD_INSTRUMENT_TYPE THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.INVALID_PARAMETER,
    PROCS_NAME, 'Bad instrument type id');
WHEN BAD_INVOICE_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    PROCS_NAME, 'No such invoice');
WHEN BAD_TRANSACTION_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    PROCS_NAME, 'No such transaction');
WHEN BAD_PAYPAL_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    PROCS_NAME, 'No such paypal');
WHEN BAD_CREDIT_CARD_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    PROCS_NAME, 'No such credit card');
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    PROCS_NAME, 'Unknown error', SQLERRM);
END CREATE_CHARGE;

/********************************************************/
-- norlov #38562 :
PROCEDURE GET_PENDING_REFUND_CHARGES (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  out_result_set      OUT SYS_REFCURSOR,
  in_row_number       IN NUMBER DEFAULT NULL
) AS
SPROC_NAME CONSTANT VARCHAR2(26) := 'GET_PENDING_REFUND_CHARGES';
-- COMSTANTS
DEFAULT_ROW_NUMBER CONSTANT NUMBER := 1;
-- VARIABLES
var_row_number NUMBER;
BEGIN
  IF in_row_number IS NULL THEN
    var_row_number := DEFAULT_ROW_NUMBER;
  ELSE
    var_row_number := in_row_number;
  END IF;

  -- Select charges
  OPEN out_result_set FOR
SELECT * FROM
(
  SELECT
    CHARGE.ID,
    CHARGE.TRANSACTION_ID,
    CHARGE.INSTRUMENT_ID,
    CHARGE.INSTRUMENT_TYPE_ID,
    CHARGE.CHARGE_AMOUNT,
    CHARGE.CREATE_DATE,
    CHARGE.CREATED_BY,
    CHARGE.INVOICE_ID
  FROM
    CHARGE
    INNER JOIN TRANSACTION ON CHARGE.TRANSACTION_ID = TRANSACTION.ID
  WHERE
    TRANSACTION.TRANSACTION_STATUS_ID = GLOBAL_STATUSES_V18.TRANSACTION_PENDING
    AND TRANSACTION.IS_REFUND = GLOBAL_CONSTANTS_V18.TRUE
    AND TRANSACTION.TRANSACTION_AMOUNT < 0
    AND NOT EXISTS
    (
      SELECT NULL
      FROM PROCESS_RETRY_THROTTLE
      WHERE PROCESS_NAME = SPROC_NAME
        AND GENERIC_ID = CHARGE.ID
    )
    AND ROWNUM <= var_row_number*10
    ORDER BY dbms_random.value
) WHERE
    ROWNUM <= var_row_number;

END GET_PENDING_REFUND_CHARGES;
/******************************************************************************/

PROCEDURE GET_UNPROCESSED_CHARGES (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_invoice_id  IN NUMBER,
  out_result_set OUT SYS_REFCURSOR
) AS
SPROC_NAME      CONSTANT VARCHAR2(24) := 'GET_UNPROCESSED_CHARGES';
-- VARIABLES
temp_invoice_id NUMBER;
-- EXCEPTIONS
BAD_INVOICE_ID EXCEPTION;
BEGIN

  -- Check that invoice exists
  BEGIN
    SELECT
      INVOICE.ID into temp_invoice_id
    FROM
      INVOICE
    WHERE
      INVOICE.ID = in_invoice_id;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE BAD_INVOICE_ID;
  END;

  -- Select charges
  OPEN out_result_set FOR
  SELECT
    CHARGE.ID,
    CHARGE.TRANSACTION_ID,
    CHARGE.INSTRUMENT_ID,
    CHARGE.INSTRUMENT_TYPE_ID,
    CHARGE.CHARGE_AMOUNT,
    CHARGE.CREATE_DATE,
    CHARGE.CREATED_BY,
    CHARGE.INVOICE_ID
  FROM
    CHARGE
    INNER JOIN TRANSACTION ON CHARGE.TRANSACTION_ID = TRANSACTION.ID
  WHERE
    CHARGE.INVOICE_ID = in_invoice_id
    AND CHARGE.CHARGE_STATUS_ID = GLOBAL_STATUSES_V18.CHARGE_OPENED
    AND 
      TRANSACTION.TRANSACTION_STATUS_ID = GLOBAL_STATUSES_V18.TRANSACTION_PENDING;

EXCEPTION
WHEN BAD_INVOICE_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'No such invoice');
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END GET_UNPROCESSED_CHARGES;

/******************************************************************************/

PROCEDURE GET_PROCESSED_CHARGES (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_invoice_id  IN NUMBER,
  out_result_set OUT SYS_REFCURSOR
) AS
SPROC_NAME      CONSTANT VARCHAR2(21) := 'GET_PROCESSED_CHARGES';
-- VARIABLES
temp_invoice_id NUMBER;
-- EXCEPTIONS
BAD_INVOICE_ID  EXCEPTION;
BEGIN

  -- Check that invoice exists
  BEGIN
    SELECT
      INVOICE.ID into temp_invoice_id
    FROM
      INVOICE
    WHERE
      INVOICE.ID = in_invoice_id;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE BAD_INVOICE_ID;
  END;

  -- Select charges
  OPEN out_result_set FOR
  SELECT /*+ STAR_TRANSFORMATION */
    CHARGE.ID,
    CHARGE.TRANSACTION_ID,
    CHARGE.INSTRUMENT_ID,
    CHARGE.INSTRUMENT_TYPE_ID,
    CHARGE.CHARGE_AMOUNT,
    CHARGE.CREATE_DATE,
    CHARGE.CREATED_BY,
    CHARGE.INVOICE_ID
  FROM
    CHARGE
    INNER JOIN TRANSACTION ON CHARGE.TRANSACTION_ID = TRANSACTION.ID
  WHERE
    CHARGE.INVOICE_ID = in_invoice_id
    AND CHARGE.CHARGE_STATUS_ID = GLOBAL_STATUSES_V18.CHARGE_PROCESSED
    AND TRANSACTION.TRANSACTION_STATUS_ID = GLOBAL_STATUSES_V18.TRANSACTION_CLOSED;

EXCEPTION
WHEN BAD_INVOICE_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'No such invoice');
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END GET_PROCESSED_CHARGES;

/******************************************************************************/

PROCEDURE GET_SUBSCR_ID_BY_CHARGE_ID (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_charge_id        IN NUMBER,
  out_subscription_id OUT NUMBER
) AS
SPROC_NAME          CONSTANT VARCHAR2(26) := 'GET_SUBSCR_ID_BY_CHARGE_ID';
-- VARIABLES
var_invoice_id      NUMBER;
var_subscription_id NUMBER;
-- EXCEPTIONS
BAD_CHARGE_ID             EXCEPTION;
CAN_NOT_FIND_SUBSCRIPTION EXCEPTION;
BEGIN

  BEGIN
    SELECT
      CHARGE.INVOICE_ID into var_invoice_id
    FROM
      CHARGE
    WHERE
      CHARGE.ID = in_charge_id;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE BAD_CHARGE_ID;
  END;

  BEGIN
    SELECT
      LICENSE.SUBSCRIPTION_ID into var_subscription_id
    FROM
      LICENSE
    WHERE
      LICENSE.INVOICE_ID = var_invoice_id
      AND ROWNUM <= 1; -- That's because many licenses could be pointed to the same invoice
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE CAN_NOT_FIND_SUBSCRIPTION;
  END;

  out_subscription_id := var_subscription_id;

EXCEPTION
WHEN BAD_CHARGE_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'No such charge');
WHEN CAN_NOT_FIND_SUBSCRIPTION THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'Could not find subscription for given charge');
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END GET_SUBSCR_ID_BY_CHARGE_ID;

/******************************************************************************/

PROCEDURE UPDATE_CHARGE_STATUS (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_charge_id        IN CHARGE.ID%TYPE,
  in_charge_status_id IN CHARGE.CHARGE_STATUS_ID%TYPE,
  in_updated_by       IN CHARGE.UPDATED_BY%TYPE
) AS
SPROC_NAME CONSTANT VARCHAR2(20) := 'UPDATE_CHARGE_STATUS';
-- EXCEPTIONS
BAD_CHARGE_ID          EXCEPTION;
BAD_STATUS_ID          EXCEPTION;
EXCEPTION_MESSAGE      VARCHAR2(1024);
BEGIN

  IF in_charge_status_id != GLOBAL_STATUSES_V18.CHARGE_OPENED
    AND in_charge_status_id != GLOBAL_STATUSES_V18.CHARGE_PROCESSED
    AND in_charge_status_id != GLOBAL_STATUSES_V18.CHARGE_CANCELED THEN
    RAISE BAD_STATUS_ID;
  END IF;

  PROCS_CHARGE_CRU_V18.UPDATE_CHARGE(
    in_charge_id        => in_charge_id,
    in_charge_status_id => in_charge_status_id,
    in_updated_by       => in_updated_by
  );

  IF SQL%ROWCOUNT = 0 THEN
    RAISE BAD_CHARGE_ID;
  END IF;

EXCEPTION
WHEN BAD_CHARGE_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'No such charge');
WHEN BAD_STATUS_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.INVALID_PARAMETER,
    SPROC_NAME, 'Bad status id');
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END UPDATE_CHARGE_STATUS;

FUNCTION IS_CHARGE_COLLECTED (
/*
Throws:
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
Returns:
GLOBAL_CONST.TRUE if transaction collected,
GLOBAL_CONST.FALSE else
*/
  in_charge_id IN NUMBER
) RETURN NUMBER AS
SPROC_NAME CONSTANT VARCHAR2(19) := 'IS_CHARGE_COLLECTED';
-- VARIABLES
var_transaction_id NUMBER;
is_transaction_collected NUMBER;
-- EXCEPTIONS
BAD_CHARGE_ID            EXCEPTION;
CAN_NOT_CHECK_TRANSACTION EXCEPTION;
EXCEPTION_MESSAGE        VARCHAR2(1024);
BEGIN

  BEGIN
    SELECT
      CHARGE.TRANSACTION_ID into var_transaction_id
    FROM
      CHARGE
    WHERE
      CHARGE.ID = in_charge_id;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE BAD_CHARGE_ID;
  END;

  BEGIN
    is_transaction_collected := PROCS_TRANSACTION_V18.IS_TRANSACTION_COLLECTED(var_transaction_id);
    EXCEPTION
      WHEN OTHERS THEN
        EXCEPTION_MESSAGE := SQLERRM;
        RAISE CAN_NOT_CHECK_TRANSACTION;
  END;
  
  RETURN is_transaction_collected;

EXCEPTION
WHEN BAD_CHARGE_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'No such charge');
WHEN CAN_NOT_CHECK_TRANSACTION THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.INTERNAL_ERROR,
    SPROC_NAME, 'Could not check if transaction was collected', EXCEPTION_MESSAGE);
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END;

PROCEDURE GET_COLLECTED_CHARGES (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_invoice_id  IN NUMBER,
  out_result_set OUT SYS_REFCURSOR
) AS
SPROC_NAME      CONSTANT VARCHAR2(21) := 'GET_COLLECTED_CHARGES';
-- VARIABLES
temp_invoice_id NUMBER;
-- EXCEPTIONS
BAD_INVOICE_ID  EXCEPTION;
BEGIN

  -- Check that invoice exists
  BEGIN
    SELECT
      INVOICE.ID into temp_invoice_id
    FROM
      INVOICE
    WHERE
      INVOICE.ID = in_invoice_id;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE BAD_INVOICE_ID;
  END;

  -- Select charges
  OPEN out_result_set FOR
  SELECT
    CHARGE.ID,
    CHARGE.TRANSACTION_ID,
    CHARGE.INSTRUMENT_ID,
    CHARGE.INSTRUMENT_TYPE_ID,
    CHARGE.CHARGE_AMOUNT,
    CHARGE.CREATE_DATE,
    CHARGE.CREATED_BY,
    CHARGE.INVOICE_ID
  FROM
    CHARGE
    INNER JOIN TRANSACTION ON CHARGE.TRANSACTION_ID = TRANSACTION.ID
  WHERE
    CHARGE.INVOICE_ID = in_invoice_id
    AND CHARGE.CHARGE_STATUS_ID IN (SELECT GLOBAL_STATUSES_V18.CHARGE_PROCESSED FROM DUAL)
    AND PROCS_CHARGE_V18.IS_CHARGE_COLLECTED(CHARGE.ID) = GLOBAL_CONSTANTS_V18.TRUE;

EXCEPTION
WHEN BAD_INVOICE_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'No such invoice');
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END GET_COLLECTED_CHARGES;

END PROCS_CHARGE_V18;
.
/

CREATE OR REPLACE PACKAGE BODY "PROCS_SUBSCRIPTION_V18" AS

PROCEDURE START_GRACE_BY_INVOICE_ID(
  in_invoice_id        IN LICENSE.INVOICE_ID%TYPE,
  in_updater           IN VARCHAR2,
  in_duration_in_hours IN NUMBER
) AS
SPROC_NAME CONSTANT VARCHAR2(32) := 'START_GRACE_BY_INVOICE_ID';
var_subs_id         SUBSCRIPTION.ID%TYPE;
var_lic_id          LICENSE.ID%TYPE;
var_grace_start     DATE;
var_grace_end       DATE;
BEGIN
  SELECT
    ID,
    SUBSCRIPTION_ID,
    START_DATE,
    START_DATE + (in_duration_in_hours / 24)
  INTO var_lic_id, var_subs_id, var_grace_start, var_grace_end
  FROM
    LICENSE
  WHERE
    INVOICE_ID = in_invoice_id
    AND ROWNUM <= 1;

  PROCS_LICENSE_CRU_V18.UPDATE_LICENSE(
      in_license_id           => var_lic_id,
      in_updated_by           => in_updater,
      in_grace_start_date     => var_grace_start,
      in_grace_end_date       => var_grace_end,
      in_entitlement_end_date => var_grace_end,
      in_license_status_id    => GLOBAL_STATUSES_V18.LICENSE_IN_GRACE_PERIOD
  );

  PROCS_SUBSCRIPTION_CRU_V18.UPDATE_SUBSCRIPTION(
      in_subscription_id        => var_subs_id,
      in_updated_by             => in_updater,
      in_subscription_status_id => GLOBAL_STATUSES_V18.SUBSCRIPTION_IN_GRACE_PERIOD
    );
END START_GRACE_BY_INVOICE_ID;

PROCEDURE STOP_GRACE_BY_INVOICE_ID(
  in_invoice_id IN LICENSE.INVOICE_ID%TYPE,
  in_updater    IN VARCHAR2
) AS
SPROC_NAME CONSTANT VARCHAR2(32) := 'START_GRACE_BY_INVOICE_ID';
var_subs_id         SUBSCRIPTION.ID%TYPE;
var_lic_id          LICENSE.ID%TYPE;
var_lic_end_date    DATE;
BEGIN
  SELECT
    ID,
    SUBSCRIPTION_ID,
    END_DATE
  INTO var_lic_id, var_subs_id, var_lic_end_date
  FROM
    LICENSE
  WHERE
    INVOICE_ID = in_invoice_id
    AND ROWNUM <= 1;

  PROCS_LICENSE_CRU_V18.UPDATE_LICENSE(
      in_license_id           => var_lic_id,
      in_updated_by           => in_updater,
      in_grace_end_date       => SYSDATE,
      in_entitlement_end_date => var_lic_end_date,
      in_license_status_id    => GLOBAL_STATUSES_V18.LICENSE_ACTIVE
  );

  PROCS_SUBSCRIPTION_CRU_V18.UPDATE_SUBSCRIPTION(
      in_subscription_id        => var_subs_id,
      in_updated_by             => in_updater,
      in_subscription_status_id => GLOBAL_STATUSES_V18.SUBSCRIPTION_ACTIVE
  );
END STOP_GRACE_BY_INVOICE_ID;


PROCEDURE START_SUBSCRIPTION_CREATION (
  in_group_id           IN NUMBER,
  in_created_by         IN VARCHAR2,
  in_offer_chain_id     IN NUMBER,
  in_instrument_type_id IN NUMBER,
  in_instrument_id      IN NUMBER,
  in_agent_id           IN NUMBER,
  in_note               IN VARCHAR2,
  out_subscription_id   OUT NUMBER,
  out_invoice_id        OUT NUMBER,
  out_new_license_id    OUT NUMBER,
  in_check_dupe_products   IN NUMBER DEFAULT GLOBAL_CONSTANTS_V18.TRUE
) AS
SPROC_NAME CONSTANT VARCHAR2(27) := 'START_SUBSCRIPTION_CREATION';
-- VARIABLES
var_account_id             NUMBER;
var_account_status         NUMBER;
var_offer_chain_status_id  NUMBER;
var_is_gift_certificate    NUMBER;
var_is_for_redemption      NUMBER;
var_same_offer_chains_num  NUMBER;
var_max_concurrent_subscrs NUMBER;
var_first_offer_id         NUMBER;
var_new_invoice_id         NUMBER;
var_new_subscription_id    NUMBER;
var_date                   DATE := SYSDATE;
var_account_tax_exempt_id  VARCHAR2(255);
var_concur_subscription_id NUMBER;
-- EXCEPTIONS
BAD_GROUP_ID                  EXCEPTION;
CAN_NOT_CREATE_FOR_DISABLE    EXCEPTION;
BAD_OFFER_CHAIN               EXCEPTION;
BAD_OFFER_CHAIN_STATUS        EXCEPTION;
CAN_NOT_SUBSCRIBE_TO_GC       EXCEPTION;
CAN_NOT_SUBSCRIBE_TO_RGC      EXCEPTION;
LIMIT_REACHED                 EXCEPTION;
PRODUCT_ALREADY_PURCHASED     EXCEPTION;
CAN_NOT_GET_FIRST_OFFER_CHAIN EXCEPTION;
CAN_NOT_CREATE_INVOICE        EXCEPTION;
CAN_NOT_CREATE_LINE_ITEMS     EXCEPTION;
CAN_NOT_CREATE_LICENSE        EXCEPTION;
CAN_NOT_CREATE_NOTE           EXCEPTION;

EXCEPTION_MESSAGE VARCHAR2(1024);
BEGIN

  -- Get account id and status
  BEGIN
    SELECT
      ACCOUNT.ID,
      ACCOUNT.ACCOUNT_STATUS_ID,
      ACCOUNT.TAX_EXEMPT_ID
      into
      var_account_id,
      var_account_status,
      var_account_tax_exempt_id
    FROM
      ACCOUNT
    WHERE
      ACCOUNT.GROUP_ID = in_group_id;
    EXCEPTION
    WHEN NO_DATA_FOUND THEN
      RAISE BAD_GROUP_ID;
  END;

  -- Could not create subscription for disabled account
  IF var_account_status = GLOBAL_STATUSES_V18.ACCOUNT_DISABLED THEN
    RAISE CAN_NOT_CREATE_FOR_DISABLE;
  END IF;

  -- Get offer chain status
  BEGIN
    SELECT
      OFFER_CHAIN.OFFER_CHAIN_STATUS_ID,
      OFFER_CHAIN.IS_GIFT_CERTIFICATE
      into
      var_offer_chain_status_id,
      var_is_gift_certificate
    FROM
      OFFER_CHAIN
    WHERE
      OFFER_CHAIN.ID = in_offer_chain_id;

    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE BAD_OFFER_CHAIN;
  END;

  -- Could not subscribe to inactive/disabled offer chain
  IF var_offer_chain_status_id != GLOBAL_STATUSES_V18.OFFER_CHAIN_ACTIVE THEN
    RAISE BAD_OFFER_CHAIN_STATUS;
  END IF;

  -- Can not subscribe to Offer Chain for a Gift Certfiicate
  IF var_is_gift_certificate = GLOBAL_CONSTANTS_V18.TRUE THEN
    RAISE CAN_NOT_SUBSCRIBE_TO_GC;
  END IF;

  -- check if the OC is for Redemption:
  SELECT
    COUNT(*) into var_is_for_redemption
  FROM
    OFFER_CHAIN_ELIGIBILITY
  WHERE
    OFFER_CHAIN_ELIGIBILITY.OFFER_CHAIN_ID = in_offer_chain_id
    AND OFFER_CHAIN_ELIGIBILITY.NAME = GLOBAL_CONSTANTS_V18.GIFT_CERTIFICATE_REQUIRED
    AND OFFER_CHAIN_ELIGIBILITY.VALUE = GLOBAL_CONSTANTS_V18.ELIGIBILITY_FLAG_SET;

  IF var_is_for_redemption > 0 THEN
    RAISE CAN_NOT_SUBSCRIBE_TO_RGC;
  END IF;

  SELECT
    COUNT(*) into var_same_offer_chains_num
  FROM
    SUBSCRIPTION
  WHERE
    SUBSCRIPTION.ACCOUNT_ID = var_account_id
    AND SUBSCRIPTION.OFFER_CHAIN_ID = in_offer_chain_id
    AND (SUBSCRIPTION.SUBSCRIPTION_STATUS_ID = GLOBAL_STATUSES_V18.SUBSCRIPTION_ACTIVE
         OR SUBSCRIPTION.SUBSCRIPTION_STATUS_ID = GLOBAL_STATUSES_V18.SUBSCRIPTION_IN_GRACE_PERIOD);

  -- ELIGIBILITY LOGIC CHANGED TO:
  -- FOR EACH offer chain eligibility rule in OC:
  --   IF offer chain eligibility rule fails:
  --     deny purchase;
  --   END IF
  -- END FOR
  -- FOR EACH product eligibility rule in OC:
  --   IF product eligibilty rule fails:
  --     deny purchase;
  --   END IF
  -- END FOR
  -- allow purchase;

  -- if user have any active existing subscriptions to the offer chain
  -- and if MAX_CONCURRENT_SUBS <= [user's subscription count for the offer chain]
  -- then deny purchase
  var_max_concurrent_subscrs := PROCS_OFFER_CHAIN_V18.GET_OFFER_CHAIN_MAX_CONC_SUBSC(in_offer_chain_id);
  IF var_max_concurrent_subscrs != GLOBAL_CONSTANTS_V18.INFINITY
    AND var_max_concurrent_subscrs <= var_same_offer_chains_num THEN
    -- Find first concurrent subscription id:
    SELECT
      ID into var_concur_subscription_id
    FROM (
      SELECT
        ID
      FROM
        SUBSCRIPTION
      WHERE
        SUBSCRIPTION.ACCOUNT_ID = var_account_id
        AND SUBSCRIPTION.OFFER_CHAIN_ID = in_offer_chain_id
        AND (SUBSCRIPTION.SUBSCRIPTION_STATUS_ID = GLOBAL_STATUSES_V18.SUBSCRIPTION_ACTIVE
             OR SUBSCRIPTION.SUBSCRIPTION_STATUS_ID = GLOBAL_STATUSES_V18.SUBSCRIPTION_IN_GRACE_PERIOD)
      ORDER BY
        ID
    )
    WHERE
      ROWNUM <= 1;
    RAISE LIMIT_REACHED;
  END IF;

  -- if user does not have any active existing subscriptions to the offer chain
  -- and if product from the offer chain is already owned from another offer chain
  -- then deny purchase
  IF (in_check_dupe_products != GLOBAL_CONSTANTS_V18.FALSE) THEN
    FOR f_account_offer_chains IN (
      SELECT DISTINCT
        OFFER_CHAIN_ID
      FROM
        SUBSCRIPTION
      WHERE
        ACCOUNT_ID = var_account_id
        AND (
          SUBSCRIPTION_STATUS_ID = GLOBAL_STATUSES_V18.SUBSCRIPTION_ACTIVE
          OR SUBSCRIPTION_STATUS_ID = GLOBAL_STATUSES_V18.SUBSCRIPTION_SUSPENDED
          OR SUBSCRIPTION_STATUS_ID = GLOBAL_STATUSES_V18.SUBSCRIPTION_IN_GRACE_PERIOD)
    )
    LOOP
      IF PROCS_OFFER_CHAIN_V18.CHECK_FOR_SAME_PRODUCTS(
        in_offer_chain_1         => in_offer_chain_id,
        in_offer_chain_2         => f_account_offer_chains.OFFER_CHAIN_ID,
        in_use_eligibility_rules => GLOBAL_CONSTANTS_V18.TRUE
      ) = GLOBAL_CONSTANTS_V18.TRUE THEN

        -- Find first concurrent subscription id:
        SELECT
          ID into var_concur_subscription_id
        FROM (
          SELECT
            ID
          FROM
            SUBSCRIPTION
          WHERE
            SUBSCRIPTION.ACCOUNT_ID = var_account_id
            AND SUBSCRIPTION.OFFER_CHAIN_ID = f_account_offer_chains.OFFER_CHAIN_ID
            AND (
              SUBSCRIPTION.SUBSCRIPTION_STATUS_ID = GLOBAL_STATUSES_V18.SUBSCRIPTION_ACTIVE
              OR SUBSCRIPTION.SUBSCRIPTION_STATUS_ID = GLOBAL_STATUSES_V18.SUBSCRIPTION_SUSPENDED
              OR SUBSCRIPTION.SUBSCRIPTION_STATUS_ID = GLOBAL_STATUSES_V18.SUBSCRIPTION_IN_GRACE_PERIOD)
          ORDER BY
            ID
        )
        WHERE
          ROWNUM <= 1;

        RAISE PRODUCT_ALREADY_PURCHASED;
      END IF;
    END LOOP;
  END IF;

  BEGIN
    PROCS_OFFER_CHAIN_V18.GET_FIRST_OFFER(in_offer_chain_id, var_first_offer_id);
    EXCEPTION
      WHEN OTHERS THEN
        EXCEPTION_MESSAGE := SQLERRM;
        RAISE CAN_NOT_GET_FIRST_OFFER_CHAIN;
  END;

  BEGIN
    PROCS_INVOICE_V18.CREATE_INVOICE(
      in_invoice_status => GLOBAL_STATUSES_V18.INVOICE_OPEN,
      in_created_by     => in_created_by,
      in_tax_exempt_id  => var_account_tax_exempt_id,
      out_invoice_id    => var_new_invoice_id
    );
    EXCEPTION
      WHEN OTHERS THEN
        EXCEPTION_MESSAGE := SQLERRM;
        RAISE CAN_NOT_CREATE_INVOICE;
  END;

  BEGIN
    PROCS_LINE_ITEMS_V18.ADD_LINE_ITEMS(
      in_invoice_id => var_new_invoice_id,
      in_offer_id   => var_first_offer_id,
      in_created_by => in_created_by
    );
    EXCEPTION
      WHEN OTHERS THEN
        EXCEPTION_MESSAGE := SQLERRM;
        RAISE CAN_NOT_CREATE_LINE_ITEMS;
  END;

  PROCS_SUBSCRIPTION_CRU_V18.CREATE_SUBSCRIPTION(
    out_subscription_id       => var_new_subscription_id,
    in_account_id             => var_account_id,
    in_purchase_date          => var_date,
    in_offer_chain_id         => in_offer_chain_id,
    in_created_by             => in_created_by,
    in_instrument_type_id     => in_instrument_type_id,
    in_instrument_id          => in_instrument_id,
    in_subscription_status_id => GLOBAL_STATUSES_V18.SUBSCRIPTION_ACTIVE
  );

  BEGIN
    PROCS_SUBSCRIPTION_V18.ANNOTATE_SUBSCRIPTION(
      in_subscription_id => var_new_subscription_id,
      in_agent_id        => in_agent_id,
      in_note            => in_note,
      in_created_by      => in_created_by
    );
    EXCEPTION
     WHEN OTHERS THEN
       EXCEPTION_MESSAGE := SQLERRM;
       RAISE CAN_NOT_CREATE_NOTE;
  END;

  BEGIN
    PROCS_LICENSE_V18.CREATE_LICENSE(
      in_status_id                => GLOBAL_STATUSES_V18.LICENSE_ACTIVE,
      in_needs_entitlements       => GLOBAL_CONSTANTS_V18.TRUE,
      in_start_date               => var_date,
      in_end_date                 => NULL, -- Will be calculated automatically
      in_offer_id                 => var_first_offer_id,
      in_subscription_id          => var_new_subscription_id,
      in_invoice_id               => var_new_invoice_id,
      in_created_by               => in_created_by,
      in_is_extension             => GLOBAL_CONSTANTS_V18.FALSE,
      in_current_offer_index      => PROCS_OFFER_CHAIN_V18.GET_FIRST_OFFER_INDEX(in_offer_chain_id),
      in_current_offer_recurr_num => 1,
      out_license_id              => out_new_license_id
    );
    EXCEPTION
      WHEN OTHERS THEN
        EXCEPTION_MESSAGE := SQLERRM;
        RAISE CAN_NOT_CREATE_LICENSE;
  END;

  out_subscription_id := var_new_subscription_id;
  out_invoice_id := var_new_invoice_id;

EXCEPTION
WHEN BAD_OFFER_CHAIN_STATUS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.STATE_ERROR,
    SPROC_NAME, 'Offer chain is not active');
WHEN LIMIT_REACHED THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.CONFLICT_ERROR,
    SPROC_NAME, 'Limit reached for given offer chain. Concurrent subscription id: ' || var_concur_subscription_id);
WHEN CAN_NOT_CREATE_FOR_DISABLE THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.STATE_ERROR,
    SPROC_NAME, 'Can not create subsscription for disabled account');
WHEN CAN_NOT_SUBSCRIBE_TO_GC THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.STATE_ERROR,
    SPROC_NAME, 'Can not subscribe to Offer Chain for Gift Certificate');
WHEN CAN_NOT_SUBSCRIBE_TO_RGC THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.STATE_ERROR,
    SPROC_NAME, 'Can not subscribe to Offer Chain that is for redemption');
WHEN BAD_OFFER_CHAIN THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'No such offer chain');
WHEN PRODUCT_ALREADY_PURCHASED THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.CONFLICT_ERROR,
    SPROC_NAME, 'User already subscribed to some product in given offer chain. Concurrent subscription id: ' || var_concur_subscription_id);
WHEN CAN_NOT_GET_FIRST_OFFER_CHAIN THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.INTERNAL_ERROR,
    SPROC_NAME, 'Could not find first offer in offer chain', EXCEPTION_MESSAGE);
WHEN CAN_NOT_CREATE_INVOICE THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.INTERNAL_ERROR,
    SPROC_NAME, 'Could not create invoice', EXCEPTION_MESSAGE);
WHEN CAN_NOT_CREATE_LINE_ITEMS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.INTERNAL_ERROR,
    SPROC_NAME, 'Could not create line items', EXCEPTION_MESSAGE);
WHEN CAN_NOT_CREATE_LICENSE THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.INTERNAL_ERROR,
    SPROC_NAME, 'Could not create new license', EXCEPTION_MESSAGE);
WHEN BAD_GROUP_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'Bad group id');
WHEN CAN_NOT_CREATE_NOTE THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.INTERNAL_ERROR,
    SPROC_NAME, 'Could not annotate subscription', EXCEPTION_MESSAGE);
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END START_SUBSCRIPTION_CREATION;

/******************************************************************************/

PROCEDURE FINALIZE_SUBSCRIPTION_CREATION (
  in_subscription_id    IN NUMBER,
  in_invoice_id         IN NUMBER,
  in_instrument_type_id IN NUMBER,
  in_instrument_id      IN NUMBER,
  in_created_by         IN VARCHAR2
) AS
SPROC_NAME CONSTANT VARCHAR2(30) := 'FINALIZE_SUBSCRIPTION_CREATION';
-- VARIABLES
var_invoice_amount     NUMBER(10, 2);
var_new_transaction_id NUMBER;
var_new_charge_id      NUMBER;
-- EXCEPTIONS
CAN_NOT_USE_FCINSTR         EXCEPTION;
CAN_NOT_CALC_INVOICE_AMOUNT EXCEPTION;
CAN_NOT_CREATE_TRANSACTION  EXCEPTION;
CAN_NOT_CREATE_CHARGE       EXCEPTION;

EXCEPTION_MESSAGE VARCHAR2(1024);
BEGIN

  -- Calculate invoice amount ( + discounts, taxes)
  BEGIN
    PROCS_INVOICE_V18.CALCULATE_INVOICE_AMOUNT(
      in_invoice_id => in_invoice_id,
      out_amount    => var_invoice_amount
    );
    EXCEPTION
     WHEN OTHERS THEN
       EXCEPTION_MESSAGE := SQLERRM;
       RAISE CAN_NOT_CALC_INVOICE_AMOUNT;
  END;

  IF in_instrument_type_id = GLOBAL_ENUMS_V18.INSTRUMENT_ZCI_INSTRUMENT
    AND var_invoice_amount > 0 THEN
    RAISE CAN_NOT_USE_FCINSTR;
  END IF;

  IF var_invoice_amount = 0 THEN
    -- UPDATE INVOICE. SET STATUS TO PROCESSED
    PROCS_INVOICE_CRU_V18.UPDATE_INVOICE(
      in_invoice_id                  => in_invoice_id,
      in_updated_by                  => in_created_by,
      in_invoice_status_id           => GLOBAL_STATUSES_V18.INVOICE_CLOSED
    );
  ELSE
    -- Create transaction and charge
    BEGIN
      PROCS_TRANSACTION_V18.CREATE_TRANSACTION(
        in_transaction_id         => NULL,
        in_status_id              => GLOBAL_STATUSES_V18.TRANSACTION_PENDING,
        in_amount                 => var_invoice_amount,
        in_created_by             => in_created_by,
        in_order_id               => NULL,
        in_transaction_type_code  => 'START_SUBSCRIPTION',
        out_transaction_id        => var_new_transaction_id
      );
      EXCEPTION
        WHEN OTHERS THEN
          EXCEPTION_MESSAGE := SQLERRM;
          RAISE CAN_NOT_CREATE_TRANSACTION;
    END;

    BEGIN
      PROCS_CHARGE_V18.CREATE_CHARGE(
        in_invoice_id         => in_invoice_id,
        in_transaction_id     => var_new_transaction_id,
        in_instrument_type_id => in_instrument_type_id,
        in_instrument_id      => in_instrument_id,
        in_charge_amount      => var_invoice_amount,
        in_created_by         => in_created_by,
        in_charge_status_id   => GLOBAL_STATUSES_V18.CHARGE_OPENED,
        out_charge_id         => var_new_charge_id
      );
      EXCEPTION
        WHEN OTHERS THEN
          EXCEPTION_MESSAGE := SQLERRM;
          RAISE CAN_NOT_CREATE_CHARGE;
    END;
  END IF;

EXCEPTION
WHEN CAN_NOT_USE_FCINSTR THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.STATE_ERROR,
    SPROC_NAME, 'Could not use "free charge instrument" for non-zero invoice');
WHEN CAN_NOT_CALC_INVOICE_AMOUNT THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.INTERNAL_ERROR,
    SPROC_NAME, 'Could not calculate invoice amount', EXCEPTION_MESSAGE);
WHEN CAN_NOT_CREATE_TRANSACTION THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.INTERNAL_ERROR,
    SPROC_NAME, 'Could not create transaction', EXCEPTION_MESSAGE);
WHEN CAN_NOT_CREATE_CHARGE THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.INTERNAL_ERROR,
    SPROC_NAME, 'Could not create charge', EXCEPTION_MESSAGE);
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END FINALIZE_SUBSCRIPTION_CREATION;

/******************************************************************************/

PROCEDURE SUSPEND_SUBSCRIPTION(
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.INTERNAL_ERROR
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
    in_subs_id    IN NUMBER,
    in_updated_by IN VARCHAR2
) AS
SPROC_NAME                  CONSTANT VARCHAR2(20) := 'SUSPEND_SUBSCRIPTION';
var_subscription_status_id  NUMBER;
var_license_id              NUMBER;
var_offer_id                NUMBER;
var_license_start_date      DATE;
var_license_end_date        DATE;

var_entitlement_dupration   VARCHAR2(30);
var_d_entitlement_dupration NUMBER;

var_ym_interval INTERVAL YEAR TO MONTH;
var_ds_interval INTERVAL DAY(3) TO SECOND;

-- EXCEPTIONS
BAD_SUBSCRIPTION_ID     EXCEPTION;
BAD_SUBSCRIPTION_STATUS EXCEPTION;
NO_LICENSE_FOUND        EXCEPTION;
NO_OFFER_FOUND          EXCEPTION;
EXCEPTION_MESSAGE       VARCHAR2(1024);
BEGIN
  -- TODO: Finish this prcedure (in Phase II)

  -- Get subscription by id. FAULT if no such subscription.
  -- begin TX
  --   Get for update associated license (subscription.license_id). FAULT if not found.
  --   Set status to PROCESSED.
  --   updated record.
  --   compute days remaining in the subscription: original end_date - today = days_remaining_adjustment
  --   new subscription status is SUSPENDED.
  --   suspend_date is now.
  --   update subscription record.
  -- end TX

  BEGIN
    SELECT
      SUBSCRIPTION.SUBSCRIPTION_STATUS_ID into var_subscription_status_id
    FROM
      SUBSCRIPTION
    WHERE
      SUBSCRIPTION.ID = in_subs_id;
    EXCEPTION
    WHEN NO_DATA_FOUND THEN
      RAISE BAD_SUBSCRIPTION_ID;
  END;

  IF var_subscription_status_id != GLOBAL_STATUSES_V18.SUBSCRIPTION_ACTIVE THEN
    RAISE BAD_SUBSCRIPTION_STATUS;
  END IF;

  BEGIN
    SELECT
      LICENSE.ID,
      LICENSE.OFFER_ID,
      LICENSE.START_DATE
      into
      var_license_id,
      var_offer_id,
      var_license_start_date
    FROM
      LICENSE
    WHERE
      LICENSE.SUBSCRIPTION_ID = in_subs_id
        AND LICENSE.LICENSE_STATUS_ID = GLOBAL_STATUSES_V18.LICENSE_ACTIVE;
    EXCEPTION
    WHEN NO_DATA_FOUND THEN
      RAISE NO_LICENSE_FOUND;
  END;

  PROCS_LICENSE_CRU_V18.UPDATE_LICENSE(
    in_license_id        => var_license_id,
    in_updated_by        => in_updated_by,
    in_license_status_id => GLOBAL_STATUSES_V18.LICENSE_CLOSED
  );

  BEGIN
    SELECT
      OFFER.ENTITLEMENT_DURATION into var_entitlement_dupration
    FROM
      OFFER
    WHERE
      OFFER.ID = var_offer_id;
    EXCEPTION
    WHEN NO_DATA_FOUND THEN
      RAISE NO_OFFER_FOUND;
  END;

  var_ym_interval := substr(var_entitlement_dupration, 0, 4);
  var_ds_interval := substr(var_entitlement_dupration, 4);

  var_license_end_date := var_license_start_date + var_ym_interval + var_ds_interval;

  var_d_entitlement_dupration := var_license_end_date - current_date;

  PROCS_SUBSCRIPTION_CRU_V18.UPDATE_SUBSCRIPTION(
    in_subscription_id           => in_subs_id,
    in_updated_by                => in_updated_by,
    in_suspend_date              => SYSDATE,
    in_subscription_status_id    => GLOBAL_STATUSES_V18.SUBSCRIPTION_SUSPENDED,
    in_days_remainning_ajustment => var_d_entitlement_dupration
  );

EXCEPTION
WHEN BAD_SUBSCRIPTION_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'No such subscription');
WHEN BAD_SUBSCRIPTION_STATUS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.STATE_ERROR,
    SPROC_NAME, 'Subscription is not active');
WHEN NO_LICENSE_FOUND THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'Can not find license associated with given subscription ID');
WHEN NO_OFFER_FOUND THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'Can not find offer associated with given subscription ID');
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END SUSPEND_SUBSCRIPTION;

/******************************************************************************/

PROCEDURE REACTIVATE_SUBSCRIPTION (
  in_subscription_id IN  NUMBER,
  in_updated_by      IN  VARCHAR2
) AS
BEGIN
  -- TODO: finish this function (in Phase II)
  NULL;
END REACTIVATE_SUBSCRIPTION;

/******************************************************************************/

PROCEDURE GET_SUBSCRIPTION_INFO (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
    in_subscription_id  IN  NUMBER,
    out_result_set      OUT SYS_REFCURSOR
) AS
SPROC_NAME CONSTANT VARCHAR2(21) := 'GET_SUBSCRIPTION_INFO';
-- VARIABLES
temp_subscription_id NUMBER;
-- EXCEPTIONS
BAD_SUBSCRIPTION_ID EXCEPTION;
BEGIN
  -- Find subscription by id
  -- Return its details

  BEGIN
    SELECT
      SUBSCRIPTION.ID into temp_subscription_id
    FROM
      SUBSCRIPTION
    WHERE
      SUBSCRIPTION.ID = in_subscription_id;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE BAD_SUBSCRIPTION_ID;
  END;

  OPEN out_result_set FOR
  SELECT
    SUBSCRIPTION.ID AS "SUBSCRIPTION_ID",
    SUBSCRIPTION.SUBSCRIPTION_STATUS_ID,
    SUBSCRIPTION.PURCHASE_DATE,
    SUBSCRIPTION.SUSPEND_DATE,
    SUBSCRIPTION.REACTIVATION_DATE,
    SUBSCRIPTION.CANCELLATION_DATE,
    SUBSCRIPTION_CANCEL_REASON.VALUE as "CANCEL_TYPE",
    OFFER_CHAIN.ID AS "OFFER_CHAIN_ID",
    OFFER_CHAIN.NAME,
    OFFER_CHAIN.DESCRIPTION,
    OFFER_CHAIN.PRODUCT_URI,
    SUBSCRIPTION.INSTRUMENT_ID,
    SUBSCRIPTION.INSTRUMENT_TYPE_ID,
    PROCS_SUBSCRIPTION_V18.CALC_SUBSCRIPTION_END_DATE(SUBSCRIPTION.ID) as "END_DATE",
    PROCS_SUBSCRIPTION_V18.GET_RECENT_CHARGE(SUBSCRIPTION.ID) AS "RECENT_CHARGE",
    PROCS_SUBSCRIPTION_V18.GET_RENEWAL_DATE(SUBSCRIPTION.ID) AS "RENEWAL_DATE",
    PROCS_SUBSCRIPTION_V18.GET_BILLING_CYCLE(SUBSCRIPTION.ID) AS "BILLING_CYCLE",
    (
      SELECT
        ACCOUNT.GROUP_ID
        FROM ACCOUNT
        WHERE ACCOUNT.ID = SUBSCRIPTION.ACCOUNT_ID
    ) as "GROUP_ID",
    (
      SELECT
        MAX(ENTITLEMENT_END_DATE)
        FROM LICENSE
        WHERE LICENSE.SUBSCRIPTION_ID = SUBSCRIPTION.ID
    )
    as "ENT_END_DATE",
    (
      SELECT
        MIN(START_DATE)
        FROM LICENSE
        WHERE LICENSE.SUBSCRIPTION_ID = SUBSCRIPTION.ID
    )
    as "ENT_START_DATE",
    PROCS_SUBSCRIPTION_V18.IS_SUBSCRIPTION_CANCELABLE(SUBSCRIPTION.ID) AS "IS_CANCELABLE",
    ITUNES_RECEIPT.ID AS "ITUNES_RECEIPT_ID",
    GROUP_ACCOUNT.ID GA_ID,
    GROUP_ACCOUNT.SUBSCRIPTION_ID GA_SUBSCRIPTION_ID,
    GROUP_ACCOUNT.GROUP_NAME GA_GROUP_NAME,
    GROUP_ACCOUNT.FIRST_NAME GA_FIRST_NAME,
    GROUP_ACCOUNT.LAST_NAME GA_LAST_NAME,
    GROUP_ACCOUNT.EMAIL GA_EMAIL,
    GROUP_ACCOUNT.PHONE GA_PHONE,
    GROUP_ACCOUNT.ORGANIZATION_TYPE GA_ORGANIZATION_TYPE,
    GROUP_ACCOUNT.SEATS GA_SEATS,
    PROCS_GROUP_ACCOUNT_V18.F_GET_NUM_OCCUPIED_GROUP_SEATS(GROUP_ACCOUNT.ID) GA_SEATS_USED,
    GROUP_ACCOUNT.IP GA_IP,
    PROCS_SUBSCRIPTION_V18.GET_GIFT_CERT_CODE_BY_SUB_ID(SUBSCRIPTION.ID) gift_certificate_code,
    PROCS_ACCOUNT_V18.GET_GRACE_START_DATE(SUBSCRIPTION.ID) GRACE_START_DATE,
    PROCS_ACCOUNT_V18.GET_GRACE_END_DATE(SUBSCRIPTION.ID) GRACE_END_DATE
  FROM
    SUBSCRIPTION
    INNER JOIN OFFER_CHAIN ON SUBSCRIPTION.OFFER_CHAIN_ID = OFFER_CHAIN.ID
    LEFT JOIN SUBSCRIPTION_CANCEL_REASON ON SUBSCRIPTION.SCT_ID = SUBSCRIPTION_CANCEL_REASON.ID
    LEFT JOIN ITUNES_RECEIPT ON SUBSCRIPTION.ID = ITUNES_RECEIPT.SUBSCRIPTION_ID
    LEFT JOIN GROUP_ACCOUNT ON SUBSCRIPTION.ID = GROUP_ACCOUNT.SUBSCRIPTION_ID
  WHERE
    SUBSCRIPTION.ID = in_subscription_id;

EXCEPTION
WHEN BAD_SUBSCRIPTION_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'No such subscription');
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END GET_SUBSCRIPTION_INFO;

/******************************************************************************/

PROCEDURE GET_SUBSCRIPTION_INVOICES (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND,
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_subscription_id  IN  NUMBER,
  out_result_set      OUT SYS_REFCURSOR
) AS
SPROC_NAME           CONSTANT VARCHAR2(25) := 'GET_SUBSCRIPTION_INVOICES';
temp_subscription_id NUMBER;
BEGIN
  -- Note: A subscription has one or more associated licenses, each of which has an associated invoice.
  -- Find associated LICENSES for the subscription by "LICENSE.subscription_id"
  --   for each license
  --     get associated invoice
  --     add to results list
  --   end loop
  -- end

  SELECT
    SUBSCRIPTION.ID into temp_subscription_id
  FROM
    SUBSCRIPTION
  WHERE
    SUBSCRIPTION.ID = in_subscription_id;

  OPEN out_result_set FOR
  SELECT
    INVOICE.ID,
    INVOICE.INVOICE_STATUS_ID,
    INVOICE.CREATE_DATE,
    INVOICE.CREATED_BY,
    INVOICE.UPDATE_DATE,
    INVOICE.UPDATED_BY,
    INVOICE.TAX_EXEMPT_ID
  FROM
    LICENSE
      INNER JOIN INVOICE ON LICENSE.INVOICE_ID = INVOICE.ID
  WHERE
    LICENSE.SUBSCRIPTION_ID = in_subscription_id;

EXCEPTION
WHEN NO_DATA_FOUND THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'Could not find subscription with given ID');
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END GET_SUBSCRIPTION_INVOICES;

/******************************************************************************/

PROCEDURE GET_SUBSCRIPTION_NOTES (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_subscription_id  IN  NUMBER,
  out_result_set      OUT SYS_REFCURSOR
) AS
-- VARIABLES
SPROC_NAME           CONSTANT VARCHAR2(22) := 'GET_SUBSCRIPTION_NOTES';
temp_subscription_id NUMBER;
-- EXCEPTIONS
BAD_SUBSCRIPTION_ID EXCEPTION;
BEGIN

  -- Check that subscription exists
  BEGIN
    SELECT
      SUBSCRIPTION.ID into temp_subscription_id
    FROM
      SUBSCRIPTION
    WHERE
      SUBSCRIPTION.ID = in_subscription_id;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE BAD_SUBSCRIPTION_ID;
  END;

  OPEN out_result_set FOR
  SELECT
    SUBSCRIPTION_NOTE.NOTE,
    SUBSCRIPTION_NOTE.CREATED_BY,
    SUBSCRIPTION_NOTE.CREATE_DATE
  FROM
    SUBSCRIPTION_NOTE
  WHERE
    SUBSCRIPTION_NOTE.SUBSCRIPTION_ID = in_subscription_id
  ORDER BY
    SUBSCRIPTION_NOTE.CREATE_DATE ASC;

EXCEPTION
WHEN BAD_SUBSCRIPTION_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'No such subscription');
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END GET_SUBSCRIPTION_NOTES;

/******************************************************************************/

PROCEDURE ANNOTATE_SUBSCRIPTION (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND,
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_subscription_id IN  NUMBER,
  in_agent_id        IN  NUMBER,
  in_note            IN  VARCHAR2,
  in_created_by      IN  VARCHAR2
) AS
-- VARIABLES
SPROC_NAME               CONSTANT VARCHAR2(21) := 'ANNOTATE_SUBSCRIPTION';
temp_subscription_id     NUMBER;
var_subscription_note_id NUMBER;
-- EXCEPTIONS
BAD_SUBSCRIPTION_ID EXCEPTION;
BEGIN

  -- Check that subscription exists
  BEGIN
    SELECT
      SUBSCRIPTION.ID into temp_subscription_id
    FROM
      SUBSCRIPTION
    WHERE
      SUBSCRIPTION.ID = in_subscription_id;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE BAD_SUBSCRIPTION_ID;
  END;

  PROCS_SUBSCRIPTION_CRU_V18.CREATE_SUBSCRIPTION_NOTE(
    inout_subscription_note_id => var_subscription_note_id,
    in_agent_id                => in_agent_id,
    in_subscription_id         => in_subscription_id,
    in_note                    => in_note,
    in_created_by              => in_created_by
  );

EXCEPTION
WHEN BAD_SUBSCRIPTION_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'No such subscription');
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END ANNOTATE_SUBSCRIPTION;

/******************************************************************************/

PROCEDURE GET_CANCEL_REASONS (
  out_result_set    OUT SYS_REFCURSOR
) AS
SPROC_NAME CONSTANT VARCHAR2(30) := 'GET_CANCEL_REASONS';
BEGIN
  OPEN out_result_set FOR
  SELECT
    SUBSCRIPTION_CANCEL_REASON.ID,
    SUBSCRIPTION_CANCEL_REASON.VALUE,
    SUBSCRIPTION_CANCEL_REASON.DESCRIPTION,
    SUBSCRIPTION_CANCEL_REASON.CANCELATION_STATUS_ID AS STATUS_ID
  FROM
    SUBSCRIPTION_CANCEL_REASON;

END GET_CANCEL_REASONS;

/******************************************************************************/

FUNCTION GET_RENEWAL_DATE (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_subscription_id in NUMBER
) RETURN DATE AS
-- VARIABLES
SPROC_NAME              CONSTANT VARCHAR2(16) := 'GET_RENEWAL_DATE';
var_subscription_status NUMBER;
var_licenses_count      NUMBER;
var_license_end_date    DATE;
var_last_offer_id       NUMBER;
var_offer_chain_id      NUMBER;
var_last_license_id     NUMBER;
var_current_offer_index NUMBER;
var_current_offer_recurr_num NUMBER;
var_offer_recurr_num    NUMBER;
-- EXCEPTIONS
BAD_SUBSCRIPTION_ID EXCEPTION;
NO_LICENSES_FOUND EXCEPTION;
BEGIN

  -- Get subscription id and offer chain id
  BEGIN
    SELECT
      SUBSCRIPTION.SUBSCRIPTION_STATUS_ID,
      SUBSCRIPTION.OFFER_CHAIN_ID
      into
      var_subscription_status,
      var_offer_chain_id
    FROM
      SUBSCRIPTION
    WHERE
      SUBSCRIPTION.ID = in_subscription_id;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE BAD_SUBSCRIPTION_ID;
  END;

  IF var_subscription_status != GLOBAL_STATUSES_V18.SUBSCRIPTION_ACTIVE THEN
    -- TODO: Is suspended subscription has renewal date? (For the phase II)
    -- AND var_subscription_status != GLOBAL_STATUSES_V18.SUBSCRIPTION_SUSPENDED THEN
    RETURN NULL;
  END IF;

  BEGIN
    SELECT
      LICENSE_ID,
      END_DATE,
      OFFER_ID,
      CURRENT_OFFER_INDEX,
      CURRENT_OFFER_RECURR_NUM
      into
      var_last_license_id,
      var_license_end_date,
      var_last_offer_id,
      var_current_offer_index,
      var_current_offer_recurr_num
    FROM
      (
        SELECT
          LICENSE.ID as "LICENSE_ID",
          LICENSE.END_DATE,
          LICENSE.OFFER_ID,
          LICENSE.CURRENT_OFFER_INDEX,
          LICENSE.CURRENT_OFFER_RECURR_NUM
        FROM
          LICENSE
        WHERE
          LICENSE.LICENSE_STATUS_ID = GLOBAL_STATUSES_V18.LICENSE_ACTIVE
          AND LICENSE.SUBSCRIPTION_ID = in_subscription_id
        ORDER BY END_DATE DESC
      )
      INNER JOIN OFFER ON OFFER_ID = OFFER.ID
    WHERE
      ROWNUM <= 1;

    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        -- RAISE NO_LICENSES_FOUND;
        RETURN NULL;
  END;

  SELECT
    OFFER_OFFER_CHAIN.NUM_RECURRENCES into var_offer_recurr_num
  FROM
    OFFER_OFFER_CHAIN
  WHERE
    OFFER_OFFER_CHAIN.OFFER_CHAIN_ID = var_offer_chain_id
    AND OFFER_OFFER_CHAIN.OFFER_ID = var_last_offer_id;

  IF PROCS_OFFER_CHAIN_V18.GET_NEXT_OFFER_INDEX(var_offer_chain_id, var_current_offer_index) IS NULL
    AND var_offer_recurr_num = var_current_offer_recurr_num THEN
    -- There is no next offer for this subscription
    RETURN NULL;
  END IF;

  RETURN var_license_end_date;

EXCEPTION
WHEN BAD_SUBSCRIPTION_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'No such subscription');
WHEN NO_LICENSES_FOUND THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'No licenses found');
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END GET_RENEWAL_DATE;

/******************************************************************************/

FUNCTION GET_RECENT_CHARGE (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_subscription_id IN NUMBER
) RETURN NUMBER AS
-- VARIABLES
SPROC_NAME           CONSTANT VARCHAR2(17) := 'GET_RECENT_CHARGE';
temp_subscription_id NUMBER;
var_recent_charge    NUMBER(10,2);

-- EXCEPTIONS
BAD_SUBSCRIPTION_ID EXCEPTION;
BEGIN

  BEGIN
    SELECT
      SUBSCRIPTION.ID into temp_subscription_id
    FROM
      SUBSCRIPTION
    WHERE
      SUBSCRIPTION.ID = in_subscription_id;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE BAD_SUBSCRIPTION_ID;
  END;

  BEGIN
    SELECT
      CHARGE.CHARGE_AMOUNT into var_recent_charge
    FROM
      LICENSE
      INNER JOIN SUBSCRIPTION ON LICENSE.SUBSCRIPTION_ID = SUBSCRIPTION.ID
      INNER JOIN INVOICE ON LICENSE.INVOICE_ID = INVOICE.ID
      INNER JOIN CHARGE ON CHARGE.INVOICE_ID = INVOICE.ID
    WHERE
      -- TODO: Review
      -- LICENSE.LICENSE_STATUS_ID = GLOBAL_STATUSES_V18.LICENSE_PROCESSED
      -- AND
      SUBSCRIPTION.ID = in_subscription_id
      AND CHARGE.CHARGE_AMOUNT >= 0
      AND ROWNUM <= 1
    ORDER BY
      LICENSE.ID ASC, CHARGE.ID DESC;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        var_recent_charge := 0;
  END;

  RETURN var_recent_charge;

EXCEPTION
WHEN BAD_SUBSCRIPTION_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'No such subscription');
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END GET_RECENT_CHARGE;

/******************************************************************************/

FUNCTION GET_BILLING_CYCLE (
  in_subscription_id IN NUMBER
) RETURN VARCHAR2 AS
-- VARIABLES
SPROC_NAME           CONSTANT VARCHAR2(17) := 'GET_BILLING_CYCLE';
temp_subscription_id NUMBER;
var_offer_duration   VARCHAR2(30);

-- EXCEPTIONS
BAD_SUBSCRIPTION_ID EXCEPTION;
BEGIN

  BEGIN
    SELECT
      SUBSCRIPTION.ID into temp_subscription_id
    FROM
      SUBSCRIPTION
    WHERE
      SUBSCRIPTION.ID = in_subscription_id;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE BAD_SUBSCRIPTION_ID;
  END;

  SELECT
    OFFER.ENTITLEMENT_DURATION into var_offer_duration
  FROM
    LICENSE
    INNER JOIN SUBSCRIPTION ON LICENSE.SUBSCRIPTION_ID = SUBSCRIPTION.ID
    INNER JOIN OFFER ON LICENSE.OFFER_ID = OFFER.ID
  WHERE
    --LICENSE.LICENSE_STATUS_ID = GLOBAL_STATUSES_V18.LICENSE_PROCESSED
    --AND
    SUBSCRIPTION.ID = in_subscription_id
    AND ROWNUM <= 1
  ORDER BY
    LICENSE.ID ASC;

  RETURN var_offer_duration;

EXCEPTION
WHEN BAD_SUBSCRIPTION_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'No such subscription');
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END GET_BILLING_CYCLE;

/******************************************************************************/

PROCEDURE REFUND_SUBSCRIPTION (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_subscription_id IN NUMBER,
  in_invoice_id      IN NUMBER,
  in_refund_amount   IN NUMBER,
  in_note            IN VARCHAR2,
  in_created_by      IN VARCHAR2,
  out_charge_id      OUT NUMBER
) AS
-- VARIABLES
SPROC_NAME             CONSTANT VARCHAR2(19) := 'REFUND_SUBSCRIPTION';
var_invoice_status_id  NUMBER;
var_account_id         NUMBER;
var_account_status_id  NUMBER;
var_new_transaction_id NUMBER;
var_instrument_type_id NUMBER;
var_instrument_id      NUMBER;
var_new_charge_id      NUMBER;
var_invoice_amount     NUMBER(10,2);
var_refunds_before     NUMBER(10,2);
var_charges_amount     NUMBER(10,2);
-- EXCEPTIONS
BAD_SUBSCRIPTION_ID           EXCEPTION;
ACCOUNT_IS_FROZEN             EXCEPTION;
BAD_INVOICE_ID                EXCEPTION;
CAN_NOT_CREATE_TRANSACTION    EXCEPTION;
CAN_NOT_CREATE_CHARGE         EXCEPTION;
CAN_NOT_CALC_INVOICE_AMOUNT   EXCEPTION;
REFUND_IS_GREATER_THAN_ANOUNT EXCEPTION;
CAN_NOT_ANNOTATE_SUBSCRIPTION EXCEPTION;
TOT_REF_IS_GREATER_THAN_ANOUNT EXCEPTION;
INVOICE_IS_NOT_CLOSED         EXCEPTION;
TOT_REF_IS_GRATER_THAN_CHARGES EXCEPTION;
EXCEPTION_MESSAGE              VARCHAR2(1024);
BEGIN

  BEGIN
    SELECT
      SUBSCRIPTION.INSTRUMENT_ID,
      SUBSCRIPTION.INSTRUMENT_TYPE_ID,
      SUBSCRIPTION.ACCOUNT_ID
      into
      var_instrument_id,
      var_instrument_type_id,
      var_account_id
    FROM
      SUBSCRIPTION
    WHERE
      SUBSCRIPTION.ID = in_subscription_id;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE BAD_SUBSCRIPTION_ID;
  END;

  -- Check account status. It should not to be frozen
  SELECT
    ACCOUNT.ACCOUNT_STATUS_ID into var_account_status_id
  FROM
    ACCOUNT
  WHERE
    ACCOUNT.ID = var_account_id;

  IF var_account_status_id = GLOBAL_STATUSES_V18.ACCOUNT_FROZEN THEN
    RAISE ACCOUNT_IS_FROZEN;
  END IF;

  BEGIN
    SELECT
      INVOICE.INVOICE_STATUS_ID into var_invoice_status_id
    FROM
      INVOICE
    WHERE
      INVOICE.ID = in_invoice_id;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE BAD_INVOICE_ID;
  END;

  IF var_invoice_status_id != GLOBAL_STATUSES_V18.INVOICE_CLOSED THEN
    RAISE INVOICE_IS_NOT_CLOSED;
  END IF;

  BEGIN
    PROCS_INVOICE_V18.CALCULATE_INVOICE_AMOUNT (
      in_invoice_id => in_invoice_id,
      out_amount    => var_invoice_amount
    );
    EXCEPTION
      WHEN OTHERS THEN
        EXCEPTION_MESSAGE := SQLERRM;
        RAISE CAN_NOT_CALC_INVOICE_AMOUNT;
  END;

  IF ( in_refund_amount > var_invoice_amount ) THEN
    RAISE REFUND_IS_GREATER_THAN_ANOUNT;
  END IF;

  SELECT /*+ STAR_TRANSFORMATION */
    SUM(CHARGE.CHARGE_AMOUNT) into var_refunds_before
  FROM
    CHARGE
  WHERE
    CHARGE.INVOICE_ID = in_invoice_id
    AND (
      CHARGE.CHARGE_STATUS_ID = GLOBAL_STATUSES_V18.CHARGE_OPENED
      OR CHARGE.CHARGE_STATUS_ID = GLOBAL_STATUSES_V18.CHARGE_PROCESSED
    )
    AND CHARGE.CHARGE_AMOUNT < 0;

  -- Refunds are negative
  var_refunds_before := -var_refunds_before;

  var_charges_amount := 0;

  FOR f_processed_charges IN (
    SELECT
      CHARGE.CHARGE_AMOUNT
    FROM
      CHARGE
    WHERE
      CHARGE.INVOICE_ID = in_invoice_id
      AND CHARGE.CHARGE_STATUS_ID IN (SELECT GLOBAL_STATUSES_V18.CHARGE_PROCESSED FROM DUAL)
  )
  LOOP
    IF f_processed_charges.CHARGE_AMOUNT > 0 THEN
      var_charges_amount := var_charges_amount + f_processed_charges.CHARGE_AMOUNT;
    END IF;
  END LOOP;

  IF (in_refund_amount + var_refunds_before > var_invoice_amount) THEN
    RAISE TOT_REF_IS_GREATER_THAN_ANOUNT;
  END IF;

  IF (in_refund_amount + var_refunds_before > var_charges_amount) THEN
    RAISE TOT_REF_IS_GRATER_THAN_CHARGES;
  END IF;

  BEGIN
    PROCS_TRANSACTION_V18.CREATE_TRANSACTION(
      in_transaction_id         => NULL,
      in_status_id              => GLOBAL_STATUSES_V18.TRANSACTION_PREPARE,
      in_amount                 => -in_refund_amount,
      in_created_by             => in_created_by,
      in_order_id               => NULL,
      in_is_refund              => GLOBAL_CONSTANTS_V18.TRUE,
      in_transaction_type_code  => 'REFUND',
      out_transaction_id        => var_new_transaction_id
    );
    EXCEPTION
      WHEN OTHERS THEN
        EXCEPTION_MESSAGE := SQLERRM;
        RAISE CAN_NOT_CREATE_TRANSACTION;
  END;

  BEGIN
    PROCS_CHARGE_V18.CREATE_CHARGE(
      in_invoice_id         => in_invoice_id,
      in_transaction_id     => var_new_transaction_id,
      in_instrument_type_id => var_instrument_type_id,
      in_instrument_id      => var_instrument_id,
      in_charge_amount      => -in_refund_amount,
      in_created_by         => in_created_by,
      in_charge_status_id   => GLOBAL_STATUSES_V18.CHARGE_OPENED,
      out_charge_id         => var_new_charge_id
    );
    EXCEPTION
      WHEN OTHERS THEN
        EXCEPTION_MESSAGE := SQLERRM;
        RAISE CAN_NOT_CREATE_CHARGE;
  END;

  IF in_note IS NOT NULL THEN
    BEGIN
      PROCS_SUBSCRIPTION_V18.ANNOTATE_SUBSCRIPTION(
        in_subscription_id => in_subscription_id,
        in_agent_id        => 0, -- AGENT_ID??
        in_note            => in_note,
        in_created_by      => in_created_by
      );
      EXCEPTION
        WHEN OTHERS THEN
          EXCEPTION_MESSAGE := SQLERRM;
          RAISE CAN_NOT_ANNOTATE_SUBSCRIPTION;
    END;
  END IF;

  out_charge_id := var_new_charge_id;

EXCEPTION
WHEN INVOICE_IS_NOT_CLOSED THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.STATE_ERROR,
    SPROC_NAME, 'Invoice is not closed');
WHEN BAD_SUBSCRIPTION_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'No such subscription');
WHEN ACCOUNT_IS_FROZEN THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.STATE_ERROR,
    SPROC_NAME, 'Could not refund subscription for frozen account');
WHEN BAD_INVOICE_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'No such invoice');
WHEN CAN_NOT_CALC_INVOICE_AMOUNT THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.INTERNAL_ERROR,
    SPROC_NAME, 'Could not calculate invoice amount', EXCEPTION_MESSAGE);
WHEN REFUND_IS_GREATER_THAN_ANOUNT THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.INVALID_PARAMETER,
    SPROC_NAME, 'Refund is greater than amount');
WHEN TOT_REF_IS_GREATER_THAN_ANOUNT THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.INVALID_PARAMETER,
    SPROC_NAME, 'There were refunds before and sum of all refunds and new refund more than invoice amount');
WHEN TOT_REF_IS_GRATER_THAN_CHARGES THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.INVALID_PARAMETER,
    SPROC_NAME, 'Total refund amount is greater than sum of processed charges');
WHEN CAN_NOT_CREATE_TRANSACTION THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.INTERNAL_ERROR,
    SPROC_NAME, 'Could not create transaction', EXCEPTION_MESSAGE);
WHEN CAN_NOT_CREATE_CHARGE THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.INTERNAL_ERROR,
    SPROC_NAME, 'Could not create charge', EXCEPTION_MESSAGE);
WHEN CAN_NOT_ANNOTATE_SUBSCRIPTION THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.INTERNAL_ERROR,
    SPROC_NAME, 'Could not annotate subscription', EXCEPTION_MESSAGE);
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END REFUND_SUBSCRIPTION;

/******************************************************************************/

PROCEDURE ADD_SUBSCRIPTION_EXTENSION (
/*
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.INTERNAL_ERROR
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_subscription_id      IN NUMBER,
  in_effective_start_date IN DATE,
  in_effective_end_date   IN DATE,
  in_note                 IN VARCHAR2,
  in_updated_by           IN VARCHAR2
) AS
-- VARIABLES
SPROC_NAME                   CONSTANT VARCHAR2(26) := 'ADD_SUBSCRIPTION_EXTENSION';
temp_subscription_id         NUMBER;
var_current_license_id       NUMBER;
var_current_license_start_date DATE;
var_current_license_end_date DATE;
var_current_offer_id         NUMBER;
var_current_invoice_id       NUMBER;
var_current_date             DATE;
var_current_offer_index      NUMBER;
var_current_offer_recurr_num NUMBER;
var_account_tax_exempt_id    VARCHAR2(255);

var_free_invoice_id NUMBER;
var_free_license_id NUMBER;
var_new_license_id  NUMBER;
var_ext_license_id  NUMBER;
-- EXCEPTIONS
BAD_SUBSCRIPTION_ID           EXCEPTION;
CAN_NOT_FIND_OFFER_OR_LICENSE EXCEPTION;
CAN_NOT_CHANGE_LICENSE_STATUS EXCEPTION;
CAN_NOT_CREATE_INVOICE        EXCEPTION;
CAN_NOT_CREATE_NEW_LICENSE    EXCEPTION;
CAN_NOT_CREATE_END_LICENSE    EXCEPTION;
CAN_NOT_ANNOTATE_SUBSCRIPTION EXCEPTION;
EXTENS_START_DATE_IS_TOO_FAR  EXCEPTION;
EXT_START_DATE_LATER_THEN_END EXCEPTION;
EXTENS_START_DATE_IS_TOO_SMALL EXCEPTION;
EXCEPTION_MESSAGE             VARCHAR2(1024);
BEGIN

  var_current_date := PROCS_COMMON_V18.NORMALIZE_DATE(SYSDATE);

  -- Check that subscription exists
  BEGIN
    SELECT
      SUBSCRIPTION.ID into temp_subscription_id
    FROM
      SUBSCRIPTION
    WHERE
      SUBSCRIPTION.ID = in_subscription_id;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE BAD_SUBSCRIPTION_ID;
  END;

  -- Get account tax exempt id
  SELECT DISTINCT
    ACCOUNT.TAX_EXEMPT_ID into var_account_tax_exempt_id
  FROM
    ACCOUNT
    INNER JOIN SUBSCRIPTION ON SUBSCRIPTION.ACCOUNT_ID = ACCOUNT.ID
  WHERE
    SUBSCRIPTION.ID = in_subscription_id;

  -- Select current data
  BEGIN
    SELECT
      LICENSE.ID,
      LICENSE.START_DATE,
      LICENSE.END_DATE,
      LICENSE.CURRENT_OFFER_INDEX,
      LICENSE.CURRENT_OFFER_RECURR_NUM,
      OFFER.ID,
      INVOICE.ID
    INTO
      var_current_license_id,
      var_current_license_start_date,
      var_current_license_end_date,
      var_current_offer_index,
      var_current_offer_recurr_num,
      var_current_offer_id,
      var_current_invoice_id
    FROM
      LICENSE
      INNER JOIN SUBSCRIPTION ON LICENSE.SUBSCRIPTION_ID = SUBSCRIPTION.ID
      INNER JOIN OFFER ON LICENSE.OFFER_ID = OFFER.ID
      INNER JOIN INVOICE ON LICENSE.INVOICE_ID = INVOICE.ID
    WHERE
      SUBSCRIPTION.ID = in_subscription_id
      AND PROCS_COMMON_V18.NORMALIZE_DATE(LICENSE.END_DATE) > var_current_date
      AND PROCS_COMMON_V18.NORMALIZE_DATE(LICENSE.START_DATE) <= var_current_date
      AND ROWNUM <= 1
    ORDER BY
      LICENSE.ID DESC;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE CAN_NOT_FIND_OFFER_OR_LICENSE;
  END;

  IF var_current_license_end_date < in_effective_start_date THEN
    RAISE EXTENS_START_DATE_IS_TOO_FAR;
  END IF;

  IF var_current_license_start_date > in_effective_start_date THEN
    RAISE EXTENS_START_DATE_IS_TOO_SMALL;
  END IF;

  IF in_effective_start_date > in_effective_end_date THEN
    RAISE EXT_START_DATE_LATER_THEN_END;
  END IF;

  -- Closing curent license
  BEGIN
    PROCS_LICENSE_CRU_V18.UPDATE_LICENSE(
      in_license_id         => var_current_license_id,
      in_updated_by         => in_updated_by,
      in_license_status_id  => GLOBAL_STATUSES_V18.LICENSE_CLOSED,
      in_end_date           => in_effective_start_date,
      in_needs_entitlements => GLOBAL_CONSTANTS_V18.TRUE
    );
    EXCEPTION
      WHEN OTHERS THEN
        EXCEPTION_MESSAGE := SQLERRM;
        RAISE CAN_NOT_CHANGE_LICENSE_STATUS;
  END;

  -- Creating new "free" invoice
  BEGIN
    PROCS_INVOICE_V18.CREATE_INVOICE(
      in_invoice_status => GLOBAL_STATUSES_V18.INVOICE_CLOSED,
      in_created_by     => in_updated_by,
      in_tax_exempt_id  => var_account_tax_exempt_id,
      out_invoice_id    => var_free_invoice_id
    );
    EXCEPTION
      WHEN OTHERS THEN
        EXCEPTION_MESSAGE := SQLERRM;
        RAISE CAN_NOT_CREATE_INVOICE;
  END;

  -- Creating new "free" license
  BEGIN
    PROCS_LICENSE_V18.CREATE_LICENSE (
      in_status_id                => GLOBAL_STATUSES_V18.LICENSE_ACTIVE,
      in_needs_entitlements       => GLOBAL_CONSTANTS_V18.TRUE,
      in_start_date               => in_effective_start_date,
      in_end_date                 => in_effective_end_date,
      in_offer_id                 => var_current_offer_id,
      in_subscription_id          => in_subscription_id,
      in_invoice_id               => var_free_invoice_id,
      in_created_by               => in_updated_by,
      in_is_extension             => GLOBAL_CONSTANTS_V18.TRUE,
      in_current_offer_index      => var_current_offer_index,
      in_current_offer_recurr_num => var_current_offer_recurr_num,
      out_license_id              => var_free_license_id
    );
    EXCEPTION
      WHEN OTHERS THEN
        EXCEPTION_MESSAGE := SQLERRM;
        RAISE CAN_NOT_CREATE_NEW_LICENSE;
  END;

  -- Creating new license
  IF PROCS_COMMON_V18.NORMALIZE_DATE(var_current_license_end_date) >
     PROCS_COMMON_V18.NORMALIZE_DATE(in_effective_start_date) THEN
    BEGIN
      PROCS_LICENSE_V18.CREATE_LICENSE (
        in_status_id                => GLOBAL_STATUSES_V18.LICENSE_ACTIVE,
        in_needs_entitlements       => GLOBAL_CONSTANTS_V18.TRUE,
        in_start_date               => in_effective_end_date,
        in_end_date                 => var_current_license_end_date + (in_effective_end_date - in_effective_start_date),
        in_offer_id                 => var_current_offer_id,
        in_subscription_id          => in_subscription_id,
        in_invoice_id               => var_current_invoice_id,
        in_created_by               => in_updated_by,
        in_is_extension             => GLOBAL_CONSTANTS_V18.FALSE,
        in_current_offer_index      => var_current_offer_index,
        in_current_offer_recurr_num => var_current_offer_recurr_num,
        out_license_id              => var_ext_license_id
      );
      EXCEPTION
        WHEN OTHERS THEN
          EXCEPTION_MESSAGE := SQLERRM;
          RAISE CAN_NOT_CREATE_END_LICENSE;
    END;
  END IF;

  -- Create new note for subscription
  BEGIN
    PROCS_SUBSCRIPTION_V18.ANNOTATE_SUBSCRIPTION (
      in_subscription_id => in_subscription_id,
      in_agent_id        => 0, -- FIXME: What should to be here (agent id)?
      in_note            => in_note,
      in_created_by      => in_updated_by
    );
    EXCEPTION
      WHEN OTHERS THEN
        EXCEPTION_MESSAGE := SQLERRM;
        RAISE CAN_NOT_ANNOTATE_SUBSCRIPTION;
  END;

EXCEPTION
WHEN EXT_START_DATE_LATER_THEN_END THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.INVALID_PARAMETER,
    SPROC_NAME, 'Extension start date is bigger then end date');
WHEN EXTENS_START_DATE_IS_TOO_FAR THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.INVALID_PARAMETER,
    SPROC_NAME, 'Extension start date is too far');
WHEN EXTENS_START_DATE_IS_TOO_SMALL THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.INVALID_PARAMETER,
    SPROC_NAME, 'Extension start date is too small');
WHEN BAD_SUBSCRIPTION_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'No such subscription');
WHEN CAN_NOT_FIND_OFFER_OR_LICENSE THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'Could not find license and/or offer for given subscription');
WHEN CAN_NOT_CHANGE_LICENSE_STATUS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.INTERNAL_ERROR,
    SPROC_NAME, 'Could not change license status', EXCEPTION_MESSAGE);
WHEN CAN_NOT_CREATE_INVOICE THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.INTERNAL_ERROR,
    SPROC_NAME, 'Could not create new invoice', EXCEPTION_MESSAGE);
WHEN CAN_NOT_CREATE_NEW_LICENSE THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.INTERNAL_ERROR,
    SPROC_NAME, 'Could not create new license', EXCEPTION_MESSAGE);
WHEN CAN_NOT_CREATE_END_LICENSE THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.INTERNAL_ERROR,
    SPROC_NAME, 'Could not create last license', EXCEPTION_MESSAGE);
WHEN CAN_NOT_ANNOTATE_SUBSCRIPTION THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.INTERNAL_ERROR,
    SPROC_NAME, 'Could not create new note for subscription', EXCEPTION_MESSAGE);
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END ADD_SUBSCRIPTION_EXTENSION;

/******************************************************************************/

FUNCTION CALC_SUBSCRIPTION_END_DATE (
/*
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.INTERNAL_ERROR
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
Returns:
NULL if it is impossible to calculate end date (for example,
  offer chain includes offer with infinity recurrences number)
DATE else
*/
  in_subscription_id IN NUMBER
) RETURN DATE AS
-- VARIABLES
SPROC_NAME                    CONSTANT VARCHAR2(26) := 'CALC_SUBSCRIPTION_END_DATE';
last_license_id               NUMBER;
last_license_end_date         DATE;
last_license_offer_id         NUMBER;
last_license_offer_index      NUMBER;
last_license_offer_recurr_num NUMBER;
var_last_license_id           NUMBER;
var_offer_chain_id            NUMBER;
var_current_offer_rec_number  NUMBER;
var_next_offers_set           SYS_REFCURSOR;
var_next_offer_duration       VARCHAR2(30);
var_next_offer_recur          NUMBER;
var_infinity_offers_number    NUMBER;

var_result_date DATE;

var_ym_interval  INTERVAL YEAR TO MONTH;
var_ds_interval  INTERVAL DAY(3) TO SECOND;
var_offer_years  NUMBER;
var_offer_months NUMBER;
var_offer_days   NUMBER;

-- EXCEPTIONS
BAD_SUBSCRIPTION_ID        EXCEPTION;
CAN_NOT_FIND_LAST_LICENSE  EXCEPTION;
CAN_NOT_CALC_OFFER_LENGTH  EXCEPTION;
CAN_NOT_CALC_OFFER_LENGTH2 EXCEPTION;
EXCEPTION_MESSAGE          VARCHAR2(1024);
BEGIN

  BEGIN
    SELECT
      SUBSCRIPTION.OFFER_CHAIN_ID into var_offer_chain_id
    FROM
      SUBSCRIPTION
    WHERE
      SUBSCRIPTION.ID = in_subscription_id;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE BAD_SUBSCRIPTION_ID;
  END;

  BEGIN
    SELECT
      ID into var_last_license_id
    FROM
      (
        SELECT
          LICENSE.ID
        FROM
          LICENSE
        WHERE
          LICENSE.SUBSCRIPTION_ID = in_subscription_id
        ORDER BY
          LICENSE.END_DATE DESC
      )
    WHERE
      ROWNUM <= 1;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE CAN_NOT_FIND_LAST_LICENSE;
  END;

  SELECT
    COUNT(*) into var_infinity_offers_number
  FROM
    OFFER_OFFER_CHAIN
  WHERE
    OFFER_OFFER_CHAIN.OFFER_CHAIN_ID = var_offer_chain_id
    AND OFFER_OFFER_CHAIN.NUM_RECURRENCES = GLOBAL_ENUMS_V18.OFFER_REC_INFINITY;

  IF var_infinity_offers_number > 0 THEN
    RETURN NULL;
  END IF;

  BEGIN
    SELECT
      LICENSE.ID,
      LICENSE.END_DATE,
      LICENSE.CURRENT_OFFER_INDEX,
      LICENSE.CURRENT_OFFER_RECURR_NUM,
      LICENSE.OFFER_ID
      into
      last_license_id,
      last_license_end_date,
      last_license_offer_index,
      last_license_offer_recurr_num,
      last_license_offer_id
    FROM
      LICENSE
    WHERE
      LICENSE.ID = var_last_license_id;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE CAN_NOT_FIND_LAST_LICENSE;
  END;

  var_result_date := last_license_end_date;

  -- Find current recurrence number
  SELECT
    OFFER_OFFER_CHAIN.NUM_RECURRENCES into var_current_offer_rec_number
  FROM
    OFFER_OFFER_CHAIN
  WHERE
    OFFER_OFFER_CHAIN.OFFER_CHAIN_ID = var_offer_chain_id
    AND OFFER_OFFER_CHAIN.OFFER_ID = last_license_offer_id
    AND OFFER_OFFER_CHAIN.INDEX_VALUE = last_license_offer_index;

  IF var_current_offer_rec_number > last_license_offer_recurr_num THEN
    BEGIN
      PROCS_OFFER_CHAIN_V18.GET_OFFER_LENGTH(
        last_license_offer_id,
        var_offer_years,
        var_offer_months,
        var_offer_days
      );

      var_ym_interval := var_offer_years||'-'||var_offer_months;
      var_ds_interval := var_offer_days||' 0:0:0';

      var_result_date := var_result_date
        + ( var_ym_interval * ( var_current_offer_rec_number - last_license_offer_recurr_num ) )
        + ( var_ds_interval * ( var_current_offer_rec_number - last_license_offer_recurr_num ) );
      EXCEPTION
        WHEN OTHERS THEN
          EXCEPTION_MESSAGE := SQLERRM;
          RAISE CAN_NOT_CALC_OFFER_LENGTH;
    END;
  END IF;

  OPEN var_next_offers_set FOR
  SELECT
    OFFER.ENTITLEMENT_DURATION,
    OFFER_OFFER_CHAIN.NUM_RECURRENCES
  FROM
    OFFER_OFFER_CHAIN
    INNER JOIN OFFER ON OFFER_OFFER_CHAIN.OFFER_ID = OFFER.ID
  WHERE
    OFFER_OFFER_CHAIN.INDEX_VALUE > last_license_offer_index
    AND OFFER_OFFER_CHAIN.OFFER_CHAIN_ID = var_offer_chain_id;

  LOOP
    FETCH var_next_offers_set into var_next_offer_duration, var_next_offer_recur;
    EXIT WHEN var_next_offers_set%NOTFOUND;
    BEGIN
      PROCS_COMMON_V18.ISO8601DURATION_TO_INTERVALS(
        var_next_offer_duration,
        var_offer_years,
        var_offer_months,
        var_offer_days
      );

      var_ym_interval := var_offer_years||'-'||var_offer_months;
      var_ds_interval := var_offer_days||' 0:0:0';

      var_result_date := var_result_date
        + ( var_ym_interval * var_next_offer_recur )
        + ( var_ds_interval * var_next_offer_recur );
      EXCEPTION
        WHEN OTHERS THEN
          EXCEPTION_MESSAGE := SQLERRM;
          RAISE CAN_NOT_CALC_OFFER_LENGTH2;
    END;
  END LOOP;

  RETURN var_result_date;

EXCEPTION
WHEN BAD_SUBSCRIPTION_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'No such subscription');
WHEN CAN_NOT_FIND_LAST_LICENSE THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'Could not find last license for given subscription');
WHEN CAN_NOT_CALC_OFFER_LENGTH THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.INTERNAL_ERROR,
    SPROC_NAME, 'Could not calculate offer length', EXCEPTION_MESSAGE);
WHEN CAN_NOT_CALC_OFFER_LENGTH2 THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.INTERNAL_ERROR,
    SPROC_NAME, 'Could not calculate last offer length', EXCEPTION_MESSAGE);
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unkown error', SQLERRM);
END CALC_SUBSCRIPTION_END_DATE;

/******************************************************************************/

PROCEDURE HAS_FUTURE_LICENSE (
/*
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
--
RETURNS:
GLOBAL_CONSTANTS_V18.TRUE - if has,
GLOBAL_CONSTANTS_V18.FALSE - else
*/
  in_license_id IN  NUMBER,
  out_result    OUT NUMBER
) AS
-- VARIABLES
SPROC_NAME                CONSTANT VARCHAR2(18) := 'HAS_FUTURE_LICENSE';
var_subscription_id       NUMBER;
var_future_licenses_count NUMBER;
-- EXCEPTIONS
BAD_LICENSE_ID       EXCEPTION;
BEGIN

  BEGIN
    SELECT
      LICENSE.SUBSCRIPTION_ID into var_subscription_id
    FROM
      LICENSE
    WHERE
      LICENSE.ID = in_license_id;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE BAD_LICENSE_ID;
  END;

  SELECT
    COUNT(*) into var_future_licenses_count
  FROM
    LICENSE
  WHERE
    LICENSE.ID != in_license_id
    AND LICENSE.SUBSCRIPTION_ID = var_subscription_id
    AND LICENSE.END_DATE > sysdate;

  IF var_future_licenses_count > 0 THEN
    out_result := GLOBAL_CONSTANTS_V18.TRUE;
  ELSE
    out_result := GLOBAL_CONSTANTS_V18.FALSE;
  END IF;

EXCEPTION
WHEN BAD_LICENSE_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'No such license');
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END HAS_FUTURE_LICENSE;

/******************************************************************************/

PROCEDURE CLOSE_SUBSCRIPTION (
  in_subscription_id IN NUMBER,
  in_updated_by      IN VARCHAR2
) AS
-- VARIABLES
SPROC_NAME           CONSTANT VARCHAR2(18) := 'CLOSE_SUBSCRIPTION';
temp_subscription_id NUMBER;
var_licenses_count   NUMBER;
-- EXCEPTIONS
BAD_SUBSCRIPTION_ID    EXCEPTION;
ACTIVE_LICENSES_FOUND  EXCEPTION;
EXCEPTION_MESSAGE      VARCHAR2(1024);
BEGIN

  BEGIN
    SELECT
      SUBSCRIPTION.ID into temp_subscription_id
    FROM
      SUBSCRIPTION
    WHERE
      SUBSCRIPTION.ID = in_subscription_id;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE BAD_SUBSCRIPTION_ID;
  END;

  SELECT
    COUNT(*) into var_licenses_count
  FROM
    LICENSE
  WHERE
    LICENSE.SUBSCRIPTION_ID = in_subscription_id
    AND LICENSE.LICENSE_STATUS_ID = GLOBAL_STATUSES_V18.LICENSE_ACTIVE;

  IF var_licenses_count > 0 THEN
    RAISE ACTIVE_LICENSES_FOUND;
  END IF;

  PROCS_SUBSCRIPTION_V18.UPDATE_SUBSCRIPTION_STATUS(
    in_subscription_id        => in_subscription_id,
    in_updated_by             => in_updated_by,
    in_subscription_status_id => GLOBAL_STATUSES_V18.SUBSCRIPTION_CLOSED
  );

EXCEPTION
WHEN BAD_SUBSCRIPTION_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'No such subscription');
WHEN ACTIVE_LICENSES_FOUND THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.STATE_ERROR,
    SPROC_NAME, 'Active licenses found');
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END CLOSE_SUBSCRIPTION;

/******************************************************************************/

PROCEDURE GET_GROUP_ID_BY_SBSCRPTN_ID (
  in_subscription_id IN NUMBER,
  out_group_id       OUT NUMBER
) AS
SPROC_NAME CONSTANT VARCHAR2(27) := 'GET_GROUP_ID_BY_SBSCRPTN_ID';
BEGIN
  SELECT
    ACCOUNT.GROUP_ID into out_group_id
  FROM
    SUBSCRIPTION
    INNER JOIN ACCOUNT ON SUBSCRIPTION.ACCOUNT_ID = ACCOUNT.ID
  WHERE
    SUBSCRIPTION.ID = in_subscription_id;
EXCEPTION
WHEN NO_DATA_FOUND THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'No such subscription');
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END GET_GROUP_ID_BY_SBSCRPTN_ID;

/******************************************************************************/

PROCEDURE GET_SUBSCRIPTION_PRODUCTS (
/*
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_subscription_id IN NUMBER,
  out_result_set     OUT SYS_REFCURSOR
) AS
SPROC_NAME CONSTANT VARCHAR2(25) := 'GET_SUBSCRIPTION_PRODUCTS';
-- VARIABLES
var_offer_chain NUMBER;
-- EXCEPTIONS
BAD_SUBSCRIPTION_ID EXCEPTION;
BEGIN
  BEGIN
    SELECT
      SUBSCRIPTION.OFFER_CHAIN_ID into var_offer_chain
    FROM
      SUBSCRIPTION
    WHERE
      SUBSCRIPTION.ID = in_subscription_id;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE BAD_SUBSCRIPTION_ID;
  END;

  OPEN out_result_set FOR
  SELECT DISTINCT
    PRODUCT.ID,
    PRODUCT.NAME
  FROM
    PRODUCT
  WHERE
    PRODUCT.ID IN (
      SELECT DISTINCT
        PRODUCT_OFFERING.PRODUCT_ID
      FROM
        PRODUCT_OFFERING
      WHERE
        PRODUCT_OFFERING.ID IN (
          SELECT DISTINCT
            OFFER_PRODUCT_OFFERING.PRODUCT_OFFERING_ID
          FROM
            OFFER_PRODUCT_OFFERING
          WHERE
            OFFER_PRODUCT_OFFERING.OFFER_ID IN (
              SELECT DISTINCT
                OFFER_OFFER_CHAIN.OFFER_ID
              FROM
                OFFER_OFFER_CHAIN
              WHERE
                OFFER_OFFER_CHAIN.OFFER_CHAIN_ID = var_offer_chain
            )
        )
    );

EXCEPTION
WHEN BAD_SUBSCRIPTION_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'No such subscription');
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END GET_SUBSCRIPTION_PRODUCTS;

/******************************************************************************/

PROCEDURE UPDATE_SUBSCRIPTION_STATUS (
  in_subscription_id        IN SUBSCRIPTION.ID%TYPE,
  in_subscription_status_id IN SUBSCRIPTION.SUBSCRIPTION_STATUS_ID%TYPE,
  in_updated_by             IN SUBSCRIPTION.UPDATED_BY%TYPE
) AS
SPROC_NAME CONSTANT VARCHAR2(26) := 'UPDATE_SUBSCRIPTION_STATUS';
BEGIN
  PROCS_SUBSCRIPTION_CRU_V18.UPDATE_SUBSCRIPTION(
    in_subscription_id        => in_subscription_id,
    in_subscription_status_id => in_subscription_status_id,
    in_updated_by             => in_updated_by
  );
END UPDATE_SUBSCRIPTION_STATUS;

/******************************************************************************/

PROCEDURE GET_ACTIVE_INVOICES_IDS (
/*
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
--  in_subscription_id IN SUBSCRIPTION.ID%TYPE,
  in_subscription_id IN NUMBER,
  out_result_set     OUT SYS_REFCURSOR
) AS
SPROC_NAME CONSTANT VARCHAR2(23) := 'GET_ACTIVE_INVOICES_IDS';
-- VARIABLES
temp_subscription_id SUBSCRIPTION.ID%TYPE;
-- EXCEPTIONS
BAD_SUBSCRIPTION_ID EXCEPTION;
BEGIN

  BEGIN
    SELECT
      SUBSCRIPTION.ID into temp_subscription_id
    FROM
      SUBSCRIPTION
    WHERE
      SUBSCRIPTION.ID = in_subscription_id;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE BAD_SUBSCRIPTION_ID;
  END;

  OPEN out_result_set FOR
  SELECT DISTINCT
    LICENSE.INVOICE_ID as "ID"
  FROM
    LICENSE
  WHERE
    LICENSE.LICENSE_STATUS_ID in (GLOBAL_STATUSES_V18.LICENSE_ACTIVE, GLOBAL_STATUSES_V18.LICENSE_IN_GRACE_PERIOD)
    AND LICENSE.SUBSCRIPTION_ID = in_subscription_id;

EXCEPTION
WHEN BAD_SUBSCRIPTION_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'No such subscription');
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END GET_ACTIVE_INVOICES_IDS;

/******************************************************************************/

PROCEDURE CANCEL_SUBSCRIPTION_INVOICE (
/*
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
APP_EXCEPTION_CODES_V18.INTERNAL_ERROR
*/
  in_invoice_id        IN NUMBER,
  in_updated_by        IN VARCHAR2,
  in_refundable        IN NUMBER DEFAULT GLOBAL_CONSTANTS_V18.FALSE
) AS
SPROC_NAME CONSTANT VARCHAR2(27) := 'CANCEL_SUBSCRIPTION_INVOICE';
-- VARIABLES
temp_invoice_id        INVOICE.ID%TYPE;
var_chargeback_amount  NUMBER(10,2);
ver_refund_charge_id   NUMBER;
-- EXCEPTIONS
BAD_INVOICE_ID               EXCEPTION;
CAN_NOT_CALCULATE_CHARGEBACK EXCEPTION;
CAN_NOT_APPLY_CHARGEBACK     EXCEPTION;
EXCEPTION_MESSAGE            VARCHAR2(1024);
-- STUB
var_now DATE;
var_revoke NUMBER;
var_refund NUMBER;
var_billed NUMBER;
var_subscription_in_grace NUMBER;
BEGIN

  var_now := sysdate;

  -- Check that invoice exists
  BEGIN
    SELECT
      INVOICE.ID into temp_invoice_id
    FROM
      INVOICE
    WHERE
      INVOICE.ID = in_invoice_id;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE BAD_INVOICE_ID;
  END;

  select decode(count(1), 0, GLOBAL_CONSTANTS_V18.FALSE, GLOBAL_CONSTANTS_V18.TRUE) into var_revoke
  from license l, subscription s, offer_chain oc
  where
    l.subscription_id = s.id and
    s.offer_chain_id = oc.id and
    l.invoice_id = in_invoice_id and
    oc.revoke_entitlements = GLOBAL_CONSTANTS_V18.TRUE and
    rownum < 2;

  select
    decode(s.subscription_status_id, GLOBAL_STATUSES_V18.SUBSCRIPTION_IN_GRACE_PERIOD, 1, 0)
  into
    var_subscription_in_grace
  from license l, subscription s
  where
    l.subscription_id = s.id and
    l.invoice_id = in_invoice_id and
    rownum < 2;

  var_billed := PROCS_INVOICE_V18.IS_INVOICE_PAYING_STARTED(in_invoice_id);
  var_refund := GLOBAL_CONSTANTS_V18.FALSE;

  -- Check that transaction for given invoice not started
  -- if refund enabled calculate and apply chargeback
  IF (
      var_billed = GLOBAL_CONSTANTS_V18.TRUE
    )THEN
    if (in_refundable = GLOBAL_CONSTANTS_V18.TRUE) then
      -- If started then we need to calculate refund
      BEGIN
        PROCS_INVOICE_V18.CALCULATE_INVOICE_CHARGEBACK(
          in_invoice_id,
          var_now,
          var_chargeback_amount
        );
        EXCEPTION
          WHEN OTHERS THEN
            EXCEPTION_MESSAGE := SQLERRM;
            RAISE CAN_NOT_CALCULATE_CHARGEBACK;
      END;
      IF var_chargeback_amount > 0 THEN
        BEGIN
          PROCS_INVOICE_V18.APPLY_REFUND(
            in_invoice_id,
            var_chargeback_amount,
            in_updated_by,
            ver_refund_charge_id
          );
          EXCEPTION
            WHEN OTHERS THEN
              EXCEPTION_MESSAGE := SQLERRM;
              RAISE CAN_NOT_APPLY_CHARGEBACK;
        END;
        var_refund := GLOBAL_CONSTANTS_V18.TRUE;
      END IF;
    end if;
  ELSE

    FOR f_transaction_to_close IN (
      SELECT DISTINCT CHARGE.TRANSACTION_ID AS "ID" FROM CHARGE WHERE CHARGE.INVOICE_ID = in_invoice_id and CHARGE.CHARGE_STATUS_ID = GLOBAL_STATUSES_V18.CHARGE_OPENED
    )
    LOOP
      PROCS_TRANSACTION_V18.UPDATE_TRANSACTION_STATUS(
        in_transaction_id        => f_transaction_to_close.ID,
        in_updated_by            => in_updated_by,
        in_transaction_status_id => GLOBAL_STATUSES_V18.TRANSACTION_CLOSED
      );
    END LOOP;
    -- Needs to close charges. No refund.
    FOR f_charge_to_close IN (
      SELECT CHARGE.ID FROM CHARGE WHERE CHARGE.INVOICE_ID = in_invoice_id and CHARGE.CHARGE_STATUS_ID = GLOBAL_STATUSES_V18.CHARGE_OPENED
    )
    LOOP
      PROCS_CHARGE_V18.UPDATE_CHARGE_STATUS(
        in_charge_id        => f_charge_to_close.ID,
        in_updated_by       => in_updated_by,
        in_charge_status_id => GLOBAL_STATUSES_V18.CHARGE_CANCELED
      );
    END LOOP;

    PROCS_INVOICE_V18.UPDATE_INVOICE_STATUS(
      in_invoice_id                  => in_invoice_id,
      in_updated_by                  => in_updated_by,
      in_invoice_status_id           => GLOBAL_STATUSES_V18.INVOICE_CLOSED
    );

  END IF;
  -- update licenses
  IF(var_revoke = GLOBAL_CONSTANTS_V18.TRUE OR var_chargeback_amount > 0 OR (var_subscription_in_grace = GLOBAL_CONSTANTS_V18.FALSE AND var_billed = GLOBAL_CONSTANTS_V18.FALSE)) THEN
    FOR f_license_to_cancel IN (
      SELECT LICENSE.ID FROM LICENSE WHERE LICENSE.INVOICE_ID = in_invoice_id AND LICENSE.LICENSE_STATUS_ID = GLOBAL_STATUSES_V18.LICENSE_ACTIVE
    )
    LOOP
      PROCS_LICENSE_CRU_V18.UPDATE_LICENSE(
        in_license_id         => f_license_to_cancel.ID,
        in_license_status_id  => GLOBAL_STATUSES_V18.LICENSE_CLOSED,
        in_needs_entitlements => GLOBAL_CONSTANTS_V18.TRUE,
        in_updated_by         => in_updated_by,
        in_entitlement_end_date => var_now
      );
    END LOOP;
  ELSE
    FOR f_license_to_cancel IN (
      SELECT LICENSE.ID FROM LICENSE WHERE LICENSE.INVOICE_ID = in_invoice_id AND LICENSE.LICENSE_STATUS_ID in (GLOBAL_STATUSES_V18.LICENSE_ACTIVE, GLOBAL_STATUSES_V18.LICENSE_IN_GRACE_PERIOD)
    )
    LOOP
      PROCS_LICENSE_CRU_V18.UPDATE_LICENSE(
        in_license_id         => f_license_to_cancel.ID,
        in_license_status_id  => GLOBAL_STATUSES_V18.LICENSE_CLOSED,
        in_updated_by         => in_updated_by
      );
    END LOOP;
  END IF;


EXCEPTION
WHEN BAD_INVOICE_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'No such invoice');
WHEN CAN_NOT_CALCULATE_CHARGEBACK THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.INTERNAL_ERROR,
    SPROC_NAME, 'Could not calculate invoice refund', EXCEPTION_MESSAGE);
WHEN CAN_NOT_APPLY_CHARGEBACK THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.INTERNAL_ERROR,
    SPROC_NAME, 'Could not apply chargeback', EXCEPTION_MESSAGE);
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END CANCEL_SUBSCRIPTION_INVOICE;

/******************************************************************************/

PROCEDURE FINALIZE_CANCELATION (
/*
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
APP_EXCEPTION_CODES_V18.INTERNAL_ERROR
*/
--  in_subscription_id    IN SUBSCRIPTION.ID%TYPE,
--  in_cancelation_reason IN SUBSCRIPTION_CANCEL_REASON.VALUE%TYPE,
--  in_cancelation_date   IN SUBSCRIPTION.CANCELLATION_DATE%TYPE,
--  in_note               IN SUBSCRIPTION_NOTE.NOTE%TYPE,
--  in_agent_id           IN SUBSCRIPTION_NOTE.AGENT_ID%TYPE,
--  in_updated_by         IN SUBSCRIPTION.UPDATED_BY%TYPE
  in_subscription_id    IN NUMBER,
  in_cancelation_reason IN VARCHAR2,
  in_cancelation_date   IN DATE,
  in_note               IN VARCHAR2,
  in_agent_id           IN NUMBER,
  in_updated_by         IN VARCHAR2
) AS
SPROC_NAME CONSTANT VARCHAR2(20) := 'FINALIZE_CANCELATION';
-- VARIABLES
var_current_subscr_status SUBSCRIPTION.SUBSCRIPTION_STATUS_ID%TYPE;
var_sct_id                SUBSCRIPTION.SCT_ID%TYPE;
var_active_invoices_count NUMBER;
var_license_to_disgrace   LICENSE.ID%TYPE;
var_now                   DATE := SYSDATE;
-- EXCEPTIONS
BAD_SUBSCRIPTION_ID         EXCEPTION;
BAD_SUBSCRIPTION_STATUS     EXCEPTION;
BAD_CANCELATION_REASON      EXCEPTION;
CAN_NOT_UPDATE_SUBSCRIPTION EXCEPTION;
ACTIVE_INVOICES_FOUND       EXCEPTION;
CAN_NOT_CREATE_NOTE         EXCEPTION;
EXCEPTION_MESSAGE           VARCHAR2(1024);
BEGIN

  -- Get current subscription status
  BEGIN
    SELECT
      SUBSCRIPTION.SUBSCRIPTION_STATUS_ID into var_current_subscr_status
    FROM
      SUBSCRIPTION
    WHERE
      SUBSCRIPTION.ID = in_subscription_id;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE BAD_SUBSCRIPTION_ID;
  END;

  -- Check that subscription reason is correct
  BEGIN
    SELECT
      SUBSCRIPTION_CANCEL_REASON.ID into var_sct_id
    FROM
      SUBSCRIPTION_CANCEL_REASON
    WHERE
      SUBSCRIPTION_CANCEL_REASON.VALUE LIKE in_cancelation_reason
      AND ROWNUM <= 1;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE BAD_CANCELATION_REASON;
  END;

  -- Check for invoices with active licenses
  SELECT
    COUNT(*) into var_active_invoices_count
  FROM
    LICENSE
    INNER JOIN INVOICE ON LICENSE.INVOICE_ID = INVOICE.ID
  WHERE
    LICENSE.LICENSE_STATUS_ID in (GLOBAL_STATUSES_V18.LICENSE_ACTIVE, GLOBAL_STATUSES_V18.LICENSE_IN_GRACE_PERIOD)
    AND LICENSE.SUBSCRIPTION_ID = in_subscription_id;

  IF var_active_invoices_count > 0 THEN
    RAISE ACTIVE_INVOICES_FOUND;
  END IF;

  -- Check that subscription is active
  IF var_current_subscr_status != GLOBAL_STATUSES_V18.SUBSCRIPTION_ACTIVE AND
     var_current_subscr_status != GLOBAL_STATUSES_V18.SUBSCRIPTION_SUSPENDED AND
     var_current_subscr_status != GLOBAL_STATUSES_V18.SUBSCRIPTION_IN_GRACE_PERIOD THEN
    RAISE BAD_SUBSCRIPTION_STATUS;
  END IF;

  -- Update subscription data
  BEGIN
    PROCS_SUBSCRIPTION_CRU_V18.UPDATE_SUBSCRIPTION(
      in_subscription_id        => in_subscription_id,
      in_subscription_status_id => GLOBAL_STATUSES_V18.SUBSCRIPTION_CANCELED,
      in_cancelation_date       => in_cancelation_date,
      in_updated_by             => in_updated_by,
      in_sct_id                 => var_sct_id
    );
    EXCEPTION
      WHEN OTHERS THEN
        EXCEPTION_MESSAGE := SQLERRM;
        RAISE CAN_NOT_UPDATE_SUBSCRIPTION;
  END;

  -- Terminate grace period for licenses in grace [SAR-31]
  BEGIN
    SELECT
      LICENSE.ID into var_license_to_disgrace
    FROM
      LICENSE
    WHERE
      LICENSE.SUBSCRIPTION_ID = in_subscription_id
      AND LICENSE.LICENSE_STATUS_ID = GLOBAL_STATUSES_V18.LICENSE_IN_GRACE_PERIOD
      AND ROWNUM <= 1
    ORDER BY
      CREATE_DATE DESC;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      var_license_to_disgrace := NULL;
  END;

  IF var_license_to_disgrace IS NOT NULL THEN
    PROCS_LICENSE_CRU_V18.UPDATE_LICENSE(
      in_license_id           => var_license_to_disgrace,
      in_license_status_id    => GLOBAL_STATUSES_V18.LICENSE_CLOSED,
      in_updated_by           => in_updated_by
    );
  END IF;

  -- Annotate subscription
  IF in_note IS NOT NULL THEN
    BEGIN
      PROCS_SUBSCRIPTION_V18.ANNOTATE_SUBSCRIPTION(
        in_subscription_id,
        in_agent_id,
        in_note,
        in_updated_by
      );
      EXCEPTION
       WHEN OTHERS THEN
         EXCEPTION_MESSAGE := SQLERRM;
         RAISE CAN_NOT_CREATE_NOTE;
    END;
  END IF;

EXCEPTION
WHEN BAD_SUBSCRIPTION_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'No such subscription');
WHEN BAD_SUBSCRIPTION_STATUS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.INVALID_PARAMETER,
    SPROC_NAME, 'Bad current subscription status');
WHEN BAD_CANCELATION_REASON THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.INVALID_PARAMETER,
    SPROC_NAME, 'Bad cancellation reason');
WHEN CAN_NOT_UPDATE_SUBSCRIPTION THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.INTERNAL_ERROR,
    SPROC_NAME, 'Could not update subscription data', EXCEPTION_MESSAGE);
WHEN ACTIVE_INVOICES_FOUND THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.STATE_ERROR,
    SPROC_NAME, 'Invoices with active licenses found');
WHEN CAN_NOT_CREATE_NOTE THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.INTERNAL_ERROR,
    SPROC_NAME, 'Could not annotate subscription', EXCEPTION_MESSAGE);
--WHEN OTHERS THEN
--  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
--    SPROC_NAME, 'Unknown error', SQLERRM);
END FINALIZE_CANCELATION;

/******************************************************************************/

PROCEDURE FINALIZE_FALSE_START (
/*
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
APP_EXCEPTION_CODES_V18.INTERNAL_ERROR
*/
--  in_subscription_id    IN SUBSCRIPTION.ID%TYPE,
--  in_cancelation_date   IN SUBSCRIPTION.CANCELLATION_DATE%TYPE,
--  in_note               IN SUBSCRIPTION_NOTE.NOTE%TYPE,
--  in_agent_id           IN SUBSCRIPTION_NOTE.AGENT_ID%TYPE,
--  in_updated_by         IN SUBSCRIPTION.UPDATED_BY%TYPE
  in_subscription_id    IN NUMBER,
  in_cancelation_date   IN DATE,
  in_note               IN VARCHAR2,
  in_agent_id           IN NUMBER,
  in_updated_by         IN VARCHAR2
) AS
SPROC_NAME CONSTANT VARCHAR2(20) := 'FINALIZE_FALSE_START';
FALSE_START_REASON CONSTANT NUMBER := 41;
-- VARIABLES
var_current_subscr_status SUBSCRIPTION.SUBSCRIPTION_STATUS_ID%TYPE;
var_active_invoices_count NUMBER;
-- EXCEPTIONS
BAD_SUBSCRIPTION_ID         EXCEPTION;
BAD_SUBSCRIPTION_STATUS     EXCEPTION;
CAN_NOT_UPDATE_SUBSCRIPTION EXCEPTION;
ACTIVE_INVOICES_FOUND       EXCEPTION;
CAN_NOT_CREATE_NOTE         EXCEPTION;
EXCEPTION_MESSAGE           VARCHAR2(1024);
BEGIN

  -- Get current subscription status
  BEGIN
    SELECT
      SUBSCRIPTION.SUBSCRIPTION_STATUS_ID into var_current_subscr_status
    FROM
      SUBSCRIPTION
    WHERE
      SUBSCRIPTION.ID = in_subscription_id;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE BAD_SUBSCRIPTION_ID;
  END;

  -- Check for invoices with active licenses
  SELECT
    COUNT(*) into var_active_invoices_count
  FROM
    LICENSE
    INNER JOIN INVOICE ON LICENSE.INVOICE_ID = INVOICE.ID
  WHERE
    LICENSE.LICENSE_STATUS_ID = GLOBAL_STATUSES_V18.LICENSE_ACTIVE
    AND LICENSE.SUBSCRIPTION_ID = in_subscription_id;

  IF var_active_invoices_count > 0 THEN
    RAISE ACTIVE_INVOICES_FOUND;
  END IF;

  -- Check that subscription is active
  IF var_current_subscr_status != GLOBAL_STATUSES_V18.SUBSCRIPTION_ACTIVE
     AND var_current_subscr_status != GLOBAL_STATUSES_V18.SUBSCRIPTION_SUSPENDED THEN
    RAISE BAD_SUBSCRIPTION_STATUS;
  END IF;

  -- Update subscription data
  BEGIN
    PROCS_SUBSCRIPTION_CRU_V18.UPDATE_SUBSCRIPTION(
      in_subscription_id        => in_subscription_id,
      in_subscription_status_id => GLOBAL_STATUSES_V18.SUBSCRIPTION_FALSE_START,
      in_cancelation_date       => in_cancelation_date,
      in_updated_by             => in_updated_by,
      in_sct_id                 => FALSE_START_REASON
    );
    EXCEPTION
      WHEN OTHERS THEN
        EXCEPTION_MESSAGE := SQLERRM;
        RAISE CAN_NOT_UPDATE_SUBSCRIPTION;
  END;

  -- Annotate subscription
  IF in_note IS NOT NULL THEN
    BEGIN
      PROCS_SUBSCRIPTION_V18.ANNOTATE_SUBSCRIPTION(
        in_subscription_id,
        in_agent_id,
        in_note,
        in_updated_by
      );
      EXCEPTION
       WHEN OTHERS THEN
         EXCEPTION_MESSAGE := SQLERRM;
         RAISE CAN_NOT_CREATE_NOTE;
    END;
  END IF;

EXCEPTION
WHEN BAD_SUBSCRIPTION_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'No such subscription');
WHEN BAD_SUBSCRIPTION_STATUS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.INVALID_PARAMETER,
    SPROC_NAME, 'Bad current subscription status');
WHEN CAN_NOT_UPDATE_SUBSCRIPTION THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.INTERNAL_ERROR,
    SPROC_NAME, 'Could not update subscription data', EXCEPTION_MESSAGE);
WHEN ACTIVE_INVOICES_FOUND THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.STATE_ERROR,
    SPROC_NAME, 'Invoices with active licenses found');
WHEN CAN_NOT_CREATE_NOTE THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.INTERNAL_ERROR,
    SPROC_NAME, 'Could not annotate subscription', EXCEPTION_MESSAGE);
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END FINALIZE_FALSE_START;

/******************************************************************************/

FUNCTION IS_SUBSCRIPTION_CANCELABLE (
  in_subscription_id IN NUMBER
) RETURN NUMBER AS
SPROC_NAME CONSTANT VARCHAR2(26) := 'IS_SUBSCRIPTION_CANCELABLE';
-- VARIABLES
var_is_offer_chain_cancelable NUMBER;
--64603
var_end_date date;
today_date date := current_date;
offer_id number;
-- EXCEPTIONS
COULD_NOT_CHECK     EXCEPTION;
BAD_SUBSCRIPTION_ID EXCEPTION;
EXCEPTION_MESSAGE   VARCHAR2(1024);
BEGIN

  BEGIN
    -- find offer_chain_id for given in_subscription_id
    SELECT OFFER_CHAIN_ID into offer_id
    FROM SUBSCRIPTION
    WHERE ID = in_subscription_id;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE BAD_SUBSCRIPTION_ID;
      WHEN OTHERS THEN
        EXCEPTION_MESSAGE := SQLERRM;
        RAISE COULD_NOT_CHECK;
  END;

  -- find if it was redeemed from a gift certificate
  BEGIN
    SELECT l.end_date INTO var_end_date
    FROM LICENSE l, GIFT_CERTIFICATE g
    WHERE l.invoice_id = g.finalized_invoice_id
    AND l.subscription_id = in_subscription_id;

    -- if the license end_date is bigger than today, we are in the
    -- first period, so we cannot cancel; otherwise can cancel
    IF var_end_date > today_date THEN
        RETURN GLOBAL_CONSTANTS_V18.FALSE;
    ELSE
        RETURN GLOBAL_CONSTANTS_V18.TRUE;
    END IF;

    EXCEPTION
        -- not coming from a gift certificate,
        -- use old logic
        WHEN NO_DATA_FOUND THEN
            SELECT
                PROCS_OFFER_CHAIN_V18.IS_OFFER_CHAIN_CANCELABLE(offer_id)
                INTO var_is_offer_chain_cancelable
            FROM DUAL;
            RETURN var_is_offer_chain_cancelable;
  END;

EXCEPTION
WHEN BAD_SUBSCRIPTION_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'No such subscription');
WHEN COULD_NOT_CHECK THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.INTERNAL_ERROR,
    SPROC_NAME, 'Could not check if offer chain calcelable', EXCEPTION_MESSAGE);
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);

END IS_SUBSCRIPTION_CANCELABLE;
/******************************************************************************/

PROCEDURE GET_SUBSCR_PROD_OFFERRINGS (
/*
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_subscription_id IN NUMBER,
  out_result_set     OUT SYS_REFCURSOR
) AS
SPROC_NAME CONSTANT VARCHAR2(26) := 'GET_SUBSCR_PROD_OFFERRINGS';
-- VARIABLES
var_offer NUMBER;
-- EXCEPTIONS
BAD_SUBSCRIPTION_ID EXCEPTION;
BEGIN

  OPEN out_result_set FOR
  SELECT DISTINCT
    PRODUCT_OFFERING.ID,
    PRODUCT_OFFERING.PRODUCT_ID,
    PRODUCT_OFFERING.TAX_CATEGORY_ID,
    PRODUCT_OFFERING.UNIT_PRICE,
    PRODUCT_OFFERING.QUANTITY,
    PRODUCT_OFFERING.CREATE_DATE,
    PRODUCT_OFFERING.CREATED_BY,
    CAPABILITY.ID CAP_ID,
    CAPABILITY.CODE CAP_CODE,
    CAPABILITY.DESCRIPTION CAP_DESCRIPTION,
    CAPABILITY.SHAREABLE CAP_SHAREABLE
  FROM
    OFFER_PRODUCT_OFFERING
    INNER JOIN PRODUCT_OFFERING ON PRODUCT_OFFERING.ID = OFFER_PRODUCT_OFFERING.PRODUCT_OFFERING_ID
    INNER JOIN CAPABILITY ON PRODUCT_OFFERING.CAPABILITY_ID = CAPABILITY.ID
  WHERE
    OFFER_PRODUCT_OFFERING.OFFER_ID IN (
      SELECT
        LICENSE.OFFER_ID
      FROM
        SUBSCRIPTION
        JOIN LICENSE ON LICENSE.SUBSCRIPTION_ID = SUBSCRIPTION.ID AND LICENSE.NEEDS_ENTITLEMENTS = GLOBAL_CONSTANTS_V18.TRUE
      WHERE
        SUBSCRIPTION.ID = in_subscription_id
    );

EXCEPTION
WHEN BAD_SUBSCRIPTION_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'No such subscription');
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END GET_SUBSCR_PROD_OFFERRINGS;


PROCEDURE RETRIEVE_SUB_PROD_OFFER (
/*
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_subscription_id IN NUMBER,
  out_result_set     OUT SYS_REFCURSOR
) AS
SPROC_NAME CONSTANT VARCHAR2(27) := 'RETRIEVE_SUB_PROD_OFFER';
-- VARIABLES
var_offer NUMBER;
-- EXCEPTIONS
BAD_SUBSCRIPTION_ID EXCEPTION;
BEGIN

  OPEN out_result_set FOR
  SELECT DISTINCT
    PRODUCT_OFFERING.ID,
    PRODUCT_OFFERING.PRODUCT_ID,
    PRODUCT_OFFERING.TAX_CATEGORY_ID,
    PRODUCT_OFFERING.UNIT_PRICE,
    PRODUCT_OFFERING.QUANTITY,
    PRODUCT_OFFERING.CREATE_DATE,
    PRODUCT_OFFERING.CREATED_BY,
    CAPABILITY.ID CAP_ID,
    CAPABILITY.CODE CAP_CODE,
    CAPABILITY.DESCRIPTION CAP_DESCRIPTION,
    CAPABILITY.SHAREABLE CAP_SHAREABLE
  FROM
    OFFER_PRODUCT_OFFERING
    INNER JOIN PRODUCT_OFFERING ON PRODUCT_OFFERING.ID = OFFER_PRODUCT_OFFERING.PRODUCT_OFFERING_ID
    INNER JOIN CAPABILITY ON PRODUCT_OFFERING.CAPABILITY_ID = CAPABILITY.ID
  WHERE
    OFFER_PRODUCT_OFFERING.OFFER_ID IN (
      SELECT
        LICENSE.OFFER_ID
      FROM
        SUBSCRIPTION
        JOIN LICENSE ON LICENSE.SUBSCRIPTION_ID = SUBSCRIPTION.ID
      WHERE
        SUBSCRIPTION.ID = in_subscription_id
    );

EXCEPTION
WHEN BAD_SUBSCRIPTION_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'No such subscription');
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END RETRIEVE_SUB_PROD_OFFER;
/******************************************************************************/




PROCEDURE GET_SUBSCR_LIC_OFFER(
/*
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_subscription_id IN NUMBER,
  out_result_set     OUT SYS_REFCURSOR
) AS
SPROC_NAME CONSTANT VARCHAR2(26) := 'GET_SUBSCR_LIC_OFFER';
-- VARIABLES
var_offer_chain NUMBER;
-- EXCEPTIONS
BAD_SUBSCRIPTION_ID EXCEPTION;
BEGIN
  BEGIN
    SELECT
      SUBSCRIPTION.OFFER_CHAIN_ID into var_offer_chain
    FROM
      SUBSCRIPTION
    WHERE
      SUBSCRIPTION.ID = in_subscription_id;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE BAD_SUBSCRIPTION_ID;
  END;

  OPEN out_result_set FOR
  SELECT DISTINCT
    po.ID po_id,
    po.PRODUCT_ID po_product_id,
    po.TAX_CATEGORY_ID po_tax_category_id,
    po.UNIT_PRICE po_unit_price,
    po.QUANTITY po_quantity,
    po.CREATE_DATE po_create_date,
    po.CREATED_BY po_created_by,
    l.ID l_id,
    l.license_status_id l_license_status_id,
    l.start_date l_start_date,
    l.offer_id l_offer_id,
    l.subscription_id l_subscription_id,
    l.invoice_id l_invoice_id,
    l.end_date l_end_date,
    l.entitlement_end_date l_entitlement_end_date,
    l.create_date l_create_date,
    l.created_by l_created_by,
    l.is_extension l_is_extension,
    l.current_offer_index l_current_offer_index,
    l.current_offer_recurr_num l_current_offer_recurr_num,
    l.needs_entitlements l_needs_entitlements
  FROM
    OFFER_PRODUCT_OFFERING opo,
    PRODUCT_OFFERING po,
    SUBSCRIPTION s,
    LICENSE l
  WHERE
    opo.product_offering_id = po.id
    and po.id = l.offer_id
    and l.subscription_id = s.id
    and l.license_status_id = GLOBAL_STATUSES_V18.LICENSE_ACTIVE
    and s.id = in_subscription_id
  ;
EXCEPTION
WHEN BAD_SUBSCRIPTION_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'No such subscription');
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END GET_SUBSCR_LIC_OFFER;

/******************************************************************************/

PROCEDURE ARE_REFUNDS_PENDING_FOR_SUBSCR (
/*
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_subscription_id IN NUMBER,
  out_result         OUT NUMBER
) AS
SPROC_NAME CONSTANT VARCHAR2(30) := 'ARE_REFUNDS_PENDING_FOR_SUBSCR';
-- VARIABLES
temp_subscription_id NUMBER;
var_local_result     NUMBER;
-- EXCEPTIONS
BAD_SUBSCRIPTION_ID EXCEPTION;
BEGIN

  -- Check that subscription exists
  BEGIN
    SELECT
      SUBSCRIPTION.ID into temp_subscription_id
    FROM
      SUBSCRIPTION
    WHERE
      SUBSCRIPTION.ID = in_subscription_id;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE BAD_SUBSCRIPTION_ID;
  END;

  var_local_result := NULL;

  -- Check charges for each invoice associated with gived subscription
  FOR f_invoice IN (
    SELECT DISTINCT
      LICENSE.INVOICE_ID as "ID"
    FROM
      LICENSE
    WHERE
      LICENSE.SUBSCRIPTION_ID = in_subscription_id
      AND LICENSE.LICENSE_STATUS_ID IN ( SELECT GLOBAL_STATUSES_V18.LICENSE_ACTIVE FROM DUAL )
  )
  LOOP

    -- Check each charge in invoice
    FOR f_charge IN (
      SELECT
        CHARGE.ID,
        CHARGE.CHARGE_STATUS_ID,
        CHARGE.CHARGE_AMOUNT
      FROM
        CHARGE
      WHERE
        CHARGE.INVOICE_ID = f_invoice.ID
    )
    LOOP

      -- Charge amount < 0     => it is a refund
      -- Charge status is OPEN => means that it is not processed yet
      IF f_charge.CHARGE_AMOUNT < 0
         AND f_charge.CHARGE_STATUS_ID = GLOBAL_STATUSES_V18.CHARGE_OPENED THEN
        var_local_result := GLOBAL_CONSTANTS_V18.TRUE;
      END IF;

    END LOOP;

  END LOOP;

  IF var_local_result IS NULL THEN
    out_result := GLOBAL_CONSTANTS_V18.FALSE;
  ELSE
    out_result := GLOBAL_CONSTANTS_V18.TRUE;
  END IF;

EXCEPTION
WHEN BAD_SUBSCRIPTION_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'No such transaction id');
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END ARE_REFUNDS_PENDING_FOR_SUBSCR;

PROCEDURE GET_EXISTING_SUBSCR_NUMBER (
/*
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_group_id        IN NUMBER,
  in_offer_chain_id  IN NUMBER,
  out_result         OUT NUMBER
) AS
SPROC_NAME CONSTANT VARCHAR2(28) := 'GET_EXISTING_SUBSCR_NUMBER';
-- VARIABLES
temp_acct_id         NUMBER;
temp_oc_id           NUMBER;
-- EXCEPTIONS
BAD_GROUP_ID EXCEPTION;
BAD_OFFER_CHAIN_ID EXCEPTION;
BEGIN
  -- Check that group id exists
  BEGIN
    SELECT
      ACCOUNT.ID into temp_acct_id
    FROM
      ACCOUNT
    WHERE
      ACCOUNT.GROUP_ID = in_group_id;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE BAD_GROUP_ID;
  END;
  -- Check that offer chain id exists
  BEGIN
    SELECT
      OFFER_CHAIN.ID into temp_oc_id
    FROM
      OFFER_CHAIN
    WHERE
      OFFER_CHAIN.ID = in_offer_chain_id;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE BAD_OFFER_CHAIN_ID;
  END;
  SELECT
    COUNT(*) into out_result
  FROM
    SUBSCRIPTION
      INNER JOIN ACCOUNT ON SUBSCRIPTION.ACCOUNT_ID = ACCOUNT.ID
  WHERE
    ACCOUNT.GROUP_ID = in_group_id
    AND SUBSCRIPTION.OFFER_CHAIN_ID = in_offer_chain_id
    AND (
      SUBSCRIPTION.SUBSCRIPTION_STATUS_ID = GLOBAL_STATUSES_V18.SUBSCRIPTION_ACTIVE
      OR SUBSCRIPTION.SUBSCRIPTION_STATUS_ID = GLOBAL_STATUSES_V18.SUBSCRIPTION_IN_GRACE_PERIOD);

EXCEPTION
WHEN BAD_GROUP_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'No such transaction id');
WHEN BAD_OFFER_CHAIN_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'No such offer chain id');
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    sproc_name, 'Unknown error', sqlerrm);
END GET_EXISTING_SUBSCR_NUMBER;

PROCEDURE GET_EXISTING_SUBSCR_IDS (
/*
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_group_id        IN NUMBER,
  in_offer_chain_id  IN NUMBER,
  out_result_set     OUT SYS_REFCURSOR
) AS
SPROC_NAME CONSTANT VARCHAR2(26) := 'GET_EXISTING_SUBSCR_NUMBER';
-- VARIABLES
temp_acct_id         NUMBER;
temp_oc_id           NUMBER;
-- EXCEPTIONS
BAD_GROUP_ID EXCEPTION;
BAD_OFFER_CHAIN_ID EXCEPTION;
BEGIN

  -- Check that group id exists
  BEGIN
    SELECT
      ACCOUNT.ID into temp_acct_id
    FROM
      ACCOUNT
    WHERE
      ACCOUNT.GROUP_ID = in_group_id;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE BAD_GROUP_ID;
  END;
  -- Check that offer chain id exists
  BEGIN
    SELECT
      OFFER_CHAIN.ID into temp_oc_id
    FROM
      OFFER_CHAIN
    WHERE
      OFFER_CHAIN.ID = in_offer_chain_id;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE BAD_OFFER_CHAIN_ID;
  END;

  OPEN out_result_set FOR
  SELECT
    SUBSCRIPTION.ID
  FROM
    SUBSCRIPTION
    INNER JOIN ACCOUNT ON SUBSCRIPTION.ACCOUNT_ID = ACCOUNT.ID
  WHERE
    ACCOUNT.GROUP_ID = in_group_id
    AND SUBSCRIPTION.OFFER_CHAIN_ID = in_offer_chain_id
    AND (
      SUBSCRIPTION.SUBSCRIPTION_STATUS_ID = GLOBAL_STATUSES_V18.SUBSCRIPTION_ACTIVE
      OR SUBSCRIPTION.SUBSCRIPTION_STATUS_ID = GLOBAL_STATUSES_V18.SUBSCRIPTION_IN_GRACE_PERIOD);

EXCEPTION
WHEN BAD_GROUP_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'No such transaction id');
WHEN BAD_OFFER_CHAIN_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'No such offer chain id');
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    sproc_name, 'Unknown error', sqlerrm);
END GET_EXISTING_SUBSCR_IDS;

PROCEDURE ADD_META_DATA (
/*
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_subscription_id IN NUMBER,
  in_name            IN VARCHAR2,
  in_value           IN VARCHAR2,
  in_created_by      IN VARCHAR2
) AS
SPROC_NAME CONSTANT VARCHAR2(13) := 'ADD_META_DATA';
BEGIN

  INSERT INTO SUBSCRIPTION_META_DATA (
    ID,
    SUBSCRIPTION_ID,
    NAME,
    VALUE,
    CREATE_DATE,
    CREATED_BY
  ) VALUES (
    SUBMD_ID_SEQ.nextVal,
    in_subscription_id,
    in_name,
    in_value,
    sysdate,
    in_created_by
  );

EXCEPTION
WHEN OTHERS THEN
  IF SQLCODE = -2291 THEN
    PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
      SPROC_NAME, 'No such subscription');
  ELSE
    PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
      SPROC_NAME, 'Unknown error', sqlerrm);
  END IF;
END ADD_META_DATA;

/******************************************************************************/

PROCEDURE GET_SUBSCRIPTIONS_META_DATA (
/*
APP_EXCEPTION_CODES_V18.INVALID_PARAMETER
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_subscriptions_ids IN core_owner.NUMBER_TABLE,
  out_result_set       OUT SYS_REFCURSOR
) AS
SPROC_NAME CONSTANT VARCHAR2(27) := 'GET_SUBSCRIPTIONS_META_DATA';
-- Exceptions
SUBSCRIPTION_IDS_IS_NULL EXCEPTION;
BEGIN

  IF in_subscriptions_ids IS NULL THEN
    RAISE SUBSCRIPTION_IDS_IS_NULL;
  END IF;

  OPEN out_result_set FOR
  SELECT
    SMD.SUBSCRIPTION_ID,
    SMD.NAME,
    SMD.VALUE
  FROM
    SUBSCRIPTION_META_DATA SMD
  WHERE
    SMD.SUBSCRIPTION_ID IN (SELECT * FROM TABLE(in_subscriptions_ids));

EXCEPTION
WHEN SUBSCRIPTION_IDS_IS_NULL THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.INVALID_PARAMETER,
    SPROC_NAME, 'Bad subscription ids parameter');
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END GET_SUBSCRIPTIONS_META_DATA;

PROCEDURE GET_SUBS_BY_TRNS_ORDER_ID (
/*
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_order_id        IN TRANSACTION.ORDER_ID%TYPE,
  out_result_set     OUT SYS_REFCURSOR
) AS
SPROC_NAME CONSTANT VARCHAR2(25) := 'GET_SUBS_BY_TRNS_ORDER_ID';
BEGIN
  OPEN out_result_set FOR
  SELECT subscription.id FROM
    subscription
  INNER JOIN license ON license.subscription_id = subscription.id
  INNER JOIN invoice ON invoice.id = license.invoice_id
  INNER JOIN charge ON invoice.id = charge.invoice_id
  INNER JOIN transaction ON charge.transaction_id = transaction.id
  WHERE transaction.order_id = in_order_id;
EXCEPTION
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', sqlerrm);
END GET_SUBS_BY_TRNS_ORDER_ID;

PROCEDURE GET_OPEN_CHARGES_BY_SUBID
 (
/*
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_subscription_id  IN SUBSCRIPTION.ID%TYPE,
  out_result_set      OUT SYS_REFCURSOR
)
AS
SPROC_NAME CONSTANT VARCHAR2(32) := 'GET_OPEN_CHARGES_BY_SUBID';
BEGIN
  OPEN out_result_set FOR
  SELECT
    c.ID,
    c.TRANSACTION_ID,
    c.INSTRUMENT_ID,
    c.INSTRUMENT_TYPE_ID,
    c.CHARGE_AMOUNT,
    c.CREATE_DATE,
    c.CREATED_BY,
    c.INVOICE_ID
   FROM
    subscription s,
    license l,
    charge c
  WHERE
    s.id = l.subscription_id and
    l.invoice_id = c.invoice_id and
    c.charge_status_id = GLOBAL_STATUSES_V18.CHARGE_OPENED and
    exists (
      select null
      from transaction t
      where
        t.id = c.transaction_id
    ) and
    s.id = in_subscription_id;
EXCEPTION
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', sqlerrm);
END GET_OPEN_CHARGES_BY_SUBID;

FUNCTION GET_GIFT_CERT_ID_BY_SUB_ID (
  in_subscription_id IN SUBSCRIPTION.ID%TYPE
) RETURN NUMBER
AS
var_gift_certificate_id NUMBER;
BEGIN
      SELECT id INTO var_gift_certificate_id
      FROM
        gift_certificate gc
      WHERE
        gc.finalized_invoice_id in (
          SELECT invoice_id
          FROM (
            SELECT l.invoice_id
            FROM
              license l
            WHERE
              l.subscription_id = in_subscription_id
            ORDER BY l.create_date asc
          )
        )
        and rownum <= 1;
      return var_gift_certificate_id;
END GET_GIFT_CERT_ID_BY_SUB_ID;

FUNCTION GET_GIFT_CERT_CODE_BY_SUB_ID (
  in_subscription_id IN SUBSCRIPTION.ID%TYPE
) RETURN VARCHAR2
AS
var_gift_certificate_code VARCHAR2(255 BYTE);
BEGIN
      SELECT code INTO var_gift_certificate_code
      FROM
        gift_certificate gc
      WHERE
        gc.finalized_invoice_id in (
          SELECT invoice_id
          FROM (
            SELECT l.invoice_id
            FROM
              license l
            WHERE
              l.subscription_id = in_subscription_id
          )
        )
        and rownum <= 1;
      return var_gift_certificate_code;
END GET_GIFT_CERT_CODE_BY_SUB_ID;

PROCEDURE GET_ACTIVE_MEU_SUBS (
  out_result_set      OUT SYS_REFCURSOR
)
AS
SPROC_NAME     CONSTANT VARCHAR2(19) := 'GET_ACTIVE_MEU_SUBS';
BEGIN
  OPEN out_result_set FOR
        SELECT
            s.id,
            s.instrument_type_id,
            s.instrument_id,
            a.group_id,
            s.offer_chain_id
        FROM
            core_owner.subscription s,
            core_owner.account a
        WHERE
            a.id = s.account_id AND(
                s.offer_chain_id = 1745992781 OR
                s.offer_chain_id = 3902149773 OR
                s.offer_chain_id = 2240201337) AND
            NOT EXISTS
            (
                SELECT
                    1
                FROM
                    core_owner.subscription ss
                WHERE
                    ss.account_id = a.id AND(
                        ss.offer_chain_id = 2794122734 OR
                        ss.offer_chain_id = 3564368005 OR
                        ss.offer_chain_id = 757934392)) AND
            rownum < 5000;
END GET_ACTIVE_MEU_SUBS;

PROCEDURE GET_EARLIEST_ACTIVE_OFFER_ID (
  in_subscription_id  IN SUBSCRIPTION.ID%TYPE,
  out_offer_id        OUT LICENSE.ID%TYPE
)
AS
SPROC_NAME     CONSTANT VARCHAR2(28) := 'GET_EARLIEST_ACTIVE_OFFER_ID';
BEGIN
  SELECT OFFER_ID INTO out_offer_id
  FROM LICENSE L,
  (
    SELECT MIN(ID) ID FROM LICENSE
    WHERE SUBSCRIPTION_ID = in_subscription_id
    AND LICENSE_STATUS_ID = 2
    AND SYSDATE BETWEEN START_DATE AND END_DATE
  ) EARLIEST_ACTIVE_LICENSE
  WHERE L.ID = EARLIEST_ACTIVE_LICENSE.ID;
END GET_EARLIEST_ACTIVE_OFFER_ID;

PROCEDURE GET_EARLIEST_ACTIVE_LICENSE_ID (
  in_subscription_id  IN SUBSCRIPTION.ID%TYPE,
  out_license_id      OUT LICENSE.ID%TYPE
)
AS
SPROC_NAME     CONSTANT VARCHAR2(30) := 'GET_EARLIEST_ACTIVE_LICENSE_ID';
BEGIN
  SELECT MIN(ID) into out_license_id
  FROM LICENSE
  WHERE SUBSCRIPTION_ID = in_subscription_id
    AND LICENSE_STATUS_ID = 2
  AND SYSDATE BETWEEN START_DATE AND END_DATE;
END GET_EARLIEST_ACTIVE_LICENSE_ID;

PROCEDURE GET_ACT_SUBS_W_CPT_CHARGEBACKS (
  out_result_set      OUT SYS_REFCURSOR
)
AS
SPROC_NAME     CONSTANT VARCHAR2(30) := 'GET_ACT_SUBS_W_CPT_CHARGEBACKS';
BEGIN
  OPEN out_result_set FOR
    SELECT
      s.id
    FROM
      core_owner.transaction t
    INNER JOIN
      core_owner.charge c
    ON
      c.transaction_id = t.id
    INNER JOIN
      core_owner.invoice i
    ON
      i.id = c.invoice_id
    INNER JOIN
      core_owner.license l
    ON
      i.id = l.invoice_id
    INNER JOIN
      core_owner.subscription s
    ON
      l.subscription_id = s.id
    INNER JOIN
      core_owner.account a
    ON
      s.account_id = a.id
    JOIN
      core_owner.rcn_cpt_chargeback_act_detail ccad
    ON
      t.order_id = ccad.merchant_order_number
    WHERE
      ccad.chargeback_category = 'RECD'
    AND s.subscription_status_id in (GLOBAL_STATUSES_V18.SUBSCRIPTION_ACTIVE, GLOBAL_STATUSES_V18.SUBSCRIPTION_IN_GRACE_PERIOD);
END GET_ACT_SUBS_W_CPT_CHARGEBACKS;

PROCEDURE GET_ACT_SUBS_W_PP_CHARGEBACKS (
  out_result_set      OUT SYS_REFCURSOR
)
AS
SPROC_NAME     CONSTANT VARCHAR2(29) := 'GET_ACT_SUBS_W_PP_CHARGEBACKS';
BEGIN
  OPEN out_result_set FOR
    SELECT
      s.id
    FROM
      core_owner.transaction t
    INNER JOIN
      core_owner.charge c
    ON
      c.transaction_id = t.id
    INNER JOIN
      core_owner.invoice i
    ON
      i.id = c.invoice_id
    INNER JOIN
      core_owner.license l
    ON
      i.id = l.invoice_id
    INNER JOIN
      core_owner.subscription s
    ON
      l.subscription_id = s.id
    INNER JOIN
      core_owner.account a
    ON
      s.account_id = a.id
    INNER JOIN
      core_owner.rcn_pp_trans_detail ptd
    ON
      t.order_id = ptd.invoice_id
    WHERE
      ptd.trans_status = 'D'
    AND s.subscription_status_id in (GLOBAL_STATUSES_V18.SUBSCRIPTION_ACTIVE, GLOBAL_STATUSES_V18.SUBSCRIPTION_IN_GRACE_PERIOD);
END GET_ACT_SUBS_W_PP_CHARGEBACKS;

PROCEDURE GET_GRACE_PERIOD_SUB_REGIS (
  in_max_days_until_close IN NUMBER,
  in_num_subs_to_fetch    IN NUMBER,
  out_result_set          OUT SYS_REFCURSOR
)
AS
SPROC_NAME CONSTANT VARCHAR2(30) := 'GET_GRACE_PERIOD_SUB_REGIS';
BEGIN
  OPEN out_result_set FOR
  SELECT
      *
  FROM
      (
          SELECT
              a.group_id group_id,
              l.grace_end_date grace_end_date
          FROM
              license l
          JOIN
              subscription s
          ON
              s.id = l.subscription_id
          JOIN
              account a
          ON
              a.id = s.account_id
          WHERE
              l.license_status_id = GLOBAL_STATUSES_V18.LICENSE_IN_GRACE_PERIOD
          AND l.grace_end_date - SYSDATE <= in_max_days_until_close
          AND NOT EXISTS
              (
                  SELECT
                      NULL
                  FROM
                      process_retry_throttle
                  WHERE
                      process_name = sproc_name
                  AND generic_id = a.group_id)
          AND rownum <= in_num_subs_to_fetch * 10
          ORDER BY
              dbms_random.value)
  WHERE
      rownum <= in_num_subs_to_fetch;
END GET_GRACE_PERIOD_SUB_REGIS;

PROCEDURE GET_ACT_SUBS_W_AMEX_CB (
  out_result_set      OUT SYS_REFCURSOR
)
AS
SPROC_NAME     CONSTANT VARCHAR2(29) := 'GET_ACT_SUBS_W_AMEX_CB';
BEGIN
  OPEN out_result_set FOR
    SELECT
      s.id
    FROM
      core_owner.transaction t
    INNER JOIN
      core_owner.charge c
    ON
      c.transaction_id = t.id
    INNER JOIN
      core_owner.invoice i
    ON
      i.id = c.invoice_id
    INNER JOIN
      core_owner.license l
    ON
      i.id = l.invoice_id
    INNER JOIN
      core_owner.subscription s
    ON
      l.subscription_id = s.id
    INNER JOIN
      core_owner.account a
    ON
      s.account_id = a.id
    INNER JOIN
      core_owner.rcn_amex_chargeback ac
    ON
      t.order_id = lower(ac.ind_ref_number)
    WHERE
      s.subscription_status_id in (GLOBAL_STATUSES_V18.SUBSCRIPTION_ACTIVE, GLOBAL_STATUSES_V18.SUBSCRIPTION_IN_GRACE_PERIOD);
END GET_ACT_SUBS_W_AMEX_CB;

END PROCS_SUBSCRIPTION_V18;
.
/

CREATE OR REPLACE PACKAGE BODY "PROCS_INVOICE_V18" AS

PROCEDURE GET_INVOICE_IDS(
  in_group_id    IN ACCOUNT.GROUP_ID%TYPE,
  in_fin_id      IN SUBSCRIPTION.INSTRUMENT_ID%TYPE,
  out_result_set OUT SYS_REFCURSOR
) AS
SPROC_NAME CONSTANT VARCHAR2(32) := 'GET_INVOICE_IDS';
BEGIN
  OPEN out_result_set FOR
    SELECT
      Invoice.ID
    FROM
        Invoice
        INNER JOIN License
          ON
            License.Invoice_Id = Invoice.Id
        INNER JOIN Subscription
          ON
            License.Subscription_Id = Subscription.Id
        INNER JOIN account
          ON
            Subscription.Account_Id = account.id
    WHERE
      Account.Group_Id = in_group_id
      AND SUBSCRIPTION.INSTRUMENT_ID = in_fin_id
      AND Invoice.Invoice_Status_Id = GLOBAL_STATUSES_V18.INVOICE_OPEN;
END GET_INVOICE_IDS;


PROCEDURE IS_INVOICE_FOR_GC (
  in_invoice_id IN NUMBER,
  out_result    OUT NUMBER
) AS
SPROC_NAME CONSTANT VARCHAR2(32) := 'IS_INVOICE_FOR_GC';
var_is_for_gc NUMBER;
BEGIN
  SELECT
    count(1) into var_is_for_gc
  FROM GIFT_CERTIFICATE GC
  WHERE GC.PURCHASE_INVOICE_ID = in_invoice_id;

  IF var_is_for_gc > 0 THEN
    out_result := 1;
  ELSE
    out_result := 0;
  END IF;
END IS_INVOICE_FOR_GC;

PROCEDURE CREATE_INVOICE(
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
    in_invoice_status IN NUMBER,
    in_created_by     IN VARCHAR2,
    in_tax_exempt_id  IN VARCHAR2,
    out_invoice_id    OUT NUMBER
) AS
-- VARIABLES
SPROC_NAME         CONSTANT VARCHAR2(14) := 'CREATE_INVOICE';
var_new_invoice_id NUMBER;
-- EXCEPTIONS
EXCEPTION_MESSAGE      VARCHAR2(1024);
BEGIN

  PROCS_INVOICE_CRU_V18.CREATE_INVOICE(
    out_invoice_id                 => var_new_invoice_id,
    in_created_by                  => in_created_by,
    in_invoice_status_id           => in_invoice_status,
    in_tax_exempt_id               => in_tax_exempt_id
  );

  out_invoice_id := var_new_invoice_id;
  
EXCEPTION
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END CREATE_INVOICE;

/************************************************************/

PROCEDURE GET_PENDING_INVOICES (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  out_result_set1      OUT SYS_REFCURSOR,
  out_result_set2      OUT SYS_REFCURSOR,
  out_result_set3      OUT SYS_REFCURSOR,
  in_row_number        IN NUMBER DEFAULT NULL
) AS
SPROC_NAME CONSTANT VARCHAR2(20) := 'GET_PENDING_INVOICES';
-- COMSTANTS
DEFAULT_ROW_NUMBER CONSTANT NUMBER := 1;
-- VARIABLES
var_row_number NUMBER;
BEGIN

  IF in_row_number IS NULL THEN
    var_row_number := DEFAULT_ROW_NUMBER;
  ELSE
    var_row_number := in_row_number;
  END IF;

  -- Invoices with one or more payments(charges) with transaction status PENDING
  OPEN out_result_set1 FOR
SELECT * FROM
(
  SELECT
    INVOICE.ID
  FROM
    CHARGE
    INNER JOIN INVOICE ON CHARGE.INVOICE_ID = INVOICE.ID
  WHERE
    EXISTS(
      SELECT NULL
      FROM TRANSACTION
      WHERE 
        TRANSACTION.TRANSACTION_STATUS_ID = GLOBAL_STATUSES_V18.TRANSACTION_PENDING
        AND TRANSACTION.ID = CHARGE.TRANSACTION_ID
	AND TRANSACTION.IS_REFUND != GLOBAL_CONSTANTS_V18.TRUE
	AND TRANSACTION.TRANSACTION_AMOUNT >= 0
    )
    AND
    NOT EXISTS(
      SELECT NULL
      FROM PROCESS_RETRY_THROTTLE
      WHERE PROCESS_NAME = SPROC_NAME
        AND GENERIC_ID = INVOICE.ID
    )
    AND ROWNUM <= var_row_number*10
    ORDER BY dbms_random.value
) WHERE
    ROWNUM <= var_row_number;

  -- Invoices not marked as CLOSED but are fully paid (shouldn't happen).
  OPEN out_result_set2 FOR
  SELECT
    INVOICE.ID
  FROM
    INVOICE
  WHERE
    1 = 2 AND
    (
      INVOICE.INVOICE_STATUS_ID = GLOBAL_STATUSES_V18.INVOICE_OPEN
    )
    AND NOT EXISTS(
      SELECT 1 FROM CHARGE WHERE INVOICE_ID=INVOICE.ID AND CHARGE_STATUS_ID = GLOBAL_STATUSES_V18.CHARGE_OPENED AND ROWNUM <= 1
    )
    AND EXISTS (
      SELECT 1 FROM CHARGE WHERE INVOICE_ID=INVOICE.ID AND CHARGE_STATUS_ID != GLOBAL_STATUSES_V18.CHARGE_OPENED AND ROWNUM <= 1
    )
    AND INVOICE.ID NOT IN
      (
        SELECT GENERIC_ID 
        FROM PROCESS_RETRY_THROTTLE
        WHERE 
          PROCESS_NAME = SPROC_NAME
      )
    AND ROWNUM <= var_row_number;

  -- Invoices not marked as CLOSED with no payments(charges).
  OPEN out_result_set3 FOR
  SELECT
    INVOICE.ID
  FROM
    INVOICE
  WHERE
    1 = 2 AND
    (
      INVOICE.INVOICE_STATUS_ID = GLOBAL_STATUSES_V18.INVOICE_OPEN
    )
    AND NOT EXISTS (
      SELECT 1 FROM CHARGE WHERE CHARGE.INVOICE_ID = INVOICE.ID AND ROWNUM <= 1
    )
    AND INVOICE.ID NOT IN
      (
        SELECT GENERIC_ID 
        FROM PROCESS_RETRY_THROTTLE
        WHERE 
          PROCESS_NAME = SPROC_NAME
      )
    AND ROWNUM <= var_row_number;

EXCEPTION
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END GET_PENDING_INVOICES;

/************************************************************/

FUNCTION F_CALCULATE_INVOICE_AMOUNT(
  in_invoice_id IN  NUMBER
) RETURN NUMBER AS
var_amount NUMBER;
BEGIN

  CALCULATE_INVOICE_AMOUNT(in_invoice_id, var_amount);
  RETURN var_amount;

END;

PROCEDURE CALCULATE_INVOICE_AMOUNT (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_invoice_id IN  NUMBER,
  out_amount    OUT NUMBER
) AS
-- VARIABLES
SPROC_NAME             CONSTANT VARCHAR2(24) := 'CALCULATE_INVOICE_AMOUNT';
temp_invoice_id        NUMBER;
var_total_amount       NUMBER(10,6);
var_final_amount       NUMBER(10,2);
var_line_item_amount   NUMBER(10,6);

var_line_items_set     SYS_REFCURSOR;
var_line_item_id       NUMBER;
var_line_item_quantity NUMBER;
var_line_item_price    NUMBER (10,2);

var_discount_fixed_amount NUMBER (10,2);
var_discount_percent_amount NUMBER (10,2);

-- EXCEPTIONS
BAD_INVOICE_ID                EXCEPTION;
CAN_NOT_CALC_LINE_ITEM_AMOUNT EXCEPTION;
EXCEPTION_MESSAGE VARCHAR2(1024);
BEGIN

  var_total_amount := 0;

  -- Check that given invoice exists
  BEGIN
    SELECT
      INVOICE.ID into temp_invoice_id
    FROM
      INVOICE
    WHERE
      INVOICE.ID = in_invoice_id
      AND ROWNUM <= 1;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE BAD_INVOICE_ID;
  END;
  
  -- Calculate amount for each line item in invoice
  FOR f_line_item IN (
    SELECT
      LINE_ITEM.ID
    FROM
      LINE_ITEM
    WHERE
      LINE_ITEM.INVOICE_ID = in_invoice_id
  )
  LOOP
    BEGIN
      PROCS_LINE_ITEMS_V18.CALCULATE_LINE_ITEM_AMOUNT(
        in_line_item_id => f_line_item.ID,
        out_amount      => var_line_item_amount
      );
      var_total_amount := var_total_amount + var_line_item_amount;
      EXCEPTION
        WHEN OTHERS THEN
          EXCEPTION_MESSAGE := SQLERRM;
          RAISE CAN_NOT_CALC_LINE_ITEM_AMOUNT;
    END;
  END LOOP;
  var_final_amount := var_total_amount;
  out_amount := var_final_amount;
  
EXCEPTION
WHEN BAD_INVOICE_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'No such invoice');
WHEN CAN_NOT_CALC_LINE_ITEM_AMOUNT THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.INTERNAL_ERROR,
    SPROC_NAME, 'Could not calculate line item amount', EXCEPTION_MESSAGE);
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END;

PROCEDURE GET_ACCOUNT_BY_INVOICE_ID (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_invoice_id  IN  NUMBER,
  out_account_id OUT NUMBER
) AS
-- VARIABLES
SPROC_NAME         CONSTANT VARCHAR2(25) := 'GET_ACCOUNT_BY_INVOICE_ID';
temp_gc_account_id NUMBER;
temp_ss_account_id NUMBER;
temp_invoice_id    NUMBER;
-- EXCEPTIONS
BAD_INVOICE_ID       EXCEPTION;
CAN_NOT_FIND_ACCOUNT EXCEPTION;
BEGIN

  -- Check that given invoice exists
  BEGIN
    SELECT
      INVOICE.ID into temp_invoice_id
    FROM
      INVOICE
    WHERE
      INVOICE.ID = in_invoice_id;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE BAD_INVOICE_ID;
  END;

  -- Try to find gift certificate with given invoice
  BEGIN
    SELECT
      ACCOUNT.GROUP_ID into temp_gc_account_id
    FROM
      GIFT_CERTIFICATE
      INNER JOIN ACCOUNT ON GIFT_CERTIFICATE.PURCHASER_GROUP_ID = ACCOUNT.GROUP_ID
    WHERE
      GIFT_CERTIFICATE.PURCHASE_INVOICE_ID = in_invoice_id
      AND ROWNUM <= 1;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        temp_gc_account_id := NULL;
  END;
  
  -- check subscriptions for given invoice
  IF temp_gc_account_id IS NOT NULL THEN
    out_account_id := temp_gc_account_id;
  ELSE
    BEGIN
      SELECT
        ACCOUNT.GROUP_ID into temp_ss_account_id
      FROM
        LICENSE
        INNER JOIN SUBSCRIPTION ON LICENSE.SUBSCRIPTION_ID = SUBSCRIPTION.ID
        INNER JOIN ACCOUNT ON SUBSCRIPTION.ACCOUNT_ID = ACCOUNT.ID
      WHERE
        LICENSE.INVOICE_ID = in_invoice_id
        AND ROWNUM <= 1;
      EXCEPTION
        WHEN NO_DATA_FOUND THEN
          temp_ss_account_id := NULL;
    END;
    IF temp_ss_account_id IS NULL THEN
      RAISE CAN_NOT_FIND_ACCOUNT;
    ELSE
      out_account_id := temp_ss_account_id;
    END IF;
  END IF;

EXCEPTION
WHEN BAD_INVOICE_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'No such invoice');
WHEN CAN_NOT_FIND_ACCOUNT THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'Could not find account by given invoice id');
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END GET_ACCOUNT_BY_INVOICE_ID;

/*****************************************************************/

PROCEDURE GET_INVOICE_DETAILS (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_invoice_id      IN  NUMBER,
  out_group_id       OUT NUMBER,
  out_status_id      OUT NUMBER,
  out_line_items_set OUT SYS_REFCURSOR,
  out_pp_charges_set OUT SYS_REFCURSOR,
  out_cc_charges_set OUT SYS_REFCURSOR,
  out_gc_charges_set OUT SYS_REFCURSOR
) AS
-- VARIABLES
SPROC_NAME CONSTANT VARCHAR2(19) := 'GET_INVOICE_DETAILS';

-- EXCEPTIONS
BAD_INVOICE_ID         EXCEPTION;
CAN_NOT_FIND_ACCOUNT   EXCEPTION;
EXCEPTION_MESSAGE      VARCHAR2(1024);
BEGIN

  -- get invoice status
  BEGIN
    SELECT
      INVOICE.INVOICE_STATUS_ID into out_status_id
    FROM
      INVOICE
    WHERE
      INVOICE.ID = in_invoice_id;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE BAD_INVOICE_ID;
  END;
  
  -- get group id
  BEGIN
    PROCS_INVOICE_V18.GET_ACCOUNT_BY_INVOICE_ID(in_invoice_id, out_group_id);
    EXCEPTION
      WHEN OTHERS THEN
        EXCEPTION_MESSAGE := SQLERRM;
        RAISE CAN_NOT_FIND_ACCOUNT;
  END;
  
  -- get all line items for given invoice
  OPEN out_line_items_set FOR
  SELECT
    LINE_ITEM.AMOUNT,
    LINE_ITEM.ID,
    LINE_ITEM.CREATED_BY,
    LINE_ITEM.CREATE_DATE,
    LINE_ITEM.DISCOUNT_AMOUNT,
    LINE_ITEM.TAXES_AMOUNT,
    LINE_ITEM.PRODUCT_OFFER_ID,
    LINE_ITEM.INVOICE_ID
  FROM
    LINE_ITEM
  WHERE
    LINE_ITEM.INVOICE_ID = in_invoice_id;
  
  -- get all pp charges for given invoice
  OPEN out_pp_charges_set FOR
  SELECT
    CHARGE.ID as "CHARGE_ID",
    CHARGE_AMOUNT,
    CHARGE.INSTRUMENT_ID,
    CHARGE.CHARGE_STATUS_ID
  FROM
    CHARGE
  WHERE
    CHARGE.INVOICE_ID = in_invoice_id
    AND CHARGE.INSTRUMENT_TYPE_ID = GLOBAL_ENUMS_V18.INSTRUMENT_PAYPAL;
  
  -- get all credir cards for given invoice
  OPEN out_cc_charges_set FOR
  SELECT
    CHARGE.ID as "CHARGE_ID",
    CHARGE.CHARGE_AMOUNT,
    CHARGE.INSTRUMENT_ID,
    CHARGE.CHARGE_STATUS_ID
  FROM
    CHARGE
  WHERE
    CHARGE.INVOICE_ID = in_invoice_id
    AND CHARGE.INSTRUMENT_TYPE_ID = GLOBAL_ENUMS_V18.INSTRUMENT_CREDIT_CARD;
    
  OPEN out_gc_charges_set FOR
  SELECT
    CHARGE.ID as "CHARGE_ID",
    CHARGE.CHARGE_AMOUNT,
    CHARGE.INSTRUMENT_ID,
    CHARGE.CHARGE_STATUS_ID
  FROM
    CHARGE
  WHERE
    CHARGE.INVOICE_ID = in_invoice_id
    AND CHARGE.INSTRUMENT_TYPE_ID = GLOBAL_ENUMS_V18.INSTRUMENT_GIFT_CERTIFICATE;

EXCEPTION
WHEN BAD_INVOICE_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'No such invoice');
WHEN CAN_NOT_FIND_ACCOUNT THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'Could not find account for given invoice id', EXCEPTION_MESSAGE);
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END GET_INVOICE_DETAILS;

/******************************************************/
-- norlov: #38796
PROCEDURE GET_TRANSACTION_INVOICE (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_transaction_id  IN  NUMBER,
  out_result_set        OUT SYS_REFCURSOR
) AS
SPROC_NAME CONSTANT  VARCHAR2(23) := 'GET_TRANSACTION_INVOICE';
-- VARIABLES
temp_transaction_id  NUMBER;
var_invoice_id       NUMBER;
var_subscription_id  NUMBER;
var_offer_chain_id   NUMBER;
var_offer_chain_name VARCHAR2(255);
-- EXCEPTIONS
BAD_TRANSACTION_ID     EXCEPTION;
EXCEPTION_MESSAGE      VARCHAR2(1024);
BEGIN  
 -- check if there is the transaction
  BEGIN
    SELECT
      TRANSACTION.ID into temp_transaction_id
    FROM
      TRANSACTION
    WHERE
      TRANSACTION.ID = in_transaction_id;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE BAD_TRANSACTION_ID;
  END;

  -- Get invoice id
  SELECT DISTINCT
    CHARGE.INVOICE_ID into var_invoice_id
  FROM
    CHARGE
  WHERE
    CHARGE.TRANSACTION_ID = in_transaction_id;
    
  -- Get subscription id if exists
  BEGIN
    SELECT DISTINCT
      LICENSE.SUBSCRIPTION_ID into var_subscription_id
    FROM
      LICENSE
    WHERE
      LICENSE.INVOICE_ID = var_invoice_id;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        var_subscription_id := NULL;
  END;
  
  IF var_subscription_id IS NOT NULL THEN
    -- Fetch offer chain from subscription
    SELECT
      OFFER_CHAIN.ID,
      OFFER_CHAIN.NAME
      into
      var_offer_chain_id,
      var_offer_chain_name
    FROM
      OFFER_CHAIN
      INNER JOIN SUBSCRIPTION ON SUBSCRIPTION.OFFER_CHAIN_ID = OFFER_CHAIN.ID
    WHERE
      SUBSCRIPTION.ID = var_subscription_id;
  ELSE
    -- Fetch offer chain from GC
    SELECT
      OFFER_CHAIN.ID,
      OFFER_CHAIN.NAME
      into
      var_offer_chain_id,
      var_offer_chain_name
    FROM
      OFFER_CHAIN
      INNER JOIN GIFT_CERTIFICATE ON GIFT_CERTIFICATE.OFFER_CHAIN_ID = OFFER_CHAIN.ID
    WHERE
      GIFT_CERTIFICATE.PURCHASE_INVOICE_ID = var_invoice_id;
  END IF;
  
  OPEN out_result_set FOR
  SELECT DISTINCT
    var_invoice_id       AS "INVOICE_ID",
    var_subscription_id  AS "SUBSCRIPTION_ID",
    var_offer_chain_id   AS "OFFER_CHAIN_ID",
    var_offer_chain_name AS "OFFER_CHAIN_NAME"
  FROM
    DUAL;

EXCEPTION
WHEN BAD_TRANSACTION_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'No such transaction');
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END GET_TRANSACTION_INVOICE;

/******************************************************/

PROCEDURE UPDATE_INVOICE_STATUS (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_invoice_id                  IN NUMBER,
  in_invoice_status_id           IN NUMBER,
  in_updated_by                  IN VARCHAR2
) AS
SPROC_NAME CONSTANT VARCHAR2(21) := 'UPDATE_INVOICE_STATUS';
-- VARIABLES
temp_invoice_id NUMBER;
-- EXCEPTIONS
BAD_INVOICE_ID                  EXCEPTION;
BAD_INVOICE_STATUS_ID           EXCEPTION;
EXCEPTION_MESSAGE               VARCHAR2(1024);
BEGIN

  -- Check if invoice exists
  BEGIN
    SELECT
      INVOICE.ID into temp_invoice_id
    FROM
      INVOICE
    WHERE
      INVOICE.ID = in_invoice_id;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE BAD_INVOICE_ID;
  END;
  
  IF in_invoice_status_id != GLOBAL_STATUSES_V18.INVOICE_OPEN
    AND in_invoice_status_id != GLOBAL_STATUSES_V18.INVOICE_CLOSED THEN
    RAISE BAD_INVOICE_STATUS_ID;
  END IF;
  
  PROCS_INVOICE_CRU_V18.UPDATE_INVOICE(
    in_invoice_id                  => in_invoice_id,
    in_invoice_status_id           => in_invoice_status_id,
    in_updated_by                  => in_updated_by
  );

EXCEPTION
WHEN BAD_INVOICE_STATUS_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.INVALID_PARAMETER,
    SPROC_NAME, 'Bad invoice status id');
WHEN BAD_INVOICE_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'No such invoice');
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END UPDATE_INVOICE_STATUS;

/****************************************************************/

FUNCTION IS_INVOICE_PAYING_STARTED (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_invoice_id IN NUMBER
) RETURN NUMBER AS
-- VARIABLES
SPROC_NAME                 CONSTANT VARCHAR2(30) := 'IS_INVOICE_PAYING_STARTED';
temp_invoice_id            NUMBER;
var_processed_charges_num  NUMBER;
var_processed_transac_num  NUMBER;
var_success_attempts_num   NUMBER;
var_is_gc                  NUMBER;
-- EXCEPTIONS
BAD_INVOICE_ID EXCEPTION;
BEGIN
  
  -- Check that invoice exists
  BEGIN
    SELECT
      INVOICE.ID into temp_invoice_id
    FROM
      INVOICE
    WHERE
      INVOICE.ID = in_invoice_id;
    EXCEPTION
     WHEN NO_DATA_FOUND THEN
       RAISE BAD_INVOICE_ID;
  END;
  
  -- Check that there are tansaction attempts with status success
  SELECT
    COUNT(1) into var_success_attempts_num
  FROM
    TRANSACTION_ATTEMPT ta,
    TRANSACTION t,
    CHARGE c
  WHERE
    ta.TRANSACTION_ATTEMPT_STATUS_ID = GLOBAL_STATUSES_V18.TRANS_ATTEMPT_SUCCESS and
    ta.transaction_id = t.id and
    c.transaction_id = t.id and
    t.is_refund = GLOBAL_CONSTANTS_V18.FALSE and
    c.invoice_id = in_invoice_id
  ;
    
  IF var_success_attempts_num > 0 THEN
    RETURN GLOBAL_CONSTANTS_V18.TRUE;
  END IF;
  
  SELECT
    COUNT(1) into var_success_attempts_num
  FROM
    TRANSACTION t,
    CHARGE c
  WHERE
    c.transaction_id = t.id and
    t.is_refund = GLOBAL_CONSTANTS_V18.FALSE and
    t.is_settled = GLOBAL_CONSTANTS_V18.TRUE and
    c.invoice_id = in_invoice_id
  ;
   
  IF var_success_attempts_num > 0 THEN
    RETURN GLOBAL_CONSTANTS_V18.TRUE;
  END IF;

  SELECT
    COUNT(1) into var_is_gc
  FROM
    gift_certificate gc
  WHERE
    gc.finalized_invoice_id = in_invoice_id
  ;

  IF var_is_gc > 0 THEN
    RETURN GLOBAL_CONSTANTS_V18.TRUE;
  END IF;

  RETURN GLOBAL_CONSTANTS_V18.FALSE;
  
EXCEPTION
WHEN BAD_INVOICE_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'No such invoice');
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END IS_INVOICE_PAYING_STARTED;

/******************************************************************************/

PROCEDURE P_IS_INVOICE_PAYING_STARTED (
  in_invoice_id  IN NUMBER,
  out_is_started OUT NUMBER
) AS
BEGIN
  -- Just a wrapper
  out_is_started := PROCS_INVOICE_V18.IS_INVOICE_PAYING_STARTED(in_invoice_id);
END P_IS_INVOICE_PAYING_STARTED;

/******************************************************************************/

PROCEDURE CALCULATE_INVOICE_CHARGEBACK (
  in_invoice_id         IN NUMBER,
  in_chargeback_date    IN DATE,
  out_chargeback_amount OUT NUMBER
) AS
-- VARIABLES
SPROC_NAME             CONSTANT VARCHAR2(28) := 'CALCULATE_INVOICE_CHARGEBACK';
var_chargeback_date    DATE;
temp_invoice_id        NUMBER;
var_licenses_number    NUMBER;
var_invoice_start_date DATE;
var_invoice_end_date   DATE;
var_offer_id           NUMBER;
var_offer_days_interval NUMBER;
var_license_days_used  NUMBER;
var_invoice_amount     NUMBER(10,2);
var_offer_chain_id     NUMBER;
var_offer_chain_meta_data_val VARCHAR2(1024);
var_offer_chain_full_refund   NUMBER;
var_offer_chain_prorated_ref  NUMBER;
var_chargeback_calculated NUMBER;
var_max_invoice_refund    NUMBER;
-- EXCEPTIONS
BAD_INVOICE_ID              EXCEPTION;
NO_LICENSES_FOUND_EXCEPTION EXCEPTION;
OFFER_LENGTH_IS_ZERO        EXCEPTION;
BEGIN
  
  IF in_chargeback_date IS NULL THEN
    var_chargeback_date := PROCS_COMMON_V18.NORMALIZE_DATE(current_date);
  ELSE
    var_chargeback_date := PROCS_COMMON_V18.NORMALIZE_DATE(in_chargeback_date);
  END IF;
  
  -- Check that invoice exists
  BEGIN
    SELECT
      INVOICE.ID into temp_invoice_id
    FROM
      INVOICE
    WHERE
      INVOICE.ID = in_invoice_id;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE BAD_INVOICE_ID;
  END;
  
  -- Check that invoice has at least one license
  SELECT
    COUNT(*) into var_licenses_number
  FROM
    LICENSE
  WHERE
    LICENSE.INVOICE_ID = in_invoice_id;
  
  IF var_licenses_number = 0 THEN
    RAISE NO_LICENSES_FOUND_EXCEPTION;
  END IF;
  
  SELECT
    MIN(LICENSE.START_DATE) into var_invoice_start_date
  FROM
    LICENSE
  WHERE
    LICENSE.INVOICE_ID = in_invoice_id;
    
  var_invoice_start_date := PROCS_COMMON_V18.NORMALIZE_DATE(var_invoice_start_date);
  
  SELECT DISTINCT
    LICENSE.OFFER_ID into var_offer_id
  FROM
    LICENSE
  WHERE
    LICENSE.INVOICE_ID = in_invoice_id;
  
  SELECT
    MAX (LICENSE.END_DATE) into var_invoice_end_date
  FROM
    LICENSE
  WHERE
    LICENSE.INVOICE_ID = in_invoice_id;
  
  -- All licenses for given invoice should point into the same offer
  
  PROCS_OFFER_CHAIN_V18.GET_OFFER_LENGTH_IN_DAYS(
    in_offer_id   => var_offer_id,
    in_start_date => var_invoice_start_date,
    out_days      => var_offer_days_interval
  );
  
  IF var_offer_days_interval = 0 THEN
    RAISE OFFER_LENGTH_IS_ZERO;
  END IF;
    
  PROCS_INVOICE_V18.GET_INVOICE_DAYS_USED_NUMBER(
    in_invoice_id      => in_invoice_id,
    in_chargeback_date => var_chargeback_date,
    out_days_num       => var_license_days_used
  );
  
  PROCS_INVOICE_V18.CALCULATE_INVOICE_AMOUNT(
    in_invoice_id => in_invoice_id,
    out_amount    => var_invoice_amount
  );
  
  -- 39437
  -- Get offer chain id by invoice id
  SELECT DISTINCT
    SUBSCRIPTION.OFFER_CHAIN_ID into var_offer_chain_id
  FROM
    SUBSCRIPTION
    INNER JOIN LICENSE ON LICENSE.SUBSCRIPTION_ID = SUBSCRIPTION.ID
  WHERE
    LICENSE.INVOICE_ID = in_invoice_id;
  
  -- Get offer chain's meta data full amount value
  PROCS_OFFER_CHAIN_V18.GET_OFFER_CHAIN_MD_VALUE(
    in_offer_chain_id => var_offer_chain_id,
    in_meta_data_name => GLOBAL_CONSTANTS_V18.OFFER_CHAIN_FULL_REFUND,
    out_value         => var_offer_chain_meta_data_val
  );
  IF var_offer_chain_meta_data_val IS NULL THEN
    var_offer_chain_full_refund := NULL;
  ELSE
    var_offer_chain_full_refund := TO_NUMBER(var_offer_chain_meta_data_val);
  END IF;

  -- Get offer chain's meta data prorated amount value
  PROCS_OFFER_CHAIN_V18.GET_OFFER_CHAIN_MD_VALUE(
    in_offer_chain_id => var_offer_chain_id,
    in_meta_data_name => GLOBAL_CONSTANTS_V18.OFFER_CHAIN_PRORATED_REFUND,
    out_value         => var_offer_chain_meta_data_val
  );
  IF var_offer_chain_meta_data_val IS NULL THEN
    var_offer_chain_prorated_ref := NULL;
  ELSE
    var_offer_chain_prorated_ref := TO_NUMBER(var_offer_chain_meta_data_val);
  END IF;
  
  var_chargeback_calculated := GLOBAL_CONSTANTS_V18.FALSE;
  
  IF var_offer_chain_full_refund IS NOT NULL
     AND var_chargeback_calculated = GLOBAL_CONSTANTS_V18.FALSE THEN
    IF var_license_days_used < var_offer_chain_full_refund THEN
      out_chargeback_amount := var_invoice_amount;
      var_chargeback_calculated := GLOBAL_CONSTANTS_V18.TRUE;
    END IF;
  END IF;
  
  IF var_offer_chain_prorated_ref IS NOT NULL
     AND var_chargeback_calculated = GLOBAL_CONSTANTS_V18.FALSE THEN
    IF var_license_days_used < var_offer_chain_prorated_ref THEN
      out_chargeback_amount := ( var_invoice_amount * (var_offer_days_interval - var_license_days_used) ) / var_offer_days_interval;
      var_chargeback_calculated := GLOBAL_CONSTANTS_V18.TRUE;
    END IF;
  END IF;
  
  IF var_chargeback_calculated = GLOBAL_CONSTANTS_V18.TRUE THEN
    PROCS_INVOICE_V18.GET_MAX_REFUND(
      in_invoice_id => in_invoice_id,
      out_amount    => var_max_invoice_refund
    );
    IF var_max_invoice_refund < out_chargeback_amount THEN 
      out_chargeback_amount := var_max_invoice_refund;
    END IF;
  END IF;
  
  IF var_chargeback_calculated = GLOBAL_CONSTANTS_V18.FALSE THEN
    out_chargeback_amount := 0;
  END IF;

EXCEPTION
WHEN BAD_INVOICE_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'No such invoice');
WHEN NO_LICENSES_FOUND_EXCEPTION THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'No licenses found');
WHEN OFFER_LENGTH_IS_ZERO THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.INTERNAL_ERROR,
    SPROC_NAME, 'Offer length is zero');
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END CALCULATE_INVOICE_CHARGEBACK;

/********************************************************************/

PROCEDURE APPLY_REFUND (
  in_invoice_id        IN NUMBER,
  in_chargeback_amount IN NUMBER,
  in_created_by        IN VARCHAR2,
  out_charge_id        OUT NUMBER
) AS
-- VARIABLES
SPROC_NAME                 CONSTANT VARCHAR2(16) := 'APPLY_CHARGEBACK';
temp_invoice_id            NUMBER;
var_total_charges_amount   NUMBER(10,2);
var_charge_amount_to_apply NUMBER(10,2);
var_transaction_id         NUMBER;
var_instrument_type_id     NUMBER;
var_instrument_id          NUMBER;
var_charge_id              NUMBER;
-- EXCEPTIONS
BAD_INVOICE_ID             EXCEPTION;
CAN_NOT_CREATE_TRANSACTION EXCEPTION;
CAN_NOT_FIND_INSTRUMENT    EXCEPTION;
CAN_NOT_CREATE_CHARGE      EXCEPTION;
EXCEPTION_MESSAGE          VARCHAR2(1024);
BEGIN
  
  BEGIN
    SELECT
      INVOICE.ID into temp_invoice_id
    FROM
      INVOICE
    WHERE
      INVOICE.ID = in_invoice_id;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE BAD_INVOICE_ID;
  END;
  
  SELECT
    SUM (CHARGE.CHARGE_AMOUNT) into var_total_charges_amount
  FROM
    CHARGE
  WHERE
    CHARGE.INVOICE_ID = in_invoice_id
    AND CHARGE.CHARGE_STATUS_ID = GLOBAL_STATUSES_V18.CHARGE_PROCESSED
    AND CHARGE.INSTRUMENT_TYPE_ID != GLOBAL_ENUMS_V18.INSTRUMENT_GIFT_CERTIFICATE;
    
  -- FIXME: Maybe whe should throw exception here?
  IF var_total_charges_amount < in_chargeback_amount THEN
    var_charge_amount_to_apply := var_total_charges_amount;
  ELSE
    var_charge_amount_to_apply := in_chargeback_amount;
  END IF;
  
  BEGIN
    PROCS_TRANSACTION_V18.CREATE_TRANSACTION(
      in_transaction_id         => NULL,
      in_status_id              => GLOBAL_STATUSES_V18.TRANSACTION_PREPARE,
      in_amount                 => -var_charge_amount_to_apply,
      in_created_by             => in_created_by,
      in_order_id               => NULL,
      in_is_refund              => GLOBAL_CONSTANTS_V18.TRUE,
      in_transaction_type_code  => 'REFUND',
      out_transaction_id        => var_transaction_id
    );
    EXCEPTION
      WHEN OTHERS THEN
        EXCEPTION_MESSAGE := SQLERRM;
        RAISE CAN_NOT_CREATE_TRANSACTION;
  END;
  
  BEGIN
    SELECT
      C.INSTRUMENT_TYPE_ID,
      C.INSTRUMENT_ID
      into
      var_instrument_type_id,
      var_instrument_id
    FROM
      CHARGE C,
      TRANSACTION_ATTEMPT TA,
      TRANSACTION T
    WHERE
      C.INVOICE_ID = in_invoice_id and
      C.TRANSACTION_ID = T.ID and
      TA.TRANSACTION_ID = T.ID and
      TA.TRANSACTION_ATTEMPT_STATUS_ID = GLOBAL_STATUSES_V18.TRANS_ATTEMPT_SUCCESS and
      T.IS_REFUND = GLOBAL_CONSTANTS_V18.FALSE and
      T.TRANSACTION_AMOUNT >= 0 and
      rownum < 2;
  EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE CAN_NOT_FIND_INSTRUMENT;
  END;
  BEGIN
    PROCS_CHARGE_V18.CREATE_CHARGE(
      in_invoice_id         => in_invoice_id,
      in_transaction_id     => var_transaction_id,
      in_instrument_type_id => var_instrument_type_id,
      in_instrument_id      => var_instrument_id,
      in_charge_amount      => -var_charge_amount_to_apply,
      in_created_by         => in_created_by,
      in_charge_status_id   => GLOBAL_STATUSES_V18.CHARGE_OPENED,
      out_charge_id         => var_charge_id
    );
    EXCEPTION
      WHEN OTHERS THEN
        EXCEPTION_MESSAGE := SQLERRM;
        RAISE CAN_NOT_CREATE_CHARGE;
  END;
  
  out_charge_id := var_charge_id;

EXCEPTION
WHEN BAD_INVOICE_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'No such invoice');
WHEN CAN_NOT_CREATE_TRANSACTION THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.INTERNAL_ERROR,
    SPROC_NAME, 'Could not create transaction', EXCEPTION_MESSAGE);
WHEN CAN_NOT_FIND_INSTRUMENT THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'Could not find financial instrument');
WHEN CAN_NOT_CREATE_CHARGE THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.INTERNAL_ERROR,
    SPROC_NAME, 'Could not create charge', EXCEPTION_MESSAGE);
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END APPLY_REFUND;

/******************************************************************************/

PROCEDURE GET_MAX_REFUND (
  in_invoice_id IN NUMBER,
  out_amount    OUT NUMBER
) AS
SPROC_NAME CONSTANT VARCHAR2(14) := 'GET_MAX_REFUND';
-- VARIABLES
temp_invoice_id         NUMBER;
var_invoice_refunds_sum NUMBER(10,2);
var_invoice_charges_sum NUMBER(10,2);
-- EXCEPTIONS
BAD_INVOICE_ID EXCEPTION;
BEGIN
  
  BEGIN
    SELECT
      INVOICE.ID into temp_invoice_id
    FROM
      INVOICE
    WHERE
      INVOICE.ID = in_invoice_id;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE BAD_INVOICE_ID;
  END;
  
  var_invoice_refunds_sum := 0;
  var_invoice_charges_sum := 0;
  
  FOR f_charge IN (
    SELECT
      CHARGE.ID,
      CHARGE.CHARGE_STATUS_ID,
      CHARGE.CHARGE_AMOUNT,
      CHARGE.TRANSACTION_ID
    FROM
      CHARGE
    WHERE
      CHARGE.INVOICE_ID = in_invoice_id
  )
  LOOP
    -- If charge.status = canceled then continue
    IF f_charge.CHARGE_STATUS_ID != GLOBAL_STATUSES_V18.CHARGE_CANCELED THEN
    
      IF f_charge.CHARGE_AMOUNT > 0 THEN
        IF f_charge.CHARGE_STATUS_ID = GLOBAL_STATUSES_V18.CHARGE_PROCESSED
           AND PROCS_TRANSACTION_V18.IS_TRANSACTION_COLLECTED(f_charge.TRANSACTION_ID) = GLOBAL_CONSTANTS_V18.TRUE THEN
          -- Transaction collected
          var_invoice_charges_sum := var_invoice_charges_sum + f_charge.CHARGE_AMOUNT;
        ELSE
          -- Transaction is not collected. Do nothing
          NULL;
        END IF;
      ELSE
        IF f_charge.CHARGE_STATUS_ID = GLOBAL_STATUSES_V18.CHARGE_PROCESSED
           AND PROCS_TRANSACTION_V18.IS_TRANSACTION_COLLECTED(f_charge.TRANSACTION_ID) = GLOBAL_CONSTANTS_V18.FALSE THEN
          -- If charge is processed transaction is not collected then do nothing
          NULL;
        ELSE
          var_invoice_refunds_sum := var_invoice_refunds_sum + f_charge.CHARGE_AMOUNT;
        END IF;
      END IF;
      
    END IF;
  END LOOP;
  
  -- Refunds are negative
  var_invoice_refunds_sum := 0 - var_invoice_refunds_sum;
  
  out_amount := var_invoice_charges_sum - var_invoice_refunds_sum;

EXCEPTION
WHEN BAD_INVOICE_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'No such invoice');
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END GET_MAX_REFUND;

/******************************************************************************/

PROCEDURE GET_INVOICE_DAYS_USED_NUMBER (
  in_invoice_id       IN NUMBER,
  in_chargeback_date  IN DATE DEFAULT SYSDATE,
  out_days_num        OUT NUMBER
) AS
SPROC_NAME CONSTANT VARCHAR2(28) := 'GET_INVOICE_DAYS_USED_NUMBER';
-- VARIABLES
temp_invoice_id        NUMBER;
var_license_start_date DATE;
var_license_end_date   DATE;
var_chargeback_date    DATE;
var_invoice_days_used  NUMBER;
-- EXCEPTIONS
BAD_INVOICE_ID EXCEPTION;
BEGIN

  var_chargeback_date := NVL(in_chargeback_date, SYSDATE);

  BEGIN
    SELECT
      INVOICE.ID into temp_invoice_id
    FROM
      INVOICE
    WHERE
      INVOICE.ID = in_invoice_id;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE BAD_INVOICE_ID;
  END;

  var_invoice_days_used := 0;

  FOR f_license IN (
    SELECT
      LICENSE.START_DATE,
      LICENSE.END_DATE
    FROM
      LICENSE
    WHERE
      LICENSE.INVOICE_ID = in_invoice_id
      AND LICENSE.IS_EXTENSION = GLOBAL_CONSTANTS_V18.FALSE
  )
  LOOP
    var_license_start_date := PROCS_COMMON_V18.NORMALIZE_DATE(f_license.START_DATE);
    var_license_end_date := PROCS_COMMON_V18.NORMALIZE_DATE(f_license.END_DATE);
    
    IF var_license_start_date <= var_chargeback_date THEN
      IF var_license_end_date <= var_chargeback_date THEN
        -- License is passed
        var_invoice_days_used := var_invoice_days_used + (var_license_end_date - var_license_start_date);
      ELSE
        -- This is current license
        var_invoice_days_used := var_invoice_days_used + (var_chargeback_date - var_license_start_date);
      END IF;
    ELSE
      -- if var_license_start_date > in_chargeback_date then do nothing
      NULL;
    END IF;
  END LOOP;
  
  out_days_num := var_invoice_days_used;

EXCEPTION
WHEN BAD_INVOICE_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'No such invoice');
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END GET_INVOICE_DAYS_USED_NUMBER;

/******************************************************************************/

PROCEDURE GET_INVOICE_LINE_ITEMS (
  in_invoice_id  IN NUMBER,
  out_result_set OUT SYS_REFCURSOR
) AS
SPROC_NAME CONSTANT VARCHAR2(22) := 'GET_INVOICE_LINE_ITEMS';
-- VARIABLES
temp_invoice_id NUMBER;
-- EXCEPTIONS
BAD_INVOICE_ID EXCEPTION;
BEGIN
  
  BEGIN
    SELECT
      INVOICE.ID into temp_invoice_id
    FROM
      INVOICE
    WHERE
      INVOICE.ID = in_invoice_id;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE BAD_INVOICE_ID;
  END;
  
  OPEN out_result_set FOR
  SELECT
    LINE_ITEM.ID,
    LINE_ITEM.PRODUCT_OFFER_ID,
    LINE_ITEM.INVOICE_ID,
    LINE_ITEM.AMOUNT,
    LINE_ITEM.DISCOUNT_AMOUNT,
    LINE_ITEM.TAXES_AMOUNT,
    LINE_ITEM.CREATE_DATE,
    LINE_ITEM.CREATED_BY
  FROM
    LINE_ITEM
  WHERE
    LINE_ITEM.INVOICE_ID = in_invoice_id;

EXCEPTION
WHEN BAD_INVOICE_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'No such invoice');
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END GET_INVOICE_LINE_ITEMS;

/******************************************************************************/

PROCEDURE GET_INVOICE_LICENSES (
  in_invoice_id  IN NUMBER,
  out_result_set OUT SYS_REFCURSOR
) AS
SPROC_NAME CONSTANT VARCHAR2(20) := 'GET_INVOICE_LICENSES';
-- VARIABLES
temp_invoice_id NUMBER;
-- EXCEPTIONS
BAD_INVOICE_ID EXCEPTION;
BEGIN

  BEGIN
    SELECT
      INVOICE.ID into temp_invoice_id
    FROM
      INVOICE
    WHERE
      INVOICE.ID = in_invoice_id;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE BAD_INVOICE_ID;
  END;
  
  OPEN out_result_set FOR
  SELECT
    LICENSE.ID,
    LICENSE.INVOICE_ID,
    LICENSE.CREATE_DATE,
    LICENSE.CREATED_BY,
    LICENSE.CURRENT_OFFER_INDEX,
    LICENSE.CURRENT_OFFER_RECURR_NUM,
    LICENSE.END_DATE,
    LICENSE.ENTITLEMENT_END_DATE,
    LICENSE.IS_EXTENSION,
    LICENSE.LICENSE_STATUS_ID,
    LICENSE.NEEDS_ENTITLEMENTS,
    LICENSE.OFFER_ID,
    LICENSE.START_DATE,
    LICENSE.SUBSCRIPTION_ID,
    LICENSE.UPDATE_DATE,
    LICENSE.UPDATED_BY
  FROM
    LICENSE
  WHERE
    LICENSE.INVOICE_ID = in_invoice_id;

EXCEPTION
WHEN BAD_INVOICE_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'No such invoice');
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error');
END GET_INVOICE_LICENSES;

/******************************************************************************/

PROCEDURE GET_OFFER_CH_ID_BY_INVOICE_ID (
  in_invoice_id      IN NUMBER,
  out_offer_chain_id OUT NUMBER
) AS
SPROC_NAME CONSTANT VARCHAR2(29) := 'GET_OFFER_CH_ID_BY_INVOICE_ID';
-- VARIABLES
temp_invoice_id NUMBER;
-- EXCEPTIONS
BAD_INVOICE_ID EXCEPTION;
BEGIN
  
  BEGIN
    SELECT
      INVOICE.ID into temp_invoice_id
    FROM
      INVOICE
    WHERE
      INVOICE.ID = in_invoice_id;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE BAD_INVOICE_ID;
  END;
  
  BEGIN
    SELECT DISTINCT
      SUBSCRIPTION.OFFER_CHAIN_ID into out_offer_chain_id
    FROM
      LICENSE
      INNER JOIN SUBSCRIPTION ON LICENSE.SUBSCRIPTION_ID = SUBSCRIPTION.ID
    WHERE
      LICENSE.INVOICE_ID = in_invoice_id;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        out_offer_chain_id := NULL;
  END;
  
EXCEPTION
WHEN BAD_INVOICE_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'No such invoice');
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END GET_OFFER_CH_ID_BY_INVOICE_ID;

/******************************************************************************/

PROCEDURE CLOSE_INVOICE_AS_NOT_COLLECTED (
-- Closing invoice without refund
  in_invoice_id IN NUMBER,
  in_updated_by IN VARCHAR2
) AS
SPROC_NAME CONSTANT VARCHAR2(30) := 'CLOSE_INVOICE_AS_NOT_COLLECTED';
-- VARIABLES
temp_invoice_id NUMBER;
-- EXCEPTIONS
BAD_INVOICE_ID EXCEPTION;
BEGIN
  
  BEGIN
    SELECT
      INVOICE.ID into temp_invoice_id
    FROM
      INVOICE
    WHERE
      INVOICE.ID = in_invoice_id;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE BAD_INVOICE_ID;
  END;
  
  -- Needs to close charges. No refund.
  FOR f_charge_to_close IN (
    SELECT CHARGE.ID FROM CHARGE WHERE CHARGE.INVOICE_ID = in_invoice_id
  )
  LOOP
    PROCS_CHARGE_V18.UPDATE_CHARGE_STATUS(
      in_charge_id        => f_charge_to_close.ID,
      in_updated_by       => in_updated_by,
      in_charge_status_id => GLOBAL_STATUSES_V18.CHARGE_CANCELED
    );
  END LOOP;
  
  --FOR f_license_to_cancel IN (
  --  SELECT LICENSE.ID FROM LICENSE WHERE LICENSE.INVOICE_ID = in_invoice_id AND LICENSE.LICENSE_STATUS_ID = GLOBAL_STATUSES_V18.LICENSE_ACTIVE
  --)
  --LOOP
  --  PROCS_LICENSE_CRU_V18.UPDATE_LICENSE(
  --    in_license_id         => f_license_to_cancel.ID,
  --    in_license_status_id  => GLOBAL_STATUSES_V18.LICENSE_CLOSED,
  --    in_needs_entitlements => GLOBAL_CONSTANTS_V18.FALSE,
  --    in_updated_by         => in_updated_by
  --  );
  --END LOOP;
  
  PROCS_INVOICE_V18.UPDATE_INVOICE_STATUS(
    in_invoice_id                  => in_invoice_id,
    in_updated_by                  => in_updated_by,
    in_invoice_status_id           => GLOBAL_STATUSES_V18.INVOICE_CLOSED
  );
  
  FOR f_transaction_to_close IN (
    SELECT DISTINCT CHARGE.TRANSACTION_ID AS "ID" FROM CHARGE WHERE CHARGE.INVOICE_ID = in_invoice_id
  )
  LOOP
    PROCS_TRANSACTION_V18.UPDATE_TRANSACTION_STATUS(
      in_transaction_id        => f_transaction_to_close.ID,
      in_updated_by            => in_updated_by,
      in_transaction_status_id => GLOBAL_STATUSES_V18.TRANSACTION_CLOSED
    );
  END LOOP;
  
EXCEPTION
WHEN BAD_INVOICE_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'No such invoice');
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END CLOSE_INVOICE_AS_NOT_COLLECTED;

/******************************************************************************/

PROCEDURE GET_SUBSCR_ID_BY_INVOICE_ID (
  in_invoice_id       IN NUMBER,
  out_subscription_id OUT NUMBER
) AS
SPROC_NAME CONSTANT VARCHAR2(27) := 'GET_SUBSCR_ID_BY_INVOICE_ID';
-- VARIABLES
temp_invoice_id NUMBER;
-- EXCEPTIONS
BAD_INVOICE_ID            EXCEPTION;
CAN_NOT_FIND_SUBSCRIPTION EXCEPTION;
BEGIN

  BEGIN
    SELECT
      INVOICE.ID into temp_invoice_id
    FROM
      INVOICE
    WHERE
      INVOICE.ID = in_invoice_id;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE BAD_INVOICE_ID;
  END;
  
  BEGIN
    SELECT DISTINCT
      LICENSE.SUBSCRIPTION_ID into out_subscription_id
    FROM
      LICENSE
    WHERE
      LICENSE.INVOICE_ID = in_invoice_id;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE CAN_NOT_FIND_SUBSCRIPTION;
  END;

EXCEPTION
WHEN BAD_INVOICE_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'No such invoice');
WHEN CAN_NOT_FIND_SUBSCRIPTION THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'Could not find subscription for given invoice');
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END GET_SUBSCR_ID_BY_INVOICE_ID;

/******************************************************************************/

PROCEDURE IS_INVOICE_TAX_EXEMPT (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND,
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
Return:
  GLOBAL_CONSTANTS_V18.TRUE if ACCOUNT.EXEMPT_ID is not null
  GLOBAL_CONSTANTS_V18.FALSE else
*/
  in_invoice_id     IN NUMBER,
  out_is_tax_exempt OUT NUMBER
) AS
SPROC_NAME CONSTANT VARCHAR2(21) := 'IS_INVOICE_TAX_EXEMPT';
-- VARIABLES
var_is_tax_exempt INVOICE.TAX_EXEMPT_ID%TYPE;
-- EXCEPTIONS
BAD_INVOICE_ID EXCEPTION;
BEGIN

  BEGIN
    SELECT
      INVOICE.TAX_EXEMPT_ID into var_is_tax_exempt
    FROM
      INVOICE
    WHERE
      INVOICE.ID = in_invoice_id;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE BAD_INVOICE_ID;
  END;

  IF var_is_tax_exempt IS NULL THEN
    out_is_tax_exempt := GLOBAL_CONSTANTS_V18.FALSE;
  ELSE
    out_is_tax_exempt := GLOBAL_CONSTANTS_V18.TRUE;
  END IF;

EXCEPTION
WHEN BAD_INVOICE_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'No such invoice');
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END IS_INVOICE_TAX_EXEMPT;

/******************************************************************************/

PROCEDURE GET_INVOICE_BY_TRNS_ORDER_ID (
  in_order_id  IN TRANSACTION.ORDER_ID%TYPE,
  out_result_set OUT SYS_REFCURSOR
) AS
SPROC_NAME CONSTANT VARCHAR2(28) := 'GET_INVOICE_BY_TRNS_ORDER_ID';
-- VARIABLE
temp_order_id TRANSACTION.ORDER_ID%TYPE;
-- EXCEPTIONS
BAD_ORDER_ID EXCEPTION;
CAN_NOT_FIND_INVOICE EXCEPTION;
BEGIN
  
  OPEN out_result_set FOR
    SELECT DISTINCT
      CHARGE.INVOICE_ID
    FROM
      CHARGE
    INNER JOIN
      TRANSACTION ON TRANSACTION.ID = CHARGE.TRANSACTION_ID
    WHERE
      TRANSACTION.ORDER_ID = in_order_id;
  
EXCEPTION
WHEN BAD_ORDER_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'No such transaction');
WHEN CAN_NOT_FIND_INVOICE THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'Could not find invoice for given order id');
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END GET_INVOICE_BY_TRNS_ORDER_ID;

/******************************************************************************/

PROCEDURE GET_INVOICE_BY_ID (
  in_invoice_id  IN NUMBER,
  out_result_set OUT SYS_REFCURSOR
) AS
SPROC_NAME CONSTANT VARCHAR2(17) := 'GET_INVOICE_BY_ID';
-- VARIABLE
temp_invoice_id NUMBER;
-- EXCEPTIONS
BAD_INVOCIE_ID EXCEPTION;
BEGIN
  
  BEGIN
    SELECT
      INVOICE.ID into temp_invoice_id
    FROM
      INVOICE
    WHERE
      INVOICE.ID = in_invoice_id;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE BAD_INVOCIE_ID;
  END;
  
  OPEN out_result_set FOR
  SELECT
    INVOICE.ID,
    INVOICE.INVOICE_STATUS_ID,
    INVOICE.TAX_EXEMPT_ID,
    INVOICE.UPDATE_DATE,
    INVOICE.UPDATED_BY,
    INVOICE.CREATE_DATE,
    INVOICE.CREATED_BY
  FROM
    INVOICE
  WHERE
    INVOICE.ID = in_invoice_id;
  
EXCEPTION
WHEN BAD_INVOCIE_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'No such invoice');
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END GET_INVOICE_BY_ID;

/******************************************************************************/

PROCEDURE GET_IS_TAX_CALCULATION_NEEDED (
  in_invoice_id                 IN NUMBER,
  out_is_tax_calculation_needed OUT NUMBER
) AS
SPROC_NAME CONSTANT VARCHAR2(29) := 'GET_IS_TAX_CALCULATION_NEEDED';
BEGIN

  SELECT
    I.IS_TAX_CALCULATION_NEEDED into out_is_tax_calculation_needed
  FROM
    INVOICE I
  WHERE
    I.ID = in_invoice_id;

EXCEPTION
WHEN NO_DATA_FOUND THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'No such invoice');
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END GET_IS_TAX_CALCULATION_NEEDED;

/******************************************************************************/

PROCEDURE SET_IS_TAX_CALCULATION_NEEDED (
  in_invoice_id                IN NUMBER,
  in_updated_by                IN VARCHAR2,
  in_is_tax_calculation_needed IN NUMBER
) AS
SPROC_NAME CONSTANT VARCHAR2(29) := 'SET_IS_TAX_CALCULATION_NEEDED';
-- VARIABLES
temp_invoice_id        NUMBER;
-- EXCEPTIONS
BAD_INVOICE_ID         EXCEPTION;
CAN_NOT_UPDATE_INVOCIE EXCEPTION;
EXCEPTION_MESSAGE      VARCHAR2(1024);
BEGIN
  
  BEGIN
    SELECT
      i.id into temp_invoice_id
    FROM
      invoice i
    WHERE
      i.id = in_invoice_id;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE BAD_INVOICE_ID;
  END;
  
  BEGIN
    PROCS_INVOICE_CRU_V18.UPDATE_INVOICE(
      in_invoice_id => in_invoice_id,
      in_updated_by => in_updated_by,
      in_is_tax_calculation_needed => in_is_tax_calculation_needed
    );
    EXCEPTION
      WHEN OTHERS THEN
        EXCEPTION_MESSAGE := SQLERRM;
        RAISE CAN_NOT_UPDATE_INVOCIE;
  END;
  
EXCEPTION
WHEN BAD_INVOICE_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'No such invoice');
WHEN CAN_NOT_UPDATE_INVOCIE THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.INTERNAL_ERROR,
    SPROC_NAME, 'Could not update invoice', EXCEPTION_MESSAGE);
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END SET_IS_TAX_CALCULATION_NEEDED;

/******************************************************************************/

PROCEDURE REFUND_INVOICE (
  in_invoice_id      IN NUMBER,
  in_refund_amount   IN NUMBER,
  in_note            IN VARCHAR2,
  in_created_by      IN VARCHAR2,
  out_charge_id      OUT NUMBER
) AS
SPROC_NAME CONSTANT VARCHAR2(14) := 'REFUND_INVOICE';
-- VARIABLES
var_invoice_status_id  NUMBER;
var_subscription_id    NUMBER;
var_account_id         NUMBER;
var_group_id           NUMBER;
var_account_status_id  NUMBER;
var_new_transaction_id NUMBER;
var_instrument_type_id NUMBER;
var_instrument_id      NUMBER;
var_new_charge_id      NUMBER;
var_invoice_amount     NUMBER(10,2);
var_refunds_before     NUMBER(10,2);
var_charges_amount     NUMBER(10,2);
-- EXCEPTIONS
CAN_NOT_FIND_SUBSCR_OR_GC     EXCEPTION;
ACCOUNT_IS_FROZEN             EXCEPTION;
BAD_INVOICE_ID                EXCEPTION;
CAN_NOT_CREATE_TRANSACTION    EXCEPTION;
CAN_NOT_CREATE_CHARGE         EXCEPTION;
CAN_NOT_CALC_INVOICE_AMOUNT   EXCEPTION;
REFUND_IS_GREATER_THAN_ANOUNT EXCEPTION;
CAN_NOT_ANNOTATE_SUBSCRIPTION EXCEPTION;
TOT_REF_IS_GREATER_THAN_ANOUNT EXCEPTION;
INVOICE_IS_NOT_CLOSED         EXCEPTION;
TOT_REF_IS_GRATER_THAN_CHARGES EXCEPTION;
EXCEPTION_MESSAGE              VARCHAR2(1024);
BEGIN

  BEGIN
    SELECT
      INVOICE.INVOICE_STATUS_ID into var_invoice_status_id
    FROM
      INVOICE
    WHERE
      INVOICE.ID = in_invoice_id;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE BAD_INVOICE_ID;
  END;

  -- Get instrument and subscription id if exists
  BEGIN
    SELECT
      SUBSCRIPTION.INSTRUMENT_ID,
      SUBSCRIPTION.INSTRUMENT_TYPE_ID,
      SUBSCRIPTION.ACCOUNT_ID,
      SUBSCRIPTION.ID
      into
      var_instrument_id,
      var_instrument_type_id,
      var_account_id,
      var_subscription_id
    FROM
      SUBSCRIPTION
      INNER JOIN LICENSE ON SUBSCRIPTION.ID = LICENSE.SUBSCRIPTION_ID
    WHERE
      LICENSE.INVOICE_ID = in_invoice_id
      AND ROWNUM <= 1;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        BEGIN
          
          var_subscription_id := NULL;
          
          SELECT
            CHARGE.INSTRUMENT_ID,
            CHARGE.INSTRUMENT_TYPE_ID,
            GIFT_CERTIFICATE.PURCHASER_GROUP_ID
            into
            var_instrument_id,
            var_instrument_type_id,
            var_group_id
          FROM
            INVOICE
            INNER JOIN CHARGE ON INVOICE.ID = CHARGE.INVOICE_ID
            INNER JOIN GIFT_CERTIFICATE ON GIFT_CERTIFICATE.PURCHASE_INVOICE_ID = INVOICE.ID
          WHERE
            INVOICE.ID = in_invoice_id
            AND ROWNUM <= 1;
          
          SELECT
            ACCOUNT.ID into var_account_id
          FROM
            ACCOUNT
          WHERE
            ACCOUNT.GROUP_ID = var_group_id;

          EXCEPTION
            WHEN NO_DATA_FOUND THEN
              RAISE CAN_NOT_FIND_SUBSCR_OR_GC;
        END;
  END;

  -- Check account status. It should not to be frozen
  SELECT
    ACCOUNT.ACCOUNT_STATUS_ID into var_account_status_id
  FROM
    ACCOUNT
  WHERE
    ACCOUNT.ID = var_account_id;
    
  IF var_account_status_id = GLOBAL_STATUSES_V18.ACCOUNT_FROZEN THEN
    RAISE ACCOUNT_IS_FROZEN;
  END IF;
  
  IF var_invoice_status_id != GLOBAL_STATUSES_V18.INVOICE_CLOSED THEN
    RAISE INVOICE_IS_NOT_CLOSED;
  END IF;

  BEGIN
    PROCS_INVOICE_V18.CALCULATE_INVOICE_AMOUNT (
      in_invoice_id => in_invoice_id,
      out_amount    => var_invoice_amount
    );
    EXCEPTION
      WHEN OTHERS THEN
        EXCEPTION_MESSAGE := SQLERRM;
        RAISE CAN_NOT_CALC_INVOICE_AMOUNT;
  END;

  IF ( in_refund_amount > var_invoice_amount ) THEN
    RAISE REFUND_IS_GREATER_THAN_ANOUNT;
  END IF;
  
  SELECT /*+ STAR_TRANSFORMATION */
    SUM(CHARGE.CHARGE_AMOUNT) into var_refunds_before
  FROM
    CHARGE
  WHERE
    CHARGE.INVOICE_ID = in_invoice_id
    AND (
      CHARGE.CHARGE_STATUS_ID = GLOBAL_STATUSES_V18.CHARGE_OPENED
      OR (
        CHARGE.CHARGE_STATUS_ID = GLOBAL_STATUSES_V18.CHARGE_PROCESSED
        AND EXISTS (
          SELECT 1 FROM TRANSACTION_ATTEMPT ta where ta.transaction_id = CHARGE.TRANSACTION_ID and ta.transaction_attempt_status_id = GLOBAL_STATUSES_V18.TRANS_ATTEMPT_SUCCESS
        )
      )
    )
    AND CHARGE.CHARGE_AMOUNT < 0;
  
  -- Refunds are negative
  IF var_refunds_before IS NULL THEN var_refunds_before := 0; END IF;
  var_refunds_before := 0 - var_refunds_before;
  
  var_charges_amount := 0;
  
  FOR f_processed_charges IN (
    SELECT
      CHARGE.CHARGE_AMOUNT
    FROM
      CHARGE
    WHERE
      CHARGE.INVOICE_ID = in_invoice_id
      AND CHARGE.CHARGE_AMOUNT > 0
      AND CHARGE.CHARGE_STATUS_ID IN (SELECT GLOBAL_STATUSES_V18.CHARGE_PROCESSED FROM DUAL)
      AND EXISTS (SELECT 1 FROM TRANSACTION_ATTEMPT ta where ta.transaction_id = CHARGE.TRANSACTION_ID and ta.transaction_attempt_status_id = GLOBAL_STATUSES_V18.TRANS_ATTEMPT_SUCCESS)
  )
  LOOP
    var_charges_amount := var_charges_amount + f_processed_charges.CHARGE_AMOUNT;
  END LOOP;
  
  IF (in_refund_amount + var_refunds_before > var_invoice_amount) THEN
    RAISE TOT_REF_IS_GREATER_THAN_ANOUNT;
  END IF;
  
  IF (in_refund_amount + var_refunds_before > var_charges_amount) THEN
    RAISE TOT_REF_IS_GRATER_THAN_CHARGES;
  END IF;

  BEGIN
    PROCS_TRANSACTION_V18.CREATE_TRANSACTION(
      in_transaction_id         => NULL,
      in_status_id              => GLOBAL_STATUSES_V18.TRANSACTION_PREPARE,
      in_amount                 => -in_refund_amount,
      in_created_by             => in_created_by,
      in_order_id               => NULL,
      in_is_refund              => GLOBAL_CONSTANTS_V18.TRUE,
      in_transaction_type_code  => 'REFUND',
      out_transaction_id        => var_new_transaction_id
    );
    EXCEPTION
      WHEN OTHERS THEN
        EXCEPTION_MESSAGE := SQLERRM;
        RAISE CAN_NOT_CREATE_TRANSACTION;
  END;
  
  BEGIN
    PROCS_CHARGE_V18.CREATE_CHARGE(
      in_invoice_id         => in_invoice_id,
      in_transaction_id     => var_new_transaction_id,
      in_instrument_type_id => var_instrument_type_id,
      in_instrument_id      => var_instrument_id,
      in_charge_amount      => -in_refund_amount,
      in_created_by         => in_created_by,
      in_charge_status_id   => GLOBAL_STATUSES_V18.CHARGE_OPENED,
      out_charge_id         => var_new_charge_id
    );
    EXCEPTION
      WHEN OTHERS THEN
        EXCEPTION_MESSAGE := SQLERRM;
        RAISE CAN_NOT_CREATE_CHARGE;
  END;
  
  out_charge_id := var_new_charge_id;

  IF in_note IS NOT NULL AND var_subscription_id IS NOT NULL THEN
    BEGIN
      PROCS_SUBSCRIPTION_V18.ANNOTATE_SUBSCRIPTION(
        in_subscription_id => var_subscription_id,
        in_agent_id        => 0, -- AGENT_ID??
        in_note            => in_note,
        in_created_by      => in_created_by
      );
      EXCEPTION
        WHEN OTHERS THEN
          EXCEPTION_MESSAGE := SQLERRM;
          RAISE CAN_NOT_ANNOTATE_SUBSCRIPTION;
    END;
  END IF;

EXCEPTION
WHEN CAN_NOT_FIND_SUBSCR_OR_GC THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'Could not find subscription or GC for the inovice');
WHEN INVOICE_IS_NOT_CLOSED THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.STATE_ERROR,
    SPROC_NAME, 'Invoice is not closed');
WHEN ACCOUNT_IS_FROZEN THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.STATE_ERROR,
    SPROC_NAME, 'Could not refund subscription for frozen account');
WHEN BAD_INVOICE_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'No such invoice');
WHEN CAN_NOT_CALC_INVOICE_AMOUNT THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.INTERNAL_ERROR,
    SPROC_NAME, 'Could not calculate invoice amount', EXCEPTION_MESSAGE);
WHEN REFUND_IS_GREATER_THAN_ANOUNT THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.INVALID_PARAMETER,
    SPROC_NAME, 'Refund is greater than amount');
WHEN TOT_REF_IS_GREATER_THAN_ANOUNT THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.INVALID_PARAMETER,
    SPROC_NAME, 'There were refunds before and sum of all refunds and new refund more than invoice amount');
WHEN TOT_REF_IS_GRATER_THAN_CHARGES THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.INVALID_PARAMETER,
    SPROC_NAME, 'Total refund amount is greater than sum of processed charges');
WHEN CAN_NOT_CREATE_TRANSACTION THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.INTERNAL_ERROR,
    SPROC_NAME, 'Could not create transaction', EXCEPTION_MESSAGE);
WHEN CAN_NOT_CREATE_CHARGE THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.INTERNAL_ERROR,
    SPROC_NAME, 'Could not create charge', EXCEPTION_MESSAGE);
WHEN CAN_NOT_ANNOTATE_SUBSCRIPTION THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.INTERNAL_ERROR,
    SPROC_NAME, 'Could not annotate subscription', EXCEPTION_MESSAGE);
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END REFUND_INVOICE;

/******************************************************************************/

PROCEDURE GET_PAYMENT_INFO_BY_INVOICE_ID (
  in_invoice_id               IN NUMBER,
  out_order_id                OUT VARCHAR2,
  out_external_transaction_id OUT VARCHAR2
) AS
SPROC_NAME CONSTANT VARCHAR2(30) := 'GET_PEYMENT_INFO_BY_INVOICE_ID';
-- VARIABLES
temp_invoice_id number;
cnt_matched_instr number := 0;
-- EXCEPTIONS
BAD_INVOICE_ID EXCEPTION;
BEGIN
  
  BEGIN
    SELECT
      i.id into temp_invoice_id
    from
      invoice i
    where
      i.id = in_invoice_id;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE BAD_INVOICE_ID;
  END;

  select
    count(1) into cnt_matched_instr 
  from
    charge ch
  inner join
    subscription s
  on
    s.instrument_id = ch.instrument_id
  where
    ch.invoice_id = in_invoice_id;
  
  if cnt_matched_instr = 0 then
    out_external_transaction_id := null;
    out_order_id := null;
    return;
  end if;
  
  SELECT
    t.order_id,
    ta.external_transaction_id
    into
    out_order_id,
    out_external_transaction_id
  from
    charge ch
    inner join transaction t on ch.transaction_id = t.id
    inner join transaction_attempt ta on ta.transaction_id = t.id
  where
    ch.invoice_id = in_invoice_id
    and ta.transaction_attempt_status_id = GLOBAL_STATUSES_V18.TRANS_ATTEMPT_SUCCESS
    and ch.charge_amount > 0; -- We are not creating charges for the 0-amount invoices

EXCEPTION
WHEN BAD_INVOICE_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'No such invoice');
WHEN NO_DATA_FOUND THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'No payment data found');
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END GET_PAYMENT_INFO_BY_INVOICE_ID;

PROCEDURE IS_REVOKE_ENTITLEMENTS(
  in_invoice_id IN NUMBER,
  out_is_revoke OUT NUMBER
) AS
BEGIN
  SELECT DECODE(COUNT(1), 0, GLOBAL_CONSTANTS_V18.FALSE, GLOBAL_CONSTANTS_V18.TRUE)
    into out_is_revoke
  FROM
    offer_chain oc,
    subscription s,
    license l,
    invoice i
  where
    oc.id = s.offer_chain_id and
    s.id = l.subscription_id and
    l.invoice_id = i.id and
    oc.revoke_entitlements = GLOBAL_CONSTANTS_V18.TRUE and
    i.id = in_invoice_id and
    rownum < 2
  ;
END IS_REVOKE_ENTITLEMENTS;

END PROCS_INVOICE_V18;
.
/

CREATE OR REPLACE PACKAGE BODY "PROCS_FIN_INSTRUMENTS_V18" AS

PROCEDURE UPDATE_GC_STATUS_BY_INVOICE(
    in_invoice_id IN GIFT_CERTIFICATE.PURCHASE_INVOICE_ID%TYPE,
    in_status_id  IN GIFT_CERTIFICATE_STATUS.ID%TYPE,
    in_updater    IN GIFT_CERTIFICATE.UPDATED_BY%TYPE)
AS
SPROC_NAME CONSTANT VARCHAR2(32) := 'UPDATE_GC_STATUS_BY_INVOICE';
BEGIN
  FOR rec IN (SELECT id FROM Gift_Certificate WHERE Purchase_Invoice_Id = in_invoice_id) LOOP
    PROCS_FIN_INSTRUMENTS_CRU_V18.UPDATE_GIFT_CERTIFICATE (
      in_gift_certificate_id        => rec.Id,
      in_gift_certificate_status_id => in_status_id,
      in_updated_by                 => in_updater
    ); 
  END LOOP;
END UPDATE_GC_STATUS_BY_INVOICE;

PROCEDURE IS_INVOICE_FOR_REDEEMED_GC (
  in_invoice_id                IN NUMBER,
  out_is_invoice_for_redeem_gc OUT NUMBER
) AS
SPROC_NAME CONSTANT VARCHAR2(32) := 'IS_INVOICE_FOR_REDEEMED_GC';
var_is_for_gc NUMBER;
BEGIN
  SELECT
    count(1) into var_is_for_gc
  FROM GIFT_CERTIFICATE GC
  WHERE GC.PURCHASE_INVOICE_ID = in_invoice_id AND 
        GC.GIFT_CERTIFICATE_STATUS_ID = 2; 

  IF var_is_for_gc > 0 THEN
    out_is_invoice_for_redeem_gc := 1;
  ELSE
    out_is_invoice_for_redeem_gc := 0;
  END IF;
END IS_INVOICE_FOR_REDEEMED_GC;

PROCEDURE GET_UNREDEEMED_GCS (
  out_result_set          OUT SYS_REFCURSOR,
  in_hours_number         IN NUMBER DEFAULT 14*24,
  in_num_rows             IN NUMBER DEFAULT 10000,
  in_process_name IN PROCESS_RETRY_THROTTLE.PROCESS_NAME%TYPE
) AS
SPROC_NAME CONSTANT VARCHAR2(32) := 'GET_UNREDEEMED_GCS';
BEGIN
  OPEN out_result_set FOR
SELECT * FROM
(
  SELECT
    gc.EXPIRATION_DATE,
    ch.name,
    ch.id offer_chain_id,
    gc.sender_email,
    gc.sender_name,
    gc.recipient_email,
    gc.recipient_name,
    gc.purchase_date,
    gc.redemption_date,
    gc.purchaser_group_id,
    gc.redeemer_group_id,
    gc.code,
    gc.gift_message,
    gc.recipient_notify_date,
    gc.id
  FROM
    GIFT_CERTIFICATE gc,
    OFFER_CHAIN ch
  WHERE
    ch.id = gc.offer_chain_id
    AND gc.RECIPIENT_NOTIFY_DATE is not null
    AND gc.RECIPIENT_NOTIFY_DATE >= (sysdate - in_hours_number/24)
    AND gc.RECIPIENT_NOTIFY_DATE < (sysdate - (in_hours_number-72)/24)
    AND gc.redeemer_group_id is null
    AND NOT EXISTS(
      SELECT NULL
      FROM PROCESS_RETRY_THROTTLE
      WHERE PROCESS_NAME = in_process_name
        AND GENERIC_ID = gc.id
    ) AND EXISTS(
      SELECT NULL
      FROM
        charge c,
        transaction_attempt ta,
        transaction t
      WHERE
        c.invoice_id = gc.purchase_invoice_id and
        c.transaction_id = t.id and
        t.id = ta.transaction_id and
        ta.transaction_attempt_status_id = GLOBAL_STATUSES_V18.TRANS_ATTEMPT_SUCCESS
    ) AND NOT EXISTS (
      SELECT NULL
      FROM
        charge c,
        transaction t
      WHERE
        c.invoice_id = gc.purchase_invoice_id and
        c.transaction_id = t.id and
        t.is_refund = GLOBAL_CONSTANTS_V18.TRUE
    )
    AND ROWNUM <= in_num_rows*10
    ORDER BY dbms_random.value
) WHERE
    ROWNUM <= in_num_rows;
EXCEPTION
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END GET_UNREDEEMED_GCS;

PROCEDURE ADD_CREDIT_CARD (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
APP_EXCEPTION_CODES_V18.INTERNAL_ERROR
*/
  in_group_id               IN NUMBER,
  in_updated_by             IN VARCHAR2,
  in_instrument_name        IN VARCHAR2,
  in_card_holder_name       IN VARCHAR2,
  in_street_address         IN VARCHAR2,
  in_street_address2        IN VARCHAR2,
  in_state                  IN VARCHAR2,
  in_city                   IN VARCHAR2,
  in_postal_code            IN VARCHAR2,
  in_country                IN CHAR,
  in_last_four_cc           IN VARCHAR2,
  in_expiration_date        IN DATE,
  in_credit_card_type_id    IN NUMBER,
  in_token                  IN VARCHAR2,
  in_chase_profile_id       IN VARCHAR2,
  in_credit_card_status_id  IN NUMBER,
  in_private_first_name     IN VARCHAR2,
  in_private_last_name      IN VARCHAR2,
  out_credit_card_id        OUT NUMBER
) AS
SPROC_NAME             CONSTANT VARCHAR2(15) := 'ADD_CREDIT_CARD';
-- VARIABLES
var_account_id          NUMBER;
var_account_status      NUMBER;
var_credit_card_id      NUMBER;
temp_old_credit_card_id NUMBER;
-- EXCEPTIONS
BAD_ACCOUNT_STATUS         EXCEPTION;
CAN_NOT_SET_DEF_FINANCIAL  EXCEPTION;
BAD_IS_DEFAULT_VALUE       EXCEPTION;
BAD_OLD_CREDIT_CARD        EXCEPTION;
EXCEPTION_MESSAGE          VARCHAR2(1024);
----- DELETE NEXT LINES WHEN UI WILL SUPPORT MANY CC PER ACCOUNT
var_charges_set           SYS_REFCURSOR;
var_charge_id             NUMBER;
var_charge_invoice_id     NUMBER;
var_charge_transaction_id NUMBER;
var_charge_amount         NUMBER(10,2);
temp_out_charge_id        NUMBER;
temp_out_transaction_id   NUMBER;
var_order_id			  VARCHAR2(1024);
BEGIN

  -- Get account id
  -- Get account status
  SELECT
    ACCOUNT.ID,
    ACCOUNT.ACCOUNT_STATUS_ID
    into
    var_account_id,
    var_account_status
  FROM
    ACCOUNT
  WHERE
    ACCOUNT.GROUP_ID = in_group_id;

  SELECT
    CC_ID_SEQ.nextVal into var_credit_card_id
  FROM DUAL;

  -- Insert new row in CREDIT_CARD table
  PROCS_FIN_INSTRUMENTS_CRU_V18.CREATE_CREDIT_CARD(
    out_credit_card_id          => var_credit_card_id,
    in_account_id               => var_account_id,
    in_instrument_name          => in_instrument_name,
    in_private_card_holder_name => in_card_holder_name,
    in_private_street_address   => in_street_address,
    in_private_street_address2  => in_street_address2,
    in_state                    => in_state,
    in_city                     => in_city,
    in_postal_code              => in_postal_code,
    in_country                  => in_country,
    in_last_four_cc             => in_last_four_cc,
    in_expiration_date          => in_expiration_date,
    in_credit_card_type_id      => in_credit_card_type_id,
    in_secret_token             => in_token,
    in_chase_profile_id         => in_chase_profile_id,
    in_created_by               => in_updated_by,
    in_credit_card_status_id    => in_credit_card_status_id,
    in_private_first_name       => in_private_first_name,
    in_private_last_name        => in_private_last_name
  );

  out_credit_card_id := var_credit_card_id;
  
EXCEPTION
WHEN NO_DATA_FOUND THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'No such account');
WHEN BAD_OLD_CREDIT_CARD THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'Bad old credit card id');
WHEN BAD_IS_DEFAULT_VALUE THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.INVALID_PARAMETER,
    SPROC_NAME, 'Bad is_default value');
WHEN CAN_NOT_SET_DEF_FINANCIAL THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.INTERNAL_ERROR,
    SPROC_NAME, 'Can not set default finansial instrument', EXCEPTION_MESSAGE);
WHEN BAD_ACCOUNT_STATUS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.STATE_ERROR,
    SPROC_NAME, 'Account is not active');
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END ADD_CREDIT_CARD;

/******************************************************************************/

PROCEDURE ADD_PAYPAL (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_group_id                     IN NUMBER,
  in_instrument_name              IN VARCHAR2,
  in_private_email_address        IN VARCHAR2,
  in_created_by                   IN VARCHAR2,
  in_paypal_status_id             IN NUMBER,
  in_paypal_prvt_street_address   IN VARCHAR2,
  in_paypal_prvt_street_address2  IN VARCHAR2,
  in_state                        IN VARCHAR2,
  in_city                         IN VARCHAR2,
  in_postal_code                  IN VARCHAR2,
  in_country                      IN CHAR,
  in_expiration_date              IN DATE,
  in_secret_token                 IN VARCHAR2,
  out_paypal_id                   OUT NUMBER
) AS
SPROC_NAME CONSTANT VARCHAR2(10) := 'ADD_PAYPAL';
var_paypal_id NUMBER;
var_account_id  NUMBER;
-- EXCEPTIONS
BAD_GROUP_ID          EXCEPTION;
CAN_NOT_CREATE_PAYPAL EXCEPTION;
BAD_PAYPAL_STATUS     EXCEPTION;
EXCEPTION_MESSAGE VARCHAR2(1024);
BEGIN
  
  IF in_paypal_status_id != GLOBAL_STATUSES_V18.PAYPAL_ACTIVE
    AND in_paypal_status_id != GLOBAL_STATUSES_V18.PAYPAL_INACTIVE
    AND in_paypal_status_id != GLOBAL_STATUSES_V18.PAYPAL_FROZEN THEN
    RAISE BAD_PAYPAL_STATUS;
  END IF;
  
  BEGIN
    SELECT
      a.id into var_account_id
    from
      account a
    where
      a.group_id = in_group_id;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE BAD_GROUP_ID;
  END;
  
  BEGIN
    PROCS_FIN_INSTRUMENTS_CRU_V18.CREATE_PAYPAL(
      out_paypal_id                  => var_paypal_id,
      in_paypal_id                   => NULL,
      in_account_id                  => var_account_id,
      in_instrument_name             => in_instrument_name,
      in_private_email_address       => in_private_email_address,
      in_created_by                  => in_created_by,
      in_paypal_status_id            => in_paypal_status_id,
      in_paypal_prvt_street_address  => in_paypal_prvt_street_address,
      in_paypal_prvt_street_address2 => in_paypal_prvt_street_address2,
      in_state                       => in_state,
      in_city                        => in_city,
      in_postal_code                 => in_postal_code,
      in_country                     => in_country,
      in_expiration_date             => in_expiration_date,
      in_secret_token                => in_secret_token
    );
    EXCEPTION
      WHEN OTHERS THEN
        EXCEPTION_MESSAGE := SQLERRM;
        RAISE CAN_NOT_CREATE_PAYPAL;
  END;
  
  out_paypal_id := var_paypal_id;

EXCEPTION
WHEN BAD_GROUP_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'No such group id');
WHEN BAD_PAYPAL_STATUS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'Bad paypal status');
WHEN CAN_NOT_CREATE_PAYPAL THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.INTERNAL_ERROR,
    SPROC_NAME, 'Could not create paypal', EXCEPTION_MESSAGE);
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END ADD_PAYPAL;

/******************************************************************************/

PROCEDURE DISABLE_CREDIT_CARD (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
APP_EXCEPTION_CODES_V18.INTERNAL_ERROR
*/
  in_credit_card_id IN NUMBER,
  in_updated_by     IN VARCHAR2
) AS 
SPROC_NAME                   CONSTANT VARCHAR2(19) := 'DISABLE_CREDIT_CARD';
-- VARIBLES
var_account_id                 NUMBER;
var_group_id                   NUMBER;
var_credit_card_status         NUMBER;
var_pending_transactions_num   NUMBER;
var_pending_invoices_num       NUMBER;
current_def_instrument_type_id NUMBER;
current_def_instrument_id      NUMBER;
-- EXCEPTIONS
BAD_CC_STATUS                EXCEPTION;
PENDING_TRANSACTIONS_FOUNDED EXCEPTION;
CAN_NOT_GET_DEF_FINANCIAL    EXCEPTION;
CAN_NOT_DEL_DEF_FINANCIAL    EXCEPTION;
CAN_NOT_DISABLE_CREDIT_CARD  EXCEPTION;
EXCEPTION_MESSAGE            VARCHAR2(1024);
BEGIN

  -- Get credit card status
  -- Get account id
  SELECT
    CREDIT_CARD.CREDIT_CARD_STATUS_ID,
    CREDIT_CARD.ACCOUNT_ID
    into
    var_credit_card_status,
    var_account_id
  FROM
    CREDIT_CARD
  WHERE
    CREDIT_CARD.ID = in_credit_card_id;

  -- Check that we can disable this credit card (STUB)
  IF F_CAN_DISABLE_CREDIT_CARD(in_credit_card_id) = GLOBAL_CONSTANTS_V18.FALSE THEN
    RAISE CAN_NOT_DISABLE_CREDIT_CARD;
  END IF;
  
  -- Get account id
  SELECT
    ACCOUNT.GROUP_ID into var_group_id
  FROM
    ACCOUNT
  WHERE
    ACCOUNT.ID = var_account_id;
  
  -- Card should to be active
  IF var_credit_card_status != GLOBAL_STATUSES_V18.CREDIT_CARD_ACTIVE THEN
    RAISE BAD_CC_STATUS;
  END IF;
  
  -- Looking for pending transactions associated with given credit card
  SELECT
    COUNT(*) into var_pending_invoices_num
  FROM
    CHARGE
    INNER JOIN TRANSACTION ON CHARGE.TRANSACTION_ID = TRANSACTION.ID
  WHERE
    CHARGE.INSTRUMENT_TYPE_ID = GLOBAL_ENUMS_V18.INSTRUMENT_CREDIT_CARD
    AND CHARGE.INSTRUMENT_ID = in_credit_card_id
    AND TRANSACTION.TRANSACTION_STATUS_ID = GLOBAL_STATUSES_V18.TRANSACTION_PENDING;
    
  IF var_pending_invoices_num > 0 THEN
    RAISE PENDING_TRANSACTIONS_FOUNDED;
  END IF;
  
  -- Getting current default financial instrument
  BEGIN
    GET_DEF_FINANCIAL_INSTRUMENT(
      in_group_id            => var_group_id,
      out_instrument_type_id => current_def_instrument_type_id,
      out_instrument_id      => current_def_instrument_id
    );
    EXCEPTION
      WHEN OTHERS THEN
        EXCEPTION_MESSAGE := SQLERRM;
        RAISE CAN_NOT_GET_DEF_FINANCIAL;
  END;
  
  -- Checking that credit card is not default
  IF current_def_instrument_type_id = GLOBAL_ENUMS_V18.INSTRUMENT_CREDIT_CARD
    AND current_def_instrument_id = in_credit_card_id THEN
    BEGIN
      DEL_DEF_FINANCIAL_INSTRUMENT(
        in_group_id => var_group_id
      );
    EXCEPTION
      WHEN OTHERS THEN
        EXCEPTION_MESSAGE := SQLERRM;
        RAISE CAN_NOT_DEL_DEF_FINANCIAL;
    END;
  END IF;

  -- Update credit card status
  PROCS_FIN_INSTRUMENTS_V18.UPDATE_CREDIT_CARD_STATUS(
    in_credit_card_id        => in_credit_card_id,
    in_updated_by            => in_updated_by,
    in_credit_card_status_id => GLOBAL_STATUSES_V18.CREDIT_CARD_DISABLED
  );
    
EXCEPTION
WHEN NO_DATA_FOUND THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'No such credit card');
WHEN CAN_NOT_GET_DEF_FINANCIAL THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.INTERNAL_ERROR,
    SPROC_NAME, 'Could not get current default financial instrument', EXCEPTION_MESSAGE);
WHEN CAN_NOT_DEL_DEF_FINANCIAL THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.INTERNAL_ERROR,
    SPROC_NAME, 'Could not delete information about default financial instrument from account', EXCEPTION_MESSAGE);
WHEN BAD_CC_STATUS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.STATE_ERROR,
    SPROC_NAME, 'Credit card is not active');
WHEN PENDING_TRANSACTIONS_FOUNDED THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.STATE_ERROR,
    SPROC_NAME, 'Account has pending charge which is using this card');
WHEN CAN_NOT_DISABLE_CREDIT_CARD THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.INTERNAL_ERROR,
    SPROC_NAME, 'Could not disable this credit card', EXCEPTION_MESSAGE);
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END DISABLE_CREDIT_CARD;

/******************************************************************************/

PROCEDURE DISABLE_PAYPAL (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
APP_EXCEPTION_CODES_V18.INTERNAL_ERROR
*/
  in_paypal_id  IN NUMBER,
  in_updated_by IN VARCHAR2
) AS
SPROC_NAME CONSTANT VARCHAR2(14) := 'DISABLE_PAYPAL';
-- VARIABLES
var_paypal_status_id NUMBER;
var_account_id       NUMBER;
var_group_id         NUMBER;
var_pending_invoices_num NUMBER;
current_def_instrument_type_id NUMBER;
current_def_instrument_id NUMBER;
-- EXCEPTIONS
BAD_PAYPAL_ID EXCEPTION;
PAYPAL_ALREADY_INACTIVE EXCEPTION;
PENDING_TRANSACTIONS_FOUND EXCEPTION;
CAN_NOT_GET_DEF_FINANCIAL EXCEPTION;
CAN_NOT_DEL_DEF_FINANCIAL EXCEPTION;
EXCEPTION_MESSAGE VARCHAR2(1024);
BEGIN
  
  -- Get Paypal status
  -- Get account
  BEGIN
    SELECT
      PAYPAL.PAYPAL_STATUS_ID,
      PAYPAL.ACCOUNT_ID
      into
      var_paypal_status_id,
      var_account_id
    FROM
      PAYPAL
    WHERE
      PAYPAL.ID = in_paypal_id;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE BAD_PAYPAL_ID;
  END;
  
  -- Get group id
  SELECT
    ACCOUNT.GROUP_ID into var_group_id
  FROM
    ACCOUNT
  WHERE
    ACCOUNT.ID = var_account_id;
  
  -- Card should not be disabled
  IF var_paypal_status_id = GLOBAL_STATUSES_V18.PAYPAL_INACTIVE THEN
    RAISE PAYPAL_ALREADY_INACTIVE;
  END IF;

  -- Looking for pending transactions associated with given credit card
  SELECT
    COUNT(*) into var_pending_invoices_num
  FROM
    CHARGE
    INNER JOIN TRANSACTION ON CHARGE.TRANSACTION_ID = TRANSACTION.ID
  WHERE
    CHARGE.INSTRUMENT_TYPE_ID = GLOBAL_ENUMS_V18.INSTRUMENT_PAYPAL
    AND CHARGE.INSTRUMENT_ID = in_paypal_id
    AND TRANSACTION.TRANSACTION_STATUS_ID = GLOBAL_STATUSES_V18.TRANSACTION_PENDING;
    
  IF var_pending_invoices_num > 0 THEN
    RAISE PENDING_TRANSACTIONS_FOUND;
  END IF;

  -- Getting current default financial instrument
  BEGIN
    GET_DEF_FINANCIAL_INSTRUMENT(
      in_group_id            => var_group_id,
      out_instrument_type_id => current_def_instrument_type_id,
      out_instrument_id      => current_def_instrument_id
    );
    EXCEPTION
      WHEN OTHERS THEN
        EXCEPTION_MESSAGE := SQLERRM;
        RAISE CAN_NOT_GET_DEF_FINANCIAL;
  END;

  -- Checking that credit card is not default
  IF current_def_instrument_type_id = GLOBAL_ENUMS_V18.INSTRUMENT_PAYPAL
    AND current_def_instrument_id = in_paypal_id THEN
    BEGIN
      DEL_DEF_FINANCIAL_INSTRUMENT(
        in_group_id => var_group_id
      );
    EXCEPTION
      WHEN OTHERS THEN
        EXCEPTION_MESSAGE := SQLERRM;
        RAISE CAN_NOT_DEL_DEF_FINANCIAL;
    END;
  END IF;
  
  PROCS_FIN_INSTRUMENTS_V18.UPDATE_PAYPAL_STATUS(
    in_paypal_id        => in_paypal_id,
    in_updated_by       => in_updated_by,
    in_paypal_status_id => GLOBAL_STATUSES_V18.PAYPAL_INACTIVE
  );

EXCEPTION
WHEN BAD_PAYPAL_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'No such paypal');
WHEN PAYPAL_ALREADY_INACTIVE THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.STATE_ERROR,
    SPROC_NAME, 'Paypal already inactive');
WHEN PENDING_TRANSACTIONS_FOUND THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.STATE_ERROR,
    SPROC_NAME, 'Account has pending charge which are using this paypal');
WHEN CAN_NOT_GET_DEF_FINANCIAL THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.INTERNAL_ERROR,
    SPROC_NAME, 'Could not get current default financial instrument', EXCEPTION_MESSAGE);
WHEN CAN_NOT_DEL_DEF_FINANCIAL THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.INTERNAL_ERROR,
    SPROC_NAME, 'Could not delete information about default financial instrument from account', EXCEPTION_MESSAGE);
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END DISABLE_PAYPAL;

/******************************************************************************/

PROCEDURE UPDATE_CREDIT_CARD (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_credit_card_id         IN NUMBER,
  in_updated_by             IN VARCHAR2,
  in_instrument_name        IN VARCHAR2,
  in_is_default             IN NUMBER
) AS 
SPROC_NAME CONSTANT VARCHAR2(18) := 'UPDATE_CREDIT_CARD';
-- VARIABLES
var_account_id NUMBER;
var_group_id   NUMBER;
temp_cc_rownum NUMBER;
current_def_instrument_type_id NUMBER;
current_def_instrument_id      NUMBER;
-- EXCEPTION
CAN_NOT_SET_DEF_FINANCIAL  EXCEPTION;
BAD_IS_DEFAULT_VALUE       EXCEPTION;
CAN_NOT_GET_DEF_FINANCIAL  EXCEPTION;
CAN_NOT_DEL_DEF_FINANCIAL  EXCEPTION;
EXCEPTION_MESSAGE          VARCHAR2(1024);
BEGIN
  
  -- Get account id
  SELECT
    CREDIT_CARD.ACCOUNT_ID
    into
    var_account_id
  FROM
    CREDIT_CARD
  WHERE
    CREDIT_CARD.ID = in_credit_card_id;
  
  -- Get group id
  SELECT
    ACCOUNT.GROUP_ID into var_group_id
  FROM
    ACCOUNT
  WHERE
    ACCOUNT.ID = var_account_id;

  -- Check that passed data is correct
  IF in_is_default != GLOBAL_CONSTANTS_V18.TRUE
    AND in_is_default != GLOBAL_CONSTANTS_V18.FALSE
    AND in_is_default IS NOT NULL THEN
    RAISE BAD_IS_DEFAULT_VALUE;
  END IF;

  -- Update credit card
  IF in_instrument_name IS NOT NULL THEN
    PROCS_FIN_INSTRUMENTS_CRU_V18.UPDATE_CREDIT_CARD(
      in_credit_card_id  => in_credit_card_id,
      in_updated_by      => in_updated_by,
      in_instrument_name => in_instrument_name
    );
  END IF;

  -- Set default financial instrument
  IF in_is_default = GLOBAL_CONSTANTS_V18.TRUE THEN
    BEGIN
      PROCS_FIN_INSTRUMENTS_V18.SET_DEF_FINANCIAL_INSTRUMENT(
        in_group_id           => var_group_id,
        in_instrument_type_id => GLOBAL_ENUMS_V18.INSTRUMENT_CREDIT_CARD,
        in_instrument_id      => in_credit_card_id,
        in_updated_by         => in_updated_by
      );
      EXCEPTION
        WHEN OTHERS THEN
          EXCEPTION_MESSAGE := SQLERRM;
          RAISE CAN_NOT_SET_DEF_FINANCIAL;
    END;
  END IF;
  
  -- Set default financial instrument
  IF in_is_default = GLOBAL_CONSTANTS_V18.FALSE THEN
    BEGIN
      GET_DEF_FINANCIAL_INSTRUMENT(
        in_group_id            => var_group_id,
        out_instrument_type_id => current_def_instrument_type_id,
        out_instrument_id      => current_def_instrument_id
      );
    EXCEPTION
      WHEN OTHERS THEN
        EXCEPTION_MESSAGE := SQLERRM;
        RAISE CAN_NOT_GET_DEF_FINANCIAL;
    END;
    IF current_def_instrument_type_id = GLOBAL_ENUMS_V18.INSTRUMENT_CREDIT_CARD
      AND current_def_instrument_id = in_credit_card_id THEN
      BEGIN
        DEL_DEF_FINANCIAL_INSTRUMENT(
          in_group_id => var_group_id
        );
        EXCEPTION
          WHEN OTHERS THEN
            EXCEPTION_MESSAGE := SQLERRM;
            RAISE CAN_NOT_DEL_DEF_FINANCIAL;
      END;
    END IF;
  END IF;

EXCEPTION
WHEN NO_DATA_FOUND THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'No such credit card');
WHEN CAN_NOT_SET_DEF_FINANCIAL THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.INTERNAL_ERROR,
    SPROC_NAME, 'Could not set default financial instrument for account', EXCEPTION_MESSAGE);
WHEN CAN_NOT_GET_DEF_FINANCIAL THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.INTERNAL_ERROR,
    SPROC_NAME, 'Could not get default financial instrument for account', EXCEPTION_MESSAGE);
WHEN CAN_NOT_DEL_DEF_FINANCIAL THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.INTERNAL_ERROR,
    SPROC_NAME, 'Could not delete information about default financial instrument', EXCEPTION_MESSAGE);
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END UPDATE_CREDIT_CARD;

/******************************************************************************/

PROCEDURE START_GC_PURCHASING (
  in_group_id               IN NUMBER,
  in_offer_chain_id         IN VARCHAR2,
  in_gift_certificate_code  IN  VARCHAR2,
  in_created_by             IN  VARCHAR2,
  in_recipient_name         IN  VARCHAR2,
  in_recipient_email        IN  VARCHAR2,
  in_recipient_address_id   IN NUMBER,
  in_recipient_notify_date  IN DATE,
  in_sender_name            IN VARCHAR2,
  in_sender_email           IN VARCHAR2,
  in_gift_message           IN  VARCHAR2,
  in_expiration_date        IN DATE,
  out_gift_certificate_id   OUT NUMBER,
  out_invoice_id            OUT NUMBER
) AS
SPROC_NAME CONSTANT VARCHAR2(19) := 'START_GC_PURCHASING';
-- VARIABLES
var_account_id            NUMBER;
temp_gc_code              GIFT_CERTIFICATE.CODE%TYPE;
var_och_is_gc             NUMBER;
var_offer_chain_status_id NUMBER;
var_is_for_redemption     NUMBER;
var_new_invoice_id        NUMBER;
var_gift_cert_id          NUMBER;
var_account_tax_exempt_id VARCHAR2(255);
-- EXCEPTIONS
BAD_GROUP_ID                  EXCEPTION;
GC_CODE_ALREADY_EXISTS        EXCEPTION;
BAD_OFFER_CHAIN_ID            EXCEPTION;
OCH_IS_NOT_GIFT_CERTIFICATE   EXCEPTION;
BAD_OFFER_CHAIN_STATUS        EXCEPTION;
CAN_NOT_PURCHASE_GC_FOR_RDMPN EXCEPTION;
CAN_NOT_CREATE_INVOICE        EXCEPTION;
OFFER_REC_NUM_LESS_THAN_ONE   EXCEPTION;
CAN_NOT_CREATE_LINE_ITEMS     EXCEPTION;

EXCEPTION_MESSAGE VARCHAR2(1024);
BEGIN
  -- Get account id
  BEGIN
    SELECT
      ACCOUNT.ID,
      ACCOUNT.TAX_EXEMPT_ID
      into
      var_account_id,
      var_account_tax_exempt_id
    FROM
      ACCOUNT
    WHERE
      ACCOUNT.GROUP_ID = in_group_id;
    EXCEPTION
    WHEN NO_DATA_FOUND THEN
      RAISE BAD_GROUP_ID;
  END;

  -- Check for the same code
  BEGIN
    SELECT
      GIFT_CERTIFICATE.CODE into temp_gc_code
    FROM
      GIFT_CERTIFICATE
    WHERE
      GIFT_CERTIFICATE.CODE = in_gift_certificate_code;
      
    RAISE GC_CODE_ALREADY_EXISTS;
    
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        NULL;
  END;
  
  -- Get offer chain flag "is_gift_certificate"
  BEGIN
    SELECT
      OFFER_CHAIN.IS_GIFT_CERTIFICATE,
      OFFER_CHAIN.OFFER_CHAIN_STATUS_ID
      into
      var_och_is_gc,
      var_offer_chain_status_id
    FROM
      OFFER_CHAIN
    WHERE
      OFFER_CHAIN.ID = in_offer_chain_id;
    EXCEPTION
    WHEN NO_DATA_FOUND THEN
      RAISE BAD_OFFER_CHAIN_ID;
  END;

  IF var_och_is_gc != GLOBAL_CONSTANTS_V18.TRUE
    OR var_och_is_gc IS NULL THEN
    RAISE OCH_IS_NOT_GIFT_CERTIFICATE;
  END IF;
  
  IF var_offer_chain_status_id != GLOBAL_STATUSES_V18.OFFER_CHAIN_ACTIVE THEN
    RAISE BAD_OFFER_CHAIN_STATUS;
  END IF;

  -- norlov: #38151 check if the OC is for Redemption:
  SELECT 
    COUNT(*) into var_is_for_redemption
  FROM
    OFFER_CHAIN_ELIGIBILITY 
  WHERE
    OFFER_CHAIN_ELIGIBILITY.OFFER_CHAIN_ID = in_offer_chain_id
    AND OFFER_CHAIN_ELIGIBILITY.NAME = GLOBAL_CONSTANTS_V18.GIFT_CERTIFICATE_REQUIRED
    AND OFFER_CHAIN_ELIGIBILITY.VALUE = GLOBAL_CONSTANTS_V18.ELIGIBILITY_FLAG_SET;
  
  IF var_is_for_redemption > 0 THEN
    RAISE CAN_NOT_PURCHASE_GC_FOR_RDMPN;
  END IF;

  -- Create new invoice  
  BEGIN
    PROCS_INVOICE_V18.CREATE_INVOICE(
      in_invoice_status => GLOBAL_STATUSES_V18.INVOICE_OPEN,
      in_created_by     => in_created_by,
      in_tax_exempt_id  => var_account_tax_exempt_id,
      out_invoice_id    => var_new_invoice_id
    );
    EXCEPTION
      WHEN OTHERS THEN
        EXCEPTION_MESSAGE := SQLERRM;
        RAISE CAN_NOT_CREATE_INVOICE;
  END;

  -- Add line items for new invoice
  BEGIN
    FOR f_offer_data IN (
      SELECT
        OFFER_ID,
        NUM_RECURRENCES
      FROM
        OFFER_OFFER_CHAIN
      WHERE
        OFFER_OFFER_CHAIN.OFFER_CHAIN_ID = in_offer_chain_id
    )
    LOOP
      IF f_offer_data.NUM_RECURRENCES < 1 THEN
        RAISE OFFER_REC_NUM_LESS_THAN_ONE;
      END IF;
      FOR i_offer_recurrences_iterator IN 1..f_offer_data.NUM_RECURRENCES
      LOOP
        PROCS_LINE_ITEMS_V18.ADD_LINE_ITEMS(
          in_invoice_id => var_new_invoice_id,
          in_offer_id   => f_offer_data.OFFER_ID,
          in_created_by => in_created_by
        );
      END LOOP;
    END LOOP;
  
    EXCEPTION
      WHEN OTHERS THEN
        EXCEPTION_MESSAGE := SQLERRM;
        RAISE CAN_NOT_CREATE_LINE_ITEMS;
  END;
  
  PROCS_FIN_INSTRUMENTS_CRU_V18.CREATE_GIFT_CERTIFICATE(
    out_gift_certificate_id       => var_gift_cert_id,
    in_purchaser_group_id         => in_group_id,
    in_purchaser_invoice_id       => var_new_invoice_id,
    in_offer_chain_id             => in_offer_chain_id,
    in_expiration_date            => in_expiration_date,
    in_purchase_date              => SYSDATE,
    in_gift_certificate_status_id => GLOBAL_STATUSES_V18.GIFT_CERTIFICATE_ACTIVE,
    in_code                       => in_gift_certificate_code,
    in_created_by                 => in_created_by,
    in_recipient_name             => in_recipient_name,
    in_gift_message               => in_gift_message,
    in_recipient_email            => in_recipient_email,
    in_sender_email               => in_sender_email,
    in_sender_name                => in_sender_name,
    in_recipient_address_id       => in_recipient_address_id,
    in_recipient_notify_date      => in_recipient_notify_date
  );
  
  out_gift_certificate_id := var_gift_cert_id;
  out_invoice_id := var_new_invoice_id;

EXCEPTION
WHEN BAD_OFFER_CHAIN_STATUS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.STATE_ERROR,
    SPROC_NAME, 'Offer chain is not active');
WHEN GC_CODE_ALREADY_EXISTS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.DUPLICATE_ERROR,
    SPROC_NAME, 'Gift certificate with same code already exists');
WHEN OCH_IS_NOT_GIFT_CERTIFICATE THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.INVALID_PARAMETER,
    SPROC_NAME, 'This offer chain can not be used for gift certificate');
WHEN CAN_NOT_PURCHASE_GC_FOR_RDMPN THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.INVALID_PARAMETER,
    SPROC_NAME, 'This offer chain can not be purchased for gift certificate since it is for redemption');
WHEN CAN_NOT_CREATE_INVOICE THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.INTERNAL_ERROR,
    SPROC_NAME, 'Could not create new invoice', EXCEPTION_MESSAGE);
WHEN CAN_NOT_CREATE_LINE_ITEMS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.INTERNAL_ERROR,
    SPROC_NAME, 'Could not create line items', EXCEPTION_MESSAGE);
WHEN BAD_GROUP_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'No such group id');
WHEN BAD_OFFER_CHAIN_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'No such offer chain');
WHEN OFFER_REC_NUM_LESS_THAN_ONE THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.INTERNAL_ERROR,
    SPROC_NAME, 'Some offer has recurrences number less than 1');
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END START_GC_PURCHASING;

/******************************************************************************/

PROCEDURE FINALIZE_GC_PURCHASING (
  in_invoice_id         IN NUMBER,
  in_created_by         IN VARCHAR2,
  in_instrument_id      IN NUMBER,
  in_instrument_type_id IN NUMBER,
  in_order_id           IN VARCHAR2,
  in_transaction_id     IN NUMBER,
  out_charge_amount     OUT NUMBER
) AS
SPROC_NAME CONSTANT VARCHAR2(22) := 'FINALIZE_GC_PURCHASING';
-- VARIABLES
temp_transaction_id_count NUMBER;
var_invoice_amount        NUMBER(10,2);
var_transaction_id        NUMBER;
var_new_charge_id         NUMBER;
-- EXCEPTIONS
BAD_CREDIT_CARD_ID          EXCEPTION;
BAD_PAYPAL_ID               EXCEPTION;
BAD_INSTRUMENT_TYPE         EXCEPTION;
TRANSACTION_EXISTS          EXCEPTION;
CAN_NOT_CALC_INVOICE_AMOUNT EXCEPTION;
CAN_NOT_USE_FCINSTR         EXCEPTION;
CAN_NOT_CREATE_TRANSACTION  EXCEPTION;
CAN_NOT_CREATE_CHARGE       EXCEPTION;
EXCEPTION_MESSAGE   VARCHAR2(1024);
BEGIN

  -- Check that instrument exists
  IF in_instrument_type_id = GLOBAL_ENUMS_V18.INSTRUMENT_CREDIT_CARD THEN
    IF IS_CREDIT_CARD_EXISTS(in_instrument_id) = GLOBAL_CONSTANTS_V18.FALSE THEN
      RAISE BAD_CREDIT_CARD_ID;
    END IF;
  ELSIF in_instrument_type_id = GLOBAL_ENUMS_V18.INSTRUMENT_PAYPAL THEN
    IF IS_PAYPAL_EXISTS(in_instrument_id) = GLOBAL_CONSTANTS_V18.FALSE THEN
      RAISE BAD_PAYPAL_ID;
    END IF;
  ELSIF in_instrument_type_id = GLOBAL_ENUMS_V18.INSTRUMENT_ZCI_INSTRUMENT THEN
    NULL;
  ELSE
    RAISE BAD_INSTRUMENT_TYPE;
  END IF;
  
  -- Check that transaction with given id do not exists
  SELECT
    COUNT(*) into temp_transaction_id_count
  FROM
    TRANSACTION
  WHERE
    TRANSACTION.ID = in_transaction_id;

  IF temp_transaction_id_count > 0 THEN
    RAISE TRANSACTION_EXISTS;
  END IF;

  -- Calculate new invoice amount
  BEGIN
    PROCS_INVOICE_V18.CALCULATE_INVOICE_AMOUNT(in_invoice_id, var_invoice_amount);
    EXCEPTION
      WHEN OTHERS THEN
        EXCEPTION_MESSAGE := SQLERRM;
        RAISE CAN_NOT_CALC_INVOICE_AMOUNT;
  END;
  
  IF var_invoice_amount > 0
    AND in_instrument_type_id = GLOBAL_ENUMS_V18.INSTRUMENT_ZCI_INSTRUMENT THEN
    RAISE CAN_NOT_USE_FCINSTR;
  END IF;
  
  -- If invoice amount iz 0 then we need to set status for this invoice to PROCCESSED
  IF var_invoice_amount = 0 THEN
    PROCS_INVOICE_CRU_V18.UPDATE_INVOICE(
      in_invoice_id                  => in_invoice_id,
      in_updated_by                  => in_created_by,
      in_invoice_status_id           => GLOBAL_STATUSES_V18.INVOICE_CLOSED
    );
  END IF;

  IF var_invoice_amount > 0 THEN
    -- Create transaction
    BEGIN
      PROCS_TRANSACTION_V18.CREATE_TRANSACTION(
        in_transaction_id        => in_transaction_id,
        in_status_id             => GLOBAL_STATUSES_V18.TRANSACTION_PENDING,
        in_amount                => var_invoice_amount,
        in_created_by            => in_created_by,
        in_order_id              => in_order_id,
        in_transaction_type_code => 'GIFT_CERTIFICATE_PURCHASE',
        out_transaction_id       => var_transaction_id
      );
      EXCEPTION
        WHEN OTHERS THEN
          EXCEPTION_MESSAGE := SQLERRM;
          RAISE CAN_NOT_CREATE_TRANSACTION;
    END;

    -- Create charge
    BEGIN
      PROCS_CHARGE_V18.CREATE_CHARGE(
        in_invoice_id         => in_invoice_id,
        in_transaction_id     => var_transaction_id,
        in_instrument_type_id => in_instrument_type_id,
        in_instrument_id      => in_instrument_id,
        in_charge_amount      => var_invoice_amount,
        in_created_by         => in_created_by,
        in_charge_status_id   => GLOBAL_STATUSES_V18.CHARGE_OPENED,
        out_charge_id         => var_new_charge_id
      );
      out_charge_amount := var_invoice_amount;
      EXCEPTION
        WHEN OTHERS THEN
          EXCEPTION_MESSAGE := SQLERRM;
          RAISE CAN_NOT_CREATE_CHARGE;
    END;
  ELSE
    out_charge_amount := 0;
  END IF;

EXCEPTION
WHEN CAN_NOT_USE_FCINSTR THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.STATE_ERROR,
    SPROC_NAME, 'Could not use "free charge instrument" for non-zero invoice');
WHEN BAD_CREDIT_CARD_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'Bad credit card id');
WHEN BAD_PAYPAL_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'Bad paypal id');
WHEN BAD_INSTRUMENT_TYPE THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.INVALID_PARAMETER,
    SPROC_NAME, 'Bad instrument type');
WHEN TRANSACTION_EXISTS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.DUPLICATE_ERROR,
    SPROC_NAME, 'Transaction with given id already exists');
WHEN CAN_NOT_CREATE_TRANSACTION THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.INTERNAL_ERROR,
    SPROC_NAME, 'Could not create transaction', EXCEPTION_MESSAGE);
WHEN CAN_NOT_CREATE_CHARGE THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.INTERNAL_ERROR,
    SPROC_NAME, 'Could not create charge', EXCEPTION_MESSAGE);
WHEN CAN_NOT_CALC_INVOICE_AMOUNT THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.INTERNAL_ERROR,
    SPROC_NAME, 'Could not calculate amount for new invoice', EXCEPTION_MESSAGE);
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END FINALIZE_GC_PURCHASING;

/******************************************************************************/

PROCEDURE PURCHASE_GIFT_CERTIFICATE (
  in_group_id               IN NUMBER,
  in_offer_chain_id         IN VARCHAR2,
  in_gift_certificate_code  IN VARCHAR2,
  in_created_by             IN VARCHAR2,
  in_recipient_name         IN VARCHAR2,
  in_recipient_email        IN VARCHAR2,
  in_sender_name            IN VARCHAR2,
  in_sender_email           IN VARCHAR2,
  in_gift_message           IN VARCHAR2,
  in_instrument_id          IN NUMBER,
  in_instrument_type_id     IN NUMBER,
  in_expiration_date        IN DATE,
  in_order_id               IN VARCHAR2,
  in_transaction_id         IN NUMBER
) AS 
SPROC_NAME         CONSTANT VARCHAR2(25) := 'PURCHASE_GIFT_CERTIFICATE';
-- VARIABLES
var_gift_cert_id   NUMBER;
var_account_id     NUMBER;
var_invoice_amount NUMBER (10,2);
var_new_invoice_id NUMBER;
var_new_charge_id  NUMBER;
var_och_is_gc      NUMBER;
var_offer_chain_status_id NUMBER;
var_is_for_redemption     NUMBER;
var_account_tax_exempt_id VARCHAR2(255);

temp_transaction_id_count NUMBER;
var_transaction_id        NUMBER;
temp_gc_code VARCHAR2(255);

var_invoice_status_id NUMBER;
-- EXCEPTIONS
CAN_NOT_CREATE_INVOICE              EXCEPTION;
CAN_NOT_CREATE_TRANSACTION          EXCEPTION;
CAN_NOT_CREATE_CHARGE               EXCEPTION;
CAN_NOT_CREATE_LINE_ITEMS           EXCEPTION;
BAD_GROUP_ID                        EXCEPTION;
BAD_OFFER_CHAIN_ID                  EXCEPTION;
OCH_IS_NOT_GIFT_CERTIFICATE         EXCEPTION;
TRANSACTION_EXISTS                  EXCEPTION;
GC_CODE_ALREADY_EXISTS              EXCEPTION;
BAD_INSTRUMENT_TYPE                 EXCEPTION;
BAD_CREDIT_CARD_ID                  EXCEPTION;
BAD_PAYPAL_ID                       EXCEPTION;
CAN_NOT_CALCULATE_OCH_AMOUNT        EXCEPTION;
BAD_OFFER_CHAIN_STATUS              EXCEPTION;
OFFER_REC_NUM_LESS_THAN_ONE         EXCEPTION;
CAN_NOT_CALC_INVOICE_AMOUNT         EXCEPTION;
CAN_NOT_USE_FCINSTR                 EXCEPTION;
CAN_NOT_PURCHASE_GC_FOR_RDMPN       EXCEPTION;
EXCEPTION_MESSAGE                   VARCHAR2(1024);
BEGIN

  -- Get account id
  BEGIN
    SELECT
      ACCOUNT.ID,
      ACCOUNT.TAX_EXEMPT_ID
      into
      var_account_id,
      var_account_tax_exempt_id
    FROM
      ACCOUNT
    WHERE
      ACCOUNT.GROUP_ID = in_group_id;
    EXCEPTION
    WHEN NO_DATA_FOUND THEN
      RAISE BAD_GROUP_ID;
  END;
  
  -- Check that instrument exists
  IF in_instrument_type_id = GLOBAL_ENUMS_V18.INSTRUMENT_CREDIT_CARD THEN
    IF IS_CREDIT_CARD_EXISTS(in_instrument_id) = GLOBAL_CONSTANTS_V18.FALSE THEN
      RAISE BAD_CREDIT_CARD_ID;
    END IF;
  ELSIF in_instrument_type_id = GLOBAL_ENUMS_V18.INSTRUMENT_PAYPAL THEN
    IF IS_PAYPAL_EXISTS(in_instrument_id) = GLOBAL_CONSTANTS_V18.FALSE THEN
      RAISE BAD_PAYPAL_ID;
    END IF;
  ELSIF in_instrument_type_id = GLOBAL_ENUMS_V18.INSTRUMENT_ZCI_INSTRUMENT THEN
    NULL;
  ELSE
    RAISE BAD_INSTRUMENT_TYPE;
  END IF;
  
  -- Check for the same code
  BEGIN
    SELECT
      GIFT_CERTIFICATE.CODE into temp_gc_code
    FROM
      GIFT_CERTIFICATE
    WHERE
      GIFT_CERTIFICATE.CODE = in_gift_certificate_code;
      
    RAISE GC_CODE_ALREADY_EXISTS;
    
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        NULL;
  END;
  
  -- Get offer chain flag "is_gift_certificate"
  BEGIN
    SELECT
      OFFER_CHAIN.IS_GIFT_CERTIFICATE,
      OFFER_CHAIN.OFFER_CHAIN_STATUS_ID
      into
      var_och_is_gc,
      var_offer_chain_status_id
    FROM
      OFFER_CHAIN
    WHERE
      OFFER_CHAIN.ID = in_offer_chain_id;
    EXCEPTION
    WHEN NO_DATA_FOUND THEN
      RAISE BAD_OFFER_CHAIN_ID;
  END;

  IF var_och_is_gc != GLOBAL_CONSTANTS_V18.TRUE
    OR var_och_is_gc IS NULL THEN
    RAISE OCH_IS_NOT_GIFT_CERTIFICATE;
  END IF;
  
  IF var_offer_chain_status_id != GLOBAL_STATUSES_V18.OFFER_CHAIN_ACTIVE THEN
    RAISE BAD_OFFER_CHAIN_STATUS;
  END IF;

  -- norlov: #38151 check if the OC is for Redemption:
  SELECT 
    COUNT(*) into var_is_for_redemption
  FROM
    OFFER_CHAIN_ELIGIBILITY 
  WHERE
    OFFER_CHAIN_ELIGIBILITY.OFFER_CHAIN_ID = in_offer_chain_id
    AND OFFER_CHAIN_ELIGIBILITY.NAME = GLOBAL_CONSTANTS_V18.GIFT_CERTIFICATE_REQUIRED
    AND OFFER_CHAIN_ELIGIBILITY.VALUE = GLOBAL_CONSTANTS_V18.ELIGIBILITY_FLAG_SET;
  
  IF var_is_for_redemption > 0 THEN
    RAISE CAN_NOT_PURCHASE_GC_FOR_RDMPN;
  END IF;

  -- Check that transaction with given id do not exists
  SELECT
    COUNT(*) into temp_transaction_id_count
  FROM
    TRANSACTION
  WHERE
    TRANSACTION.ID = in_transaction_id;

  IF temp_transaction_id_count > 0 THEN
    RAISE TRANSACTION_EXISTS;
  END IF;

  -- Create new invoice  
  BEGIN
    PROCS_INVOICE_V18.CREATE_INVOICE(
      in_invoice_status => GLOBAL_STATUSES_V18.INVOICE_OPEN,
      in_created_by     => in_created_by,
      in_tax_exempt_id  => var_account_tax_exempt_id,
      out_invoice_id    => var_new_invoice_id
    );
    EXCEPTION
      WHEN OTHERS THEN
        EXCEPTION_MESSAGE := SQLERRM;
        RAISE CAN_NOT_CREATE_INVOICE;
  END;

  -- Add line items for new invoice
  BEGIN
    FOR f_offer_data IN (
      SELECT
        OFFER_ID,
        NUM_RECURRENCES
      FROM
        OFFER_OFFER_CHAIN
      WHERE
        OFFER_OFFER_CHAIN.OFFER_CHAIN_ID = in_offer_chain_id
    )
    LOOP
      IF f_offer_data.NUM_RECURRENCES < 1 THEN
        RAISE OFFER_REC_NUM_LESS_THAN_ONE;
      END IF;
      FOR i_offer_recurrences_iterator IN 1..f_offer_data.NUM_RECURRENCES
      LOOP
        PROCS_LINE_ITEMS_V18.ADD_LINE_ITEMS(
          in_invoice_id => var_new_invoice_id,
          in_offer_id   => f_offer_data.OFFER_ID,
          in_created_by => in_created_by
        );
      END LOOP;
    END LOOP;
  
    EXCEPTION
      WHEN OTHERS THEN
        EXCEPTION_MESSAGE := SQLERRM;
        RAISE CAN_NOT_CREATE_LINE_ITEMS;
  END;
  
  -- Calculate new invoice amount
  BEGIN
    PROCS_INVOICE_V18.CALCULATE_INVOICE_AMOUNT(var_new_invoice_id, var_invoice_amount);
    EXCEPTION
      WHEN OTHERS THEN
        EXCEPTION_MESSAGE := SQLERRM;
        RAISE CAN_NOT_CALC_INVOICE_AMOUNT;
  END;
  
  IF var_invoice_amount > 0
    AND in_instrument_type_id = GLOBAL_ENUMS_V18.INSTRUMENT_ZCI_INSTRUMENT THEN
    RAISE CAN_NOT_USE_FCINSTR;
  END IF;
  
  -- If invoice amount iz 0 then we need to set status for this invoice to PROCCESSED
  IF var_invoice_amount = 0 THEN
    PROCS_INVOICE_CRU_V18.UPDATE_INVOICE(
      in_invoice_id                  => var_new_invoice_id,
      in_updated_by                  => in_created_by,
      in_invoice_status_id           => GLOBAL_STATUSES_V18.INVOICE_CLOSED
    );
  END IF;

  IF var_invoice_amount > 0 THEN
    -- Create transaction
    BEGIN
      PROCS_TRANSACTION_V18.CREATE_TRANSACTION(
        in_transaction_id  => in_transaction_id,
        in_status_id       => GLOBAL_STATUSES_V18.TRANSACTION_PENDING,
        in_amount          => var_invoice_amount,
        in_created_by      => in_created_by,
        in_order_id        => in_order_id,
        out_transaction_id => var_transaction_id
      );
      EXCEPTION
        WHEN OTHERS THEN
          EXCEPTION_MESSAGE := SQLERRM;
          RAISE CAN_NOT_CREATE_TRANSACTION;
    END;

    -- Create charge
    BEGIN
      PROCS_CHARGE_V18.CREATE_CHARGE(
        in_invoice_id         => var_new_invoice_id,
        in_transaction_id     => var_transaction_id,
        in_instrument_type_id => in_instrument_type_id,
        in_instrument_id      => in_instrument_id,
        in_charge_amount      => var_invoice_amount,
        in_created_by         => in_created_by,
        in_charge_status_id   => GLOBAL_STATUSES_V18.CHARGE_OPENED,
        out_charge_id         => var_new_charge_id
      );
      EXCEPTION
        WHEN OTHERS THEN
          EXCEPTION_MESSAGE := SQLERRM;
          RAISE CAN_NOT_CREATE_CHARGE;
    END;
  END IF;

  -- Create new row in GIFT_CERTIFICATE table
  PROCS_FIN_INSTRUMENTS_CRU_V18.CREATE_GIFT_CERTIFICATE(
    out_gift_certificate_id       => var_gift_cert_id,
    in_purchaser_group_id         => in_group_id,
    in_purchaser_invoice_id       => var_new_invoice_id,
    in_offer_chain_id             => in_offer_chain_id,
    in_expiration_date            => in_expiration_date,
    in_purchase_date              => SYSDATE,
    in_gift_certificate_status_id => GLOBAL_STATUSES_V18.GIFT_CERTIFICATE_ACTIVE,
    in_code                       => in_gift_certificate_code,
    in_created_by                 => in_created_by,
    in_recipient_name             => in_recipient_name,
    in_gift_message               => in_gift_message,
    in_recipient_email            => in_recipient_email,
    in_sender_email               => in_sender_email,
    in_sender_name                => in_sender_name
  );
  
EXCEPTION
WHEN CAN_NOT_USE_FCINSTR THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.STATE_ERROR,
    SPROC_NAME, 'Could not use "free charge instrument" for non-zero invoice');
WHEN BAD_OFFER_CHAIN_STATUS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.STATE_ERROR,
    SPROC_NAME, 'Offer chain is not active');
WHEN CAN_NOT_CALCULATE_OCH_AMOUNT THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.INTERNAL_ERROR,
    SPROC_NAME, 'Could not calculate offer chain amount', EXCEPTION_MESSAGE);
WHEN BAD_CREDIT_CARD_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'Bad credit card id');
WHEN BAD_PAYPAL_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'Bad paypal id');
WHEN BAD_INSTRUMENT_TYPE THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.INVALID_PARAMETER,
    SPROC_NAME, 'Bad instrument type');
WHEN GC_CODE_ALREADY_EXISTS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.DUPLICATE_ERROR,
    SPROC_NAME, 'Gift certificate with same code already exists');
WHEN OCH_IS_NOT_GIFT_CERTIFICATE THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.INVALID_PARAMETER,
    SPROC_NAME, 'This offer chain can not be used for gift certificate');
WHEN CAN_NOT_PURCHASE_GC_FOR_RDMPN THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.INVALID_PARAMETER,
    SPROC_NAME, 'This offer chain can not be purchased for gift certificate since it is for redemption');
WHEN TRANSACTION_EXISTS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.DUPLICATE_ERROR,
    SPROC_NAME, 'Transaction with given id already exists');
WHEN CAN_NOT_CREATE_INVOICE THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.INTERNAL_ERROR,
    SPROC_NAME, 'Could not create new invoice', EXCEPTION_MESSAGE);
WHEN CAN_NOT_CREATE_TRANSACTION THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.INTERNAL_ERROR,
    SPROC_NAME, 'Could not create transaction', EXCEPTION_MESSAGE);
WHEN CAN_NOT_CREATE_CHARGE THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.INTERNAL_ERROR,
    SPROC_NAME, 'Could not create charge', EXCEPTION_MESSAGE);
WHEN CAN_NOT_CREATE_LINE_ITEMS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.INTERNAL_ERROR,
    SPROC_NAME, 'Could not create line items', EXCEPTION_MESSAGE);
WHEN BAD_GROUP_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'No such group id');
WHEN BAD_OFFER_CHAIN_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'No such offer chain');
WHEN OFFER_REC_NUM_LESS_THAN_ONE THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.INTERNAL_ERROR,
    SPROC_NAME, 'Some offer has recurrences number less than 1');
WHEN CAN_NOT_CALC_INVOICE_AMOUNT THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.INTERNAL_ERROR,
    SPROC_NAME, 'COuold not calculate amount for new invoice', EXCEPTION_MESSAGE);
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END PURCHASE_GIFT_CERTIFICATE;

/******************************************************************************/

PROCEDURE REDEEM_GIFT_CERTIFICATE (
  in_group_id                     IN NUMBER,
  in_gift_certificate_code        IN VARCHAR2,
  in_created_by                   IN VARCHAR2,
  in_redeemer_address_id          IN NUMBER,
  in_fin_instrument_id            IN NUMBER,
  in_fin_instrument_type_id       IN NUMBER,
  in_redemption_offer_chain_id    IN NUMBER,
  out_subscription_id             OUT NUMBER,
  out_license_id                  OUT NUMBER
) AS
SPROC_NAME              CONSTANT VARCHAR2(23) := 'REDEEM_GIFT_CERTIFICATE';
-- VARIABLES
var_gift_certificate_id NUMBER;
-- norlov: #38151 var_offer_chain_id replaced by var_purchased_oc_id and var_oc_id_to_redeem
var_purchased_oc_id     NUMBER;
var_oc_id_to_redeem     NUMBER := in_redemption_offer_chain_id;
var_offer_duration      VARCHAR2(30);
var_invoice_id          NUMBER;
var_succ_purch_attempts_num NUMBER;
var_subscription_id     NUMBER;
var_license_id          NUMBER;
var_account_id          NUMBER;
var_gc_status_id        NUMBER;
var_gc_charges_amount   NUMBER;
var_gc_expiration_date  DATE;
var_gc_redeemer_group_id NUMBER;
var_gc_purchase_invoice_id NUMBER;
var_gc_purchase_inv_status_id NUMBER;
var_offer_index               NUMBER;
var_purchaser_group_id        NUMBER;
temp_license_id               NUMBER;
var_same_offer_chains_num     NUMBER;
var_max_concurrent_subscrs    NUMBER;
var_account_tax_exempt_id     VARCHAR2(255);
var_fin_instrument_type_id    NUMBER := in_fin_instrument_type_id;
var_fin_instrument_id         NUMBER := in_fin_instrument_id;
var_first_offer_id         NUMBER;
var_date              DATE := SYSDATE;

var_offers SYS_REFCURSOR;

-- EXCEPTIONS
BAD_GIFT_CERTIFICATE_CODE      EXCEPTION;
BAD_GROUP_ID                   EXCEPTION;
CAN_NOT_CREATE_LICENSE         EXCEPTION;
GIFT_CERT_IS_FINALIZED         EXCEPTION;
GIFT_CERT_IS_REFUNDED          EXCEPTION;
CAN_NOT_UPDATE_CERTIFICATE     EXCEPTION;
GIFT_CERTIFICATE_EXPIRED       EXCEPTION;
GIFT_CERTIFICATE_REDEEMED      EXCEPTION;
USER_ALREADY_SUBSCRIBED_TO_PRD EXCEPTION;
LIMIT_REACHED                  EXCEPTION;
GC_PURCHASE_INVOICE_NOT_CLOSED EXCEPTION;
PURCHASE_INVOICES_NOT_PAID     EXCEPTION;
OC_TO_REDEEM_NOT_FOUND         EXCEPTION;
CAN_NOT_GET_FIRST_OFFER_CHAIN  EXCEPTION;
EXCEPTION_MESSAGE              VARCHAR2(1024);
BEGIN

  -- Get account id
  BEGIN
    SELECT
      ACCOUNT.ID,
      ACCOUNT.TAX_EXEMPT_ID
      into
      var_account_id,
      var_account_tax_exempt_id
    FROM
      ACCOUNT
    WHERE
      ACCOUNT.GROUP_ID = in_group_id
      AND ROWNUM <= 1;
    
    EXCEPTION
    WHEN NO_DATA_FOUND THEN
      RAISE BAD_GROUP_ID;
  END;

  -- Get gift certificate data
  BEGIN
    SELECT
      GIFT_CERTIFICATE.ID,
      GIFT_CERTIFICATE.OFFER_CHAIN_ID,
      GIFT_CERTIFICATE.GIFT_CERTIFICATE_STATUS_ID,
      GIFT_CERTIFICATE.PURCHASER_GROUP_ID,
      GIFT_CERTIFICATE.EXPIRATION_DATE,
      GIFT_CERTIFICATE.REDEEMER_GROUP_ID,
      GIFT_CERTIFICATE.PURCHASE_INVOICE_ID
      into
      var_gift_certificate_id,
      var_purchased_oc_id,
      var_gc_status_id,
      var_purchaser_group_id,
      var_gc_expiration_date,
      var_gc_redeemer_group_id,
      var_gc_purchase_invoice_id
    FROM
      GIFT_CERTIFICATE
    WHERE
      GIFT_CERTIFICATE.CODE = in_gift_certificate_code
      AND ROWNUM <= 1;
    
    EXCEPTION
    WHEN NO_DATA_FOUND THEN
      RAISE BAD_GIFT_CERTIFICATE_CODE;
  END;
  
  -- get redemption oc id from meta data if it wasn't passed in, parsing will fail for gcs with multiple redemption offer chains,
  -- but in that case a redemption offer chain id should always be passed in
  IF var_oc_id_to_redeem IS NULL THEN
    BEGIN
      SELECT
        to_number(OFFER_CHAIN_META_DATA.VALUE)
        into
        var_oc_id_to_redeem
      FROM
        OFFER_CHAIN_META_DATA
      WHERE
        OFFER_CHAIN_META_DATA.OFFER_CHAIN_ID = var_purchased_oc_id
        AND OFFER_CHAIN_META_DATA.NAME = GLOBAL_CONSTANTS_V18.REDEMPTION_OC_ID
        AND ROWNUM = 1;
-- requested by ticket so (but above is correct for the actual migrated data):      
--  SELECT
--      OFFER_CHAIN.ID
--      into
--      var_oc_id_to_redeem
--    FROM
--      OFFER_CHAIN 
--        INNER JOIN ELIGIBILITY ON OFFER_CHAIN.ID = ELIGIBILITY.OFFER_CHAIN_ID
--        INNER JOIN OFFER_CHAIN_META_DATA ON OFFER_CHAIN.ID = OFFER_CHAIN_META_DATA.OFFER_CHAIN_ID
--    WHERE
--      ELIGIBILITY.OFFER_CHAIN_ID = OFFER_CHAIN.ID
--      AND ELIGIBILITY.NAME = GLOBAL_CONSTANTS_V18.GIFT_CERTIFICATE_REQUIRED
--      AND ELIGIBILITY.VALUE = GLOBAL_CONSTANTS_V18.ELIGIBILITY_FLAG_SET
--      AND OFFER_CHAIN_META_DATA.OFFER_CHAIN_ID = OFFER_CHAIN.ID
--      AND OFFER_CHAIN_META_DATA.NAME = GLOBAL_CONSTANTS_V18.REDEMPTION_OC_ID
--      AND to_number(OFFER_CHAIN_META_DATA.VALUE) = var_purchased_oc_id
--      AND ROWNUM = 1;
      
      EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE OC_TO_REDEEM_NOT_FOUND;
    END;
  END IF;
  
  -- Check that purchase invoice for this GC was closed
  SELECT
    INVOICE.INVOICE_STATUS_ID into var_gc_purchase_inv_status_id
  FROM
    INVOICE
  WHERE
    INVOICE.ID = var_gc_purchase_invoice_id;

  IF var_gc_purchase_inv_status_id != GLOBAL_STATUSES_V18.INVOICE_CLOSED THEN
    RAISE GC_PURCHASE_INVOICE_NOT_CLOSED;
  END IF;
  
  -- Check that this invoice was successfully processed by billing
  SELECT
    COUNT(1) into var_succ_purch_attempts_num
  FROM
    TRANSACTION_ATTEMPT TA
    INNER JOIN TRANSACTION T ON T.ID = TA.TRANSACTION_ID
    INNER JOIN CHARGE CH ON CH.TRANSACTION_ID = T.ID
  WHERE
    CH.INVOICE_ID = var_gc_purchase_invoice_id
    AND TA.TRANSACTION_ATTEMPT_STATUS_ID = GLOBAL_STATUSES_V18.TRANS_ATTEMPT_SUCCESS;
  
  IF var_succ_purch_attempts_num = 0 THEN
    SELECT
      COUNT(1) into var_succ_purch_attempts_num
    FROM
      DUAL
    WHERE 
      PROCS_INVOICE_V18.F_CALCULATE_INVOICE_AMOUNT(var_gc_purchase_invoice_id) = 0;
  END IF;

  IF var_succ_purch_attempts_num = 0 THEN
    RAISE PURCHASE_INVOICES_NOT_PAID;
  END IF;
  
  -- Check limit for gc's offer chain
  SELECT
    COUNT(*) into var_same_offer_chains_num
  FROM
    SUBSCRIPTION
  WHERE
    SUBSCRIPTION.ACCOUNT_ID = var_account_id
    AND SUBSCRIPTION.OFFER_CHAIN_ID = var_oc_id_to_redeem
    AND (
      SUBSCRIPTION.SUBSCRIPTION_STATUS_ID = GLOBAL_STATUSES_V18.SUBSCRIPTION_ACTIVE
      OR SUBSCRIPTION.SUBSCRIPTION_STATUS_ID = GLOBAL_STATUSES_V18.SUBSCRIPTION_IN_GRACE_PERIOD);
IF var_same_offer_chains_num = 0 THEN
    -- if user does not have any active existing subscriptions to the offer chain
    -- and if product from the offer chain is already owned from another offer chain
    -- then deny purchase
    FOR f_account_offer_chains IN (
      SELECT DISTINCT
        OFFER_CHAIN_ID
      FROM
        SUBSCRIPTION
      WHERE
        ACCOUNT_ID = var_account_id
        AND (
          SUBSCRIPTION_STATUS_ID = GLOBAL_STATUSES_V18.SUBSCRIPTION_ACTIVE
          OR SUBSCRIPTION_STATUS_ID = GLOBAL_STATUSES_V18.SUBSCRIPTION_SUSPENDED
          OR SUBSCRIPTION_STATUS_ID = GLOBAL_STATUSES_V18.SUBSCRIPTION_IN_GRACE_PERIOD)
    )
    LOOP
      IF PROCS_OFFER_CHAIN_V18.CHECK_FOR_SAME_PRODUCTS(var_oc_id_to_redeem, f_account_offer_chains.OFFER_CHAIN_ID) = GLOBAL_CONSTANTS_V18.TRUE THEN
        RAISE USER_ALREADY_SUBSCRIBED_TO_PRD;
      END IF;
    END LOOP;
  ELSE
  
    -- if user have any active existing subscriptions to the offer chain
    -- and if MAX_CONCURRENT_SUBS <= [user's subscription count for the offer chain]
    -- then deny purchase
    var_max_concurrent_subscrs := PROCS_OFFER_CHAIN_V18.GET_OFFER_CHAIN_MAX_CONC_SUBSC(var_oc_id_to_redeem);
    IF var_max_concurrent_subscrs != GLOBAL_CONSTANTS_V18.INFINITY
      AND var_max_concurrent_subscrs <= var_same_offer_chains_num THEN
      RAISE LIMIT_REACHED;
    END IF;
  END IF;
-- norlov: END OF TODO  

  
  IF var_gc_redeemer_group_id IS NOT NULL THEN
    RAISE GIFT_CERTIFICATE_REDEEMED;
  END IF;
  
  IF var_gc_expiration_date < sysdate THEN
    RAISE GIFT_CERTIFICATE_EXPIRED;
  END IF;
 
   IF var_gc_status_id = GLOBAL_STATUSES_V18.GIFT_CERTIFICATE_REFUNDED THEN
    RAISE GIFT_CERT_IS_REFUNDED;
  END IF;
  
  IF var_gc_status_id = GLOBAL_STATUSES_V18.GIFT_CERTIFICATE_FINALIZED THEN
    RAISE GIFT_CERT_IS_FINALIZED;
  END IF;
  
  -- Check that user did not subscribed to same product already
  -- norlov: get rid of this since there is already the check?
  FOR f_user_offer_chain IN (
    SELECT DISTINCT
      OFFER_CHAIN_ID
    FROM
      SUBSCRIPTION
    WHERE
      ACCOUNT_ID=var_account_id
      AND (
        SUBSCRIPTION_STATUS_ID = GLOBAL_STATUSES_V18.SUBSCRIPTION_ACTIVE
        OR SUBSCRIPTION_STATUS_ID = GLOBAL_STATUSES_V18.SUBSCRIPTION_SUSPENDED
        OR SUBSCRIPTION_STATUS_ID = GLOBAL_STATUSES_V18.SUBSCRIPTION_IN_GRACE_PERIOD)
  )
  LOOP
    IF PROCS_OFFER_CHAIN_V18.CHECK_FOR_SAME_PRODUCTS(var_oc_id_to_redeem, f_user_offer_chain.OFFER_CHAIN_ID)=GLOBAL_CONSTANTS_V18.TRUE THEN
      RAISE USER_ALREADY_SUBSCRIBED_TO_PRD;
    END IF;
  END LOOP;
  
  -- Check for gift certificate amount
  SELECT
    SUM(CHARGE.CHARGE_AMOUNT) into var_gc_charges_amount
  FROM
    CHARGE
  WHERE
    CHARGE.INSTRUMENT_ID = var_gift_certificate_id
    AND CHARGE.INSTRUMENT_TYPE_ID = GLOBAL_ENUMS_V18.INSTRUMENT_GIFT_CERTIFICATE;
  
  -- Create new invoice
  PROCS_INVOICE_V18.CREATE_INVOICE(
    out_invoice_id    => var_invoice_id,
    in_invoice_status => GLOBAL_STATUSES_V18.INVOICE_CLOSED,
    in_tax_exempt_id  => var_account_tax_exempt_id,
    in_created_by     => in_created_by
  );

  -- If a financial instrument wasn't passed in, use the gift certificate id
  -- Real financial instrument is required for upsell/till forbid gift subscriptions
  IF var_fin_instrument_id is null THEN
    var_fin_instrument_id := var_gift_certificate_id;
    var_fin_instrument_type_id := GLOBAL_ENUMS_V18.INSTRUMENT_GIFT_CERTIFICATE;
  END IF;

  -- Insert new row into subscription table
  PROCS_SUBSCRIPTION_CRU_V18.CREATE_SUBSCRIPTION(
    out_subscription_id       => var_subscription_id,
    in_account_id             => var_account_id,
    in_purchase_date          => var_date,
    in_offer_chain_id         => var_oc_id_to_redeem,
    in_created_by             => in_created_by,
    in_instrument_type_id     => var_fin_instrument_type_id,
    in_instrument_id          => var_fin_instrument_id,
    in_subscription_status_id => GLOBAL_STATUSES_V18.SUBSCRIPTION_ACTIVE
  );
  
  out_subscription_id := var_subscription_id;

  BEGIN
    PROCS_OFFER_CHAIN_V18.GET_FIRST_OFFER(var_oc_id_to_redeem, var_first_offer_id);
    EXCEPTION
      WHEN OTHERS THEN
        EXCEPTION_MESSAGE := SQLERRM;
        RAISE CAN_NOT_GET_FIRST_OFFER_CHAIN;
  END;

  BEGIN
    PROCS_LICENSE_V18.CREATE_LICENSE (
      out_license_id              => out_license_id,
      in_status_id                => GLOBAL_STATUSES_V18.LICENSE_ACTIVE,
      in_needs_entitlements       => GLOBAL_CONSTANTS_V18.TRUE,
      in_start_date               => var_date,
      in_offer_id                 => var_first_offer_id,
      in_subscription_id          => var_subscription_id,
      in_invoice_id               => var_invoice_id,
      in_created_by               => in_created_by,
      in_end_date                 => NULL, -- Will be calculated automatically
      in_is_extension             => GLOBAL_CONSTANTS_V18.FALSE,
      in_current_offer_index      => PROCS_OFFER_CHAIN_V18.GET_FIRST_OFFER_INDEX(var_oc_id_to_redeem),
      in_current_offer_recurr_num => 1
    );

    EXCEPTION
      WHEN OTHERS THEN
        EXCEPTION_MESSAGE := SQLERRM;
        RAISE CAN_NOT_CREATE_LICENSE;
  END;
  
  -- Update original gift certificate
  BEGIN
    PROCS_FIN_INSTRUMENTS_CRU_V18.UPDATE_GIFT_CERTIFICATE(
      in_gift_certificate_id        => var_gift_certificate_id,
      in_updated_by                 => in_created_by,
      in_redeemer_group_id          => in_group_id,
      in_finalized_invoice_id       => var_invoice_id,
      in_redemption_date            => var_date,
      in_redeemer_address_id        => in_redeemer_address_id,
      in_gift_certificate_status_id => GLOBAL_STATUSES_V18.GIFT_CERTIFICATE_FINALIZED
    );
    EXCEPTION
      WHEN OTHERS THEN
        EXCEPTION_MESSAGE := SQLERRM;
        RAISE CAN_NOT_UPDATE_CERTIFICATE;
  END;
  
EXCEPTION
WHEN LIMIT_REACHED THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.CONFLICT_ERROR,
    SPROC_NAME, 'Limit reached for given offer chain');
WHEN USER_ALREADY_SUBSCRIBED_TO_PRD THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.CONFLICT_ERROR,
    SPROC_NAME, 'User already subscribed to some product in given gift certificate');
WHEN GIFT_CERTIFICATE_REDEEMED THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.STATE_ERROR,
    SPROC_NAME, 'Gift certificate already redeemed');
WHEN GIFT_CERTIFICATE_EXPIRED THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.INVALID_PARAMETER,
    SPROC_NAME, 'Gift certificate expired');
WHEN GIFT_CERT_IS_FINALIZED THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.STATE_ERROR,
    SPROC_NAME, 'Gift certificate is finalized');
WHEN GIFT_CERT_IS_REFUNDED THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.STATE_ERROR,
    SPROC_NAME, 'Gift certificate has been refunded');    
WHEN BAD_GROUP_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'No such account with given group id');
WHEN OC_TO_REDEEM_NOT_FOUND THEN    
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'Offer chain to redeem not found');
WHEN BAD_GIFT_CERTIFICATE_CODE THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'No such gift certificate code');
WHEN CAN_NOT_CREATE_LICENSE THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.INTERNAL_ERROR,
    SPROC_NAME, 'Could not create new license', EXCEPTION_MESSAGE);
WHEN CAN_NOT_UPDATE_CERTIFICATE THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.INTERNAL_ERROR,
    SPROC_NAME, 'Could not update gift certificate', EXCEPTION_MESSAGE);
WHEN GC_PURCHASE_INVOICE_NOT_CLOSED THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.STATE_ERROR,
    SPROC_NAME, 'Purchase invoice is not closed');
WHEN PURCHASE_INVOICES_NOT_PAID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.STATE_ERROR,
    SPROC_NAME, 'Purchase invoice is not successfully processed by billing');
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END;

/******************************************************************************/

PROCEDURE GET_GIFT_CERTIFICATE_BY_CODE (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND,
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_code        IN VARCHAR,
  out_result_set OUT SYS_REFCURSOR
) AS
-- VARIABLES
SPROC_NAME               CONSTANT VARCHAR2(28) := 'GET_GIFT_CERTIFICATE_BY_CODE';
temp_gift_certificate_id NUMBER;
-- EXCEPTIONS
BAD_GIFT_CERTIFICATE_CODE EXCEPTION;
BEGIN

  BEGIN
    SELECT
      GIFT_CERTIFICATE.ID into temp_gift_certificate_id
    FROM
      GIFT_CERTIFICATE
    WHERE
      GIFT_CERTIFICATE.CODE = in_code;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE BAD_GIFT_CERTIFICATE_CODE;
  END;

  -- Select all gift certificates with given code
  OPEN out_result_set FOR
  SELECT
    gc.EXPIRATION_DATE,
    ch.name,
    ch.id,
    gc.sender_email,
    gc.sender_name,
    gc.recipient_email,
    gc.recipient_name,
    gc.purchase_date,
    gc.redemption_date,
    gc.purchaser_group_id,
    gc.redeemer_group_id,
    gc.gift_message,
    ocmd.value redemption_offer_chain_ids,
    s.offer_chain_id redeemed_offer_chain_id,
    gc.recipient_notify_date,
    gc.gift_certificate_status_id,
    gc.purchase_invoice_id,
    gc.finalized_invoice_id
  FROM
    GIFT_CERTIFICATE gc
  INNER JOIN OFFER_CHAIN ch ON ch.id = gc.offer_chain_id
  INNER JOIN OFFER_CHAIN_META_DATA ocmd ON gc.offer_chain_id = ocmd.offer_chain_id AND ocmd.name = 'redemption offer chain id'
  LEFT JOIN LICENSE l ON l.invoice_id = gc.finalized_invoice_id
  LEFT JOIN SUBSCRIPTION s ON l.subscription_id = s.id
  WHERE
    gc.code = in_code;

EXCEPTION
WHEN BAD_GIFT_CERTIFICATE_CODE THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'No such gift certificate');
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown Error', SQLERRM);
END;

/******************************************************************************/

PROCEDURE GET_GIFT_CERTIFICATE_BY_ID (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND,
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_gift_certificate_id IN NUMBER,
  out_result_set         OUT SYS_REFCURSOR
) AS
-- VARIABLES
SPROC_NAME               CONSTANT VARCHAR2(26) := 'GET_GIFT_CERTIFICATE_BY_ID';
temp_gift_certificate_id NUMBER;
-- EXCEPTIONS
BAD_GIFT_CERTIFICATE_ID EXCEPTION;
BEGIN

  BEGIN
    SELECT
      GIFT_CERTIFICATE.ID into temp_gift_certificate_id
    FROM
      GIFT_CERTIFICATE
    WHERE
      GIFT_CERTIFICATE.ID = in_gift_certificate_id;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE BAD_GIFT_CERTIFICATE_ID;
  END;

  -- Select all gift certificates with given code
  OPEN out_result_set FOR
  SELECT
    gc.EXPIRATION_DATE,
    ch.name,
    ch.id,
    gc.sender_email,
    gc.sender_name,
    gc.recipient_email,
    gc.recipient_name,
    gc.purchase_date,
    gc.redemption_date,
    gc.purchaser_group_id,
    gc.redeemer_group_id,
    gc.code,
    gc.gift_message,
    gc.recipient_notify_date
  FROM
    GIFT_CERTIFICATE gc
  INNER JOIN OFFER_CHAIN ch ON ch.id = gc.offer_chain_id
  WHERE
    gc.id = in_gift_certificate_id;

EXCEPTION
WHEN BAD_GIFT_CERTIFICATE_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'No such gift certificate');
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown Error', SQLERRM);
END GET_GIFT_CERTIFICATE_BY_ID;

/******************************************************************************/

PROCEDURE GET_DEF_FINANCIAL_INSTRUMENT (
  in_group_id            IN  NUMBER,
  out_instrument_type_id OUT NUMBER,
  out_instrument_id      OUT NUMBER
) AS
SPROC_NAME CONSTANT VARCHAR2(28) := 'GET_DEF_FINANCIAL_INSTRUMENT';
BEGIN
  
  SELECT
    ACCOUNT.INSTRUMENT_TYPE_ID,
    ACCOUNT.INSTRUMENT_ID
    into
    out_instrument_type_id,
    out_instrument_id
  FROM
    ACCOUNT
  WHERE
    ACCOUNT.GROUP_ID = in_group_id;
    
EXCEPTION
WHEN NO_DATA_FOUND THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'Bad group id');
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END GET_DEF_FINANCIAL_INSTRUMENT;

/******************************************************************************/

PROCEDURE SET_DEF_FINANCIAL_INSTRUMENT (
  in_group_id           IN NUMBER,
  in_instrument_type_id IN NUMBER,
  in_instrument_id      IN NUMBER,
  in_updated_by         IN VARCHAR2
) AS
-- VARIABLES
SPROC_NAME             CONSTANT VARCHAR2(28) := 'SET_DEF_FINANCIAL_INSTRUMENT';
var_account_id         NUMBER;
-- EXCEPTIONS
BAD_GROUP_ID           EXCEPTION;
BAD_CREDIT_CARD        EXCEPTION;
BAD_PAYPAL             EXCEPTION;
BAD_INSTRUMENT_TYPE    EXCEPTION;
EXCEPTION_MESSAGE      VARCHAR2(1024);
BEGIN

  -- get account id
  BEGIN
    SELECT
      ACCOUNT.ID into var_account_id
    FROM
      ACCOUNT
    WHERE
      ACCOUNT.GROUP_ID = in_group_id;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE BAD_GROUP_ID;
  END;

  -- Chech that given instrument exists  
  IF in_instrument_type_id = GLOBAL_ENUMS_V18.INSTRUMENT_CREDIT_CARD THEN
    IF IS_CREDIT_CARD_EXISTS(in_instrument_id) = GLOBAL_CONSTANTS_V18.FALSE THEN
      RAISE BAD_CREDIT_CARD;
    END IF;
  ELSIF in_instrument_type_id = GLOBAL_ENUMS_V18.INSTRUMENT_PAYPAL THEN
    IF IS_PAYPAL_EXISTS(in_instrument_id) = GLOBAL_CONSTANTS_V18.FALSE THEN
      RAISE BAD_PAYPAL;
    END IF;
  ELSE
    RAISE BAD_INSTRUMENT_TYPE;
  END IF;
  
  -- update account information
  PROCS_ACCOUNT_CRU_V18.UPDATE_ACCOUNT(
    in_account_id         => var_account_id,
    in_updated_by         => in_updated_by,
    in_instrument_type_id => in_instrument_type_id,
    in_instrument_id      => in_instrument_id
  );
  
EXCEPTION
WHEN BAD_GROUP_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'No such account');
WHEN BAD_CREDIT_CARD THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'Could not find credit card with given ID');
WHEN BAD_PAYPAL THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'Could not find paypal with given ID');
WHEN BAD_INSTRUMENT_TYPE THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.INVALID_PARAMETER,
    SPROC_NAME, 'Bad instrument type id');
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END SET_DEF_FINANCIAL_INSTRUMENT;

/******************************************************************************/

PROCEDURE DEL_DEF_FINANCIAL_INSTRUMENT (
  in_group_id IN NUMBER
) AS
SPROC_NAME CONSTANT VARCHAR2(28) := 'DEL_DEF_FINANCIAL_INSTRUMENT';
-- VARIABLES
var_account_id NUMBER;
-- EXCEPTIONS
BAD_GROUP_ID      EXCEPTION;
EXCEPTION_MESSAGE VARCHAR2(1024);
BEGIN

  BEGIN
    SELECT
      ACCOUNT.ID into var_account_id
    FROM
      ACCOUNT
    WHERE
      ACCOUNT.GROUP_ID = in_group_id;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE BAD_GROUP_ID;
  END;

  PROCS_ACCOUNT_CRU_V18.UPDATE_DEF_FIN_INSTRUMENT(
    in_account_id => var_account_id,
    in_instrument_type_id => NULL,
    in_instrument_id => NULL,
    in_updated_by => 'in_updated_by' -- TODO: add in_updated_by field
  );

EXCEPTION
WHEN BAD_GROUP_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'No such group id');
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END DEL_DEF_FINANCIAL_INSTRUMENT;

/******************************************************************************/

PROCEDURE GET_CREDIT_CARD_BY_ID (
  in_credit_card_id IN  NUMBER,
  out_result_set    OUT SYS_REFCURSOR
) AS
-- VARIABLES
SPROC_NAME    CONSTANT VARCHAR2(21) := 'GET_CREDIT_CARD_BY_ID';
temp_cc_count NUMBER;

-- EXCEPTIONS
BAD_CREDIT_CARD_ID EXCEPTION;
BEGIN

  -- Check that credit card exists  
  SELECT
    COUNT(*) into temp_cc_count
  FROM
    CREDIT_CARD
  WHERE
    CREDIT_CARD.ID = in_credit_card_id;
  IF temp_cc_count = 0 THEN
    RAISE BAD_CREDIT_CARD_ID;
  END IF;
  
  -- Get data
  OPEN out_result_set FOR
  SELECT
    CREDIT_CARD.ID,
    CREDIT_CARD.ACCOUNT_ID,
    CREDIT_CARD.INSTRUMENT_NAME,
    CREDIT_CARD.PRIVATE_CARD_HOLDER_NAME,
    CREDIT_CARD.PRIVATE_STREET_ADDRESS,
    CREDIT_CARD.PRIVATE_STREET_ADDRESS2,
    CREDIT_CARD.STATE,
    CREDIT_CARD.CITY,
    CREDIT_CARD.POSTAL_CODE,
    CREDIT_CARD.COUNTRY,
    CREDIT_CARD.LAST_FOUR_CC,
    CREDIT_CARD.EXPIRATION_DATE,
    CREDIT_CARD.CREDIT_CARD_TYPE_ID,
    CREDIT_CARD.SECRET_TOKEN,
    CREDIT_CARD.CREATE_DATE,
    CREDIT_CARD.CREATED_BY,
    CREDIT_CARD.UPDATE_DATE,
    CREDIT_CARD.UPDATED_BY,
    CREDIT_CARD.CREDIT_CARD_STATUS_ID,
    CREDIT_CARD.PRIVATE_FIRST_NAME,
    CREDIT_CARD.PRIVATE_LAST_NAME,
	CREDIT_CARD.CHASE_PROFILE_ID
  FROM
    CREDIT_CARD
  WHERE
    CREDIT_CARD.ID = in_credit_card_id;

EXCEPTION
WHEN BAD_CREDIT_CARD_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'No such credit card');
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END GET_CREDIT_CARD_BY_ID;

/******************************************************************************/

PROCEDURE GET_PAYPAL_BY_ID (
  in_paypal_id   IN  NUMBER,
  out_result_set OUT SYS_REFCURSOR
) AS
SPROC_NAME CONSTANT VARCHAR2(16) := 'GET_PAYPAL_BY_ID';
-- VARIABLES
temp_pp_count NUMBER;
-- EXCEPTIONS
BAD_PAYPAL_ID EXCEPTION;
BEGIN
  
  -- Check that credit card exists  
  SELECT
    COUNT(*) into temp_pp_count
  FROM
    PAYPAL
  WHERE
    PAYPAL.ID = in_paypal_id;
  IF temp_pp_count = 0 THEN
    RAISE BAD_PAYPAL_ID;
  END IF;

  OPEN out_result_set FOR
  SELECT
    ID,
    ACCOUNT_ID,
    INSTRUMENT_NAME,
    PRIVATE_EMAIL_ADDRESS,
    CREATE_DATE,
    CREATED_BY,
    UPDATE_DATE,
    UPDATED_BY,
    PAYPAL_STATUS_ID,
    PRIVATE_STREET_ADDRESS,
    PRIVATE_STREET_ADDRESS2,
    STATE,
    CITY,
    POSTAL_CODE,
    COUNTRY,
    EXPIRATION_DATE,
    SECRET_TOKEN
  FROM
    PAYPAL
  WHERE
    ID = in_paypal_id;

EXCEPTION
WHEN BAD_PAYPAL_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'No such paypal');
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END GET_PAYPAL_BY_ID;

/******************************************************************************/

FUNCTION F_CAN_DISABLE_CREDIT_CARD (
/*
  Returns GLOBAL_CONSTANTS_V18.TRUE if system can disable credit card
  GLOBAL_CONSTANTS_V18.FALSE else
*/
  in_credit_card_id NUMBER
) RETURN NUMBER AS
BEGIN
  -- STUB
  RETURN GLOBAL_CONSTANTS_V18.TRUE;
END F_CAN_DISABLE_CREDIT_CARD;

/******************************************************************************/

PROCEDURE GET_PURCHASED_GCERTIFICATES (
  in_group_id    IN NUMBER,
  out_result_set OUT SYS_REFCURSOR
) AS
-- VARIABLES
SPROC_NAME     CONSTANT VARCHAR2(27) := 'GET_PURCHASED_GCERTIFICATES';
var_account_id NUMBER;
-- EXCEPTIONS
BAD_GROUP_ID EXCEPTION;
BEGIN
  
  BEGIN
    SELECT
      ACCOUNT.ID into var_account_id
    FROM
      ACCOUNT
    WHERE
      ACCOUNT.GROUP_ID = in_group_id;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE BAD_GROUP_ID;
  END;
  
  OPEN out_result_set FOR
  SELECT
    GIFT_CERTIFICATE.CODE,
    GIFT_CERTIFICATE.EXPIRATION_DATE,
    OFFER_CHAIN.NAME AS "OFFER_CHAIN_NAME",
    OFFER_CHAIN.ID AS "OFFER_CHAIN_ID",
    GIFT_CERTIFICATE.SENDER_EMAIL,
    GIFT_CERTIFICATE.SENDER_NAME,
    GIFT_CERTIFICATE.RECIPIENT_EMAIL,
    GIFT_CERTIFICATE.RECIPIENT_NAME,
    GIFT_CERTIFICATE.PURCHASE_DATE,
    GIFT_CERTIFICATE.REDEMPTION_DATE,
    GIFT_CERTIFICATE.REDEEMER_GROUP_ID
  FROM
    GIFT_CERTIFICATE
    INNER JOIN OFFER_CHAIN ON GIFT_CERTIFICATE.OFFER_CHAIN_ID = OFFER_CHAIN.ID
  WHERE
    ROWNUM <= 100 AND
    GIFT_CERTIFICATE.PURCHASER_GROUP_ID = in_group_id;
    
EXCEPTION
WHEN BAD_GROUP_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'No such group id');
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END GET_PURCHASED_GCERTIFICATES;

/******************************************************************************/

PROCEDURE IS_GCERT_FOR_PROPER_OFFER (
  in_gift_certificate_id IN NUMBER,
  in_charge_id           IN NUMBER,
  out_result             OUT NUMBER
) AS
-- VARIABLES
SPROC_NAME           CONSTANT VARCHAR2(25) := 'IS_GCERT_FOR_PROPER_OFFER';
var_invoice_id       NUMBER;
var_offer_chain_id   NUMBER;
var_offer_chain_s_id NUMBER;
-- EXCEPTIONS
BAD_CHARGE_ID             EXCEPTION;
BAD_GIFT_CERTIFICATE_ID   EXCEPTION;
CAN_NOT_FIND_SUBSCRIPTION EXCEPTION;
BEGIN
  
  BEGIN
    SELECT
      CHARGE.INVOICE_ID into var_invoice_id
    FROM
      CHARGE
    WHERE
      CHARGE.ID = in_charge_id;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE BAD_CHARGE_ID;
  END;
  
  BEGIN
    SELECT
      GIFT_CERTIFICATE.OFFER_CHAIN_ID into var_offer_chain_id
    FROM
      GIFT_CERTIFICATE
    WHERE
      GIFT_CERTIFICATE.ID = in_gift_certificate_id;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE BAD_GIFT_CERTIFICATE_ID;
  END;
  
  BEGIN
    SELECT
      SUBSCRIPTION.OFFER_CHAIN_ID into var_offer_chain_s_id
    FROM
      SUBSCRIPTION
    WHERE
      SUBSCRIPTION.ID IN (
        SELECT DISTINCT
          LICENSE.SUBSCRIPTION_ID
        FROM
          LICENSE
        WHERE
          LICENSE.INVOICE_ID = var_invoice_id
      );
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE CAN_NOT_FIND_SUBSCRIPTION;
  END;

  IF var_offer_chain_s_id = var_offer_chain_id THEN
    out_result := GLOBAL_CONSTANTS_V18.TRUE;
  ELSE
    out_result := GLOBAL_CONSTANTS_V18.FALSE;
  END IF;

EXCEPTION
WHEN BAD_CHARGE_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'No such charge');
WHEN BAD_GIFT_CERTIFICATE_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'No such gift certificate');
WHEN CAN_NOT_FIND_SUBSCRIPTION THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'Could not find subscription for given charge');
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END IS_GCERT_FOR_PROPER_OFFER;

/******************************************************************************/

FUNCTION IS_CREDIT_CARD_EXISTS (
/*
GLOBAL_CONSTANTS_V18.TRUE - if instrument exists
GLOBAL_CONSTANTS_V18.FALSE - else
*/
  in_credit_card_id IN NUMBER
) RETURN NUMBER AS
-- VARIABLES
var_cc_count NUMBER;
BEGIN
  SELECT
    COUNT(*) into var_cc_count
  FROM
    CREDIT_CARD
  WHERE
    CREDIT_CARD.ID = in_credit_card_id;
  
  IF var_cc_count = 0 THEN
    RETURN GLOBAL_CONSTANTS_V18.FALSE;
  ELSE
    RETURN GLOBAL_CONSTANTS_V18.TRUE;
  END IF;
  
END IS_CREDIT_CARD_EXISTS;

/******************************************************************************/

FUNCTION IS_PAYPAL_EXISTS (
/*
GLOBAL_CONSTANTS_V18.TRUE - if instrument exists
GLOBAL_CONSTANTS_V18.FALSE - else
*/
  in_paypal_id IN NUMBER
) RETURN NUMBER AS
-- VARIABLES
var_pp_count NUMBER;
BEGIN
  SELECT
    COUNT(*) into var_pp_count
  FROM
    PAYPAL
  WHERE
    PAYPAL.ID = in_paypal_id;
  
  IF var_pp_count = 0 THEN
    RETURN GLOBAL_CONSTANTS_V18.FALSE;
  ELSE
    RETURN GLOBAL_CONSTANTS_V18.TRUE;
  END IF;
  
END IS_PAYPAL_EXISTS;

/******************************************************************************/

FUNCTION IS_GIFT_CERTIFICATE_EXISTS (
/*
GLOBAL_CONSTANTS_V18.TRUE - if instrument exists
GLOBAL_CONSTANTS_V18.FALSE - else
*/
  in_gift_certificate_id IN NUMBER
) RETURN NUMBER AS
-- VARIABLES
var_gc_count NUMBER;
BEGIN
  SELECT
    COUNT(*) into var_gc_count
  FROM
    GIFT_CERTIFICATE
  WHERE
    GIFT_CERTIFICATE.ID = in_gift_certificate_id;
  
  IF var_gc_count = 0 THEN
    RETURN GLOBAL_CONSTANTS_V18.FALSE;
  ELSE
    RETURN GLOBAL_CONSTANTS_V18.TRUE;
  END IF;
  
END IS_GIFT_CERTIFICATE_EXISTS;

/******************************************************************************/

PROCEDURE GET_GROUP_ID_BY_CREDIT_CARD_ID (
  in_credit_card_id IN NUMBER,
  out_group_id      OUT NUMBER
) AS
SPROC_NAME CONSTANT VARCHAR2(30) := 'GET_GROUP_ID_BY_CREDIT_CARD_ID';
BEGIN
  SELECT
    ACCOUNT.GROUP_ID into out_group_id
  FROM
    CREDIT_CARD
    INNER JOIN ACCOUNT ON CREDIT_CARD.ACCOUNT_ID = ACCOUNT.ID
  WHERE
    CREDIT_CARD.ID = in_credit_card_id;
EXCEPTION
WHEN NO_DATA_FOUND THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'No such credit card');
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END GET_GROUP_ID_BY_CREDIT_CARD_ID;

/******************************************************************************/

PROCEDURE GET_GROUP_ID_BY_PAYPAL_ID (
  in_paypal_id IN NUMBER,
  out_group_id OUT NUMBER
) AS
SPROC_NAME CONSTANT VARCHAR2(32) := 'GET_GROUP_ID_BY_PAYPAL_ID';
BEGIN
  SELECT
    ACCOUNT.GROUP_ID into out_group_id
  FROM
    PAYPAL
    INNER JOIN ACCOUNT ON PAYPAL.ACCOUNT_ID = ACCOUNT.ID
  WHERE
    PAYPAL.ID = in_paypal_id;
EXCEPTION
WHEN NO_DATA_FOUND THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'No such paypal');
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END GET_GROUP_ID_BY_PAYPAL_ID;

/******************************************************************************/

PROCEDURE UPDATE_CREDIT_CARD_STATUS (
  in_credit_card_id        IN CREDIT_CARD.ID%TYPE,
  in_credit_card_status_id IN CREDIT_CARD.CREDIT_CARD_STATUS_ID%TYPE,
  in_updated_by            IN CREDIT_CARD.UPDATED_BY%TYPE
) AS
SPROC_NAME CONSTANT VARCHAR2(25) := 'UPDATE_CREDIT_CARD_STATUS';
-- EXCEPTIONS
BAD_CREDIT_CARD_ID     EXCEPTION;
BAD_STATUS_ID          EXCEPTION;
EXCEPTION_MESSAGE      VARCHAR2(1024);
BEGIN
  
  IF in_credit_card_status_id != GLOBAL_STATUSES_V18.CREDIT_CARD_ACTIVE
    AND in_credit_card_status_id != GLOBAL_STATUSES_V18.CREDIT_CARD_INVALID
    AND in_credit_card_status_id != GLOBAL_STATUSES_V18.CREDIT_CARD_DISABLED
    AND in_credit_card_status_id != GLOBAL_STATUSES_V18.CREDIT_CARD_EXPIRED THEN
    RAISE BAD_STATUS_ID;
  END IF;
  
  PROCS_FIN_INSTRUMENTS_CRU_V18.UPDATE_CREDIT_CARD(
    in_credit_card_id        => in_credit_card_id,
    in_updated_by            => in_updated_by,
    in_credit_card_status_id => in_credit_card_status_id
  );
  
  IF SQL%ROWCOUNT = 0 THEN
    RAISE BAD_CREDIT_CARD_ID;
  END IF;
  
EXCEPTION
WHEN BAD_CREDIT_CARD_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'No such credit card');
WHEN BAD_STATUS_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.INVALID_PARAMETER,
    SPROC_NAME, 'Bad credit card status id');
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END UPDATE_CREDIT_CARD_STATUS;

/******************************************************************************/

PROCEDURE UPDATE_PAYPAL_STATUS (
  in_paypal_id        IN PAYPAL.ID%TYPE,
  in_paypal_status_id IN PAYPAL.PAYPAL_STATUS_ID%TYPE,
  in_updated_by       IN PAYPAL.UPDATED_BY%TYPE
) AS
SPROC_NAME CONSTANT VARCHAR2(20) := 'UPDATE_PAYPAL_STATUS';
-- EXCEPTIONS
BAD_PAYPAL_ID          EXCEPTION;
BAD_STATUS_ID          EXCEPTION;
EXCEPTION_MESSAGE      VARCHAR2(1024);
BEGIN

  IF in_paypal_status_id != GLOBAL_STATUSES_V18.PAYPAL_ACTIVE
    AND in_paypal_status_id != GLOBAL_STATUSES_V18.PAYPAL_INACTIVE
    AND in_paypal_status_id != GLOBAL_STATUSES_V18.PAYPAL_FROZEN THEN
    RAISE BAD_STATUS_ID;
  END IF;
  
  PROCS_FIN_INSTRUMENTS_CRU_V18.UPDATE_PAYPAL(
    in_paypal_id        => in_paypal_id,
    in_paypal_status_id => in_paypal_status_id,
    in_updated_by       => in_updated_by
  );
  
  IF SQL%ROWCOUNT = 0 THEN
    RAISE BAD_PAYPAL_ID;
  END IF;
  
EXCEPTION
WHEN BAD_PAYPAL_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'No such paypal');
WHEN BAD_STATUS_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.INVALID_PARAMETER,
    SPROC_NAME, 'Bad paypal status id');
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END UPDATE_PAYPAL_STATUS;

/******************************************************************************/

PROCEDURE UPDATE_GIFT_CERTIFICATE_STATUS (
  in_gift_certificate_id        IN GIFT_CERTIFICATE.ID%TYPE,
  in_gift_certificate_status_id IN GIFT_CERTIFICATE.GIFT_CERTIFICATE_STATUS_ID%TYPE,
  in_updated_by                 IN GIFT_CERTIFICATE.UPDATED_BY%TYPE
) AS
SPROC_NAME CONSTANT VARCHAR2(30) := 'UPDATE_GIFT_CERTIFICATE_STATUS';
-- EXCEPTIONS
BAD_GIFT_CERTIFICATE_ID EXCEPTION;
BAD_STATUS_ID           EXCEPTION;
EXCEPTION_MESSAGE       VARCHAR2(1024);
BEGIN
  
  IF in_gift_certificate_status_id != GLOBAL_STATUSES_V18.GIFT_CERTIFICATE_ACTIVE
    AND in_gift_certificate_status_id != GLOBAL_STATUSES_V18.GIFT_CERTIFICATE_FINALIZED THEN
    RAISE BAD_STATUS_ID;
  END IF;
  
  PROCS_FIN_INSTRUMENTS_CRU_V18.UPDATE_GIFT_CERTIFICATE(
    in_gift_certificate_id        => in_gift_certificate_id,
    in_gift_certificate_status_id => in_gift_certificate_status_id,
    in_updated_by                 => in_updated_by
  );
  
  IF SQL%ROWCOUNT = 0 THEN
    RAISE BAD_GIFT_CERTIFICATE_ID;
  END IF;
  
EXCEPTION
WHEN BAD_GIFT_CERTIFICATE_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'No such gift certificate');
WHEN BAD_STATUS_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.INVALID_PARAMETER,
    SPROC_NAME, 'Bad paypal status id');
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END UPDATE_GIFT_CERTIFICATE_STATUS;

/******************************************************************************/

PROCEDURE GET_GC_BY_PURCH_INVOICE_ID (
  in_invoice_id           IN GIFT_CERTIFICATE.PURCHASE_INVOICE_ID%TYPE,
  out_result_set OUT SYS_REFCURSOR
) AS
SPROC_NAME CONSTANT VARCHAR2(32) := 'GET_GC_BY_PURCHASE_INVOICE_ID';
-- VARIABLES
temp_invoice_id NUMBER;
-- EXCEPTIONS
BAD_INVOICE_ID EXCEPTION;
BEGIN

  BEGIN
    SELECT
      I.ID into temp_invoice_id
    FROM
      INVOICE I
    WHERE
      I.ID = in_invoice_id;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE BAD_INVOICE_ID;
  END;

  OPEN out_result_set FOR
    SELECT
      gc.EXPIRATION_DATE,
      ch.name,
      ch.id offer_chain_id,
      gc.sender_email,
      gc.sender_name,
      gc.recipient_email,
      gc.recipient_name,
      gc.purchase_date,
      gc.redemption_date,
      gc.purchaser_group_id,
      gc.redeemer_group_id,
      gc.code,
      gc.gift_message,
      gc.recipient_notify_date,
      gc.id
    FROM
      GIFT_CERTIFICATE gc
      INNER JOIN OFFER_CHAIN ch ON ch.id = gc.offer_chain_id
    WHERE
      gc.PURCHASE_INVOICE_ID = in_invoice_id;

EXCEPTION
WHEN BAD_INVOICE_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'No such invoice');
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END GET_GC_BY_PURCH_INVOICE_ID;


PROCEDURE GET_GC_ID_BY_PURCH_INVOICE_ID (
  in_invoice_id           IN GIFT_CERTIFICATE.PURCHASE_INVOICE_ID%TYPE,
  out_gift_certificate_id OUT GIFT_CERTIFICATE.ID%TYPE
) AS
SPROC_NAME CONSTANT VARCHAR2(32) := 'GET_GC_ID_BY_PURCHASE_INVOICE_ID';
-- VARIABLES
temp_invoice_id NUMBER;
-- EXCEPTIONS
BAD_INVOICE_ID EXCEPTION;
BEGIN

  BEGIN
    SELECT
      I.ID into temp_invoice_id
    FROM
      INVOICE I
    WHERE
      I.ID = in_invoice_id;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE BAD_INVOICE_ID;
  END;

  BEGIN
    SELECT
      GIFT_CERTIFICATE.ID into out_gift_certificate_id
    FROM
      GIFT_CERTIFICATE
    WHERE
      GIFT_CERTIFICATE.PURCHASE_INVOICE_ID = in_invoice_id;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        out_gift_certificate_id := NULL;
  END;

EXCEPTION
WHEN BAD_INVOICE_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'No such invoice');
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END GET_GC_ID_BY_PURCH_INVOICE_ID;

/******************************************************************************/

PROCEDURE SWITCH_FINANCIAL_INSTRUMENT (
  in_old_fin_instrument_id   IN NUMBER,
  in_old_fin_instrument_type IN NUMBER,
  in_new_fin_instrument_id   IN NUMBER,
  in_new_fin_instrument_type IN NUMBER,
  in_updated_by              IN VARCHAR2
) AS
SPROC_NAME CONSTANT VARCHAR2(27) := 'SWITCH_FINANCIAL_INSTRUMENT';
-- variables
temp_out_transaction_id NUMBER;
temp_out_charge_id      NUMBER;
var_accounts_count      NUMBER;
var_transaction_type_old  "TRANSACTION".TRANSACTION_TYPE_CODE%TYPE;
var_transaction_type      "TRANSACTION".TRANSACTION_TYPE_CODE%TYPE;
-- EXCEPTIONS
BAD_OLD_CC   EXCEPTION;
BAD_OLD_PP   EXCEPTION;
BAD_OLD_TYPE EXCEPTION;
BAD_NEW_CC   EXCEPTION;
BAD_NEW_PP   EXCEPTION;
BAD_NEW_TYPE EXCEPTION;
DIFFERENT_OWNERS EXCEPTION;
BEGIN

  IF in_old_fin_instrument_type = GLOBAL_ENUMS_V18.INSTRUMENT_CREDIT_CARD THEN
    IF PROCS_FIN_INSTRUMENTS_V18.IS_CREDIT_CARD_EXISTS(in_old_fin_instrument_id) = GLOBAL_CONSTANTS_V18.FALSE THEN
      -- throw exception: bad old credit card
      RAISE BAD_OLD_CC;
    END IF;
  ELSIF in_old_fin_instrument_type = GLOBAL_ENUMS_V18.INSTRUMENT_PAYPAL THEN
    IF PROCS_FIN_INSTRUMENTS_V18.IS_PAYPAL_EXISTS(in_old_fin_instrument_id) = GLOBAL_CONSTANTS_V18.FALSE THEN
      -- throw exception: bad old paypal
      RAISE BAD_OLD_PP;
    END IF;
  ELSE
    -- throw exception: bad instrument type
    RAISE BAD_OLD_TYPE;
  END IF;

  IF in_new_fin_instrument_type = GLOBAL_ENUMS_V18.INSTRUMENT_CREDIT_CARD THEN
    IF PROCS_FIN_INSTRUMENTS_V18.IS_CREDIT_CARD_EXISTS(in_new_fin_instrument_id) = GLOBAL_CONSTANTS_V18.FALSE THEN
      -- throw exception: bad new credit card
      RAISE BAD_NEW_CC;
    END IF;
  ELSIF in_new_fin_instrument_type = GLOBAL_ENUMS_V18.INSTRUMENT_PAYPAL THEN
    IF PROCS_FIN_INSTRUMENTS_V18.IS_PAYPAL_EXISTS(in_new_fin_instrument_id) = GLOBAL_CONSTANTS_V18.FALSE THEN
      -- throw exception: bad new paypal
      RAISE BAD_NEW_PP;
    END IF;
  ELSE
    -- throw exception: bad new instrument type
    RAISE BAD_NEW_TYPE;
  END IF;
  
  -- Check that owner of both instruments - same man
  
  SELECT count(1) into var_accounts_count FROM (
    SELECT
      CC.ACCOUNT_ID
    FROM
      CREDIT_CARD CC
    WHERE
      (
        CC.ID = in_old_fin_instrument_id
        AND in_old_fin_instrument_type = GLOBAL_ENUMS_V18.INSTRUMENT_CREDIT_CARD
      )
      OR
      (
        CC.ID = in_new_fin_instrument_id
        AND in_new_fin_instrument_type = GLOBAL_ENUMS_V18.INSTRUMENT_CREDIT_CARD
      )
    UNION
    SELECT
      PP.ACCOUNT_ID
    FROM
      PAYPAL PP
    WHERE
      (
        PP.ID = in_old_fin_instrument_id
        AND in_old_fin_instrument_type = GLOBAL_ENUMS_V18.INSTRUMENT_PAYPAL
      )
      OR
      (
        PP.ID = in_new_fin_instrument_id
        AND in_new_fin_instrument_type = GLOBAL_ENUMS_V18.INSTRUMENT_PAYPAL
      )
  )
  WHERE
    account_id IS NOT NULL;
  
  IF (var_accounts_count > 1) THEN
    -- Throw exception: different owners of instruments
    RAISE DIFFERENT_OWNERS;
  END IF;
  
  FOR f_sub IN (
    select
      s.id
    FROM
      subscription s
    WHERE
      (
        s.subscription_status_id = GLOBAL_STATUSES_V18.SUBSCRIPTION_ACTIVE OR
        s.subscription_status_id = GLOBAL_STATUSES_V18.SUBSCRIPTION_SUSPENDED OR
        s.subscription_status_id = GLOBAL_STATUSES_V18.SUBSCRIPTION_IN_GRACE_PERIOD
      )
      AND
      s.instrument_type_id = in_old_fin_instrument_type AND
      s.instrument_id = in_old_fin_instrument_id
  ) LOOP
    PROCS_SUBSCRIPTION_CRU_V18.UPDATE_SUBSCRIPTION(
      in_subscription_id => f_sub.id,
      in_instrument_type_id => in_new_fin_instrument_type,
      in_instrument_id => in_new_fin_instrument_id,
      in_updated_by => in_updated_by
    );
  END LOOP;
  
  FOR f_open_charge IN (
    select
      ch.id,
      ch.invoice_id,
      ch.transaction_id,
      ch.charge_amount
    FROM
      charge ch
    WHERE
      ch.instrument_type_id = in_old_fin_instrument_type
      AND ch.instrument_id = in_old_fin_instrument_id
      AND ch.charge_status_id = GLOBAL_STATUSES_V18.CHARGE_OPENED
  ) LOOP

    FOR f_pending_transaction IN (
      select
        id, transaction_amount, order_id, is_refund
      from
        transaction
      where
        id = f_open_charge.transaction_id
        and transaction_status_id = GLOBAL_STATUSES_V18.TRANSACTION_PENDING
    ) LOOP

      SELECT
        DECODE(TRANSACTION_TYPE_CODE, 'RECURRING_BILLING', 'RECURRING_BILLING_USER_UPDATE',
                                      'GRACE_PERIOD_FINAL', 'GRACE_PERIOD_USER_UPDATE',
                                      TRANSACTION_TYPE_CODE)
      INTO var_transaction_type
      FROM
        Transaction
      WHERE
        id = f_pending_transaction.id
        AND ROWNUM <= 1;

      PROCS_TRANSACTION_V18.CREATE_TRANSACTION (
        in_transaction_id => NULL,
        in_status_id  => GLOBAL_STATUSES_V18.TRANSACTION_PENDING,
        in_amount     => f_pending_transaction.transaction_amount,
        in_created_by => in_updated_by,
        in_order_id   => null,
        in_is_refund  => f_pending_transaction.is_refund,
        in_transaction_type_code => var_transaction_type,
        out_transaction_id => temp_out_transaction_id
      );

      PROCS_TRANSACTION_V18.UPDATE_TRANSACTION_STATUS(
        in_transaction_id => f_pending_transaction.id,
        in_updated_by     => in_updated_by,
        in_transaction_status_id  => GLOBAL_STATUSES_V18.TRANSACTION_CLOSED
      );
      
      -- Create new charge
      PROCS_CHARGE_V18.CREATE_CHARGE (
        in_invoice_id         => f_open_charge.invoice_id,
        in_transaction_id     => temp_out_transaction_id,
        in_instrument_type_id => in_new_fin_instrument_type,
        in_instrument_id      => in_new_fin_instrument_id,
        in_charge_amount      => f_open_charge.charge_amount,
        in_created_by         => in_updated_by,
        in_charge_status_id   => GLOBAL_STATUSES_V18.CHARGE_OPENED,
        out_charge_id         => temp_out_charge_id
      );
      -- Cancel old charge
      PROCS_CHARGE_V18.UPDATE_CHARGE_STATUS(
        in_charge_id        => f_open_charge.id,
        in_updated_by       => in_updated_by,
        in_charge_status_id => GLOBAL_STATUSES_V18.CHARGE_CANCELED
      );

      PROCS_ADJUSTMENTS_V18.UPDATE_INVOICE_ADJUSTMENT(
        IN_INVOICE_ID => f_open_charge.invoice_id,
        IN_ORIGINAL_CHARGE_ID => f_open_charge.id,
        IN_CHARGE_ID => temp_out_charge_id,
        IN_UPDATED_BY => in_updated_by
      );
        
    END LOOP;
  END LOOP;

EXCEPTION
WHEN BAD_OLD_CC THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'Trying to switch from non existing credit card');
WHEN BAD_OLD_PP THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'Trying to switch from non existing paypal');
WHEN BAD_OLD_TYPE THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'Trying to switch from unknown/unsupported financial instrument');
WHEN BAD_NEW_CC THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'Trying to switch to non existing credit card');
WHEN BAD_NEW_PP THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'Trying to switch to non existing paypal');
WHEN BAD_NEW_TYPE THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'Trying to switch to unknown/unsupported financial instrument');
WHEN DIFFERENT_OWNERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.INVALID_PARAMETER,
    SPROC_NAME, 'Could not switch instrument, because owners are different');
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END SWITCH_FINANCIAL_INSTRUMENT;

END PROCS_FIN_INSTRUMENTS_V18;
.
/

CREATE OR REPLACE PACKAGE BODY "PROCS_GROUP_ACCOUNT_V18" AS

PROCEDURE UPDATE_SS_NEED_ENTITLEMENTS (
  in_sub_share_id      IN SUBSCRIPTION_SHARE.ID%TYPE,
  in_need_entitlements IN SUBSCRIPTION_SHARE.NEEDS_ENTITLEMENTS%TYPE,
  in_updater           IN SUBSCRIPTION_SHARE.UPDATED_BY%TYPE
) AS
SPROC_NAME CONSTANT VARCHAR2(32) := 'UPDATE_SS_NEED_ENTITLEMENTS';
BEGIN
  CORE_OWNER.PROCS_GROUP_ACCOUNT_CRU_V18.UPDATE_SUBSCRIPTION_SHARE (
    in_id                 => in_sub_share_id,
    in_needs_entitlements => in_need_entitlements,
    in_updated_by         => in_updater
  );
END UPDATE_SS_NEED_ENTITLEMENTS;

PROCEDURE SUB_EXPIRES_NEED_ENTITLEMENTS (
  out_result_set OUT SYS_REFCURSOR
) AS
SPROC_NAME CONSTANT VARCHAR2(32) := 'SUB_EXPIRES_NEED_ENTITLEMENTS';
BEGIN
  OPEN out_result_set FOR
  SELECT * FROM (
    SELECT DISTINCT
      ga.Subscription_Id,
      A.Group_Id Borrower_Group_Id,
      L.Offer_Id,
      ss.id Subscription_Share_id
    FROM
      Subscription_Share Ss,
      Group_Account Ga,
      Account A,
      License l
    WHERE
      Ss.Group_Account_Id        = ga.id
      AND Ss.Needs_Entitlements  = GLOBAL_CONSTANTS_V18.TRUE
      AND Ss.Borrower_Account_Id = A.Id
      AND L.Subscription_Id      = Ga.Subscription_Id
      AND ROWNUM <= 5000
    ORDER BY dbms_random.value
) WHERE
  ROWNUM <= 1000;
END SUB_EXPIRES_NEED_ENTITLEMENTS;

PROCEDURE EXPIRE_SUB_SHARE(
  in_sub_share_id IN SUBSCRIPTION_SHARE.ID%TYPE,
  in_updater      IN SUBSCRIPTION_SHARE.UPDATED_BY%TYPE
) AS
SPROC_NAME CONSTANT VARCHAR2(32) := 'EXPIRE_SUB_SHARE';
BEGIN
  CORE_OWNER.PROCS_GROUP_ACCOUNT_CRU_V18.UPDATE_SUBSCRIPTION_SHARE (
    in_id         => in_sub_share_id,
    in_end_date   => SYSDATE,
    in_updated_by => in_updater,
    in_needs_entitlements => 1
  );
END EXPIRE_SUB_SHARE; 

PROCEDURE EXPIRE_ALL_SHARES (
  in_group_account_id IN SUBSCRIPTION_SHARE.GROUP_ACCOUNT_ID%TYPE,
  in_updated_by       IN SUBSCRIPTION_SHARE.UPDATED_BY%TYPE
) AS
SPROC_NAME CONSTANT VARCHAR2(28) := 'EXPIRE_ALL_SHARES';
BEGIN
  UPDATE SUBSCRIPTION_SHARE SET
    END_DATE = SYSDATE,
    UPDATED_BY = in_updated_by,
    UPDATE_DATE = SYSDATE
  WHERE
    GROUP_ACCOUNT_ID = in_group_account_id
  AND
    SYSDATE < END_DATE;
EXCEPTION
  WHEN OTHERS THEN
    PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
        SPROC_NAME, 'Unknown error while expiring subscription shares', SQLERRM);
END EXPIRE_ALL_SHARES;

PROCEDURE SUB_SHARE_BY_GROUP_ID (
  in_group_id      IN  ACCOUNT.GROUP_ID%TYPE,
  in_start         IN  NUMBER,
  in_end           IN  NUMBER,
  in_expired       IN  NUMBER,
  out_result_set   OUT SYS_REFCURSOR,
  out_shares_count OUT NUMBER  
) AS
SPROC_NAME CONSTANT VARCHAR2(32) := 'SUB_SHARE_BY_GROUP_ID';
range_diff NUMBER := 0;
upper_bond_diff NUMBER := 0;
l_start NUMBER := 0;
l_end   NUMBER := 0;
BEGIN
  --Normalize the end points [START]
  IF (in_start IS NULL OR in_start < 0) Then
    l_start := 0;
  ELSE
    l_start := in_start;
  END IF;

  IF (in_end IS NULL) Then
    l_end := 11;
  ELSE
    l_end := in_end;
  END IF;

  l_start := l_start + 1;
  l_end   := l_end   + 1;
  
  range_diff := l_end - l_start;
  upper_bond_diff :=  range_diff - GLOBAL_CONSTANTS_V18.MAX_RETURN_COUNT;
   
  IF (upper_bond_diff > 0) Then
    l_end := l_end - upper_bond_diff;
  END IF;
  --Normalize the end points [END]
  
  BEGIN
    SELECT 
      COUNT(1) INTO out_shares_count
    FROM
      GROUP_ACCOUNT ga,
      SUBSCRIPTION_SHARE ss,
      ACCOUNT a
    WHERE
      a.GROUP_ID          = in_group_id AND
      a.Id                = ss.borrower_account_id And 
      ss.GROUP_ACCOUNT_ID = ga.ID;
  END;

  IF in_expired > 0 THEN
  BEGIN
      OPEN out_result_set FOR
      SELECT 
        *
      FROM
        (SELECT rownum rnum, q.* 
         FROM  
          (SELECT
             ga.SUBSCRIPTION_ID,
             ss.START_DATE,
             ss.END_DATE,
             a2.GROUP_ID AS PARENT_GROUP_ID
           FROM
             GROUP_ACCOUNT ga,
             SUBSCRIPTION_SHARE ss,
             ACCOUNT a,
             SUBSCRIPTION s,
             ACCOUNT a2
           WHERE
             a.GROUP_ID          = in_group_id AND
             a.ID                = ss.BORROWER_ACCOUNT_ID AND 
             ss.GROUP_ACCOUNT_ID = ga.ID  AND
             ga.SUBSCRIPTION_ID  = s.ID AND 
             s.ACCOUNT_ID        = a2.ID
          ) Q
        WHERE rownum <= l_end)
      WHERE rnum >= l_Start;
  END;
  ELSE
  BEGIN
      OPEN out_result_set FOR
      SELECT 
        *
      FROM
        (SELECT rownum rnum, q.* 
         FROM  
          (SELECT
             ga.SUBSCRIPTION_ID,
             ss.START_DATE,
             ss.END_DATE,
             a2.GROUP_ID AS PARENT_GROUP_ID
           FROM
             GROUP_ACCOUNT ga,
             SUBSCRIPTION_SHARE ss,
             ACCOUNT a,
             SUBSCRIPTION s,
             ACCOUNT a2
           WHERE
             a.GROUP_ID          = in_group_id AND
             a.ID                = ss.BORROWER_ACCOUNT_ID AND 
             SYSDATE BETWEEN START_DATE AND END_DATE AND
             ss.GROUP_ACCOUNT_ID = ga.ID AND
             ga.SUBSCRIPTION_ID  = s.ID  AND 
             s.ACCOUNT_ID        = a2.ID
          ) Q 
        WHERE rownum <= l_end) 
      WHERE rnum >= l_start;
    END;  
  END IF;
EXCEPTION
WHEN NO_DATA_FOUND THEN
  NULL;
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknow error while retrieving subscription share info by group id', SQLERRM);
END SUB_SHARE_BY_GROUP_ID;

PROCEDURE IS_VALID_IP_ADDRESS (
  in_group_account_id IN GROUP_ACCOUNT_IP_RANGE.GROUP_ACCOUNT_ID%TYPE,
  in_ip_low IN GROUP_ACCOUNT_IP_RANGE.MINIMUM_IP_LOW%TYPE,
  in_ip_high IN GROUP_ACCOUNT_IP_RANGE.MINIMUM_IP_HIGH%TYPE,
  out_is_valid        OUT NUMBER
) AS
SPROC_NAME CONSTANT VARCHAR2(32) := 'IS_VALID_IP_ADDRESS';
BEGIN
  SELECT 
    COUNT(1) INTO out_is_valid
  FROM
    GROUP_ACCOUNT_IP_RANGE,
    GROUP_ACCOUNT,
    SUBSCRIPTION,
    OFFER_CHAIN
  WHERE
    GROUP_ACCOUNT.ID = GROUP_ACCOUNT_ID AND
    GROUP_ACCOUNT.SUBSCRIPTION_ID = SUBSCRIPTION.ID AND
    SUBSCRIPTION.OFFER_CHAIN_ID = OFFER_CHAIN.ID AND
    OFFER_CHAIN.GROUP_ACCOUNT_TYPE_ID = 'GL' AND
   GROUP_ACCOUNT_ID = in_group_account_id AND
   (
    (in_ip_high > minimum_ip_high and in_ip_high < maximum_ip_high) or
    (in_ip_high = minimum_ip_high and (in_ip_low >= minimum_ip_low and in_ip_low <= maximum_ip_low)) or
    (in_ip_high = maximum_ip_high and (in_ip_low >= minimum_ip_low and in_ip_low <= maximum_ip_low))
   ) AND
   GROUP_ACC_IP_RNG_STATUS_ID = GLOBAL_STATUSES_V18.GROUP_ACC_IP_RNG_ACTIVE;
EXCEPTION
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Error while checking IP', SQLERRM);
END IS_VALID_IP_ADDRESS;

PROCEDURE IS_VALID_EMAIL_DOMAIN (
  in_group_account_id IN GROUP_ACCOUNT_EMAIL_DOMAIN.GROUP_ACCOUNT_ID%TYPE,
  in_email_domain     IN GROUP_ACCOUNT_EMAIL_DOMAIN.EMAIL_DOMAIN%TYPE,
  out_is_valid        OUT NUMBER
) AS
SPROC_NAME CONSTANT VARCHAR2(32) := 'IS_VALID_EMAIL_DOMAIN';
var_second_level_domain GROUP_ACCOUNT_EMAIL_DOMAIN.EMAIL_DOMAIN%TYPE;
var_third_level_domain GROUP_ACCOUNT_EMAIL_DOMAIN.EMAIL_DOMAIN%TYPE;
BEGIN
  var_second_level_domain := REGEXP_REPLACE(in_email_domain, '.*?([^\.]+\.[^\.]+)$', '\1');
  var_third_level_domain := REGEXP_REPLACE(in_email_domain, '.*?(([^\.]+\.){2}[^\.]+)$', '\1');

  SELECT
    COUNT(1) INTO out_is_valid
  FROM
    GROUP_ACCOUNT_EMAIL_DOMAIN gaed,
    GROUP_ACCOUNT ga,
    SUBSCRIPTION s,
    OFFER_CHAIN oc
  WHERE
    ga.ID = gaed.GROUP_ACCOUNT_ID AND
    ga.SUBSCRIPTION_ID = s.ID AND
    s.OFFER_CHAIN_ID = oc.ID AND
    oc.GROUP_ACCOUNT_TYPE_ID IN ('GL', 'KL') AND
    gaed.GROUP_ACCOUNT_ID = in_group_account_id AND
    (gaed.EMAIL_DOMAIN = var_third_level_domain OR gaed.EMAIL_DOMAIN = var_second_level_domain) AND
    gaed.IS_ACTIVE = 1;
EXCEPTION
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Error while checking email domain', SQLERRM);
END IS_VALID_EMAIL_DOMAIN;

PROCEDURE GET_SUBSCRIPTION_SHARE (
  in_group_account_id    IN SUBSCRIPTION_SHARE.GROUP_ACCOUNT_ID%TYPE,
  In_Borrower_Account_Id In SUBSCRIPTION_SHARE.BORROWER_ACCOUNT_ID%Type,
  out_Result_Set         OUT Sys_Refcursor
) AS
SPROC_NAME CONSTANT VARCHAR2(32) := 'GET_SUBSCRIPTION_SHARE';
BEGIN
  BEGIN
     OPEN out_result_set FOR
     SELECT
        ss.ID,
        ss.GROUP_ACCOUNT_ID,
        ss.BORROWER_ACCOUNT_ID,
        ss.IP_ADDRESS,
        ss.START_DATE,
        ss.END_DATE,
        ss.CREATED_BY,
        ss.CREATE_DATE,
        ss.UPDATED_BY,
        ss.UPDATE_DATE,
        a.GROUP_ID AS BORROWER_GROUP_ID
     FROM 
       SUBSCRIPTION_SHARE ss,
       ACCOUNT a
     WHERE
       ss.GROUP_ACCOUNT_ID    = in_group_account_id AND
       ss.BORROWER_ACCOUNT_ID = in_borrower_account_id AND
       SYSDATE BETWEEN ss.START_DATE AND END_DATE AND
       ss.BORROWER_ACCOUNT_ID  = a.ID;
  END;
EXCEPTION
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    Sproc_Name, 'Error while getting subscription share', Sqlerrm);
END GET_SUBSCRIPTION_SHARE;

PROCEDURE GET_GROUP_ACCOUNT_BY_SUB_ID (
  in_subscription_id IN Group_Account.SUBSCRIPTION_ID%TYPE,
  out_result_set     OUT SYS_REFCURSOR
) As
SPROC_NAME CONSTANT VARCHAR2(32) := 'GET_GROUP_ACCOUNT_BY_SUB_ID';
BEGIN
OPEN out_result_set FOR
  SELECT
    ID,
    SUBSCRIPTION_ID,
    GROUP_NAME,
    FIRST_NAME,
    LAST_NAME,
    EMAIL,
    PHONE,
    ORGANIZATION_TYPE,
    SEATS,
    SEAT_TTL_IN_HOURS,
    CREATE_DATE,
    CREATED_BY,
    UPDATE_DATE,
    UPDATED_BY
  FROM
    GROUP_ACCOUNT
  Where
    Subscription_Id = in_subscription_id;
EXCEPTION
WHEN OTHERS THEN
  Procs_Common_V18.Throw_Exception(APP_EXCEPTION_CODES_V18.Unknown_Error,
    SPROC_NAME, 'Unknown error', SQLERRM);

END GET_GROUP_ACCOUNT_BY_SUB_ID;

PROCEDURE CREATE_GROUP_ACCOUNT (
  in_subscription_id       IN NUMBER,
  in_group_name            IN VARCHAR2,
  in_first_name            IN VARCHAR2,
  in_last_name             IN VARCHAR2,
  in_email                 IN VARCHAR2,
  in_phone                 IN VARCHAR2,
  in_organization_type     IN VARCHAR2,
  in_seats                 IN NUMBER,
  in_seat_ttl_in_hours     IN NUMBER,
  in_ip                    IN NUMBER,
  in_created_by            IN VARCHAR2
) AS
SPROC_NAME CONSTANT VARCHAR2(32) := 'CREATE_GROUP_ACCOUNT';
BEGIN

  CORE_OWNER.PROCS_GROUP_ACCOUNT_CRU_V18.CREATE_GROUP_ACCOUNT(
    in_subscription_id => in_subscription_id,
    in_group_name => in_group_name,
    in_first_name => in_first_name,
    in_last_name => in_last_name,
    in_email => in_email,
    in_phone => in_phone,
    in_organization_type => in_organization_type,
    in_seats => in_seats,
    in_seat_ttl_in_hours => in_seat_ttl_in_hours,
    in_ip => in_ip,
    in_created_by => in_created_by
  );

END CREATE_GROUP_ACCOUNT;

PROCEDURE GET_SUBSCRIPTION_SHARES (
  in_group_account_id IN NUMBER,
  in_start            IN NUMBER,
  in_end              IN NUMBER,
  out_Result_Set      OUT Sys_Refcursor
) AS 
SPROC_NAME CONSTANT VARCHAR2(32) := 'GET_SUBSCRIPTION_SHARES';
range_diff NUMBER := 0;
upper_bond_diff NUMBER := 0;
l_start NUMBER := 0;
l_end   NUMBER := 0;
BEGIN
  -- Normalize the end points [START]
  IF (in_start IS NULL OR in_start < 0) Then
    l_start := 0;
  ELSE
    l_start := in_start;
  END IF;

  IF (in_end IS NULL) Then
    l_end := 11;
  ELSE
    l_end := in_end;
  END IF;

  l_start := l_start + 1;
  l_end   := l_end   + 1;
  
  range_diff := l_end - l_start;
  upper_bond_diff :=  range_diff - GLOBAL_CONSTANTS_V18.MAX_RETURN_COUNT;
   
  IF (upper_bond_diff > 0) Then
    l_end := l_end - upper_bond_diff;
  END IF;
  -- Normalize the end points [END]

  BEGIN
     OPEN out_result_set FOR
     SELECT *
     FROM
       (SELECT rownum rnum, Q.*
        FROM
         (SELECT 
            ss.ID,
            ss.GROUP_ACCOUNT_ID,
            ss.BORROWER_ACCOUNT_ID,
            ss.IP_ADDRESS,
            ss.START_DATE,
            ss.END_DATE,
            ss.CREATED_BY,
            ss.CREATE_DATE,
            ss.UPDATED_BY,
            ss.UPDATE_DATE,
            a.GROUP_ID AS BORROWER_GROUP_ID
          FROM 
            SUBSCRIPTION_SHARE ss,
            ACCOUNT a,
            LICENSE l,
            GROUP_ACCOUNT ga
          WHERE
            ss.GROUP_ACCOUNT_ID = in_group_account_id AND
            ss.GROUP_ACCOUNT_ID = ga.ID AND
            GA.SUBSCRIPTION_ID = l.SUBSCRIPTION_ID AND
            SYSDATE BETWEEN l.START_DATE AND l.ENTITLEMENT_END_DATE AND
            SYSDATE BETWEEN ss.START_DATE AND ss.END_DATE AND
            ss.BORROWER_ACCOUNT_ID  = a.ID
        ) Q 
      WHERE rownum <= l_end) 
    WHERE rnum >= l_start;
  END;
EXCEPTION
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error while retrieving subscription shares', SQLERRM);
END GET_SUBSCRIPTION_SHARES; 

PROCEDURE GET_GROUP_ACCOUNT_BY_IP (
  in_ip_low           IN GROUP_ACCOUNT_IP_RANGE.MINIMUM_IP_LOW%TYPE,
  in_ip_high          IN GROUP_ACCOUNT_IP_RANGE.MINIMUM_IP_HIGH%TYPE,
  out_result_set        OUT SYS_REFCURSOR
) AS
SPROC_NAME CONSTANT VARCHAR2(32) := 'GET_GROUP_ACCOUNT_BY_IP';
BEGIN
  BEGIN
    OPEN out_result_set FOR
    SELECT
      ID,
      SUBSCRIPTION_ID,
      GROUP_NAME,
      FIRST_NAME,
      LAST_NAME,
      EMAIL,
      PHONE,    
      ORGANIZATION_TYPE,
      SEATS,
      SEAT_TTL_IN_HOURS,
      CREATE_DATE,
      CREATED_BY,
      UPDATE_DATE,
      UPDATED_BY
    FROM
      GROUP_ACCOUNT
    WHERE
      ID IN (
        SELECT
          GROUP_ACCOUNT_ID
        FROM
          GROUP_ACCOUNT_IP_RANGE,
          GROUP_ACCOUNT,
          SUBSCRIPTION,
          OFFER_CHAIN
        WHERE
          GROUP_ACCOUNT.ID = GROUP_ACCOUNT_ID
        AND
          GROUP_ACCOUNT.SUBSCRIPTION_ID = SUBSCRIPTION.ID AND
          SUBSCRIPTION.OFFER_CHAIN_ID = OFFER_CHAIN.ID AND
          OFFER_CHAIN.GROUP_ACCOUNT_TYPE_ID = 'GL'
        AND
          (
            (in_ip_high > minimum_ip_high and in_ip_high < maximum_ip_high) or
            (in_ip_high = minimum_ip_high and (in_ip_low >= minimum_ip_low and in_ip_low <= maximum_ip_low)) or
            (in_ip_high = maximum_ip_high and (in_ip_low >= minimum_ip_low and in_ip_low <= maximum_ip_low))
          )
        AND
          GROUP_ACC_IP_RNG_STATUS_ID = GLOBAL_STATUSES_V18.GROUP_ACC_IP_RNG_ACTIVE
      );
    END;
EXCEPTION
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END GET_GROUP_ACCOUNT_BY_IP;

PROCEDURE GET_GROUP_ACCOUNT_BY_EMAIL (
  in_email_domain     IN GROUP_ACCOUNT_EMAIL_DOMAIN.EMAIL_DOMAIN%TYPE,
  out_result_set      OUT SYS_REFCURSOR
) AS
SPROC_NAME CONSTANT VARCHAR2(32) := 'GET_GROUP_ACCOUNT_BY_EMAIL';
var_second_level_domain GROUP_ACCOUNT_EMAIL_DOMAIN.EMAIL_DOMAIN%TYPE;
var_third_level_domain GROUP_ACCOUNT_EMAIL_DOMAIN.EMAIL_DOMAIN%TYPE;
BEGIN
  var_second_level_domain := REGEXP_REPLACE(in_email_domain, '.*?([^\.]+\.[^\.]+)$', '\1');
  var_third_level_domain := REGEXP_REPLACE(in_email_domain, '.*?(([^\.]+\.){2}[^\.]+)$', '\1');
  BEGIN
    OPEN out_result_set FOR
    SELECT
      ID,
      SUBSCRIPTION_ID,
      GROUP_NAME,
      FIRST_NAME,
      LAST_NAME,
      EMAIL,
      PHONE,
      ORGANIZATION_TYPE,
      SEATS,
      SEAT_TTL_IN_HOURS,
      CREATE_DATE,
      CREATED_BY,
      UPDATE_DATE,
      UPDATED_BY
    FROM
      GROUP_ACCOUNT
    WHERE
      ID IN (
        SELECT
          GROUP_ACCOUNT_ID
        FROM
          GROUP_ACCOUNT_EMAIL_DOMAIN gaed,
          GROUP_ACCOUNT ga,
          SUBSCRIPTION s,
          OFFER_CHAIN oc
        WHERE
          ga.ID = gaed.GROUP_ACCOUNT_ID AND
          ga.SUBSCRIPTION_ID = s.ID AND
          s.OFFER_CHAIN_ID = oc.ID AND
          oc.GROUP_ACCOUNT_TYPE_ID in ('GL', 'KL') AND
          (gaed.EMAIL_DOMAIN = var_third_level_domain OR gaed.EMAIL_DOMAIN = var_second_level_domain) AND
          gaed.IS_ACTIVE = 1
      );
    END;
EXCEPTION
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END GET_GROUP_ACCOUNT_BY_EMAIL;

PROCEDURE GET_GROUP_ACCOUNT_IP_RANGES (
  in_group_account_id   IN NUMBER,
  in_start              IN NUMBER,
  in_end                IN NUMBER,
  in_status             IN NUMBER,
  out_record_count      OUT NUMBER,
  out_result_set        OUT SYS_REFCURSOR
) AS
SPROC_NAME CONSTANT VARCHAR2(32) := 'GET_GROUP_ACCOUNT_IP_RANGES';
range_diff NUMBER := 0;
upper_bond_diff NUMBER := 0;
l_start NUMBER := 0;
l_end   NUMBER := 0;
BEGIN
  --Normalize the end points [START]
  IF (in_start IS NULL OR in_start < 0) Then
    l_start := 0;
  ELSE
    l_start := in_start;
  END IF;

  IF (in_end IS NULL) Then
    l_end := 11;
  ELSE
    l_end := in_end;
  END IF;

  l_start := l_start + 1;
  l_end   := l_end   + 1;
  
  range_diff := l_end - l_start;
  upper_bond_diff :=  range_diff - GLOBAL_CONSTANTS_V18.MAX_RETURN_COUNT;
   
  IF (upper_bond_diff > 0) Then
    l_end := l_end - upper_bond_diff;
  END IF; 
  --Normalize the end points [END]
  
  --Total count of records [START]
  SELECT 
    COUNT(1) INTO out_record_count
  FROM
    GROUP_ACCOUNT_IP_RANGE
  WHERE
    GROUP_ACCOUNT_ID = in_group_account_id AND
    (in_status IS NULL OR GROUP_ACC_IP_RNG_STATUS_ID = in_status);
  --Total count of records [END]

  OPEN out_result_set FOR
  SELECT 
    *
  FROM
    (SELECT rownum rnum, q.* 
     FROM  
      (SELECT
         ID,
         GROUP_ACCOUNT_ID,
         MINIMUM_IP_STRING,
         MAXIMUM_IP_STRING,
         GROUP_ACC_IP_RNG_STATUS_ID
       FROM
         GROUP_ACCOUNT_IP_RANGE
       WHERE
         GROUP_ACCOUNT_ID = in_group_account_id AND
         (in_status IS NULL OR 
          GROUP_ACC_IP_RNG_STATUS_ID = in_status)
      ) Q
    WHERE rownum <= l_end)
  WHERE rnum >= l_Start;
EXCEPTION
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error while retrieving IP ranges ', SQLERRM);
END GET_GROUP_ACCOUNT_IP_RANGES;

PROCEDURE GET_GRP_ACCNT_EMAIL_DOMAINS (
  in_group_account_id   IN GROUP_ACCOUNT_EMAIL_DOMAIN.GROUP_ACCOUNT_ID%TYPE, 
  in_start              IN NUMBER,
  in_end                IN NUMBER,
  in_status             IN GROUP_ACCOUNT_EMAIL_DOMAIN.IS_ACTIVE%TYPE,
  out_record_count      OUT NUMBER,
  out_result_set        OUT SYS_REFCURSOR
) AS
SPROC_NAME CONSTANT VARCHAR2(32) := 'GET_GRP_ACCNT_EMAIL_DOMAINS';
range_diff NUMBER := 0;
upper_bond_diff NUMBER := 0;
l_start NUMBER := 0;
l_end   NUMBER := 0;
BEGIN
  --Normalize the end points [START]
  IF (in_start IS NULL OR in_start < 0) Then
    l_start := 0;
  ELSE
    l_start := in_start;
  END IF;

  IF (in_end IS NULL) Then
    l_end := 11;
  ELSE
    l_end := in_end;
  END IF;

  l_start := l_start + 1;
  l_end   := l_end   + 1;
  
  range_diff := l_end - l_start;
  upper_bond_diff :=  range_diff - GLOBAL_CONSTANTS_V18.MAX_RETURN_COUNT;
   
  IF (upper_bond_diff > 0) Then
    l_end := l_end - upper_bond_diff;
  END IF; 
  --Normalize the end points [END]
  
  --Total count of records [START]
  SELECT 
    COUNT(1) INTO out_record_count
  FROM
    GROUP_ACCOUNT_EMAIL_DOMAIN
  WHERE
    GROUP_ACCOUNT_ID = in_group_account_id AND
    (IS_ACTIVE IS NULL OR IS_ACTIVE = in_status);
  --Total count of records [END]

  OPEN out_result_set FOR
  SELECT 
    *
  FROM
    (SELECT rownum rnum, q.* 
     FROM  
      (SELECT
        ID,
        GROUP_ACCOUNT_ID,
        EMAIL_DOMAIN,
        IS_ACTIVE
       FROM
         GROUP_ACCOUNT_EMAIL_DOMAIN
       WHERE
         GROUP_ACCOUNT_ID = in_group_account_id AND
         (in_status IS NULL OR 
          IS_ACTIVE = in_status)
      ) Q
    WHERE rownum <= l_end)
  WHERE rnum >= l_Start;

EXCEPTION
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error while retrieving Email Domains ', SQLERRM);
END GET_GRP_ACCNT_EMAIL_DOMAINS;

PROCEDURE DISABLE_EMAIL_DOMAIN_BY_GA_ID (
  in_group_account_id IN GROUP_ACCOUNT_EMAIL_DOMAIN.GROUP_ACCOUNT_ID%TYPE,
  in_updated_by IN GROUP_ACCOUNT_EMAIL_DOMAIN.UPDATED_BY%TYPE
) AS
SPROC_NAME CONSTANT VARCHAR2(32) := 'DISABLE_EMAIL_DOMAIN_BY_GA_ID';
BEGIN
    PROCS_GROUP_ACCOUNT_CRU_V18.DISABLE_EMAIL_DOMAIN_BY_GA_ID(
      in_group_account_id => in_group_account_id,
      in_updated_by => in_updated_by
    );
EXCEPTION
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END DISABLE_EMAIL_DOMAIN_BY_GA_ID;

PROCEDURE DISABLE_EMAIL_DOMAIN_BY_ID (
  in_id IN GROUP_ACCOUNT_EMAIL_DOMAIN.ID%TYPE,
  in_updated_by IN GROUP_ACCOUNT_EMAIL_DOMAIN.UPDATED_BY%TYPE
) AS
SPROC_NAME CONSTANT VARCHAR2(32) := 'DISABLE_EMAIL_DOMAIN_BY_ID';
BEGIN
    PROCS_GROUP_ACCOUNT_CRU_V18.DISABLE_EMAIL_DOMAIN_BY_ID(
      in_id => in_id,
      in_updated_by => in_updated_by
    );
EXCEPTION
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END DISABLE_EMAIL_DOMAIN_BY_ID;

PROCEDURE ADD_EMAIL_DOMAIN (
  in_group_account_id IN GROUP_ACCOUNT_EMAIL_DOMAIN.GROUP_ACCOUNT_ID%TYPE,
  in_email_domain IN GROUP_ACCOUNT_EMAIL_DOMAIN.EMAIL_DOMAIN%TYPE,	
  in_created_by IN GROUP_ACCOUNT_EMAIL_DOMAIN.CREATED_BY%TYPE
) AS
SPROC_NAME CONSTANT VARCHAR2(32) := 'ADD_EMAIL_DOMAIN';
var_ga_type OFFER_CHAIN.GROUP_ACCOUNT_TYPE_ID%TYPE;
var_is_dupe NUMBER(1);
var_group_account_count NUMBER := 0;
var_id  GROUP_ACCOUNT_EMAIL_DOMAIN.ID%TYPE;
NOT_GL EXCEPTION;
DUPE EXCEPTION;
BEGIN
    SELECT OFFER_CHAIN.GROUP_ACCOUNT_TYPE_ID into var_ga_type
    FROM
      GROUP_ACCOUNT,
      SUBSCRIPTION,
      OFFER_CHAIN
    WHERE
      GROUP_ACCOUNT.ID = in_group_account_id AND
      GROUP_ACCOUNT.SUBSCRIPTION_ID = SUBSCRIPTION.ID AND
      SUBSCRIPTION.OFFER_CHAIN_ID = OFFER_CHAIN.ID
    ;
    IF(var_ga_type != 'GL' and var_ga_type != 'KL' ) THEN
      RAISE NOT_GL;
    END IF;
    
    --check if email domain already exists 
    SELECT count(1) into var_group_account_count
    FROM
        GROUP_ACCOUNT_EMAIL_DOMAIN
    WHERE
        GROUP_ACCOUNT_ID= in_group_account_id AND
        EMAIL_DOMAIN = in_email_domain 
    ;
        
    IF(var_group_account_count > 0) THEN
        SELECT ID into var_id
        FROM
            GROUP_ACCOUNT_EMAIL_DOMAIN
        WHERE
            GROUP_ACCOUNT_ID= in_group_account_id AND
            EMAIL_DOMAIN = in_email_domain AND
            rownum <= 1;
        PROCS_GROUP_ACCOUNT_CRU_V18.ENABLE_EMAIL_DOMAIN_BY_ID(
            in_id => var_id,
            in_updated_by => in_created_by
            );
    ELSE
        PROCS_GROUP_ACCOUNT_CRU_V18.ADD_EMAIL_DOMAIN(
            in_group_account_id => in_group_account_id,
            in_email_domain => in_email_domain,
	        in_is_active => GLOBAL_STATUSES_V18.GROUP_ACC_EMAIL_DOMAIN_ACT,
            in_created_by => in_created_by
        );
    END IF; 

EXCEPTION
WHEN NOT_GL THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.INVALID_PARAMETER,
    SPROC_NAME, 'Group account type does not support Email Domains', SQLERRM);
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END ADD_EMAIL_DOMAIN;

PROCEDURE CREATE_SUBSCRIPTION_SHARE (
  in_group_account_id    IN NUMBER,
  in_borrower_account_id IN NUMBER,
  in_ip_address          IN VARCHAR2,
  in_email_domain        IN VARCHAR2,
  in_created_by          IN VARCHAR2
) AS
SPROC_NAME CONSTANT VARCHAR2(32) := 'CREATE_SUBSCRIPTION_SHARE';
ga_ttl_in_hours NUMBER := NULL;
start_date DATE := NULL;
end_date DATE := NULL;
BEGIN
  start_date := sysdate;
  end_date   := GLOBAL_CONSTANTS_V18.MAX_DATE;

  BEGIN
    SELECT SEAT_TTL_IN_HOURS into ga_ttl_in_hours
    FROM GROUP_ACCOUNT, SUBSCRIPTION, OFFER_CHAIN
    WHERE GROUP_ACCOUNT.ID = in_group_account_id AND 
          GROUP_ACCOUNT.SUBSCRIPTION_ID = SUBSCRIPTION.ID AND
          SUBSCRIPTION.OFFER_CHAIN_ID = OFFER_CHAIN.ID AND
          OFFER_CHAIN.GROUP_ACCOUNT_TYPE_ID in ('GL', 'KL');
  EXCEPTION 
    WHEN no_data_found THEN
      ga_ttl_in_hours := NULL;
  END;

  IF (ga_ttl_in_hours IS NOT NULL) THEN
    end_date := (start_date + (1/24 * ga_ttl_in_hours));
  END IF;

  CORE_OWNER.PROCS_GROUP_ACCOUNT_CRU_V18.CREATE_SUBSCRIPTION_SHARE(
    in_group_account_id => in_group_account_id,
    in_borrower_account_id => in_borrower_account_id,
    in_ip_address => in_ip_address,
    in_email_domain => in_email_domain,
    in_start_date => start_date,
    in_end_date => end_date,
    in_created_by => in_created_by
  );
END CREATE_SUBSCRIPTION_SHARE;


PROCEDURE GET_NUM_OCCUPIED_GROUP_SEATS (
  in_group_account_id   IN NUMBER,
  out_occupied_seats   OUT NUMBER
) AS
SPROC_NAME CONSTANT VARCHAR2(32) := 'GET_NUM_OCCUPIED_GROUP_SEATS';
BEGIN
  SELECT 
    PROCS_GROUP_ACCOUNT_V18.F_GET_NUM_OCCUPIED_GROUP_SEATS(in_group_account_id) INTO out_occupied_seats
  FROM dual;
EXCEPTION
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END GET_NUM_OCCUPIED_GROUP_SEATS;


FUNCTION F_GET_NUM_OCCUPIED_GROUP_SEATS (
  in_group_account_id   IN NUMBER
) RETURN NUMBER IS
SPROC_NAME CONSTANT VARCHAR2(32) := 'GET_NUM_OCCUPIED_GROUP_SEATS';
num_seats NUMBER;
BEGIN
  SELECT 
    COUNT(1) INTO num_seats
  FROM 
    SUBSCRIPTION_SHARE
  WHERE
    GROUP_ACCOUNT_ID = in_group_account_id AND
    SYSDATE BETWEEN START_DATE AND END_DATE;
  RETURN num_seats;
EXCEPTION
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END F_GET_NUM_OCCUPIED_GROUP_SEATS;

-- *********************************************************************
-- *************** GROUP ACCOUNT IP RANGE JUNK *************************
-- *********************************************************************
-- I'm debating if this should be in a different package, but right now
-- I'm too lazy to move this else where.
-- *********************************************************************

PROCEDURE DISABLE_IP_RANGES_BY_GA_ID (
  in_group_account_id IN GROUP_ACCOUNT_IP_RANGE.GROUP_ACCOUNT_ID%TYPE,
  in_updated_by IN GROUP_ACCOUNT_IP_RANGE.UPDATED_BY%TYPE
) AS
SPROC_NAME CONSTANT VARCHAR2(32) := 'DISABLE_IP_RANGES_BY_GA_ID';
BEGIN
    PROCS_GROUP_ACCOUNT_CRU_V18.DISABLE_IP_RANGES_BY_GA_ID(
      in_group_account_id => in_group_account_id,
      in_updated_by => in_updated_by
    );
EXCEPTION
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END DISABLE_IP_RANGES_BY_GA_ID;

PROCEDURE DISABLE_IP_RANGE_BY_ID (
  in_id IN GROUP_ACCOUNT_IP_RANGE.ID%TYPE,
  in_updated_by IN GROUP_ACCOUNT_IP_RANGE.UPDATED_BY%TYPE
) AS
SPROC_NAME CONSTANT VARCHAR2(32) := 'DISABLE_IP_RANGE_BY_ID';
BEGIN
    PROCS_GROUP_ACCOUNT_CRU_V18.DISABLE_IP_RANGE_BY_ID(
      in_id => in_id,
      in_updated_by => in_updated_by
    );
EXCEPTION
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END DISABLE_IP_RANGE_BY_ID;

PROCEDURE ADD_IP_RANGE (
  in_group_account_id IN GROUP_ACCOUNT_IP_RANGE.GROUP_ACCOUNT_ID%TYPE,
  in_minimum_ip_string IN GROUP_ACCOUNT_IP_RANGE.MINIMUM_IP_STRING%TYPE,
  in_minimum_ip_low IN GROUP_ACCOUNT_IP_RANGE.MINIMUM_IP_LOW%TYPE,
  in_minimum_ip_high IN GROUP_ACCOUNT_IP_RANGE.MINIMUM_IP_HIGH%TYPE,
  in_maximum_ip_string IN GROUP_ACCOUNT_IP_RANGE.MAXIMUM_IP_STRING%TYPE,
  in_maximum_ip_low IN GROUP_ACCOUNT_IP_RANGE.MAXIMUM_IP_LOW%TYPE,
  in_maximum_ip_high IN GROUP_ACCOUNT_IP_RANGE.MAXIMUM_IP_HIGH%TYPE,
  in_created_by IN GROUP_ACCOUNT_IP_RANGE.CREATED_BY%TYPE
) AS
SPROC_NAME CONSTANT VARCHAR2(32) := 'ADD_IP_RANGE';
var_ga_type OFFER_CHAIN.GROUP_ACCOUNT_TYPE_ID%TYPE;
var_is_dupe NUMBER(1);
NOT_GL EXCEPTION;
DUPE EXCEPTION;
BEGIN
    SELECT OFFER_CHAIN.GROUP_ACCOUNT_TYPE_ID into var_ga_type
    FROM
      GROUP_ACCOUNT,
      SUBSCRIPTION,
      OFFER_CHAIN
    WHERE
      GROUP_ACCOUNT.ID = in_group_account_id AND
      GROUP_ACCOUNT.SUBSCRIPTION_ID = SUBSCRIPTION.ID AND
      SUBSCRIPTION.OFFER_CHAIN_ID = OFFER_CHAIN.ID
    ;
    IF(var_ga_type != 'GL') THEN
      RAISE NOT_GL;
    END IF;

    PROCS_GROUP_ACCOUNT_CRU_V18.ADD_IP_RANGE(
      in_group_account_id => in_group_account_id,
      in_minimum_ip_string => in_minimum_ip_string,
      in_minimum_ip_low => in_minimum_ip_low,
      in_minimum_ip_high => in_minimum_ip_high,
      in_maximum_ip_string => in_maximum_ip_string,
      in_maximum_ip_low => in_maximum_ip_low,
      in_maximum_ip_high => in_maximum_ip_high,
      in_created_by => in_created_by
    );

    -- Check for overlapping ip address range after insert.  Note that if another
    -- call to add_ip_range has not completed, overlapping ip entries can occur.
    SELECT count(1) into var_is_dupe
    FROM
      GROUP_ACCOUNT_IP_RANGE
    WHERE
      GROUP_ACC_IP_RNG_STATUS_ID = GLOBAL_STATUSES_V18.GROUP_ACC_IP_RNG_ACTIVE AND
          ((
            (in_minimum_ip_high > minimum_ip_high and in_minimum_ip_high < maximum_ip_high) or
            (in_minimum_ip_high = minimum_ip_high and (in_minimum_ip_low >= minimum_ip_low and in_minimum_ip_low <= maximum_ip_low)) or
            (in_minimum_ip_high = maximum_ip_high and (in_minimum_ip_low >= minimum_ip_low and in_minimum_ip_low <= maximum_ip_low))
          ) OR

          (
            (in_maximum_ip_high > minimum_ip_high and in_maximum_ip_high < maximum_ip_high) or
            (in_maximum_ip_high = minimum_ip_high and (in_maximum_ip_low >= minimum_ip_low and in_maximum_ip_low <= maximum_ip_low)) or
            (in_maximum_ip_high = maximum_ip_high and (in_maximum_ip_low >= minimum_ip_low and in_maximum_ip_low <= maximum_ip_low))
          )) AND
      ROWNUM < 3;

    If(var_is_dupe > 1) THEN
      RAISE DUPE;
    END IF;
EXCEPTION
WHEN NOT_GL THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.INVALID_PARAMETER,
    SPROC_NAME, 'Group account type does not support IPs', SQLERRM);
WHEN DUPE THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.INVALID_PARAMETER,
    SPROC_NAME, 'The IP address range is already in use', SQLERRM);
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END ADD_IP_RANGE;

PROCEDURE GET_GRP_ID_BY_GRP_ACCOUNT_ID (
  in_group_account_id IN NUMBER,
  out_group_id OUT NUMBER
) AS
SPROC_NAME CONSTANT VARCHAR2(32) := 'GET_GRP_ID_BY_GRP_ACCOUNT_ID';
BEGIN
  SELECT
    a.group_id into out_group_id
  FROM
    account a,
    subscription s,
    group_account ga
  WHERE
    a.id = s.account_id and
    s.id = ga.subscription_id and
    ga.id = in_group_account_id and
    rownum < 2
  ;
EXCEPTION
WHEN NO_DATA_FOUND THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'Bad group_account_id');
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END GET_GRP_ID_BY_GRP_ACCOUNT_ID;

PROCEDURE GET_GRP_ID_BY_GRPACCIPRNG_ID (
  in_group_account_ip_range_id IN NUMBER,
  out_group_id OUT NUMBER
) AS
SPROC_NAME CONSTANT VARCHAR2(32) := 'GET_GRP_ID_BY_GRPACCIPRNG_ID';
BEGIN
  SELECT
    a.group_id into out_group_id
  FROM
    account a,
    subscription s,
    group_account ga,
    group_account_ip_range ir
  WHERE
    a.id = s.account_id and
    s.id = ga.subscription_id and
    ga.id = ir.group_account_id and
    ir.id = in_group_account_ip_range_id and
    rownum < 2
  ;
EXCEPTION
WHEN NO_DATA_FOUND THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'Bad group_account_ip_range_id');
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END GET_GRP_ID_BY_GRPACCIPRNG_ID;

PROCEDURE GET_GRP_ID_BY_EMAIL_DOM_ID (
  in_group_account_email_dom_id IN NUMBER,
  out_group_id OUT NUMBER
) AS
SPROC_NAME CONSTANT VARCHAR2(32) := 'GET_GRP_ID_BY_EMAIL_DOM_ID';
BEGIN
  SELECT
    a.group_id into out_group_id
  FROM
    account a,
    subscription s,
    group_account ga,
    group_account_email_domain ir
  WHERE
    a.id = s.account_id and
    s.id = ga.subscription_id and
    ga.id = ir.group_account_id and
    ir.id = in_group_account_email_dom_id and
    rownum < 2
  ;
EXCEPTION
WHEN NO_DATA_FOUND THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'Bad group_account_ip_range_id');
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END GET_GRP_ID_BY_EMAIL_DOM_ID;

PROCEDURE UPDATE_GROUP_ACCOUNT (
  in_group_account_id      IN GROUP_ACCOUNT.ID%TYPE,
  in_group_name            IN GROUP_ACCOUNT.GROUP_NAME%TYPE,
  in_first_name            IN GROUP_ACCOUNT.FIRST_NAME%TYPE,
  in_last_name             IN GROUP_ACCOUNT.LAST_NAME%TYPE,
  in_email                 IN GROUP_ACCOUNT.EMAIL%TYPE,
  in_phone                 IN GROUP_ACCOUNT.PHONE%TYPE,
  in_updated_by            IN GROUP_ACCOUNT.UPDATED_BY%TYPE
) AS
BEGIN
  PROCS_GROUP_ACCOUNT_CRU_V18.UPDATE_GROUP_ACCOUNT(
    in_group_account_id => in_group_account_id,
    in_group_name => in_group_name,
    in_first_name => in_first_name,
    in_last_name => in_last_name,
    in_email => in_email,
    in_phone => in_phone,
    in_updated_by => in_updated_by
  );
END UPDATE_GROUP_ACCOUNT;

PROCEDURE UPDATE_GROUP_ACCOUNT_SEATS (
  in_group_account_id      IN GROUP_ACCOUNT.ID%TYPE,
  in_seats                 IN GROUP_ACCOUNT.SEATS%TYPE,
  in_updated_by            IN GROUP_ACCOUNT.UPDATED_BY%TYPE
) AS
BEGIN
  PROCS_GROUP_ACCOUNT_CRU_V18.UPDATE_GROUP_ACCOUNT_SEATS(
    in_group_account_id => in_group_account_id,
    in_seats => in_seats,
    in_updated_by => in_updated_by
  );
END UPDATE_GROUP_ACCOUNT_SEATS;

END PROCS_GROUP_ACCOUNT_V18;
.
/

CREATE OR REPLACE PACKAGE BODY "PROCS_TEST_V18" AS

PROCEDURE TEST_CLEAR_ALL IS 
BEGIN
  DELETE FROM TAX_ADJUSTMENT;
  DELETE FROM LINE_ITEM_ADJUSTMENT;
  DELETE FROM INVOICE_ADJUSTMENT;
  DELETE FROM LICENSE;
  DELETE FROM OFFER_OFFER_CHAIN;
  delete from offer_product_offering;
  delete from tax;
  delete from discount_lineitem_adjustment; -- ? JUnitTests don't clear db in the moment of clear sproc corrections
  delete from discount_line_item; -- ?
  delete from discount; -- ?
  DELETE FROM LINE_ITEM;
  DELETE FROM PRODUCT_OFFERING_META_DATA;
  DELETE FROM PRODUCT_OFFERING;
  DELETE FROM PRODUCT;
  DELETE FROM INVOICE_NOTE;
  DELETE FROM GIFT_CERTIFICATE;
  DELETE FROM OFFER;
  DELETE FROM OFFER_CHAIN_META_DATA;
  DELETE FROM SUBSCRIPTION_NOTE;
  DELETE FROM SUBSCRIPTION_META_DATA;
  DELETE FROM SUBSCRIPTION;
  DELETE FROM CREDIT_CARD;
  DELETE FROM FLAGGED_ACCOUNTS;
  DELETE FROM ACCOUNT_NOTE;
  DELETE FROM ACCOUNT_LOCK;
  DELETE FROM ACCOUNT;
  DELETE FROM CHARGE;
  DELETE FROM TRANSACTION_ATTEMPT;
  DELETE FROM CHARGEBACK;
  DELETE FROM TRANSACTION;
  DELETE FROM INVOICE_NOTE;
  DELETE FROM INVOICE;
  DELETE FROM OFFER_CHAIN_ELIGIBILITY;
  DELETE FROM OFFER_CHAIN;
END TEST_CLEAR_ALL;

PROCEDURE TEST_CLEAR_PRODUCTS AS
BEGIN
  DELETE FROM OFFER_OFFER_CHAIN;
  DELETE FROM OFFER_PRODUCT_OFFERING;
  DELETE FROM TAX;
  DELETE FROM PRODUCT_OFFERING;
  DELETE FROM PRODUCT;
  DELETE FROM OFFER;
  DELETE FROM OFFER_CHAIN_META_DATA;
  DELETE FROM OFFER_CHAIN;
  DELETE FROM OFFER_CHAIN_ELIGIBILITY;
END;

/******************************************/

PROCEDURE TEST_GET_ACCOUNT (
  in_group_id     IN NUMBER,
  out_result_set  OUT SYS_REFCURSOR
) AS 
BEGIN

  OPEN out_result_set FOR
  SELECT *
  FROM
    ACCOUNT
  WHERE
    ACCOUNT.GROUP_ID = in_group_id;

END TEST_GET_ACCOUNT;

/*******************************************/

PROCEDURE TEST_GET_SUBSCRIPTION (
  in_subscription_id IN NUMBER,
  out_result_set     OUT SYS_REFCURSOR
) AS 
BEGIN
  OPEN out_result_set FOR
  SELECT *
  FROM
    SUBSCRIPTION
  WHERE
    SUBSCRIPTION.ID = in_subscription_id;
    
END TEST_GET_SUBSCRIPTION;

/***************************************************/

PROCEDURE TEST_DELETE_INVOICE (
  in_invoice_id IN NUMBER
) AS
var_line_item_id_set SYS_REFCURSOR;
var_line_item_id     NUMBER;

var_charge_id_set  SYS_REFCURSOR;
var_charge_id      NUMBER;
var_transaction_id NUMBER;
BEGIN
  -- GET ACCOUNT'S LINE_ITEMS
  OPEN var_line_item_id_set FOR
  SELECT LINE_ITEM.ID FROM LINE_ITEM WHERE LINE_ITEM.INVOICE_ID = in_invoice_id;
  LOOP
    FETCH var_line_item_id_set into var_line_item_id;
    EXIT WHEN var_line_item_id_set%NOTFOUND;
    
    -- DELETE ADJUSTMENTS
    FOR f_line_item_adjustments IN (SELECT * FROM LINE_ITEM_ADJUSTMENT WHERE LINE_ITEM_ID = var_line_item_id)
    LOOP
      
      -- DELETE DISCOUNT ADJUSTMENTS
      DELETE FROM DISCOUNT_LINEITEM_ADJUSTMENT WHERE LINE_ITEM_ADJUSTMENT_ID = f_line_item_adjustments.ID;
      
      -- DELETE TAX ADJUSTMENTS
      DELETE FROM TAX_ADJUSTMENT WHERE LINE_ITEM_ADJUSTMENT_ID = f_line_item_adjustments.ID;
    END LOOP;
    
    -- DELETE LINE ITEM ADJUSTMENTS
    DELETE FROM LINE_ITEM_ADJUSTMENT WHERE LINE_ITEM_ID = var_line_item_id;

    -- DELETE DISCOUNT_LINE_ITEM
    DELETE FROM DISCOUNT_LINE_ITEM WHERE DISCOUNT_LINE_ITEM.LINE_ITEM_ID = var_line_item_id;

    DELETE FROM TAX WHERE LINE_ITEM_ID = var_line_item_id;

    -- DELETE LINE ITEM
    DELETE FROM LINE_ITEM WHERE LINE_ITEM.ID = var_line_item_id;

  END LOOP;
  
  -- DELETE INVOICE ADJUSTMENTS
  DELETE FROM INVOICE_ADJUSTMENT WHERE INVOICE_ID = in_invoice_id;

  -- GET ACCOUNT'S CHARGES AND TRANSACTIONS
  OPEN var_charge_id_set FOR
  SELECT CHARGE.ID, CHARGE.TRANSACTION_ID FROM CHARGE WHERE CHARGE.INVOICE_ID = in_invoice_id;
  LOOP
    FETCH var_charge_id_set into var_charge_id, var_transaction_id;
    EXIT WHEN var_charge_id_set%NOTFOUND;
    -- DELETE CHARGEBACK
    DELETE FROM CHARGEBACK WHERE CHARGEBACK.TRANSACTION_ID = var_transaction_id;
    
    -- DELETE TRANSACTION ATTEMP
    DELETE FROM TRANSACTION_ATTEMPT WHERE TRANSACTION_ATTEMPT.TRANSACTION_ID = var_transaction_id;
    
    -- DELETE CHARGE
    DELETE FROM CHARGE WHERE CHARGE.ID = var_charge_id;

    -- DELETE TRANSACTION
    DELETE FROM TRANSACTION WHERE TRANSACTION.ID = var_transaction_id;
  END LOOP;
  
  -- DELETE INVOICE NOTES
  DELETE FROM INVOICE_NOTE WHERE INVOICE_NOTE.INVOICE_ID = in_invoice_id;
  
  -- DELETE INVOICE
  DELETE FROM INVOICE WHERE INVOICE.ID = in_invoice_id;
END;

PROCEDURE TEST_DELETE_USER_ACCOUNT (
  in_group_id IN NUMBER
) AS
-- VARIABLES
var_account_id NUMBER;

-- CURSORS
var_subscription_id_set SYS_REFCURSOR;
var_subscription_id     NUMBER;

var_license_id_set SYS_REFCURSOR;
var_license_id     NUMBER;
var_invoice_id     NUMBER;

var_gift_certificate_id_set SYS_REFCURSOR;
var_gift_certificate_id     NUMBER;
var_gc_purchase_invoice_id  NUMBER;
BEGIN
  
 /*FOR f_account in (
    select id from account where group_id = in_group_id
  )
  loop
    
    -- delete account
    delete from account where id = f_account.id;
    
  end loop;*/
  
  BEGIN
    SELECT
      ACCOUNT.ID into var_account_id
    FROM
      ACCOUNT
    WHERE
      ACCOUNT.GROUP_ID = in_group_id;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        -- Nothing to do
        RETURN;
  END;

  -- GET ACCOUNT'S SUBSCRIPTIONS
  OPEN var_subscription_id_set FOR
  SELECT SUBSCRIPTION.ID FROM SUBSCRIPTION WHERE SUBSCRIPTION.ACCOUNT_ID = var_account_id;
  LOOP
    FETCH var_subscription_id_set into var_subscription_id;
    EXIT WHEN var_subscription_id_set%NOTFOUND;
    
    -- GET ACCOUNT'S LICENSES AND INVOICES
    OPEN var_license_id_set FOR
    SELECT LICENSE.ID, LICENSE.INVOICE_ID FROM LICENSE WHERE LICENSE.SUBSCRIPTION_ID = var_subscription_id;
    LOOP
      FETCH var_license_id_set into var_license_id, var_invoice_id;
      EXIT WHEN var_license_id_set%NOTFOUND;
      

      -- GET GC WHERE PURCHASE_INVOICE_ID = invoice
      OPEN var_gift_certificate_id_set FOR
      SELECT GIFT_CERTIFICATE.ID, GIFT_CERTIFICATE.PURCHASE_INVOICE_ID FROM GIFT_CERTIFICATE WHERE GIFT_CERTIFICATE.FINALIZED_INVOICE_ID = var_invoice_id;
      LOOP
        FETCH var_gift_certificate_id_set into var_gift_certificate_id, var_gc_purchase_invoice_id;
        EXIT WHEN var_gift_certificate_id_set%NOTFOUND;
        
        -- DELETE GIFT_CERTIFICATE
        DELETE FROM GIFT_CERTIFICATE WHERE GIFT_CERTIFICATE.ID = var_gift_certificate_id;

        -- DELETE LICENSE
        IF TEST_IS_INVOICE_EXISTS(var_gc_purchase_invoice_id) = 1 THEN
          TEST_DELETE_INVOICE(var_gc_purchase_invoice_id);
        END IF;
        
      END LOOP;

      -- DELETE GIFT_CERTIFICATE WHERE GC.REDEEMER_GROUP_ID = out group_id
      DELETE FROM GIFT_CERTIFICATE WHERE GIFT_CERTIFICATE.REDEEMER_GROUP_ID = in_group_id;
      
      -- DELETE LICENSE
      DELETE FROM LICENSE WHERE LICENSE.ID = var_license_id;
      
      -- DELETE INVOICE
      IF TEST_IS_INVOICE_EXISTS(var_invoice_id) = 1 THEN
        TEST_DELETE_INVOICE(var_invoice_id);
      END IF;
    END LOOP;
    
    -- DELETE SUBSCRIPTION_NOTE
    DELETE FROM SUBSCRIPTION_NOTE WHERE SUBSCRIPTION_NOTE.SUBSCRIPTION_ID = var_subscription_id;
    
    -- DELETE SUBSCRIPTION META_DATA
    DELETE FROM SUBSCRIPTION_META_DATA WHERE SUBSCRIPTION_META_DATA.SUBSCRIPTION_ID = var_subscription_id;
    
    -- DELETE SUBSCRIPTION
    DELETE FROM SUBSCRIPTION WHERE SUBSCRIPTION.ID = var_subscription_id;
  END LOOP;
  
  -- DELETE CREDIT_CARDS
  DELETE FROM CREDIT_CARD WHERE CREDIT_CARD.ACCOUNT_ID = var_account_id;
  
  -- DELETE PAYPAL
  DELETE FROM PAYPAL WHERE PAYPAL.ACCOUNT_ID = var_account_id;
  
  -- DELETE FLAGS
  DELETE FROM FLAGGED_ACCOUNTS WHERE FLAGGED_ACCOUNTS.ACCOUNT_ID = var_account_id;
  
  -- DELETE ACCOUNT NOTES
  DELETE FROM ACCOUNT_NOTE WHERE ACCOUNT_NOTE.ACCOUNT_ID = var_account_id;
  
  -- DELETE INVOICES AND GC'S WHERE USER IS PURCHASER
  OPEN var_gift_certificate_id_set FOR
  SELECT GIFT_CERTIFICATE.ID, GIFT_CERTIFICATE.PURCHASE_INVOICE_ID FROM GIFT_CERTIFICATE WHERE GIFT_CERTIFICATE.PURCHASER_GROUP_ID = in_group_id;
  LOOP
    FETCH var_gift_certificate_id_set into var_gift_certificate_id, var_gc_purchase_invoice_id;
    EXIT WHEN var_gift_certificate_id_set%NOTFOUND;
    
    -- DELETE GIFT CERTIFICATE
    DELETE FROM GIFT_CERTIFICATE WHERE GIFT_CERTIFICATE.ID = var_gift_certificate_id;

    -- DELETE INVOICE
    IF TEST_IS_INVOICE_EXISTS(var_gc_purchase_invoice_id) = 1 THEN
      TEST_DELETE_INVOICE(var_gc_purchase_invoice_id);
    END IF;
  END LOOP;
  
  -- DELETE LOCKS
  DELETE FROM ACCOUNT_LOCK WHERE ACCOUNT_ID = var_account_id;
  
  -- DELETE ACCOUNT
  DELETE FROM ACCOUNT WHERE ACCOUNT.ID = var_account_id;
  
END TEST_DELETE_USER_ACCOUNT;

PROCEDURE TEST_DELETE_USER_ACCOUNTS  (
  in_start_group_id IN NUMBER,
  in_end_group_id   IN NUMBER
) IS
 gid ACCOUNT.GROUP_ID%TYPE;
 CURSOR c (v_from NUMBER, v_to NUMBER) IS SELECT ACCOUNT.GROUP_ID FROM ACCOUNT WHERE GROUP_ID BETWEEN v_from AND v_to;
BEGIN
-- arosolovskiy refactoring: call delete_user_account only "COUNT(group_id) WHERE ...." times instead of "in_end_group_id - in_start_group_id" times;
  /*
  FOR var_group_id IN in_start_group_id..in_end_group_id
  LOOP
    TEST_DELETE_USER_ACCOUNT(var_group_id);
  END LOOP;*/
  OPEN c(in_start_group_id, in_end_group_id);
  WHILE c%ISOPEN LOOP
    FETCH c INTO gid;
    IF c%NOTFOUND THEN
     CLOSE c;
    END IF;
    TEST_DELETE_USER_ACCOUNT(gid);
  END LOOP;
END;

/**********************************************************/

FUNCTION TEST_IS_INVOICE_EXISTS(
/*
1 - exists
0 - not exists
*/
  in_invoice_id IN NUMBER
) RETURN NUMBER AS
var_invoice_count NUMBER;
BEGIN
  SELECT
    COUNT(*) into var_invoice_count
  FROM
    INVOICE
  WHERE
    INVOICE.ID = in_invoice_id;
  IF var_invoice_count = 0 THEN
    RETURN 0;
  ELSE
    RETURN 1;
  END IF;
END;

PROCEDURE TEST_GET_INVOICE_INFO (
  in_invoice_id  IN NUMBER,
  out_result_set OUT SYS_REFCURSOR
) AS
SPROC_NAME      CONSTANT VARCHAR2(21) := 'TEST_GET_INVOICE_INFO';
BEGIN

   OPEN out_result_set FOR SELECT 
      in_invoice_id AS "INVOICE_ID",
      INVOICE.INVOICE_STATUS_ID,
      PROCS_INVOICE_V18.F_CALCULATE_INVOICE_AMOUNT(in_invoice_id) AS "INVOICE_AMOUNT",
      CHARGE.ID AS "CHARGE_ID",
      CHARGE.CHARGE_AMOUNT,
      CHARGE.TRANSACTION_ID,
      TRANSACTION.TRANSACTION_STATUS_ID
    FROM CHARGE INNER JOIN INVOICE ON INVOICE.ID = CHARGE.INVOICE_ID INNER JOIN TRANSACTION ON TRANSACTION.ID = CHARGE.TRANSACTION_ID WHERE CHARGE.INVOICE_ID = in_invoice_id ORDER BY INVOICE.ID, CHARGE.ID, TRANSACTION.ID;
   
END TEST_GET_INVOICE_INFO;

/******************************************************************************/

PROCEDURE TEST_DELETE_OFFER_CHAIN(
  in_offer_chain_id in number
) as
begin
  
  for v_offer_chain in (
    select och.id from offer_chain och where och.id = in_offer_chain_id
  )
  loop
    
    for v_offer in (
      select offer_id as id from offer_offer_chain where offer_chain_id = v_offer_chain.id
    )
    loop
      
      for v_product_offering in (
        select
          product_offering.id,
          product_offering.product_id
        from
          offer_product_offering
          inner join product_offering on offer_product_offering.product_offering_id = product_offering.id
        where offer_product_offering.offer_id = v_offer.id
      )
      loop
        
        -- delete product eligibility
        delete from product_eligibility where product_id = v_product_offering.product_id;
        
        -- delete meta data
        delete from product_offering_meta_data where product_offering_id = v_product_offering.id;
        
        -- delete product
        delete from product where id = v_product_offering.product_id;
        
        -- delete product_offering
        delete from product_offering where id = v_product_offering.id;
        
      end loop;
      
      -- delete data from offer_product_offering table
      delete from offer_product_offering where offer_id = v_offer.id;
      
      -- delete data from offer_offer_chain table
      delete from offer_offer_chain where offer_chain_id = v_offer_chain.id;

      -- delete offer
      delete from offer where id = v_offer.id;

    end loop;
    
    -- delete offer_chain_eligibility
    delete from offer_chain_eligibility where offer_chain_id = v_offer_chain.id;
    
    -- delete metadata
    delete from offer_chain_meta_data where offer_chain_id = v_offer_chain.id;
    
    -- delete offer chain
    delete from offer_chain where id = v_offer_chain.id;
    
  end loop;
  
end;

END PROCS_TEST_V18;
.
/

CREATE OR REPLACE PACKAGE BODY "PROCS_ACCOUNT_V18" AS

PROCEDURE INVOICE_IDS_BY_GROUP_ID (
  in_group_id    IN  NUMBER,
  out_result_set OUT SYS_REFCURSOR
) AS
SPROC_NAME CONSTANT VARCHAR2(32) := 'INVOICE_IDS_BY_GROUP_ID';
BEGIN
  OPEN out_result_set FOR
  SELECT
    Invoice.Id
  FROM
    LICENSE
    INNER JOIN SUBSCRIPTION ON LICENSE.SUBSCRIPTION_ID = SUBSCRIPTION.ID
    INNER JOIN INVOICE ON LICENSE.INVOICE_ID = INVOICE.ID
    INNER JOIN OFFER_CHAIN ON SUBSCRIPTION.OFFER_CHAIN_ID = OFFER_CHAIN.ID
    INNER JOIN INVOICE_STATUS ON INVOICE.INVOICE_STATUS_ID = INVOICE_STATUS.ID
  Where
    SUBSCRIPTION.ACCOUNT_ID IN (SELECT ID FROM ACCOUNT WHERE GROUP_ID = in_group_id) AND
    INVOICE.INVOICE_STATUS_ID = GLOBAL_STATUSES_V18.INVOICE_OPEN;
END INVOICE_IDS_BY_GROUP_ID;

FUNCTION GET_GRACE_START_DATE(
  in_subscription_id IN NUMBER
) RETURN DATE AS
SPROC_NAME           CONSTANT VARCHAR2(32) := 'GET_GRACE_START_DATE';
grace_start_date_var DATE;
BEGIN
  SELECT GRACE_START_DATE into grace_start_date_var
  FROM
    (
      SELECT
        GRACE_START_DATE
      FROM
        LICENSE
      WHERE
        LICENSE.SUBSCRIPTION_ID = in_subscription_id
      ORDER BY
        LICENSE.END_DATE DESC
    )
  WHERE
    ROWNUM <= 1;

  RETURN grace_start_date_var;
END GET_GRACE_START_DATE;

FUNCTION GET_GRACE_END_DATE(
  in_subscription_id IN NUMBER
) RETURN DATE AS
SPROC_NAME         CONSTANT VARCHAR2(32) := 'GET_GRACE_END_DATE';
grace_end_date_var DATE;
BEGIN
  SELECT GRACE_END_DATE into grace_end_date_var
  FROM
    (
      SELECT
        GRACE_END_DATE
      FROM
        LICENSE
      WHERE
        LICENSE.SUBSCRIPTION_ID = in_subscription_id
      ORDER BY
        LICENSE.END_DATE DESC
    )
  WHERE ROWNUM <= 1;

  RETURN grace_end_date_var;
END GET_GRACE_END_DATE;



PROCEDURE ANNOTATE_ACCOUNT (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_group_id   IN  NUMBER,
  in_agent_id   IN  NUMBER,
  in_note       IN  VARCHAR2,
  in_created_by IN  VARCHAR2
) AS
SPROC_NAME  CONSTANT VARCHAR2(16) := 'ANNOTATE_ACCOUNT';
-- VARIABLES
var_account_id      NUMBER;
var_account_note_id NUMBER;
-- EXCEPTIONS
BAD_ACCOUNT_ID EXCEPTION;
BEGIN

  -- Get account id
  BEGIN
    SELECT
      ACCOUNT.ID into var_account_id
    FROM
      ACCOUNT
    WHERE
      ACCOUNT.GROUP_ID = in_group_id;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE BAD_ACCOUNT_ID;
  END;

  -- Insert new row into ACCOUNT_NOTE table
  PROCS_ACCOUNT_CRU_V18.CREATE_ACCOUNT_NOTE(
    inout_account_note_id => var_account_note_id,
    in_agent_id           => in_agent_id,
    in_account_id         => var_account_id,
    in_note               => in_note,
    in_created_by         => in_created_by
  );

EXCEPTION
WHEN BAD_ACCOUNT_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'No such group id');
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END ANNOTATE_ACCOUNT;

/******************************************************************************/

PROCEDURE ASSERT_ACCOUNT_EXISTS (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_group_id IN  NUMBER,
  out_exists  OUT NUMBER
) AS
-- VARIABLES
var_found_id  NUMBER;
SPROC_NAME    CONSTANT VARCHAR2(21) := 'ASSERT_ACCOUNT_EXISTS';
BEGIN
  SELECT ACCOUNT.ID INTO var_found_id FROM ACCOUNT WHERE ACCOUNT.GROUP_ID = in_group_id;
  out_exists := GLOBAL_CONSTANTS_V18.TRUE;
EXCEPTION
WHEN NO_DATA_FOUND THEN
  out_exists := GLOBAL_CONSTANTS_V18.FALSE;
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END ASSERT_ACCOUNT_EXISTS;

/******************************************************************************/

PROCEDURE DISABLE_ACCOUNT (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.INTERNAL_ERROR,
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
*/
  in_group_id   IN NUMBER,
  in_updated_by IN VARCHAR2,
  in_note       IN VARCHAR2,
  in_agent_id   IN NUMBER
) AS
SPROC_NAME              CONSTANT VARCHAR2(15) := 'DISABLE_ACCOUNT';
var_account_id          NUMBER;
current_account_status  NUMBER;

var_active_subscriptions_num NUMBER;
var_pending_invoices_num     NUMBER;

-- EXCEPTIONS
BAD_ACOUNT_ID             EXCEPTION;
BAD_CURRENT_ACC_STATUS    EXCEPTION;
PENDING_INVOICES_FOUND    EXCEPTION;
ACCOUNT_HAS_ACIVE_SUBSCRS EXCEPTION;
CAN_NOT_ANNOTATE_ACCOUNT  EXCEPTION;
EXCEPTION_MESSAGE         VARCHAR2(1024);
BEGIN

  -- Get account's status and id
  BEGIN
    SELECT
      ACCOUNT.ACCOUNT_STATUS_ID,
      ACCOUNT.ID
    INTO
      current_account_status,
      var_account_id
    FROM ACCOUNT
    WHERE
      ACCOUNT.GROUP_ID = in_group_id;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE BAD_ACOUNT_ID;
  END;

  -- For now, we can disable account whenever
  IF current_account_status = GLOBAL_STATUSES_V18.ACCOUNT_DISABLED THEN
    RAISE BAD_CURRENT_ACC_STATUS;
  END IF;

  -- Checks for out outstanding balances
  -- CHECK: No outstanding balances. If monies are due, then we can not cancel account. Return ERROR.
  SELECT
    COUNT(*) into var_pending_invoices_num
  FROM
    LICENSE
      INNER JOIN SUBSCRIPTION ON LICENSE.SUBSCRIPTION_ID = SUBSCRIPTION.ID
      INNER JOIN INVOICE ON LICENSE.INVOICE_ID = INVOICE.ID
  WHERE
    SUBSCRIPTION.ACCOUNT_ID = var_account_id
    AND INVOICE.INVOICE_STATUS_ID IN ( SELECT GLOBAL_STATUSES_V18.INVOICE_OPEN FROM DUAL );

  IF var_pending_invoices_num > 0 THEN
    RAISE PENDING_INVOICES_FOUND;
  END IF;

  SELECT
    COUNT(*) into var_active_subscriptions_num
  FROM
    SUBSCRIPTION
  WHERE
    SUBSCRIPTION.ACCOUNT_ID = var_account_id
    AND (
      SUBSCRIPTION.SUBSCRIPTION_STATUS_ID = GLOBAL_STATUSES_V18.SUBSCRIPTION_ACTIVE
      OR SUBSCRIPTION.SUBSCRIPTION_STATUS_ID = GLOBAL_STATUSES_V18.SUBSCRIPTION_SUSPENDED
      OR SUBSCRIPTION.SUBSCRIPTION_STATUS_ID = GLOBAL_STATUSES_V18.SUBSCRIPTION_IN_GRACE_PERIOD);

  IF var_active_subscriptions_num > 0 THEN
    RAISE ACCOUNT_HAS_ACIVE_SUBSCRS;
  END IF;

  PROCS_ACCOUNT_V18.UPDATE_ACCOUNT_STATUS(
    in_account_id        => var_account_id,
    in_account_status_id => GLOBAL_STATUSES_V18.ACCOUNT_DISABLED,
    in_updated_by        => in_updated_by
  );

  -- Annotate account
  IF in_note IS NOT NULL THEN
    BEGIN
      PROCS_ACCOUNT_V18.ANNOTATE_ACCOUNT(
        in_group_id   => in_group_id,
        in_agent_id   => in_agent_id,
        in_note       => in_note,
        in_created_by => in_updated_by
      );
      EXCEPTION
        WHEN OTHERS THEN
          EXCEPTION_MESSAGE := SQLERRM;
          RAISE CAN_NOT_ANNOTATE_ACCOUNT;
    END;
  END IF;

EXCEPTION
WHEN ACCOUNT_HAS_ACIVE_SUBSCRS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.INTERNAL_ERROR,
    SPROC_NAME, 'Account has active or suspended subsciptions');
WHEN BAD_CURRENT_ACC_STATUS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.STATE_ERROR,
    SPROC_NAME, 'Current account status is "disabled". Can not disable it one more time.');
WHEN PENDING_INVOICES_FOUND THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.INTERNAL_ERROR,
    SPROC_NAME, 'Opened/Pending invoices founded');
WHEN BAD_ACOUNT_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'No such account');
WHEN CAN_NOT_ANNOTATE_ACCOUNT THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.INTERNAL_ERROR,
    SPROC_NAME, 'Could not annotate account', EXCEPTION_MESSAGE);
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END DISABLE_ACCOUNT;

/******************************************************************************/

PROCEDURE CREATE_ACTIVE_ACCOUNT(
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
APP_EXCEPTION_CODES_V18.DUPLICATE_ERROR
*/
    in_created_by IN VARCHAR2,
    in_group_id   IN NUMBER
) AS
-- VARIABLES
SPROC_NAME      CONSTANT VARCHAR2(21) := 'CREATE_ACTIVE_ACCOUNT';
new_account_id  NUMBER;
temp_group_id   NUMBER;
-- EXCEPTIONS
GROUP_EXISTS_EXCEPTION EXCEPTION;
EXCEPTION_MESSAGE      VARCHAR2(1024);
BEGIN
  -- Check if account already exists
  BEGIN
    SELECT
      ACCOUNT.GROUP_ID into temp_group_id
    FROM
      ACCOUNT
    WHERE
      ACCOUNT.GROUP_ID = in_group_id
      AND ROWNUM <= 1;

    IF SQL%ROWCOUNT = 1 THEN
      RAISE GROUP_EXISTS_EXCEPTION;
    END IF;

    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        NULL;
  END;

  -- Insert new row into ACCOUNT table
  PROCS_ACCOUNT_CRU_V18.CREATE_ACCOUNT(
    out_account_id        => new_account_id,
    in_account_status_id  => GLOBAL_STATUSES_V18.ACCOUNT_ACTIVE,
    in_group_id           => in_group_id,
    in_created_by         => in_created_by,
    in_system_category_id => GLOBAL_ENUMS_V18.SYSTEM_CATEGORY_LIVE
  );

EXCEPTION
WHEN GROUP_EXISTS_EXCEPTION THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.DUPLICATE_ERROR,
    SPROC_NAME, 'Group already exists');
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END CREATE_ACTIVE_ACCOUNT;

/******************************************************************************/

PROCEDURE REACTIVATE_ACCOUNT (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.INTERNAL_ERROR,
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
*/
  in_group_id   IN NUMBER,
  in_updated_by IN VARCHAR2,
  in_note       IN VARCHAR2,
  in_agent_id   IN NUMBER
) AS
-- VARIABLES
SPROC_NAME              CONSTANT VARCHAR2(18) := 'REACTIVATE_ACCOUNT';
var_account_id          NUMBER;
current_account_status  NUMBER;

-- EXCEPTIONS
BAD_CURRENT_ACC_STATUS EXCEPTION;
CAN_NOT_CREATE_NOTE    EXCEPTION;
EXCEPTION_MESSAGE      VARCHAR2(1024);
BEGIN
  -- Get account id, status
  SELECT
    ACCOUNT.ACCOUNT_STATUS_ID,
    ACCOUNT.ID
  INTO
    current_account_status,
    var_account_id
  FROM ACCOUNT
  WHERE
    ACCOUNT.GROUP_ID = in_group_id;

  IF current_account_status != GLOBAL_STATUSES_V18.ACCOUNT_FROZEN THEN
    RAISE BAD_CURRENT_ACC_STATUS;
  END IF;

  -- Change account status
  PROCS_ACCOUNT_V18.UPDATE_ACCOUNT_STATUS(
    in_account_id        => var_account_id,
    in_updated_by        => in_updated_by,
    in_account_status_id => GLOBAL_STATUSES_V18.ACCOUNT_ACTIVE
  );

  -- Add note
  BEGIN
    PROCS_ACCOUNT_V18.ANNOTATE_ACCOUNT(
      in_group_id   => in_group_id,
      in_agent_id   => in_agent_id,
      in_note       => in_note,
      in_created_by => in_updated_by
    );
    EXCEPTION
      WHEN OTHERS THEN
        EXCEPTION_MESSAGE := SQLERRM;
        RAISE CAN_NOT_CREATE_NOTE;
  END;

EXCEPTION
WHEN BAD_CURRENT_ACC_STATUS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.STATE_ERROR,
    SPROC_NAME, 'Current account status is not "frozen"');
WHEN NO_DATA_FOUND THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'Could not find account with given group ID');
WHEN CAN_NOT_CREATE_NOTE THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.INTERNAL_ERROR,
    SPROC_NAME, 'Could not annotate account');
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END REACTIVATE_ACCOUNT;

/******************************************************************************/

PROCEDURE GET_ACCOUNT_CREDIT_CARDS (
  in_group_id    IN ACCOUNT.GROUP_ID%TYPE,
  in_status_id   IN CREDIT_CARD.CREDIT_CARD_STATUS_ID%TYPE DEFAULT GLOBAL_STATUSES_V18.CREDIT_CARD_ACTIVE,
  out_result_set OUT SYS_REFCURSOR
) AS
SPROC_NAME CONSTANT VARCHAR2(32) := 'GET_ACCOUNT_CREDIT_CARDS';
BEGIN
  OPEN out_result_set FOR
    SELECT
      CREDIT_CARD.ID,
      CREDIT_CARD.ACCOUNT_ID,
      CREDIT_CARD.INSTRUMENT_NAME,
      CREDIT_CARD.PRIVATE_CARD_HOLDER_NAME,
      CREDIT_CARD.PRIVATE_STREET_ADDRESS,
      CREDIT_CARD.PRIVATE_STREET_ADDRESS2,
      CREDIT_CARD.STATE,
      CREDIT_CARD.CITY,
      CREDIT_CARD.POSTAL_CODE,
      CREDIT_CARD.COUNTRY,
      CREDIT_CARD.LAST_FOUR_CC,
      CREDIT_CARD.EXPIRATION_DATE,
      CREDIT_CARD.CREDIT_CARD_TYPE_ID,
      CREDIT_CARD.SECRET_TOKEN,
      CREDIT_CARD.CREATE_DATE,
      CREDIT_CARD.CREATED_BY,
      CREDIT_CARD.UPDATE_DATE,
      CREDIT_CARD.UPDATED_BY,
      CREDIT_CARD.CREDIT_CARD_STATUS_ID,
      CREDIT_CARD.PRIVATE_FIRST_NAME,
      Credit_Card.Private_Last_Name,
      decode((SELECT Instrument_Id FROM ACCOUNT WHERE group_id = in_group_id and Instrument_Id = CREDIT_CARD.ID),null,'false', 'true') is_default
    From
        CREDIT_CARD left join account on account.id = CREDIT_CARD.Account_Id
    Where
      Account.Group_Id = in_group_id
      AND CREDIT_CARD.CREDIT_CARD_STATUS_ID = in_status_id;
END GET_ACCOUNT_CREDIT_CARDS;

/******************************************************************************/

PROCEDURE GET_ACCOUNT_GIFT_CERTIFICATES (
/*
IN:
instr_status:
GLOBAL_CONSTANTS_V18.TRUE - get active instruments only (default)
GLOBAL_CONSTANTS_V18.FALSE - get inactive instruments only

Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND,
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_group_id       IN NUMBER,
  out_result_gc_set OUT SYS_REFCURSOR,
  in_instr_status   IN NUMBER DEFAULT GLOBAL_CONSTANTS_V18.TRUE
) AS
SPROC_NAME     CONSTANT VARCHAR2(29) := 'GET_ACCOUNT_GIFT_CERTIFICATES';
var_account_id NUMBER;

-- Exceptions
WRONG_INSTR_EXCEPTION      EXCEPTION;
BEGIN

  -- Get account id
  SELECT
    ACCOUNT.ID INTO var_account_id
  FROM
    ACCOUNT
  WHERE
    ACCOUNT.GROUP_ID = in_group_id;

  -- Check that incoming data is correct
  IF in_instr_status != GLOBAL_CONSTANTS_V18.TRUE AND in_instr_status != GLOBAL_CONSTANTS_V18.FALSE THEN
    RAISE WRONG_INSTR_EXCEPTION;
  END IF;

  OPEN out_result_gc_set FOR
  SELECT
    GIFT_CERTIFICATE.ID,
    GIFT_CERTIFICATE.PURCHASER_GROUP_ID,
    GIFT_CERTIFICATE.PURCHASE_INVOICE_ID,
    GIFT_CERTIFICATE.PURCHASE_DATE,
    GIFT_CERTIFICATE.OFFER_CHAIN_ID,
    GIFT_CERTIFICATE.EXPIRATION_DATE,
    GIFT_CERTIFICATE.GIFT_CERTIFICATE_STATUS_ID,
    GIFT_CERTIFICATE.CODE,
    GIFT_CERTIFICATE.CREATE_DATE,
    GIFT_CERTIFICATE.CREATED_BY,
    GIFT_CERTIFICATE.UPDATE_DATE,
    GIFT_CERTIFICATE.UPDATED_BY,
    GIFT_CERTIFICATE.RECIPIENT_NAME,
    GIFT_CERTIFICATE.RECIPIENT_EMAIL,
    GIFT_CERTIFICATE.SENDER_NAME,
    GIFT_CERTIFICATE.SENDER_EMAIL,
    GIFT_CERTIFICATE.REDEEMER_GROUP_ID,
    GIFT_CERTIFICATE.REDEMPTION_DATE,
    GIFT_CERTIFICATE.FINALIZED_INVOICE_ID,
    GIFT_CERTIFICATE.GIFT_MESSAGE
  FROM
    GIFT_CERTIFICATE
  WHERE
    GIFT_CERTIFICATE.PURCHASER_GROUP_ID = in_group_id
    AND (
          ( in_instr_status = GLOBAL_CONSTANTS_V18.TRUE AND
            (
              GIFT_CERTIFICATE.EXPIRATION_DATE >= current_date
              AND GIFT_CERTIFICATE.GIFT_CERTIFICATE_STATUS_ID = GLOBAL_STATUSES_V18.GIFT_CERTIFICATE_ACTIVE
            )
          )
          OR
          (
            in_instr_status = GLOBAL_CONSTANTS_V18.FALSE AND
            (
              GIFT_CERTIFICATE.EXPIRATION_DATE < current_date
              OR GIFT_CERTIFICATE.GIFT_CERTIFICATE_STATUS_ID != GLOBAL_STATUSES_V18.GIFT_CERTIFICATE_ACTIVE
            )
          )
        );

EXCEPTION
WHEN NO_DATA_FOUND THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'Can not find account with given group id');
WHEN WRONG_INSTR_EXCEPTION THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.INVALID_PARAMETER,
    SPROC_NAME, 'Wrong gift certificate type');
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END GET_ACCOUNT_GIFT_CERTIFICATES;

/******************************************************************************/

PROCEDURE GET_ACCOUNT_INFO  (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND,
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
    in_group_id       IN  NUMBER,
    out_account_info  OUT SYS_REFCURSOR
) AS
SPROC_NAME      CONSTANT VARCHAR2(16) := 'GET_ACCOUNT_INFO';
var_account_id  NUMBER;
BEGIN

  -- Get account id
  SELECT
    ACCOUNT.ID INTO var_account_id
  FROM
    ACCOUNT
  WHERE
    ACCOUNT.GROUP_ID = in_group_id;

  -- Get account info
  OPEN out_account_info FOR
    SELECT
      ACCOUNT.ACCOUNT_STATUS_ID
    FROM ACCOUNT
    WHERE
      ACCOUNT.GROUP_ID = in_group_id;

EXCEPTION
WHEN NO_DATA_FOUND THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'No such account');
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown Error', SQLERRM);
END GET_ACCOUNT_INFO;

/******************************************************************************/

PROCEDURE GET_ACCOUNT_NOTES (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
    in_group_id    IN  NUMBER,
    out_result_set OUT SYS_REFCURSOR
) AS
-- VARIABLES
SPROC_NAME      CONSTANT VARCHAR2(17) := 'GET_ACCOUNT_NOTES';
var_account_id NUMBER;
-- EXCEPTIONS
BAD_ACCOUNT_ID EXCEPTION;
BEGIN

  -- Check that account is exists
  BEGIN
    SELECT
      ACCOUNT.ID into var_account_id
    FROM
      ACCOUNT
    WHERE
      ACCOUNT.GROUP_ID = in_group_id;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE BAD_ACCOUNT_ID;
  END;

  -- Get account notes
  OPEN out_result_set FOR
  SELECT
    ACCOUNT_NOTE.ACCOUNT_ID,
    ACCOUNT_NOTE.AGENT_ID,
    ACCOUNT_NOTE.CREATE_DATE,
    ACCOUNT_NOTE.CREATED_BY,
    ACCOUNT_NOTE.ID,
    ACCOUNT_NOTE.NOTE
  FROM
    ACCOUNT_NOTE
  WHERE
    ACCOUNT_NOTE.ACCOUNT_ID = var_account_id
  ORDER BY
    ACCOUNT_NOTE.CREATE_DATE ASC;

EXCEPTION
WHEN BAD_ACCOUNT_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'No such account');
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END GET_ACCOUNT_NOTES;

/******************************************************************************/

PROCEDURE GET_ACCOUNT_PAYPALS(
  in_group_id    IN  ACCOUNT.GROUP_ID%TYPE,
  in_status_id   IN  PAYPAL.PAYPAL_STATUS_ID%TYPE DEFAULT GLOBAL_STATUSES_V18.PAYPAL_ACTIVE,
  out_result_set OUT SYS_REFCURSOR
) AS
SPROC_NAME     CONSTANT VARCHAR2(32) := 'GET_ACCOUNT_PAYPALS';
BEGIN
  OPEN out_result_set FOR
    SELECT
      DISTINCT
      PAYPAL.ID,
      PAYPAL.ACCOUNT_ID,
      PAYPAL.INSTRUMENT_NAME,
      PAYPAL.PRIVATE_EMAIL_ADDRESS,
      PAYPAL.CREATE_DATE,
      PAYPAL.CREATED_BY,
      PAYPAL.UPDATE_DATE,
      PAYPAL.UPDATED_BY,
      PAYPAL.PAYPAL_STATUS_ID,
      PAYPAL.PRIVATE_STREET_ADDRESS,
      PAYPAL.PRIVATE_STREET_ADDRESS2,
      PAYPAL.STATE,
      PAYPAL.CITY,
      PAYPAL.POSTAL_CODE,
      PAYPAL.COUNTRY,
      Paypal.Expiration_Date,
      Paypal.Secret_Token,
      decode((SELECT
      Instrument_Id
              FROM ACCOUNT
              WHERE group_id = in_group_id AND Instrument_Id = PAYPAL.ID), null, 'false', 'true') is_default
    FROM
        PAYPAL
        LEFT JOIN ACCOUNT ON ACCOUNT.id = PAYPAL.ACCOUNT_ID
    WHERE
      ACCOUNT.GROUP_ID = in_group_id
      AND PAYPAL.PAYPAL_STATUS_ID = in_status_id;
END GET_ACCOUNT_PAYPALS;

/******************************************************************************/

PROCEDURE GET_ACCOUNT_SUBSCRIPTIONS (
    in_group_id    IN  NUMBER,
    in_start_date  IN DATE,
    in_end_date    IN DATE,
    in_status      IN NUMBER,
    in_group_account_type IN VARCHAR2,
    out_result_set OUT SYS_REFCURSOR
) AS
-- VARIABLES
SPROC_NAME     CONSTANT VARCHAR2(25) := 'GET_ACCOUNT_SUBSCRIPTIONS';
var_account_id NUMBER;
-- EXCEPTIONS
BAD_GROUP_ID            EXCEPTION;
BEGIN
  -- Get account id
  BEGIN
    SELECT
      ACCOUNT.ID INTO var_account_id
    FROM
      ACCOUNT
    WHERE
      ACCOUNT.GROUP_ID = in_group_id;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE BAD_GROUP_ID;
  END;

  -- Get information about account subscriptions
  OPEN out_result_set FOR
  SELECT
    in_group_id AS "GROUP_ID",
    SUBSCRIPTION.ID AS "SUBSCRIPTION_ID",
    SUBSCRIPTION.SUBSCRIPTION_STATUS_ID,
    SUBSCRIPTION.PURCHASE_DATE,
    SUBSCRIPTION.SUSPEND_DATE,
    SUBSCRIPTION.REACTIVATION_DATE,
    SUBSCRIPTION.CANCELLATION_DATE,
    SUBSCRIPTION_CANCEL_REASON.VALUE as "CANCEL_TYPE",
    SUBSCRIPTION.INSTRUMENT_ID,
    SUBSCRIPTION.INSTRUMENT_TYPE_ID,
    OFFER_CHAIN.ID AS "OFFER_CHAIN_ID",
    OFFER_CHAIN.NAME,
    OFFER_CHAIN.DESCRIPTION,
    OFFER_CHAIN.PRODUCT_URI,
    PROCS_SUBSCRIPTION_V18.CALC_SUBSCRIPTION_END_DATE(SUBSCRIPTION.ID) as "END_DATE",
    PROCS_SUBSCRIPTION_V18.GET_RECENT_CHARGE(SUBSCRIPTION.ID) AS "RECENT_CHARGE",
    PROCS_SUBSCRIPTION_V18.GET_RENEWAL_DATE(SUBSCRIPTION.ID) AS "RENEWAL_DATE",
    PROCS_SUBSCRIPTION_V18.GET_BILLING_CYCLE(SUBSCRIPTION.ID) AS "BILLING_CYCLE",
    PROCS_SUBSCRIPTION_V18.IS_SUBSCRIPTION_CANCELABLE(SUBSCRIPTION.ID) AS "IS_CANCELABLE",
    ITUNES_RECEIPT.ID AS "ITUNES_RECEIPT_ID",
    (
      SELECT
        MAX(ENTITLEMENT_END_DATE)
        FROM LICENSE
        WHERE LICENSE.SUBSCRIPTION_ID = SUBSCRIPTION.ID
    )
    as "ENT_END_DATE",
    (
      SELECT
        MIN(START_DATE)
        FROM LICENSE
        WHERE LICENSE.SUBSCRIPTION_ID = SUBSCRIPTION.ID
    )
    as "ENT_START_DATE",
    GROUP_ACCOUNT.SUBSCRIPTION_ID GA_SUBSCRIPTION_ID,
    GROUP_ACCOUNT.ID GA_ID,
    GROUP_ACCOUNT.GROUP_NAME GA_GROUP_NAME,
    GROUP_ACCOUNT.FIRST_NAME GA_FIRST_NAME,
    GROUP_ACCOUNT.LAST_NAME GA_LAST_NAME,
    GROUP_ACCOUNT.EMAIL GA_EMAIL,
    GROUP_ACCOUNT.PHONE GA_PHONE,
    GROUP_ACCOUNT.ORGANIZATION_TYPE GA_ORGANIZATION_TYPE,
    GROUP_ACCOUNT.SEATS GA_SEATS,
    PROCS_GROUP_ACCOUNT_V18.F_GET_NUM_OCCUPIED_GROUP_SEATS(GROUP_ACCOUNT.ID) GA_SEATS_USED,
    GROUP_ACCOUNT.IP GA_IP,
    PROCS_SUBSCRIPTION_V18.GET_GIFT_CERT_CODE_BY_SUB_ID(SUBSCRIPTION.ID) GIFT_CERTIFICATE_CODE,
    PROCS_ACCOUNT_V18.GET_GRACE_START_DATE(SUBSCRIPTION.ID) GRACE_START_DATE,
    PROCS_ACCOUNT_V18.GET_GRACE_END_DATE(SUBSCRIPTION.ID) GRACE_END_DATE
  FROM
    SUBSCRIPTION
    INNER JOIN OFFER_CHAIN ON SUBSCRIPTION.OFFER_CHAIN_ID = OFFER_CHAIN.ID
    LEFT JOIN SUBSCRIPTION_CANCEL_REASON ON SUBSCRIPTION.SCT_ID = SUBSCRIPTION_CANCEL_REASON.ID
    LEFT JOIN ITUNES_RECEIPT ON SUBSCRIPTION.ID = ITUNES_RECEIPT.SUBSCRIPTION_ID
    LEFT JOIN GROUP_ACCOUNT ON SUBSCRIPTION.ID = GROUP_ACCOUNT.SUBSCRIPTION_ID
  WHERE
    SUBSCRIPTION.ACCOUNT_ID = var_account_id
    AND (SUBSCRIPTION.SCT_ID IS NULL OR SUBSCRIPTION.SCT_ID != GLOBAL_STATUSES_V18.REAL_TIME_CANCEL_REASON)
    AND SUBSCRIPTION.SUBSCRIPTION_STATUS_ID = NVL(in_status, SUBSCRIPTION.SUBSCRIPTION_STATUS_ID)
    AND PROCS_COMMON_V18.NORMALIZE_DATE(SUBSCRIPTION.PURCHASE_DATE) >= NVL(in_start_date, PROCS_COMMON_V18.NORMALIZE_DATE(SUBSCRIPTION.PURCHASE_DATE))
    AND PROCS_COMMON_V18.NORMALIZE_DATE(SUBSCRIPTION.PURCHASE_DATE) <= NVL(in_end_date, PROCS_COMMON_V18.NORMALIZE_DATE(SUBSCRIPTION.PURCHASE_DATE))
    AND (in_group_account_type IS NULL OR OFFER_CHAIN.GROUP_ACCOUNT_TYPE_ID = in_group_account_type);

EXCEPTION
WHEN BAD_GROUP_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'Can not find account with given group id');
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END GET_ACCOUNT_SUBSCRIPTIONS;

/******************************************************************************/

PROCEDURE FREEZE_ACCOUNT (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND,
APP_EXCEPTION_CODES_V18.INTERNAL_ERROR,
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_group_id   IN NUMBER,
  in_updated_by IN VARCHAR2,
  in_note       IN VARCHAR2,
  in_agent_id   IN NUMBER
) AS
SPROC_NAME            CONSTANT VARCHAR2(14) := 'FREEZE_ACCOUNT';
-- VARIABLES
var_account_id        NUMBER;
var_account_status_id NUMBER;
-- EXCEPTIONS
BAD_GROUP_ID          EXCEPTION;
BAD_ACCOUNT_STATUS_ID EXCEPTION;
CAN_NOT_CREATE_NOTE   EXCEPTION;
EXCEPTION_MESSAGE     VARCHAR2(1024);
BEGIN

  -- Get account status, account id
  BEGIN
    SELECT
      ACCOUNT.ID,
      ACCOUNT.ACCOUNT_STATUS_ID
      into
      var_account_id,
      var_account_status_id
    FROM
      ACCOUNT
    WHERE
      ACCOUNT.GROUP_ID = in_group_id;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE BAD_GROUP_ID;
  END;

  -- We can freeze only ACTIVE accounts
  IF var_account_status_id != GLOBAL_STATUSES_V18.ACCOUNT_ACTIVE
    AND var_account_status_id != GLOBAL_STATUSES_V18.ACCOUNT_FROZEN THEN
    RAISE BAD_ACCOUNT_STATUS_ID;
  END IF;

  -- Set account status
  PROCS_ACCOUNT_V18.UPDATE_ACCOUNT_STATUS(
    in_account_id        => var_account_id,
    in_updated_by        => in_updated_by,
    in_account_status_id => GLOBAL_STATUSES_V18.ACCOUNT_FROZEN
  );

  -- Annotate account
  BEGIN
    PROCS_ACCOUNT_V18.ANNOTATE_ACCOUNT(
      in_group_id   => in_group_id,
      in_agent_id   => in_agent_id,
      in_note       => in_note,
      in_created_by => in_updated_by
    );
    EXCEPTION
      WHEN OTHERS THEN
        EXCEPTION_MESSAGE := SQLERRM;
        RAISE CAN_NOT_CREATE_NOTE;
  END;

EXCEPTION
WHEN BAD_GROUP_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'No such group id');
WHEN BAD_ACCOUNT_STATUS_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.STATE_ERROR,
    SPROC_NAME, 'Could not update this account. Status should to be active or frozen');
WHEN CAN_NOT_CREATE_NOTE THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.INTERNAL_ERROR,
    SPROC_NAME, 'Could not annotate account', EXCEPTION_MESSAGE);
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END FREEZE_ACCOUNT;

/******************************************************************************/

PROCEDURE GET_ACCOUNT_SUBSCR_INVOICES (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND,
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_group_id        IN  NUMBER,
  in_subscription_id IN NUMBER,
  out_result_set     OUT SYS_REFCURSOR
) AS
SPROC_NAME           CONSTANT VARCHAR2(27) := 'GET_ACCOUNT_SUBSCR_INVOICES';
-- VARIABLES
var_account_id       NUMBER;
temp_subscription_id NUMBER;
-- EXCEPTIONS
BAD_GROUP_ID        EXCEPTION;
BAD_SUBSCRIPTION_ID EXCEPTION;
BEGIN
  -- Get account id
  BEGIN
    SELECT
      ACCOUNT.ID into var_account_id
    FROM
      ACCOUNT
    WHERE
      ACCOUNT.GROUP_ID = in_group_id;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE BAD_GROUP_ID;
  END;

  -- Check that subscription exists
  BEGIN
    IF in_subscription_id IS NOT NULL THEN
      SELECT
        SUBSCRIPTION.ID into temp_subscription_id
      FROM
        SUBSCRIPTION
      WHERE
        SUBSCRIPTION.ID = in_subscription_id;
    END IF;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE BAD_SUBSCRIPTION_ID;
  END;

  OPEN out_result_set FOR
  SELECT DISTINCT
    INVOICE.ID as "INVOICE_ID",
    INVOICE.CREATE_DATE,
    INVOICE.INVOICE_STATUS_ID,
    PROCS_INVOICE_V18.F_CALCULATE_INVOICE_AMOUNT(INVOICE.ID) as "AMOUNT",
    OFFER_CHAIN.ID as "OFFER_CHAIN_ID",
    OFFER_CHAIN.NAME as "OFFER_CHAIN_NAME",
    SUBSCRIPTION.ID as "SUBSCRIPTION_ID",
    NULL as "GC_CODE",
    NULL as "GC_ID"	
  FROM
    LICENSE
    INNER JOIN SUBSCRIPTION ON LICENSE.SUBSCRIPTION_ID = SUBSCRIPTION.ID
    INNER JOIN INVOICE ON LICENSE.INVOICE_ID = INVOICE.ID
    INNER JOIN OFFER_CHAIN ON SUBSCRIPTION.OFFER_CHAIN_ID = OFFER_CHAIN.ID
  WHERE
    SUBSCRIPTION.ACCOUNT_ID = var_account_id
    AND (SUBSCRIPTION.SCT_ID IS NULL OR SUBSCRIPTION.SCT_ID != GLOBAL_STATUSES_V18.REAL_TIME_CANCEL_REASON)
    AND SUBSCRIPTION.ID = NVL(in_subscription_id, SUBSCRIPTION.ID);

EXCEPTION
WHEN BAD_GROUP_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'No such account');
WHEN BAD_SUBSCRIPTION_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'No such subscription');
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END GET_ACCOUNT_SUBSCR_INVOICES;

/******************************************************************************/

PROCEDURE GET_ACCOUNT_GC_INVOICES (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND,
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_group_id    IN  NUMBER,
  out_result_set OUT SYS_REFCURSOR
) AS
SPROC_NAME     CONSTANT VARCHAR2(23) := 'GET_ACCOUNT_GC_INVOICES';
-- VARIABLES
var_account_id NUMBER;
-- EXCEPTIONS
BAD_GROUP_ID EXCEPTION;
BEGIN
  -- Get account id
  BEGIN
    SELECT
      ACCOUNT.ID into var_account_id
    FROM
      ACCOUNT
    WHERE
      ACCOUNT.GROUP_ID = in_group_id;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE BAD_GROUP_ID;
  END;

  -- Get invoices
  OPEN out_result_set FOR
  SELECT DISTINCT
    INVOICE.ID as "INVOICE_ID",
    INVOICE.CREATE_DATE,
    INVOICE.INVOICE_STATUS_ID,
    PROCS_INVOICE_V18.F_CALCULATE_INVOICE_AMOUNT(INVOICE.ID) as "AMOUNT",
    OFFER_CHAIN.ID as "OFFER_CHAIN_ID",
    OFFER_CHAIN.NAME as "OFFER_CHAIN_NAME",
    NULL as "SUBSCRIPTION_ID",
    GIFT_CERTIFICATE.CODE as "GC_CODE",
    GIFT_CERTIFICATE.ID as "GC_ID"
  FROM
    GIFT_CERTIFICATE
    INNER JOIN INVOICE ON GIFT_CERTIFICATE.PURCHASE_INVOICE_ID = INVOICE.ID
    INNER JOIN OFFER_CHAIN ON GIFT_CERTIFICATE.OFFER_CHAIN_ID = OFFER_CHAIN.ID
  WHERE
    ROWNUM <= 100 AND
    GIFT_CERTIFICATE.PURCHASER_GROUP_ID = in_group_id;

EXCEPTION
WHEN BAD_GROUP_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'No such account');
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END GET_ACCOUNT_GC_INVOICES;

/******************************************************************************/
-- norlov: #38580
PROCEDURE GET_GC_INVOICE (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND,
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_group_id    IN  NUMBER,
  in_gc_code     IN  VARCHAR2,
  out_result_set OUT SYS_REFCURSOR
) AS
SPROC_NAME     CONSTANT VARCHAR2(14) := 'GET_GC_INVOICE';
-- VARIABLES
var_account_id NUMBER;
-- EXCEPTIONS
BAD_GROUP_ID EXCEPTION;
BEGIN
  -- Get account id
  BEGIN
    SELECT
      ACCOUNT.ID into var_account_id
    FROM
      ACCOUNT
    WHERE
      ACCOUNT.GROUP_ID = in_group_id;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE BAD_GROUP_ID;
  END;

  -- Get invoice for the GC
  OPEN out_result_set FOR
  SELECT DISTINCT
    INVOICE.ID as "INVOICE_ID",
    INVOICE.CREATE_DATE,
    INVOICE.INVOICE_STATUS_ID,
    PROCS_INVOICE_V18.F_CALCULATE_INVOICE_AMOUNT(INVOICE.ID) as "AMOUNT",
    OFFER_CHAIN.ID as "OFFER_CHAIN_ID",
    OFFER_CHAIN.NAME as "OFFER_CHAIN_NAME",
    NULL as "SUBSCRIPTION_ID",
    GIFT_CERTIFICATE.CODE as "GC_CODE"
  FROM
    GIFT_CERTIFICATE
    INNER JOIN INVOICE ON GIFT_CERTIFICATE.PURCHASE_INVOICE_ID = INVOICE.ID
    INNER JOIN OFFER_CHAIN ON GIFT_CERTIFICATE.OFFER_CHAIN_ID = OFFER_CHAIN.ID
  WHERE
    GIFT_CERTIFICATE.PURCHASER_GROUP_ID = in_group_id
    AND GIFT_CERTIFICATE.CODE = in_gc_code;

EXCEPTION
WHEN BAD_GROUP_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'No such account');
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END GET_GC_INVOICE;
/******************************************************************************/

PROCEDURE GET_ACCOUNT_PRODUCTS (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND,
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_group_id    IN  NUMBER,
  out_result_set OUT SYS_REFCURSOR
) AS
SPROC_NAME     CONSTANT VARCHAR2(20) := 'GET_ACCOUNT_PRODUCTS';
-- VARIABLES
var_account_id NUMBER;
-- EXCEPTIONS
BAD_GROUP_ID EXCEPTION;
BEGIN
  -- Get account id
  BEGIN
    SELECT
      ACCOUNT.ID into var_account_id
    FROM
      ACCOUNT
    WHERE
      ACCOUNT.GROUP_ID = in_group_id;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE BAD_GROUP_ID;
  END;

  OPEN out_result_set FOR
  SELECT DISTINCT
    PRODUCT.ID,
    PRODUCT.NAME
  FROM
    PRODUCT
  WHERE
    PRODUCT.ID IN (
      SELECT DISTINCT
        PRODUCT_OFFERING.PRODUCT_ID
      FROM
        PRODUCT_OFFERING
      WHERE
        PRODUCT_OFFERING.ID IN (
          SELECT DISTINCT
            OFFER_PRODUCT_OFFERING.PRODUCT_OFFERING_ID
          FROM
            OFFER_PRODUCT_OFFERING
          WHERE
            OFFER_PRODUCT_OFFERING.OFFER_ID IN (
              SELECT DISTINCT
                OFFER_OFFER_CHAIN.OFFER_ID
              FROM
                OFFER_OFFER_CHAIN
              WHERE
                OFFER_OFFER_CHAIN.OFFER_CHAIN_ID IN (
                  SELECT DISTINCT
                    SUBSCRIPTION.OFFER_CHAIN_ID
                  FROM
                    SUBSCRIPTION
                  WHERE
                    SUBSCRIPTION.ACCOUNT_ID = var_account_id
                )
            )
        )
    );

EXCEPTION
WHEN BAD_GROUP_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'No such account');
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END GET_ACCOUNT_PRODUCTS;

/******************************************************************************/
PROCEDURE GET_ACCOUNT_PROD_OFFERRINGS (
/*
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_group_id IN NUMBER,
  out_result_set     OUT SYS_REFCURSOR
) AS
SPROC_NAME CONSTANT VARCHAR2(27) := 'GET_ACCOUNT_PROD_OFFERRINGS';
-- VARIABLES
var_account_id NUMBER;
-- EXCEPTIONS
BAD_GROUP_ID EXCEPTION;
BEGIN
   -- Get account id
  BEGIN
    SELECT
      ACCOUNT.ID into var_account_id
    FROM
      ACCOUNT
    WHERE
      ACCOUNT.GROUP_ID = in_group_id;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE BAD_GROUP_ID;
  END;

  OPEN out_result_set FOR
  SELECT DISTINCT
    PRODUCT_OFFERING.ID,
    PRODUCT_OFFERING.PRODUCT_ID,
    PRODUCT_OFFERING.TAX_CATEGORY_ID,
    PRODUCT_OFFERING.UNIT_PRICE,
    PRODUCT_OFFERING.QUANTITY,
    PRODUCT_OFFERING.CREATE_DATE,
    PRODUCT_OFFERING.CREATED_BY,
    CAPABILITY.ID CAP_ID,
    CAPABILITY.CODE CAP_CODE,
    CAPABILITY.DESCRIPTION CAP_DESCRIPTION,
    CAPABILITY.SHAREABLE CAP_SHAREABLE
  FROM
    OFFER_PRODUCT_OFFERING
    INNER JOIN PRODUCT_OFFERING ON PRODUCT_OFFERING.ID = OFFER_PRODUCT_OFFERING.PRODUCT_OFFERING_ID
    INNER JOIN CAPABILITY ON PRODUCT_OFFERING.CAPABILITY_ID = CAPABILITY.ID
  WHERE
    OFFER_PRODUCT_OFFERING.OFFER_ID IN (
      SELECT DISTINCT
        OFFER_OFFER_CHAIN.OFFER_ID
      FROM
        OFFER_OFFER_CHAIN
      WHERE
        OFFER_OFFER_CHAIN.OFFER_CHAIN_ID IN (
          SELECT DISTINCT
            SUBSCRIPTION.OFFER_CHAIN_ID
          FROM
            SUBSCRIPTION
          WHERE
            SUBSCRIPTION.ACCOUNT_ID = var_account_id
        )
    );

EXCEPTION
WHEN BAD_GROUP_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'No such account');
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END GET_ACCOUNT_PROD_OFFERRINGS;

/******************************************************************************/

PROCEDURE UPDATE_ACCOUNT_STATUS (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND,
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_account_id        IN ACCOUNT.ID%TYPE,
  in_account_status_id IN ACCOUNT.ACCOUNT_STATUS_ID%TYPE,
  in_updated_by        IN ACCOUNT.UPDATED_BY%TYPE
) AS
SPROC_NAME CONSTANT VARCHAR2(21) := 'UPDATE_ACCOUNT_STATUS';
-- EXCEPTIONS
BAD_ACCOUNT_ID         EXCEPTION;
BAD_STATUS_ID          EXCEPTION;
EXCEPTION_MESSAGE      VARCHAR2(1024);
BEGIN

  IF in_account_status_id != GLOBAL_STATUSES_V18.ACCOUNT_ACTIVE
    AND in_account_status_id != GLOBAL_STATUSES_V18.ACCOUNT_FROZEN
    AND in_account_status_id != GLOBAL_STATUSES_V18.ACCOUNT_DISABLED THEN
    RAISE BAD_STATUS_ID;
  END IF;

  PROCS_ACCOUNT_CRU_V18.UPDATE_ACCOUNT(
    in_account_id        => in_account_id,
    in_account_status_id => in_account_status_id,
    in_updated_by        => in_updated_by
  );

  IF SQL%ROWCOUNT = 0 THEN
    RAISE BAD_ACCOUNT_ID;
  END IF;

EXCEPTION
WHEN BAD_ACCOUNT_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'No such account');
WHEN BAD_STATUS_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.INVALID_PARAMETER,
    SPROC_NAME, 'Bad status id');
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END UPDATE_ACCOUNT_STATUS;

/******************************************************************************/

PROCEDURE GET_NEEDS_ENTTL_LICENSES_NUM (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND,
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_group_id      IN ACCOUNT.GROUP_ID%TYPE,
  out_licenses_num OUT NUMBER
) AS
SPROC_NAME CONSTANT VARCHAR2(28) := 'GET_NEEDS_ENTTL_LICENSES_NUM';
-- VARIABLES
var_account_id     ACCOUNT.GROUP_ID%TYPE;
-- EXCEPTIONS
BAD_ACCOUNT_ID EXCEPTION;
BEGIN
  
  BEGIN
    SELECT
      ACCOUNT.ID into var_account_id
    FROM
      ACCOUNT
    WHERE
      ACCOUNT.GROUP_ID = in_group_id;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE BAD_ACCOUNT_ID;
  END;
  
  SELECT
    COUNT(LICENSE.ID) into out_licenses_num
  FROM
    LICENSE
    INNER JOIN SUBSCRIPTION ON LICENSE.SUBSCRIPTION_ID = SUBSCRIPTION.ID
  WHERE
    SUBSCRIPTION.ACCOUNT_ID = var_account_id
    AND LICENSE.NEEDS_ENTITLEMENTS = GLOBAL_CONSTANTS_V18.TRUE;
  
EXCEPTION
WHEN BAD_ACCOUNT_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'No such group id');
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END GET_NEEDS_ENTTL_LICENSES_NUM;

/******************************************************************************/

PROCEDURE SET_TAX_EXEMPT (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND,
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_group_id  IN NUMBER,
  in_exempt_id IN VARCHAR2
) AS
SPROC_NAME CONSTANT VARCHAR2(14) := 'SET_TAX_EXEMPT';
-- VARIABLES
var_account_id NUMBER;
-- EXCEPTIONS
BAD_GROUP_ID EXCEPTION;
BEGIN
  
  BEGIN
    SELECT
      ACCOUNT.ID into var_account_id
    FROM
      ACCOUNT
    WHERE
      ACCOUNT.GROUP_ID = in_group_id;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE BAD_GROUP_ID;
  END;
  
  UPDATE
    ACCOUNT
  SET
    ACCOUNT.TAX_EXEMPT_ID = in_exempt_id
  WHERE
    ACCOUNT.ID = var_account_id;

EXCEPTION
WHEN BAD_GROUP_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'No such group id');
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END SET_TAX_EXEMPT;

/******************************************************************************/

PROCEDURE IS_TAX_EXEMPT (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND,
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
Return:
  GLOBAL_CONSTANTS_V18.TRUE if ACCOUNT.EXEMPT_ID is not null
  GLOBAL_CONSTANTS_V18.FALSE else
*/
  in_group_id       IN NUMBER,
  out_is_tax_exempt OUT NUMBER
) AS
SPROC_NAME CONSTANT VARCHAR2(13) := 'IS_TAX_EXEMPT';
-- VARIABLES
var_is_tax_exempt ACCOUNT.TAX_EXEMPT_ID%TYPE;
-- EXCEPTIONS
BAD_GROUP_ID EXCEPTION;
BEGIN

  BEGIN
    SELECT
      ACCOUNT.TAX_EXEMPT_ID into var_is_tax_exempt
    FROM
      ACCOUNT
    WHERE
      ACCOUNT.GROUP_ID = in_group_id;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE BAD_GROUP_ID;
  END;

  IF var_is_tax_exempt IS NULL THEN
    out_is_tax_exempt := GLOBAL_CONSTANTS_V18.FALSE;
  ELSE
    out_is_tax_exempt := GLOBAL_CONSTANTS_V18.TRUE;
  END IF;

EXCEPTION
WHEN BAD_GROUP_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'No such group id');
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END IS_TAX_EXEMPT;

/******************************************************************************/

PROCEDURE GET_GROUP_ID_BY_ACCOUNT_ID (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND,
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_account_id IN NUMBER,
  out_group_id  OUT NUMBER
) AS
SPROC_NAME CONSTANT VARCHAR2(26) := 'GET_GROUP_ID_BY_ACCOUNT_ID';
BEGIN

  SELECT
    ACCOUNT.GROUP_ID into out_group_id
  FROM
    ACCOUNT
  WHERE
    ACCOUNT.ID = in_account_id;
  
EXCEPTION
WHEN NO_DATA_FOUND THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'No such account');
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error');
END GET_GROUP_ID_BY_ACCOUNT_ID;

/******************************************************************************/

PROCEDURE GET_ACCOUNT_ID_BY_GROUP_ID (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND,
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_group_id IN NUMBER,
  out_account_id  OUT NUMBER
) AS
SPROC_NAME CONSTANT VARCHAR2(26) := 'GET_ACCOUNT_ID_BY_GROUP_ID';
BEGIN

  SELECT
    ACCOUNT.ID into out_account_id
  FROM
    ACCOUNT
  WHERE
    ACCOUNT.GROUP_ID = in_group_id;

EXCEPTION
WHEN NO_DATA_FOUND THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'No such account');
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error');
END GET_ACCOUNT_ID_BY_GROUP_ID;

/******************************************************************************/

PROCEDURE GET_GROUPS_ID_BY_INVOICE_ID (
/*
This procedure is using for LOCKING only

Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND,
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_invoice_id IN NUMBER,
  out_group_ids OUT SYS_REFCURSOR
) AS
SPROC_NAME CONSTANT VARCHAR2(27) := 'GET_GROUPS_ID_BY_INVOICE_ID';
-- VARIABLES
temp_invoice_id           NUMBER;
var_subscrib_group_id     NUMBER;
var_gc_purchaser_group_id NUMBER;
var_gc_redeemer_group_id  NUMBER;
-- EXCEPTIONS
BAD_INVOICE_ID       EXCEPTION;
CAN_NOT_FIND_ACCOUNT EXCEPTION;
BEGIN
  
  BEGIN
    SELECT
      INVOICE.ID into temp_invoice_id
    FROM
      INVOICE
    WHERE
      INVOICE.ID = in_invoice_id;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE BAD_INVOICE_ID;
  END;
  
  BEGIN
    SELECT DISTINCT
      ACCOUNT.GROUP_ID into var_subscrib_group_id
    FROM
      ACCOUNT
      INNER JOIN SUBSCRIPTION ON SUBSCRIPTION.ACCOUNT_ID = ACCOUNT.ID
      INNER JOIN LICENSE ON LICENSE.SUBSCRIPTION_ID = SUBSCRIPTION.ID
    WHERE
      LICENSE.INVOICE_ID = in_invoice_id;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        var_subscrib_group_id := NULL;
  END;
  
  IF var_subscrib_group_id IS NULL THEN
    BEGIN
      SELECT
        GIFT_CERTIFICATE.PURCHASER_GROUP_ID,
        GIFT_CERTIFICATE.REDEEMER_GROUP_ID
        into
        var_gc_purchaser_group_id,
        var_gc_redeemer_group_id
      FROM
        GIFT_CERTIFICATE
      WHERE
        GIFT_CERTIFICATE.PURCHASE_INVOICE_ID = in_invoice_id
        OR GIFT_CERTIFICATE.FINALIZED_INVOICE_ID = in_invoice_id;
      EXCEPTION
        WHEN NO_DATA_FOUND THEN
          var_gc_purchaser_group_id := NULL;
          var_gc_redeemer_group_id  := NULL;
    END;
  END IF;
  
  IF var_subscrib_group_id IS NULL
    AND var_gc_purchaser_group_id IS NULL
    AND var_gc_redeemer_group_id IS NULL THEN
      RAISE CAN_NOT_FIND_ACCOUNT;
  END IF;

  OPEN out_group_ids FOR
  SELECT GROUP_ID FROM (
    SELECT
      var_subscrib_group_id as "GROUP_ID"
    FROM
      DUAL
    UNION
    SELECT
      var_gc_purchaser_group_id as "GROUP_ID"
    FROM
      DUAL
    UNION
    SELECT
      var_gc_redeemer_group_id as "GROUP_ID"
    FROM
      DUAL
  )
  WHERE
    GROUP_ID IS NOT NULL;

EXCEPTION
WHEN BAD_INVOICE_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'No such invoice');
WHEN CAN_NOT_FIND_ACCOUNT THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'Could not find account for given invoice');
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END GET_GROUPS_ID_BY_INVOICE_ID;

PROCEDURE GET_ACCOUNT_TAX_EXEMPT_ID (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND,
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_group_id       IN NUMBER,
  out_tax_exempt_id OUT VARCHAR2
) AS
SPROC_NAME CONSTANT VARCHAR2(25) := 'GET_ACCOUNT_TAX_EXEMPT_ID';
-- VARIABLES
-- EXCEPTIONS
BEGIN

  SELECT
    ACCOUNT.TAX_EXEMPT_ID into out_tax_exempt_id
  FROM
    ACCOUNT
  WHERE
    ACCOUNT.GROUP_ID = in_group_id;

EXCEPTION
WHEN NO_DATA_FOUND THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'No such account');
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END GET_ACCOUNT_TAX_EXEMPT_ID;

PROCEDURE GET_UPGRADABLE_SUBSCRIPTIONS (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND,
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR

Result has two columns:
subscription_id and offer_chain_id
*/
  in_group_id    IN NUMBER,
  out_result_set OUT SYS_REFCURSOR
) AS
SPROC_NAME CONSTANT VARCHAR2(28) := 'GET_UPGRADABLE_SUBSCRIPTIONS';
-- Variables
var_account_id NUMBER;
-- Exceptions
BAD_GROUP_ID   EXCEPTION;
BEGIN
  
  BEGIN
    SELECT
      ID into var_account_id
    FROM
      ACCOUNT
    WHERE
      GROUP_ID = in_group_id;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE BAD_GROUP_ID;
  END;
  
  OPEN out_result_set FOR
  SELECT
    S.ID as SUBSCRIPTION_ID,
    OCHMD.OFFER_CHAIN_ID
  FROM
    SUBSCRIPTION S
    INNER JOIN OFFER_CHAIN OCH ON OCH.ID = S.OFFER_CHAIN_ID
    INNER JOIN OFFER_CHAIN_META_DATA OCHMD ON (OCHMD.NAME = GLOBAL_CONSTANTS_V18.OCMD_UPGRADABLE_OFFER_CHAIN_ID AND TO_NUMBER(OCHMD.VALUE) = OCH.ID)
  WHERE
    S.ACCOUNT_ID = var_account_id;
  
EXCEPTION
WHEN BAD_GROUP_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'No such account');
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END GET_UPGRADABLE_SUBSCRIPTIONS;

/******************************************************************************/

PROCEDURE GET_USR_ALL_SBSCR_IDS (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND,
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR

Result has two columns:
subscription_id and offer_chain_id
*/
  in_group_id        IN NUMBER,
  out_result_set     OUT SYS_REFCURSOR
) AS
SPROC_NAME CONSTANT VARCHAR2(21) := 'GET_USR_ALL_SBSCR_IDS';
-- VARIABLES
var_account_id NUMBER;
-- EXCEPTIONS
BAD_GROUP_ID EXCEPTION;
BEGIN
  
  BEGIN
    SELECT
      A.ID INTO var_account_id
    FROM
      ACCOUNT A
    WHERE
      A.GROUP_ID = in_group_id;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE BAD_GROUP_ID;
  END;
  
  OPEN out_result_set FOR
  SELECT
    S.ID
  FROM
    SUBSCRIPTION S
  WHERE
    S.ACCOUNT_ID = var_account_id
    AND S.SUBSCRIPTION_STATUS_ID = GLOBAL_STATUSES_V18.SUBSCRIPTION_ACTIVE;
  
EXCEPTION
WHEN BAD_GROUP_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'No such account');
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END GET_USR_ALL_SBSCR_IDS;

/******************************************************************************/

PROCEDURE GET_USR_SBSCR_IDS_BY_OFFCH_IDS (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND,
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
APP_EXCEPTION_CODES_V18.INVALID_PARAMETER

Result has two columns:
subscription_id and offer_chain_id
*/
  in_group_id        IN NUMBER,
  in_offer_chain_ids IN core_owner.NUMBER_TABLE,
  out_result_set     OUT SYS_REFCURSOR
) AS
SPROC_NAME CONSTANT VARCHAR2(30) := 'GET_USR_SBSCR_IDS_BY_OFFCH_IDS';
-- VARIABLES
var_account_id NUMBER;
-- EXCEPTIONS
BAD_GROUP_ID        EXCEPTION;
BAD_OFFER_CHAIN_IDS EXCEPTION;
BEGIN
  
  IF in_offer_chain_ids IS NULL THEN
    RAISE BAD_OFFER_CHAIN_IDS;
  END IF;
  
  BEGIN
    SELECT
      A.ID INTO var_account_id
    FROM
      ACCOUNT A
    WHERE
      A.GROUP_ID = in_group_id;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE BAD_GROUP_ID;
  END;
  
  OPEN out_result_set FOR
  SELECT
    S.ID
  FROM
    SUBSCRIPTION S
  WHERE
    S.ACCOUNT_ID = var_account_id
    AND S.OFFER_CHAIN_ID IN (SELECT * FROM TABLE(in_offer_chain_ids))
    AND S.SUBSCRIPTION_STATUS_ID = GLOBAL_STATUSES_V18.SUBSCRIPTION_ACTIVE;
  
EXCEPTION
WHEN BAD_OFFER_CHAIN_IDS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.INVALID_PARAMETER,
    SPROC_NAME, 'Offer chains ids parameter is null');
WHEN BAD_GROUP_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'No such account');
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END GET_USR_SBSCR_IDS_BY_OFFCH_IDS;

PROCEDURE GET_GROUP_IDS_BY_CC_INFO (
  in_last_four_cc IN CREDIT_CARD.LAST_FOUR_CC%TYPE,
  in_expiration_date IN DATE,
  in_country IN CREDIT_CARD.COUNTRY%TYPE DEFAULT NULL,
  in_postal_code IN CREDIT_CARD.POSTAL_CODE%TYPE DEFAULT NULL,
  in_city IN CREDIT_CARD.CITY%TYPE DEFAULT NULL,
  in_state IN CREDIT_CARD.STATE%TYPE DEFAULT NULL,
  in_credit_card_type_id IN CREDIT_CARD.CREDIT_CARD_TYPE_ID%TYPE DEFAULT NULL,
  in_credit_card_status_id IN CREDIT_CARD.CREDIT_CARD_STATUS_ID%TYPE DEFAULT NULL,
  in_lower_bound IN NUMBER DEFAULT 1,
  in_upper_bound IN NUMBER DEFAULT 11,
  out_result_set OUT SYS_REFCURSOR
) AS
SPROC_NAME CONSTANT VARCHAR2(32) := 'GET_GROUP_IDS_BY_CC_INFO';
BEGIN

  OPEN out_result_set FOR
      SELECT
        distinct /*+ first_rows(in_upper_bound-in_lower_bound) */ a.GROUP_ID GROUP_ID
      FROM
        account a,
        credit_card cc
      WHERE
        cc.expiration_date = in_expiration_date and
        cc.last_four_cc = in_last_four_cc and
        upper(cc.postal_code) = upper(nvl(in_postal_code, cc.postal_code)) and
        upper(cc.city) = upper(nvl(in_city, cc.city)) and
        upper(cc.state) = upper(nvl(in_state, cc.state)) and
        upper(cc.country) = upper(nvl(in_country, cc.country)) and
        cc.credit_card_status_id = nvl(in_credit_card_status_id, cc.credit_card_status_id) and
        cc.credit_card_type_id = nvl(in_credit_card_type_id, cc.credit_card_type_id) and
        a.id = cc.account_id and
        rownum >= in_lower_bound and
        rownum <= in_upper_bound
    ;

EXCEPTION
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END GET_GROUP_IDS_BY_CC_INFO;

END PROCS_ACCOUNT_V18;
.
/

CREATE OR REPLACE PACKAGE BODY "PROCS_PROCESS_RETRY_V18" AS

PROCEDURE LOG_RETRY(
    in_process_name IN VARCHAR2,
    in_generic_id   IN NUMBER,
    in_date         IN VARCHAR2,
    out_success      OUT NUMBER
) AS
SPROC_NAME CONSTANT VARCHAR2(32) := 'PROCS_PROCESS_RETRY_V18';
BEGIN

  out_success := 1;
  INSERT into PROCESS_RETRY_THROTTLE(process_name, generic_id, RETRY_count, create_date, update_date)
  VALUES (in_process_name, in_generic_id, 1, to_date(in_date, 'DD-Mon-YYYY HH24:MI:SS'), sysdate);
  commit;
EXCEPTION
WHEN DUP_VAL_ON_INDEX THEN
  rollback;
  out_success := 0;
WHEN OTHERS THEN
  rollback;
  PROCS_COMMON_V18.THROW_EXCEPTION(CORE_OWNER.APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);

END;

PROCEDURE LOG_RETRY_DATE(
    in_process_name IN VARCHAR2,
    in_generic_id   IN NUMBER,
    in_date         IN DATE,
    out_success      OUT NUMBER
) AS
SPROC_NAME CONSTANT VARCHAR2(32) := 'PROCS_PROCESS_RETRY_V18';
BEGIN

  out_success := 1;
  INSERT into PROCESS_RETRY_THROTTLE(process_name, generic_id, RETRY_count, create_date, update_date)
  VALUES (in_process_name, in_generic_id, 1, in_date, sysdate);
  commit;
EXCEPTION
WHEN DUP_VAL_ON_INDEX THEN
  rollback;
  out_success := 0;
WHEN OTHERS THEN
  rollback;
  PROCS_COMMON_V18.THROW_EXCEPTION(CORE_OWNER.APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);

END;

PROCEDURE DELETE_RETRY(
    in_process_name IN VARCHAR2,
    in_remove_minutes  IN NUMBER
) AS
BEGIN

delete from PROCESS_RETRY_THROTTLE
where
  process_name = in_process_name and
  create_date <= sysdate-in_remove_minutes/1440;
commit;
END;

PROCEDURE GET_SYSDATE (
  out_date  OUT VARCHAR2
) AS
BEGIN
  SELECT to_char(SYSDATE, 'DD-Mon-YYYY HH24:MI:SS') into out_date from dual;
END;

END PROCS_PROCESS_RETRY_V18;
.
/

CREATE OR REPLACE PACKAGE BODY "PROCS_NOTIFICATION_V18" AS

PROCEDURE GET_NOTIFICATION_TYPE_BY_NAME (
/*
Throws exceptions:
CORE_OWNER.APP_EXCEPTION_CODES_V18.NOT_FOUND
CORE_OWNER.APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_notification_type_name IN VARCHAR2,
  out_notification_type_id  OUT NUMBER
) AS
SPROC_NAME CONSTANT VARCHAR2(32) := 'GET_NOTIFICATION_TYPE_BY_NAME';
BEGIN
  SELECT
    NOTIFICATION_TYPE.ID into out_notification_type_id
  FROM
    NOTIFICATION_TYPE
  WHERE
    NOTIFICATION_TYPE.VALUE = in_notification_type_name;
EXCEPTION
WHEN NO_DATA_FOUND THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(CORE_OWNER.APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'No such type');
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(CORE_OWNER.APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END GET_NOTIFICATION_TYPE_BY_NAME;

/******************************************************************/

PROCEDURE ADD_NOTIFICATION (
/*
Throws exceptions:
CORE_OWNER.APP_EXCEPTION_CODES_V18.NOT_FOUND
CORE_OWNER.APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_sender_account_id     IN NUMBER DEFAULT 0,
  in_recipient_group_id    IN NUMBER,
  in_notification_type_id  IN NUMBER,
  in_date_to_notify        IN DATE,
  in_email_template_params IN CLOB
) AS
SPROC_NAME CONSTANT VARCHAR2(32) := 'ADD_NOTIFICATION';
-- VARIABLES
temp_type_count NUMBER;
var_create_date DATE := SYSDATE;
-- EXCEPTIONS
BAD_NOTIFICATION_TYPE_ID EXCEPTION;
CAN_NOT_CREATE_HISTORY   EXCEPTION;
EXCEPTION_MESSAGE        VARCHAR2(1024);
BEGIN

  SELECT
    COUNT(*) into temp_type_count
  FROM
    NOTIFICATION_TYPE
  WHERE
    NOTIFICATION_TYPE.ID = in_notification_type_id;
    
  IF temp_type_count = 0 THEN
    RAISE BAD_NOTIFICATION_TYPE_ID;
  END IF;

  INSERT INTO NOTIFICATION (
    ID,
    ACCOUNT_ID,
    GROUP_ID,
    NOTIFICATION_TYPE_ID,
    NOTIFICATION_STATUS_ID,
    EMAIL_TEMPLATE_PARAMS,
    UPDATE_DATE,
    CREATE_DATE,
    DATE_TO_NOTIFY
  ) VALUES (
    NOT_ID_SEQ.nextVal,
    in_sender_account_id, 
    in_recipient_group_id,
    in_notification_type_id,
    NOTIFICATION_STATUSES_V18.NOTIFICATION_PENDING,
    in_email_template_params,
    var_create_date,
    var_create_date,
    in_date_to_notify
  );
  
  --BEGIN
  --  OPS_HIST_OWNER.PUBLIC_PROCS_OPS_V18.CREATE_NOTIFICATION_HISTORY (
  --    in_account_id               => 0, -- ACCOUNT_ID. Can we delete it?
  --    in_group_id                 => in_recipient_group_id,
  --    notification_reason_type_id => in_notification_type_id,
  --    notification_status_id      => NOTIFICATION_STATUSES_V18.NOTIFICATION_PENDING,
  --    email_template_params       => in_email_template_params,
  --    in_create_date              => var_create_date
  --  );
  --  EXCEPTION
  --    WHEN OTHERS THEN
  --      EXCEPTION_MESSAGE := SQLERRM;
  --      RAISE CAN_NOT_CREATE_HISTORY;
  --END;
  
EXCEPTION
WHEN BAD_NOTIFICATION_TYPE_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(CORE_OWNER.APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'No such notification status');
WHEN CAN_NOT_CREATE_HISTORY THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(CORE_OWNER.APP_EXCEPTION_CODES_V18.INTERNAL_ERROR,
    SPROC_NAME, 'Could not create history', EXCEPTION_MESSAGE);
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(CORE_OWNER.APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END ADD_NOTIFICATION;

/******************************************************************************/

PROCEDURE GET_PENDING_NOTIFICATIONS (
/*
Throws exceptions:
CORE_OWNER.APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  out_result_set OUT SYS_REFCURSOR
) AS
SPROC_NAME CONSTANT VARCHAR2(32) := 'GET_PENDING_NOTIFICATIONS';
-- CONSTANTS
C_NOTIFICATION_COUNT_LIMIT CONSTANT NUMBER := 500;
BEGIN
  OPEN out_result_set FOR
SELECT * FROM
(
  SELECT
    NOTIFICATION.ID
  FROM
    NOTIFICATION
    INNER JOIN NOTIFICATION_TYPE ON NOTIFICATION.NOTIFICATION_TYPE_ID = NOTIFICATION_TYPE.ID
  WHERE
    ROWNUM <= C_NOTIFICATION_COUNT_LIMIT*10
    AND NOT EXISTS (
      SELECT NULL
      FROM PROCESS_RETRY_THROTTLE
      WHERE GENERIC_ID = NOTIFICATION.ID AND PROCESS_NAME = SPROC_NAME
    )
    AND (
      NOTIFICATION.NOTIFICATION_STATUS_ID = NOTIFICATION_STATUSES_V18.NOTIFICATION_PENDING
      OR NOTIFICATION.NOTIFICATION_STATUS_ID = NOTIFICATION_STATUSES_V18.NOTIFICATION_FAILED
    )
    AND (
      NOTIFICATION.DATE_TO_NOTIFY IS NULL OR SYSDATE > NOTIFICATION.DATE_TO_NOTIFY
    )ORDER BY dbms_random.value
) WHERE
  ROWNUM <= C_NOTIFICATION_COUNT_LIMIT;

EXCEPTION
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(CORE_OWNER.APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END GET_PENDING_NOTIFICATIONS;

/******************************************************************************/

PROCEDURE UPDATE_NOTIFICATION_TIMESTAMP (
/*
Throws exceptions:
CORE_OWNER.APP_EXCEPTION_CODES_V18.NOT_FOUND
CORE_OWNER.APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_notification_id IN NUMBER
) AS
SPROC_NAME CONSTANT VARCHAR2(32) := 'UPDATE_NOTIFICATION_TIMESTAMP';
-- VARIABLES
temp_notification_id NUMBER;
-- EXCEPTIONS
BAD_NOTIFICATION_ID EXCEPTION;
BEGIN

  BEGIN
    SELECT
      NOTIFICATION.ID into temp_notification_id
    FROM
      NOTIFICATION
    WHERE
      NOTIFICATION.ID = in_notification_id;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE BAD_NOTIFICATION_ID;
  END;
  
  UPDATE
    NOTIFICATION
  SET
    NOTIFICATION.UPDATE_DATE = sysdate
  WHERE
    NOTIFICATION.ID = in_notification_id;

EXCEPTION
WHEN BAD_NOTIFICATION_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(CORE_OWNER.APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'No such notification');
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(CORE_OWNER.APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END UPDATE_NOTIFICATION_TIMESTAMP;

/******************************************************************************/

PROCEDURE SET_NOTIFICATION_STATUS (
/*
Throws exceptions:
CORE_OWNER.APP_EXCEPTION_CODES_V18.NOT_FOUND
CORE_OWNER.APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_notification_id        IN NUMBER,
  in_notification_status_id IN NUMBER,
  in_error_message          IN VARCHAR2
) AS
SPROC_NAME CONSTANT VARCHAR2(32) := 'SET_NOTIFICATION_STATUS';
-- VARIABLES
var_group_id              NUMBER;
var_account_id            NUMBER;
var_notification_type_id  NUMBER;
var_email_template_params CLOB;
var_create_history_date   DATE := SYSDATE;
var_notification_status_id   NUMBER;
var_date_to_notify        DATE;
max_fails   NUMBER := 5;
num_fails   NUMBER;
-- EXCEPTIONS
BAD_NOTIFICATION_ID        EXCEPTION;
BAD_NOTIFICATION_STATUS_ID EXCEPTION;
CAN_NOT_CREATE_HISTORY     EXCEPTION;
EXCEPTION_MESSAGE          VARCHAR2(1024);
BEGIN

  IF in_notification_status_id != NOTIFICATION_STATUSES_V18.NOTIFICATION_SENT
    AND in_notification_status_id != NOTIFICATION_STATUSES_V18.NOTIFICATION_PENDING
    AND in_notification_status_id != NOTIFICATION_STATUSES_V18.NOTIFICATION_FAILED THEN
    RAISE BAD_NOTIFICATION_STATUS_ID;
  END IF;

  BEGIN
    SELECT
      NOTIFICATION.GROUP_ID,
      NOTIFICATION.ACCOUNT_ID,
      NOTIFICATION.NOTIFICATION_TYPE_ID,
      NOTIFICATION.NOTIFICATION_STATUS_ID,
      NOTIFICATION.EMAIL_TEMPLATE_PARAMS,
      NOTIFICATION.DATE_TO_NOTIFY
      into
      var_group_id,
      var_account_id,
      var_notification_type_id,
      var_notification_status_id,
      var_email_template_params,
      var_date_to_notify
    FROM
      NOTIFICATION
    WHERE
      NOTIFICATION.ID = in_notification_id;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE BAD_NOTIFICATION_ID;
  END;

  BEGIN
    CORE_HIST_OWNER.PUBLIC_PROCS_CORE_V18.CREATE_NOTIFICATION_HISTORY (
      in_notification_id          => in_notification_id,
      in_account_id               => var_account_id,
      in_group_id                 => var_group_id,
      notification_reason_type_id => var_notification_type_id,
      notification_status_id      => var_notification_status_id,
      email_template_params       => var_email_template_params,
      in_create_date              => var_create_history_date,
      in_date_to_notify           => var_date_to_notify
    );
    EXCEPTION
      WHEN OTHERS THEN
        EXCEPTION_MESSAGE := SQLERRM;
        RAISE CAN_NOT_CREATE_HISTORY;
  END;

  UPDATE
    NOTIFICATION
  SET
    NOTIFICATION.NOTIFICATION_STATUS_ID = in_notification_status_id,
    NOTIFICATION.UPDATE_DATE = sysdate
  WHERE
    NOTIFICATION.ID = in_notification_id;

  IF ( in_error_message IS NOT NULL ) THEN
    ADD_NOTIFICATION_FAILURE(
      in_notification_id => in_notification_id,
      in_error_message => in_error_message
    );
  END IF;

  SELECT COUNT(1) INTO num_fails
  FROM NOTIFICATION_FAILURE
  WHERE NOTIFICATION_ID = in_notification_id;

  IF (in_notification_status_id = NOTIFICATION_STATUSES_V18.NOTIFICATION_SENT OR num_fails >= max_fails) then
    FOR REC IN (
        SELECT ID, NOTIFICATION_ID, ERROR_MESSAGE, CREATE_DATE
        FROM NOTIFICATION_FAILURE
        WHERE NOTIFICATION_ID = in_notification_id
        ) LOOP
        BEGIN
          CORE_HIST_OWNER.PUBLIC_PROCS_CORE_V18.CREATE_NOTIF_FAILURE_HISTORY(
            in_error_message         => REC.ERROR_MESSAGE,
            in_notification_id       => REC.NOTIFICATION_ID,
            in_create_date           => REC.CREATE_DATE
          );
          EXCEPTION
            WHEN OTHERS THEN
              EXCEPTION_MESSAGE := SQLERRM;
              RAISE CAN_NOT_CREATE_HISTORY;
        END;
    END LOOP;
    DELETE FROM NOTIFICATION_FAILURE WHERE NOTIFICATION_ID = in_notification_id;

    BEGIN
      SELECT
        NOTIFICATION.GROUP_ID,
        NOTIFICATION.ACCOUNT_ID,
        NOTIFICATION.NOTIFICATION_TYPE_ID,
        NOTIFICATION.NOTIFICATION_STATUS_ID,
        NOTIFICATION.EMAIL_TEMPLATE_PARAMS,
        NOTIFICATION.DATE_TO_NOTIFY
        into
        var_group_id,
        var_account_id,
        var_notification_type_id,
        var_notification_status_id,
        var_email_template_params,
        var_date_to_notify
      FROM
        NOTIFICATION
      WHERE
        NOTIFICATION.ID = in_notification_id;
      EXCEPTION
        WHEN NO_DATA_FOUND THEN
          RAISE BAD_NOTIFICATION_ID;
    END;

    BEGIN
      CORE_HIST_OWNER.PUBLIC_PROCS_CORE_V18.CREATE_NOTIFICATION_HISTORY (
        in_notification_id          => in_notification_id,
        in_account_id               => var_account_id,
        in_group_id                 => var_group_id,
        notification_reason_type_id => var_notification_type_id,
        notification_status_id      => var_notification_status_id,
        email_template_params       => var_email_template_params,
        in_create_date              => var_create_history_date,
        in_date_to_notify           => var_date_to_notify
      );
      EXCEPTION
        WHEN OTHERS THEN
          EXCEPTION_MESSAGE := SQLERRM;
          RAISE CAN_NOT_CREATE_HISTORY;
    END;
 
    DELETE FROM NOTIFICATION WHERE ID = in_notification_id;
    
  END IF;
  commit;

EXCEPTION
WHEN BAD_NOTIFICATION_STATUS_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(CORE_OWNER.APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'Bad notification status');
WHEN BAD_NOTIFICATION_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(CORE_OWNER.APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'No such notification');
WHEN CAN_NOT_CREATE_HISTORY THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(CORE_OWNER.APP_EXCEPTION_CODES_V18.INTERNAL_ERROR,
    SPROC_NAME, 'Could not create history', EXCEPTION_MESSAGE);
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(CORE_OWNER.APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END SET_NOTIFICATION_STATUS;

/******************************************************************************/

PROCEDURE ADD_NOTIFICATION_FAILURE (
/*
Throws exceptions:
CORE_OWNER.APP_EXCEPTION_CODES_V18.NOT_FOUND
CORE_OWNER.APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_notification_id IN NUMBER,
  in_error_message   IN VARCHAR2
) AS
SPROC_NAME CONSTANT VARCHAR2(32) := 'ADD_NOTIFICATION_FAILURE';
-- VARIABLES
temp_notification_id NUMBER;
var_create_date      DATE := SYSDATE;
-- EXCEPTIONS
BAD_NOTIFICATION_ID        EXCEPTION;
CAN_NOT_CREATE_HISTORY     EXCEPTION;
EXCEPTION_MESSAGE          VARCHAR2(1024);
BEGIN

  BEGIN
    SELECT
      NOTIFICATION.ID into temp_notification_id
    FROM
      NOTIFICATION
    WHERE
      NOTIFICATION.ID = in_notification_id;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE BAD_NOTIFICATION_ID;
  END;
  
  INSERT INTO NOTIFICATION_FAILURE (
    ID,
    NOTIFICATION_ID,
    ERROR_MESSAGE,
    CREATE_DATE
  ) VALUES (
    NOTF_ID_SEQ.nextVal,
    in_notification_id,
    in_error_message,
    sysdate
  );
  
  --BEGIN
  --  OPS_HIST_OWNER.PUBLIC_PROCS_OPS_V18.CREATE_NOTIF_FAILURE_HISTORY(
  --    in_error_message         => in_error_message,
  --    in_notification_queue_id => in_notification_id,
  --    in_create_date           => var_create_date
  --  );
  --  EXCEPTION
  --    WHEN OTHERS THEN
  --      EXCEPTION_MESSAGE := SQLERRM;
  --      RAISE CAN_NOT_CREATE_HISTORY;
  --END;
  
EXCEPTION
WHEN BAD_NOTIFICATION_ID THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(CORE_OWNER.APP_EXCEPTION_CODES_V18.NOT_FOUND,
    SPROC_NAME, 'No such notification');
WHEN CAN_NOT_CREATE_HISTORY THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(CORE_OWNER.APP_EXCEPTION_CODES_V18.INTERNAL_ERROR,
    SPROC_NAME, 'Could not create history', EXCEPTION_MESSAGE);
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(CORE_OWNER.APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END ADD_NOTIFICATION_FAILURE;

/******************************************************************************/

PROCEDURE LOCK_PENDING_NOTIFICATION (
/*
Result: GLOBAL_STATUSES.TRUE if notification locked
GLOBA_STATUSES.FALSE - else
*/
  in_notification_id IN NUMBER,
  out_lock_status    OUT NUMBER
) AS
SPROC_NAME CONSTANT VARCHAR2(25) := 'LOCK_PENDING_NOTIFICATION';
-- VARIABLE
temp_notification_id NUMBER;
BEGIN
  SELECT
    NOTIFICATION.ID into temp_notification_id
  FROM
    NOTIFICATION
  WHERE
    NOTIFICATION.ID = in_notification_id
    AND (
      NOTIFICATION.NOTIFICATION_STATUS_ID = NOTIFICATION_STATUSES_V18.NOTIFICATION_PENDING
      OR NOTIFICATION.NOTIFICATION_STATUS_ID = NOTIFICATION_STATUSES_V18.NOTIFICATION_FAILED
    )
  FOR UPDATE;

  out_lock_status := 1;

EXCEPTION
WHEN NO_DATA_FOUND THEN
  out_lock_status := 0;
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(CORE_OWNER.APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END LOCK_PENDING_NOTIFICATION;

/******************************************************************************/

PROCEDURE GET_NOTIFICATION_DATA (
  in_notification_id IN NUMBER,
  out_result_set     OUT SYS_REFCURSOR
) AS
SPROC_NAME CONSTANT VARCHAR2(21) := 'GET_NOTIFICATION_DATA';
BEGIN
  OPEN out_result_set FOR
  SELECT
    NOTIFICATION.ID,
    NOTIFICATION.GROUP_ID,
    NOTIFICATION.EMAIL_TEMPLATE_PARAMS,
    NOTIFICATION.NOTIFICATION_STATUS_ID,
    NOTIFICATION.CREATE_DATE,
    NOTIFICATION.UPDATE_DATE,
    NOTIFICATION.NOTIFICATION_TYPE_ID,
    NOTIFICATION_TYPE.VALUE as "TYPE_VALUE",
    NOTIFICATION_TYPE.TEMPLATE_URL
  FROM
    NOTIFICATION
    INNER JOIN NOTIFICATION_TYPE ON NOTIFICATION.NOTIFICATION_TYPE_ID = NOTIFICATION_TYPE.ID
  WHERE
    NOTIFICATION.ID = in_notification_id;

EXCEPTION
WHEN OTHERS THEN
  PROCS_COMMON_V18.THROW_EXCEPTION(CORE_OWNER.APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END GET_NOTIFICATION_DATA;

END PROCS_NOTIFICATION_V18;
.
/

CREATE OR REPLACE PACKAGE BODY "PUBLIC_PROCS_BILLING_V18" AS

PROCEDURE GET_OFFER_CHAIN_BY_ID (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
    in_offer_chain_id IN   NUMBER,
    out_result_set    OUT  SYS_REFCURSOR
) AS
BEGIN
  PROCS_OFFER_CHAIN_V18.GET_OFFER_CHAIN_BY_ID (
    in_offer_chain_id => in_offer_chain_id,
    out_result_set => out_result_set
  );
END GET_OFFER_CHAIN_BY_ID;

PROCEDURE GET_PENDING_INVOICES (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  out_result_set1      OUT SYS_REFCURSOR,
  out_result_set2      OUT SYS_REFCURSOR,
  out_result_set3      OUT SYS_REFCURSOR,
  in_row_number        IN NUMBER DEFAULT NULL
) AS
BEGIN
  PROCS_INVOICE_V18.GET_PENDING_INVOICES(
    out_result_set1,
    out_result_set2,
    out_result_set3,
    in_row_number
  );
END GET_PENDING_INVOICES;

/********************************************************/
PROCEDURE GET_PENDING_REFUND_CHARGES (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  out_result_set      OUT SYS_REFCURSOR,
  in_row_number       IN NUMBER DEFAULT NULL
) AS
BEGIN
  PROCS_CHARGE_V18.GET_PENDING_REFUND_CHARGES(
    out_result_set,
    in_row_number
  );
END GET_PENDING_REFUND_CHARGES;
/********************************************************/

PROCEDURE GET_UNPROCESSED_CHARGES (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_invoice_id  IN NUMBER,
  out_result_set OUT SYS_REFCURSOR
) AS
BEGIN
  PROCS_CHARGE_V18.GET_UNPROCESSED_CHARGES(
    in_invoice_id,
    out_result_set
  );
END GET_UNPROCESSED_CHARGES;

/********************************************************/

PROCEDURE GET_PROCESSED_CHARGES (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_invoice_id  IN NUMBER,
  out_result_set OUT SYS_REFCURSOR
) AS
BEGIN
  PROCS_CHARGE_V18.GET_PROCESSED_CHARGES(
    in_invoice_id,
    out_result_set
  );
END GET_PROCESSED_CHARGES;

/********************************************************/

PROCEDURE GET_TRNSCTN_ATTEMPTS_BY_STATUS (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_transaction_id             IN NUMBER,
  in_transaction_attempt_status IN NUMBER,
  out_result_set                OUT SYS_REFCURSOR
) AS
BEGIN
  PROCS_TRANSACTION_V18.GET_TRNSCTN_ATTEMPTS_BY_STATUS(
    in_transaction_id,
    in_transaction_attempt_status,
    out_result_set
  );
END GET_TRNSCTN_ATTEMPTS_BY_STATUS;

/********************************************************/

PROCEDURE UPDATE_TRNSCTN_ATTEMPT_STATUS (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_transaction_attempt_id     IN NUMBER,
  in_transaction_attempt_status IN NUMBER
) AS
BEGIN
  PROCS_TRANSACTION_V18.UPDATE_TRNSCTN_ATTEMPT_STATUS(
     in_transaction_attempt_id,
     in_transaction_attempt_status
  );
END UPDATE_TRNSCTN_ATTEMPT_STATUS;

/********************************************************/
PROCEDURE GET_CLOSED_REFUNDS_BY_INVOICE (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_invoice_id   IN  NUMBER,
  out_result_set OUT SYS_REFCURSOR
) AS
BEGIN
  PROCS_TRANSACTION_V18.GET_CLOSED_REFUNDS_BY_INVOICE(
     in_invoice_id,
     out_result_set
  );
END GET_CLOSED_REFUNDS_BY_INVOICE;

/********************************************************/

PROCEDURE UPDATE_TRNSCTN_ATTEMPT_TIME (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_transaction_attempt_id IN NUMBER,
  in_updated_by             IN VARCHAR2
) AS
BEGIN
  PROCS_TRANSACTION_V18.UPDATE_TRNSCTN_ATTEMPT_TIME(
    in_transaction_attempt_id,
    in_updated_by
  );
END UPDATE_TRNSCTN_ATTEMPT_TIME;

/********************************************************/

PROCEDURE CREATE_TRANSACTION_ATTEMPT (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_transaction_id          IN NUMBER,
  in_trans_attempt_status    IN NUMBER,
  in_external_status_code    IN VARCHAR2,
  in_external_status_message IN VARCHAR2,
  in_created_by              IN VARCHAR2,
  in_ext_transaction_id      IN VARCHAR2,
  out_transaction_attempt_id OUT NUMBER
) AS
BEGIN
  PROCS_TRANSACTION_V18.CREATE_TRANSACTION_ATTEMPT(
    in_transaction_id,
    in_trans_attempt_status,
    in_external_status_code,
    in_external_status_message,
    in_created_by,
    in_ext_transaction_id,
    out_transaction_attempt_id
  );
END CREATE_TRANSACTION_ATTEMPT;

/********************************************************/

PROCEDURE UPDATE_TRANSACTION_ATTEMPT_INF (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_transaction_attempt_id IN NUMBER,
  in_ext_status_code        IN VARCHAR2,
  in_ext_status_message     IN VARCHAR2,
  in_ext_transaction_id     IN VARCHAR2
) AS
BEGIN
  PROCS_TRANSACTION_V18.UPDATE_TRANSACTION_ATTEMPT_INF(
    in_transaction_attempt_id,
    in_ext_status_code,
    in_ext_status_message,
    in_ext_transaction_id
  );
END UPDATE_TRANSACTION_ATTEMPT_INF;

/********************************************************/

PROCEDURE UPDATE_TRANSACTION_STATUS (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_transaction_id        IN NUMBER,
  in_updated_by            IN VARCHAR2,
  in_transaction_status_id IN NUMBER
) AS
BEGIN
  PROCS_TRANSACTION_V18.UPDATE_TRANSACTION_STATUS(
    in_transaction_id,
    in_updated_by,
    in_transaction_status_id
  );
END UPDATE_TRANSACTION_STATUS;

/********************************************************/

PROCEDURE GET_FAILED_ATTEMPTS_NUMBER (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND
*/
  in_transaction_id IN  NUMBER,
  out_attempts_num  OUT NUMBER
) AS
BEGIN
  PROCS_TRANSACTION_V18.GET_FAILED_ATTEMPTS_NUMBER(
    in_transaction_id,
    out_attempts_num
  );
END GET_FAILED_ATTEMPTS_NUMBER;

/********************************************************/

PROCEDURE IS_TRANSACTION_SUCCESSFULL (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_transaction_id IN  NUMBER,
  out_is_successfull  OUT NUMBER
) AS
BEGIN
  PROCS_TRANSACTION_V18.IS_TRANSACTION_SUCCESSFULL(
    in_transaction_id,
    out_is_successfull
  );
END IS_TRANSACTION_SUCCESSFULL;
/********************************************************/

PROCEDURE UPDATE_INVOICE_STATUS (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_invoice_id                  IN NUMBER,
  in_invoice_status_id           IN NUMBER,
  in_updated_by                  IN VARCHAR2
) AS
BEGIN
  PROCS_INVOICE_V18.UPDATE_INVOICE_STATUS(
    in_invoice_id,
    in_invoice_status_id,
    in_updated_by
  );
END UPDATE_INVOICE_STATUS;

/********************************************************/

PROCEDURE SUSPEND_SUBSCRIPTION(
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.INTERNAL_ERROR
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
    in_subs_id    IN NUMBER ,
    in_updated_by IN VARCHAR2
) AS
BEGIN
  PROCS_SUBSCRIPTION_V18.SUSPEND_SUBSCRIPTION(
    in_subs_id,
    in_updated_by
  );
END SUSPEND_SUBSCRIPTION;

/********************************************************/

PROCEDURE GET_CREDIT_CARD_BY_ID (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_credit_card_id IN  NUMBER,
  out_result_set    OUT SYS_REFCURSOR
) AS
BEGIN
  PROCS_FIN_INSTRUMENTS_V18.GET_CREDIT_CARD_BY_ID(
    in_credit_card_id,
    out_result_set
  );
END GET_CREDIT_CARD_BY_ID;

/*********************************************************/

PROCEDURE GET_TRANSACTION_AMOUNT (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_transaction_id      IN  NUMBER,
  out_transaction_amount OUT NUMBER
) AS
BEGIN
  PROCS_TRANSACTION_V18.GET_TRANSACTION_AMOUNT(
    in_transaction_id,
    out_transaction_amount
  );
END GET_TRANSACTION_AMOUNT;

/***********************************************************/

PROCEDURE GET_ACCOUNT_BY_INVOICE_ID (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_invoice_id  IN  NUMBER,
  out_account_id OUT NUMBER
) AS
BEGIN
  PROCS_INVOICE_V18.GET_ACCOUNT_BY_INVOICE_ID(
    in_invoice_id,
    out_account_id
  );
END GET_ACCOUNT_BY_INVOICE_ID;

/************************************************************/

PROCEDURE GET_GIFT_CERTIFICATE_BY_ID (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND,
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_gift_certificate_id IN NUMBER,
  out_result_set         OUT SYS_REFCURSOR
) AS
BEGIN
  PROCS_FIN_INSTRUMENTS_V18.GET_GIFT_CERTIFICATE_BY_ID (
    in_gift_certificate_id,
    out_result_set
  );
END GET_GIFT_CERTIFICATE_BY_ID;

/**************************************************************/

PROCEDURE GET_SUBSCR_ID_BY_CHARGE_ID (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_charge_id        IN NUMBER,
  out_subscription_id OUT NUMBER
) AS
BEGIN
  PROCS_CHARGE_V18.GET_SUBSCR_ID_BY_CHARGE_ID(
    in_charge_id,
    out_subscription_id
  );
END GET_SUBSCR_ID_BY_CHARGE_ID;

/**************************************************************/

PROCEDURE IS_GCERT_FOR_PROPER_OFFER (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_gift_certificate_id IN NUMBER,
  in_charge_id           IN NUMBER,
  out_result             OUT NUMBER
) AS
BEGIN
  PROCS_FIN_INSTRUMENTS_V18.IS_GCERT_FOR_PROPER_OFFER (
    in_gift_certificate_id,
    in_charge_id,
    out_result
  );
END IS_GCERT_FOR_PROPER_OFFER;

/**************************************************************/

PROCEDURE GET_SUBSCRIPTION_INFO (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
    in_subscription_id IN  NUMBER,
    out_result_set      OUT SYS_REFCURSOR
) AS
BEGIN
  PROCS_SUBSCRIPTION_V18.GET_SUBSCRIPTION_INFO (
    in_subscription_id,
    out_result_set
  );
END GET_SUBSCRIPTION_INFO;

/****************************************************************/

PROCEDURE CALCULATE_INVOICE_AMOUNT (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_invoice_id IN  NUMBER,
  out_amount    OUT NUMBER
) AS
BEGIN
  PROCS_INVOICE_V18.CALCULATE_INVOICE_AMOUNT (
    in_invoice_id,
    out_amount
  );
END CALCULATE_INVOICE_AMOUNT;

/****************************************************************/

PROCEDURE GET_TRANSACTION_BY_ID (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_transaction_id IN NUMBER,
  out_result_set    OUT SYS_REFCURSOR
) AS
BEGIN
  PROCS_TRANSACTION_V18.GET_TRANSACTION_BY_ID(
    in_transaction_id,
    out_result_set
  );
END GET_TRANSACTION_BY_ID;

/****************************************************************/

PROCEDURE UPDATE_CHARGE_STATUS (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_charge_id        IN CHARGE.ID%TYPE,
  in_charge_status_id IN CHARGE.CHARGE_STATUS_ID%TYPE,
  in_updated_by       IN CHARGE.UPDATED_BY%TYPE
) AS
BEGIN
  PROCS_CHARGE_V18.UPDATE_CHARGE_STATUS(
    in_charge_id,
    in_charge_status_id,
    in_updated_by
  );
END UPDATE_CHARGE_STATUS;

/****************************************************************/

PROCEDURE GET_GC_BY_PURCH_INVOICE_ID (
  in_invoice_id           IN GIFT_CERTIFICATE.PURCHASE_INVOICE_ID%TYPE,
  out_result_set OUT SYS_REFCURSOR
) AS
BEGIN
  PROCS_FIN_INSTRUMENTS_V18.GET_GC_BY_PURCH_INVOICE_ID(
    in_invoice_id,
    out_result_set 
  );
END GET_GC_BY_PURCH_INVOICE_ID;

/****************************************************************/

PROCEDURE UPDATE_TRANSACTION_ORDER_ID (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.INTRNAL_ERROR
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_transaction_id IN TRANSACTION.ID%TYPE,
  in_order_id       IN TRANSACTION.ORDER_ID%TYPE,
  in_updated_by     IN TRANSACTION.UPDATED_BY%TYPE
) AS
BEGIN
  PROCS_TRANSACTION_V18.UPDATE_TRANSACTION_ORDER_ID(
    in_transaction_id,
    in_order_id,
    in_updated_by
  );
END UPDATE_TRANSACTION_ORDER_ID;

/****************************************************************/

PROCEDURE GET_ACTIVE_INVOICES_IDS (
/*
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
--  in_subscription_id IN SUBSCRIPTION.ID%TYPE,
  in_subscription_id IN NUMBER,
  out_result_set     OUT SYS_REFCURSOR
) AS
BEGIN
  PROCS_SUBSCRIPTION_V18.GET_ACTIVE_INVOICES_IDS(
    in_subscription_id, 
    out_result_set
  );
END GET_ACTIVE_INVOICES_IDS;

/****************************************************************/

PROCEDURE CANCEL_SUBSCRIPTION_INVOICE (
/*
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
APP_EXCEPTION_CODES_V18.INTERNAL_ERROR
*/
--  in_invoice_id        IN INVOICE.ID%TYPE,
--  in_updated_by        IN INVOICE.UPDATED_BY%TYPE,
-- norlov: in_refundable        IN refund enabled
  in_invoice_id        IN NUMBER,
  in_updated_by        IN VARCHAR2,
  in_refundable        IN NUMBER DEFAULT GLOBAL_CONSTANTS_V18.FALSE
--  in_cancellation_date IN DATE DEFAULT current_timestamp
) AS
BEGIN
  PROCS_SUBSCRIPTION_V18.CANCEL_SUBSCRIPTION_INVOICE(
    in_invoice_id,
    in_updated_by,
    in_refundable
  );
END CANCEL_SUBSCRIPTION_INVOICE;

/****************************************************************/

PROCEDURE FINALIZE_CANCELATION (
/*
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
APP_EXCEPTION_CODES_V18.INTERNAL_ERROR
*/
--  in_subscription_id    IN SUBSCRIPTION.ID%TYPE,
--  in_cancelation_reason IN SUBSCRIPTION_CANCEL_REASON.VALUE%TYPE,
--  in_cancelation_date   IN SUBSCRIPTION.CANCELLATION_DATE%TYPE,
--  in_note               IN SUBSCRIPTION_NOTE.NOTE%TYPE,
--  in_agent_id           IN SUBSCRIPTION_NOTE.AGENT_ID%TYPE,
--  in_updated_by         IN SUBSCRIPTION.UPDATED_BY%TYPE
  in_subscription_id    IN NUMBER,
  in_cancelation_reason IN VARCHAR2,
  in_cancelation_date   IN DATE,
  in_note               IN VARCHAR2,
  in_agent_id           IN NUMBER,
  in_updated_by         IN VARCHAR2
) AS
BEGIN
  PROCS_SUBSCRIPTION_V18.FINALIZE_CANCELATION(
    in_subscription_id,
    in_cancelation_reason,
    in_cancelation_date,
    in_note,
    in_agent_id,
    in_updated_by
  );
END FINALIZE_CANCELATION;

/****************************************************************/

PROCEDURE GET_SUBSCR_PROD_OFFERRINGS (
/*
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_subscription_id IN NUMBER,
  out_result_set     OUT SYS_REFCURSOR
) AS
BEGIN
  PROCS_SUBSCRIPTION_V18.GET_SUBSCR_PROD_OFFERRINGS(
    in_subscription_id,
    out_result_set
  );
END GET_SUBSCR_PROD_OFFERRINGS;

/****************************************************************/

PROCEDURE GET_OFFER_CHAIN_META_DATA (
/*
Throws exceptions (codes):
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_offer_chain_id IN NUMBER,
  in_meta_data_name IN VARCHAR2,
  out_result_set    OUT SYS_REFCURSOR
)AS
BEGIN
  PROCS_OFFER_CHAIN_V18.GET_OFFER_CHAIN_META_DATA(
    in_offer_chain_id,
    in_meta_data_name,
    out_result_set
  );
END GET_OFFER_CHAIN_META_DATA;

/****************************************************************/

PROCEDURE GET_PRODUCT_OFFERING_META_DATA (
/*
Throws exceptions (codes):
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_product_offering_id IN NUMBER,
  in_meta_data_name      IN VARCHAR2 DEFAULT NULL,
  out_result_set         OUT SYS_REFCURSOR
)AS
BEGIN
  PROCS_OFFER_CHAIN_V18.GET_PRODUCT_OFFERING_META_DATA(
    in_product_offering_id,
    in_meta_data_name,
    out_result_set
  );
END GET_PRODUCT_OFFERING_META_DATA;

/****************************************************************/

PROCEDURE READ_ACCOUNT (
  in_account_id  IN ACCOUNT.ID%TYPE,
  out_result_set OUT SYS_REFCURSOR
)AS
BEGIN
  PROCS_ACCOUNT_CRU_V18.READ_ACCOUNT(
    in_account_id,
    out_result_set
  );
END READ_ACCOUNT;

/****************************************************************/

PROCEDURE GET_COLLECTED_CHARGES (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_invoice_id  IN NUMBER,
  out_result_set OUT SYS_REFCURSOR
) AS
BEGIN
  PROCS_CHARGE_V18.GET_COLLECTED_CHARGES(
    in_invoice_id,
    out_result_set
  );
END GET_COLLECTED_CHARGES;

/****************************************************************/

PROCEDURE GET_GROUPS_ID_BY_INVOICE_ID (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND,
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_invoice_id IN NUMBER,
  out_group_ids OUT SYS_REFCURSOR
) AS
BEGIN
  
  PROCS_ACCOUNT_V18.GET_GROUPS_ID_BY_INVOICE_ID(
    in_invoice_id,
    out_group_ids
  );
  
END GET_GROUPS_ID_BY_INVOICE_ID;

/****************************************************************/

PROCEDURE GET_ACCOUNT_ID_BY_GROUP_ID (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND,
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_group_id IN NUMBER,
  out_account_id  OUT NUMBER
) AS
BEGIN
  
  PROCS_ACCOUNT_V18.GET_ACCOUNT_ID_BY_GROUP_ID(
    in_group_id,
    out_account_id
  );
  
END GET_ACCOUNT_ID_BY_GROUP_ID;

/****************************************************************/

PROCEDURE LOCK_ACCOUNT (
  in_group_id    IN NUMBER,
  in_lock_key    IN VARCHAR2,
  in_seconds_num IN NUMBER,
  in_created_by  IN VARCHAR2,
  in_reason      IN VARCHAR2
) AS
BEGIN
  PROCS_LOCKING_V18.LOCK_ACCOUNT(
    in_group_id,
    in_lock_key,
    in_seconds_num,
    in_created_by,
    in_reason
  );
END LOCK_ACCOUNT;

/****************************************************************/

PROCEDURE RELEASE_LOCK (
  in_group_id IN NUMBER,
  in_lock_key IN VARCHAR2
) AS
BEGIN
  PROCS_LOCKING_V18.RELEASE_LOCK(
    in_group_id,
    in_lock_key
  );
END RELEASE_LOCK;

PROCEDURE GET_PAYMENT_INFO_BY_INVOICE_ID (
  in_invoice_id               IN NUMBER,
  out_order_id                OUT VARCHAR2,
  out_external_transaction_id OUT VARCHAR2
) AS
BEGIN
  PROCS_INVOICE_V18.GET_PAYMENT_INFO_BY_INVOICE_ID(
    in_invoice_id,
    out_order_id,
    out_external_transaction_id
  );
END GET_PAYMENT_INFO_BY_INVOICE_ID;

/******************************************************************************/

PROCEDURE GET_PAYPAL_BY_ID (
  in_paypal_id   IN  NUMBER,
  out_result_set OUT SYS_REFCURSOR
) AS
BEGIN
  PROCS_FIN_INSTRUMENTS_V18.GET_PAYPAL_BY_ID(
    in_paypal_id,
    out_result_set
  );
END GET_PAYPAL_BY_ID;

PROCEDURE GET_NEXT_ATTEMPT_NUMBER (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_charge_id   in  number,
  out_attempt_count out number
) as
begin
  PROCS_TRANSACTION_V18.GET_NEXT_ATTEMPT_NUMBER(
    in_charge_id,
    out_attempt_count
  );
end GET_NEXT_ATTEMPT_NUMBER;

PROCEDURE GET_NOTIFICATION_TYPE_ID (
  in_offer_chain_id        IN NUMBER,
  in_action_name           IN VARCHAR2,
  out_notification_type_id out number
) as
begin
  PROCS_OFFER_CHAIN_V18.GET_NOTIFICATION_TYPE_ID(
    in_offer_chain_id,
    in_action_name,
    out_notification_type_id
  );
end GET_NOTIFICATION_TYPE_ID;

PROCEDURE GET_GC_ID_BY_PURCH_INVOICE_ID (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
in_invoice_id IN GIFT_CERTIFICATE.PURCHASE_INVOICE_ID%TYPE,
out_gift_certificate_id OUT GIFT_CERTIFICATE.ID%TYPE
) AS
BEGIN
PROCS_FIN_INSTRUMENTS_V18.GET_GC_ID_BY_PURCH_INVOICE_ID(
in_invoice_id,
out_gift_certificate_id
);
END GET_GC_ID_BY_PURCH_INVOICE_ID;

/****************************************************************************/

PROCEDURE SHOULD_MOVE_TO_GRACE(
  in_invoice_id  IN INVOICE.ID%TYPE,
  out_result     OUT NUMBER
) AS
BEGIN
  -- if the invoice preceding the given invoice has no transaction attempts, then
  -- it is not billed out of Sartre. if so, then the associated subscription
  -- should be canceled after a final failed billing attempt--not moved to grace.
  SELECT DECODE(COUNT(1), 0, 0, 1) INTO out_result
  FROM CHARGE c
  INNER JOIN TRANSACTION t ON c.TRANSACTION_ID = t.ID
  INNER JOIN TRANSACTION_ATTEMPT ta ON ta.TRANSACTION_ID = t.ID
  WHERE c.INVOICE_ID = (
    -- select previous invoice_id, or -1 if there is none
    SELECT PREV_INVOICE_ID FROM (
      SELECT i.ID, LAG(i.ID, 1, -1) OVER (ORDER BY i.CREATE_DATE) AS PREV_INVOICE_ID
      FROM INVOICE i
      INNER JOIN LICENSE l ON i.ID = l.INVOICE_ID
      WHERE l.SUBSCRIPTION_ID = (
        SELECT SUBSCRIPTION_ID FROM LICENSE WHERE INVOICE_ID = in_invoice_id
      )
    ) WHERE ID = in_invoice_id
  );
END SHOULD_MOVE_TO_GRACE;

/****************************************************************************/

PROCEDURE MOVE_TO_GRACE(
  in_invoice_id                 IN INVOICE.ID%TYPE,
  in_updated_by                 IN LICENSE.UPDATED_BY%TYPE,
  in_grace_period_length_hours  IN NUMBER
) AS
BEGIN
  PROCS_SUBSCRIPTION_V18.START_GRACE_BY_INVOICE_ID(
    in_invoice_id        => in_invoice_id,
    in_updater           => in_updated_by,
    in_duration_in_hours => in_grace_period_length_hours
  );
END MOVE_TO_GRACE;

/****************************************************************************/

PROCEDURE MOVE_OUT_OF_GRACE(
  in_invoice_id   IN INVOICE.ID%TYPE,
  in_updated_by   IN LICENSE.UPDATED_BY%TYPE
) AS
BEGIN
  PROCS_SUBSCRIPTION_V18.STOP_GRACE_BY_INVOICE_ID(
    in_invoice_id => in_invoice_id,
    in_updater    => in_updated_by
  );
END MOVE_OUT_OF_GRACE;

END PUBLIC_PROCS_BILLING_V18;
.
/

CREATE OR REPLACE PACKAGE BODY "PUBLIC_PROCS_NOTIFICATION_V18" AS

PROCEDURE LOCK_ACCOUNT (
  in_group_id    IN NUMBER,
  in_lock_key    IN VARCHAR2,
  in_seconds_num IN NUMBER,
  in_created_by  IN VARCHAR2,
  in_reason      IN VARCHAR2
) AS
BEGIN
  PROCS_LOCKING_V18.LOCK_ACCOUNT(
    in_group_id,
    in_lock_key,
    in_seconds_num,
    in_created_by,
    in_reason
  );
END LOCK_ACCOUNT;

/******************************************************************************/

PROCEDURE RELEASE_LOCK (
  in_group_id IN NUMBER,
  in_lock_key IN VARCHAR2
) AS
BEGIN
  PROCS_LOCKING_V18.RELEASE_LOCK(
    in_group_id,
    in_lock_key
  );
END RELEASE_LOCK;

END PUBLIC_PROCS_NOTIFICATION_V18;
.
/

CREATE OR REPLACE PACKAGE BODY "PUBLIC_PROCS_RENEWAL_V18" AS

PROCEDURE SUB_EXPIRES_NEED_ENTITLEMENTS (
  out_result_set OUT SYS_REFCURSOR
) AS
BEGIN
  PROCS_GROUP_ACCOUNT_V18.SUB_EXPIRES_NEED_ENTITLEMENTS(out_result_set => out_result_set);
END SUB_EXPIRES_NEED_ENTITLEMENTS;

PROCEDURE UPDATE_SS_NEED_ENTITLEMENTS (
  in_sub_share_id      IN SUBSCRIPTION_SHARE.ID%TYPE,
  in_need_entitlements IN SUBSCRIPTION_SHARE.NEEDS_ENTITLEMENTS%TYPE,
  in_updater           IN SUBSCRIPTION_SHARE.UPDATED_BY%TYPE
) AS
BEGIN
  PROCS_GROUP_ACCOUNT_V18.UPDATE_SS_NEED_ENTITLEMENTS(
    in_sub_share_id => in_sub_share_id,
    in_need_entitlements => in_need_entitlements,
    in_updater => in_updater
  );
END UPDATE_SS_NEED_ENTITLEMENTS;

PROCEDURE GET_OFFER_CHAIN_BY_ID (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
    in_offer_chain_id IN   NUMBER,
    out_result_set    OUT  SYS_REFCURSOR
) AS
BEGIN
  PROCS_OFFER_CHAIN_V18.GET_OFFER_CHAIN_BY_ID (
    in_offer_chain_id => in_offer_chain_id,
    out_result_set => out_result_set
  );
END GET_OFFER_CHAIN_BY_ID;

PROCEDURE GET_OFFER_CHAIN_META_DATA (
/*
Throws exceptions (codes):
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_offer_chain_id IN NUMBER,
  in_meta_data_name IN VARCHAR2,
  out_result_set    OUT SYS_REFCURSOR
)AS
BEGIN
  PROCS_OFFER_CHAIN_V18.GET_OFFER_CHAIN_META_DATA(
    in_offer_chain_id,
    in_meta_data_name,
    out_result_set
  );
END GET_OFFER_CHAIN_META_DATA;

PROCEDURE GET_ENDING_LICENSES (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_hours_number IN NUMBER,
  out_result_set OUT SYS_REFCURSOR
) AS
BEGIN
  PROCS_LICENSE_V18.GET_ENDING_LICENSES(in_hours_number,out_result_set);
END GET_ENDING_LICENSES;

PROCEDURE GET_ENDING_LICENSES_CC (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_hours_number IN NUMBER,
  out_result_set OUT SYS_REFCURSOR,
  in_process_name         IN PROCESS_RETRY_THROTTLE.PROCESS_NAME%TYPE
) AS
BEGIN
  PROCS_LICENSE_V18.GET_ENDING_LICENSES_CC(in_hours_number,out_result_set, in_process_name);
END GET_ENDING_LICENSES_CC;

/*******************************************************/

PROCEDURE GET_RECURRING_OFFER (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_license_id  IN NUMBER,
  out_result_set OUT SYS_REFCURSOR
) AS
BEGIN
  PROCS_LICENSE_V18.GET_RECURRING_OFFER (
    in_license_id,
    out_result_set
  );
END GET_RECURRING_OFFER;

/********************************************************/

PROCEDURE GET_NEXT_OFFER (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.INTERNAL_ERROR
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_license_id  IN NUMBER,
  out_result_set OUT SYS_REFCURSOR
) AS
BEGIN
  PROCS_LICENSE_V18.GET_NEXT_OFFER (
    in_license_id,
    out_result_set
  );
END GET_NEXT_OFFER;

/*********************************************************/

PROCEDURE UPDATE_LICENSE_STATUS(
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
    in_license_id     IN NUMBER,
    in_license_status IN NUMBER,
    in_updated_by     IN VARCHAR2
) AS
BEGIN
  PROCS_LICENSE_V18.UPDATE_LICENSE_STATUS (
    in_license_id,
    in_license_status,
    in_updated_by
  );
END UPDATE_LICENSE_STATUS;

/**********************************************************/

PROCEDURE UPDATE_INVOICE_STATUS (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_invoice_id                  IN NUMBER,
  in_invoice_status_id           IN NUMBER,
  in_updated_by                  IN VARCHAR2
) AS
BEGIN
  PROCS_INVOICE_V18.UPDATE_INVOICE_STATUS(
    in_invoice_id,
    in_invoice_status_id,
    in_updated_by
  );
END UPDATE_INVOICE_STATUS;

/***********************************************************/

PROCEDURE CREATE_LICENSE(
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
APP_EXCEPTION_CODES_V18.INTERNAL_ERROR
*/
  in_status_id                IN NUMBER,
  in_needs_entitlements       IN NUMBER,
  in_start_date               IN DATE,
  in_end_date                 IN DATE,
  in_offer_id                 IN NUMBER,
  in_subscription_id          IN NUMBER,
  in_invoice_id               IN NUMBER,
  in_created_by               IN VARCHAR2,
  in_is_extension             IN NUMBER,
  in_current_offer_index      IN NUMBER,
  in_current_offer_recurr_num IN NUMBER,
  out_license_id              OUT NUMBER
) AS
BEGIN
  PROCS_LICENSE_V18.CREATE_LICENSE (
    in_status_id,
    in_needs_entitlements,
    in_start_date,
    in_end_date,
    in_offer_id,
    in_subscription_id,
    in_invoice_id,
    in_created_by,
    in_is_extension,
    in_current_offer_index,
    in_current_offer_recurr_num,
    out_license_id
  );
END CREATE_LICENSE;

/******************************************************/

PROCEDURE CREATE_INVOICE(
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
    in_invoice_status IN NUMBER,
    in_created_by     IN VARCHAR2,
    in_tax_exempt_id  IN VARCHAR2,
    out_invoice_id    OUT NUMBER
) AS
BEGIN
  PROCS_INVOICE_V18.CREATE_INVOICE (
    in_invoice_status,
    in_created_by,
    in_tax_exempt_id,
    out_invoice_id
  );
END CREATE_INVOICE;

/*******************************************************/

PROCEDURE CREATE_CHARGE(
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_invoice_id         IN NUMBER,
  in_transaction_id     IN NUMBER,
  in_instrument_type_id IN NUMBER,
  in_instrument_id      IN NUMBER,
  in_charge_amount      IN NUMBER,
  in_created_by         IN VARCHAR2,
  in_charge_status_id   IN NUMBER,
  out_charge_id         OUT NUMBER
) AS
BEGIN
  PROCS_CHARGE_V18.CREATE_CHARGE (
    in_invoice_id,
    in_transaction_id,
    in_instrument_type_id,
    in_instrument_id,
    in_charge_amount,
    in_created_by,
    in_charge_status_id,
    out_charge_id
  );
END CREATE_CHARGE;

/**********************************************************/

PROCEDURE HAS_FUTURE_LICENSE (
/*
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
--
RETURNS:
1 - if has,
0 - else
*/
  in_license_id IN NUMBER,
  out_result         OUT NUMBER
) AS
BEGIN
  PROCS_SUBSCRIPTION_V18.HAS_FUTURE_LICENSE (
    in_license_id,
    out_result
  );
END HAS_FUTURE_LICENSE;

/***********************************************************/

PROCEDURE GET_GROUP_ID_BY_LICENSE_ID (
/*
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_license_id IN NUMBER,
  out_group_id  OUT NUMBER
) AS
BEGIN
  PROCS_LICENSE_V18.GET_GROUP_ID_BY_LICENSE_ID (
    in_license_id,
    out_group_id
  );
END GET_GROUP_ID_BY_LICENSE_ID;

/**********************************************************/

PROCEDURE GET_OFFER_PRODUCTS (
/*
Throws exceptions (codes):
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_offer_id    IN NUMBER,
  out_result_set OUT SYS_REFCURSOR
) AS
BEGIN
  PROCS_OFFER_CHAIN_V18.GET_OFFER_PRODUCTS (
    in_offer_id,
    out_result_set
  );
END GET_OFFER_PRODUCTS;

/***********************************************************/

PROCEDURE CREATE_TRANSACTION (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_transaction_id         IN NUMBER,
  in_status_id              IN NUMBER,
  in_amount                 IN NUMBER,
  in_created_by             IN VARCHAR2,
  in_order_id               IN VARCHAR2,
  in_transaction_type_code  IN VARCHAR2 DEFAULT NULL,
  out_transaction_id        OUT NUMBER
) AS
BEGIN
  PROCS_TRANSACTION_V18.CREATE_TRANSACTION(
    in_transaction_id,
    in_status_id,
    in_amount,
    in_created_by,
    in_order_id,
    GLOBAL_CONSTANTS_V18.FALSE, -- is_refund should be false in renewal
    in_transaction_type_code,
    out_transaction_id
  );
END CREATE_TRANSACTION;

/************************************************************/

PROCEDURE ADD_LINE_ITEMS(
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_invoice_id IN NUMBER,
  in_offer_id   IN NUMBER,
  in_created_by IN VARCHAR2
) AS
BEGIN
  PROCS_LINE_ITEMS_V18.ADD_LINE_ITEMS(
    in_invoice_id,
    in_offer_id,
    in_created_by
  );
END ADD_LINE_ITEMS;

/************************************************************/

PROCEDURE CALCULATE_INVOICE_AMOUNT (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_invoice_id IN  NUMBER,
  out_amount    OUT NUMBER
) AS
BEGIN
  PROCS_INVOICE_V18.CALCULATE_INVOICE_AMOUNT (
    in_invoice_id,
    out_amount
  );
END CALCULATE_INVOICE_AMOUNT;

/*************************************************************/

PROCEDURE RESERVE_TRANSACTION_ID (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  out_transaction_id OUT NUMBER
) AS
BEGIN
  PROCS_TRANSACTION_V18.RESERVE_TRANSACTION_ID (
    out_transaction_id
  );
END RESERVE_TRANSACTION_ID;

/***************************************************************/

PROCEDURE P_GET_NEXT_OFFER_INDEX (
  in_offer_chain_id            IN NUMBER,
  in_offer_chain_current_index IN NUMBER,
  out_next_offer_index         OUT NUMBER
) AS
BEGIN
  PROCS_OFFER_CHAIN_V18.P_GET_NEXT_OFFER_INDEX(
    in_offer_chain_id,
    in_offer_chain_current_index,
    out_next_offer_index
  );
END P_GET_NEXT_OFFER_INDEX;

/***************************************************************/

PROCEDURE GET_NEXT_OFFER_INDEX_BY_LCNS (
  in_license_id                IN NUMBER,
  in_offer_chain_current_index IN NUMBER,
  out_next_offer_index         OUT NUMBER
) AS
BEGIN
  PROCS_OFFER_CHAIN_V18.GET_NEXT_OFFER_INDEX_BY_LCNS(
    in_license_id,
    in_offer_chain_current_index,
    out_next_offer_index
  );
END GET_NEXT_OFFER_INDEX_BY_LCNS;

/******************************************************************/

PROCEDURE GET_SUBSCRIPTION_INFO (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
    in_subscription_id IN  NUMBER,
    out_result_set      OUT SYS_REFCURSOR
) AS
BEGIN
  PROCS_SUBSCRIPTION_V18.GET_SUBSCRIPTION_INFO(
    in_subscription_id,
    out_result_set
  );
END GET_SUBSCRIPTION_INFO;

/*******************************************************************/

PROCEDURE CLOSE_SUBSCRIPTION (
  in_subscription_id IN NUMBER,
  in_updated_by      IN VARCHAR2
) AS
BEGIN
  PROCS_SUBSCRIPTION_V18.CLOSE_SUBSCRIPTION(
    in_subscription_id,
    in_updated_by
  );
END CLOSE_SUBSCRIPTION;

/*******************************************************************/

PROCEDURE GET_NEED_ENTITLEMENTS_LICENSES (
  out_result_set OUT SYS_REFCURSOR
) AS
BEGIN
  PROCS_LICENSE_V18.GET_NEED_ENTITLEMENTS_LICENSES(
    out_result_set
  );
END GET_NEED_ENTITLEMENTS_LICENSES;

/*******************************************************************/

PROCEDURE UPDATE_NEED_ENTITLEMENTS_FLAG (
  in_license_id         IN NUMBER,
  in_needs_entitlements IN NUMBER,
  in_updated_by         IN VARCHAR2
) AS
BEGIN
  PROCS_LICENSE_V18.UPDATE_NEED_ENTITLEMENTS_FLAG(
    in_license_id,
    in_needs_entitlements,
    in_updated_by
  );
END UPDATE_NEED_ENTITLEMENTS_FLAG;

/*******************************************************/

PROCEDURE GET_PROD_OFFERINGS_BY_OFFER_ID (
/*
Throws exceptions (codes):
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_offer_id    IN NUMBER,
  out_result_set OUT SYS_REFCURSOR
) AS
BEGIN
  PROCS_OFFER_CHAIN_V18.GET_PROD_OFFERINGS_BY_OFFER_ID(in_offer_id,out_result_set);
END GET_PROD_OFFERINGS_BY_OFFER_ID;

/*******************************************************/
PROCEDURE GET_PRODUCT_OFFERING_META_DATA (
/*
Throws exceptions (codes):
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_product_offering_id IN NUMBER,
  in_meta_data_name      IN VARCHAR2 DEFAULT NULL,
  out_result_set         OUT SYS_REFCURSOR
) AS
BEGIN
  PROCS_OFFER_CHAIN_V18.GET_PRODUCT_OFFERING_META_DATA(in_product_offering_id,in_meta_data_name,out_result_set);
END GET_PRODUCT_OFFERING_META_DATA;

/*******************************************************/

PROCEDURE LOCK_ACCOUNT (
  in_group_id    IN NUMBER,
  in_lock_key    IN VARCHAR2,
  in_seconds_num IN NUMBER,
  in_created_by  IN VARCHAR2,
  in_reason      IN VARCHAR2
) AS
BEGIN
  PROCS_LOCKING_V18.LOCK_ACCOUNT(
    in_group_id,
    in_lock_key,
    in_seconds_num,
    in_created_by,
    in_reason
  );
END LOCK_ACCOUNT;

/****************************************************************/

PROCEDURE RELEASE_LOCK (
  in_group_id IN NUMBER,
  in_lock_key IN VARCHAR2
) AS
BEGIN
  PROCS_LOCKING_V18.RELEASE_LOCK(
    in_group_id,
    in_lock_key
  );
END RELEASE_LOCK;

/******************************************************************************/

PROCEDURE GET_INVOICE_LINE_ITEMS (
  in_invoice_id  IN NUMBER,
  out_result_set OUT SYS_REFCURSOR
) AS
BEGIN
  PROCS_INVOICE_V18.GET_INVOICE_LINE_ITEMS(
    in_invoice_id,
    out_result_set
  );
END GET_INVOICE_LINE_ITEMS;

/******************************************************************************/

PROCEDURE ADD_TAX (
  in_tax_type_id           IN NUMBER,
  in_calculated_amount     IN NUMBER,
  in_created_by            IN VARCHAR2,
  in_line_item_id          IN NUMBER,
  in_effective_rate        IN VARCHAR2,
  in_taxable_amount        IN NUMBER,
  in_tax_rule_id           IN NUMBER,
  in_jurisdiction_level_id IN NUMBER,
  in_jurisdiction_name     IN VARCHAR2,
  in_jurisdiction_id       IN VARCHAR2,
  in_ext_tax_type          IN VARCHAR2,
  in_ext_result            IN VARCHAR2,
  in_imposition_type       IN VARCHAR2,
  in_imposition            IN VARCHAR2
) AS
BEGIN
  PROCS_TAXES_V18.ADD_TAX(
    in_tax_type_id,
    in_calculated_amount,
    in_created_by,
    in_line_item_id,
    in_effective_rate,
    in_taxable_amount,
    in_tax_rule_id,
    in_jurisdiction_level_id,
    in_jurisdiction_name,
    in_jurisdiction_id,
    in_ext_tax_type,
    in_ext_result,
    in_imposition_type,
    in_imposition
  );
END ADD_TAX;

/******************************************************************************/

PROCEDURE GET_CREDIT_CARD_BY_ID (
  in_credit_card_id IN  NUMBER,
  out_result_set    OUT SYS_REFCURSOR
) AS
BEGIN
  PROCS_FIN_INSTRUMENTS_V18.GET_CREDIT_CARD_BY_ID(
    in_credit_card_id,
    out_result_set
  );
END GET_CREDIT_CARD_BY_ID;

/******************************************************************************/

PROCEDURE GET_PRD_OFFERING_BY_LINE_IT_ID (
  in_line_item_id IN NUMBER,
  out_result_set  OUT SYS_REFCURSOR
) AS
BEGIN
  PROCS_PRODUCT_V18.GET_PRD_OFFERING_BY_LINE_IT_ID(
    in_line_item_id,
    out_result_set
  );
END GET_PRD_OFFERING_BY_LINE_IT_ID;

/******************************************************************************/

PROCEDURE GET_ACCOUNT_ID_BY_GROUP_ID (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND,
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_group_id IN NUMBER,
  out_account_id  OUT NUMBER
) AS
BEGIN
  PROCS_ACCOUNT_V18.GET_ACCOUNT_ID_BY_GROUP_ID(
    in_group_id,
    out_account_id
  );
END GET_ACCOUNT_ID_BY_GROUP_ID;

/******************************************************************************/

PROCEDURE GET_LINE_ITEM_DISCOUNTS (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V18.NOT_FOUND
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_line_item_id IN  NUMBER,
  out_result_set  OUT SYS_REFCURSOR
) AS
BEGIN
  PROCS_LINE_ITEMS_V18.GET_LINE_ITEM_DISCOUNTS(
    in_line_item_id,
    out_result_set
  );
END GET_LINE_ITEM_DISCOUNTS;

/******************************************************************************/

PROCEDURE UPDATE_LINE_ITEM_AMOUNT (
  in_line_item_id    IN NUMBER,
  in_amount          IN NUMBER,
  in_discount_amount IN NUMBER,
  in_taxes_amount    IN NUMBER
) AS
BEGIN
  PROCS_LINE_ITEMS_V18.UPDATE_LINE_ITEM_AMOUNT(
    in_line_item_id,
    in_amount,
    in_discount_amount,
    in_taxes_amount
  );
END UPDATE_LINE_ITEM_AMOUNT;

/******************************************************************************/

PROCEDURE GET_PAYPAL_BY_ID (
  in_paypal_id   IN  NUMBER,
  out_result_set OUT SYS_REFCURSOR
) AS
BEGIN
  PROCS_FIN_INSTRUMENTS_V18.GET_PAYPAL_BY_ID(
    in_paypal_id,
    out_result_set
  );
END GET_PAYPAL_BY_ID;

PROCEDURE GET_GC_BY_PURCH_INVOICE_ID (
  in_invoice_id           IN GIFT_CERTIFICATE.PURCHASE_INVOICE_ID%TYPE,
  out_result_set OUT SYS_REFCURSOR
) AS
BEGIN
  PROCS_FIN_INSTRUMENTS_V18.GET_GC_BY_PURCH_INVOICE_ID (
    in_invoice_id,
    out_result_set
  );
END GET_GC_BY_PURCH_INVOICE_ID;

PROCEDURE GET_LICENSE_BY_ID (
  in_license_id  IN NUMBER,
  out_result_set OUT SYS_REFCURSOR
) AS
BEGIN
  PROCS_LICENSE_V18.GET_LICENSE_BY_ID (
    in_license_id,
    out_result_set
  );
END GET_LICENSE_BY_ID;

/******************************************************************************/

PROCEDURE GET_NOTIFICATION_TYPE_ID (
  in_offer_chain_id        IN NUMBER,
  in_action_name           IN VARCHAR2,
  out_notification_type_id OUT NUMBER
) AS
BEGIN
  PROCS_OFFER_CHAIN_V18.GET_NOTIFICATION_TYPE_ID(
    in_offer_chain_id,
    in_action_name,
    out_notification_type_id
  );
END GET_NOTIFICATION_TYPE_ID;

/******************************************************************************/

PROCEDURE GET_ALL_OCH_META_DATA (
  in_offer_chain_id IN NUMBER,
  out_result_set    OUT SYS_REFCURSOR
) AS
BEGIN
  PROCS_OFFER_CHAIN_V18.GET_ALL_META_DATA (
    in_offer_chain_id,
    out_result_set
  );
END GET_ALL_OCH_META_DATA;

/******************************************************************************/

PROCEDURE GET_SUBSCRIPTIONS_META_DATA (
/*
APP_EXCEPTION_CODES_V18.INVALID_PARAMETER
APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_subscriptions_ids IN core_owner.NUMBER_TABLE,
  out_result_set       OUT SYS_REFCURSOR
) AS
BEGIN
  PROCS_SUBSCRIPTION_V18.GET_SUBSCRIPTIONS_META_DATA(
    in_subscriptions_ids,
    out_result_set
  );
END GET_SUBSCRIPTIONS_META_DATA;

PROCEDURE GET_UNREDEEMED_GCS (
  out_result_set          OUT SYS_REFCURSOR,
  in_hours_number         IN NUMBER DEFAULT 14*24,
  in_num_rows             IN NUMBER DEFAULT 10000,
  in_process_name         IN PROCESS_RETRY_THROTTLE.PROCESS_NAME%TYPE
) AS
BEGIN
  PROCS_FIN_INSTRUMENTS_V18.GET_UNREDEEMED_GCS(
    out_result_set => out_result_set,
    in_hours_number => in_hours_number,
    in_num_rows => in_num_rows,
    in_process_name => in_process_name
  );
END GET_UNREDEEMED_GCS;

PROCEDURE GET_OFFER_CHAIN_MD_VALUE (
  in_offer_chain_id IN NUMBER,
  in_meta_data_name IN VARCHAR2,
  out_value         OUT VARCHAR2
) AS
BEGIN
  PROCS_OFFER_CHAIN_V18.GET_OFFER_CHAIN_MD_VALUE(
    in_offer_chain_id => in_offer_chain_id,
    in_meta_data_name => in_meta_data_name,
    out_value => out_value
  );
END GET_OFFER_CHAIN_MD_VALUE;

PROCEDURE GET_ACT_SUBS_W_CPT_CHARGEBACKS (
  out_result_set      OUT SYS_REFCURSOR
)
AS
BEGIN
  PROCS_SUBSCRIPTION_V18.GET_ACT_SUBS_W_CPT_CHARGEBACKS(
    out_result_set => out_result_set
  );
END GET_ACT_SUBS_W_CPT_CHARGEBACKS;

PROCEDURE GET_ACT_SUBS_W_PP_CHARGEBACKS (
  out_result_set      OUT SYS_REFCURSOR
)
AS
BEGIN
  PROCS_SUBSCRIPTION_V18.GET_ACT_SUBS_W_PP_CHARGEBACKS(
    out_result_set => out_result_set
  );
END GET_ACT_SUBS_W_PP_CHARGEBACKS;

PROCEDURE GET_GRACE_PERIOD_SUB_REGIS (
  in_max_days_until_close IN NUMBER,
  in_num_subs_to_fetch    IN NUMBER,
  out_result_set          OUT SYS_REFCURSOR
)
AS
BEGIN
  PROCS_SUBSCRIPTION_V18.GET_GRACE_PERIOD_SUB_REGIS(
    in_max_days_until_close => in_max_days_until_close,
    in_num_subs_to_fetch => in_num_subs_to_fetch,
    out_result_set => out_result_set
  );
END GET_GRACE_PERIOD_SUB_REGIS;

PROCEDURE GET_ACT_SUBS_W_AMEX_CB (
  out_result_set      OUT SYS_REFCURSOR
)
AS
BEGIN
  PROCS_SUBSCRIPTION_V18.GET_ACT_SUBS_W_AMEX_CB(
    out_result_set => out_result_set
  );
END GET_ACT_SUBS_W_AMEX_CB;

PROCEDURE GET_GRACE_LICE_FOR_FINAL_TRANS (
  in_days_before_close     IN NUMBER,
  in_num_licenses_to_fetch IN NUMBER,
  out_result_set           OUT SYS_REFCURSOR
) AS
BEGIN
  PROCS_LICENSE_V18.GET_GRACE_LICE_FOR_FINAL_TRANS(
    in_days_before_close => in_days_before_close,
    in_num_licenses_to_fetch => in_num_licenses_to_fetch,
    out_result_set => out_result_set
  );
END GET_GRACE_LICE_FOR_FINAL_TRANS;

END PUBLIC_PROCS_RENEWAL_V18;
.
/

CREATE OR REPLACE PACKAGE BODY "PUBLIC_PROCS_CLIENT_V18" AS

PROCEDURE GET_NOTIFICATION_TYPE_BY_NAME (
/*
Throws exceptions:
CORE_OWNER.APP_EXCEPTION_CODES_V18.NOT_FOUND
CORE_OWNER.APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_notification_type_name IN VARCHAR2,
  out_notification_type_id  OUT NUMBER
) AS
BEGIN
  PROCS_NOTIFICATION_V18.GET_NOTIFICATION_TYPE_BY_NAME (
    in_notification_type_name,
    out_notification_type_id
  );
END;

/*****************************************************************/

PROCEDURE ADD_NOTIFICATION (
/*
Throws exceptions:
CORE_OWNER.APP_EXCEPTION_CODES_V18.NOT_FOUND
CORE_OWNER.APP_EXCEPTION_CODES_V18.UNKNOWN_ERROR
*/
  in_sender_account_id     IN NUMBER DEFAULT 0,
  in_recipient_group_id    IN NUMBER,
  in_notification_type_id  IN NUMBER,
  in_date_to_notify        IN DATE,
  in_email_template_params IN CLOB
) AS
BEGIN
  PROCS_NOTIFICATION_V18.ADD_NOTIFICATION (
    in_sender_account_id,
    in_recipient_group_id,
    in_notification_type_id,
    in_date_to_notify,
    in_email_template_params
  );
END;

END PUBLIC_PROCS_CLIENT_V18;
.
/

grant execute on CORE_OWNER.PROCS_ACCOUNT_V18 to core_app;
grant execute on CORE_OWNER.PROCS_ADX_V18 to core_app;
grant execute on CORE_OWNER.PROCS_CHARGE_V18 to core_app;
grant execute on CORE_OWNER.PROCS_COMMON_V18 to core_app;
grant execute on CORE_OWNER.PROCS_FIN_INSTRUMENTS_V18 to core_app;
grant execute on CORE_OWNER.PROCS_INVOICE_V18 to core_app;
grant execute on CORE_OWNER.PROCS_LICENSE_V18 to core_app;
grant execute on CORE_OWNER.PROCS_LINE_ITEMS_V18 to core_app;
grant execute on CORE_OWNER.PROCS_OFFER_CHAIN_V18 to core_app;
grant execute on CORE_OWNER.PROCS_PRODUCT_V18 to core_app;
grant execute on CORE_OWNER.PROCS_SUBSCRIPTION_V18 to core_app;
grant execute on CORE_OWNER.PROCS_SYSTEM_V18 to core_app;
grant execute on CORE_OWNER.PROCS_TEST_V18 to core_app;
grant execute on CORE_OWNER.PROCS_TRANSACTION_V18 to core_app;
grant execute on CORE_OWNER.PROCS_TAXES_V18 to core_app;
grant execute on CORE_OWNER.PROCS_LOCKING_V18 to core_app;
grant execute on CORE_OWNER.PROCS_ADJUSTMENTS_V18 to core_app;
grant execute on CORE_OWNER.PUBLIC_PROCS_BILLING_V18 to core_app;
grant execute on CORE_OWNER.PROCS_ADDRESS_V18 to core_app;
grant execute on CORE_OWNER.PROCS_GROUP_ACCOUNT_V18 to core_app;

grant execute on CORE_OWNER.PUBLIC_PROCS_BILLING_V18 to core_billing_app;
grant execute on CORE_OWNER.PUBLIC_PROCS_RENEWAL_V18 to core_licensing_app;
grant execute on CORE_OWNER.PROCS_GROUP_ACCOUNT_V18 to core_licensing_app;
grant execute on CORE_OWNER.PUBLIC_PROCS_NOTIFICATION_V18 to ops_notif_app;


grant execute on CORE_OWNER.PROCS_TAXES_V18 to core_tax_app;
grant execute on CORE_OWNER.PROCS_PRODUCT_V18 to core_tax_app;
grant execute on CORE_OWNER.PROCS_ACCOUNT_V18 to core_tax_app;

grant execute on CORE_OWNER.PROCS_POLLING_SYNC to core_poller_app;

grant execute on CORE_OWNER.PROCS_RECONCILIATION_CRU_V18 to etl_app;
grant execute on CORE_OWNER.PROCS_SUBSCRIPTION_V18 to etl_app;
grant execute on CORE_OWNER.PROCS_TRANSACTION_V18 to etl_app;
grant execute on CORE_OWNER.PROCS_REPORTING to etl_app;
grant execute on CORE_OWNER.PROCS_LOCKING_V18 to etl_app;
grant execute on CORE_OWNER.PROCS_ACCOUNT_V18 to etl_app;
grant execute on CORE_OWNER.PROCS_INVOICE_V18 to etl_app;

grant execute on CORE_OWNER.PROCS_ITUNES_RECEIPT_V18 to core_app;
grant execute on CORE_OWNER.PROCS_ITUNES_RECEIPT_V18 to core_subup_app;
grant execute on CORE_OWNER.PROCS_AMAZON_V18 to core_app;
grant execute on CORE_OWNER.PROCS_AMAZON_V18 to core_subup_app;
grant execute on CORE_OWNER.PROCS_LICENSE_V18 to core_subup_app;
grant execute on CORE_OWNER.PROCS_LOCKING_V18 to core_subup_app;

grant execute on CORE_OWNER.PROCS_SUBSCRIPTION_V18 to core_subup_app;
grant execute on CORE_OWNER.PROCS_GROUP_ACCOUNT_V18 to core_app;
grant execute on CORE_OWNER.PROCS_GROUP_ACCOUNT_CRU_V18 to core_app;
grant execute on CORE_OWNER.PROCS_ENTITLEMENT_V18 to core_app;

grant execute on CORE_OWNER.PROCS_CUPY to cupy_app;
grant execute on CORE_OWNER.PROCS_LOCKING_V18 to cupy_app;

grant execute on CORE_OWNER.NOTIFICATION_STATUSES_V18 to ops_aaa_app;
grant execute on CORE_OWNER.PROCS_NOTIFICATION_V18 to ops_aaa_app;
grant execute on CORE_OWNER.PROCS_SYSTEM_V18 to ops_aaa_app;

grant execute on CORE_OWNER.NOTIFICATION_STATUSES_V18 to ops_payment_app;
grant execute on CORE_OWNER.PROCS_NOTIFICATION_V18 to ops_payment_app;
grant execute on CORE_OWNER.PROCS_SYSTEM_V18 to ops_payment_app;

grant execute on CORE_OWNER.NOTIFICATION_STATUSES_V18 to ops_notif_app;
grant execute on CORE_OWNER.PROCS_NOTIFICATION_V18 to ops_notif_app;
grant execute on CORE_OWNER.PROCS_SYSTEM_V18 to ops_notif_app;

grant execute on CORE_OWNER.PUBLIC_PROCS_CLIENT_V18 to core_licensing_app;
grant execute on CORE_OWNER.PUBLIC_PROCS_CLIENT_V18 to core_billing_app;
grant execute on CORE_OWNER.PUBLIC_PROCS_CLIENT_V18 to core_app;
grant execute on CORE_OWNER.PUBLIC_PROCS_CLIENT_V18 to cupy_app;

grant execute on CORE_OWNER.PROCS_PROCESS_RETRY_V18 to cupy_app;
grant execute on CORE_OWNER.PROCS_PROCESS_RETRY_V18 to core_owner;
grant execute on CORE_OWNER.PROCS_PROCESS_RETRY_V18 to core_app;
grant execute on CORE_OWNER.PROCS_PROCESS_RETRY_V18 to core_billing_app;
grant execute on CORE_OWNER.PROCS_PROCESS_RETRY_V18 to core_licensing_app;
grant execute on CORE_OWNER.PROCS_PROCESS_RETRY_V18 to ops_notif_app;
grant execute on CORE_OWNER.PROCS_PROCESS_RETRY_V18 to etl_app;
grant execute on CORE_OWNER.PROCS_PROCESS_RETRY_V18 to core_subup_app;
grant execute on CORE_OWNER.PROCS_PROCESS_RETRY_V18 to core_poller_app;
grant execute on CORE_OWNER.PROCS_PROCESS_RETRY_V18 to core_subup_app;

grant select on CORE_OWNER.PROCESS_RETRY_THROTTLE to cupy_app;
grant select on CORE_OWNER.PROCESS_RETRY_THROTTLE to core_owner;
grant select on CORE_OWNER.PROCESS_RETRY_THROTTLE to core_app;
grant select on CORE_OWNER.PROCESS_RETRY_THROTTLE to core_billing_app;
grant select on CORE_OWNER.PROCESS_RETRY_THROTTLE to core_licensing_app;
grant select on CORE_OWNER.PROCESS_RETRY_THROTTLE to core_subup_app;

grant select on CORE_OWNER.NOTIFICATION_TYPE to cupy_app;
grant select on CORE_OWNER.NOTIFICATION_TYPE to core_owner;
grant select on CORE_OWNER.NOTIFICATION_TYPE to core_app;
grant select on CORE_OWNER.NOTIFICATION_TYPE to core_billing_app;
grant select on CORE_OWNER.NOTIFICATION_TYPE to core_licensing_app;

grant REFERENCES on CORE_OWNER.NOTIFICATION_TYPE to cupy_app;
grant REFERENCES on CORE_OWNER.NOTIFICATION_TYPE to core_owner;
grant REFERENCES on CORE_OWNER.NOTIFICATION_TYPE to core_app;
grant REFERENCES on CORE_OWNER.NOTIFICATION_TYPE to core_billing_app;
grant REFERENCES on CORE_OWNER.NOTIFICATION_TYPE to core_licensing_app;

grant select, insert, update, delete ON CORE_OWNER.NOTIFICATION_TYPE to core_owner;
grant select ON CORE_OWNER.NOTTID_SEQ to core_owner;

Grant Execute On Core_Owner.App_Exception_Codes_V18 To Ops_Owner;
Grant Execute On Core_Owner.App_Exception_Codes_V18 To Core_Hist_Owner;

Grant Execute On Core_Owner.GLOBAL_ENUMS_V18 To Ops_Owner;
Grant Execute On Core_Owner.GLOBAL_ENUMS_V18 To Core_Hist_Owner;

Grant Execute On Core_Owner.Global_Statuses_V18 To Ops_Owner;
Grant Execute On Core_Owner.Global_Statuses_V18 To Core_Hist_Owner;

