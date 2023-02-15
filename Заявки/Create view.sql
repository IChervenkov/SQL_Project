USE Library

/* Изглед който включва името на читателите които са взели книга, заглавията на съответните книги */

GO
CREATE VIEW readerbook_book
AS 
SELECT r.name, b.title
FROM Reader r
JOIN Reader_book rb ON r.id = rb.id_reader
JOIN Book b ON rb.code_book = b.code;

/* Изглед който включва имената на читателите, които са взели поне една книга, ЕГН-то им, адреса им и датата на последното подновяване на картата им */

GO
CREATE VIEW reader_readercard_readerbook
AS
SELECT r.name, r.egn, r.address, rc.date_renewal
FROM Reader r
JOIN Reader_book rb ON rb.id_reader = r.id
JOIN reader_card rc ON rc.code = r.code_card;

/* Изглед за данните на читателя, чиито месеци на създаване и подновяване на картите е нечетно число */

GO
CREATE VIEW reader_readercard
AS 
SELECT *
FROM Reader r
JOIN Reader_card rc ON rc.code = r.code_card
WHERE MONTH(rc.date_create) % 2 <> 0 AND MONTH(rc.date_renewal) % 2 <> 0;

/* Изглед за данните на книгите чиито секций имат поне 1 взета книга и в името си съдържат 'е' */

GO
CREATE VIEW book_section
AS
SELECT *
FROM Book b
JOIN Section s ON s.id = b.id_section
WHERE s.name LIKE '%e%'
GROUP BY b.code,b.author,b.title,b.year_create,b.id_section,b.available,s.id,s.name
HAVING (SELECT COUNT(b.code) FROM Book b WHERE b.available = 'N') >= 1;