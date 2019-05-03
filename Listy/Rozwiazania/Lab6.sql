/* Potrzebna jest tabela o nazwie Sala z Listy 5 */
/* Lab 6_1 */
INSERT INTO [dbo].[Sala](IdOddzialu, IdSali, Pojemnosc, KodTyp) VALUES
('1', '1', '20', 'LAB'),
('1', '2', '25', 'LAB'),
('1', '3', '60', 'WYK'),
('1', '4', '60', 'WYK'),

('2', '5', '20', 'LAB'),
('2', '6', '25', 'LAB'),
('2', '7', '60', 'WYK'),
('2', '8', '60', 'WYK'),

('3', '9', '20', 'LAB'),
('3', '10', '25', 'LAB'),
('3', '11', '60', 'WYK'),
('3', '12', '60', 'WYK')


/* Lab 6_2 */
INSERT INTO [dbo].[Grupa](IdOddzialu, IdGrupy, RokRozpoczecia, Starosta, NrGrupy) VALUES
('1', '5', '2019', NULL, '5DE inf'),
('1', '6', '2019', NULL, '5DF inf'),

('2', '7', '2019', NULL, '5DG inf'),
('2', '8', '2019', NULL, '5DH inf'),

('3', '9', '2019', NULL, '5DI inf'),
('3', '10', '2019', NULL, '5DJ inf')


/* Lab 6_3 */
SELECT * FROM Grupa
SELECT * FROM OddzialUczelni
SELECT * FROM Student

INSERT INTO [dbo].[Student]
(IdGrupy, NrIndeksu, Nazwisko, Imie, PESEL, NIP, Adres, Miejscowosc, KodPocztowy, Telefon, Email, DataZapisania, DataWypisania, PoprzedniOddzial, IdOddzialu) VALUES
('1', 6, 'Kowalski', 'Jan', '90102000000', '000-000-00-00', 'ul. Sienkiewicza 1/1', 'Wroc³aw', '53-234', '+48-000-000-000', 'jan.kowalski@wsiz.pl', CONVERT(DATETIME, '2019-05-03 00:00:00', 102), '', '', '1'),
('1', 7, 'Kowalska', 'Janina', '90102000001', '000-000-00-01', 'ul. Sienkiewicza 1/2', 'Wroc³aw', '53-234', '+48-000-000-001', 'janina.kowalska@wsiz.pl', CONVERT(DATETIME, '2019-05-03 00:00:00', 102), '', '', '1'),
('1', 8, 'Kowal', 'Jan', '90102000002', '000-000-00-02', 'ul. Sienkiewicza 1/3', 'Wroc³aw', '53-234', '+48-000-000-002', 'jan.kowal@wsiz.pl', CONVERT(DATETIME, '2019-05-03 00:00:00', 102), '', '', '1'),

('2', 9, 'Kowalski', 'Adam', '90102000003', '000-000-00-03', 'ul. Sienkiewicza 1/4', 'Wroc³aw', '53-234', '+48-000-000-003', 'adam.kowalski@wsiz.pl', CONVERT(DATETIME, '2019-05-03 00:00:00', 102), '', '', '2'),
('2', 10, 'Kowalski', 'Marek', '90102000004', '000-000-00-04', 'ul. Sienkiewicza 1/5', 'Wroc³aw', '53-234', '+48-000-000-004', 'marek.kowalski@wsiz.pl', CONVERT(DATETIME, '2019-05-03 00:00:00', 102), '', '', '2'),
('2', 11, 'Kowalski', 'Bartek', '90102000005', '000-000-00-05', 'ul. Sienkiewicza 1/6', 'Wroc³aw', '53-234', '+48-000-000-005', 'bartek.kowalski@wsiz.pl', CONVERT(DATETIME, '2019-05-03 00:00:00', 102), '', '', '2'),

