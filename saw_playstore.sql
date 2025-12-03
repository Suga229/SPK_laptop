-- phpMyAdmin SQL Dump (versi modifikasi untuk SPK Smartphone)
-- Database: `saw_playstore`

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
 /*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
 /*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
 /*!40101 SET NAMES utf8mb4 */;

-- =====================================================================
-- BUAT DATABASE (kalau belum ada)
-- =====================================================================
CREATE DATABASE IF NOT EXISTS `saw_playstore`
  DEFAULT CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;
USE `saw_playstore`;

-- =====================================================================
-- HAPUS TABEL JIKA SUDAH ADA (supaya bersih)
-- =====================================================================
DROP TABLE IF EXISTS `saw_perankingan`;
DROP TABLE IF EXISTS `saw_penilaian`;
DROP TABLE IF EXISTS `saw_kriteria`;
DROP TABLE IF EXISTS `saw_aplikasi`;

-- =====================================================================
-- TABEL: saw_aplikasi (sekarang berisi data smartphone)
-- =====================================================================

CREATE TABLE `saw_aplikasi` (
  `nama` varchar(100) NOT NULL,
  `pengembang` varchar(100) NOT NULL,
  `kategori` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data contoh: 3 smartphone
INSERT INTO `saw_aplikasi` (`nama`, `pengembang`, `kategori`) VALUES
('Samsung Galaxy A55', 'Samsung', 'Mid-range'),
('Xiaomi Redmi Note 13 Pro', 'Xiaomi', 'Mid-range'),
('Realme 11 Pro', 'Realme', 'Mid-range');

-- =====================================================================
-- TABEL: saw_kriteria (bobot kriteria)
-- peringkat  = Performa & Ulasan
-- ukuran     = Harga           (COST)
-- unduhan    = Kapasitas Baterai
-- aktif      = Kamera
-- manfaat    = Fitur Pendukung
-- kelebihan  = Ketersediaan / After Sales
-- =====================================================================

CREATE TABLE `saw_kriteria` (
  `no` int(11) NOT NULL,
  `peringkat` float NOT NULL,
  `ukuran` float NOT NULL,
  `unduhan` float NOT NULL,
  `aktif` float NOT NULL,
  `manfaat` float NOT NULL,
  `kelebihan` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Bobot contoh (total = 1.00)
-- Performa  : 0.25
-- Harga     : 0.20 (cost)
-- Baterai   : 0.20
-- Kamera    : 0.15
-- Fitur     : 0.10
-- Ketersediaan : 0.10
INSERT INTO `saw_kriteria`
(`no`, `peringkat`, `ukuran`, `unduhan`, `aktif`, `manfaat`, `kelebihan`) VALUES
(1, 0.25, 0.20, 0.20, 0.15, 0.10, 0.10);

-- =====================================================================
-- TABEL: saw_penilaian
-- Nilai 1–5 (kecuali rating bisa pecahan)
-- =====================================================================

CREATE TABLE `saw_penilaian` (
  `nama` varchar(100) NOT NULL,
  `peringkat` float NOT NULL,
  `ukuran` float NOT NULL,
  `unduhan` float NOT NULL,
  `aktif` float NOT NULL,
  `manfaat` float NOT NULL,
  `kelebihan` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data contoh penilaian:
-- peringkat : rating / performa (1–5)
-- ukuran    : Harga           (1 = sangat mahal, 5 = sangat murah)
-- unduhan   : Kapasitas baterai (1 = sangat kecil, 5 = sangat besar)
-- aktif     : Kamera (1 = sangat buruk, 5 = sangat baik)
-- manfaat   : Fitur pendukung (1 = sangat sedikit, 5 = sangat banyak)
-- kelebihan : Ketersediaan / after sales (1 = sangat sulit, 5 = sangat mudah)

INSERT INTO `saw_penilaian`
(`nama`, `peringkat`, `ukuran`, `unduhan`, `aktif`, `manfaat`, `kelebihan`) VALUES
('Samsung Galaxy A55',        4.5, 3, 4, 4, 4, 5),
('Xiaomi Redmi Note 13 Pro',  4.4, 4, 5, 4, 4, 3),
('Realme 11 Pro',             4.3, 4, 4, 3, 3, 3);

-- =====================================================================
-- TABEL: saw_perankingan
-- Akan di-TRUNCATE dan diisi ulang setiap kali hitung.php dijalankan.
-- =====================================================================

CREATE TABLE `saw_perankingan` (
  `no` int(11) NOT NULL,
  `nama` varchar(100) NOT NULL,
  `nilai_akhir` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data contoh (hasil perhitungan SAW dari data di atas):
-- (Catatan: begitu kamu buka hitung.php, tabel ini akan di-TRUNCATE
-- dan diisi ulang sesuai data aktual.)
INSERT INTO `saw_perankingan` (`no`, `nama`, `nilai_akhir`) VALUES
(1, 'Samsung Galaxy A55',       0.960),
(2, 'Xiaomi Redmi Note 13 Pro', 0.904),
(3, 'Realme 11 Pro',            0.796);

-- =====================================================================
-- INDEXES
-- =====================================================================

ALTER TABLE `saw_aplikasi`
  ADD PRIMARY KEY (`nama`);

ALTER TABLE `saw_kriteria`
  ADD PRIMARY KEY (`no`);

ALTER TABLE `saw_penilaian`
  ADD PRIMARY KEY (`nama`);

ALTER TABLE `saw_perankingan`
  ADD PRIMARY KEY (`no`);

-- =====================================================================
-- AUTO_INCREMENT
-- =====================================================================

ALTER TABLE `saw_kriteria`
  MODIFY `no` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

ALTER TABLE `saw_perankingan`
  MODIFY `no` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
 /*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
 /*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
