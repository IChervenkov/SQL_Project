USE Library

/* ������� ����� � ������� �� ���������� �� ����� �������� �� ��������� ������� � �������� �� ����������� */

GO
SELECT r.name AS 'Name of reader', r.egn AS 'EGN of reader'
FROM reader r
WHERE r.codecard IN (SELECT rc.code FROM reader_card rc WHERE YEAR(rc.date_create) = FORMAT(rc.date_renewal, N'yyyy'))
ORDER BY name DESC;

/* ������� ������� � �������� �� ���������� ����� ����� �� ��������� �� 11 (���) � ���� �� ������� �� ���� ����� �� � ������ �� 1 */

GO
SELECT r.name AS 'Name of reader', r.adres AS 'Address of reader'
FROM reader r
WHERE r.codecard IN (SELECT rc.code FROM reader_card rc WHERE FORMAT(rc.date_create, N'dd') = 11) 
AND r.name IN (SELECT rb.name_reader FROM reader_book rb GROUP BY rb.name_reader HAVING COUNT(rb.name_reader) > 1);

/* OR */

GO
SELECT r.name AS 'Name of reader', r.adres AS 'Address of reader'
FROM reader r 
WHERE r.codecard IN (SELECT rc.code FROM reader_card rc WHERE FORMAT(rc.date_create, N'dd') = 11) 
AND r.count_get_book > 1;

/* ������� ���������� � ������ �� ������� ����� ������ ���� ���� ���� �������� �����*/

GO
SELECT b.title AS 'Title of book', b.author AS 'Author of book'  
FROM book b
WHERE b.name_section IN (SELECT s.name FROM section s WHERE s.count_availabal_book >= 1);

/* ������� ������� �� ���������� ����� �� ����� ����� ����� � �������� ����� 1937 */

GO
SELECT rb.name_reader AS 'Name of reader'
FROM reader_book rb
WHERE rb.code_book IN (SELECT b.code FROM book b WHERE b.year_create <= 1937);

/* ������� ����������, ������, �������� �� ��������� �� �������, ����� �� ����� �� Georgi Georgiev � �������� �� ��� ���� 1 ����� ��� ������� ����� */

GO
SELECT b.title AS 'Title of book', b.author AS 'Author of book', b.year_create AS 'Year of create of book' 
FROM book b
WHERE b.code IN (SELECT rb.code_book FROM reader_book rb WHERE rb.name_reader = 'Georgi Georgiev') 
AND b.name_section IN (SELECT s.name FROM section s WHERE s.count_availabal_book >= 1 OR s.count_get_book >= 1);