('3', 12, 'Kowalski', 'Adrian', '90102000006', '000-000-00-06', 'ul. Sienkiewicza 1/6', 'Wroc³aw', '53-234', '+48-000-000-006', 'adrian.kowalski@wsiz.pl', CONVERT(DATETIME, '2019-05-03 00:00:00', 102), '', '', '3'),
('3', 13, 'Kowalski', 'Albert', '90102000007', '000-000-00-07', 'ul. Sienkiewicza 1/7', 'Wroc³aw', '53-234', '+48-000-000-007', 'albert.kowalski@wsiz.pl', CONVERT(DATETIME, '2019-05-03 00:00:00', 102), '', '', '3'),
('3', 14, 'Kowalski', 'Alan', '90102000008', '000-000-00-08', 'ul. Sienkiewicza 1/8', 'Wroc³aw', '53-234', '+48-000-000-008', 'alan.kowalski@wsiz.pl', CONVERT(DATETIME, '2019-05-03 00:00:00', 102), '', '', '3'),

('4', 15, 'Kowalski', 'Borys', '90102000009', '000-000-00-09', 'ul. Sienkiewicza 1/9', 'Wroc³aw', '53-234', '+48-000-000-009', 'borys.kowalski@wsiz.pl', CONVERT(DATETIME, '2019-05-03 00:00:00', 102), '', '', '1'),
('4', 16, 'Kowalski', 'Czarek', '90102000010', '000-000-00-10', 'ul. Sienkiewicza 1/10', 'Wroc³aw', '53-234', '+48-000-000-010', 'czarek.kowalski@wsiz.pl', CONVERT(DATETIME, '2019-05-03 00:00:00', 102), '', '', '1'),
('4', 17, 'Kowalski', 'Damian', '90102000011', '000-000-00-11', 'ul. Sienkiewicza 1/11', 'Wroc³aw', '53-234', '+48-000-000-011', 'damian.kowalski@wsiz.pl', CONVERT(DATETIME, '2019-05-03 00:00:00', 102), '', '', '1'),

('5', 18, 'Kowalski', 'Dawid', '90102000012', '000-000-00-12', 'ul. Sienkiewicza 1/12', 'Wroc³aw', '53-234', '+48-000-000-012', 'dawid.kowalski@wsiz.pl', CONVERT(DATETIME, '2019-05-03 00:00:00', 102), '', '', '2'),
('5', 19, 'Kowalski', 'Geniusz', '90102000013', '000-000-00-13', 'ul. Sienkiewicza 1/13', 'Wroc³aw', '53-234', '+48-000-000-013', 'geniusz.kowalski@wsiz.pl', CONVERT(DATETIME, '2019-05-03 00:00:00', 102), '', '', '2'),
('5', 20, 'Kowalski', 'Filip', '90102000014', '000-000-00-14', 'ul. Sienkiewicza 1/14', 'Wroc³aw', '53-234', '+48-000-000-014', 'filip.kowalski@wsiz.pl', CONVERT(DATETIME, '2019-05-03 00:00:00', 102), '', '', '2'),

('6', 21, 'Nowak', 'Jan', '90102000015', '000-000-00-15', 'ul. Sienkiewicza 1/15', 'Wroc³aw', '53-234', '+48-000-000-015', 'jan.nowak@wsiz.pl', CONVERT(DATETIME, '2019-05-03 00:00:00', 102), '', '', '3'),
('6', 22, 'Nowak', 'Janina', '90102000016', '000-000-00-16', 'ul. Sienkiewicza 1/16', 'Wroc³aw', '53-234', '+48-000-000-016', 'janina.nowak@wsiz.pl', CONVERT(DATETIME, '2019-05-03 00:00:00', 102), '', '', '3'),
('6', 23, 'Nowak', 'Tomek', '90102000017', '000-000-00-17', 'ul. Sienkiewicza 1/17', 'Wroc³aw', '53-234', '+48-000-000-017', 'marek.nowak@wsiz.pl', CONVERT(DATETIME, '2019-05-03 00:00:00', 102), '', '', '3'),

