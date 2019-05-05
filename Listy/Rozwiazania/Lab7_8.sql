/*************** Lab 7_8_1 ****************/
--DROP VIEW V_Pracownicy_I_Oddzial
--GO 

CREATE VIEW V_Pracownicy_I_Oddzial as SELECT

PRACOWNIK.Tytul, PRACOWNIK.Nazwisko, PRACOWNIK.Imie, PRACOWNIK.Stanowisko, PRACOWNIK.TelefonKom, PRACOWNIK.Email,
ODDZIAL.Nazwa as MiejscePracy_Nazwa, ODDZIAL.Miasto as MiejscePracy_Adres, ODDZIAL.Telefon as MiejscePracy_Telefon, ODDZIAL.Email as MiejscePracy_Email

FROM Pracownik as PRACOWNIK
INNER JOIN OddzialUczelni ODDZIAL ON PRACOWNIK.IdOddzialu=ODDZIAL.IdOddzialu
GO

SELECT * FROM V_Pracownicy_I_Oddzial
GO

/**************** Lab 7_8_2 ****************/
--DROP VIEW V_Przedmiot_I_Prowadzacy
--GO

CREATE VIEW V_Przedmiot_I_Prowadzacy as SELECT

PRZEDMIOT.Nazwa, PRZEDMIOT.KodPrzedmiotu, PRZEDMIOT.Semestr, PRZEDMIOT.ECTS, PRZEDMIOT.FormaZajec,
PRACOWNIK.Imie as Pracownik_Imie, PRACOWNIK.Nazwisko as Pracownik_Nazwisko

FROM Przedmiot as PRZEDMIOT
LEFT JOIN ProwadzacyPrzedmiot as PROWADZACY ON PRZEDMIOT.KodPrzedmiotu=PROWADZACY.KodPrzedmiotu
JOIN Pracownik as PRACOWNIK ON PROWADZACY.IdPracownika=PRACOWNIK.IdPracownika
GO

SELECT * FROM V_Przedmiot_I_Prowadzacy
GO

/**************** Lab 7_8_3 ****************/
--DROP VIEW V_Zaliczenie_I_Student_I_Prowadzacy
--GO

CREATE VIEW V_Zaliczenie_I_Student_I_Prowadzacy as SELECT

PROWADZACY.KodPrzedmiotu, PRZEDMIOT.Nazwa,
ZALICZENIE.Ocena, ZALICZENIE.TypZaliczenia, ZALICZENIE.Termin,
STUDENT.Imie as StudentImie, STUDENT.Nazwisko as StudentNazwisko,
PRACOWNIK.Imie as ProwadzacyImie, PRACOWNIK.Nazwisko as ProwadzacyNazwisko

FROM Zaliczenie as ZALICZENIE
LEFT JOIN Zapisy as ZAPISY ON ZALICZENIE.IdZapisu=ZAPISY.IdZapisu
JOIN Student as STUDENT ON ZAPISY.NrIndeksu=STUDENT.NrIndeksu
JOIN ProwadzacyPrzedmiot as PROWADZACY ON ZAPISY.IdPrzydzialu=PROWADZACY.IdPrzydzialu
JOIN Pracownik as PRACOWNIK ON PROWADZACY.IdPracownika=PRACOWNIK.IdPracownika
JOIN Przedmiot as PRZEDMIOT ON PRZEDMIOT.KodPrzedmiotu=PROWADZACY.KodPrzedmiotu
GO

SELECT * FROM V_Zaliczenie_I_Student_I_Prowadzacy
GO

/**************** Lab 7_8_4 ****************/
--DROP VIEW V_Student_I_NazwaGrupy_I_NazwaOddzialu
--GO

CREATE VIEW V_Student_I_NazwaGrupy_I_NazwaOddzialu as SELECT

Student.Nazwisko, Student.Imie, Student.IdGrupy,
ODDZIAL.Nazwa

FROM Student as STUDENT
LEFT JOIN OddzialUczelni as ODDZIAL ON STUDENT.IdOddzialu=ODDZIAL.IdOddzialu
GO

SELECT * FROM V_Student_I_NazwaGrupy_I_NazwaOddzialu
GO

