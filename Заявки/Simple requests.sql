USE Library

/* Извежда кода и заглавието на книгите които са от секция Business 
и са написани след 1926 сортирани низходящо по заглавието на книгата */

GO
SELECT code AS 'Code of book', title AS 'Title of book' 
FROM book
WHERE name_section LIKE 'Business' AND year_create >= 1926
ORDER BY title ASC;

/* Иззвежда имената, адресите, телефоните 
и кода на читателските карти на тези читатели които имат адрес Sofia
сортирани възходящо по името на читателя */

GO
SELECT name AS 'Name of reader', adres AS 'Address of reader', phone AS 'Phone of reader', codecard AS 'Code of reader' 
FROM reader 
WHERE adres = 'Sofia'
ORDER BY name DESC;

/* Извежда цялата информация за секциите без тази на Art and Creativity */

GO
SELECT * 
FROM section 
WHERE name NOT LIKE 'Art and Creativity';

/*  Извежда цялата информация за книгите които са свободни */

GO
SELECT * 
FROM book 
WHERE available = 'Y';

/* Извежда имената на читателите които са взели книга с код 1 */

GO
SELECT name_reader AS 'Name of reader' 
FROM reader_book 
WHERE code_book = 1;
