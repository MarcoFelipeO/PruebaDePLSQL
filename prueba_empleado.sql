-- MySQL dump 10.13  Distrib 8.0.38, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: prueba
-- ------------------------------------------------------
-- Server version	8.0.38

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
-- Table structure for table `empleado`
--

DROP TABLE IF EXISTS `empleado`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `empleado` (
  `id_empl` bigint NOT NULL,
  `nombres` varchar(255) DEFAULT NULL,
  `apellidos` varchar(255) DEFAULT NULL,
  `id_cargo` bigint DEFAULT NULL,
  `salario` bigint DEFAULT NULL,
  `fecha_contratacion` date DEFAULT NULL,
  `id_jefatura` bigint DEFAULT NULL,
  `id_depart` bigint DEFAULT NULL,
  PRIMARY KEY (`id_empl`),
  KEY `id_depart` (`id_depart`),
  CONSTRAINT `empleado_ibfk_1` FOREIGN KEY (`id_depart`) REFERENCES `departamento` (`id_depart`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `empleado`
--

LOCK TABLES `empleado` WRITE;
/*!40000 ALTER TABLE `empleado` DISABLE KEYS */;
INSERT INTO `empleado` VALUES (1,'Juan','Perez',2,858,'2023-01-15',1,1),(2,'Marco','Orellana',1,1580,'2023-01-20',3,2),(3,'Felipe','Santos',1,1300,'2022-01-20',1,1),(4,'Anna','White',2,800,'2021-01-20',2,2),(5,'John','Doe',1,4500,'2020-05-15',1,3),(6,'Jane','Smith',3,3500,'2019-03-10',1,1),(7,'Mike','Brown',2,6000,'2018-07-22',3,2),(8,'Lisa','Taylor',4,4200,'2021-09-12',NULL,2),(9,'Tom','Harris',1,5000,'2017-11-25',2,1),(10,'Emma','Wilson',3,3800,'2020-12-01',3,2),(11,'James','Davis',2,7000,'2016-08-17',4,3),(12,'Olivia','Martin',1,3200,'2019-01-09',2,3),(13,'William','Garcia',4,8000,'2021-02-14',4,2),(14,'Sophia','Martinez',3,5500,'2018-10-05',NULL,1),(15,'Alexander','Rodriguez',2,6300,'2017-07-19',3,3);
/*!40000 ALTER TABLE `empleado` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-07-20 15:16:48
