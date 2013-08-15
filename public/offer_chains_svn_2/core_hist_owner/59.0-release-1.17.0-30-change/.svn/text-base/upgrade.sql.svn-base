WHENEVER SQLERROR EXIT ROLLBACK;

variable is_current_version_fine NUMBER;
variable change_version NUMBER;
variable bad_current_version VARCHAR2(1024);

exec :change_version := 30;
exec PROCS_SYSTEM_V17.CHECK_VERSION(:change_version - 1, :is_current_version_fine);
exec :bad_current_version := 'Current version is bad, please update your version to '||(:change_version-1);

BEGIN
  IF (:is_current_version_fine != 0) THEN
    RAISE_APPLICATION_ERROR(-20001, :bad_current_version);
  END IF;
END;
/

CREATE TABLE dbdeploy_changelog (
  change_number NUMBER(22,0) NOT NULL,
  complete_dt TIMESTAMP NOT NULL,
  applied_by VARCHAR2(100) NOT NULL,
  description VARCHAR2(500) NOT NULL
);

ALTER TABLE dbdeploy_changelog ADD CONSTRAINT dbdeploy_changelog_pk PRIMARY KEY (change_number);

exec PROCS_SYSTEM_V17.INCREMENT_VERSION();
