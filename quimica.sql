/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

DROP DATABASE IF EXISTS `quimica`;
CREATE DATABASE IF NOT EXISTS `quimica` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `quimica`;

DROP TABLE IF EXISTS `compuestos`;
CREATE TABLE IF NOT EXISTS `compuestos` (
  `formula` varchar(20) NOT NULL,
  `nombre` varchar(20) NOT NULL,
  `densidad` decimal(5,2) DEFAULT NULL,
  `numeroelementos` int DEFAULT NULL,
  PRIMARY KEY (`formula`),
  UNIQUE KEY `nombre` (`nombre`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `compuestos` (`formula`, `nombre`, `densidad`, `numeroelementos`) VALUES
	('H2O', 'Agua', NULL, NULL);

DROP TABLE IF EXISTS `EC`;
CREATE TABLE IF NOT EXISTS `EC` (
  `elemento` varchar(2) NOT NULL,
  `compuesto` varchar(20) NOT NULL,
  `atomos` int DEFAULT NULL,
  PRIMARY KEY (`elemento`,`compuesto`),
  KEY `fkcompuestos` (`compuesto`),
  CONSTRAINT `fkcompuestos` FOREIGN KEY (`compuesto`) REFERENCES `compuestos` (`formula`),
  CONSTRAINT `fkelementos` FOREIGN KEY (`elemento`) REFERENCES `elementos` (`simbolo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `EC` (`elemento`, `compuesto`, `atomos`) VALUES
	('H', 'H2O', 2),
	('O', 'H2O', 1);

DROP TABLE IF EXISTS `elementos`;
CREATE TABLE IF NOT EXISTS `elementos` (
  `simbolo` varchar(2) NOT NULL,
  `nombre` varchar(20) NOT NULL,
  `numeroatomico` int DEFAULT NULL,
  `grupo` int DEFAULT NULL,
  `masaatomica` decimal(5,2) DEFAULT NULL,
  PRIMARY KEY (`simbolo`),
  UNIQUE KEY `nombre` (`nombre`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `elementos` (`simbolo`, `nombre`, `numeroatomico`, `grupo`, `masaatomica`) VALUES
	('CL', 'Cloro', NULL, NULL, NULL),
	('H', 'Hidrógeno', NULL, NULL, NULL),
	('O', 'Oxígeno', NULL, NULL, NULL);






/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
