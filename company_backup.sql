-- MySQL dump 10.13  Distrib 8.0.45, for Linux (x86_64)
--
-- Host: localhost    Database: company
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
-- Table structure for table `department`
--

DROP TABLE IF EXISTS `department`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `department` (
  `dname` varchar(15) DEFAULT NULL,
  `dnumber` int NOT NULL,
  `mgr_ssn` char(9) DEFAULT NULL,
  `mgr_start_date` date DEFAULT NULL,
  PRIMARY KEY (`dnumber`),
  UNIQUE KEY `dname` (`dname`),
  KEY `fk_department` (`mgr_ssn`),
  CONSTRAINT `fk_department` FOREIGN KEY (`mgr_ssn`) REFERENCES `employee` (`ssn`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `department`
--

LOCK TABLES `department` WRITE;
/*!40000 ALTER TABLE `department` DISABLE KEYS */;
INSERT INTO `department` VALUES ('Headquarters',1,'888665555','1981-06-19'),('Administration',4,'987654321','1995-01-01'),('Research',5,'333445555','1988-05-22'),('TI',7,'123456759','2026-03-09'),('Financeiro',10,NULL,NULL);
/*!40000 ALTER TABLE `department` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dependent`
--

DROP TABLE IF EXISTS `dependent`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dependent` (
  `essn` char(9) NOT NULL,
  `dependent_name` varchar(15) NOT NULL,
  `sex` char(1) DEFAULT NULL,
  `bdate` date DEFAULT NULL,
  `relationship` varchar(8) DEFAULT NULL,
  PRIMARY KEY (`essn`,`dependent_name`),
  CONSTRAINT `dependent_ibfk_1` FOREIGN KEY (`essn`) REFERENCES `employee` (`ssn`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dependent`
--

LOCK TABLES `dependent` WRITE;
/*!40000 ALTER TABLE `dependent` DISABLE KEYS */;
INSERT INTO `dependent` VALUES ('123456789','Alice','F','1988-12-30','Daughter'),('123456789','Elizabeth','F','1967-05-05','Spouse'),('123456789','Michael','M','1988-01-04','Son'),('333445555','Alice','F','1986-04-05','Daughter'),('333445555','Joy','F','1958-05-03','Spouse'),('333445555','Theodore','M','1983-10-25','Son'),('987654321','Abner','M','1942-02-28','Spouse');
/*!40000 ALTER TABLE `dependent` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dept_locations`
--

DROP TABLE IF EXISTS `dept_locations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dept_locations` (
  `dnumber` int NOT NULL,
  `dlocation` varchar(15) NOT NULL,
  PRIMARY KEY (`dnumber`,`dlocation`),
  KEY `idx_dept_locations_dnumber` (`dnumber`),
  KEY `idx_dept_locations_location` (`dlocation`),
  CONSTRAINT `dept_locations_ibfk_1` FOREIGN KEY (`dnumber`) REFERENCES `department` (`dnumber`),
  CONSTRAINT `fk_dept_locations` FOREIGN KEY (`dnumber`) REFERENCES `department` (`dnumber`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dept_locations`
--

LOCK TABLES `dept_locations` WRITE;
/*!40000 ALTER TABLE `dept_locations` DISABLE KEYS */;
INSERT INTO `dept_locations` VALUES (1,'Houston'),(4,'Stafford'),(5,'Bellaire'),(5,'Houston'),(5,'Sugarland');
/*!40000 ALTER TABLE `dept_locations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employee`
--

DROP TABLE IF EXISTS `employee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `employee` (
  `fname` varchar(15) NOT NULL,
  `minit` char(1) DEFAULT NULL,
  `lname` varchar(15) NOT NULL,
  `ssn` char(9) NOT NULL,
  `bdate` date DEFAULT NULL,
  `address` varchar(30) DEFAULT NULL,
  `sex` char(1) DEFAULT NULL,
  `salary` decimal(10,2) DEFAULT NULL,
  `super_ssn` char(9) DEFAULT NULL,
  `dno` int NOT NULL,
  PRIMARY KEY (`ssn`),
  KEY `idx_employee_dno` (`dno`),
  CONSTRAINT `chk_salary_employee` CHECK ((`salary` > 2000.0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employee`
--

LOCK TABLES `employee` WRITE;
/*!40000 ALTER TABLE `employee` DISABLE KEYS */;
INSERT INTO `employee` VALUES ('João','B','Good','123456759','1965-01-09','731-Fondren-Houston-TX','M',50000.00,'987654321',5),('Fulana','B','Good','123456769','1965-01-09',NULL,'M',30000.00,'987654321',5),('Fulana','B','Good','123456779','1965-01-09',NULL,'M',30000.00,'987654321',5),('Jhon','B','Good','123456789','1965-01-09','731-Fondren-Houston-TX','M',30000.00,'333445555',5),('Maria','B','Smith','123456824','1965-08-10','731-Fondren-Houston-TX','F',35000.00,'888665555',5),('Franklin','T','Wong','333445555','1955-12-08','638 Voss, Houston, TX','M',52000.00,'888665555',5),('Joyce','A','English','453453453','1972-07-31','5631 Rice, Houston, TX','F',25000.00,'333445555',5),('Ramesh','K','Narayan','666884444','1962-09-15','975 Fire Oak, Humble, TX','M',38000.00,'333445555',5),('Cládio','B','Texeira','824456123','1965-07-15','731-Fondren-Houston-TX','M',40000.00,'123456789',4),('James','E','Borg','888665555','1937-11-10','450 Stone, Houston, TX','M',55000.00,NULL,7),('Caruzzo','F','Smith','987654321','1965-03-07','731-Fondren-Houston-TX','M',30000.00,'888665555',7),('Ahmad','V','Jabbar','987987987','1969-03-29','980 Dallas, Houston, TX','M',25000.00,'987654321',4),('Alicia','J','Zelaya','999887777','1968-01-19','3321 Castle, Spring, TX','F',25000.00,'987654321',4);
/*!40000 ALTER TABLE `employee` ENABLE KEYS */;
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `superssn_check` BEFORE INSERT ON `employee` FOR EACH ROW BEGIN
    CASE NEW.dno
        WHEN 1 THEN SET NEW.super_ssn = '333445555';
        WHEN 2 THEN SET NEW.super_ssn = NULL;
        WHEN 3 THEN SET NEW.super_ssn = NULL;
        WHEN 4 THEN SET NEW.super_ssn = '123456789';
        WHEN 5 THEN SET NEW.super_ssn = '987654321';
    END CASE;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `null_value_check` AFTER INSERT ON `employee` FOR EACH ROW BEGIN
    IF NEW.address IS NULL THEN
        INSERT INTO user_msg (message, ssn)
        VALUES ('Update your address, please!', NEW.ssn);
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `salary_update_log` BEFORE UPDATE ON `employee` FOR EACH ROW BEGIN
    IF OLD.salary <> NEW.salary THEN
        INSERT INTO salary_log (ssn, old_salary, new_salary)
        VALUES (OLD.ssn, OLD.salary, NEW.salary);
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_before_update_salary` BEFORE UPDATE ON `employee` FOR EACH ROW BEGIN
    IF OLD.salary <> NEW.salary THEN
        INSERT INTO salary_update_log (ssn, salario_antigo, salario_novo)
        VALUES (OLD.ssn, OLD.salary, NEW.salary);
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_before_delete_employee` BEFORE DELETE ON `employee` FOR EACH ROW BEGIN
    INSERT INTO employee_deleted_log (ssn, fname, lname)
    VALUES (OLD.ssn, OLD.fname, OLD.lname);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `employee_deleted_log`
--

DROP TABLE IF EXISTS `employee_deleted_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `employee_deleted_log` (
  `ssn` char(9) DEFAULT NULL,
  `fname` varchar(50) DEFAULT NULL,
  `lname` varchar(50) DEFAULT NULL,
  `deleted_at` datetime DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employee_deleted_log`
--

LOCK TABLES `employee_deleted_log` WRITE;
/*!40000 ALTER TABLE `employee_deleted_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `employee_deleted_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `employee_dp`
--

DROP TABLE IF EXISTS `employee_dp`;
/*!50001 DROP VIEW IF EXISTS `employee_dp`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `employee_dp` AS SELECT 
 1 AS `nome`,
 1 AS `numero departamento`,
 1 AS `departamento`,
 1 AS `projeto`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `employees_salary_2700_view`
--

DROP TABLE IF EXISTS `employees_salary_2700_view`;
/*!50001 DROP VIEW IF EXISTS `employees_salary_2700_view`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `employees_salary_2700_view` AS SELECT 
 1 AS `nome`,
 1 AS `salario`,
 1 AS `numero departamento`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `project`
--

DROP TABLE IF EXISTS `project`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `project` (
  `pname` varchar(15) NOT NULL,
  `pnumber` int NOT NULL,
  `plocation` varchar(15) DEFAULT NULL,
  `dnum` int NOT NULL,
  PRIMARY KEY (`pnumber`),
  UNIQUE KEY `pname` (`pname`),
  KEY `dnumber` (`dnum`),
  CONSTRAINT `project_ibfk_1` FOREIGN KEY (`dnum`) REFERENCES `department` (`dnumber`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project`
--

LOCK TABLES `project` WRITE;
/*!40000 ALTER TABLE `project` DISABLE KEYS */;
INSERT INTO `project` VALUES ('ProductX',1,'Bellaire',5),('ProductY',2,'Sugarland',5),('ProductZ',3,'Houston',5),('Computerization',10,'Stafford',4),('Reorganization',20,'Houston',1),('Newbenefits',30,'Stafford',4);
/*!40000 ALTER TABLE `project` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `salary_log`
--

DROP TABLE IF EXISTS `salary_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `salary_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `ssn` char(9) DEFAULT NULL,
  `old_salary` decimal(10,2) DEFAULT NULL,
  `new_salary` decimal(10,2) DEFAULT NULL,
  `changed_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `salary_log`
--

LOCK TABLES `salary_log` WRITE;
/*!40000 ALTER TABLE `salary_log` DISABLE KEYS */;
INSERT INTO `salary_log` VALUES (1,'123456759',30000.00,32000.00,'2026-02-13 13:20:21'),(2,'123456759',30000.00,32000.00,'2026-02-13 13:29:05'),(3,'333445555',40000.00,32000.00,'2026-02-13 13:30:04'),(4,'333445555',32000.00,52000.00,'2026-02-13 13:30:31'),(5,'123456759',32000.00,37000.00,'2026-03-09 15:27:05'),(6,'123456759',37000.00,50000.00,'2026-03-09 15:52:41');
/*!40000 ALTER TABLE `salary_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `salary_update_log`
--

DROP TABLE IF EXISTS `salary_update_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `salary_update_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `ssn` char(9) DEFAULT NULL,
  `salario_antigo` decimal(10,2) DEFAULT NULL,
  `salario_novo` decimal(10,2) DEFAULT NULL,
  `data_alteracao` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `salary_update_log`
--

LOCK TABLES `salary_update_log` WRITE;
/*!40000 ALTER TABLE `salary_update_log` DISABLE KEYS */;
INSERT INTO `salary_update_log` VALUES (1,'123456759',32000.00,37000.00,'2026-03-09 15:27:05'),(2,'123456759',37000.00,50000.00,'2026-03-09 15:52:41');
/*!40000 ALTER TABLE `salary_update_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_msg`
--

DROP TABLE IF EXISTS `user_msg`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_msg` (
  `id` int NOT NULL AUTO_INCREMENT,
  `message` varchar(100) DEFAULT NULL,
  `ssn` char(9) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_ssn_msg` (`ssn`),
  CONSTRAINT `fk_ssn_msg` FOREIGN KEY (`ssn`) REFERENCES `employee` (`ssn`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_msg`
--

LOCK TABLES `user_msg` WRITE;
/*!40000 ALTER TABLE `user_msg` DISABLE KEYS */;
INSERT INTO `user_msg` VALUES (1,'Update your address, please!','123456779');
/*!40000 ALTER TABLE `user_msg` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `vw_departamentos_gerentes`
--

DROP TABLE IF EXISTS `vw_departamentos_gerentes`;
/*!50001 DROP VIEW IF EXISTS `vw_departamentos_gerentes`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_departamentos_gerentes` AS SELECT 
 1 AS `departamento`,
 1 AS `gerente`,
 1 AS `inicio_gerencia`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_empregados_dependentes_gerentes`
--

DROP TABLE IF EXISTS `vw_empregados_dependentes_gerentes`;
/*!50001 DROP VIEW IF EXISTS `vw_empregados_dependentes_gerentes`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_empregados_dependentes_gerentes` AS SELECT 
 1 AS `empregado`,
 1 AS `total_dependentes`,
 1 AS `eh_gerente`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_empregados_por_departamento_localidade`
--

DROP TABLE IF EXISTS `vw_empregados_por_departamento_localidade`;
/*!50001 DROP VIEW IF EXISTS `vw_empregados_por_departamento_localidade`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_empregados_por_departamento_localidade` AS SELECT 
 1 AS `departamento`,
 1 AS `localidade`,
 1 AS `total_empregados`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_projetos_departamentos_gerentes`
--

DROP TABLE IF EXISTS `vw_projetos_departamentos_gerentes`;
/*!50001 DROP VIEW IF EXISTS `vw_projetos_departamentos_gerentes`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_projetos_departamentos_gerentes` AS SELECT 
 1 AS `projeto`,
 1 AS `departamento`,
 1 AS `gerente`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_projetos_maior_num_empregados`
--

DROP TABLE IF EXISTS `vw_projetos_maior_num_empregados`;
/*!50001 DROP VIEW IF EXISTS `vw_projetos_maior_num_empregados`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_projetos_maior_num_empregados` AS SELECT 
 1 AS `projeto`,
 1 AS `total_empregados`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `works_on`
--

DROP TABLE IF EXISTS `works_on`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `works_on` (
  `essn` char(9) NOT NULL,
  `pno` int NOT NULL,
  `hours` decimal(3,1) DEFAULT NULL,
  PRIMARY KEY (`essn`,`pno`),
  KEY `pno` (`pno`),
  CONSTRAINT `works_on_ibfk_1` FOREIGN KEY (`essn`) REFERENCES `employee` (`ssn`),
  CONSTRAINT `works_on_ibfk_2` FOREIGN KEY (`pno`) REFERENCES `project` (`pnumber`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `works_on`
--

LOCK TABLES `works_on` WRITE;
/*!40000 ALTER TABLE `works_on` DISABLE KEYS */;
INSERT INTO `works_on` VALUES ('123456789',1,32.5),('123456789',2,7.5),('333445555',2,10.0),('333445555',3,10.0),('333445555',10,10.0),('333445555',20,10.0),('453453453',1,20.0),('453453453',2,20.0),('666884444',3,40.0),('888665555',20,NULL),('987654321',20,15.0),('987654321',30,20.0),('987987987',10,35.0),('987987987',30,5.0),('999887777',10,10.0),('999887777',30,30.0);
/*!40000 ALTER TABLE `works_on` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Final view structure for view `employee_dp`
--

/*!50001 DROP VIEW IF EXISTS `employee_dp`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `employee_dp` AS select concat(`e`.`fname`,' ',`e`.`minit`,' ',`e`.`lname`) AS `nome`,`e`.`dno` AS `numero departamento`,`d`.`dname` AS `departamento`,`p`.`pname` AS `projeto` from ((`employee` `e` join `department` `d` on((`d`.`dnumber` = `e`.`dno`))) left join `project` `p` on((`p`.`dnum` = `d`.`dnumber`))) order by concat(`e`.`fname`,' ',`e`.`minit`,' ',`e`.`lname`) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `employees_salary_2700_view`
--

/*!50001 DROP VIEW IF EXISTS `employees_salary_2700_view`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `employees_salary_2700_view` AS select concat(`employee`.`fname`,' ',`employee`.`minit`,' ',`employee`.`lname`) AS `nome`,`employee`.`salary` AS `salario`,`employee`.`dno` AS `numero departamento` from `employee` where (`employee`.`sex` = 'M') */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_departamentos_gerentes`
--

/*!50001 DROP VIEW IF EXISTS `vw_departamentos_gerentes`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_departamentos_gerentes` AS select `d`.`dname` AS `departamento`,concat(`e`.`fname`,' ',`e`.`lname`) AS `gerente`,`d`.`mgr_start_date` AS `inicio_gerencia` from (`department` `d` left join `employee` `e` on((`d`.`mgr_ssn` = `e`.`ssn`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_empregados_dependentes_gerentes`
--

/*!50001 DROP VIEW IF EXISTS `vw_empregados_dependentes_gerentes`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_empregados_dependentes_gerentes` AS select concat(`e`.`fname`,' ',`e`.`lname`) AS `empregado`,count(`dep`.`dependent_name`) AS `total_dependentes`,(case when `e`.`ssn` in (select `department`.`mgr_ssn` from `department`) then 'Sim' else 'Não' end) AS `eh_gerente` from (`employee` `e` left join `dependent` `dep` on((`e`.`ssn` = `dep`.`essn`))) group by `e`.`ssn` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_empregados_por_departamento_localidade`
--

/*!50001 DROP VIEW IF EXISTS `vw_empregados_por_departamento_localidade`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_empregados_por_departamento_localidade` AS select `d`.`dname` AS `departamento`,`dl`.`dlocation` AS `localidade`,count(`e`.`ssn`) AS `total_empregados` from ((`department` `d` join `dept_locations` `dl` on((`d`.`dnumber` = `dl`.`dnumber`))) left join `employee` `e` on((`e`.`dno` = `d`.`dnumber`))) group by `d`.`dname`,`dl`.`dlocation` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_projetos_departamentos_gerentes`
--

/*!50001 DROP VIEW IF EXISTS `vw_projetos_departamentos_gerentes`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_projetos_departamentos_gerentes` AS select `p`.`pname` AS `projeto`,`d`.`dname` AS `departamento`,concat(`e`.`fname`,' ',`e`.`lname`) AS `gerente` from ((`project` `p` join `department` `d` on((`p`.`dnum` = `d`.`dnumber`))) left join `employee` `e` on((`d`.`mgr_ssn` = `e`.`ssn`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_projetos_maior_num_empregados`
--

/*!50001 DROP VIEW IF EXISTS `vw_projetos_maior_num_empregados`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_projetos_maior_num_empregados` AS select `p`.`pname` AS `projeto`,count(`w`.`essn`) AS `total_empregados` from (`project` `p` left join `works_on` `w` on((`p`.`pnumber` = `w`.`pno`))) group by `p`.`pname` order by `total_empregados` desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-03-09 16:38:18
