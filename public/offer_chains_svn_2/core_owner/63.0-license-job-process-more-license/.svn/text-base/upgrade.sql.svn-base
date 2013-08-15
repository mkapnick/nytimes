CREATE OR REPLACE PACKAGE BODY "PROCS_LICENSE_V22" AS

PROCEDURE CREATE_LICENSE(
/*
Throws exceptions:
APP_EXCEPTION_CODES_V22.NOT_FOUND
APP_EXCEPTION_CODES_V22.UNKNOWN_ERROR
APP_EXCEPTION_CODES_V22.INTERNAL_ERROR
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
    PROCS_COMMON_V22.ISO8601DURATION_TO_INTERVALS(
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
  PROCS_LICENSE_CRU_V22.CREATE_LICENSE(
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
  PROCS_COMMON_V22.THROW_EXCEPTION(APP_EXCEPTION_CODES_V22.INTERNAL_ERROR,
    SPROC_NAME, 'Bad offer duration format', EXCEPTION_MESSAGE);
WHEN BAD_OFFER_ID THEN
  PROCS_COMMON_V22.THROW_EXCEPTION(APP_EXCEPTION_CODES_V22.NOT_FOUND,
    SPROC_NAME, 'No such offer');
WHEN BAD_SUBSCRIPTION_ID THEN
  PROCS_COMMON_V22.THROW_EXCEPTION(APP_EXCEPTION_CODES_V22.NOT_FOUND,
    SPROC_NAME, 'No such subscription');
WHEN BAD_INVOICE_ID THEN
  PROCS_COMMON_V22.THROW_EXCEPTION(APP_EXCEPTION_CODES_V22.NOT_FOUND,
    SPROC_NAME, 'No such invoice');
WHEN OTHERS THEN
  PROCS_COMMON_V22.THROW_EXCEPTION(APP_EXCEPTION_CODES_V22.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END;

/******************************************************************************/

PROCEDURE UPDATE_LICENSE_STATUS(
    in_license_id     IN NUMBER,
    in_license_status IN NUMBER,
    in_updated_by     IN VARCHAR2,
    in_ent_end        IN NUMBER DEFAULT GLOBAL_CONSTANTS_V22.FALSE
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

  IF in_license_status != GLOBAL_STATUSES_V22.LICENSE_CLOSED
     AND in_license_status != GLOBAL_STATUSES_V22.LICENSE_ACTIVE
     AND in_license_status != GLOBAL_STATUSES_V22.LICENSE_IN_GRACE_PERIOD THEN
    RAISE BAD_LICENSE_STATUS;
  END IF;

  IF (in_ent_end is not null and in_ent_end = GLOBAL_CONSTANTS_V22.TRUE) then
    PROCS_LICENSE_CRU_V22.UPDATE_LICENSE(
      in_license_id        => in_license_id,
      in_updated_by        => in_updated_by,
      in_license_status_id => in_license_status,
      in_entitlement_end_date      => sysdate
    );
  ELSE
    PROCS_LICENSE_CRU_V22.UPDATE_LICENSE(
      in_license_id        => in_license_id,
      in_updated_by        => in_updated_by,
      in_license_status_id => in_license_status
    );
  END IF;
  
EXCEPTION
WHEN BAD_LICENSE_STATUS THEN
  PROCS_COMMON_V22.THROW_EXCEPTION(APP_EXCEPTION_CODES_V22.INVALID_PARAMETER,
    SPROC_NAME, 'Bad status id');
WHEN BAD_LICENSE_ID THEN
  PROCS_COMMON_V22.THROW_EXCEPTION(APP_EXCEPTION_CODES_V22.NOT_FOUND,
    SPROC_NAME, 'No such license');
WHEN OTHERS THEN
  PROCS_COMMON_V22.THROW_EXCEPTION(APP_EXCEPTION_CODES_V22.UNKNOWN_ERROR,
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
    AND LICENSE.LICENSE_STATUS_ID = GLOBAL_STATUSES_V22.LICENSE_ACTIVE
    AND NOT EXISTS
    (
      SELECT NULL
      FROM PROCESS_RETRY_THROTTLE
      WHERE PROCESS_NAME = SPROC_NAME
        AND GENERIC_ID = LICENSE.ID
    )
    AND ROWNUM <= 40000
    ORDER BY dbms_random.value
) WHERE
    ROWNUM <= 4000;
EXCEPTION
WHEN OTHERS THEN
  PROCS_COMMON_V22.THROW_EXCEPTION(APP_EXCEPTION_CODES_V22.UNKNOWN_ERROR,
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
    AND LICENSE.LICENSE_STATUS_ID = GLOBAL_STATUSES_V22.LICENSE_ACTIVE
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
  PROCS_COMMON_V22.THROW_EXCEPTION(APP_EXCEPTION_CODES_V22.UNKNOWN_ERROR,
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
  PROCS_COMMON_V22.THROW_EXCEPTION(APP_EXCEPTION_CODES_V22.NOT_FOUND,
    SPROC_NAME, 'No such license');
WHEN CAN_NOT_GET_OFFER_INFO THEN
  PROCS_COMMON_V22.THROW_EXCEPTION(APP_EXCEPTION_CODES_V22.NOT_FOUND,
    SPROC_NAME, 'Could not get offer information. Offer id = '||var_offer_id||', Offer chain id = '||var_offer_chain_id);
WHEN OTHERS THEN
  PROCS_COMMON_V22.THROW_EXCEPTION(APP_EXCEPTION_CODES_V22.UNKNOWN_ERROR,
    SPROC_NAME, 'Unknown error', SQLERRM);
END GET_RECURRING_OFFER;

/******************************************************************************/

PROCEDURE GET_NEXT_OFFER (
/*
Throws exceptions:
APP_EXCEPTION_CODES_V22.NOT_FOUND
APP_EXCEPTION_CODES_V22.UNKNOWN_ERROR
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
    var_next_offer_index := PROCS_OFFER_CHAIN_V22.GET_NEXT_OFFER_INDEX(
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
  PROCS_COMMON_V22.THROW_EXCEPTION(APP_EXCEPTION_CODES_V22.NOT_FOUND,
    SPROC_NAME, 'No such license');
WHEN CAN_NOT_FIND_NEXT_OFFER THEN
  PROCS_COMMON_V22.THROW_EXCEPTION(APP_EXCEPTION_CODES_V22.INTERNAL_ERROR,
    SPROC_NAME, 'Could not find next offer', EXCEPTION_MESSAGE);
WHEN OTHERS THEN
  PROCS_COMMON_V22.THROW_EXCEPTION(APP_EXCEPTION_CODES_V22.UNKNOWN_ERROR,
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
  PROCS_COMMON_V22.THROW_EXCEPTION(APP_EXCEPTION_CODES_V22.NOT_FOUND,
    SPROC_NAME, 'No such license');
WHEN CAN_NOT_GET_GROUP_ID THEN
  PROCS_COMMON_V22.THROW_EXCEPTION(APP_EXCEPTION_CODES_V22.NOT_FOUND,
    SPROC_NAME, 'Could not get group id');
WHEN OTHERS THEN
  PROCS_COMMON_V22.THROW_EXCEPTION(APP_EXCEPTION_CODES_V22.UNKNOWN_ERROR,
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
    LICENSE.NEEDS_ENTITLEMENTS = GLOBAL_CONSTANTS_V22.TRUE
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
  
  IF in_needs_entitlements != GLOBAL_CONSTANTS_V22.TRUE
    AND in_needs_entitlements != GLOBAL_CONSTANTS_V22.FALSE THEN
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
  
  PROCS_LICENSE_CRU_V22.UPDATE_LICENSE(
    in_license_id         => in_license_id,
    in_needs_entitlements => in_needs_entitlements,
    in_updated_by         => in_updated_by
  );
  
EXCEPTION
WHEN BAD_ENTITLEMENTS_FLAG THEN
  PROCS_COMMON_V22.THROW_EXCEPTION(APP_EXCEPTION_CODES_V22.INVALID_PARAMETER,
    SPROC_NAME, 'Bad entitlements flag value');
WHEN BAD_LICENSE_ID THEN
  PROCS_COMMON_V22.THROW_EXCEPTION(APP_EXCEPTION_CODES_V22.NOT_FOUND,
    SPROC_NAME, 'No such license');
WHEN OTHERS THEN
  PROCS_COMMON_V22.THROW_EXCEPTION(APP_EXCEPTION_CODES_V22.UNKNOWN_ERROR,
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
    l.LICENSE_STATUS_ID != GLOBAL_STATUSES_V22.LICENSE_ACTIVE
    AND l.ENTITLEMENT_END_DATE <= (current_timestamp)
    AND l.ENTITLEMENT_END_DATE > (current_timestamp - var_time_interval)
    AND s.subscription_status_id = GLOBAL_STATUSES_V22.SUBSCRIPTION_CLOSED
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
  PROCS_COMMON_V22.THROW_EXCEPTION(APP_EXCEPTION_CODES_V22.UNKNOWN_ERROR,
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
  PROCS_COMMON_V22.THROW_EXCEPTION(APP_EXCEPTION_CODES_V22.NOT_FOUND,
    SPROC_NAME, 'No such license');
WHEN OTHERS THEN
  PROCS_COMMON_V22.THROW_EXCEPTION(APP_EXCEPTION_CODES_V22.UNKNOWN_ERROR,
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
  
  PROCS_LICENSE_CRU_V22.UPDATE_LICENSE(
    in_license_id        => var_latest_lice,
    in_updated_by        => in_updated_by,
    in_needs_entitlements => GLOBAL_CONSTANTS_V22.TRUE,
    in_end_date          => in_end_date,
    in_entitlement_end_date => in_end_date
  );

EXCEPTION
WHEN NO_DATA_FOUND THEN
  PROCS_COMMON_V22.THROW_EXCEPTION(APP_EXCEPTION_CODES_V22.UNKNOWN_ERROR,
    SPROC_NAME, 'No licenses from subscription', SQLERRM);
WHEN OTHERS THEN
  PROCS_COMMON_V22.THROW_EXCEPTION(APP_EXCEPTION_CODES_V22.UNKNOWN_ERROR,
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
              i.invoice_status_id = GLOBAL_STATUSES_V22.INVOICE_OPEN
          AND l.license_status_id = GLOBAL_STATUSES_V22.LICENSE_IN_GRACE_PERIOD
          AND SYSDATE + in_days_before_close >= l.grace_end_date
          AND NOT EXISTS
              (
                  SELECT
                      1
                  FROM
                      charge c
                  WHERE
                      c.invoice_id = i.id
                  AND c.charge_status_id = GLOBAL_STATUSES_V22.CHARGE_OPENED)
          AND rownum <= in_num_licenses_to_fetch * 10
          ORDER BY
              dbms_random.value)
  WHERE
      rownum <= in_num_licenses_to_fetch;
END GET_GRACE_LICE_FOR_FINAL_TRANS;

End Procs_License_V22;
.
/

