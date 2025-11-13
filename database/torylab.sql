-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 13, 2025 at 07:46 AM
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
-- Database: `torylab`
--

-- --------------------------------------------------------

--
-- Table structure for table `actions`
--

CREATE TABLE `actions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `actionable_type` varchar(40) NOT NULL,
  `actionable_id` int(10) UNSIGNED NOT NULL,
  `action_name` varchar(40) NOT NULL,
  `admin_id` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `actions`
--

INSERT INTO `actions` (`id`, `actionable_type`, `actionable_id`, `action_name`, `admin_id`, `created_at`) VALUES
(1, 'App\\Models\\Customer', 1, 'CREATED', 1, '2025-07-28 05:46:55'),
(2, 'App\\Models\\Supplier', 1, 'CREATED', 1, '2025-07-28 06:39:39'),
(3, 'App\\Models\\Expense', 1, 'CREATED', 1, '2025-07-28 06:49:18'),
(4, 'App\\Models\\Product', 1, 'CREATED', 1, '2025-07-28 12:30:16'),
(5, 'App\\Models\\Purchase', 1, 'CREATED', 1, '2025-07-28 12:35:06'),
(6, 'App\\Models\\Customer', 2, 'CREATED', 1, '2025-11-10 19:34:54'),
(7, 'App\\Models\\Customer', 3, 'CREATED', 1, '2025-11-12 09:19:27'),
(8, 'App\\Models\\Customer', 4, 'CREATED', 1, '2025-11-12 09:36:07'),
(9, 'App\\Models\\Customer', 4, 'UPDATED', 1, '2025-11-12 09:36:24'),
(10, 'App\\Models\\Customer', 5, 'CREATED', 1, '2025-11-12 18:46:50'),
(11, 'App\\Models\\Customer', 5, 'UPDATED', 1, '2025-11-12 18:47:00'),
(12, 'App\\Models\\Customer', 5, 'UPDATED', 1, '2025-11-12 18:47:25'),
(13, 'App\\Models\\Customer', 4, 'UPDATED', 1, '2025-11-12 20:45:11'),
(14, 'App\\Models\\Customer', 6, 'CREATED', 1, '2025-11-12 20:46:43'),
(15, 'App\\Models\\Customer', 1, 'UPDATED', 1, '2025-11-12 21:08:56');

-- --------------------------------------------------------

--
-- Table structure for table `adjustments`
--

CREATE TABLE `adjustments` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `warehouse_id` int(10) UNSIGNED NOT NULL,
  `adjust_date` date DEFAULT NULL,
  `tracking_no` varchar(40) NOT NULL,
  `note` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `adjustment_details`
--

CREATE TABLE `adjustment_details` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `adjustment_id` int(10) UNSIGNED NOT NULL,
  `product_id` int(10) UNSIGNED NOT NULL,
  `quantity` int(10) UNSIGNED NOT NULL,
  `adjust_type` tinyint(3) UNSIGNED NOT NULL COMMENT '1=> Minus, 2=> Plus',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `admins`
--

CREATE TABLE `admins` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `role_id` int(10) UNSIGNED NOT NULL,
  `name` varchar(40) DEFAULT NULL,
  `email` varchar(40) DEFAULT NULL,
  `mobile` varchar(40) DEFAULT NULL,
  `username` varchar(40) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1 COMMENT '1 => Enable,\r\nDisabled => 0',
  `remember_token` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `admins`
--

INSERT INTO `admins` (`id`, `role_id`, `name`, `email`, `mobile`, `username`, `image`, `password`, `status`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 0, 'Super Admin', 'admin@site.com', NULL, 'admin', '6912d1e803f9a1762841064.jpg', '$2y$12$gI.ZhR6XPl2pRtoG0nnZUOvStQvtMY1VMn4IFgA7vKdlnicWTGoue', 1, 'fNBhrBsqbZMzRABDxNavlygDk80xJpInVn0rCTdEixLIwHyUk2xz6WekC2lb', NULL, '2025-11-11 06:04:27');

-- --------------------------------------------------------

--
-- Table structure for table `admin_notifications`
--

CREATE TABLE `admin_notifications` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `title` varchar(255) DEFAULT NULL,
  `is_read` tinyint(1) NOT NULL DEFAULT 0,
  `click_url` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `admin_password_resets`
--

CREATE TABLE `admin_password_resets` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `email` varchar(40) DEFAULT NULL,
  `token` varchar(40) DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `admin_password_resets`
--

INSERT INTO `admin_password_resets` (`id`, `email`, `token`, `status`, `created_at`, `updated_at`) VALUES
(1, 'admin@site.com', '774522', 0, '2024-07-11 04:22:15', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `brands`
--

CREATE TABLE `brands` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(40) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `brands`
--

INSERT INTO `brands` (`id`, `name`, `created_at`, `updated_at`) VALUES
(1, 'Brand One', '2025-07-28 12:28:06', '2025-07-28 12:28:06');

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
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(40) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `name`, `created_at`, `updated_at`) VALUES
(1, 'Category one', '2025-07-28 12:27:44', '2025-07-28 12:27:44');

-- --------------------------------------------------------

--
-- Table structure for table `customers`
--

CREATE TABLE `customers` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(40) DEFAULT NULL,
  `email` varchar(40) NOT NULL,
  `mobile` varchar(40) DEFAULT NULL,
  `address` text DEFAULT NULL COMMENT 'contains full address',
  `zone_id` bigint(20) UNSIGNED DEFAULT NULL,
  `site_id` bigint(20) UNSIGNED DEFAULT NULL,
  `id_number` varchar(100) DEFAULT NULL,
  `photo` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `customers`
--

INSERT INTO `customers` (`id`, `name`, `email`, `mobile`, `address`, `zone_id`, `site_id`, `id_number`, `photo`, `created_at`, `updated_at`) VALUES
(1, 'Chetan Vadaye', 'chetan2022aspirantsolutions@gmail.com', '8806811667', 'NSP', 5, 3, 'CUST0001', '6914f767ccfcb1762981735.jpg', '2025-07-28 05:46:55', '2025-11-12 21:08:56');

-- --------------------------------------------------------

--
-- Table structure for table `customer_payments`
--

CREATE TABLE `customer_payments` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `customer_id` int(10) UNSIGNED NOT NULL,
  `sale_id` int(10) UNSIGNED DEFAULT NULL,
  `sale_return_id` int(10) UNSIGNED DEFAULT NULL,
  `amount` decimal(28,8) UNSIGNED NOT NULL DEFAULT 0.00000000,
  `trx` varchar(40) NOT NULL,
  `remark` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `expenses`
--

CREATE TABLE `expenses` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `expense_type_id` int(10) UNSIGNED NOT NULL,
  `date_of_expense` date DEFAULT NULL COMMENT 'Expense date',
  `amount` double(28,8) NOT NULL DEFAULT 0.00000000,
  `note` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `expenses`
--

INSERT INTO `expenses` (`id`, `expense_type_id`, `date_of_expense`, `amount`, `note`, `created_at`, `updated_at`) VALUES
(1, 1, '2025-07-28', 1000.00000000, '10 pens, 20 notepad purchase', '2025-07-28 06:49:18', '2025-07-28 06:49:18');

-- --------------------------------------------------------

--
-- Table structure for table `expense_types`
--

CREATE TABLE `expense_types` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(40) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `expense_types`
--

INSERT INTO `expense_types` (`id`, `name`, `created_at`, `updated_at`) VALUES
(1, 'Stationary', '2025-07-28 06:47:50', '2025-07-28 06:48:08');

-- --------------------------------------------------------

--
-- Table structure for table `extensions`
--

CREATE TABLE `extensions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `act` varchar(40) DEFAULT NULL,
  `name` varchar(40) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `script` text DEFAULT NULL,
  `shortcode` text DEFAULT NULL COMMENT 'object',
  `support` text DEFAULT NULL COMMENT 'help section',
  `status` tinyint(1) NOT NULL DEFAULT 1 COMMENT '1=>enable, 2=>disable',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `extensions`
--

