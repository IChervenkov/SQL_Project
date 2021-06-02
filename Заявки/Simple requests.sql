USE Library

/* ������� ���� � ���������� �� ������� ����� �� �� ������ Business 
� �� �������� ���� 1926 ��������� ��������� �� ���������� �� ������� */

GO
SELECT code AS 'Code of book', title AS 'Title of book' 
FROM book
WHERE name_section LIKE 'Business' AND year_create >= 1926
ORDER BY title ASC;

/* �������� �������, ��������, ���������� 
� ���� �� ������������ ����� �� ���� �������� ����� ���� ����� Sofia
��������� ��������� �� ����� �� �������� */

GO
SELECT name AS 'Name of reader', adres AS 'Address of reader', phone AS 'Phone of reader', codecard AS 'Code of reader' 
FROM reader 
WHERE adres = 'Sofia'
ORDER BY name DESC;

/* ������� ������ ���������� �� �������� ��� ���� �� Art and Creativity */

GO
SELECT * 
FROM section 
WHERE name NOT LIKE 'Art and Creativity';

/*  ������� ������ ���������� �� ������� ����� �� �������� */

GO
SELECT * 
FROM book 
WHERE available = 'Y';

/* ������� ������� �� ���������� ����� �� ����� ����� � ��� 1 */

GO
SELECT name_reader AS 'Name of reader' 
FROM reader_book 
WHERE code_book = 1;
