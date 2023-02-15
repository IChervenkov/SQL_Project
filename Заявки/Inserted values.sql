GO
USE Library

GO
INSERT INTO Section VALUES (1,'Art and Creativity',0,0);
INSERT INTO Section VALUES (2,'Business',0,0);
INSERT INTO Section VALUES (3,'Fantasy',0,0);
INSERT INTO Section VALUES (4,'Fitness',0,0);
INSERT INTO Section VALUES (5,'History',0,0);
INSERT INTO Section VALUES (6,'Novel',0,0);
INSERT INTO Section VALUES (7,'Philosophy',0,0);
INSERT INTO Section VALUES (8,'Science',0,0);

GO
INSERT INTO Book VALUES	(1,'Robert Kiyosaki','Rich Dad Poor Dad',1997,2,'Y');
INSERT INTO Book VALUES	(2,'George S. Clason','The Richest Man in Babylon ',1926,2,'N');
INSERT INTO Book VALUES	(3,'J. R. R. Tolkien','The Lord of the Rings',1937,3,'N');
INSERT INTO Book VALUES	(4,'Frederic Delavier','Strength Training Anatomy',1998,4,'Y');
INSERT INTO Book VALUES	(5,'Leo Tolstoy','War and Peace',1865,5,'N');
INSERT INTO Book VALUES	(6,'Carl Sagan','Cosmos',1980,8,'Y');
INSERT INTO Book VALUES	(7,'Napoleon Hill','Think and Grow Rich',1937,2,'Y');
INSERT INTO Book VALUES	(8,'F. Scott Fitzgerald','The Great Gatsby',1925,6,'Y');
INSERT INTO Book VALUES	(9,'Daniel Defoe','Robinsons Crusoe',1719,6,'Y');

GO
INSERT INTO Reader VALUES (1,'9910253454','Desislava Ivanova','Sofia','0882343543',10,'2008-11-11',0);
INSERT INTO Reader VALUES (2,'9504253410','Georgi Georgiev','Pleven','0881246532',11,'2011-5-11',0);
INSERT INTO Reader VALUES (3,'9510103420','Emilia Yancheva','Sofia','0881251956',12,'2015-9-6',0);
INSERT INTO Reader VALUES (4,'0210253620','Galin Petrov','Dobrich','0881263245',13,'2017-10-29',0);
INSERT INTO Reader VALUES (5,'9210303352','Yavor Yanakiev','Varna','0881276547',14,'2019-10-29',0);
INSERT INTO Reader VALUES (6,'9805203152','Yanica Vulkova','Ruse','0881281296',15,'2020-3-15',0);

GO
INSERT INTO Reader_card VALUES (10,'2008-11-11 00:00:00.000','2010-11-11 00:00:00.000');
INSERT INTO Reader_card VALUES (11,'2011-05-11 00:00:00.000','2014-05-11 00:00:00.000');
INSERT INTO Reader_card VALUES (12,'2015-09-06 00:00:00.000','2017-09-06 00:00:00.000');
INSERT INTO Reader_card VALUES (13,'2017-10-29 00:00:00.000','2019-10-29 00:00:00.000');
INSERT INTO Reader_card VALUES (14,'2019-10-29 00:00:00.000','2019-10-29 00:00:00.000');
INSERT INTO Reader_card VALUES (15,'2020-03-15 00:00:00.000','2020-03-15 00:00:00.000');

GO
INSERT INTO Reader_book VALUES (4,1);
INSERT INTO Reader_book VALUES (5,2);
INSERT INTO Reader_book VALUES (6,3);
INSERT INTO Reader_book VALUES (3,7);
INSERT INTO Reader_book VALUES (2,4);
INSERT INTO Reader_book VALUES (2,5);