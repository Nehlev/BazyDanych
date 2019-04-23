SELECT * FROM Uczelnia.dbo.Pracownik
SELECT * FROM Uczelnia.dbo.Student
SELECT * FROM Uczelnia.dbo.Grupa
SELECT * FROM Uczelnia.dbo.OddzialUczelni
SELECT * FROM Uczelnia.dbo.Przedmiot

/* Lab3_2 */
SELECT Nazwisko, Nazwa
FROM Uczelnia.dbo.Pracownik as LHS INNER JOIN Uczelnia.dbo.OddzialUczelni as RHS 
ON LHS.IdOddzialu = RHS.IdOddzialu

/* Lab3_3 */
SELECT DISTINCT Nazwa FROM Uczelnia.dbo.OddzialUczelni LHS LEFT JOIN Uczelnia.dbo.Pracownik RHS
ON LHS.IdOddzialu=RHS.IdOddzialu WHERE RHS.Nazwisko IS NULL

/* Lab3_4 */
SELECT LHS.Nazwisko, RHS.IdGrupy FROM Uczelnia.dbo.Student LHS RIGHT JOIN Uczelnia.dbo.Grupa RHS
ON LHS.IdGrupy=RHS.IdGrupy

/* Lab3_5 */
SELECT PRZEDMIOT.KodPrzedmiotu, PRZEDMIOT.Nazwa, CONCAT(PROWADZACY.RokPoczatek, '/', PROWADZACY.RokKoniec) AS RokAkademicki,/* Rok Akademicki */ PRZEDMIOT.Semestr, PRACOWNIK.Nazwisko
FROM Uczelnia.dbo.Przedmiot PRZEDMIOT
INNER JOIN Uczelnia.dbo.ProwadzacyPrzedmiot PROWADZACY ON PROWADZACY.KodPrzedmiotu=PRZEDMIOT.KodPrzedmiotu
INNER JOIN Uczelnia.dbo.Pracownik PRACOWNIK ON PRACOWNIK.IdPracownika=PROWADZACY.IdPracownika