/**************** Lab 7_8_5 ****************/
--"Zaprojektowaæ widok który wyœwietli imiê i nazwisko studenta, numer jego indeksu oraz nazwy przedmiotów na jakie jest zapisany."
--Nie znam mechanizmu ( nie wiem czy Microsoft SQL takowy oferuje ) który potrafi zaprezentowaæ wynik który jest kolekcj¹ w jednej kolumnie :/

--DROP VIEW V_Student_Imie_Nazwisko_NumerIndeksu_NazwyPrzedmiotow
--GO

CREATE VIEW V_Student_Imie_Nazwisko_NumerIndeksu_NazwyPrzedmiotow as SELECT

Student.Imie, Student.Nazwisko, Student.NrIndeksu,
PRZEDMIOT.Nazwa, PRZEDMIOT.KodPrzedmiotu

FROM Student as STUDENT
LEFT JOIN Zapisy as ZAPISY ON Zapisy.NrIndeksu=STUDENT.NrIndeksu
JOIN ProwadzacyPrzedmiot as PROWADZACY ON ZAPISY.IdPrzydzialu=PROWADZACY.IdPrzydzialu
JOIN Przedmiot as PRZEDMIOT ON PROWADZACY.KodPrzedmiotu=PRZEDMIOT.KodPrzedmiotu
GO

SELECT * FROM V_Student_Imie_Nazwisko_NumerIndeksu_NazwyPrzedmiotow
GO

/**************** Lab 7_8_6 ****************/
--DROP PROC Przedmioty_Studenta_pokaz
--GO

CREATE PROC Przedmioty_Studenta_pokaz
	@ImieStudenta char(30),
	@NazwiskoStudenta char(40) AS SELECT DISTINCT

Imie, Nazwisko, Nazwa FROM V_Student_Imie_Nazwisko_NumerIndeksu_NazwyPrzedmiotow 
WHERE 
Imie=@ImieStudenta AND Nazwisko=@NazwiskoStudenta

GO

EXEC Przedmioty_Studenta_pokaz 'Marcin', 'Andrzejewski'
EXEC Przedmioty_Studenta_pokaz 'Micha³', 'Bobrowski'
GO

/**************** Lab 7_8_7 ****************/
--DROP PROC Przedmioty_Prowadzacego_pokaz
--GO

CREATE PROC Przedmioty_Prowadzacego_pokaz
	@ImieProwadzacego char(30),
	@NazwiskoProwadzacego char(40) AS SELECT DISTINCT

Pracownik_Imie, Pracownik_Nazwisko, Nazwa FROM V_Przedmiot_I_Prowadzacy 
WHERE 
Pracownik_Imie=@ImieProwadzacego AND Pracownik_Nazwisko=@NazwiskoProwadzacego
GO

EXEC Przedmioty_Prowadzacego_pokaz 'Bogdan', 'Janicki'
EXEC Przedmioty_Prowadzacego_pokaz 'Jan', 'Kowalski'
EXEC Przedmioty_Prowadzacego_pokaz 'Piotr', 'Marcinkowski'
EXEC Przedmioty_Prowadzacego_pokaz 'Grzegorz', 'Andrzejewski'
GO

/**************** Lab 7_8_8 ****************/
--DROP VIEW V_Student_Imie_Nazwisko_NumerIndeksu_Ocena
--GO

CREATE VIEW V_Student_Imie_Nazwisko_NumerIndeksu_Ocena as SELECT 

Student.Imie, Student.Nazwisko, Student.NrIndeksu, ZALICZENIE.Ocena

FROM Student as STUDENT
LEFT JOIN Zapisy as ZAPISY ON Zapisy.NrIndeksu=STUDENT.NrIndeksu
JOIN Zaliczenie as ZALICZENIE ON ZAPISY.IdPrzydzialu=ZALICZENIE.IdZapisu
GO

SELECT * FROM V_Student_Imie_Nazwisko_NumerIndeksu_Ocena
GO

/**************** Lab 7_8_9 ****************/
--DROP PROC Tylko_Oceny_Studenta_pokaz
--GO

CREATE PROC Tylko_Oceny_Studenta_pokaz
	@ImieStudenta char(30),
	@NazwiskoStudenta char(40) AS SELECT 

Imie, Nazwisko, Ocena FROM V_Student_Imie_Nazwisko_NumerIndeksu_Ocena 
WHERE 
Imie=@ImieStudenta AND Nazwisko=@NazwiskoStudenta
GO

