USE Library

/* ������� ���������� � ������ �� ������� ����� �� �������� ���� 1926 ��������� ��������� �� ���������� �� ������� */

GO
SELECT b.title AS 'title_of_book', b.author AS 'author_of_book'
FROM Book b
WHERE b.year_create >= 1926
ORDER BY b.title ASC;

/* �������� �������, ��������, ���������� 
� �� ���� �������� ����� ���� ����� Sofia
��������� ��������� �� ����� �� �������� */

GO
SELECT r.name AS 'name_of_reader', r.address AS 'address_of_reader', r.phone AS 'phone_of_reader'
FROM Reader r 
WHERE r.address = 'Sofia'
ORDER BY r.name DESC;

/* ������� ������ ���������� �� �������� ��� ���� �� Art and Creativity */

GO
SELECT * 
FROM Section s
WHERE s.name NOT LIKE 'Art and Creativity';

/*  ������� ������ ���������� �� ������� ����� �� �������� */

GO
SELECT * 
FROM Book b
WHERE b.available = 'Y';
