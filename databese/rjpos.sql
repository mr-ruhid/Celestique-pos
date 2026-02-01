-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Feb 01, 2026 at 08:11 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `rjpos`
--

-- --------------------------------------------------------

--
-- Table structure for table `cache`
--

CREATE TABLE `cache` (
  `key` varchar(255) NOT NULL,
  `value` mediumtext NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cache_locks`
--

CREATE TABLE `cache_locks` (
  `key` varchar(255) NOT NULL,
  `owner` varchar(255) NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cash_registers`
--

CREATE TABLE `cash_registers` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `code` varchar(255) NOT NULL,
  `ip_address` varchar(255) DEFAULT NULL,
  `balance` decimal(10,2) NOT NULL DEFAULT 0.00,
  `status` enum('open','closed') NOT NULL DEFAULT 'closed',
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `cash_registers`
--

INSERT INTO `cash_registers` (`id`, `name`, `code`, `ip_address`, `balance`, `status`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 'Kassa 1', 'pos-1', NULL, 0.00, 'closed', 1, '2026-01-28 10:08:56', '2026-01-29 10:44:33');

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `slug` varchar(255) DEFAULT NULL,
  `image` text DEFAULT NULL,
  `parent_id` bigint(20) UNSIGNED DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `jobs`
--

CREATE TABLE `jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `queue` varchar(255) NOT NULL,
  `payload` longtext NOT NULL,
  `attempts` tinyint(3) UNSIGNED NOT NULL,
  `reserved_at` int(10) UNSIGNED DEFAULT NULL,
  `available_at` int(10) UNSIGNED NOT NULL,
  `created_at` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `job_batches`
--

CREATE TABLE `job_batches` (
  `id` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `total_jobs` int(11) NOT NULL,
  `pending_jobs` int(11) NOT NULL,
  `failed_jobs` int(11) NOT NULL,
  `failed_job_ids` longtext NOT NULL,
  `options` mediumtext DEFAULT NULL,
  `cancelled_at` int(11) DEFAULT NULL,
  `created_at` int(11) NOT NULL,
  `finished_at` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '0001_01_01_000000_create_users_table', 1),
(2, '0001_01_01_000001_create_cache_table', 1),
(3, '0001_01_01_000002_create_jobs_table', 1),
(4, '2026_01_28_081305_create_telegram_partners_table', 2),
(5, '2026_01_28_085606_create_roles_table', 3),
(6, '2026_01_28_085624_add_role_id_to_users_table', 4),
(7, '2026_01_28_092736_create_categories_table', 5),
(8, '2026_01_28_090000_create_products_table', 6),
(9, '2026_01_28_092745_add_category_id_to_products_table', 6),
(10, '2026_01_28_094922_create_taxes_table', 7),
(11, '2026_01_28_110041_create_product_batches_table', 8),
(12, '2026_01_28_114225_alert_limit', 9),
(13, '2026_01_28_132449_create_product_discounts_table', 10),
(14, '2026_01_28_133209_create_cash_registers_table', 11),
(15, '2026_01_28_135742_create_orders_table', 12),
(16, '2026_01_28_142000_create_new_table', 13),
(17, '2026_01_29_083917_qaytarama_mentiqi', 14),
(18, '2026_01_29_085652_lotoreya_table', 15),
(19, '2026_01_29_104625_hediyye_situnu', 16),
(20, '2026_01_29_111738_promo_system_setup', 17),
(21, '2026_01_29_144839_create_payment_methods_table', 18),
(22, '2026_01_30_105910_add_location_to_product_batches', 19),
(23, '2026_01_30_111332_add_location_to_product_batches', 19);

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id` char(36) NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `cash_register_id` bigint(20) UNSIGNED DEFAULT NULL,
  `receipt_code` varchar(255) NOT NULL,
  `lottery_code` varchar(255) DEFAULT NULL,
  `promo_code` varchar(255) DEFAULT NULL,
  `promocode_id` bigint(20) UNSIGNED DEFAULT NULL,
  `subtotal` decimal(10,2) NOT NULL,
  `total_discount` decimal(10,2) NOT NULL DEFAULT 0.00,
  `total_tax` decimal(10,2) NOT NULL DEFAULT 0.00,
  `grand_total` decimal(10,2) NOT NULL,
  `refunded_amount` decimal(10,2) NOT NULL DEFAULT 0.00,
  `total_cost` decimal(10,2) NOT NULL DEFAULT 0.00,
  `total_commission` decimal(10,2) NOT NULL DEFAULT 0.00,
  `paid_amount` decimal(10,2) NOT NULL,
  `change_amount` decimal(10,2) NOT NULL DEFAULT 0.00,
  `payment_method` varchar(255) NOT NULL DEFAULT 'cash',
  `status` enum('completed','refunded','cancelled') NOT NULL DEFAULT 'completed',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`id`, `user_id`, `cash_register_id`, `receipt_code`, `lottery_code`, `promo_code`, `promocode_id`, `subtotal`, `total_discount`, `total_tax`, `grand_total`, `refunded_amount`, `total_cost`, `total_commission`, `paid_amount`, `change_amount`, `payment_method`, `status`, `created_at`, `updated_at`) VALUES
