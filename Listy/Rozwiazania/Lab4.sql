/* Lab 4_1 */
SELECT GRUPA.NrGrupy, COUNT(STUDENT.Nazwisko) AS LiczbaStudentow
FROM Uczelnia.dbo.Grupa as GRUPA
LEFT JOIN Uczelnia.dbo.Student as STUDENT
ON GRUPA.IdGrupy=STUDENT.IdGrupy GROUP BY GRUPA.NrGrupy

/* Lab 4_2 */
SELECT * FROM Przedmiot
SELECT PRZEDMIOT.Nazwa, SUM(PRZEDMIOT.ECTS) as SumaPktEcts 
FROM Uczelnia.dbo.Przedmiot as PRZEDMIOT GROUP BY PRZEDMIOT.Nazwa

/* LAB 4_3 */
SELECT ZALICZENIE.DataZaliczenia, AVG(ZALICZENIE.Ocena) as SredniaOcen
FROM Uczelnia.dbo.Zaliczenie as ZALICZENIE GROUP BY ZALICZENIE.DataZaliczenia
