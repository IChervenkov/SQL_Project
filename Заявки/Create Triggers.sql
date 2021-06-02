USE Library

GO
ALTER TABLE Reader
ADD count_get_book INT;

GO
CREATE TRIGGER trg_readerbook_insert
ON reader_book
AFTER INSERT
AS
BEGIN
	UPDATE Reader SET count_get_book = count_get_book + 1 
	WHERE name IN (SELECT i.name_reader FROM inserted i)

	UPDATE Book SET available = 'N'
	WHERE code IN (SELECT i.code_book FROM inserted i)
END;

GO
CREATE TRIGGER trg_readerbook_delete
ON reader_book
AFTER DELETE
AS
BEGIN
	UPDATE Reader SET count_get_book = count_get_book - 1 
	WHERE name IN (SELECT d.name_reader FROM deleted d);

	UPDATE Book SET available = 'Y'
	WHERE code IN (SELECT d.code_book FROM deleted d)
END;

GO
ALTER TABLE Section
ADD count_availabal_book INT, count_get_book INT;

GO
CREATE TRIGGER trg_book_insert
ON Book
AFTER INSERT
AS
BEGIN
	UPDATE Section SET count_availabal_book = count_availabal_book + 1 
	WHERE name IN (SELECT i.name_section FROM inserted i WHERE i.available = 'Y');

	UPDATE Section SET count_get_book = count_get_book + 1 
	WHERE name IN (SELECT i.name_section FROM inserted i WHERE i.available = 'N');
END;

GO
CREATE TRIGGER trg_book_delete
ON Book
AFTER DELETE
AS
BEGIN
	UPDATE Section SET count_availabal_book = count_availabal_book - 1 
	WHERE name IN (SELECT i.name_section FROM deleted i WHERE i.available = 'Y');

	UPDATE Section SET count_get_book = count_get_book - 1 
	WHERE name IN (SELECT i.name_section FROM deleted i WHERE i.available = 'N');
END;

GO
CREATE TRIGGER trg_reader_update
ON Reader
AFTER UPDATE
AS
BEGIN
	UPDATE reader_book SET name_reader = (SELECT i.name FROM inserted i) 
	WHERE name_reader IN (SELECT d.name FROM deleted d);
END;

GO
CREATE TRIGGER trg_book_update
ON Book
AFTER UPDATE
AS
BEGIN
	UPDATE reader_book SET code_book = (SELECT i.code FROM inserted i) 
	WHERE code_book IN (SELECT d.code FROM deleted d);

	UPDATE Section SET count_availabal_book = count_availabal_book + 1
	WHERE name IN (SELECT i.name_section FROM inserted i
				   JOIN deleted d ON i.code = d.code 
				   WHERE i.available = 'Y' AND d.available = 'N');

	UPDATE Section SET count_get_book = count_get_book + 1 
	WHERE name IN (SELECT i.name_section FROM inserted i
				   JOIN deleted d ON i.code = d.code 
				   WHERE i.available = 'N' AND d.available = 'Y');

	UPDATE Section SET count_availabal_book = count_availabal_book - 1 
	WHERE name IN (SELECT d.name_section FROM deleted d
				   JOIN inserted i ON d.code = i.code
				   WHERE i.available = 'N' AND d.available = 'Y');

	UPDATE Section SET count_get_book = count_get_book - 1 
	WHERE name IN (SELECT d.name_section FROM deleted d 
				   JOIN inserted i ON i.code = d.code 
				   WHERE i.available = 'Y' AND d.available = 'N');
END;