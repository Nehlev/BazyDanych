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
SELECT PRZEDMIOT.KodPrzedmiotu, PRZEDMIOT.Nazwa, CONCAT(PROWADZACY.RokPoczatek, '/', PROWADZACY.RokKoniec) AS RokAkademicki, PRZEDMIOT.Semestr, PRACOWNIK.Nazwisko
FROM Uczelnia.dbo.Przedmiot PRZEDMIOT
INNER JOIN Uczelnia.dbo.ProwadzacyPrzedmiot PROWADZACY ON PROWADZACY.KodPrzedmiotu=PRZEDMIOT.KodPrzedmiotu
INNER JOIN Uczelnia.dbo.Pracownik PRACOWNIK ON PRACOWNIK.IdPracownika=PROWADZACY.IdPracownika

/* Lab3_6 */
SELECT ZALICZENIE.Ocena, STUDENT.Nazwisko as NazwiskoStudenta, PRZEDMIOT.Nazwa, PRACOWNIK.Nazwisko as NazwiskoProwadzacego
FROM Uczelnia.dbo.Zaliczenie ZALICZENIE
INNER JOIN Uczelnia.dbo.Zapisy ZAPISY ON ZALICZENIE.IdZapisu=ZAPISY.IdZapisu
INNER JOIN Uczelnia.dbo.Student STUDENT ON STUDENT.NrIndeksu=ZAPISY.NrIndeksu
INNER JOIN Uczelnia.dbo.ProwadzacyPrzedmiot PROWADZACY ON PROWADZACY.IdPrzydzialu=ZAPISY.IdPrzydzialu
INNER JOIN Uczelnia.dbo.Pracownik PRACOWNIK ON PRACOWNIK.IdPracownika=PROWADZACY.IdPracownika
INNER JOIN Uczelnia.dbo.Przedmiot PRZEDMIOT ON PRZEDMIOT.KodPrzedmiotu=PROWADZACY.KodPrzedmiotu
