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
