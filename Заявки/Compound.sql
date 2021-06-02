USE Library

/* Извежда името, адреса и датата на създаване на читателската карта на читателите които са взели книга написана през 1937 */

GO
CREATE INDEX idx_book_year
ON book(code,year_create);

GO
SELECT r.name AS 'Name of reader', r.adres AS 'Address of reader', FORMAT(rc.date_create,'dd-MM-yyyy') AS 'Date of create reader_card'
FROM reader r
JOIN reader_card rc ON rc.code = r.codecard
JOIN reader_book rb ON r.name = rb.name_reader
JOIN book b ON b.code = rb.code_book
WHERE b.year_create = 1937;

/* Извежда всички секций и заглавиата на всички книги към тях дори и секцийте да нямат книга */

GO
SELECT s.name AS 'Name of section', b.title AS 'Title of book'
FROM section s
FULL OUTER JOIN book b ON s.name = b.name_section;

/* Извежда кодовете на читателските карти на тези читатели които са взели книга от секция History 
и картата е последно подновена след 2010 год. */

GO
CREATE INDEX idx_book_aval_ns
ON book(code,available,name_section);

GO
CREATE INDEX idx_readercard_dr
ON reader_card(code,date_renewal);

GO
SELECT rc.code AS 'Code of reader card'
FROM reader_card rc
JOIN reader r ON rc.code = r.codecard
JOIN reader_book rb ON rb.name_reader = r.name
JOIN book b ON b.code = rb.code_book
WHERE b.available = 'N' AND b.name_section = 'History' AND YEAR(rc.date_renewal) >= 2010;

/* Извежда заглавието на книгите и имената на читателите, които имат не повече от 2 взети книги, които са написани от Frederic Delavier или Daniel Defoe */

GO
CREATE INDEX idx_reader_cgb
ON reader(name,count_get_book);

GO
CREATE INDEX idx_book_aut
ON book(code,author);

GO
SELECT r.name AS 'Name of reader', b.title AS 'Book title'
FROM reader r
JOIN reader_book rb ON rb.name_reader = r.name
JOIN book b ON b.code = rb.code_book
WHERE r.count_get_book <= 2 AND b.author = 'Frederic Delavier' OR b.author = 'Daniel Defoe';

/* Извежда имената на секцийте които имат поне една взета книга и взетите книги от тази секция да са написани след 1865,
извежда и заглавието на тези книги, имената на читателите, които са ги взели и тяхното ЕГН и месеца на създаване на читателската им карта исписан с думи. */

GO
CREATE INDEX idx_section_cd
ON section(name,count_get_book);

GO
SELECT s.name AS 'Name of section', b.title AS 'Title of book', rb.name_reader AS 'Name of reder', r.egn AS 'Reader EGN', FORMAT(rc.date_create,'MMMM') AS 'Month of create of profile'
FROM section s
JOIN book b ON b.name_section = s.name
JOIN reader_book rb ON rb.code_book = b.code
JOIN reader r ON r.name = rb.name_reader
JOIN reader_card rc ON rc.code = r.codecard
WHERE s.count_get_book >= 1 AND b.year_create > 1865 AND b.available = 'N';