('019c04ef-1bd3-724c-ac99-595ad4d8fce1', 1, NULL, 'YELOMZ7U', NULL, NULL, NULL, 100.00, 33.44, 0.00, 66.56, 0.00, 50.00, 0.00, 66.56, 0.00, 'cash', 'completed', '2026-01-28 10:08:25', '2026-01-28 10:08:25'),
('019c04fc-c6e9-7025-ae22-fa5f7be3fd68', 1, NULL, 'E0C3DXVT', NULL, NULL, NULL, 100.00, 33.44, 0.00, 66.56, 0.00, 50.00, 0.00, 66.56, 0.00, 'cash', 'completed', '2026-01-28 10:23:20', '2026-01-28 10:23:20'),
('019c090d-dbf0-73a3-b4f0-5f8d1be52ef6', 1, NULL, 'DMX3DLZW', NULL, NULL, NULL, 100.00, 33.44, 0.00, 66.56, 66.56, 50.00, 0.00, 66.56, 0.00, 'cash', 'refunded', '2026-01-29 05:20:29', '2026-01-29 05:21:05'),
('019c0911-ef0e-73ca-b0f6-eb9f802fb7c1', 1, NULL, '5OY1F1BV', NULL, NULL, NULL, 100.00, 33.44, 0.00, 66.56, 0.00, 50.00, 0.00, 66.56, 0.00, 'cash', 'completed', '2026-01-29 05:24:56', '2026-01-29 05:24:56'),
('019c0914-1804-72cf-b5b5-0b91e38117c5', 1, NULL, 'F1MYCFWQ', NULL, NULL, NULL, 100.00, 33.44, 0.00, 66.56, 0.00, 50.00, 0.00, 66.56, 0.00, 'cash', 'completed', '2026-01-29 05:27:17', '2026-01-29 05:27:17'),
('019c091b-05a3-7373-88ee-d069f1b3e13b', 1, NULL, 'ZF395SV4', NULL, NULL, NULL, 100.00, 33.44, 0.00, 66.56, 0.00, 50.00, 0.00, 66.56, 0.00, 'cash', 'completed', '2026-01-29 05:34:51', '2026-01-29 05:34:51'),
('019c091d-699c-738b-87ea-2ac37299d6c1', 1, NULL, 'MPJ4MEP6', NULL, NULL, NULL, 100.00, 33.44, 0.00, 66.56, 0.00, 50.00, 0.00, 66.56, 0.00, 'cash', 'completed', '2026-01-29 05:37:28', '2026-01-29 05:37:28'),
('019c092c-9f1a-7089-ae2a-484a3dbf851b', 1, NULL, 'YKT8IGQA', NULL, NULL, NULL, 100.00, 33.44, 0.00, 66.56, 0.00, 50.00, 0.00, 66.56, 0.00, 'cash', 'completed', '2026-01-29 05:54:05', '2026-01-29 05:54:05'),
('019c0936-6d83-73e0-9c32-0c5347b13fc3', 1, NULL, 'KIETDZ6C', NULL, NULL, NULL, 100.00, 33.44, 0.00, 66.56, 0.00, 50.00, 0.00, 66.56, 0.00, 'card', 'completed', '2026-01-29 06:04:47', '2026-01-29 06:04:47'),
('019c093b-ebba-7374-a06f-2d3f32923a6b', 1, NULL, 'IDTDLQXU', NULL, NULL, NULL, 100.00, 33.44, 0.00, 66.56, 0.00, 50.00, 0.00, 66.56, 0.00, 'cash', 'completed', '2026-01-29 06:10:47', '2026-01-29 06:10:47'),
('019c093f-3767-7354-b258-f1d292f762e8', 1, NULL, 'PQGWUTXV', 'RJ-9DQM-9653', NULL, NULL, 100.00, 33.44, 0.00, 66.56, 0.00, 50.00, 0.00, 66.56, 0.00, 'cash', 'completed', '2026-01-29 06:14:23', '2026-01-29 06:14:23'),
('019c0943-0cad-730c-b408-7bae883c393a', 1, NULL, 'H82ETPNN', 'RJ-FJ9K-1388', NULL, NULL, 100.00, 33.44, 0.00, 66.56, 0.00, 50.00, 0.00, 66.56, 0.00, 'cash', 'completed', '2026-01-29 06:18:35', '2026-01-29 06:18:35'),
('019c0950-b4a9-72c9-a095-a54834302b33', 1, NULL, 'IB41I1WY', '5536', NULL, NULL, 100.00, 33.44, 0.00, 66.56, 0.00, 50.00, 0.00, 66.56, 0.00, 'cash', 'completed', '2026-01-29 06:33:30', '2026-01-29 06:33:30'),
('019c0967-0a96-72c4-92a0-fc10fbda744d', 1, NULL, 'Y9DWXZLX', '2776', NULL, NULL, 0.00, 0.00, 0.00, 0.00, 0.00, 50.00, 0.00, 0.00, 0.00, 'cash', 'completed', '2026-01-29 06:57:53', '2026-01-29 06:57:53'),
('019c0e9c-50aa-702c-b953-88b6046f583c', 1, NULL, 'MCAJCP8M', '2113', NULL, NULL, 100.00, 33.44, 0.00, 66.56, 0.00, 50.00, 0.00, 66.56, 0.00, 'cash', 'completed', '2026-01-30 07:14:11', '2026-01-30 07:14:11'),
('019c0e9d-78a2-703a-bf42-74536421214e', 1, NULL, 'W3WFPM6K', '2162', NULL, NULL, 100.00, 33.44, 0.00, 66.56, 0.00, 50.00, 0.00, 66.56, 0.00, 'cash', 'completed', '2026-01-30 07:15:27', '2026-01-30 07:15:27'),
('019c0e9d-bae0-7207-b254-b5b2b4e2bd0b', 1, NULL, 'PRATBNMQ', '1012', NULL, NULL, 100.00, 33.44, 0.00, 66.56, 0.00, 50.00, 0.00, 66.56, 0.00, 'cash', 'completed', '2026-01-30 07:15:43', '2026-01-30 07:15:43'),
('019c0eba-2dab-73f5-8e1e-ec3e4c545b45', 1, NULL, 'QE0YU9QB', '1032', NULL, NULL, 100.00, 33.44, 0.00, 66.56, 0.00, 50.00, 0.00, 66.56, 0.00, 'cash', 'completed', '2026-01-30 07:46:48', '2026-01-30 07:46:48'),
('019c0ebd-93f8-7181-b6a2-6abd876382c1', 1, NULL, '0VJIMT7F', '7049', NULL, NULL, 100.00, 33.44, 0.00, 66.56, 0.00, 50.00, 0.00, 66.56, 0.00, 'cash', 'completed', '2026-01-30 07:50:31', '2026-01-30 07:50:31'),
('019c0ebe-db98-73f0-bc86-0700ab06c7d1', 1, NULL, 'HSP31Q2V', '9737', NULL, NULL, 100.00, 33.44, 0.00, 66.56, 0.00, 50.00, 0.00, 66.56, 0.00, 'cash', 'completed', '2026-01-30 07:51:55', '2026-01-30 07:51:55'),
('019c0ebf-e1a2-727c-8bef-efceb8faa9f8', 1, NULL, 'NJ6LUTXJ', '5528', NULL, NULL, 100.00, 33.44, 0.00, 66.56, 0.00, 50.00, 0.00, 66.56, 0.00, 'cash', 'completed', '2026-01-30 07:53:02', '2026-01-30 07:53:02'),
('019c0ec1-d30f-7189-a308-1d86c4df6ad8', 1, NULL, 'S76FGGO9', '7797', NULL, NULL, 100.00, 33.44, 0.00, 66.56, 0.00, 50.00, 0.00, 66.56, 0.00, 'cash', 'completed', '2026-01-30 07:55:09', '2026-01-30 07:55:09'),
('019c0ec5-6938-7284-b68d-c37093adbe69', 1, NULL, 'WIMBKZG0', '4863', NULL, NULL, 100.00, 33.44, 0.00, 66.56, 0.00, 50.00, 0.00, 66.56, 0.00, 'cash', 'completed', '2026-01-30 07:59:04', '2026-01-30 07:59:04'),
('019c0ec9-0ad1-727f-bfed-b2072a2b9b54', 1, NULL, 'CZEODWPO', '7175', NULL, NULL, 100.00, 33.44, 10.15, 66.56, 0.00, 50.00, 0.00, 66.56, 0.00, 'cash', 'completed', '2026-01-30 08:03:02', '2026-01-30 08:03:02'),
('019c0ecb-a7cf-7269-bc9e-4376a4a6b08c', 1, NULL, 'RFUIIK8G', '8167', NULL, NULL, 100.00, 33.44, 9.00, 66.56, 0.00, 50.00, 0.00, 66.56, 0.00, 'cash', 'completed', '2026-01-30 08:05:53', '2026-01-30 08:05:53'),
('019c0ecc-3504-7343-8303-47f7f2412f9f', 1, NULL, '8WDWRMQR', '8194', NULL, NULL, 100.00, 33.44, 9.00, 66.56, 0.00, 50.00, 0.00, 66.56, 0.00, 'cash', 'completed', '2026-01-30 08:06:29', '2026-01-30 08:06:29');

