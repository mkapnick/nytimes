UPDATE OFFER_CHAIN_NOTIFICATION_TYPE
SET NOTIFICATION_TYPE_ID = (
  SELECT NOTIFICATION_TYPE.ID FROM NOTIFICATION_TYPE WHERE VALUE = 'sartre-upsell-sub-activation-digital-access-code'
)
WHERE OFFER_CHAIN_ID = 60015003
AND ACTION_ID = (
    SELECT ID FROM ACTION WHERE NAME = 'GC_REDEEMER_ON_REDEEM'
);

COMMIT;