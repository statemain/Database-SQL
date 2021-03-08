-- phpMyAdmin SQL Dump
-- version 4.6.6deb5ubuntu0.5
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Mar 08, 2021 at 06:47 PM
-- Server version: 5.7.33-0ubuntu0.18.04.1
-- PHP Version: 7.2.24-0ubuntu0.18.04.7

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_invoice`
--

-- --------------------------------------------------------

--
-- Table structure for table `tbl_invoice`
--

CREATE TABLE `tbl_invoice` (
  `no_invoice` varchar(60) NOT NULL,
  `tanggal_dibuat` datetime DEFAULT NULL,
  `mata_uang` text,
  `kode_bank` varchar(60) NOT NULL,
  `no_suratjalan` varchar(60) NOT NULL,
  `kode_manager` varchar(60) NOT NULL,
  `tgl_jatuhtempo` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_invoice`
--

INSERT INTO `tbl_invoice` (`no_invoice`, `tanggal_dibuat`, `mata_uang`, `kode_bank`, `no_suratjalan`, `kode_manager`, `tgl_jatuhtempo`) VALUES
('FT/12/02/2021', '2021-02-12 13:10:35', 'IDR', 'BCA', 'SJ/12022021/PO2', 'MGR192301', '2021-02-13 14:00:00'),
('FT/30/01/2021', '2021-01-30 02:46:14', 'IDR', 'BCA', 'SJ/30012021/PO1', 'MGR192301', '2021-02-28 15:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_manager`
--

CREATE TABLE `tbl_manager` (
  `kode_manager` varchar(60) NOT NULL,
  `posisi` text
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_manager`
--

INSERT INTO `tbl_manager` (`kode_manager`, `posisi`) VALUES
('MGR192301', 'Indra Kusuma');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_partner`
--

CREATE TABLE `tbl_partner` (
  `kode_partner` varchar(60) NOT NULL,
  `nama_partner` text,
  `alamat_partner` text,
  `kota` text,
  `kode_pos` text
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_partner`
--

INSERT INTO `tbl_partner` (`kode_partner`, `nama_partner`, `alamat_partner`, `kota`, `kode_pos`) VALUES
('CM0123', 'PT. LOKAKARYA MULTI INTI FACTORY BEKASI', 'Jl. Raya Tambun, No. 22', 'Bekasi', '17550'),
('CM1239', 'PT. HARUM TEKNOLOGI BANDUNG', 'Jl. Raya Melati, No. 15', 'Bandung', '16193');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_po`
--

CREATE TABLE `tbl_po` (
  `no_po` varchar(60) NOT NULL,
  `tanggal_po` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_po`
--

INSERT INTO `tbl_po` (`no_po`, `tanggal_po`) VALUES
('PO-1/01/2021', '2021-01-25 12:19:48'),
('PO-2/02/2021', '2021-02-05 18:23:40');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_produk`
--

CREATE TABLE `tbl_produk` (
  `kode_produk` varchar(60) NOT NULL,
  `produk` text,
  `diskon` int(11) DEFAULT NULL,
  `minimum_request` int(11) DEFAULT NULL,
  `satuan` text,
  `harga_satuan` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_produk`
--

INSERT INTO `tbl_produk` (`kode_produk`, `produk`, `diskon`, `minimum_request`, `satuan`, `harga_satuan`) VALUES
('B7623984', 'External USB Keyboard (LG)', 10, 10, 'Unit', 210000),
('B7623985', 'Logitech Mouse Wireless M171', 10, 20, 'Unit', 169400),
('B7623986', 'SMT Power Stabilizer Single Phase', 15, 50, 'Unit', 341000),
('B7623987', 'Logitech Desktop Combo', 10, 10, 'Package', 9900),
('B7623988', 'Verbatim CD-RW', 10, 10, 'Package', 189200),
('B7623989', 'Asus ZenBook 14', 10, 10, 'Unit', 11880000),
('B7623990', 'Verbatim DVD-RW', 10, 10, 'Package', 159800),
('B7623991', 'Monitor Led Samsung 22SF350 - 22 Inch PC Komputer - VGA HDMI 22 SF350', 25, 25, 'Unit', 1325000);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_rek_perusahaan`
--

CREATE TABLE `tbl_rek_perusahaan` (
  `kode_bank` varchar(60) NOT NULL,
  `no_rekening` text,
  `atas_nama` text,
  `cabang` text
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_rek_perusahaan`
--

INSERT INTO `tbl_rek_perusahaan` (`kode_bank`, `no_rekening`, `atas_nama`, `cabang`) VALUES
('BCA', '021-222111232', 'PT. PLASMA TECH INDONESIA', 'Bekasi');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_staff`
--

CREATE TABLE `tbl_staff` (
  `no_staff` varchar(60) NOT NULL,
  `nama_staff` text,
  `posisi` text
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_staff`
--

INSERT INTO `tbl_staff` (`no_staff`, `nama_staff`, `posisi`) VALUES
('2801923813', 'Wirda Anggraeni', 'Staff Administrasi'),
('8912371237', 'Lucy Hendarwati', 'Staff Administrasi');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_suratjalan`
--

CREATE TABLE `tbl_suratjalan` (
  `no_suratjalan` varchar(60) NOT NULL,
  `tanggal_pengiriman` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_suratjalan`
--

INSERT INTO `tbl_suratjalan` (`no_suratjalan`, `tanggal_pengiriman`) VALUES
('SJ/12022021/PO2', '2021-02-22 08:00:00'),
('SJ/30012021/PO1', '2021-02-10 14:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_transaksi`
--

CREATE TABLE `tbl_transaksi` (
  `id_transaksi` int(11) NOT NULL,
  `no_invoice` varchar(60) NOT NULL,
  `no_po` varchar(60) NOT NULL,
  `no_staff` varchar(60) NOT NULL,
  `kode_partner` varchar(60) NOT NULL,
  `kode_produk` varchar(60) NOT NULL,
  `dateadded` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `jml_qty` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_transaksi`
--

INSERT INTO `tbl_transaksi` (`id_transaksi`, `no_invoice`, `no_po`, `no_staff`, `kode_partner`, `kode_produk`, `dateadded`, `jml_qty`) VALUES
(1, 'FT/30/01/2021', 'PO-1/01/2021', '2801923813', 'CM0123', 'B7623984', '2021-02-10 03:47:12', 10),
(2, 'FT/30/01/2021', 'PO-1/01/2021', '2801923813', 'CM0123', 'B7623985', '2021-02-10 03:47:14', 26),
(3, 'FT/30/01/2021', 'PO-1/01/2021', '2801923813', 'CM0123', 'B7623986', '2021-02-10 03:47:19', 25),
(4, 'FT/30/01/2021', 'PO-1/01/2021', '2801923813', 'CM0123', 'B7623987', '2021-02-10 03:47:23', 25),
(5, 'FT/30/01/2021', 'PO-1/01/2021', '2801923813', 'CM0123', 'B7623988', '2021-02-10 03:47:25', 8),
(6, 'FT/30/01/2021', 'PO-1/01/2021', '2801923813', 'CM0123', 'B7623989', '2021-02-10 03:47:33', 12),
(7, 'FT/30/01/2021', 'PO-1/01/2021', '2801923813', 'CM0123', 'B7623990', '2021-02-10 03:47:35', 10),
(8, 'FT/30/01/2021', 'PO-1/01/2021', '2801923813', 'CM0123', 'B7623991', '2021-02-10 03:47:37', 5),
(9, 'FT/12/02/2021', 'PO-2/02/2021', '8912371237', 'CM1239', 'B7623990', '2021-02-10 12:43:37', 15),
(10, 'FT/12/02/2021', 'PO-2/02/2021', '8912371237', 'CM1239', 'B7623991', '2021-02-10 12:43:39', 12);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `tbl_invoice`
--
ALTER TABLE `tbl_invoice`
  ADD PRIMARY KEY (`no_invoice`,`kode_bank`,`no_suratjalan`,`kode_manager`),
  ADD KEY `fk_rekperusahaan2invoice` (`kode_bank`),
  ADD KEY `fk_suratjalan2invoice` (`no_suratjalan`),
  ADD KEY `fk_manager2invoice` (`kode_manager`);

--
-- Indexes for table `tbl_manager`
--
ALTER TABLE `tbl_manager`
  ADD PRIMARY KEY (`kode_manager`);

--
-- Indexes for table `tbl_partner`
--
ALTER TABLE `tbl_partner`
  ADD PRIMARY KEY (`kode_partner`);

--
-- Indexes for table `tbl_po`
--
ALTER TABLE `tbl_po`
  ADD PRIMARY KEY (`no_po`);

--
-- Indexes for table `tbl_produk`
--
ALTER TABLE `tbl_produk`
  ADD PRIMARY KEY (`kode_produk`);

--
-- Indexes for table `tbl_rek_perusahaan`
--
ALTER TABLE `tbl_rek_perusahaan`
  ADD PRIMARY KEY (`kode_bank`);

--
-- Indexes for table `tbl_staff`
--
ALTER TABLE `tbl_staff`
  ADD PRIMARY KEY (`no_staff`);

--
-- Indexes for table `tbl_suratjalan`
--
ALTER TABLE `tbl_suratjalan`
  ADD PRIMARY KEY (`no_suratjalan`);

--
-- Indexes for table `tbl_transaksi`
--
ALTER TABLE `tbl_transaksi`
  ADD PRIMARY KEY (`id_transaksi`,`no_invoice`,`no_po`,`no_staff`,`kode_partner`,`kode_produk`),
  ADD KEY `fk_po2transaksi` (`no_po`),
  ADD KEY `fk_staff2transaksi` (`no_staff`),
  ADD KEY `fk_partner2transaksi` (`kode_partner`),
  ADD KEY `fk_invoice2transaksi` (`no_invoice`),
  ADD KEY `fk_produk2transaksi` (`kode_produk`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `tbl_invoice`
--
ALTER TABLE `tbl_invoice`
  ADD CONSTRAINT `fk_manager2invoice` FOREIGN KEY (`kode_manager`) REFERENCES `tbl_manager` (`kode_manager`),
  ADD CONSTRAINT `fk_rekperusahaan2invoice` FOREIGN KEY (`kode_bank`) REFERENCES `tbl_rek_perusahaan` (`kode_bank`),
  ADD CONSTRAINT `fk_suratjalan2invoice` FOREIGN KEY (`no_suratjalan`) REFERENCES `tbl_suratjalan` (`no_suratjalan`);

--
-- Constraints for table `tbl_transaksi`
--
ALTER TABLE `tbl_transaksi`
  ADD CONSTRAINT `fk_invoice2transaksi` FOREIGN KEY (`no_invoice`) REFERENCES `tbl_invoice` (`no_invoice`),
  ADD CONSTRAINT `fk_partner2transaksi` FOREIGN KEY (`kode_partner`) REFERENCES `tbl_partner` (`kode_partner`),
  ADD CONSTRAINT `fk_po2transaksi` FOREIGN KEY (`no_po`) REFERENCES `tbl_po` (`no_po`),
  ADD CONSTRAINT `fk_produk2transaksi` FOREIGN KEY (`kode_produk`) REFERENCES `tbl_produk` (`kode_produk`),
  ADD CONSTRAINT `fk_staff2transaksi` FOREIGN KEY (`no_staff`) REFERENCES `tbl_staff` (`no_staff`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
