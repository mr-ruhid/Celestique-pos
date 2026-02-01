-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Feb 01, 2026 at 06:27 PM
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
-- Database: `test1`
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
-- Table structure for table `contact_settings`
--

CREATE TABLE `contact_settings` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `phone_1` varchar(255) DEFAULT NULL,
  `phone_2` varchar(255) DEFAULT NULL,
  `email_receiver` varchar(255) DEFAULT NULL,
  `facebook` varchar(255) DEFAULT NULL,
  `instagram` varchar(255) DEFAULT NULL,
  `twitter` varchar(255) DEFAULT NULL,
  `linkedin` varchar(255) DEFAULT NULL,
  `github` varchar(255) DEFAULT NULL,
  `behance` varchar(255) DEFAULT NULL,
  `tiktok` varchar(255) DEFAULT NULL,
  `threads` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `contact_settings`
--

INSERT INTO `contact_settings` (`id`, `phone_1`, `phone_2`, `email_receiver`, `facebook`, `instagram`, `twitter`, `linkedin`, `github`, `behance`, `tiktok`, `threads`, `created_at`, `updated_at`) VALUES
(1, '+994 50 663 60 31', '+99470 576 67 31', 'ruhidjavadoff@gmail.com', 'https://www.facebook.com/p/Ruhid-Javadoff-100086599801160/', 'https://www.instagram.com/veb.developher.az/?g=5', 'https://x.com/rjcompanyllc', 'https://www.linkedin.com/in/ruhid-j-60a777254/?locale=tr_TR', 'https://github.com/mr-ruhid', 'https://www.behance.net/ruhidjavadoff', 'https://www.tiktok.com/@ruhidjavadov', NULL, '2026-02-01 07:29:47', '2026-02-01 07:29:47');

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
-- Table structure for table `home_contents`
--

CREATE TABLE `home_contents` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `hero_title_1` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`hero_title_1`)),
  `hero_title_2` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`hero_title_2`)),
  `hero_subtext` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`hero_subtext`)),
  `hero_btn_text` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`hero_btn_text`)),
  `hero_btn_url` varchar(255) DEFAULT NULL,
  `hero_gallery` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`hero_gallery`)),
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `home_contents`
--

INSERT INTO `home_contents` (`id`, `hero_title_1`, `hero_title_2`, `hero_subtext`, `hero_btn_text`, `hero_btn_url`, `hero_gallery`, `created_at`, `updated_at`) VALUES
(1, '{\"az\":\"RJ Site Updater\",\"en\":\"RJ Site Updater\",\"ru\":\"RJ Site Updater\",\"tr\":\"RJ Site Updater\"}', '{\"az\":\"RJ POS \\u00fc\\u00e7\\u00fcn\",\"en\":\"For RJ POS\",\"ru\":\"\\u0414\\u043b\\u044f RJ POS\",\"tr\":\"RJ POS i\\u00e7in\"}', '{\"az\":\"RJ Pos Sistemin\\u0259 adi plugin v\\u0259 yenilikl\\u0259ri buradan \\u0259ld\\u0259 ed\\u0259 bil\\u0259rsiniz!\",\"en\":\"You can get regular plugins and updates for the RJ Pos System here!\",\"ru\":\"\\u0417\\u0434\\u0435\\u0441\\u044c \\u0432\\u044b \\u043c\\u043e\\u0436\\u0435\\u0442\\u0435 \\u0440\\u0435\\u0433\\u0443\\u043b\\u044f\\u0440\\u043d\\u043e \\u043f\\u043e\\u043b\\u0443\\u0447\\u0430\\u0442\\u044c \\u043f\\u043b\\u0430\\u0433\\u0438\\u043d\\u044b \\u0438 \\u043e\\u0431\\u043d\\u043e\\u0432\\u043b\\u0435\\u043d\\u0438\\u044f \\u0434\\u043b\\u044f \\u0441\\u0438\\u0441\\u0442\\u0435\\u043c\\u044b RJ Pos!\",\"tr\":\"RJ Pos Sistemi i\\u00e7in d\\u00fczenli eklentileri ve g\\u00fcncellemeleri buradan edinebilirsiniz!\"}', '{\"az\":\"Ba\\u015fla\",\"en\":\"Start\",\"ru\":\"\\u041d\\u0430\\u0447\\u0438\\u043d\\u0430\\u0442\\u044c\",\"tr\":\"Ba\\u015fla\"}', NULL, '[\"hero_697f439fc1a78.png\"]', '2026-02-01 07:19:44', '2026-02-01 08:14:27');

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
-- Table structure for table `login_logs`
--

