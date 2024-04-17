-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: 17 أبريل 2024 الساعة 20:59
-- إصدار الخادم: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `laqahy`
--

-- --------------------------------------------------------

--
-- بنية الجدول `branches`
--

CREATE TABLE `branches` (
  `branch_id` int(11) NOT NULL,
  `branch_name` varchar(150) NOT NULL,
  `branch_hc_name` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- إرجاع أو استيراد بيانات الجدول `branches`
--

INSERT INTO `branches` (`branch_id`, `branch_name`, `branch_hc_name`) VALUES
(1, 'فرع بيرباشا', 3),
(2, 'فرع التحرير الاسفل', 3);

-- --------------------------------------------------------

--
-- بنية الجدول `center_vax_store`
--

CREATE TABLE `center_vax_store` (
  `center_vax_id` int(11) NOT NULL,
  `vactype_type` int(11) NOT NULL,
  `health_center` int(11) NOT NULL,
  `center_vax_quantity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- بنية الجدول `child statement`
--

CREATE TABLE `child statement` (
  `cs_id` int(11) NOT NULL,
  `cs_child_name` int(11) DEFAULT NULL,
  `cs_health_center` int(11) DEFAULT NULL,
  `cs_branch_name` int(11) DEFAULT NULL,
  `cs_emp_name` int(11) DEFAULT NULL,
  `cs_vaccine_type` int(11) DEFAULT NULL,
  `cs_visit_type` int(11) DEFAULT NULL,
  `cs_dosage_type` int(11) DEFAULT NULL,
  `cs_dosage_date` date NOT NULL,
  `cs_return_date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- بنية الجدول `child_data`
--

CREATE TABLE `child_data` (
  `child_id` int(11) NOT NULL,
  `child_name` varchar(150) NOT NULL,
  `child_mother_name` int(11) DEFAULT NULL,
  `child_birthdate` date NOT NULL,
  `child_place_birth` varchar(150) NOT NULL,
  `child_gender` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- بنية الجدول `cities`
--

CREATE TABLE `cities` (
  `city_id` int(11) NOT NULL,
  `city_name` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- إرجاع أو استيراد بيانات الجدول `cities`
--

INSERT INTO `cities` (`city_id`, `city_name`) VALUES
(1, 'تعز'),
(2, 'صنعاء'),
(3, 'عدن');

-- --------------------------------------------------------

--
-- بنية الجدول `directorates`
--

CREATE TABLE `directorates` (
  `directorate_id` int(11) NOT NULL,
  `directorate_name` varchar(150) NOT NULL,
  `directorate_city_name` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- إرجاع أو استيراد بيانات الجدول `directorates`
--

INSERT INTO `directorates` (`directorate_id`, `directorate_name`, `directorate_city_name`) VALUES
(1, 'المظفر', 1),
(2, 'القاهرة', 1),
(3, 'صالة', 1),
(6, 'الشيخ عثمان', 3);

-- --------------------------------------------------------

--
-- بنية الجدول `dosage_levels`
--

CREATE TABLE `dosage_levels` (
  `dl_id` int(11) NOT NULL,
  `dl_level` varchar(150) NOT NULL,
  `dl_dosage_type` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- بنية الجدول `dosage_type`
--

CREATE TABLE `dosage_type` (
  `dt_id` int(11) NOT NULL,
  `dt_type` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- بنية الجدول `employees`
--

CREATE TABLE `employees` (
  `emp_id` int(11) NOT NULL,
  `emp_name` varchar(150) NOT NULL,
  `emp_phone` varchar(150) NOT NULL,
  `emp_address` varchar(150) NOT NULL,
  `emp_health_center` int(11) DEFAULT NULL,
  `emp_branch_name` int(11) DEFAULT NULL,
  `emp_birthdate` date NOT NULL,
  `emp_gender` int(11) DEFAULT NULL,
  `emp_username` varchar(150) NOT NULL,
  `emp_password` varchar(150) NOT NULL,
  `emp_permission_type` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- إرجاع أو استيراد بيانات الجدول `employees`
--

INSERT INTO `employees` (`emp_id`, `emp_name`, `emp_phone`, `emp_address`, `emp_health_center`, `emp_branch_name`, `emp_birthdate`, `emp_gender`, `emp_username`, `emp_password`, `emp_permission_type`) VALUES
(2, 'حسام خالد سعيد علي الزريقي', '772957881', 'تعز - باب موسى', 2, 1, '2002-07-21', 1, 'hussam772', '123456789', 2);

-- --------------------------------------------------------

--
-- بنية الجدول `gender`
--

CREATE TABLE `gender` (
  `gender_id` int(11) NOT NULL,
  `gender_type` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- إرجاع أو استيراد بيانات الجدول `gender`
--

INSERT INTO `gender` (`gender_id`, `gender_type`) VALUES
(1, 'ذكر'),
(2, 'انثى');

-- --------------------------------------------------------

--
-- بنية الجدول `health_centers`
--

CREATE TABLE `health_centers` (
  `hc_id` int(11) NOT NULL,
  `hc_name` varchar(150) NOT NULL,
  `hc_phone` varchar(150) NOT NULL,
  `hc_address` varchar(150) NOT NULL,
  `hc_city` int(11) DEFAULT NULL,
  `hc_directorate` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- إرجاع أو استيراد بيانات الجدول `health_centers`
--

INSERT INTO `health_centers` (`hc_id`, `hc_name`, `hc_phone`, `hc_address`, `hc_city`, `hc_directorate`) VALUES
(1, 'مستوصف التعاون', '777777777-733333333', 'المسبح - جوار حديقة التعاون', 1, 2),
(2, 'مستوصف المظفر', '777777777-733333333', 'حي الميدان - جوار مجمع هائل للبنات', 1, 1),
(3, 'مركز التضامن', '777777777-733333333', 'بيرباشا - جوار نادي الصقر', 1, 1);

-- --------------------------------------------------------

--
-- بنية الجدول `ministry_vax_store`
--

CREATE TABLE `ministry_vax_store` (
  `ministry_vax_id` int(11) NOT NULL,
  `vactype_type` int(11) NOT NULL,
  `ministry_vax_quantity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- بنية الجدول `ministry_vax_store_statement`
--

CREATE TABLE `ministry_vax_store_statement` (
  `mvs_id` int(11) NOT NULL,
  `vactype_type` int(11) NOT NULL,
  `mvs_source` text NOT NULL,
  `mvs_quantity` int(11) NOT NULL,
  `mvs_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `mvs_details` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- بنية الجدول `mother_data`
--

CREATE TABLE `mother_data` (
  `mother_id` int(11) NOT NULL,
  `mother_name` varchar(150) NOT NULL,
  `mother_phone` varchar(150) NOT NULL,
  `identity_num` varchar(15) NOT NULL,
  `mother_birthdate` date NOT NULL,
  `mother_city` int(11) DEFAULT NULL,
  `mother_directorate` int(11) DEFAULT NULL,
  `mother_village` varchar(150) NOT NULL,
  `mother_health_center` int(11) DEFAULT NULL,
  `mother_branch_name` int(11) DEFAULT NULL,
  `mother_password` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- بنية الجدول `mother_statement`
--

CREATE TABLE `mother_statement` (
  `ms_id` int(11) NOT NULL,
  `ms_mother_name` int(11) DEFAULT NULL,
  `ms_health_center` int(11) DEFAULT NULL,
  `ms_branch_name` int(11) DEFAULT NULL,
  `ms_emp_name` int(11) DEFAULT NULL,
  `ms_dosage_date` date NOT NULL,
  `ms_dosage_level` int(11) DEFAULT NULL,
  `ms_dosage_type` int(11) DEFAULT NULL,
  `ms_return_date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- بنية الجدول `orders`
--

CREATE TABLE `orders` (
  `order_id` int(11) NOT NULL,
  `health_center` int(11) NOT NULL,
  `vactype_type` int(11) NOT NULL,
  `order_date` datetime NOT NULL,
  `order_delivery_date` datetime NOT NULL,
  `order_quantity` int(11) NOT NULL,
  `order_status` int(11) NOT NULL,
  `order_center_comment` text DEFAULT NULL,
  `order_ministry_comment` text DEFAULT NULL,
  `ministry_deleted_at` datetime DEFAULT NULL,
  `center_deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- بنية الجدول `order_status`
--

CREATE TABLE `order_status` (
  `oreder_status_id` int(11) NOT NULL,
  `order_status` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- إرجاع أو استيراد بيانات الجدول `order_status`
--

INSERT INTO `order_status` (`oreder_status_id`, `order_status`) VALUES
(1, 'صادرة'),
(2, 'قيد الاستلام'),
(3, 'تم التسليم'),
(4, 'ملغية');

-- --------------------------------------------------------

--
-- بنية الجدول `permission_type`
--

CREATE TABLE `permission_type` (
  `pt_id` int(11) NOT NULL,
  `pt_type` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- إرجاع أو استيراد بيانات الجدول `permission_type`
--

INSERT INTO `permission_type` (`pt_id`, `pt_type`) VALUES
(1, 'user'),
(2, 'admin');

-- --------------------------------------------------------

--
-- بنية الجدول `posts`
--

CREATE TABLE `posts` (
  `post_id` int(11) NOT NULL,
  `post_title` varchar(300) NOT NULL,
  `post_description` text NOT NULL,
  `post_image` text NOT NULL,
  `post_date` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- بنية الجدول `vaccine_type`
--

CREATE TABLE `vaccine_type` (
  `vactype_id` int(11) NOT NULL,
  `vactype_type` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- بنية الجدول `vaccine_with_dosage`
--

CREATE TABLE `vaccine_with_dosage` (
  `vaccine_type` int(11) DEFAULT NULL,
  `dosage_type` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- بنية الجدول `visit_type`
--

CREATE TABLE `visit_type` (
  `vt_id` int(11) NOT NULL,
  `vt_period` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- بنية الجدول `visit_with_vaccine`
--

CREATE TABLE `visit_with_vaccine` (
  `visit_type` int(11) DEFAULT NULL,
  `vaccine_type` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `branches`
--
ALTER TABLE `branches`
  ADD PRIMARY KEY (`branch_id`),
  ADD KEY `branch_hc_name` (`branch_hc_name`);

--
-- Indexes for table `center_vax_store`
--
ALTER TABLE `center_vax_store`
  ADD PRIMARY KEY (`center_vax_id`),
  ADD KEY `health_center` (`health_center`),
  ADD KEY `vactype_type` (`vactype_type`);

--
-- Indexes for table `child statement`
--
ALTER TABLE `child statement`
  ADD PRIMARY KEY (`cs_id`),
  ADD KEY `cs_child_name` (`cs_child_name`),
  ADD KEY `cs_dosage_type` (`cs_dosage_type`),
  ADD KEY `cs_emp_name` (`cs_emp_name`),
  ADD KEY `cs_health_center` (`cs_health_center`),
  ADD KEY `cs_vaccine_type` (`cs_vaccine_type`),
  ADD KEY `cs_visit_type` (`cs_visit_type`),
  ADD KEY `cs_branch_name` (`cs_branch_name`);

--
-- Indexes for table `child_data`
--
ALTER TABLE `child_data`
  ADD PRIMARY KEY (`child_id`),
  ADD KEY `child_gender` (`child_gender`),
  ADD KEY `child_mother_name` (`child_mother_name`);

--
-- Indexes for table `cities`
--
ALTER TABLE `cities`
  ADD PRIMARY KEY (`city_id`);

--
-- Indexes for table `directorates`
--
ALTER TABLE `directorates`
  ADD PRIMARY KEY (`directorate_id`),
  ADD KEY `directorates_ibfk_1` (`directorate_city_name`);

--
-- Indexes for table `dosage_levels`
--
ALTER TABLE `dosage_levels`
  ADD PRIMARY KEY (`dl_id`),
  ADD KEY `dl_dosage_type` (`dl_dosage_type`);

--
-- Indexes for table `dosage_type`
--
ALTER TABLE `dosage_type`
  ADD PRIMARY KEY (`dt_id`);

--
-- Indexes for table `employees`
--
ALTER TABLE `employees`
  ADD PRIMARY KEY (`emp_id`),
  ADD KEY `emp_gender` (`emp_gender`),
  ADD KEY `emp_health_center` (`emp_health_center`),
  ADD KEY `emp_permission_type` (`emp_permission_type`),
  ADD KEY `employees_ibfk_4` (`emp_branch_name`);

--
-- Indexes for table `gender`
--
ALTER TABLE `gender`
  ADD PRIMARY KEY (`gender_id`);

--
-- Indexes for table `health_centers`
--
ALTER TABLE `health_centers`
  ADD PRIMARY KEY (`hc_id`),
  ADD KEY `hc_city` (`hc_city`),
  ADD KEY `hc_directorate` (`hc_directorate`);

--
-- Indexes for table `ministry_vax_store`
--
ALTER TABLE `ministry_vax_store`
  ADD PRIMARY KEY (`ministry_vax_id`),
  ADD KEY `vactype_type` (`vactype_type`);

--
-- Indexes for table `ministry_vax_store_statement`
--
ALTER TABLE `ministry_vax_store_statement`
  ADD PRIMARY KEY (`mvs_id`),
  ADD KEY `vactype_type` (`vactype_type`);

--
-- Indexes for table `mother_data`
--
ALTER TABLE `mother_data`
  ADD PRIMARY KEY (`mother_id`),
  ADD KEY `mother_city` (`mother_city`),
  ADD KEY `mother_directorate` (`mother_directorate`),
  ADD KEY `mother_health_center` (`mother_health_center`),
  ADD KEY `mother_branch_name` (`mother_branch_name`);

--
-- Indexes for table `mother_statement`
--
ALTER TABLE `mother_statement`
  ADD PRIMARY KEY (`ms_id`),
  ADD KEY `ms_dosage_level` (`ms_dosage_level`),
  ADD KEY `ms_dosage_type` (`ms_dosage_type`),
  ADD KEY `ms_emp_name` (`ms_emp_name`),
  ADD KEY `ms_health_center` (`ms_health_center`),
  ADD KEY `ms_mother_name` (`ms_mother_name`),
  ADD KEY `ms_branch_name` (`ms_branch_name`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`order_id`),
  ADD KEY `health_center` (`health_center`),
  ADD KEY `vactype_type` (`vactype_type`),
  ADD KEY `order_status` (`order_status`);

--
-- Indexes for table `order_status`
--
ALTER TABLE `order_status`
  ADD PRIMARY KEY (`oreder_status_id`);

--
-- Indexes for table `permission_type`
--
ALTER TABLE `permission_type`
  ADD PRIMARY KEY (`pt_id`);

--
-- Indexes for table `posts`
--
ALTER TABLE `posts`
  ADD PRIMARY KEY (`post_id`);

--
-- Indexes for table `vaccine_type`
--
ALTER TABLE `vaccine_type`
  ADD PRIMARY KEY (`vactype_id`);

--
-- Indexes for table `vaccine_with_dosage`
--
ALTER TABLE `vaccine_with_dosage`
  ADD KEY `dosage_type` (`dosage_type`),
  ADD KEY `vaccine_type` (`vaccine_type`);

--
-- Indexes for table `visit_type`
--
ALTER TABLE `visit_type`
  ADD PRIMARY KEY (`vt_id`);

--
-- Indexes for table `visit_with_vaccine`
--
ALTER TABLE `visit_with_vaccine`
  ADD KEY `vaccine_type` (`vaccine_type`),
  ADD KEY `visit_type` (`visit_type`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `branches`
--
ALTER TABLE `branches`
  MODIFY `branch_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `center_vax_store`
--
ALTER TABLE `center_vax_store`
  MODIFY `center_vax_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `child statement`
--
ALTER TABLE `child statement`
  MODIFY `cs_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `child_data`
--
ALTER TABLE `child_data`
  MODIFY `child_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `cities`
--
ALTER TABLE `cities`
  MODIFY `city_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `directorates`
--
ALTER TABLE `directorates`
  MODIFY `directorate_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `dosage_levels`
--
ALTER TABLE `dosage_levels`
  MODIFY `dl_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `dosage_type`
--
ALTER TABLE `dosage_type`
  MODIFY `dt_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `employees`
--
ALTER TABLE `employees`
  MODIFY `emp_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `gender`
--
ALTER TABLE `gender`
  MODIFY `gender_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `health_centers`
--
ALTER TABLE `health_centers`
  MODIFY `hc_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `ministry_vax_store`
--
ALTER TABLE `ministry_vax_store`
  MODIFY `ministry_vax_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ministry_vax_store_statement`
--
ALTER TABLE `ministry_vax_store_statement`
  MODIFY `mvs_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mother_data`
--
ALTER TABLE `mother_data`
  MODIFY `mother_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mother_statement`
--
ALTER TABLE `mother_statement`
  MODIFY `ms_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `order_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `order_status`
--
ALTER TABLE `order_status`
  MODIFY `oreder_status_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `permission_type`
--
ALTER TABLE `permission_type`
  MODIFY `pt_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `posts`
--
ALTER TABLE `posts`
  MODIFY `post_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `vaccine_type`
--
ALTER TABLE `vaccine_type`
  MODIFY `vactype_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `visit_type`
--
ALTER TABLE `visit_type`
  MODIFY `vt_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- قيود الجداول المُلقاة.
--

--
-- قيود الجداول `branches`
--
ALTER TABLE `branches`
  ADD CONSTRAINT `branches_ibfk_1` FOREIGN KEY (`branch_hc_name`) REFERENCES `health_centers` (`hc_id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- قيود الجداول `center_vax_store`
--
ALTER TABLE `center_vax_store`
  ADD CONSTRAINT `center_vax_store_ibfk_1` FOREIGN KEY (`health_center`) REFERENCES `health_centers` (`hc_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `center_vax_store_ibfk_2` FOREIGN KEY (`vactype_type`) REFERENCES `vaccine_type` (`vactype_id`) ON UPDATE CASCADE;

--
-- قيود الجداول `child statement`
--
ALTER TABLE `child statement`
  ADD CONSTRAINT `child statement_ibfk_1` FOREIGN KEY (`cs_child_name`) REFERENCES `child_data` (`child_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `child statement_ibfk_2` FOREIGN KEY (`cs_dosage_type`) REFERENCES `dosage_type` (`dt_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `child statement_ibfk_3` FOREIGN KEY (`cs_emp_name`) REFERENCES `employees` (`emp_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `child statement_ibfk_4` FOREIGN KEY (`cs_health_center`) REFERENCES `health_centers` (`hc_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `child statement_ibfk_5` FOREIGN KEY (`cs_vaccine_type`) REFERENCES `vaccine_type` (`vactype_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `child statement_ibfk_6` FOREIGN KEY (`cs_visit_type`) REFERENCES `visit_type` (`vt_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `child statement_ibfk_7` FOREIGN KEY (`cs_branch_name`) REFERENCES `branches` (`branch_id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- قيود الجداول `child_data`
--
ALTER TABLE `child_data`
  ADD CONSTRAINT `child_data_ibfk_3` FOREIGN KEY (`child_gender`) REFERENCES `gender` (`gender_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `child_data_ibfk_4` FOREIGN KEY (`child_mother_name`) REFERENCES `mother_data` (`mother_id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- قيود الجداول `directorates`
--
ALTER TABLE `directorates`
  ADD CONSTRAINT `directorates_ibfk_1` FOREIGN KEY (`directorate_city_name`) REFERENCES `cities` (`city_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- قيود الجداول `dosage_levels`
--
ALTER TABLE `dosage_levels`
  ADD CONSTRAINT `dosage_levels_ibfk_1` FOREIGN KEY (`dl_dosage_type`) REFERENCES `dosage_type` (`dt_id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- قيود الجداول `employees`
--
ALTER TABLE `employees`
  ADD CONSTRAINT `employees_ibfk_1` FOREIGN KEY (`emp_gender`) REFERENCES `gender` (`gender_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `employees_ibfk_2` FOREIGN KEY (`emp_health_center`) REFERENCES `health_centers` (`hc_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `employees_ibfk_3` FOREIGN KEY (`emp_permission_type`) REFERENCES `permission_type` (`pt_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `employees_ibfk_4` FOREIGN KEY (`emp_branch_name`) REFERENCES `branches` (`branch_id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- قيود الجداول `health_centers`
--
ALTER TABLE `health_centers`
  ADD CONSTRAINT `health_centers_ibfk_1` FOREIGN KEY (`hc_city`) REFERENCES `cities` (`city_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `health_centers_ibfk_2` FOREIGN KEY (`hc_directorate`) REFERENCES `directorates` (`directorate_id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- قيود الجداول `ministry_vax_store`
--
ALTER TABLE `ministry_vax_store`
  ADD CONSTRAINT `ministry_vax_store_ibfk_1` FOREIGN KEY (`vactype_type`) REFERENCES `vaccine_type` (`vactype_id`) ON UPDATE CASCADE;

--
-- قيود الجداول `ministry_vax_store_statement`
--
ALTER TABLE `ministry_vax_store_statement`
  ADD CONSTRAINT `ministry_vax_store_statement_ibfk_1` FOREIGN KEY (`vactype_type`) REFERENCES `vaccine_type` (`vactype_id`) ON UPDATE CASCADE;

--
-- قيود الجداول `mother_data`
--
ALTER TABLE `mother_data`
  ADD CONSTRAINT `mother_data_ibfk_1` FOREIGN KEY (`mother_city`) REFERENCES `cities` (`city_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `mother_data_ibfk_2` FOREIGN KEY (`mother_directorate`) REFERENCES `directorates` (`directorate_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `mother_data_ibfk_3` FOREIGN KEY (`mother_health_center`) REFERENCES `health_centers` (`hc_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `mother_data_ibfk_5` FOREIGN KEY (`mother_branch_name`) REFERENCES `branches` (`branch_id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- قيود الجداول `mother_statement`
--
ALTER TABLE `mother_statement`
  ADD CONSTRAINT `mother_statement_ibfk_1` FOREIGN KEY (`ms_dosage_level`) REFERENCES `dosage_levels` (`dl_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `mother_statement_ibfk_2` FOREIGN KEY (`ms_dosage_type`) REFERENCES `dosage_type` (`dt_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `mother_statement_ibfk_3` FOREIGN KEY (`ms_emp_name`) REFERENCES `employees` (`emp_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `mother_statement_ibfk_4` FOREIGN KEY (`ms_health_center`) REFERENCES `health_centers` (`hc_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `mother_statement_ibfk_5` FOREIGN KEY (`ms_mother_name`) REFERENCES `mother_data` (`mother_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `mother_statement_ibfk_6` FOREIGN KEY (`ms_branch_name`) REFERENCES `branches` (`branch_id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- قيود الجداول `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`health_center`) REFERENCES `health_centers` (`hc_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `orders_ibfk_2` FOREIGN KEY (`vactype_type`) REFERENCES `vaccine_type` (`vactype_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `orders_ibfk_3` FOREIGN KEY (`order_status`) REFERENCES `order_status` (`oreder_status_id`) ON UPDATE CASCADE;

--
-- قيود الجداول `vaccine_with_dosage`
--
ALTER TABLE `vaccine_with_dosage`
  ADD CONSTRAINT `vaccine_with_dosage_ibfk_1` FOREIGN KEY (`dosage_type`) REFERENCES `dosage_type` (`dt_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `vaccine_with_dosage_ibfk_2` FOREIGN KEY (`vaccine_type`) REFERENCES `vaccine_type` (`vactype_id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- قيود الجداول `visit_with_vaccine`
--
ALTER TABLE `visit_with_vaccine`
  ADD CONSTRAINT `visit_with_vaccine_ibfk_1` FOREIGN KEY (`vaccine_type`) REFERENCES `vaccine_type` (`vactype_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `visit_with_vaccine_ibfk_2` FOREIGN KEY (`visit_type`) REFERENCES `visit_type` (`vt_id`) ON DELETE SET NULL ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
