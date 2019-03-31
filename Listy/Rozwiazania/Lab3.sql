SELECT * FROM Uczelnia.dbo.Pracownik
SELECT * FROM Uczelnia.dbo.OddzialUczelni

/* Lab3_2 */
SELECT Nazwisko, Nazwa
FROM Uczelnia.dbo.Pracownik as LHS INNER JOIN Uczelnia.dbo.OddzialUczelni as RHS 
ON LHS.IdOddzialu = RHS.IdOddzialu

/* Lab3_3 */
SELECT Nazwa
FROM Uczelnia.dbo.OddzialUczelni WHERE NOT EXISTS 
(SELECT * FROM Uczelnia.dbo.Pracownik WHERE Uczelnia.dbo.OddzialUczelni.IdOddzialu = Uczelnia.dbo.Pracownik.IdOddzialu)

SELECT * FROM Uczelnia.dbo.Student
SELECT * FROM Uczelnia.dbo.Grupa

SELECT Nazwisko, IdGrupy FROM Uczelnia.dbo.Student

SELECT Nazwisko, Student.IdGrupy
FROM Uczelnia.dbo.Student as LHS FULL OUTER JOIN Uczelnia.dbo.Grupa as RHS
ON LHS.IdGrupy = RHS.IdGrupy