INSERT INTO `extensions` (`id`, `act`, `name`, `description`, `image`, `script`, `shortcode`, `support`, `status`, `created_at`, `updated_at`) VALUES
(2, 'google-recaptcha2', 'Google Recaptcha 2', 'Key location is shown bellow', 'recaptcha3.png', '\n<script src=\"https://www.google.com/recaptcha/api.js\"></script>\n<div class=\"g-recaptcha\" data-sitekey=\"{{site_key}}\" data-callback=\"verifyCaptcha\"></div>\n<div id=\"g-recaptcha-error\"></div>', '{\"site_key\":{\"title\":\"Site Key\",\"value\":\"------------------\"},\"secret_key\":{\"title\":\"Secret Key\",\"value\":\"------------\"}}', 'recaptcha.png', 0, '2019-10-18 11:16:05', '2025-07-28 12:55:19'),
(3, 'custom-captcha', 'Custom Captcha', 'Just put any random string', 'customcaptcha.png', NULL, '{\"random_key\":{\"title\":\"Random String\",\"value\":\"SecureString\"}}', 'na', 1, '2019-10-18 11:16:05', '2025-07-28 12:54:49');

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
-- Table structure for table `general_settings`
--

CREATE TABLE `general_settings` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `site_name` varchar(40) DEFAULT NULL,
  `cur_text` varchar(40) DEFAULT NULL COMMENT 'currency text',
  `cur_sym` varchar(40) DEFAULT NULL COMMENT 'currency symbol',
  `email_from` varchar(40) DEFAULT NULL,
  `email_from_name` varchar(255) DEFAULT NULL,
  `email_template` text DEFAULT NULL,
  `active_template` varchar(255) NOT NULL,
  `sms_template` varchar(255) DEFAULT NULL,
  `sms_from` varchar(255) DEFAULT NULL,
  `mail_config` text DEFAULT NULL COMMENT 'email configuration',
  `sms_config` text DEFAULT NULL,
  `global_shortcodes` text DEFAULT NULL,
  `en` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'email notification, 0 - dont send, 1 - send',
  `sn` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'sms notification, 0 - dont send, 1 - send',
  `system_customized` tinyint(1) NOT NULL DEFAULT 0,
  `paginate_number` int(11) NOT NULL DEFAULT 0,
  `currency_format` tinyint(1) NOT NULL DEFAULT 0 COMMENT '1=>Both\r\n2=>Text Only\r\n3=>Symbol Only',
  `available_version` varchar(40) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `general_settings`
--

INSERT INTO `general_settings` (`id`, `site_name`, `cur_text`, `cur_sym`, `email_from`, `email_from_name`, `email_template`, `active_template`, `sms_template`, `sms_from`, `mail_config`, `sms_config`, `global_shortcodes`, `en`, `sn`, `system_customized`, `paginate_number`, `currency_format`, `available_version`, `created_at`, `updated_at`) VALUES
(1, 'ToryLab', 'INR', '₹', 'info@viserlab.com', 'viserlab', '<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\">\n  <!--[if !mso]><!-->\n  <meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\">\n  <!--<![endif]-->\n  <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\n  <title></title>\n  <style type=\"text/css\">\n.ReadMsgBody { width: 100%; background-color: #ffffff; }\n.ExternalClass { width: 100%; background-color: #ffffff; }\n.ExternalClass, .ExternalClass p, .ExternalClass span, .ExternalClass font, .ExternalClass td, .ExternalClass div { line-height: 100%; }\nhtml { width: 100%; }\nbody { -webkit-text-size-adjust: none; -ms-text-size-adjust: none; margin: 0; padding: 0; }\ntable { border-spacing: 0; table-layout: fixed; margin: 0 auto;border-collapse: collapse; }\ntable table table { table-layout: auto; }\n.yshortcuts a { border-bottom: none !important; }\nimg:hover { opacity: 0.9 !important; }\na { color: #0087ff; text-decoration: none; }\n.textbutton a { font-family: \'open sans\', arial, sans-serif !important;}\n.btn-link a { color:#FFFFFF !important;}\n\n@media only screen and (max-width: 480px) {\nbody { width: auto !important; }\n*[class=\"table-inner\"] { width: 90% !important; text-align: center !important; }\n*[class=\"table-full\"] { width: 100% !important; text-align: center !important; }\n/* image */\nimg[class=\"img1\"] { width: 100% !important; height: auto !important; }\n}\n</style>\n\n\n\n  <table bgcolor=\"#414a51\" width=\"100%\" border=\"0\" align=\"center\" cellpadding=\"0\" cellspacing=\"0\">\n    <tbody><tr>\n      <td height=\"50\"></td>\n    </tr>\n    <tr>\n      <td align=\"center\" style=\"text-align:center;vertical-align:top;font-size:0;\">\n        <table align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">\n          <tbody><tr>\n            <td align=\"center\" width=\"600\">\n              <!--header-->\n              <table class=\"table-inner\" width=\"95%\" border=\"0\" align=\"center\" cellpadding=\"0\" cellspacing=\"0\">\n                <tbody><tr>\n                  <td bgcolor=\"#0087ff\" style=\"border-top-left-radius:6px; border-top-right-radius:6px;text-align:center;vertical-align:top;font-size:0;\" align=\"center\">\n                    <table width=\"90%\" border=\"0\" align=\"center\" cellpadding=\"0\" cellspacing=\"0\">\n                      <tbody><tr>\n                        <td height=\"20\"></td>\n                      </tr>\n                      <tr>\n                        <td align=\"center\" style=\"font-family: \'Open sans\', Arial, sans-serif; color:#FFFFFF; font-size:16px; font-weight: bold;\">This is a System Generated Email</td>\n                      </tr>\n                      <tr>\n                        <td height=\"20\"></td>\n                      </tr>\n                    </tbody></table>\n                  </td>\n                </tr>\n              </tbody></table>\n              <!--end header-->\n              <table class=\"table-inner\" width=\"95%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">\n                <tbody><tr>\n                  <td bgcolor=\"#FFFFFF\" align=\"center\" style=\"text-align:center;vertical-align:top;font-size:0;\">\n                    <table align=\"center\" width=\"90%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">\n                      <tbody><tr>\n                        <td height=\"35\"></td>\n                      </tr>\n                      <!--logo-->\n                      <tr>\n                        <td align=\"center\" style=\"vertical-align:top;font-size:0;\">\n                          <a href=\"#\">\n                            <img style=\"display:block; line-height:0px; font-size:0px; border:0px;\" src=\"https://i.imgur.com/Z1qtvtV.png\" alt=\"img\">\n                          </a>\n                        </td>\n                      </tr>\n                      <!--end logo-->\n                      \n                      <!--headline-->\n                      <tr>\n                        \n                      </tr>\n                      <!--end headline-->\n                      <tr>\n                        <td align=\"center\" style=\"text-align:center;vertical-align:top;font-size:0;\">\n                          <table width=\"40\" border=\"0\" align=\"center\" cellpadding=\"0\" cellspacing=\"0\">\n                            <tbody>\n                          </tbody></table>\n                        </td>\n                      </tr>\n                      <tr>\n                        <td height=\"20\"></td>\n                      </tr>\n                      <!--content-->\n                      <tr>\n                        <td align=\"left\" style=\"font-family: \'Open sans\', Arial, sans-serif; color:#7f8c8d; font-size:16px; line-height: 28px;\">{{message}}</td>\n                      </tr>\n                      <!--end content-->\n                      <tr>\n                        <td height=\"40\"></td>\n                      </tr>\n              \n                    </tbody></table>\n                  </td>\n                </tr>\n                <tr>\n                  <td height=\"45\" align=\"center\" bgcolor=\"#f4f4f4\" style=\"border-bottom-left-radius:6px;border-bottom-right-radius:6px;\">\n                    <table align=\"center\" width=\"90%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">\n                      <tbody><tr>\n                        <td height=\"10\"></td>\n                      </tr>\n                      <!--preference-->\n                      <tr>\n                        <td class=\"preference-link\" align=\"center\" style=\"font-family: \'Open sans\', Arial, sans-serif; color:#95a5a6; font-size:14px;\">\n                          © 2024 <a href=\"#\">{{site_name}}</a>&nbsp;. All Rights Reserved. \n                        </td>\n                      </tr>\n                      <!--end preference-->\n                      <tr>\n                        <td height=\"10\"></td>\n                      </tr>\n                    </tbody></table>\n                  </td>\n                </tr>\n              </tbody></table>\n            </td>\n          </tr>\n        </tbody></table>\n      </td>\n    </tr>\n    <tr>\n      <td height=\"60\"></td>\n    </tr>\n  </tbody></table>', 'basic', '{{message}}', 'ViserAdmin', '{\"name\":\"php\"}', '{\"name\":\"nexmo\",\"clickatell\":{\"api_key\":\"----------------\"},\"infobip\":{\"username\":\"------------8888888\",\"password\":\"-----------------\"},\"message_bird\":{\"api_key\":\"-------------------\"},\"nexmo\":{\"api_key\":\"----------------------\",\"api_secret\":\"----------------------\"},\"sms_broadcast\":{\"username\":\"----------------------\",\"password\":\"-----------------------------\"},\"twilio\":{\"account_sid\":\"-----------------------\",\"auth_token\":\"---------------------------\",\"from\":\"----------------------\"},\"text_magic\":{\"username\":\"-----------------------\",\"apiv2_key\":\"-------------------------------\"},\"custom\":{\"method\":\"get\",\"url\":\"https:\\/\\/hostname\\/demo-api-v1\",\"headers\":{\"name\":[\"api_key\"],\"value\":[\"test_api 555\"]},\"body\":{\"name\":[\"from_number\"],\"value\":[\"5657545757\"]}}}', '{\n    \"site_name\":\"Name of your site\",\n    \"site_currency\":\"Currency of your site\",\n    \"currency_symbol\":\"Symbol of currency\"\n}', 1, 1, 0, 20, 3, '2.0', NULL, '2025-07-28 06:51:12');

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
(4, '2025_11_10_013401_add_zone_to_warehouses_table', 1),
(5, '2025_11_10_000001_create_zones_table', 2),
(6, '2025_11_10_000002_add_zoneid_photo_idnumber_to_customers', 3),
(7, '2025_11_12_000010_create_sites_table', 4),
(8, '2025_11_12_000011_add_siteid_to_customers_table', 5);

