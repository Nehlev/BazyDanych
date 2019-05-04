/* Lab 7_8_1 */

CREATE VIEW V_Pracownicy_I_Oddzial AS SELECT

PRACOWNIK.Tytul, PRACOWNIK.Nazwisko, PRACOWNIK.Imie, PRACOWNIK.Stanowisko, PRACOWNIK.TelefonKom, PRACOWNIK.Email,
ODDZIAL.Nazwa as MiejscePracy_Nazwa, ODDZIAL.Miasto as MiejscePracy_Adres, ODDZIAL.Telefon as MiejscePracy_Telefon, ODDZIAL.Email as MiejscePracy_Email

FROM [dbo].[Pracownik] as PRACOWNIK
INNER JOIN OddzialUczelni ODDZIAL ON PRACOWNIK.IdOddzialu=ODDZIAL.IdOddzialu
GO

SELECT * FROM V_Pracownicy_I_Oddzial

/* Aby skasowac widok 
DROP VIEW V_Pracownicy_I_Oddzial */

/* Lab 7_8_2 */

