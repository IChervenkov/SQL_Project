GO
CREATE DATABASE Library

USE Library

GO
CREATE TABLE Reader 
(
	id INT PRIMARY KEY NOT NULL,
	egn NCHAR(10) UNIQUE NOT NULL,
	name VARCHAR(256),
	address VARCHAR(256),
	phone NVARCHAR(13) UNIQUE NOT NULL,
	code_card INT FOREIGN KEY REFERENCES Reader_card(code),
	record_data DATETIME,
	count_get_book INT
);
   
GO
CREATE TABLE Reader_book
(
	id_reader INT FOREIGN KEY REFERENCES Reader(id),
	code_book INT FOREIGN KEY REFERENCES Book(code)
);

GO
CREATE TABLE Reader_card
(	
	code INT PRIMARY KEY NOT NULL,
	date_create DATETIME DEFAULT GETDATE(),
	date_renewal DATETIME
);

GO
CREATE TABLE Book
( 
	code INT PRIMARY KEY NOT NULL,
	author VARCHAR(256),
	title VARCHAR(256),
	year_create INT,
	id_section INT FOREIGN KEY REFERENCES Section(id),
	available CHAR(2),
	CHECK ((available = 'Y' OR available = 'N') AND (year_create >= 1000 AND year_create <= 9999))
);

GO
CREATE TABLE Section
(
	id INT PRIMARY KEY NOT NULL,
	name VARCHAR(256),
	count_availabal_book INT DEFAULT 0,
	count_get_book INT DEFAULT 0
);