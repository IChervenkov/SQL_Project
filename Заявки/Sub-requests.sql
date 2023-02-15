USE Library

/* Изкарва името и егенето на читателите на които са подновили картите си в същата година през която са създадени */

GO
SELECT r.name AS 'name_of_reader', r.egn AS 'egn_of_reader'
FROM Reader r
WHERE r.code_card IN (SELECT rc.code FROM Reader_card rc WHERE YEAR(rc.date_create) = FORMAT(rc.date_renewal, N'yyyy'))
ORDER BY name DESC;

/* Изкарва имената и адресите на читателите чийто карти са направени през месец Май и броя на взетите от него книги да е повече от 1 */

GO
SELECT r.name AS 'name_of_reader', r.address AS 'address_of_reader'
FROM Reader r
WHERE r.code_card IN (SELECT rc.code FROM Reader_card rc WHERE FORMAT(rc.date_create, N'MM') = 05) 
AND r.id IN (SELECT rb.id_reader FROM Reader_book rb GROUP BY rb.id_reader HAVING COUNT(rb.id_reader) > 1);


/* Изкарва заглавието и автора на книгите чиито секции имат поне една свободна книга*/

GO
SELECT b.title AS 'title_of_book', b.author AS 'author_of_book'  
FROM Book b
WHERE b.id_section IN (SELECT s.id FROM Section s GROUP BY s.id HAVING (SELECT COUNT(b.code) FROM Book b WHERE b.available = 'Y') >= 1);

/* Извежда имената на читателите които са взели книга която е написана преди 1937 */

GO
SELECT r.name AS 'name_of_reader'
FROM Reader r
WHERE r.id IN (SELECT rb.id_reader FROM Reader_book rb WHERE rb.code_book IN (SELECT b.code FROM Book b WHERE b.year_create < 1937));

/* Изважда заглавието, автора, годината на създаване на книгите, които са взети от Georgi Georgiev и секцията им има поне 1 взета или невзета книга */

GO
SELECT b.title AS 'title_of_book', b.author AS 'author_of_book', b.year_create AS 'year_of_create_of_book' 
FROM Book b
WHERE b.code IN (SELECT rb.code_book FROM Reader_book rb WHERE rb.id_reader IN (SELECT r.id FROM Reader r WHERE r.name = 'Georgi Georgiev') 
AND b.id_section IN (SELECT s.id FROM Section s GROUP BY s.id HAVING (SELECT COUNT(b.code) FROM Book b WHERE b.available = 'Y') >= 1 
OR (SELECT COUNT(b.code) FROM Book b WHERE b.available = 'N') >= 1));