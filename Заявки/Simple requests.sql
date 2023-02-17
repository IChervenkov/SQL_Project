USE Library

/* Displays the title and author of books written after 1926, sorted ascending by book title */

GO
SELECT b.title AS 'title_of_book', b.author AS 'author_of_book'
FROM Book b
WHERE b.year_create >= 1926
ORDER BY b.title ASC;

/* Displays names, addresses, phone numbers 
and those readers who have a Sofia address,
sorted descending by the name of the reader */

GO
SELECT r.name AS 'name_of_reader', r.address AS 'address_of_reader', r.phone AS 'phone_of_reader'
FROM Reader r 
WHERE r.address = 'Sofia'
ORDER BY r.name DESC;

/* Displays all section information except Art and Creativity */

GO
SELECT * 
FROM Section s
WHERE s.name NOT LIKE 'Art and Creativity';

/*  Displays all information about the books that are free */

GO
SELECT * 
FROM Book b
WHERE b.available = 'Y';
