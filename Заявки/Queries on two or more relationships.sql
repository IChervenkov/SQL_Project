USE Library

/* Извежда заглавието на книгите които Emilia Yancheva е взела */

GO
SELECT b.title AS 'title_of_book' 
FROM Book b
JOIN Reader_book rb ON b.code = rb.code_book
JOIN Reader r ON rb.id_reader = r.id
WHERE r.name = 'Emilia Yancheva';

/* Извежда имената на читателите които са взели книги само от секция Fantasy */

GO
SELECT r.name AS 'name_of_reader' 
FROM Reader r
JOIN Reader_book rb ON r.id = rb.id_reader
JOIN Book b ON rb.code_book = b.code
JOIN Section s ON b.id_section = s.id
WHERE s.name = 'Fantasy';

/* Извежда имената на читателите и дата на създаване на читателската им картата който са подновени преди днешната дата */

GO
SELECT r.name AS 'name_of_reader', FORMAT(rc.date_create,N'dd.MM.yyyy') AS 'Date_of_create_profile'
FROM Reader r
JOIN Reader_card rc ON r.code_card = rc.code
WHERE rc.date_renewal < GETDATE();

/* Извежда имената на читателите които са взели книги с автори Robert Kiyosaki и Napoleon Hill */

GO
SELECT r.name AS 'name_of_reader'
FROM Reader r
JOIN Reader_book rb ON rb.id_reader = r.id
JOIN Book b ON rb.code_book = b.code
WHERE b.author = 'Robert Kiyosaki' OR b.author = 'Napoleon Hill';
