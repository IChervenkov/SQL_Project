USE Library

GO
INSERT INTO Section VALUES ('Art and Creativity',0,0);
INSERT INTO Section VALUES ('Business',0,0);
INSERT INTO Section VALUES ('Fantasy',0,0);
INSERT INTO Section VALUES ('Fitness',0,0);
INSERT INTO Section VALUES ('History',0,0);
INSERT INTO Section VALUES ('Novel',0,0);
INSERT INTO Section VALUES ('Philosophy',0,0);
INSERT INTO Section VALUES ('Science',0,0);

GO
INSERT INTO Book VALUES	(1,'Robert Kiyosaki','Rich Dad Poor Dad',1997,'Business','Y');
INSERT INTO Book VALUES	(2,'George S. Clason','The Richest Man in Babylon ',1926,'Business','N');
INSERT INTO Book VALUES	(3,'J. R. R. Tolkien','The Lord of the Rings',1937,'Fantasy','N');
INSERT INTO Book VALUES	(4,'Frederic Delavier','Strength Training Anatomy',1998,'Fitness','Y');
INSERT INTO Book VALUES	(5,'Leo Tolstoy','War and Peace',1865,'History','N');
INSERT INTO Book VALUES	(6,'Carl Sagan','Cosmos',1980,'Science','Y');
INSERT INTO Book VALUES	(7,'Napoleon Hill','Think and Grow Rich',1937,'Business','Y');
INSERT INTO Book VALUES	(8,'F. Scott Fitzgerald','The Great Gatsby',1925,'Novel','Y');
INSERT INTO Book VALUES	(9,'Daniel Defoe','Robinsons Crusoe',1719,'Novel','Y');

GO
INSERT INTO Reader VALUES (12345,'Desislava Ivanova','Sofia',89123,10,'2008-11-11 00:00:00.000',0);
INSERT INTO Reader VALUES (12346,'Georgi Georgiev','Pleven','088124',11,'2011-5-11',0);
INSERT INTO Reader VALUES (12347,'Emilia Yancheva','Sofia','088125',12,'2015-9-6',0);
INSERT INTO Reader VALUES (12348,'Galin Petrov','Dobrich','088126',13,'2017-10-29',0);
INSERT INTO Reader VALUES (12349,'Yavor Yanakiev','Varna','088127',14,'2019-10-29',0);
INSERT INTO Reader VALUES (12350,'Yanica Vulkova','Ruse','088128',15,'2020-3-15',0);

GO
INSERT INTO Reader_card VALUES (10,'2008-11-11 00:00:00.000','2010-11-11 00:00:00.000');
INSERT INTO Reader_card VALUES (11,'2011-05-11 00:00:00.000','2014-05-11 00:00:00.000');
INSERT INTO Reader_card VALUES (12,'2015-09-06 00:00:00.000','2017-09-06 00:00:00.000');
INSERT INTO Reader_card VALUES (13,'2017-10-29 00:00:00.000','2019-10-29 00:00:00.000');
INSERT INTO Reader_card VALUES (14,'2019-10-29 00:00:00.000','2019-10-29 00:00:00.000');
INSERT INTO Reader_card VALUES (15,'2020-03-15 00:00:00.000','2020-03-15 00:00:00.000');

GO
INSERT INTO Reader_book VALUES ('Galin Petrov',1);
INSERT INTO Reader_book VALUES ('Yavor Yanakiev',2);
INSERT INTO Reader_book VALUES ('Yanica Vulkova',3);
INSERT INTO Reader_book VALUES ('Emilia Yancheva',7);
INSERT INTO Reader_book VALUES ('Georgi Georgiev',4);
INSERT INTO Reader_book VALUES ('Georgi Georgiev',5);