EXEC Tylko_Oceny_Studenta_pokaz 'Marcin', 'Andrzejewski'
EXEC Tylko_Oceny_Studenta_pokaz 'Micha³', 'Bobrowski'
GO

/**************** Lab 7_8_10 ****************/
--DROP VIEW V_Przedmiot_Student_Niezdal
--GO

CREATE VIEW V_Przedmiot_Student_Niezdal as SELECT DISTINCT

PRZEDMIOT.Nazwa, PRZEDMIOT.KodPrzedmiotu, ZALICZENIE.Ocena,
STUDENT.Imie, STUDENT.Nazwisko, STUDENT.NrIndeksu

FROM Zaliczenie as ZALICZENIE
LEFT JOIN Zapisy as ZAPISY ON ZALICZENIE.IdZapisu=ZAPISY.IdZapisu
JOIN Student as STUDENT ON Student.NrIndeksu=ZAPISY.NrIndeksu
JOIN ProwadzacyPrzedmiot as PROWADZACY ON ZAPISY.IdPrzydzialu=PROWADZACY.IdPrzydzialu
JOIN Przedmiot as PRZEDMIOT ON PROWADZACY.KodPrzedmiotu=PRZEDMIOT.KodPrzedmiotu
WHERE ZALICZENIE.Ocena like 2.0
GO

SELECT * FROM V_Przedmiot_Student_Niezdal
GO

/**************** Lab 7_8_11 ****************/
--DROP PROC Sala_wstawianie
--GO

CREATE PROC Sala_wstawianie
	@IdSali int,
	@IdOddzialu tinyint,
	@Pojemnosc int,
	@KodTyp char(3) AS INSERT
Sala(IdSali, IdOddzialu, Pojemnosc, KodTyp)
VALUES (@IdSali, @IdOddzialu, @Pojemnosc, @KodTyp)
GO

EXEC Sala_wstawianie 13, 3, 30, LAB
EXEC Sala_wstawianie 14, 3, 30, LAB
GO

/**************** Lab 7_8_12 ****************/
DROP PROC ProwadzacyPrzedmiot_wstawianie
GO 
/* Odkomentowane poniewaz jest to modyfikacja utworzonej juz wczesniej procedury */

CREATE PROC ProwadzacyPrzedmiot_wstawianie
	@IdPrzydzialu int, -- klucz glówny
	@KodPrzedmiotu char(7),
	@IdPracownika int,
	@IdGrupy smallint,
	@RokPoczatek smallint,
	@RokKoniec smallint,
	@Semestr tinyint, -- "1" - zimowy; "2" - letni
	@IdOddzialu tinyint,
	@IdSali int
AS

INSERT ProwadzacyPrzedmiot
(IdPrzydzialu, KodPrzedmiotu, IdPracownika, IdGrupy, RokPoczatek, RokKoniec, Semestr, IdOddzialu)
VALUES
(@IdPrzydzialu, @KodPrzedmiotu, @IdPracownika, @IdGrupy, @RokPoczatek, @RokKoniec, @Semestr, @IdOddzialu)

INSERT SalaPrzydzial(IdPrzydzialu, IdSali)
VALUES (@IdPrzydzialu, @IdSali)

GO

EXEC ProwadzacyPrzedmiot_wstawianie 5, 'INF517L', 5, 1, 2004, 2005, 1, 1, 2
GO

/**************** Lab 7_8_13 ****************/
DROP PROC Srednia_Ocen_pokaz
GO

CREATE PROC Srednia_Ocen_pokaz
	@NrIndeksu int AS SELECT

Imie, Nazwisko, AVG(Ocena) AS SredniaOcen FROM V_Student_Imie_Nazwisko_NumerIndeksu_Ocena
WHERE NrIndeksu=@NrIndeksu
GROUP BY 
	V_Student_Imie_Nazwisko_NumerIndeksu_Ocena.Imie,
	V_Student_Imie_Nazwisko_NumerIndeksu_Ocena.Nazwisko

GO

SELECT * FROM V_Student_Imie_Nazwisko_NumerIndeksu_Ocena
ORDER BY Nazwisko

EXEC Srednia_Ocen_pokaz 1
EXEC Srednia_Ocen_pokaz 2
GO
