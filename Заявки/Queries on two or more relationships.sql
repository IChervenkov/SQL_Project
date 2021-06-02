USE Library

/* Извежда заглавието на книгите които Emilia Yancheva е взела */

GO
SELECT b.title AS 'Title of book' 
FROM book b
JOIN Reader_book rb ON b.code = rb.code_book
WHERE name_reader = 'Emilia Yancheva';

/* Извежда имената на читателите които са взели книги само от секция Fantasy */

GO
SELECT rb.name_reader AS 'Name of reader' 
FROM Reader_book rb
JOIN book b ON rb.code_book = b.code
WHERE b.name_section = 'Fantasy';

/* Извежда имената на читателите, техният код на читателската им карта
и дата на създаване на профила им */

GO
SELECT r.name AS 'Name of reader', r.codecard AS 'Code of reader card', FORMAT(rc.date_renewal,N'dd.MM.yyyy') AS 'Date of create profil'
FROM reader r
JOIN reader_card rc ON r.codecard = rc.code
WHERE rc.date_renewal > '2015-06-06';

/* Извежда имената на читателите които са взели книги с автори Robert Kiyosaki и Napoleon Hill */

GO
SELECT rb.name_reader AS 'Name of reader'
FROM Reader_book rb
JOIN book b ON rb.code_book = b.code 
WHERE b.author = 'Robert Kiyosaki'
UNION ALL
SELECT rb.name_reader 
FROM Reader_book rb
JOIN book b ON rb.code_book = b.code 
WHERE b.author = 'Napoleon Hill';

/* Извежда имента на читателите, телефоните им и кода на читателската им карта
само на тези които са взели книга чиито автор и заглавие започват с еднакви букви */

GO
SELECT r.name AS 'Name of reader', r.phone AS 'Phone of reader', r.codecard AS 'Code of reader card'
FROM reader r 
JOIN Reader_book rb ON r.name = rb.name_reader
JOIN book b ON rb.code_book = b.code
WHERE LEFT(b.author,1) = LEFT(b.title,1);