USE Library

/* ������� ���������� �� ����������, ������, �������� �� ��������� �� ������� ����� ������ ���� ���� 1 ����� ����� */

GO
SELECT b.title AS 'title_of_book', b.author AS 'author_of_book', b.year_create AS 'year_of_writing'
FROM Book b
JOIN
(SELECT id_section FROM Book
GROUP BY id_section
HAVING COUNT(id_section) > 1) bs ON bs.id_section = b.id_section;

/* ������� ������� �� ���������e ����� �� ����� ������ �� ���� ����� */

GO
SELECT r.name AS 'name_of_reader'
FROM Reader r
JOIN(
SELECT id_reader FROM Reader_book
GROUP BY id_reader
HAVING COUNT(id_reader) > 1) rb ON rb.id_reader = r.id

/*  ������� ������� �� ��������, ����� ������ �� ��������� � ����������� �� ������� � ������� ����� � ������� ������ 
� ���������� �� ��������� �� ������� ����� */

GO
SELECT r.name AS 'name_of_reader', r.egn AS 'egn', r.address AS 'address', r.phone AS 'phone'
FROM Reader r
JOIN
(SELECT address
FROM Reader
GROUP BY address
HAVING COUNT(1) > 1) r1 ON r1.address = r.address 
JOIN Reader_card rc ON rc.code = r.code_card
WHERE RIGHT(r.phone,1) % 2 <> 0 AND MONTH(rc.date_create) % 2 <> 0 AND MONTH(rc.date_renewal) % 2 <> 0;

/* ������� ������� �� ����������, ����� �� ����� ���� ���� �����, ���-�� ��, ������ �� � ������ �� ���������� ����������� �� ������� �� 
� ���������� �� ������� ����� �� �����, 
���� ������� ���� ���� ����� ��������� �� ������ � ��-������ �� ���������� 2 ����� �� ���-������� ������ �� ��������� �� ������� �� ��������,
���� ���� ���� ������������ �� ������� � ���������� �� ������ � ������ �� 1 ����� ����� */

GO
SELECT DISTINCT r.name AS 'name_of_reader', r.egn AS 'egn', r.address AS 'reader_address', rc.date_renewal AS 'date_of_create_profile', 
b.title AS 'title_of_book', b.author AS 'author_of_book', b.year_create 'year_of_create_book', s.name AS 'book_section'
FROM Reader r
JOIN Reader_card rc ON rc.code = r.code_card
JOIN Reader_book rb ON rb.id_reader = r.id
JOIN Book b ON b.code = rb.code_book
JOIN Section s ON b.id_section = s.id
JOIN
(SELECT id_section
FROM Book
GROUP BY id_section
HAVING COUNT(id_section) > 1) b1 ON b1.id_section = b.id_section
GROUP BY b.author, r.name, r.egn, r.address, rc.date_renewal, b.title, b.year_create,s.name 
HAVING LEN(b.author) > (SELECT RIGHT(MIN(YEAR(date_renewal)),2) FROM Reader_card);

/* ������� ���� �� �������� ����� ���� ���� 1 ������� ����� � �������� �� ��������� �� ����� �� ���� ������ �� �� �� 20 ��� */

GO
SELECT COUNT(s.name) AS 'count_of_section'
FROM Book b
JOIN Section s ON s.id= b.id_section
WHERE s.count_availabal_book >= 1 AND LEFT(b.year_create,2) = 19;

/* ������� ���������� �� �������� � ������������ �� ����� 
���� ������� ���������� ���� �� ����� �������� �� ��������� �� ������� � ����� ���-������� ������ �� ����������� � ���-�������� �� ��������� �� ������������ �����
� ���������� � ������� ������ */

GO
SELECT r.name AS 'name_of_reader', r.address AS 'address_of_reader', r.egn AS 'egn', r.phone AS 'reader_phone', r.record_data AS 'date_of_create_acount', 
rc.date_create AS 'date_of_create_reader_card', rc.date_renewal AS 'date_of_last_renewal'
FROM Reader r
JOIN Reader_card rc ON r.code_card = rc.code
JOIN
(SELECT r.record_data
FROM Reader r
JOIN Reader_card rc ON rc.code = r.code_card
WHERE YEAR(r.record_data) BETWEEN (SELECT MIN(YEAR(date_renewal)) FROM reader_card) AND (SELECT MAX(YEAR(date_create)) FROM Reader_card)
) r2 ON r2.record_data = r.record_data
JOIN(
SELECT address 
FROM Reader
GROUP BY address
HAVING COUNT(1) > 1
) r1 ON r1.address = r.address;

/* ������� ������� �� �������� �� ������� �������� ���� ���� � ���� ������ � �� �� �������*/

GO
SELECT b.author AS 'author_of_book' 
FROM Book b
JOIN
(SELECT year_create
FROM Book
GROUP BY year_create
HAVING COUNT(1)>1) b1 ON b.year_create = b1.year_create
WHERE b.available = 'N';

/* ������� ���� �� ���������� ����� �� 1 ����� �� ������ Business */

GO
SELECT COUNT(r.name) AS 'name_of_reader'
FROM Reader r
JOIN Reader_book rb ON rb.id_reader = r.id
JOIN Book b ON b.code = rb.code_book
JOIN Section s ON b.id_section = s.id
WHERE r.count_get_book = 1 AND s.name = 'Business';

/* ������� ����� � ������ ���� �� ������ ����� � ������������ */

GO
SELECT COUNT(*) AS 'all_book_in_the_library'
FROM Book;

/* ������� ���������� �� ���������� � ������� ������� �� ����� �������� �� ��������,
�������� �� ��������� �� ������� �� ���������� �������� �� ������� ������� � ������� �� ����� �� �������� ���������*/

GO
SELECT r.name AS 'name_of_reader', r.address AS 'address_of_reader', r.egn AS 'egn', r.phone AS 'phone', r.record_data AS 'date_of_create_profile',
rc.date_create AS 'date_of_create_reader_card', rc.date_renewal AS 'date_RRC', b.title AS 'title', b.author AS 'author', 
b.year_create AS 'year_create_book', s.name AS 'name_of_section', s.count_get_book AS 'section_get_book'
FROM Reader r
JOIN Reader_card rc ON rc.code = r.code_card
JOIN Reader_book rb ON rb.id_reader = r.id
JOIN Book b ON b.code = rb.code_book
JOIN Section s ON s.id = b.id_section
JOIN(
SELECT id_section
FROM Book
GROUP BY id_section
HAVING COUNT(1) > 1
) b1 ON b1.id_section = b.id_section
WHERE b.year_create >= (SELECT AVG(year_create) FROM Book)
ORDER BY r.name DESC;