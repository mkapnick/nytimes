-- Bug 76373: Correct revoke_entitlements setting for comp offer chains
WHENEVER SQLERROR EXIT ROLLBACK;

UPDATE offer_chain
SET revoke_entitlements = 1,
    updated_by = 'bugzilla_76373',
    update_date = SYSDATE
WHERE id IN (1000002,
             1000221,
             1000231,
             1000241,
             1000251,
             3990783944,
             1000281,
             826796,
             126084,
             256605,
             1000481);

COMMIT;

