-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               8.0.30 - MySQL Community Server - GPL
-- Server OS:                    Win64
-- HeidiSQL Version:             12.1.0.6537
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Dumping database structure for fria02
DROP DATABASE IF EXISTS `fria02`;
CREATE DATABASE IF NOT EXISTS `fria02` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `fria02`;

-- Dumping structure for table fria02.detil_rep
DROP TABLE IF EXISTS `detil_rep`;
CREATE TABLE IF NOT EXISTS `detil_rep` (
  `noReparasi` char(8) DEFAULT NULL,
  `kdSparepart` char(8) DEFAULT NULL,
  `jmlSparepart` int DEFAULT NULL,
  KEY `FK_fromTHIStoREPARASI` (`noReparasi`),
  KEY `FK_fromTHIStoSPAREPART` (`kdSparepart`),
  CONSTRAINT `FK_fromTHIStoREPARASI` FOREIGN KEY (`noReparasi`) REFERENCES `reparasi` (`noReparasi`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_fromTHIStoSPAREPART` FOREIGN KEY (`kdSparepart`) REFERENCES `sparepart` (`kdSparepart`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Tabel Many-to-Many yang menghubungkan tabel REPARASI dengan tabel SPAREPART.';

-- Dumping data for table fria02.detil_rep: ~0 rows (approximately)
INSERT INTO `detil_rep` (`noReparasi`, `kdSparepart`, `jmlSparepart`) VALUES
	('RE000001', 'SP000002', 1),
	('RE000002', NULL, NULL),
	('RE000003', 'SP000001', 1),
	('RE000003', 'SP000003', 1);

-- Dumping structure for table fria02.jenis_reparasi
DROP TABLE IF EXISTS `jenis_reparasi`;
CREATE TABLE IF NOT EXISTS `jenis_reparasi` (
  `kdJenisRep` char(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `reparasi` varchar(50) DEFAULT NULL,
  `tarif` double(255,3) DEFAULT NULL,
  `keterangan` text,
  PRIMARY KEY (`kdJenisRep`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Katalog jenis reparasi yang disediakan.';

-- Dumping data for table fria02.jenis_reparasi: ~0 rows (approximately)
INSERT INTO `jenis_reparasi` (`kdJenisRep`, `reparasi`, `tarif`, `keterangan`) VALUES
	('JR000001', 'Penggantian Sparepart', 50000.000, 'Reparasi yang dilakukan hanyalah berupa pengggantian part, baik dalam mesin maupun badan kendaraan.'),
	('JR000002', 'Perbaikan Kerusakan', 100000.000, 'Reparasi berupa memperbaiki kerusakan yang dialami kendaraan.'),
	('JR000003', 'Full Service', 300000.000, 'Upaya restorasi penuh kendaraan, umumnya disebabkan oleh kerusakan fatal dari kecelakaan.');

-- Dumping structure for view fria02.number4task
DROP VIEW IF EXISTS `number4task`;
-- Creating temporary table to overcome VIEW dependency errors
CREATE TABLE `number4task` (
	`noReparasi` CHAR(8) NOT NULL COLLATE 'utf8mb4_0900_ai_ci',
	`namaMontir` VARCHAR(50) NULL COLLATE 'utf8mb4_0900_ai_ci',
	`reparasi` VARCHAR(50) NULL COLLATE 'utf8mb4_0900_ai_ci',
	`namaSparepart` VARCHAR(150) NULL COLLATE 'utf8mb4_0900_ai_ci',
	`stok` INT(10) NULL
) ENGINE=MyISAM;

-- Dumping structure for table fria02.reparasi
DROP TABLE IF EXISTS `reparasi`;
CREATE TABLE IF NOT EXISTS `reparasi` (
  `noReparasi` char(8) NOT NULL,
  `tglReparasi` datetime DEFAULT NULL,
  `namaMontir` varchar(50) DEFAULT NULL,
  `noMobil` varchar(15) DEFAULT NULL,
  `kdJenisRep` char(8) DEFAULT NULL,
  `tglBayar` datetime DEFAULT NULL,
  `status` varchar(25) DEFAULT NULL,
  PRIMARY KEY (`noReparasi`),
  KEY `FK_for_JENIS_REPARASI` (`kdJenisRep`),
  CONSTRAINT `FK_for_JENIS_REPARASI` FOREIGN KEY (`kdJenisRep`) REFERENCES `jenis_reparasi` (`kdJenisRep`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Tabel yang digunakan untuk mencatat data transaksi kegiatan reparasi yang dilakukan.';

-- Dumping data for table fria02.reparasi: ~0 rows (approximately)
INSERT INTO `reparasi` (`noReparasi`, `tglReparasi`, `namaMontir`, `noMobil`, `kdJenisRep`, `tglBayar`, `status`) VALUES
	('RE000001', '2024-03-09 13:40:23', 'Budi', 'YU1997LK0798', 'JR000001', '2024-03-09 13:41:11', 'On-Going'),
	('RE000002', '2024-02-09 09:00:30', 'Tono', 'HT1956JK2001', 'JR000002', '2024-02-09 09:05:33', 'Finished'),
	('RE000003', '2024-01-22 19:43:45', 'Harto', 'BG1654AS0101', 'JR000003', '2024-01-22 20:43:45', 'Ready');

-- Dumping structure for table fria02.sparepart
DROP TABLE IF EXISTS `sparepart`;
CREATE TABLE IF NOT EXISTS `sparepart` (
  `kdSparepart` char(8) NOT NULL,
  `namaSparepart` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `harga` double(255,3) DEFAULT NULL,
  `stok` int DEFAULT NULL,
  `log_update` varchar(75) DEFAULT NULL,
  PRIMARY KEY (`kdSparepart`),
  FULLTEXT KEY `namaSparepart` (`namaSparepart`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Daftar sparepart yang digunakan untuk reparasi.';

-- Dumping data for table fria02.sparepart: ~3 rows (approximately)
INSERT INTO `sparepart` (`kdSparepart`, `namaSparepart`, `harga`, `stok`, `log_update`) VALUES
	('SP000001', 'Generator Mobil FUNKY', 1000000.000, 10, NULL),
	('SP000002', 'Mesin Motor SPEEDZ', 450000.000, 14, NULL),
	('SP000003', 'Stir Mobil JORDI', 200000.000, 16, NULL);

-- Dumping structure for trigger fria02.sparepart_after_update
DROP TRIGGER IF EXISTS `sparepart_after_update`;
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `sparepart_after_update` AFTER UPDATE ON `sparepart` FOR EACH ROW UPDATE sparepart 
SET log_update='data diupdate pada: ' + CURRENT_TIMESTAMP() 
WHERE kdSparePart IN (SELECT DISTINCT kdSparePart FROM inserted)//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Dumping structure for view fria02.number4task
DROP VIEW IF EXISTS `number4task`;
-- Removing temporary table and create final VIEW structure
DROP TABLE IF EXISTS `number4task`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `number4task` AS select `re`.`noReparasi` AS `noReparasi`,`re`.`namaMontir` AS `namaMontir`,`jr`.`reparasi` AS `reparasi`,`sp`.`namaSparepart` AS `namaSparepart`,`sp`.`stok` AS `stok` from (((`reparasi` `re` join `jenis_reparasi` `jr` on((`re`.`kdJenisRep` = `jr`.`kdJenisRep`))) join `detil_rep` `dr` on((`re`.`noReparasi` = `dr`.`noReparasi`))) join `sparepart` `sp` on((`dr`.`kdSparepart` = `sp`.`kdSparepart`)));

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
