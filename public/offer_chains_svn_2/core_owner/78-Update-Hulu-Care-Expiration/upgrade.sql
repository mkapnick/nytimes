UPDATE GIFT_CERTIFICATE 
SET 	EXPIRATION_DATE = to_date('2013-Nov-01', 'yyyy-mon-dd'),
	UPDATED_BY = 'PMOM-47',
	UPDATE_DATE = SYSDATE
WHERE SENDER_EMAIL = 'hulu_bun_b_care_300@nyt.net';