('7', 21, 'Nowak', 'Adam', '90102000018', '000-000-00-18', 'ul. Sienkiewicza 1/18', 'Wroc³aw', '53-234', '+48-000-000-018', 'adam.nowak@wsiz.pl', CONVERT(DATETIME, '2019-05-03 00:00:00', 102), '', '', '1'),
('7', 22, 'Nowak', 'Marek', '90102000019', '000-000-00-19', 'ul. Sienkiewicza 1/19', 'Wroc³aw', '53-234', '+48-000-000-019', 'marek.nowak@wsiz.pl', CONVERT(DATETIME, '2019-05-03 00:00:00', 102), '', '', '1'),
('7', 23, 'Nowak', 'Bartek', '90102000020', '000-000-00-20', 'ul. Sienkiewicza 1/20', 'Wroc³aw', '53-234', '+48-000-000-020', 'bartek.nowak@wsiz.pl', CONVERT(DATETIME, '2019-05-03 00:00:00', 102), '', '', '1'),

('8', 24, 'Nowak', 'Adrian', '90102000021', '000-000-00-21', 'ul. Sienkiewicza 1/21', 'Wroc³aw', '53-234', '+48-000-000-021', 'adrian.nowak@wsiz.pl', CONVERT(DATETIME, '2019-05-03 00:00:00', 102), '', '', '2'),
('8', 25, 'Nowak', 'Albert', '90102000022', '000-000-00-22', 'ul. Sienkiewicza 1/22', 'Wroc³aw', '53-234', '+48-000-000-022', 'albert.nowak@wsiz.pl', CONVERT(DATETIME, '2019-05-03 00:00:00', 102), '', '', '2'),
('8', 26, 'Nowak', 'Alan', '90102000023', '000-000-00-23', 'ul. Sienkiewicza 1/23', 'Wroc³aw', '53-234', '+48-000-000-023', 'alan.nowak@wsiz.pl', CONVERT(DATETIME, '2019-05-03 00:00:00', 102), '', '', '2'),

('9', 27, 'Nowak', 'Borys', '90102000024', '000-000-00-24', 'ul. Sienkiewicza 1/24', 'Wroc³aw', '53-234', '+48-000-000-024', 'borys.nowak@wsiz.pl', CONVERT(DATETIME, '2019-05-03 00:00:00', 102), '', '', '3'),
('9', 28, 'Nowak', 'Czarek', '90102000025', '000-000-00-25', 'ul. Sienkiewicza 1/25', 'Wroc³aw', '53-234', '+48-000-000-025', 'czarek.nowak@wsiz.pl', CONVERT(DATETIME, '2019-05-03 00:00:00', 102), '', '', '3'),
('9', 29, 'Nowak', 'Damian', '90102000026', '000-000-00-26', 'ul. Sienkiewicza 1/26', 'Wroc³aw', '53-234', '+48-000-000-026', 'damian.nowak@wsiz.pl', CONVERT(DATETIME, '2019-05-03 00:00:00', 102), '', '', '3'),

('10', 30, 'Nowak', 'Dawid', '90102000027', '000-000-00-27', 'ul. Sienkiewicza 1/27', 'Wroc³aw', '53-234', '+48-000-000-027', 'dawid.nowak@wsiz.pl', CONVERT(DATETIME, '2019-05-03 00:00:00', 102), '', '', '1'),
('10', 31, 'Nowak', 'Eugeniusz', '90102000028', '000-000-00-28', 'ul. Sienkiewicza 1/28', 'Wroc³aw', '53-234', '+48-000-000-028', 'eugeniusz.nowak@wsiz.pl', CONVERT(DATETIME, '2019-05-03 00:00:00', 102), '', '', '1'),
('10', 32, 'Nowak', 'Filip', '90102000029', '000-000-00-29', 'ul. Sienkiewicza 1/29', 'Wroc³aw', '53-234', '+48-000-000-029', 'filip.nowak@wsiz.pl', CONVERT(DATETIME, '2019-05-03 00:00:00', 102), '', '', '1')