CREATE TABLE `login_logs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `ip_address` varchar(255) DEFAULT NULL,
  `user_agent` varchar(255) DEFAULT NULL,
  `login_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `login_logs`
--

INSERT INTO `login_logs` (`id`, `user_id`, `ip_address`, `user_agent`, `login_at`) VALUES
(1, 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', '2026-02-01 06:56:34');

-- --------------------------------------------------------

--
-- Table structure for table `menus`
--

CREATE TABLE `menus` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `key` varchar(255) DEFAULT NULL,
  `title` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`title`)),
  `url` varchar(255) NOT NULL,
  `type` varchar(255) NOT NULL DEFAULT 'custom',
  `order` int(11) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `menus`
--

INSERT INTO `menus` (`id`, `key`, `title`, `url`, `type`, `order`, `created_at`, `updated_at`) VALUES
(18, 'menu_home', '{\"az\":\"Ana S\\u0259hif\\u0259\",\"en\":\"Home\",\"ru\":\"\\u0413\\u043b\\u0430\\u0432\\u043d\\u0430\\u044f\",\"tr\":\"Ana Sayfa\"}', '/', 'page', 1, NULL, '2026-02-01 12:29:16'),
(19, 'menu_updates', '{\"az\":\"Yenilikl\\u0259r\",\"en\":\"Updates\",\"ru\":\"\\u041e\\u0431\\u043d\\u043e\\u0432\\u043b\\u0435\\u043d\\u0438\\u044f\",\"tr\":\"G\\u00fcncellemeler\"}', '/updates', 'page', 2, NULL, '2026-02-01 12:29:16'),
(20, 'menu_plugins', '{\"az\":\"Pluginl\\u0259r\",\"en\":\"Plugins\",\"ru\":\"\\u041f\\u043b\\u0430\\u0433\\u0438\\u043d\\u044b\",\"tr\":\"Eklentiler\"}', '/plugins', 'page', 3, NULL, '2026-02-01 12:29:16'),
(21, 'menu_about', '{\"az\":\"Haqq\\u0131m\\u0131zda\",\"en\":\"About\",\"ru\":\"\\u041e \\u043d\\u0430\\u0441\",\"tr\":\"Hakk\\u0131m\\u0131zda\"}', '/about', 'page', 4, NULL, '2026-02-01 12:29:16'),
(22, 'menu_contact', '{\"az\":\"\\u018flaq\\u0259\",\"en\":\"Contact\",\"ru\":\"\\u041a\\u043e\\u043d\\u0442\\u0430\\u043a\\u0442\\u044b\",\"tr\":\"\\u0130leti\\u015fim\"}', '/contact', 'page', 5, NULL, '2026-02-01 12:29:16');

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
(4, '2026_01_30_140923_add_location_to_product_batches', 1),
(5, '2026_02_01_074705_create_updates_table', 2),
(6, '2026_02_01_080127_create_subscribers_table', 3),
(7, '2026_02_01_081356_create_pages_table', 4),
(8, '2026_02_01_081900_create_contact_settings_table', 5),
(9, '2026_02_01_083228_create_site_settings_table', 6),
(10, '2026_02_01_083621_create_smtp_settings_table', 7),
(11, '2026_02_01_084105_create_translations_table', 8),
(12, '2026_02_01_090416_enable_2fa', 9),
(13, '2026_02_01_093022_create_plugins_table', 10),
(14, '2026_02_01_093629_create_payment_settings_table', 11),
(15, '2026_02_01_095728_add_cryptomus_to_payment_settings', 12),
(16, '2026_02_01_100221_add_status_to_payment_settings', 13),
(17, '2026_02_01_101730_create_menus_table', 14),
(18, '2026_02_01_102419_add_two_factor_columns_to_users_table', 15),
(19, '2026_02_01_105103_create_login_logs_table', 16),
(20, '2026_02_01_111344_create_home_contents_table', 17),
(21, '2026_02_01_092416_create_plugins_table', 18),
(22, '2026_02_01_132915_create_sales_table', 18),
(23, '2026_02_01_133947_create_sales_table', 19),
(24, '2026_02_01_141658_add_description_to_plugins_table', 19),
(25, '2026_02_01_151919_tr', 20),
(26, '2026_02_01_155513_seed_translations_data', 21),
(27, '2026_02_01_162200_dil_duzelis', 22),
(29, '2026_02_01_162400_menu_tercume', 23);

-- --------------------------------------------------------

