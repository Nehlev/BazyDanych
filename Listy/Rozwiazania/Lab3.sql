SELECT * FROM Uczelnia.dbo.Pracownik
SELECT * FROM Uczelnia.dbo.OddzialUczelni

/* Lab3_2 */
SELECT Nazwisko, Nazwa
FROM Uczelnia.dbo.Pracownik as LHS INNER JOIN Uczelnia.dbo.OddzialUczelni as RHS 
ON LHS.IdOddzialu = RHS.IdOddzialu

/* Lab3_3 */
SELECT DISTINCT Nazwa FROM Uczelnia.dbo.OddzialUczelni LHS LEFT JOIN Uczelnia.dbo.Pracownik RHS
ON LHS.IdOddzialu=RHS.IdOddzialu WHERE RHS.Nazwisko IS NULL

/* Lab3_4 */
SELECT Dupa.Nazwisko, Dupa.IdGrupy
FROM Uczelnia.dbo.Student as Dupa 
RIGHT JOIN grupa Cycki on Dupa.IdGrupy = Cycki.IdGrupy
