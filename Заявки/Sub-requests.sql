USE Library

/* Retrieves the name and EGN of readers who renewed their cards in the same year they were created */

GO
SELECT r.name AS 'name_of_reader', r.egn AS 'egn_of_reader'
FROM Reader r
WHERE r.code_card IN (SELECT rc.code FROM Reader_card rc WHERE YEAR(rc.date_create) = FORMAT(rc.date_renewal, N'yyyy'))
ORDER BY name DESC;

/* Retrieves the names and addresses of readers whose cards were made in the month of May and the number of books taken from it is more than 1 */

GO
SELECT r.name AS 'name_of_reader', r.address AS 'address_of_reader'
FROM Reader r
WHERE r.code_card IN (SELECT rc.code FROM Reader_card rc WHERE FORMAT(rc.date_create, N'MM') = 05) 
AND r.id IN (SELECT rb.id_reader FROM Reader_book rb GROUP BY rb.id_reader HAVING COUNT(rb.id_reader) > 1);


/* Brings up the title and author of books whose sections have at least one free book */

GO
SELECT b.title AS 'title_of_book', b.author AS 'author_of_book'  
FROM Book b
WHERE b.id_section IN (SELECT s.id FROM Section s GROUP BY s.id HAVING (SELECT COUNT(b.code) FROM Book b WHERE b.available = 'Y') >= 1);

/* Lists the names of readers who have picked up a book that was written before 1937 */

GO
SELECT r.name AS 'name_of_reader'
FROM Reader r
WHERE r.id IN (SELECT rb.id_reader FROM Reader_book rb WHERE rb.code_book IN (SELECT b.code FROM Book b WHERE b.year_create < 1937));

/* Retrieves the title, author, year of creation of books that are checked out by Georgi Georgiev and their section has at least 1 checked out or unchecked book */

GO
SELECT b.title AS 'title_of_book', b.author AS 'author_of_book', b.year_create AS 'year_of_create_of_book' 
FROM Book b
WHERE b.code IN (SELECT rb.code_book FROM Reader_book rb WHERE rb.id_reader IN (SELECT r.id FROM Reader r WHERE r.name = 'Georgi Georgiev') 
AND b.id_section IN (SELECT s.id FROM Section s GROUP BY s.id HAVING (SELECT COUNT(b.code) FROM Book b WHERE b.available = 'Y') >= 1 
OR (SELECT COUNT(b.code) FROM Book b WHERE b.available = 'N') >= 1));