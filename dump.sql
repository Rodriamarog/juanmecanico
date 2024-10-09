CREATE DATABASE  IF NOT EXISTS `juanmecanico` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `juanmecanico`;
-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: localhost    Database: juanmecanico
-- ------------------------------------------------------
-- Server version	8.0.36

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
-- Table structure for table `asignacion`
--

DROP TABLE IF EXISTS `asignacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `asignacion` (
  `ID_Asignacion` varchar(6) NOT NULL,
  `ID_Empleado` varchar(6) DEFAULT NULL,
  `ID_Servicio` varchar(6) DEFAULT NULL,
  `ID_Orden_Trabajo` varchar(6) DEFAULT NULL,
  `ID_Parte` varchar(6) DEFAULT NULL,
  `Fecha_Inicio` date DEFAULT NULL,
  `Fecha_Fin` date DEFAULT NULL,
  PRIMARY KEY (`ID_Asignacion`),
  KEY `ID_Empleado` (`ID_Empleado`),
  KEY `ID_Servicio` (`ID_Servicio`),
  KEY `ID_Orden_Trabajo` (`ID_Orden_Trabajo`),
  KEY `ID_Parte` (`ID_Parte`),
  CONSTRAINT `asignacion_ibfk_1` FOREIGN KEY (`ID_Empleado`) REFERENCES `empleado` (`ID_Empleado`),
  CONSTRAINT `asignacion_ibfk_2` FOREIGN KEY (`ID_Servicio`) REFERENCES `servicio` (`ID_Servicio`),
  CONSTRAINT `asignacion_ibfk_3` FOREIGN KEY (`ID_Orden_Trabajo`) REFERENCES `orden_trabajo` (`ID_Orden_Trabajo`),
  CONSTRAINT `asignacion_ibfk_4` FOREIGN KEY (`ID_Parte`) REFERENCES `parte` (`ID_Parte`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `asignacion`
--

LOCK TABLES `asignacion` WRITE;
/*!40000 ALTER TABLE `asignacion` DISABLE KEYS */;
INSERT INTO `asignacion` VALUES ('AS0001','EM0001','SR0001','OT0014','PT0002','2023-04-01','2023-04-03'),('AS0002','EM0004','SR0001','OT0015',NULL,'2023-04-02','2023-04-04'),('AS0003','EM0007','SR0004','OT0020','PT0001','2023-04-03','2023-04-05'),('AS0004','EM0010','SR0003','OT0003','PT0003','2023-04-04','2023-04-06'),('AS0005','EM0011','SR0002','OT0001','PT0004','2023-04-05','2023-04-07'),('AS0006','EM0003','SR0005','OT0010','PT0005','2023-04-06','2023-04-08'),('AS0007','EM0005','SR0006','OT0013',NULL,'2023-04-07','2023-04-09'),('AS0008','EM0004','SR0007','OT0001','PT0006','2023-04-08','2023-04-10'),('AS0009','EM0007','SR0008','OT0004','PT0007','2023-04-09','2023-04-11'),('AS0010','EM0009','SR0009','OT0008','PT0008','2023-04-10','2023-04-12'),('AS0011','EM0004','SR0010','OT0012',NULL,'2023-04-11','2023-04-13'),('AS0012','EM0012','SR0011','OT0002','PT0009','2023-04-12','2023-04-14'),('AS0013','EM0013','SR0012','OT0006','PT0010','2023-04-13','2023-04-15'),('AS0014','EM0014','SR0013','OT0009',NULL,'2023-04-14','2023-04-16'),('AS0015','EM0010','SR0014','OT0011','PT0011','2023-04-15','2023-04-17'),('AS0016','EM0016','SR0015','OT0014','PT0012','2023-04-16','2023-04-18'),('AS0017','EM0017','SR0016','OT0016','PT0013','2023-04-17','2023-04-19'),('AS0018','EM0004','SR0017','OT0001','PT0014','2023-04-18','2023-04-20'),('AS0019','EM0019','SR0018','OT0018','PT0015','2023-04-19','2023-04-21'),('AS0020','EM0020','SR0019','OT0003','PT0016','2023-04-20','2023-04-22');
/*!40000 ALTER TABLE `asignacion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `automovil`
--

