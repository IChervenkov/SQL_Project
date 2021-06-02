GO
CREATE DATABASE Library

USE Library

GO
CREATE TABLE Reader 
(
	egn INT NOT NULL,
	name VARCHAR(256) PRIMARY KEY NOT NULL,
	adres VARCHAR(256),
	phone INT,
	codecard INT NOT NULL,
	record_data DATETIME NOT NULL
);
   
GO
CREATE TABLE Reader_book
(
	name_reader VARCHAR(256),
	code_book INT
);

GO
CREATE TABLE Reader_card
(	
	code INT PRIMARY KEY NOT NULL,
	date_create DATETIME NOT NULL DEFAULT GETDATE(),
	date_renewal DATETIME NOT NULL
);

GO
CREATE TABLE Book
( 
	code INT PRIMARY KEY NOT NULL,
	author VARCHAR(256) NOT NULL,
	title VARCHAR(256) NOT NULL,
	year_create INT NOT NULL,
	name_section VARCHAR(256) NOT NULL,
	available CHAR(2) NOT NULL,
	CHECK ((available = 'Y' OR available = 'N') AND (year_create >= 1000 AND year_create <= 9999))
);

GO
CREATE TABLE Section
(
	name VARCHAR(256) PRIMARY KEY NOT NULL
);

GO
ALTER TABLE Reader
ADD FOREIGN KEY (codecard) REFERENCES Reader_card(code);

GO
ALTER TABLE  Reader_book
ADD FOREIGN KEY (code_book) REFERENCES Book(code);

GO
ALTER TABLE  Reader_book
ADD FOREIGN KEY (name_reader) REFERENCES Reader(name);

GO
ALTER TABLE Book
ADD FOREIGN KEY (name_section) REFERENCES Section(name);
