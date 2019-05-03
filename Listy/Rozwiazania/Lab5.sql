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

ALTER TABLE [dbo].[Sala] ADD
	CONSTRAINT [FK_Sala_IdOddzialu] FOREIGN KEY
	(
		[IdOddzialu]
	) REFERENCES OddzialUczelni(IdOddzialu)
GO

ALTER TABLE [dbo].[Sala] ADD
	CONSTRAINT [FK_Sala_KodTyp] FOREIGN KEY
	(
		[KodTyp]
	) REFERENCES TypSali(KodTyp)
GO
