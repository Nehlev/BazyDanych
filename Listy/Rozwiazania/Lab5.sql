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

SELECT * FROM TypSali

