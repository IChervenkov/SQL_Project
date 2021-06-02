USE Library

/* ������ ����� ������� ����� �� ���������� ����� �� ����� �����, ���������� �� ����������� ����� � ���� �� ������� ����� �� ����������� ������ */

GO
CREATE VIEW readerbook_book
AS 
SELECT rb.name_reader, b.title
FROM reader_book rb
JOIN book b ON b.code = rb.code_book;

/* ������ ����� ������� ������� �� ����������, ����� �� ����� ���� ���� �����, ���-�� ��, ������ �� � ������ �� ���������� ����������� �� ������� �� */

GO
CREATE VIEW reader_readercard_readerbook
AS
SELECT rb.name_reader, r.egn, r.adres, rc.date_renewal
FROM reader r
JOIN reader_book rb ON rb.name_reader = r.name
JOIN reader_card rc ON rc.code = r.codecard;

/* ������ �� ������� �� ��������, ����� ������ �� ��������� � ����������� �� ������� � ������� ����� */

GO
CREATE VIEW reader_readercard
AS 
SELECT r.name, r.egn, r.adres, r.phone,
r.count_get_book, FORMAT(r.record_data,'dd-MM-yyyy') AS date
FROM reader r
JOIN reader_card rc ON rc.code = r.codecard
WHERE MONTH(rc.date_create) %2 <> 0 AND MONTH(rc.date_renewal) %2 <> 0;

/* ������ �� ������� �� ������� ����� ������ ���� ���� 1 ����� ����� � � ����� �� �������� '�' */

GO
CREATE VIEW book_section
AS
SELECT b.title, b.author, b.year_create, b.name_section
FROM book b
JOIN section s ON s.name = b.name_section
WHERE s.count_get_book >= 1 AND s.name LIKE '%e%';