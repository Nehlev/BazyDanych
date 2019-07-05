USE master
IF EXISTS (SELECT name FROM master.dbo.sysdatabases WHERE name = N'Telco_Wroclaw')
	DROP DATABASE [Telco_Wroclaw]
GO

CREATE DATABASE [Telco_Wroclaw]
GO

EXEC Telco_Wroclaw.dbo.sp_changedbowner @loginame = N'sa', @map = false
GO

USE Telco_Wroclaw
GO

--------------------------------------------------------------------------------
-- Definicje tabel.
---

CREATE TABLE [dbo].[Operator] (
	[Name] [char] (64) COLLATE Polish_CI_AS NOT NULL,
	[Money] [int] NOT NULL
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[Hardware] (
	[HwType] [char] (64) COLLATE Polish_CI_AS NOT NULL ,
	[ProductCodeAndSerialNumber] [char] (64) COLLATE Polish_CI_AS NOT NULL ,
	[SoftwareVersion_Active] [int] NOT NULL,
	[SoftwareVersion_Passive] [int] NOT NULL,
	[Money] [int] NOT NULL,
	[Owner] [char] (64) NOT NULL,
	[Location] [char] (64) COLLATE Polish_CI_AS NOT NULL,
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[HardwareType] (
	[Name] [char] (64) COLLATE Polish_CI_AS NOT NULL
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[Software] (
	[SwType] [char] (64) COLLATE Polish_CI_AS NOT NULL,
	[Version] [int] NOT NULL,
	[Money] [int] NOT NULL
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[TelcoUser] (
	[Pesel] [nchar] (11) NOT NULL,
	[OperatorName] [char] (64) COLLATE Polish_CI_AS NOT NULL
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[TelcoWorker] (
	[Pesel] [nchar] (11) NOT NULL,
	[Job] [nchar] (64) COLLATE Polish_CI_AS NOT NULL
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[ContactInformation] (
	[Pesel] [nchar] (11) NOT NULL,
	[Name] [nchar] (64) COLLATE Polish_CI_AS NOT NULL,
	[Surname] [nchar] (64) COLLATE Polish_CI_AS NOT NULL,
	[Address_City] [nchar] (64) COLLATE Polish_CI_AS NOT NULL,
	[Address_Street] [nchar] (64) COLLATE Polish_CI_AS NOT NULL,
	[Email] [nchar] (64) COLLATE Polish_CI_AS NOT NULL
) ON [PRIMARY]
GO

--------------------------------------------------------------------------------
-- Definicje kluczy glownych
---
ALTER TABLE [dbo].[Operator] WITH NOCHECK ADD 
	CONSTRAINT [PK_Operator_Name] PRIMARY KEY  CLUSTERED 
	(
		[Name]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[Hardware] WITH NOCHECK ADD 
	CONSTRAINT [PK_Hardware_UniqueId] PRIMARY KEY  CLUSTERED 
	(
		[ProductCodeAndSerialNumber]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[Software] WITH NOCHECK ADD 
	CONSTRAINT [PK_Software_Version] PRIMARY KEY  CLUSTERED 
	(
		[Version]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[TelcoUser] WITH NOCHECK ADD 
	CONSTRAINT [PK_TelcoUser_Pesel] PRIMARY KEY  CLUSTERED 
	(
		[Pesel]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[TelcoWorker] WITH NOCHECK ADD 
	CONSTRAINT [PK_TelcoWorker_Pesel] PRIMARY KEY  CLUSTERED 
	(
		[Pesel]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[ContactInformation] WITH NOCHECK ADD 
	CONSTRAINT [PK_TelcoWorker_ContactInformation] PRIMARY KEY  CLUSTERED 
	(
		[Pesel]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[HardwareType] WITH NOCHECK ADD 
	CONSTRAINT [PK_HardwareType_Name] PRIMARY KEY  CLUSTERED 
	(
		[Name]
	)  ON [PRIMARY] 
GO

-------------------------
--------------------------------------------------------------------------------
-- Definicje kluczy FK i innych ograniczeñ.
---

ALTER TABLE [dbo].[Hardware] ADD 
	CONSTRAINT [FK_Software_Passive] FOREIGN KEY 
	(
		[SoftwareVersion_Passive]
	) REFERENCES [dbo].[Software](
		[Version]
	),
	CONSTRAINT [FK_Software_Active] FOREIGN KEY 
	(
		[SoftwareVersion_Active]
	) REFERENCES [dbo].[Software] (
		[Version]
	),
	CONSTRAINT [FK_Owner] FOREIGN KEY 
	(
		[Owner]
	) REFERENCES [dbo].[Operator] (
		[Name]
	),
	CONSTRAINT [FK_HardwareType] FOREIGN KEY
	(
		[HwType]
	) REFERENCES [dbo].[HardwareType] (
		[Name]
	)
GO

ALTER TABLE [dbo].[TelcoUser] ADD
	CONSTRAINT [FK_TelcoUser_OperatorName] FOREIGN KEY
	(
		[OperatorName]
	) REFERENCES [dbo].[Operator] (
		[Name]
	),
	CONSTRAINT [FK_TelcoUser_Pesel] FOREIGN KEY
	(
		[Pesel]
	) REFERENCES [dbo].[ContactInformation] (
		[Pesel]
	)
GO

ALTER TABLE [dbo].[TelcoWorker] ADD
	CONSTRAINT [FK_TelcoWorker_Pesel] FOREIGN KEY
	(
		[Pesel]
	) REFERENCES [dbo].[ContactInformation] (
		[Pesel]
	)
GO


--------------------------------------------------------------------------------
-- Parametry
---

SET ANSI_NULLS ON 
GO
SET QUOTED_IDENTIFIER ON 
GO

--------------------------------------------------------------------------------
-- Definicje procedur przechowywanych.
---

CREATE PROC Operator_Insert
@Name char(64),
@Money int
AS
INSERT Operator(Name, Money)
VALUES (@Name, @Money)
GO

CREATE PROC Operator_Update
@Name char(64),
@Money int
AS
UPDATE Operator
SET
	Money=@Money
where Name=@Name
GO

CREATE PROC HardwareType_Insert
@Name char(64)
AS
INSERT HardwareType(Name)
VALUES (@Name)
GO

CREATE PROC Hardware_Insert
@HwType char(64),
@ProductCodeAndSerialNumber char(64),
@SoftwareVersion_Active int,
@SoftwareVersion_Passive int,
@Money int,
@Owner char(64),
@Location char(64)
AS
INSERT Hardware(HwType, ProductCodeAndSerialNumber, SoftwareVersion_Active, SoftwareVersion_Passive, Money, Owner, Location)
VALUES (@HwType, @ProductCodeAndSerialNumber, @SoftwareVersion_Active, @SoftwareVersion_Passive, @Money, @Owner, @Location)
GO

CREATE PROC Hardware_Update
@HwType char(64),
@ProductCodeAndSerialNumber char(64),
@SoftwareVersion_Active int,
@SoftwareVersion_Passive int,
@Money int,
@Owner char(64),
@Location char(64)
AS
UPDATE Hardware
SET
	HwType=@HwType,
	SoftwareVersion_Active=@SoftwareVersion_Active,
	SoftwareVersion_Passive=@SoftwareVersion_Passive,
	Money=@Money,
	Owner=@Owner,
	Location=@Location
where ProductCodeAndSerialNumber=@ProductCodeAndSerialNumber
GO

CREATE PROC Software_Insert
@SwType char(64),
@Version int,
@Money int
AS
INSERT Software(SwType, Version, Money)
VALUES (@SwType, @Version, @Money)
GO

CREATE PROC ContactInformation_Insert
@Pesel nchar(11),
@Name nchar(64),
@Surname nchar(64),
@Address_City nchar(64),
@Address_Street nchar(64),
@Email nchar(64)
AS
INSERT ContactInformation(Pesel, Name, Surname, Address_City, Address_Street, Email)
VALUES (@Pesel, @Name, @Surname, @Address_City, @Address_Street, @Email)
GO

CREATE PROC TelcoUser_Insert
@Pesel nchar(11),
@OperatorName nchar(64)
AS
INSERT TelcoUser(Pesel, OperatorName)
VALUES (@Pesel, @OperatorName)
GO

CREATE PROC TelcoWorker_Insert
@Pesel nchar(11),
@Job nchar(64)
AS
INSERT TelcoWorker(Pesel, Job)
VALUES (@Pesel, @Job)
GO

--------------------------------------------------------------------------------
-- Definicja wysokoziomowych procedur
---

CREATE PROCEDURE CreateSiteFor(@OperatorName char(64))
AS
BEGIN TRANSACTION Transaction_CreateDatabaseState
	EXEC Operator_Insert @OperatorName, 500

	EXEC HardwareType_Insert 'MHA'

	EXEC Software_Insert 'MHA', 1, 50
	EXEC Software_Insert 'MHA', 2, 50

	EXEC Hardware_Insert 'MHA', 'MHA_1_A', 1, 1, 100, @OperatorName, 'Wroclaw Centrum'
	EXEC Hardware_Insert 'MHA', 'MHA_2_B', 1, 1, 100, @OperatorName, 'Wroclaw Centrum'

	IF @@ERROR <> 0
		BEGIN
			ROLLBACK
			RAISERROR ('An error occured during initializng state of new site', 10, 10)
			RETURN
		END
COMMIT
GO

CREATE PROCEDURE BuyNewVersionOfSoftwareAndSendToHardware(@OperatorName char(64))
AS
BEGIN TRANSACTION Transaction_CreateDatabaseState
	EXEC Operator_Update @OperatorName, 400
	EXEC Hardware_Update 'MHA', 'MHA_1_A', 1, 2, 100, @OperatorName, 'Wroclaw Centrum'
	EXEC Hardware_Update 'MHA', 'MHA_2_B', 1, 2, 100, @OperatorName, 'Wroclaw Centrum'
	IF @@ERROR <> 0
		BEGIN
			ROLLBACK
			RAISERROR ('An error occured during initializng state of new site', 10, 10)
			RETURN
		END
COMMIT
GO

CREATE PROCEDURE SoftwareUpgrade(@OperatorName char(64), @LastError int)
AS
BEGIN TRANSACTION Transaction_CreateDatabaseState
	EXEC Hardware_Update 'MHA', 'MHA_1_A', 2, 1, 100, @OperatorName, 'Wroclaw Centrum'
	EXEC Hardware_Update 'MHA', 'MHA_2_B', 2, 1, 100, @OperatorName, 'Wroclaw Centrum'
	IF @LastError <> 0
		BEGIN
			ROLLBACK
			RAISERROR ('An error occured during initializng state of new site', 10, 10)
			RETURN
		END
COMMIT
GO

CREATE PROCEDURE AddTelcoUsers
AS
BEGIN TRANSACTION Transaction_AddTelcoUsers
	EXEC ContactInformation_Insert '90010100000', 'Jan', 'Kowalski', 'Wroclaw', 'Sienkiewicza 1', 'jan.kowalski@interia.pl'
	EXEC TelcoUser_Insert '90010100000', 'Korytko'

	EXEC ContactInformation_Insert '90010100001', 'Adam', 'Nowak', 'Wroclaw', 'Sienkiewicza 2', 'adam.nowak@gmail.pl'
	EXEC TelcoUser_Insert '90010100001', 'Korytko'

	EXEC ContactInformation_Insert '90010100002', 'Tomek', 'Wolski', 'Warszawa', 'Mickiewicza 3', 'tomek.wolski@interia.pl'
	EXEC TelcoUser_Insert '90010100002', 'Korytko'

	EXEC ContactInformation_Insert '90010100003', 'Marek', 'Adamski', 'Krakow', 'Mickiewicza 4', 'marek.adamski@interia.pl'
	EXEC TelcoUser_Insert '90010100003', 'Korytko'

	IF @@ERROR <> 0
		BEGIN
			ROLLBACK
			RAISERROR ('An error occured during initializng users of the site', 10, 10)
			RETURN
		END
COMMIT
GO

CREATE PROCEDURE AddTelcoWorkers
AS
BEGIN TRANSACTION Transaction_AddTelcoWorkers
	EXEC ContactInformation_Insert '90010100004', 'Jan', 'Kowalski', 'Wroclaw', 'Sienkiewicza 1', 'jan.kowalski@interia.pl'
	EXEC TelcoWorker_Insert '90010100004', 'Programmer'

	EXEC ContactInformation_Insert '90010100005', 'Adam', 'Nowak', 'Wroclaw', 'Sienkiewicza 2', 'adam.nowak@gmail.pl'
	EXEC TelcoWorker_Insert '90010100005', 'Programmer'

	EXEC ContactInformation_Insert '90010100006', 'Tomek', 'Wolski', 'Warszawa', 'Mickiewicza 3', 'tomek.wolski@interia.pl'
	EXEC TelcoWorker_Insert '90010100006', 'Tester'

	IF @@ERROR <> 0
		BEGIN
			ROLLBACK
			RAISERROR ('An error occured during initializng users of the site', 10, 10)
			RETURN
		END
COMMIT
GO

-------------------------------------------------------------------------------
-- Definicja stanu startowego bazy danych END
---
EXEC CreateSiteFor 'Korytko'
EXEC AddTelcoUsers
EXEC AddTelcoWorkers

SELECT * FROM [Telco_Wroclaw].dbo.Hardware
SELECT * FROM [Telco_Wroclaw].dbo.Software
SELECT * FROM [Telco_Wroclaw].dbo.Operator
SELECT * FROM [Telco_Wroclaw].dbo.TelcoUser
SELECT * FROM [Telco_Wroclaw].dbo.TelcoWorker
SELECT * FROM [Telco_Wroclaw].dbo.ContactInformation
GO

---------------------------------------------------------------------------------
---- Widok dla wyswietlania informacji o pracowniku
-----
CREATE VIEW [dbo].[TelcoUserWithContactInfo_View] WITH SCHEMABINDING as SELECT

CONTACT.Pesel, CONTACT.Name, CONTACT.Surname, CONTACT.Address_City, CONTACT.Address_Street, CONTACT.Email, TELCO_USER.OperatorName
FROM [dbo].[ContactInformation] as CONTACT
INNER JOIN [dbo].[TelcoUser] TELCO_USER ON CONTACT.Pesel=TELCO_USER.Pesel
GO

CREATE UNIQUE CLUSTERED INDEX TelcoUserWithContactInfo_View_Index ON [dbo].[TelcoUserWithContactInfo_View]
(
	[Pesel] ASC
)
GO

SELECT * FROM TelcoUserWithContactInfo_View
GO

---------------------------------------------------------------------------------
---- Widok dla wyswietlania informacji o uzytkowniku
-----
CREATE VIEW [dbo].[TelcoWorkerWithContactInfo_View] WITH SCHEMABINDING as SELECT

CONTACT.Pesel, CONTACT.Name, CONTACT.Surname, CONTACT.Address_City, CONTACT.Address_Street, CONTACT.Email, TELCO_WORKER.Job
FROM [dbo].[ContactInformation] as CONTACT
INNER JOIN [dbo].[TelcoWorker] TELCO_WORKER ON CONTACT.Pesel=TELCO_WORKER.Pesel
GO

CREATE UNIQUE CLUSTERED INDEX TelcoWorkerWithContactInfo_View_Index ON [dbo].[TelcoWorkerWithContactInfo_View]
(
	[Pesel] ASC
)
GO

SELECT * FROM TelcoWorkerWithContactInfo_View
GO

-------------------------------------------------------------------------------
-- Kup nowe oprogramowanie i zaktualizuj partycje pasywne
---
EXEC BuyNewVersionOfSoftwareAndSendToHardware 'Korytko'

SELECT * FROM [Telco_Wroclaw].dbo.Hardware
SELECT * FROM [Telco_Wroclaw].dbo.Software
SELECT * FROM [Telco_Wroclaw].dbo.Operator

-------------------------------------------------------------------------------
-- Symuluj niepowodzenie aktualizacji oprogramowania ( zamiana aktywnej partycji z pasywna )
---
EXEC SoftwareUpgrade 'Korytko', 10

SELECT * FROM [Telco_Wroclaw].dbo.Hardware
SELECT * FROM [Telco_Wroclaw].dbo.Software
SELECT * FROM [Telco_Wroclaw].dbo.Operator

-------------------------------------------------------------------------------
-- Symuluj powodzenie aktualizacji oprogramowania ( zamiana aktywnej partycji z pasywna )
---
EXEC SoftwareUpgrade 'Korytko', 1

SELECT * FROM [Telco_Wroclaw].dbo.Hardware
SELECT * FROM [Telco_Wroclaw].dbo.Software
SELECT * FROM [Telco_Wroclaw].dbo.Operator

CREATE UNIQUE INDEX TelcoWroclaw_Hardware_UniqueIndex_PC_and_SN
ON [Telco_Wroclaw].dbo.Hardware (ProductCodeAndSerialNumber);
