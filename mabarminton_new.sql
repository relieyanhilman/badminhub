-- phpMyAdmin SQL Dump
-- version 4.9.5deb2
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Aug 12, 2024 at 12:40 PM
-- Server version: 8.0.39-0ubuntu0.20.04.1
-- PHP Version: 7.4.3-4ubuntu2.23

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `mabarminton`
--

-- --------------------------------------------------------

--
-- Table structure for table `account`
--

CREATE TABLE `account` (
  `id` int NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `logo` varchar(255) DEFAULT NULL,
  `website` varchar(255) DEFAULT NULL,
  `notif_invoice` varchar(255) DEFAULT NULL,
  `notif_suspend` varchar(255) DEFAULT NULL,
  `notif_unsuspend` varchar(255) DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `action`
--

CREATE TABLE `action` (
  `id` int NOT NULL,
  `ip_address` varchar(255) DEFAULT NULL,
  `user_access` varchar(255) DEFAULT NULL,
  `password_access` varchar(255) DEFAULT NULL,
  `remote_protocol` varchar(255) DEFAULT NULL,
  `remote_data` varchar(255) DEFAULT NULL,
  `command` varchar(255) DEFAULT NULL,
  `execute_date` datetime DEFAULT NULL,
  `status` int DEFAULT NULL,
  `note` varchar(255) DEFAULT NULL,
  `account_id` int DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cash_flow`
--

CREATE TABLE `cash_flow` (
  `id` int NOT NULL,
  `community_id` int DEFAULT NULL,
  `type` enum('in','out') NOT NULL,
  `source` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `purpose` varchar(255) DEFAULT NULL,
  `payment_method` enum('Cash','Bank Transfer','QRIS') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'Bank Transfer',
  `date` date NOT NULL,
  `nominal` decimal(10,2) NOT NULL,
  `note` text,
  `user_id` int DEFAULT NULL,
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `cash_flow`
--

INSERT INTO `cash_flow` (`id`, `community_id`, `type`, `source`, `purpose`, `payment_method`, `date`, `nominal`, `note`, `user_id`, `createdAt`) VALUES
(1, 1, 'in', 'iuran non member-Open Mabar Selasa-2024-08-06', NULL, 'Cash', '2024-08-06', '35000.00', 'iuran non member-Open Mabar Selasa-2024-08-06-Dika-085961160400', 1, '2024-08-08 01:24:41'),
(2, 1, 'in', 'iuran member-Open Mabar Selasa', NULL, 'QRIS', '2024-08-06', '120000.00', 'iuran member-Open Mabar Selasa-Dwiki-081392427605', 1, '2024-08-08 01:28:49'),
(3, 1, 'in', 'iuran non member-Open Mabar Selasa-2024-08-06', NULL, 'QRIS', '2024-08-06', '35000.00', 'iuran non member-Open Mabar Selasa-2024-08-06-Ngurah Danta-082145672881', 1, '2024-08-08 01:29:53'),
(4, 1, 'in', 'iuran non member-Open Mabar Selasa-2024-08-06', NULL, 'QRIS', '2024-08-06', '35000.00', 'iuran non member-Open Mabar Selasa-2024-08-06-Yudhi Harta-081934345480', 1, '2024-08-08 01:31:01'),
(5, 1, 'in', 'iuran non member-Open Mabar Selasa-2024-08-06', NULL, 'QRIS', '2024-08-06', '35000.00', 'iuran non member-Open Mabar Selasa-2024-08-06-Arif-081339866427', 1, '2024-08-08 01:31:24'),
(6, 1, 'in', 'iuran non member-Open Mabar Selasa-2024-08-06', NULL, 'Cash', '2024-08-06', '35000.00', 'iuran non member-Open Mabar Selasa-2024-08-06-Aditya Riyanto-0818562726', 1, '2024-08-08 01:32:14'),
(7, 1, 'in', 'iuran non member-Open Mabar Selasa-2024-08-06', NULL, 'QRIS', '2024-08-06', '35000.00', 'iuran non member-Open Mabar Selasa-2024-08-06-Ismi Azyzah-08568620699', 1, '2024-08-08 01:32:44'),
(8, 1, 'in', 'iuran non member-Open Mabar Selasa-2024-08-06', NULL, 'QRIS', '2024-08-06', '35000.00', 'iuran non member-Open Mabar Selasa-2024-08-06-Clara-085222333012', 1, '2024-08-08 01:33:08'),
(9, 1, 'in', 'iuran non member-Open Mabar Selasa-2024-08-06', NULL, 'QRIS', '2024-08-06', '35000.00', 'iuran non member-Open Mabar Selasa-2024-08-06-Rico-085444333012', 1, '2024-08-08 01:33:19'),
(10, 1, 'in', 'iuran non member-Open Mabar Selasa-2024-08-06', NULL, 'Cash', '2024-08-06', '35000.00', 'iuran non member-Open Mabar Selasa-2024-08-06-Made Cahyadi-081111222012', 1, '2024-08-08 01:33:50'),
(11, 1, 'in', 'iuran non member-Open Mabar Selasa-2024-08-06', NULL, 'Cash', '2024-08-06', '35000.00', 'iuran non member-Open Mabar Selasa-2024-08-06-Irul-081936531237', 1, '2024-08-08 01:36:07'),
(12, 1, 'in', 'iuran non member-Open Mabar Selasa-2024-08-06', NULL, 'Cash', '2024-08-06', '35000.00', 'iuran non member-Open Mabar Selasa-2024-08-06-Martono Putra-082299220069', 1, '2024-08-08 01:36:34'),
(13, 1, 'in', 'iuran non member-Open Mabar Selasa-2024-08-06', NULL, 'Cash', '2024-08-06', '35000.00', 'iuran non member-Open Mabar Selasa-2024-08-06-Ardhi-085738225587', 1, '2024-08-08 01:37:12'),
(14, 1, 'in', 'iuran non member-Open Mabar Selasa-2024-08-06', NULL, 'QRIS', '2024-08-06', '35000.00', 'iuran non member-Open Mabar Selasa-2024-08-06-Juan Morino-089634862299', 1, '2024-08-08 01:37:46'),
(17, 1, 'in', 'iuran non member-Open Mabar Selasa-2024-08-06', NULL, 'QRIS', '2024-08-06', '35000.00', 'iuran non member-Open Mabar Selasa-2024-08-06-Arga-082142534636', 1, '2024-08-08 01:41:12'),
(18, 1, 'out', '', 'Subsidi', 'Cash', '2024-08-06', '25000.00', 'subsidi iuran non member khusus 5 orang (5000/orang)', 1, '2024-08-08 01:43:39'),
(19, 1, 'out', NULL, 'Buy Shuttlecock', 'Bank Transfer', '2024-08-06', '291000.00', 'pembelian 3 slop shuttlecock', 1, '2024-08-08 01:45:26');

-- --------------------------------------------------------

--
-- Table structure for table `clients`
--

CREATE TABLE `clients` (
  `id` int NOT NULL,
  `machine_id` varchar(255) DEFAULT NULL,
  `license` varchar(255) DEFAULT NULL,
  `expired_at` int DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `community`
--

CREATE TABLE `community` (
  `id` int NOT NULL,
  `username` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `address` text,
  `contact` varchar(20) DEFAULT NULL,
  `pic` varchar(255) DEFAULT NULL,
  `instagram` varchar(255) DEFAULT NULL,
  `tiktok` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `website` varchar(255) DEFAULT NULL,
  `logo` varchar(255) DEFAULT NULL,
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `community`
--

INSERT INTO `community` (`id`, `username`, `name`, `address`, `contact`, `pic`, `instagram`, `tiktok`, `email`, `website`, `logo`, `createdAt`) VALUES
(0, '*', 'Super Admin App', 'jl .xxx', '080', 'admin', NULL, NULL, NULL, NULL, NULL, '2024-07-29 02:43:54'),
(1, 'pbbedahulu', 'PB BEDAHULU', 'Jl. Bedahulu X No. 17, Denpasar Utara - Bali', '087809538080', 'Admin PB Bedahulu', '@pb_bedahulu', '@pb_bedahulu', 'pbbedahulu@gmail.com', 'pbbedahulu.my.id', 'logo-pbbedahulu.png', '2024-07-29 01:51:21');

-- --------------------------------------------------------

--
-- Table structure for table `court`
--

CREATE TABLE `court` (
  `id` int NOT NULL,
  `hall_id` int DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `type` enum('carpet','floor') NOT NULL,
  `price_per_hour` decimal(10,0) DEFAULT NULL,
  `price_per_month` decimal(10,0) DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `court`
--

INSERT INTO `court` (`id`, `hall_id`, `name`, `type`, `price_per_hour`, `price_per_month`, `user_id`, `createdAt`) VALUES
(1, 1, 'Court C - Atas', 'carpet', '60000', '350000', 1, '2024-07-29 01:51:22'),
(2, 1, 'Court D - Atas', 'carpet', '60000', '350000', 1, '2024-07-29 01:51:22'),
(3, 1, 'Court E - Atas', 'carpet', '60000', '350000', 1, '2024-07-29 01:51:22'),
(4, 1, 'Court A - Bawah', 'floor', '40000', '200000', 1, '2024-07-29 01:51:22'),
(5, 1, 'Court B - Bawah', 'floor', '40000', '200000', 1, '2024-07-29 01:51:22');

-- --------------------------------------------------------

--
-- Table structure for table `customers`
--

CREATE TABLE `customers` (
  `id` int NOT NULL,
  `customer_id_number` varchar(255) DEFAULT NULL,
  `customer_id_card` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `alias` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `pic` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) DEFAULT NULL,
  `account_id` int DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `customer_services`
--

CREATE TABLE `customer_services` (
  `id` int NOT NULL,
  `customer_id` int DEFAULT NULL,
  `subscription_date` datetime NOT NULL,
  `location_coordinate` varchar(255) DEFAULT NULL,
  `location_photo` varchar(255) DEFAULT NULL,
  `service_address` varchar(255) DEFAULT NULL,
  `service_district` varchar(255) DEFAULT NULL,
  `service_regency` varchar(255) DEFAULT NULL,
  `service_province` varchar(255) DEFAULT NULL,
  `odp_photo` varchar(255) DEFAULT NULL,
  `ont_photo` varchar(255) DEFAULT NULL,
  `rsl_photo` varchar(255) DEFAULT NULL,
  `service_order_id` int DEFAULT NULL,
  `product_id` int DEFAULT NULL,
  `sales_id` int DEFAULT NULL,
  `cluster_id` int DEFAULT NULL,
  `circuit_id` varchar(255) DEFAULT NULL,
  `rad_id` int DEFAULT NULL,
  `pppoe_user` varchar(255) DEFAULT NULL,
  `pppoe_pass` varchar(255) DEFAULT NULL,
  `sn_onu` varchar(255) DEFAULT NULL,
  `ont_type` varchar(255) DEFAULT NULL,
  `olt_id` int DEFAULT NULL,
  `bng_id` int DEFAULT NULL,
  `status` int DEFAULT NULL,
  `reactivation_date` datetime DEFAULT NULL,
  `notif` int DEFAULT NULL,
  `notif_token` varchar(255) DEFAULT NULL,
  `account_id` int DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `devices`
--

CREATE TABLE `devices` (
  `id` int NOT NULL,
  `hostname` varchar(255) DEFAULT NULL,
  `ip_address` varchar(255) DEFAULT NULL,
  `function` int DEFAULT NULL,
  `vendor` int DEFAULT NULL,
  `vendor_product_type` int DEFAULT NULL,
  `number_of_circuit_pon` int DEFAULT NULL,
  `snmp_community` int DEFAULT NULL,
  `snmp_version` varchar(255) DEFAULT NULL,
  `user_access` varchar(255) DEFAULT NULL,
  `password_access` varchar(255) DEFAULT NULL,
  `remote_protocol` varchar(255) DEFAULT NULL,
  `remote_data` varchar(255) DEFAULT NULL,
  `parent` int DEFAULT NULL,
  `desc` varchar(255) DEFAULT NULL,
  `account_id` int DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hall`
--

CREATE TABLE `hall` (
  `id` int NOT NULL,
  `name` varchar(255) NOT NULL,
  `address` text,
  `location_coordinate` varchar(255) DEFAULT NULL,
  `contact` varchar(20) DEFAULT NULL,
  `pic` varchar(255) DEFAULT NULL,
  `court_count` int NOT NULL,
  `price_per_hour` decimal(10,2) DEFAULT NULL,
  `price_per_month` decimal(10,2) DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `hall`
--

INSERT INTO `hall` (`id`, `name`, `address`, `location_coordinate`, `contact`, `pic`, `court_count`, `price_per_hour`, `price_per_month`, `user_id`, `createdAt`) VALUES
(1, 'Arena Badminton Center', 'Jl. Bedahulu X No. 17, Denpasar Utara - Bali', '-8.633194029888086, 115.21867358397054', 'Sutris', '085338258785', 5, '60000.00', '350000.00', 1, '2024-07-29 01:51:22');

-- --------------------------------------------------------

--
-- Table structure for table `invoice_customer`
--

CREATE TABLE `invoice_customer` (
  `id` int NOT NULL,
  `outbox` int DEFAULT NULL,
  `generate_id` varchar(255) DEFAULT NULL,
  `invoice_template_id` int DEFAULT NULL,
  `cut_off` datetime DEFAULT NULL,
  `due_date` datetime DEFAULT NULL,
  `bill_name` varchar(255) DEFAULT NULL,
  `period` varchar(255) DEFAULT NULL,
  `recurring` int DEFAULT NULL,
  `customer_service_id` int DEFAULT NULL,
  `customer_id` int DEFAULT NULL,
  `customer_id_number` varchar(255) DEFAULT NULL,
  `customer_id_card` varchar(255) DEFAULT NULL,
  `customer_name` varchar(255) DEFAULT NULL,
  `customer_alias` varchar(255) DEFAULT NULL,
  `customer_pic` varchar(255) DEFAULT NULL,
  `customer_phone` varchar(255) DEFAULT NULL,
  `customer_email` varchar(255) DEFAULT NULL,
  `subscription_date` datetime DEFAULT NULL,
  `location_coordinate` varchar(255) DEFAULT NULL,
  `location_photo` varchar(255) DEFAULT NULL,
  `service_address` varchar(255) DEFAULT NULL,
  `service_district` varchar(255) DEFAULT NULL,
  `service_regency` varchar(255) DEFAULT NULL,
  `service_province` varchar(255) DEFAULT NULL,
  `service_order_id` int DEFAULT NULL,
  `product_id` int DEFAULT NULL,
  `product_name` varchar(255) DEFAULT NULL,
  `product_price` int DEFAULT NULL,
  `product_limit` int DEFAULT NULL,
  `product_profile` varchar(255) DEFAULT NULL,
  `sales_id` int DEFAULT NULL,
  `sales_name` varchar(255) DEFAULT NULL,
  `cluster_id` int DEFAULT NULL,
  `cluster_name` varchar(255) DEFAULT NULL,
  `rad_id` int DEFAULT NULL,
  `radius_hostname` varchar(255) DEFAULT NULL,
  `radius_ip_address` varchar(255) DEFAULT NULL,
  `radius_template` varchar(255) DEFAULT NULL,
  `radius_user_access` varchar(255) DEFAULT NULL,
  `radius_password_access` varchar(255) DEFAULT NULL,
  `radius_remote_protocol` varchar(255) DEFAULT NULL,
  `radius_remote_data` varchar(255) DEFAULT NULL,
  `bng_id` int DEFAULT NULL,
  `bng_hostname` varchar(255) DEFAULT NULL,
  `bng_ip_address` varchar(255) DEFAULT NULL,
  `bng_template` varchar(255) DEFAULT NULL,
  `bng_user_access` varchar(255) DEFAULT NULL,
  `bng_password_access` varchar(255) DEFAULT NULL,
  `bng_remote_protocol` varchar(255) DEFAULT NULL,
  `bng_remote_data` varchar(255) DEFAULT NULL,
  `olt_id` int DEFAULT NULL,
  `olt_hostname` varchar(255) DEFAULT NULL,
  `olt_ip_address` varchar(255) DEFAULT NULL,
  `olt_template` varchar(255) DEFAULT NULL,
  `olt_user_access` varchar(255) DEFAULT NULL,
  `olt_password_access` varchar(255) DEFAULT NULL,
  `olt_remote_protocol` varchar(255) DEFAULT NULL,
  `olt_remote_data` varchar(255) DEFAULT NULL,
  `circuit_id` varchar(255) DEFAULT NULL,
  `notif_id` int DEFAULT NULL,
  `notif_server` varchar(255) DEFAULT NULL,
  `notif_token` varchar(255) DEFAULT NULL,
  `blast_wa_status` int DEFAULT NULL,
  `pppoe_user` varchar(255) DEFAULT NULL,
  `pppoe_pass` varchar(255) DEFAULT NULL,
  `sn_onu` varchar(255) DEFAULT NULL,
  `ont_type` int DEFAULT NULL,
  `ont_type_name` varchar(255) DEFAULT NULL,
  `customer_service_status` int DEFAULT NULL,
  `customer_service_status_name` varchar(255) DEFAULT NULL,
  `nominal` double DEFAULT NULL,
  `payment_date` datetime DEFAULT NULL,
  `suspend` int DEFAULT NULL,
  `status` int DEFAULT NULL,
  `account_id` int DEFAULT NULL,
  `account_name` varchar(255) DEFAULT NULL,
  `account_address` varchar(255) DEFAULT NULL,
  `account_phone` varchar(255) DEFAULT NULL,
  `account_email` varchar(255) DEFAULT NULL,
  `account_logo` varchar(255) DEFAULT NULL,
  `account_website` varchar(255) DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `invoice_template`
--

CREATE TABLE `invoice_template` (
  `id` int NOT NULL,
  `cut_off` int DEFAULT NULL,
  `due_date` int DEFAULT NULL,
  `bill_name` varchar(255) DEFAULT NULL,
  `period` int DEFAULT NULL,
  `recurring` int DEFAULT NULL,
  `account_id` int DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `log`
--

CREATE TABLE `log` (
  `id` int NOT NULL,
  `datetime` datetime NOT NULL,
  `activity` varchar(255) DEFAULT NULL,
  `description` json DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  `user_job` int DEFAULT NULL,
  `note` varchar(255) DEFAULT NULL,
  `account_id` int DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `log`
--

INSERT INTO `log` (`id`, `datetime`, `activity`, `description`, `user_id`, `user_job`, `note`, `account_id`, `createdAt`, `updatedAt`) VALUES
(1, '2024-07-29 10:15:10', 'Register', '\"{\\\"success\\\":true,\\\"statusCode\\\":200,\\\"message\\\":\\\"Register successfully\\\",\\\"query\\\":{\\\"name\\\":\\\"Relieyan Hilman\\\",\\\"contact\\\":\\\"081337126075\\\",\\\"privilege\\\":\\\"super admin\\\",\\\"username\\\":\\\"rian\\\",\\\"password\\\":\\\"pbbedahulu!\\\",\\\"community_id\\\":1},\\\"data\\\":{\\\"name\\\":\\\"Relieyan Hilman\\\",\\\"contact\\\":\\\"081337126075\\\",\\\"privilege\\\":\\\"super admin\\\",\\\"username\\\":\\\"rian\\\",\\\"password\\\":\\\"pbbedahulu!\\\",\\\"community_id\\\":1}}\"', 2, NULL, NULL, NULL, '2024-07-29 10:15:10', '2024-07-29 10:15:10'),
(2, '2024-07-29 10:22:38', 'Login', '\"{\\\"success\\\":true,\\\"statusCode\\\":200,\\\"message\\\":\\\"Login successfully\\\",\\\"query\\\":{\\\"username\\\":\\\"rian@pbbedahulu\\\",\\\"password\\\":\\\"pbbedahulu!\\\"},\\\"data\\\":{\\\"id\\\":2,\\\"name\\\":\\\"Relieyan Hilman\\\",\\\"username\\\":\\\"rian\\\",\\\"contact\\\":\\\"081337126075\\\",\\\"community_id\\\":1,\\\"community_name\\\":\\\"PB BEDAHULU\\\",\\\"community\\\":\\\"pbbedahulu\\\",\\\"token\\\":\\\"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MiwibmFtZSI6IlJlbGlleWFuIEhpbG1hbiIsImNvbnRhY3QiOiIwODEzMzcxMjYwNzUiLCJ1c2VybmFtZSI6InJpYW4iLCJjb21tdW5pdHlfaWQiOjEsImNvbW11bml0eV9uYW1lIjoiUEIgQkVEQUhVTFUiLCJjb21tdW5pdHkiOiJwYmJlZGFodWx1IiwiaWF0IjoxNzIyMjE5NzU4fQ.J8eQwx2gvWaJHccsF_KU3hdWdgRElhfop3WwlGYC1kY\\\"}}\"', 2, NULL, NULL, NULL, '2024-07-29 10:22:38', '2024-07-29 10:22:38'),
(3, '2024-07-29 10:23:19', 'Profile', '\"{\\\"success\\\":true,\\\"statusCode\\\":200,\\\"message\\\":\\\"Profile retrieved successfully\\\",\\\"query\\\":{},\\\"data\\\":{\\\"id\\\":2,\\\"name\\\":\\\"Relieyan Hilman\\\",\\\"contact\\\":\\\"081337126075\\\",\\\"username\\\":\\\"rian\\\",\\\"community_id\\\":1,\\\"community_name\\\":\\\"PB BEDAHULU\\\",\\\"community\\\":\\\"pbbedahulu\\\",\\\"iat\\\":1722219758}}\"', 2, NULL, NULL, NULL, '2024-07-29 10:23:19', '2024-07-29 10:23:19'),
(4, '2024-07-29 10:23:56', 'Login', '\"{\\\"success\\\":true,\\\"statusCode\\\":200,\\\"message\\\":\\\"Login successfully\\\",\\\"query\\\":{\\\"username\\\":\\\"admin@pbbedahulu\\\",\\\"password\\\":\\\"pbbedahulu!\\\"},\\\"data\\\":{\\\"id\\\":1,\\\"name\\\":\\\"Eggi Dwitama\\\",\\\"username\\\":\\\"admin\\\",\\\"contact\\\":\\\"085323085692\\\",\\\"community_id\\\":1,\\\"community_name\\\":\\\"PB BEDAHULU\\\",\\\"community\\\":\\\"pbbedahulu\\\",\\\"token\\\":\\\"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwibmFtZSI6IkVnZ2kgRHdpdGFtYSIsImNvbnRhY3QiOiIwODUzMjMwODU2OTIiLCJ1c2VybmFtZSI6ImFkbWluIiwiY29tbXVuaXR5X2lkIjoxLCJjb21tdW5pdHlfbmFtZSI6IlBCIEJFREFIVUxVIiwiY29tbXVuaXR5IjoicGJiZWRhaHVsdSIsImlhdCI6MTcyMjIxOTgzNn0.8Q8_iNYt3rrqeyzfIlrp-LyyUxBKhpCkW0K97XFBctU\\\"}}\"', 1, NULL, NULL, NULL, '2024-07-29 10:23:56', '2024-07-29 10:23:56'),
(5, '2024-07-29 10:24:09', 'Profile', '\"{\\\"success\\\":true,\\\"statusCode\\\":200,\\\"message\\\":\\\"Profile retrieved successfully\\\",\\\"query\\\":{},\\\"data\\\":{\\\"id\\\":1,\\\"name\\\":\\\"Eggi Dwitama\\\",\\\"contact\\\":\\\"085323085692\\\",\\\"username\\\":\\\"admin\\\",\\\"community_id\\\":1,\\\"community_name\\\":\\\"PB BEDAHULU\\\",\\\"community\\\":\\\"pbbedahulu\\\",\\\"iat\\\":1722219836}}\"', 1, NULL, NULL, NULL, '2024-07-29 10:24:09', '2024-07-29 10:24:09'),
(6, '2024-07-29 10:40:42', 'Login', '\"{\\\"success\\\":true,\\\"statusCode\\\":200,\\\"message\\\":\\\"Login successfully\\\",\\\"query\\\":{\\\"username\\\":\\\"admin@pbbedahulu\\\",\\\"password\\\":\\\"pbbedahulu!\\\"},\\\"data\\\":{\\\"id\\\":1,\\\"name\\\":\\\"Eggi Dwitama\\\",\\\"username\\\":\\\"admin\\\",\\\"contact\\\":\\\"085323085692\\\",\\\"community_id\\\":1,\\\"community_name\\\":\\\"PB BEDAHULU\\\",\\\"community\\\":\\\"pbbedahulu\\\",\\\"token\\\":\\\"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwibmFtZSI6IkVnZ2kgRHdpdGFtYSIsImNvbnRhY3QiOiIwODUzMjMwODU2OTIiLCJ1c2VybmFtZSI6ImFkbWluIiwiY29tbXVuaXR5Ijp7ImlkIjoxLCJ1c2VybmFtZSI6InBiYmVkYWh1bHUiLCJuYW1lIjoiUEIgQkVEQUhVTFUiLCJhZGRyZXNzIjoiSmwuIEJlZGFodWx1IFggTm8uIDE3LCBEZW5wYXNhciBVdGFyYSAtIEJhbGkiLCJjb250YWN0IjoiMDg3ODA5NTM4MDgwIiwicGljIjoiQWRtaW4gUEIgQmVkYWh1bHUiLCJpbnN0YWdyYW0iOiJAcGJfYmVkYWh1bHUiLCJ0aWt0b2siOiJAcGJfYmVkYWh1bHUiLCJlbWFpbCI6InBiYmVkYWh1bHVAZ21haWwuY29tIiwid2Vic2l0ZSI6InBiYmVkYWh1bHUubXkuaWQiLCJsb2dvIjoibG9nby1wYmJlZGFodWx1LnBuZyIsImNyZWF0ZWRBdCI6IjIwMjQtMDctMjlUMDE6NTE6MjEuMDAwWiIsInVwZGF0ZWRBdCI6IjIwMjQtMDctMjlUMDE6NTE6MjEuMDAwWiJ9LCJpYXQiOjE3MjIyMjA4NDJ9.kbUcU3pCqPqxEaFpS2_Z8XfKXRbJPpnjTt0fWq3DGPQ\\\"}}\"', 1, NULL, NULL, NULL, '2024-07-29 10:40:42', '2024-07-29 10:40:42'),
(7, '2024-07-29 10:41:09', 'Profile', '\"{\\\"success\\\":true,\\\"statusCode\\\":200,\\\"message\\\":\\\"Profile retrieved successfully\\\",\\\"query\\\":{},\\\"data\\\":{\\\"id\\\":1,\\\"name\\\":\\\"Eggi Dwitama\\\",\\\"contact\\\":\\\"085323085692\\\",\\\"username\\\":\\\"admin\\\",\\\"community\\\":{\\\"id\\\":1,\\\"username\\\":\\\"pbbedahulu\\\",\\\"name\\\":\\\"PB BEDAHULU\\\",\\\"address\\\":\\\"Jl. Bedahulu X No. 17, Denpasar Utara - Bali\\\",\\\"contact\\\":\\\"087809538080\\\",\\\"pic\\\":\\\"Admin PB Bedahulu\\\",\\\"instagram\\\":\\\"@pb_bedahulu\\\",\\\"tiktok\\\":\\\"@pb_bedahulu\\\",\\\"email\\\":\\\"pbbedahulu@gmail.com\\\",\\\"website\\\":\\\"pbbedahulu.my.id\\\",\\\"logo\\\":\\\"logo-pbbedahulu.png\\\",\\\"createdAt\\\":\\\"2024-07-29T01:51:21.000Z\\\",\\\"updatedAt\\\":\\\"2024-07-29T01:51:21.000Z\\\"},\\\"iat\\\":1722220842}}\"', 1, NULL, NULL, NULL, '2024-07-29 10:41:09', '2024-07-29 10:41:09'),
(8, '2024-07-29 12:18:52', 'Profile', '\"{\\\"success\\\":true,\\\"statusCode\\\":200,\\\"message\\\":\\\"Profile retrieved successfully\\\",\\\"query\\\":{},\\\"data\\\":{\\\"id\\\":1,\\\"name\\\":\\\"Eggi Dwitama\\\",\\\"contact\\\":\\\"085323085692\\\",\\\"username\\\":\\\"admin\\\",\\\"community\\\":{\\\"id\\\":1,\\\"username\\\":\\\"pbbedahulu\\\",\\\"name\\\":\\\"PB BEDAHULU\\\",\\\"address\\\":\\\"Jl. Bedahulu X No. 17, Denpasar Utara - Bali\\\",\\\"contact\\\":\\\"087809538080\\\",\\\"pic\\\":\\\"Admin PB Bedahulu\\\",\\\"instagram\\\":\\\"@pb_bedahulu\\\",\\\"tiktok\\\":\\\"@pb_bedahulu\\\",\\\"email\\\":\\\"pbbedahulu@gmail.com\\\",\\\"website\\\":\\\"pbbedahulu.my.id\\\",\\\"logo\\\":\\\"logo-pbbedahulu.png\\\",\\\"createdAt\\\":\\\"2024-07-29T01:51:21.000Z\\\",\\\"updatedAt\\\":\\\"2024-07-29T01:51:21.000Z\\\"},\\\"iat\\\":1722220842}}\"', 1, NULL, NULL, NULL, '2024-07-29 12:18:52', '2024-07-29 12:18:52'),
(9, '2024-07-29 12:20:21', 'Login', '\"{\\\"success\\\":true,\\\"statusCode\\\":200,\\\"message\\\":\\\"Login successfully\\\",\\\"query\\\":{\\\"username\\\":\\\"admin@pbbedahulu\\\",\\\"password\\\":\\\"pbbedahulu!\\\"},\\\"data\\\":{\\\"id\\\":1,\\\"name\\\":\\\"Eggi Dwitama\\\",\\\"username\\\":\\\"admin\\\",\\\"contact\\\":\\\"085323085692\\\",\\\"community_id\\\":1,\\\"community_name\\\":\\\"PB BEDAHULU\\\",\\\"community\\\":\\\"pbbedahulu\\\",\\\"token\\\":\\\"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwibmFtZSI6IkVnZ2kgRHdpdGFtYSIsImNvbnRhY3QiOiIwODUzMjMwODU2OTIiLCJ1c2VybmFtZSI6ImFkbWluIiwiY29tbXVuaXR5X2lkIjoxLCJjb21tdW5pdHkiOnsiaWQiOjEsInVzZXJuYW1lIjoicGJiZWRhaHVsdSIsIm5hbWUiOiJQQiBCRURBSFVMVSIsImFkZHJlc3MiOiJKbC4gQmVkYWh1bHUgWCBOby4gMTcsIERlbnBhc2FyIFV0YXJhIC0gQmFsaSIsImNvbnRhY3QiOiIwODc4MDk1MzgwODAiLCJwaWMiOiJBZG1pbiBQQiBCZWRhaHVsdSIsImluc3RhZ3JhbSI6IkBwYl9iZWRhaHVsdSIsInRpa3RvayI6IkBwYl9iZWRhaHVsdSIsImVtYWlsIjoicGJiZWRhaHVsdUBnbWFpbC5jb20iLCJ3ZWJzaXRlIjoicGJiZWRhaHVsdS5teS5pZCIsImxvZ28iOiJsb2dvLXBiYmVkYWh1bHUucG5nIiwiY3JlYXRlZEF0IjoiMjAyNC0wNy0yOVQwMTo1MToyMS4wMDBaIiwidXBkYXRlZEF0IjoiMjAyNC0wNy0yOVQwMTo1MToyMS4wMDBaIn0sImlhdCI6MTcyMjIyNjgyMX0.lOTxximP76JvRzkZILmPZG_3F58aQbaUHY-FgkhHEQ0\\\"}}\"', 1, NULL, NULL, NULL, '2024-07-29 12:20:21', '2024-07-29 12:20:21'),
(10, '2024-07-29 12:20:40', 'Profile', '\"{\\\"success\\\":true,\\\"statusCode\\\":200,\\\"message\\\":\\\"Profile retrieved successfully\\\",\\\"query\\\":{},\\\"data\\\":{\\\"id\\\":1,\\\"name\\\":\\\"Eggi Dwitama\\\",\\\"contact\\\":\\\"085323085692\\\",\\\"username\\\":\\\"admin\\\",\\\"community_id\\\":1,\\\"community\\\":{\\\"id\\\":1,\\\"username\\\":\\\"pbbedahulu\\\",\\\"name\\\":\\\"PB BEDAHULU\\\",\\\"address\\\":\\\"Jl. Bedahulu X No. 17, Denpasar Utara - Bali\\\",\\\"contact\\\":\\\"087809538080\\\",\\\"pic\\\":\\\"Admin PB Bedahulu\\\",\\\"instagram\\\":\\\"@pb_bedahulu\\\",\\\"tiktok\\\":\\\"@pb_bedahulu\\\",\\\"email\\\":\\\"pbbedahulu@gmail.com\\\",\\\"website\\\":\\\"pbbedahulu.my.id\\\",\\\"logo\\\":\\\"logo-pbbedahulu.png\\\",\\\"createdAt\\\":\\\"2024-07-29T01:51:21.000Z\\\",\\\"updatedAt\\\":\\\"2024-07-29T01:51:21.000Z\\\"},\\\"iat\\\":1722226821}}\"', 1, NULL, NULL, NULL, '2024-07-29 12:20:40', '2024-07-29 12:20:40'),
(11, '2024-07-30 10:48:24', 'Profile', '\"{\\\"success\\\":true,\\\"statusCode\\\":200,\\\"message\\\":\\\"Profile retrieved successfully\\\",\\\"query\\\":{},\\\"data\\\":{\\\"id\\\":1,\\\"name\\\":\\\"Eggi Dwitama\\\",\\\"contact\\\":\\\"085323085692\\\",\\\"username\\\":\\\"admin\\\",\\\"community_id\\\":1,\\\"community\\\":{\\\"id\\\":1,\\\"username\\\":\\\"pbbedahulu\\\",\\\"name\\\":\\\"PB BEDAHULU\\\",\\\"address\\\":\\\"Jl. Bedahulu X No. 17, Denpasar Utara - Bali\\\",\\\"contact\\\":\\\"087809538080\\\",\\\"pic\\\":\\\"Admin PB Bedahulu\\\",\\\"instagram\\\":\\\"@pb_bedahulu\\\",\\\"tiktok\\\":\\\"@pb_bedahulu\\\",\\\"email\\\":\\\"pbbedahulu@gmail.com\\\",\\\"website\\\":\\\"pbbedahulu.my.id\\\",\\\"logo\\\":\\\"logo-pbbedahulu.png\\\",\\\"createdAt\\\":\\\"2024-07-29T01:51:21.000Z\\\",\\\"updatedAt\\\":\\\"2024-07-29T01:51:21.000Z\\\"},\\\"iat\\\":1722226821}}\"', 1, NULL, NULL, NULL, '2024-07-30 10:48:24', '2024-07-30 10:48:24'),
(12, '2024-07-30 11:07:54', 'Create Open Mabar', '\"{\\\"success\\\":true,\\\"statusCode\\\":200,\\\"message\\\":\\\"Open Mabar create successfully\\\",\\\"query\\\":{\\\"name\\\":\\\"Open Mabar Rabu\\\",\\\"hall_id\\\":1,\\\"day\\\":\\\"wed\\\",\\\"time\\\":\\\"19.00 - 21.00 WITA\\\",\\\"court_count_used\\\":2,\\\"max_slot\\\":20,\\\"htm_member\\\":25000,\\\"htm_nonmember\\\":30000},\\\"data\\\":{\\\"id\\\":2,\\\"name\\\":\\\"Open Mabar Rabu\\\",\\\"hall_id\\\":1,\\\"day\\\":\\\"wed\\\",\\\"time\\\":\\\"19.00 - 21.00 WITA\\\",\\\"max_slot\\\":20,\\\"htm_member\\\":25000,\\\"htm_nonmember\\\":30000,\\\"community_id\\\":1,\\\"user_id\\\":1}}\"', 1, NULL, NULL, NULL, '2024-07-30 11:07:54', '2024-07-30 11:07:54'),
(13, '2024-07-30 11:16:18', 'Update Open Mabar', '\"{\\\"success\\\":true,\\\"statusCode\\\":200,\\\"message\\\":\\\"Open Mabar update successfully\\\",\\\"query\\\":{\\\"id\\\":2,\\\"name\\\":\\\"Open Mabar Rabu\\\",\\\"hall_id\\\":1,\\\"day\\\":\\\"wed\\\",\\\"time\\\":\\\"19.00 - 22.00 WITA\\\",\\\"court_count_used\\\":3,\\\"max_slot\\\":22,\\\"htm_member\\\":27000,\\\"htm_nonmember\\\":37000},\\\"data\\\":{\\\"id\\\":2,\\\"community_id\\\":1,\\\"name\\\":\\\"Open Mabar Rabu\\\",\\\"hall_id\\\":1,\\\"day\\\":\\\"wed\\\",\\\"time\\\":\\\"19.00 - 22.00 WITA\\\",\\\"court_count_used\\\":2,\\\"max_slot\\\":22,\\\"htm_member\\\":\\\"27000.00\\\",\\\"htm_nonmember\\\":\\\"37000.00\\\",\\\"note\\\":null,\\\"user_id\\\":1}}\"', 1, NULL, NULL, NULL, '2024-07-30 11:16:18', '2024-07-30 11:16:18'),
(14, '2024-07-30 11:16:38', 'Update Open Mabar', '\"{\\\"success\\\":true,\\\"statusCode\\\":200,\\\"message\\\":\\\"Open Mabar update successfully\\\",\\\"query\\\":{\\\"id\\\":2,\\\"name\\\":\\\"Open Mabar Rabu\\\",\\\"hall_id\\\":1,\\\"day\\\":\\\"wed\\\",\\\"time\\\":\\\"19.00 - 21.00 WITA\\\",\\\"court_count_used\\\":2,\\\"max_slot\\\":20,\\\"htm_member\\\":25000,\\\"htm_nonmember\\\":30000},\\\"data\\\":{\\\"id\\\":2,\\\"community_id\\\":1,\\\"name\\\":\\\"Open Mabar Rabu\\\",\\\"hall_id\\\":1,\\\"day\\\":\\\"wed\\\",\\\"time\\\":\\\"19.00 - 21.00 WITA\\\",\\\"court_count_used\\\":2,\\\"max_slot\\\":20,\\\"htm_member\\\":\\\"25000.00\\\",\\\"htm_nonmember\\\":\\\"30000.00\\\",\\\"note\\\":null,\\\"user_id\\\":1}}\"', 1, NULL, NULL, NULL, '2024-07-30 11:16:38', '2024-07-30 11:16:38'),
(15, '2024-07-30 11:26:30', 'Create Open Mabar Day', '\"{\\\"success\\\":true,\\\"statusCode\\\":200,\\\"message\\\":\\\"Open Mabar Day create successfully\\\",\\\"query\\\":{\\\"open_mabar_id\\\":1,\\\"date\\\":\\\"2024-08-06\\\",\\\"note\\\":\\\"sesi 1 bulan agustus 2024\\\"},\\\"data\\\":{\\\"id\\\":2,\\\"open_mabar_id\\\":1,\\\"date\\\":\\\"2024-08-06\\\",\\\"note\\\":\\\"sesi 1 bulan agustus 2024\\\",\\\"user_id\\\":1}}\"', 1, NULL, NULL, NULL, '2024-07-30 11:26:30', '2024-07-30 11:26:30'),
(16, '2024-07-30 11:28:31', 'Update Open Mabar', '\"{\\\"success\\\":true,\\\"statusCode\\\":200,\\\"message\\\":\\\"Open Mabar Day update successfully\\\",\\\"query\\\":{\\\"id\\\":2,\\\"open_mabar_id\\\":1,\\\"date\\\":\\\"2024-08-07\\\",\\\"note\\\":\\\"Sesi 1 Bulan Agustus 2024\\\"},\\\"data\\\":{\\\"id\\\":2,\\\"open_mabar_id\\\":1,\\\"date\\\":\\\"2024-08-07\\\",\\\"note\\\":\\\"Sesi 1 Bulan Agustus 2024\\\",\\\"user_id\\\":1}}\"', 1, NULL, NULL, NULL, '2024-07-30 11:28:31', '2024-07-30 11:28:31'),
(17, '2024-07-30 11:28:38', 'Update Open Mabar', '\"{\\\"success\\\":true,\\\"statusCode\\\":200,\\\"message\\\":\\\"Open Mabar Day update successfully\\\",\\\"query\\\":{\\\"id\\\":2,\\\"open_mabar_id\\\":1,\\\"date\\\":\\\"2024-08-06\\\",\\\"note\\\":\\\"Sesi 1 Bulan Agustus 2024\\\"},\\\"data\\\":{\\\"id\\\":2,\\\"open_mabar_id\\\":1,\\\"date\\\":\\\"2024-08-06\\\",\\\"note\\\":\\\"Sesi 1 Bulan Agustus 2024\\\",\\\"user_id\\\":1}}\"', 1, NULL, NULL, NULL, '2024-07-30 11:28:38', '2024-07-30 11:28:38'),
(18, '2024-07-30 11:44:04', 'Create Player', '\"{\\\"success\\\":true,\\\"statusCode\\\":200,\\\"message\\\":\\\"Player create successfully\\\",\\\"query\\\":{\\\"name\\\":\\\"Nyoman Sudarma\\\",\\\"alias\\\":\\\"nyoman s\\\",\\\"username\\\":\\\"nyoman201\\\",\\\"gender\\\":\\\"M\\\",\\\"contact\\\":\\\"081238458201\\\",\\\"level\\\":\\\"B\\\",\\\"age_range\\\":\\\"51-60\\\"},\\\"data\\\":{\\\"id\\\":13,\\\"name\\\":\\\"Nyoman Sudarma\\\",\\\"alias\\\":\\\"nyoman s\\\",\\\"username\\\":\\\"nyoman201\\\",\\\"gender\\\":\\\"M\\\",\\\"contact\\\":\\\"081238458201\\\",\\\"level\\\":\\\"B\\\",\\\"age_range\\\":\\\"51-60\\\",\\\"user_id\\\":1}}\"', 1, NULL, NULL, NULL, '2024-07-30 11:44:04', '2024-07-30 11:44:04'),
(19, '2024-07-30 11:47:24', 'Update Player', '\"{\\\"success\\\":true,\\\"statusCode\\\":200,\\\"message\\\":\\\"Player update successfully\\\",\\\"query\\\":{\\\"id\\\":13,\\\"name\\\":\\\"Nyoman Sudarma\\\",\\\"alias\\\":\\\"nyoman s\\\",\\\"username\\\":\\\"nyoman201\\\",\\\"gender\\\":\\\"M\\\",\\\"contact\\\":\\\"081238458201\\\",\\\"level\\\":\\\"B\\\",\\\"age_range\\\":\\\"51-60\\\"},\\\"data\\\":{\\\"id\\\":13,\\\"name\\\":\\\"Nyoman Sudarma\\\",\\\"alias\\\":\\\"nyoman s\\\",\\\"username\\\":\\\"nyoman201\\\",\\\"gender\\\":\\\"M\\\",\\\"contact\\\":\\\"081238458201\\\",\\\"level\\\":\\\"B\\\",\\\"age_range\\\":\\\"51-60\\\",\\\"user_id\\\":1}}\"', 1, NULL, NULL, NULL, '2024-07-30 11:47:24', '2024-07-30 11:47:24'),
(20, '2024-07-30 14:10:38', 'Create Open Mabar Day Detail', '\"{\\\"success\\\":true,\\\"statusCode\\\":200,\\\"message\\\":\\\"Open Mabar Day Detail create successfully\\\",\\\"query\\\":{\\\"open_mabar_day_id\\\":1,\\\"player_id\\\":13,\\\"player_level\\\":\\\"B\\\",\\\"payment_status\\\":\\\"paid\\\"},\\\"data\\\":{\\\"id\\\":15,\\\"open_mabar_day_id\\\":1,\\\"player_id\\\":13,\\\"player_level\\\":\\\"B\\\",\\\"payment_status\\\":\\\"paid\\\",\\\"user_id\\\":1}}\"', 1, NULL, NULL, NULL, '2024-07-30 14:10:38', '2024-07-30 14:10:38'),
(21, '2024-07-30 14:30:05', 'Create Player', '\"{\\\"success\\\":true,\\\"statusCode\\\":200,\\\"message\\\":\\\"Player create successfully\\\",\\\"query\\\":{\\\"name\\\":\\\"Kelvin P\\\",\\\"alias\\\":\\\"kelvin\\\",\\\"username\\\":\\\"kelvin978\\\",\\\"gender\\\":\\\"M\\\",\\\"contact\\\":\\\"087863088978\\\",\\\"level\\\":\\\"A\\\",\\\"age_range\\\":\\\"31-40\\\"},\\\"data\\\":{\\\"id\\\":14,\\\"name\\\":\\\"Kelvin P\\\",\\\"alias\\\":\\\"kelvin\\\",\\\"username\\\":\\\"kelvin978\\\",\\\"gender\\\":\\\"M\\\",\\\"contact\\\":\\\"087863088978\\\",\\\"level\\\":\\\"A\\\",\\\"age_range\\\":\\\"31-40\\\",\\\"user_id\\\":1}}\"', 1, NULL, NULL, NULL, '2024-07-30 14:30:05', '2024-07-30 14:30:05'),
(22, '2024-07-30 14:30:49', 'Create Open Mabar Day Detail', '\"{\\\"success\\\":true,\\\"statusCode\\\":200,\\\"message\\\":\\\"Open Mabar Day Detail create successfully\\\",\\\"query\\\":{\\\"open_mabar_day_id\\\":1,\\\"player_id\\\":14,\\\"player_level\\\":\\\"A\\\",\\\"payment_status\\\":\\\"paid\\\",\\\"player_status\\\":\\\"member\\\",\\\"note\\\":\\\"\\\"},\\\"data\\\":{\\\"id\\\":16,\\\"open_mabar_day_id\\\":1,\\\"player_id\\\":14,\\\"player_level\\\":\\\"A\\\",\\\"payment_status\\\":\\\"paid\\\",\\\"user_id\\\":1}}\"', 1, NULL, NULL, NULL, '2024-07-30 14:30:49', '2024-07-30 14:30:49'),
(23, '2024-07-30 14:31:44', 'Create Player', '\"{\\\"success\\\":true,\\\"statusCode\\\":200,\\\"message\\\":\\\"Player create successfully\\\",\\\"query\\\":{\\\"name\\\":\\\"Dika\\\",\\\"alias\\\":\\\"dika\\\",\\\"username\\\":\\\"dika400\\\",\\\"gender\\\":\\\"M\\\",\\\"contact\\\":\\\"085961160400\\\",\\\"level\\\":\\\"A\\\",\\\"age_range\\\":\\\"31-40\\\"},\\\"data\\\":{\\\"id\\\":15,\\\"name\\\":\\\"Dika\\\",\\\"alias\\\":\\\"dika\\\",\\\"username\\\":\\\"dika400\\\",\\\"gender\\\":\\\"M\\\",\\\"contact\\\":\\\"085961160400\\\",\\\"level\\\":\\\"A\\\",\\\"age_range\\\":\\\"31-40\\\",\\\"user_id\\\":1}}\"', 1, NULL, NULL, NULL, '2024-07-30 14:31:44', '2024-07-30 14:31:44'),
(24, '2024-07-30 14:32:54', 'Create Open Mabar Player', '\"{\\\"success\\\":true,\\\"statusCode\\\":200,\\\"message\\\":\\\"Open Mabar Player create successfully\\\",\\\"query\\\":{\\\"open_mabar_id\\\":1,\\\"player_id\\\":15,\\\"status\\\":\\\"member\\\",\\\"note\\\":\\\"\\\"},\\\"data\\\":{\\\"id\\\":15,\\\"open_mabar_id\\\":1,\\\"player_id\\\":15,\\\"status\\\":\\\"member\\\",\\\"note\\\":\\\"\\\",\\\"user_id\\\":1}}\"', 1, NULL, NULL, NULL, '2024-07-30 14:32:54', '2024-07-30 14:32:54'),
(25, '2024-07-30 14:33:16', 'Create Open Mabar Day Detail', '\"{\\\"success\\\":true,\\\"statusCode\\\":200,\\\"message\\\":\\\"Open Mabar Day Detail create successfully\\\",\\\"query\\\":{\\\"open_mabar_day_id\\\":1,\\\"player_id\\\":15,\\\"player_level\\\":\\\"A\\\",\\\"payment_status\\\":\\\"paid\\\",\\\"player_status\\\":\\\"member\\\",\\\"note\\\":\\\"\\\"},\\\"data\\\":{\\\"id\\\":17,\\\"open_mabar_day_id\\\":1,\\\"player_id\\\":15,\\\"player_level\\\":\\\"A\\\",\\\"payment_status\\\":\\\"paid\\\",\\\"user_id\\\":1}}\"', 1, NULL, NULL, NULL, '2024-07-30 14:33:16', '2024-07-30 14:33:16'),
(26, '2024-07-30 14:43:06', 'Create Player', '\"{\\\"success\\\":true,\\\"statusCode\\\":200,\\\"message\\\":\\\"Player create successfully\\\",\\\"query\\\":{\\\"name\\\":\\\"Satria\\\",\\\"alias\\\":\\\"satria\\\",\\\"username\\\":\\\"satria556\\\",\\\"gender\\\":\\\"M\\\",\\\"contact\\\":\\\"081805395556\\\",\\\"level\\\":\\\"A\\\",\\\"age_range\\\":\\\"41-50\\\"},\\\"data\\\":{\\\"id\\\":16,\\\"name\\\":\\\"Satria\\\",\\\"alias\\\":\\\"satria\\\",\\\"username\\\":\\\"satria556\\\",\\\"gender\\\":\\\"M\\\",\\\"contact\\\":\\\"081805395556\\\",\\\"level\\\":\\\"A\\\",\\\"age_range\\\":\\\"41-50\\\",\\\"user_id\\\":1}}\"', 1, NULL, NULL, NULL, '2024-07-30 14:43:06', '2024-07-30 14:43:06'),
(27, '2024-07-30 14:44:18', 'Update Open Mabar Day Detail', '\"{\\\"success\\\":true,\\\"statusCode\\\":200,\\\"message\\\":\\\"Open Mabar Day Detail update successfully\\\",\\\"query\\\":{\\\"id\\\":17,\\\"open_mabar_day_id\\\":1,\\\"player_id\\\":16,\\\"player_level\\\":\\\"A\\\",\\\"payment_status\\\":\\\"paid\\\",\\\"player_status\\\":\\\"member\\\",\\\"note\\\":\\\"\\\"},\\\"data\\\":{\\\"id\\\":17,\\\"open_mabar_day_id\\\":1,\\\"player_id\\\":16,\\\"player_level\\\":\\\"A\\\",\\\"player_arrival_time\\\":\\\"2024-07-30T12:33:16.000Z\\\",\\\"payment_status\\\":\\\"paid\\\",\\\"user_id\\\":1}}\"', 1, NULL, NULL, NULL, '2024-07-30 14:44:18', '2024-07-30 14:44:18'),
(28, '2024-07-30 14:44:25', 'Update Open Mabar Day Detail', '\"{\\\"success\\\":true,\\\"statusCode\\\":200,\\\"message\\\":\\\"Open Mabar Day Detail update successfully\\\",\\\"query\\\":{\\\"id\\\":17,\\\"open_mabar_day_id\\\":1,\\\"player_id\\\":15,\\\"player_level\\\":\\\"A\\\",\\\"payment_status\\\":\\\"paid\\\",\\\"player_status\\\":\\\"member\\\",\\\"note\\\":\\\"\\\"},\\\"data\\\":{\\\"id\\\":17,\\\"open_mabar_day_id\\\":1,\\\"player_id\\\":15,\\\"player_level\\\":\\\"A\\\",\\\"player_arrival_time\\\":\\\"2024-07-30T12:33:16.000Z\\\",\\\"payment_status\\\":\\\"paid\\\",\\\"user_id\\\":1}}\"', 1, NULL, NULL, NULL, '2024-07-30 14:44:25', '2024-07-30 14:44:25'),
(29, '2024-07-30 15:29:35', 'Create Open Mabar Day Match ', '\"{\\\"success\\\":true,\\\"statusCode\\\":200,\\\"message\\\":\\\"Open Mabar Day  Match create successfully\\\",\\\"query\\\":{\\\"open_mabar_day_id\\\":1,\\\"court_id\\\":1,\\\"player_id_a1\\\":13,\\\"player_level_a1\\\":\\\"B\\\",\\\"player_id_a2\\\":14,\\\"player_level_a2\\\":\\\"A\\\",\\\"player_id_b1\\\":15,\\\"player_level_b1\\\":\\\"A\\\",\\\"player_id_b2\\\":16,\\\"player_level_b2\\\":\\\"A\\\",\\\"start_time\\\":\\\"20:05:00\\\",\\\"note\\\":\\\"\\\"},\\\"data\\\":{\\\"id\\\":5,\\\"open_mabar_day_id\\\":1,\\\"court_id\\\":1,\\\"player_id_a1\\\":13,\\\"player_level_a1\\\":\\\"B\\\",\\\"player_id_a2\\\":14,\\\"player_level_a2\\\":\\\"A\\\",\\\"player_id_b1\\\":15,\\\"player_level_b1\\\":\\\"A\\\",\\\"player_id_b2\\\":16,\\\"player_level_b2\\\":\\\"A\\\",\\\"start_time\\\":\\\"20:05:00\\\",\\\"note\\\":\\\"\\\",\\\"user_id\\\":1}}\"', 1, NULL, NULL, NULL, '2024-07-30 15:29:35', '2024-07-30 15:29:35'),
(30, '2024-07-30 15:38:19', 'Update Open Mabar Match', '\"{\\\"success\\\":true,\\\"statusCode\\\":200,\\\"message\\\":\\\"Open Mabar Match update successfully\\\",\\\"query\\\":{\\\"id\\\":5,\\\"open_mabar_day_id\\\":1,\\\"court_id\\\":1,\\\"player_id_a1\\\":13,\\\"player_level_a1\\\":\\\"B\\\",\\\"player_id_a2\\\":14,\\\"player_level_a2\\\":\\\"A\\\",\\\"player_id_b1\\\":15,\\\"player_level_b1\\\":\\\"A\\\",\\\"player_id_b2\\\":16,\\\"player_level_b2\\\":\\\"A\\\",\\\"start_time\\\":\\\"20:05:00\\\",\\\"end_time\\\":\\\"20:30:00\\\",\\\"score\\\":\\\"42-38\\\",\\\"shuttlecock_used\\\":\\\"1\\\",\\\"note\\\":\\\"\\\"},\\\"data\\\":{\\\"id\\\":5,\\\"open_mabar_day_id\\\":1,\\\"court_id\\\":1,\\\"player_id_a1\\\":13,\\\"player_level_a1\\\":\\\"B\\\",\\\"player_id_a2\\\":14,\\\"player_level_a2\\\":\\\"A\\\",\\\"player_id_b1\\\":15,\\\"player_level_b1\\\":\\\"A\\\",\\\"player_id_b2\\\":16,\\\"player_level_b2\\\":\\\"A\\\",\\\"start_time\\\":\\\"20:05:00\\\",\\\"end_time\\\":\\\"20:30:00\\\",\\\"score\\\":\\\"42-38\\\",\\\"shuttlecock_used\\\":1,\\\"note\\\":\\\"\\\",\\\"user_id\\\":1}}\"', 1, NULL, NULL, NULL, '2024-07-30 15:38:19', '2024-07-30 15:38:19'),
(31, '2024-07-30 16:27:06', 'Create Player', '\"{\\\"success\\\":true,\\\"statusCode\\\":200,\\\"message\\\":\\\"Player create successfully\\\",\\\"query\\\":{\\\"name\\\":\\\"Ngurah JB\\\",\\\"alias\\\":\\\"ajik\\\",\\\"username\\\":\\\"ajik227\\\",\\\"gender\\\":\\\"M\\\",\\\"contact\\\":\\\"081337569227\\\",\\\"level\\\":\\\"B\\\",\\\"age_range\\\":\\\"41-50\\\"},\\\"data\\\":{\\\"id\\\":17,\\\"name\\\":\\\"Ngurah JB\\\",\\\"alias\\\":\\\"ajik\\\",\\\"username\\\":\\\"ajik227\\\",\\\"gender\\\":\\\"M\\\",\\\"contact\\\":\\\"081337569227\\\",\\\"level\\\":\\\"B\\\",\\\"age_range\\\":\\\"41-50\\\",\\\"user_id\\\":1}}\"', 1, NULL, NULL, NULL, '2024-07-30 16:27:06', '2024-07-30 16:27:06'),
(32, '2024-07-30 16:27:52', 'Create Player', '\"{\\\"success\\\":true,\\\"statusCode\\\":200,\\\"message\\\":\\\"Player create successfully\\\",\\\"query\\\":{\\\"name\\\":\\\"Putu Adi\\\",\\\"alias\\\":\\\"putu adi\\\",\\\"username\\\":\\\"putuadi390\\\",\\\"gender\\\":\\\"M\\\",\\\"contact\\\":\\\"081805612390\\\",\\\"level\\\":\\\"B\\\",\\\"age_range\\\":\\\"41-50\\\"},\\\"data\\\":{\\\"id\\\":18,\\\"name\\\":\\\"Putu Adi\\\",\\\"alias\\\":\\\"putu adi\\\",\\\"username\\\":\\\"putuadi390\\\",\\\"gender\\\":\\\"M\\\",\\\"contact\\\":\\\"081805612390\\\",\\\"level\\\":\\\"B\\\",\\\"age_range\\\":\\\"41-50\\\",\\\"user_id\\\":1}}\"', 1, NULL, NULL, NULL, '2024-07-30 16:27:52', '2024-07-30 16:27:52'),
(33, '2024-07-30 16:28:41', 'Create Player', '\"{\\\"success\\\":true,\\\"statusCode\\\":200,\\\"message\\\":\\\"Player create successfully\\\",\\\"query\\\":{\\\"name\\\":\\\"Donny\\\",\\\"alias\\\":\\\"donny maybank\\\",\\\"username\\\":\\\"donny043\\\",\\\"gender\\\":\\\"M\\\",\\\"contact\\\":\\\"08123874043\\\",\\\"level\\\":\\\"A\\\",\\\"age_range\\\":\\\"41-50\\\"},\\\"data\\\":{\\\"id\\\":19,\\\"name\\\":\\\"Donny\\\",\\\"alias\\\":\\\"donny maybank\\\",\\\"username\\\":\\\"donny043\\\",\\\"gender\\\":\\\"M\\\",\\\"contact\\\":\\\"08123874043\\\",\\\"level\\\":\\\"A\\\",\\\"age_range\\\":\\\"41-50\\\",\\\"user_id\\\":1}}\"', 1, NULL, NULL, NULL, '2024-07-30 16:28:41', '2024-07-30 16:28:41'),
(34, '2024-07-30 16:29:54', 'Create Player', '\"{\\\"success\\\":true,\\\"statusCode\\\":200,\\\"message\\\":\\\"Player create successfully\\\",\\\"query\\\":{\\\"name\\\":\\\"Fajar Pradnyana\\\",\\\"alias\\\":\\\"fajar\\\",\\\"username\\\":\\\"imfpradnyana431\\\",\\\"gender\\\":\\\"M\\\",\\\"contact\\\":\\\"081236638431\\\",\\\"level\\\":\\\"B\\\",\\\"age_range\\\":\\\"21-30\\\"},\\\"data\\\":{\\\"id\\\":20,\\\"name\\\":\\\"Fajar Pradnyana\\\",\\\"alias\\\":\\\"fajar\\\",\\\"username\\\":\\\"imfpradnyana431\\\",\\\"gender\\\":\\\"M\\\",\\\"contact\\\":\\\"081236638431\\\",\\\"level\\\":\\\"B\\\",\\\"age_range\\\":\\\"21-30\\\",\\\"user_id\\\":1}}\"', 1, NULL, NULL, NULL, '2024-07-30 16:29:54', '2024-07-30 16:29:54'),
(35, '2024-07-30 16:30:43', 'Create Player', '\"{\\\"success\\\":true,\\\"statusCode\\\":200,\\\"message\\\":\\\"Player create successfully\\\",\\\"query\\\":{\\\"name\\\":\\\"Dendy\\\",\\\"alias\\\":\\\"ko dendy\\\",\\\"username\\\":\\\"dendy907\\\",\\\"gender\\\":\\\"M\\\",\\\"contact\\\":\\\"082233009907\\\",\\\"level\\\":\\\"A\\\",\\\"age_range\\\":\\\"41-50\\\"},\\\"data\\\":{\\\"id\\\":21,\\\"name\\\":\\\"Dendy\\\",\\\"alias\\\":\\\"ko dendy\\\",\\\"username\\\":\\\"dendy907\\\",\\\"gender\\\":\\\"M\\\",\\\"contact\\\":\\\"082233009907\\\",\\\"level\\\":\\\"A\\\",\\\"age_range\\\":\\\"41-50\\\",\\\"user_id\\\":1}}\"', 1, NULL, NULL, NULL, '2024-07-30 16:30:43', '2024-07-30 16:30:43'),
(36, '2024-07-30 16:31:30', 'Create Player', '\"{\\\"success\\\":true,\\\"statusCode\\\":200,\\\"message\\\":\\\"Player create successfully\\\",\\\"query\\\":{\\\"name\\\":\\\"Nyoman Adi\\\",\\\"alias\\\":\\\"nyoman TJ\\\",\\\"username\\\":\\\"manadi008\\\",\\\"gender\\\":\\\"M\\\",\\\"contact\\\":\\\"081246529008\\\",\\\"level\\\":\\\"A\\\",\\\"age_range\\\":\\\"41-50\\\"},\\\"data\\\":{\\\"id\\\":22,\\\"name\\\":\\\"Nyoman Adi\\\",\\\"alias\\\":\\\"nyoman TJ\\\",\\\"username\\\":\\\"manadi008\\\",\\\"gender\\\":\\\"M\\\",\\\"contact\\\":\\\"081246529008\\\",\\\"level\\\":\\\"A\\\",\\\"age_range\\\":\\\"41-50\\\",\\\"user_id\\\":1}}\"', 1, NULL, NULL, NULL, '2024-07-30 16:31:30', '2024-07-30 16:31:30'),
(37, '2024-07-30 16:32:26', 'Create Player', '\"{\\\"success\\\":true,\\\"statusCode\\\":200,\\\"message\\\":\\\"Player create successfully\\\",\\\"query\\\":{\\\"name\\\":\\\"Mandra\\\",\\\"alias\\\":\\\"mandra\\\",\\\"username\\\":\\\"mandra052\\\",\\\"gender\\\":\\\"M\\\",\\\"contact\\\":\\\"085103543052\\\",\\\"level\\\":\\\"A\\\",\\\"age_range\\\":\\\"51-60\\\"},\\\"data\\\":{\\\"id\\\":23,\\\"name\\\":\\\"Mandra\\\",\\\"alias\\\":\\\"mandra\\\",\\\"username\\\":\\\"mandra052\\\",\\\"gender\\\":\\\"M\\\",\\\"contact\\\":\\\"085103543052\\\",\\\"level\\\":\\\"A\\\",\\\"age_range\\\":\\\"51-60\\\",\\\"user_id\\\":1}}\"', 1, NULL, NULL, NULL, '2024-07-30 16:32:26', '2024-07-30 16:32:26'),
(38, '2024-07-30 16:33:14', 'Create Player', '\"{\\\"success\\\":true,\\\"statusCode\\\":200,\\\"message\\\":\\\"Player create successfully\\\",\\\"query\\\":{\\\"name\\\":\\\"Arya\\\",\\\"alias\\\":\\\"arya bni\\\",\\\"username\\\":\\\"arya738\\\",\\\"gender\\\":\\\"M\\\",\\\"contact\\\":\\\"08124678738\\\",\\\"level\\\":\\\"B\\\",\\\"age_range\\\":\\\"51-60\\\"},\\\"data\\\":{\\\"id\\\":24,\\\"name\\\":\\\"Arya\\\",\\\"alias\\\":\\\"arya bni\\\",\\\"username\\\":\\\"arya738\\\",\\\"gender\\\":\\\"M\\\",\\\"contact\\\":\\\"08124678738\\\",\\\"level\\\":\\\"B\\\",\\\"age_range\\\":\\\"51-60\\\",\\\"user_id\\\":1}}\"', 1, NULL, NULL, NULL, '2024-07-30 16:33:14', '2024-07-30 16:33:14'),
(39, '2024-07-30 16:34:25', 'Create Player', '\"{\\\"success\\\":true,\\\"statusCode\\\":200,\\\"message\\\":\\\"Player create successfully\\\",\\\"query\\\":{\\\"name\\\":\\\"Wayan\\\",\\\"alias\\\":\\\"wayan tato\\\",\\\"username\\\":\\\"wayan062\\\",\\\"gender\\\":\\\"M\\\",\\\"contact\\\":\\\"085792386062\\\",\\\"level\\\":\\\"A\\\",\\\"age_range\\\":\\\"31-40\\\"},\\\"data\\\":{\\\"id\\\":25,\\\"name\\\":\\\"Wayan\\\",\\\"alias\\\":\\\"wayan tato\\\",\\\"username\\\":\\\"wayan062\\\",\\\"gender\\\":\\\"M\\\",\\\"contact\\\":\\\"085792386062\\\",\\\"level\\\":\\\"A\\\",\\\"age_range\\\":\\\"31-40\\\",\\\"user_id\\\":1}}\"', 1, NULL, NULL, NULL, '2024-07-30 16:34:25', '2024-07-30 16:34:25'),
(40, '2024-07-30 16:35:10', 'Create Player', '\"{\\\"success\\\":true,\\\"statusCode\\\":200,\\\"message\\\":\\\"Player create successfully\\\",\\\"query\\\":{\\\"name\\\":\\\"Wayan Suwarna\\\",\\\"alias\\\":\\\"wayan suwarna\\\",\\\"username\\\":\\\"suwarna750\\\",\\\"gender\\\":\\\"M\\\",\\\"contact\\\":\\\"081338600750\\\",\\\"level\\\":\\\"A\\\",\\\"age_range\\\":\\\"41-50\\\"},\\\"data\\\":{\\\"id\\\":26,\\\"name\\\":\\\"Wayan Suwarna\\\",\\\"alias\\\":\\\"wayan suwarna\\\",\\\"username\\\":\\\"suwarna750\\\",\\\"gender\\\":\\\"M\\\",\\\"contact\\\":\\\"081338600750\\\",\\\"level\\\":\\\"A\\\",\\\"age_range\\\":\\\"41-50\\\",\\\"user_id\\\":1}}\"', 1, NULL, NULL, NULL, '2024-07-30 16:35:10', '2024-07-30 16:35:10'),
(41, '2024-07-30 16:36:13', 'Create Open Mabar Day Detail', '\"{\\\"success\\\":true,\\\"statusCode\\\":200,\\\"message\\\":\\\"Open Mabar Day Detail create successfully\\\",\\\"query\\\":{\\\"open_mabar_day_id\\\":1,\\\"player_id\\\":17,\\\"player_level\\\":\\\"B\\\",\\\"payment_status\\\":\\\"paid\\\",\\\"player_status\\\":\\\"member\\\",\\\"note\\\":\\\"\\\"},\\\"data\\\":{\\\"id\\\":18,\\\"open_mabar_day_id\\\":1,\\\"player_id\\\":17,\\\"player_level\\\":\\\"B\\\",\\\"payment_status\\\":\\\"paid\\\",\\\"user_id\\\":1}}\"', 1, NULL, NULL, NULL, '2024-07-30 16:36:13', '2024-07-30 16:36:13'),
(42, '2024-07-30 16:36:20', 'Create Open Mabar Day Detail', '\"{\\\"success\\\":true,\\\"statusCode\\\":200,\\\"message\\\":\\\"Open Mabar Day Detail create successfully\\\",\\\"query\\\":{\\\"open_mabar_day_id\\\":1,\\\"player_id\\\":18,\\\"player_level\\\":\\\"B\\\",\\\"payment_status\\\":\\\"paid\\\",\\\"player_status\\\":\\\"non member\\\",\\\"note\\\":\\\"\\\"},\\\"data\\\":{\\\"id\\\":19,\\\"open_mabar_day_id\\\":1,\\\"player_id\\\":18,\\\"player_level\\\":\\\"B\\\",\\\"payment_status\\\":\\\"paid\\\",\\\"user_id\\\":1}}\"', 1, NULL, NULL, NULL, '2024-07-30 16:36:20', '2024-07-30 16:36:20'),
(43, '2024-07-30 16:36:33', 'Create Open Mabar Day Detail', '\"{\\\"success\\\":true,\\\"statusCode\\\":200,\\\"message\\\":\\\"Open Mabar Day Detail create successfully\\\",\\\"query\\\":{\\\"open_mabar_day_id\\\":1,\\\"player_id\\\":19,\\\"player_level\\\":\\\"A\\\",\\\"payment_status\\\":\\\"paid\\\",\\\"player_status\\\":\\\"member\\\",\\\"note\\\":\\\"\\\"},\\\"data\\\":{\\\"id\\\":20,\\\"open_mabar_day_id\\\":1,\\\"player_id\\\":19,\\\"player_level\\\":\\\"A\\\",\\\"payment_status\\\":\\\"paid\\\",\\\"user_id\\\":1}}\"', 1, NULL, NULL, NULL, '2024-07-30 16:36:33', '2024-07-30 16:36:33'),
(44, '2024-07-30 16:36:39', 'Create Open Mabar Day Detail', '\"{\\\"success\\\":true,\\\"statusCode\\\":200,\\\"message\\\":\\\"Open Mabar Day Detail create successfully\\\",\\\"query\\\":{\\\"open_mabar_day_id\\\":1,\\\"player_id\\\":20,\\\"player_level\\\":\\\"B\\\",\\\"payment_status\\\":\\\"paid\\\",\\\"player_status\\\":\\\"member\\\",\\\"note\\\":\\\"\\\"},\\\"data\\\":{\\\"id\\\":21,\\\"open_mabar_day_id\\\":1,\\\"player_id\\\":20,\\\"player_level\\\":\\\"B\\\",\\\"payment_status\\\":\\\"paid\\\",\\\"user_id\\\":1}}\"', 1, NULL, NULL, NULL, '2024-07-30 16:36:39', '2024-07-30 16:36:39'),
(45, '2024-07-30 16:36:50', 'Create Open Mabar Day Detail', '\"{\\\"success\\\":true,\\\"statusCode\\\":200,\\\"message\\\":\\\"Open Mabar Day Detail create successfully\\\",\\\"query\\\":{\\\"open_mabar_day_id\\\":1,\\\"player_id\\\":21,\\\"player_level\\\":\\\"A\\\",\\\"payment_status\\\":\\\"paid\\\",\\\"player_status\\\":\\\"non member\\\",\\\"note\\\":\\\"\\\"},\\\"data\\\":{\\\"id\\\":22,\\\"open_mabar_day_id\\\":1,\\\"player_id\\\":21,\\\"player_level\\\":\\\"A\\\",\\\"payment_status\\\":\\\"paid\\\",\\\"user_id\\\":1}}\"', 1, NULL, NULL, NULL, '2024-07-30 16:36:50', '2024-07-30 16:36:50'),
(46, '2024-07-30 16:36:56', 'Create Open Mabar Day Detail', '\"{\\\"success\\\":true,\\\"statusCode\\\":200,\\\"message\\\":\\\"Open Mabar Day Detail create successfully\\\",\\\"query\\\":{\\\"open_mabar_day_id\\\":1,\\\"player_id\\\":22,\\\"player_level\\\":\\\"A\\\",\\\"payment_status\\\":\\\"paid\\\",\\\"player_status\\\":\\\"member\\\",\\\"note\\\":\\\"\\\"},\\\"data\\\":{\\\"id\\\":23,\\\"open_mabar_day_id\\\":1,\\\"player_id\\\":22,\\\"player_level\\\":\\\"A\\\",\\\"payment_status\\\":\\\"paid\\\",\\\"user_id\\\":1}}\"', 1, NULL, NULL, NULL, '2024-07-30 16:36:56', '2024-07-30 16:36:56'),
(47, '2024-07-30 16:37:04', 'Create Open Mabar Day Detail', '\"{\\\"success\\\":true,\\\"statusCode\\\":200,\\\"message\\\":\\\"Open Mabar Day Detail create successfully\\\",\\\"query\\\":{\\\"open_mabar_day_id\\\":1,\\\"player_id\\\":23,\\\"player_level\\\":\\\"A\\\",\\\"payment_status\\\":\\\"paid\\\",\\\"player_status\\\":\\\"member\\\",\\\"note\\\":\\\"\\\"},\\\"data\\\":{\\\"id\\\":24,\\\"open_mabar_day_id\\\":1,\\\"player_id\\\":23,\\\"player_level\\\":\\\"A\\\",\\\"payment_status\\\":\\\"paid\\\",\\\"user_id\\\":1}}\"', 1, NULL, NULL, NULL, '2024-07-30 16:37:04', '2024-07-30 16:37:04'),
(48, '2024-07-30 16:37:07', 'Create Open Mabar Day Detail', '\"{\\\"success\\\":true,\\\"statusCode\\\":200,\\\"message\\\":\\\"Open Mabar Day Detail create successfully\\\",\\\"query\\\":{\\\"open_mabar_day_id\\\":1,\\\"player_id\\\":24,\\\"player_level\\\":\\\"A\\\",\\\"payment_status\\\":\\\"paid\\\",\\\"player_status\\\":\\\"member\\\",\\\"note\\\":\\\"\\\"},\\\"data\\\":{\\\"id\\\":25,\\\"open_mabar_day_id\\\":1,\\\"player_id\\\":24,\\\"player_level\\\":\\\"A\\\",\\\"payment_status\\\":\\\"paid\\\",\\\"user_id\\\":1}}\"', 1, NULL, NULL, NULL, '2024-07-30 16:37:07', '2024-07-30 16:37:07'),
(49, '2024-07-30 16:37:11', 'Create Open Mabar Day Detail', '\"{\\\"success\\\":true,\\\"statusCode\\\":200,\\\"message\\\":\\\"Open Mabar Day Detail create successfully\\\",\\\"query\\\":{\\\"open_mabar_day_id\\\":1,\\\"player_id\\\":25,\\\"player_level\\\":\\\"A\\\",\\\"payment_status\\\":\\\"paid\\\",\\\"player_status\\\":\\\"member\\\",\\\"note\\\":\\\"\\\"},\\\"data\\\":{\\\"id\\\":26,\\\"open_mabar_day_id\\\":1,\\\"player_id\\\":25,\\\"player_level\\\":\\\"A\\\",\\\"payment_status\\\":\\\"paid\\\",\\\"user_id\\\":1}}\"', 1, NULL, NULL, NULL, '2024-07-30 16:37:11', '2024-07-30 16:37:11'),
(50, '2024-07-30 16:44:13', 'Create Open Mabar Day Detail', '\"{\\\"success\\\":true,\\\"statusCode\\\":200,\\\"message\\\":\\\"Open Mabar Day Detail create successfully\\\",\\\"query\\\":{\\\"open_mabar_day_id\\\":1,\\\"player_id\\\":16,\\\"player_level\\\":\\\"A\\\",\\\"payment_status\\\":\\\"paid\\\",\\\"player_status\\\":\\\"member\\\",\\\"note\\\":\\\"\\\"},\\\"data\\\":{\\\"id\\\":27,\\\"open_mabar_day_id\\\":1,\\\"player_id\\\":16,\\\"player_level\\\":\\\"A\\\",\\\"payment_status\\\":\\\"paid\\\",\\\"user_id\\\":1,\\\"community_id\\\":1}}\"', 1, NULL, NULL, NULL, '2024-07-30 16:44:13', '2024-07-30 16:44:13'),
(51, '2024-07-30 16:47:11', 'Create Open Mabar Day Match ', '\"{\\\"success\\\":true,\\\"statusCode\\\":200,\\\"message\\\":\\\"Open Mabar Day  Match create successfully\\\",\\\"query\\\":{\\\"open_mabar_day_id\\\":1,\\\"court_id\\\":2,\\\"player_id_a1\\\":17,\\\"player_level_a1\\\":\\\"B\\\",\\\"player_id_a2\\\":18,\\\"player_level_a2\\\":\\\"B\\\",\\\"player_id_b1\\\":19,\\\"player_level_b1\\\":\\\"A\\\",\\\"player_id_b2\\\":20,\\\"player_level_b2\\\":\\\"B\\\",\\\"start_time\\\":\\\"20:45:00\\\",\\\"note\\\":\\\"\\\"},\\\"data\\\":{\\\"id\\\":6,\\\"open_mabar_day_id\\\":1,\\\"court_id\\\":2,\\\"player_id_a1\\\":17,\\\"player_level_a1\\\":\\\"B\\\",\\\"player_id_a2\\\":18,\\\"player_level_a2\\\":\\\"B\\\",\\\"player_id_b1\\\":19,\\\"player_level_b1\\\":\\\"A\\\",\\\"player_id_b2\\\":20,\\\"player_level_b2\\\":\\\"B\\\",\\\"start_time\\\":\\\"20:45:00\\\",\\\"note\\\":\\\"\\\",\\\"user_id\\\":1,\\\"community_id\\\":1}}\"', 1, NULL, NULL, NULL, '2024-07-30 16:47:11', '2024-07-30 16:47:11'),
(52, '2024-07-30 16:48:43', 'Create Open Mabar Day Match ', '\"{\\\"success\\\":true,\\\"statusCode\\\":200,\\\"message\\\":\\\"Open Mabar Day  Match create successfully\\\",\\\"query\\\":{\\\"open_mabar_day_id\\\":1,\\\"court_id\\\":1,\\\"player_id_a1\\\":21,\\\"player_level_a1\\\":\\\"A\\\",\\\"player_id_a2\\\":22,\\\"player_level_a2\\\":\\\"A\\\",\\\"player_id_b1\\\":23,\\\"player_level_b1\\\":\\\"A\\\",\\\"player_id_b2\\\":24,\\\"player_level_b2\\\":\\\"A\\\",\\\"start_time\\\":\\\"20:35:00\\\",\\\"note\\\":\\\"\\\"},\\\"data\\\":{\\\"id\\\":7,\\\"open_mabar_day_id\\\":1,\\\"court_id\\\":1,\\\"player_id_a1\\\":21,\\\"player_level_a1\\\":\\\"A\\\",\\\"player_id_a2\\\":22,\\\"player_level_a2\\\":\\\"A\\\",\\\"player_id_b1\\\":23,\\\"player_level_b1\\\":\\\"A\\\",\\\"player_id_b2\\\":24,\\\"player_level_b2\\\":\\\"A\\\",\\\"start_time\\\":\\\"20:35:00\\\",\\\"note\\\":\\\"\\\",\\\"user_id\\\":1,\\\"community_id\\\":1}}\"', 1, NULL, NULL, NULL, '2024-07-30 16:48:43', '2024-07-30 16:48:43'),
(53, '2024-07-30 16:49:52', 'Update Open Mabar Match', '\"{\\\"success\\\":true,\\\"statusCode\\\":200,\\\"message\\\":\\\"Open Mabar Match update successfully\\\",\\\"query\\\":{\\\"id\\\":6,\\\"open_mabar_day_id\\\":1,\\\"court_id\\\":2,\\\"player_id_a1\\\":17,\\\"player_level_a1\\\":\\\"B\\\",\\\"player_id_a2\\\":18,\\\"player_level_a2\\\":\\\"B\\\",\\\"player_id_b1\\\":19,\\\"player_level_b1\\\":\\\"A\\\",\\\"player_id_b2\\\":20,\\\"player_level_b2\\\":\\\"B\\\",\\\"start_time\\\":\\\"20:45:00\\\",\\\"end_time\\\":\\\"21:00:00\\\",\\\"score\\\":\\\"28-42\\\",\\\"shuttlecock_used\\\":\\\"2\\\",\\\"note\\\":\\\"\\\"},\\\"data\\\":{\\\"id\\\":6,\\\"open_mabar_day_id\\\":1,\\\"court_id\\\":2,\\\"player_id_a1\\\":17,\\\"player_level_a1\\\":\\\"B\\\",\\\"player_id_a2\\\":18,\\\"player_level_a2\\\":\\\"B\\\",\\\"player_id_b1\\\":19,\\\"player_level_b1\\\":\\\"A\\\",\\\"player_id_b2\\\":20,\\\"player_level_b2\\\":\\\"B\\\",\\\"start_time\\\":\\\"20:45:00\\\",\\\"end_time\\\":\\\"21:00:00\\\",\\\"score\\\":\\\"28-42\\\",\\\"shuttlecock_used\\\":2,\\\"note\\\":\\\"\\\",\\\"user_id\\\":1,\\\"community_id\\\":1}}\"', 1, NULL, NULL, NULL, '2024-07-30 16:49:52', '2024-07-30 16:49:52'),
(54, '2024-07-30 16:50:41', 'Update Open Mabar Match', '\"{\\\"success\\\":true,\\\"statusCode\\\":200,\\\"message\\\":\\\"Open Mabar Match update successfully\\\",\\\"query\\\":{\\\"id\\\":7,\\\"open_mabar_day_id\\\":1,\\\"court_id\\\":1,\\\"player_id_a1\\\":21,\\\"player_level_a1\\\":\\\"A\\\",\\\"player_id_a2\\\":22,\\\"player_level_a2\\\":\\\"A\\\",\\\"player_id_b1\\\":23,\\\"player_level_b1\\\":\\\"A\\\",\\\"player_id_b2\\\":24,\\\"player_level_b2\\\":\\\"A\\\",\\\"start_time\\\":\\\"20:35:00\\\",\\\"end_time\\\":\\\"20:55:00\\\",\\\"score\\\":\\\"42-39\\\",\\\"shuttlecock_used\\\":\\\"2\\\",\\\"note\\\":\\\"\\\"},\\\"data\\\":{\\\"id\\\":7,\\\"open_mabar_day_id\\\":1,\\\"court_id\\\":1,\\\"player_id_a1\\\":21,\\\"player_level_a1\\\":\\\"A\\\",\\\"player_id_a2\\\":22,\\\"player_level_a2\\\":\\\"A\\\",\\\"player_id_b1\\\":23,\\\"player_level_b1\\\":\\\"A\\\",\\\"player_id_b2\\\":24,\\\"player_level_b2\\\":\\\"A\\\",\\\"start_time\\\":\\\"20:35:00\\\",\\\"end_time\\\":\\\"20:55:00\\\",\\\"score\\\":\\\"42-39\\\",\\\"shuttlecock_used\\\":2,\\\"note\\\":\\\"\\\",\\\"user_id\\\":1,\\\"community_id\\\":1}}\"', 1, NULL, NULL, NULL, '2024-07-30 16:50:41', '2024-07-30 16:50:41'),
(55, '2024-07-30 16:52:15', 'Create Open Mabar Day Match ', '\"{\\\"success\\\":true,\\\"statusCode\\\":200,\\\"message\\\":\\\"Open Mabar Day  Match create successfully\\\",\\\"query\\\":{\\\"open_mabar_day_id\\\":1,\\\"court_id\\\":1,\\\"player_id_a1\\\":25,\\\"player_level_a1\\\":\\\"A\\\",\\\"player_id_a2\\\":1,\\\"player_level_a2\\\":\\\"A\\\",\\\"player_id_b1\\\":2,\\\"player_level_b1\\\":\\\"A\\\",\\\"player_id_b2\\\":3,\\\"player_level_b2\\\":\\\"A\\\",\\\"start_time\\\":\\\"21:00:00\\\",\\\"note\\\":\\\"\\\"},\\\"data\\\":{\\\"id\\\":8,\\\"open_mabar_day_id\\\":1,\\\"court_id\\\":1,\\\"player_id_a1\\\":25,\\\"player_level_a1\\\":\\\"A\\\",\\\"player_id_a2\\\":1,\\\"player_level_a2\\\":\\\"A\\\",\\\"player_id_b1\\\":2,\\\"player_level_b1\\\":\\\"A\\\",\\\"player_id_b2\\\":3,\\\"player_level_b2\\\":\\\"A\\\",\\\"start_time\\\":\\\"21:00:00\\\",\\\"note\\\":\\\"\\\",\\\"user_id\\\":1,\\\"community_id\\\":1}}\"', 1, NULL, NULL, NULL, '2024-07-30 16:52:15', '2024-07-30 16:52:15'),
(56, '2024-07-30 16:52:49', 'Update Open Mabar Match', '\"{\\\"success\\\":true,\\\"statusCode\\\":200,\\\"message\\\":\\\"Open Mabar Match update successfully\\\",\\\"query\\\":{\\\"id\\\":8,\\\"open_mabar_day_id\\\":1,\\\"court_id\\\":1,\\\"player_id_a1\\\":25,\\\"player_level_a1\\\":\\\"A\\\",\\\"player_id_a2\\\":1,\\\"player_level_a2\\\":\\\"A\\\",\\\"player_id_b1\\\":2,\\\"player_level_b1\\\":\\\"A\\\",\\\"player_id_b2\\\":3,\\\"player_level_b2\\\":\\\"A\\\",\\\"start_time\\\":\\\"21:00:00\\\",\\\"end_time\\\":\\\"21:25:00\\\",\\\"score\\\":\\\"37-42\\\",\\\"shuttlecock_used\\\":\\\"2\\\",\\\"note\\\":\\\"\\\"},\\\"data\\\":{\\\"id\\\":8,\\\"open_mabar_day_id\\\":1,\\\"court_id\\\":1,\\\"player_id_a1\\\":25,\\\"player_level_a1\\\":\\\"A\\\",\\\"player_id_a2\\\":1,\\\"player_level_a2\\\":\\\"A\\\",\\\"player_id_b1\\\":2,\\\"player_level_b1\\\":\\\"A\\\",\\\"player_id_b2\\\":3,\\\"player_level_b2\\\":\\\"A\\\",\\\"start_time\\\":\\\"21:00:00\\\",\\\"end_time\\\":\\\"21:25:00\\\",\\\"score\\\":\\\"37-42\\\",\\\"shuttlecock_used\\\":2,\\\"note\\\":\\\"\\\",\\\"user_id\\\":1,\\\"community_id\\\":1}}\"', 1, NULL, NULL, NULL, '2024-07-30 16:52:49', '2024-07-30 16:52:49'),
(57, '2024-07-30 16:53:42', 'Create Open Mabar Day Match ', '\"{\\\"success\\\":true,\\\"statusCode\\\":200,\\\"message\\\":\\\"Open Mabar Day  Match create successfully\\\",\\\"query\\\":{\\\"open_mabar_day_id\\\":1,\\\"court_id\\\":2,\\\"player_id_a1\\\":4,\\\"player_level_a1\\\":\\\"A\\\",\\\"player_id_a2\\\":5,\\\"player_level_a2\\\":\\\"A\\\",\\\"player_id_b1\\\":6,\\\"player_level_b1\\\":\\\"A\\\",\\\"player_id_b2\\\":7,\\\"player_level_b2\\\":\\\"A\\\",\\\"start_time\\\":\\\"21:10:00\\\",\\\"note\\\":\\\"\\\"},\\\"data\\\":{\\\"id\\\":9,\\\"open_mabar_day_id\\\":1,\\\"court_id\\\":2,\\\"player_id_a1\\\":4,\\\"player_level_a1\\\":\\\"A\\\",\\\"player_id_a2\\\":5,\\\"player_level_a2\\\":\\\"A\\\",\\\"player_id_b1\\\":6,\\\"player_level_b1\\\":\\\"A\\\",\\\"player_id_b2\\\":7,\\\"player_level_b2\\\":\\\"A\\\",\\\"start_time\\\":\\\"21:10:00\\\",\\\"note\\\":\\\"\\\",\\\"user_id\\\":1,\\\"community_id\\\":1}}\"', 1, NULL, NULL, NULL, '2024-07-30 16:53:42', '2024-07-30 16:53:42'),
(58, '2024-07-30 16:54:07', 'Update Open Mabar Match', '\"{\\\"success\\\":true,\\\"statusCode\\\":200,\\\"message\\\":\\\"Open Mabar Match update successfully\\\",\\\"query\\\":{\\\"id\\\":9,\\\"open_mabar_day_id\\\":1,\\\"court_id\\\":2,\\\"player_id_a1\\\":4,\\\"player_level_a1\\\":\\\"A\\\",\\\"player_id_a2\\\":5,\\\"player_level_a2\\\":\\\"A\\\",\\\"player_id_b1\\\":6,\\\"player_level_b1\\\":\\\"A\\\",\\\"player_id_b2\\\":7,\\\"player_level_b2\\\":\\\"A\\\",\\\"start_time\\\":\\\"21:10:00\\\",\\\"end_time\\\":\\\"21:35:00\\\",\\\"score\\\":\\\"42-30\\\",\\\"shuttlecock_used\\\":\\\"1\\\",\\\"note\\\":\\\"\\\"},\\\"data\\\":{\\\"id\\\":9,\\\"open_mabar_day_id\\\":1,\\\"court_id\\\":2,\\\"player_id_a1\\\":4,\\\"player_level_a1\\\":\\\"A\\\",\\\"player_id_a2\\\":5,\\\"player_level_a2\\\":\\\"A\\\",\\\"player_id_b1\\\":6,\\\"player_level_b1\\\":\\\"A\\\",\\\"player_id_b2\\\":7,\\\"player_level_b2\\\":\\\"A\\\",\\\"start_time\\\":\\\"21:10:00\\\",\\\"end_time\\\":\\\"21:35:00\\\",\\\"score\\\":\\\"42-30\\\",\\\"shuttlecock_used\\\":1,\\\"note\\\":\\\"\\\",\\\"user_id\\\":1,\\\"community_id\\\":1}}\"', 1, NULL, NULL, NULL, '2024-07-30 16:54:07', '2024-07-30 16:54:07'),
(59, '2024-07-30 16:54:42', 'Create Open Mabar Day Match ', '\"{\\\"success\\\":true,\\\"statusCode\\\":200,\\\"message\\\":\\\"Open Mabar Day  Match create successfully\\\",\\\"query\\\":{\\\"open_mabar_day_id\\\":1,\\\"court_id\\\":2,\\\"player_id_a1\\\":8,\\\"player_level_a1\\\":\\\"A\\\",\\\"player_id_a2\\\":9,\\\"player_level_a2\\\":\\\"A\\\",\\\"player_id_b1\\\":10,\\\"player_level_b1\\\":\\\"A\\\",\\\"player_id_b2\\\":11,\\\"player_level_b2\\\":\\\"A\\\",\\\"start_time\\\":\\\"21:30:00\\\",\\\"note\\\":\\\"\\\"},\\\"data\\\":{\\\"id\\\":10,\\\"open_mabar_day_id\\\":1,\\\"court_id\\\":2,\\\"player_id_a1\\\":8,\\\"player_level_a1\\\":\\\"A\\\",\\\"player_id_a2\\\":9,\\\"player_level_a2\\\":\\\"A\\\",\\\"player_id_b1\\\":10,\\\"player_level_b1\\\":\\\"A\\\",\\\"player_id_b2\\\":11,\\\"player_level_b2\\\":\\\"A\\\",\\\"start_time\\\":\\\"21:30:00\\\",\\\"note\\\":\\\"\\\",\\\"user_id\\\":1,\\\"community_id\\\":1}}\"', 1, NULL, NULL, NULL, '2024-07-30 16:54:42', '2024-07-30 16:54:42'),
(60, '2024-07-30 16:55:12', 'Update Open Mabar Match', '\"{\\\"success\\\":true,\\\"statusCode\\\":200,\\\"message\\\":\\\"Open Mabar Match update successfully\\\",\\\"query\\\":{\\\"id\\\":10,\\\"open_mabar_day_id\\\":1,\\\"court_id\\\":2,\\\"player_id_a1\\\":8,\\\"player_level_a1\\\":\\\"A\\\",\\\"player_id_a2\\\":9,\\\"player_level_a2\\\":\\\"A\\\",\\\"player_id_b1\\\":10,\\\"player_level_b1\\\":\\\"A\\\",\\\"player_id_b2\\\":11,\\\"player_level_b2\\\":\\\"A\\\",\\\"start_time\\\":\\\"21:30:00\\\",\\\"end_time\\\":\\\"21:58:00\\\",\\\"score\\\":\\\"42-41\\\",\\\"shuttlecock_used\\\":\\\"2\\\",\\\"note\\\":\\\"\\\"},\\\"data\\\":{\\\"id\\\":10,\\\"open_mabar_day_id\\\":1,\\\"court_id\\\":2,\\\"player_id_a1\\\":8,\\\"player_level_a1\\\":\\\"A\\\",\\\"player_id_a2\\\":9,\\\"player_level_a2\\\":\\\"A\\\",\\\"player_id_b1\\\":10,\\\"player_level_b1\\\":\\\"A\\\",\\\"player_id_b2\\\":11,\\\"player_level_b2\\\":\\\"A\\\",\\\"start_time\\\":\\\"21:30:00\\\",\\\"end_time\\\":\\\"21:58:00\\\",\\\"score\\\":\\\"42-41\\\",\\\"shuttlecock_used\\\":2,\\\"note\\\":\\\"\\\",\\\"user_id\\\":1,\\\"community_id\\\":1}}\"', 1, NULL, NULL, NULL, '2024-07-30 16:55:12', '2024-07-30 16:55:12'),
(61, '2024-07-30 16:56:09', 'Create Open Mabar Day Match ', '\"{\\\"success\\\":true,\\\"statusCode\\\":200,\\\"message\\\":\\\"Open Mabar Day  Match create successfully\\\",\\\"query\\\":{\\\"open_mabar_day_id\\\":1,\\\"court_id\\\":1,\\\"player_id_a1\\\":12,\\\"player_level_a1\\\":\\\"A\\\",\\\"player_id_a2\\\":13,\\\"player_level_a2\\\":\\\"B\\\",\\\"player_id_b1\\\":14,\\\"player_level_b1\\\":\\\"A\\\",\\\"player_id_b2\\\":15,\\\"player_level_b2\\\":\\\"A\\\",\\\"start_time\\\":\\\"21:35:00\\\",\\\"note\\\":\\\"\\\"},\\\"data\\\":{\\\"id\\\":11,\\\"open_mabar_day_id\\\":1,\\\"court_id\\\":1,\\\"player_id_a1\\\":12,\\\"player_level_a1\\\":\\\"A\\\",\\\"player_id_a2\\\":13,\\\"player_level_a2\\\":\\\"B\\\",\\\"player_id_b1\\\":14,\\\"player_level_b1\\\":\\\"A\\\",\\\"player_id_b2\\\":15,\\\"player_level_b2\\\":\\\"A\\\",\\\"start_time\\\":\\\"21:35:00\\\",\\\"note\\\":\\\"\\\",\\\"user_id\\\":1,\\\"community_id\\\":1}}\"', 1, NULL, NULL, NULL, '2024-07-30 16:56:09', '2024-07-30 16:56:09'),
(62, '2024-07-30 16:56:36', 'Update Open Mabar Match', '\"{\\\"success\\\":true,\\\"statusCode\\\":200,\\\"message\\\":\\\"Open Mabar Match update successfully\\\",\\\"query\\\":{\\\"id\\\":11,\\\"open_mabar_day_id\\\":1,\\\"court_id\\\":1,\\\"player_id_a1\\\":12,\\\"player_level_a1\\\":\\\"A\\\",\\\"player_id_a2\\\":13,\\\"player_level_a2\\\":\\\"B\\\",\\\"player_id_b1\\\":14,\\\"player_level_b1\\\":\\\"A\\\",\\\"player_id_b2\\\":15,\\\"player_level_b2\\\":\\\"A\\\",\\\"start_time\\\":\\\"21:35:00\\\",\\\"end_time\\\":\\\"22:00:00\\\",\\\"score\\\":\\\"33-42\\\",\\\"shuttlecock_used\\\":\\\"2\\\",\\\"note\\\":\\\"\\\"},\\\"data\\\":{\\\"id\\\":11,\\\"open_mabar_day_id\\\":1,\\\"court_id\\\":1,\\\"player_id_a1\\\":12,\\\"player_level_a1\\\":\\\"A\\\",\\\"player_id_a2\\\":13,\\\"player_level_a2\\\":\\\"B\\\",\\\"player_id_b1\\\":14,\\\"player_level_b1\\\":\\\"A\\\",\\\"player_id_b2\\\":15,\\\"player_level_b2\\\":\\\"A\\\",\\\"start_time\\\":\\\"21:35:00\\\",\\\"end_time\\\":\\\"22:00:00\\\",\\\"score\\\":\\\"33-42\\\",\\\"shuttlecock_used\\\":2,\\\"note\\\":\\\"\\\",\\\"user_id\\\":1,\\\"community_id\\\":1}}\"', 1, NULL, NULL, NULL, '2024-07-30 16:56:36', '2024-07-30 16:56:36');
INSERT INTO `log` (`id`, `datetime`, `activity`, `description`, `user_id`, `user_job`, `note`, `account_id`, `createdAt`, `updatedAt`) VALUES
(63, '2024-07-30 20:07:33', 'Login', '\"{\\\"success\\\":true,\\\"statusCode\\\":200,\\\"message\\\":\\\"Login successfully\\\",\\\"query\\\":{\\\"username\\\":\\\"admin@pbbedahulu\\\",\\\"password\\\":\\\"pbbedahulu!\\\"},\\\"data\\\":{\\\"id\\\":1,\\\"name\\\":\\\"Eggi Dwitama\\\",\\\"username\\\":\\\"admin\\\",\\\"contact\\\":\\\"085323085692\\\",\\\"community_id\\\":1,\\\"community_name\\\":\\\"PB BEDAHULU\\\",\\\"community\\\":\\\"pbbedahulu\\\",\\\"token\\\":\\\"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwibmFtZSI6IkVnZ2kgRHdpdGFtYSIsImNvbnRhY3QiOiIwODUzMjMwODU2OTIiLCJ1c2VybmFtZSI6ImFkbWluIiwiY29tbXVuaXR5X2lkIjoxLCJjb21tdW5pdHkiOnsiaWQiOjEsInVzZXJuYW1lIjoicGJiZWRhaHVsdSIsIm5hbWUiOiJQQiBCRURBSFVMVSIsImFkZHJlc3MiOiJKbC4gQmVkYWh1bHUgWCBOby4gMTcsIERlbnBhc2FyIFV0YXJhIC0gQmFsaSIsImNvbnRhY3QiOiIwODc4MDk1MzgwODAiLCJwaWMiOiJBZG1pbiBQQiBCZWRhaHVsdSIsImluc3RhZ3JhbSI6IkBwYl9iZWRhaHVsdSIsInRpa3RvayI6IkBwYl9iZWRhaHVsdSIsImVtYWlsIjoicGJiZWRhaHVsdUBnbWFpbC5jb20iLCJ3ZWJzaXRlIjoicGJiZWRhaHVsdS5teS5pZCIsImxvZ28iOiJsb2dvLXBiYmVkYWh1bHUucG5nIiwiY3JlYXRlZEF0IjoiMjAyNC0wNy0yOVQwMTo1MToyMS4wMDBaIiwidXBkYXRlZEF0IjoiMjAyNC0wNy0yOVQwMTo1MToyMS4wMDBaIn0sImlhdCI6MTcyMjM0MTI1M30.Z82Cws-Kyiqhjhkhd2zjgjKIxYhwuOvk8-2dqModAPQ\\\"}}\"', 1, NULL, NULL, NULL, '2024-07-30 20:07:33', '2024-07-30 20:07:33'),
(64, '2024-07-30 20:07:55', 'Profile', '\"{\\\"success\\\":true,\\\"statusCode\\\":200,\\\"message\\\":\\\"Profile retrieved successfully\\\",\\\"query\\\":{},\\\"data\\\":{\\\"id\\\":1,\\\"name\\\":\\\"Eggi Dwitama\\\",\\\"contact\\\":\\\"085323085692\\\",\\\"username\\\":\\\"admin\\\",\\\"community_id\\\":1,\\\"community\\\":{\\\"id\\\":1,\\\"username\\\":\\\"pbbedahulu\\\",\\\"name\\\":\\\"PB BEDAHULU\\\",\\\"address\\\":\\\"Jl. Bedahulu X No. 17, Denpasar Utara - Bali\\\",\\\"contact\\\":\\\"087809538080\\\",\\\"pic\\\":\\\"Admin PB Bedahulu\\\",\\\"instagram\\\":\\\"@pb_bedahulu\\\",\\\"tiktok\\\":\\\"@pb_bedahulu\\\",\\\"email\\\":\\\"pbbedahulu@gmail.com\\\",\\\"website\\\":\\\"pbbedahulu.my.id\\\",\\\"logo\\\":\\\"logo-pbbedahulu.png\\\",\\\"createdAt\\\":\\\"2024-07-29T01:51:21.000Z\\\",\\\"updatedAt\\\":\\\"2024-07-29T01:51:21.000Z\\\"},\\\"iat\\\":1722226821}}\"', 1, NULL, NULL, NULL, '2024-07-30 20:07:55', '2024-07-30 20:07:55'),
(65, '2024-07-31 10:57:38', 'Create Player', '\"{\\\"success\\\":true,\\\"statusCode\\\":200,\\\"message\\\":\\\"Player create successfully\\\",\\\"query\\\":{\\\"name\\\":\\\"Frans\\\",\\\"alias\\\":\\\"frans\\\",\\\"username\\\":\\\"frans995\\\",\\\"gender\\\":\\\"M\\\",\\\"contact\\\":\\\"089699950995\\\",\\\"level\\\":\\\"A\\\",\\\"age_range\\\":\\\"41-50\\\"},\\\"data\\\":{\\\"id\\\":27,\\\"name\\\":\\\"Frans\\\",\\\"alias\\\":\\\"frans\\\",\\\"username\\\":\\\"frans995\\\",\\\"gender\\\":\\\"M\\\",\\\"contact\\\":\\\"089699950995\\\",\\\"level\\\":\\\"A\\\",\\\"age_range\\\":\\\"41-50\\\",\\\"user_id\\\":1}}\"', 1, NULL, NULL, NULL, '2024-07-31 10:57:38', '2024-07-31 10:57:38'),
(66, '2024-07-31 11:01:35', 'Create Open Mabar Player', '\"{\\\"success\\\":true,\\\"statusCode\\\":200,\\\"message\\\":\\\"Open Mabar Player create successfully\\\",\\\"query\\\":{\\\"open_mabar_id\\\":1,\\\"player_id\\\":27,\\\"payment_method\\\":\\\"QRIS\\\",\\\"note\\\":\\\"\\\"},\\\"data\\\":{\\\"id\\\":1,\\\"community_id\\\":1,\\\"type\\\":\\\"in\\\",\\\"payment_method\\\":\\\"QRIS\\\",\\\"date\\\":\\\"2024-07-31\\\",\\\"source\\\":\\\"iuran member-Open Mabar Selasa\\\",\\\"nominal\\\":\\\"120000.00\\\",\\\"note\\\":\\\"iuran member-Open Mabar Selasa-Frans-089699950995\\\",\\\"user_id\\\":1,\\\"updatedAt\\\":\\\"2024-07-31T03:01:35.745Z\\\",\\\"createdAt\\\":\\\"2024-07-31T03:01:35.745Z\\\"}}\"', 1, NULL, NULL, NULL, '2024-07-31 11:01:35', '2024-07-31 11:01:35'),
(67, '2024-07-31 11:15:43', 'Renew Membership Open Mabar Player', '\"{\\\"success\\\":true,\\\"statusCode\\\":200,\\\"message\\\":\\\"Open Mabar Player renew membership successfully\\\",\\\"query\\\":{\\\"open_mabar_id\\\":1,\\\"player_id\\\":1,\\\"payment_method\\\":\\\"Bank Transfer\\\",\\\"note\\\":\\\"\\\"},\\\"data\\\":{\\\"id\\\":2,\\\"community_id\\\":1,\\\"type\\\":\\\"in\\\",\\\"payment_method\\\":\\\"Bank Transfer\\\",\\\"date\\\":\\\"2024-07-31\\\",\\\"source\\\":\\\"iuran member-Open Mabar Selasa\\\",\\\"nominal\\\":\\\"120000.00\\\",\\\"note\\\":\\\"iuran member-Open Mabar Selasa-Eggi Dwitama-085323085692\\\",\\\"user_id\\\":1,\\\"updatedAt\\\":\\\"2024-07-31T03:15:43.881Z\\\",\\\"createdAt\\\":\\\"2024-07-31T03:15:43.881Z\\\"}}\"', 1, NULL, NULL, NULL, '2024-07-31 11:15:43', '2024-07-31 11:15:43'),
(68, '2024-07-31 11:17:27', 'Create Player', '\"{\\\"success\\\":true,\\\"statusCode\\\":200,\\\"message\\\":\\\"Player create successfully\\\",\\\"query\\\":{\\\"name\\\":\\\"Bayu\\\",\\\"alias\\\":\\\"bayu mahaprasta\\\",\\\"username\\\":\\\"bayu022\\\",\\\"gender\\\":\\\"M\\\",\\\"contact\\\":\\\"081239839022\\\",\\\"level\\\":\\\"B\\\",\\\"age_range\\\":\\\"31-40\\\"},\\\"data\\\":{\\\"id\\\":28,\\\"name\\\":\\\"Bayu\\\",\\\"alias\\\":\\\"bayu mahaprasta\\\",\\\"username\\\":\\\"bayumahaprasta022\\\",\\\"gender\\\":\\\"M\\\",\\\"contact\\\":\\\"081239839022\\\",\\\"level\\\":\\\"B\\\",\\\"age_range\\\":\\\"31-40\\\",\\\"user_id\\\":1}}\"', 1, NULL, NULL, NULL, '2024-07-31 11:17:27', '2024-07-31 11:17:27'),
(69, '2024-07-31 11:30:10', 'Create Open Mabar Player', '\"{\\\"success\\\":true,\\\"statusCode\\\":200,\\\"message\\\":\\\"Open Mabar Player create successfully\\\",\\\"query\\\":{\\\"open_mabar_id\\\":1,\\\"player_id\\\":28,\\\"payment_method\\\":\\\"QRIS\\\",\\\"note\\\":\\\"\\\"},\\\"data\\\":{\\\"id\\\":3,\\\"community_id\\\":1,\\\"type\\\":\\\"in\\\",\\\"payment_method\\\":\\\"QRIS\\\",\\\"date\\\":\\\"2024-07-31\\\",\\\"source\\\":\\\"iuran member-Open Mabar Selasa\\\",\\\"nominal\\\":\\\"120000.00\\\",\\\"note\\\":\\\"iuran member-Open Mabar Selasa-Bayu-081239839022\\\",\\\"user_id\\\":1,\\\"updatedAt\\\":\\\"2024-07-31T03:30:10.069Z\\\",\\\"createdAt\\\":\\\"2024-07-31T03:30:10.069Z\\\"}}\"', 1, NULL, NULL, NULL, '2024-07-31 11:30:10', '2024-07-31 11:30:10'),
(70, '2024-07-31 11:31:52', 'Unsubscribe Player Membership', '\"{\\\"success\\\":true,\\\"statusCode\\\":200,\\\"message\\\":\\\"Unsubscribe Player membership successfully\\\",\\\"query\\\":{\\\"open_mabar_id\\\":1,\\\"player_id\\\":28},\\\"data\\\":[]}\"', 1, NULL, NULL, NULL, '2024-07-31 11:31:52', '2024-07-31 11:31:52'),
(71, '2024-07-31 13:34:42', 'Create Open Mabar Day Detail', '\"{\\\"success\\\":true,\\\"statusCode\\\":200,\\\"message\\\":\\\"Open Mabar Day Detail create successfully\\\",\\\"query\\\":{\\\"open_mabar_day_id\\\":1,\\\"player_id\\\":26,\\\"payment_status\\\":\\\"paid\\\",\\\"note\\\":\\\"\\\"},\\\"data\\\":{\\\"id\\\":28,\\\"open_mabar_day_id\\\":1,\\\"player_id\\\":26,\\\"player_level\\\":\\\"A\\\",\\\"payment_status\\\":\\\"paid\\\",\\\"user_id\\\":1,\\\"community_id\\\":1}}\"', 1, NULL, NULL, NULL, '2024-07-31 13:34:42', '2024-07-31 13:34:42'),
(72, '2024-07-31 13:38:33', 'Create Open Mabar Day Detail', '\"{\\\"success\\\":true,\\\"statusCode\\\":200,\\\"message\\\":\\\"Open Mabar Day Detail create successfully\\\",\\\"query\\\":{\\\"open_mabar_day_id\\\":1,\\\"player_id\\\":27,\\\"payment_status\\\":\\\"unpaid\\\",\\\"note\\\":\\\"\\\"},\\\"data\\\":{\\\"id\\\":29,\\\"open_mabar_day_id\\\":1,\\\"player_id\\\":27,\\\"player_level\\\":\\\"A\\\",\\\"payment_status\\\":\\\"unpaid\\\",\\\"user_id\\\":1,\\\"community_id\\\":1}}\"', 1, NULL, NULL, NULL, '2024-07-31 13:38:33', '2024-07-31 13:38:33'),
(73, '2024-07-31 14:46:57', 'Paid Cashflow', '\"{\\\"success\\\":true,\\\"statusCode\\\":200,\\\"message\\\":\\\"Cashflow paid successfully\\\",\\\"query\\\":{\\\"id\\\":28,\\\"payment_method\\\":\\\"QRIS\\\"},\\\"data\\\":{\\\"id\\\":28,\\\"open_mabar_day_id\\\":1,\\\"player_id\\\":26,\\\"player_level\\\":\\\"A\\\",\\\"player_arrival_time\\\":\\\"2024-07-31T05:34:42.000Z\\\",\\\"payment_status\\\":\\\"paid\\\",\\\"user_id\\\":1,\\\"community_id\\\":1}}\"', 1, NULL, NULL, NULL, '2024-07-31 14:46:57', '2024-07-31 14:46:57'),
(74, '2024-07-31 14:49:41', 'Paid Cashflow', '\"{\\\"success\\\":true,\\\"statusCode\\\":200,\\\"message\\\":\\\"Cashflow paid successfully\\\",\\\"query\\\":{\\\"id\\\":29,\\\"payment_method\\\":\\\"QRIS\\\"},\\\"data\\\":{\\\"id\\\":29,\\\"open_mabar_day_id\\\":1,\\\"player_id\\\":27,\\\"player_level\\\":\\\"A\\\",\\\"player_arrival_time\\\":\\\"2024-07-31T05:38:33.000Z\\\",\\\"payment_status\\\":\\\"paid\\\",\\\"user_id\\\":1,\\\"community_id\\\":1}}\"', 1, NULL, NULL, NULL, '2024-07-31 14:49:41', '2024-07-31 14:49:41'),
(75, '2024-07-31 15:18:50', 'Create Cashflow', '\"{\\\"success\\\":true,\\\"statusCode\\\":200,\\\"message\\\":\\\"Cashflow create successfully\\\",\\\"query\\\":{\\\"type\\\":\\\"in\\\",\\\"source\\\":\\\"others\\\",\\\"payment_method\\\":\\\"Bank Transfer\\\",\\\"date\\\":\\\"2024-07-31\\\",\\\"nominal\\\":1500000,\\\"note\\\":\\\"sumbangan dari sponsor\\\"},\\\"data\\\":{\\\"id\\\":6,\\\"type\\\":\\\"in\\\",\\\"source\\\":\\\"others\\\",\\\"payment_method\\\":\\\"Bank Transfer\\\",\\\"date\\\":\\\"2024-07-31\\\",\\\"nominal\\\":1500000,\\\"note\\\":\\\"sumbangan dari sponsor\\\",\\\"community_id\\\":1,\\\"user_id\\\":1,\\\"updatedAt\\\":\\\"2024-07-31T07:18:50.889Z\\\",\\\"createdAt\\\":\\\"2024-07-31T07:18:50.889Z\\\"}}\"', 1, NULL, NULL, NULL, '2024-07-31 15:18:50', '2024-07-31 15:18:50'),
(76, '2024-07-31 15:19:15', 'Create Cashflow', '\"{\\\"success\\\":true,\\\"statusCode\\\":200,\\\"message\\\":\\\"Cashflow create successfully\\\",\\\"query\\\":{\\\"type\\\":\\\"in\\\",\\\"source\\\":\\\"others\\\",\\\"payment_method\\\":\\\"Bank Transfer\\\",\\\"date\\\":\\\"2024-07-31\\\",\\\"nominal\\\":1500000,\\\"note\\\":\\\"sumbangan dari sponsor\\\"},\\\"data\\\":{\\\"id\\\":7,\\\"type\\\":\\\"in\\\",\\\"source\\\":\\\"others\\\",\\\"payment_method\\\":\\\"Bank Transfer\\\",\\\"date\\\":\\\"2024-07-31\\\",\\\"nominal\\\":1500000,\\\"note\\\":\\\"sumbangan dari sponsor\\\",\\\"community_id\\\":1,\\\"user_id\\\":1,\\\"updatedAt\\\":\\\"2024-07-31T07:19:15.105Z\\\",\\\"createdAt\\\":\\\"2024-07-31T07:19:15.105Z\\\"}}\"', 1, NULL, NULL, NULL, '2024-07-31 15:19:15', '2024-07-31 15:19:15'),
(77, '2024-07-31 15:20:00', 'Update Cashflow', '\"{\\\"success\\\":true,\\\"statusCode\\\":200,\\\"message\\\":\\\"Cashflow update successfully\\\",\\\"query\\\":{\\\"id\\\":7,\\\"type\\\":\\\"in\\\",\\\"source\\\":\\\"others\\\",\\\"payment_method\\\":\\\"QRIS\\\",\\\"date\\\":\\\"2024-07-31\\\",\\\"nominal\\\":1000000,\\\"note\\\":\\\"sumbangan dari sponsor\\\"},\\\"data\\\":null}\"', 1, NULL, NULL, NULL, '2024-07-31 15:20:00', '2024-07-31 15:20:00'),
(78, '2024-07-31 15:20:34', 'Delete Player', '\"{\\\"success\\\":true,\\\"statusCode\\\":200,\\\"message\\\":\\\"Player delete successfully\\\",\\\"query\\\":{\\\"id\\\":\\\"7\\\"},\\\"data\\\":[]}\"', 1, NULL, NULL, NULL, '2024-07-31 15:20:34', '2024-07-31 15:20:34'),
(79, '2024-07-31 15:42:22', 'Create Cashflow', '\"{\\\"success\\\":true,\\\"statusCode\\\":200,\\\"message\\\":\\\"Cashflow create successfully\\\",\\\"query\\\":{\\\"type\\\":\\\"out\\\",\\\"source\\\":\\\"buy shuttlecock\\\",\\\"payment_method\\\":\\\"Cash\\\",\\\"date\\\":\\\"2024-07-31\\\",\\\"nominal\\\":200000,\\\"note\\\":\\\"2 slop shuttlecock\\\"},\\\"data\\\":{\\\"id\\\":7,\\\"type\\\":\\\"out\\\",\\\"source\\\":\\\"buy shuttlecock\\\",\\\"payment_method\\\":\\\"Cash\\\",\\\"date\\\":\\\"2024-07-31\\\",\\\"nominal\\\":200000,\\\"note\\\":\\\"2 slop shuttlecock\\\",\\\"community_id\\\":1,\\\"user_id\\\":1,\\\"updatedAt\\\":\\\"2024-07-31T07:42:22.046Z\\\",\\\"createdAt\\\":\\\"2024-07-31T07:42:22.046Z\\\"}}\"', 1, NULL, NULL, NULL, '2024-07-31 15:42:22', '2024-07-31 15:42:22'),
(80, '2024-08-02 14:49:53', 'Register', '\"{\\\"success\\\":true,\\\"statusCode\\\":200,\\\"message\\\":\\\"Register successfully\\\",\\\"query\\\":{\\\"name\\\":\\\"Yuhdi Harta\\\",\\\"contact\\\":\\\"081934345480\\\",\\\"privilege\\\":\\\"super admin\\\",\\\"username\\\":\\\"yudhi\\\",\\\"password\\\":\\\"pbbedahulu!\\\",\\\"community_id\\\":1},\\\"data\\\":{\\\"name\\\":\\\"Yuhdi Harta\\\",\\\"contact\\\":\\\"081934345480\\\",\\\"privilege\\\":\\\"super admin\\\",\\\"username\\\":\\\"yudhi\\\",\\\"password\\\":\\\"pbbedahulu!\\\",\\\"community_id\\\":1}}\"', 3, NULL, NULL, NULL, '2024-08-02 14:49:53', '2024-08-02 14:49:53'),
(81, '2024-08-02 14:50:12', 'Register', '\"{\\\"success\\\":true,\\\"statusCode\\\":200,\\\"message\\\":\\\"Register successfully\\\",\\\"query\\\":{\\\"name\\\":\\\"Morino\\\",\\\"contact\\\":\\\"089634862299\\\",\\\"privilege\\\":\\\"super admin\\\",\\\"username\\\":\\\"juan\\\",\\\"password\\\":\\\"pbbedahulu!\\\",\\\"community_id\\\":1},\\\"data\\\":{\\\"name\\\":\\\"Morino\\\",\\\"contact\\\":\\\"089634862299\\\",\\\"privilege\\\":\\\"super admin\\\",\\\"username\\\":\\\"juan\\\",\\\"password\\\":\\\"pbbedahulu!\\\",\\\"community_id\\\":1}}\"', 4, NULL, NULL, NULL, '2024-08-02 14:50:12', '2024-08-02 14:50:12'),
(82, '2024-08-02 14:50:34', 'Register', '\"{\\\"success\\\":true,\\\"statusCode\\\":200,\\\"message\\\":\\\"Register successfully\\\",\\\"query\\\":{\\\"name\\\":\\\"Aditya Riyanto\\\",\\\"contact\\\":\\\"0818562726\\\",\\\"privilege\\\":\\\"super admin\\\",\\\"username\\\":\\\"adit\\\",\\\"password\\\":\\\"pbbedahulu!\\\",\\\"community_id\\\":1},\\\"data\\\":{\\\"name\\\":\\\"Aditya Riyanto\\\",\\\"contact\\\":\\\"0818562726\\\",\\\"privilege\\\":\\\"super admin\\\",\\\"username\\\":\\\"adit\\\",\\\"password\\\":\\\"pbbedahulu!\\\",\\\"community_id\\\":1}}\"', 5, NULL, NULL, NULL, '2024-08-02 14:50:34', '2024-08-02 14:50:34'),
(83, '2024-08-02 14:50:51', 'Register', '\"{\\\"success\\\":true,\\\"statusCode\\\":200,\\\"message\\\":\\\"Register successfully\\\",\\\"query\\\":{\\\"name\\\":\\\"Denny Tenggala\\\",\\\"contact\\\":\\\"081246376666\\\",\\\"privilege\\\":\\\"super admin\\\",\\\"username\\\":\\\"denny\\\",\\\"password\\\":\\\"pbbedahulu!\\\",\\\"community_id\\\":1},\\\"data\\\":{\\\"name\\\":\\\"Denny Tenggala\\\",\\\"contact\\\":\\\"081246376666\\\",\\\"privilege\\\":\\\"super admin\\\",\\\"username\\\":\\\"denny\\\",\\\"password\\\":\\\"pbbedahulu!\\\",\\\"community_id\\\":1}}\"', 6, NULL, NULL, NULL, '2024-08-02 14:50:51', '2024-08-02 14:50:51'),
(84, '2024-08-02 14:55:47', 'Profile', '\"{\\\"success\\\":true,\\\"statusCode\\\":200,\\\"message\\\":\\\"Profile retrieved successfully\\\",\\\"query\\\":{},\\\"data\\\":{\\\"id\\\":1,\\\"name\\\":\\\"Eggi Dwitama\\\",\\\"contact\\\":\\\"085323085692\\\",\\\"username\\\":\\\"admin\\\",\\\"community_id\\\":1,\\\"community\\\":{\\\"id\\\":1,\\\"username\\\":\\\"pbbedahulu\\\",\\\"name\\\":\\\"PB BEDAHULU\\\",\\\"address\\\":\\\"Jl. Bedahulu X No. 17, Denpasar Utara - Bali\\\",\\\"contact\\\":\\\"087809538080\\\",\\\"pic\\\":\\\"Admin PB Bedahulu\\\",\\\"instagram\\\":\\\"@pb_bedahulu\\\",\\\"tiktok\\\":\\\"@pb_bedahulu\\\",\\\"email\\\":\\\"pbbedahulu@gmail.com\\\",\\\"website\\\":\\\"pbbedahulu.my.id\\\",\\\"logo\\\":\\\"logo-pbbedahulu.png\\\",\\\"createdAt\\\":\\\"2024-07-29T01:51:21.000Z\\\",\\\"updatedAt\\\":\\\"2024-07-29T01:51:21.000Z\\\"},\\\"iat\\\":1722226821}}\"', 1, NULL, NULL, NULL, '2024-08-02 14:55:47', '2024-08-02 14:55:47'),
(85, '2024-08-02 14:56:32', 'Profile', '\"{\\\"success\\\":true,\\\"statusCode\\\":200,\\\"message\\\":\\\"Profile retrieved successfully\\\",\\\"query\\\":{},\\\"data\\\":{\\\"id\\\":1,\\\"name\\\":\\\"Eggi Dwitama\\\",\\\"contact\\\":\\\"085323085692\\\",\\\"username\\\":\\\"admin\\\",\\\"community_id\\\":1,\\\"community\\\":{\\\"id\\\":1,\\\"username\\\":\\\"pbbedahulu\\\",\\\"name\\\":\\\"PB BEDAHULU\\\",\\\"address\\\":\\\"Jl. Bedahulu X No. 17, Denpasar Utara - Bali\\\",\\\"contact\\\":\\\"087809538080\\\",\\\"pic\\\":\\\"Admin PB Bedahulu\\\",\\\"instagram\\\":\\\"@pb_bedahulu\\\",\\\"tiktok\\\":\\\"@pb_bedahulu\\\",\\\"email\\\":\\\"pbbedahulu@gmail.com\\\",\\\"website\\\":\\\"pbbedahulu.my.id\\\",\\\"logo\\\":\\\"logo-pbbedahulu.png\\\",\\\"createdAt\\\":\\\"2024-07-29T01:51:21.000Z\\\",\\\"updatedAt\\\":\\\"2024-07-29T01:51:21.000Z\\\"},\\\"iat\\\":1722226821}}\"', 1, NULL, NULL, NULL, '2024-08-02 14:56:32', '2024-08-02 14:56:32'),
(86, '2024-08-03 10:47:20', 'Create Open Mabar Day Recap', '\"{\\\"success\\\":true,\\\"statusCode\\\":200,\\\"message\\\":\\\"Open Mabar Day Recap generated successfully\\\",\\\"query\\\":{\\\"open_mabar_day_id\\\":1,\\\"note\\\":\\\"mabar day one\\\",\\\"shuttlecock_provided\\\":36},\\\"data\\\":{\\\"id\\\":1,\\\"open_mabar_day_id\\\":1,\\\"date\\\":\\\"2024-07-30\\\",\\\"shuttlecock_provided\\\":36,\\\"shuttlecock_available\\\":null,\\\"note\\\":\\\"mabar day one\\\",\\\"user_id\\\":1,\\\"community_id\\\":1}}\"', 1, NULL, NULL, NULL, '2024-08-03 10:47:20', '2024-08-03 10:47:20'),
(87, '2024-08-03 10:50:47', 'Create Open Mabar Day Recap', '\"{\\\"success\\\":true,\\\"statusCode\\\":200,\\\"message\\\":\\\"Open Mabar Day Recap generated successfully\\\",\\\"query\\\":{\\\"open_mabar_day_id\\\":1,\\\"note\\\":\\\"mabar day one\\\",\\\"shuttlecock_provided\\\":36},\\\"data\\\":{\\\"id\\\":2,\\\"open_mabar_day_id\\\":1,\\\"date\\\":\\\"2024-07-30\\\",\\\"shuttlecock_provided\\\":36,\\\"shuttlecock_available\\\":null,\\\"note\\\":\\\"mabar day one\\\",\\\"user_id\\\":1,\\\"community_id\\\":1}}\"', 1, NULL, NULL, NULL, '2024-08-03 10:50:47', '2024-08-03 10:50:47'),
(88, '2024-08-03 10:55:50', 'Create Open Mabar Day Recap', '\"{\\\"success\\\":true,\\\"statusCode\\\":200,\\\"message\\\":\\\"Open Mabar Day Recap generated successfully\\\",\\\"query\\\":{\\\"open_mabar_day_id\\\":1,\\\"note\\\":\\\"mabar day one\\\",\\\"shuttlecock_provided\\\":36},\\\"data\\\":{\\\"id\\\":1,\\\"open_mabar_day_id\\\":1,\\\"date\\\":\\\"2024-07-30\\\",\\\"participant_count_member\\\":0,\\\"participant_count_nonmember\\\":27,\\\"total_matches_count\\\":11,\\\"shuttlecock_provided\\\":36,\\\"shuttlecock_used\\\":\\\"21\\\",\\\"shuttlecock_available\\\":15,\\\"note\\\":\\\"mabar day one\\\",\\\"user_id\\\":1,\\\"community_id\\\":1}}\"', 1, NULL, NULL, NULL, '2024-08-03 10:55:50', '2024-08-03 10:55:50'),
(89, '2024-08-05 10:26:06', 'Create Open Mabar Day Recap', '\"{\\\"success\\\":true,\\\"statusCode\\\":200,\\\"message\\\":\\\"Open Mabar Day Recap generated successfully\\\",\\\"query\\\":{\\\"open_mabar_day_id\\\":1,\\\"note\\\":\\\"mabar day one update\\\",\\\"shuttlecock_provided\\\":36},\\\"data\\\":[0]}\"', 1, NULL, NULL, NULL, '2024-08-05 10:26:06', '2024-08-05 10:26:06'),
(90, '2024-08-05 10:27:30', 'Create Open Mabar Day Recap', '\"{\\\"success\\\":true,\\\"statusCode\\\":200,\\\"message\\\":\\\"Open Mabar Day Recap generated successfully\\\",\\\"query\\\":{\\\"open_mabar_day_id\\\":1,\\\"note\\\":\\\"mabar day one update\\\",\\\"shuttlecock_provided\\\":36},\\\"data\\\":{\\\"id\\\":1,\\\"open_mabar_day_id\\\":1,\\\"date\\\":\\\"2024-07-30\\\",\\\"participant_count_member\\\":0,\\\"participant_count_nonmember\\\":27,\\\"total_matches_count\\\":11,\\\"shuttlecock_provided\\\":36,\\\"shuttlecock_used\\\":21,\\\"shuttlecock_available\\\":15,\\\"note\\\":\\\"mabar day one update\\\",\\\"user_id\\\":1,\\\"community_id\\\":1}}\"', 1, NULL, NULL, NULL, '2024-08-05 10:27:30', '2024-08-05 10:27:30'),
(91, '2024-08-05 10:27:35', 'Create Open Mabar Day Recap', '\"{\\\"success\\\":true,\\\"statusCode\\\":200,\\\"message\\\":\\\"Open Mabar Day Recap generated successfully\\\",\\\"query\\\":{\\\"open_mabar_day_id\\\":1,\\\"note\\\":\\\"mabar day one\\\",\\\"shuttlecock_provided\\\":36},\\\"data\\\":{\\\"id\\\":1,\\\"open_mabar_day_id\\\":1,\\\"date\\\":\\\"2024-07-30\\\",\\\"participant_count_member\\\":0,\\\"participant_count_nonmember\\\":27,\\\"total_matches_count\\\":11,\\\"shuttlecock_provided\\\":36,\\\"shuttlecock_used\\\":21,\\\"shuttlecock_available\\\":15,\\\"note\\\":\\\"mabar day one\\\",\\\"user_id\\\":1,\\\"community_id\\\":1}}\"', 1, NULL, NULL, NULL, '2024-08-05 10:27:35', '2024-08-05 10:27:35'),
(92, '2024-08-05 13:52:05', 'Create Player', '\"{\\\"success\\\":true,\\\"statusCode\\\":200,\\\"message\\\":\\\"Player create successfully\\\",\\\"query\\\":{\\\"name\\\":\\\"Dwiki\\\",\\\"alias\\\":\\\"wiki\\\",\\\"gender\\\":\\\"M\\\",\\\"contact\\\":\\\"081392427605\\\",\\\"level\\\":\\\"C\\\",\\\"age_range\\\":\\\"21-30\\\"},\\\"data\\\":{\\\"id\\\":33,\\\"name\\\":\\\"Dwiki\\\",\\\"alias\\\":\\\"wiki\\\",\\\"username\\\":\\\"wiki605\\\",\\\"gender\\\":\\\"M\\\",\\\"contact\\\":\\\"081392427605\\\",\\\"level\\\":\\\"C\\\",\\\"age_range\\\":\\\"21-30\\\",\\\"user_id\\\":1}}\"', 1, NULL, NULL, NULL, '2024-08-05 13:52:05', '2024-08-05 13:52:05'),
(93, '2024-08-05 13:52:48', 'Create Open Mabar Player', '\"{\\\"success\\\":true,\\\"statusCode\\\":200,\\\"message\\\":\\\"Open Mabar Player create successfully\\\",\\\"query\\\":{\\\"open_mabar_id\\\":1,\\\"player_id\\\":33,\\\"payment_method\\\":\\\"QRIS\\\",\\\"note\\\":\\\"\\\"},\\\"data\\\":{\\\"id\\\":8,\\\"community_id\\\":1,\\\"type\\\":\\\"in\\\",\\\"payment_method\\\":\\\"QRIS\\\",\\\"date\\\":\\\"2024-08-05\\\",\\\"source\\\":\\\"iuran member-Open Mabar Selasa\\\",\\\"nominal\\\":\\\"120000.00\\\",\\\"note\\\":\\\"iuran member-Open Mabar Selasa-Dwiki-081392427605\\\",\\\"user_id\\\":1,\\\"updatedAt\\\":\\\"2024-08-05T05:52:48.596Z\\\",\\\"createdAt\\\":\\\"2024-08-05T05:52:48.596Z\\\"}}\"', 1, NULL, NULL, NULL, '2024-08-05 13:52:48', '2024-08-05 13:52:48'),
(94, '2024-08-05 13:53:39', 'Create Player', '\"{\\\"success\\\":true,\\\"statusCode\\\":200,\\\"message\\\":\\\"Player create successfully\\\",\\\"query\\\":{\\\"name\\\":\\\"Arif\\\",\\\"alias\\\":\\\"arif\\\",\\\"gender\\\":\\\"M\\\",\\\"contact\\\":\\\"081339866427\\\",\\\"level\\\":\\\"C\\\",\\\"age_range\\\":\\\"21-30\\\"},\\\"data\\\":{\\\"id\\\":34,\\\"name\\\":\\\"Arif\\\",\\\"alias\\\":\\\"arif\\\",\\\"username\\\":\\\"arif427\\\",\\\"gender\\\":\\\"M\\\",\\\"contact\\\":\\\"081339866427\\\",\\\"level\\\":\\\"C\\\",\\\"age_range\\\":\\\"21-30\\\",\\\"user_id\\\":1}}\"', 1, NULL, NULL, NULL, '2024-08-05 13:53:39', '2024-08-05 13:53:39'),
(95, '2024-08-06 09:31:09', 'Create Player', '\"{\\\"success\\\":true,\\\"statusCode\\\":200,\\\"message\\\":\\\"Player create successfully\\\",\\\"query\\\":{\\\"name\\\":\\\"Made Cahyadi\\\",\\\"alias\\\":\\\"cahyadi\\\",\\\"gender\\\":\\\"M\\\",\\\"contact\\\":\\\"081111222012\\\",\\\"level\\\":\\\"A\\\",\\\"age_range\\\":\\\"31-40\\\"},\\\"data\\\":{\\\"id\\\":35,\\\"name\\\":\\\"Made Cahyadi\\\",\\\"alias\\\":\\\"cahyadi\\\",\\\"username\\\":\\\"cahyadi012\\\",\\\"gender\\\":\\\"M\\\",\\\"contact\\\":\\\"081111222012\\\",\\\"level\\\":\\\"A\\\",\\\"age_range\\\":\\\"31-40\\\",\\\"user_id\\\":1}}\"', 1, NULL, NULL, NULL, '2024-08-06 09:31:09', '2024-08-06 09:31:09'),
(96, '2024-08-06 09:31:31', 'Create Player', '\"{\\\"success\\\":true,\\\"statusCode\\\":200,\\\"message\\\":\\\"Player create successfully\\\",\\\"query\\\":{\\\"name\\\":\\\"Martono Putra\\\",\\\"alias\\\":\\\"nono\\\",\\\"gender\\\":\\\"M\\\",\\\"contact\\\":\\\"082299220069\\\",\\\"level\\\":\\\"A\\\",\\\"age_range\\\":\\\"31-40\\\"},\\\"data\\\":{\\\"id\\\":36,\\\"name\\\":\\\"Martono Putra\\\",\\\"alias\\\":\\\"nono\\\",\\\"username\\\":\\\"nono069\\\",\\\"gender\\\":\\\"M\\\",\\\"contact\\\":\\\"082299220069\\\",\\\"level\\\":\\\"A\\\",\\\"age_range\\\":\\\"31-40\\\",\\\"user_id\\\":1}}\"', 1, NULL, NULL, NULL, '2024-08-06 09:31:31', '2024-08-06 09:31:31'),
(97, '2024-08-06 09:31:48', 'Create Player', '\"{\\\"success\\\":true,\\\"statusCode\\\":200,\\\"message\\\":\\\"Player create successfully\\\",\\\"query\\\":{\\\"name\\\":\\\"Ardhi\\\",\\\"alias\\\":\\\"ardhi alila\\\",\\\"gender\\\":\\\"M\\\",\\\"contact\\\":\\\"085738225587\\\",\\\"level\\\":\\\"A\\\",\\\"age_range\\\":\\\"31-40\\\"},\\\"data\\\":{\\\"id\\\":37,\\\"name\\\":\\\"Ardhi\\\",\\\"alias\\\":\\\"ardhi alila\\\",\\\"username\\\":\\\"ardhialila587\\\",\\\"gender\\\":\\\"M\\\",\\\"contact\\\":\\\"085738225587\\\",\\\"level\\\":\\\"A\\\",\\\"age_range\\\":\\\"31-40\\\",\\\"user_id\\\":1}}\"', 1, NULL, NULL, NULL, '2024-08-06 09:31:48', '2024-08-06 09:31:48'),
(98, '2024-08-08 09:19:32', 'Create Player', '\"{\\\"success\\\":true,\\\"statusCode\\\":200,\\\"message\\\":\\\"Player create successfully\\\",\\\"query\\\":{\\\"name\\\":\\\"Ismi Azyzah\\\",\\\"alias\\\":\\\"ismi\\\",\\\"gender\\\":\\\"F\\\",\\\"contact\\\":\\\"08568620699\\\",\\\"level\\\":\\\"C\\\",\\\"age_range\\\":\\\"21-30\\\"},\\\"data\\\":{\\\"id\\\":38,\\\"name\\\":\\\"Ismi Azyzah\\\",\\\"alias\\\":\\\"ismi\\\",\\\"username\\\":\\\"ismi699\\\",\\\"gender\\\":\\\"F\\\",\\\"contact\\\":\\\"08568620699\\\",\\\"level\\\":\\\"C\\\",\\\"age_range\\\":\\\"21-30\\\",\\\"user_id\\\":1}}\"', 1, NULL, NULL, NULL, '2024-08-08 09:19:32', '2024-08-08 09:19:32'),
(99, '2024-08-08 09:20:01', 'Create Player', '\"{\\\"success\\\":true,\\\"statusCode\\\":200,\\\"message\\\":\\\"Player create successfully\\\",\\\"query\\\":{\\\"name\\\":\\\"Clara\\\",\\\"alias\\\":\\\"clara\\\",\\\"gender\\\":\\\"F\\\",\\\"contact\\\":\\\"085222333012\\\",\\\"level\\\":\\\"C\\\",\\\"age_range\\\":\\\"21-30\\\"},\\\"data\\\":{\\\"id\\\":39,\\\"name\\\":\\\"Clara\\\",\\\"alias\\\":\\\"clara\\\",\\\"username\\\":\\\"clara012\\\",\\\"gender\\\":\\\"F\\\",\\\"contact\\\":\\\"085222333012\\\",\\\"level\\\":\\\"C\\\",\\\"age_range\\\":\\\"21-30\\\",\\\"user_id\\\":1}}\"', 1, NULL, NULL, NULL, '2024-08-08 09:20:01', '2024-08-08 09:20:01'),
(100, '2024-08-08 09:20:25', 'Create Player', '\"{\\\"success\\\":true,\\\"statusCode\\\":200,\\\"message\\\":\\\"Player create successfully\\\",\\\"query\\\":{\\\"name\\\":\\\"Rico\\\",\\\"alias\\\":\\\"rico\\\",\\\"gender\\\":\\\"M\\\",\\\"contact\\\":\\\"085444333012\\\",\\\"level\\\":\\\"C\\\",\\\"age_range\\\":\\\"21-30\\\"},\\\"data\\\":{\\\"id\\\":40,\\\"name\\\":\\\"Rico\\\",\\\"alias\\\":\\\"rico\\\",\\\"username\\\":\\\"rico012\\\",\\\"gender\\\":\\\"M\\\",\\\"contact\\\":\\\"085444333012\\\",\\\"level\\\":\\\"C\\\",\\\"age_range\\\":\\\"21-30\\\",\\\"user_id\\\":1}}\"', 1, NULL, NULL, NULL, '2024-08-08 09:20:25', '2024-08-08 09:20:25'),
(101, '2024-08-08 09:20:45', 'Create Player', '\"{\\\"success\\\":true,\\\"statusCode\\\":200,\\\"message\\\":\\\"Player create successfully\\\",\\\"query\\\":{\\\"name\\\":\\\"Arga\\\",\\\"alias\\\":\\\"arga\\\",\\\"gender\\\":\\\"M\\\",\\\"contact\\\":\\\"082142534636\\\",\\\"level\\\":\\\"C\\\",\\\"age_range\\\":\\\"21-30\\\"},\\\"data\\\":{\\\"id\\\":41,\\\"name\\\":\\\"Arga\\\",\\\"alias\\\":\\\"arga\\\",\\\"username\\\":\\\"arga636\\\",\\\"gender\\\":\\\"M\\\",\\\"contact\\\":\\\"082142534636\\\",\\\"level\\\":\\\"C\\\",\\\"age_range\\\":\\\"21-30\\\",\\\"user_id\\\":1}}\"', 1, NULL, NULL, NULL, '2024-08-08 09:20:45', '2024-08-08 09:20:45'),
(102, '2024-08-08 09:24:42', 'Create Open Mabar Day Detail', '\"{\\\"success\\\":true,\\\"statusCode\\\":200,\\\"message\\\":\\\"Open Mabar Day Detail create successfully\\\",\\\"query\\\":{\\\"open_mabar_day_id\\\":2,\\\"player_id\\\":15,\\\"payment_status\\\":\\\"paid\\\",\\\"note\\\":\\\"\\\"},\\\"data\\\":{\\\"id\\\":30,\\\"open_mabar_day_id\\\":2,\\\"player_id\\\":15,\\\"player_level\\\":\\\"A\\\",\\\"payment_status\\\":\\\"paid\\\",\\\"user_id\\\":1,\\\"community_id\\\":1}}\"', 1, NULL, NULL, NULL, '2024-08-08 09:24:42', '2024-08-08 09:24:42'),
(103, '2024-08-08 09:27:26', 'Create Open Mabar Day Detail', '\"{\\\"success\\\":true,\\\"statusCode\\\":200,\\\"message\\\":\\\"Open Mabar Day Detail create successfully\\\",\\\"query\\\":{\\\"open_mabar_day_id\\\":2,\\\"player_id\\\":33,\\\"payment_method\\\":\\\"Cash\\\",\\\"payment_status\\\":\\\"paid\\\",\\\"note\\\":\\\"\\\"},\\\"data\\\":{\\\"id\\\":31,\\\"open_mabar_day_id\\\":2,\\\"player_id\\\":33,\\\"player_level\\\":\\\"C\\\",\\\"payment_status\\\":\\\"paid\\\",\\\"user_id\\\":1,\\\"community_id\\\":1}}\"', 1, NULL, NULL, NULL, '2024-08-08 09:27:26', '2024-08-08 09:27:26'),
(104, '2024-08-08 09:28:49', 'Create Open Mabar Player', '\"{\\\"success\\\":true,\\\"statusCode\\\":200,\\\"message\\\":\\\"Open Mabar Player create successfully\\\",\\\"query\\\":{\\\"open_mabar_id\\\":1,\\\"player_id\\\":33,\\\"payment_method\\\":\\\"QRIS\\\",\\\"note\\\":\\\"\\\"},\\\"data\\\":{\\\"id\\\":2,\\\"community_id\\\":1,\\\"type\\\":\\\"in\\\",\\\"payment_method\\\":\\\"QRIS\\\",\\\"date\\\":\\\"2024-08-08\\\",\\\"source\\\":\\\"iuran member-Open Mabar Selasa\\\",\\\"nominal\\\":\\\"120000.00\\\",\\\"note\\\":\\\"iuran member-Open Mabar Selasa-Dwiki-081392427605\\\",\\\"user_id\\\":1,\\\"updatedAt\\\":\\\"2024-08-08T01:28:49.262Z\\\",\\\"createdAt\\\":\\\"2024-08-08T01:28:49.262Z\\\"}}\"', 1, NULL, NULL, NULL, '2024-08-08 09:28:49', '2024-08-08 09:28:49'),
(105, '2024-08-08 09:29:25', 'Create Open Mabar Day Detail', '\"{\\\"success\\\":true,\\\"statusCode\\\":200,\\\"message\\\":\\\"Open Mabar Day Detail create successfully\\\",\\\"query\\\":{\\\"open_mabar_day_id\\\":2,\\\"player_id\\\":33,\\\"payment_method\\\":\\\"Cash\\\",\\\"payment_status\\\":\\\"paid\\\",\\\"note\\\":\\\"\\\"},\\\"data\\\":{\\\"id\\\":31,\\\"open_mabar_day_id\\\":2,\\\"player_id\\\":33,\\\"player_level\\\":\\\"C\\\",\\\"payment_status\\\":\\\"paid\\\",\\\"user_id\\\":1,\\\"community_id\\\":1}}\"', 1, NULL, NULL, NULL, '2024-08-08 09:29:25', '2024-08-08 09:29:25'),
(106, '2024-08-08 09:29:53', 'Create Open Mabar Day Detail', '\"{\\\"success\\\":true,\\\"statusCode\\\":200,\\\"message\\\":\\\"Open Mabar Day Detail create successfully\\\",\\\"query\\\":{\\\"open_mabar_day_id\\\":2,\\\"player_id\\\":6,\\\"payment_method\\\":\\\"QRIS\\\",\\\"payment_status\\\":\\\"paid\\\",\\\"note\\\":\\\"\\\"},\\\"data\\\":{\\\"id\\\":32,\\\"open_mabar_day_id\\\":2,\\\"player_id\\\":6,\\\"player_level\\\":\\\"A\\\",\\\"payment_status\\\":\\\"paid\\\",\\\"user_id\\\":1,\\\"community_id\\\":1}}\"', 1, NULL, NULL, NULL, '2024-08-08 09:29:53', '2024-08-08 09:29:53'),
(107, '2024-08-08 09:31:01', 'Create Open Mabar Day Detail', '\"{\\\"success\\\":true,\\\"statusCode\\\":200,\\\"message\\\":\\\"Open Mabar Day Detail create successfully\\\",\\\"query\\\":{\\\"open_mabar_day_id\\\":2,\\\"player_id\\\":3,\\\"payment_method\\\":\\\"QRIS\\\",\\\"payment_status\\\":\\\"paid\\\",\\\"note\\\":\\\"\\\"},\\\"data\\\":{\\\"id\\\":33,\\\"open_mabar_day_id\\\":2,\\\"player_id\\\":3,\\\"player_level\\\":\\\"A\\\",\\\"payment_status\\\":\\\"paid\\\",\\\"user_id\\\":1,\\\"community_id\\\":1}}\"', 1, NULL, NULL, NULL, '2024-08-08 09:31:01', '2024-08-08 09:31:01'),
(108, '2024-08-08 09:31:24', 'Create Open Mabar Day Detail', '\"{\\\"success\\\":true,\\\"statusCode\\\":200,\\\"message\\\":\\\"Open Mabar Day Detail create successfully\\\",\\\"query\\\":{\\\"open_mabar_day_id\\\":2,\\\"player_id\\\":34,\\\"payment_method\\\":\\\"QRIS\\\",\\\"payment_status\\\":\\\"paid\\\",\\\"note\\\":\\\"\\\"},\\\"data\\\":{\\\"id\\\":34,\\\"open_mabar_day_id\\\":2,\\\"player_id\\\":34,\\\"player_level\\\":\\\"C\\\",\\\"payment_status\\\":\\\"paid\\\",\\\"user_id\\\":1,\\\"community_id\\\":1}}\"', 1, NULL, NULL, NULL, '2024-08-08 09:31:24', '2024-08-08 09:31:24'),
(109, '2024-08-08 09:32:14', 'Create Open Mabar Day Detail', '\"{\\\"success\\\":true,\\\"statusCode\\\":200,\\\"message\\\":\\\"Open Mabar Day Detail create successfully\\\",\\\"query\\\":{\\\"open_mabar_day_id\\\":2,\\\"player_id\\\":5,\\\"payment_method\\\":\\\"Cash\\\",\\\"payment_status\\\":\\\"paid\\\",\\\"note\\\":\\\"\\\"},\\\"data\\\":{\\\"id\\\":35,\\\"open_mabar_day_id\\\":2,\\\"player_id\\\":5,\\\"player_level\\\":\\\"A\\\",\\\"payment_status\\\":\\\"paid\\\",\\\"user_id\\\":1,\\\"community_id\\\":1}}\"', 1, NULL, NULL, NULL, '2024-08-08 09:32:14', '2024-08-08 09:32:14'),
(110, '2024-08-08 09:32:44', 'Create Open Mabar Day Detail', '\"{\\\"success\\\":true,\\\"statusCode\\\":200,\\\"message\\\":\\\"Open Mabar Day Detail create successfully\\\",\\\"query\\\":{\\\"open_mabar_day_id\\\":2,\\\"player_id\\\":38,\\\"payment_method\\\":\\\"QRIS\\\",\\\"payment_status\\\":\\\"paid\\\",\\\"note\\\":\\\"\\\"},\\\"data\\\":{\\\"id\\\":36,\\\"open_mabar_day_id\\\":2,\\\"player_id\\\":38,\\\"player_level\\\":\\\"C\\\",\\\"payment_status\\\":\\\"paid\\\",\\\"user_id\\\":1,\\\"community_id\\\":1}}\"', 1, NULL, NULL, NULL, '2024-08-08 09:32:44', '2024-08-08 09:32:44'),
(111, '2024-08-08 09:33:08', 'Create Open Mabar Day Detail', '\"{\\\"success\\\":true,\\\"statusCode\\\":200,\\\"message\\\":\\\"Open Mabar Day Detail create successfully\\\",\\\"query\\\":{\\\"open_mabar_day_id\\\":2,\\\"player_id\\\":39,\\\"payment_method\\\":\\\"QRIS\\\",\\\"payment_status\\\":\\\"paid\\\",\\\"note\\\":\\\"\\\"},\\\"data\\\":{\\\"id\\\":37,\\\"open_mabar_day_id\\\":2,\\\"player_id\\\":39,\\\"player_level\\\":\\\"C\\\",\\\"payment_status\\\":\\\"paid\\\",\\\"user_id\\\":1,\\\"community_id\\\":1}}\"', 1, NULL, NULL, NULL, '2024-08-08 09:33:08', '2024-08-08 09:33:08'),
(112, '2024-08-08 09:33:19', 'Create Open Mabar Day Detail', '\"{\\\"success\\\":true,\\\"statusCode\\\":200,\\\"message\\\":\\\"Open Mabar Day Detail create successfully\\\",\\\"query\\\":{\\\"open_mabar_day_id\\\":2,\\\"player_id\\\":40,\\\"payment_method\\\":\\\"QRIS\\\",\\\"payment_status\\\":\\\"paid\\\",\\\"note\\\":\\\"\\\"},\\\"data\\\":{\\\"id\\\":38,\\\"open_mabar_day_id\\\":2,\\\"player_id\\\":40,\\\"player_level\\\":\\\"C\\\",\\\"payment_status\\\":\\\"paid\\\",\\\"user_id\\\":1,\\\"community_id\\\":1}}\"', 1, NULL, NULL, NULL, '2024-08-08 09:33:19', '2024-08-08 09:33:19'),
(113, '2024-08-08 09:33:51', 'Create Open Mabar Day Detail', '\"{\\\"success\\\":true,\\\"statusCode\\\":200,\\\"message\\\":\\\"Open Mabar Day Detail create successfully\\\",\\\"query\\\":{\\\"open_mabar_day_id\\\":2,\\\"player_id\\\":35,\\\"payment_method\\\":\\\"Cash\\\",\\\"payment_status\\\":\\\"paid\\\",\\\"note\\\":\\\"\\\"},\\\"data\\\":{\\\"id\\\":39,\\\"open_mabar_day_id\\\":2,\\\"player_id\\\":35,\\\"player_level\\\":\\\"A\\\",\\\"payment_status\\\":\\\"paid\\\",\\\"user_id\\\":1,\\\"community_id\\\":1}}\"', 1, NULL, NULL, NULL, '2024-08-08 09:33:51', '2024-08-08 09:33:51'),
(114, '2024-08-08 09:35:48', 'Create Player', '\"{\\\"success\\\":true,\\\"statusCode\\\":200,\\\"message\\\":\\\"Player create successfully\\\",\\\"query\\\":{\\\"name\\\":\\\"Irul\\\",\\\"alias\\\":\\\"irul\\\",\\\"gender\\\":\\\"M\\\",\\\"contact\\\":\\\"081936531237\\\",\\\"level\\\":\\\"B\\\",\\\"age_range\\\":\\\"21-30\\\"},\\\"data\\\":{\\\"id\\\":42,\\\"name\\\":\\\"Irul\\\",\\\"alias\\\":\\\"irul\\\",\\\"username\\\":\\\"irul237\\\",\\\"gender\\\":\\\"M\\\",\\\"contact\\\":\\\"081936531237\\\",\\\"level\\\":\\\"B\\\",\\\"age_range\\\":\\\"21-30\\\",\\\"user_id\\\":1}}\"', 1, NULL, NULL, NULL, '2024-08-08 09:35:48', '2024-08-08 09:35:48'),
(115, '2024-08-08 09:36:07', 'Create Open Mabar Day Detail', '\"{\\\"success\\\":true,\\\"statusCode\\\":200,\\\"message\\\":\\\"Open Mabar Day Detail create successfully\\\",\\\"query\\\":{\\\"open_mabar_day_id\\\":2,\\\"player_id\\\":42,\\\"payment_method\\\":\\\"Cash\\\",\\\"payment_status\\\":\\\"paid\\\",\\\"note\\\":\\\"\\\"},\\\"data\\\":{\\\"id\\\":40,\\\"open_mabar_day_id\\\":2,\\\"player_id\\\":42,\\\"player_level\\\":\\\"B\\\",\\\"payment_status\\\":\\\"paid\\\",\\\"user_id\\\":1,\\\"community_id\\\":1}}\"', 1, NULL, NULL, NULL, '2024-08-08 09:36:07', '2024-08-08 09:36:07'),
(116, '2024-08-08 09:36:34', 'Create Open Mabar Day Detail', '\"{\\\"success\\\":true,\\\"statusCode\\\":200,\\\"message\\\":\\\"Open Mabar Day Detail create successfully\\\",\\\"query\\\":{\\\"open_mabar_day_id\\\":2,\\\"player_id\\\":36,\\\"payment_method\\\":\\\"Cash\\\",\\\"payment_status\\\":\\\"paid\\\",\\\"note\\\":\\\"\\\"},\\\"data\\\":{\\\"id\\\":41,\\\"open_mabar_day_id\\\":2,\\\"player_id\\\":36,\\\"player_level\\\":\\\"A\\\",\\\"payment_status\\\":\\\"paid\\\",\\\"user_id\\\":1,\\\"community_id\\\":1}}\"', 1, NULL, NULL, NULL, '2024-08-08 09:36:34', '2024-08-08 09:36:34'),
(117, '2024-08-08 09:37:12', 'Create Open Mabar Day Detail', '\"{\\\"success\\\":true,\\\"statusCode\\\":200,\\\"message\\\":\\\"Open Mabar Day Detail create successfully\\\",\\\"query\\\":{\\\"open_mabar_day_id\\\":2,\\\"player_id\\\":37,\\\"payment_method\\\":\\\"Cash\\\",\\\"payment_status\\\":\\\"paid\\\",\\\"note\\\":\\\"\\\"},\\\"data\\\":{\\\"id\\\":42,\\\"open_mabar_day_id\\\":2,\\\"player_id\\\":37,\\\"player_level\\\":\\\"A\\\",\\\"payment_status\\\":\\\"paid\\\",\\\"user_id\\\":1,\\\"community_id\\\":1}}\"', 1, NULL, NULL, NULL, '2024-08-08 09:37:12', '2024-08-08 09:37:12'),
(118, '2024-08-08 09:37:46', 'Create Open Mabar Day Detail', '\"{\\\"success\\\":true,\\\"statusCode\\\":200,\\\"message\\\":\\\"Open Mabar Day Detail create successfully\\\",\\\"query\\\":{\\\"open_mabar_day_id\\\":2,\\\"player_id\\\":4,\\\"payment_method\\\":\\\"QRIS\\\",\\\"payment_status\\\":\\\"paid\\\",\\\"note\\\":\\\"\\\"},\\\"data\\\":{\\\"id\\\":43,\\\"open_mabar_day_id\\\":2,\\\"player_id\\\":4,\\\"player_level\\\":\\\"A\\\",\\\"payment_status\\\":\\\"paid\\\",\\\"user_id\\\":1,\\\"community_id\\\":1}}\"', 1, NULL, NULL, NULL, '2024-08-08 09:37:46', '2024-08-08 09:37:46'),
(119, '2024-08-08 09:38:50', 'Create Open Mabar Day Detail', '\"{\\\"success\\\":true,\\\"statusCode\\\":200,\\\"message\\\":\\\"Open Mabar Day Detail create successfully\\\",\\\"query\\\":{\\\"open_mabar_day_id\\\":2,\\\"player_id\\\":2,\\\"payment_method\\\":\\\"Cash\\\",\\\"payment_status\\\":\\\"paid\\\",\\\"note\\\":\\\"\\\"},\\\"data\\\":{\\\"id\\\":44,\\\"open_mabar_day_id\\\":2,\\\"player_id\\\":2,\\\"player_level\\\":\\\"A\\\",\\\"payment_status\\\":\\\"paid\\\",\\\"user_id\\\":1,\\\"community_id\\\":1}}\"', 1, NULL, NULL, NULL, '2024-08-08 09:38:50', '2024-08-08 09:38:50'),
(120, '2024-08-08 09:38:54', 'Create Open Mabar Day Detail', '\"{\\\"success\\\":true,\\\"statusCode\\\":200,\\\"message\\\":\\\"Open Mabar Day Detail create successfully\\\",\\\"query\\\":{\\\"open_mabar_day_id\\\":2,\\\"player_id\\\":1,\\\"payment_method\\\":\\\"Cash\\\",\\\"payment_status\\\":\\\"paid\\\",\\\"note\\\":\\\"\\\"},\\\"data\\\":{\\\"id\\\":45,\\\"open_mabar_day_id\\\":2,\\\"player_id\\\":1,\\\"player_level\\\":\\\"A\\\",\\\"payment_status\\\":\\\"paid\\\",\\\"user_id\\\":1,\\\"community_id\\\":1}}\"', 1, NULL, NULL, NULL, '2024-08-08 09:38:54', '2024-08-08 09:38:54'),
(121, '2024-08-08 09:41:12', 'Create Open Mabar Day Detail', '\"{\\\"success\\\":true,\\\"statusCode\\\":200,\\\"message\\\":\\\"Open Mabar Day Detail create successfully\\\",\\\"query\\\":{\\\"open_mabar_day_id\\\":2,\\\"player_id\\\":41,\\\"payment_method\\\":\\\"QRIS\\\",\\\"payment_status\\\":\\\"paid\\\",\\\"note\\\":\\\"\\\"},\\\"data\\\":{\\\"id\\\":46,\\\"open_mabar_day_id\\\":2,\\\"player_id\\\":41,\\\"player_level\\\":\\\"C\\\",\\\"payment_status\\\":\\\"paid\\\",\\\"user_id\\\":1,\\\"community_id\\\":1}}\"', 1, NULL, NULL, NULL, '2024-08-08 09:41:12', '2024-08-08 09:41:12'),
(122, '2024-08-08 09:43:39', 'Create Cashflow', '\"{\\\"success\\\":true,\\\"statusCode\\\":200,\\\"message\\\":\\\"Cashflow create successfully\\\",\\\"query\\\":{\\\"type\\\":\\\"out\\\",\\\"source\\\":\\\"\\\",\\\"payment_method\\\":\\\"Cash\\\",\\\"date\\\":\\\"2024-08-06\\\",\\\"nominal\\\":25000,\\\"note\\\":\\\"subsidi iuran non member khusus 5 orang (5000/orang)\\\"},\\\"data\\\":{\\\"id\\\":18,\\\"type\\\":\\\"out\\\",\\\"source\\\":\\\"\\\",\\\"payment_method\\\":\\\"Cash\\\",\\\"date\\\":\\\"2024-08-06\\\",\\\"nominal\\\":25000,\\\"note\\\":\\\"subsidi iuran non member khusus 5 orang (5000/orang)\\\",\\\"community_id\\\":1,\\\"user_id\\\":1,\\\"updatedAt\\\":\\\"2024-08-08T01:43:39.519Z\\\",\\\"createdAt\\\":\\\"2024-08-08T01:43:39.519Z\\\"}}\"', 1, NULL, NULL, NULL, '2024-08-08 09:43:39', '2024-08-08 09:43:39'),
(123, '2024-08-08 09:45:26', 'Create Cashflow', '\"{\\\"success\\\":true,\\\"statusCode\\\":200,\\\"message\\\":\\\"Cashflow create successfully\\\",\\\"query\\\":{\\\"type\\\":\\\"out\\\",\\\"purpose\\\":\\\"Buy Shuttlecock\\\",\\\"payment_method\\\":\\\"Bank Transfer\\\",\\\"date\\\":\\\"2024-08-06\\\",\\\"nominal\\\":291000,\\\"note\\\":\\\"pembelian 3 slop shuttlecock\\\"},\\\"data\\\":{\\\"id\\\":19,\\\"type\\\":\\\"out\\\",\\\"purpose\\\":\\\"Buy Shuttlecock\\\",\\\"payment_method\\\":\\\"Bank Transfer\\\",\\\"date\\\":\\\"2024-08-06\\\",\\\"nominal\\\":291000,\\\"note\\\":\\\"pembelian 3 slop shuttlecock\\\",\\\"community_id\\\":1,\\\"user_id\\\":1,\\\"updatedAt\\\":\\\"2024-08-08T01:45:26.742Z\\\",\\\"createdAt\\\":\\\"2024-08-08T01:45:26.742Z\\\"}}\"', 1, NULL, NULL, NULL, '2024-08-08 09:45:26', '2024-08-08 09:45:26'),
(124, '2024-08-08 14:07:38', 'Create Open Mabar Day Match ', '\"{\\\"success\\\":true,\\\"statusCode\\\":200,\\\"message\\\":\\\"Open Mabar Day  Match create successfully\\\",\\\"query\\\":{\\\"open_mabar_day_id\\\":1,\\\"court_id\\\":3,\\\"player_id_a1\\\":6,\\\"player_level_a1\\\":\\\"A\\\",\\\"player_id_a2\\\":34,\\\"player_level_a2\\\":\\\"B\\\",\\\"player_id_b1\\\":15,\\\"player_level_b1\\\":\\\"A\\\",\\\"player_id_b2\\\":33,\\\"player_level_b2\\\":\\\"B\\\",\\\"start_time\\\":\\\"19:20:00\\\",\\\"end_time\\\":\\\"19:42:00\\\",\\\"score\\\":\\\"33-42\\\",\\\"shuttlecock_used\\\":\\\"3\\\",\\\"note\\\":\\\"\\\"},\\\"data\\\":{\\\"id\\\":12,\\\"open_mabar_day_id\\\":1,\\\"court_id\\\":3,\\\"player_id_a1\\\":6,\\\"player_level_a1\\\":\\\"A\\\",\\\"player_id_a2\\\":34,\\\"player_level_a2\\\":\\\"B\\\",\\\"player_id_b1\\\":15,\\\"player_level_b1\\\":\\\"A\\\",\\\"player_id_b2\\\":33,\\\"player_level_b2\\\":\\\"B\\\",\\\"start_time\\\":\\\"19:20:00\\\",\\\"end_time\\\":\\\"19:42:00\\\",\\\"score\\\":\\\"33-42\\\",\\\"shuttlecock_used\\\":\\\"3\\\",\\\"note\\\":\\\"\\\",\\\"user_id\\\":1,\\\"community_id\\\":1}}\"', 1, NULL, NULL, NULL, '2024-08-08 14:07:38', '2024-08-08 14:07:38'),
(125, '2024-08-08 14:08:42', 'Create Open Mabar Day Match ', '\"{\\\"success\\\":true,\\\"statusCode\\\":200,\\\"message\\\":\\\"Open Mabar Day  Match create successfully\\\",\\\"query\\\":{\\\"open_mabar_day_id\\\":1,\\\"court_id\\\":3,\\\"player_id_a1\\\":36,\\\"player_level_a1\\\":\\\"A\\\",\\\"player_id_a2\\\":42,\\\"player_level_a2\\\":\\\"B\\\",\\\"player_id_b1\\\":35,\\\"player_level_b1\\\":\\\"A\\\",\\\"player_id_b2\\\":41,\\\"player_level_b2\\\":\\\"C\\\",\\\"start_time\\\":\\\"19:47:00\\\",\\\"end_time\\\":\\\"20:05:00\\\",\\\"score\\\":\\\"42-16\\\",\\\"shuttlecock_used\\\":\\\"2\\\",\\\"note\\\":\\\"\\\"},\\\"data\\\":{\\\"id\\\":13,\\\"open_mabar_day_id\\\":1,\\\"court_id\\\":3,\\\"player_id_a1\\\":36,\\\"player_level_a1\\\":\\\"A\\\",\\\"player_id_a2\\\":42,\\\"player_level_a2\\\":\\\"B\\\",\\\"player_id_b1\\\":35,\\\"player_level_b1\\\":\\\"A\\\",\\\"player_id_b2\\\":41,\\\"player_level_b2\\\":\\\"C\\\",\\\"start_time\\\":\\\"19:47:00\\\",\\\"end_time\\\":\\\"20:05:00\\\",\\\"score\\\":\\\"42-16\\\",\\\"shuttlecock_used\\\":\\\"2\\\",\\\"note\\\":\\\"\\\",\\\"user_id\\\":1,\\\"community_id\\\":1}}\"', 1, NULL, NULL, NULL, '2024-08-08 14:08:42', '2024-08-08 14:08:42'),
(126, '2024-08-08 14:09:40', 'Create Open Mabar Day Match ', '\"{\\\"success\\\":true,\\\"statusCode\\\":200,\\\"message\\\":\\\"Open Mabar Day  Match create successfully\\\",\\\"query\\\":{\\\"open_mabar_day_id\\\":1,\\\"court_id\\\":2,\\\"player_id_a1\\\":1,\\\"player_level_a1\\\":\\\"A\\\",\\\"player_id_a2\\\":38,\\\"player_level_a2\\\":\\\"C\\\",\\\"player_id_b1\\\":39,\\\"player_level_b1\\\":\\\"C\\\",\\\"player_id_b2\\\":40,\\\"player_level_b2\\\":\\\"C\\\",\\\"start_time\\\":\\\"19:35:00\\\",\\\"end_time\\\":\\\"19:51:00\\\",\\\"score\\\":\\\"42-11\\\",\\\"shuttlecock_used\\\":\\\"1\\\",\\\"note\\\":\\\"\\\"},\\\"data\\\":{\\\"id\\\":14,\\\"open_mabar_day_id\\\":1,\\\"court_id\\\":2,\\\"player_id_a1\\\":1,\\\"player_level_a1\\\":\\\"A\\\",\\\"player_id_a2\\\":38,\\\"player_level_a2\\\":\\\"C\\\",\\\"player_id_b1\\\":39,\\\"player_level_b1\\\":\\\"C\\\",\\\"player_id_b2\\\":40,\\\"player_level_b2\\\":\\\"C\\\",\\\"start_time\\\":\\\"19:35:00\\\",\\\"end_time\\\":\\\"19:51:00\\\",\\\"score\\\":\\\"42-11\\\",\\\"shuttlecock_used\\\":\\\"1\\\",\\\"note\\\":\\\"\\\",\\\"user_id\\\":1,\\\"community_id\\\":1}}\"', 1, NULL, NULL, NULL, '2024-08-08 14:09:40', '2024-08-08 14:09:40'),
(127, '2024-08-08 14:11:23', 'Create Open Mabar Day Match ', '\"{\\\"success\\\":true,\\\"statusCode\\\":200,\\\"message\\\":\\\"Open Mabar Day  Match create successfully\\\",\\\"query\\\":{\\\"open_mabar_day_id\\\":2,\\\"court_id\\\":2,\\\"player_id_a1\\\":2,\\\"player_level_a1\\\":\\\"A\\\",\\\"player_id_a2\\\":37,\\\"player_level_a2\\\":\\\"A\\\",\\\"player_id_b1\\\":3,\\\"player_level_b1\\\":\\\"A\\\",\\\"player_id_b2\\\":33,\\\"player_level_b2\\\":\\\"B\\\",\\\"start_time\\\":\\\"19:56:00\\\",\\\"end_time\\\":\\\"20:15:00\\\",\\\"score\\\":\\\"42-33\\\",\\\"shuttlecock_used\\\":\\\"2\\\",\\\"note\\\":\\\"\\\"},\\\"data\\\":{\\\"id\\\":15,\\\"open_mabar_day_id\\\":2,\\\"court_id\\\":2,\\\"player_id_a1\\\":2,\\\"player_level_a1\\\":\\\"A\\\",\\\"player_id_a2\\\":37,\\\"player_level_a2\\\":\\\"A\\\",\\\"player_id_b1\\\":3,\\\"player_level_b1\\\":\\\"A\\\",\\\"player_id_b2\\\":33,\\\"player_level_b2\\\":\\\"B\\\",\\\"start_time\\\":\\\"19:56:00\\\",\\\"end_time\\\":\\\"20:15:00\\\",\\\"score\\\":\\\"42-33\\\",\\\"shuttlecock_used\\\":\\\"2\\\",\\\"note\\\":\\\"\\\",\\\"user_id\\\":1,\\\"community_id\\\":1}}\"', 1, NULL, NULL, NULL, '2024-08-08 14:11:23', '2024-08-08 14:11:23'),
(128, '2024-08-08 14:12:49', 'Create Open Mabar Day Match ', '\"{\\\"success\\\":true,\\\"statusCode\\\":200,\\\"message\\\":\\\"Open Mabar Day  Match create successfully\\\",\\\"query\\\":{\\\"open_mabar_day_id\\\":2,\\\"court_id\\\":2,\\\"player_id_a1\\\":4,\\\"player_level_a1\\\":\\\"A\\\",\\\"player_id_a2\\\":41,\\\"player_level_a2\\\":\\\"C\\\",\\\"player_id_b1\\\":42,\\\"player_level_b1\\\":\\\"B\\\",\\\"player_id_b2\\\":34,\\\"player_level_b2\\\":\\\"B\\\",\\\"start_time\\\":\\\"20:20:00\\\",\\\"end_time\\\":\\\"20:41:00\\\",\\\"score\\\":\\\"33-42\\\",\\\"shuttlecock_used\\\":\\\"1\\\",\\\"note\\\":\\\"\\\"},\\\"data\\\":{\\\"id\\\":16,\\\"open_mabar_day_id\\\":2,\\\"court_id\\\":2,\\\"player_id_a1\\\":4,\\\"player_level_a1\\\":\\\"A\\\",\\\"player_id_a2\\\":41,\\\"player_level_a2\\\":\\\"C\\\",\\\"player_id_b1\\\":42,\\\"player_level_b1\\\":\\\"B\\\",\\\"player_id_b2\\\":34,\\\"player_level_b2\\\":\\\"B\\\",\\\"start_time\\\":\\\"20:20:00\\\",\\\"end_time\\\":\\\"20:41:00\\\",\\\"score\\\":\\\"33-42\\\",\\\"shuttlecock_used\\\":\\\"1\\\",\\\"note\\\":\\\"\\\",\\\"user_id\\\":1,\\\"community_id\\\":1}}\"', 1, NULL, NULL, NULL, '2024-08-08 14:12:49', '2024-08-08 14:12:49'),
(129, '2024-08-08 14:13:50', 'Create Open Mabar Day Match ', '\"{\\\"success\\\":true,\\\"statusCode\\\":200,\\\"message\\\":\\\"Open Mabar Day  Match create successfully\\\",\\\"query\\\":{\\\"open_mabar_day_id\\\":2,\\\"court_id\\\":3,\\\"player_id_a1\\\":15,\\\"player_level_a1\\\":\\\"A\\\",\\\"player_id_a2\\\":38,\\\"player_level_a2\\\":\\\"C\\\",\\\"player_id_b1\\\":40,\\\"player_level_b1\\\":\\\"C\\\",\\\"player_id_b2\\\":39,\\\"player_level_b2\\\":\\\"C\\\",\\\"start_time\\\":\\\"20:10:00\\\",\\\"end_time\\\":\\\"20:26:00\\\",\\\"score\\\":\\\"42-9\\\",\\\"shuttlecock_used\\\":\\\"1\\\",\\\"note\\\":\\\"\\\"},\\\"data\\\":{\\\"id\\\":17,\\\"open_mabar_day_id\\\":2,\\\"court_id\\\":3,\\\"player_id_a1\\\":15,\\\"player_level_a1\\\":\\\"A\\\",\\\"player_id_a2\\\":38,\\\"player_level_a2\\\":\\\"C\\\",\\\"player_id_b1\\\":40,\\\"player_level_b1\\\":\\\"C\\\",\\\"player_id_b2\\\":39,\\\"player_level_b2\\\":\\\"C\\\",\\\"start_time\\\":\\\"20:10:00\\\",\\\"end_time\\\":\\\"20:26:00\\\",\\\"score\\\":\\\"42-9\\\",\\\"shuttlecock_used\\\":\\\"1\\\",\\\"note\\\":\\\"\\\",\\\"user_id\\\":1,\\\"community_id\\\":1}}\"', 1, NULL, NULL, NULL, '2024-08-08 14:13:50', '2024-08-08 14:13:50'),
(130, '2024-08-08 14:15:30', 'Create Open Mabar Day Match ', '\"{\\\"success\\\":true,\\\"statusCode\\\":200,\\\"message\\\":\\\"Open Mabar Day  Match create successfully\\\",\\\"query\\\":{\\\"open_mabar_day_id\\\":2,\\\"court_id\\\":3,\\\"player_id_a1\\\":15,\\\"player_level_a1\\\":\\\"A\\\",\\\"player_id_a2\\\":37,\\\"player_level_a2\\\":\\\"A\\\",\\\"player_id_b1\\\":36,\\\"player_level_b1\\\":\\\"A\\\",\\\"player_id_b2\\\":35,\\\"player_level_b2\\\":\\\"A\\\",\\\"start_time\\\":\\\"20:30:00\\\",\\\"end_time\\\":\\\"20:50:00\\\",\\\"score\\\":\\\"42-39\\\",\\\"shuttlecock_used\\\":\\\"3\\\",\\\"note\\\":\\\"\\\"},\\\"data\\\":{\\\"id\\\":18,\\\"open_mabar_day_id\\\":2,\\\"court_id\\\":3,\\\"player_id_a1\\\":15,\\\"player_level_a1\\\":\\\"A\\\",\\\"player_id_a2\\\":37,\\\"player_level_a2\\\":\\\"A\\\",\\\"player_id_b1\\\":36,\\\"player_level_b1\\\":\\\"A\\\",\\\"player_id_b2\\\":35,\\\"player_level_b2\\\":\\\"A\\\",\\\"start_time\\\":\\\"20:30:00\\\",\\\"end_time\\\":\\\"20:50:00\\\",\\\"score\\\":\\\"42-39\\\",\\\"shuttlecock_used\\\":\\\"3\\\",\\\"note\\\":\\\"\\\",\\\"user_id\\\":1,\\\"community_id\\\":1}}\"', 1, NULL, NULL, NULL, '2024-08-08 14:15:30', '2024-08-08 14:15:30'),
(131, '2024-08-08 14:16:27', 'Create Open Mabar Day Match ', '\"{\\\"success\\\":true,\\\"statusCode\\\":200,\\\"message\\\":\\\"Open Mabar Day  Match create successfully\\\",\\\"query\\\":{\\\"open_mabar_day_id\\\":2,\\\"court_id\\\":2,\\\"player_id_a1\\\":4,\\\"player_level_a1\\\":\\\"A\\\",\\\"player_id_a2\\\":6,\\\"player_level_a2\\\":\\\"A\\\",\\\"player_id_b1\\\":1,\\\"player_level_b1\\\":\\\"A\\\",\\\"player_id_b2\\\":2,\\\"player_level_b2\\\":\\\"A\\\",\\\"start_time\\\":\\\"20:45:00\\\",\\\"end_time\\\":\\\"21:05:00\\\",\\\"score\\\":\\\"30-42\\\",\\\"shuttlecock_used\\\":\\\"3\\\",\\\"note\\\":\\\"\\\"},\\\"data\\\":{\\\"id\\\":19,\\\"open_mabar_day_id\\\":2,\\\"court_id\\\":2,\\\"player_id_a1\\\":4,\\\"player_level_a1\\\":\\\"A\\\",\\\"player_id_a2\\\":6,\\\"player_level_a2\\\":\\\"A\\\",\\\"player_id_b1\\\":1,\\\"player_level_b1\\\":\\\"A\\\",\\\"player_id_b2\\\":2,\\\"player_level_b2\\\":\\\"A\\\",\\\"start_time\\\":\\\"20:45:00\\\",\\\"end_time\\\":\\\"21:05:00\\\",\\\"score\\\":\\\"30-42\\\",\\\"shuttlecock_used\\\":\\\"3\\\",\\\"note\\\":\\\"\\\",\\\"user_id\\\":1,\\\"community_id\\\":1}}\"', 1, NULL, NULL, NULL, '2024-08-08 14:16:27', '2024-08-08 14:16:27');
INSERT INTO `log` (`id`, `datetime`, `activity`, `description`, `user_id`, `user_job`, `note`, `account_id`, `createdAt`, `updatedAt`) VALUES
(132, '2024-08-08 14:17:22', 'Create Open Mabar Day Match ', '\"{\\\"success\\\":true,\\\"statusCode\\\":200,\\\"message\\\":\\\"Open Mabar Day  Match create successfully\\\",\\\"query\\\":{\\\"open_mabar_day_id\\\":2,\\\"court_id\\\":3,\\\"player_id_a1\\\":3,\\\"player_level_a1\\\":\\\"A\\\",\\\"player_id_a2\\\":42,\\\"player_level_a2\\\":\\\"B\\\",\\\"player_id_b1\\\":37,\\\"player_level_b1\\\":\\\"A\\\",\\\"player_id_b2\\\":33,\\\"player_level_b2\\\":\\\"B\\\",\\\"start_time\\\":\\\"20:50:00\\\",\\\"end_time\\\":\\\"21:15:00\\\",\\\"score\\\":\\\"32-42\\\",\\\"shuttlecock_used\\\":\\\"2\\\",\\\"note\\\":\\\"\\\"},\\\"data\\\":{\\\"id\\\":20,\\\"open_mabar_day_id\\\":2,\\\"court_id\\\":3,\\\"player_id_a1\\\":3,\\\"player_level_a1\\\":\\\"A\\\",\\\"player_id_a2\\\":42,\\\"player_level_a2\\\":\\\"B\\\",\\\"player_id_b1\\\":37,\\\"player_level_b1\\\":\\\"A\\\",\\\"player_id_b2\\\":33,\\\"player_level_b2\\\":\\\"B\\\",\\\"start_time\\\":\\\"20:50:00\\\",\\\"end_time\\\":\\\"21:15:00\\\",\\\"score\\\":\\\"32-42\\\",\\\"shuttlecock_used\\\":\\\"2\\\",\\\"note\\\":\\\"\\\",\\\"user_id\\\":1,\\\"community_id\\\":1}}\"', 1, NULL, NULL, NULL, '2024-08-08 14:17:22', '2024-08-08 14:17:22'),
(133, '2024-08-08 14:18:34', 'Create Open Mabar Day Match ', '\"{\\\"success\\\":true,\\\"statusCode\\\":200,\\\"message\\\":\\\"Open Mabar Day  Match create successfully\\\",\\\"query\\\":{\\\"open_mabar_day_id\\\":2,\\\"court_id\\\":2,\\\"player_id_a1\\\":34,\\\"player_level_a1\\\":\\\"B\\\",\\\"player_id_a2\\\":41,\\\"player_level_a2\\\":\\\"C\\\",\\\"player_id_b1\\\":1,\\\"player_level_b1\\\":\\\"A\\\",\\\"player_id_b2\\\":38,\\\"player_level_b2\\\":\\\"C\\\",\\\"start_time\\\":\\\"21:00:00\\\",\\\"end_time\\\":\\\"21:30:00\\\",\\\"score\\\":\\\"27-42\\\",\\\"shuttlecock_used\\\":\\\"1\\\",\\\"note\\\":\\\"\\\"},\\\"data\\\":{\\\"id\\\":21,\\\"open_mabar_day_id\\\":2,\\\"court_id\\\":2,\\\"player_id_a1\\\":34,\\\"player_level_a1\\\":\\\"B\\\",\\\"player_id_a2\\\":41,\\\"player_level_a2\\\":\\\"C\\\",\\\"player_id_b1\\\":1,\\\"player_level_b1\\\":\\\"A\\\",\\\"player_id_b2\\\":38,\\\"player_level_b2\\\":\\\"C\\\",\\\"start_time\\\":\\\"21:00:00\\\",\\\"end_time\\\":\\\"21:30:00\\\",\\\"score\\\":\\\"27-42\\\",\\\"shuttlecock_used\\\":\\\"1\\\",\\\"note\\\":\\\"\\\",\\\"user_id\\\":1,\\\"community_id\\\":1}}\"', 1, NULL, NULL, NULL, '2024-08-08 14:18:34', '2024-08-08 14:18:34'),
(134, '2024-08-08 14:19:48', 'Create Open Mabar Day Match ', '\"{\\\"success\\\":true,\\\"statusCode\\\":200,\\\"message\\\":\\\"Open Mabar Day  Match create successfully\\\",\\\"query\\\":{\\\"open_mabar_day_id\\\":2,\\\"court_id\\\":3,\\\"player_id_a1\\\":2,\\\"player_level_a1\\\":\\\"A\\\",\\\"player_id_a2\\\":5,\\\"player_level_a2\\\":\\\"A\\\",\\\"player_id_b1\\\":36,\\\"player_level_b1\\\":\\\"A\\\",\\\"player_id_b2\\\":35,\\\"player_level_b2\\\":\\\"A\\\",\\\"start_time\\\":\\\"21:20:00\\\",\\\"end_time\\\":\\\"21:39:00\\\",\\\"score\\\":\\\"42-24\\\",\\\"shuttlecock_used\\\":\\\"2\\\",\\\"note\\\":\\\"\\\"},\\\"data\\\":{\\\"id\\\":22,\\\"open_mabar_day_id\\\":2,\\\"court_id\\\":3,\\\"player_id_a1\\\":2,\\\"player_level_a1\\\":\\\"A\\\",\\\"player_id_a2\\\":5,\\\"player_level_a2\\\":\\\"A\\\",\\\"player_id_b1\\\":36,\\\"player_level_b1\\\":\\\"A\\\",\\\"player_id_b2\\\":35,\\\"player_level_b2\\\":\\\"A\\\",\\\"start_time\\\":\\\"21:20:00\\\",\\\"end_time\\\":\\\"21:39:00\\\",\\\"score\\\":\\\"42-24\\\",\\\"shuttlecock_used\\\":\\\"2\\\",\\\"note\\\":\\\"\\\",\\\"user_id\\\":1,\\\"community_id\\\":1}}\"', 1, NULL, NULL, NULL, '2024-08-08 14:19:48', '2024-08-08 14:19:48'),
(135, '2024-08-08 14:21:09', 'Create Open Mabar Day Match ', '\"{\\\"success\\\":true,\\\"statusCode\\\":200,\\\"message\\\":\\\"Open Mabar Day  Match create successfully\\\",\\\"query\\\":{\\\"open_mabar_day_id\\\":2,\\\"court_id\\\":2,\\\"player_id_a1\\\":15,\\\"player_level_a1\\\":\\\"A\\\",\\\"player_id_a2\\\":37,\\\"player_level_a2\\\":\\\"A\\\",\\\"player_id_b1\\\":42,\\\"player_level_b1\\\":\\\"B\\\",\\\"player_id_b2\\\":33,\\\"player_level_b2\\\":\\\"B\\\",\\\"start_time\\\":\\\"21:35:00\\\",\\\"end_time\\\":\\\"21:15:00\\\",\\\"score\\\":\\\"42-33\\\",\\\"shuttlecock_used\\\":\\\"2\\\",\\\"note\\\":\\\"\\\"},\\\"data\\\":{\\\"id\\\":23,\\\"open_mabar_day_id\\\":2,\\\"court_id\\\":2,\\\"player_id_a1\\\":15,\\\"player_level_a1\\\":\\\"A\\\",\\\"player_id_a2\\\":37,\\\"player_level_a2\\\":\\\"A\\\",\\\"player_id_b1\\\":42,\\\"player_level_b1\\\":\\\"B\\\",\\\"player_id_b2\\\":33,\\\"player_level_b2\\\":\\\"B\\\",\\\"start_time\\\":\\\"21:35:00\\\",\\\"end_time\\\":\\\"21:15:00\\\",\\\"score\\\":\\\"42-33\\\",\\\"shuttlecock_used\\\":\\\"2\\\",\\\"note\\\":\\\"\\\",\\\"user_id\\\":1,\\\"community_id\\\":1}}\"', 1, NULL, NULL, NULL, '2024-08-08 14:21:09', '2024-08-08 14:21:09'),
(136, '2024-08-08 14:22:21', 'Create Open Mabar Day Match ', '\"{\\\"success\\\":true,\\\"statusCode\\\":200,\\\"message\\\":\\\"Open Mabar Day  Match create successfully\\\",\\\"query\\\":{\\\"open_mabar_day_id\\\":2,\\\"court_id\\\":3,\\\"player_id_a1\\\":4,\\\"player_level_a1\\\":\\\"A\\\",\\\"player_id_a2\\\":41,\\\"player_level_a2\\\":\\\"C\\\",\\\"player_id_b1\\\":1,\\\"player_level_b1\\\":\\\"A\\\",\\\"player_id_b2\\\":38,\\\"player_level_b2\\\":\\\"C\\\",\\\"start_time\\\":\\\"21:35:00\\\",\\\"end_time\\\":\\\"22:00:00\\\",\\\"score\\\":\\\"38-42\\\",\\\"shuttlecock_used\\\":\\\"1\\\",\\\"note\\\":\\\"\\\"},\\\"data\\\":{\\\"id\\\":24,\\\"open_mabar_day_id\\\":2,\\\"court_id\\\":3,\\\"player_id_a1\\\":4,\\\"player_level_a1\\\":\\\"A\\\",\\\"player_id_a2\\\":41,\\\"player_level_a2\\\":\\\"C\\\",\\\"player_id_b1\\\":1,\\\"player_level_b1\\\":\\\"A\\\",\\\"player_id_b2\\\":38,\\\"player_level_b2\\\":\\\"C\\\",\\\"start_time\\\":\\\"21:35:00\\\",\\\"end_time\\\":\\\"22:00:00\\\",\\\"score\\\":\\\"38-42\\\",\\\"shuttlecock_used\\\":\\\"1\\\",\\\"note\\\":\\\"\\\",\\\"user_id\\\":1,\\\"community_id\\\":1}}\"', 1, NULL, NULL, NULL, '2024-08-08 14:22:21', '2024-08-08 14:22:21'),
(137, '2024-08-08 14:23:12', 'Create Open Mabar Day Match ', '\"{\\\"success\\\":true,\\\"statusCode\\\":200,\\\"message\\\":\\\"Open Mabar Day  Match create successfully\\\",\\\"query\\\":{\\\"open_mabar_day_id\\\":2,\\\"court_id\\\":2,\\\"player_id_a1\\\":1,\\\"player_level_a1\\\":\\\"A\\\",\\\"player_id_a2\\\":42,\\\"player_level_a2\\\":\\\"B\\\",\\\"player_id_b1\\\":5,\\\"player_level_b1\\\":\\\"A\\\",\\\"player_id_b2\\\":34,\\\"player_level_b2\\\":\\\"B\\\",\\\"start_time\\\":\\\"21:40:00\\\",\\\"end_time\\\":\\\"22:00:00\\\",\\\"score\\\":\\\"42-25\\\",\\\"shuttlecock_used\\\":\\\"2\\\",\\\"note\\\":\\\"\\\"},\\\"data\\\":{\\\"id\\\":25,\\\"open_mabar_day_id\\\":2,\\\"court_id\\\":2,\\\"player_id_a1\\\":1,\\\"player_level_a1\\\":\\\"A\\\",\\\"player_id_a2\\\":42,\\\"player_level_a2\\\":\\\"B\\\",\\\"player_id_b1\\\":5,\\\"player_level_b1\\\":\\\"A\\\",\\\"player_id_b2\\\":34,\\\"player_level_b2\\\":\\\"B\\\",\\\"start_time\\\":\\\"21:40:00\\\",\\\"end_time\\\":\\\"22:00:00\\\",\\\"score\\\":\\\"42-25\\\",\\\"shuttlecock_used\\\":\\\"2\\\",\\\"note\\\":\\\"\\\",\\\"user_id\\\":1,\\\"community_id\\\":1}}\"', 1, NULL, NULL, NULL, '2024-08-08 14:23:12', '2024-08-08 14:23:12'),
(138, '2024-08-08 14:25:12', 'Create Open Mabar Day Recap', '\"{\\\"success\\\":true,\\\"statusCode\\\":200,\\\"message\\\":\\\"Open Mabar Day Recap generated successfully\\\",\\\"query\\\":{\\\"open_mabar_day_id\\\":2,\\\"note\\\":\\\"mabar perdana\\\",\\\"shuttlecock_provided\\\":36},\\\"data\\\":{\\\"id\\\":2,\\\"open_mabar_day_id\\\":2,\\\"date\\\":\\\"2024-08-06\\\",\\\"participant_count_member\\\":1,\\\"participant_count_nonmember\\\":36,\\\"total_matches_count\\\":14,\\\"shuttlecock_provided\\\":36,\\\"shuttlecock_used\\\":26,\\\"shuttlecock_available\\\":10,\\\"note\\\":\\\"mabar perdana\\\",\\\"user_id\\\":1,\\\"community_id\\\":1}}\"', 1, NULL, NULL, NULL, '2024-08-08 14:25:12', '2024-08-08 14:25:12'),
(139, '2024-08-08 14:47:40', 'Create Open Mabar Day Recap', '\"{\\\"success\\\":true,\\\"statusCode\\\":200,\\\"message\\\":\\\"Open Mabar Day Recap generated successfully\\\",\\\"query\\\":{\\\"open_mabar_day_id\\\":2,\\\"note\\\":\\\"mabar perdana\\\",\\\"shuttlecock_provided\\\":36},\\\"data\\\":{\\\"id\\\":2,\\\"open_mabar_day_id\\\":2,\\\"date\\\":\\\"2024-08-06\\\",\\\"participant_count_member\\\":1,\\\"participant_count_nonmember\\\":16,\\\"total_matches_count\\\":14,\\\"shuttlecock_provided\\\":36,\\\"shuttlecock_used\\\":26,\\\"shuttlecock_available\\\":10,\\\"note\\\":\\\"mabar perdana\\\",\\\"user_id\\\":1,\\\"community_id\\\":1}}\"', 1, NULL, NULL, NULL, '2024-08-08 14:47:40', '2024-08-08 14:47:40'),
(140, '2024-08-11 10:18:34', 'Login', '\"{\\\"success\\\":true,\\\"statusCode\\\":200,\\\"message\\\":\\\"Login successfully\\\",\\\"query\\\":{\\\"username\\\":\\\"admin@pbbedahulu\\\",\\\"password\\\":\\\"pbbedahulu!\\\"},\\\"data\\\":{\\\"id\\\":1,\\\"name\\\":\\\"Eggi Dwitama\\\",\\\"username\\\":\\\"admin\\\",\\\"contact\\\":\\\"085323085692\\\",\\\"community_id\\\":1,\\\"community_name\\\":\\\"PB BEDAHULU\\\",\\\"community\\\":\\\"pbbedahulu\\\",\\\"token\\\":\\\"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwibmFtZSI6IkVnZ2kgRHdpdGFtYSIsImNvbnRhY3QiOiIwODUzMjMwODU2OTIiLCJ1c2VybmFtZSI6ImFkbWluIiwiY29tbXVuaXR5X2lkIjoxLCJjb21tdW5pdHkiOnsiaWQiOjEsInVzZXJuYW1lIjoicGJiZWRhaHVsdSIsIm5hbWUiOiJQQiBCRURBSFVMVSIsImFkZHJlc3MiOiJKbC4gQmVkYWh1bHUgWCBOby4gMTcsIERlbnBhc2FyIFV0YXJhIC0gQmFsaSIsImNvbnRhY3QiOiIwODc4MDk1MzgwODAiLCJwaWMiOiJBZG1pbiBQQiBCZWRhaHVsdSIsImluc3RhZ3JhbSI6IkBwYl9iZWRhaHVsdSIsInRpa3RvayI6IkBwYl9iZWRhaHVsdSIsImVtYWlsIjoicGJiZWRhaHVsdUBnbWFpbC5jb20iLCJ3ZWJzaXRlIjoicGJiZWRhaHVsdS5teS5pZCIsImxvZ28iOiJsb2dvLXBiYmVkYWh1bHUucG5nIiwiY3JlYXRlZEF0IjoiMjAyNC0wNy0yOVQwMTo1MToyMS4wMDBaIiwidXBkYXRlZEF0IjoiMjAyNC0wNy0yOVQwMTo1MToyMS4wMDBaIn0sImlhdCI6MTcyMzM0MjcxNH0.Hrv-bNqx2bGreAU8EnnkwOgBRuSoR4w69FK1H2CrwfQ\\\"}}\"', 1, NULL, NULL, NULL, '2024-08-11 10:18:34', '2024-08-11 10:18:34'),
(141, '2024-08-11 10:28:43', 'Login', '\"{\\\"success\\\":true,\\\"statusCode\\\":200,\\\"message\\\":\\\"Login successfully\\\",\\\"query\\\":{\\\"username\\\":\\\"admin@pbbedahulu\\\",\\\"password\\\":\\\"pbbedahulu!\\\"},\\\"data\\\":{\\\"id\\\":1,\\\"name\\\":\\\"Eggi Dwitama\\\",\\\"username\\\":\\\"admin\\\",\\\"contact\\\":\\\"085323085692\\\",\\\"community_id\\\":1,\\\"community_name\\\":\\\"PB BEDAHULU\\\",\\\"community\\\":\\\"pbbedahulu\\\",\\\"token\\\":\\\"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwibmFtZSI6IkVnZ2kgRHdpdGFtYSIsImNvbnRhY3QiOiIwODUzMjMwODU2OTIiLCJ1c2VybmFtZSI6ImFkbWluIiwiY29tbXVuaXR5X2lkIjoxLCJjb21tdW5pdHkiOnsiaWQiOjEsInVzZXJuYW1lIjoicGJiZWRhaHVsdSIsIm5hbWUiOiJQQiBCRURBSFVMVSIsImFkZHJlc3MiOiJKbC4gQmVkYWh1bHUgWCBOby4gMTcsIERlbnBhc2FyIFV0YXJhIC0gQmFsaSIsImNvbnRhY3QiOiIwODc4MDk1MzgwODAiLCJwaWMiOiJBZG1pbiBQQiBCZWRhaHVsdSIsImluc3RhZ3JhbSI6IkBwYl9iZWRhaHVsdSIsInRpa3RvayI6IkBwYl9iZWRhaHVsdSIsImVtYWlsIjoicGJiZWRhaHVsdUBnbWFpbC5jb20iLCJ3ZWJzaXRlIjoicGJiZWRhaHVsdS5teS5pZCIsImxvZ28iOiJsb2dvLXBiYmVkYWh1bHUucG5nIiwiY3JlYXRlZEF0IjoiMjAyNC0wNy0yOVQwMTo1MToyMS4wMDBaIiwidXBkYXRlZEF0IjoiMjAyNC0wNy0yOVQwMTo1MToyMS4wMDBaIn0sImlhdCI6MTcyMzM0MzMyM30.rm9dsmH6ITLf0WqBforhh__rNrCKIQErbj7xbMy8C7Y\\\"}}\"', 1, NULL, NULL, NULL, '2024-08-11 10:28:43', '2024-08-11 10:28:43'),
(142, '2024-08-11 10:30:50', 'Login', '\"{\\\"success\\\":true,\\\"statusCode\\\":200,\\\"message\\\":\\\"Login successfully\\\",\\\"query\\\":{\\\"username\\\":\\\"admin@pbbedahulu\\\",\\\"password\\\":\\\"pbbedahulu!\\\"},\\\"data\\\":{\\\"id\\\":1,\\\"name\\\":\\\"Eggi Dwitama\\\",\\\"username\\\":\\\"admin\\\",\\\"contact\\\":\\\"085323085692\\\",\\\"community_id\\\":1,\\\"community_name\\\":\\\"PB BEDAHULU\\\",\\\"community\\\":\\\"pbbedahulu\\\",\\\"token\\\":\\\"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwibmFtZSI6IkVnZ2kgRHdpdGFtYSIsImNvbnRhY3QiOiIwODUzMjMwODU2OTIiLCJ1c2VybmFtZSI6ImFkbWluIiwiY29tbXVuaXR5X2lkIjoxLCJjb21tdW5pdHkiOnsiaWQiOjEsInVzZXJuYW1lIjoicGJiZWRhaHVsdSIsIm5hbWUiOiJQQiBCRURBSFVMVSIsImFkZHJlc3MiOiJKbC4gQmVkYWh1bHUgWCBOby4gMTcsIERlbnBhc2FyIFV0YXJhIC0gQmFsaSIsImNvbnRhY3QiOiIwODc4MDk1MzgwODAiLCJwaWMiOiJBZG1pbiBQQiBCZWRhaHVsdSIsImluc3RhZ3JhbSI6IkBwYl9iZWRhaHVsdSIsInRpa3RvayI6IkBwYl9iZWRhaHVsdSIsImVtYWlsIjoicGJiZWRhaHVsdUBnbWFpbC5jb20iLCJ3ZWJzaXRlIjoicGJiZWRhaHVsdS5teS5pZCIsImxvZ28iOiJsb2dvLXBiYmVkYWh1bHUucG5nIiwiY3JlYXRlZEF0IjoiMjAyNC0wNy0yOVQwMTo1MToyMS4wMDBaIiwidXBkYXRlZEF0IjoiMjAyNC0wNy0yOVQwMTo1MToyMS4wMDBaIn0sImlhdCI6MTcyMzM0MzQ1MH0.ZnJHKLoi-ocXIdo7SL5S_i7EXh6ZdNpNCw683Y4xwNk\\\"}}\"', 1, NULL, NULL, NULL, '2024-08-11 10:30:50', '2024-08-11 10:30:50'),
(143, '2024-08-11 10:44:56', 'Login', '\"{\\\"success\\\":true,\\\"statusCode\\\":200,\\\"message\\\":\\\"Login successfully\\\",\\\"query\\\":{\\\"username\\\":\\\"admin@pbbedahulu\\\",\\\"password\\\":\\\"pbbedahulu!\\\"},\\\"data\\\":{\\\"id\\\":1,\\\"name\\\":\\\"Eggi Dwitama\\\",\\\"username\\\":\\\"admin\\\",\\\"contact\\\":\\\"085323085692\\\",\\\"community_id\\\":1,\\\"community_name\\\":\\\"PB BEDAHULU\\\",\\\"community\\\":\\\"pbbedahulu\\\",\\\"token\\\":\\\"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwibmFtZSI6IkVnZ2kgRHdpdGFtYSIsImNvbnRhY3QiOiIwODUzMjMwODU2OTIiLCJ1c2VybmFtZSI6ImFkbWluIiwiY29tbXVuaXR5X2lkIjoxLCJjb21tdW5pdHkiOnsiaWQiOjEsInVzZXJuYW1lIjoicGJiZWRhaHVsdSIsIm5hbWUiOiJQQiBCRURBSFVMVSIsImFkZHJlc3MiOiJKbC4gQmVkYWh1bHUgWCBOby4gMTcsIERlbnBhc2FyIFV0YXJhIC0gQmFsaSIsImNvbnRhY3QiOiIwODc4MDk1MzgwODAiLCJwaWMiOiJBZG1pbiBQQiBCZWRhaHVsdSIsImluc3RhZ3JhbSI6IkBwYl9iZWRhaHVsdSIsInRpa3RvayI6IkBwYl9iZWRhaHVsdSIsImVtYWlsIjoicGJiZWRhaHVsdUBnbWFpbC5jb20iLCJ3ZWJzaXRlIjoicGJiZWRhaHVsdS5teS5pZCIsImxvZ28iOiJsb2dvLXBiYmVkYWh1bHUucG5nIiwiY3JlYXRlZEF0IjoiMjAyNC0wNy0yOVQwMTo1MToyMS4wMDBaIiwidXBkYXRlZEF0IjoiMjAyNC0wNy0yOVQwMTo1MToyMS4wMDBaIn0sImlhdCI6MTcyMzM0NDI5Nn0.8MppV8LxkddLsSkUqa82hNSICbcYtYrACVTtX6pMZcg\\\"}}\"', 1, NULL, NULL, NULL, '2024-08-11 10:44:56', '2024-08-11 10:44:56'),
(144, '2024-08-11 10:55:59', 'Login', '\"{\\\"success\\\":true,\\\"statusCode\\\":200,\\\"message\\\":\\\"Login successfully\\\",\\\"query\\\":{\\\"username\\\":\\\"admin@pbbedahulu\\\",\\\"password\\\":\\\"pbbedahulu!\\\"},\\\"data\\\":{\\\"id\\\":1,\\\"name\\\":\\\"Eggi Dwitama\\\",\\\"username\\\":\\\"admin\\\",\\\"contact\\\":\\\"085323085692\\\",\\\"community_id\\\":1,\\\"community_name\\\":\\\"PB BEDAHULU\\\",\\\"community\\\":\\\"pbbedahulu\\\",\\\"token\\\":\\\"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwibmFtZSI6IkVnZ2kgRHdpdGFtYSIsImNvbnRhY3QiOiIwODUzMjMwODU2OTIiLCJ1c2VybmFtZSI6ImFkbWluIiwiY29tbXVuaXR5X2lkIjoxLCJjb21tdW5pdHkiOnsiaWQiOjEsInVzZXJuYW1lIjoicGJiZWRhaHVsdSIsIm5hbWUiOiJQQiBCRURBSFVMVSIsImFkZHJlc3MiOiJKbC4gQmVkYWh1bHUgWCBOby4gMTcsIERlbnBhc2FyIFV0YXJhIC0gQmFsaSIsImNvbnRhY3QiOiIwODc4MDk1MzgwODAiLCJwaWMiOiJBZG1pbiBQQiBCZWRhaHVsdSIsImluc3RhZ3JhbSI6IkBwYl9iZWRhaHVsdSIsInRpa3RvayI6IkBwYl9iZWRhaHVsdSIsImVtYWlsIjoicGJiZWRhaHVsdUBnbWFpbC5jb20iLCJ3ZWJzaXRlIjoicGJiZWRhaHVsdS5teS5pZCIsImxvZ28iOiJsb2dvLXBiYmVkYWh1bHUucG5nIiwiY3JlYXRlZEF0IjoiMjAyNC0wNy0yOVQwMTo1MToyMS4wMDBaIiwidXBkYXRlZEF0IjoiMjAyNC0wNy0yOVQwMTo1MToyMS4wMDBaIn0sImlhdCI6MTcyMzM0NDk1OX0.dOXUMZGEmF0vHNpYlZO1PqBkpKO5F2Z7S2_RTi4mZ3I\\\"}}\"', 1, NULL, NULL, NULL, '2024-08-11 10:55:59', '2024-08-11 10:55:59'),
(145, '2024-08-11 11:16:26', 'Login', '\"{\\\"success\\\":true,\\\"statusCode\\\":200,\\\"message\\\":\\\"Login successfully\\\",\\\"query\\\":{\\\"username\\\":\\\"admin@pbbedahulu\\\",\\\"password\\\":\\\"pbbedahulu!\\\"},\\\"data\\\":{\\\"id\\\":1,\\\"name\\\":\\\"Eggi Dwitama\\\",\\\"username\\\":\\\"admin\\\",\\\"contact\\\":\\\"085323085692\\\",\\\"community_id\\\":1,\\\"community_name\\\":\\\"PB BEDAHULU\\\",\\\"community\\\":\\\"pbbedahulu\\\",\\\"token\\\":\\\"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwibmFtZSI6IkVnZ2kgRHdpdGFtYSIsImNvbnRhY3QiOiIwODUzMjMwODU2OTIiLCJ1c2VybmFtZSI6ImFkbWluIiwiY29tbXVuaXR5X2lkIjoxLCJjb21tdW5pdHkiOnsiaWQiOjEsInVzZXJuYW1lIjoicGJiZWRhaHVsdSIsIm5hbWUiOiJQQiBCRURBSFVMVSIsImFkZHJlc3MiOiJKbC4gQmVkYWh1bHUgWCBOby4gMTcsIERlbnBhc2FyIFV0YXJhIC0gQmFsaSIsImNvbnRhY3QiOiIwODc4MDk1MzgwODAiLCJwaWMiOiJBZG1pbiBQQiBCZWRhaHVsdSIsImluc3RhZ3JhbSI6IkBwYl9iZWRhaHVsdSIsInRpa3RvayI6IkBwYl9iZWRhaHVsdSIsImVtYWlsIjoicGJiZWRhaHVsdUBnbWFpbC5jb20iLCJ3ZWJzaXRlIjoicGJiZWRhaHVsdS5teS5pZCIsImxvZ28iOiJsb2dvLXBiYmVkYWh1bHUucG5nIiwiY3JlYXRlZEF0IjoiMjAyNC0wNy0yOVQwMTo1MToyMS4wMDBaIiwidXBkYXRlZEF0IjoiMjAyNC0wNy0yOVQwMTo1MToyMS4wMDBaIn0sImlhdCI6MTcyMzM0NjE4Nn0.mYXyHsecuPZkWY7Equqv-ajOU-AIIh6sSTmAiihy4XM\\\"}}\"', 1, NULL, NULL, NULL, '2024-08-11 11:16:26', '2024-08-11 11:16:26'),
(146, '2024-08-11 15:07:34', 'Login', '\"{\\\"success\\\":true,\\\"statusCode\\\":200,\\\"message\\\":\\\"Login successfully\\\",\\\"query\\\":{\\\"username\\\":\\\"admin@pbbedahulu\\\",\\\"password\\\":\\\"pbbedahulu!\\\"},\\\"data\\\":{\\\"id\\\":1,\\\"name\\\":\\\"Eggi Dwitama\\\",\\\"username\\\":\\\"admin\\\",\\\"contact\\\":\\\"085323085692\\\",\\\"community_id\\\":1,\\\"community_name\\\":\\\"PB BEDAHULU\\\",\\\"community\\\":\\\"pbbedahulu\\\",\\\"token\\\":\\\"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwibmFtZSI6IkVnZ2kgRHdpdGFtYSIsImNvbnRhY3QiOiIwODUzMjMwODU2OTIiLCJ1c2VybmFtZSI6ImFkbWluIiwiY29tbXVuaXR5X2lkIjoxLCJjb21tdW5pdHkiOnsiaWQiOjEsInVzZXJuYW1lIjoicGJiZWRhaHVsdSIsIm5hbWUiOiJQQiBCRURBSFVMVSIsImFkZHJlc3MiOiJKbC4gQmVkYWh1bHUgWCBOby4gMTcsIERlbnBhc2FyIFV0YXJhIC0gQmFsaSIsImNvbnRhY3QiOiIwODc4MDk1MzgwODAiLCJwaWMiOiJBZG1pbiBQQiBCZWRhaHVsdSIsImluc3RhZ3JhbSI6IkBwYl9iZWRhaHVsdSIsInRpa3RvayI6IkBwYl9iZWRhaHVsdSIsImVtYWlsIjoicGJiZWRhaHVsdUBnbWFpbC5jb20iLCJ3ZWJzaXRlIjoicGJiZWRhaHVsdS5teS5pZCIsImxvZ28iOiJsb2dvLXBiYmVkYWh1bHUucG5nIiwiY3JlYXRlZEF0IjoiMjAyNC0wNy0yOVQwMTo1MToyMS4wMDBaIiwidXBkYXRlZEF0IjoiMjAyNC0wNy0yOVQwMTo1MToyMS4wMDBaIn0sImlhdCI6MTcyMzM2MDA1NH0.dAnv0VhUBqL2wvC2exnhiuEWPFkpdiyoiCLnc_EhWvU\\\"}}\"', 1, NULL, NULL, NULL, '2024-08-11 15:07:34', '2024-08-11 15:07:34'),
(147, '2024-08-11 15:08:06', 'Profile', '\"{\\\"success\\\":true,\\\"statusCode\\\":200,\\\"message\\\":\\\"Profile retrieved successfully\\\",\\\"query\\\":{},\\\"data\\\":{\\\"id\\\":1,\\\"name\\\":\\\"Eggi Dwitama\\\",\\\"contact\\\":\\\"085323085692\\\",\\\"username\\\":\\\"admin\\\",\\\"community_id\\\":1,\\\"community\\\":{\\\"id\\\":1,\\\"username\\\":\\\"pbbedahulu\\\",\\\"name\\\":\\\"PB BEDAHULU\\\",\\\"address\\\":\\\"Jl. Bedahulu X No. 17, Denpasar Utara - Bali\\\",\\\"contact\\\":\\\"087809538080\\\",\\\"pic\\\":\\\"Admin PB Bedahulu\\\",\\\"instagram\\\":\\\"@pb_bedahulu\\\",\\\"tiktok\\\":\\\"@pb_bedahulu\\\",\\\"email\\\":\\\"pbbedahulu@gmail.com\\\",\\\"website\\\":\\\"pbbedahulu.my.id\\\",\\\"logo\\\":\\\"logo-pbbedahulu.png\\\",\\\"createdAt\\\":\\\"2024-07-29T01:51:21.000Z\\\",\\\"updatedAt\\\":\\\"2024-07-29T01:51:21.000Z\\\"},\\\"iat\\\":1723360054}}\"', 1, NULL, NULL, NULL, '2024-08-11 15:08:06', '2024-08-11 15:08:06'),
(148, '2024-08-11 16:17:03', 'Login', '\"{\\\"success\\\":true,\\\"statusCode\\\":200,\\\"message\\\":\\\"Login successfully\\\",\\\"query\\\":{\\\"username\\\":\\\"admin@pbbedahulu\\\",\\\"password\\\":\\\"pbbedahulu!\\\"},\\\"data\\\":{\\\"id\\\":1,\\\"name\\\":\\\"Eggi Dwitama\\\",\\\"username\\\":\\\"admin\\\",\\\"contact\\\":\\\"085323085692\\\",\\\"community_id\\\":1,\\\"community_name\\\":\\\"PB BEDAHULU\\\",\\\"community\\\":\\\"pbbedahulu\\\",\\\"token\\\":\\\"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwibmFtZSI6IkVnZ2kgRHdpdGFtYSIsImNvbnRhY3QiOiIwODUzMjMwODU2OTIiLCJ1c2VybmFtZSI6ImFkbWluIiwiY29tbXVuaXR5X2lkIjoxLCJjb21tdW5pdHkiOnsiaWQiOjEsInVzZXJuYW1lIjoicGJiZWRhaHVsdSIsIm5hbWUiOiJQQiBCRURBSFVMVSIsImFkZHJlc3MiOiJKbC4gQmVkYWh1bHUgWCBOby4gMTcsIERlbnBhc2FyIFV0YXJhIC0gQmFsaSIsImNvbnRhY3QiOiIwODc4MDk1MzgwODAiLCJwaWMiOiJBZG1pbiBQQiBCZWRhaHVsdSIsImluc3RhZ3JhbSI6IkBwYl9iZWRhaHVsdSIsInRpa3RvayI6IkBwYl9iZWRhaHVsdSIsImVtYWlsIjoicGJiZWRhaHVsdUBnbWFpbC5jb20iLCJ3ZWJzaXRlIjoicGJiZWRhaHVsdS5teS5pZCIsImxvZ28iOiJsb2dvLXBiYmVkYWh1bHUucG5nIiwiY3JlYXRlZEF0IjoiMjAyNC0wNy0yOVQwMTo1MToyMS4wMDBaIiwidXBkYXRlZEF0IjoiMjAyNC0wNy0yOVQwMTo1MToyMS4wMDBaIn0sImlhdCI6MTcyMzM2NDIyM30.CpkhXB6MBA4jt65AKHtr4iDE8TQgIb-5KmuZze5Lss8\\\"}}\"', 1, NULL, NULL, NULL, '2024-08-11 16:17:03', '2024-08-11 16:17:03'),
(149, '2024-08-11 16:19:47', 'Profile', '\"{\\\"success\\\":true,\\\"statusCode\\\":200,\\\"message\\\":\\\"Profile retrieved successfully\\\",\\\"query\\\":{},\\\"data\\\":{\\\"id\\\":1,\\\"name\\\":\\\"Eggi Dwitama\\\",\\\"contact\\\":\\\"085323085692\\\",\\\"username\\\":\\\"admin\\\",\\\"community_id\\\":1,\\\"community\\\":{\\\"id\\\":1,\\\"username\\\":\\\"pbbedahulu\\\",\\\"name\\\":\\\"PB BEDAHULU\\\",\\\"address\\\":\\\"Jl. Bedahulu X No. 17, Denpasar Utara - Bali\\\",\\\"contact\\\":\\\"087809538080\\\",\\\"pic\\\":\\\"Admin PB Bedahulu\\\",\\\"instagram\\\":\\\"@pb_bedahulu\\\",\\\"tiktok\\\":\\\"@pb_bedahulu\\\",\\\"email\\\":\\\"pbbedahulu@gmail.com\\\",\\\"website\\\":\\\"pbbedahulu.my.id\\\",\\\"logo\\\":\\\"logo-pbbedahulu.png\\\",\\\"createdAt\\\":\\\"2024-07-29T01:51:21.000Z\\\",\\\"updatedAt\\\":\\\"2024-07-29T01:51:21.000Z\\\"},\\\"iat\\\":1723364223}}\"', 1, NULL, NULL, NULL, '2024-08-11 16:19:47', '2024-08-11 16:19:47'),
(150, '2024-08-11 16:44:40', 'Create Player', '\"{\\\"success\\\":true,\\\"statusCode\\\":200,\\\"message\\\":\\\"Player create successfully\\\",\\\"query\\\":{\\\"name\\\":\\\"Susi Suzanna\\\",\\\"alias\\\":\\\"Susan\\\",\\\"gender\\\":\\\"M\\\",\\\"contact\\\":\\\"08113114213\\\",\\\"level\\\":\\\"A\\\",\\\"age_range\\\":\\\"21-30\\\"},\\\"data\\\":{\\\"id\\\":43,\\\"name\\\":\\\"Susi Suzanna\\\",\\\"alias\\\":\\\"Susan\\\",\\\"username\\\":\\\"susan213\\\",\\\"gender\\\":\\\"M\\\",\\\"contact\\\":\\\"08113114213\\\",\\\"level\\\":\\\"A\\\",\\\"age_range\\\":\\\"21-30\\\",\\\"user_id\\\":1}}\"', 1, NULL, NULL, NULL, '2024-08-11 16:44:40', '2024-08-11 16:44:40'),
(151, '2024-08-12 07:17:49', 'Login', '\"{\\\"success\\\":true,\\\"statusCode\\\":200,\\\"message\\\":\\\"Login successfully\\\",\\\"query\\\":{\\\"username\\\":\\\"admin@pbbedahulu\\\",\\\"password\\\":\\\"pbbedahulu!\\\"},\\\"data\\\":{\\\"id\\\":1,\\\"name\\\":\\\"Eggi Dwitama\\\",\\\"username\\\":\\\"admin\\\",\\\"contact\\\":\\\"085323085692\\\",\\\"community_id\\\":1,\\\"community_name\\\":\\\"PB BEDAHULU\\\",\\\"community\\\":\\\"pbbedahulu\\\",\\\"token\\\":\\\"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwibmFtZSI6IkVnZ2kgRHdpdGFtYSIsImNvbnRhY3QiOiIwODUzMjMwODU2OTIiLCJ1c2VybmFtZSI6ImFkbWluIiwiY29tbXVuaXR5X2lkIjoxLCJjb21tdW5pdHkiOnsiaWQiOjEsInVzZXJuYW1lIjoicGJiZWRhaHVsdSIsIm5hbWUiOiJQQiBCRURBSFVMVSIsImFkZHJlc3MiOiJKbC4gQmVkYWh1bHUgWCBOby4gMTcsIERlbnBhc2FyIFV0YXJhIC0gQmFsaSIsImNvbnRhY3QiOiIwODc4MDk1MzgwODAiLCJwaWMiOiJBZG1pbiBQQiBCZWRhaHVsdSIsImluc3RhZ3JhbSI6IkBwYl9iZWRhaHVsdSIsInRpa3RvayI6IkBwYl9iZWRhaHVsdSIsImVtYWlsIjoicGJiZWRhaHVsdUBnbWFpbC5jb20iLCJ3ZWJzaXRlIjoicGJiZWRhaHVsdS5teS5pZCIsImxvZ28iOiJsb2dvLXBiYmVkYWh1bHUucG5nIiwiY3JlYXRlZEF0IjoiMjAyNC0wNy0yOVQwMTo1MToyMS4wMDBaIiwidXBkYXRlZEF0IjoiMjAyNC0wNy0yOVQwMTo1MToyMS4wMDBaIn0sImlhdCI6MTcyMzQxODI2OX0.BQiQU5lAoJhCeSbmBkQHNJn_3H_cPU9ss-qCj3LSqPc\\\"}}\"', 1, NULL, NULL, NULL, '2024-08-12 07:17:49', '2024-08-12 07:17:49'),
(152, '2024-08-12 11:06:13', 'Login', '\"{\\\"success\\\":true,\\\"statusCode\\\":200,\\\"message\\\":\\\"Login successfully\\\",\\\"query\\\":{\\\"username\\\":\\\"admin@pbbedahulu\\\",\\\"password\\\":\\\"pbbedahulu!\\\"},\\\"data\\\":{\\\"id\\\":1,\\\"name\\\":\\\"Eggi Dwitama\\\",\\\"username\\\":\\\"admin\\\",\\\"contact\\\":\\\"085323085692\\\",\\\"community_id\\\":1,\\\"community_name\\\":\\\"PB BEDAHULU\\\",\\\"community\\\":\\\"pbbedahulu\\\",\\\"token\\\":\\\"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwibmFtZSI6IkVnZ2kgRHdpdGFtYSIsImNvbnRhY3QiOiIwODUzMjMwODU2OTIiLCJ1c2VybmFtZSI6ImFkbWluIiwiY29tbXVuaXR5X2lkIjoxLCJjb21tdW5pdHkiOnsiaWQiOjEsInVzZXJuYW1lIjoicGJiZWRhaHVsdSIsIm5hbWUiOiJQQiBCRURBSFVMVSIsImFkZHJlc3MiOiJKbC4gQmVkYWh1bHUgWCBOby4gMTcsIERlbnBhc2FyIFV0YXJhIC0gQmFsaSIsImNvbnRhY3QiOiIwODc4MDk1MzgwODAiLCJwaWMiOiJBZG1pbiBQQiBCZWRhaHVsdSIsImluc3RhZ3JhbSI6IkBwYl9iZWRhaHVsdSIsInRpa3RvayI6IkBwYl9iZWRhaHVsdSIsImVtYWlsIjoicGJiZWRhaHVsdUBnbWFpbC5jb20iLCJ3ZWJzaXRlIjoicGJiZWRhaHVsdS5teS5pZCIsImxvZ28iOiJsb2dvLXBiYmVkYWh1bHUucG5nIiwiY3JlYXRlZEF0IjoiMjAyNC0wNy0yOVQwMTo1MToyMS4wMDBaIiwidXBkYXRlZEF0IjoiMjAyNC0wNy0yOVQwMTo1MToyMS4wMDBaIn0sImlhdCI6MTcyMzQzMTk3M30.LkRFsa4cmDUUPIYcDUcpHUkpKS5D3ij7rG7Qt1fBcXc\\\"}}\"', 1, NULL, NULL, NULL, '2024-08-12 11:06:13', '2024-08-12 11:06:13'),
(153, '2024-08-12 11:08:59', 'Login', '\"{\\\"success\\\":true,\\\"statusCode\\\":200,\\\"message\\\":\\\"Login successfully\\\",\\\"query\\\":{\\\"username\\\":\\\"admin@pbbedahulu\\\",\\\"password\\\":\\\"pbbedahulu!\\\"},\\\"data\\\":{\\\"id\\\":1,\\\"name\\\":\\\"Eggi Dwitama\\\",\\\"username\\\":\\\"admin\\\",\\\"contact\\\":\\\"085323085692\\\",\\\"community_id\\\":1,\\\"community_name\\\":\\\"PB BEDAHULU\\\",\\\"community\\\":\\\"pbbedahulu\\\",\\\"token\\\":\\\"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwibmFtZSI6IkVnZ2kgRHdpdGFtYSIsImNvbnRhY3QiOiIwODUzMjMwODU2OTIiLCJ1c2VybmFtZSI6ImFkbWluIiwiY29tbXVuaXR5X2lkIjoxLCJjb21tdW5pdHkiOnsiaWQiOjEsInVzZXJuYW1lIjoicGJiZWRhaHVsdSIsIm5hbWUiOiJQQiBCRURBSFVMVSIsImFkZHJlc3MiOiJKbC4gQmVkYWh1bHUgWCBOby4gMTcsIERlbnBhc2FyIFV0YXJhIC0gQmFsaSIsImNvbnRhY3QiOiIwODc4MDk1MzgwODAiLCJwaWMiOiJBZG1pbiBQQiBCZWRhaHVsdSIsImluc3RhZ3JhbSI6IkBwYl9iZWRhaHVsdSIsInRpa3RvayI6IkBwYl9iZWRhaHVsdSIsImVtYWlsIjoicGJiZWRhaHVsdUBnbWFpbC5jb20iLCJ3ZWJzaXRlIjoicGJiZWRhaHVsdS5teS5pZCIsImxvZ28iOiJsb2dvLXBiYmVkYWh1bHUucG5nIiwiY3JlYXRlZEF0IjoiMjAyNC0wNy0yOVQwMTo1MToyMS4wMDBaIiwidXBkYXRlZEF0IjoiMjAyNC0wNy0yOVQwMTo1MToyMS4wMDBaIn0sImlhdCI6MTcyMzQzMjEzOX0.A5iXkViwNVDO4R456kWroBN3KK-RWdVo2X0_dxac784\\\"}}\"', 1, NULL, NULL, NULL, '2024-08-12 11:08:59', '2024-08-12 11:08:59'),
(154, '2024-08-12 12:04:18', 'Login', '\"{\\\"success\\\":true,\\\"statusCode\\\":200,\\\"message\\\":\\\"Login successfully\\\",\\\"query\\\":{\\\"username\\\":\\\"admin@pbbedahulu\\\",\\\"password\\\":\\\"pbbedahulu!\\\"},\\\"data\\\":{\\\"id\\\":1,\\\"name\\\":\\\"Eggi Dwitama\\\",\\\"username\\\":\\\"admin\\\",\\\"contact\\\":\\\"085323085692\\\",\\\"community_id\\\":1,\\\"community_name\\\":\\\"PB BEDAHULU\\\",\\\"community\\\":\\\"pbbedahulu\\\",\\\"token\\\":\\\"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwibmFtZSI6IkVnZ2kgRHdpdGFtYSIsImNvbnRhY3QiOiIwODUzMjMwODU2OTIiLCJ1c2VybmFtZSI6ImFkbWluIiwiY29tbXVuaXR5X2lkIjoxLCJjb21tdW5pdHkiOnsiaWQiOjEsInVzZXJuYW1lIjoicGJiZWRhaHVsdSIsIm5hbWUiOiJQQiBCRURBSFVMVSIsImFkZHJlc3MiOiJKbC4gQmVkYWh1bHUgWCBOby4gMTcsIERlbnBhc2FyIFV0YXJhIC0gQmFsaSIsImNvbnRhY3QiOiIwODc4MDk1MzgwODAiLCJwaWMiOiJBZG1pbiBQQiBCZWRhaHVsdSIsImluc3RhZ3JhbSI6IkBwYl9iZWRhaHVsdSIsInRpa3RvayI6IkBwYl9iZWRhaHVsdSIsImVtYWlsIjoicGJiZWRhaHVsdUBnbWFpbC5jb20iLCJ3ZWJzaXRlIjoicGJiZWRhaHVsdS5teS5pZCIsImxvZ28iOiJsb2dvLXBiYmVkYWh1bHUucG5nIiwiY3JlYXRlZEF0IjoiMjAyNC0wNy0yOVQwMTo1MToyMS4wMDBaIiwidXBkYXRlZEF0IjoiMjAyNC0wNy0yOVQwMTo1MToyMS4wMDBaIn0sImlhdCI6MTcyMzQzNTQ1OH0.GA5zQ43K_ldi7FFojJ6DXm43cspTf29QHdC1B8P4HUk\\\"}}\"', 1, NULL, NULL, NULL, '2024-08-12 12:04:18', '2024-08-12 12:04:18'),
(155, '2024-08-12 12:04:29', 'Login', '\"{\\\"success\\\":true,\\\"statusCode\\\":200,\\\"message\\\":\\\"Login successfully\\\",\\\"query\\\":{\\\"username\\\":\\\"admin@pbbedahulu\\\",\\\"password\\\":\\\"pbbedahulu!\\\"},\\\"data\\\":{\\\"id\\\":1,\\\"name\\\":\\\"Eggi Dwitama\\\",\\\"username\\\":\\\"admin\\\",\\\"contact\\\":\\\"085323085692\\\",\\\"community_id\\\":1,\\\"community_name\\\":\\\"PB BEDAHULU\\\",\\\"community\\\":\\\"pbbedahulu\\\",\\\"token\\\":\\\"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwibmFtZSI6IkVnZ2kgRHdpdGFtYSIsImNvbnRhY3QiOiIwODUzMjMwODU2OTIiLCJ1c2VybmFtZSI6ImFkbWluIiwiY29tbXVuaXR5X2lkIjoxLCJjb21tdW5pdHkiOnsiaWQiOjEsInVzZXJuYW1lIjoicGJiZWRhaHVsdSIsIm5hbWUiOiJQQiBCRURBSFVMVSIsImFkZHJlc3MiOiJKbC4gQmVkYWh1bHUgWCBOby4gMTcsIERlbnBhc2FyIFV0YXJhIC0gQmFsaSIsImNvbnRhY3QiOiIwODc4MDk1MzgwODAiLCJwaWMiOiJBZG1pbiBQQiBCZWRhaHVsdSIsImluc3RhZ3JhbSI6IkBwYl9iZWRhaHVsdSIsInRpa3RvayI6IkBwYl9iZWRhaHVsdSIsImVtYWlsIjoicGJiZWRhaHVsdUBnbWFpbC5jb20iLCJ3ZWJzaXRlIjoicGJiZWRhaHVsdS5teS5pZCIsImxvZ28iOiJsb2dvLXBiYmVkYWh1bHUucG5nIiwiY3JlYXRlZEF0IjoiMjAyNC0wNy0yOVQwMTo1MToyMS4wMDBaIiwidXBkYXRlZEF0IjoiMjAyNC0wNy0yOVQwMTo1MToyMS4wMDBaIn0sImlhdCI6MTcyMzQzNTQ2OX0.HzaLUDjPiNOnGbWQvTVd8TT50F3yl9Fs31WN1I6ygIQ\\\"}}\"', 1, NULL, NULL, NULL, '2024-08-12 12:04:29', '2024-08-12 12:04:29'),
(156, '2024-08-12 12:04:55', 'Login', '\"{\\\"success\\\":true,\\\"statusCode\\\":200,\\\"message\\\":\\\"Login successfully\\\",\\\"query\\\":{\\\"username\\\":\\\"admin@pbbedahulu\\\",\\\"password\\\":\\\"pbbedahulu!\\\"},\\\"data\\\":{\\\"id\\\":1,\\\"name\\\":\\\"Eggi Dwitama\\\",\\\"username\\\":\\\"admin\\\",\\\"contact\\\":\\\"085323085692\\\",\\\"community_id\\\":1,\\\"community_name\\\":\\\"PB BEDAHULU\\\",\\\"community\\\":\\\"pbbedahulu\\\",\\\"token\\\":\\\"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwibmFtZSI6IkVnZ2kgRHdpdGFtYSIsImNvbnRhY3QiOiIwODUzMjMwODU2OTIiLCJ1c2VybmFtZSI6ImFkbWluIiwiY29tbXVuaXR5X2lkIjoxLCJjb21tdW5pdHkiOnsiaWQiOjEsInVzZXJuYW1lIjoicGJiZWRhaHVsdSIsIm5hbWUiOiJQQiBCRURBSFVMVSIsImFkZHJlc3MiOiJKbC4gQmVkYWh1bHUgWCBOby4gMTcsIERlbnBhc2FyIFV0YXJhIC0gQmFsaSIsImNvbnRhY3QiOiIwODc4MDk1MzgwODAiLCJwaWMiOiJBZG1pbiBQQiBCZWRhaHVsdSIsImluc3RhZ3JhbSI6IkBwYl9iZWRhaHVsdSIsInRpa3RvayI6IkBwYl9iZWRhaHVsdSIsImVtYWlsIjoicGJiZWRhaHVsdUBnbWFpbC5jb20iLCJ3ZWJzaXRlIjoicGJiZWRhaHVsdS5teS5pZCIsImxvZ28iOiJsb2dvLXBiYmVkYWh1bHUucG5nIiwiY3JlYXRlZEF0IjoiMjAyNC0wNy0yOVQwMTo1MToyMS4wMDBaIiwidXBkYXRlZEF0IjoiMjAyNC0wNy0yOVQwMTo1MToyMS4wMDBaIn0sImlhdCI6MTcyMzQzNTQ5NX0.-3gm7GllCmXpO9ItRcSGbMuo4fneKfcKXSuOY9rbdFo\\\"}}\"', 1, NULL, NULL, NULL, '2024-08-12 12:04:55', '2024-08-12 12:04:55'),
(157, '2024-08-12 12:07:08', 'Login', '\"{\\\"success\\\":true,\\\"statusCode\\\":200,\\\"message\\\":\\\"Login successfully\\\",\\\"query\\\":{\\\"username\\\":\\\"admin@pbbedahulu\\\",\\\"password\\\":\\\"pbbedahulu!\\\"},\\\"data\\\":{\\\"id\\\":1,\\\"name\\\":\\\"Eggi Dwitama\\\",\\\"username\\\":\\\"admin\\\",\\\"contact\\\":\\\"085323085692\\\",\\\"community_id\\\":1,\\\"community_name\\\":\\\"PB BEDAHULU\\\",\\\"community\\\":\\\"pbbedahulu\\\",\\\"token\\\":\\\"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwibmFtZSI6IkVnZ2kgRHdpdGFtYSIsImNvbnRhY3QiOiIwODUzMjMwODU2OTIiLCJ1c2VybmFtZSI6ImFkbWluIiwiY29tbXVuaXR5X2lkIjoxLCJjb21tdW5pdHkiOnsiaWQiOjEsInVzZXJuYW1lIjoicGJiZWRhaHVsdSIsIm5hbWUiOiJQQiBCRURBSFVMVSIsImFkZHJlc3MiOiJKbC4gQmVkYWh1bHUgWCBOby4gMTcsIERlbnBhc2FyIFV0YXJhIC0gQmFsaSIsImNvbnRhY3QiOiIwODc4MDk1MzgwODAiLCJwaWMiOiJBZG1pbiBQQiBCZWRhaHVsdSIsImluc3RhZ3JhbSI6IkBwYl9iZWRhaHVsdSIsInRpa3RvayI6IkBwYl9iZWRhaHVsdSIsImVtYWlsIjoicGJiZWRhaHVsdUBnbWFpbC5jb20iLCJ3ZWJzaXRlIjoicGJiZWRhaHVsdS5teS5pZCIsImxvZ28iOiJsb2dvLXBiYmVkYWh1bHUucG5nIiwiY3JlYXRlZEF0IjoiMjAyNC0wNy0yOVQwMTo1MToyMS4wMDBaIiwidXBkYXRlZEF0IjoiMjAyNC0wNy0yOVQwMTo1MToyMS4wMDBaIn0sImlhdCI6MTcyMzQzNTYyOH0.eiIVpRHqLvJuV2364kqKZgFXDTy43fKQ-mJGfBMxeoI\\\"}}\"', 1, NULL, NULL, NULL, '2024-08-12 12:07:08', '2024-08-12 12:07:08'),
(158, '2024-08-12 12:07:34', 'Login', '\"{\\\"success\\\":true,\\\"statusCode\\\":200,\\\"message\\\":\\\"Login successfully\\\",\\\"query\\\":{\\\"username\\\":\\\"admin@pbbedahulu\\\",\\\"password\\\":\\\"pbbedahulu!\\\"},\\\"data\\\":{\\\"id\\\":1,\\\"name\\\":\\\"Eggi Dwitama\\\",\\\"username\\\":\\\"admin\\\",\\\"contact\\\":\\\"085323085692\\\",\\\"community_id\\\":1,\\\"community_name\\\":\\\"PB BEDAHULU\\\",\\\"community\\\":\\\"pbbedahulu\\\",\\\"token\\\":\\\"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwibmFtZSI6IkVnZ2kgRHdpdGFtYSIsImNvbnRhY3QiOiIwODUzMjMwODU2OTIiLCJ1c2VybmFtZSI6ImFkbWluIiwiY29tbXVuaXR5X2lkIjoxLCJjb21tdW5pdHkiOnsiaWQiOjEsInVzZXJuYW1lIjoicGJiZWRhaHVsdSIsIm5hbWUiOiJQQiBCRURBSFVMVSIsImFkZHJlc3MiOiJKbC4gQmVkYWh1bHUgWCBOby4gMTcsIERlbnBhc2FyIFV0YXJhIC0gQmFsaSIsImNvbnRhY3QiOiIwODc4MDk1MzgwODAiLCJwaWMiOiJBZG1pbiBQQiBCZWRhaHVsdSIsImluc3RhZ3JhbSI6IkBwYl9iZWRhaHVsdSIsInRpa3RvayI6IkBwYl9iZWRhaHVsdSIsImVtYWlsIjoicGJiZWRhaHVsdUBnbWFpbC5jb20iLCJ3ZWJzaXRlIjoicGJiZWRhaHVsdS5teS5pZCIsImxvZ28iOiJsb2dvLXBiYmVkYWh1bHUucG5nIiwiY3JlYXRlZEF0IjoiMjAyNC0wNy0yOVQwMTo1MToyMS4wMDBaIiwidXBkYXRlZEF0IjoiMjAyNC0wNy0yOVQwMTo1MToyMS4wMDBaIn0sImlhdCI6MTcyMzQzNTY1NH0.iD7PEwsUgEvi2ngPdJaFVvOh4LHR0nHFLeB0keGoFvo\\\"}}\"', 1, NULL, NULL, NULL, '2024-08-12 12:07:34', '2024-08-12 12:07:34'),
(159, '2024-08-12 12:09:08', 'Login', '\"{\\\"success\\\":true,\\\"statusCode\\\":200,\\\"message\\\":\\\"Login successfully\\\",\\\"query\\\":{\\\"username\\\":\\\"admin@pbbedahulu\\\",\\\"password\\\":\\\"pbbedahulu!\\\"},\\\"data\\\":{\\\"id\\\":1,\\\"name\\\":\\\"Eggi Dwitama\\\",\\\"username\\\":\\\"admin\\\",\\\"contact\\\":\\\"085323085692\\\",\\\"community_id\\\":1,\\\"community_name\\\":\\\"PB BEDAHULU\\\",\\\"community\\\":\\\"pbbedahulu\\\",\\\"token\\\":\\\"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwibmFtZSI6IkVnZ2kgRHdpdGFtYSIsImNvbnRhY3QiOiIwODUzMjMwODU2OTIiLCJ1c2VybmFtZSI6ImFkbWluIiwiY29tbXVuaXR5X2lkIjoxLCJjb21tdW5pdHkiOnsiaWQiOjEsInVzZXJuYW1lIjoicGJiZWRhaHVsdSIsIm5hbWUiOiJQQiBCRURBSFVMVSIsImFkZHJlc3MiOiJKbC4gQmVkYWh1bHUgWCBOby4gMTcsIERlbnBhc2FyIFV0YXJhIC0gQmFsaSIsImNvbnRhY3QiOiIwODc4MDk1MzgwODAiLCJwaWMiOiJBZG1pbiBQQiBCZWRhaHVsdSIsImluc3RhZ3JhbSI6IkBwYl9iZWRhaHVsdSIsInRpa3RvayI6IkBwYl9iZWRhaHVsdSIsImVtYWlsIjoicGJiZWRhaHVsdUBnbWFpbC5jb20iLCJ3ZWJzaXRlIjoicGJiZWRhaHVsdS5teS5pZCIsImxvZ28iOiJsb2dvLXBiYmVkYWh1bHUucG5nIiwiY3JlYXRlZEF0IjoiMjAyNC0wNy0yOVQwMTo1MToyMS4wMDBaIiwidXBkYXRlZEF0IjoiMjAyNC0wNy0yOVQwMTo1MToyMS4wMDBaIn0sImlhdCI6MTcyMzQzNTc0OH0.K67FR-oSqPRsQTZpT14Cd-6RxweG_wpxsKDWXC6TjVE\\\"}}\"', 1, NULL, NULL, NULL, '2024-08-12 12:09:08', '2024-08-12 12:09:08'),
(160, '2024-08-12 12:10:29', 'Login', '\"{\\\"success\\\":true,\\\"statusCode\\\":200,\\\"message\\\":\\\"Login successfully\\\",\\\"query\\\":{\\\"username\\\":\\\"admin@pbbedahulu\\\",\\\"password\\\":\\\"pbbedahulu!\\\"},\\\"data\\\":{\\\"id\\\":1,\\\"name\\\":\\\"Eggi Dwitama\\\",\\\"username\\\":\\\"admin\\\",\\\"contact\\\":\\\"085323085692\\\",\\\"community_id\\\":1,\\\"community_name\\\":\\\"PB BEDAHULU\\\",\\\"community\\\":\\\"pbbedahulu\\\",\\\"token\\\":\\\"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwibmFtZSI6IkVnZ2kgRHdpdGFtYSIsImNvbnRhY3QiOiIwODUzMjMwODU2OTIiLCJ1c2VybmFtZSI6ImFkbWluIiwiY29tbXVuaXR5X2lkIjoxLCJjb21tdW5pdHkiOnsiaWQiOjEsInVzZXJuYW1lIjoicGJiZWRhaHVsdSIsIm5hbWUiOiJQQiBCRURBSFVMVSIsImFkZHJlc3MiOiJKbC4gQmVkYWh1bHUgWCBOby4gMTcsIERlbnBhc2FyIFV0YXJhIC0gQmFsaSIsImNvbnRhY3QiOiIwODc4MDk1MzgwODAiLCJwaWMiOiJBZG1pbiBQQiBCZWRhaHVsdSIsImluc3RhZ3JhbSI6IkBwYl9iZWRhaHVsdSIsInRpa3RvayI6IkBwYl9iZWRhaHVsdSIsImVtYWlsIjoicGJiZWRhaHVsdUBnbWFpbC5jb20iLCJ3ZWJzaXRlIjoicGJiZWRhaHVsdS5teS5pZCIsImxvZ28iOiJsb2dvLXBiYmVkYWh1bHUucG5nIiwiY3JlYXRlZEF0IjoiMjAyNC0wNy0yOVQwMTo1MToyMS4wMDBaIiwidXBkYXRlZEF0IjoiMjAyNC0wNy0yOVQwMTo1MToyMS4wMDBaIn0sImlhdCI6MTcyMzQzNTgyOX0.d8SLu4Ra3O5pNq-dpO184fO5_BF2DtnBA6rklSDIGXQ\\\"}}\"', 1, NULL, NULL, NULL, '2024-08-12 12:10:29', '2024-08-12 12:10:29'),
(161, '2024-08-12 12:12:22', 'Login', '\"{\\\"success\\\":true,\\\"statusCode\\\":200,\\\"message\\\":\\\"Login successfully\\\",\\\"query\\\":{\\\"username\\\":\\\"admin@pbbedahulu\\\",\\\"password\\\":\\\"pbbedahulu!\\\"},\\\"data\\\":{\\\"id\\\":1,\\\"name\\\":\\\"Eggi Dwitama\\\",\\\"username\\\":\\\"admin\\\",\\\"contact\\\":\\\"085323085692\\\",\\\"community_id\\\":1,\\\"community_name\\\":\\\"PB BEDAHULU\\\",\\\"community\\\":\\\"pbbedahulu\\\",\\\"token\\\":\\\"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwibmFtZSI6IkVnZ2kgRHdpdGFtYSIsImNvbnRhY3QiOiIwODUzMjMwODU2OTIiLCJ1c2VybmFtZSI6ImFkbWluIiwiY29tbXVuaXR5X2lkIjoxLCJjb21tdW5pdHkiOnsiaWQiOjEsInVzZXJuYW1lIjoicGJiZWRhaHVsdSIsIm5hbWUiOiJQQiBCRURBSFVMVSIsImFkZHJlc3MiOiJKbC4gQmVkYWh1bHUgWCBOby4gMTcsIERlbnBhc2FyIFV0YXJhIC0gQmFsaSIsImNvbnRhY3QiOiIwODc4MDk1MzgwODAiLCJwaWMiOiJBZG1pbiBQQiBCZWRhaHVsdSIsImluc3RhZ3JhbSI6IkBwYl9iZWRhaHVsdSIsInRpa3RvayI6IkBwYl9iZWRhaHVsdSIsImVtYWlsIjoicGJiZWRhaHVsdUBnbWFpbC5jb20iLCJ3ZWJzaXRlIjoicGJiZWRhaHVsdS5teS5pZCIsImxvZ28iOiJsb2dvLXBiYmVkYWh1bHUucG5nIiwiY3JlYXRlZEF0IjoiMjAyNC0wNy0yOVQwMTo1MToyMS4wMDBaIiwidXBkYXRlZEF0IjoiMjAyNC0wNy0yOVQwMTo1MToyMS4wMDBaIn0sImlhdCI6MTcyMzQzNTk0Mn0.NNEJpEzZD6Sxy82wYz-8H8e7WhfnuqTN0UMHetYvnfQ\\\"}}\"', 1, NULL, NULL, NULL, '2024-08-12 12:12:22', '2024-08-12 12:12:22'),
(162, '2024-08-12 12:12:52', 'Login', '\"{\\\"success\\\":true,\\\"statusCode\\\":200,\\\"message\\\":\\\"Login successfully\\\",\\\"query\\\":{\\\"username\\\":\\\"admin@pbbedahulu\\\",\\\"password\\\":\\\"pbbedahulu!\\\"},\\\"data\\\":{\\\"id\\\":1,\\\"name\\\":\\\"Eggi Dwitama\\\",\\\"username\\\":\\\"admin\\\",\\\"contact\\\":\\\"085323085692\\\",\\\"community_id\\\":1,\\\"community_name\\\":\\\"PB BEDAHULU\\\",\\\"community\\\":\\\"pbbedahulu\\\",\\\"token\\\":\\\"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwibmFtZSI6IkVnZ2kgRHdpdGFtYSIsImNvbnRhY3QiOiIwODUzMjMwODU2OTIiLCJ1c2VybmFtZSI6ImFkbWluIiwiY29tbXVuaXR5X2lkIjoxLCJjb21tdW5pdHkiOnsiaWQiOjEsInVzZXJuYW1lIjoicGJiZWRhaHVsdSIsIm5hbWUiOiJQQiBCRURBSFVMVSIsImFkZHJlc3MiOiJKbC4gQmVkYWh1bHUgWCBOby4gMTcsIERlbnBhc2FyIFV0YXJhIC0gQmFsaSIsImNvbnRhY3QiOiIwODc4MDk1MzgwODAiLCJwaWMiOiJBZG1pbiBQQiBCZWRhaHVsdSIsImluc3RhZ3JhbSI6IkBwYl9iZWRhaHVsdSIsInRpa3RvayI6IkBwYl9iZWRhaHVsdSIsImVtYWlsIjoicGJiZWRhaHVsdUBnbWFpbC5jb20iLCJ3ZWJzaXRlIjoicGJiZWRhaHVsdS5teS5pZCIsImxvZ28iOiJsb2dvLXBiYmVkYWh1bHUucG5nIiwiY3JlYXRlZEF0IjoiMjAyNC0wNy0yOVQwMTo1MToyMS4wMDBaIiwidXBkYXRlZEF0IjoiMjAyNC0wNy0yOVQwMTo1MToyMS4wMDBaIn0sImlhdCI6MTcyMzQzNTk3Mn0.p088eujW3HLwqftQKsS-zvevcJ-JCPPTYctiHpNB7io\\\"}}\"', 1, NULL, NULL, NULL, '2024-08-12 12:12:52', '2024-08-12 12:12:52'),
(163, '2024-08-12 12:13:15', 'Login', '\"{\\\"success\\\":true,\\\"statusCode\\\":200,\\\"message\\\":\\\"Login successfully\\\",\\\"query\\\":{\\\"username\\\":\\\"admin@pbbedahulu\\\",\\\"password\\\":\\\"pbbedahulu!\\\"},\\\"data\\\":{\\\"id\\\":1,\\\"name\\\":\\\"Eggi Dwitama\\\",\\\"username\\\":\\\"admin\\\",\\\"contact\\\":\\\"085323085692\\\",\\\"community_id\\\":1,\\\"community_name\\\":\\\"PB BEDAHULU\\\",\\\"community\\\":\\\"pbbedahulu\\\",\\\"token\\\":\\\"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwibmFtZSI6IkVnZ2kgRHdpdGFtYSIsImNvbnRhY3QiOiIwODUzMjMwODU2OTIiLCJ1c2VybmFtZSI6ImFkbWluIiwiY29tbXVuaXR5X2lkIjoxLCJjb21tdW5pdHkiOnsiaWQiOjEsInVzZXJuYW1lIjoicGJiZWRhaHVsdSIsIm5hbWUiOiJQQiBCRURBSFVMVSIsImFkZHJlc3MiOiJKbC4gQmVkYWh1bHUgWCBOby4gMTcsIERlbnBhc2FyIFV0YXJhIC0gQmFsaSIsImNvbnRhY3QiOiIwODc4MDk1MzgwODAiLCJwaWMiOiJBZG1pbiBQQiBCZWRhaHVsdSIsImluc3RhZ3JhbSI6IkBwYl9iZWRhaHVsdSIsInRpa3RvayI6IkBwYl9iZWRhaHVsdSIsImVtYWlsIjoicGJiZWRhaHVsdUBnbWFpbC5jb20iLCJ3ZWJzaXRlIjoicGJiZWRhaHVsdS5teS5pZCIsImxvZ28iOiJsb2dvLXBiYmVkYWh1bHUucG5nIiwiY3JlYXRlZEF0IjoiMjAyNC0wNy0yOVQwMTo1MToyMS4wMDBaIiwidXBkYXRlZEF0IjoiMjAyNC0wNy0yOVQwMTo1MToyMS4wMDBaIn0sImlhdCI6MTcyMzQzNTk5NX0.h-ts4pWkLsoJDrYOguTBFsZrhH9wk2BCtCcVEVLWIro\\\"}}\"', 1, NULL, NULL, NULL, '2024-08-12 12:13:15', '2024-08-12 12:13:15'),
(164, '2024-08-12 12:13:50', 'Login', '\"{\\\"success\\\":true,\\\"statusCode\\\":200,\\\"message\\\":\\\"Login successfully\\\",\\\"query\\\":{\\\"username\\\":\\\"admin@pbbedahulu\\\",\\\"password\\\":\\\"pbbedahulu!\\\"},\\\"data\\\":{\\\"id\\\":1,\\\"name\\\":\\\"Eggi Dwitama\\\",\\\"username\\\":\\\"admin\\\",\\\"contact\\\":\\\"085323085692\\\",\\\"community_id\\\":1,\\\"community_name\\\":\\\"PB BEDAHULU\\\",\\\"community\\\":\\\"pbbedahulu\\\",\\\"token\\\":\\\"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwibmFtZSI6IkVnZ2kgRHdpdGFtYSIsImNvbnRhY3QiOiIwODUzMjMwODU2OTIiLCJ1c2VybmFtZSI6ImFkbWluIiwiY29tbXVuaXR5X2lkIjoxLCJjb21tdW5pdHkiOnsiaWQiOjEsInVzZXJuYW1lIjoicGJiZWRhaHVsdSIsIm5hbWUiOiJQQiBCRURBSFVMVSIsImFkZHJlc3MiOiJKbC4gQmVkYWh1bHUgWCBOby4gMTcsIERlbnBhc2FyIFV0YXJhIC0gQmFsaSIsImNvbnRhY3QiOiIwODc4MDk1MzgwODAiLCJwaWMiOiJBZG1pbiBQQiBCZWRhaHVsdSIsImluc3RhZ3JhbSI6IkBwYl9iZWRhaHVsdSIsInRpa3RvayI6IkBwYl9iZWRhaHVsdSIsImVtYWlsIjoicGJiZWRhaHVsdUBnbWFpbC5jb20iLCJ3ZWJzaXRlIjoicGJiZWRhaHVsdS5teS5pZCIsImxvZ28iOiJsb2dvLXBiYmVkYWh1bHUucG5nIiwiY3JlYXRlZEF0IjoiMjAyNC0wNy0yOVQwMTo1MToyMS4wMDBaIiwidXBkYXRlZEF0IjoiMjAyNC0wNy0yOVQwMTo1MToyMS4wMDBaIn0sImlhdCI6MTcyMzQzNjAzMH0.pPdEUl567Q0JNVbapSU2jhn9s_lA5TWme5eof4tssl4\\\"}}\"', 1, NULL, NULL, NULL, '2024-08-12 12:13:50', '2024-08-12 12:13:50'),
(165, '2024-08-12 12:14:12', 'Login', '\"{\\\"success\\\":true,\\\"statusCode\\\":200,\\\"message\\\":\\\"Login successfully\\\",\\\"query\\\":{\\\"username\\\":\\\"admin@pbbedahulu\\\",\\\"password\\\":\\\"pbbedahulu!\\\"},\\\"data\\\":{\\\"id\\\":1,\\\"name\\\":\\\"Eggi Dwitama\\\",\\\"username\\\":\\\"admin\\\",\\\"contact\\\":\\\"085323085692\\\",\\\"community_id\\\":1,\\\"community_name\\\":\\\"PB BEDAHULU\\\",\\\"community\\\":\\\"pbbedahulu\\\",\\\"token\\\":\\\"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwibmFtZSI6IkVnZ2kgRHdpdGFtYSIsImNvbnRhY3QiOiIwODUzMjMwODU2OTIiLCJ1c2VybmFtZSI6ImFkbWluIiwiY29tbXVuaXR5X2lkIjoxLCJjb21tdW5pdHkiOnsiaWQiOjEsInVzZXJuYW1lIjoicGJiZWRhaHVsdSIsIm5hbWUiOiJQQiBCRURBSFVMVSIsImFkZHJlc3MiOiJKbC4gQmVkYWh1bHUgWCBOby4gMTcsIERlbnBhc2FyIFV0YXJhIC0gQmFsaSIsImNvbnRhY3QiOiIwODc4MDk1MzgwODAiLCJwaWMiOiJBZG1pbiBQQiBCZWRhaHVsdSIsImluc3RhZ3JhbSI6IkBwYl9iZWRhaHVsdSIsInRpa3RvayI6IkBwYl9iZWRhaHVsdSIsImVtYWlsIjoicGJiZWRhaHVsdUBnbWFpbC5jb20iLCJ3ZWJzaXRlIjoicGJiZWRhaHVsdS5teS5pZCIsImxvZ28iOiJsb2dvLXBiYmVkYWh1bHUucG5nIiwiY3JlYXRlZEF0IjoiMjAyNC0wNy0yOVQwMTo1MToyMS4wMDBaIiwidXBkYXRlZEF0IjoiMjAyNC0wNy0yOVQwMTo1MToyMS4wMDBaIn0sImlhdCI6MTcyMzQzNjA1Mn0.ryNf05aXDXaRf6d_o2NWsRHIN2C4Zni4maoU0TO09LM\\\"}}\"', 1, NULL, NULL, NULL, '2024-08-12 12:14:12', '2024-08-12 12:14:12'),
(166, '2024-08-12 12:14:35', 'Login', '\"{\\\"success\\\":true,\\\"statusCode\\\":200,\\\"message\\\":\\\"Login successfully\\\",\\\"query\\\":{\\\"username\\\":\\\"admin@pbbedahulu\\\",\\\"password\\\":\\\"pbbedahulu!\\\"},\\\"data\\\":{\\\"id\\\":1,\\\"name\\\":\\\"Eggi Dwitama\\\",\\\"username\\\":\\\"admin\\\",\\\"contact\\\":\\\"085323085692\\\",\\\"community_id\\\":1,\\\"community_name\\\":\\\"PB BEDAHULU\\\",\\\"community\\\":\\\"pbbedahulu\\\",\\\"token\\\":\\\"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwibmFtZSI6IkVnZ2kgRHdpdGFtYSIsImNvbnRhY3QiOiIwODUzMjMwODU2OTIiLCJ1c2VybmFtZSI6ImFkbWluIiwiY29tbXVuaXR5X2lkIjoxLCJjb21tdW5pdHkiOnsiaWQiOjEsInVzZXJuYW1lIjoicGJiZWRhaHVsdSIsIm5hbWUiOiJQQiBCRURBSFVMVSIsImFkZHJlc3MiOiJKbC4gQmVkYWh1bHUgWCBOby4gMTcsIERlbnBhc2FyIFV0YXJhIC0gQmFsaSIsImNvbnRhY3QiOiIwODc4MDk1MzgwODAiLCJwaWMiOiJBZG1pbiBQQiBCZWRhaHVsdSIsImluc3RhZ3JhbSI6IkBwYl9iZWRhaHVsdSIsInRpa3RvayI6IkBwYl9iZWRhaHVsdSIsImVtYWlsIjoicGJiZWRhaHVsdUBnbWFpbC5jb20iLCJ3ZWJzaXRlIjoicGJiZWRhaHVsdS5teS5pZCIsImxvZ28iOiJsb2dvLXBiYmVkYWh1bHUucG5nIiwiY3JlYXRlZEF0IjoiMjAyNC0wNy0yOVQwMTo1MToyMS4wMDBaIiwidXBkYXRlZEF0IjoiMjAyNC0wNy0yOVQwMTo1MToyMS4wMDBaIn0sImlhdCI6MTcyMzQzNjA3NX0.pHMvP9KAgQTzR6QXqbAxsGo2TW_g0jaRSTjiL7nb46g\\\"}}\"', 1, NULL, NULL, NULL, '2024-08-12 12:14:35', '2024-08-12 12:14:35'),
(167, '2024-08-12 12:14:58', 'Login', '\"{\\\"success\\\":true,\\\"statusCode\\\":200,\\\"message\\\":\\\"Login successfully\\\",\\\"query\\\":{\\\"username\\\":\\\"admin@pbbedahulu\\\",\\\"password\\\":\\\"pbbedahulu!\\\"},\\\"data\\\":{\\\"id\\\":1,\\\"name\\\":\\\"Eggi Dwitama\\\",\\\"username\\\":\\\"admin\\\",\\\"contact\\\":\\\"085323085692\\\",\\\"community_id\\\":1,\\\"community_name\\\":\\\"PB BEDAHULU\\\",\\\"community\\\":\\\"pbbedahulu\\\",\\\"token\\\":\\\"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwibmFtZSI6IkVnZ2kgRHdpdGFtYSIsImNvbnRhY3QiOiIwODUzMjMwODU2OTIiLCJ1c2VybmFtZSI6ImFkbWluIiwiY29tbXVuaXR5X2lkIjoxLCJjb21tdW5pdHkiOnsiaWQiOjEsInVzZXJuYW1lIjoicGJiZWRhaHVsdSIsIm5hbWUiOiJQQiBCRURBSFVMVSIsImFkZHJlc3MiOiJKbC4gQmVkYWh1bHUgWCBOby4gMTcsIERlbnBhc2FyIFV0YXJhIC0gQmFsaSIsImNvbnRhY3QiOiIwODc4MDk1MzgwODAiLCJwaWMiOiJBZG1pbiBQQiBCZWRhaHVsdSIsImluc3RhZ3JhbSI6IkBwYl9iZWRhaHVsdSIsInRpa3RvayI6IkBwYl9iZWRhaHVsdSIsImVtYWlsIjoicGJiZWRhaHVsdUBnbWFpbC5jb20iLCJ3ZWJzaXRlIjoicGJiZWRhaHVsdS5teS5pZCIsImxvZ28iOiJsb2dvLXBiYmVkYWh1bHUucG5nIiwiY3JlYXRlZEF0IjoiMjAyNC0wNy0yOVQwMTo1MToyMS4wMDBaIiwidXBkYXRlZEF0IjoiMjAyNC0wNy0yOVQwMTo1MToyMS4wMDBaIn0sImlhdCI6MTcyMzQzNjA5OH0.DtTHCDcxTIl9YxSN9aoljUlRH6WgucmgPqxheT-TOFQ\\\"}}\"', 1, NULL, NULL, NULL, '2024-08-12 12:14:58', '2024-08-12 12:14:58'),
(168, '2024-08-12 12:16:31', 'Login', '\"{\\\"success\\\":true,\\\"statusCode\\\":200,\\\"message\\\":\\\"Login successfully\\\",\\\"query\\\":{\\\"username\\\":\\\"admin@pbbedahulu\\\",\\\"password\\\":\\\"pbbedahulu!\\\"},\\\"data\\\":{\\\"id\\\":1,\\\"name\\\":\\\"Eggi Dwitama\\\",\\\"username\\\":\\\"admin\\\",\\\"contact\\\":\\\"085323085692\\\",\\\"community_id\\\":1,\\\"community_name\\\":\\\"PB BEDAHULU\\\",\\\"community\\\":\\\"pbbedahulu\\\",\\\"token\\\":\\\"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwibmFtZSI6IkVnZ2kgRHdpdGFtYSIsImNvbnRhY3QiOiIwODUzMjMwODU2OTIiLCJ1c2VybmFtZSI6ImFkbWluIiwiY29tbXVuaXR5X2lkIjoxLCJjb21tdW5pdHkiOnsiaWQiOjEsInVzZXJuYW1lIjoicGJiZWRhaHVsdSIsIm5hbWUiOiJQQiBCRURBSFVMVSIsImFkZHJlc3MiOiJKbC4gQmVkYWh1bHUgWCBOby4gMTcsIERlbnBhc2FyIFV0YXJhIC0gQmFsaSIsImNvbnRhY3QiOiIwODc4MDk1MzgwODAiLCJwaWMiOiJBZG1pbiBQQiBCZWRhaHVsdSIsImluc3RhZ3JhbSI6IkBwYl9iZWRhaHVsdSIsInRpa3RvayI6IkBwYl9iZWRhaHVsdSIsImVtYWlsIjoicGJiZWRhaHVsdUBnbWFpbC5jb20iLCJ3ZWJzaXRlIjoicGJiZWRhaHVsdS5teS5pZCIsImxvZ28iOiJsb2dvLXBiYmVkYWh1bHUucG5nIiwiY3JlYXRlZEF0IjoiMjAyNC0wNy0yOVQwMTo1MToyMS4wMDBaIiwidXBkYXRlZEF0IjoiMjAyNC0wNy0yOVQwMTo1MToyMS4wMDBaIn0sImlhdCI6MTcyMzQzNjE5MX0.35uBXMIq_HemBlO0LDTrYfO1SR7e1pweIwJJqM4BatE\\\"}}\"', 1, NULL, NULL, NULL, '2024-08-12 12:16:31', '2024-08-12 12:16:31'),
(169, '2024-08-12 12:17:02', 'Login', '\"{\\\"success\\\":true,\\\"statusCode\\\":200,\\\"message\\\":\\\"Login successfully\\\",\\\"query\\\":{\\\"username\\\":\\\"admin@pbbedahulu\\\",\\\"password\\\":\\\"pbbedahulu!\\\"},\\\"data\\\":{\\\"id\\\":1,\\\"name\\\":\\\"Eggi Dwitama\\\",\\\"username\\\":\\\"admin\\\",\\\"contact\\\":\\\"085323085692\\\",\\\"community_id\\\":1,\\\"community_name\\\":\\\"PB BEDAHULU\\\",\\\"community\\\":\\\"pbbedahulu\\\",\\\"token\\\":\\\"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwibmFtZSI6IkVnZ2kgRHdpdGFtYSIsImNvbnRhY3QiOiIwODUzMjMwODU2OTIiLCJ1c2VybmFtZSI6ImFkbWluIiwiY29tbXVuaXR5X2lkIjoxLCJjb21tdW5pdHkiOnsiaWQiOjEsInVzZXJuYW1lIjoicGJiZWRhaHVsdSIsIm5hbWUiOiJQQiBCRURBSFVMVSIsImFkZHJlc3MiOiJKbC4gQmVkYWh1bHUgWCBOby4gMTcsIERlbnBhc2FyIFV0YXJhIC0gQmFsaSIsImNvbnRhY3QiOiIwODc4MDk1MzgwODAiLCJwaWMiOiJBZG1pbiBQQiBCZWRhaHVsdSIsImluc3RhZ3JhbSI6IkBwYl9iZWRhaHVsdSIsInRpa3RvayI6IkBwYl9iZWRhaHVsdSIsImVtYWlsIjoicGJiZWRhaHVsdUBnbWFpbC5jb20iLCJ3ZWJzaXRlIjoicGJiZWRhaHVsdS5teS5pZCIsImxvZ28iOiJsb2dvLXBiYmVkYWh1bHUucG5nIiwiY3JlYXRlZEF0IjoiMjAyNC0wNy0yOVQwMTo1MToyMS4wMDBaIiwidXBkYXRlZEF0IjoiMjAyNC0wNy0yOVQwMTo1MToyMS4wMDBaIn0sImlhdCI6MTcyMzQzNjIyMn0.5gkfOvHnRzrJV6HqEc-Az0HdG7OIKeuwqmntQ0Qb3iE\\\"}}\"', 1, NULL, NULL, NULL, '2024-08-12 12:17:02', '2024-08-12 12:17:02'),
(170, '2024-08-12 12:28:26', 'Profile', '\"{\\\"success\\\":true,\\\"statusCode\\\":200,\\\"message\\\":\\\"Profile retrieved successfully\\\",\\\"query\\\":{},\\\"data\\\":{\\\"id\\\":1,\\\"name\\\":\\\"Eggi Dwitama\\\",\\\"contact\\\":\\\"085323085692\\\",\\\"username\\\":\\\"admin\\\",\\\"community_id\\\":1,\\\"community\\\":{\\\"id\\\":1,\\\"username\\\":\\\"pbbedahulu\\\",\\\"name\\\":\\\"PB BEDAHULU\\\",\\\"address\\\":\\\"Jl. Bedahulu X No. 17, Denpasar Utara - Bali\\\",\\\"contact\\\":\\\"087809538080\\\",\\\"pic\\\":\\\"Admin PB Bedahulu\\\",\\\"instagram\\\":\\\"@pb_bedahulu\\\",\\\"tiktok\\\":\\\"@pb_bedahulu\\\",\\\"email\\\":\\\"pbbedahulu@gmail.com\\\",\\\"website\\\":\\\"pbbedahulu.my.id\\\",\\\"logo\\\":\\\"logo-pbbedahulu.png\\\",\\\"createdAt\\\":\\\"2024-07-29T01:51:21.000Z\\\",\\\"updatedAt\\\":\\\"2024-07-29T01:51:21.000Z\\\"},\\\"iat\\\":1723435628}}\"', 1, NULL, NULL, NULL, '2024-08-12 12:28:26', '2024-08-12 12:28:26');

-- --------------------------------------------------------

--
-- Table structure for table `notif`
--

CREATE TABLE `notif` (
  `id` int NOT NULL,
  `notif_id` int DEFAULT NULL,
  `notif_type` int DEFAULT NULL,
  `notif_server` varchar(255) DEFAULT NULL,
  `notif_token` varchar(255) DEFAULT NULL,
  `invoice_id` int DEFAULT NULL,
  `cut_off` datetime DEFAULT NULL,
  `due_date` datetime DEFAULT NULL,
  `period` varchar(255) DEFAULT NULL,
  `customer_service_id` int DEFAULT NULL,
  `customer_name` varchar(255) DEFAULT NULL,
  `customer_phone` varchar(255) DEFAULT NULL,
  `customer_email` varchar(255) DEFAULT NULL,
  `service_address` varchar(255) DEFAULT NULL,
  `product_name` varchar(255) DEFAULT NULL,
  `product_price` int DEFAULT NULL,
  `product_limit` int DEFAULT NULL,
  `cluster_name` varchar(255) DEFAULT NULL,
  `nominal` double DEFAULT NULL,
  `blast_wa_date` datetime DEFAULT NULL,
  `blast_wa_status` int DEFAULT NULL,
  `blast_app_date` datetime DEFAULT NULL,
  `blast_app_status` int DEFAULT NULL,
  `account_id` int DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `open_mabar`
--

CREATE TABLE `open_mabar` (
  `id` int NOT NULL,
  `community_id` int DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `hall_id` int DEFAULT NULL,
  `day` enum('sun','mon','tue','wed','thu','fri','sat') NOT NULL,
  `time` varchar(250) DEFAULT NULL,
  `court_count_used` int DEFAULT NULL,
  `max_slot` int DEFAULT NULL,
  `htm_member` decimal(10,2) DEFAULT NULL,
  `htm_nonmember` decimal(10,2) DEFAULT NULL,
  `note` text,
  `user_id` int DEFAULT NULL,
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `open_mabar`
--

INSERT INTO `open_mabar` (`id`, `community_id`, `name`, `hall_id`, `day`, `time`, `court_count_used`, `max_slot`, `htm_member`, `htm_nonmember`, `note`, `user_id`, `createdAt`) VALUES
(1, 1, 'Open Mabar Selasa', 1, 'tue', '19.00 - 22.00 WITA', 2, 24, '120000.00', '35000.00', 'Setiap selasa jam 19.00 - 22.00 WITA menggunakan 2 lapangan', 1, '2024-07-29 01:51:22'),
(2, 1, 'Open Mabar Rabu', 1, 'wed', '19.00 - 21.00 WITA', 2, 20, '25000.00', '30000.00', 'Setiap rabujam 19.00 - 21.00 WITA menggunakan 2 lapangan', 1, '2024-07-30 03:07:54');

-- --------------------------------------------------------

--
-- Table structure for table `open_mabar_day`
--

CREATE TABLE `open_mabar_day` (
  `id` int NOT NULL,
  `open_mabar_id` int DEFAULT NULL,
  `date` date NOT NULL,
  `note` text,
  `user_id` int DEFAULT NULL,
  `community_id` int DEFAULT NULL,
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `open_mabar_day`
--

INSERT INTO `open_mabar_day` (`id`, `open_mabar_id`, `date`, `note`, `user_id`, `community_id`, `createdAt`) VALUES
(1, 1, '2024-07-30', 'Sesi terakhir bulan juli', 1, 1, '2024-07-29 07:06:37'),
(2, 1, '2024-08-06', 'Sesi 1 Bulan Agustus 2024', 1, 1, '2024-07-30 03:26:30');

-- --------------------------------------------------------

--
-- Table structure for table `open_mabar_day_detail`
--

CREATE TABLE `open_mabar_day_detail` (
  `id` int NOT NULL,
  `open_mabar_day_id` int DEFAULT NULL,
  `player_id` int DEFAULT NULL,
  `player_level` enum('A','B','C') NOT NULL,
  `player_arrival_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `payment_status` enum('paid','unpaid') NOT NULL,
  `user_id` int DEFAULT NULL,
  `community_id` int DEFAULT NULL,
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `open_mabar_day_detail`
--

INSERT INTO `open_mabar_day_detail` (`id`, `open_mabar_day_id`, `player_id`, `player_level`, `player_arrival_time`, `payment_status`, `user_id`, `community_id`, `createdAt`) VALUES
(1, 1, 1, 'A', '2024-07-30 10:28:28', 'paid', 1, 1, '2024-07-29 07:29:18'),
(2, 1, 2, 'A', '2024-07-30 11:28:28', 'paid', 1, 1, '2024-07-29 07:29:18'),
(3, 1, 3, 'A', '2024-07-30 11:29:23', 'paid', 1, 1, '2024-07-29 07:29:50'),
(4, 1, 4, 'A', '2024-07-30 11:29:23', 'paid', 1, 1, '2024-07-29 07:29:50'),
(5, 1, 5, 'A', '2024-07-30 11:15:00', 'paid', 1, 1, '2024-07-29 09:18:00'),
(6, 1, 6, 'A', '2024-07-30 11:17:00', 'unpaid', 1, 1, '2024-07-29 09:18:00'),
(9, 1, 7, 'A', '2024-07-30 11:41:13', 'unpaid', 1, 1, '2024-07-30 02:41:47'),
(10, 1, 8, 'A', '2024-07-30 11:31:13', 'paid', 1, 1, '2024-07-30 02:41:47'),
(11, 1, 9, 'A', '2024-07-30 11:22:13', 'paid', 1, 1, '2024-07-30 02:42:06'),
(12, 1, 10, 'A', '2024-07-30 11:33:13', 'paid', 1, 1, '2024-07-30 02:42:06'),
(13, 1, 11, 'A', '2024-07-30 11:10:13', 'paid', 1, 1, '2024-07-30 02:42:26'),
(14, 1, 12, 'A', '2024-07-30 11:21:13', 'paid', 1, 1, '2024-07-30 02:42:26'),
(15, 1, 13, 'B', '2024-07-30 12:00:38', 'paid', 1, 1, '2024-07-30 06:10:38'),
(16, 1, 14, 'A', '2024-07-30 12:12:49', 'paid', 1, 1, '2024-07-30 06:30:49'),
(17, 1, 15, 'A', '2024-07-30 12:33:16', 'paid', 1, 1, '2024-07-30 06:33:16'),
(18, 1, 17, 'B', '2024-07-30 12:36:13', 'paid', 1, 1, '2024-07-30 08:36:13'),
(19, 1, 18, 'B', '2024-07-30 12:36:13', 'paid', 1, 1, '2024-07-30 08:36:20'),
(20, 1, 19, 'A', '2024-07-30 12:36:13', 'paid', 1, 1, '2024-07-30 08:36:33'),
(21, 1, 20, 'B', '2024-07-30 12:36:13', 'paid', 1, 1, '2024-07-30 08:36:39'),
(22, 1, 21, 'A', '2024-07-30 12:36:13', 'paid', 1, 1, '2024-07-30 08:36:50'),
(23, 1, 22, 'A', '2024-07-30 12:36:13', 'paid', 1, 1, '2024-07-30 08:36:56'),
(24, 1, 23, 'A', '2024-07-30 12:36:13', 'paid', 1, 1, '2024-07-30 08:37:04'),
(25, 1, 24, 'A', '2024-07-30 12:36:13', 'paid', 1, 1, '2024-07-30 08:37:07'),
(26, 1, 25, 'A', '2024-07-30 12:36:13', 'paid', 1, 1, '2024-07-30 08:37:11'),
(27, 1, 16, 'A', '2024-07-30 12:36:13', 'paid', 1, 1, '2024-07-30 08:44:13'),
(28, 1, 26, 'A', '2024-07-31 05:34:42', 'paid', 1, 1, '2024-07-31 05:34:42'),
(29, 1, 27, 'A', '2024-07-31 05:38:33', 'paid', 1, 1, '2024-07-31 05:38:33'),
(30, 2, 15, 'A', '2024-08-06 10:50:00', 'paid', 1, 1, '2024-08-08 01:24:41'),
(31, 2, 33, 'C', '2024-08-06 11:05:00', 'paid', 1, 1, '2024-08-08 01:29:25'),
(32, 2, 6, 'A', '2024-08-06 11:05:00', 'paid', 1, 1, '2024-08-08 01:29:53'),
(33, 2, 3, 'A', '2024-08-06 11:05:00', 'paid', 1, 1, '2024-08-08 01:31:01'),
(34, 2, 34, 'C', '2024-08-06 11:15:24', 'paid', 1, 1, '2024-08-08 01:31:24'),
(35, 2, 5, 'A', '2024-08-06 11:05:14', 'paid', 1, 1, '2024-08-08 01:32:14'),
(36, 2, 38, 'C', '2024-08-06 11:25:44', 'paid', 1, 1, '2024-08-08 01:32:44'),
(37, 2, 39, 'C', '2024-08-06 11:25:44', 'paid', 1, 1, '2024-08-08 01:33:08'),
(38, 2, 40, 'C', '2024-08-06 11:25:44', 'paid', 1, 1, '2024-08-08 01:33:19'),
(39, 2, 35, 'A', '2024-08-06 11:26:44', 'paid', 1, 1, '2024-08-08 01:33:51'),
(40, 2, 42, 'B', '2024-08-06 11:36:44', 'paid', 1, 1, '2024-08-08 01:36:07'),
(41, 2, 36, 'A', '2024-08-06 11:45:44', 'paid', 1, 1, '2024-08-08 01:36:34'),
(42, 2, 37, 'A', '2024-08-06 11:50:44', 'paid', 1, 1, '2024-08-08 01:37:12'),
(43, 2, 4, 'A', '2024-08-06 11:25:44', 'paid', 1, 1, '2024-08-08 01:37:46'),
(44, 2, 2, 'A', '2024-08-06 11:45:44', 'paid', 1, 1, '2024-08-08 01:38:50'),
(45, 2, 1, 'A', '2024-08-06 10:50:44', 'paid', 1, 1, '2024-08-08 01:38:54'),
(46, 2, 41, 'C', '2024-08-08 01:41:12', 'paid', 1, 1, '2024-08-08 01:41:12');

-- --------------------------------------------------------

--
-- Table structure for table `open_mabar_day_recap`
--

CREATE TABLE `open_mabar_day_recap` (
  `id` int NOT NULL,
  `open_mabar_day_id` int DEFAULT NULL,
  `date` date NOT NULL,
  `participant_count_member` int DEFAULT NULL,
  `participant_count_nonmember` int DEFAULT NULL,
  `total_matches_count` int DEFAULT NULL,
  `shuttlecock_provided` int DEFAULT NULL,
  `shuttlecock_used` int DEFAULT NULL,
  `shuttlecock_available` int DEFAULT NULL,
  `note` text,
  `user_id` int DEFAULT NULL,
  `community_id` int DEFAULT NULL,
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `open_mabar_day_recap`
--

INSERT INTO `open_mabar_day_recap` (`id`, `open_mabar_day_id`, `date`, `participant_count_member`, `participant_count_nonmember`, `total_matches_count`, `shuttlecock_provided`, `shuttlecock_used`, `shuttlecock_available`, `note`, `user_id`, `community_id`, `createdAt`) VALUES
(1, 1, '2024-07-30', 0, 25, 11, 36, 21, 15, 'mabar day one', 1, 1, '2024-08-03 02:55:50'),
(2, 2, '2024-08-06', 1, 16, 14, 36, 26, 10, 'mabar perdana', 1, 1, '2024-08-08 06:25:12');

-- --------------------------------------------------------

--
-- Table structure for table `open_mabar_match`
--

CREATE TABLE `open_mabar_match` (
  `id` int NOT NULL,
  `open_mabar_day_id` int DEFAULT NULL,
  `court_id` int DEFAULT NULL,
  `player_id_a1` int DEFAULT NULL,
  `player_level_a1` enum('A','B','C') DEFAULT NULL,
  `player_id_a2` int DEFAULT NULL,
  `player_level_a2` enum('A','B','C') DEFAULT NULL,
  `player_id_b1` int DEFAULT NULL,
  `player_level_b1` enum('A','B','C') DEFAULT NULL,
  `player_id_b2` int DEFAULT NULL,
  `player_level_b2` enum('A','B','C') DEFAULT NULL,
  `start_time` time DEFAULT NULL,
  `end_time` time DEFAULT NULL,
  `score` varchar(50) DEFAULT NULL,
  `shuttlecock_used` int DEFAULT NULL,
  `note` text,
  `user_id` int DEFAULT NULL,
  `community_id` int DEFAULT NULL,
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `open_mabar_match`
--

INSERT INTO `open_mabar_match` (`id`, `open_mabar_day_id`, `court_id`, `player_id_a1`, `player_level_a1`, `player_id_a2`, `player_level_a2`, `player_id_b1`, `player_level_b1`, `player_id_b2`, `player_level_b2`, `start_time`, `end_time`, `score`, `shuttlecock_used`, `note`, `user_id`, `community_id`, `createdAt`) VALUES
(1, 1, 1, 1, 'A', 2, 'A', 3, 'A', 4, 'A', '19:10:00', '19:30:00', '42-40', 2, NULL, 1, 1, '2024-07-29 08:20:19'),
(2, 1, 2, 1, 'A', 2, 'A', 5, 'A', 6, 'A', '19:45:00', '20:10:00', '38-42', 2, NULL, 1, 1, '2024-07-29 08:20:19'),
(3, 1, 1, 7, 'A', 8, 'A', 9, 'A', 10, 'A', '19:35:00', '20:00:00', '42-33', 3, NULL, 1, 1, '2024-07-30 02:31:47'),
(4, 1, 2, 11, 'A', 12, 'A', 3, 'A', 4, 'A', '20:15:00', '20:40:00', '37-42', 2, NULL, 1, 1, '2024-07-30 02:31:47'),
(5, 1, 1, 13, 'B', 14, 'A', 15, 'A', 16, 'A', '20:05:00', '20:30:00', '42-38', 1, '', 1, 1, '2024-07-30 07:29:35'),
(6, 1, 2, 17, 'B', 18, 'B', 19, 'A', 20, 'B', '20:45:00', '21:00:00', '28-42', 2, '', 1, 1, '2024-07-30 08:47:11'),
(7, 1, 1, 21, 'A', 22, 'A', 23, 'A', 24, 'A', '20:35:00', '20:55:00', '42-39', 2, '', 1, 1, '2024-07-30 08:48:43'),
(8, 1, 1, 25, 'A', 1, 'A', 2, 'A', 3, 'A', '21:00:00', '21:25:00', '37-42', 2, '', 1, 1, '2024-07-30 08:52:15'),
(9, 1, 2, 4, 'A', 5, 'A', 6, 'A', 7, 'A', '21:10:00', '21:35:00', '42-30', 1, '', 1, 1, '2024-07-30 08:53:42'),
(10, 1, 2, 8, 'A', 9, 'A', 10, 'A', 11, 'A', '21:30:00', '21:58:00', '42-41', 2, '', 1, 1, '2024-07-30 08:54:42'),
(11, 1, 1, 12, 'A', 13, 'B', 14, 'A', 15, 'A', '21:35:00', '22:00:00', '33-42', 2, '', 1, 1, '2024-07-30 08:56:09'),
(12, 2, 3, 6, 'A', 34, 'B', 15, 'A', 33, 'B', '19:20:00', '19:42:00', '33-42', 3, '', 1, 1, '2024-08-08 06:07:38'),
(13, 2, 3, 36, 'A', 42, 'B', 35, 'A', 41, 'C', '19:47:00', '20:05:00', '42-16', 2, '', 1, 1, '2024-08-08 06:08:42'),
(14, 2, 2, 1, 'A', 38, 'C', 39, 'C', 40, 'C', '19:35:00', '19:51:00', '42-11', 1, '', 1, 1, '2024-08-08 06:09:40'),
(15, 2, 2, 2, 'A', 37, 'A', 3, 'A', 33, 'B', '19:56:00', '20:15:00', '42-33', 2, '', 1, 1, '2024-08-08 06:11:23'),
(16, 2, 2, 4, 'A', 41, 'C', 42, 'B', 34, 'B', '20:20:00', '20:41:00', '33-42', 1, '', 1, 1, '2024-08-08 06:12:49'),
(17, 2, 3, 15, 'A', 38, 'C', 40, 'C', 39, 'C', '20:10:00', '20:26:00', '42-9', 1, '', 1, 1, '2024-08-08 06:13:50'),
(18, 2, 3, 15, 'A', 37, 'A', 36, 'A', 35, 'A', '20:30:00', '20:50:00', '42-39', 3, '', 1, 1, '2024-08-08 06:15:30'),
(19, 2, 2, 4, 'A', 6, 'A', 1, 'A', 2, 'A', '20:45:00', '21:05:00', '30-42', 3, '', 1, 1, '2024-08-08 06:16:27'),
(20, 2, 3, 3, 'A', 42, 'B', 37, 'A', 33, 'B', '20:50:00', '21:15:00', '32-42', 2, '', 1, 1, '2024-08-08 06:17:22'),
(21, 2, 2, 34, 'B', 41, 'C', 1, 'A', 38, 'C', '21:00:00', '21:30:00', '27-42', 1, '', 1, 1, '2024-08-08 06:18:34'),
(22, 2, 3, 2, 'A', 5, 'A', 36, 'A', 35, 'A', '21:20:00', '21:39:00', '42-24', 2, '', 1, 1, '2024-08-08 06:19:48'),
(23, 2, 2, 15, 'A', 37, 'A', 42, 'B', 33, 'B', '21:35:00', '21:15:00', '42-33', 2, '', 1, 1, '2024-08-08 06:21:09'),
(24, 2, 3, 4, 'A', 41, 'C', 1, 'A', 38, 'C', '21:35:00', '22:00:00', '38-42', 1, '', 1, 1, '2024-08-08 06:22:21'),
(25, 2, 2, 1, 'A', 42, 'B', 5, 'A', 34, 'B', '21:40:00', '22:00:00', '42-25', 2, '', 1, 1, '2024-08-08 06:23:12');

-- --------------------------------------------------------

--
-- Table structure for table `open_mabar_player`
--

CREATE TABLE `open_mabar_player` (
  `id` int NOT NULL,
  `open_mabar_id` int DEFAULT NULL,
  `player_id` int DEFAULT NULL,
  `status` enum('member','non member') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT 'member',
  `note` text,
  `user_id` int DEFAULT NULL,
  `community_id` int DEFAULT NULL,
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `open_mabar_player`
--

INSERT INTO `open_mabar_player` (`id`, `open_mabar_id`, `player_id`, `status`, `note`, `user_id`, `community_id`, `createdAt`) VALUES
(1, 1, 1, 'non member', NULL, 1, 1, '2024-07-29 01:51:22'),
(2, 1, 2, 'non member', NULL, 1, 1, '2024-07-29 01:51:22'),
(3, 1, 3, 'non member', NULL, 1, 1, '2024-07-29 01:51:22'),
(4, 1, 4, 'non member', NULL, 1, 1, '2024-07-29 01:51:22'),
(5, 1, 5, 'non member', NULL, 1, 1, '2024-07-30 02:28:32'),
(6, 1, 6, 'non member', NULL, 1, 1, '2024-07-30 02:28:32'),
(7, 1, 7, 'non member', NULL, 1, 1, '2024-07-30 02:28:41'),
(8, 1, 8, 'non member', NULL, 1, 1, '2024-07-30 02:28:41'),
(9, 1, 9, 'non member', NULL, 1, 1, '2024-07-30 02:29:01'),
(10, 1, 10, 'non member', NULL, 1, 1, '2024-07-30 02:29:01'),
(11, 1, 11, 'non member', NULL, 1, 1, '2024-07-30 02:29:09'),
(12, 1, 12, 'non member', NULL, 1, 1, '2024-07-30 02:29:09'),
(13, 1, 13, 'non member', NULL, 1, 1, '2024-07-30 06:10:38'),
(14, 1, 14, 'non member', '', 1, 1, '2024-07-30 06:30:49'),
(15, 1, 15, 'non member', '', 1, 1, '2024-07-30 06:32:54'),
(16, 1, 16, 'non member', '', 1, 1, '2024-07-30 06:44:18'),
(17, 1, 17, 'non member', '', 1, 1, '2024-07-30 08:36:13'),
(18, 1, 18, 'non member', '', 1, 1, '2024-07-30 08:36:20'),
(19, 1, 19, 'non member', '', 1, 1, '2024-07-30 08:36:33'),
(20, 1, 20, 'non member', '', 1, 1, '2024-07-30 08:36:39'),
(21, 1, 21, 'non member', '', 1, 1, '2024-07-30 08:36:50'),
(22, 1, 22, 'non member', '', 1, 1, '2024-07-30 08:36:56'),
(23, 1, 23, 'non member', '', 1, 1, '2024-07-30 08:37:04'),
(24, 1, 24, 'non member', '', 1, 1, '2024-07-30 08:37:07'),
(25, 1, 25, 'non member', '', 1, 1, '2024-07-30 08:37:11'),
(26, 1, 27, 'non member', '', 1, 1, '2024-07-31 03:01:35'),
(27, 1, 26, 'non member', '', 1, 1, '2024-07-31 05:34:42'),
(28, 1, 33, 'member', '', 1, 1, '2024-08-08 01:28:49'),
(29, 1, 34, 'non member', '', 1, 1, '2024-08-08 01:31:24'),
(30, 1, 38, 'non member', '', 1, 1, '2024-08-08 01:32:44'),
(31, 1, 39, 'non member', '', 1, 1, '2024-08-08 01:33:08'),
(32, 1, 40, 'non member', '', 1, 1, '2024-08-08 01:33:19'),
(33, 1, 35, 'non member', '', 1, 1, '2024-08-08 01:33:50'),
(34, 1, 42, 'non member', '', 1, 1, '2024-08-08 01:36:07'),
(35, 1, 36, 'non member', '', 1, 1, '2024-08-08 01:36:34'),
(36, 1, 37, 'non member', '', 1, 1, '2024-08-08 01:37:12'),
(37, 1, 41, 'non member', '', 1, 1, '2024-08-08 01:41:12');

-- --------------------------------------------------------

--
-- Table structure for table `player`
--

CREATE TABLE `player` (
  `id` int NOT NULL,
  `name` varchar(255) NOT NULL,
  `alias` varchar(255) DEFAULT NULL,
  `username` varchar(255) NOT NULL,
  `gender` enum('M','F') NOT NULL,
  `contact` varchar(20) DEFAULT NULL,
  `level` enum('A','B','C') NOT NULL,
  `age_range` enum('15-20','21-30','31-40','41-50','51-60','61-70','71-80') NOT NULL,
  `user_id` int DEFAULT NULL,
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `player`
--

INSERT INTO `player` (`id`, `name`, `alias`, `username`, `gender`, `contact`, `level`, `age_range`, `user_id`, `createdAt`) VALUES
(1, 'Eggi Dwitama', 'eggi', 'eggi692', 'M', '085323085692', 'A', '31-40', 1, '2024-07-29 01:51:22'),
(2, 'Relieyan Hilman', 'rian', 'rian075', 'M', '081337126075', 'A', '21-30', 1, '2024-07-29 01:51:22'),
(3, 'Yudhi Harta', 'yudhi', 'yudhi480', 'M', '081934345480', 'A', '41-50', 1, '2024-07-29 01:51:22'),
(4, 'Juan Morino', 'juan', 'juan299', 'M', '089634862299', 'A', '21-30', 1, '2024-07-29 01:51:22'),
(5, 'Aditya Riyanto', 'adit', 'adit726', 'M', '0818562726', 'A', '41-50', 1, '2024-07-29 01:51:22'),
(6, 'Ngurah Danta', 'danta', 'danta881', 'M', '082145672881', 'A', '31-40', 1, '2024-07-29 01:51:22'),
(7, 'Danny', 'danny', 'danny843', 'M', '082135555843', 'A', '31-40', 1, '2024-07-30 02:24:45'),
(8, 'Kadek Juli', 'juli', 'juli114', 'M', '085253680114', 'A', '31-40', 1, '2024-07-30 02:24:45'),
(9, 'Windra Wartana', 'windra', 'windra415', 'M', '081805358415', 'A', '31-40', 1, '2024-07-30 02:26:25'),
(10, 'Ryan Wuhono', 'ryan', 'ryan999', 'M', '085205291999', 'A', '31-40', 1, '2024-07-30 02:26:25'),
(11, 'Denny Tenggala', 'denny', 'denny666', 'M', '081246376666', 'A', '31-40', 1, '2024-07-30 02:27:55'),
(12, 'Surya', 'surya', 'surya370', 'M', '087841998370', 'A', '31-40', 1, '2024-07-30 02:27:55'),
(13, 'Nyoman Sudarma', 'nyoman s', 'nyoman201', 'M', '081238458201', 'B', '51-60', 1, '2024-07-30 03:44:04'),
(14, 'Kelvin P', 'kelvin', 'kelvin978', 'M', '087863088978', 'A', '31-40', 1, '2024-07-30 06:30:05'),
(15, 'Dika', 'dika', 'dika400', 'M', '085961160400', 'A', '31-40', 1, '2024-07-30 06:31:44'),
(16, 'Satria', 'satria', 'satria556', 'M', '081805395556', 'A', '41-50', 1, '2024-07-30 06:43:06'),
(17, 'Ngurah JB', 'ajik', 'ajik227', 'M', '081337569227', 'B', '41-50', 1, '2024-07-30 08:27:06'),
(18, 'Putu Adi', 'putu adi', 'putuadi390', 'M', '081805612390', 'B', '41-50', 1, '2024-07-30 08:27:52'),
(19, 'Donny', 'donny maybank', 'donny043', 'M', '08123874043', 'A', '41-50', 1, '2024-07-30 08:28:41'),
(20, 'Fajar Pradnyana', 'fajar', 'imfpradnyana431', 'M', '081236638431', 'B', '21-30', 1, '2024-07-30 08:29:54'),
(21, 'Dendy', 'ko dendy', 'dendy907', 'M', '082233009907', 'A', '41-50', 1, '2024-07-30 08:30:43'),
(22, 'Nyoman Adi', 'nyoman TJ', 'manadi008', 'M', '081246529008', 'A', '41-50', 1, '2024-07-30 08:31:30'),
(23, 'Mandra', 'mandra', 'mandra052', 'M', '085103543052', 'A', '51-60', 1, '2024-07-30 08:32:26'),
(24, 'Arya', 'arya bni', 'arya738', 'M', '08124678738', 'B', '51-60', 1, '2024-07-30 08:33:14'),
(25, 'Wayan', 'wayan tato', 'wayan062', 'M', '085792386062', 'A', '31-40', 1, '2024-07-30 08:34:25'),
(26, 'Wayan Suwarna', 'wayan suwarna', 'suwarna750', 'M', '081338600750', 'A', '41-50', 1, '2024-07-30 08:35:10'),
(27, 'Frans', 'frans', 'frans995', 'M', '089699950995', 'A', '41-50', 1, '2024-07-31 02:57:38'),
(28, 'Bayu', 'bayu mahaprasta', 'bayumahaprasta022', 'M', '081239839022', 'B', '31-40', 1, '2024-07-31 03:17:27'),
(29, 'Ryouhei', 'ryouhei', 'yohe441', 'M', '087758288441', 'A', '41-50', 1, '2024-08-02 05:31:46'),
(30, 'Andre Wicaksana', 'ko andre', 'andre414', 'M', '08123811414', 'A', '41-50', 1, '2024-08-02 05:33:57'),
(31, 'Yenny', 'ci yenny', 'yenny414', 'F', NULL, 'B', '41-50', 1, '2024-08-02 05:33:57'),
(32, 'Stefan Farel', 'stefan', 'stefan228', 'M', '00817342228', 'A', '15-20', 1, '2024-08-02 05:38:21'),
(33, 'Dwiki', 'wiki', 'wiki605', 'M', '081392427605', 'C', '21-30', 1, '2024-08-05 05:52:05'),
(34, 'Arif', 'arif', 'arif427', 'M', '081339866427', 'C', '21-30', 1, '2024-08-05 05:53:39'),
(35, 'Made Cahyadi', 'ade alila', 'ade012', 'M', '081111222012', 'A', '31-40', 1, '2024-08-06 01:31:09'),
(36, 'Martono Putra', 'nono', 'nono069', 'M', '082299220069', 'A', '31-40', 1, '2024-08-06 01:31:31'),
(37, 'Ardhi', 'ardhi alila', 'ardhi587', 'M', '085738225587', 'A', '31-40', 1, '2024-08-06 01:31:48'),
(38, 'Ismi Azyzah', 'ismi', 'ismi699', 'F', '08568620699', 'C', '21-30', 1, '2024-08-08 01:19:32'),
(39, 'Clara', 'clara', 'clara012', 'F', '087703276758', 'C', '21-30', 1, '2024-08-08 01:20:01'),
(40, 'Rico', 'rico', 'rico012', 'M', '085444333012', 'C', '21-30', 1, '2024-08-08 01:20:25'),
(41, 'Arga', 'arga', 'arga636', 'M', '082142534636', 'C', '21-30', 1, '2024-08-08 01:20:45'),
(42, 'Irul', 'irul', 'irul237', 'M', '081936531237', 'B', '21-30', 1, '2024-08-08 01:35:48'),
(43, 'Susi Suzanna', 'Susan', 'susan213', 'M', '08113114213', 'A', '21-30', 1, '2024-08-11 08:44:40');

-- --------------------------------------------------------

--
-- Table structure for table `revokedtokens`
--

CREATE TABLE `revokedtokens` (
  `id` int NOT NULL,
  `token` varchar(255) DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `userId` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `service_log`
--

CREATE TABLE `service_log` (
  `id` int NOT NULL,
  `date` datetime NOT NULL,
  `customer_service_id` int DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  `service_action` varchar(255) DEFAULT NULL,
  `note` varchar(255) DEFAULT NULL,
  `account_id` int DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `service_order`
--

CREATE TABLE `service_order` (
  `id` int NOT NULL,
  `customer_service_id` int DEFAULT NULL,
  `so_date` datetime NOT NULL,
  `rfs_date` datetime DEFAULT NULL,
  `service_action` int DEFAULT NULL,
  `product_id` int DEFAULT NULL,
  `requested_by` int DEFAULT NULL,
  `response` int DEFAULT NULL,
  `response_pic` int DEFAULT NULL,
  `response_date` datetime DEFAULT NULL,
  `activation_date` datetime DEFAULT NULL,
  `activation_pic` int DEFAULT NULL,
  `activation_note` varchar(255) DEFAULT NULL,
  `status` int DEFAULT NULL,
  `note` varchar(255) DEFAULT NULL,
  `account_id` int DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `taxo`
--

CREATE TABLE `taxo` (
  `id` int NOT NULL,
  `sort` int DEFAULT NULL,
  `device_id` int DEFAULT NULL,
  `object` varchar(255) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  `product_price` int DEFAULT NULL,
  `product_limit` int DEFAULT NULL,
  `desc` varchar(255) DEFAULT NULL,
  `template_id` int DEFAULT NULL,
  `account_id` int DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int NOT NULL,
  `community_id` int DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `contact` varchar(20) DEFAULT NULL,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `privilege` enum('super admin','admin') NOT NULL,
  `user_id` int DEFAULT NULL,
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `community_id`, `name`, `contact`, `username`, `password`, `privilege`, `user_id`, `createdAt`) VALUES
(1, 1, 'Eggi Dwitama', '085323085692', 'admin', '$2b$10$OoJYhJGzdQev54GdEPHa4u3eO.kQfUNxk6JnIHtN3OsjJbTLOJWWK', 'super admin', 1, '2024-07-29 01:51:22'),
(2, 1, 'Relieyan Hilman', '081337126075', 'rian', '$2b$10$OoJYhJGzdQev54GdEPHa4u3eO.kQfUNxk6JnIHtN3OsjJbTLOJWWK', 'super admin', 1, '2024-07-29 02:15:10'),
(3, 1, 'Yuhdi Harta', '081934345480', 'yudhi', '$2b$10$Hu/wDq6gRdmim0YaszWV7uQsO0q67kpwZtkdI8klSovQIsT.eQ03G', 'super admin', NULL, '2024-08-02 06:49:53'),
(4, 1, 'Juan Morino', '089634862299', 'juan', '$2b$10$slj73A3KAcoMY61kPz/EG.bS.ZM.iMAoQVdR2L4t.ZUIOjnVzId16', 'super admin', NULL, '2024-08-02 06:50:12'),
(5, 1, 'Aditya Riyanto', '0818562726', 'adit', '$2b$10$GP9PLmHvSawSgAMpX/YMmOPeQU1T/AneIchPo85Td.vcZB96uAUHK', 'super admin', NULL, '2024-08-02 06:50:34'),
(6, 1, 'Denny Tenggala', '081246376666', 'denny', '$2b$10$/06b6EWghhhCTVjVmfNlYubYQS3AFysFZsR3TN4siVRdCtxEzeblO', 'super admin', NULL, '2024-08-02 06:50:51');

-- --------------------------------------------------------

--
-- Table structure for table `whatsapp`
--

CREATE TABLE `whatsapp` (
  `id` int NOT NULL,
  `server_name` varchar(255) DEFAULT NULL,
  `token` varchar(255) DEFAULT NULL,
  `capacity` int DEFAULT NULL,
  `total_usage` int DEFAULT NULL,
  `account_id` int DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `account`
--
ALTER TABLE `account`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `action`
--
ALTER TABLE `action`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `cash_flow`
--
ALTER TABLE `cash_flow`
  ADD PRIMARY KEY (`id`),
  ADD KEY `community_id` (`community_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `clients`
--
ALTER TABLE `clients`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `community`
--
ALTER TABLE `community`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indexes for table `court`
--
ALTER TABLE `court`
  ADD PRIMARY KEY (`id`),
  ADD KEY `hall_id` (`hall_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `customer_services`
--
ALTER TABLE `customer_services`
  ADD PRIMARY KEY (`id`),
  ADD KEY `customer_id` (`customer_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `devices`
--
ALTER TABLE `devices`
  ADD PRIMARY KEY (`id`),
  ADD KEY `vendor_product_type` (`vendor_product_type`);

--
-- Indexes for table `hall`
--
ALTER TABLE `hall`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `invoice_customer`
--
ALTER TABLE `invoice_customer`
  ADD PRIMARY KEY (`id`),
  ADD KEY `invoice_template_id` (`invoice_template_id`);

--
-- Indexes for table `invoice_template`
--
ALTER TABLE `invoice_template`
  ADD PRIMARY KEY (`id`),
  ADD KEY `account_id` (`account_id`);

--
-- Indexes for table `log`
--
ALTER TABLE `log`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `notif`
--
ALTER TABLE `notif`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `open_mabar`
--
ALTER TABLE `open_mabar`
  ADD PRIMARY KEY (`id`),
  ADD KEY `community_id` (`community_id`),
  ADD KEY `hall_id` (`hall_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `open_mabar_day`
--
ALTER TABLE `open_mabar_day`
  ADD PRIMARY KEY (`id`),
  ADD KEY `open_mabar_id` (`open_mabar_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `open_mabar_day_detail`
--
ALTER TABLE `open_mabar_day_detail`
  ADD PRIMARY KEY (`id`),
  ADD KEY `open_mabar_day_id` (`open_mabar_day_id`),
  ADD KEY `player_id` (`player_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `open_mabar_day_recap`
--
ALTER TABLE `open_mabar_day_recap`
  ADD PRIMARY KEY (`id`),
  ADD KEY `open_mabar_day_id` (`open_mabar_day_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `open_mabar_match`
--
ALTER TABLE `open_mabar_match`
  ADD PRIMARY KEY (`id`),
  ADD KEY `open_mabar_day_id` (`open_mabar_day_id`),
  ADD KEY `court_id` (`court_id`),
  ADD KEY `player_id_a1` (`player_id_a1`),
  ADD KEY `player_id_a2` (`player_id_a2`),
  ADD KEY `player_id_b1` (`player_id_b1`),
  ADD KEY `player_id_b2` (`player_id_b2`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `open_mabar_player`
--
ALTER TABLE `open_mabar_player`
  ADD PRIMARY KEY (`id`),
  ADD KEY `open_mabar_id` (`open_mabar_id`),
  ADD KEY `player_id` (`player_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `player`
--
ALTER TABLE `player`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `revokedtokens`
--
ALTER TABLE `revokedtokens`
  ADD PRIMARY KEY (`id`),
  ADD KEY `userId` (`userId`);

--
-- Indexes for table `service_log`
--
ALTER TABLE `service_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `customer_service_id` (`customer_service_id`);

--
-- Indexes for table `service_order`
--
ALTER TABLE `service_order`
  ADD PRIMARY KEY (`id`),
  ADD KEY `customer_service_id` (`customer_service_id`);

--
-- Indexes for table `taxo`
--
ALTER TABLE `taxo`
  ADD PRIMARY KEY (`id`),
  ADD KEY `template_id` (`template_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD KEY `community_id` (`community_id`);

--
-- Indexes for table `whatsapp`
--
ALTER TABLE `whatsapp`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `account`
--
ALTER TABLE `account`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `action`
--
ALTER TABLE `action`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `cash_flow`
--
ALTER TABLE `cash_flow`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `clients`
--
ALTER TABLE `clients`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `community`
--
ALTER TABLE `community`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `court`
--
ALTER TABLE `court`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `customers`
--
ALTER TABLE `customers`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `customer_services`
--
ALTER TABLE `customer_services`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `devices`
--
ALTER TABLE `devices`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hall`
--
ALTER TABLE `hall`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `invoice_customer`
--
ALTER TABLE `invoice_customer`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `invoice_template`
--
ALTER TABLE `invoice_template`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `log`
--
ALTER TABLE `log`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=171;

--
-- AUTO_INCREMENT for table `notif`
--
ALTER TABLE `notif`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `open_mabar`
--
ALTER TABLE `open_mabar`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `open_mabar_day`
--
ALTER TABLE `open_mabar_day`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `open_mabar_day_detail`
--
ALTER TABLE `open_mabar_day_detail`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=47;

--
-- AUTO_INCREMENT for table `open_mabar_day_recap`
--
ALTER TABLE `open_mabar_day_recap`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `open_mabar_match`
--
ALTER TABLE `open_mabar_match`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT for table `open_mabar_player`
--
ALTER TABLE `open_mabar_player`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38;

--
-- AUTO_INCREMENT for table `player`
--
ALTER TABLE `player`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=44;

--
-- AUTO_INCREMENT for table `revokedtokens`
--
ALTER TABLE `revokedtokens`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `service_log`
--
ALTER TABLE `service_log`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `service_order`
--
ALTER TABLE `service_order`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `taxo`
--
ALTER TABLE `taxo`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `whatsapp`
--
ALTER TABLE `whatsapp`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `cash_flow`
--
ALTER TABLE `cash_flow`
  ADD CONSTRAINT `cash_flow_ibfk_1` FOREIGN KEY (`community_id`) REFERENCES `community` (`id`),
  ADD CONSTRAINT `cash_flow_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `court`
--
ALTER TABLE `court`
  ADD CONSTRAINT `court_ibfk_1` FOREIGN KEY (`hall_id`) REFERENCES `hall` (`id`),
  ADD CONSTRAINT `court_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `customer_services`
--
ALTER TABLE `customer_services`
  ADD CONSTRAINT `customer_services_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `customer_services_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `taxo` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `devices`
--
ALTER TABLE `devices`
  ADD CONSTRAINT `devices_ibfk_1` FOREIGN KEY (`vendor_product_type`) REFERENCES `taxo` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `hall`
--
ALTER TABLE `hall`
  ADD CONSTRAINT `hall_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `invoice_customer`
--
ALTER TABLE `invoice_customer`
  ADD CONSTRAINT `invoice_customer_ibfk_1` FOREIGN KEY (`invoice_template_id`) REFERENCES `invoice_template` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `invoice_template`
--
ALTER TABLE `invoice_template`
  ADD CONSTRAINT `invoice_template_ibfk_1` FOREIGN KEY (`account_id`) REFERENCES `account` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `open_mabar`
--
ALTER TABLE `open_mabar`
  ADD CONSTRAINT `open_mabar_ibfk_1` FOREIGN KEY (`community_id`) REFERENCES `community` (`id`),
  ADD CONSTRAINT `open_mabar_ibfk_2` FOREIGN KEY (`hall_id`) REFERENCES `hall` (`id`),
  ADD CONSTRAINT `open_mabar_ibfk_3` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `open_mabar_day`
--
ALTER TABLE `open_mabar_day`
  ADD CONSTRAINT `open_mabar_day_ibfk_1` FOREIGN KEY (`open_mabar_id`) REFERENCES `open_mabar` (`id`),
  ADD CONSTRAINT `open_mabar_day_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `open_mabar_day_detail`
--
ALTER TABLE `open_mabar_day_detail`
  ADD CONSTRAINT `open_mabar_day_detail_ibfk_1` FOREIGN KEY (`open_mabar_day_id`) REFERENCES `open_mabar_day` (`id`),
  ADD CONSTRAINT `open_mabar_day_detail_ibfk_2` FOREIGN KEY (`player_id`) REFERENCES `player` (`id`),
  ADD CONSTRAINT `open_mabar_day_detail_ibfk_3` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `open_mabar_day_recap`
--
ALTER TABLE `open_mabar_day_recap`
  ADD CONSTRAINT `open_mabar_day_recap_ibfk_1` FOREIGN KEY (`open_mabar_day_id`) REFERENCES `open_mabar_day` (`id`),
  ADD CONSTRAINT `open_mabar_day_recap_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `open_mabar_match`
--
ALTER TABLE `open_mabar_match`
  ADD CONSTRAINT `open_mabar_match_ibfk_1` FOREIGN KEY (`open_mabar_day_id`) REFERENCES `open_mabar_day` (`id`),
  ADD CONSTRAINT `open_mabar_match_ibfk_2` FOREIGN KEY (`court_id`) REFERENCES `court` (`id`),
  ADD CONSTRAINT `open_mabar_match_ibfk_3` FOREIGN KEY (`player_id_a1`) REFERENCES `player` (`id`),
  ADD CONSTRAINT `open_mabar_match_ibfk_4` FOREIGN KEY (`player_id_a2`) REFERENCES `player` (`id`),
  ADD CONSTRAINT `open_mabar_match_ibfk_5` FOREIGN KEY (`player_id_b1`) REFERENCES `player` (`id`),
  ADD CONSTRAINT `open_mabar_match_ibfk_6` FOREIGN KEY (`player_id_b2`) REFERENCES `player` (`id`),
  ADD CONSTRAINT `open_mabar_match_ibfk_7` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `open_mabar_player`
--
ALTER TABLE `open_mabar_player`
  ADD CONSTRAINT `open_mabar_player_ibfk_1` FOREIGN KEY (`open_mabar_id`) REFERENCES `open_mabar` (`id`),
  ADD CONSTRAINT `open_mabar_player_ibfk_2` FOREIGN KEY (`player_id`) REFERENCES `player` (`id`),
  ADD CONSTRAINT `open_mabar_player_ibfk_3` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `player`
--
ALTER TABLE `player`
  ADD CONSTRAINT `player_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `revokedtokens`
--
ALTER TABLE `revokedtokens`
  ADD CONSTRAINT `revokedtokens_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `service_log`
--
ALTER TABLE `service_log`
  ADD CONSTRAINT `service_log_ibfk_1` FOREIGN KEY (`customer_service_id`) REFERENCES `customer_services` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `service_order`
--
ALTER TABLE `service_order`
  ADD CONSTRAINT `service_order_ibfk_1` FOREIGN KEY (`customer_service_id`) REFERENCES `customer_services` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `taxo`
--
ALTER TABLE `taxo`
  ADD CONSTRAINT `taxo_ibfk_1` FOREIGN KEY (`template_id`) REFERENCES `invoice_template` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_ibfk_1` FOREIGN KEY (`community_id`) REFERENCES `community` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
