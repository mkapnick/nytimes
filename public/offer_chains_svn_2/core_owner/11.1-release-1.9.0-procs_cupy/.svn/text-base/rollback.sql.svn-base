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
    in_request_filename  IN  CC_REQUEST_FILE.FILE_NAME%TYPE,
    in_status            IN  CC_REQUEST_FILE.CC_REQUEST_FILE_STATUS%TYPE,
    out_card_license     OUT SYS_REFCURSOR
  );

  PROCEDURE UPDATE_CC_UPDATE_STATUS(
    in_request_file_id IN CC_UPDATE.CC_REQUEST_FILE_ID%TYPE,
    in_credit_card_id  IN CC_UPDATE.CREDIT_CARD_ID%TYPE,
    in_status          IN CC_UPDATE.CC_UPDATE_STATUS%TYPE,
    in_action          IN CC_UPDATE.CC_UPDATE_ACTION%TYPE DEFAULT NULL,
    in_reason          IN CC_UPDATE.CC_UPDATE_REASON%TYPE DEFAULT NULL,
    in_updated_by      IN CC_UPDATE.UPDATED_BY%TYPE
  );

  PROCEDURE GET_REQUEST_FILE_BY_FILENAME (
    in_request_filename  IN  CC_REQUEST_FILE.FILE_NAME%TYPE,
    out_request_file     OUT SYS_REFCURSOR
  );

  PROCEDURE GET_REQUEST_FILE_BY_PROFILE_ID (
    in_chase_profile_id    IN  CREDIT_CARD.CHASE_PROFILE_ID%TYPE,
    in_request_file_status IN  CC_REQUEST_FILE.CC_REQUEST_FILE_STATUS%TYPE,
    out_request_file       OUT SYS_REFCURSOR
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

END PROCS_CUPY;
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
  SPROC_NAME CONSTANT VARCHAR2(32) := 'REQUEST_FILES_BY_STATUS';
  BEGIN
   OPEN out_request_files FOR
   SELECT
     ID,
     FILE_NAME
   FROM
     CC_REQUEST_FILE
   WHERE
     CC_REQUEST_FILE_STATUS = in_status
   AND
     UPDATE_DATE < SYSDATE - (in_older_than_hours / 24);
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
    in_request_filename  IN  CC_REQUEST_FILE.FILE_NAME%TYPE,
    in_status            IN  CC_REQUEST_FILE.CC_REQUEST_FILE_STATUS%TYPE,
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
      l.END_DATE LICENSE_END_DATE
    FROM CREDIT_CARD cc, CC_UPDATE u, CC_REQUEST_FILE rf, ACCOUNT a, LICENSE l
    WHERE cc.ID = u.CREDIT_CARD_ID
    AND u.CC_REQUEST_FILE_ID = rf.ID
    AND rf.CC_REQUEST_FILE_STATUS = in_status
    AND rf.FILE_NAME = in_request_filename
    AND cc.CHASE_PROFILE_ID = in_chase_profile_id
    AND cc.ACCOUNT_ID = a.ID
    AND u.LICENSE_ID = l.ID
    ORDER BY cc.UPDATE_DATE DESC;
  END GET_CREDIT_CARD_LICENSE;

  /****************************************************************************/

  PROCEDURE UPDATE_CC_UPDATE_STATUS(
    in_request_file_id IN CC_UPDATE.CC_REQUEST_FILE_ID%TYPE,
    in_credit_card_id  IN CC_UPDATE.CREDIT_CARD_ID%TYPE,
    in_status          IN CC_UPDATE.CC_UPDATE_STATUS%TYPE,
    in_action          IN CC_UPDATE.CC_UPDATE_ACTION%TYPE DEFAULT NULL,
    in_reason          IN CC_UPDATE.CC_UPDATE_REASON%TYPE DEFAULT NULL,
    in_updated_by      IN CC_UPDATE.UPDATED_BY%TYPE
  ) AS
  BEGIN
    UPDATE CC_UPDATE
    SET CC_UPDATE_STATUS = in_status,
    CC_UPDATE_ACTION = NVL(in_action, CC_UPDATE_ACTION),
    CC_UPDATE_REASON = NVL(in_reason, CC_UPDATE_REASON),
    UPDATE_DATE = SYSDATE,
    UPDATED_BY = in_updated_by
    WHERE CC_REQUEST_FILE_ID = in_request_file_id
    AND CREDIT_CARD_ID = in_credit_card_id;
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

  PROCEDURE GET_REQUEST_FILE_BY_PROFILE_ID (
    in_chase_profile_id    IN  CREDIT_CARD.CHASE_PROFILE_ID%TYPE,
    in_request_file_status IN  CC_REQUEST_FILE.CC_REQUEST_FILE_STATUS%TYPE,
    out_request_file       OUT SYS_REFCURSOR
  ) AS
  BEGIN
    OPEN out_request_file FOR
    SELECT rf.ID, rf.FILE_NAME
    FROM CC_REQUEST_FILE rf, CC_UPDATE u, CREDIT_CARD cc
    WHERE rf.ID = u.CC_REQUEST_FILE_ID
    AND cc.ID = u.CREDIT_CARD_ID
    AND cc.CHASE_PROFILE_ID = in_chase_profile_id
    AND rf.CC_REQUEST_FILE_STATUS = in_request_file_status;
  END GET_REQUEST_FILE_BY_PROFILE_ID;

  /****************************************************************************/

  PROCEDURE SUSPEND_CREDIT_CARD (
    in_credit_card_id  IN CREDIT_CARD.ID%TYPE,
    in_updated_by      IN CREDIT_CARD.UPDATED_BY%TYPE
  ) AS
  BEGIN
    -- Create history
    PROCS_HISTORY_V14.CREATE_CREDIT_CARD_HISTORY(
        in_credit_card_id            => in_credit_card_id,
        in_system_activity_reason_id => GLOBAL_ENUMS_V14.SAC_SYSTEM_APPLIED_RULE
    );

    UPDATE CREDIT_CARD
    SET UPDATE_DATE = SYSDATE,
    UPDATED_BY = in_updated_by,
    CREDIT_CARD_STATUS_ID = GLOBAL_STATUSES_V14.CREDIT_CARD_DISABLED
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
    PROCS_HISTORY_V14.CREATE_CREDIT_CARD_HISTORY(
        in_credit_card_id            => in_credit_card_id,
        in_system_activity_reason_id => GLOBAL_ENUMS_V14.SAC_SYSTEM_APPLIED_RULE
    );

    UPDATE CREDIT_CARD
    SET UPDATE_DATE = SYSDATE,
    UPDATED_BY = in_updated_by,
    LAST_FOUR_CC = NVL(in_last_four_cc, LAST_FOUR_CC),
    EXPIRATION_DATE = NVL(in_expiration_date, EXPIRATION_DATE)
    WHERE ID = in_credit_card_id;
  END UPDATE_CREDIT_CARD;

END PROCS_CUPY;

.
/

