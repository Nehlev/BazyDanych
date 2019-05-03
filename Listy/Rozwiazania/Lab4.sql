/* Lab 4_1 */
SELECT GRUPA.NrGrupy, COUNT(STUDENT.Nazwisko) AS LiczbaStudentow
FROM Uczelnia.dbo.Grupa as GRUPA
LEFT JOIN Uczelnia.dbo.Student as STUDENT
ON GRUPA.IdGrupy=STUDENT.IdGrupy GROUP BY GRUPA.NrGrupy

/* Lab 4_2 */
SELECT * FROM Przedmiot
SELECT PRZEDMIOT.Nazwa, SUM(PRZEDMIOT.ECTS) as SumaPktEcts 
FROM Uczelnia.dbo.Przedmiot as PRZEDMIOT GROUP BY PRZEDMIOT.Nazwa

/* LAB 4_3 */
SELECT ZALICZENIE.DataZaliczenia, AVG(ZALICZENIE.Ocena) as SredniaOcen
FROM Uczelnia.dbo.Zaliczenie as ZALICZENIE GROUP BY ZALICZENIE.DataZaliczenia

/* LAB 4_4 */
SELECT DISTINCT CONCAT(STUDENT.Imie, ',', STUDENT.Nazwisko) as ImieINazwisko, AVG(ZALICZENIE.Ocena) as OcenaSrednia 
FROM Uczelnia.dbo.Student AS STUDENT
JOIN Uczelnia.dbo.Zapisy as ZAPISY ON STUDENT.NrIndeksu=ZAPISY.NrIndeksu
JOIN UCZELNIA.dbo.Zaliczenie as ZALICZENIE ON ZAPISY.IdZapisu=ZALICZENIE.IdZapisu
GROUP BY STUDENT.Imie, STUDENT.Nazwisko

/* Lab 4_5 */
SELECT DISTINCT CONCAT(PRACOWNIK.Imie, PRACOWNIK.Nazwisko) AS Pracownik, AVG(ZALICZENIE.Ocena) As OcenaSrednia
FROM Uczelnia.dbo.Pracownik PRACOWNIK
LEFT JOIN Uczelnia.dbo.ProwadzacyPrzedmiot PROWADZACY ON PRACOWNIK.IdPracownika=PROWADZACY.IdPracownika
JOIN Uczelnia.dbo.Zapisy ZAPISY ON PROWADZACY.IdPrzydzialu=ZAPISY.IdPrzydzialu
JOIN Uczelnia.dbo.Zaliczenie ZALICZENIE ON ZALICZENIE.IdZapisu=ZAPISY.IdZapisu
group by PRACOWNIK.Imie, PRACOWNIK.Nazwisko

/* Lab 4_6 */
SELECT
	CONCAT(STUDENT.Imie, STUDENT.Nazwisko) AS ImieNazwisko,
	CONCAT(
		case
			when right(PRZEDMIOT.KodPrzedmiotu, 1)='L' then 'LAB'
			when right(PRZEDMIOT.KodPrzedmiotu, 1)='P' then 'PROJ'
			else right(PRZEDMIOT.KodPrzedmiotu, 1)
		end ,' ',
		case
			when ZALICZENIE.TypZaliczenia='egzamin' then 'E'
			else NULL
		end ,' ', PRZEDMIOT.Nazwa) AS Przedmiot,
	max(Zaliczenie.Ocena) AS Ocena,
	CONCAT(PRACOWNIK.Imie, PRACOWNIK.Nazwisko) AS Prowadzacy
FROM Uczelnia.dbo.Student STUDENT
LEFT JOIN Uczelnia.dbo.Zapisy ZAPISY ON STUDENT.NrIndeksu=ZAPISY.NrIndeksu
JOIN Uczelnia.dbo.Zaliczenie ZALICZENIE ON ZALICZENIE.IdZapisu=ZALICZENIE.IdZapisu
JOIN Uczelnia.dbo.ProwadzacyPrzedmiot PROWADZACY ON PROWADZACY.IdPrzydzialu=ZAPISY.IdPrzydzialu
JOIN Uczelnia.dbo.Pracownik PRACOWNIK ON PRACOWNIK.IdPracownika=PROWADZACY.IdPracownika
JOIN Uczelnia.dbo.Przedmiot PRZEDMIOT ON PROWADZACY.KodPrzedmiotu=PRZEDMIOT.KodPrzedmiotu
GROUP BY 
	CONCAT(STUDENT.Imie, STUDENT.Nazwisko),
	PRZEDMIOT.NAZWA,
	CONCAT(PRACOWNIK.Imie, PRACOWNIK.Nazwisko),
	PRZEDMIOT.KodPrzedmiotu,
	ZALICZENIE.TypZaliczenia
