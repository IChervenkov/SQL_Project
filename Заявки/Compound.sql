USE Library

/* ������� �����, ������ � ������ �� ��������� �� ������������ ����� �� ���������� ����� �� ����� ����� �������� ���� 1937 */

GO
CREATE INDEX idx_book_year
ON book(code,year_create);

GO
SELECT r.name AS 'name_of reader', r.address AS 'address_of_reader', FORMAT(rc.date_create,'dd-MM-yyyy') AS 'date_of_create_reader_card'
FROM Reader r
JOIN Reader_card rc ON rc.code = r.code_card
JOIN Reader_book rb ON r.id = rb.id_reader
JOIN Book b ON b.code = rb.code_book
WHERE b.year_create = 1937;

/* ������� ������ ������ � ���������� �� ������ ����� ��� ��� ���� � �������� �� ����� ����� */

GO
SELECT s.name AS 'name_of_section', b.title AS 'title_of_book'
FROM Section s
FULL OUTER JOIN Book b ON s.id = b.id_section;

/* ������� �������� �� ������������ ����� �� ���� �������� ����� �� ����� ����� �� ������ History 
� ������� � �������� ��������� ���� 2010 ���. */

GO
CREATE INDEX idx_book_aval_ns
ON book(code,available,id_section);

GO
CREATE INDEX idx_readercard_dr
ON reader_card(code,date_renewal);

GO
SELECT rc.code AS 'code_of_reader_card'
FROM Reader_card rc
JOIN Reader r ON rc.code = r.code_card
JOIN Reader_book rb ON rb.id_reader = r.id
JOIN Book b ON b.code = rb.code_book
JOIN Section s ON b.id_section = s.id
WHERE b.available = 'N' AND s.name = 'History' AND YEAR(rc.date_renewal) >= 2010;

/* ������� ���������� �� ������� � ������� �� ����������, ����� ���� �� ������ �� 2 ����� �����, ����� �� �������� �� Frederic Delavier ��� Daniel Defoe */

GO
CREATE INDEX idx_reader_cgb
ON Reader(name,count_get_book);

GO
CREATE INDEX idx_book_aut
ON book(code,author);

GO
SELECT r.name AS 'name_of_reader', b.title AS 'book_title'
FROM Reader r
JOIN Reader_book rb ON rb.id_reader = r.id
JOIN book b ON b.code = rb.code_book
WHERE r.count_get_book <= 2 AND b.author = 'Frederic Delavier' OR b.author = 'Daniel Defoe';

/* ������� ������� �� �������� ����� ���� ���� ���� ����� ����� � ������� ����� �� ���� ������ �� �� �������� ���� 1865,
������� � ���������� �� ���� �����, ������� �� ����������, ����� �� �� ����� � ������� ��� � ������ �� ��������� �� ������������ �� ����� ������� � ����. */

GO
CREATE INDEX idx_section_cd
ON section(name,count_get_book);

GO
SELECT s.name AS 'name_of_section', b.title AS 'title_of_book', r.name AS 'name_of_reder', r.egn AS 'reader_EGN', FORMAT(rc.date_create,'MMMM') AS 'month_of_create_of_profile'
FROM section s
JOIN Book b ON b.id_section = s.id
JOIN Reader_book rb ON rb.code_book = b.code
JOIN Reader r ON r.id = rb.id_reader
JOIN Reader_card rc ON rc.code = r.code_card
WHERE s.count_get_book >= 1 AND b.year_create > 1865 AND b.available = 'N';