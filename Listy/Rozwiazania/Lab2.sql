/* Lab2_1 */
SELECT * FROM Uczelnia.dbo.Student

/* Lab2_2 */
SELECT Imie, Nazwisko FROM Uczelnia.dbo.Student

/* Lab2_3 */
SELECT CONCAT(Imie, Nazwisko) as STUDENT FROM Uczelnia.dbo.Student

/* Lab2_4 */
SELECT * FROM Uczelnia.dbo.Student ORDER BY Nazwisko

/* Lab2_5 */
SELECT * FROM Uczelnia.dbo.Student WHERE Miejscowosc like 'Wroc³aw'

/* Lab2_6 */
SELECT * FROM Uczelnia.dbo.Student WHERE CONTAINS(Email, 'interia.pl')

/* Lab2_7 */
SELECT * FROM Uczelnia.dbo.Pracownik WHERE CONTAINS(Tytul, 'Mgr')

/* Lab2_8 */
SELECT * FROM Uczelnia.dbo.Pracownik WHERE CONTAINS(Tytul, 'Dr') and Miejscowosc like 'Wroc³aw'

/* Lab2_9 */
SELECT * FROM Uczelnia.dbo.Pracownik WHERE Stanowisko like 'asystent' or Stanowisko like 'wyk³adowca'

/* Lab2_10 */
SELECT * FROM Uczelnia.dbo.Pracownik WHERE Stanowisko like 'wyk³adowca' and not CONTAINS(Tytul, 'hab')

/* Lab2_11 */
SELECT DISTINCT Miejscowosc FROM Uczelnia.dbo.Pracownik
