WHENEVER SQLERROR EXIT SQL.SQLCODE ROLLBACK

UPDATE
    license
SET
    license.ENTITLEMENT_END_DATE = SYSDATE,
    license.UPDATE_DATE = SYSDATE,
    license.UPDATED_BY = 'JIRA-SAR-754'
WHERE
    id IN(23307269,
          22529004,
          26239404,
          26283392,
          24694981,
          22627251,
          21218821,
          26393215,
          26318666,
          24739082,
          24726869,
          24168480,
          24567430,
          25853162,
          25295384,
          25167272,
          23278626,
          23151270,
          21259222,
          20943854,
          22145648,
          27161346,
          26587927,
          24246192,
          25268036,
          23955766,
          23955076,
          23097406,
          23229128,
          23391493,
          22016587,
          22059935,
          22031504,
          26566300,
          21851569,
          26176682,
          26032716,
          25908728,
          25851977,
          24995743,
          24883855,
          24551513,
          24544701,
          24348076,
          23633821,
          23412615,
          21662639,
          21044274,
          22328748,
          22489479,
          27091857,
          26484287,
          24881384,
          24723375,
          23761848,
          23742922,
          23478697,
          23036354,
          22054061,
          22003147,
          21984176,
          21864847,
          21788972,
          21482494,
          27724429,
          22772884,
          21488847,
          21170825,
          21024384,
          27067239,
          27217924,
          22648769);

COMMIT;