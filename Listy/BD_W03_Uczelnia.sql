------------------------------------------------------
------------------------------------------------------
---------- "Bazy danych" - Wykład 3
------------------------------------------------------
------------------------------------------------------
------- Copyright (c) 2005-2009 by Damian Dudek -----------
------------------------------------------------------
------------------------------------------------------
------- Copyright (c) 2013 by Sławomir Świętoniowski -----------
------------------------------------------------------
------------------------------------------------------
-- Baza danych "Wyższa uczelnia techniczna". 
-- Wersja 1.1. ---------------------------------------
------------------------------------------------------


-- Tworzenie bazy [Uczelnia].

set nocount on;
set ansi_nulls on;
set ansi_warnings on;
set xact_abort on;

USE master
IF EXISTS (SELECT name FROM master.dbo.sysdatabases WHERE name = N'Uczelnia')
	DROP DATABASE [Uczelnia]
GO

CREATE DATABASE [Uczelnia]
GO

------------------------------------------------------
-- Instrukcje SQL są przeznaczone do uruchomienia
-- w przykładowej bazie "Uczelnia_Wroclaw".

USE Uczelnia
GO

--------------------------------------------------------------------------------
-- Definicje tabel.
---

CREATE TABLE [dbo].[Grupa] (
	[NrGrupy] [char] (7) COLLATE Polish_CI_AS NOT NULL ,
	[Starosta] [int] NULL ,
	[RokRozpoczecia] [smallint] NOT NULL ,
	[IdGrupy] [smallint] NOT NULL ,
	[IdOddzialu] [tinyint] NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[OddzialUczelni] (
	[IdOddzialu] [tinyint] NOT NULL ,
	[OddzialMacierzysty] [bit] NOT NULL ,
	[Nazwa] [char] (128) COLLATE Polish_CI_AS NOT NULL ,
	[Miasto] [char] (32) COLLATE Polish_CI_AS NOT NULL ,
	[Adres] [char] (128) COLLATE Polish_CI_AS NOT NULL ,
	[KodPocztowy] [char] (6) COLLATE Polish_CI_AS NOT NULL ,
	[Telefon] [char] (20) COLLATE Polish_CI_AS NOT NULL ,
	[Faks] [char] (20) COLLATE Polish_CI_AS NOT NULL ,
	[Email] [char] (50) COLLATE Polish_CI_AS NULL ,
	[WWW] [char] (60) COLLATE Polish_CI_AS NULL ,
	[Opis] [char] (256) COLLATE Polish_CI_AS NULL ,
	[KluczeMin] [int] NULL ,
	[KluczeMax] [int] NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[Oplata] (
	[IdOplaty] [int] NOT NULL ,
	[NrIndeksu] [int] NOT NULL ,
	[Semestr] [char] (10) COLLATE Polish_CI_AS NOT NULL ,
	[RokPoczatek] [smallint] NOT NULL ,
	[RokKoniec] [smallint] NOT NULL ,
	[Kwota] [smallmoney] NOT NULL ,
	[DataWplaty] [datetime] NOT NULL ,
	[Uwagi] [char] (256) COLLATE Polish_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[Pracownik] (
	[IdPracownika] [int] NOT NULL ,
	[Nazwisko] [char] (40) COLLATE Polish_CI_AS NOT NULL ,
	[Imie] [char] (30) COLLATE Polish_CI_AS NOT NULL ,
	[NIP] [char] (13) COLLATE Polish_CI_AS NOT NULL ,
	[PESEL] [char] (11) COLLATE Polish_CI_AS NOT NULL ,
	[Adres] [char] (128) COLLATE Polish_CI_AS NOT NULL ,
	[Miejscowosc] [char] (30) COLLATE Polish_CI_AS NOT NULL ,
	[KodPocztowy] [char] (6) COLLATE Polish_CI_AS NOT NULL ,
	[TelefonStac] [char] (20) COLLATE Polish_CI_AS NULL ,
	[TelefonKom] [char] (20) COLLATE Polish_CI_AS NULL ,
	[Email] [char] (50) COLLATE Polish_CI_AS NULL ,
	[Tytul] [char] (20) COLLATE Polish_CI_AS NOT NULL ,
	[Stanowisko] [char] (20) COLLATE Polish_CI_AS NOT NULL ,
	[DataZatrudnienia] [datetime] NULL ,
	[OkresZatrudnienia] [smallint] NULL ,
	[TypZatrudnienia] [char] (15) COLLATE Polish_CI_AS NULL ,
	[Pensja] [smallmoney] NULL ,
	[IdOddzialu] [tinyint] NOT NULL 
) ON [PRIMARY]
GO


CREATE TABLE [dbo].[ProwadzacyPrzedmiot] (
	[KodPrzedmiotu] [char] (7) COLLATE Polish_CI_AS NOT NULL ,
	[IdPracownika] [int] NOT NULL ,
	[IdGrupy] [smallint] NOT NULL ,
	[RokPoczatek] [smallint] NOT NULL ,
	[RokKoniec] [smallint] NOT NULL ,
	[Semestr] [tinyint] NOT NULL,
	[IdPrzydzialu] [int] NOT NULL ,
	[IdOddzialu] [tinyint] NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[Przedmiot] (
	[KodPrzedmiotu] [char] (7) COLLATE Polish_CI_AS NOT NULL ,
	[Nazwa] [char] (128) COLLATE Polish_CI_AS NOT NULL ,
	[Semestr] [char] (10) NOT NULL ,
	[ECTS] [tinyint] NOT NULL ,
	[FormaZajec] [char] (10) COLLATE Polish_CI_AS NOT NULL ,
	[Opiekun] [int] NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[Student] (
	[NrIndeksu] [int] NOT NULL ,
	[Nazwisko] [char] (40) COLLATE Polish_CI_AS NOT NULL ,
	[Imie] [char] (30) COLLATE Polish_CI_AS NOT NULL ,
	[PESEL] [char] (11) COLLATE Polish_CI_AS NOT NULL ,
	[NIP] [char] (13) COLLATE Polish_CI_AS NULL ,
	[Adres] [char] (128) COLLATE Polish_CI_AS NOT NULL ,
	[Miejscowosc] [char] (40) COLLATE Polish_CI_AS NOT NULL ,
	[KodPocztowy] [char] (6) COLLATE Polish_CI_AS NOT NULL ,
	[Telefon] [char] (20) COLLATE Polish_CI_AS NULL ,
	[Email] [char] (50) COLLATE Polish_CI_AS NULL ,
	[DataZapisania] [datetime] NOT NULL ,
	[DataWypisania] [datetime] NOT NULL ,
	[IdGrupy] [smallint] NULL ,
	[PoprzedniOddzial] [tinyint] NOT NULL ,
	[IdOddzialu] [tinyint] NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[Zaliczenie] (
	[IdZapisu] [int] NOT NULL ,
	[DataZaliczenia] [datetime] NOT NULL ,
	[Ocena] [decimal](18, 1) NOT NULL ,
	[Uwagi] [char] (256) COLLATE Polish_CI_AS NULL ,
	[TypZaliczenia] [char] (32) COLLATE Polish_CI_AS NOT NULL ,
	[IdZaliczenia] [int] IDENTITY (1, 1) NOT FOR REPLICATION  NOT NULL ,
	[Termin] [tinyint] NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[Zapisy] (
	[IdZapisu] [int] NOT NULL ,
	[IdPrzydzialu] [int] NOT NULL ,
	[NrIndeksu] [int] NOT NULL
) ON [PRIMARY]
GO

--------------------------------------------------------------------------------
-- Definicje kluczy PK.
---

ALTER TABLE [dbo].[Grupa] WITH NOCHECK ADD 
	CONSTRAINT [PK_Grupa] PRIMARY KEY  CLUSTERED 
	(
		[IdGrupy]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[OddzialUczelni] WITH NOCHECK ADD 
	CONSTRAINT [PK_OddzialUczelni] PRIMARY KEY  CLUSTERED 
	(
		[IdOddzialu]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[Oplata] WITH NOCHECK ADD 
	CONSTRAINT [PK_Oplata] PRIMARY KEY  CLUSTERED 
	(
		[IdOplaty]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[Pracownik] WITH NOCHECK ADD 
	CONSTRAINT [PK_Pracownik] PRIMARY KEY  CLUSTERED 
	(
		[IdPracownika]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[ProwadzacyPrzedmiot] WITH NOCHECK ADD 
	CONSTRAINT [PK_ProwadzacyPrzedmiot] PRIMARY KEY  CLUSTERED 
	(
		[IdPrzydzialu]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[Przedmiot] WITH NOCHECK ADD 
	CONSTRAINT [PK_Przedmiot] PRIMARY KEY  CLUSTERED 
	(
		[KodPrzedmiotu]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[Student] WITH NOCHECK ADD 
	CONSTRAINT [PK_Student] PRIMARY KEY  CLUSTERED 
	(
		[NrIndeksu]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[Zaliczenie] WITH NOCHECK ADD 
	CONSTRAINT [PK_Zaliczenie] PRIMARY KEY  CLUSTERED 
	(
		[IdZaliczenia]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[Zapisy] WITH NOCHECK ADD 
	CONSTRAINT [PK_Zapisy] PRIMARY KEY  CLUSTERED 
	(
		[IdZapisu]
	)  ON [PRIMARY] 
GO

--------------------------------------------------------------------------------
-- Definicje kluczy FK i innych ograniczeń.
---

ALTER TABLE [dbo].[Student] ADD 
	CONSTRAINT [DF_Student_NrIndeksu] DEFAULT (1) FOR [NrIndeksu]
	-- Sprawdzenie zakresu kluczy jest wykonywane alternatywnie przez procedurę przechowywaną i wyzwalacz.
	--,CONSTRAINT [CK_Student_NrIndeksu] CHECK ([NrIndeksu] >= 1 and [NrIndeksu] <= 1000000)
GO

ALTER TABLE [dbo].[Zaliczenie] ADD 
	CONSTRAINT [CK_Zaliczenie] CHECK ([IdZaliczenia] >= 1 and [IdZaliczenia] <= 1000000)
GO

ALTER TABLE [dbo].[Grupa] ADD 
	CONSTRAINT [FK_Grupa_OddzialUczelni] FOREIGN KEY 
	(
		[IdOddzialu]
	) REFERENCES [dbo].[OddzialUczelni] (
		[IdOddzialu]
	),
	CONSTRAINT [FK_Grupa_Student] FOREIGN KEY 
	(
		[Starosta]
	) REFERENCES [dbo].[Student] (
		[NrIndeksu]
	)
GO

ALTER TABLE [dbo].[Oplata] ADD 
	CONSTRAINT [FK_Oplata_Student] FOREIGN KEY 
	(
		[NrIndeksu]
	) REFERENCES [dbo].[Student] (
		[NrIndeksu]
	)
GO

ALTER TABLE [dbo].[Pracownik] ADD 
	CONSTRAINT [FK_Pracownik_OddzialUczelni] FOREIGN KEY 
	(
		[IdOddzialu]
	) REFERENCES [dbo].[OddzialUczelni] (
		[IdOddzialu]
	)
GO

ALTER TABLE [dbo].[ProwadzacyPrzedmiot] ADD 
	CONSTRAINT [FK_ProwadzacyPrzedmiot_Grupa] FOREIGN KEY 
	(
		[IdGrupy]
	) REFERENCES [dbo].[Grupa] (
		[IdGrupy]
	),
	CONSTRAINT [FK_ProwadzacyPrzedmiot_OddzialUczelni] FOREIGN KEY 
	(
		[IdOddzialu]
	) REFERENCES [dbo].[OddzialUczelni] (
		[IdOddzialu]
	),
	CONSTRAINT [FK_ProwadzacyPrzedmiot_Pracownik] FOREIGN KEY 
	(
		[IdPracownika]
	) REFERENCES [dbo].[Pracownik] (
		[IdPracownika]
	),
	CONSTRAINT [FK_ProwadzacyPrzedmiot_Przedmiot] FOREIGN KEY 
	(
		[KodPrzedmiotu]
	) REFERENCES [dbo].[Przedmiot] (
		[KodPrzedmiotu]
	)
GO

ALTER TABLE [dbo].[Przedmiot] ADD 
	CONSTRAINT [FK_Przedmiot_Pracownik] FOREIGN KEY 
	(
		[Opiekun]
	) REFERENCES [dbo].[Pracownik] (
		[IdPracownika]
	)
GO

ALTER TABLE [dbo].[Student] ADD 
	CONSTRAINT [FK_Student_Grupa] FOREIGN KEY 
	(
		[IdGrupy]
	) REFERENCES [dbo].[Grupa] (
		[IdGrupy]
	),
	CONSTRAINT [FK_Student_OddzialUczelni] FOREIGN KEY 
	(
		[IdOddzialu]
	) REFERENCES [dbo].[OddzialUczelni] (
		[IdOddzialu]
	)
GO

ALTER TABLE [dbo].[Zaliczenie] ADD
	CONSTRAINT [FK_Zaliczenie_Zapisy] FOREIGN KEY 
	(
		[IdZapisu]
	) REFERENCES [dbo].[Zapisy] (
		[IdZapisu]
	) ON DELETE CASCADE
GO

ALTER TABLE [dbo].[Zapisy] ADD 
	CONSTRAINT [FK_Zapisy_ProwadzacyPrzedmiot] FOREIGN KEY 
	(
		[IdPrzydzialu]
	) REFERENCES [dbo].[ProwadzacyPrzedmiot] (
		[IdPrzydzialu]
	),
	CONSTRAINT [FK_Zapisy_Student] FOREIGN KEY 
	(
		[NrIndeksu]
	) REFERENCES [dbo].[Student] (
		[NrIndeksu]
	) ON DELETE CASCADE
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

--------------------------------------------------------------------------------
-- Definicje procedur przechowywanych.
---

------------------------------------------------------
--- Tabela "Grupa" -----------------------------------
------------------------------------------------------
CREATE PROC Grupa_wstawianie
@NrGrupy char(7),
@Starosta char(10),
@RokRozpoczecia smallint,
@IdGrupy smallint,
@IdOddzialu tinyint
AS
INSERT Grupa (NrGrupy, Starosta, RokRozpoczecia, IdGrupy, IdOddzialu)
VALUES (@NrGrupy, @Starosta, @RokRozpoczecia, @IdGrupy, @IdOddzialu)
GO

------------------------------------------------------
--- Tabela "OddzialUczelni" --------------------------
------------------------------------------------------
CREATE PROC OddzialUczelni_wstawianie
@IdOddzialu tinyint,
@OddzialMacierzysty bit,
@Nazwa char(128),
@Miasto char(32),
@Adres char(128),
@KodPocztowy char(6),
@Telefon char(15),
@Faks char(15),
@Email char(50),
@WWW char(60),
@Opis char(256),
@KluczeMin int,
@KluczeMax int
AS
INSERT OddzialUczelni
(IdOddzialu, OddzialMacierzysty, Nazwa, Miasto, Adres, KodPocztowy, Telefon, Faks, Email, 
WWW, Opis, KluczeMin, KluczeMax)
VALUES
(@IdOddzialu, @OddzialMacierzysty, @Nazwa, @Miasto, @Adres, @KodPocztowy, @Telefon, @Faks, @Email, 
@WWW, @Opis, @KluczeMin, @KluczeMax)
GO

------------------------------------------------------
--- Tabela "Pracownik" -------------------------------
------------------------------------------------------
CREATE PROC Pracownik_wstawianie 
@IdPracownika int,
@Nazwisko char(40),
@Imie char(30),
@NIP char(13),
@PESEL char(11),
@Adres char(128),
@Miejscowosc char(30),
@KodPocztowy char(6),
@TelefonStac char(15),
@TelefonKom char(15),
@Email char(50),
@Tytul char(20),
@Stanowisko char(20),
@IdOddzialu tinyint
AS
INSERT Pracownik (IdPracownika, Nazwisko, Imie, NIP, PESEL, Adres, Miejscowosc,
KodPocztowy, TelefonStac, TelefonKom, Email, Tytul, Stanowisko, IdOddzialu)
VALUES 
(@IdPracownika, @Nazwisko, @Imie, @NIP, @PESEL, @Adres, @Miejscowosc,
@KodPocztowy, @TelefonStac, @TelefonKom, @Email, @Tytul, @Stanowisko, @IdOddzialu)
GO

------------------------------------------------------
--- Tabela "ProwadzacyPrzedmiot" ---------------------
------------------------------------------------------
CREATE PROC ProwadzacyPrzedmiot_wstawianie
@IdPrzydzialu int, -- klucz glówny
@KodPrzedmiotu char(7),
@IdPracownika int,
@IdGrupy smallint,
@RokPoczatek smallint,
@RokKoniec smallint,
@Semestr tinyint, -- "1" - zimowy; "2" - letni
@IdOddzialu tinyint
AS
INSERT ProwadzacyPrzedmiot
(IdPrzydzialu, KodPrzedmiotu, IdPracownika, IdGrupy, RokPoczatek, RokKoniec, Semestr, IdOddzialu)
VALUES
(@IdPrzydzialu, @KodPrzedmiotu, @IdPracownika, @IdGrupy, @RokPoczatek, @RokKoniec, @Semestr, @IdOddzialu)
GO

------------------------------------------------------
--- Tabela "Przedmiot" -------------------------------
------------------------------------------------------
CREATE PROC Przedmiot_wstawianie
@KodPrzedmiotu char(7),
@Nazwa char(128),
@Semestr char(10), -- semestr, na którym jest prowadzony przedmiot
@ECTS tinyint,
@FormaZajec char(10),
@Opiekun int
AS
INSERT Przedmiot (KodPrzedmiotu, Nazwa, Semestr, ECTS, FormaZajec, Opiekun)
VALUES
(@KodPrzedmiotu, @Nazwa, @Semestr, @ECTS, @FormaZajec, @Opiekun)
GO

------------------------------------------------------
--- Tabela "Student" ---------------------------------
------------------------------------------------------
------------------------------------------------------
-- Procedura wstawiająca studenta z możliwością automatycznego
-- obliczenia nowego numeru indeksu. Uwzględniona jest sytuacja
-- dodania całkowicie nowego studenta oraz dodania do lokalnej bazy
-- studenta przenoszonego z innego oddziału.
------------------------------------------------------
CREATE PROC Student_wstawianie
@NrIndeksu int,
@Nazwisko char(40),
@Imie char(30),
@PESEL char(11),
@NIP char(13),
@Adres char(128),
@Miejscowosc char(40),
@KodPocztowy char(6),
@Telefon char(15),
@Email char(50),
@DataZapisania datetime,
@DataWypisania datetime,
@IdGrupy smallint,
@PoprzedniOddzial tinyint,
@IdOddzialu tinyint
AS
BEGIN

IF EXISTS -- Sprawdzenie, czy ten sam student nie jest zapisywany drugi raz.
	(SELECT *
	 FROM Student
	 WHERE PESEL = @PESEL)
BEGIN
	RAISERROR('W bazie jest już student o tym numerze PESEL!', 16, 1)
	RETURN
END

DECLARE @IndeksMin int
DECLARE @IndeksMax int
-- Pobranie dopuszczalnego zakresu numeru indeksu.
SELECT @IndeksMin = KluczeMin, @IndeksMax = KluczeMax
FROM OddzialUczelni
WHERE OddzialMacierzysty = 1

SET ANSI_NULLS ON
IF (@NrIndeksu IS NOT NULL) -- Jeśli numer indeksu został podany jako parametr.
BEGIN
	-- Sprawdzenie, czy numer mieści się w zakresie ustalonym dla tego oddziału. 
	IF (@NrIndeksu NOT BETWEEN @IndeksMin AND @IndeksMax)
	BEGIN
		RAISERROR('Podany numer indeksu jest bledny!', 16, 1)
		RETURN
	END
	ELSE
		INSERT Student (NrIndeksu, Nazwisko, Imie, PESEL, NIP, Adres, Miejscowosc, 
		KodPocztowy, Telefon, Email, DataZapisania, DataWypisania, IdGrupy, 
		PoprzedniOddzial, IdOddzialu)
		VALUES
		(@NrIndeksu, @Nazwisko, @Imie, @PESEL, @NIP, @Adres, @Miejscowosc,
		@KodPocztowy, @Telefon, @Email, @DataZapisania, @DataWypisania, @IdGrupy, 
		@PoprzedniOddzial, @IdOddzialu)
END

ELSE IF (@NrIndeksu IS NULL)
BEGIN -- Automatyczne obliczenie nowego numeru indeksu.
	DECLARE @NowyNrIndeksu int
	DECLARE @MaxNrIndeksu int
	DECLARE @LiczbaStudentow int
	-- Sprawdzenie liczby studentów.
	SELECT @LiczbaStudentow = COUNT(*)
	FROM Student
	-- Obliczenie nowego numeru indeksu: maksymalny istniejacy z oddzialu 
	-- macierzystego, zwiekszony o jeden.
	IF (@LiczbaStudentow > 0)
	BEGIN
		-- Sprawdzenie największego numeru indeksu, który nie pochodzi z innego odziału.
		SELECT @MaxNrIndeksu = MAX(NrIndeksu)
		FROM Student
		WHERE @PoprzedniOddzial = IdOddzialu -- Warunek ten gwarantuje, że student nie był przenoszony.

		SET @NowyNrIndeksu = @MaxNrIndeksu + 1
	END
	ELSE IF (@LiczbaStudentow = 0) -- Jeśli w bazie nie ma studentów, nadajemy początkowy numer indeksu.
		SET @NowyNrIndeksu = @IndeksMin

	-- Jesli osiagnieto maksymalna liczbe studentów.
	IF (@NowyNrIndeksu > @IndeksMax)
	BEGIN
		RAISERROR('Osiagnieto maksymalna liczbe studentów. Nie mozna dodac nowego.', 16,1)
		RETURN
	END
	ELSE
		INSERT Student (NrIndeksu, Nazwisko, Imie, PESEL, NIP, Adres, Miejscowosc, 
		KodPocztowy, Telefon, Email, DataZapisania, DataWypisania, IdGrupy, 
		PoprzedniOddzial, IdOddzialu)
		VALUES
		(@NowyNrIndeksu, @Nazwisko, @Imie, @PESEL, @NIP, @Adres, @Miejscowosc,
		@KodPocztowy, @Telefon, @Email, @DataZapisania, @DataWypisania, @IdGrupy, 
		@PoprzedniOddzial, @IdOddzialu)
END
RETURN
END
GO

------------------------------------------------------
--- Tabela "Zaliczenie" ------------------------------
------------------------------------------------------
CREATE PROC Zaliczenie_wstawianie
@IdZapisu int,
@DataZaliczenia datetime,
@Ocena decimal(18,1),
@Uwagi char(256),
@TypZaliczenia char(32),
@Termin tinyint
AS
INSERT Zaliczenie
(IdZapisu, DataZaliczenia, Ocena, Uwagi, TypZaliczenia, Termin)
VALUES
(@IdZapisu, @DataZaliczenia, @Ocena, @Uwagi, @TypZaliczenia, @Termin)
GO

------------------------------------------------------
--- Tabela "Zapisy" ----------------------------------
------------------------------------------------------
CREATE PROC Zapisy_wstawianie
@IdZapisu int,
@IdPrzydzialu int,
@NrIndeksu char(10)
AS
INSERT Zapisy (IdZapisu, IdPrzydzialu, NrIndeksu)
VALUES
(@IdZapisu, @IdPrzydzialu, @NrIndeksu)
GO

------------------------------------------------------
------------------------------------------------------
-- Wyzwalacze. ---------------------------------------
------------------------------------------------------
------------------------------------------------------

-- Wyzwalacz sprawdzający poprawność zakresu numeru
-- indeksu przy wstawianiu nowego studenta.
--
CREATE TRIGGER Trig_Student_Ins
ON Student
FOR INSERT
AS
BEGIN
DECLARE @OddzialStudenta tinyint
DECLARE @OddzialPoprzedni tinyint
DECLARE @IndeksMin int
DECLARE @IndeksMax int
DECLARE @NrIndeksu int

-- Sprawdzenie, czy student jest zapisywany na nowo,
-- czy jest przenoszony z innego oddziału.
--
SELECT @NrIndeksu = NrIndeksu, @OddzialStudenta = IdOddzialu, 
@OddzialPoprzedni = PoprzedniOddzial
FROM Inserted

-- Jeśli student jest dodawany jako nowy.
IF (@OddzialPoprzedni = @OddzialStudenta) -- Jeśli obecny i poprzedni oddział są takie same, student nie jest przenoszony.
BEGIN
	-- Sprawdzenie dopuszczalnego zakresu numeru indeksu.
	SELECT @IndeksMin = KluczeMin, @IndeksMax = KluczeMax
	FROM OddzialUczelni
	WHERE IdOddzialu = @OddzialStudenta

	IF ((@NrIndeksu < @IndeksMin) OR (@NrIndeksu > @IndeksMax))
	BEGIN
		RAISERROR('Nr indeksu studenta nie mieści się w dopuszczalnym zakresie.',16,1)
		ROLLBACK TRAN
		RETURN
	END
	ELSE IF (@NrIndeksu BETWEEN @IndeksMin AND @IndeksMax)
		RETURN
END

-- Jeśli student jest przenoszony z innego oddziału.
ELSE IF (@OddzialPoprzedni <> @OddzialStudenta)
BEGIN
	-- Sprawdzenie dopuszczalnego zakresu numeru indeksu.
	SELECT @IndeksMin = KluczeMin, @IndeksMax = KluczeMax
	FROM OddzialUczelni
	WHERE IdOddzialu = @OddzialPoprzedni

	IF ((@NrIndeksu < @IndeksMin) OR (@NrIndeksu > @IndeksMax))
	BEGIN
		RAISERROR('Nr indeksu studenta nie mieści się w dopuszczalnym zakresie.',16,1)
		ROLLBACK TRAN
		RETURN
	END
	ELSE IF (@NrIndeksu BETWEEN @IndeksMin AND @IndeksMax)
		RETURN
END
END

GO

------------------------------------------------------
------------------------------------------------------
--- Skrypt dodający dane do bazy ---------------------
------------------------------------------------------
------------------------------------------------------

------------------------------------------------------
--- Tabela "OddzialUczelni" --------------------------
------------------------------------------------------

EXEC OddzialUczelni_wstawianie 1, 1, 'WSIZ "Copernicus"', 'Wroclaw','ul. Inowroclawska 59','53-648','+48-71-7950-393','+48-71-7950-399','dziekanat@wsiz.wroc.pl','www.wsiz.wroc.pl','Główna siedziba uczelni.', 1, 1000000
EXEC OddzialUczelni_wstawianie 2, 0, 'WSIZ "Copernicus" Filia w Legnicy', 'Legnica','ul. Chrobrego 12','','+48-76-7300-234','+48-76-7300-238','dziekanat@wsiz.legnica.pl','www.wsiz.legnical.pl','Filia w Legnicy.', 1000001, 2000000
EXEC OddzialUczelni_wstawianie 3, 0, 'WSIZ "Copernicus" Filia w Opolu', 'Opole','ul. Armii Krajowej 15','','+48-77-7530-101','+48-77-7530-110','dziekanat@wsiz.opole.pl','www.wsiz.opole.pl','Filia w Opolu.', 2000001, 3000000
GO


------------------------------------------------------
--- Tabela "Pracownik" -------------------------------
------------------------------------------------------

EXEC Pracownik_wstawianie 1, 'Nowakowski', 'Andrzej','612-412-54-64','57121943212','ul. Świerkowa 6','Wrocław','50-987','+48-71-323-54-65','+48-501-23-23-32','anowakowski@wsiz.wroc.pl','Dr inż.','wykładowca',1
EXEC Pracownik_wstawianie 2, 'Kowalski', 'Jan','663-654-76-87','72013142337','ul. Strzelecka 15/8','Wrocław','51-230','+48-71-389-98-20','+48-605-01-89-80','jkowalski@wsiz.wroc.pl','Mgr inż.','asystent',1
EXEC Pracownik_wstawianie 3, 'Janicki', 'Bogdan','432-543-654-66','49042343259','ul. Pastelowa 58/98','Wrocław','52-321','+48-71-328-29-98','+48-602-70-03-50','bjanicki@wsiz.wroc.pl','Prof. dr hab. inż.','rektor',1
EXEC Pracownik_wstawianie 4, 'Marcinkowski', 'Piotr','789-098-23-45','76110309878','ul. Lakiernicza 98A/3','Wrocław','53-789','+48-71-380-01-20','+48-503-90-22-19','pmarcinkowski@wsiz.wroc.pl','Dr inż.','wykładowca',1
EXEC Pracownik_wstawianie 5, 'Andrzejewski', 'Grzegorz','980-432-23-12','52082898152','ul. Nobla 8/3','Wrocław','50-128','+48-71-780-01-98','+48-603-81-39-28','gandrzejewski@wsiz.wroc.pl','Mgr inż.','asystent',1
GO

EXEC Pracownik_wstawianie 6, 'Piotrowski', 'Bartlomiej','780-678-66-11','65102189131','ul. Nadrzeczna 16/1','Legnica','','+48-76-720-29-89','+48-604-93-28-15','bpiotrowski@wsiz.legnica.pl','Dr hab. inż.','wykładowca',2
EXEC Pracownik_wstawianie 7, 'Bogdanska', 'Ewa','430-543-55-22','79031487924','ul. Wrocławska 23/37','Legnica','','+48-76-725-13-95','+48-501-98-28-39','mbogdanska@wsiz.legnica.pl','Mgr','asystent',2
EXEC Pracownik_wstawianie 8, 'Grzegorzewski', 'Pawel','250-532-99-90','76061898778','ul. Karkonoska 58','Wrocław','53-853','+48-71-383-28-91','+48-605-30-40-50','pgrzegorzewski@wsiz.legnica.pl','Mgr inż.','asystent',2
EXEC Pracownik_wstawianie 9, 'Styczen', 'Tomasz','610-220-96-52','68071678156','ul. Janowska 43/63','Legnica','','+48-76-782-98-01','+48-600-32-39-89','tstyczen@wsiz.legnica.pl','Dr inż.','wykładowca',2
EXEC Pracownik_wstawianie 10, 'Romanowski', 'Janusz','616-420-90-19','74090209835','ul. Góralska 43','Legnica','','+48-76-791-20-75','+48-505-02-39-80','jromanowski@wsiz.legnica.pl','Mgr inż.','asystent',2
GO

------------------------------------------------------
--- Tabela "Grupa" -----------------------------------
------------------------------------------------------

EXEC Grupa_wstawianie '5DA inf', NULL, 2002, 1, 1
EXEC Grupa_wstawianie '5DB inf', NULL, 2002, 2, 1
EXEC Grupa_wstawianie '5DC inf', NULL, 2002, 3, 1
EXEC Grupa_wstawianie '5DD inf', NULL, 2002, 4, 1
GO

------------------------------------------------------
--- Tabela "Przedmiot" -------------------------------
------------------------------------------------------

EXEC Przedmiot_wstawianie 'INF407W', 'Bazy danych', 4, 4, '20000', 1
EXEC Przedmiot_wstawianie 'INF407P', 'Bazy danych', 4, 0, '00001', 1
EXEC Przedmiot_wstawianie 'INF407L', 'Bazy danych', 4, 3, '00010', 1
EXEC Przedmiot_wstawianie 'INF507W', 'Sieciowe bazy danych', 5, 4, '10000', 1
EXEC Przedmiot_wstawianie 'INF507L', 'Sieciowe bazy danych', 5, 3, '00002', 1
EXEC Przedmiot_wstawianie 'INF517W', 'Grafika komputerowa', 5, 5, '20000', 2
EXEC Przedmiot_wstawianie 'INF517L', 'Grafika komputerowa', 5, 3,'00020', 2
GO

------------------------------------------------------
--- Tabela "Student" ---------------------------------
------------------------------------------------------
SET DATEFORMAT YMD
GO

EXEC Student_wstawianie 1, 'Andrzejewski', 'Marcin','8312157639','659-907-10-41','ul. Miodowa 138/16','Wrocław','53-763','+48-605-78-89-32','marcin.andrzejewski@poczta.onet.pl','2002-09-23','1900-01-01',1,1,1
EXEC Student_wstawianie 2, 'Bobrowski', 'Michał','84012279173','632-388-13-03','ul. Okrężna 28','Wrocław','50-389','+48-501-23-50-38','mbobrowski@interia.pl','2002-07-28','1900-01-01',1,1,1
EXEC Student_wstawianie 3, 'Ciechanowski', 'Artur','83100832153','651-124-72-28','ul.Kościuszki 15','Trzebnica','51-839','Brak.','artur_ciechanowski@gazeta.pl','2002-09-05','1900-01-01',2,1,1
EXEC Student_wstawianie 4, 'Drozdowski', 'Tomasz','83070168971','691-459-10-35','ul.Mieszka I 83/2','Wrocław','52-983','+48-604-70-35-81','tomasz_drozd@pf.pl','2002-08-17','1900-01-01',2,1,1
EXEC Student_wstawianie 5, 'Borowski', 'Daniel','83042121457','681-298-49-57','ul. Latawcowa 34/12','Wrocław','50-023','Brak.','daniel.borek@interia.pl','2002-08-09','1900-01-01',2,1,1
GO

------------------------------------------------------
--- Tabela "ProwadzacyPrzedmiot" ---------------------
------------------------------------------------------

EXEC ProwadzacyPrzedmiot_wstawianie 1, 'INF507W', 3, 1, 2004, 2005, 1, 1
EXEC ProwadzacyPrzedmiot_wstawianie 2, 'INF507L', 2, 1, 2004, 2005, 1, 1
EXEC ProwadzacyPrzedmiot_wstawianie 3, 'INF517W', 4, 1, 2004, 2005, 1, 1
EXEC ProwadzacyPrzedmiot_wstawianie 4, 'INF517L', 5, 1, 2004, 2005, 1, 1
GO

------------------------------------------------------
--- Tabela "Zapisy" ----------------------------------
------------------------------------------------------

EXEC Zapisy_wstawianie  1, 1, 1
EXEC Zapisy_wstawianie  2, 1, 2
EXEC Zapisy_wstawianie  3, 1, 3
EXEC Zapisy_wstawianie  4, 2, 1
EXEC Zapisy_wstawianie  5, 2, 2
EXEC Zapisy_wstawianie  6, 2, 3
EXEC Zapisy_wstawianie  7, 3, 1
EXEC Zapisy_wstawianie  8, 3, 2
EXEC Zapisy_wstawianie  9, 3, 3
EXEC Zapisy_wstawianie 10, 4, 1
EXEC Zapisy_wstawianie 11, 4, 2
EXEC Zapisy_wstawianie 12, 4, 3
GO

------------------------------------------------------
--- Tabela "Zaliczenie" ------------------------------
------------------------------------------------------

EXEC Zaliczenie_wstawianie 1, '2005-01-26', 2.0, 'Brak.','egzamin', 1
EXEC Zaliczenie_wstawianie 1, '2005-02-08', 2.0, 'Brak.','egzamin', 2
EXEC Zaliczenie_wstawianie 1, '2005-02-12', 3.0, 'Brak.','egzamin', 3
EXEC Zaliczenie_wstawianie 2, '2005-01-26', 5.0, 'Brak.','egzamin', 1
EXEC Zaliczenie_wstawianie 3, '2005-01-26', 4.0, 'Brak.','egzamin', 1
EXEC Zaliczenie_wstawianie 4, '2005-01-23', 2.0, 'Brak.','zaliczenie', 1
EXEC Zaliczenie_wstawianie 4, '2005-02-15', 3.5, 'Brak.','zaliczenie', 2
EXEC Zaliczenie_wstawianie 5, '2005-01-23', 5.5, 'Brak.','zaliczenie', 1
EXEC Zaliczenie_wstawianie 6, '2005-01-23', 4.5, 'Brak.','zaliczenie', 1
GO

------------------------------------------------------
----------- KONIEC -----------------------------------
------------------------------------------------------