-- --------------------------------------------------------

--
-- Table structure for table `notification_logs`
--

CREATE TABLE `notification_logs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `customer_id` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `sender` varchar(40) DEFAULT NULL,
  `sent_from` varchar(40) DEFAULT NULL,
  `sent_to` varchar(40) DEFAULT NULL,
  `subject` varchar(255) DEFAULT NULL,
  `message` text DEFAULT NULL,
  `notification_type` varchar(40) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `notification_logs`
--

INSERT INTO `notification_logs` (`id`, `customer_id`, `sender`, `sent_from`, `sent_to`, `subject`, `message`, `notification_type`, `created_at`, `updated_at`) VALUES
(1, 1, 'php', 'info@viserlab.com', 'chetan2022aspirantsolutions@gmail.com', 'test', '<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\">\r\n  <!--[if !mso]><!-->\r\n  <meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\">\r\n  <!--<![endif]-->\r\n  <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\r\n  <title></title>\r\n  <style type=\"text/css\">\r\n.ReadMsgBody { width: 100%; background-color: #ffffff; }\r\n.ExternalClass { width: 100%; background-color: #ffffff; }\r\n.ExternalClass, .ExternalClass p, .ExternalClass span, .ExternalClass font, .ExternalClass td, .ExternalClass div { line-height: 100%; }\r\nhtml { width: 100%; }\r\nbody { -webkit-text-size-adjust: none; -ms-text-size-adjust: none; margin: 0; padding: 0; }\r\ntable { border-spacing: 0; table-layout: fixed; margin: 0 auto;border-collapse: collapse; }\r\ntable table table { table-layout: auto; }\r\n.yshortcuts a { border-bottom: none !important; }\r\nimg:hover { opacity: 0.9 !important; }\r\na { color: #0087ff; text-decoration: none; }\r\n.textbutton a { font-family: \'open sans\', arial, sans-serif !important;}\r\n.btn-link a { color:#FFFFFF !important;}\r\n\r\n@media only screen and (max-width: 480px) {\r\nbody { width: auto !important; }\r\n*[class=\"table-inner\"] { width: 90% !important; text-align: center !important; }\r\n*[class=\"table-full\"] { width: 100% !important; text-align: center !important; }\r\n/* image */\r\nimg[class=\"img1\"] { width: 100% !important; height: auto !important; }\r\n}\r\n</style>\r\n\r\n\r\n\r\n  <table bgcolor=\"#414a51\" width=\"100%\" border=\"0\" align=\"center\" cellpadding=\"0\" cellspacing=\"0\">\r\n    <tbody><tr>\r\n      <td height=\"50\"></td>\r\n    </tr>\r\n    <tr>\r\n      <td align=\"center\" style=\"text-align:center;vertical-align:top;font-size:0;\">\r\n        <table align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">\r\n          <tbody><tr>\r\n            <td align=\"center\" width=\"600\">\r\n              <!--header-->\r\n              <table class=\"table-inner\" width=\"95%\" border=\"0\" align=\"center\" cellpadding=\"0\" cellspacing=\"0\">\r\n                <tbody><tr>\r\n                  <td bgcolor=\"#0087ff\" style=\"border-top-left-radius:6px; border-top-right-radius:6px;text-align:center;vertical-align:top;font-size:0;\" align=\"center\">\r\n                    <table width=\"90%\" border=\"0\" align=\"center\" cellpadding=\"0\" cellspacing=\"0\">\r\n                      <tbody><tr>\r\n                        <td height=\"20\"></td>\r\n                      </tr>\r\n                      <tr>\r\n                        <td align=\"center\" style=\"font-family: \'Open sans\', Arial, sans-serif; color:#FFFFFF; font-size:16px; font-weight: bold;\">This is a System Generated Email</td>\r\n                      </tr>\r\n                      <tr>\r\n                        <td height=\"20\"></td>\r\n                      </tr>\r\n                    </tbody></table>\r\n                  </td>\r\n                </tr>\r\n              </tbody></table>\r\n              <!--end header-->\r\n              <table class=\"table-inner\" width=\"95%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">\r\n                <tbody><tr>\r\n                  <td bgcolor=\"#FFFFFF\" align=\"center\" style=\"text-align:center;vertical-align:top;font-size:0;\">\r\n                    <table align=\"center\" width=\"90%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">\r\n                      <tbody><tr>\r\n                        <td height=\"35\"></td>\r\n                      </tr>\r\n                      <!--logo-->\r\n                      <tr>\r\n                        <td align=\"center\" style=\"vertical-align:top;font-size:0;\">\r\n                          <a href=\"#\">\r\n                            <img style=\"display:block; line-height:0px; font-size:0px; border:0px;\" src=\"https://i.imgur.com/Z1qtvtV.png\" alt=\"img\">\r\n                          </a>\r\n                        </td>\r\n                      </tr>\r\n                      <!--end logo-->\r\n                      \r\n                      <!--headline-->\r\n                      <tr>\r\n                        \r\n                      </tr>\r\n                      <!--end headline-->\r\n                      <tr>\r\n                        <td align=\"center\" style=\"text-align:center;vertical-align:top;font-size:0;\">\r\n                          <table width=\"40\" border=\"0\" align=\"center\" cellpadding=\"0\" cellspacing=\"0\">\r\n                            <tbody>\r\n                          </tbody></table>\r\n                        </td>\r\n                      </tr>\r\n                      <tr>\r\n                        <td height=\"20\"></td>\r\n                      </tr>\r\n                      <!--content-->\r\n                      <tr>\r\n                        <td align=\"left\" style=\"font-family: \'Open sans\', Arial, sans-serif; color:#7f8c8d; font-size:16px; line-height: 28px;\">test</td>\r\n                      </tr>\r\n                      <!--end content-->\r\n                      <tr>\r\n                        <td height=\"40\"></td>\r\n                      </tr>\r\n              \r\n                    </tbody></table>\r\n                  </td>\r\n                </tr>\r\n                <tr>\r\n                  <td height=\"45\" align=\"center\" bgcolor=\"#f4f4f4\" style=\"border-bottom-left-radius:6px;border-bottom-right-radius:6px;\">\r\n                    <table align=\"center\" width=\"90%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">\r\n                      <tbody><tr>\r\n                        <td height=\"10\"></td>\r\n                      </tr>\r\n                      <!--preference-->\r\n                      <tr>\r\n                        <td class=\"preference-link\" align=\"center\" style=\"font-family: \'Open sans\', Arial, sans-serif; color:#95a5a6; font-size:14px;\">\r\n                          © 2024 <a href=\"#\">ToryLab</a>&nbsp;. All Rights Reserved. \r\n                        </td>\r\n                      </tr>\r\n                      <!--end preference-->\r\n                      <tr>\r\n                        <td height=\"10\"></td>\r\n                      </tr>\r\n                    </tbody></table>\r\n                  </td>\r\n                </tr>\r\n              </tbody></table>\r\n            </td>\r\n          </tr>\r\n        </tbody></table>\r\n      </td>\r\n    </tr>\r\n    <tr>\r\n      <td height=\"60\"></td>\r\n    </tr>\r\n  </tbody></table>', 'email', '2025-07-28 05:47:52', '2025-07-28 05:47:52');

-- --------------------------------------------------------

--
-- Table structure for table `notification_templates`
--

CREATE TABLE `notification_templates` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `act` varchar(40) DEFAULT NULL,
  `name` varchar(40) DEFAULT NULL,
  `subject` varchar(255) DEFAULT NULL,
  `email_body` text DEFAULT NULL,
  `sms_body` text DEFAULT NULL,
  `shortcodes` text DEFAULT NULL,
  `email_status` tinyint(1) NOT NULL DEFAULT 1,
  `email_sent_from_name` varchar(40) DEFAULT NULL,
  `email_sent_from_address` varchar(40) DEFAULT NULL,
  `sms_status` tinyint(1) NOT NULL DEFAULT 1,
  `sms_sent_from` varchar(40) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `notification_templates`
--

INSERT INTO `notification_templates` (`id`, `act`, `name`, `subject`, `email_body`, `sms_body`, `shortcodes`, `email_status`, `email_sent_from_name`, `email_sent_from_address`, `sms_status`, `sms_sent_from`, `created_at`, `updated_at`) VALUES
(7, 'PASS_RESET_CODE', 'Password - Reset - Code', 'Password Reset', '<div style=\"font-family: Montserrat, sans-serif;\">We have received a request to reset the password for your account on&nbsp;<span style=\"font-weight: bolder;\">{{time}} .<br></span></div><div style=\"font-family: Montserrat, sans-serif;\">Requested From IP:&nbsp;<span style=\"font-weight: bolder;\">{{ip}}</span>&nbsp;using&nbsp;<span style=\"font-weight: bolder;\">{{browser}}</span>&nbsp;on&nbsp;<span style=\"font-weight: bolder;\">{{operating_system}}&nbsp;</span>.</div><div style=\"font-family: Montserrat, sans-serif;\"><br></div><br style=\"font-family: Montserrat, sans-serif;\"><div style=\"font-family: Montserrat, sans-serif;\"><div>Your account recovery code is:&nbsp;&nbsp;&nbsp;<font size=\"6\"><span style=\"font-weight: bolder;\">{{code}}</span></font></div><div><br></div></div><div style=\"font-family: Montserrat, sans-serif;\"><br></div><div style=\"font-family: Montserrat, sans-serif;\"><font size=\"4\" color=\"#CC0000\">If you do not wish to reset your password, please disregard this message.&nbsp;</font><br></div><div><font size=\"4\" color=\"#CC0000\"><br></font></div>', 'Your account recovery code is: {{code}}', '{\"code\":\"Verification code for password reset\",\"ip\":\"IP address of the user\",\"browser\":\"Browser of the user\",\"operating_system\":\"Operating system of the user\",\"time\":\"Time of the request\"}', 1, NULL, NULL, 0, NULL, '2021-11-03 12:00:00', '2022-03-20 20:47:05'),
(8, 'PASS_RESET_DONE', 'Password - Reset - Confirmation', 'You have reset your password', '<p style=\"font-family: Montserrat, sans-serif;\">You have successfully reset your password.</p><p style=\"font-family: Montserrat, sans-serif;\">You changed from&nbsp; IP:&nbsp;<span style=\"font-weight: bolder;\">{{ip}}</span>&nbsp;using&nbsp;<span style=\"font-weight: bolder;\">{{browser}}</span>&nbsp;on&nbsp;<span style=\"font-weight: bolder;\">{{operating_system}}&nbsp;</span>&nbsp;on&nbsp;<span style=\"font-weight: bolder;\">{{time}}</span></p><p style=\"font-family: Montserrat, sans-serif;\"><span style=\"font-weight: bolder;\"><br></span></p><p style=\"font-family: Montserrat, sans-serif;\"><span style=\"font-weight: bolder;\"><font color=\"#ff0000\">If you did not change that, please contact us as soon as possible.</font></span></p>', 'Your password has been changed successfully', '{\"ip\":\"IP address of the user\",\"browser\":\"Browser of the user\",\"operating_system\":\"Operating system of the user\",\"time\":\"Time of the request\"}', 1, NULL, NULL, 1, NULL, '2021-11-03 12:00:00', '2022-04-05 03:46:35'),
(15, 'DEFAULT', 'Default Template', '{{subject}}', '{{message}}', '{{message}}', '{\"subject\":\"Subject\",\"message\":\"Message\"}', 1, NULL, NULL, 1, NULL, '2019-09-14 13:14:22', '2021-11-04 09:38:55'),
(18, 'ADD_STAFF', 'Staff Add', 'Appointed as a staff', 'Hello,&nbsp;{{ name }},<br><br>Your {{ site_name }}\r\nlogin credential is username: {{username}} password: {{password}}', 'Your {{ site_name }} login credential  is  username: {{username}} password: {{password}}', '{\"name\":\"full Name\",\"username\":\"Access his/her guard username\",\"password\":\"Access his/her guard password\"}', 1, NULL, NULL, 1, NULL, '2019-09-14 13:14:22', '2022-10-17 10:31:39');

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
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
-- Table structure for table `permissions`
--

CREATE TABLE `permissions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(40) DEFAULT NULL,
  `group` varchar(40) DEFAULT NULL,
  `code` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `permissions`
