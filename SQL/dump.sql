-- MySQL dump 10.13  Distrib 8.0.45, for Linux (x86_64)
--
-- Host: localhost    Database: marathon_db
-- ------------------------------------------------------
-- Server version	8.0.45-0ubuntu0.24.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `Category`
--

DROP TABLE IF EXISTS `Category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Category` (
  `category_id` int NOT NULL AUTO_INCREMENT,
  `age_group` varchar(20) NOT NULL,
  `gender` varchar(10) NOT NULL,
  PRIMARY KEY (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Category`
--

LOCK TABLES `Category` WRITE;
/*!40000 ALTER TABLE `Category` DISABLE KEYS */;
INSERT INTO `Category` VALUES (1,'18-29','Male'),(2,'18-29','Female'),(3,'30-39','Male'),(4,'30-39','Female');
/*!40000 ALTER TABLE `Category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Checkpoint`
--

DROP TABLE IF EXISTS `Checkpoint`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Checkpoint` (
  `checkpoint_id` int NOT NULL AUTO_INCREMENT,
  `marathon_id` int NOT NULL,
  `distance_km` decimal(5,2) NOT NULL,
  PRIMARY KEY (`checkpoint_id`),
  KEY `marathon_id` (`marathon_id`),
  CONSTRAINT `Checkpoint_ibfk_1` FOREIGN KEY (`marathon_id`) REFERENCES `Marathon` (`marathon_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Checkpoint`
--

LOCK TABLES `Checkpoint` WRITE;
/*!40000 ALTER TABLE `Checkpoint` DISABLE KEYS */;
INSERT INTO `Checkpoint` VALUES (1,1,5.00),(2,1,10.00),(3,1,21.10),(4,1,30.00),(5,1,42.20);
/*!40000 ALTER TABLE `Checkpoint` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Incident`
--

DROP TABLE IF EXISTS `Incident`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Incident` (
  `incident_id` int NOT NULL AUTO_INCREMENT,
  `runner_id` int NOT NULL,
  `marathon_id` int NOT NULL,
  `checkpoint_id` int DEFAULT NULL,
  `type` varchar(50) NOT NULL,
  `description` text,
  PRIMARY KEY (`incident_id`),
  KEY `runner_id` (`runner_id`),
  KEY `marathon_id` (`marathon_id`),
  KEY `checkpoint_id` (`checkpoint_id`),
  CONSTRAINT `Incident_ibfk_1` FOREIGN KEY (`runner_id`) REFERENCES `Runner` (`runner_id`),
  CONSTRAINT `Incident_ibfk_2` FOREIGN KEY (`marathon_id`) REFERENCES `Marathon` (`marathon_id`),
  CONSTRAINT `Incident_ibfk_3` FOREIGN KEY (`checkpoint_id`) REFERENCES `Checkpoint` (`checkpoint_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Incident`
--

LOCK TABLES `Incident` WRITE;
/*!40000 ALTER TABLE `Incident` DISABLE KEYS */;
INSERT INTO `Incident` VALUES (1,2,1,3,'dropout','Runner stopped due to exhaustion');
/*!40000 ALTER TABLE `Incident` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Marathon`
--

DROP TABLE IF EXISTS `Marathon`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Marathon` (
  `marathon_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `date` date NOT NULL,
  `location` varchar(100) DEFAULT NULL,
  `total_distance_km` decimal(5,2) NOT NULL,
  PRIMARY KEY (`marathon_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Marathon`
--

LOCK TABLES `Marathon` WRITE;
/*!40000 ALTER TABLE `Marathon` DISABLE KEYS */;
INSERT INTO `Marathon` VALUES (1,'Riyadh Marathon','2025-06-01','Riyadh',42.20);
/*!40000 ALTER TABLE `Marathon` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Runner`
--

DROP TABLE IF EXISTS `Runner`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Runner` (
  `runner_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `birth_year` int NOT NULL,
  `gender` varchar(10) NOT NULL,
  `category_id` int DEFAULT NULL,
  PRIMARY KEY (`runner_id`),
  KEY `category_id` (`category_id`),
  CONSTRAINT `Runner_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `Category` (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Runner`
--

LOCK TABLES `Runner` WRITE;
/*!40000 ALTER TABLE `Runner` DISABLE KEYS */;
INSERT INTO `Runner` VALUES (1,'Nader Salah',2002,'Male',1),(2,'Haifa Al Huthiily',1998,'Female',2),(3,'Aymen Idris',1987,'Male',3),(4,'Razan Ghuraibi',1992,'Female',4);
/*!40000 ALTER TABLE `Runner` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `RunnerCheckpoint`
--

DROP TABLE IF EXISTS `RunnerCheckpoint`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `RunnerCheckpoint` (
  `runner_id` int NOT NULL,
  `checkpoint_id` int NOT NULL,
  `time_seconds` int NOT NULL,
  `pace` decimal(5,2) DEFAULT NULL,
  PRIMARY KEY (`runner_id`,`checkpoint_id`),
  KEY `checkpoint_id` (`checkpoint_id`),
  CONSTRAINT `RunnerCheckpoint_ibfk_1` FOREIGN KEY (`runner_id`) REFERENCES `Runner` (`runner_id`),
  CONSTRAINT `RunnerCheckpoint_ibfk_2` FOREIGN KEY (`checkpoint_id`) REFERENCES `Checkpoint` (`checkpoint_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `RunnerCheckpoint`
--

LOCK TABLES `RunnerCheckpoint` WRITE;
/*!40000 ALTER TABLE `RunnerCheckpoint` DISABLE KEYS */;
INSERT INTO `RunnerCheckpoint` VALUES (1,1,1500,5.00),(1,2,3000,5.00),(1,3,6300,4.98),(1,4,9000,5.00),(2,1,1600,5.33),(2,2,3300,5.50),(2,3,7000,5.53);
/*!40000 ALTER TABLE `RunnerCheckpoint` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `before_insert_runnercheckpoint` BEFORE INSERT ON `RunnerCheckpoint` FOR EACH ROW BEGIN
    DECLARE checkpoint_distance DECIMAL(5,2);

    SELECT distance_km
    INTO checkpoint_distance
    FROM Checkpoint
    WHERE checkpoint_id = NEW.checkpoint_id;

    SET NEW.pace = NEW.time_seconds / 60 / checkpoint_distance;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Dumping routines for database 'marathon_db'
--
/*!50003 DROP FUNCTION IF EXISTS `get_runner_total_time` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `get_runner_total_time`(p_runner_id INT) RETURNS int
    DETERMINISTIC
BEGIN
    DECLARE total_time INT;

    SELECT MAX(rc.time_seconds)
    INTO total_time
    FROM RunnerCheckpoint rc
    WHERE rc.runner_id = p_runner_id;

    RETURN total_time;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetLeaderboard` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetLeaderboard`()
BEGIN
    SELECT
        r.runner_id,
        r.name,
        c.age_group,
        c.gender,
        MAX(rc.time_seconds) AS total_time_seconds
    FROM Runner r
    JOIN Category c ON r.category_id = c.category_id
    JOIN RunnerCheckpoint rc ON r.runner_id = rc.runner_id
    GROUP BY r.runner_id, r.name, c.age_group, c.gender
    ORDER BY total_time_seconds ASC;
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

-- Dump completed on 2026-04-28 15:56:57
