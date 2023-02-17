USE Library

/* Displays the title of the books that Emilia Yancheva has taken */

GO
SELECT b.title AS 'title_of_book' 
FROM Book b
JOIN Reader_book rb ON b.code = rb.code_book
JOIN Reader r ON rb.id_reader = r.id
WHERE r.name = 'Emilia Yancheva';

/* Displays the names of readers who have taken books only from the Fantasy section */

GO
SELECT r.name AS 'name_of_reader' 
FROM Reader r
JOIN Reader_book rb ON r.id = rb.id_reader
JOIN Book b ON rb.code_book = b.code
JOIN Section s ON b.id_section = s.id
WHERE s.name = 'Fantasy';

/* Displays the names of the readers and the creation date of their reader card that were renewed before today's date */

GO
SELECT r.name AS 'name_of_reader', FORMAT(rc.date_create,N'dd.MM.yyyy') AS 'Date_of_create_profile'
FROM Reader r
JOIN Reader_card rc ON r.code_card = rc.code
WHERE rc.date_renewal < GETDATE();

/* Lists the names of readers who have picked up books by Robert Kiyosaki and Napoleon Hill */

GO
SELECT r.name AS 'name_of_reader'
FROM Reader r
JOIN Reader_book rb ON rb.id_reader = r.id
JOIN Book b ON rb.code_book = b.code
WHERE b.author = 'Robert Kiyosaki' OR b.author = 'Napoleon Hill';