--

INSERT INTO `permissions` (`id`, `name`, `group`, `code`) VALUES
(2, 'Dashboard', 'AdminController', 'admin.dashboard'),
(3, 'Report Request', 'AdminController', 'admin.request.report'),
(5, 'Download Attachment', 'AdminController', 'admin.download.attachment'),
(6, 'Roles Index', 'RolesController', 'admin.roles.index'),
(7, 'Roles Add', 'RolesController', 'admin.roles.add'),
(8, 'Roles Edit', 'RolesController', 'admin.roles.edit'),
(9, 'Roles Save', 'RolesController', 'admin.roles.save'),
(10, 'All Categorys', 'CategoryController', 'admin.product.category.index'),
(11, 'Delete Category', 'CategoryController', 'admin.product.category.delete'),
(12, 'Store Category', 'CategoryController', 'admin.product.category.store'),
(13, 'Import Category', 'CategoryController', 'admin.product.category.import'),
(14, 'All Brands', 'BrandController', 'admin.product.brand.index'),
(15, 'Delete Brand', 'BrandController', 'admin.product.brand.delete'),
(16, 'Store Brand', 'BrandController', 'admin.product.brand.store'),
(17, 'Import Brand', 'BrandController', 'admin.product.brand.import'),
(18, 'All Unit', 'UnitController', 'admin.product.unit.index'),
(19, 'Delete Unit', 'UnitController', 'admin.product.unit.delete'),
(20, 'Store Unit', 'UnitController', 'admin.product.unit.store'),
(21, 'Import Unit', 'UnitController', 'admin.product.unit.import'),
(22, 'All Product', 'ProductController', 'admin.product.index'),
(23, 'Add Product', 'ProductController', 'admin.product.create'),
(24, 'Product Edit', 'ProductController', 'admin.product.edit'),
(25, 'Product Store', 'ProductController', 'admin.product.store'),
(26, 'Product Alert', 'ProductController', 'admin.product.alert'),
(27, 'Product Import', 'ProductController', 'admin.product.import'),
(28, 'All Warehouses', 'WarehouseController', 'admin.warehouse.index'),
(29, 'Store Warehouse', 'WarehouseController', 'admin.warehouse.store'),
(30, 'Import Warehouses', 'WarehouseController', 'admin.warehouse.import'),
(31, 'All Purchases', 'PurchaseController', 'admin.purchase.index'),
(32, 'New Purchase', 'PurchaseController', 'admin.purchase.new'),
(33, 'Edit Purchase', 'PurchaseController', 'admin.purchase.edit'),
(34, 'Store Purchase', 'PurchaseController', 'admin.purchase.store'),
(35, 'Download Purchase PDF', 'PurchaseController', 'admin.purchase.pdf'),
(36, 'Purchase Update', 'PurchaseController', 'admin.purchase.update'),
(37, 'Product Searching', 'PurchaseController', 'admin.purchase.product.search'),
(38, 'Check Purchase Invoice', 'PurchaseController', 'admin.purchase.invoice.check'),
(39, 'Purchase Return', 'PurchaseReturnController', 'admin.purchase.return.items'),
(40, 'All Purchase Return', 'PurchaseReturnController', 'admin.purchase.return.index'),
(41, 'Store Purchase Return', 'PurchaseReturnController', 'admin.purchase.return.store'),
(42, 'Edit Purchase Return', 'PurchaseReturnController', 'admin.purchase.return.edit'),
(43, 'Update Purchase Return', 'PurchaseReturnController', 'admin.purchase.return.update'),
(44, 'Download Purchase Return PDF', 'PurchaseReturnController', 'admin.purchase.return.pdf'),
(45, 'Purchase Return Search Product', 'PurchaseReturnController', 'admin.purchase.return.search.product'),
(46, 'Purchase Return Check Invoice', 'PurchaseReturnController', 'admin.purchase.return.check.invoice'),
(47, 'All Sales', 'SaleController', 'admin.sale.index'),
(48, 'Create Sale', 'SaleController', 'admin.sale.create'),
(49, 'Store Sale', 'SaleController', 'admin.sale.store'),
(50, 'Edit Sale', 'SaleController', 'admin.sale.edit'),
(51, 'Update Sale', 'SaleController', 'admin.sale.update'),
(52, 'Download  Sales PDF', 'SaleController', 'admin.sale.pdf'),
(53, 'Sale Search Product', 'SaleController', 'admin.sale.search.product'),
(54, 'Customer Searching', 'SaleController', 'admin.sale.search.customer'),
(55, 'Last  Sale  Invoice', 'SaleController', 'admin.sale.last.invoice'),
(56, 'All Sales Return', 'SaleReturnController', 'admin.sale.return.index'),
(57, 'Item Of Sale Return', 'SaleReturnController', 'admin.sale.return.items'),
(58, 'Store Sale Return', 'SaleReturnController', 'admin.sale.return.store'),
(59, 'Edit Sale Return', 'SaleReturnController', 'admin.sale.return.edit'),
(60, 'Update Sale Return', 'SaleReturnController', 'admin.sale.return.update'),
(61, 'Download Sale Return PDF', 'SaleReturnController', 'admin.sale.return.pdf'),
(62, 'Sale Return Search Product', 'SaleReturnController', 'admin.sale.return.search.product'),
(63, 'Sale Return Search Customer', 'SaleReturnController', 'admin.sale.return.search.customer'),
(64, 'All Adjustments', 'AdjustmentController', 'admin.adjustment.index'),
(65, 'Create Adjustment', 'AdjustmentController', 'admin.adjustment.create'),
(66, 'Store Adjustment', 'AdjustmentController', 'admin.adjustment.store'),
(67, 'Download Adjustment Details PDF', 'AdjustmentController', 'admin.adjustment.details.pdf'),
(68, 'Edit Adjustment', 'AdjustmentController', 'admin.adjustment.edit'),
(69, 'Update Adjustment', 'AdjustmentController', 'admin.adjustment.update'),
(70, 'Adjustment Product Searching', 'AdjustmentController', 'admin.adjustment.search.product'),
(71, 'All Suppliers', 'SupplierController', 'admin.supplier.index'),
(72, 'Store Supplier', 'SupplierController', 'admin.supplier.store'),
(73, 'Import Suppliers', 'SupplierController', 'admin.supplier.import'),
(74, 'All Customers', 'CustomerController', 'admin.customer.index'),
(75, 'Store Customer', 'CustomerController', 'admin.customer.store'),
(76, 'Import Customers', 'CustomerController', 'admin.customer.import'),
(77, 'Customer Notification Log', 'CustomerController', 'admin.customer.notification.log'),
(78, 'Single Customer Notification', 'CustomerController', 'admin.customer.notification.single'),
(79, 'Customer Notification Single', 'CustomerController', 'admin.customer.notification.single'),
(80, 'Customer  All Notification', 'CustomerController', 'admin.customer.notification.all'),
(81, 'Customer Notification  Send To All', 'CustomerController', 'admin.customer.notification.all.send'),
(82, 'Customer Email Details', 'CustomerController', 'admin.customer.email.details'),
(83, 'Supplier Payment Index', 'SupplierPaymentController', 'admin.supplier.payment.index'),
(84, 'Supplier Payment Clear', 'SupplierPaymentController', 'admin.supplier.payment.clear'),
(85, 'Store Supplier Payment', 'SupplierPaymentController', 'admin.supplier.payment.store'),
(86, 'Store Supplier Payment Receive', 'SupplierPaymentController', 'admin.supplier.payment.receive.store'),
(87, 'Clear Payment Of Customer', 'CustomerPaymentController', 'admin.customer.payment.clear'),
(88, 'All Customer Payments', 'CustomerPaymentController', 'admin.customer.payment.index'),
(89, 'Store Customer Payment', 'CustomerPaymentController', 'admin.customer.payment.store'),
(90, 'Store  Payable Payment Of Customer', 'CustomerPaymentController', 'admin.customer.payment.payable.store'),
(91, 'All Transfers', 'TransferController', 'admin.transfer.index'),
(92, 'Create Transfer', 'TransferController', 'admin.transfer.create'),
(93, 'Edit Transfer', 'TransferController', 'admin.transfer.edit'),
(94, 'Store Transfer', 'TransferController', 'admin.transfer.store'),
(95, 'Download Transfer Pdf', 'TransferController', 'admin.transfer.pdf'),
(96, 'Update Transfer', 'TransferController', 'admin.transfer.update'),
(97, 'Transfer Product Search', 'TransferController', 'admin.transfer.search.product'),
(98, 'All Expense Types', 'ExpenseTypeController', 'admin.expense.type.index'),
(99, 'Delete Expense Type', 'ExpenseTypeController', 'admin.expense.type.delete'),
(100, 'Store Expense Type', 'ExpenseTypeController', 'admin.expense.type.store'),
(101, 'Import  Expense Types', 'ExpenseTypeController', 'admin.expense.type.import'),
(102, 'All Expenses', 'ExpenseController', 'admin.expense.index'),
(103, 'Store Expense', 'ExpenseController', 'admin.expense.store'),
(104, 'Import Expenses', 'ExpenseController', 'admin.expense.import'),
(107, 'System Configuration Setting', 'GeneralSettingController', 'admin.setting.system.configuration'),
(108, 'Logo Icon Setting', 'GeneralSettingController', 'admin.setting.logo.icon'),
(109, 'Logo Icon Dark Setting', 'GeneralSettingController', 'admin.setting.logo.icon'),
(110, 'Supplier  Payment Report', 'PaymentReportController', 'admin.report.payment.supplier'),
(111, 'Customer Payment Report', 'PaymentReportController', 'admin.report.payment.customer'),
(112, 'Product Searching', 'ProductController', 'admin.product.list'),
(113, 'Product Data Entry Report', 'DataEntryReportController', 'admin.report.data.entry.product'),
(114, 'Customer Data Entry Report', 'DataEntryReportController', 'admin.report.data.entry.customer'),
(115, 'Supplier Data Entry Report', 'DataEntryReportController', 'admin.report.data.entry.supplier'),
(116, 'Purchase Data Entry Report', 'DataEntryReportController', 'admin.report.data.entry.purchase'),
(117, 'Purchase ReturnData Entry Report', 'DataEntryReportController', 'admin.report.data.entry.purchase.return'),
(118, 'Sale Data Entry Report', 'DataEntryReportController', 'admin.report.data.entry.sale'),
(119, 'Sale Return Data Entry Report', 'DataEntryReportController', 'admin.report.data.entry.sale.return'),
(120, 'Report Data Entry Report  Adjustment', 'DataEntryReportController', 'admin.report.data.entry.adjustment'),
(121, 'Transfer Data Entry Report', 'DataEntryReportController', 'admin.report.data.entry.transfer'),
(122, 'Expense Data Entry  Report', 'DataEntryReportController', 'admin.report.data.entry.expense'),
(123, 'Supplier  Payment Data Entry Report', 'DataEntryReportController', 'admin.report.data.entry.supplier.payment'),
(124, 'Customer  Payment Data Entry Report', 'DataEntryReportController', 'admin.report.data.entry.customer.payment'),
(127, 'Notification Templates', 'NotificationController', 'admin.setting.notification.templates'),
(128, 'Notification Template Edit', 'NotificationController', 'admin.setting.notification.template.edit'),
(129, 'Notification Template Update', 'NotificationController', 'admin.setting.notification.template.update'),
(130, 'Email Notification', 'NotificationController', 'admin.setting.notification.email'),
(131, 'Notification Email Test', 'NotificationController', 'admin.setting.notification.email.test'),
(132, 'SMS Notification', 'NotificationController', 'admin.setting.notification.sms'),
(133, 'Notification SMS Test', 'NotificationController', 'admin.setting.notification.sms.test'),
(134, 'System Info', 'SystemController', 'admin.system.info'),
(135, 'System Server Info', 'SystemController', 'admin.system.server.info'),
(136, 'System Optimize', 'SystemController', 'admin.system.optimize'),
(137, 'System Optimize Clear', 'SystemController', 'admin.system.optimize.clear'),
(138, 'All Staffs', 'StaffController', 'admin.staff.index'),
(139, 'Add Staff', 'StaffController', 'admin.staff.save'),
(140, 'Staff Status Update', 'StaffController', 'admin.staff.status'),
(141, 'Staff Login', 'StaffController', 'admin.staff.login'),
(142, 'Download Product PDF', 'ProductController', 'admin.product.pdf'),
(143, 'Download  Product CSV', 'ProductController', 'admin.product.csv'),
(144, 'Download  Customer PDF', 'CustomerController', 'admin.customer.pdf'),
(145, 'Download  Customer CSV', 'CustomerController', 'admin.customer.csv'),
(146, 'Download Purchase CSV', 'PurchaseController', 'admin.purchase.csv'),
(147, 'Download  Purchase Invoice PDF', 'PurchaseController', 'admin.purchase.invoice.pdf'),
(148, 'Download Purchase Return CSV', 'PurchaseReturnController', 'admin.purchase.return.csv'),
(149, 'Download Purchase Return Invoice PDF', 'PurchaseReturnController', 'admin.purchase.return.invoice.pdf'),
(150, 'Download  Sales CSV', 'SaleController', 'admin.sale.csv'),
(151, 'Download Sale Invoice PDF', 'SaleController', 'admin.sale.invoice.pdf'),
(152, 'Download Sale Return CSV', 'SaleReturnController', 'admin.sale.return.csv'),
(153, 'Download Sale Return Invoice PDF', 'SaleReturnController', 'admin.sale.return.invoice.pdf'),
(154, 'Download Adjustment PDF', 'AdjustmentController', 'admin.adjustment.pdf'),
(155, 'Download Adjustment CSV', 'AdjustmentController', 'admin.adjustment.csv'),
(156, 'Download Supplier PDF', 'SupplierController', 'admin.supplier.pdf'),
(157, 'Download Supplier CSV', 'SupplierController', 'admin.supplier.csv'),
(158, 'Download  Supplier Payment PDF', 'SupplierPaymentController', 'admin.supplier.payment.pdf'),
(159, 'Download Customer Payment Pdf', 'CustomerPaymentController', 'admin.customer.payment.pdf'),
(160, 'Download Transfer CSV', 'TransferController', 'admin.transfer.csv'),
(161, 'Download Transfer Details PDF', 'TransferController', 'admin.transfer.details.pdf'),
(162, 'Download Expense PDF', 'ExpenseController', 'admin.expense.pdf'),
(163, 'Download Expense CSV', 'ExpenseController', 'admin.expense.csv'),
(164, 'Download Supplier Payment  Report PDF', 'PaymentReportController', 'admin.report.payment.supplier.pdf'),
(165, 'Download Supplier Payment  Report CSV', 'PaymentReportController', 'admin.report.payment.supplier.csv'),
(166, 'Download Customer  Payment Report  PDF', 'PaymentReportController', 'admin.report.payment.customer.pdf'),
(167, 'Download Customer  Payment Report CSV', 'PaymentReportController', 'admin.report.payment.customer.csv'),
(168, 'Stock Report', 'StockReportController', 'admin.report.stock.index'),
(169, 'Stock Report  PDF', 'StockReportController', 'admin.report.stock.pdf'),
(170, 'Stock Report  CSV', 'StockReportController', 'admin.report.stock.csv'),
(177, 'Notifications', 'AdminController', 'admin.notifications'),
(178, 'Notification Read', 'AdminController', 'admin.notification.read'),
(179, 'Notifications Read All', 'AdminController', 'admin.notifications.read.all'),
(180, 'Notifications Delete All', 'AdminController', 'admin.notifications.delete.all'),
(181, 'Notifications Delete Single', 'AdminController', 'admin.notifications.delete.single'),
(183, 'System Setting', 'GeneralSettingController', 'admin.setting.system'),
(184, 'General Setting', 'GeneralSettingController', 'admin.setting.general'),
(189, 'Sitemap Setting', 'GeneralSettingController', 'admin.setting.sitemap'),
(191, 'Robot Setting', 'GeneralSettingController', 'admin.setting.robot'),
(193, 'Notification Global Email', 'NotificationController', 'admin.setting.notification.global.email'),
(194, 'Notification Global Email Update', 'NotificationController', 'admin.setting.notification.global.email.update'),
(195, 'Notification Global SMS', 'NotificationController', 'admin.setting.notification.global.sms'),
(196, 'Notification Global SMS Update', 'NotificationController', 'admin.setting.notification.global.sms.update'),
(201, 'System Update', 'SystemController', 'admin.system.update'),
(202, 'System Update Process', 'SystemController', 'admin.system.update.process'),
(203, 'System Update Log', 'SystemController', 'admin.system.update.log'),
(204, 'Banned', 'AdminController', 'admin.banned'),
(205, 'Request Report Store', 'AdminController', 'admin.request.report.store'),
(206, 'General Update Setting', 'GeneralSettingController', 'admin.setting.general.update'),
(207, 'System Configuration Update Setting', 'GeneralSettingController', 'admin.setting.system.configuration.update'),
(208, 'Notification Email Update', 'NotificationController', 'admin.setting.notification.email.update'),
(209, 'Setting Notification SMS Update', 'NotificationController', 'admin.setting.notification.sms.update'),
(210, 'Sitemap Update Setting', 'GeneralSettingController', 'admin.setting.sitemap.update'),
(211, 'Robot Update Setting', 'GeneralSettingController', 'admin.setting.robot.update'),
(212, 'Warehouse Status', 'WarehouseController', 'admin.warehouse.status'),
(213, 'Customer List', 'CustomerController', 'admin.customer.list'),
(214, 'Customer Segment Count', 'CustomerController', 'admin.customer.segment.count'),
(215, 'Customer Notification History', 'CustomerController', 'admin.customer.notification.history'),
(216, 'Extensions Index', 'ExtensionController', 'admin.extensions.index'),
(217, 'Extensions Update', 'ExtensionController', 'admin.extensions.update'),
(218, 'Extensions Status', 'ExtensionController', 'admin.extensions.status'),
(219, 'Chart Purchase Sale', 'AdminController', 'admin.chart.purchase.sale'),
(220, 'Chart Sales Return', 'AdminController', 'admin.chart.sales.return'),
(221, 'Chart Purchases Return', 'AdminController', 'admin.chart.purchases.return');

