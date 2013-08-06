--------------------------------------------------------------------------------
-- DDL for package APP_EXCEPTION_CODES
--------------------------------------------------------------------------------

CREATE OR REPLACE PACKAGE "APP_EXCEPTION_CODES_V21" 
AS
-- norlov 09.09 : current_timestamp replaced by sysdate 
-- in comparisons (according to #38816)
-- 2010-09-13: according to #38860, current_timestamp calls replaced by SYSDATE variable
-- to use the same date in whole procedure, also single current_timestamp calls
-- replaced by SYSDATE calls


  -- EXCEPTION CODES
  UNKNOWN_ERROR     CONSTANT NUMBER := -20001;
  NOT_FOUND         CONSTANT NUMBER := -20002;
  STATE_ERROR       CONSTANT NUMBER := -20003;
  DUPLICATE_ERROR   CONSTANT NUMBER := -20004;
  HISTORY_ERROR     CONSTANT NUMBER := -20005;
  INVALID_PARAMETER CONSTANT NUMBER := -20006;
  INTERNAL_ERROR    CONSTANT NUMBER := -20007;
  CONFLICT_ERROR    CONSTANT NUMBER := -20008;
END APP_EXCEPTION_CODES_V21;
.
/



--------------------------------------------------------------------------------
-- DDL for package GLOBAL_CONSTANTS
--------------------------------------------------------------------------------

CREATE OR REPLACE PACKAGE "GLOBAL_CONSTANTS_V21" AS 

TRUE  CONSTANT NUMBER := 1;
FALSE CONSTANT NUMBER := 0;

INFINITY CONSTANT NUMBER := -1;

ONE_DAY_INTERVAL   CONSTANT INTERVAL DAY TO SECOND := INTERVAL '1' DAY;
ONE_MONTH_INTERVAL CONSTANT INTERVAL YEAR TO MONTH := INTERVAL '1' MONTH;
ONE_YEAR_INTERVAL   CONSTANT INTERVAL YEAR TO MONTH := INTERVAL '1' YEAR;

-- Exception delimeter
EXCEPTION_DELIMETER CONSTANT VARCHAR2(1) := chr(10);

-- Number of days when core should return all money
OFFER_START_GRACE_PERIOD CONSTANT NUMBER := 7;

-- NUmber of days when core should not return any money
OFFER_END_GRACE_PERIOD   CONSTANT NUMBER := 7;

-- OFFER CHAIN: is refundable META DATTA RULE
OFFER_CHAIN_IS_REFUNDABLE   CONSTANT NUMBER := 1;
OFFER_CHAIN_REFUNDABLE_RULE CONSTANT VARCHAR2(10) := 'REFUNDABLE';

-- OFFER CHAIN REFUNDABLE RULES
OFFER_CHAIN_FULL_REFUND     CONSTANT VARCHAR2(22) := 'FULL_REFUND_DAYS_LIMIT';
OFFER_CHAIN_PRORATED_REFUND CONSTANT VARCHAR2(26) := 'PRORATED_REFUND_DAYS_LIMIT';

-- norlov: name of the OC eligibility
GIFT_CERTIFICATE_REQUIRED CONSTANT VARCHAR2(25) := 'gift certificate required';

-- norlov: flag for set elibility
ELIGIBILITY_FLAG_SET CONSTANT VARCHAR2(1) := '1';

-- norlov: name of OC metadata 
REDEMPTION_OC_ID CONSTANT VARCHAR2(25) := 'redemption offer chain id';

-- norlov: name of the OC eligibility
MAX_CONCURRENT_SUBS CONSTANT VARCHAR2(19) := 'MAX_CONCURRENT_SUBS';

-- norlov: 'unlimited' value for max concurrent subscription number
MAX_CONCURRENT_SUBS_UNLIM CONSTANT VARCHAR2(9) := 'UNLIMITED';

-- 'unlimited' value for max concurrent products number
MAX_CONSURRENT_PRD_UNLIM CONSTANT VARCHAR2(9) := 'UNLIMITED';

-- UPGRADABLE_OFFER_CHAIN_ID
OCMD_UPGRADABLE_OFFER_CHAIN_ID CONSTANT VARCHAR(25) := 'UPGRADABLE_OFFER_CHAIN_ID';

-- Max number of records that should be return
MAX_RETURN_COUNT NUMBER := 1000;

-- Share end date for non-group-pass group accounts
MAX_DATE CONSTANT DATE := TO_DATE('12/31/9999', 'MM/DD/YYYY');

END GLOBAL_CONSTANTS_V21;
.
/



--------------------------------------------------------------------------------
-- DDL for package GLOBAL_ENUMS
--------------------------------------------------------------------------------

CREATE OR REPLACE PACKAGE "GLOBAL_ENUMS_V21" AS 

----
-- CREDIT CARD TYPES

CREDIT_CARD_AMEX        CONSTANT NUMBER := 1;
CREDIT_CARD_VISA        CONSTANT NUMBER := 2;
CREDIT_CARD_MASTER_CARD CONSTANT NUMBER := 3;
CREDIT_CARD_DISCOVER    CONSTANT NUMBER := 4;

----
-- INSTRUMENT TYPE

INSTRUMENT_CREDIT_CARD       CONSTANT NUMBER := 1;
INSTRUMENT_PAYPAL            CONSTANT NUMBER := 2;
INSTRUMENT_GIFT_CERTIFICATE  CONSTANT NUMBER := 3;
INSTRUMENT_ZCI_INSTRUMENT    CONSTANT NUMBER := 4;

----
-- SYSTEM ACTIVITY REASONS

SAC_SYSTEM_APPLIED_RULE CONSTANT NUMBER := 1;

----
-- GIFT CERTIFICATES TYPE

GSTYPE_GSTYPE1 CONSTANT NUMBER := 1;
GSTYPE_GSTYPE2 CONSTANT NUMBER := 2;

----
-- SYSTEM CATEGORY

SYSTEM_CATEGORY_LIVE CONSTANT NUMBER := 1;
SYSTEM_CATEGORY_TEST CONSTANT NUMBER := 2;

----
-- OFFER_RECURRENCES

OFFER_REC_INFINITY CONSTANT NUMBER := -1;

----
-- TAX JURISDICTION LEVELS
-- We need only international right now

JURIS_INTERNATIONAL CONSTANT NUMBER := 5;

----
-- TAX TYPES

TAX_TYPE_SALES CONSTANT NUMBER := 1;
TAX_TYPE_VAT   CONSTANT NUMBER := 2;

END GLOBAL_ENUMS_V21;
.
/



--------------------------------------------------------------------------------
-- DDL for package GLOBAL_STATUSES
--------------------------------------------------------------------------------

CREATE OR REPLACE PACKAGE "GLOBAL_STATUSES_V21" AS

REAL_TIME_CANCEL_REASON CONSTANT NUMBER := 41;

----
-- ACCOUNT STATUSES

ACCOUNT_ACTIVE   CONSTANT NUMBER := 1;
ACCOUNT_FROZEN   CONSTANT NUMBER := 2;
ACCOUNT_DISABLED CONSTANT NUMBER := 3;

----
-- SUBSCRIPTION STATUSES

SUBSCRIPTION_ACTIVE          CONSTANT NUMBER := 1;
SUBSCRIPTION_SUSPENDED       CONSTANT NUMBER := 2;
SUBSCRIPTION_CANCELED        CONSTANT NUMBER := 3;
SUBSCRIPTION_CLOSED          CONSTANT NUMBER := 4;
SUBSCRIPTION_FALSE_START     CONSTANT NUMBER := 5;
SUBSCRIPTION_IN_GRACE_PERIOD CONSTANT NUMBER := 6;

----
-- CREDIT_CARD STATUSES

CREDIT_CARD_ACTIVE   CONSTANT NUMBER := 1;
CREDIT_CARD_INVALID  CONSTANT NUMBER := 2; -- WAS INACTIVE
CREDIT_CARD_DISABLED CONSTANT NUMBER := 3; -- WAS FROZEN
CREDIT_CARD_EXPIRED  CONSTANT NUMBER := 4;

----
-- PAYPAL STATUSES

PAYPAL_ACTIVE   CONSTANT NUMBER := 1;
PAYPAL_INACTIVE CONSTANT NUMBER := 2;
PAYPAL_FROZEN   CONSTANT NUMBER := 3;

----
-- GIFT_CERTIFICATE STATUSES

GIFT_CERTIFICATE_ACTIVE    CONSTANT NUMBER := 1;
GIFT_CERTIFICATE_FINALIZED CONSTANT NUMBER := 2;
GIFT_CERTIFICATE_REFUNDED  CONSTANT NUMBER := 3;

----
-- TRANSACTION STATUSES

TRANSACTION_PENDING            CONSTANT NUMBER := 1;
TRANSACTION_CLOSED             CONSTANT NUMBER := 2;
TRANSACTION_CHARGEBACK         CONSTANT NUMBER := 3;
TRANSACTION_PREPARE            CONSTANT NUMBER := 1;
TRANSACTION_DECLINED           CONSTANT NUMBER := 7;

----
-- TRANSACTION_ATTEMPT_STATUS
TRANS_ATTEMPT_IN_PROGRESS CONSTANT NUMBER := 1;
TRANS_ATTEMPT_SUCCESS     CONSTANT NUMBER := 2;
TRANS_ATTEMPT_FAILED      CONSTANT NUMBER := 3;

----
-- PRODUCT STATUSES

PRODUCT_ACTIVE    CONSTANT NUMBER := 1;
PRODUCT_INACTIVE  CONSTANT NUMBER := 2;
PRODUCT_DISABLED  CONSTANT NUMBER := 3;

----
-- LICENSE STATUSES

LICENSE_CLOSED CONSTANT NUMBER := 1;
LICENSE_ACTIVE CONSTANT NUMBER := 2;
LICENSE_IN_GRACE_PERIOD CONSTANT NUMBER := 4;

----
-- INVOICE STATUSES

INVOICE_OPEN                CONSTANT NUMBER := 1; -- IN SPECS INVOICE_PENDING
INVOICE_CLOSED              CONSTANT NUMBER := 3; -- IN SPECS INVOICE_PAID


----
-- CHARGE STATUSES

CHARGE_OPENED    CONSTANT NUMBER := 1;
CHARGE_PROCESSED CONSTANT NUMBER := 2;
CHARGE_CANCELED  CONSTANT NUMBER := 3;

----
-- OFFER STATUSES

OFFER_ACTIVE   CONSTANT NUMBER := 1;
OFFER_INACTIVE CONSTANT NUMBER := 2;
OFFER_DISABLED CONSTANT NUMBER := 3;

----
-- OFFER_CHAIN STATUSES

OFFER_CHAIN_ACTIVE   CONSTANT NUMBER := 1;
OFFER_CHAIN_INACTIVE CONSTANT NUMBER := 2;
OFFER_CHAIN_DISABLED CONSTANT NUMBER := 3;

----
-- ZERO_CHARGE_INSTRUMENT STATUSES

ZERO_CHARGE_INSTR_ACTIVE CONSTANT NUMBER := 1;
ZERO_CHARGE_INSTR_DISABLED CONSTANT NUMBER := 2;

----
-- SUBSCRIPTION_CANCELATION_REASONS

SUBSCR_CANC_REASON_ACTIVE CONSTANT NUMBER := 1;
SUBSCR_CANC_REASON_INACTIVE CONSTANT NUMBER := 2;
SUBSCR_CANC_REASON_INT_ONLY CONSTANT NUMBER := 3;

GROUP_ACC_IP_RNG_ACTIVE CONSTANT NUMBER := 1;
GROUP_ACC_IP_RNG_INACTIVE CONSTANT NUMBER := 2;

GROUP_ACC_EMAIL_DOMAIN_ACT CONSTANT NUMBER := 1;
GROUP_ACC_EMAIL_DOMAIN_INACT CONSTANT NUMBER := 0;

END GLOBAL_STATUSES_V21;
.
/



--------------------------------------------------------------------------------
-- DDL for package NOTIFICATION_STATUSES
--------------------------------------------------------------------------------

CREATE OR REPLACE PACKAGE "NOTIFICATION_STATUSES_V21" AS

----
-- NOTIFICATION STATUSES

NOTIFICATION_SENT    CONSTANT NUMBER := 1;
NOTIFICATION_PENDING CONSTANT NUMBER := 2;
NOTIFICATION_FAILED  CONSTANT NUMBER := 3;

END NOTIFICATION_STATUSES_V21;
.
/



--------------------------------------------------------------------------------
-- DDL for package PROCS_COMMON
--------------------------------------------------------------------------------

CREATE OR REPLACE PACKAGE "PROCS_COMMON_V21" AS 

FUNCTION ADD_ISO8601DURATION_TO_DATE(
  in_duration IN VARCHAR2,
  in_start_date IN DATE
) RETURN DATE;

PROCEDURE ISO8601DURATION_TO_INTERVALS(
/*
Throws exceptions:
APP_EXCEPTION_CODES_V21.INTERNAL_ERROR
APP_EXCEPTION_CODES_V21.UNKNOWN_ERROR
*/
  in_duration IN  VARCHAR2,
  out_years   OUT NUMBER,
  out_months  OUT NUMBER,
  out_days    OUT NUMBER
);

FUNCTION NORMALIZE_DATE(
 in_date IN DATE
) RETURN DATE;

FUNCTION GENERATE_EXCEPTION_MESSAGE(
  in_sproc_name       IN VARCHAR2,
  in_error_message    IN VARCHAR2,
  in_error_stacktrace IN VARCHAR2 DEFAULT NULL
) RETURN VARCHAR2;

PROCEDURE THROW_EXCEPTION(
  in_exception_code   IN NUMBER,
  in_sproc_name       IN VARCHAR2,
  in_error_message    IN VARCHAR2,
  in_error_stacktrace IN VARCHAR2 DEFAULT NULL
);

FUNCTION ROUND_10_6_TO_10_2 (
  in_number NUMBER
) RETURN NUMBER;

END PROCS_COMMON_V21;
.
/

CREATE OR REPLACE PACKAGE BODY "PROCS_COMMON_V21" AS

FUNCTION ADD_ISO8601DURATION_TO_DATE(
  in_duration IN VARCHAR2,
  in_start_date IN DATE
) RETURN DATE AS
  var_end_date DATE;
  var_years NUMBER;
  var_months NUMBER;
  var_days NUMBER;
  var_ym_interval INTERVAL YEAR TO MONTH;
  var_ds_interval INTERVAL DAY(3) TO SECOND;
BEGIN
  PROCS_COMMON_V21.ISO8601DURATION_TO_INTERVALS(in_duration, var_years, var_months, var_days);
  var_ym_interval := var_years || '-' || var_months;
  var_ds_interval := var_days || ' 0:0:0';

  var_end_date := in_start_date + var_ym_interval + var_ds_interval;
  RETURN var_end_date;
END ADD_ISO8601DURATION_TO_DATE;

PROCEDURE ISO8601DURATION_TO_INTERVALS(
/*
Throws exceptions:
APP_EXCEPTION_CODES_V21.INTERNAL_ERROR
APP_EXCEPTION_CODES_V21.UNKNOWN_ERROR
*/
  in_duration IN  VARCHAR2,
  out_years   OUT NUMBER,
  out_months  OUT NUMBER,
  out_days    OUT NUMBER
) AS
SPROC_NAME          CONSTANT VARCHAR2(28) := 'ISO8601DURATION_TO_INTERVALS';
-- VARIABLES
var_checking_status NUMBER;
temp_duration       VARCHAR2(29);
var_is_t_founded    NUMBER;

var_date_duration VARCHAR2(29);
var_time_duration VARCHAR2(29);

var_years   VARCHAR2(4);
var_monthes VARCHAR2(4);
var_days    VARCHAR2(4);
var_hours   VARCHAR2(4);
var_minutes VARCHAR2(4);
var_seconds VARCHAR2(4);

-- EXCEPTIONS
BAD_ISO_FORMAT EXCEPTION;
BEGIN

  var_years   := '0';
  var_monthes := '0';
  var_days    := '0';
  var_hours   := '0';
  var_minutes := '0';
  var_seconds := '0';

  SELECT
    COUNT(*) into var_checking_status
  FROM
    DUAL
  WHERE
    REGEXP_LIKE(in_duration, '^P')
    AND ROWNUM <= 1;
    
  IF var_checking_status = 0 THEN
    RAISE BAD_ISO_FORMAT;
  END IF;
  
  SELECT
    SUBSTR(in_duration, 2) into temp_duration
  FROM DUAL
  WHERE ROWNUM <= 1;
  
  var_is_t_founded := INSTR(temp_duration, 'T');

  IF var_is_t_founded > 1 OR var_is_t_founded = 0 THEN
    -- RESOLVING DATE FROM ISO STRING
    IF var_is_t_founded != 0 THEN
      var_date_duration := SUBSTR(temp_duration, 1, var_is_t_founded - 1);
    ELSE
      var_date_duration := temp_duration;
    END IF;
    
    SELECT
      COUNT(*) into var_checking_status
    FROM
      DUAL
    WHERE
      REGEXP_LIKE(var_date_duration, '^(\d{1,3}Y){0,1}(\d{1,3}M){0,1}(\d{1,3}D){0,1}$')
      AND ROWNUM <= 1;

    IF var_checking_status = 0 THEN
      RAISE BAD_ISO_FORMAT;
    END IF;

    IF INSTR(var_date_duration, 'Y') != 0 THEN
      SELECT
        REGEXP_SUBSTR(var_date_duration, '\d+Y') into var_years
      FROM
        DUAL;
      var_years := SUBSTR(var_years, 1, LENGTH(var_years) - 1);
    END IF;

    IF INSTR(var_date_duration, 'M') != 0 THEN
      SELECT
        REGEXP_SUBSTR(var_date_duration, '\d+M') into var_monthes
      FROM
        DUAL;
      var_monthes := SUBSTR(var_monthes, 1, LENGTH(var_monthes) - 1);
    END IF;

    IF INSTR(var_date_duration, 'D') != 0 THEN
      SELECT
        REGEXP_SUBSTR(var_date_duration, '\d+D') into var_days
      FROM
        DUAL;
      var_days := SUBSTR(var_days, 1, LENGTH(var_days) - 1);
    END IF;
  END IF;
  
  IF (var_is_t_founded > 0) THEN
    -- RESOLVING TIME FROM ISO STRING
    var_time_duration := SUBSTR(temp_duration, var_is_t_founded + 1);

    SELECT
      COUNT(*) into var_checking_status
    FROM
      DUAL
    WHERE
      REGEXP_LIKE(var_time_duration, '^(\d{1,3}H){0,1}(\d{1,3}M){0,1}(\d{1,3}S){0,1}$')
      AND ROWNUM <= 1;
      
    IF var_checking_status = 0 THEN
      RAISE BAD_ISO_FORMAT;
    END IF;

    IF INSTR(var_time_duration, 'H') != 0 THEN
      SELECT
        REGEXP_SUBSTR(var_time_duration, '\d+H') into var_hours
      FROM
        DUAL;
      var_hours := SUBSTR(var_hours, 1, LENGTH(var_hours) - 1);
    END IF;

    IF INSTR(var_time_duration, 'M') != 0 THEN
      SELECT
        REGEXP_SUBSTR(var_time_duration, '\d+M') into var_minutes
      FROM
        DUAL;
      var_minutes := SUBSTR(var_minutes, 1, LENGTH(var_minutes) - 1);
    END IF;

    IF INSTR(var_time_duration, 'S') != 0 THEN
      SELECT
        REGEXP_SUBSTR(var_time_duration, '\d+S') into var_seconds
      FROM
        DUAL;
      var_seconds := SUBSTR(var_seconds, 1, LENGTH(var_seconds) - 1);
    END IF;

    var_time_duration := SUBSTR(temp_duration, var_is_t_founded);
  END IF;
  
  out_years  := var_years;
  out_months := var_monthes;
  out_days   := var_days;
  
EXCEPTION
WHEN BAD_ISO_FORMAT THEN
  PROCS_COMMON_V21.THROW_EXCEPTION(APP_EXCEPTION_CODES_V21.INTERNAL_ERROR,
    SPROC_NAME, 'Bad date format');
WHEN OTHERS THEN
  PROCS_COMMON_V21.THROW_EXCEPTION(APP_EXCEPTION_CODES_V21.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END ISO8601DURATION_TO_INTERVALS;

/******************************************************************************/

FUNCTION NORMALIZE_DATE(
 in_date IN DATE
) RETURN DATE AS
-- VARIABLES
var_normalized_date DATE;
BEGIN
  var_normalized_date := TRUNC(in_date);
  RETURN var_normalized_date;
END NORMALIZE_DATE;

/******************************************************************************/

FUNCTION GENERATE_EXCEPTION_MESSAGE(
  in_sproc_name       IN VARCHAR2,
  in_error_message    IN VARCHAR2,
  in_error_stacktrace IN VARCHAR2 DEFAULT NULL
) RETURN VARCHAR2 AS
BEGIN
  IF in_error_stacktrace IS NOT NULL THEN
    RETURN in_sproc_name || ': ' || in_error_message || ': ' || GLOBAL_CONSTANTS_V21.EXCEPTION_DELIMETER || in_error_stacktrace;
  END IF;
  RETURN
    in_sproc_name || ': ' || in_error_message;
END GENERATE_EXCEPTION_MESSAGE;

/******************************************************************************/

PROCEDURE THROW_EXCEPTION(
  in_exception_code   IN NUMBER,
  in_sproc_name       IN VARCHAR2,
  in_error_message    IN VARCHAR2,
  in_error_stacktrace IN VARCHAR2 DEFAULT NULL
) AS
BEGIN
  RAISE_APPLICATION_ERROR(in_exception_code, GENERATE_EXCEPTION_MESSAGE(in_sproc_name, in_error_message, in_error_stacktrace));
END;

FUNCTION ROUND_10_6_TO_10_2 (
  in_number NUMBER
) RETURN NUMBER AS
v_result NUMBER(10,2);
BEGIN
  v_result := in_number;
  return v_result;
END;

END PROCS_COMMON_V21;
.
/

grant execute on CORE_OWNER.APP_EXCEPTION_CODES_V21 to core_hist_owner;
grant execute on CORE_OWNER.GLOBAL_ENUMS_V21 to core_hist_owner;
grant execute on CORE_OWNER.GLOBAL_STATUSES_V21 to core_hist_owner;