-- --------------------------------------------------------

--
-- Table structure for table `order_items`
--

CREATE TABLE `order_items` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `order_id` char(36) NOT NULL,
  `product_id` char(36) NOT NULL,
  `product_name` varchar(255) NOT NULL,
  `product_barcode` varchar(255) NOT NULL,
  `quantity` int(11) NOT NULL,
  `is_gift` tinyint(1) NOT NULL DEFAULT 0,
  `returned_quantity` int(11) NOT NULL DEFAULT 0,
  `price` decimal(10,2) NOT NULL,
  `cost` decimal(10,2) NOT NULL,
  `tax_amount` decimal(10,2) NOT NULL DEFAULT 0.00,
  `discount_amount` decimal(10,2) NOT NULL DEFAULT 0.00,
  `total` decimal(10,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `order_items`
--

INSERT INTO `order_items` (`id`, `order_id`, `product_id`, `product_name`, `product_barcode`, `quantity`, `is_gift`, `returned_quantity`, `price`, `cost`, `tax_amount`, `discount_amount`, `total`, `created_at`, `updated_at`) VALUES
(1, '019c04ef-1bd3-724c-ac99-595ad4d8fce1', '019c0461-9bd3-7225-8d1f-96ed54fef8cd', 'demo', '1', 1, 0, 0, 100.00, 50.00, 0.00, 33.44, 66.56, '2026-01-28 10:08:25', '2026-01-28 10:08:25'),
(2, '019c04fc-c6e9-7025-ae22-fa5f7be3fd68', '019c0461-9bd3-7225-8d1f-96ed54fef8cd', 'demo', '1', 1, 0, 0, 100.00, 50.00, 0.00, 33.44, 66.56, '2026-01-28 10:23:20', '2026-01-28 10:23:20'),
(3, '019c090d-dbf0-73a3-b4f0-5f8d1be52ef6', '019c0461-9bd3-7225-8d1f-96ed54fef8cd', 'demo', '1', 1, 0, 1, 100.00, 50.00, 0.00, 33.44, 66.56, '2026-01-29 05:20:29', '2026-01-29 05:21:05'),
(4, '019c0911-ef0e-73ca-b0f6-eb9f802fb7c1', '019c0461-9bd3-7225-8d1f-96ed54fef8cd', 'demo', '1', 1, 0, 0, 100.00, 50.00, 0.00, 33.44, 66.56, '2026-01-29 05:24:56', '2026-01-29 05:24:56'),
(5, '019c0914-1804-72cf-b5b5-0b91e38117c5', '019c0461-9bd3-7225-8d1f-96ed54fef8cd', 'demo', '1', 1, 0, 0, 100.00, 50.00, 0.00, 33.44, 66.56, '2026-01-29 05:27:17', '2026-01-29 05:27:17'),
(6, '019c091b-05a3-7373-88ee-d069f1b3e13b', '019c0461-9bd3-7225-8d1f-96ed54fef8cd', 'demo', '1', 1, 0, 0, 100.00, 50.00, 0.00, 33.44, 66.56, '2026-01-29 05:34:51', '2026-01-29 05:34:51'),
(7, '019c091d-699c-738b-87ea-2ac37299d6c1', '019c0461-9bd3-7225-8d1f-96ed54fef8cd', 'demo', '1', 1, 0, 0, 100.00, 50.00, 0.00, 33.44, 66.56, '2026-01-29 05:37:28', '2026-01-29 05:37:28'),
(8, '019c092c-9f1a-7089-ae2a-484a3dbf851b', '019c0461-9bd3-7225-8d1f-96ed54fef8cd', 'demo', '1', 1, 0, 0, 100.00, 50.00, 0.00, 33.44, 66.56, '2026-01-29 05:54:05', '2026-01-29 05:54:05'),
(9, '019c0936-6d83-73e0-9c32-0c5347b13fc3', '019c0461-9bd3-7225-8d1f-96ed54fef8cd', 'demo', '1', 1, 0, 0, 100.00, 50.00, 0.00, 33.44, 66.56, '2026-01-29 06:04:47', '2026-01-29 06:04:47'),
(10, '019c093b-ebba-7374-a06f-2d3f32923a6b', '019c0461-9bd3-7225-8d1f-96ed54fef8cd', 'demo', '1', 1, 0, 0, 100.00, 50.00, 0.00, 33.44, 66.56, '2026-01-29 06:10:47', '2026-01-29 06:10:47'),
(11, '019c093f-3767-7354-b258-f1d292f762e8', '019c0461-9bd3-7225-8d1f-96ed54fef8cd', 'demo', '1', 1, 0, 0, 100.00, 50.00, 0.00, 33.44, 66.56, '2026-01-29 06:14:23', '2026-01-29 06:14:23'),
(12, '019c0943-0cad-730c-b408-7bae883c393a', '019c0461-9bd3-7225-8d1f-96ed54fef8cd', 'demo', '1', 1, 0, 0, 100.00, 50.00, 0.00, 33.44, 66.56, '2026-01-29 06:18:35', '2026-01-29 06:18:35'),
(13, '019c0950-b4a9-72c9-a095-a54834302b33', '019c0461-9bd3-7225-8d1f-96ed54fef8cd', 'demo', '1', 1, 0, 0, 100.00, 50.00, 0.00, 33.44, 66.56, '2026-01-29 06:33:30', '2026-01-29 06:33:30'),
(14, '019c0967-0a96-72c4-92a0-fc10fbda744d', '019c0461-9bd3-7225-8d1f-96ed54fef8cd', 'demo', '1', 1, 0, 0, 0.00, 50.00, 0.00, 0.00, 0.00, '2026-01-29 06:57:53', '2026-01-29 06:57:53'),
(15, '019c0e9c-50aa-702c-b953-88b6046f583c', '019c0461-9bd3-7225-8d1f-96ed54fef8cd', 'demo', '1', 1, 0, 0, 100.00, 50.00, 0.00, 33.44, 66.56, '2026-01-30 07:14:11', '2026-01-30 07:14:11'),
(16, '019c0e9d-78a2-703a-bf42-74536421214e', '019c0461-9bd3-7225-8d1f-96ed54fef8cd', 'demo', '1', 1, 0, 0, 100.00, 50.00, 0.00, 33.44, 66.56, '2026-01-30 07:15:27', '2026-01-30 07:15:27'),
(17, '019c0e9d-bae0-7207-b254-b5b2b4e2bd0b', '019c0461-9bd3-7225-8d1f-96ed54fef8cd', 'demo', '1', 1, 0, 0, 100.00, 50.00, 0.00, 33.44, 66.56, '2026-01-30 07:15:43', '2026-01-30 07:15:43'),
(18, '019c0eba-2dab-73f5-8e1e-ec3e4c545b45', '019c0461-9bd3-7225-8d1f-96ed54fef8cd', 'demo', '1', 1, 0, 0, 100.00, 50.00, 0.00, 33.44, 66.56, '2026-01-30 07:46:48', '2026-01-30 07:46:48'),
(19, '019c0ebd-93f8-7181-b6a2-6abd876382c1', '019c0461-9bd3-7225-8d1f-96ed54fef8cd', 'demo', '1', 1, 0, 0, 100.00, 50.00, 0.00, 33.44, 66.56, '2026-01-30 07:50:31', '2026-01-30 07:50:31'),
(20, '019c0ebe-db98-73f0-bc86-0700ab06c7d1', '019c0461-9bd3-7225-8d1f-96ed54fef8cd', 'demo', '1', 1, 0, 0, 100.00, 50.00, 0.00, 33.44, 66.56, '2026-01-30 07:51:55', '2026-01-30 07:51:55'),
(21, '019c0ebf-e1a2-727c-8bef-efceb8faa9f8', '019c0461-9bd3-7225-8d1f-96ed54fef8cd', 'demo', '1', 1, 0, 0, 100.00, 50.00, 0.00, 33.44, 66.56, '2026-01-30 07:53:02', '2026-01-30 07:53:02'),
(22, '019c0ec1-d30f-7189-a308-1d86c4df6ad8', '019c0461-9bd3-7225-8d1f-96ed54fef8cd', 'demo', '1', 1, 0, 0, 100.00, 50.00, 0.00, 33.44, 66.56, '2026-01-30 07:55:09', '2026-01-30 07:55:09'),
(23, '019c0ec5-6938-7284-b68d-c37093adbe69', '019c0461-9bd3-7225-8d1f-96ed54fef8cd', 'demo', '1', 1, 0, 0, 100.00, 50.00, 0.00, 33.44, 66.56, '2026-01-30 07:59:04', '2026-01-30 07:59:04'),
(24, '019c0ec9-0ad1-727f-bfed-b2072a2b9b54', '019c0461-9bd3-7225-8d1f-96ed54fef8cd', 'demo', '1', 1, 0, 0, 100.00, 50.00, 10.15, 33.44, 66.56, '2026-01-30 08:03:02', '2026-01-30 08:03:02'),
(25, '019c0ecb-a7cf-7269-bc9e-4376a4a6b08c', '019c0461-9bd3-7225-8d1f-96ed54fef8cd', 'demo', '1', 1, 0, 0, 100.00, 50.00, 9.00, 33.44, 66.56, '2026-01-30 08:05:53', '2026-01-30 08:05:53'),
(26, '019c0ecc-3504-7343-8303-47f7f2412f9f', '019c0461-9bd3-7225-8d1f-96ed54fef8cd', 'demo', '1', 1, 0, 0, 100.00, 50.00, 9.00, 33.44, 66.56, '2026-01-30 08:06:29', '2026-01-30 08:06:29');

-- --------------------------------------------------------

--
-- Table structure for table `partners`
--

CREATE TABLE `partners` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `telegram_chat_id` varchar(255) DEFAULT NULL,
  `balance` decimal(10,2) NOT NULL DEFAULT 0.00,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `payment_methods`
--

CREATE TABLE `payment_methods` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `type` enum('cash','card','other') NOT NULL DEFAULT 'card',
  `is_integrated` tinyint(1) NOT NULL DEFAULT 0,
  `driver_name` varchar(255) DEFAULT NULL,
  `settings` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`settings`)),
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `payment_methods`
--