-- --------------------------------------------------------

--
-- Table structure for table `permission_role`
--

CREATE TABLE `permission_role` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `permission_id` bigint(20) UNSIGNED NOT NULL,
  `role_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `permission_role`
--

INSERT INTO `permission_role` (`id`, `permission_id`, `role_id`) VALUES
(1, 2, 1),
(2, 3, 1),
(3, 5, 1),
(4, 177, 1),
(5, 204, 1),
(6, 10, 1),
(7, 11, 1),
(8, 12, 1);

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL COMMENT 'Product Name',
  `image` varchar(255) DEFAULT NULL,
  `category_id` int(10) UNSIGNED NOT NULL,
  `brand_id` int(10) UNSIGNED DEFAULT NULL,
  `unit_id` int(11) DEFAULT NULL,
  `sku` varchar(40) NOT NULL COMMENT 'Stock-keeping-unit',
  `alert_quantity` int(10) UNSIGNED DEFAULT NULL,
  `note` varchar(255) DEFAULT NULL,
  `total_sale` int(11) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `name`, `image`, `category_id`, `brand_id`, `unit_id`, `sku`, `alert_quantity`, `note`, `total_sale`, `created_at`, `updated_at`) VALUES
(1, 'Product Ont', '68876d588b8741753705816.png', 1, 1, 1, 'SKU001', 10, 'Demo Product', 0, '2025-07-28 12:30:16', '2025-07-28 12:30:16');

-- --------------------------------------------------------

--
-- Table structure for table `product_stocks`
--

CREATE TABLE `product_stocks` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `product_id` int(10) UNSIGNED NOT NULL,
  `warehouse_id` int(10) UNSIGNED NOT NULL,
  `quantity` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `product_stocks`
--

INSERT INTO `product_stocks` (`id`, `product_id`, `warehouse_id`, `quantity`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 15, '2025-07-28 12:35:06', '2025-07-28 12:35:06');

-- --------------------------------------------------------

--
-- Table structure for table `purchases`
--

CREATE TABLE `purchases` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `supplier_id` int(10) UNSIGNED NOT NULL,
  `invoice_no` varchar(255) NOT NULL,
  `warehouse_id` int(10) UNSIGNED NOT NULL,
  `purchase_date` date DEFAULT NULL,
  `total_price` decimal(28,8) NOT NULL DEFAULT 0.00000000,
  `discount_amount` decimal(28,8) NOT NULL DEFAULT 0.00000000,
  `payable_amount` decimal(28,8) NOT NULL DEFAULT 0.00000000,
  `paid_amount` decimal(28,8) NOT NULL DEFAULT 0.00000000,
  `due_amount` decimal(28,8) NOT NULL DEFAULT 0.00000000,
  `note` text DEFAULT NULL,
  `return_status` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `purchases`
--

INSERT INTO `purchases` (`id`, `supplier_id`, `invoice_no`, `warehouse_id`, `purchase_date`, `total_price`, `discount_amount`, `payable_amount`, `paid_amount`, `due_amount`, `note`, `return_status`, `created_at`, `updated_at`) VALUES
(1, 1, 'INV0001', 1, '2025-07-28', 1500.00000000, 10.00000000, 1490.00000000, 0.00000000, 1490.00000000, NULL, 0, '2025-07-28 12:35:06', '2025-07-28 12:35:06');

-- --------------------------------------------------------

--
-- Table structure for table `purchase_details`
--

CREATE TABLE `purchase_details` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `purchase_id` int(10) UNSIGNED NOT NULL,
  `product_id` int(10) UNSIGNED NOT NULL,
  `quantity` int(10) UNSIGNED NOT NULL,
  `price` double(28,8) NOT NULL DEFAULT 0.00000000,
  `total` double(28,8) NOT NULL DEFAULT 0.00000000,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `purchase_details`
--

INSERT INTO `purchase_details` (`id`, `purchase_id`, `product_id`, `quantity`, `price`, `total`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 15, 100.00000000, 1500.00000000, '2025-07-28 12:35:06', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `purchase_returns`
--

CREATE TABLE `purchase_returns` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `purchase_id` int(10) UNSIGNED NOT NULL,
  `supplier_id` int(10) UNSIGNED NOT NULL,
  `return_date` date NOT NULL,
  `total_price` decimal(28,8) NOT NULL DEFAULT 0.00000000,
  `discount_amount` decimal(28,8) NOT NULL DEFAULT 0.00000000,
  `receivable_amount` decimal(28,8) NOT NULL DEFAULT 0.00000000,
  `received_amount` decimal(28,8) NOT NULL DEFAULT 0.00000000,
  `due_amount` decimal(28,8) NOT NULL DEFAULT 0.00000000,
  `note` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `purchase_return_details`
--

CREATE TABLE `purchase_return_details` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `purchase_return_id` int(10) UNSIGNED NOT NULL,
  `product_id` int(10) UNSIGNED NOT NULL,
  `quantity` int(10) UNSIGNED NOT NULL,
  `price` double(28,8) NOT NULL DEFAULT 0.00000000,
  `total` double(28,8) NOT NULL DEFAULT 0.00000000
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(40) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id`, `name`, `created_at`, `updated_at`) VALUES
(1, 'User', '2025-07-28 06:41:21', '2025-07-28 06:41:21');

