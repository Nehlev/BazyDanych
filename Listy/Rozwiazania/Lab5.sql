/* Lab 5_1 */
DROP TABLE [TypSali]
DROP PROC TypSali_wstawianie

CREATE TABLE [dbo].[TypSali] (
	[KodTyp] [char] (3) NOT NULL PRIMARY KEY,
	[Typ] [nvarchar] (50) COLLATE Polish_CI_AS NOT NULL
) ON [PRIMARY]
GO

CREATE PROC TypSali_wstawianie
@KodTyp char(3),
@Typ nvarchar(50)
AS INSERT TypSali(KodTyp, Typ)
VALUES (@KodTyp, @Typ)
GO

EXEC TypSali_wstawianie 'LAB', 'Laboratoryjna'
EXEC TypSali_wstawianie 'WYK', 'Wyk³adowa'
GO

SELECT * FROM [dbo].[TypSali]

/* Lab 5_2 */
DROP TABLE [dbo].[Sala]
CREATE TABLE [dbo].[Sala] (
	[IdSali] [int] NOT NULL PRIMARY KEY,
	[IdOddzialu] [tinyint] NOT NULL,
	[Pojemnosc] [int] NOT NULL,
	[KodTyp] [char] (3) NOT NULL
) ON [PRIMARY]
GO

/* Lab 5_3 */
ALTER TABLE [dbo].[Sala] ADD
	CONSTRAINT [FK_Sala_IdOddzialu] FOREIGN KEY
	(
		[IdOddzialu]
	) REFERENCES OddzialUczelni(IdOddzialu),

	CONSTRAINT [FK_Sala_KodTyp] FOREIGN KEY
	(
		[KodTyp]
	) REFERENCES TypSali(KodTyp)
GO

/* Lab 5_4 */
DROP TABLE [dbo].[SalaPrzydzial]
CREATE TABLE [dbo].[SalaPrzydzial] (
	[IdPrzydzialu] [int] NOT NULL,
	[IdSali] [int] NOT NULL
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[SalaPrzydzial] ADD
	CONSTRAINT [FK_SalaPrzydzial_IdPrzydzialu] FOREIGN KEY
	(
		[IdPrzydzialu]
	) REFERENCES ProwadzacyPrzedmiot(IdPrzydzialu)
	ON DELETE NO ACTION
	ON UPDATE CASCADE,

	CONSTRAINT [FK_SalaPrzydzial_IdSali] FOREIGN KEY
	(
		[IdSali]
	) REFERENCES Sala(IdSali)
	ON DELETE NO ACTION
	ON UPDATE CASCADE
GO

/* To drop FOREIGN KEY */
/* ALTER TABLE [dbo].[SalaPrzydzial] DROP CONSTRAINT FK_SalaPrzydzial_IdPrzydzialu */