INSERT INTO `payment_methods` (`id`, `name`, `slug`, `type`, `is_integrated`, `driver_name`, `settings`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 'Nəğd', 'cash', 'cash', 0, NULL, NULL, 1, '2026-01-29 10:49:04', '2026-01-29 10:49:04'),
(2, 'Bank Kartı (Terminal)', 'card', 'card', 0, NULL, NULL, 1, '2026-01-29 10:49:04', '2026-01-29 10:49:04');

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` char(36) NOT NULL,
  `name` varchar(255) NOT NULL,
  `barcode` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `category_id` bigint(20) UNSIGNED DEFAULT NULL,
  `cost_price` decimal(10,2) NOT NULL,
  `selling_price` decimal(10,2) NOT NULL,
  `tax_rate` decimal(5,2) NOT NULL DEFAULT 0.00,
  `alert_limit` int(11) NOT NULL DEFAULT 5,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `last_synced_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `name`, `barcode`, `description`, `image`, `category_id`, `cost_price`, `selling_price`, `tax_rate`, `alert_limit`, `is_active`, `last_synced_at`, `created_at`, `updated_at`, `deleted_at`) VALUES
('019c0461-9bd3-7225-8d1f-96ed54fef8cd', 'demo', '1', NULL, NULL, NULL, 0.00, 100.00, 0.00, 5, 1, NULL, '2026-01-28 07:33:51', '2026-01-28 07:33:51', NULL),
('019c0464-a94c-7018-913d-f0e45a83467c', 'test 2', '2', NULL, NULL, NULL, 0.00, 100.00, 0.00, 5, 1, NULL, '2026-01-28 07:37:11', '2026-01-28 07:37:11', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `product_batches`
--

CREATE TABLE `product_batches` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `product_id` char(36) NOT NULL,
  `cost_price` decimal(10,2) NOT NULL,
  `initial_quantity` int(11) NOT NULL,
  `current_quantity` int(11) NOT NULL,
  `location` varchar(255) NOT NULL DEFAULT 'store',
  `batch_code` varchar(255) DEFAULT NULL,
  `expiration_date` date DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `product_batches`
--

INSERT INTO `product_batches` (`id`, `product_id`, `cost_price`, `initial_quantity`, `current_quantity`, `location`, `batch_code`, `expiration_date`, `created_at`, `updated_at`) VALUES
(5, '019c0461-9bd3-7225-8d1f-96ed54fef8cd', 50.00, 54, 0, 'store', 'Qeyri-rəsmi (0.00%) | LOC:warehouse', NULL, '2026-01-28 08:15:42', '2026-01-29 05:24:56'),
(6, '019c0461-9bd3-7225-8d1f-96ed54fef8cd', 50.00, 44, 10, 'warehouse', 'Standart (18.00%) | LOC:warehouse', NULL, '2026-01-28 08:15:42', '2026-01-30 07:49:07'),
(7, '019c0461-9bd3-7225-8d1f-96ed54fef8cd', 50.00, 44, 45, 'warehouse', 'Standart (18.00%) | LOC:warehouse', NULL, '2026-01-28 08:15:42', '2026-01-30 07:48:28'),
(8, '019c0461-9bd3-7225-8d1f-96ed54fef8cd', 50.00, 55, 105, 'warehouse', 'Qeyri-rəsmi (0.00%) | LOC:warehouse', NULL, '2026-01-28 08:15:42', '2026-01-30 07:48:34'),
(9, '019c0461-9bd3-7225-8d1f-96ed54fef8cd', 50.00, 20, 20, 'warehouse', 'Standart (18.00%) | LOC:warehouse', NULL, '2026-01-30 07:19:00', '2026-01-30 07:48:47'),
(10, '019c0461-9bd3-7225-8d1f-96ed54fef8cd', 50.00, 20, 12, 'store', 'Standart (18.00%) | LOC:store', NULL, '2026-01-30 07:49:07', '2026-01-30 08:06:29');

-- --------------------------------------------------------

--
-- Table structure for table `product_discounts`
--

CREATE TABLE `product_discounts` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `product_id` char(36) NOT NULL,
  `type` enum('fixed','percent') NOT NULL DEFAULT 'fixed',
  `value` decimal(10,2) NOT NULL,
  `start_date` datetime NOT NULL,
  `end_date` datetime NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `product_discounts`
--

INSERT INTO `product_discounts` (`id`, `product_id`, `type`, `value`, `start_date`, `end_date`, `is_active`, `created_at`, `updated_at`) VALUES
(1, '019c0461-9bd3-7225-8d1f-96ed54fef8cd', 'percent', 10.00, '2026-01-28 17:45:00', '2026-01-31 17:45:00', 0, '2026-01-28 09:45:33', '2026-01-28 09:46:01'),
(2, '019c0461-9bd3-7225-8d1f-96ed54fef8cd', 'percent', 20.00, '2026-01-28 17:45:00', '2026-01-31 17:45:00', 0, '2026-01-28 09:46:01', '2026-01-28 09:46:37'),
(3, '019c0461-9bd3-7225-8d1f-96ed54fef8cd', 'fixed', 0.00, '2026-01-28 16:46:00', '2026-01-31 17:46:00', 0, '2026-01-28 09:46:37', '2026-01-28 09:47:04'),
(4, '019c0461-9bd3-7225-8d1f-96ed54fef8cd', 'fixed', 5.00, '2026-01-28 17:46:00', '2026-01-28 13:55:51', 0, '2026-01-28 09:47:04', '2026-01-28 09:55:51'),
(5, '019c0461-9bd3-7225-8d1f-96ed54fef8cd', 'fixed', 0.00, '2026-01-28 18:05:00', '2026-01-28 14:06:04', 0, '2026-01-28 10:05:58', '2026-01-28 10:06:04'),
(6, '019c0461-9bd3-7225-8d1f-96ed54fef8cd', 'fixed', 0.00, '2026-01-27 18:06:00', '2026-01-28 14:06:15', 0, '2026-01-28 10:06:11', '2026-01-28 10:06:15'),
(7, '019c0461-9bd3-7225-8d1f-96ed54fef8cd', 'percent', 33.44, '2026-01-27 18:06:00', '2026-01-31 18:06:00', 1, '2026-01-28 10:06:31', '2026-01-28 10:06:31');

-- --------------------------------------------------------

--
-- Table structure for table `promocodes`
--

CREATE TABLE `promocodes` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `code` varchar(255) NOT NULL,
  `type` enum('store','partner') NOT NULL DEFAULT 'store',
  `partner_id` bigint(20) UNSIGNED DEFAULT NULL,
  `discount_type` enum('fixed','percent') NOT NULL DEFAULT 'percent',
  `discount_value` decimal(10,2) NOT NULL,
  `commission_type` enum('fixed','percent') NOT NULL DEFAULT 'percent',
  `commission_value` decimal(10,2) NOT NULL DEFAULT 0.00,
  `usage_limit` int(11) DEFAULT NULL,
  `used_count` int(11) NOT NULL DEFAULT 0,
  `expires_at` datetime DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `promocodes`
--

INSERT INTO `promocodes` (`id`, `code`, `type`, `partner_id`, `discount_type`, `discount_value`, `commission_type`, `commission_value`, `usage_limit`, `used_count`, `expires_at`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 'YAY20', 'store', NULL, 'percent', 10.00, 'percent', 0.00, 1000, 0, '2026-01-31 00:00:00', 1, '2026-01-29 08:04:50', '2026-01-29 08:04:50');

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `permissions` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id`, `name`, `slug`, `permissions`, `created_at`, `updated_at`) VALUES
(1, 'Super Admin', 'super_admin', '{\"all\":true}', '2026-01-28 05:05:52', '2026-01-28 05:05:52'),
(2, 'Mağaza Müdiri (Admin)', 'admin', '{\"products.create\":true,\"products.edit\":true,\"products.delete\":true,\"reports.view\":true,\"discounts.manage\":true,\"users.manage\":false}', '2026-01-28 05:05:52', '2026-01-28 05:05:52'),
(3, 'Kassir', 'kassa', '{\"pos.access\":true,\"sales.create\":true,\"returns.create\":true,\"reports.view\":false}', '2026-01-28 05:05:52', '2026-01-28 05:05:52'),
(4, 'Anbardar', 'anbar', '{\"stock.view\":true,\"stock.manage\":true,\"pos.access\":false}', '2026-01-28 05:05:52', '2026-01-28 05:05:52');

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(255) NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `payload` longtext NOT NULL,
  `last_activity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sessions`
--

INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
('rNSiLiECL2wLAbRkjwExL6o8Nxw8EkFdV9L5wAcx', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiMnZoTWREelFXTkZOaTBlTkhCN2p5ZnhLVENmUjRCVGtmMEJjTU1DaCI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MzU6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9zeXN0ZW0vc2VydmVyIjtzOjU6InJvdXRlIjtzOjE1OiJzZXR0aW5ncy5zZXJ2ZXIiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1769774960);

-- --------------------------------------------------------

--
-- Table structure for table `settings`
--

CREATE TABLE `settings` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `key` varchar(255) NOT NULL,
  `value` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `settings`
--

INSERT INTO `settings` (`id`, `key`, `value`, `created_at`, `updated_at`) VALUES
(1, 'store_name', 'RJ POS Market', '2026-01-28 10:20:13', '2026-01-28 10:20:13'),
(2, 'store_address', 'Bakı şəhəri, Mərkəz küçəsi 1', '2026-01-28 10:20:13', '2026-01-28 10:20:13'),
(3, 'store_phone', '+994 50 000 00 00', '2026-01-28 10:20:13', '2026-01-28 10:20:13'),
(4, 'receipt_footer', 'Bizi seçdiyiniz üçün təşəkkürlər!', '2026-01-28 10:20:13', '2026-01-28 10:20:13'),
(5, 'store_voen', '3222222222222', '2026-01-29 05:36:00', '2026-01-29 05:36:00'),
(6, 'object_code', '323323', '2026-01-29 05:36:00', '2026-01-29 05:36:00'),
(7, 'receipt_header', 'Yaşa Azərbaycan', '2026-01-29 05:36:00', '2026-01-29 05:36:00'),
(8, 'telegram_bot_token', '', '2026-01-29 07:39:18', '2026-01-29 07:39:18'),
(9, 'telegram_admin_id', NULL, '2026-01-29 07:39:18', '2026-01-29 07:39:18'),
(10, 'server_api_key', '', '2026-01-29 08:43:06', '2026-01-29 08:43:06'),
(11, 'system_mode', 'server', '2026-01-29 09:29:30', '2026-01-29 09:52:30'),
(12, 'server_url', NULL, '2026-01-29 09:29:30', '2026-01-29 09:35:39'),
(13, 'client_api_key', NULL, '2026-01-29 09:29:30', '2026-01-29 09:35:39');

-- --------------------------------------------------------

--
-- Table structure for table `taxes`
--

CREATE TABLE `taxes` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `rate` decimal(5,2) NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `taxes`
--

INSERT INTO `taxes` (`id`, `name`, `rate`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 'Standart', 18.00, 1, '2026-01-28 06:03:17', '2026-01-28 06:03:17'),
(2, 'Qeyri-rəsmi', 0.00, 1, '2026-01-28 06:03:35', '2026-01-28 06:03:35');

-- --------------------------------------------------------

--
-- Table structure for table `telegram_partners`
--

CREATE TABLE `telegram_partners` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `telegram_chat_id` varchar(255) DEFAULT NULL,
  `promo_code` varchar(255) DEFAULT NULL,
  `commission_percent` decimal(5,2) NOT NULL DEFAULT 0.00,
  `discount_percent` decimal(5,2) NOT NULL DEFAULT 0.00,
  `balance` decimal(10,2) NOT NULL DEFAULT 0.00,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `role_id` bigint(20) UNSIGNED DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `role_id`, `name`, `email`, `is_active`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 1, 'Baş Admin', 'admin@rjpos.com', 1, NULL, '$2y$10$N1lcvFEHX3NX6xcTluGVde0cGSoCJK/30fKCqHyix5N.vSIX9AJjm', NULL, '2026-01-28 05:15:51', '2026-01-28 05:15:51');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cache`
--
ALTER TABLE `cache`
  ADD PRIMARY KEY (`key`),
  ADD KEY `cache_expiration_index` (`expiration`);

--
-- Indexes for table `cache_locks`
--
ALTER TABLE `cache_locks`
  ADD PRIMARY KEY (`key`),
  ADD KEY `cache_locks_expiration_index` (`expiration`);

--
-- Indexes for table `cash_registers`
--
ALTER TABLE `cash_registers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `cash_registers_code_unique` (`code`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`),
  ADD KEY `categories_parent_id_foreign` (`parent_id`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jobs_queue_index` (`queue`);

--
-- Indexes for table `job_batches`
--
ALTER TABLE `job_batches`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `orders_receipt_code_unique` (`receipt_code`),
  ADD UNIQUE KEY `orders_lottery_code_unique` (`lottery_code`),
  ADD KEY `orders_user_id_foreign` (`user_id`),
  ADD KEY `orders_cash_register_id_foreign` (`cash_register_id`),
  ADD KEY `orders_promocode_id_foreign` (`promocode_id`);

--
-- Indexes for table `order_items`
--
ALTER TABLE `order_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `order_items_order_id_foreign` (`order_id`),
  ADD KEY `order_items_product_id_foreign` (`product_id`);

--
-- Indexes for table `partners`
--
ALTER TABLE `partners`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Indexes for table `payment_methods`
--
ALTER TABLE `payment_methods`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `payment_methods_slug_unique` (`slug`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `products_barcode_unique` (`barcode`),
  ADD KEY `products_category_id_foreign` (`category_id`);

--
-- Indexes for table `product_batches`
--
ALTER TABLE `product_batches`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_batches_product_id_foreign` (`product_id`),
  ADD KEY `product_batches_location_index` (`location`);

--
-- Indexes for table `product_discounts`
--
ALTER TABLE `product_discounts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_discounts_product_id_foreign` (`product_id`);

--
-- Indexes for table `promocodes`
--
ALTER TABLE `promocodes`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `promocodes_code_unique` (`code`),
  ADD KEY `promocodes_partner_id_foreign` (`partner_id`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `roles_slug_unique` (`slug`);

--
-- Indexes for table `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_index` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);

--
-- Indexes for table `settings`
--
ALTER TABLE `settings`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `settings_key_unique` (`key`);

--
-- Indexes for table `taxes`
--
ALTER TABLE `taxes`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `telegram_partners`
--
ALTER TABLE `telegram_partners`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `telegram_partners_telegram_chat_id_unique` (`telegram_chat_id`),
  ADD UNIQUE KEY `telegram_partners_promo_code_unique` (`promo_code`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`),
  ADD KEY `users_role_id_foreign` (`role_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `cash_registers`
--
ALTER TABLE `cash_registers`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `order_items`
--
ALTER TABLE `order_items`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT for table `partners`
--
ALTER TABLE `partners`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `payment_methods`
--
ALTER TABLE `payment_methods`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `product_batches`
--
ALTER TABLE `product_batches`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `product_discounts`
--
ALTER TABLE `product_discounts`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `promocodes`
--
ALTER TABLE `promocodes`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `settings`
--
ALTER TABLE `settings`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `taxes`
--
ALTER TABLE `taxes`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `telegram_partners`
--
ALTER TABLE `telegram_partners`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `categories`
--
ALTER TABLE `categories`
  ADD CONSTRAINT `categories_parent_id_foreign` FOREIGN KEY (`parent_id`) REFERENCES `categories` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_cash_register_id_foreign` FOREIGN KEY (`cash_register_id`) REFERENCES `cash_registers` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `orders_promocode_id_foreign` FOREIGN KEY (`promocode_id`) REFERENCES `promocodes` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `orders_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `order_items`
--
ALTER TABLE `order_items`
  ADD CONSTRAINT `order_items_order_id_foreign` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `order_items_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`);

--
-- Constraints for table `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `products_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `product_batches`
--
ALTER TABLE `product_batches`
  ADD CONSTRAINT `product_batches_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `product_discounts`
--
ALTER TABLE `product_discounts`
  ADD CONSTRAINT `product_discounts_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `promocodes`
--
ALTER TABLE `promocodes`
  ADD CONSTRAINT `promocodes_partner_id_foreign` FOREIGN KEY (`partner_id`) REFERENCES `partners` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE SET NULL;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
