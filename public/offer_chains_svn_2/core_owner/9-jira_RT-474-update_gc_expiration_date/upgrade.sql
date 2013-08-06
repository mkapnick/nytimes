WHENEVER SQLERROR EXIT SQL.SQLCODE ROLLBACK

UPDATE GIFT_CERTIFICATE
SET EXPIRATION_DATE = to_date('2/28/2013', 'MM/DD/YYYY'),
    UPDATE_DATE = SYSDATE,
    UPDATED_BY = 'JIRA_RT-474'
WHERE offer_chain_id = 1777260
      and expiration_date > SYSDATE
      and cancelation_date is NULL
      and redemption_date is NULL;

COMMIT;

