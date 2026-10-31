-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               5.7.33 - MySQL Community Server (GPL)
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


-- Dumping database structure for db_siswa2
CREATE DATABASE IF NOT EXISTS `db_siswa2` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `db_siswa2`;

-- Dumping structure for table db_siswa2.admin
CREATE TABLE IF NOT EXISTS `admin` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

-- Dumping data for table db_siswa2.admin: ~1 rows (approximately)
INSERT INTO `admin` (`id`, `email`, `password`) VALUES
	(1, 'admin@gmail.com', 'admin123');

-- Dumping structure for table db_siswa2.siswa
CREATE TABLE IF NOT EXISTS `siswa` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nipd` varchar(20) NOT NULL,
  `nama_lengkap` varchar(100) NOT NULL,
  `jenis_kelamin` enum('Laki-laki','Perempuan') NOT NULL,
  `alamat` text,
  `kelas` varchar(20) NOT NULL,
  `jurusan` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;

-- Dumping data for table db_siswa2.siswa: ~7 rows (approximately)
INSERT INTO `siswa` (`id`, `nipd`, `nama_lengkap`, `jenis_kelamin`, `alamat`, `kelas`, `jurusan`) VALUES
	(1, '242510070', 'Nurlita', 'Perempuan', 'Cibeber', 'XII', 'Teknik Komputer dan Jaringan'),
	(2, '242510071', 'Oktapia Nurpadilah', 'Perempuan', 'Kp.sukamanah 2', 'XII', 'Rekayasa Perangkat Lunak'),
	(3, '242510064', 'Melvin Olivia', 'Perempuan', 'Kp.sadangan', 'XII', 'Bisnis Digital'),
	(4, '242510069', 'Novita Damayanti', 'Perempuan', 'Kp.sadangan', 'XII', 'Akuntansi'),
	(6, '242510076', 'Rina Rusliana', 'Perempuan', 'Griya Parungpanjang', 'XII', 'Rekayasa Perangkat Lunak'),
	(7, '242510059', 'Felicya Agatha', 'Perempuan', 'Milenium City', 'XII', 'Rekayasa Perangkat Lunak'),
	(9, '242610079', 'Siti Nur Kholisha', 'Perempuan', 'Kp. sukamanah', 'XII', 'Teknik Komputer dan Jaringan');

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