--
-- Table structure for table `pages`
--

CREATE TABLE `pages` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `slug` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL,
  `content` longtext DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `pages`
--

INSERT INTO `pages` (`id`, `slug`, `title`, `content`, `image`, `created_at`, `updated_at`) VALUES
(1, 'about', '{\"az\":\"Haqq\\u0131m\\u0131zda\",\"en\":\"About us\",\"ru\":\"\\u041e \\u043d\\u0430\\u0441\",\"tr\":\"Hakk\\u0131m\\u0131zda\"}', '{\"az\":\"<p>Haqq\\u0131m\\u0131zda<\\/p>\",\"en\":\"<p>About us<\\/p>\",\"ru\":\"<p>\\u041e \\u043d\\u0430\\u0441<\\/p>\",\"tr\":\"<p>Hakk\\u0131m\\u0131zda<\\/p>\"}', 'about_1769957675.png', '2026-02-01 04:14:37', '2026-02-01 11:05:50');

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
-- Table structure for table `payment_settings`
--

CREATE TABLE `payment_settings` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `currency` varchar(255) NOT NULL DEFAULT 'AZN',
  `currency_symbol` varchar(255) NOT NULL DEFAULT '₼',
  `stripe_public_key` varchar(255) DEFAULT NULL,
  `stripe_secret_key` varchar(255) DEFAULT NULL,
  `bank_account_info` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `cryptomus_merchant_id` varchar(255) DEFAULT NULL,
  `cryptomus_payment_key` varchar(255) DEFAULT NULL,
  `is_cryptomus_active` tinyint(1) NOT NULL DEFAULT 0,
  `is_stripe_active` tinyint(1) NOT NULL DEFAULT 0,
  `is_bank_active` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `payment_settings`
--

