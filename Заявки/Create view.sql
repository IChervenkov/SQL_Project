USE Library

/* A view that includes the name of the readers who have taken a book, the titles of the respective books */

GO
CREATE VIEW readerbook_book
AS 
SELECT r.name, b.title
FROM Reader r
JOIN Reader_book rb ON r.id = rb.id_reader
JOIN Book b ON rb.code_book = b.code;

/* A view that includes the names of readers who have checked out at least one book, their PIN, their address, and the date their card was last renewed */

GO
CREATE VIEW reader_readercard_readerbook
AS
SELECT r.name, r.egn, r.address, rc.date_renewal
FROM Reader r
JOIN Reader_book rb ON rb.id_reader = r.id
JOIN reader_card rc ON rc.code = r.code_card;

/* Data view of the reader whose card creation and renewal months is an odd number */

GO
CREATE VIEW reader_readercard
AS 
SELECT *
FROM Reader r
JOIN Reader_card rc ON rc.code = r.code_card
WHERE MONTH(rc.date_create) % 2 <> 0 AND MONTH(rc.date_renewal) % 2 <> 0;

/* View data of books whose sections have at least 1 book taken and contain 'e' in their name */

GO
CREATE VIEW book_section
AS
SELECT *
FROM Book b
JOIN Section s ON s.id = b.id_section
WHERE s.name LIKE '%e%'
GROUP BY b.code,b.author,b.title,b.year_create,b.id_section,b.available,s.id,s.name
HAVING (SELECT COUNT(b.code) FROM Book b WHERE b.available = 'N') >= 1;