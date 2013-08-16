WHENEVER SQLERROR EXIT SQL.SQLCODE ROLLBACK

-- Run time in ECST2 was about 6mins
INSERT
INTO
    Amazon_Sub
    (
        ID ,
        subscription_Id ,
        Amazon_Id ,
        CREATE_DATE ,
        Created_By ,
        Update_Date ,
        Updated_By
    )
SELECT
    AMAZON_SUB_ID_SEQ.nextVal,
    s2.id,
    Az.Amazon_Id,
    SYSDATE,
    'JIRA-SAR-538',
    SYSDATE,
    'JIRA-SAR-538'
FROM
    CORE_OWNER.AMAZON_SUB az
INNER JOIN
    CORE_OWNER.SUBSCRIPTION s
ON
    az.SUBSCRIPTION_ID = s.id
INNER JOIN
    CORE_OWNER.ACCOUNT a
ON
    s.Account_Id = a.Id
INNER JOIN
    CORE_OWNER.SUBSCRIPTION s2
ON
    s2.ACCOUNT_ID = a.id
WHERE
    S.Offer_Chain_Id = 494003
AND S.Updated_By = 'JIRA-SAR-538'
AND S2.Subscription_Status_Id = 1
AND S2.Created_By = 'JIRA-SAR-538'
AND S2.Offer_Chain_Id = 2691330666;

COMMIT;