-- --------------------------------------------------------

--
-- Table structure for table `sales`
--

CREATE TABLE `sales` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `customer_id` int(10) UNSIGNED NOT NULL,
  `invoice_no` varchar(255) NOT NULL,
  `warehouse_id` int(10) UNSIGNED NOT NULL,
  `sale_date` date NOT NULL,
  `total_price` decimal(28,8) NOT NULL DEFAULT 0.00000000,
  `discount_amount` decimal(28,8) NOT NULL DEFAULT 0.00000000,
  `receivable_amount` decimal(28,8) NOT NULL DEFAULT 0.00000000,
  `received_amount` decimal(28,8) NOT NULL DEFAULT 0.00000000,
  `due_amount` decimal(28,8) NOT NULL DEFAULT 0.00000000,
  `note` text DEFAULT NULL,
  `return_status` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `sale_details`
--

CREATE TABLE `sale_details` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `sale_id` int(10) UNSIGNED NOT NULL,
  `product_id` int(10) UNSIGNED NOT NULL,
  `quantity` int(10) UNSIGNED NOT NULL,
  `price` double NOT NULL,
  `total` double NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `sale_returns`
--

CREATE TABLE `sale_returns` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `sale_id` int(10) UNSIGNED NOT NULL,
  `customer_id` int(10) UNSIGNED NOT NULL,
  `return_date` date NOT NULL,
  `total_price` decimal(28,8) NOT NULL DEFAULT 0.00000000,
  `discount_amount` decimal(28,8) NOT NULL DEFAULT 0.00000000,
  `payable_amount` decimal(28,8) NOT NULL,
  `paid_amount` decimal(28,8) NOT NULL DEFAULT 0.00000000,
  `due_amount` decimal(28,8) NOT NULL DEFAULT 0.00000000,
  `note` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `sale_return_details`