INSERT INTO `payment_settings` (`id`, `currency`, `currency_symbol`, `stripe_public_key`, `stripe_secret_key`, `bank_account_info`, `created_at`, `updated_at`, `cryptomus_merchant_id`, `cryptomus_payment_key`, `is_cryptomus_active`, `is_stripe_active`, `is_bank_active`) VALUES
(1, 'USD', '$', NULL, NULL, NULL, '2026-02-01 06:08:19', '2026-02-01 10:05:17', '0f1c989e-7ff3-4da3-b319-c865cfdb1776', 'AH7BLpUZCEY1e69qhVetwkHNIPZQzHylBJI8s9fCR4FYxD7Y61iOeRWcd4YC5J831NWB5joxxlSDKbOOzBqRO94S9w8wZD8uHpxfCN7t2czv5uyU3WUdrOiir1leEdbp', 1, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `plugins`
--

CREATE TABLE `plugins` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `version` varchar(255) NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  `file_path` varchar(255) NOT NULL,
  `is_free` tinyint(1) NOT NULL DEFAULT 1,
  `price` decimal(10,2) DEFAULT NULL,
  `payment_link` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `plugins`
--

INSERT INTO `plugins` (`id`, `name`, `description`, `version`, `image`, `file_path`, `is_free`, `price`, `payment_link`, `created_at`, `updated_at`) VALUES
(1, 'tes 1', NULL, 'v1', 'pl_img_1769952904.png', 'plugin_1769952904.zip', 0, 0.20, NULL, '2026-02-01 09:35:04', '2026-02-01 09:35:04');

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `barcode` varchar(255) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `image_path` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `sales`
--

CREATE TABLE `sales` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `order_id` varchar(255) NOT NULL,
  `plugin_id` bigint(20) UNSIGNED NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `currency` varchar(10) NOT NULL,
  `status` varchar(255) NOT NULL DEFAULT 'pending',
  `payment_method` varchar(255) NOT NULL DEFAULT 'cryptomus',
  `customer_email` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sales`
--

INSERT INTO `sales` (`id`, `order_id`, `plugin_id`, `amount`, `currency`, `status`, `payment_method`, `customer_email`, `created_at`, `updated_at`) VALUES
(1, '1769952909-1-983', 1, 0.20, 'USD', 'pending', 'cryptomus', NULL, '2026-02-01 09:35:09', '2026-02-01 09:35:09'),
(2, '1769952915-1-667', 1, 0.20, 'USD', 'pending', 'cryptomus', NULL, '2026-02-01 09:35:15', '2026-02-01 09:35:15'),
(3, '1769953206-1-526', 1, 0.20, 'USD', 'pending', 'cryptomus', NULL, '2026-02-01 09:40:06', '2026-02-01 09:40:06'),
(4, '1769953210-1-922', 1, 0.20, 'USD', 'pending', 'cryptomus', NULL, '2026-02-01 09:40:10', '2026-02-01 09:40:10'),
(5, '1769953212-1-699', 1, 0.20, 'USD', 'pending', 'cryptomus', NULL, '2026-02-01 09:40:12', '2026-02-01 09:40:12'),
(6, '1769953216-1-793', 1, 0.20, 'USD', 'pending', 'cryptomus', NULL, '2026-02-01 09:40:16', '2026-02-01 09:40:16'),
(7, '1769953243-1-828', 1, 0.20, 'USD', 'pending', 'cryptomus', NULL, '2026-02-01 09:40:43', '2026-02-01 09:40:43'),
(8, '1769953356-1-102', 1, 0.20, 'USD', 'pending', 'cryptomus', NULL, '2026-02-01 09:42:36', '2026-02-01 09:42:36'),
(9, '1769954769-1-427', 1, 0.20, 'USD', 'pending', 'cryptomus', NULL, '2026-02-01 10:06:09', '2026-02-01 10:06:09'),
(10, '1769954804-1-846', 1, 0.20, 'USD', 'pending', 'cryptomus', NULL, '2026-02-01 10:06:44', '2026-02-01 10:06:44'),
(11, '1769955443-1-879', 1, 0.20, 'USD', 'pending', 'cryptomus', NULL, '2026-02-01 10:17:23', '2026-02-01 10:17:23'),
(12, '1769960358-1-601', 1, 0.20, 'USD', 'pending', 'cryptomus', NULL, '2026-02-01 11:39:18', '2026-02-01 11:39:18');

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
('C4sGOGgSfuo2JH8XqBbGmtuiClAsnApDZE0Wo6CC', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'YTo1OntzOjY6Il90b2tlbiI7czo0MDoiSnpxU1NudEo4WVJjRDMyUHRrVjZRVkp1U05WZW5RYTZ1cEVUeEdOaSI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMCI7czo1OiJyb3V0ZSI7czo0OiJob21lIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czo1MDoibG9naW5fd2ViXzU5YmEzNmFkZGMyYjJmOTQwMTU4MGYwMTRjN2Y1OGVhNGUzMDk4OWQiO2k6MTtzOjY6ImxvY2FsZSI7czoyOiJheiI7fQ==', 1769964845),
('p0QBGs5poBfWRaQtkPFyTAfwvN4raQV1hqFwFWah', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiSkcxY0FnaGJrOW00cjVJVXRDWG02UzBVbDY3NVZmTmdGSmhydFJ5SiI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6Mjc6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9hYm91dCI7czo1OiJyb3V0ZSI7czo0OiJwYWdlIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1769959265);

-- --------------------------------------------------------

--
-- Table structure for table `site_settings`
--

CREATE TABLE `site_settings` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `site_name` varchar(255) DEFAULT NULL,
  `logo` varchar(255) DEFAULT NULL,
  `favicon` varchar(255) DEFAULT NULL,
  `enable_2fa` tinyint(1) NOT NULL DEFAULT 0,
  `seo_title` varchar(255) DEFAULT NULL,
  `seo_description` text DEFAULT NULL,
  `seo_keywords` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `site_settings`
--

INSERT INTO `site_settings` (`id`, `site_name`, `logo`, `favicon`, `enable_2fa`, `seo_title`, `seo_description`, `seo_keywords`, `created_at`, `updated_at`) VALUES
(1, 'RJ Pos Updater', 'logo_1769945714.png', 'favicon_1769945714.png', 0, 'RJ POS system updater', 'Burada RJ POS sistemi üçün yeniləmələri görə və yükləyə bilərsiniz. Hazırda sistem pulsuzdur və yeniliklərə görə bir şey tələb olunmur.', 'update,updater,rj pos,ruhid cavadov, ruhid javadoff, ruhid javadov', '2026-02-01 05:09:55', '2026-02-01 07:35:14');

-- --------------------------------------------------------

--
-- Table structure for table `smtp_settings`
--

CREATE TABLE `smtp_settings` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `mail_mailer` varchar(255) NOT NULL DEFAULT 'smtp',
  `mail_host` varchar(255) DEFAULT NULL,
  `mail_port` varchar(255) DEFAULT NULL,
  `mail_username` varchar(255) DEFAULT NULL,
  `mail_password` varchar(255) DEFAULT NULL,
  `mail_encryption` varchar(255) DEFAULT NULL,
  `mail_from_address` varchar(255) DEFAULT NULL,
  `mail_from_name` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `subscribers`
--

CREATE TABLE `subscribers` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `email` varchar(255) NOT NULL,
  `ip_address` varchar(255) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `translations`
--

CREATE TABLE `translations` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `key` varchar(255) NOT NULL,
  `az` text DEFAULT NULL,
  `en` text DEFAULT NULL,
  `ru` text DEFAULT NULL,
  `tr` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `translations`
--

INSERT INTO `translations` (`id`, `key`, `az`, `en`, `ru`, `tr`, `created_at`, `updated_at`) VALUES
(30, 'global_free', 'PULSUZ', 'FREE', 'БЕСПЛАТНО', 'ÜCRETSİZ', '2026-02-01 11:55:37', '2026-02-01 12:07:15'),
(31, 'global_read_more', 'Ətraflı Bax', 'Read More', 'Подробнее', 'Daha Fazla', '2026-02-01 11:55:37', '2026-02-01 12:07:15'),
(32, 'global_download', 'Yüklə', 'Download', 'Скачать', 'İndir', '2026-02-01 11:55:37', '2026-02-01 12:07:15'),
(33, 'global_buy', 'Satın Al', 'Buy', 'Купить', 'Satın Al', '2026-02-01 11:55:37', '2026-02-01 12:07:15'),
(34, 'global_loading', 'Yüklənir...', 'Loading...', 'Загрузка...', 'Yükleniyor...', '2026-02-01 11:55:37', '2026-02-01 12:07:15'),
(35, 'global_started', 'Başladı', 'Started', 'Началось', 'Başladı', '2026-02-01 11:55:37', '2026-02-01 12:07:15'),
(36, 'global_full_version', 'Tam Versiya', 'Full Version', 'Полная версия', 'Tam Sürüm', '2026-02-01 11:55:37', '2026-02-01 12:07:15'),
(37, 'global_update_package', 'Update Paketi', 'Update Package', 'Пакет обновлений', 'Güncelleme Paketi', '2026-02-01 11:55:37', '2026-02-01 12:07:15'),
(38, 'home_page_title', 'Ana Səhifə', 'Home Page', 'Главная', 'Ana Sayfa', '2026-02-01 11:55:37', '2026-02-01 12:07:15'),
(39, 'hero_default_title_1', 'RJ Pos Updater', 'RJ Pos Updater', 'RJ Pos Updater', 'RJ Pos Updater', '2026-02-01 11:55:37', '2026-02-01 12:07:15'),
(40, 'hero_default_title_2', 'Sistem İdarəetməsi', 'System Management', 'Управление системой', 'Sistem Yönetimi', '2026-02-01 11:55:37', '2026-02-01 12:07:15'),
(41, 'hero_default_subtext', 'Sistem haqqında məlumat...', 'Information about the system...', 'Информация о системе...', 'Sistem hakkında bilgi...', '2026-02-01 11:55:37', '2026-02-01 12:07:15'),
(42, 'hero_default_btn_text', 'Başla', 'Get Started', 'Начать', 'Başla', '2026-02-01 11:55:37', '2026-02-01 12:07:15'),
(43, 'home_latest_update_heading', 'Son Sistem Yeniləməsi', 'Latest System Update', 'Последнее обновление', 'Son Sistem Güncellemesi', '2026-02-01 11:55:37', '2026-02-01 12:07:15'),
(44, 'home_download_disabled', 'Yükləmə Deaktivdir', 'Download Disabled', 'Загрузка отключена', 'İndirme Devre Dışı', '2026-02-01 11:55:37', '2026-02-01 12:07:15'),
(45, 'home_no_updates_found', 'Hələ heç bir yenilik yoxdur.', 'No updates yet.', 'Обновлений пока нет.', 'Henüz güncelleme yok.', '2026-02-01 11:55:37', '2026-02-01 12:07:15'),
(46, 'home_popular_plugins_heading', 'Populyar Pluginlər', 'Popular Plugins', 'Популярные плагины', 'Popüler Eklentiler', '2026-02-01 11:55:37', '2026-02-01 12:07:15'),
(47, 'home_no_plugins_found', 'Plugin tapılmadı.', 'No plugins found.', 'Плагины не найдены.', 'Eklenti bulunamadı.', '2026-02-01 11:55:37', '2026-02-01 12:07:15'),
(48, 'updates_page_title', 'Yeniliklər', 'Updates', 'Обновления', 'Güncellemeler', '2026-02-01 11:55:37', '2026-02-01 11:55:37'),
(49, 'updates_hero_title', 'Yeniliklər', 'Updates', 'Обновления', 'Güncellemeler', '2026-02-01 11:55:37', '2026-02-01 11:55:37'),
(50, 'updates_hero_subtitle', 'Sistemin inkişaf tarixi və son versiyalar.', 'Development history and latest versions.', 'История развития и последние версии.', 'Sistemin gelişim geçmişi ve son sürümler.', '2026-02-01 11:55:37', '2026-02-01 11:55:37'),
(51, 'updates_latest_badge', 'Son Versiya', 'Latest Version', 'Последняя версия', 'Son Sürüm', '2026-02-01 11:55:37', '2026-02-01 11:55:37'),
(52, 'updates_btn_full_short', 'Tam', 'Full', 'Полная', 'Tam', '2026-02-01 11:55:37', '2026-02-01 11:55:37'),
(53, 'updates_btn_update_short', 'Update', 'Update', 'Обновление', 'Güncelleme', '2026-02-01 11:55:37', '2026-02-01 11:55:37'),
(54, 'updates_empty_title', 'Hələ heç bir yenilik yoxdur', 'No updates yet', 'Обновлений пока нет', 'Henüz güncelleme yok', '2026-02-01 11:55:37', '2026-02-01 11:55:37'),
(55, 'updates_empty_text', 'Tezliklə ilk versiya əlavə ediləcək.', 'The first version will be added soon.', 'Первая версия скоро будет добавлена.', 'Yakında ilk sürüm eklenecek.', '2026-02-01 11:55:37', '2026-02-01 11:55:37'),
(56, 'updates_screenshots_label', 'Ekran Görüntüləri', 'Screenshots', 'Скриншоты', 'Ekran Görüntüleri', '2026-02-01 11:55:37', '2026-02-01 11:55:37'),
(57, 'updates_download_disabled_msg', 'Yükləmə bu versiya üçün deaktivdir.', 'Download is disabled for this version.', 'Скачивание недоступно для этой версии.', 'Bu sürüm için indirme devre dışı.', '2026-02-01 11:55:37', '2026-02-01 11:55:37'),
(58, 'plugins_page_title', 'Pluginlər', 'Plugins', 'Плагины', 'Eklentiler', '2026-02-01 11:55:37', '2026-02-01 11:55:37'),
(59, 'plugins_hero_title', 'Plugin Mərkəzi', 'Plugin Center', 'Центр плагинов', 'Eklenti Merkezi', '2026-02-01 11:55:37', '2026-02-01 11:55:37'),
(60, 'plugins_hero_subtitle', 'Sisteminizi gücləndirmək üçün əlavələr.', 'Add-ons to enhance your system.', 'Дополнения для улучшения вашей системы.', 'Sisteminizi güçlendirmek için eklentiler.', '2026-02-01 11:55:37', '2026-02-01 11:55:37'),
(61, 'plugins_default_desc', 'Bu plugin sistemə yeni funksiyalar əlavə edir.', 'This plugin adds new features.', 'Этот плагин добавляет новые функции.', 'Bu eklenti sisteme yeni özellikler katar.', '2026-02-01 11:55:37', '2026-02-01 11:55:37'),
(62, 'plugins_not_found_title', 'Plugin tapılmadı', 'No plugins found', 'Плагин не найден', 'Eklenti bulunamadı', '2026-02-01 11:55:37', '2026-02-01 11:55:37'),
(63, 'plugins_not_found_text', 'Hazırda sistemdə heç bir əlavə yoxdur.', 'There are currently no add-ons.', 'На данный момент дополнений нет.', 'Şu anda sistemde eklenti yok.', '2026-02-01 11:55:37', '2026-02-01 11:55:37'),
(64, 'contact_page_title', 'Əlaqə', 'Contact', 'Контакты', 'İletişim', '2026-02-01 11:55:37', '2026-02-01 11:55:37'),
(65, 'contact_hero_title', 'Bizimlə Əlaqə', 'Contact Us', 'Связаться с нами', 'Bizimle İletişime Geçin', '2026-02-01 11:55:37', '2026-02-01 11:55:37'),
(66, 'contact_hero_subtitle', 'Sualınız var? Bizimlə əlaqə saxlaya bilərsiniz.', 'Have questions? You can contact us.', 'Есть вопросы? Свяжитесь с нами.', 'Sorunuz mu var? Bizimle iletişime geçebilirsiniz.', '2026-02-01 11:55:37', '2026-02-01 11:55:37'),
(67, 'contact_info_title', 'Əlaqə Məlumatları', 'Contact Information', 'Контактная информация', 'İletişim Bilgileri', '2026-02-01 11:55:37', '2026-02-01 11:55:37'),
(68, 'contact_phone_label', 'Telefon', 'Phone', 'Телефон', 'Telefon', '2026-02-01 11:55:37', '2026-02-01 11:55:37'),
(69, 'contact_email_label', 'Email', 'Email', 'Email', 'E-posta', '2026-02-01 11:55:37', '2026-02-01 11:55:37'),
(70, 'contact_social_label', 'Sosial Media', 'Social Media', 'Социальные сети', 'Sosyal Medya', '2026-02-01 11:55:37', '2026-02-01 11:55:37'),
(71, 'contact_form_title', 'Mesaj Göndər', 'Send Message', 'Отправить сообщение', 'Mesaj Gönder', '2026-02-01 11:55:37', '2026-02-01 11:55:37'),
(72, 'form_name_label', 'Adınız', 'Your Name', 'Ваше имя', 'Adınız', '2026-02-01 11:55:37', '2026-02-01 11:55:37'),
(73, 'form_email_label', 'Email', 'Email', 'Email', 'E-posta', '2026-02-01 11:55:37', '2026-02-01 11:55:37'),
(74, 'form_subject_label', 'Mövzu', 'Subject', 'Тема', 'Konu', '2026-02-01 11:55:37', '2026-02-01 11:55:37'),
(75, 'form_message_label', 'Mesaj', 'Message', 'Сообщение', 'Mesaj', '2026-02-01 11:55:37', '2026-02-01 11:55:37'),
(76, 'form_send_button', 'Göndər', 'Send', 'Отправить', 'Gönder', '2026-02-01 11:55:37', '2026-02-01 11:55:37'),
(77, 'about_subtitle', 'Biz kimik və nə edirik?', 'Who are we and what do we do?', 'Кто мы и чем занимаемся?', 'Biz kimiz ve ne yapıyoruz?', '2026-02-01 11:56:34', '2026-02-01 12:07:15'),
(79, 'home', 'Ana səhifə', 'Who are we and what do we do?', 'Updates', 'Satın Al', '2026-02-01 12:08:44', '2026-02-01 12:08:44'),
(85, 'menu_home', 'Ana Səhifə', 'Home', 'Главная', 'Ana Sayfa', '2026-02-01 12:29:16', '2026-02-01 12:29:16'),
(86, 'menu_updates', 'Yeniliklər', 'Updates', 'Обновления', 'Güncellemeler', '2026-02-01 12:29:16', '2026-02-01 12:29:16'),
(87, 'menu_plugins', 'Pluginlər', 'Plugins', 'Плагины', 'Eklentiler', '2026-02-01 12:29:16', '2026-02-01 12:29:16'),
(88, 'menu_about', 'Haqqımızda', 'About', 'О нас', 'Hakkımızda', '2026-02-01 12:29:16', '2026-02-01 12:29:16'),
(89, 'menu_contact', 'Əlaqə', 'Contact', 'Контакты', 'İletişim', '2026-02-01 12:29:16', '2026-02-01 12:29:16'),
(90, 'select_language', 'Dillər', 'Languages', 'Языки', 'Diller', '2026-02-01 12:33:16', '2026-02-01 12:33:16');

-- --------------------------------------------------------

--
-- Table structure for table `updates`
--

CREATE TABLE `updates` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `version` varchar(255) NOT NULL,
  `changelog` text DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `allow_download` tinyint(1) NOT NULL DEFAULT 1,
  `has_update_file` tinyint(1) NOT NULL DEFAULT 0,
  `update_file_path` varchar(255) DEFAULT NULL,
  `price_update` decimal(10,2) DEFAULT NULL,
  `has_full_file` tinyint(1) NOT NULL DEFAULT 0,
  `full_file_path` varchar(255) DEFAULT NULL,
  `price_full` decimal(10,2) DEFAULT NULL,
  `gallery_images` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`gallery_images`)),
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `updates`
--

INSERT INTO `updates` (`id`, `version`, `changelog`, `is_active`, `allow_download`, `has_update_file`, `update_file_path`, `price_update`, `has_full_file`, `full_file_path`, `price_full`, `gallery_images`, `created_at`, `updated_at`) VALUES
(2, 'RJ Pos v1', '-Pos ekranı\r\n-Məhsul siyahısı\r\n-Stok', 1, 0, 0, NULL, NULL, 1, 'full_RJPosv1_1769947409.zip', NULL, '[\"gal_697f41114eaec.png\"]', '2026-02-01 08:03:29', '2026-02-01 08:03:29'),
(4, 'RJ Pos v2 Build 1.2', '- HTML sistem PHP Laravel/Bootstrap layihəyə dəyişdi\r\n- Ana səhifə artırıldı\r\n-Dashboard artırıldı\r\n-Kassa ekranı yeniləndi\r\n-Məhsul siyahısı səhifəsi yeniləndi\r\n-Kateqoriyalar bölməsi\r\n-Barkod çapı\r\nMağaza endirimi\r\nÜmumi stok\r\nAnbar stok\r\nMağaza stok\r\nStok transfer\r\nSatış tarixşəsi\r\nGeri qaytarma\r\nLotoreya\r\nPromokodlar\r\nPartnyorlar\r\nHesabatlar\r\nMağaza məlumatları\r\nKassalar\r\nRollar\r\nVergi\r\nÖdəniş növü\r\nQəbz şablomu\r\nApi tənzimləməsi\r\nBackup və restore bölməsi\r\nServer quraşdırması\r\nAdmin Hesabları\r\nKassa hesabları\r\nTelegram API artırıldı\r\nOrtaq paylaşım (server sync)\r\nGiriş ekranı', 1, 1, 0, NULL, NULL, 1, 'full_RJPosv2Build12_1769950419.rar', NULL, '[\"gal_697f4cd34e274.png\"]', '2026-02-01 08:53:39', '2026-02-01 08:53:39');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `two_factor_code` varchar(255) DEFAULT NULL,
  `two_factor_expires_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`, `two_factor_code`, `two_factor_expires_at`) VALUES
(1, 'Admin', 'admin@admin.com', '2026-02-01 03:15:14', '$2y$10$ZjjDp/FLqQ.Rvrqbhk/SP.OXAnTflMO0brJ6fvJsFkkCm5RAe9AbG', '0000', '2026-02-01 03:15:14', '2026-02-01 06:56:34', NULL, NULL);

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
-- Indexes for table `contact_settings`
--
ALTER TABLE `contact_settings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `home_contents`
--
ALTER TABLE `home_contents`
  ADD PRIMARY KEY (`id`);

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
-- Indexes for table `login_logs`
--
ALTER TABLE `login_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `login_logs_user_id_foreign` (`user_id`);

--
-- Indexes for table `menus`
--
ALTER TABLE `menus`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `pages`
--
ALTER TABLE `pages`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `pages_slug_unique` (`slug`);

--
-- Indexes for table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Indexes for table `payment_settings`
--
ALTER TABLE `payment_settings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `plugins`
--
ALTER TABLE `plugins`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `products_barcode_unique` (`barcode`);

--
-- Indexes for table `sales`
--
ALTER TABLE `sales`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `sales_order_id_unique` (`order_id`),
  ADD KEY `sales_plugin_id_foreign` (`plugin_id`);

--
-- Indexes for table `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_index` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);

