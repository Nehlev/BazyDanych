/* Lab2_1 */
SELECT * FROM Telco_Wroclaw.dbo.TelcoUser

/* Lab2_2 */
SELECT Name, Surname FROM Telco_Wroclaw.dbo.TelcoUser

/* Lab2_3 */
SELECT CONCAT(Name, Surname) as STUDENT FROM Telco_Wroclaw.dbo.TelcoUser

/* Lab2_4 */
SELECT * FROM Telco_Wroclaw.dbo.TelcoUser ORDER BY Surname

/* Lab2_5 */
SELECT * FROM Telco_Wroclaw.dbo.TelcoUser WHERE Address_City like 'Wroclaw'