--

CREATE TABLE `sale_return_details` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `sale_return_id` int(10) UNSIGNED NOT NULL,
  `product_id` int(10) UNSIGNED NOT NULL,
  `quantity` int(10) UNSIGNED NOT NULL,
  `price` double(28,8) NOT NULL DEFAULT 0.00000000,
  `total` double(28,8) NOT NULL DEFAULT 0.00000000
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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

-- --------------------------------------------------------

--
-- Table structure for table `sites`
--

CREATE TABLE `sites` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `zone_id` bigint(20) UNSIGNED DEFAULT NULL,
  `name` varchar(191) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sites`
--

INSERT INTO `sites` (`id`, `zone_id`, `name`, `created_at`, `updated_at`) VALUES
(3, 5, 'SOmething1', '2025-11-12 18:45:06', '2025-11-12 18:45:06'),
(4, 6, 'Somewhere', '2025-11-12 18:45:20', '2025-11-12 18:45:20'),
(5, 7, 'Near You', '2025-11-12 18:46:20', '2025-11-12 18:46:20');

-- --------------------------------------------------------

--
-- Table structure for table `suppliers`
--

CREATE TABLE `suppliers` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(40) NOT NULL,
  `email` varchar(40) NOT NULL,
  `mobile` varchar(40) NOT NULL,
  `address` text DEFAULT NULL,
  `company_name` varchar(40) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `suppliers`
--

INSERT INTO `suppliers` (`id`, `name`, `email`, `mobile`, `address`, `company_name`, `created_at`, `updated_at`) VALUES
(1, 'Satyam Maurya', 'satyammaurya@gmail.com', '8874461586', 'Dahisar East', 'Aspirant Solutions', '2025-07-28 06:39:39', '2025-07-28 06:39:39');

-- --------------------------------------------------------

--
-- Table structure for table `supplier_payments`
--

CREATE TABLE `supplier_payments` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `supplier_id` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `purchase_id` int(10) UNSIGNED DEFAULT NULL,
  `purchase_return_id` int(10) UNSIGNED DEFAULT NULL,
  `amount` decimal(28,2) UNSIGNED NOT NULL DEFAULT 0.00,
  `trx` varchar(40) NOT NULL,
  `remark` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `transfers`
--

CREATE TABLE `transfers` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tracking_no` varchar(40) DEFAULT NULL,
  `from_warehouse_id` int(10) UNSIGNED NOT NULL,
  `to_warehouse_id` int(10) UNSIGNED NOT NULL,
  `transfer_date` date DEFAULT NULL,
  `note` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `transfer_details`
