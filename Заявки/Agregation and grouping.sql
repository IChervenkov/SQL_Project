USE Library

/* Извежда информация за заглавието, автора, годината на написване на книгите чиито секций имат поне 1 взета книга и в името си съдържат 'е', 
също така извежда само тези книги които се намират в секция която се среща повече от един път */

GO
SELECT bs.title AS 'Title of book', bs.author AS 'Author of book', bs.year_create AS 'Year of writing'
FROM book_section bs
JOIN
(SELECT name_section FROM book_section
GROUP BY name_section
HAVING COUNT(name_section)>1) bs1 ON bs1.name_section = bs.name_section;

/* Извежда имената на читателитe които са взели повече от една книга и заглавията им */

GO
SELECT rb.name_reader AS 'Name of reader', rb.title AS 'Title of book'
FROM readerbook_book rb
JOIN(
SELECT name_reader FROM readerbook_book
GROUP BY name_reader
HAVING COUNT(name_reader) > 1) rb1 ON rb1.name_reader = rb.name_reader;

/*  Извежда данните на читателя, чиито месеци на създаване и подновяване на картите е нечетно число с еднакви адреси 
и телефоните им завършват на нечетна цифра */

GO
SELECT rr.name AS 'Name of reader', rr.egn AS 'EGN', rr.adres AS 'Adres', rr.phone AS 'Phone',
rr.count_get_book AS 'Number of get book', rr.date AS 'Date create of account'
FROM reader_readercard rr
JOIN
(SELECT adres
FROM reader_readercard
GROUP BY adres
HAVING COUNT(1) > 1) rr1 ON rr.adres = rr1.adres 
WHERE RIGHT(rr.phone,1) %2 <> 0;

/* Извежда имената на читателите, които са взели поне една книга, ЕГН-то им, адреса им и датата на последното подновяване на картата им 
и информация за книгата която са взели, 
като извежда само тези които дължината на автора е по-голяма от последните 2 цифри на най-малката година на създаване на профила на читателя,
също така само информацията за книгите и читателите от секция с повече от 1 взета книга */

GO
SELECT DISTINCT rrr.name_reader AS 'Name of reader', rrr.egn AS 'Reader EGN', rrr.adres AS 'Reader address', rrr.date_renewal AS 'Date of create profile', 
b.title AS 'Title of book', b.author AS 'Author of book', b.year_create 'Year of create book', b.name_section AS 'Book section'
FROM reader_readercard_readerbook rrr
JOIN reader_book rb ON rb.name_reader = rrr.name_reader
JOIN book b ON b.code = rb.code_book
JOIN
(SELECT name_section
FROM book
GROUP BY name_section
HAVING COUNT(name_section) > 1) b1 ON b1.name_section = b.name_section
WHERE LEN(b.author) > (SELECT RIGHT(MIN(YEAR(date_renewal)),2) FROM reader_readercard_readerbook);

/* Извежда броя на секциите които имат поне 1 налична книга и годината на написване на книга от тази секция да са от 20 век */

GO
SELECT COUNT(s.name) AS 'Count of name section'
FROM book b
JOIN section s ON s.name= b.name_section
WHERE s.count_availabal_book >= 1 AND LEFT(b.year_create,2) = 19;

/* Извежда информация за читателя и читателската му карта 
като извежда единствено тези на които годината на създаване напрофила е между най-малката година на подновяване и най-голямата на създаване на читателската карта
и читателите с еднакви адреси */

GO
SELECT r.name AS 'Name of reader', r.adres AS 'Address of reader', r.egn AS 'Reader EGN', r.phone AS 'Reader phone', r.record_data AS 'Date of create acount', 
rc.date_create AS 'Date of create reader card', rc.date_renewal AS 'Date of last renewal' 
FROM reader r
JOIN reader_card rc ON r.codecard = rc.code
JOIN
(SELECT r.record_data
FROM reader r
JOIN reader_card rc ON rc.code = r.codecard
WHERE YEAR(r.record_data) BETWEEN (SELECT MIN(YEAR(date_renewal)) FROM reader_card) AND (SELECT MAX(YEAR(date_create)) FROM Reader_card)
) r2 ON r2.record_data = r.record_data
JOIN(
SELECT adres 
FROM reader
GROUP BY adres
HAVING COUNT(1) > 1
) r1 ON r1.adres = r.adres;

/* Извежда имената на авторите на книгите написани през една и съща година и не са налични*/

GO
SELECT b.author AS 'Author of book' 
FROM book b
JOIN
(SELECT year_create
FROM book
GROUP BY year_create
HAVING COUNT(1)>1) b1 ON b.year_create = b1.year_create
WHERE b.available = 'N';

/* Извежда броя на читателите взели по 1 книга от секция Business */

GO
SELECT COUNT(r.name) AS 'Name of reader'
FROM reader r
JOIN reader_book rb ON rb.name_reader = r.name
JOIN book b ON b.code = rb.code_book
WHERE r.count_get_book = 1 AND b.name_section = 'Business';

/* Извежда колко е общият брой на всички книги библиотеката */

GO
SELECT SUM(s.count_availabal_book + s.count_get_book) AS 'All book in the library'
FROM section s;

/* Извежда информация за читателите и книгите които са взели на които секциите се повтарят,
годините на написване на книгите да надвишават средната им годишка стоинос и сортира по името на читателя възходящо*/

GO
SELECT r.name AS 'Name of reader', r.adres AS 'Address of reader', r.egn AS 'Reader EGN', r.phone AS 'Phone of reader', r.record_data AS 'Date of create profile',
rc.date_create AS 'Date of create reader card', rc.date_renewal AS 'Date of renewal reader card', b.title AS 'Title of book', b.author AS 'Author of book', 
b.year_create AS 'Year of create book', b.name_section AS 'Name of section', s.count_get_book AS 'Section get book'
FROM reader r
JOIN reader_card rc ON rc.code = r.codecard
JOIN reader_book rb ON rb.name_reader = r.name
JOIN book b ON b.code = rb.code_book
JOIN section s ON s.name = b.name_section
JOIN(
SELECT name_section
FROM book
GROUP BY name_section
HAVING COUNT(1) > 1
) b1 ON b1.name_section = b.name_section
WHERE b.year_create >= (SELECT AVG(year_create) FROM book)
ORDER BY r.name DESC;