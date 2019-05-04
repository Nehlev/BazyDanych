/*************** Lab 7_8_1 ****************/
/* 
DROP VIEW V_Pracownicy_I_Oddzial
GO 
*/
CREATE VIEW V_Pracownicy_I_Oddzial AS SELECT

PRACOWNIK.Tytul, PRACOWNIK.Nazwisko, PRACOWNIK.Imie, PRACOWNIK.Stanowisko, PRACOWNIK.TelefonKom, PRACOWNIK.Email,
ODDZIAL.Nazwa as MiejscePracy_Nazwa, ODDZIAL.Miasto as MiejscePracy_Adres, ODDZIAL.Telefon as MiejscePracy_Telefon, ODDZIAL.Email as MiejscePracy_Email

FROM Pracownik as PRACOWNIK
INNER JOIN OddzialUczelni ODDZIAL ON PRACOWNIK.IdOddzialu=ODDZIAL.IdOddzialu
GO

SELECT * FROM V_Pracownicy_I_Oddzial

/**************** Lab 7_8_2 ****************/
/*
DROP VIEW V_Przedmiot_I_Prowadzacy
GO
*/
CREATE VIEW V_Przedmiot_I_Prowadzacy AS SELECT

PRZEDMIOT.Nazwa, PRZEDMIOT.KodPrzedmiotu, PRZEDMIOT.Semestr, PRZEDMIOT.ECTS, PRZEDMIOT.FormaZajec,
PRACOWNIK.Imie as Pracownik_Imie, PRACOWNIK.Nazwisko as Pracownik_Nazwisko

FROM Przedmiot as PRZEDMIOT
LEFT JOIN ProwadzacyPrzedmiot as PROWADZACY ON PRZEDMIOT.KodPrzedmiotu=PROWADZACY.KodPrzedmiotu
JOIN Pracownik as PRACOWNIK ON PROWADZACY.IdPracownika=PRACOWNIK.IdPracownika
GO

SELECT * FROM V_Przedmiot_I_Prowadzacy

/**************** Lab 7_8_3 ****************/
