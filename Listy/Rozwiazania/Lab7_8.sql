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
--DROP PROC All_Subjects_Of_Student
--GO

CREATE PROC All_Subjects_Of_Student
	@ImieStudenta char(30),
	@NazwiskoStudenta char(40) AS SELECT DISTINCT

Imie, Nazwisko, Nazwa FROM V_Student_Imie_Nazwisko_NumerIndeksu_NazwyPrzedmiotow 
WHERE 
Imie=@ImieStudenta AND Nazwisko=@NazwiskoStudenta

GO

EXEC All_Subjects_Of_Student 'Marcin', 'Andrzejewski'
EXEC All_Subjects_Of_Student 'Micha³', 'Bobrowski'
GO

/**************** Lab 7_8_7 ****************/
--DROP PROC All_Subjects_Of_Lecturer
--GO

CREATE PROC All_Subjects_Of_Lecturer
	@ImieProwadzacego char(30),
	@NazwiskoProwadzacego char(40) AS SELECT DISTINCT

Pracownik_Imie, Pracownik_Nazwisko, Nazwa FROM V_Przedmiot_I_Prowadzacy 
WHERE 
Pracownik_Imie=@ImieProwadzacego AND Pracownik_Nazwisko=@NazwiskoProwadzacego
GO

EXEC All_Subjects_Of_Lecturer 'Bogdan', 'Janicki'
EXEC All_Subjects_Of_Lecturer 'Jan', 'Kowalski'
EXEC All_Subjects_Of_Lecturer 'Piotr', 'Marcinkowski'
EXEC All_Subjects_Of_Lecturer 'Grzegorz', 'Andrzejewski'
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
