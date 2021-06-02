USE Library

/* ������� ���������� �� ������� ����� Emilia Yancheva � ����� */

GO
SELECT b.title AS 'Title of book' 
FROM book b
JOIN Reader_book rb ON b.code = rb.code_book
WHERE name_reader = 'Emilia Yancheva';

/* ������� ������� �� ���������� ����� �� ����� ����� ���� �� ������ Fantasy */

GO
SELECT rb.name_reader AS 'Name of reader' 
FROM Reader_book rb
JOIN book b ON rb.code_book = b.code
WHERE b.name_section = 'Fantasy';

/* ������� ������� �� ����������, ������� ��� �� ������������ �� �����
� ���� �� ��������� �� ������� �� */

GO
SELECT r.name AS 'Name of reader', r.codecard AS 'Code of reader card', FORMAT(rc.date_renewal,N'dd.MM.yyyy') AS 'Date of create profil'
FROM reader r
JOIN reader_card rc ON r.codecard = rc.code
WHERE rc.date_renewal > '2015-06-06';

/* ������� ������� �� ���������� ����� �� ����� ����� � ������ Robert Kiyosaki � Napoleon Hill */

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

/* ������� ������ �� ����������, ���������� �� � ���� �� ������������ �� �����
���� �� ���� ����� �� ����� ����� ����� ����� � �������� �������� � ������� ����� */

GO
SELECT r.name AS 'Name of reader', r.phone AS 'Phone of reader', r.codecard AS 'Code of reader card'
FROM reader r 
JOIN Reader_book rb ON r.name = rb.name_reader
JOIN book b ON rb.code_book = b.code
WHERE LEFT(b.author,1) = LEFT(b.title,1);