--
-- Indexes for table `site_settings`
--
ALTER TABLE `site_settings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `smtp_settings`
--
ALTER TABLE `smtp_settings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `subscribers`
--
ALTER TABLE `subscribers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `subscribers_email_unique` (`email`);

--
-- Indexes for table `translations`
--
ALTER TABLE `translations`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `translations_key_unique` (`key`);

--
-- Indexes for table `updates`
--
ALTER TABLE `updates`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `contact_settings`
--
ALTER TABLE `contact_settings`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `home_contents`
--
ALTER TABLE `home_contents`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `login_logs`
--
ALTER TABLE `login_logs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `menus`
--
ALTER TABLE `menus`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT for table `pages`
--
ALTER TABLE `pages`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `payment_settings`
--
ALTER TABLE `payment_settings`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `plugins`
--
ALTER TABLE `plugins`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `sales`
--
ALTER TABLE `sales`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `site_settings`
--
ALTER TABLE `site_settings`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `smtp_settings`
--
ALTER TABLE `smtp_settings`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `subscribers`
--
ALTER TABLE `subscribers`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `translations`
--
ALTER TABLE `translations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=91;

--
-- AUTO_INCREMENT for table `updates`
--
ALTER TABLE `updates`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `login_logs`
--
ALTER TABLE `login_logs`
  ADD CONSTRAINT `login_logs_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `sales`
--
ALTER TABLE `sales`
  ADD CONSTRAINT `sales_plugin_id_foreign` FOREIGN KEY (`plugin_id`) REFERENCES `plugins` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