--

CREATE TABLE `transfer_details` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `transfer_id` int(10) UNSIGNED NOT NULL,
  `product_id` int(10) UNSIGNED NOT NULL,
  `quantity` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `units`
--

CREATE TABLE `units` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(40) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `units`
--

INSERT INTO `units` (`id`, `name`, `created_at`, `updated_at`) VALUES
(1, 'Unit One', '2025-07-28 12:28:26', '2025-07-28 12:28:26');

-- --------------------------------------------------------

--
-- Table structure for table `update_logs`
--

CREATE TABLE `update_logs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `version` varchar(40) DEFAULT NULL,
  `update_log` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `warehouses`
--

CREATE TABLE `warehouses` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(40) NOT NULL,
  `address` text NOT NULL,
  `status` tinyint(4) NOT NULL DEFAULT 1 COMMENT '''Active''=>1 and ''Deactive''=>0 ',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `warehouses`
--

INSERT INTO `warehouses` (`id`, `name`, `address`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Dahisar East', 'Dahisar east', 1, '2025-07-28 06:23:06', '2025-07-28 06:23:06'),
(2, 'Sandhya Nishad', 'kashimira', 1, '2025-11-09 20:31:29', '2025-11-09 20:32:05');

-- --------------------------------------------------------

--
-- Table structure for table `zones`
--

CREATE TABLE `zones` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(100) NOT NULL,
  `address` varchar(500) DEFAULT NULL,
  `status` tinyint(4) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `zones`
--

INSERT INTO `zones` (`id`, `name`, `address`, `status`, `created_at`, `updated_at`) VALUES
(5, 'Sandhya Nishad', 'Miraroad', 1, '2025-11-12 18:44:43', '2025-11-12 18:45:48'),
(6, 'sandhya', 'Miraroad', 1, '2025-11-12 18:45:20', '2025-11-12 18:45:40'),
(7, 'Sharjah', 'Dahisar', 1, '2025-11-12 18:46:20', '2025-11-12 18:46:20'),
(8, 'Sandhya2', 'kashimira', 1, '2025-11-12 20:21:52', '2025-11-12 20:21:52');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `actions`
--
ALTER TABLE `actions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `adjustments`
--
ALTER TABLE `adjustments`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `adjustment_details`
--
ALTER TABLE `adjustment_details`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `admins`
--
ALTER TABLE `admins`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`,`username`);

--
-- Indexes for table `admin_notifications`
--
ALTER TABLE `admin_notifications`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `admin_password_resets`
--
ALTER TABLE `admin_password_resets`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `brands`
--
ALTER TABLE `brands`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `cache`
--
ALTER TABLE `cache`
  ADD PRIMARY KEY (`key`);

--
-- Indexes for table `cache_locks`
--
ALTER TABLE `cache_locks`
  ADD PRIMARY KEY (`key`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `mobile` (`mobile`),
  ADD KEY `customers_site_id_foreign` (`site_id`);

--
-- Indexes for table `customer_payments`
--
ALTER TABLE `customer_payments`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `expenses`
--
ALTER TABLE `expenses`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `expense_types`
--
ALTER TABLE `expense_types`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `extensions`
--
ALTER TABLE `extensions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `general_settings`
--
ALTER TABLE `general_settings`
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
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `notification_logs`
--
ALTER TABLE `notification_logs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `notification_templates`
--
ALTER TABLE `notification_templates`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`);

--
-- Indexes for table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Indexes for table `permissions`
--
ALTER TABLE `permissions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `permission_role`
--
ALTER TABLE `permission_role`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `product_stocks`
--
ALTER TABLE `product_stocks`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `purchases`
--
ALTER TABLE `purchases`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `purchase_details`
--
ALTER TABLE `purchase_details`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `purchase_returns`
--
ALTER TABLE `purchase_returns`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `purchase_return_details`
--
ALTER TABLE `purchase_return_details`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sales`
--
ALTER TABLE `sales`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sale_details`
--
ALTER TABLE `sale_details`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sale_returns`
--
ALTER TABLE `sale_returns`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sale_return_details`
--
ALTER TABLE `sale_return_details`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_index` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);

--
-- Indexes for table `sites`
--
ALTER TABLE `sites`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sites_zone_id_foreign` (`zone_id`);

--
-- Indexes for table `suppliers`
--
ALTER TABLE `suppliers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `suppliers_email_unique` (`email`),
  ADD UNIQUE KEY `suppliers_mobile_unique` (`mobile`);

--
-- Indexes for table `supplier_payments`
--
ALTER TABLE `supplier_payments`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `transfers`
--
ALTER TABLE `transfers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `transfer_details`
--
ALTER TABLE `transfer_details`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `units`
--
ALTER TABLE `units`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `update_logs`
--
ALTER TABLE `update_logs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- Indexes for table `warehouses`
--
ALTER TABLE `warehouses`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `zones`
--
ALTER TABLE `zones`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `zones_name_unique` (`name`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `actions`
--
ALTER TABLE `actions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `adjustments`
--
ALTER TABLE `adjustments`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `adjustment_details`
--
ALTER TABLE `adjustment_details`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `admins`
--
ALTER TABLE `admins`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `admin_notifications`
--
ALTER TABLE `admin_notifications`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `admin_password_resets`
--
ALTER TABLE `admin_password_resets`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `brands`
--
ALTER TABLE `brands`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `customers`
--
ALTER TABLE `customers`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `customer_payments`
--
ALTER TABLE `customer_payments`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `expenses`
--
ALTER TABLE `expenses`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `expense_types`
--
ALTER TABLE `expense_types`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `extensions`
--
ALTER TABLE `extensions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `general_settings`
--
ALTER TABLE `general_settings`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `notification_logs`
--
ALTER TABLE `notification_logs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `notification_templates`
--
ALTER TABLE `notification_templates`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `permissions`
--
ALTER TABLE `permissions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=222;

--
-- AUTO_INCREMENT for table `permission_role`
--
ALTER TABLE `permission_role`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `product_stocks`
--
ALTER TABLE `product_stocks`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `purchases`
--
ALTER TABLE `purchases`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `purchase_details`
--
ALTER TABLE `purchase_details`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `purchase_returns`
--
ALTER TABLE `purchase_returns`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `purchase_return_details`
--
ALTER TABLE `purchase_return_details`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `sales`
--
ALTER TABLE `sales`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `sale_details`
--
ALTER TABLE `sale_details`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `sale_returns`
--
ALTER TABLE `sale_returns`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `sale_return_details`
--
ALTER TABLE `sale_return_details`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `sites`
--
ALTER TABLE `sites`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `suppliers`
--
ALTER TABLE `suppliers`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `supplier_payments`
--
ALTER TABLE `supplier_payments`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `transfers`
--
ALTER TABLE `transfers`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `transfer_details`
--
ALTER TABLE `transfer_details`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `units`
--
ALTER TABLE `units`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `update_logs`
--
ALTER TABLE `update_logs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `warehouses`
--
ALTER TABLE `warehouses`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `zones`
--
ALTER TABLE `zones`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `customers`
--
ALTER TABLE `customers`
  ADD CONSTRAINT `customers_site_id_foreign` FOREIGN KEY (`site_id`) REFERENCES `sites` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `sites`
--
ALTER TABLE `sites`
  ADD CONSTRAINT `sites_zone_id_foreign` FOREIGN KEY (`zone_id`) REFERENCES `zones` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
