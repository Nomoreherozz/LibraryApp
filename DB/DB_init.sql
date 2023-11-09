DROP DATABASE IF EXISTS `pe2023`;
CREATE DATABASE  IF NOT EXISTS `pe2023` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `pe2023`;
-- MySQL dump 10.13  Distrib 8.0.27, for Win64 (x86_64)
--
-- Host: 127.0.0.2    Database: pe2023
-- ------------------------------------------------------
-- Server version	8.0.27

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `author`
--

DROP TABLE IF EXISTS `author`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `author` (
  `Author_ID` int NOT NULL,
  `Author_fname` varchar(45) NOT NULL,
  `Author_lname` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`Author_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `author`
--

LOCK TABLES `author` WRITE;
/*!40000 ALTER TABLE `author` DISABLE KEYS */;
INSERT INTO `author` VALUES (1,'Nomad','Nomor'),(2,'Gla1ve','Dev1ce'),(3,'Decade','Build'),(4,'Triss','Yennefer'),(5,'Holmes','Watson'),(6,'Excalibur','Mag'),(7,'V','X');
/*!40000 ALTER TABLE `author` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `book`
--

DROP TABLE IF EXISTS `book`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `book` (
  `Book_ID` int NOT NULL DEFAULT '0',
  `Title` varchar(45) NOT NULL,
  `Category_ID` int NOT NULL,
  `Publication_year` int NOT NULL,
  `Quantity` int NOT NULL,
  PRIMARY KEY (`Book_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `book`
--

LOCK TABLES `book` WRITE;
/*!40000 ALTER TABLE `book` DISABLE KEYS */;
INSERT INTO `book` VALUES (1,'The Da Vinci Code',3,2003,3),(2,'Fugilm (The Horus Heresy)',2,2015,3),(3,'The Girl Who Loved Tom Gordon',1,1999,3),(4,'Warframe',2,2021,4),(5,'CyberPunk 2077: No Coincidence',2,2020,3),(6,'The Witcher: The Last Wish',4,2010,2),(7,'Sherlock',5,2011,1),(8,'Lord of the Rings: The return of the King',4,2000,2),(9,'Harry Potter: hội con gà lửa',4,9999,5);
/*!40000 ALTER TABLE `book` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `book_author`
--

DROP TABLE IF EXISTS `book_author`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `book_author` (
  `BookID` int NOT NULL,
  `AuthorID` int NOT NULL,
  KEY `Author_ID_idx` (`AuthorID`),
  KEY `BookID_idx` (`BookID`),
  CONSTRAINT `AuthorID` FOREIGN KEY (`AuthorID`) REFERENCES `author` (`Author_ID`),
  CONSTRAINT `BookID` FOREIGN KEY (`BookID`) REFERENCES `book` (`Book_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `book_author`
--

LOCK TABLES `book_author` WRITE;
/*!40000 ALTER TABLE `book_author` DISABLE KEYS */;
INSERT INTO `book_author` VALUES (1,1),(1,3),(2,3),(3,3),(4,4),(5,5),(6,6),(7,7),(8,2);
/*!40000 ALTER TABLE `book_author` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `category` (
  `Category_ID` int NOT NULL,
  `Category_name` varchar(45) NOT NULL,
  KEY `Category_ID` (`Category_ID`),
  CONSTRAINT `Category_ID` FOREIGN KEY (`Category_ID`) REFERENCES `book` (`Book_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` VALUES (1,'Horror fiction'),(2,'science fiction'),(3,'Mystery, Thriller'),(4,'Fantasy'),(5,'Drama');
/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fine`
--

DROP TABLE IF EXISTS `fine`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fine` (
  `SessionID` int NOT NULL,
  `Fine_days` int NOT NULL DEFAULT '0',
  `Fine_amount` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`SessionID`),
  UNIQUE KEY `SessionID_UNIQUE` (`SessionID`),
  CONSTRAINT `SessionID` FOREIGN KEY (`SessionID`) REFERENCES `lease` (`SessionID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fine`
--

LOCK TABLES `fine` WRITE;
/*!40000 ALTER TABLE `fine` DISABLE KEYS */;
INSERT INTO `fine` VALUES (1,16,16000),(2,31,31000),(3,31,31000),(4,9,9000),(5,9,9000),(6,1,1000),(7,1,1000),(8,0,0),(9,0,0),(10,0,0);
/*!40000 ALTER TABLE `fine` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lease`
--

DROP TABLE IF EXISTS `lease`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lease` (
  `SessionID` int NOT NULL,
  `Book_ID` int NOT NULL,
  `ISSN` int NOT NULL,
  `Lease_date` datetime NOT NULL,
  `Expiry_date` datetime NOT NULL,
  `Status` varchar(45) NOT NULL DEFAULT 'active',
  PRIMARY KEY (`SessionID`),
  UNIQUE KEY `SessionID_UNIQUE` (`SessionID`),
  KEY `Book_ID_idx` (`Book_ID`),
  KEY `ISSN_idx` (`ISSN`),
  CONSTRAINT `Book_ID` FOREIGN KEY (`Book_ID`) REFERENCES `book` (`Book_ID`),
  CONSTRAINT `ISSN` FOREIGN KEY (`ISSN`) REFERENCES `user` (`ISSN`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lease`
--

LOCK TABLES `lease` WRITE;
/*!40000 ALTER TABLE `lease` DISABLE KEYS */;
INSERT INTO `lease` VALUES (1,1,16014,'2023-05-08 01:00:00','2023-05-30 00:00:00','de-active'),(2,2,16014,'2023-05-08 16:37:00','2023-05-15 16:37:00','de-active'),(3,3,16014,'2023-05-08 16:48:00','2023-05-15 16:48:00','de-active'),(4,4,17096,'2023-05-31 09:47:00','2023-06-07 09:47:00','active'),(5,7,17096,'2023-05-31 10:02:00','2023-06-07 10:02:00','active'),(6,5,16014,'2023-06-07 13:35:00','2023-06-14 13:35:00','de-active'),(7,5,16014,'2023-06-07 13:37:00','2023-06-14 13:37:00','de-active'),(8,1,16014,'2023-06-09 11:03:00','2023-06-16 11:03:00','active'),(9,1,14820,'2023-06-09 11:05:00','2023-06-16 11:05:00','de-active'),(10,2,14820,'2023-06-09 11:06:00','2023-06-16 11:06:00','active');
/*!40000 ALTER TABLE `lease` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payment`
--

DROP TABLE IF EXISTS `payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payment` (
  `Payment_ID` int NOT NULL,
  `Customer_ID` int NOT NULL,
  `Lease_date` datetime NOT NULL,
  `Payment_date` datetime NOT NULL,
  `Payment_amount` int NOT NULL DEFAULT '7000',
  PRIMARY KEY (`Payment_ID`),
  UNIQUE KEY `Payment_ID_UNIQUE` (`Payment_ID`),
  KEY `Customer_ID_idx` (`Customer_ID`),
  CONSTRAINT `Customer_ID` FOREIGN KEY (`Customer_ID`) REFERENCES `user` (`ISSN`),
  CONSTRAINT `Payment_ID` FOREIGN KEY (`Payment_ID`) REFERENCES `lease` (`SessionID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment`
--

LOCK TABLES `payment` WRITE;
/*!40000 ALTER TABLE `payment` DISABLE KEYS */;
INSERT INTO `payment` VALUES (1,16014,'2023-05-08 01:00:00','2023-06-13 15:05:53',21000),(2,16014,'2023-05-08 16:37:00','2023-05-31 12:21:57',22000),(3,16014,'2023-05-08 16:48:00','2023-06-07 13:38:26',29000),(6,16014,'2023-06-07 13:35:00','2023-06-07 13:38:42',7000),(7,16014,'2023-06-07 13:37:00','2023-06-14 11:18:05',7000),(9,14820,'2023-06-09 11:05:00','2023-06-16 14:26:27',7000);
/*!40000 ALTER TABLE `payment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `review`
--

DROP TABLE IF EXISTS `review`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `review` (
  `ISSNum` int NOT NULL,
  `IDBook` int NOT NULL,
  `Review_date` datetime DEFAULT NULL,
  `Review_context` longtext,
  `Review_star` int DEFAULT NULL,
  KEY `ISSNum_idx` (`ISSNum`),
  KEY `IDBook_idx` (`IDBook`),
  CONSTRAINT `IDBook` FOREIGN KEY (`IDBook`) REFERENCES `book` (`Book_ID`),
  CONSTRAINT `ISSNum` FOREIGN KEY (`ISSNum`) REFERENCES `user` (`ISSN`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `review`
--

LOCK TABLES `review` WRITE;
/*!40000 ALTER TABLE `review` DISABLE KEYS */;
INSERT INTO `review` VALUES (16014,1,'2023-05-08 16:37:00','đúng là hảo hán, anh nên lãnh đạo chúng tôi',5),(16014,3,'2023-05-17 23:15:00','khóc hết nước mắt rồi T-T',2),(16014,5,'2023-05-31 12:40:00','Đọc xong chả hiểu mẹ gì (o_O) ? ',2),(17096,4,'2023-05-31 12:42:54','sau khi đọc xong tôi đã giác ngộ được nhân sinh quan của thế giói',5),(16014,2,'2023-06-07 13:37:09','đọc được nửa cuốn thì bị chó cắn mất nửa còn lại nhưng mà hay',4),(14820,5,'2077-06-16 14:26:53','ôi bạn ơi đó là do bạn ngu đấy bạn. Cuốn này hay, rất thực tế',4),(16014,9,'2023-05-08 20:37:00','thư viện kiêu gì ko có mấy tập còn lại, lởm',1),(14820,8,'2023-07-08 21:40:00','Thư viện này ngáo à nhập có 1 cuốn trong séies vậy',1),(17096,1,'2023-09-08 22:37:00','đọc xong não to hẳn ra',5),(16014,1,'2023-05-09 10:37:00','Yennerfer cũng ngon đấy nhưng Tris Best girl',4);
/*!40000 ALTER TABLE `review` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `ISSN` int NOT NULL,
  `Name` varchar(45) NOT NULL,
  `Email` varchar(45) NOT NULL,
  `Address` longtext NOT NULL,
  `Phone` varchar(45) NOT NULL,
  `Pass` varchar(45) NOT NULL,
  `ACCESS_CONTROL` int NOT NULL DEFAULT '1',
  PRIMARY KEY (`ISSN`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (123,'admin','admin@student.vgu.edu.vn','VGU','9999','admin123',2),(14820,'Khoa Nguyen','khoa@student.vgu.edu.vn','VGU','9999','khoa123',1),(17096,'Khanh Nguyen','khanh@student.vgu.edu.vn','VGU','0969696969','khanh123',1),(16014,'Do Tran','Do@student.vgu.edu.vn','VGU','9999','do123',1),(17529,'Khai Huynh','Khai@student.vgu.edu.vn','VGU','0979836970','khai123',1),(17469,'Vinh Hoang','Vinh@student.vgu.edu.vn','VGU','00000','vinh123',1);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'pe2023'
--

--
-- Dumping routines for database 'pe2023'
--
/*!50003 DROP PROCEDURE IF EXISTS `AddBook` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `AddBook`(
	ID		INTEGER,
	Title    VARCHAR(45),
	Category_ID        INTEGER,
	Publication_year    INTEGER,
	Quantity			INTEGER(10)
)
BEGIN
	INSERT INTO book
				(Book_ID,
				 Title,
				 Category_ID,
				 Publication_year,
				 Quantity
				 )
	VALUES     ( ID,
				 Title,
				 Category_ID,
				 Publication_year,
				 Quantity
				 );
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetAllBooks` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetAllBooks`()
BEGIN
	SELECT *
	FROM   book order by Title, Publication_year;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetAllUsers` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetAllUsers`()
BEGIN
	SELECT *
	FROM   user order by Name, ISSN;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ISUDAuthor` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ISUDAuthor`(AuthorID     INTEGER,
                                          Authorfname	VARCHAR(45),
                                          Authorlname	VARCHAR(45),
                                          StatementType NVARCHAR(20) )
BEGIN
      IF StatementType = 'INSERT' 
      THEN
            INSERT INTO author
                        (Author_ID,
                        Author_fname,
                        Author_lname
                         )
            VALUES     (AuthorID,
						Authorfname,
                        Authorlname
                         );
		END IF;
        
		IF StatementType = 'SELECT' 
		THEN
            SELECT *
            FROM   author order by Author_fname;
		END IF;
        
        IF StatementType = 'SELECTAuthorID' 
     THEN
            SELECT distinct Author_ID
            FROM   author
            WHERE Author_fname = Authorfname AND Author_lname = Authorlname;
		END IF;
        
      IF StatementType = 'UPDATE' 
      THEN
      SET SQL_SAFE_UPDATES = 0;
            UPDATE author
            SET    Author_fname = Authorfname,
				   Author_lname = Authorlname
            WHERE  Author_ID = AuthorID;
        END IF;
        
      IF StatementType = 'DELETE' 
      THEN
      SET SQL_SAFE_UPDATES = 0;
		DELETE FROM author
		WHERE  Author_ID = AuthorID;
        END IF;
  END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ISUDBook` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ISUDBook`(BookID            INTEGER,
                                          Title    VARCHAR(45),
                                          Category_ID        INTEGER,
                                          Publication_year          INTEGER,
                                          Quantity					INTEGER,
                                          StatementType NVARCHAR(20) )
BEGIN
      IF StatementType = 'INSERT' 
      THEN
            INSERT INTO book
                        (Book_ID,
                         Title,
                         Category_ID,
                         Publication_year,
                         Quantity
                         )
            VALUES     (BookID,
                         Title,
                         Category_ID,
                         Publication_year,
                         Quantity
                         );
		END IF;
     
     IF StatementType = 'SELECT' 
     THEN
            SELECT *
            FROM   book order by Book_ID DESC;
		END IF;

      IF StatementType = 'UPDATE' 
      THEN
      SET SQL_SAFE_UPDATES = 0;
            UPDATE book
            SET    Title = Title,
                   Category_ID = Category_ID,
                   Publication_year = Publication_year,
                   Quantity = Quantity
            WHERE  Book_ID = BookID;
        END IF;
      IF StatementType = 'DELETE' 
      THEN
      SET SQL_SAFE_UPDATES = 0;
		DELETE FROM book
		WHERE  Book_ID = BookID;
        END IF;
  END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ISUDBook_Author` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ISUDBook_Author`(Book_ID            INTEGER,
                                          Author_ID     INTEGER,
                                          StatementType NVARCHAR(20) )
BEGIN
      IF StatementType = 'INSERT' 
      THEN
            INSERT INTO book_author
                        (BookID,
                         AuthorID
                         )
            VALUES     (Book_ID,
                         Author_ID
                         );
		END IF;
		IF StatementType = 'SELECT' 
		THEN
            SELECT *
            FROM   book_author order by BookID;
		END IF;
        
        IF StatementType = 'SELECTBA' 
		THEN
            SELECT *
            FROM   book_author 
            where BookID = Book_ID AND AuthorID = Author_ID;
		END IF;

      IF StatementType = 'UPDATE' 
      THEN
      SET SQL_SAFE_UPDATES = 0;
            UPDATE book_author
            SET    AuthorID = Author_ID
            WHERE  BookID = Book_ID;
        END IF;
      IF StatementType = 'DELETE' 
      THEN
      SET SQL_SAFE_UPDATES = 0;
		DELETE FROM book_author
		WHERE  BookID = Book_ID AND AuthorID = Author_ID;
        END IF;
  END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ISUDCategory` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ISUDCategory`(CategoryID int ,
															Categoryname varchar(45),
                                          StatementType NVARCHAR(20) )
BEGIN
      IF StatementType = 'INSERT' 
      THEN
            INSERT INTO category
                        (Category_ID,
						Category_name
                         )
            VALUES     (CategoryID,
						Categoryname
                         );
		END IF;
        
		IF StatementType = 'SELECT' 
		THEN
            SELECT *
            FROM   category order by Category_name;
		END IF;
        
      IF StatementType = 'UPDATE' 
      THEN
      SET SQL_SAFE_UPDATES = 0;
            UPDATE category
            SET    Category_name = Categoryname
            WHERE Category_ID = CategoryID;
        END IF;
      IF StatementType = 'DELETE' 
      THEN
      SET SQL_SAFE_UPDATES = 0;
		DELETE FROM category
		WHERE  Category_ID = CategoryID OR Category_name = Categoryname ;
        END IF;
  END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ISUDFine` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ISUDFine`(Session_ID     INTEGER,
                                          Finedays		INTEGER,
                                          Fineamount		INTEGER,
                                          StatementType NVARCHAR(20) )
BEGIN
      IF StatementType = 'INSERT' 
      THEN
            INSERT INTO fine
                        (SessionID,
						Fine_days,
						Fine_amount
                         )
            VALUES     (Session_ID,
						Finedays,
						Fineamount
                         );
		END IF;

      IF StatementType = 'UPDATE' 
      THEN
      SET SQL_SAFE_UPDATES = 0;
            UPDATE fine
            SET    Fine_days = Finedays,
					Fine_amount = Fineamount
            WHERE  SessionID = Session_ID;
        END IF;
        
		IF StatementType = 'SELECT' 
     THEN
            SELECT *
            FROM   fine;
		END IF;
        
      IF StatementType = 'DELETE' 
      THEN
      SET SQL_SAFE_UPDATES = 0;
		DELETE FROM fine
		WHERE  SessionID = Session_ID;
        END IF;
  END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ISUDLease` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ISUDLease`(Session_ID            INTEGER,
                                          BookID     INTEGER,
                                          ISSNum        INTEGER,
                                          Leasedate          datetime,
                                          Expirydate		datetime,
                                          report	varchar(45),
                                          StatementType NVARCHAR(20) )
BEGIN
      IF StatementType = 'INSERT' 
      THEN
            INSERT INTO lease
                        (SessionID,
						Book_ID ,
						ISSN,
						Lease_date,
						Expiry_date
						)
            VALUES     (Session_ID,
						BookID ,
						ISSNum,
						Leasedate,
						Expirydate
						);
		END IF;
     
     IF StatementType = 'SELECT' 
     THEN
            SELECT *
            FROM  lease order by Lease_date;
		END IF;

      IF StatementType = 'UPDATE' 
      THEN
      SET SQL_SAFE_UPDATES = 0;
            UPDATE lease
            SET    Book_ID = BookID,
					ISSN = ISSNum,
					Lease_date = Leasedate,
					Expiry_date = Expirydate,
                    Status = report
            WHERE  SessionID = Session_ID;
        END IF;
      IF StatementType = 'DELETE' 
      THEN
      SET SQL_SAFE_UPDATES = 0;
		DELETE FROM lease
		WHERE  SessionID = Session_ID;
        END IF;
  END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ISUDPayment` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ISUDPayment`(PaymentID int,
															CustomerID int,
															Leasedate datetime ,
															Paymentdate datetime ,
															Paymentamount int,
                                          StatementType NVARCHAR(20) )
BEGIN
	  
      IF StatementType = 'INSERT' 
      THEN
            INSERT INTO payment
                        (Payment_ID,
						Customer_ID,
						Lease_date  ,
						Payment_date  ,
						Payment_amount
                         )
            VALUES     (PaymentID,
						CustomerID,
						Leasedate  ,
						Paymentdate  ,
						Paymentamount
						);
		END IF;
     
     IF StatementType = 'SELECT' 
     THEN
            SELECT *
            FROM   payment;
		END IF;

      IF StatementType = 'UPDATE' 
      THEN
      SET SQL_SAFE_UPDATES = 0;
            UPDATE payment
            SET    Customer_ID = CustomerID,
					Lease_date = Leasedate ,
					Payment_date = Paymentdate ,
					Payment_amount = Paymentamount
            WHERE  Payment_ID = PaymentID;
        END IF;
      IF StatementType = 'DELETE' 
      THEN
      SET SQL_SAFE_UPDATES = 0;
		DELETE FROM payment
		WHERE  Payment_ID = PaymentID;
        END IF;
  END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ISUDReview` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ISUDReview`(ISSNumb int ,
														ID_Book int ,
														Reviewdate datetime ,
														Reviewcontext longtext ,
														Reviewstar int,
                                          StatementType NVARCHAR(20) )
BEGIN
      IF StatementType = 'INSERT' 
      THEN
            INSERT INTO review
                        (ISSNum ,
						IDBook  ,
						Review_date ,
						Review_context ,
						Review_star
                         )
            VALUES     (ISSNumb ,
						ID_Book  ,
						Reviewdate ,
						Reviewcontext ,
						Reviewstar
						);
		END IF;
     
     IF StatementType = 'SELECT' 
     THEN
            SELECT *
            FROM   review;
		END IF;

      IF StatementType = 'UPDATE' 
      THEN
      SET SQL_SAFE_UPDATES = 0;
            UPDATE review
            SET     Review_date = Reviewdate ,
					Review_context = Reviewcontext ,
					Review_star = Reviewstar
            WHERE  ISSNum = ISSNumb AND IDBook = ID_Book;
        END IF;
      IF StatementType = 'DELETE' 
      THEN
      SET SQL_SAFE_UPDATES = 0;
		DELETE FROM review
		WHERE  ISSNum = ISSNumb 
		AND 	IDBook = ID_Book;
        END IF;
  END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ISUDUser` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ISUDUser`(ISSN_cus int ,
														Name_cus varchar(45) ,
														Email_cus varchar(45) ,
														Address_cus longtext ,
														Phone_cus varchar(45),
                                                        PASS varchar(45),
                                          StatementType NVARCHAR(20) )
BEGIN
      IF StatementType = 'INSERT' 
      THEN
            INSERT INTO user
                        (ISSN,
						Name ,
						Email ,
						Address ,
						Phone,
                        Pass
                         )
            VALUES     (ISSN_cus,
						Name_cus ,
						Email_cus ,
						Address_cus ,
						Phone_cus,
                        PASS
                         );
		END IF;
     
     IF StatementType = 'SELECT' 
     THEN
            SELECT *
            FROM   user order by Name;
		END IF;

      IF StatementType = 'UPDATE' 
      THEN
      SET SQL_SAFE_UPDATES = 0;
            UPDATE user
            SET    Name = Name_cus,
					Email = Email_cus,
					Address = Address_cus,
					Phone = Phone_cus,
                    Pass = PASS
            WHERE  ISSN = ISSN_cus;
        END IF;
      IF StatementType = 'DELETE' 
      THEN
      SET SQL_SAFE_UPDATES = 0;
		DELETE FROM user
		WHERE  ISSN = ISSN_cus;
        END IF;
  END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `IUDAuthor` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `IUDAuthor`(AuthorID     INTEGER,
                                          Authorfname	VARCHAR(45),
                                          Authorlname	VARCHAR(45),
                                          StatementType NVARCHAR(20) )
BEGIN
      IF StatementType = 'INSERT' 
      THEN
            INSERT INTO author
                        (Author_ID,
                        Author_fname,
                        Author_lname
                         )
            VALUES     (AuthorID,
						Authorfname,
                        Authorlname
                         );
		END IF;

      IF StatementType = 'UPDATE' 
      THEN
      SET SQL_SAFE_UPDATES = 0;
            UPDATE author
            SET    Author_fname = Authorfname AND Author_lname =Authorlname
            WHERE  Author_ID = AuthorID;
        END IF;
        
      IF StatementType = 'DELETE' 
      THEN
      SET SQL_SAFE_UPDATES = 0;
		DELETE FROM author
		WHERE  Author_ID = AuthorID;
        END IF;
  END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `IUDBook_Author` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `IUDBook_Author`(Book_ID            INTEGER,
                                          Author_ID     INTEGER,
                                          StatementType NVARCHAR(20) )
BEGIN
      IF StatementType = 'INSERT' 
      THEN
            INSERT INTO book_author
                        (BookID,
                         AuthorID
                         )
            VALUES     (Book_ID,
                         Author_ID
                         );
		END IF;

      IF StatementType = 'UPDATE' 
      THEN
      SET SQL_SAFE_UPDATES = 0;
            UPDATE book_author
            SET    AuthorID = Author_ID
            WHERE  BookID = Book_ID;
        END IF;
      IF StatementType = 'DELETE' 
      THEN
      SET SQL_SAFE_UPDATES = 0;
		DELETE FROM book_author
		WHERE  BookID = Book_ID AND AuthorID = Author_ID;
        END IF;
  END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `IUDCategory` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `IUDCategory`(CategoryID int ,
															Categoryname varchar(45),
                                          StatementType NVARCHAR(20) )
BEGIN
      IF StatementType = 'INSERT' 
      THEN
            INSERT INTO category
                        (Category_ID,
						Category_name
                         )
            VALUES     (CategoryID,
						Categoryname
                         );
		END IF;

      IF StatementType = 'UPDATE' 
      THEN
      SET SQL_SAFE_UPDATES = 0;
            UPDATE category
            SET    Category_name = Categoryname
            WHERE Category_ID = CategoryID;
        END IF;
      IF StatementType = 'DELETE' 
      THEN
      SET SQL_SAFE_UPDATES = 0;
		DELETE FROM category
		WHERE  Category_ID = CategoryID OR Category_name = Categoryname ;
        END IF;
  END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-06-18 12:02:35
