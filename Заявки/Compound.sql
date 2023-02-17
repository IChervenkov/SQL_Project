USE Library

/* Displays the name, address, and creation date on the library card of readers who checked out a book written in 1937 */

GO
CREATE INDEX idx_book_year
ON book(code,year_create);

GO
SELECT r.name AS 'name_of reader', r.address AS 'address_of_reader', FORMAT(rc.date_create,'dd-MM-yyyy') AS 'date_of_create_reader_card'
FROM Reader r
JOIN Reader_card rc ON rc.code = r.code_card
JOIN Reader_book rb ON r.id = rb.id_reader
JOIN Book b ON b.code = rb.code_book
WHERE b.year_create = 1937;

/* Displays all sections and titles of all books to them even if the sections have no book */

GO
SELECT s.name AS 'name_of_section', b.title AS 'title_of_book'
FROM Section s
FULL OUTER JOIN Book b ON s.id = b.id_section;

/* Displays the reader card codes of those readers who have taken a book from the History section 
and the card was last renewed after 2010. */

GO
CREATE INDEX idx_book_aval_ns
ON book(code,available,id_section);

GO
CREATE INDEX idx_readercard_dr
ON reader_card(code,date_renewal);

GO
SELECT rc.code AS 'code_of_reader_card'
FROM Reader_card rc
JOIN Reader r ON rc.code = r.code_card
JOIN Reader_book rb ON rb.id_reader = r.id
JOIN Book b ON b.code = rb.code_book
JOIN Section s ON b.id_section = s.id
WHERE b.available = 'N' AND s.name = 'History' AND YEAR(rc.date_renewal) >= 2010;

/* Displays the title of books and the names of readers who have no more than 2 books taken that were written by Frederic Delavier or Daniel Defoe */

GO
CREATE INDEX idx_reader_cgb
ON Reader(name,count_get_book);

GO
CREATE INDEX idx_book_aut
ON book(code,author);

GO
SELECT r.name AS 'name_of_reader', b.title AS 'book_title'
FROM Reader r
JOIN Reader_book rb ON rb.id_reader = r.id
JOIN book b ON b.code = rb.code_book
WHERE r.count_get_book <= 2 AND b.author = 'Frederic Delavier' OR b.author = 'Daniel Defoe';

/* Lists the names of sections that have at least one book taken and the books taken from that section were written after 1865,
also displays the title of those books, the names of the readers who took them and their SSN and the month of creation of their reading card written out in words. */

GO
CREATE INDEX idx_section_cd
ON section(name,count_get_book);

GO
SELECT s.name AS 'name_of_section', b.title AS 'title_of_book', r.name AS 'name_of_reder', r.egn AS 'reader_EGN', FORMAT(rc.date_create,'MMMM') AS 'month_of_create_of_profile'
FROM section s
JOIN Book b ON b.id_section = s.id
JOIN Reader_book rb ON rb.code_book = b.code
JOIN Reader r ON r.id = rb.id_reader
JOIN Reader_card rc ON rc.code = r.code_card
WHERE s.count_get_book >= 1 AND b.year_create > 1865 AND b.available = 'N';