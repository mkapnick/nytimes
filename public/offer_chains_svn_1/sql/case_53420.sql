BEGIN
  UPDATE OFFER_CHAIN_META_DATA SET VALUE = 'uco.edu' WHERE offer_chain_id = '271264' and name = 'REQUIRES_EMAIL_DOMAIN';
  UPDATE OFFER_CHAIN_ELIGIBILITY SET VALUE = 'uco.edu' WHERE offer_chain_id = '271264' and name = 'REQUIRES_EMAIL_DOMAIN';
  COMMIT;
END;
/
exit