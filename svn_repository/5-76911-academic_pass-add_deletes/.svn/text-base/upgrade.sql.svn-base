-- Bugzilla: 76911 - Academic Passes - adds and deletes
WHENEVER SQLERROR EXIT ROLLBACK;

--------------------------------------------------------------------------------
-- Group Id: 59131
-- Group Name: SWAWLX200253862
-- Subscription Id: 7145077
-- Subscription created: 2012-08-23 12:12:46
--------------------------------------------------------------------------------
INSERT INTO group_account_email_domain (id, group_account_id, email_domain, is_active, created_by, create_date, updated_by, update_date)
VALUES (groupaccountemaildomain_seq.nextval, 59131, 'students.wwu.edu', 1, 'bugzilla_76911', SYSDATE, 'bugzilla_76911', SYSDATE);

--------------------------------------------------------------------------------
-- Group Id: 58946
-- Group Name: SSDK3X200273225
-- Subscription Id: 7144380
-- Subscription created: 2012-08-23 09:34:49
--------------------------------------------------------------------------------
INSERT INTO group_account_email_domain (id, group_account_id, email_domain, is_active, created_by, create_date, updated_by, update_date)
VALUES (groupaccountemaildomain_seq.nextval, 58946, 'ole.auggies.edu', 1, 'bugzilla_76911', sysdate, 'bugzilla_76911', sysdate);

--------------------------------------------------------------------------------
-- Group Id: 59208
-- Group Name: SNEPXX200274025
-- Subscription Id: 7145327
-- Subscription created: 2012-08-23 13:28:47
--------------------------------------------------------------------------------
INSERT INTO group_account_email_domain (id, group_account_id, email_domain, is_active, created_by, create_date, updated_by, update_date)
VALUES (groupaccountemaildomain_seq.nextval, 59208, 'unk.edu', 1, 'bugzilla_76911', sysdate, 'bugzilla_76911', sysdate);

-- disable two email domains
UPDATE group_account_email_domain
SET is_active = 0,
    updated_by = 'bugzilla_76911',
    update_date = SYSDATE
    WHERE email_domain IN ('augie.edu','nebrska.edu');

COMMIT;

