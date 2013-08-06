WHENEVER SQLERROR EXIT ROLLBACK;

--was set to pacific.edu incorrectly for SY-2192
update group_account_email_domain set email_domain='pacificu.edu', updated_by='jira-SAR-617', update_date=sysdate where ID=724;

--is active even though the subscription is  not, another sjcny.edu is active with group account id 59253 with active subscription
update group_account_email_domain set is_active=0, updated_by='jira-SAR-617', update_date=sysdate where ID=431;

--Based on Carol email
--UNIV OF NEB-LINCOLN via Bugzilla 74966 (892025628@unl.edu) is UNL.edu – that’s a L as in Lincoln
--UNIV OF NORTHERN IA via Bugzilla 74966 (same ticket) (892025586@uni.edu) is UNI.edu – as in Iowa
update group_account_email_domain set email_domain='unl.edu', updated_by='jira-SAR-617', update_date=sysdate where ID=306;

--duplicate uni.edu under same  group account
update group_account_email_domain set is_active=0, updated_by='jira-SAR-617', update_date=sysdate where ID=307;

commit;