DROP TABLE IF EXISTS `automovil`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `automovil` (
  `ID_Automovil` varchar(6) NOT NULL,
  `Marca` varchar(50) DEFAULT NULL,
  `Modelo` varchar(50) DEFAULT NULL,
  `Anio` int DEFAULT NULL,
  `Vin` varchar(50) DEFAULT NULL,
  `ID_Cliente` varchar(6) DEFAULT NULL,
  PRIMARY KEY (`ID_Automovil`),
  KEY `ID_Cliente` (`ID_Cliente`),
  CONSTRAINT `automovil_ibfk_1` FOREIGN KEY (`ID_Cliente`) REFERENCES `cliente` (`ID_Cliente`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `automovil`
--

LOCK TABLES `automovil` WRITE;
/*!40000 ALTER TABLE `automovil` DISABLE KEYS */;
INSERT INTO `automovil` VALUES ('AU0001','Toyota','Corolla',2018,'JT2BF22K6W0215387','CL0001'),('AU0002','Honda','Civic',2019,'2HGFC2F53KH572851','CL0002'),('AU0003','Ford','Mustang',2017,'1FA6P8TH2H5247896','CL0003'),('AU0004','Chevrolet','Camaro',2020,'1G1FF1R35L0117749','CL0004'),('AU0005','Nissan','Sentra',2016,'3N1AB7AP2GL665278','CL0005'),('AU0006','BMW','X5',2021,'5UXCR6C55M9D34511','CL0006'),('AU0007','Audi','A4',2015,'WAUGFAFC2FN014986','CL0007'),('AU0008','Mercedes-Benz','C-Class',2014,'WDDGF8AB2EA940265','CL0008'),('AU0009','Volkswagen','Jetta',2013,'3VWD17AJ4DM388460','CL0009'),('AU0010','Mazda','CX-5',2022,'JM3KFBCM7N0952864','CL0010'),('AU0011','Kia','Sportage',2017,'KNDPM3AC7J7444509','CL0001'),('AU0012','Hyundai','Elantra',2018,'KMHD74LF9JU622537','CL0002'),('AU0013','Subaru','Outback',2020,'4S4BTAMC8L3232470','CL0003'),('AU0014','Jeep','Wrangler',2019,'1C4HJXDG8KW564602','CL0004'),('AU0015','Lexus','RX',2016,'2T2BZMCA2GC076337','CL0005'),('AU0016','Acura','TLX',2021,'19UUB3F73MA004352','CL0006'),('AU0017','Infiniti','Q50',2015,'JN1EV7AR7FM430872','CL0007'),('AU0018','Buick','Enclave',2014,'5GAKRBKD1EJ270367','CL0008'),('AU0019','Cadillac','Escalade',2022,'1GYS4CKJ5NR400745','CL0009'),('AU0020','GMC','Yukon',2013,'1GKS1CE04DR228369','CL0010');
/*!40000 ALTER TABLE `automovil` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cliente`
--

DROP TABLE IF EXISTS `cliente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cliente` (
  `ID_Cliente` varchar(6) NOT NULL,
  `Nombre` varchar(100) DEFAULT NULL,
  `Recurrencia` tinyint(1) DEFAULT NULL,
  `Telefono` varchar(20) DEFAULT NULL,
  `Correo_Electronico` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`ID_Cliente`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cliente`
--

LOCK TABLES `cliente` WRITE;
/*!40000 ALTER TABLE `cliente` DISABLE KEYS */;
INSERT INTO `cliente` VALUES ('CL0001','Juan Pérez',1,'555-1234','juan.perez@email.com'),('CL0002','María García',0,'555-5678','maria.garcia@email.com'),('CL0003','Pedro Rodríguez',1,'555-9012','pedro.rodriguez@email.com'),('CL0004','Ana Martínez',0,'555-3456','ana.martinez@email.com'),('CL0005','Luis Hernández',1,'555-7890','luis.hernandez@email.com'),('CL0006','Marta Gómez',1,'555-2345','marta.gomez@email.com'),('CL0007','Carlos Sánchez',0,'555-6789','carlos.sanchez@email.com'),('CL0008','Laura Torres',1,'555-0123','laura.torres@email.com'),('CL0009','Jorge Díaz',0,'555-4567','jorge.diaz@email.com'),('CL0010','Sofía Ruiz',1,'555-8901','sofia.ruiz@email.com'),('CL0011','Miguel Castro',1,'555-2345','miguel.castro@email.com'),('CL0012','Carmen Flores',0,'555-6789','carmen.flores@email.com'),('CL0013','Ricardo Ortega',1,'555-0123','ricardo.ortega@email.com'),('CL0014','Isabel Vargas',0,'555-4567','isabel.vargas@email.com'),('CL0015','Javier Morales',1,'555-8901','javier.morales@email.com'),('CL0016','Lucía Jiménez',1,'555-2345','lucia.jimenez@email.com'),('CL0017','Fernando Gutiérrez',0,'555-6789','fernando.gutierrez@email.com'),('CL0018','Gabriela Navarro',1,'555-0123','gabriela.navarro@email.com'),('CL0019','Diego Romero',0,'555-4567','diego.romero@email.com'),('CL0020','Valentina Herrera',1,'555-8901','valentina.herrera@email.com');
/*!40000 ALTER TABLE `cliente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `departamento`
--

DROP TABLE IF EXISTS `departamento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `departamento` (
  `ID_Departamento` varchar(6) NOT NULL,
  `Nombre` varchar(100) DEFAULT NULL,
  `Supervisor` varchar(6) DEFAULT NULL,
  PRIMARY KEY (`ID_Departamento`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `departamento`
--

LOCK TABLES `departamento` WRITE;
/*!40000 ALTER TABLE `departamento` DISABLE KEYS */;
INSERT INTO `departamento` VALUES ('DP0001','Carrocería y pintura','EM0002'),('DP0002','Eléctrico','EM0006'),('DP0003','Alineación y Balanceo, suspensión','EM0012'),('DP0004','Mecánico','EM0018'),('DP0005','Refaccionaria','EM0020');
/*!40000 ALTER TABLE `departamento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `diagnostico`
--

DROP TABLE IF EXISTS `diagnostico`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `diagnostico` (
  `ID_Diagnostico` varchar(6) NOT NULL,
  `Fecha` date DEFAULT NULL,
  `Notas` text,
  `ID_Empleado` varchar(6) DEFAULT NULL,
  `ID_Automovil` varchar(6) DEFAULT NULL,
  `ID_Cliente` varchar(6) DEFAULT NULL,
  `ID_Orden_Trabajo` varchar(6) DEFAULT NULL,
  `ID_Venta` varchar(6) DEFAULT NULL,
  PRIMARY KEY (`ID_Diagnostico`),
  KEY `ID_Empleado` (`ID_Empleado`),
  KEY `ID_Automovil` (`ID_Automovil`),
  KEY `ID_Cliente` (`ID_Cliente`),
  KEY `ID_Orden_Trabajo` (`ID_Orden_Trabajo`),
  KEY `ID_Venta` (`ID_Venta`),
  CONSTRAINT `diagnostico_ibfk_1` FOREIGN KEY (`ID_Empleado`) REFERENCES `empleado` (`ID_Empleado`),
  CONSTRAINT `diagnostico_ibfk_2` FOREIGN KEY (`ID_Automovil`) REFERENCES `automovil` (`ID_Automovil`),
  CONSTRAINT `diagnostico_ibfk_3` FOREIGN KEY (`ID_Cliente`) REFERENCES `cliente` (`ID_Cliente`),
  CONSTRAINT `diagnostico_ibfk_4` FOREIGN KEY (`ID_Orden_Trabajo`) REFERENCES `orden_trabajo` (`ID_Orden_Trabajo`),
  CONSTRAINT `diagnostico_ibfk_5` FOREIGN KEY (`ID_Venta`) REFERENCES `ventas` (`ID_Venta`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `diagnostico`
--

LOCK TABLES `diagnostico` WRITE;
/*!40000 ALTER TABLE `diagnostico` DISABLE KEYS */;
INSERT INTO `diagnostico` VALUES ('DI001','2023-04-01','Revisión general','EM0001','AU0001','CL0001','OT0001','1'),('DI002','2023-04-02','Cambio de aceite necesario','EM0002','AU0002','CL0002','OT0002','2'),('DI003','2023-04-03','Revisión de frenos','EM0003','AU0003','CL0003','OT0003','3'),('DI004','2023-04-04','Problema con el sistema eléctrico','EM0004','AU0004','CL0004','OT0004','2'),('DI005','2023-04-05','Inspección de suspensión','EM0005','AU0005','CL0005','OT0005','5'),('DI006','2023-04-06','Verificar niveles de líquidos','EM0006','AU0006','CL0006','OT0006','6'),('DI007','2023-04-07','Ruido en el motor','EM0007','AU0007','CL0007','OT0007','10'),('DI008','2023-04-08','Alineación necesaria','EM0008','AU0008','CL0008','OT0008','8'),('DI009','2023-04-09','Problemas con la calefacción','EM0009','AU0009','CL0009','OT0009','9'),('DI010','2024-04-10','Revisar sistema de escape','EM0010','AU0010','CL0010','OT0010','10'),('DI011','2023-04-11','Mantenimiento de la transmisión','EM0011','AU0011','CL0011','OT0011','11'),('DI012','2025-04-12','Error en el sistema de navegación','EM0012','AU0012','CL0012','OT0012','12'),('DI013','2023-04-13','Chequeo pre-viaje completo','EM0013','AU0013','CL0013','OT0013','13'),('DI014','2023-04-14','Reemplazo de la batería','EM0014','AU0014','CL0014','OT0014','14'),('DI015','2023-04-15','Inspección de seguridad detallada','EM0015','AU0015','CL0015','OT0015','15'),('DI016','2025-04-16','Cambio de las pastillas de freno','EM0016','AU0016','CL0016','OT0016','16'),('DI017','2023-04-17','Evaluación de emisiones','EM0017','AU0017','CL0017','OT0017','17'),('DI018','2023-04-18','Servicio de climatización','EM0018','AU0018','CL0018','OT0018','18'),('DI019','2024-04-19','Revisión de la dirección y suspensión','EM0019','AU0019','CL0019','OT0019','2'),('DI020','2023-04-20','Diagnóstico de sistema de advertencia','EM0020','AU0020','CL0020','OT0020','20');
/*!40000 ALTER TABLE `diagnostico` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `empleado`
--

DROP TABLE IF EXISTS `empleado`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `empleado` (
  `ID_Empleado` varchar(6) NOT NULL,
  `Nombre` varchar(100) NOT NULL,
  `Cargo` varchar(100) NOT NULL,
  `ID_Departamento` varchar(6) NOT NULL,
  `Sueldo` decimal(10,0) NOT NULL,
  `ServiciosRealizados` int DEFAULT '0',
  `TotalPago` decimal(10,2) DEFAULT '0.00',
  PRIMARY KEY (`ID_Empleado`),
  KEY `empleado_ibfk_1` (`ID_Departamento`),
  CONSTRAINT `empleado_ibfk_1` FOREIGN KEY (`ID_Departamento`) REFERENCES `departamento` (`ID_Departamento`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `empleado`
--

LOCK TABLES `empleado` WRITE;
/*!40000 ALTER TABLE `empleado` DISABLE KEYS */;
INSERT INTO `empleado` VALUES ('EM0001','Juan Gómez','Mecánico','DP0004',20000,1,0.00),('EM0002','Pedro López','Supervisor','DP0002',30000,0,0.00),('EM0003','María Hernández','Pintor','DP0001',15000,1,0.00),('EM0004','Ana Torres','Mecánico','DP0004',20000,4,0.00),('EM0005','Luis García','Técnico de Alineación','DP0003',22000,1,0.00),('EM0006','Marta Rodríguez','Supervisor','DP0005',30000,0,0.00),('EM0007','Carlos Martínez','Mecánico','DP0004',20000,2,0.00),('EM0008','Laura Sánchez','Cajero','DP0002',13000,0,0.00),('EM0009','Jorge Pérez','Pintor','DP0001',15000,1,0.00),('EM0010','Sofía Díaz','Mecánico','DP0004',20000,2,0.00),('EM0011','Miguel Ruiz','Técnico de Alineación','DP0003',22000,1,0.00),('EM0012','Carmen Castro','Supervisor','DP0005',30000,1,0.00),('EM0013','Ricardo Flores','Mecánico','DP0004',20000,1,0.00),('EM0014','Isabel Ortega','Electricista','DP0002',22000,1,0.00),('EM0015','Javier Vargas','Cajero','DP0001',13000,0,0.00),('EM0016','Lucía Morales','Mecánico','DP0004',20000,1,0.00),('EM0017','Fernando Jiménez','Técnico de Alineación','DP0003',22000,1,0.00),('EM0018','Gabriela Gutiérrez','Supervisor','DP0005',30000,0,0.00),('EM0019','Diego Navarro','Mecánico','DP0004',20000,1,0.00),('EM0020','Valentina Romero','Supervisor','DP0002',30000,1,0.00);
/*!40000 ALTER TABLE `empleado` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orden_trabajo`
--

DROP TABLE IF EXISTS `orden_trabajo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orden_trabajo` (
  `ID_Orden_Trabajo` varchar(6) NOT NULL,
  `Fecha_Ingreso` date DEFAULT NULL,
  `Fecha_Promesa` date DEFAULT NULL,
  `Fecha_Salida` date DEFAULT NULL,
  `Observaciones` text,
  `ID_Venta` varchar(6) DEFAULT NULL,
  `Garantia` enum('Si','No') DEFAULT NULL,
  PRIMARY KEY (`ID_Orden_Trabajo`),
  KEY `ID_Venta` (`ID_Venta`),
  CONSTRAINT `orden_trabajo_ibfk_1` FOREIGN KEY (`ID_Venta`) REFERENCES `ventas` (`ID_Venta`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orden_trabajo`
--

LOCK TABLES `orden_trabajo` WRITE;
/*!40000 ALTER TABLE `orden_trabajo` DISABLE KEYS */;
INSERT INTO `orden_trabajo` VALUES ('OT0001','2023-04-01','2023-04-03','2023-04-03','Revisión general completada','14','Si'),('OT0002','2023-04-02','2023-04-04','2024-04-04','Cambio de aceite y filtros','2','Si'),('OT0003','2024-04-05','2023-04-07','2023-04-07','Reparación del sistema de frenos','3','No'),('OT0004','2023-04-08','2023-04-10','2023-04-10','Mantenimiento del sistema de suspensión','4','No'),('OT0005','2023-04-11','2023-04-13','2024-04-13','Cambio de bujías y revisión del motor','5','Si'),('OT0006','2025-04-15','2023-04-17','2023-04-17','Servicio de alineación y balanceo','6','No'),('OT0007','2023-04-18','2023-04-20','2023-04-20','Reparación de aire acondicionado','7','No'),('OT0008','2023-04-21','2023-04-23','2023-04-23','Pintura y reparación de carrocería','8','Si'),('OT0009','2025-04-25','2023-04-27','2023-04-27','Revisión de sistemas eléctricos','6','Si'),('OT0010','2023-04-28','2023-04-30','2023-04-30','Instalación de sistema de audio','10','No'),('OT0011','2024-05-01','2023-05-03','2023-05-03','Cambio de llantas y revisión de presiones','11','No'),('OT0012','2023-05-04','2023-05-06','2023-05-06','Servicio completo pre-viaje','12','Si'),('OT0013','2024-05-07','2023-05-09','2024-05-09','Cambio de transmisión automática','13','Si'),('OT0014','2025-05-10','2023-05-12','2025-05-12','Reparación de sistema de escape','14','Si'),('OT0015','2023-05-13','2023-05-15','2023-05-15','Recarga de refrigerante y revisión de fugas','14','Si'),('OT0016','2023-05-16','2023-05-18','2023-05-18','Restauración de faros y ajustes exteriores','16','No'),('OT0017','2023-05-19','2023-05-21','2023-05-21','Diagnóstico de fallas con OBD','17','Si'),('OT0018','2023-05-22','2023-05-24','2023-05-24','Sustitución de amortiguadores','18','Si'),('OT0019','2023-05-25','2023-05-27','2023-05-27','Reparación de inyectores y sistema de combustible','6','No'),('OT0020','2023-05-28','2023-05-30','2023-05-30','Mantenimiento general y chequeo de fluidos','20','No');
/*!40000 ALTER TABLE `orden_trabajo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `parte`
--

DROP TABLE IF EXISTS `parte`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `parte` (
  `ID_Parte` varchar(6) NOT NULL,
  `Descripcion` varchar(100) DEFAULT NULL,
  `Precio_Unitario` decimal(10,2) DEFAULT NULL,
  `Stock` int DEFAULT NULL,
  `ID_Departamento` varchar(6) DEFAULT NULL,
  PRIMARY KEY (`ID_Parte`),
  KEY `ID_Departamento` (`ID_Departamento`),
  CONSTRAINT `parte_ibfk_1` FOREIGN KEY (`ID_Departamento`) REFERENCES `departamento` (`ID_Departamento`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `parte`
--

LOCK TABLES `parte` WRITE;
/*!40000 ALTER TABLE `parte` DISABLE KEYS */;
INSERT INTO `parte` VALUES ('PT0001','Balatas de freno',50.00,100,'DP0004'),('PT0002','Filtro de aire',20.00,200,'DP0004'),('PT0003','Bujías',15.00,150,'DP0002'),('PT0004','Aceite motor 5W-30',25.00,300,'DP0004'),('PT0005','Líquido de frenos',30.00,120,'DP0004'),('PT0006','Correa de distribución',45.00,80,'DP0004'),('PT0007','Filtro de aceite',10.00,150,'DP0004'),('PT0008','Filtro de combustible',35.00,90,'DP0004'),('PT0009','Amortiguadores',70.00,50,'DP0003'),('PT0010','Pastillas de freno',55.00,110,'DP0004'),('PT0011','Rótulas',65.00,60,'DP0003'),('PT0012','Bombillas LED',22.00,130,'DP0002'),('PT0013','Espejos laterales',40.00,40,'DP0001'),('PT0014','Radiador',120.00,30,'DP0004'),('PT0015','Alternador',200.00,25,'DP0002'),('PT0016','Cables de encendido',18.00,95,'DP0002'),('PT0017','Batería de coche',90.00,70,'DP0004'),('PT0018','Neumáticos',100.00,200,'DP0003'),('PT0019','Tubo de escape',150.00,40,'DP0004'),('PT0020','Catalizador',300.00,30,'DP0004');
/*!40000 ALTER TABLE `parte` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `promocion`
--

DROP TABLE IF EXISTS `promocion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `promocion` (
  `ID_Promocion` varchar(6) NOT NULL,
  `Descripcion` varchar(100) DEFAULT NULL,
  `Descuento` decimal(5,2) DEFAULT NULL,
  `Fecha_Inicio` date DEFAULT NULL,
  `Fecha_Fin` date DEFAULT NULL,
  PRIMARY KEY (`ID_Promocion`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `promocion`
--

LOCK TABLES `promocion` WRITE;
/*!40000 ALTER TABLE `promocion` DISABLE KEYS */;
INSERT INTO `promocion` VALUES ('PM0001','20% descuento en cambio de aceite',20.00,'2023-06-01','2023-06-30'),('PM0002','15% descuento en alineación y balanceo',15.00,'2023-06-15','2023-07-15'),('PM0003','10% descuento en reparaciones mayores',10.00,'2023-07-01','2023-07-31'),('PM0004','25% descuento en servicios de frenos',25.00,'2023-08-01','2023-08-31'),('PM0005','5% descuento en compra de accesorios',5.00,'2023-09-01','2023-09-30'),('PM0006','30% descuento en pintura completa',30.00,'2023-10-01','2023-10-31'),('PM0007','50% descuento en segundo cambio de aceite',50.00,'2023-11-01','2023-11-30'),('PM0008','Gratis lavado con cualquier servicio',0.00,'2023-12-01','2023-12-31'),('PM0009','20% descuento en cambio de llantas',20.00,'2024-01-01','2024-01-31'),('PM0010','15% descuento general para nuevos clientes',15.00,'2024-02-01','2024-02-28'),('PM0011','10% descuento en reparación de transmisión',10.00,'2024-03-01','2024-03-31'),('PM0012','25% en revisión y mantenimiento de A/C',25.00,'2024-04-01','2024-04-30'),('PM0013','20% descuento en cambio de amortiguadores',20.00,'2024-05-01','2024-05-31'),('PM0014','15% descuento en cambio de filtro de aire',15.00,'2024-06-01','2024-06-30'),('PM0015','30% descuento para servicios a vehículos híbridos',30.00,'2024-07-01','2024-07-31'),('PM0016','Promoción de verano, 20% en todos los servicios',20.00,'2024-08-01','2024-08-31'),('PM0017','15% descuento en reparaciones de sistema eléctrico',15.00,'2024-09-01','2024-09-30'),('PM0018','25% descuento en cambio de bujías',25.00,'2024-10-01','2024-10-31'),('PM0019','10% descuento en servicios de carrocería y pintura',10.00,'2024-11-01','2024-11-30'),('PM0020','Oferta de fin de año, 30% en diagnósticos',30.00,'2024-12-01','2024-12-31');
/*!40000 ALTER TABLE `promocion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `servicio`
--

DROP TABLE IF EXISTS `servicio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `servicio` (
  `ID_Servicio` varchar(6) NOT NULL,
  `Descripcion` varchar(100) DEFAULT NULL,
  `Costo` decimal(10,2) DEFAULT NULL,
  `ID_Departamento` varchar(6) DEFAULT NULL,
  PRIMARY KEY (`ID_Servicio`),
  KEY `ID_Departamento` (`ID_Departamento`),
  CONSTRAINT `servicio_ibfk_1` FOREIGN KEY (`ID_Departamento`) REFERENCES `departamento` (`ID_Departamento`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `servicio`
--

LOCK TABLES `servicio` WRITE;
/*!40000 ALTER TABLE `servicio` DISABLE KEYS */;
INSERT INTO `servicio` VALUES ('SR0001','Cambio de aceite',500.00,'DP0004'),('SR0002','Alineación y balanceo',800.00,'DP0003'),('SR0003','Reparación de motor',5000.00,'DP0004'),('SR0004','Cambio de frenos',1500.00,'DP0004'),('SR0005','Reparación de transmisión',4000.00,'DP0004'),('SR0006','Cambio de bujías',300.00,'DP0002'),('SR0007','Reparación de alternador',2000.00,'DP0002'),('SR0008','Pintura completa',10000.00,'DP0001'),('SR0009','Reparación de chasis',3000.00,'DP0001'),('SR0010','Cambio de llantas',2000.00,'DP0003'),('SR0011','Cambio de filtro de aire',200.00,'DP0004'),('SR0012','Reparación de aire acondicionado',1500.00,'DP0002'),('SR0013','Cambio de batería',800.00,'DP0002'),('SR0014','Reparación de radiador',1000.00,'DP0004'),('SR0015','Cambio de amortiguadores',2500.00,'DP0003'),('SR0016','Reparación de dirección',2000.00,'DP0004'),('SR0017','Cambio de correa de distribución',3000.00,'DP0004'),('SR0018','Reparación de sistema de escape',1500.00,'DP0004'),('SR0019','Cambio de bomba de agua',1000.00,'DP0004'),('SR0020','Reparación de sistema de combustible',2500.00,'DP0004');
/*!40000 ALTER TABLE `servicio` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `venta_diagnostico`
--

DROP TABLE IF EXISTS `venta_diagnostico`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `venta_diagnostico` (
  `ID_Venta_Diagnostico` varchar(6) NOT NULL,
  `ID_Venta` varchar(6) DEFAULT NULL,
  `ID_Diagnostico` varchar(6) DEFAULT NULL,
  `Importe` decimal(10,2) NOT NULL,
  `Total` decimal(10,2) NOT NULL,
  PRIMARY KEY (`ID_Venta_Diagnostico`,`Importe`,`Total`),
  KEY `ID_Venta` (`ID_Venta`),
  KEY `ID_Diagnostico` (`ID_Diagnostico`),
  CONSTRAINT `venta_diagnostico_ibfk_1` FOREIGN KEY (`ID_Venta`) REFERENCES `ventas` (`ID_Venta`),
  CONSTRAINT `venta_diagnostico_ibfk_2` FOREIGN KEY (`ID_Diagnostico`) REFERENCES `diagnostico` (`ID_Diagnostico`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `venta_diagnostico`
--

LOCK TABLES `venta_diagnostico` WRITE;
/*!40000 ALTER TABLE `venta_diagnostico` DISABLE KEYS */;
INSERT INTO `venta_diagnostico` VALUES ('VD001','22','DI002',50.00,50.00),('VD002','23','DI003',75.00,75.00),('VD003','21','DI004',60.00,60.00),('VD004','23','DI005',100.00,100.00),('VD005','24','DI006',85.00,85.00),('VD006','25','DI007',40.00,40.00),('VD007','27','DI008',110.00,110.00),('VD008','28','DI004',90.00,90.00),('VD009','29','DI010',55.00,55.00),('VD010','30','DI011',95.00,95.00),('VD011','31','DI012',120.00,120.00),('VD012','32','DI013',130.00,130.00),('VD013','33','DI014',45.00,45.00),('VD014','34','DI015',70.00,70.00),('VD015','35','DI016',65.00,65.00),('VD016','36','DI004',80.00,80.00),('VD017','37','DI018',105.00,105.00),('VD018','38','DI019',35.00,35.00),('VD019','39','DI002',115.00,115.00),('VD020','40','DI012',25.00,25.00);
/*!40000 ALTER TABLE `venta_diagnostico` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `venta_parte`
--

DROP TABLE IF EXISTS `venta_parte`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `venta_parte` (
  `ID_Parte` varchar(6) NOT NULL,
  `ID_Venta` varchar(6) NOT NULL,
  `ID_Promocion` varchar(6) DEFAULT NULL,
  `Fecha` date NOT NULL,
  `Fecha_Vencimiento_Garantia` date NOT NULL,
  `Cantidad` int NOT NULL,
  `Importe` decimal(10,2) NOT NULL,
  `Total` decimal(10,2) NOT NULL,
  PRIMARY KEY (`ID_Parte`,`ID_Venta`),
  KEY `ID_Venta` (`ID_Venta`),
  KEY `ID_Promocion` (`ID_Promocion`),
  CONSTRAINT `venta_parte_ibfk_1` FOREIGN KEY (`ID_Parte`) REFERENCES `parte` (`ID_Parte`),
  CONSTRAINT `venta_parte_ibfk_2` FOREIGN KEY (`ID_Venta`) REFERENCES `ventas` (`ID_Venta`),
  CONSTRAINT `venta_parte_ibfk_3` FOREIGN KEY (`ID_Promocion`) REFERENCES `promocion` (`ID_Promocion`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `venta_parte`
--

LOCK TABLES `venta_parte` WRITE;
/*!40000 ALTER TABLE `venta_parte` DISABLE KEYS */;
INSERT INTO `venta_parte` VALUES ('PT0001','41','PM0001','2023-04-15','2024-04-15',2,100.00,200.00),('PT0002','42',NULL,'2023-05-01','2024-05-01',1,20.00,20.00),('PT0003','23','PM0002','2023-06-10','2024-06-10',4,15.00,60.00),('PT0004','44',NULL,'2023-07-20','2024-07-20',3,25.00,75.00),('PT0005','45','PM0003','2023-08-15','2024-08-15',5,30.00,150.00),('PT0006','55',NULL,'2023-09-01','2024-09-01',2,45.00,90.00),('PT0007','56','PM0004','2023-10-25','2024-10-25',1,10.00,10.00),('PT0008','57',NULL,'2023-11-15','2024-11-15',3,35.00,105.00),('PT0009','57','PM0005','2023-12-05','2024-12-05',2,70.00,140.00),('PT0010','55',NULL,'2024-01-20','2025-01-20',2,55.00,110.00),('PT0011','46','PM0006','2024-02-18','2025-02-18',4,65.00,260.00),('PT0012','47',NULL,'2024-03-22','2025-03-22',3,22.00,66.00),('PT0013','48','PM0007','2024-04-15','2025-04-15',2,40.00,80.00),('PT0014','49',NULL,'2024-05-10','2025-05-10',1,120.00,120.00),('PT0015','50','PM0008','2024-06-05','2025-06-05',1,200.00,200.00),('PT0016','51',NULL,'2024-07-19','2025-07-19',3,18.00,54.00),('PT0017','52','PM0009','2024-08-20','2025-08-20',2,90.00,180.00),('PT0018','53',NULL,'2024-09-30','2025-09-30',4,100.00,400.00),('PT0019','54','PM0010','2024-10-25','2025-10-25',2,150.00,300.00),('PT0020','58',NULL,'2024-11-15','2025-11-15',1,300.00,300.00);
/*!40000 ALTER TABLE `venta_parte` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ventas`
--

DROP TABLE IF EXISTS `ventas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ventas` (
  `ID_Venta` varchar(6) NOT NULL,
  `Fecha` date DEFAULT NULL,
  `Total` decimal(10,2) DEFAULT NULL,
  `ID_Promocion` varchar(6) DEFAULT NULL,
  `Cajero` varchar(6) DEFAULT NULL,
  PRIMARY KEY (`ID_Venta`),
  KEY `ID_Promocion` (`ID_Promocion`),
  KEY `fk_cajero_empleado` (`Cajero`),
  CONSTRAINT `fk_cajero_empleado` FOREIGN KEY (`Cajero`) REFERENCES `empleado` (`ID_Empleado`),
  CONSTRAINT `ventas_ibfk_1` FOREIGN KEY (`ID_Promocion`) REFERENCES `promocion` (`ID_Promocion`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ventas`
--

LOCK TABLES `ventas` WRITE;
/*!40000 ALTER TABLE `ventas` DISABLE KEYS */;
INSERT INTO `ventas` VALUES ('1','2023-04-15',1000.00,'PM0001','EM0015'),('10','2024-01-05',850.00,NULL,'EM0015'),('11','2024-02-14',950.00,'PM0007','EM0015'),('12','2024-03-21',2000.00,NULL,'EM0015'),('13','2024-04-30',1250.00,'PM0008','EM0015'),('14','2024-05-16',2600.00,NULL,'EM0015'),('15','2024-06-18',2300.00,'PM0009','EM0015'),('16','2024-07-19',2800.00,'PM0010','EM0015'),('17','2024-08-25',1100.00,NULL,'EM0015'),('18','2024-09-30',3200.00,'PM0011','EM0015'),('19','2024-10-31',2100.00,'PM0012','EM0015'),('2','2023-05-01',2500.00,NULL,'EM0015'),('20','2024-11-20',3000.00,NULL,'EM0015'),('21','2023-04-15',1000.00,'PM0001','EM0008'),('22','2023-12-15',750.00,NULL,'EM0008'),('23','2023-12-15',750.00,NULL,'EM0008'),('24','2023-05-01',2500.00,NULL,'EM0008'),('25','2023-06-10',1200.00,'PM0002','EM0008'),('26','2023-07-05',3000.00,'PM0003','EM0008'),('27','2023-10-20',2200.00,'PM0005','EM0008'),('28','2023-11-28',1900.00,NULL,'EM0008'),('29','2023-12-15',2900.00,'PM0006','EM0008'),('3','2023-06-10',1200.00,'PM0002','EM0008'),('30','2024-01-05',850.00,NULL,'EM0008'),('31','2024-02-14',950.00,'PM0007','EM0008'),('32','2024-03-21',2000.00,NULL,'EM0008'),('33','2024-04-30',1250.00,'PM0008','EM0008'),('34','2024-05-16',2600.00,NULL,'EM0008'),('35','2024-06-18',2300.00,'PM0009','EM0015'),('36','2024-07-19',2800.00,'PM0010','EM0015'),('37','2024-08-25',1100.00,NULL,'EM0008'),('38','2024-09-30',3200.00,'PM0011','EM0008'),('39','2023-08-15',1500.00,NULL,'EM0015'),('4','2023-07-05',3000.00,'PM0003','EM0015'),('40','2023-09-10',750.00,'PM0004','EM0015'),('41','2023-04-15',1000.00,'PM0001','EM0015'),('42','2023-05-01',2500.00,NULL,'EM0015'),('43','2023-06-10',1200.00,'PM0002','EM0015'),('44','2023-05-01',2500.00,NULL,'EM0015'),('45','2023-06-10',1200.00,'PM0002','EM0015'),('46','2023-07-05',2500.00,'PM0003','EM0015'),('47','2023-10-20',2200.00,'PM0005','EM0015'),('48','2023-11-28',2500.00,NULL,'EM0015'),('49','2023-12-15',2900.00,'PM0006','EM0015'),('5','2023-08-15',1500.00,NULL,'EM0015'),('50','2024-01-05',850.00,NULL,'EM0008'),('51','2024-02-14',950.00,'PM0007','EM0008'),('52','2024-03-21',2500.00,NULL,'EM0008'),('53','2025-04-30',1250.00,'PM0008','EM0008'),('54','2025-05-16',2600.00,NULL,'EM0008'),('55','2024-06-18',2300.00,'PM0009','EM0008'),('56','2024-07-19',2500.00,'PM0010','EM0008'),('57','2025-08-25',2500.00,NULL,'EM0008'),('58','2024-09-30',3200.00,'PM0011','EM0008'),('59','2023-08-15',1500.00,NULL,'EM0008'),('6','2023-09-10',750.00,'PM0004','EM0008'),('60','2023-09-10',750.00,'PM0004','EM0008'),('7','2023-10-20',2200.00,'PM0005','EM0008'),('8','2023-11-28',1900.00,NULL,'EM0008'),('9','2023-12-15',2900.00,'PM0006','EM0008');
/*!40000 ALTER TABLE `ventas` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-08-26 10:06:48
