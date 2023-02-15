USE Library

/* Извежда заглавието и автора на книгите които са написани след 1926 сортирани низходящо по заглавието на книгата */

GO
SELECT b.title AS 'title_of_book', b.author AS 'author_of_book'
FROM Book b
WHERE b.year_create >= 1926
ORDER BY b.title ASC;

/* Иззвежда имената, адресите, телефоните 
и на тези читатели които имат адрес Sofia
сортирани възходящо по името на читателя */

GO
SELECT r.name AS 'name_of_reader', r.address AS 'address_of_reader', r.phone AS 'phone_of_reader'
FROM Reader r 
WHERE r.address = 'Sofia'
ORDER BY r.name DESC;

/* Извежда цялата информация за секциите без тази на Art and Creativity */

GO
SELECT * 
FROM Section s
WHERE s.name NOT LIKE 'Art and Creativity';

/*  Извежда цялата информация за книгите които са свободни */

GO
SELECT * 
FROM Book b
WHERE b.available = 'Y';
