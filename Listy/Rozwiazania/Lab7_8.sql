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
--"Zaprojektowa� widok kt�ry wy�wietli imi� i nazwisko studenta, numer jego indeksu oraz nazwy przedmiot�w na jakie jest zapisany."
--Nie znam mechanizmu ( nie wiem czy Microsoft SQL takowy oferuje ) kt�ry potrafi zaprezentowa� wynik kt�ry jest kolekcj� w jednej kolumnie :/

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
--DROP PROC Pokaz_Wszystkie_Przedmioty_Studenta
--GO

CREATE PROC Pokaz_Wszystkie_Przedmioty_Studenta
	@ImieStudenta char(30),
	@NazwiskoStudenta char(40) AS SELECT DISTINCT

Imie, Nazwisko, Nazwa FROM V_Student_Imie_Nazwisko_NumerIndeksu_NazwyPrzedmiotow 
WHERE 
Imie=@ImieStudenta AND Nazwisko=@NazwiskoStudenta

GO

EXEC Pokaz_Wszystkie_Przedmioty_Studenta 'Marcin', 'Andrzejewski'
EXEC Pokaz_Wszystkie_Przedmioty_Studenta 'Micha�', 'Bobrowski'
GO

/**************** Lab 7_8_7 ****************/
--DROP PROC Pokaz_Wszystkie_Przedmioty_Prowadzacego
--GO

CREATE PROC Pokaz_Wszystkie_Przedmioty_Prowadzacego
	@ImieProwadzacego char(30),
	@NazwiskoProwadzacego char(40) AS SELECT DISTINCT

Pracownik_Imie, Pracownik_Nazwisko, Nazwa FROM V_Przedmiot_I_Prowadzacy 
WHERE 
Pracownik_Imie=@ImieProwadzacego AND Pracownik_Nazwisko=@NazwiskoProwadzacego
GO

EXEC Pokaz_Wszystkie_Przedmioty_Prowadzacego 'Bogdan', 'Janicki'
EXEC Pokaz_Wszystkie_Przedmioty_Prowadzacego 'Jan', 'Kowalski'
EXEC Pokaz_Wszystkie_Przedmioty_Prowadzacego 'Piotr', 'Marcinkowski'
EXEC Pokaz_Wszystkie_Przedmioty_Prowadzacego 'Grzegorz', 'Andrzejewski'
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
--DROP PROC Pokaz_Wszystkie_Tylko_Oceny_Studenta
--GO

CREATE PROC Pokaz_Wszystkie_Tylko_Oceny_Studenta
	@ImieStudenta char(30),
	@NazwiskoStudenta char(40) AS SELECT 

Imie, Nazwisko, Ocena FROM V_Student_Imie_Nazwisko_NumerIndeksu_Ocena 
WHERE 
Imie=@ImieStudenta AND Nazwisko=@NazwiskoStudenta
GO

EXEC Pokaz_Wszystkie_Tylko_Oceny_Studenta 'Marcin', 'Andrzejewski'
EXEC Pokaz_Wszystkie_Tylko_Oceny_Studenta 'Micha�', 'Bobrowski'
GO

/**************** Lab 7_8_10  ****************/
DROP VIEW V_Przedmiot_Student_Niezdal
GO

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

/**************** Lab 7_8_11  ****************/
--DROP PROC Dodaj_Sale
--GO

CREATE PROC Dodaj_Sale
	@IdSali int,
	@IdOddzialu tinyint,
	@Pojemnosc int,
	@KodTyp char(3) AS INSERT
Sala(IdSali, IdOddzialu, Pojemnosc, KodTyp)
VALUES (@IdSali, @IdOddzialu, @Pojemnosc, @KodTyp)
GO

EXEC Dodaj_Sale 13, 3, 30, LAB
EXEC Dodaj_Sale 14, 3, 30, LAB
GO

SELECT * FROM Sala
