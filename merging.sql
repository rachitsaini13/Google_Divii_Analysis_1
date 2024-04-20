
  
CREATE TABLE `something-420903.GoogleCapstone.all_months`
AS (SELECT * FROM `something-420903.GoogleCapstone.april23`
UNION ALL 
SELECT * FROM `something-420903.GoogleCapstone.aug23`
UNION ALL 
SELECT * FROM `something-420903.GoogleCapstone.dec22`
UNION ALL 
SELECT * FROM `something-420903.GoogleCapstone.feb23`
UNION ALL 
SELECT * FROM `something-420903.GoogleCapstone.jan23`
UNION ALL 
SELECT * FROM `something-420903.GoogleCapstone.july23`
UNION ALL 
SELECT * FROM `something-420903.GoogleCapstone.june23`
UNION ALL 
SELECT * FROM `something-420903.GoogleCapstone.march23`
UNION ALL 
SELECT * FROM `something-420903.GoogleCapstone.may23`
UNION ALL 
SELECT * FROM `something-420903.GoogleCapstone.nov22`
UNION ALL 
SELECT * FROM `something-420903.GoogleCapstone.oct22`
UNION ALL 
SELECT * FROM `something-420903.GoogleCapstone.sept22`
)
