/* Lab 5_1 */
DROP TABLE [TypSali]
DROP PROC TypSali_wstawianie

CREATE TABLE [TypSali] (
	[KodTyp] [char] (3) COLLATE Polish_CI_AS NOT NULL ,
	[Typ] [nvarchar] (50) COLLATE Polish_CI_AS NOT NULL ,
) ON [PRIMARY]
GO

ALTER TABLE [TypSali] WITH NOCHECK ADD
	CONSTRAINT [PK_TypSali] PRIMARY KEY CLUSTERED
	(
		[KodTyp]
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

/* Lab 5_2 */
DROP TABLE [Sala]
CREATE TABLE [Sala] (
	[IdSali] [int] NOT NULL,
	[IdOddzialu] [tinyint] NOT NULL,
	[Pojemnosc] [int] NOT NULL,
	[KodTyp] [char] (3) NOT NULL
) ON [PRIMARY]
GO

ALTER TABLE [Sala] WITH NOCHECK ADD
	CONSTRAINT [PK_Sala] PRIMARY KEY CLUSTERED
	(
		[IdSali]
	) ON [PRIMARY]
GO
