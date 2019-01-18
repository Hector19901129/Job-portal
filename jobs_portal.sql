-- phpMyAdmin SQL Dump
-- version 4.7.7
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Nov 08, 2018 at 12:53 AM
-- Server version: 5.6.39-cll-lve
-- PHP Version: 5.6.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `jobs_portal`
--

-- --------------------------------------------------------

--
-- Table structure for table `announcements`
--

CREATE TABLE `announcements` (
  `ID` int(11) NOT NULL,
  `title` varchar(500) COLLATE utf8_unicode_ci NOT NULL,
  `body` mediumtext COLLATE utf8_unicode_ci NOT NULL,
  `status` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `canned_responses`
--

CREATE TABLE `canned_responses` (
  `ID` int(11) NOT NULL,
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `body` mediumtext COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `custom_fields`
--

CREATE TABLE `custom_fields` (
  `ID` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `type` int(11) NOT NULL,
  `options` varchar(2000) COLLATE utf8_unicode_ci NOT NULL,
  `required` int(11) NOT NULL,
  `profile` int(11) NOT NULL,
  `edit` int(11) NOT NULL,
  `help_text` varchar(500) COLLATE utf8_unicode_ci NOT NULL,
  `register` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `custom_views`
--

CREATE TABLE `custom_views` (
  `ID` int(11) NOT NULL,
  `userid` int(11) NOT NULL,
  `status` int(11) NOT NULL,
  `categoryid` int(11) NOT NULL,
  `order_by` int(11) NOT NULL,
  `order_by_type` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(500) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `email_templates`
--

CREATE TABLE `email_templates` (
  `ID` int(11) NOT NULL,
  `title` varchar(500) COLLATE utf8_unicode_ci NOT NULL,
  `message` text COLLATE utf8_unicode_ci NOT NULL,
  `hook` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `language` varchar(255) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `email_templates`
--

INSERT INTO `email_templates` (`ID`, `title`, `message`, `hook`, `language`) VALUES
(1, 'Forgot Your Password', '<p>Dear [NAME],<br />\r\n<br />\r\nSomeone (hopefully you) requested a password reset at [SITE_URL].<br />\r\n<br />\r\nTo reset your password, please follow the following link: [EMAIL_LINK]<br />\r\n<br />\r\nIf you did not reset your password, please kindly ignore this email.<br />\r\n<br />\r\nYours,<br />\r\n[SITE_NAME]</p>\r\n', 'forgot_password', 'english'),
(2, 'Email Activation', '<p>Dear [NAME],<br />\r\n<br />\r\nSomeone (hopefully you) has registered an account on [SITE_NAME] using this email address.<br />\r\n<br />\r\nPlease activate the account by following this link: [EMAIL_LINK]<br />\r\n<br />\r\nIf you did not register an account, please kindly ignore this email.<br />\r\n<br />\r\nYours,<br />\r\n[SITE_NAME]</p>\r\n', 'email_activation', 'english'),
(3, 'Support Job Reply', '<p>[IMAP_TICKET_REPLY_STRING]<br />\r\n<br />\r\nDear [NAME],<br />\r\n<br />\r\nA new reply was posted on your job:<br />\r\n<br />\r\n[TICKET_BODY]<br />\r\n<br />\r\nJob was generated here: [SITE_URL]<br />\r\n<br />\r\n[IMAP_TICKET_ID] [TICKET_ID]<br />\r\n<br />\r\n[SITE_NAME]</p>\r\n', 'job_reply', 'english'),
(4, 'Support Job Creation', '<p>[IMAP_TICKET_REPLY_STRING]<br />\r\n<br />\r\nDear [NAME],<br />\r\n<br />\r\nThanks for creating a job at our site: [SITE_URL]<br />\r\n<br />\r\nYour message:<br />\r\n<br />\r\n[TICKET_BODY]<br />\r\n<br />\r\nWe&#39;ll be in touch shortly.<br />\r\n<br />\r\n[IMAP_TICKET_ID] [TICKET_ID]<br />\r\n<br />\r\nYours,<br />\r\n[SITE_NAME]</p>\r\n', 'job_creation', 'english'),
(5, 'Support Guest Job Creation', '<p>[IMAP_TICKET_REPLY_STRING]<br />\r\n<br />\r\nDear [NAME],<br />\r\n<br />\r\nThanks for creating a job at our site: [SITE_URL]<br />\r\n<br />\r\nYour message:<br />\r\n<br />\r\n[TICKET_BODY]<br />\r\n<br />\r\nTo view your job, use these Guest Login details:<br />\r\nEmail: [GUEST_EMAIL]<br />\r\nPassword: [GUEST_PASS]<br />\r\n<br />\r\nGuests Login Here: [GUEST_LOGIN]<br />\r\n<br />\r\nWe&#39;ll be in touch shortly.<br />\r\n<br />\r\n[IMAP_TICKET_ID] [TICKET_ID]<br />\r\n<br />\r\nYours,<br />\r\n[SITE_NAME]</p>\r\n', 'guest_job_creation', 'english'),
(7, 'Job Reminder', '<p>Dear [USER],<br />\r\n<br />\r\nThis is a reminder that you currently have an open job that needs your attention.<br />\r\n<br />\r\nPlease login to your job at:<br />\r\n<br />\r\n[SITE_URL]<br />\r\n<br />\r\nEmail Login: [USER]<br />\r\nJob Password: [GUEST_PASS]<br />\r\n<br />\r\nYours,<br />\r\n[SITE_NAME]</p>\r\n', 'job_reminder', 'english');

-- --------------------------------------------------------

--
-- Table structure for table `home_stats`
--

CREATE TABLE `home_stats` (
  `ID` int(11) NOT NULL,
  `google_members` int(11) NOT NULL DEFAULT '0',
  `facebook_members` int(11) NOT NULL DEFAULT '0',
  `twitter_members` int(11) NOT NULL DEFAULT '0',
  `total_members` int(11) NOT NULL DEFAULT '0',
  `new_members` int(11) NOT NULL DEFAULT '0',
  `active_today` int(11) NOT NULL DEFAULT '0',
  `timestamp` int(11) NOT NULL DEFAULT '0',
  `total_jobs` int(11) NOT NULL,
  `total_assigned_jobs` int(11) NOT NULL,
  `jobs_today` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `home_stats`
--

INSERT INTO `home_stats` (`ID`, `google_members`, `facebook_members`, `twitter_members`, `total_members`, `new_members`, `active_today`, `timestamp`, `total_jobs`, `total_assigned_jobs`, `jobs_today`) VALUES
(1, 0, 0, 0, 1, 1, 1, 1541659850, 34, 33, 0);

-- --------------------------------------------------------

--
-- Table structure for table `ipn_log`
--

CREATE TABLE `ipn_log` (
  `ID` int(11) NOT NULL,
  `data` text COLLATE utf8_unicode_ci,
  `timestamp` int(11) NOT NULL DEFAULT '0',
  `IP` varchar(500) COLLATE utf8_unicode_ci NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ip_block`
--

CREATE TABLE `ip_block` (
  `ID` int(11) NOT NULL,
  `IP` varchar(500) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `timestamp` int(11) NOT NULL DEFAULT '0',
  `reason` varchar(1000) COLLATE utf8_unicode_ci NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `jobs`
--

CREATE TABLE `jobs` (
  `ID` int(11) NOT NULL,
  `title` varchar(500) COLLATE utf8_unicode_ci NOT NULL,
  `body` mediumtext COLLATE utf8_unicode_ci NOT NULL,
  `userid` int(11) NOT NULL,
  `assignedid` int(11) NOT NULL,
  `timestamp` int(11) NOT NULL,
  `categoryid` int(11) NOT NULL,
  `status` int(11) NOT NULL,
  `priority` int(11) NOT NULL,
  `last_reply_timestamp` int(11) NOT NULL,
  `last_reply_userid` int(11) NOT NULL,
  `notes` mediumtext COLLATE utf8_unicode_ci NOT NULL,
  `message_id_hash` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `guest_email` varchar(500) COLLATE utf8_unicode_ci NOT NULL,
  `guest_password` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `last_reply_string` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `rating` int(11) NOT NULL,
  `job_date` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `close_job_date` varchar(255) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `jobs`
--

INSERT INTO `jobs` (`ID`, `title`, `body`, `userid`, `assignedid`, `timestamp`, `categoryid`, `status`, `priority`, `last_reply_timestamp`, `last_reply_userid`, `notes`, `message_id_hash`, `guest_email`, `guest_password`, `last_reply_string`, `rating`, `job_date`, `close_job_date`) VALUES
(40, '2/34 Thompson Street, Bowen Hills', '<p>This is a new job</p>\r\n', 5, 1, 1538096961, 1, 2, 2, 1538970038, 1, '', '8cd73d420ba2ab6d24c4da7b8407292d', '', 'Pf3AsHRXr9yN4', '08/10/2018 01:40', 0, '28-9-2018', '04-10-2018'),
(41, '6 Allison Street, Bowen Hills', '<p>This is a new job</p>\r\n', 5, 1, 1538097172, 1, 2, 2, 1538623298, 1, '', '66153a45a5bd6cb92903006446887996', '', 'gpkenoak2mi7', '04/10/2018 01:21', 0, '28-9-2018', '04-10-2018'),
(42, '749 Kingsford Smith Drive, Eagle Farm', '<p>This is a new job</p>\r\n', 5, 1, 1538438892, 1, 2, 2, 1538528014, 1, '', '62e47dc8a0efabde3d5fa007956e3f3f', '', 'KS1v9bi4ms1RoQ1', '03/10/2018 10:53', 0, '02-10-2018', '03-10-2018'),
(43, '121 Main Beach Road, Pinkenba', '<p>This is a new job</p>\r\n', 5, 1, 1538439019, 1, 2, 2, 1538528100, 1, '', 'af13331ec199475e379d83d57470ca4c', '', 'b5qmr1OE1bzHb', '03/10/2018 10:55', 0, '02-10-2018', '03-10-2018'),
(44, 'Unit 1&amp;4/ 482 Kingsford Smith Drive, Hamilton', '<p>This is a new job</p>\r\n', 5, 1, 1538439143, 1, 2, 2, 1538962456, 1, '', 'd15aa93c969f88d1c66d6822f9685361', '', 'YE6R4O8bp6qu2F3D', '08/10/2018 11:34', 0, '02-10-2018', '03-10-2018'),
(45, '1/353 MacDonnell Road, Clontarf', '<p>This is a new job</p>\r\n', 5, 1, 1538453147, 1, 2, 2, 1538537559, 1, '', '5fc1e701b9fb7a1f7a6556adb7fb6bb8', '', 'YwN9G7Uj8a5QcN', '03/10/2018 01:32', 0, '02-10-2018', '03-10-2018'),
(46, 'Shop 14 1477 Anzac Avenue, Kallangur', '<p>This is a new job</p>\r\n', 5, 1, 1538537735, 1, 2, 2, 1538537846, 1, '', '2cf5a3e41265437b6ad81b96510326b0', '', 'D5e7fK4VbpQQY2', '03/10/2018 01:37', 0, '03-10-2018', '03-10-2018'),
(49, '18 Austin Street, Newstead', '<p>This is a new job</p>\r\n', 5, 1, 1538720353, 1, 2, 2, 1539048351, 1, '', '0d551fac974a0852839d86889de620f7', '', 'UX9Ib5gl2w9JQV1', '09/10/2018 11:25', 0, '05-10-2018', '09-10-2018'),
(54, '67 Depot St, Banyo', '<p>This is a new job</p>\r\n', 5, 1, 1539031409, 1, 2, 2, 1539150328, 1, '', '1f99a4ec70206ec4c6d136c833e4c88b', '', 'bsfTwXX1p3tS', '10/10/2018 03:45', 0, '09-10-2018', '09-10-2018'),
(55, '201 Wickham Terrace, Spring Hill', '<p>This is a new job</p>\r\n', 5, 1, 1539213999, 1, 2, 2, 1539652145, 1, '', '13c48a10e88a1946c83d109d209432c2', '', 'sFUaX5kn4l9jh', '16/10/2018 11:09', 0, '11-10-2018', '16-10-2018'),
(58, '250 St Vincent Parade, Banyo', '<p>This is a new job</p>\r\n', 5, 1, 1539315013, 1, 2, 2, 1539825253, 1, '', '63e585a4e4630bca36a0ca82b28464df', '', 'l4B9h6aM2Mt4PPV', '18/10/2018 11:14', 0, '12-10-2018', '18-10-2018'),
(59, '4 Noble Avenue, Northgate', '<p>This is a new job</p>\r\n', 5, 1, 1539562589, 1, 2, 2, 1539667446, 1, '', 'd357829274586b4f7e7a06839f08c465', '', 'hi6SWXuqqlQ', '16/10/2018 03:24', 0, '15-10-2018', '16-10-2018'),
(60, '344 Bilsen Road, Geebung', '<p>This is a new job</p>\r\n', 5, 1, 1539578313, 1, 2, 2, 1539766003, 1, '', 'af6a18e7e16c7b243ca2ac17d67e64da', '', 'i5Ya2PGC4JQE7a2', '17/10/2018 06:46', 0, '15-10-2018', '17-10-2018'),
(61, '6/50 Northlink Place, Virginia', '<p>This is a new job</p>\r\n', 5, 1, 1539578448, 1, 2, 2, 1539765952, 1, '', '3159d25e14df6cd4bbd476bb13963c2e', '', 'P9KTuPi1sc5vN', '17/10/2018 06:45', 0, '15-10-2018', '17-10-2018'),
(62, '6/84 Newmarket Road, Windsor', '<p>This is a new job</p>\r\n', 5, 1, 1539653871, 1, 2, 2, 1539765886, 1, '', '76cdd261f4e9f7e095157af18e8b2f89', '', 'IdK5Oxo2Q1PKF', '17/10/2018 06:44', 0, '16-10-2018', '17-10-2018'),
(63, '30 Blackwood Street, Mitchelton', '<p>This is a new job</p>\r\n', 5, 1, 1539732127, 1, 2, 2, 1539910524, 1, '', '31b572f182e5b40471b8728d0c0fc19b', '', 'MH8Z4z6kzPd5iM', '19/10/2018 10:55', 0, '17-10-2018', '19-10-2018'),
(64, '200 Moggill Road, Taringa', '<p>This is a new job</p>\r\n', 5, 1, 1539734472, 1, 2, 2, 1539848493, 1, '', '62c8bfb22e1f3190fe9c0b6fa000ab69', '', 'Ja2Yy7Ioq1g7J5b', '18/10/2018 05:41', 0, '17-10-2018', '18-10-2018'),
(65, '4/482 Stafford Road, Stafford', '<p>This is a new job</p>\r\n', 5, 1, 1539831193, 1, 2, 2, 1539931989, 1, '', 'bfcda55a0576d0a838405fb5a1e2658d', '', 'oOC5K4E3E9T9Ih7I', '19/10/2018 04:53', 0, '18-10-2018', '19-10-2018'),
(66, '18 Boothby Street, Kedron', '<p>This is a new job</p>\r\n', 5, 1, 1539831277, 1, 2, 2, 1541559682, 1, '', '21c42e6b2c6665c286b036bf30a65c97', '', 'tX2I2spEI3atP', '07/11/2018 01:01', 0, '18-10-2018', '19-10-2018'),
(67, '15 Lang Parade, Milton', '<p>This is a new job</p>\r\n', 5, 1, 1539831391, 1, 2, 2, 1540689884, 1, '', '4ab185fd0e83b188510e8423e234a32f', '', 'RsaI9m2WByiD', '28/10/2018 11:24', 0, '18-10-2018', '28-10-2018'),
(68, '18/23 Ashtan Place, Banyo', '<p>This is a new job</p>\r\n', 5, 1, 1539920460, 1, 2, 2, 1540166351, 1, '', 'da05372ab487602ef01a7086b36109b0', '', 'y7Jq2JYtx6w6cU3', '22/10/2018 09:59', 0, '19-10-2018', '22-10-2018'),
(69, '616 Rode Road, Chermside', '<p>This is a new job</p>\r\n', 5, 1, 1539920545, 1, 2, 2, 1540166202, 1, '', '3b2c4be49f9d71faf31ef29f09d9b828', '', 'JBWU7lG9DUSO', '22/10/2018 09:56', 0, '19-10-2018', '22-10-2018'),
(70, '15 Lang Parade, Milton', '<p>This is a new job</p>\r\n', 5, 1, 1540169719, 1, 2, 2, 1540416045, 1, '', '76000d438193e1b2002ecbd7751f9b8e', '', 'zi8NsuHTS3U1s', '25/10/2018 07:20', 0, '22-10-2018', '25-10-2018'),
(71, '38 Buchanan Road, Banyo', '<p>This is a new job</p>\r\n', 5, 0, 1540169848, 1, 1, 2, 1540169848, 0, '', '95fb8dc93a40f6e09d30ee15cd57afa4', '', 'wde3dU8J3th5fP', '22/10/2018 10:57', 0, '22-10-2018', ''),
(72, '71 Wilgarning Street, Stafford', '<p>This is a new job</p>\r\n', 5, 1, 1540170019, 1, 2, 2, 1541041307, 1, '', '01869b88c30a7c1671b7d73d5b615c69', '', 'j1w8mc7fpm4zZk', '01/11/2018 01:01', 0, '22-10-2018', '01-11-2018'),
(73, '252 Kelvin Grove Road, Kelvin Grove', '<p>This is a new job</p>\r\n', 5, 1, 1540175806, 1, 2, 2, 1540352109, 1, '', 'efc9f45ae206ab78b60308ebdf9357fd', '', 'kD2GnrUxc5Nw', '24/10/2018 01:35', 0, '22-10-2018', '24-10-2018'),
(74, '19 Thompson Street, Bowen Hills', '<p>This is a new job</p>\r\n', 5, 1, 1540177109, 1, 2, 2, 1540695550, 1, '', '21eeed01e7e77a8dc7d83a52c87ddac9', '', 'ROd6uuG4f1uVK1', '28/10/2018 12:59', 0, '22-10-2018', '28-10-2018'),
(75, '470 Upper Roma Street, Brisbane', '<p>This is a new job</p>\r\n', 5, 1, 1540195177, 1, 2, 2, 1541041273, 1, '', 'a176142554f08f53ea4c1bf6940b7218', '', 'vb6dfdhaJXZ', '01/11/2018 01:01', 0, '22-10-2018', '01-11-2018'),
(76, '12 Blackwood Street, Mitchelton', '<p>This is a new job</p>\r\n', 5, 1, 1540254320, 1, 2, 2, 1540352163, 1, '', '1dd0d6dd43ac0ddd134a36f6ae68e278', '', 'AChHc1W7Ap4W5M', '24/10/2018 01:36', 0, '23-10-2018', '24-10-2018'),
(77, '2/445 Upper Edward Street, Spring Hill', '<p>This is a new job</p>\r\n', 5, 1, 1540428792, 1, 2, 2, 1540515338, 1, '', 'df0e32da5dbd0dab9ee56e1d77a75164', '', 'SHsAQn6cDH1V', '26/10/2018 10:55', 0, '25-10-2018', '26-10-2018'),
(78, '730 South Pine Road, Everton Park', '<p>This is a new job</p>\r\n', 5, 1, 1540519016, 1, 2, 2, 1540850907, 1, '', 'f269df7b5ba5db00c49c66f85df3d3b1', '', 'd3r7xm4XtNDu2m8', '30/10/2018 08:08', 0, '26-10-2018', '30-10-2018'),
(79, '1 Windsor Road, Red Hill', '<p>This is a new job</p>\r\n', 5, 1, 1540519489, 1, 2, 2, 1540850858, 1, '', '3d6555c5052b154a269ad5fd09e13dc9', '', 'Jn8l2Wklsz9ZW3', '30/10/2018 08:07', 0, '26-10-2018', '30-10-2018'),
(80, '6a/68 Racecourse Road, Hamilton', '<p>This is a new job</p>\r\n', 5, 1, 1540959702, 1, 2, 2, 1541389471, 1, '', 'ca082c9afa8477853d577d4b0ce22fce', '', 'hPWXEP8Qpfn9', '05/11/2018 01:44', 0, '31-10-2018', '05-11-2018'),
(81, '4 Noble Avenue, Northgate', '<p>This is a new removal</p>\r\n', 5, 1, 1541473381, 2, 3, 2, 1541559622, 1, '', '51bc2db27915e94a228f88cc3ff46846', '', 'JCwlqzbj4k5u', '07/11/2018 01:00', 0, '06-11-2018', '');

-- --------------------------------------------------------

--
-- Table structure for table `job_categories`
--

CREATE TABLE `job_categories` (
  `ID` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` mediumtext COLLATE utf8_unicode_ci NOT NULL,
  `cat_parent` int(11) NOT NULL,
  `image` varchar(1000) COLLATE utf8_unicode_ci NOT NULL,
  `no_jobs` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `job_categories`
--

INSERT INTO `job_categories` (`ID`, `name`, `description`, `cat_parent`, `image`, `no_jobs`) VALUES
(1, 'Default', 'The default group.', 0, 'default_cat.png', 0),
(2, 'Removal', '', 0, 'default_cat.png', 0),
(3, 'Task', '', 0, 'default_cat.png', 0);

-- --------------------------------------------------------

--
-- Table structure for table `job_category_groups`
--

CREATE TABLE `job_category_groups` (
  `ID` int(11) NOT NULL,
  `groupid` int(11) NOT NULL,
  `catid` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `job_custom_fields`
--

CREATE TABLE `job_custom_fields` (
  `ID` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `type` int(11) NOT NULL,
  `options` varchar(2000) COLLATE utf8_unicode_ci NOT NULL,
  `help_text` varchar(1000) COLLATE utf8_unicode_ci NOT NULL,
  `required` int(11) NOT NULL,
  `all_cats` int(11) NOT NULL,
  `hide_clientside` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `job_custom_fields`
--

INSERT INTO `job_custom_fields` (`ID`, `name`, `type`, `options`, `help_text`, `required`, `all_cats`, `hide_clientside`) VALUES
(2, 'Property Type', 4, 'Office,Retail,Industrial,Land,Other', '', 0, 0, 0),
(3, 'Orientation', 4, 'Portrait,Landscape,NA', '', 0, 0, 0),
(4, 'Sign Type', 4, 'Stockboard,Text Board,Photoboard,Window Graphic,Banner,Corflute,Other', '', 0, 0, 0),
(5, 'Size', 4, '1800x1200mm,2400x1800mm,Other', '', 0, 0, 0),
(6, 'Quantity', 0, '', '', 1, 0, 0),
(7, 'V Board', 4, 'No,Yes', '', 0, 0, 0),
(8, 'Sale Method', 4, 'Sale,Lease,Sale/Lease,Auction', '', 0, 0, 0),
(9, 'Nameplate 2', 4, 'Trent Bruce 0423 591 528,Brad Weston 0478 352 346,Brandon Mertz 0423 591 533,David Kettle 0423 591 541,David Miller 0423 591 111,Hudson Dale 0423 591 529,James Doyle 0423 591 530,Lawrence Temple 0423 591 534,Michael Richardson 0478 352 341,Michael Schafferius 0423 591 540,Vaughn Smart 0423 591 531, NA', '', 0, 0, 0),
(10, 'Nameplate', 4, 'Trent Bruce 0423 591 528,Brad Weston 0478 352 346,Brandon Mertz 0423 591 533,David Kettle 0423 591 541,David Miller 0423 591 111,Hudson Dale 0423 591 529,James Doyle 0423 591 530,Lawrence Temple 0423 591 534,Michael Richardson 0478 352 341,Michael Schafferius 0423 591 540,Vaughn Smart 0423 591 531', '', 0, 0, 0),
(11, 'Install Notes', 1, '', '', 0, 0, 0),
(12, 'Task', 4, 'New/Additional Decal or Nameplate,Remove Graffiti,Relocate,Other,Standard Sold Sticker,Standard Leased Sticker,Sold By Sticker,Leased By Sticker', '', 0, 0, 0),
(13, 'Notes', 1, '', '', 0, 0, 0),
(14, 'Overlays', 4, 'Multiple,Exclusive Agent,Rear Tenancy,Investment,Unit,Other,NA', '', 0, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `job_custom_field_cats`
--

CREATE TABLE `job_custom_field_cats` (
  `ID` int(11) NOT NULL,
  `fieldid` int(11) NOT NULL,
  `catid` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `job_custom_field_cats`
--

INSERT INTO `job_custom_field_cats` (`ID`, `fieldid`, `catid`) VALUES
(1, 2, 1),
(2, 3, 1),
(3, 4, 1),
(4, 5, 1),
(6, 7, 1),
(7, 8, 1),
(25, 12, 3),
(27, 10, 1),
(29, 9, 1),
(36, 14, 1),
(37, 11, 1),
(38, 13, 2),
(39, 13, 3),
(43, 6, 1);

-- --------------------------------------------------------

--
-- Table structure for table `job_files`
--

CREATE TABLE `job_files` (
  `ID` int(11) NOT NULL,
  `jobid` int(11) NOT NULL,
  `upload_file_name` varchar(500) COLLATE utf8_unicode_ci NOT NULL,
  `file_type` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `extension` varchar(12) COLLATE utf8_unicode_ci NOT NULL,
  `file_size` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `timestamp` int(11) NOT NULL,
  `replyid` int(11) NOT NULL,
  `userid` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `job_files`
--

INSERT INTO `job_files` (`ID`, `jobid`, `upload_file_name`, `file_type`, `extension`, `file_size`, `timestamp`, `replyid`, `userid`) VALUES
(1, 11, 'd453f5389e037e1b7e84658ebee4d4ca.pdf', 'application/pdf', '.pdf', '773.71', 1537274233, 0, 1),
(2, 12, '733bbd1877fd5552efb0600e6ca5e138.pdf', 'application/pdf', '.pdf', '212.16', 1537274655, 0, 3),
(3, 12, '0231652736a2d624a4dd0e63cc5a2dd6.pdf', 'application/pdf', '.pdf', '974.08', 1537275068, 1, 1),
(4, 13, '61d9ea696f269a621f056df11ea4e607.pdf', 'application/pdf', '.pdf', '194.63', 1537308859, 0, 3),
(5, 35, '5f7895f5be8206b969efe2a99012ae1e.jpg', 'image/jpeg', '.jpg', '9.2', 1538011551, 0, 3),
(6, 36, 'b4c3262e4d9c8cbfcddf24599f21b961.jpg', 'image/jpeg', '.jpg', '9.2', 1538011647, 0, 3),
(7, 36, 'ce6f0fd604f048747bbb858cc256c7d8.jpg', 'image/jpeg', '.jpg', '78.17', 1538011647, 0, 3),
(8, 37, '73ed4e88c0195835e9f132e762ad8d76.JPG', 'image/jpeg', '.JPG', '544.6', 1538011739, 0, 5),
(9, 38, '2ed3a1d7311ef7db0d48fc77ee605e00.JPG', 'image/jpeg', '.JPG', '544.6', 1538011762, 0, 5),
(10, 34, 'd7c9857d779681f2c6da5a5718aa6dba.JPG', 'image/jpeg', '.JPG', '544.6', 1538011808, 2, 1),
(11, 39, '0c768f4fc65205a0ebe111813e65db8d.pdf', 'application/pdf', '.pdf', '192.66', 1538012193, 0, 5),
(12, 40, '4cf7e8edf906aec497463c2cce92b837.pdf', 'application/pdf', '.pdf', '416.17', 1538096961, 0, 5),
(13, 41, '2bb45fcd3e39c832e24c9b49caf34139.pdf', 'application/pdf', '.pdf', '401.67', 1538097172, 0, 5),
(14, 42, '31f7594d8441621c2bc17003c37916a7.pdf', 'application/pdf', '.pdf', '479.39', 1538438892, 0, 5),
(15, 43, '0b55c52faeca3dc554f2321cd03e0b64.pdf', 'application/pdf', '.pdf', '444.05', 1538439019, 0, 5),
(16, 44, '58b87ea65ce4d41cec94a03702cfd3c4.pdf', 'application/pdf', '.pdf', '482.93', 1538439143, 0, 5),
(17, 45, '2c76f3465180a97b8f948847060d5b7c.pdf', 'application/pdf', '.pdf', '387.73', 1538453147, 0, 5),
(18, 44, '8461a665e890e0f137ec479c23c344bb.JPG', 'image/jpeg', '.JPG', '599.5', 1538527903, 3, 1),
(19, 44, 'd2dc3b86deba10ff11d236aa010c9c1f.JPG', 'image/jpeg', '.JPG', '875.37', 1538527903, 3, 1),
(20, 42, 'dfb6173908e41abc01b1cbdc81bd43f2.JPG', 'image/jpeg', '.JPG', '897.42', 1538528014, 4, 1),
(21, 42, '763f9556fd4493098485b2a4cdf253a9.JPG', 'image/jpeg', '.JPG', '784.89', 1538528014, 4, 1),
(22, 43, 'd85cb8202863408c3cb8627149873f1f.JPG', 'image/jpeg', '.JPG', '955.84', 1538528100, 5, 1),
(23, 45, '2a8f867a37e9488328bd69d724546218.JPG', 'image/jpeg', '.JPG', '711.79', 1538537557, 6, 1),
(24, 45, '5973dc918f254809298453708fee20a6.JPG', 'image/jpeg', '.JPG', '777.92', 1538537559, 6, 1),
(25, 46, 'c463c155821910e7f37a26561b881bb4.JPG', 'image/jpeg', '.JPG', '556.82', 1538537846, 7, 1),
(26, 46, 'a972f37649c8b7a7e592bf1ea3901747.JPG', 'image/jpeg', '.JPG', '477.84', 1538537846, 7, 1),
(27, 48, '9a673c9aa57c1fda7ac2f48a76e094d0.jpg', 'image/jpeg', '.jpg', '155.09', 1538557180, 0, 22),
(28, 41, '04d9b680cb1a1be7edb4a44c30e92a76.jpeg', 'image/jpeg', '.jpeg', '650.52', 1538623298, 8, 1),
(29, 40, '84f0957681b414391f274018fc080e61.JPG', 'image/jpeg', '.JPG', '701.3', 1538623346, 9, 1),
(30, 49, '2b90faf8f5634d1a67d1cdbfb4224a8d.pdf', 'application/pdf', '.pdf', '792.79', 1538720353, 0, 5),
(31, 44, '641dc913e1b5092c56d89dee4879f357.JPG', 'image/jpeg', '.JPG', '599.5', 1538962456, 10, 1),
(34, 40, '2ae9b3176bf153c2df6da62232638a87.png', 'image/png', '.png', '62.63', 1538967453, 12, 1),
(35, 40, '75676cb3ca27f865375be05703a0c9c2.pdf', 'application/pdf', '.pdf', '67.92', 1538967453, 12, 1),
(36, 40, '111cbf194abb956f365b8fada48bc39f.JPG', 'image/jpeg', '.JPG', '777.92', 1538968084, 13, 1),
(38, 40, '69354f6d2852b89855d7f0abc48a0dee.JPG', 'image/jpeg', '.JPG', '777.92', 1538970038, 15, 1),
(39, 50, '2bbb6cca0e0b2b3c0ef8199956fb9721.pdf', 'application/pdf', '.pdf', '878.48', 1538976642, 0, 5),
(40, 51, '26b551776259bfb9612353272e6660bc.pdf', 'application/pdf', '.pdf', '881.84', 1538978379, 0, 5),
(41, 54, '7ae7762b0aad2dd730281ca40ea7d53a.pdf', 'application/pdf', '.pdf', '881.84', 1539031409, 0, 5),
(42, 49, '777a811adc710cface6351d3b191c7f9.JPG', 'image/jpeg', '.JPG', '528.73', 1539048351, 16, 1),
(43, 54, 'b02903a20a595e7b23915575c45ff490.jpeg', 'image/jpeg', '.jpeg', '823.82', 1539063363, 17, 1),
(44, 54, 'cf577e6a29a3111e908dd16bce312aef.JPG', 'image/jpeg', '.JPG', '731.09', 1539150328, 18, 1),
(45, 58, '8c599a0a59b8522e4c6629787c030a82.pdf', 'application/pdf', '.pdf', '426.17', 1539315013, 0, 5),
(46, 59, '53a535e31075a60c16b867a1464824ff.pdf', 'application/pdf', '.pdf', '243.32', 1539562589, 0, 5),
(47, 60, '9f42c36ee7e369aa14b4864de18262b1.pdf', 'application/pdf', '.pdf', '575.23', 1539578313, 0, 5),
(48, 61, 'f001d3ae6a924b83a1f10d589036f5b1.pdf', 'application/pdf', '.pdf', '601.28', 1539578448, 0, 5),
(49, 55, 'f90dd2a7d1935b580c6e30886e1ea007.JPG', 'image/jpeg', '.JPG', '811.85', 1539652143, 19, 1),
(50, 55, '2c775c7d0c3e728c5b0fbff16682885a.JPG', 'image/jpeg', '.JPG', '631.19', 1539652145, 19, 1),
(51, 55, '38f3c7d3c14852e83ff417d44778ca1d.JPG', 'image/jpeg', '.JPG', '555.91', 1539652145, 19, 1),
(52, 62, '9022b19810a0f60cc7459afb3fffe01f.pdf', 'application/pdf', '.pdf', '382.42', 1539653871, 0, 5),
(53, 59, '05f8e5abfbe10d0336489a42ae182265.JPG', 'image/jpeg', '.JPG', '843.46', 1539667446, 20, 1),
(54, 63, 'bb483e7ee15e7956dac7b0584caa7812.pdf', 'application/pdf', '.pdf', '766.82', 1539732127, 0, 5),
(55, 64, 'd8ac78bca12612deda3c4a84634186eb.pdf', 'application/pdf', '.pdf', '469.94', 1539734472, 0, 5),
(56, 62, '0536992583233a260277c0134d49e076.JPG', 'image/jpeg', '.JPG', '666.59', 1539765886, 21, 1),
(57, 61, '3b075928778c2f0ab250af06cc225662.JPG', 'image/jpeg', '.JPG', '898.68', 1539765952, 22, 1),
(58, 60, '5f2f7dcf002836fe6edc9996a0899924.JPG', 'image/jpeg', '.JPG', '626.51', 1539766003, 23, 1),
(59, 58, 'c73c13941fed8a3640c09d660885b98f.JPG', 'image/jpeg', '.JPG', '687.93', 1539825253, 24, 1),
(60, 65, 'bea5bb62c6a018a2616726d847e0b917.pdf', 'application/pdf', '.pdf', '220.75', 1539831193, 0, 5),
(61, 66, 'ad36f7bc27b12aacbac2492110662218.pdf', 'application/pdf', '.pdf', '214.61', 1539831277, 0, 5),
(62, 67, '023e85310ab479d470cab4e1ed455efc.pdf', 'application/pdf', '.pdf', '983.24', 1539831391, 0, 5),
(63, 64, '4fefe057746a065490c3dd67d35c86b8.JPG', 'image/jpeg', '.JPG', '959.77', 1539848493, 25, 1),
(64, 63, 'af6f187ef73b8f6375f6afbbee0ca0da.JPG', 'image/jpeg', '.JPG', '770.71', 1539910524, 26, 1),
(65, 68, 'bd26bfed2576b23df2999426430cef54.pdf', 'application/pdf', '.pdf', '476.08', 1539920460, 0, 5),
(66, 69, '317ff6eb00fc9b5aba5f210f8f871f6e.pdf', 'application/pdf', '.pdf', '437.01', 1539920545, 0, 5),
(67, 66, 'ddbef03a34689aee39ee95b1f98ffb7d.JPG', 'image/jpeg', '.JPG', '891.67', 1539930417, 27, 1),
(68, 65, '8bac1b19fae8fc760aa8daaa39522ef1.JPG', 'image/jpeg', '.JPG', '834.8', 1539931989, 28, 1),
(69, 69, 'ac480b947137fb74284577d491d16cd8.JPG', 'image/jpeg', '.JPG', '747.6', 1540166201, 29, 1),
(70, 68, '42e3700bd5807bf5423effebefd27cc7.jpg', 'image/jpeg', '.jpg', '445.22', 1540166351, 30, 1),
(71, 68, '16297565a8dd511f3484b1d075816498.jpg', 'image/jpeg', '.jpg', '672.4', 1540166351, 30, 1),
(72, 70, '00aec6f372d1f1a4bbbe6a1b64a0e391.pdf', 'application/pdf', '.pdf', '260.76', 1540169719, 0, 5),
(73, 71, '1f577e3ef228f237bb11f18c56d0d3fe.pdf', 'application/pdf', '.pdf', '153.02', 1540169848, 0, 5),
(74, 72, '190eb83bfcc3555db80039e33bac7d43.pdf', 'application/pdf', '.pdf', '272.41', 1540170019, 0, 5),
(75, 72, 'd5bbcef6d21e5dd0853d7ef05b5108c0.pdf', 'application/pdf', '.pdf', '52.23', 1540170019, 0, 5),
(76, 73, '88bf41043969890e7e76d7fa98f45159.pdf', 'application/pdf', '.pdf', '442.71', 1540175806, 0, 5),
(77, 73, '931c6ad5cdee976f4992e1ab70abfd8d.pdf', 'application/pdf', '.pdf', '51.64', 1540175806, 0, 5),
(78, 74, '6159581000d1dc165ed189a37e45db2d.pdf', 'application/pdf', '.pdf', '230.45', 1540177109, 0, 5),
(79, 76, '78ff40a47c236b7f34f87facaf7f3f63.pdf', 'application/pdf', '.pdf', '394.5', 1540254320, 0, 5),
(80, 73, '791d72a6293979b12991df82f18a3cff.JPG', 'image/jpeg', '.JPG', '959.34', 1540352109, 31, 1),
(81, 73, '33f43e4efee0a68f7e0dd0ff580632b7.JPG', 'image/jpeg', '.JPG', '669.8', 1540352109, 31, 1),
(82, 76, '27233b647a15d2880c7372bfc7cf62df.JPG', 'image/jpeg', '.JPG', '808.74', 1540352163, 32, 1),
(83, 70, '4707312300ce23223ad0ce3fdcfa38a5.JPG', 'image/jpeg', '.JPG', '658.06', 1540416044, 33, 1),
(84, 77, 'dcac39d3f739cba457acd9ae292b900f.JPG', 'image/jpeg', '.JPG', '506.68', 1540515338, 34, 1),
(85, 78, 'cff8484b8cf091511003d81e6ff25e33.pdf', 'application/pdf', '.pdf', '557.18', 1540519016, 0, 5),
(86, 78, 'ed176372703a33a4cfc81354cb250b2c.pdf', 'application/pdf', '.pdf', '575.13', 1540519016, 0, 5),
(87, 79, '45296dd3f4e79f5b429d338576d12137.pdf', 'application/pdf', '.pdf', '463.83', 1540519489, 0, 5),
(88, 67, '4cee1b0301f84f7c240941f1a2ac61f3.JPG', 'image/jpeg', '.JPG', '646.76', 1540689884, 35, 1),
(89, 74, '057a26dfa34a7993053e25fd8c445ea1.JPG', 'image/jpeg', '.JPG', '793.42', 1540695550, 36, 1),
(90, 79, '5224ad55f7e0dee9866ddc8b07b8294a.JPG', 'image/jpeg', '.JPG', '777.52', 1540850858, 37, 1),
(91, 78, 'd9af803a9c158d0657224d05d4ff0c42.JPG', 'image/jpeg', '.JPG', '812.84', 1540850906, 38, 1),
(92, 78, '7dd6c82750d438a1812c850afcdc7888.JPG', 'image/jpeg', '.JPG', '832.64', 1540850907, 38, 1),
(93, 80, 'b3e5f52364d880a9ee90747d871eec6b.pdf', 'application/pdf', '.pdf', '494.37', 1540959702, 0, 5),
(94, 75, '209831703e99b3a8680ea9720c07b039.jpg', 'image/jpeg', '.jpg', '888.68', 1541041273, 39, 1),
(95, 72, 'e293fb0200c2cfd5991e651275023c01.jpg', 'image/jpeg', '.jpg', '926.71', 1541041307, 40, 1),
(96, 80, '25322b28d6befdb5fee01fc1a2bd612f.JPG', 'image/jpeg', '.JPG', '717.96', 1541389471, 41, 1),
(97, 66, '4af01c796fff08f7aad6a52746ccec9b.JPG', 'image/jpeg', '.JPG', '139.79', 1541559682, 43, 1);

-- --------------------------------------------------------

--
-- Table structure for table `job_history`
--

CREATE TABLE `job_history` (
  `ID` int(11) NOT NULL,
  `jobid` int(11) NOT NULL,
  `userid` int(11) NOT NULL,
  `message` varchar(500) COLLATE utf8_unicode_ci NOT NULL,
  `timestamp` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `job_history`
--

INSERT INTO `job_history` (`ID`, `jobid`, `userid`, `message`, `timestamp`) VALUES
(1, 8, 2, 'Job was created [CLIENT].', 1537127879),
(2, 8, 1, 'Job status was changed to In Progress', 1537128079),
(3, 8, 1, 'Administrator was assigned to job.', 1537128110),
(4, 9, 2, 'Job was created [CLIENT].', 1537270910),
(5, 10, 1, 'Job was created [CLIENT].', 1537271785),
(6, 11, 1, 'Job was created [CLIENT].', 1537274233),
(7, 12, 3, 'Job was created [CLIENT].', 1537274655),
(8, 12, 1, 'Job status was changed to Closed', 1537274926),
(9, 12, 1, 'Replied to the job.', 1537275068),
(10, 13, 3, 'Job was created [CLIENT].', 1537308859),
(11, 13, 1, 'Job status was changed to In Progress', 1537308974),
(12, 14, 1, 'Job was created [CLIENT].', 1537321206),
(13, 15, 1, 'Job was created [CLIENT].', 1537321388),
(14, 15, 1, 'Replied to the job.', 1537321431),
(15, 15, 1, 'Job reply was deleted: <p>sddsdsd</p>\r\n', 1537321449),
(16, 16, 1, 'Job was created [CLIENT].', 1537321732),
(17, 17, 1, 'Job was created [CLIENT].', 1537444018),
(18, 18, 1, 'Job was created [CLIENT].', 1537445319),
(19, 19, 1, 'Job was created [CLIENT].', 1537445453),
(20, 20, 1, 'Job was created [CLIENT].', 1537445961),
(21, 21, 1, 'Job was created [CLIENT].', 1537445974),
(22, 20, 1, 'Job status was changed to Removed', 1537447689),
(23, 22, 1, 'Job was created [CLIENT].', 1537448269),
(24, 22, 1, 'Job status was changed to Removed', 1537448304),
(25, 23, 3, 'Job was created [CLIENT].', 1537452199),
(26, 24, 1, 'Job was created [CLIENT].', 1537545947),
(27, 25, 1, 'Job was created [CLIENT].', 1537546048),
(28, 25, 1, 'Job status was changed to Completed', 1537547808),
(29, 25, 1, 'Job status was changed to Completed', 1537547967),
(30, 25, 1, 'Job status was changed to Removed', 1537547975),
(31, 25, 1, 'Job status was changed to Installed', 1537547978),
(32, 25, 1, 'Job status was changed to Completed', 1537547980),
(33, 26, 1, 'Job was created [CLIENT].', 1537548019),
(34, 27, 1, 'Job was created [CLIENT].', 1537548042),
(35, 26, 1, 'Job status was changed to Removed', 1537548075),
(36, 27, 1, 'Job status was changed to Completed', 1537548087),
(37, 28, 3, 'Job was created [CLIENT].', 1537802276),
(38, 29, 3, 'Job was created [CLIENT].', 1537802289),
(39, 30, 3, 'Job was created [CLIENT].', 1537802306),
(40, 31, 3, 'Job was created [CLIENT].', 1537802366),
(41, 32, 5, 'Job was created [CLIENT].', 1538005106),
(42, 33, 5, 'Job was created [CLIENT].', 1538009300),
(43, 34, 5, 'Job was created [CLIENT].', 1538009353),
(44, 34, 1, 'Job status was changed to Installed', 1538009386),
(45, 35, 3, 'Job was created [CLIENT].', 1538011551),
(46, 36, 3, 'Job was created [CLIENT].', 1538011647),
(47, 37, 5, 'Job was created [CLIENT].', 1538011739),
(48, 38, 5, 'Job was created [CLIENT].', 1538011762),
(49, 34, 1, 'Replied to the job.', 1538011808),
(50, 39, 5, 'Job was created [CLIENT].', 1538012193),
(51, 39, 1, 'Job status was changed to In Progress', 1538012235),
(52, 40, 5, 'Job was created [CLIENT].', 1538096961),
(53, 41, 5, 'Job was created [CLIENT].', 1538097172),
(54, 41, 1, 'Job status was changed to In Progress', 1538432929),
(55, 40, 1, 'Job status was changed to In Progress', 1538432939),
(56, 42, 5, 'Job was created [CLIENT].', 1538438892),
(57, 43, 5, 'Job was created [CLIENT].', 1538439019),
(58, 44, 5, 'Job was created [CLIENT].', 1538439143),
(59, 42, 1, 'Job status was changed to In Progress', 1538444851),
(60, 43, 1, 'Job status was changed to In Progress', 1538444858),
(61, 44, 1, 'Job status was changed to In Progress', 1538444865),
(62, 45, 5, 'Job was created [CLIENT].', 1538453147),
(63, 45, 1, 'Job status was changed to In Progress', 1538461507),
(64, 44, 1, 'Replied to the job.', 1538527903),
(65, 44, 1, 'Job status was changed to Installed', 1538527918),
(66, 42, 1, 'Job status was changed to Installed', 1538527975),
(67, 42, 1, 'Replied to the job.', 1538528014),
(68, 43, 1, 'Job status was changed to Installed', 1538528077),
(69, 43, 1, 'Replied to the job.', 1538528100),
(70, 45, 1, 'Job status was changed to Installed', 1538537520),
(71, 45, 1, 'Replied to the job.', 1538537560),
(72, 46, 5, 'Job was created [CLIENT].', 1538537735),
(73, 46, 1, 'Job status was changed to Installed', 1538537819),
(74, 46, 1, 'Replied to the job.', 1538537847),
(75, 47, 16, 'Job was created [CLIENT].', 1538550179),
(76, 48, 22, 'Job was created [CLIENT].', 1538557180),
(77, 41, 1, 'Replied to the job.', 1538623298),
(78, 41, 1, 'Job status was changed to Installed', 1538623316),
(79, 40, 1, 'Replied to the job.', 1538623346),
(80, 40, 1, 'Job status was changed to Installed', 1538625860),
(81, 49, 5, 'Job was created [CLIENT].', 1538720353),
(82, 49, 1, 'Job status was changed to In Progress', 1538946191),
(83, 44, 1, 'Replied to the job.', 1538962457),
(84, 40, 1, 'Replied to the job.', 1538967195),
(85, 40, 1, 'Deleted a job file attachment.', 1538967394),
(86, 40, 1, 'Deleted a job file attachment.', 1538967397),
(87, 40, 1, 'Replied to the job.', 1538967453),
(88, 40, 1, 'Job reply was deleted: <p>test working fine</p>\r\n', 1538967561),
(89, 40, 1, 'Job reply was deleted: <p>good one</p>\r\n', 1538967567),
(90, 40, 1, 'Replied to the job.', 1538968084),
(91, 44, 1, 'Job reply was deleted: <p>Trial response</p>\r\n', 1538968168),
(92, 40, 1, 'Job reply was deleted: <p>Test</p>\r\n', 1538969835),
(93, 40, 1, 'Replied to the job.', 1538969859),
(94, 40, 1, 'Deleted a job file attachment.', 1538969984),
(95, 40, 1, 'Replied to the job.', 1538970038),
(96, 50, 5, 'Job was created [CLIENT].', 1538976642),
(97, 51, 5, 'Job was created [CLIENT].', 1538978379),
(98, 52, 5, 'Job was created [CLIENT].', 1538988626),
(99, 53, 5, 'Job was created [CLIENT].', 1538995769),
(100, 51, 1, 'Job status was changed to In Progress', 1539031270),
(101, 54, 5, 'Job was created [CLIENT].', 1539031409),
(102, 54, 1, 'Job status was changed to In Progress', 1539031458),
(103, 49, 1, 'Job status was changed to Installed', 1539048341),
(104, 49, 1, 'Replied to the job.', 1539048351),
(105, 54, 1, 'Job status was changed to Installed', 1539063269),
(106, 54, 1, 'Replied to the job.', 1539063363),
(107, 54, 1, 'Replied to the job.', 1539150328),
(108, 55, 5, 'Job was created [CLIENT].', 1539213999),
(109, 55, 1, 'Job status was changed to In Progress', 1539220293),
(110, 56, 28, 'Job was created [CLIENT].', 1539293072),
(111, 57, 1, 'Job was created [CLIENT].', 1539293296),
(112, 58, 5, 'Job was created [CLIENT].', 1539315013),
(113, 58, 1, 'Job status was changed to In Progress', 1539558838),
(114, 59, 5, 'Job was created [CLIENT].', 1539562589),
(115, 59, 1, 'Job status was changed to In Progress', 1539570490),
(116, 60, 5, 'Job was created [CLIENT].', 1539578313),
(117, 61, 5, 'Job was created [CLIENT].', 1539578448),
(118, 60, 1, 'Job status was changed to In Progress', 1539583225),
(119, 61, 1, 'Job status was changed to In Progress', 1539583236),
(120, 55, 1, 'Job status was changed to Installed', 1539652062),
(121, 55, 1, 'Replied to the job.', 1539652145),
(122, 62, 5, 'Job was created [CLIENT].', 1539653871),
(123, 62, 1, 'Job status was changed to In Progress', 1539654656),
(124, 59, 1, 'Job status was changed to Installed', 1539667424),
(125, 59, 1, 'Replied to the job.', 1539667446),
(126, 63, 5, 'Job was created [CLIENT].', 1539732127),
(127, 64, 5, 'Job was created [CLIENT].', 1539734472),
(128, 63, 1, 'Job status was changed to In Progress', 1539738342),
(129, 64, 1, 'Job status was changed to In Progress', 1539738348),
(130, 62, 1, 'Job status was changed to Installed', 1539765858),
(131, 62, 1, 'Replied to the job.', 1539765886),
(132, 61, 1, 'Job status was changed to In Progress', 1539765927),
(133, 61, 1, 'Job status was changed to Installed', 1539765928),
(134, 61, 1, 'Replied to the job.', 1539765952),
(135, 60, 1, 'Job status was changed to Installed', 1539765983),
(136, 60, 1, 'Replied to the job.', 1539766003),
(137, 58, 1, 'Job status was changed to Installed', 1539825229),
(138, 58, 1, 'Replied to the job.', 1539825253),
(139, 65, 5, 'Job was created [CLIENT].', 1539831193),
(140, 66, 5, 'Job was created [CLIENT].', 1539831277),
(141, 67, 5, 'Job was created [CLIENT].', 1539831391),
(142, 66, 1, 'Job status was changed to In Progress', 1539833283),
(143, 65, 1, 'Job status was changed to In Progress', 1539833296),
(144, 64, 1, 'Job status was changed to Installed', 1539848469),
(145, 64, 1, 'Replied to the job.', 1539848493),
(146, 67, 1, 'Job status was changed to In Progress', 1539848524),
(147, 63, 1, 'Job status was changed to Installed', 1539910457),
(148, 63, 1, 'Replied to the job.', 1539910524),
(149, 68, 5, 'Job was created [CLIENT].', 1539920460),
(150, 69, 5, 'Job was created [CLIENT].', 1539920545),
(151, 66, 1, 'Job status was changed to Installed', 1539930393),
(152, 66, 1, 'Replied to the job.', 1539930417),
(153, 65, 1, 'Job status was changed to In Progress', 1539931810),
(154, 65, 1, 'Replied to the job.', 1539931989),
(155, 65, 1, 'Job status was changed to Installed', 1539932007),
(156, 69, 1, 'Job status was changed to Installed', 1540166112),
(157, 69, 1, 'Replied to the job.', 1540166202),
(158, 68, 1, 'Job status was changed to Installed', 1540166214),
(159, 68, 1, 'Replied to the job.', 1540166351),
(160, 70, 5, 'Job was created [CLIENT].', 1540169719),
(161, 71, 5, 'Job was created [CLIENT].', 1540169848),
(162, 72, 5, 'Job was created [CLIENT].', 1540170019),
(163, 73, 5, 'Job was created [CLIENT].', 1540175806),
(164, 74, 5, 'Job was created [CLIENT].', 1540177109),
(165, 70, 1, 'Job status was changed to In Progress', 1540186957),
(166, 71, 1, 'Job status was changed to In Progress', 1540186965),
(167, 73, 1, 'Job status was changed to In Progress', 1540187129),
(168, 74, 1, 'Job status was changed to Installed', 1540187138),
(169, 74, 1, 'Job status was changed to In Progress', 1540187140),
(170, 72, 1, 'Job status was changed to In Progress', 1540193270),
(171, 75, 5, 'Job was created [CLIENT].', 1540195177),
(172, 76, 5, 'Job was created [CLIENT].', 1540254320),
(173, 76, 1, 'Job status was changed to In Progress', 1540268930),
(174, 75, 1, 'Job status was changed to Installed', 1540268937),
(175, 75, 1, 'Job status was changed to In Progress', 1540268939),
(176, 73, 1, 'Job status was changed to Installed', 1540352065),
(177, 73, 1, 'Replied to the job.', 1540352109),
(178, 76, 1, 'Job status was changed to Installed', 1540352142),
(179, 76, 1, 'Replied to the job.', 1540352163),
(180, 70, 1, 'Job status was changed to Installed', 1540416001),
(181, 70, 1, 'Replied to the job.', 1540416045),
(182, 77, 5, 'Job was created [CLIENT].', 1540428792),
(183, 77, 1, 'Job status was changed to In Progress', 1540431948),
(184, 77, 1, 'Job status was changed to Installed', 1540515317),
(185, 77, 1, 'Replied to the job.', 1540515338),
(186, 78, 5, 'Job was created [CLIENT].', 1540519016),
(187, 79, 5, 'Job was created [CLIENT].', 1540519489),
(188, 79, 1, 'Job status was changed to In Progress', 1540680906),
(189, 78, 1, 'Job status was changed to In Progress', 1540680916),
(190, 67, 1, 'Job status was changed to Installed', 1540689852),
(191, 67, 1, 'Replied to the job.', 1540689884),
(192, 74, 1, 'Job status was changed to Installed', 1540695528),
(193, 74, 1, 'Replied to the job.', 1540695550),
(194, 79, 1, 'Job status was changed to Installed', 1540850819),
(195, 79, 1, 'Replied to the job.', 1540850858),
(196, 78, 1, 'Replied to the job.', 1540850907),
(197, 78, 1, 'Job status was changed to Installed', 1540855361),
(198, 80, 5, 'Job was created [CLIENT].', 1540959702),
(199, 80, 1, 'Job status was changed to Installed', 1540962219),
(200, 80, 1, 'Job status was changed to In Progress', 1540962222),
(201, 75, 1, 'Job status was changed to Installed', 1541041231),
(202, 75, 1, 'Replied to the job.', 1541041273),
(203, 72, 1, 'Job status was changed to Installed', 1541041284),
(204, 72, 1, 'Replied to the job.', 1541041307),
(205, 80, 1, 'Job status was changed to Installed', 1541387794),
(206, 80, 1, 'Replied to the job.', 1541389471),
(207, 81, 5, 'Job was created [CLIENT].', 1541473381),
(208, 81, 1, 'Job status was changed to In Progress', 1541485962),
(209, 81, 1, 'Job status was changed to Removed', 1541559620),
(210, 81, 1, 'Replied to the job.', 1541559622),
(211, 66, 1, 'Replied to the job.', 1541559682);

-- --------------------------------------------------------

--
-- Table structure for table `job_replies`
--

CREATE TABLE `job_replies` (
  `ID` int(11) NOT NULL,
  `jobid` int(11) NOT NULL,
  `userid` int(11) NOT NULL,
  `body` mediumtext COLLATE utf8_unicode_ci NOT NULL,
  `timestamp` int(11) NOT NULL,
  `replyid` int(11) NOT NULL,
  `files` int(11) NOT NULL,
  `hash` varchar(255) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `job_replies`
--

INSERT INTO `job_replies` (`ID`, `jobid`, `userid`, `body`, `timestamp`, `replyid`, `files`, `hash`) VALUES
(1, 12, 1, '<p>Installation Picture</p>\r\n', 1537275068, 0, 1, 'b46657747faa1c84af5fabfebb733d0e'),
(2, 34, 1, '<p>Installation picture</p>\r\n', 1538011808, 0, 1, 'f05e55b9a9cc4100629b42ef2ddb1a5a'),
(3, 44, 1, '<p>Installed</p>\r\n', 1538527903, 0, 1, 'ef70abdf29c06c29720ef8372d3edabb'),
(4, 42, 1, '<p>Installed</p>\r\n', 1538528014, 0, 1, '74e386539ae8f22bda9f97c0b3296d89'),
(5, 43, 1, '<p>Installed</p>\r\n', 1538528100, 0, 1, '1740d83e59f0806272e1175ed603c243'),
(6, 45, 1, '<p>Installed</p>\r\n', 1538537559, 0, 1, '03442176e0d5654b5318011f1ae045e0'),
(7, 46, 1, '<p>Installed</p>\r\n', 1538537846, 0, 1, '67f9ea9f8d503ffdc5fdb0a0784236b7'),
(8, 41, 1, '<p>Installed</p>\r\n', 1538623298, 0, 1, '1f4ea7eb0bc2a8a373169cbc8dcadb9f'),
(9, 40, 1, '<p>Installed</p>\r\n', 1538623346, 0, 1, '4d9a07dee8d3dc55dfaff159ff82bd1e'),
(14, 40, 1, '<p>test</p>\r\n', 1538969857, 0, 1, '2b135ff93896475c944bd8ed696fad30'),
(15, 40, 1, '<p>test</p>\r\n', 1538970038, 0, 1, '754ba3bdcfad2b52fa8730feb7534f95'),
(16, 49, 1, '<p>Installed</p>\r\n', 1539048351, 0, 1, 'f97cfe443797efb26b8202ff18c3db12'),
(17, 54, 1, '<p>Installed. &nbsp;Please note &#39;Exclusive Listing&#39; Decal applied after photo. &nbsp;Will update with&nbsp;new photo ASAP.</p>\r\n', 1539063363, 0, 1, '9fde4e4513754be52f7fc594b4a7f917'),
(18, 54, 1, '<p>Updated Install Photo</p>\r\n', 1539150328, 0, 1, '6231cd1b2ddf452285d91cce73172d07'),
(19, 55, 1, '<p>Installed</p>\r\n', 1539652145, 0, 1, '097d82113b069549fb884d60f654231d'),
(20, 59, 1, '<p>Installed</p>\r\n', 1539667446, 0, 1, '6626b34ff3c2b46a807a4101d8d255cc'),
(21, 62, 1, '<p>Installed</p>\r\n', 1539765886, 0, 1, 'a399d57193858640856534c2fa155a08'),
(22, 61, 1, '<p>Installed</p>\r\n', 1539765952, 0, 1, '6a12554bc627e7937a67eb2029f3db06'),
(23, 60, 1, '<p>Installed</p>\r\n', 1539766003, 0, 1, 'b068b61564d6846b719f0a9105490362'),
(24, 58, 1, '<p>Installed</p>\r\n', 1539825253, 0, 1, 'ed3b12972c6a2433f6932bef322ec7dd'),
(25, 64, 1, '<p>Installed</p>\r\n', 1539848493, 0, 1, '6185b96d3bf233a84d1370978d3bdb1e'),
(26, 63, 1, '<p>Installed. &nbsp;Backing brace installed to concrete as approved/requested&nbsp;by&nbsp;Hudson</p>\r\n', 1539910524, 0, 1, '0b1ac2d4d85db79a9ba8b3ae9c8a8fdf'),
(27, 66, 1, '<p>Installed</p>\r\n', 1539930417, 0, 1, 'ddb2ac87fccb7776bd07a1fab2e13117'),
(28, 65, 1, '<p>Installed</p>\r\n', 1539931989, 0, 1, '46a547a0d3560aef4934799b59bc0abe'),
(29, 69, 1, '<p>Installed. &nbsp;Location moved to further to left of driveway to avoid HP Gas line and Turning Trucks</p>\r\n', 1540166201, 0, 1, '02cd9bfbc36c6bbcae9f4a667e12410f'),
(30, 68, 1, '<p>Installed</p>\r\n', 1540166351, 0, 1, '6da7755ba39364f6452525ef5787b435'),
(31, 73, 1, '<p>Installed</p>\r\n', 1540352109, 0, 1, '2b1d6686f6b492253367bd469ce2923c'),
(32, 76, 1, '<p>Installed</p>\r\n', 1540352163, 0, 1, '00d64eab4c037b3a8a04bbf015e90f33'),
(33, 70, 1, '<p>Installed</p>\r\n', 1540416045, 0, 1, '173f3f38749967d7a14f5b8a97a6094d'),
(34, 77, 1, '<p>Installed</p>\r\n', 1540515338, 0, 1, '4b0c59f4aa5438c5d994e03b9d4048c7'),
(35, 67, 1, '<p>Installed</p>\r\n', 1540689884, 0, 1, 'f218d3b1db7453e7e8c6d593555e32ef'),
(36, 74, 1, '<p>Installed</p>\r\n', 1540695550, 0, 1, '8b11a50e200ce04ede0ed1b94e922b83'),
(37, 79, 1, '<p>Installed</p>\r\n', 1540850858, 0, 1, '47a0df130b505b9576c9a66c62d3e98f'),
(38, 78, 1, '<p>Installed</p>\r\n', 1540850907, 0, 1, '4a20004e45b4420d9e4ffc3b035d9d0d'),
(39, 75, 1, '<p>Installed</p>\r\n', 1541041273, 0, 1, '5441b65a9d3df445c7063d74f271b21c'),
(40, 72, 1, '<p>Installed</p>\r\n', 1541041307, 0, 1, '3aa1f45ebc8d642ae3c0ae954eb3c0a1'),
(41, 80, 1, '<p>Installed</p>\r\n', 1541389471, 0, 1, 'ec62fce338264b851d4c9b93996e32d4'),
(42, 81, 1, '<p>Removed</p>\r\n', 1541559622, 0, 0, '2698d4d81b8f49c46bfda38304395781'),
(43, 66, 1, '<p>&nbsp;Relocated as instructed to face Gympie Road</p>\r\n', 1541559682, 0, 1, 'c2d001c47ab99f3237a4d37ae177a616');

-- --------------------------------------------------------

--
-- Table structure for table `job_user_custom_fields`
--

CREATE TABLE `job_user_custom_fields` (
  `ID` int(11) NOT NULL,
  `fieldid` int(11) NOT NULL,
  `jobid` int(11) NOT NULL,
  `value` mediumtext COLLATE utf8_unicode_ci NOT NULL,
  `itemname` varchar(500) COLLATE utf8_unicode_ci NOT NULL,
  `support` int(11) NOT NULL,
  `error` varchar(1000) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `job_user_custom_fields`
--

INSERT INTO `job_user_custom_fields` (`ID`, `fieldid`, `jobid`, `value`, `itemname`, `support`, `error`) VALUES
(1, 1, 1, 'tunis', '', 0, ''),
(2, 2, 1, 'Retail', '', 0, ''),
(3, 3, 1, 'Landscape', '', 0, ''),
(4, 4, 1, 'Text Board', '', 0, ''),
(5, 5, 1, '2400x1800mm', '', 0, ''),
(6, 6, 1, 'Sale/Lease', '', 0, ''),
(7, 7, 1, 'dddd', '', 0, ''),
(8, 8, 1, 'Investment', '', 0, ''),
(9, 9, 1, 'dddd', '', 0, ''),
(10, 1, 2, 'tunis', '', 0, ''),
(11, 2, 2, 'Retail', '', 0, ''),
(12, 3, 2, 'Landscape', '', 0, ''),
(13, 4, 2, 'Text Board', '', 0, ''),
(14, 5, 2, '2400x1800mm', '', 0, ''),
(15, 6, 2, 'Sale/Lease', '', 0, ''),
(16, 7, 2, 'dddd', '', 0, ''),
(17, 8, 2, 'Investment', '', 0, ''),
(18, 9, 2, 'dddd', '', 0, ''),
(19, 1, 3, 'tunis', '', 0, ''),
(20, 2, 3, 'Retail', '', 0, ''),
(21, 3, 3, 'Landscape', '', 0, ''),
(22, 4, 3, 'Text Board', '', 0, ''),
(23, 5, 3, '2400x1800mm', '', 0, ''),
(24, 6, 3, 'Sale/Lease', '', 0, ''),
(25, 7, 3, 'dddd', '', 0, ''),
(26, 8, 3, 'Investment', '', 0, ''),
(27, 9, 3, 'dddd', '', 0, ''),
(28, 1, 4, 'tunis', '', 0, ''),
(29, 2, 4, 'Retail', '', 0, ''),
(30, 3, 4, 'Landscape', '', 0, ''),
(31, 4, 4, 'Text Board', '', 0, ''),
(32, 5, 4, '2400x1800mm', '', 0, ''),
(33, 6, 4, 'Sale/Lease', '', 0, ''),
(34, 7, 4, 'dddd', '', 0, ''),
(35, 8, 4, 'Investment', '', 0, ''),
(36, 9, 4, 'dddd', '', 0, ''),
(37, 1, 5, 'tunis', '', 0, ''),
(38, 2, 5, 'Retail', '', 0, ''),
(39, 3, 5, 'Landscape', '', 0, ''),
(40, 4, 5, 'Text Board', '', 0, ''),
(41, 5, 5, '2400x1800mm', '', 0, ''),
(42, 6, 5, 'Sale/Lease', '', 0, ''),
(43, 7, 5, 'dddd', '', 0, ''),
(44, 8, 5, 'Investment', '', 0, ''),
(45, 9, 5, 'dddd', '', 0, ''),
(46, 1, 6, 'tunis', '', 0, ''),
(47, 2, 6, 'Retail', '', 0, ''),
(48, 3, 6, 'Landscape', '', 0, ''),
(49, 4, 6, 'Text Board', '', 0, ''),
(50, 5, 6, '2400x1800mm', '', 0, ''),
(51, 6, 6, 'Sale/Lease', '', 0, ''),
(52, 7, 6, 'dddd', '', 0, ''),
(53, 8, 6, 'Investment', '', 0, ''),
(54, 9, 6, 'dddd', '', 0, ''),
(55, 1, 7, 'tunis', '', 0, ''),
(56, 2, 7, 'Retail', '', 0, ''),
(57, 3, 7, 'Landscape', '', 0, ''),
(58, 4, 7, 'Text Board', '', 0, ''),
(59, 5, 7, '2400x1800mm', '', 0, ''),
(60, 6, 7, 'Sale/Lease', '', 0, ''),
(61, 7, 7, 'dddd', '', 0, ''),
(62, 8, 7, 'Investment', '', 0, ''),
(63, 9, 7, 'dddd', '', 0, ''),
(64, 1, 8, '', '', 0, ''),
(65, 2, 8, 'Office', '', 0, ''),
(66, 3, 8, 'Portrait', '', 0, ''),
(67, 4, 8, 'Stockboard', '', 0, ''),
(68, 5, 8, '1800x1200mm', '', 0, ''),
(69, 6, 8, 'Sale', '', 0, ''),
(70, 7, 8, 'ddd', '', 0, ''),
(71, 8, 8, 'Exclusive Agent', '', 0, ''),
(72, 9, 8, 'sss', '', 0, ''),
(73, 2, 9, 'Office', '', 0, ''),
(74, 3, 9, 'Portrait', '', 0, ''),
(75, 4, 9, 'Stockboard', '', 0, ''),
(76, 5, 9, '1800x1200mm', '', 0, ''),
(77, 6, 9, 'Sale', '', 0, ''),
(78, 7, 9, '', '', 0, ''),
(79, 8, 9, 'Exclusive Agent', '', 0, ''),
(80, 9, 9, '', '', 0, ''),
(81, 2, 10, 'Office', '', 0, ''),
(82, 3, 10, 'Portrait', '', 0, ''),
(83, 4, 10, 'Stockboard', '', 0, ''),
(84, 5, 10, '1800x1200mm', '', 0, ''),
(85, 6, 10, 'Sale', '', 0, ''),
(86, 7, 10, '<p>xccs</p>\r\n', '', 0, ''),
(87, 8, 10, 'Exclusive Agent', '', 0, ''),
(88, 9, 10, '<p>dsscd</p>\r\n', '', 0, ''),
(89, 2, 11, 'Office', '', 0, ''),
(90, 3, 11, 'Portrait', '', 0, ''),
(91, 4, 11, 'Stockboard', '', 0, ''),
(92, 5, 11, '1800x1200mm', '', 0, ''),
(93, 6, 11, 'Sale', '', 0, ''),
(94, 7, 11, '', '', 0, ''),
(95, 8, 11, 'Exclusive Agent', '', 0, ''),
(96, 9, 11, '', '', 0, ''),
(97, 2, 12, 'Office', '', 0, ''),
(98, 3, 12, 'Portrait', '', 0, ''),
(99, 4, 12, 'Stockboard', '', 0, ''),
(100, 5, 12, '1800x1200mm', '', 0, ''),
(101, 6, 12, 'Sale', '', 0, ''),
(102, 7, 12, '<p>test</p>\r\n', '', 0, ''),
(103, 8, 12, 'Exclusive Agent', '', 0, ''),
(104, 9, 12, '<p>test</p>\r\n', '', 0, ''),
(105, 2, 13, 'Office', '', 0, ''),
(106, 3, 13, 'Portrait', '', 0, ''),
(107, 4, 13, 'Stockboard', '', 0, ''),
(108, 5, 13, '1800x1200mm', '', 0, ''),
(109, 6, 13, 'Sale', '', 0, ''),
(110, 7, 13, '<p>test</p>\r\n', '', 0, ''),
(111, 8, 13, 'Exclusive Agent', '', 0, ''),
(112, 9, 13, '<p>test</p>\r\n', '', 0, ''),
(113, 2, 14, 'Office', '', 0, ''),
(114, 3, 14, 'Portrait', '', 0, ''),
(115, 4, 14, 'Stockboard', '', 0, ''),
(116, 5, 14, '1800x1200mm', '', 0, ''),
(117, 6, 14, 'Sale', '', 0, ''),
(118, 7, 14, '<p>sqfsd</p>\r\n', '', 0, ''),
(119, 8, 14, 'Exclusive Agent', '', 0, ''),
(120, 9, 14, '<p>qsdfsdsd</p>\r\n', '', 0, ''),
(121, 2, 15, 'Office', '', 0, ''),
(122, 3, 15, 'Portrait', '', 0, ''),
(123, 4, 15, 'Stockboard', '', 0, ''),
(124, 5, 15, '1800x1200mm', '', 0, ''),
(125, 6, 15, 'Sale', '', 0, ''),
(126, 7, 15, '', '', 0, ''),
(127, 8, 15, 'Exclusive Agent', '', 0, ''),
(128, 9, 15, '', '', 0, ''),
(129, 2, 16, 'Office', '', 0, ''),
(130, 3, 16, 'Portrait', '', 0, ''),
(131, 4, 16, 'Stockboard', '', 0, ''),
(132, 5, 16, '1800x1200mm', '', 0, ''),
(133, 6, 16, 'Sale', '', 0, ''),
(134, 7, 16, '', '', 0, ''),
(135, 8, 16, 'Exclusive Agent', '', 0, ''),
(136, 9, 16, '', '', 0, ''),
(137, 2, 17, 'Office', '', 0, ''),
(138, 3, 17, 'Portrait', '', 0, ''),
(139, 4, 17, 'Stockboard', '', 0, ''),
(140, 5, 17, '1800x1200mm', '', 0, ''),
(141, 6, 17, 'Sale', '', 0, ''),
(142, 7, 17, '', '', 0, ''),
(143, 8, 17, 'Exclusive Agent', '', 0, ''),
(144, 9, 17, '', '', 0, ''),
(145, 2, 18, 'Office', '', 0, ''),
(146, 3, 18, 'Portrait', '', 0, ''),
(147, 4, 18, 'Stockboard', '', 0, ''),
(148, 5, 18, '1800x1200mm', '', 0, ''),
(149, 6, 18, 'Sale', '', 0, ''),
(150, 7, 18, '', '', 0, ''),
(151, 8, 18, 'Exclusive Agent', '', 0, ''),
(152, 9, 18, '', '', 0, ''),
(153, 2, 19, 'Office', '', 0, ''),
(154, 3, 19, 'Portrait', '', 0, ''),
(155, 4, 19, 'Stockboard', '', 0, ''),
(156, 5, 19, '1800x1200mm', '', 0, ''),
(157, 6, 19, 'Sale', '', 0, ''),
(158, 7, 19, '', '', 0, ''),
(159, 8, 19, 'Exclusive Agent', '', 0, ''),
(160, 9, 19, '', '', 0, ''),
(161, 2, 20, 'Office', '', 0, ''),
(162, 3, 20, 'Portrait', '', 0, ''),
(163, 4, 20, 'Stockboard', '', 0, ''),
(164, 5, 20, '1800x1200mm', '', 0, ''),
(165, 6, 20, 'Sale', '', 0, ''),
(166, 7, 20, '', '', 0, ''),
(167, 8, 20, 'Exclusive Agent', '', 0, ''),
(168, 9, 20, '', '', 0, ''),
(169, 2, 21, 'Office', '', 0, ''),
(170, 3, 21, 'Portrait', '', 0, ''),
(171, 4, 21, 'Stockboard', '', 0, ''),
(172, 5, 21, '1800x1200mm', '', 0, ''),
(173, 6, 21, 'Sale', '', 0, ''),
(174, 7, 21, '', '', 0, ''),
(175, 8, 21, 'Exclusive Agent', '', 0, ''),
(176, 9, 21, '', '', 0, ''),
(177, 2, 22, 'Office', '', 0, ''),
(178, 3, 22, 'Portrait', '', 0, ''),
(179, 4, 22, 'Stockboard', '', 0, ''),
(180, 5, 22, '1800x1200mm', '', 0, ''),
(181, 6, 22, 'Sale', '', 0, ''),
(182, 7, 22, '', '', 0, ''),
(183, 8, 22, 'Exclusive Agent', '', 0, ''),
(184, 9, 22, '', '', 0, ''),
(185, 2, 23, 'Office', '', 0, ''),
(186, 3, 23, 'Portrait', '', 0, ''),
(187, 4, 23, 'Stockboard', '', 0, ''),
(188, 5, 23, '1800x1200mm', '', 0, ''),
(189, 6, 23, 'Sale', '', 0, ''),
(190, 7, 23, '', '', 0, ''),
(191, 8, 23, 'Exclusive Agent', '', 0, ''),
(192, 9, 23, '', '', 0, ''),
(193, 10, 24, 'Remove Graffiti', '', 0, ''),
(194, 11, 24, '', '', 0, ''),
(195, 10, 25, 'Remove Graffiti', '', 0, ''),
(196, 11, 25, '<p>fdrgdf</p>\r\n', '', 0, ''),
(197, 10, 27, 'Relocate', '', 0, ''),
(198, 11, 27, '<p>sdfqdsgvsdgvmsdflo</p>\r\n', '', 0, ''),
(199, 2, 28, 'Office', '', 0, ''),
(200, 3, 28, 'Portrait', '', 0, ''),
(201, 4, 28, 'Stockboard', '', 0, ''),
(202, 5, 28, '1800x1200mm', '', 0, ''),
(203, 6, 28, 'Sale', '', 0, ''),
(204, 7, 28, 'test', '', 0, ''),
(205, 8, 28, 'Exclusive Agent', '', 0, ''),
(206, 9, 28, '<p>test</p>\r\n', '', 0, ''),
(207, 10, 30, 'Remove Graffiti', '', 0, ''),
(208, 11, 30, '<p>ffdfd</p>\r\n', '', 0, ''),
(209, 2, 31, 'Office', '', 0, ''),
(210, 3, 31, 'Portrait', '', 0, ''),
(211, 4, 31, 'Stockboard', '', 0, ''),
(212, 5, 31, '1800x1200mm', '', 0, ''),
(213, 6, 31, 'Sale', '', 0, ''),
(214, 7, 31, '', '', 0, ''),
(215, 8, 31, 'Exclusive Agent', '', 0, ''),
(216, 9, 31, '', '', 0, ''),
(217, 2, 32, 'Office', '', 0, ''),
(218, 3, 32, 'Portrait', '', 0, ''),
(219, 4, 32, 'Stockboard', '', 0, ''),
(220, 5, 32, '1800x1200mm', '', 0, ''),
(221, 6, 32, 'Lease', '', 0, ''),
(222, 7, 32, '', '', 0, ''),
(223, 8, 32, 'Exclusive Agent', '', 0, ''),
(224, 9, 32, '<p>Please install to front of lot as per attachement.</p>\r\n', '', 0, ''),
(225, 2, 33, 'Office', '', 0, ''),
(226, 3, 33, 'Portrait', '', 0, ''),
(227, 4, 33, 'Stockboard', '', 0, ''),
(228, 5, 33, '1800x1200mm', '', 0, ''),
(229, 6, 33, 'Sale', '', 0, ''),
(230, 7, 33, '', '', 0, ''),
(231, 8, 33, 'Exclusive Agent', '', 0, ''),
(232, 9, 33, '', '', 0, ''),
(233, 2, 34, 'Retail', '', 0, ''),
(234, 3, 34, 'NA', '', 0, ''),
(235, 4, 34, 'Window Graphic', '', 0, ''),
(236, 5, 34, 'Other', '', 0, ''),
(237, 6, 34, 'Lease', '', 0, ''),
(238, 7, 34, 'As Artwork', '', 0, ''),
(239, 8, 34, 'Other', '', 0, ''),
(240, 9, 34, '<p>Install to shopfront as picture supplied</p>\r\n', '', 0, ''),
(241, 2, 35, 'Office', '', 0, ''),
(242, 3, 35, 'Portrait', '', 0, ''),
(243, 4, 35, 'Stockboard', '', 0, ''),
(244, 5, 35, '1800x1200mm', '', 0, ''),
(245, 6, 35, 'Sale', '', 0, ''),
(246, 7, 35, 'aszc', '', 0, ''),
(247, 8, 35, 'Exclusive Agent', '', 0, ''),
(248, 9, 35, '', '', 0, ''),
(249, 10, 36, 'Remove Graffiti', '', 0, ''),
(250, 11, 36, '<p>fkjghfdkjvh</p>\r\n', '', 0, ''),
(251, 2, 37, 'Office', '', 0, ''),
(252, 3, 37, 'Portrait', '', 0, ''),
(253, 4, 37, 'Stockboard', '', 0, ''),
(254, 5, 37, '1800x1200mm', '', 0, ''),
(255, 6, 37, 'Sale', '', 0, ''),
(256, 7, 37, 'test', '', 0, ''),
(257, 8, 37, 'Exclusive Agent', '', 0, ''),
(258, 9, 37, '<p>test</p>\r\n', '', 0, ''),
(259, 10, 38, 'Remove Graffiti', '', 0, ''),
(260, 11, 38, '<p>test</p>\r\n', '', 0, ''),
(261, 2, 39, 'Office', '', 0, ''),
(262, 3, 39, 'Portrait', '', 0, ''),
(263, 4, 39, 'Stockboard', '', 0, ''),
(264, 5, 39, '1800x1200mm', '', 0, ''),
(265, 6, 39, 'Lease', '', 0, ''),
(266, 7, 39, 'DK', '', 0, ''),
(267, 8, 39, 'Other', '', 0, ''),
(268, 9, 39, '<p>Please place sign as shown below. &nbsp;Any issues call 0423 591 541</p>\r\n', '', 0, ''),
(269, 2, 40, 'Office', '', 0, ''),
(270, 3, 40, 'Portrait', '', 0, ''),
(271, 4, 40, 'Stockboard', '', 0, ''),
(272, 5, 40, '1800x1200mm', '', 0, ''),
(273, 6, 40, 'Sale', '', 0, ''),
(274, 7, 40, '', '', 0, ''),
(275, 8, 40, 'Exclusive Agent', '', 0, ''),
(276, 9, 40, '', '', 0, ''),
(277, 2, 41, 'Office', '', 0, ''),
(278, 3, 41, 'Portrait', '', 0, ''),
(279, 4, 41, 'Text Board', '', 0, ''),
(280, 5, 41, '2400x1800mm', '', 0, ''),
(281, 6, 41, 'Lease', '', 0, ''),
(282, 7, 41, 'VS &amp; Conjunctional Agents', '', 0, ''),
(283, 8, 41, 'Other', '', 0, ''),
(284, 9, 41, '<p>Please install signage against the fence as per the diagram.</p>\r\n', '', 0, ''),
(285, 2, 42, 'Land', '', 0, ''),
(286, 3, 42, 'Portrait', '', 0, ''),
(287, 4, 42, 'Stockboard', '', 0, ''),
(288, 5, 42, '1800x1200mm', '', 0, ''),
(289, 6, 42, 'Lease', '', 0, ''),
(290, 7, 42, 'James Doyle 0423 591 530 &amp; Lawrence Temple 0423 591 534', '', 0, ''),
(291, 8, 42, 'Other', '', 0, ''),
(292, 9, 42, '<p>Please place signage in between the existing Raine &amp; Horne signs facing Kingsford Smith Drive. Do not remove the current sigange.</p>\r\n', '', 0, ''),
(293, 2, 43, 'Land', '', 0, ''),
(294, 3, 43, 'Portrait', '', 0, ''),
(295, 4, 43, 'Stockboard', '', 0, ''),
(296, 5, 43, '1800x1200mm', '', 0, ''),
(297, 6, 43, 'Lease', '', 0, ''),
(298, 7, 43, 'James Doyle 0423 591 530 &amp; Lawrence Temple 0423 591 534', '', 0, ''),
(299, 8, 43, 'Other', '', 0, ''),
(300, 9, 43, '<p>Please place signage to the right hand side of the driveway facing the road as per the diagram.</p>\r\n', '', 0, ''),
(301, 2, 44, 'Office', '', 0, ''),
(302, 3, 44, 'Portrait', '', 0, ''),
(303, 4, 44, 'Stockboard', '', 0, ''),
(304, 5, 44, '1800x1200mm', '', 0, ''),
(305, 6, 44, 'Lease', '', 0, ''),
(306, 7, 44, 'James Doyle 0423 591 530 &amp; Lawrence Temple 0423 591 534', '', 0, ''),
(307, 8, 44, 'Unit', '', 0, ''),
(308, 9, 44, '<p>Unit 1 &amp; 4</p>\r\n\r\n<p>Please place sigange to the right of King &amp; Co&#39;s sign up against the metal fence. Ensure not to attach to the gate or infront of any signage.</p>\r\n', '', 0, ''),
(309, 2, 45, 'Industrial', '', 0, ''),
(310, 3, 45, 'Portrait', '', 0, ''),
(311, 4, 45, 'Stockboard', '', 0, ''),
(312, 5, 45, '1800x1200mm', '', 0, ''),
(313, 6, 45, 'Lease', '', 0, ''),
(314, 7, 45, 'Michael Schafferius 0423 591 540 &amp; Lawrence Temple 0423 591 534', '', 0, ''),
(315, 8, 45, 'Unit', '', 0, ''),
(316, 9, 45, '<p>Unit 1</p>\r\n\r\n<p>Please place signage to the left hand side of the driveway as per the diagram. Do not attach to the fence.</p>\r\n', '', 0, ''),
(317, 2, 46, 'Retail', '', 0, ''),
(318, 3, 46, 'NA', '', 0, ''),
(319, 4, 46, 'Window Graphic', '', 0, ''),
(320, 5, 46, 'Other', '', 0, ''),
(321, 6, 46, 'Lease', '', 0, ''),
(322, 7, 46, 'As Artwork', '', 0, ''),
(323, 8, 46, 'Other', '', 0, ''),
(324, 9, 46, '<p>Installation as supplied by approved artowrk</p>\r\n', '', 0, ''),
(325, 2, 47, 'Office', '', 0, ''),
(326, 3, 47, 'Portrait', '', 0, ''),
(327, 4, 47, 'Stockboard', '', 0, ''),
(328, 5, 47, '1800x1200mm', '', 0, ''),
(329, 6, 47, 'Sale', '', 0, ''),
(330, 7, 47, '', '', 0, ''),
(331, 8, 47, 'Exclusive Agent', '', 0, ''),
(332, 9, 47, '', '', 0, ''),
(333, 2, 48, 'Retail', '', 0, ''),
(334, 3, 48, 'Landscape', '', 0, ''),
(335, 4, 48, 'Text Board', '', 0, ''),
(336, 5, 48, '1800x1200mm', '', 0, ''),
(337, 6, 48, 'Sale', '', 0, ''),
(338, 7, 48, '', '', 0, ''),
(339, 8, 48, 'Exclusive Agent', '', 0, ''),
(340, 9, 48, '', '', 0, ''),
(341, 2, 49, 'Industrial', '', 0, ''),
(342, 3, 49, 'Portrait', '', 0, ''),
(343, 4, 49, 'Text Board', '', 0, ''),
(344, 5, 49, '2400x1800mm', '', 0, ''),
(345, 6, 49, 'Lease', '', 0, ''),
(346, 7, 49, 'Conjunctional Board', '', 0, ''),
(347, 8, 49, 'Other', '', 0, ''),
(348, 9, 49, '<p>Please install signage as per the diagram to the right of the roller door.</p>\r\n', '', 0, ''),
(349, 2, 50, 'Office', '', 0, ''),
(350, 3, 50, 'Portrait', '', 0, ''),
(351, 4, 50, 'Stockboard', '', 0, ''),
(352, 5, 50, '1800x1200mm', '', 0, ''),
(353, 6, 50, '10', '', 0, ''),
(354, 7, 50, 'No', '', 0, ''),
(355, 8, 50, 'Sale/Lease', '', 0, ''),
(356, 10, 50, 'James Doyle 0423 591 530', '', 0, ''),
(357, 9, 50, 'Lawrence Temple 0423 591 534', '', 0, ''),
(358, 14, 50, 'Unit', '', 0, ''),
(359, 11, 50, '<p>Unit 6,18,22</p>\r\n\r\n<p>Please place signage to the left hand side of the driveway as per the old signage in the diagram below, facing Depot Street</p>\r\n', '', 0, ''),
(360, 2, 51, 'Office', '', 0, ''),
(361, 3, 51, 'Portrait', '', 0, ''),
(362, 4, 51, 'Stockboard', '', 0, ''),
(363, 5, 51, '1800x1200mm', '', 0, ''),
(364, 6, 51, '10', '', 0, ''),
(365, 7, 51, 'No', '', 0, ''),
(366, 8, 51, 'Sale/Lease', '', 0, ''),
(367, 10, 51, 'James Doyle 0423 591 530', '', 0, ''),
(368, 9, 51, 'Lawrence Temple 0423 591 534', '', 0, ''),
(369, 14, 51, 'Multiple', '', 0, ''),
(370, 11, 51, '<p>Unit 6,18,22</p>\r\n\r\n<p>Please place signage to the left hand side of the driveway as per the old signage in the diagram below, facing Depot Street</p>\r\n', '', 0, ''),
(371, 10, 40, 'James Doyle 0423 591 530', '', 0, ''),
(372, 10, 41, 'James Doyle 0423 591 530', '', 0, ''),
(373, 10, 42, 'James Doyle 0423 591 530', '', 0, ''),
(374, 10, 43, 'James Doyle 0423 591 530', '', 0, ''),
(375, 10, 44, 'James Doyle 0423 591 530', '', 0, ''),
(376, 10, 45, 'James Doyle 0423 591 530', '', 0, ''),
(377, 10, 46, 'James Doyle 0423 591 530', '', 0, ''),
(378, 10, 49, 'James Doyle 0423 591 530', '', 0, ''),
(379, 10, 50, 'James Doyle 0423 591 530', '', 0, ''),
(380, 2, 52, 'Office', '', 0, ''),
(381, 3, 52, 'Portrait', '', 0, ''),
(382, 4, 52, 'Stockboard', '', 0, ''),
(383, 5, 52, '1800x1200mm', '', 0, ''),
(384, 6, 52, '10', '', 0, ''),
(385, 7, 52, 'No', '', 0, ''),
(386, 8, 52, 'Sale', '', 0, ''),
(387, 10, 52, 'Trent Bruce 0423 591 528', '', 0, ''),
(388, 9, 52, 'Brandon Mertz 0423 591 533', '', 0, ''),
(389, 14, 52, 'Multiple', '', 0, ''),
(390, 11, 52, '', '', 0, ''),
(391, 2, 53, 'Office', '', 0, ''),
(392, 3, 53, 'Portrait', '', 0, ''),
(393, 4, 53, 'Stockboard', '', 0, ''),
(394, 5, 53, '1800x1200mm', '', 0, ''),
(395, 6, 53, '10', '', 0, ''),
(396, 7, 53, 'No', '', 0, ''),
(397, 8, 53, 'Sale', '', 0, ''),
(398, 10, 53, 'Trent Bruce 0423 591 528', '', 0, ''),
(399, 9, 53, 'Trent Bruce 0423 591 528', '', 0, ''),
(400, 14, 53, 'Multiple', '', 0, ''),
(401, 11, 53, '', '', 0, ''),
(402, 2, 54, 'Industrial', '', 0, ''),
(403, 3, 54, 'Portrait', '', 0, ''),
(404, 4, 54, 'Stockboard', '', 0, ''),
(405, 5, 54, '1800x1200mm', '', 0, ''),
(406, 6, 54, '10', '', 0, ''),
(407, 7, 54, 'No', '', 0, ''),
(408, 8, 54, 'Sale/Lease', '', 0, ''),
(409, 10, 54, 'James Doyle 0423 591 530', '', 0, ''),
(410, 9, 54, 'Lawrence Temple 0423 591 534', '', 0, ''),
(411, 14, 54, 'Multiple', '', 0, ''),
(412, 11, 54, '<p>Unit 6,18,22 &amp; Exclusive Agent</p>\r\n\r\n<p>Please place signage to the left hand side of the driveway as per the old signage in the diagram below, facing Depot Street</p>\r\n', '', 0, ''),
(413, 2, 55, 'Office', '', 0, ''),
(414, 3, 55, 'NA', '', 0, ''),
(415, 4, 55, 'Window Graphic', '', 0, ''),
(416, 5, 55, 'Other', '', 0, ''),
(417, 6, 55, '10', '', 0, ''),
(418, 7, 55, 'No', '', 0, ''),
(419, 8, 55, 'Lease', '', 0, ''),
(420, 10, 55, 'Trent Bruce 0423 591 528', '', 0, ''),
(421, 9, 55, ' NA', '', 0, ''),
(422, 14, 55, 'NA', '', 0, ''),
(423, 11, 55, '<p>Printed vinyl install to&nbsp;1 x Small Lightbox to the side viewable From&nbsp;Stanely St only. &nbsp;2 x Large lightbox faces to each side of office/building.</p>\r\n', '', 0, ''),
(424, 2, 56, 'Office', '', 0, ''),
(425, 3, 56, 'Portrait', '', 0, ''),
(426, 4, 56, 'Stockboard', '', 0, ''),
(427, 5, 56, '1800x1200mm', '', 0, ''),
(428, 6, 56, '10', '', 0, ''),
(429, 7, 56, 'No', '', 0, ''),
(430, 8, 56, 'Sale', '', 0, ''),
(431, 10, 56, 'Trent Bruce 0423 591 528', '', 0, ''),
(432, 9, 56, 'Trent Bruce 0423 591 528', '', 0, ''),
(433, 14, 56, 'Multiple', '', 0, ''),
(434, 11, 56, '', '', 0, ''),
(435, 2, 57, 'Office', '', 0, ''),
(436, 3, 57, 'Portrait', '', 0, ''),
(437, 4, 57, 'Stockboard', '', 0, ''),
(438, 5, 57, '1800x1200mm', '', 0, ''),
(439, 7, 57, 'No', '', 0, ''),
(440, 8, 57, 'Sale', '', 0, ''),
(441, 10, 57, 'Trent Bruce 0423 591 528', '', 0, ''),
(442, 9, 57, 'Trent Bruce 0423 591 528', '', 0, ''),
(443, 14, 57, 'Multiple', '', 0, ''),
(444, 11, 57, '', '', 0, ''),
(445, 6, 57, '5', '', 0, ''),
(446, 2, 58, 'Retail', '', 0, ''),
(447, 3, 58, 'Portrait', '', 0, ''),
(448, 4, 58, 'Stockboard', '', 0, ''),
(449, 5, 58, '1800x1200mm', '', 0, ''),
(450, 7, 58, 'Yes', '', 0, ''),
(451, 8, 58, 'Lease', '', 0, ''),
(452, 10, 58, 'James Doyle 0423 591 530', '', 0, ''),
(453, 9, 58, 'Lawrence Temple 0423 591 534', '', 0, ''),
(454, 14, 58, 'NA', '', 0, ''),
(455, 11, 58, '<p>Please place V-board&nbsp;on top of the awning ensuring that each sign is clearly seen by the oncoming traffic.</p>\r\n', '', 0, ''),
(456, 6, 58, '2', '', 0, ''),
(457, 2, 59, 'Office', '', 0, ''),
(458, 3, 59, 'Portrait', '', 0, ''),
(459, 4, 59, 'Stockboard', '', 0, ''),
(460, 5, 59, '1800x1200mm', '', 0, ''),
(461, 7, 59, 'No', '', 0, ''),
(462, 8, 59, 'Lease', '', 0, ''),
(463, 10, 59, 'James Doyle 0423 591 530', '', 0, ''),
(464, 9, 59, 'Lawrence Temple 0423 591 534', '', 0, ''),
(465, 14, 59, 'NA', '', 0, ''),
(466, 11, 59, '<p>Place place sign directly on the right hand side of the driveway, ensuring it is freestanding and NOT attached or tied to the fence.</p>\r\n', '', 0, ''),
(467, 6, 59, '1', '', 0, ''),
(468, 2, 60, 'Industrial', '', 0, ''),
(469, 3, 60, 'Portrait', '', 0, ''),
(470, 4, 60, 'Stockboard', '', 0, ''),
(471, 5, 60, '1800x1200mm', '', 0, ''),
(472, 7, 60, 'No', '', 0, ''),
(473, 8, 60, 'Lease', '', 0, ''),
(474, 10, 60, 'Michael Schafferius 0423 591 540', '', 0, ''),
(475, 9, 60, 'Lawrence Temple 0423 591 534', '', 0, ''),
(476, 14, 60, 'Other', '', 0, ''),
(477, 11, 60, '<p>Please place sign on the right hand side of the driveway as shown in image sent to you. Please place a &quot;Multiple Units&quot; sticker on board.&nbsp;</p>\r\n', '', 0, ''),
(478, 6, 60, '1', '', 0, ''),
(479, 2, 61, 'Office', '', 0, ''),
(480, 3, 61, 'Portrait', '', 0, ''),
(481, 4, 61, 'Stockboard', '', 0, ''),
(482, 5, 61, '1800x1200mm', '', 0, ''),
(483, 7, 61, 'No', '', 0, ''),
(484, 8, 61, 'Lease', '', 0, ''),
(485, 10, 61, 'Michael Schafferius 0423 591 540', '', 0, ''),
(486, 9, 61, 'Lawrence Temple 0423 591 534', '', 0, ''),
(487, 14, 61, 'Multiple', '', 0, ''),
(488, 11, 61, '<p>Please place board on the left hand side of the driveway, angled facing the left as shown in image sent to you. Please place &nbsp;&quot;Unit 6&quot; &amp; &quot;Exclusive Agent&quot; stickers on board.</p>\r\n', '', 0, ''),
(489, 6, 61, '1', '', 0, ''),
(490, 2, 62, 'Industrial', '', 0, ''),
(491, 3, 62, 'Portrait', '', 0, ''),
(492, 4, 62, 'Stockboard', '', 0, ''),
(493, 5, 62, '1800x1200mm', '', 0, ''),
(494, 7, 62, 'Yes', '', 0, ''),
(495, 8, 62, 'Sale', '', 0, ''),
(496, 10, 62, 'Vaughn Smart 0423 591 531', '', 0, ''),
(497, 9, 62, 'Trent Bruce 0423 591 528', '', 0, ''),
(498, 14, 62, 'Multiple', '', 0, ''),
(499, 11, 62, '<p>Please install V-Board on the right hand side of the drvieway, as shown in image sent to you. Please place &quot;Exclusive Agent&quot; &amp; &quot;Unit 6&quot; overlay on both boards.</p>\r\n', '', 0, ''),
(500, 6, 62, '2', '', 0, ''),
(501, 2, 63, 'Retail', '', 0, ''),
(502, 3, 63, 'Portrait', '', 0, ''),
(503, 4, 63, 'Stockboard', '', 0, ''),
(504, 5, 63, '1800x1200mm', '', 0, ''),
(505, 7, 63, 'No', '', 0, ''),
(506, 8, 63, 'Lease', '', 0, ''),
(507, 10, 63, 'Hudson Dale 0423 591 529', '', 0, ''),
(508, 9, 63, ' NA', '', 0, ''),
(509, 14, 63, 'Exclusive Agent', '', 0, ''),
(510, 11, 63, '<p>Please place signage in the concrete as per the diagram attached.</p>\r\n', '', 0, ''),
(511, 6, 63, '1', '', 0, ''),
(512, 2, 64, 'Office', '', 0, ''),
(513, 3, 64, 'Portrait', '', 0, ''),
(514, 4, 64, 'Stockboard', '', 0, ''),
(515, 5, 64, '1800x1200mm', '', 0, ''),
(516, 7, 64, 'No', '', 0, ''),
(517, 8, 64, 'Sale/Lease', '', 0, ''),
(518, 10, 64, 'David Kettle 0423 591 541', '', 0, ''),
(519, 9, 64, ' NA', '', 0, ''),
(520, 14, 64, 'Multiple', '', 0, ''),
(521, 11, 64, '<p>Please place sign as shown in image sent to you, please face a little towards oncoming traffic. Please place the following overlays: &quot;Exclusive Agent&quot;, &quot;35sqm Strata Office&quot;</p>\r\n', '', 0, ''),
(522, 6, 64, '1', '', 0, ''),
(523, 2, 65, 'Retail', '', 0, ''),
(524, 3, 65, 'Portrait', '', 0, ''),
(525, 4, 65, 'Stockboard', '', 0, ''),
(526, 5, 65, '1800x1200mm', '', 0, ''),
(527, 7, 65, 'No', '', 0, ''),
(528, 8, 65, 'Sale/Lease', '', 0, ''),
(529, 10, 65, 'Hudson Dale 0423 591 529', '', 0, ''),
(530, 9, 65, 'David Miller 0423 591 111', '', 0, ''),
(531, 14, 65, 'NA', '', 0, ''),
(532, 11, 65, '<p>Please install on Shand Street side of the complex as per the diagram</p>\r\n', '', 0, ''),
(533, 6, 65, '1', '', 0, ''),
(534, 2, 66, 'Retail', '', 0, ''),
(535, 3, 66, 'Portrait', '', 0, ''),
(536, 4, 66, 'Stockboard', '', 0, ''),
(537, 5, 66, '1800x1200mm', '', 0, ''),
(538, 7, 66, 'No', '', 0, ''),
(539, 8, 66, 'Lease', '', 0, ''),
(540, 10, 66, 'Hudson Dale 0423 591 529', '', 0, ''),
(541, 9, 66, 'Trent Bruce 0423 591 528', '', 0, ''),
(542, 14, 66, 'Exclusive Agent', '', 0, ''),
(543, 11, 66, '<p>Please install signage to the left hand side of the right driveway as per the diagram sent to you.</p>\r\n', '', 0, ''),
(544, 6, 66, '1', '', 0, ''),
(545, 2, 67, 'Office', '', 0, ''),
(546, 3, 67, 'Portrait', '', 0, ''),
(547, 4, 67, 'Text Board', '', 0, ''),
(548, 5, 67, '2400x1800mm', '', 0, ''),
(549, 7, 67, 'No', '', 0, ''),
(550, 8, 67, 'Auction', '', 0, ''),
(551, 10, 67, 'Vaughn Smart 0423 591 531', '', 0, ''),
(552, 9, 67, 'David Kettle 0423 591 541', '', 0, ''),
(553, 14, 67, 'Exclusive Agent', '', 0, ''),
(554, 11, 67, '<p>Please ensure AUCTION heading is an overlay over SALE &amp; AUCTION DETAILS are an overlay only.</p>\r\n\r\n<p>Please install in the garden bed as per the diagram. Please be careful of newly painted garden bed when installing</p>\r\n', '', 0, ''),
(555, 6, 67, '1', '', 0, ''),
(556, 2, 68, 'Office', '', 0, ''),
(557, 3, 68, 'Portrait', '', 0, ''),
(558, 4, 68, 'Stockboard', '', 0, ''),
(559, 5, 68, '1800x1200mm', '', 0, ''),
(560, 7, 68, 'No', '', 0, ''),
(561, 8, 68, 'Lease', '', 0, ''),
(562, 10, 68, 'James Doyle 0423 591 530', '', 0, ''),
(563, 9, 68, 'Lawrence Temple 0423 591 534', '', 0, ''),
(564, 14, 68, 'NA', '', 0, ''),
(565, 11, 68, '<p>Please place one sign on the left hand side of the drive way on Ashtan Place into the complex, next to King &amp; Co&#39;s sign. Please have sign facing the road. Please have the other sign against the fence, facing Nudgee Road,</p>\r\n', '', 0, ''),
(566, 6, 68, '2', '', 0, ''),
(567, 2, 69, 'Industrial', '', 0, ''),
(568, 3, 69, 'Portrait', '', 0, ''),
(569, 4, 69, 'Stockboard', '', 0, ''),
(570, 5, 69, '1800x1200mm', '', 0, ''),
(571, 7, 69, 'Yes', '', 0, ''),
(572, 8, 69, 'Sale', '', 0, ''),
(573, 10, 69, 'Hudson Dale 0423 591 529', '', 0, ''),
(574, 9, 69, ' NA', '', 0, ''),
(575, 14, 69, 'Exclusive Agent', '', 0, ''),
(576, 11, 69, '<p>Please place V board on the left hand side of the driveway in front of the fence.</p>\r\n', '', 0, ''),
(577, 6, 69, '2', '', 0, ''),
(578, 2, 70, 'Office', '', 0, ''),
(579, 3, 70, 'Portrait', '', 0, ''),
(580, 4, 70, 'Stockboard', '', 0, ''),
(581, 5, 70, '1800x1200mm', '', 0, ''),
(582, 7, 70, 'No', '', 0, ''),
(583, 8, 70, 'Auction', '', 0, ''),
(584, 10, 70, 'Vaughn Smart 0423 591 531', '', 0, ''),
(585, 9, 70, 'David Kettle 0423 591 541', '', 0, ''),
(586, 14, 70, 'Multiple', '', 0, ''),
(587, 11, 70, '<p>Exclusive Agent</p>\r\n\r\n<p>&quot;Auction&quot; heading to be an overlay only</p>\r\n\r\n<p>&quot;In-Rooms Wed 21st Nov 2018&quot; to be an overlay only</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>Please install as per the diagram in the garden bed. Please place board face on to oncoming traffic.</p>\r\n', '', 0, ''),
(588, 6, 70, '1', '', 0, ''),
(589, 2, 71, 'Office', '', 0, ''),
(590, 3, 71, 'Portrait', '', 0, ''),
(591, 4, 71, 'Stockboard', '', 0, ''),
(592, 5, 71, '1800x1200mm', '', 0, ''),
(593, 7, 71, 'No', '', 0, ''),
(594, 8, 71, 'Lease', '', 0, ''),
(595, 10, 71, 'James Doyle 0423 591 530', '', 0, ''),
(596, 9, 71, 'Lawrence Temple 0423 591 534', '', 0, ''),
(597, 14, 71, 'Exclusive Agent', '', 0, ''),
(598, 11, 71, '<p>Address also known as - 5 Huntington Place, Banyo</p>\r\n\r\n<p>Please install signage on the corner up against the fence facing Buchanan Road</p>\r\n', '', 0, ''),
(599, 6, 71, '1', '', 0, ''),
(600, 2, 72, 'Retail', '', 0, ''),
(601, 3, 72, 'Portrait', '', 0, ''),
(602, 4, 72, 'Text Board', '', 0, ''),
(603, 5, 72, '2400x1800mm', '', 0, ''),
(604, 7, 72, 'No', '', 0, ''),
(605, 8, 72, 'Auction', '', 0, ''),
(606, 10, 72, 'Trent Bruce 0423 591 528', '', 0, ''),
(607, 9, 72, 'Hudson Dale 0423 591 529', '', 0, ''),
(608, 14, 72, 'Multiple', '', 0, ''),
(609, 11, 72, '<p>Please install signage as shown in the diagram on the awning. Please ensure signage in on an angle facing westbound traffic.</p>\r\n\r\n<p>If you have any questions regarding install , please phone Trent 0423 591 528.</p>\r\n\r\n<p>AUCTION heading to be an overlay only</p>\r\n\r\n<p>AUCTION DETAILS to be an overlay only &quot;In-Rooms 11:00am 21 November 2018 (If Not Sold Prior)&quot;</p>\r\n\r\n<p>Thankyou</p>\r\n', '', 0, ''),
(610, 6, 72, '1', '', 0, ''),
(611, 2, 73, 'Retail', '', 0, ''),
(612, 3, 73, 'Portrait', '', 0, ''),
(613, 4, 73, 'Text Board', '', 0, ''),
(614, 5, 73, '1800x1200mm', '', 0, ''),
(615, 7, 73, 'No', '', 0, ''),
(616, 8, 73, 'Auction', '', 0, ''),
(617, 10, 73, 'Trent Bruce 0423 591 528', '', 0, ''),
(618, 9, 73, 'Hudson Dale 0423 591 529', '', 0, ''),
(619, 14, 73, 'Multiple', '', 0, ''),
(620, 11, 73, '<p>AUCTION heading overlay only</p>\r\n\r\n<p>AUCTION details - overlay only</p>\r\n\r\n<p>Small Textboards</p>\r\n\r\n<p>Please place 1 board to the right hand side of the entrance on a slight angle facing traffic. Please place the 2nd board on the left hand side of the property flush with the building in the concrete.</p>\r\n', '', 0, ''),
(621, 6, 73, '2', '', 0, ''),
(622, 2, 74, 'Office', '', 0, ''),
(623, 3, 74, 'Portrait', '', 0, ''),
(624, 4, 74, 'Text Board', '', 0, ''),
(625, 5, 74, '2400x1800mm', '', 0, ''),
(626, 7, 74, 'No', '', 0, ''),
(627, 8, 74, 'Lease', '', 0, ''),
(628, 10, 74, 'Vaughn Smart 0423 591 531', '', 0, ''),
(629, 9, 74, 'Brandon Mertz 0423 591 533', '', 0, ''),
(630, 14, 74, 'Exclusive Agent', '', 0, ''),
(631, 11, 74, '<p>Please install signage to the right hand side of the driveway against the hedges.</p>\r\n', '', 0, ''),
(632, 6, 74, '1', '', 0, ''),
(633, 2, 75, 'Office', '', 0, ''),
(634, 3, 75, 'NA', '', 0, ''),
(635, 4, 75, 'Banner', '', 0, ''),
(636, 5, 75, 'Other', '', 0, ''),
(637, 7, 75, 'No', '', 0, ''),
(638, 8, 75, 'Lease', '', 0, ''),
(639, 10, 75, 'David Kettle 0423 591 541', '', 0, ''),
(640, 9, 75, ' NA', '', 0, ''),
(641, 14, 75, 'NA', '', 0, ''),
(642, 11, 75, '<p>Installation to site at approved by photo. &nbsp;Install between two poles with cable tie or similar</p>\r\n', '', 0, ''),
(643, 6, 75, '1', '', 0, ''),
(644, 2, 76, 'Office', '', 0, ''),
(645, 3, 76, 'Portrait', '', 0, ''),
(646, 4, 76, 'Stockboard', '', 0, ''),
(647, 5, 76, '1800x1200mm', '', 0, ''),
(648, 7, 76, 'No', '', 0, ''),
(649, 8, 76, 'Sale', '', 0, ''),
(650, 10, 76, 'Hudson Dale 0423 591 529', '', 0, ''),
(651, 9, 76, ' NA', '', 0, ''),
(652, 14, 76, 'Exclusive Agent', '', 0, ''),
(653, 11, 76, '<p>Please place signage to the right of the driveway in the garden bed.</p>\r\n', '', 0, ''),
(654, 6, 76, '1', '', 0, ''),
(655, 2, 77, 'Retail', '', 0, ''),
(656, 3, 77, 'NA', '', 0, ''),
(657, 4, 77, 'Window Graphic', '', 0, ''),
(658, 5, 77, 'Other', '', 0, ''),
(659, 7, 77, 'No', '', 0, ''),
(660, 8, 77, 'Auction', '', 0, ''),
(661, 10, 77, 'Brandon Mertz 0423 591 533', '', 0, ''),
(662, 9, 77, 'Vaughn Smart 0423 591 531', '', 0, ''),
(663, 14, 77, 'NA', '', 0, ''),
(664, 11, 77, '<p>Install to window onsite as approved</p>\r\n', '', 0, ''),
(665, 6, 77, '1', '', 0, ''),
(666, 2, 78, 'Office', '', 0, ''),
(667, 3, 78, 'Portrait', '', 0, ''),
(668, 4, 78, 'Stockboard', '', 0, ''),
(669, 5, 78, '1800x1200mm', '', 0, ''),
(670, 7, 78, 'No', '', 0, ''),
(671, 8, 78, 'Lease', '', 0, ''),
(672, 10, 78, 'David Miller 0423 591 111', '', 0, ''),
(673, 9, 78, 'Hudson Dale 0423 591 529', '', 0, ''),
(674, 14, 78, 'NA', '', 0, ''),
(675, 11, 78, '<p>Please install one sign to the left of the property within the garden bed as shown in image sent to you. Please install another sign in front of the property within the garden bed as shown in image sent to you.</p>\r\n', '', 0, ''),
(676, 6, 78, '2', '', 0, ''),
(677, 2, 79, 'Office', '', 0, ''),
(678, 3, 79, 'Portrait', '', 0, ''),
(679, 4, 79, 'Stockboard', '', 0, ''),
(680, 5, 79, '1800x1200mm', '', 0, ''),
(681, 7, 79, 'No', '', 0, ''),
(682, 8, 79, 'Lease', '', 0, ''),
(683, 10, 79, 'David Kettle 0423 591 541', '', 0, ''),
(684, 9, 79, 'Brandon Mertz 0423 591 533', '', 0, ''),
(685, 14, 79, 'Exclusive Agent', '', 0, ''),
(686, 11, 79, '<p>Please place sign on the corner on fence as shown in image sent to you.</p>\r\n', '', 0, ''),
(687, 6, 79, '1', '', 0, ''),
(688, 2, 80, 'Retail', '', 0, ''),
(689, 3, 80, 'Portrait', '', 0, ''),
(690, 4, 80, 'Text Board', '', 0, ''),
(691, 5, 80, '1800x1200mm', '', 0, ''),
(692, 7, 80, 'No', '', 0, ''),
(693, 8, 80, 'Lease', '', 0, ''),
(694, 10, 80, 'Michael Richardson 0478 352 341', '', 0, ''),
(695, 9, 80, ' NA', '', 0, ''),
(696, 14, 80, 'Multiple', '', 0, ''),
(697, 11, 80, '<p>Please place the textboard to the left hand side of the driveway in front of the hedges as per the diagram.</p>\r\n', '', 0, ''),
(698, 6, 80, '1', '', 0, ''),
(699, 13, 81, '<p>Please remove signage.&nbsp;</p>\r\n', '', 0, '');

-- --------------------------------------------------------

--
-- Table structure for table `knowledge_articles`
--

CREATE TABLE `knowledge_articles` (
  `ID` int(11) NOT NULL,
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `body` mediumtext COLLATE utf8_unicode_ci NOT NULL,
  `userid` int(11) NOT NULL,
  `timestamp` int(11) NOT NULL,
  `catid` int(11) NOT NULL,
  `last_updated_timestamp` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `knowledge_categories`
--

CREATE TABLE `knowledge_categories` (
  `ID` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` mediumtext COLLATE utf8_unicode_ci NOT NULL,
  `image` varchar(1000) COLLATE utf8_unicode_ci NOT NULL,
  `parent_category` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `login_attempts`
--

CREATE TABLE `login_attempts` (
  `ID` int(11) NOT NULL,
  `IP` varchar(500) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `username` varchar(500) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `count` int(11) NOT NULL DEFAULT '0',
  `timestamp` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `login_attempts`
--

INSERT INTO `login_attempts` (`ID`, `IP`, `username`, `count`, `timestamp`) VALUES
(1, '41.229.5.126', 'eagle.free.me@gmail.com', 3, 1537261509),
(2, '41.229.5.126', 'eagle.free.me@gmail.com', 1, 1537263603),
(3, '41.229.5.126', 'eagle.free.me@gmail.com', 1, 1537270879),
(4, '41.229.5.126', 'eagle.free.me@gmail.com', 1, 1537272989),
(5, '220.101.84.98', 'murrayid2', 2, 1537273451),
(6, '180.168.40.154', 'murray2001', 1, 1537582398),
(7, '124.170.81.48', 'murray2001', 1, 1537583870),
(8, '45.56.155.133', 'murray2001id', 2, 1537613993),
(9, '45.56.155.133', 'murray2001', 1, 1537614025),
(10, '104.237.86.183', 'murray2001', 1, 1537701619),
(11, '103.201.142.140', ' murrayid2001', 2, 1538010652),
(12, '209.197.6.169', 'mobdev2018@gmail.com', 1, 1538552308),
(13, '119.160.118.55', '\" or \'\'=\"', 1, 1538566298),
(14, '119.160.118.55', '\" or \"\"=\"', 1, 1538566365),
(15, '119.160.118.55', '\'or \'\'=\'', 1, 1538566393),
(16, '119.160.118.55', '\'or \"\"=\'', 1, 1538566413),
(17, '119.160.118.55', '\" or \"\"=\"', 1, 1538566698),
(18, '119.160.118.55', '\"\" or \"\"=\"\"', 1, 1538566746),
(19, '119.160.118.55', '105 OR 1=1', 1, 1538566953),
(20, '119.160.118.55', '\"or\"\"=\"', 1, 1538567024),
(21, '203.206.84.254', 'free.tunisian.me@gmail.com', 1, 1538640762),
(22, '203.206.84.254', 'free.tunisian.me@gmail.com', 1, 1538647986),
(23, '1.129.106.103', 'free.tunisian.me@gmail.com', 1, 1538774911),
(24, '117.224.42.136', 'par.caresu@gmail.com', 1, 1538796493),
(25, '157.36.210.251', 'Administartor', 3, 1538984622),
(26, '124.170.81.48', 'ap@signcreators.com.au', 1, 1539036976),
(27, '1.132.106.118', 'ap@signcreators.com.au', 1, 1539158225),
(28, '103.6.219.0', 'subhash1120@gmail.com', 4, 1541649560),
(29, '103.6.219.0', 'ap@signcreators.com.au', 2, 1541649577);

-- --------------------------------------------------------

--
-- Table structure for table `password_reset`
--

CREATE TABLE `password_reset` (
  `ID` int(11) NOT NULL,
  `userid` int(11) NOT NULL DEFAULT '0',
  `token` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `timestamp` int(11) NOT NULL DEFAULT '0',
  `IP` varchar(500) COLLATE utf8_unicode_ci NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `payment_logs`
--

CREATE TABLE `payment_logs` (
  `ID` int(11) NOT NULL,
  `userid` int(11) NOT NULL DEFAULT '0',
  `amount` decimal(10,2) NOT NULL DEFAULT '0.00',
  `timestamp` int(11) NOT NULL DEFAULT '0',
  `email` varchar(500) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `processor` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `hash` varchar(255) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `payment_plans`
--

CREATE TABLE `payment_plans` (
  `ID` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `hexcolor` varchar(6) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `fontcolor` varchar(6) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `cost` decimal(10,2) NOT NULL DEFAULT '0.00',
  `days` int(11) NOT NULL DEFAULT '0',
  `sales` int(11) NOT NULL DEFAULT '0',
  `description` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `icon` varchar(255) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `payment_plans`
--

INSERT INTO `payment_plans` (`ID`, `name`, `hexcolor`, `fontcolor`, `cost`, `days`, `sales`, `description`, `icon`) VALUES
(2, 'BASIC', '65E0EB', 'FFFFFF', '3.00', 30, 11, 'This is the basic plan which gives you a introduction to our Premium Plans', 'glyphicon glyphicon-heart-empty'),
(3, 'Professional', '55CD7B', 'FFFFFF', '7.99', 90, 3, 'Get all the benefits of basic at a cheaper price and gain content for longer.', 'glyphicon glyphicon-piggy-bank'),
(4, 'LIFETIME', 'EE5782', 'FFFFFF', '300.00', 0, 2, 'Become a premium member for life and have access to all our premium content.', 'glyphicon glyphicon-gift');

-- --------------------------------------------------------

--
-- Table structure for table `reset_log`
--

CREATE TABLE `reset_log` (
  `ID` int(11) NOT NULL,
  `IP` varchar(500) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `timestamp` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `site_layouts`
--

CREATE TABLE `site_layouts` (
  `ID` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `layout_path` varchar(500) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `site_layouts`
--

INSERT INTO `site_layouts` (`ID`, `name`, `layout_path`) VALUES
(1, 'Basic', 'layout/themes/layout.php'),
(2, 'Titan', 'layout/themes/titan_layout.php'),
(3, 'Dark Fire', 'layout/themes/dark_fire_layout.php'),
(4, 'Light Blue', 'layout/themes/light_blue_layout.php');

-- --------------------------------------------------------

--
-- Table structure for table `site_settings`
--

CREATE TABLE `site_settings` (
  `ID` int(11) NOT NULL,
  `site_name` varchar(500) COLLATE utf8_unicode_ci NOT NULL,
  `site_desc` varchar(500) COLLATE utf8_unicode_ci NOT NULL,
  `upload_path` varchar(500) COLLATE utf8_unicode_ci NOT NULL,
  `upload_path_relative` varchar(500) COLLATE utf8_unicode_ci NOT NULL,
  `site_email` varchar(500) COLLATE utf8_unicode_ci NOT NULL,
  `site_logo` varchar(1000) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'logo.png',
  `register` int(11) NOT NULL,
  `disable_captcha` int(11) NOT NULL,
  `date_format` varchar(25) COLLATE utf8_unicode_ci NOT NULL,
  `avatar_upload` int(11) NOT NULL DEFAULT '1',
  `file_types` varchar(500) COLLATE utf8_unicode_ci NOT NULL,
  `twitter_consumer_key` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `twitter_consumer_secret` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `disable_social_login` int(11) NOT NULL,
  `facebook_app_id` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `facebook_app_secret` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `google_client_id` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `google_client_secret` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `file_size` int(11) NOT NULL,
  `paypal_email` varchar(1000) COLLATE utf8_unicode_ci NOT NULL,
  `paypal_currency` varchar(100) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'USD',
  `payment_enabled` int(11) NOT NULL,
  `payment_symbol` varchar(5) COLLATE utf8_unicode_ci NOT NULL DEFAULT '$',
  `global_premium` int(11) NOT NULL,
  `install` int(11) NOT NULL DEFAULT '1',
  `login_protect` int(11) NOT NULL,
  `activate_account` int(11) NOT NULL,
  `default_user_role` int(11) NOT NULL,
  `secure_login` int(11) NOT NULL,
  `stripe_secret_key` varchar(1000) COLLATE utf8_unicode_ci NOT NULL,
  `stripe_publish_key` varchar(1000) COLLATE utf8_unicode_ci NOT NULL,
  `enable_job_uploads` int(11) NOT NULL,
  `enable_job_guests` int(11) NOT NULL,
  `enable_job_edit` int(11) NOT NULL,
  `require_login` int(11) NOT NULL,
  `protocol` int(11) NOT NULL,
  `protocol_path` varchar(1000) COLLATE utf8_unicode_ci NOT NULL,
  `protocol_email` varchar(500) COLLATE utf8_unicode_ci NOT NULL,
  `protocol_password` varchar(500) COLLATE utf8_unicode_ci NOT NULL,
  `job_title` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `protocol_ssl` int(11) NOT NULL,
  `job_rating` int(11) NOT NULL,
  `notes` text COLLATE utf8_unicode_ci NOT NULL,
  `google_recaptcha` int(11) NOT NULL,
  `google_recaptcha_secret` varchar(500) COLLATE utf8_unicode_ci NOT NULL,
  `google_recaptcha_key` varchar(500) COLLATE utf8_unicode_ci NOT NULL,
  `logo_option` int(11) NOT NULL,
  `avatar_height` int(11) NOT NULL,
  `avatar_width` int(11) NOT NULL,
  `default_category` int(11) NOT NULL,
  `checkout2_accountno` int(11) NOT NULL,
  `checkout2_secret` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `layout` varchar(500) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'layout/themes/titan_layout.php',
  `imap_job_string` varchar(500) COLLATE utf8_unicode_ci DEFAULT '## Job ID: ',
  `imap_reply_string` varchar(500) COLLATE utf8_unicode_ci NOT NULL DEFAULT '## - REPLY ABOVE THIS LINE - ##',
  `captcha_job` int(11) NOT NULL,
  `envato_personal_token` varchar(500) COLLATE utf8_unicode_ci NOT NULL,
  `cache_time` int(11) NOT NULL DEFAULT '3600'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `site_settings`
--

INSERT INTO `site_settings` (`ID`, `site_name`, `site_desc`, `upload_path`, `upload_path_relative`, `site_email`, `site_logo`, `register`, `disable_captcha`, `date_format`, `avatar_upload`, `file_types`, `twitter_consumer_key`, `twitter_consumer_secret`, `disable_social_login`, `facebook_app_id`, `facebook_app_secret`, `google_client_id`, `google_client_secret`, `file_size`, `paypal_email`, `paypal_currency`, `payment_enabled`, `payment_symbol`, `global_premium`, `install`, `login_protect`, `activate_account`, `default_user_role`, `secure_login`, `stripe_secret_key`, `stripe_publish_key`, `enable_job_uploads`, `enable_job_guests`, `enable_job_edit`, `require_login`, `protocol`, `protocol_path`, `protocol_email`, `protocol_password`, `job_title`, `protocol_ssl`, `job_rating`, `notes`, `google_recaptcha`, `google_recaptcha_secret`, `google_recaptcha_key`, `logo_option`, `avatar_height`, `avatar_width`, `default_category`, `checkout2_accountno`, `checkout2_secret`, `layout`, `imap_job_string`, `imap_reply_string`, `captcha_job`, `envato_personal_token`, `cache_time`) VALUES
(1, 'Sign Creators Real Estate Portal', 'Sign Creators Real Estate Portal', '/home/mt40isswwava/public_html/uploads', 'uploads', 'info@signcreators.com.au', '06deead3b7cd8a88991722388031e2b1.png', 0, 1, 'd/m/Y h:i', 1, 'gif|png|jpg|jpeg|pdf', '', '', 1, '', '', '', '', 1028, '', 'USD', 0, '$', 0, 0, 1, 0, 10, 0, '', '', 1, 1, 0, 1, 1, 'imap.gmail.com:993', '', '', 'Support Job', 1, 1, '', 0, '', '', 1, 100, 100, 1, 0, '', 'layout/themes/titan_layout.php', '## Job ID:', '## - REPLY ABOVE THIS LINE - ##', 0, '', 3600);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `ID` int(11) NOT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `password` varchar(100) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `token` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `IP` varchar(500) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `username` varchar(25) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `first_name` varchar(25) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `last_name` varchar(25) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `avatar` varchar(1000) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'default.png',
  `joined` int(11) NOT NULL DEFAULT '0',
  `joined_date` varchar(10) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `online_timestamp` int(11) NOT NULL DEFAULT '0',
  `oauth_provider` varchar(40) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `oauth_id` varchar(1000) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `oauth_token` varchar(1500) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `oauth_secret` varchar(500) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `email_notification` int(11) NOT NULL DEFAULT '1',
  `aboutme` varchar(1000) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `points` decimal(10,2) NOT NULL DEFAULT '0.00',
  `premium_time` int(11) NOT NULL DEFAULT '0',
  `user_role` int(11) NOT NULL DEFAULT '0',
  `premium_planid` int(11) NOT NULL DEFAULT '0',
  `active` int(11) NOT NULL DEFAULT '1',
  `activate_code` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `noti_count` int(11) NOT NULL,
  `custom_view` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`ID`, `email`, `password`, `token`, `IP`, `username`, `first_name`, `last_name`, `avatar`, `joined`, `joined_date`, `online_timestamp`, `oauth_provider`, `oauth_id`, `oauth_token`, `oauth_secret`, `email_notification`, `aboutme`, `points`, `premium_time`, `user_role`, `premium_planid`, `active`, `activate_code`, `noti_count`, `custom_view`) VALUES
(1, 'ap@signcreators.com.au', '$2a$12$rQuox4DGQMaPmLPQGhFIve7zNXeMhadYRBSTZ6s3sI.gE9RUa97Fi', 'ea62063b6673fbf24e9ff293508c9803', '::1', 'Administrator', 'Admin', 'User', 'default.png', 1537116931, '9-2018', 1541663346, '', '', '', '', 0, '', '0.00', 0, 1, 0, 1, '', 0, 0),
(2, 'eagle.free.me@gmail.com', '$2a$12$pvPXyGzIK.gngMd/QaN7U.sCwiBrNsvOzIqZqC4.P2fNOb5AvIH4a', 'f08713fab5bdc59a2b2a1924ea1f0c9b', '::1', 'lou_tuni', 'Lotfi', 'Ben Taleb', 'default.png', 1537126184, '9-2018', 1537273354, '', '', '', '', 1, '', '0.00', 0, 10, 0, 1, '', 0, 0),
(3, 'murrayid2001@gmail.com', '$2a$12$BQJIhk2eXvfNHT3q5clcA.x/VMCzwYKvyawfHBxJ2OfgUOYyAEVlG', 'a3e17a025fc07e543d6dcb47bba6482f', '103.239.252.22', 'murrayid2001', 'Omar', 'Faruk', 'default.png', 1537143281, '9-2018', 1538437621, '', '', '', '', 1, '', '0.00', 0, 10, 0, 1, '', 0, 0),
(4, 'bowlesdeidre@gmail.com', '$2a$12$6UNY3UUQepcW4vjY9UGlQuY1zBMMtnviV4cNxMwyhKgyylhNrPNJy', '84ab938bb82ef908e903a7ebc8bef70c', '124.170.81.48', 'dbowles', 'Deidre', 'Bowles', 'default.png', 1537867957, '9-2018', 1539054532, '', '', '', '', 1, '', '0.00', 0, 10, 0, 1, '', 0, 0),
(5, 'marketing@rhcommercial.com', '$2a$12$SR55eeeYcG/s2OurU/Rw9OBdiDyDudf2J3CBfIhr3bRe0iRpNRh1.', '61b271b608328fdd8515bef941a3124a', '124.170.81.48', 'Rhcommercial', 'Raine Horne', 'Commercial', 'default.png', 1538004345, '9-2018', 1541547461, '', '', '', '', 0, '', '0.00', 0, 10, 0, 1, '', 41, 0),
(6, 'andrew@signcreators.com.au', '$2a$12$7zvtWd3Qnvxu6DRtdwhX1eeLgOVOb7G7gsLcZEsCemdY7bNqmbaO.', '', '124.170.81.48', 'SignCreators', 'Sign', 'Creators', 'default.png', 1538011996, '9-2018', 0, '', '', '', '', 1, '', '0.00', 0, 10, 0, 1, '', 0, 0),
(7, 'ping.waqas@gmail.com', '$2a$12$BE7ie5dzOGeR6v6RVmBpqeAtzdqE71cbEyJJFdcesa3kN1ArXHjS6', '4e253fa0d73f3b75235c6c7ce964a317', '116.58.35.116', 'waqas93', 'Waqas', 'Ali', 'default.png', 1538549027, '10-2018', 1538549038, '', '', '', '', 1, '', '0.00', 0, 10, 0, 1, '', 0, 0),
(8, 'tarikgenrosys@gmail.com', '$2a$12$ZAZbbuo5i8ToaRpW0jKooOFBt3uMuk34nkEkqyiWPCDOO9rDHChG6', 'dc74e5382c1650df30a28511a60a03d9', '122.160.97.131', 'Tarik', 'Tarik', 'Khanna', 'default.png', 1538549269, '10-2018', 1538549300, '', '', '', '', 1, '', '0.00', 0, 10, 0, 1, '', 0, 0),
(9, 'subhash1120@gmail.com', '$2a$12$UHWOh6CmN.8vF9eBYoQfLeHbHCedN1KTgsUs0O1BmPFq72Iqd5U.i', 'f2b2661ca7389b6f95f393c0bf57f887', '122.173.195.51', 'admin', 'Subhash', 'Chand', 'default.png', 1538549274, '10-2018', 1538549286, '', '', '', '', 1, '', '0.00', 0, 10, 0, 1, '', 0, 0),
(10, 'bunnysusheel@gmail.com', '$2a$12$nH2o66BYOnDmM4nNxXda/.kVUqOhMQYDuEed7DEdNzUzCp1k16zC.', 'b5cd8e134b18dbfe74d5e56998ae83b5', '42.104.97.18', 'SusheelAdirala', 'susheel', 'adirala', 'default.png', 1538549329, '10-2018', 1538549340, '', '', '', '', 1, '', '0.00', 0, 10, 0, 1, '', 0, 0),
(11, 'davidmullerx825@gmail.com', '$2a$12$2BXbH4jX7vYblc.mwXDb6uphztDzQH7ysG.CofWW8HWhZ3/Xr7qo2', '353d791170ed68125858d3050d414116', '167.88.108.136', 'davidmullerx', 'David', 'Muller', 'default.png', 1538549423, '10-2018', 1538549449, '', '', '', '', 1, '', '0.00', 0, 10, 0, 1, '', 0, 0),
(12, 'naveengautam62@gmail.com', '$2a$12$bd038sh20yVzM01E1aAnyemcBcO4k0Yrw0fol3Vlj4ZhQ8QUmphfa', '6e5681fbb4f6dcc761d8182c36babaf2', '116.193.163.50', 'ngautam90', 'Naveen', 'Gautam', 'default.png', 1538549503, '10-2018', 1538549508, '', '', '', '', 1, '', '0.00', 0, 10, 0, 1, '', 0, 0),
(13, 'skshahnawaz2909@gmail.com', '$2a$12$XYYgH4k/FykJFEPyU/jkruHmVKtEFyHVAuiba4aItD2DLfefc9Sr6', 'ce5c8f7e935fade71508766a98343333', '116.193.133.231', 'sks', 'sk', 'sh', 'default.png', 1538549573, '10-2018', 1538553260, '', '', '', '', 1, '', '0.00', 0, 10, 0, 1, '', 0, 0),
(14, 'aliasgar.vanak@gmail.com', '$2a$12$EOqD6bQeA7aG8HBOyyV0FO7y9KVphOOoaICHOR9tRxh6b5K0y8cS.', '96ff9a5ce645e529f0132e32cafecbd9', '43.230.46.198', 'aliasgarvanak', 'Aliasgar', 'Vanak', 'default.png', 1538549648, '10-2018', 1538549660, '', '', '', '', 1, '', '0.00', 0, 10, 0, 1, '', 0, 0),
(15, 'breakout.soul@gmail.com', '$2a$12$ctZDT56t//zDfTgMDHGMGetIsftWmRIrcbpUTYWal.DtEt0ShSpCa', 'e9579bdd7590a6efd766bed449d9a9db', '119.30.45.82', 'Shimul22', 'Ihteshamul', 'Alam', 'default.png', 1538549866, '10-2018', 1538549872, '', '', '', '', 1, '', '0.00', 0, 10, 0, 1, '', 0, 0),
(16, 'yogesh.more@itoolsolutions.com', '$2a$12$yhux398UU4HFEsZfjovmd.WARQFO1A5Zb9wHzhe11VlR8iHC/1NOq', '0900dd3c5e5de5e37071f69e59b2ea30', '219.91.239.202', 'yogesh_more', 'yogesh', 'more', 'default.png', 1538549977, '10-2018', 1538549985, '', '', '', '', 1, '', '0.00', 0, 10, 0, 1, '', 0, 0),
(17, 'par.caresu@gmail.com', '$2a$12$0rWvNGnWAS6olNmEABr7IufTNIrxQTqa/U6APBTtc3g/3fR.MGS.u', 'cad222fe310e4b84a61acfe2845fef29', '122.173.103.85', 'pardeep2370', 'Pardeep', 'Kumar', 'default.png', 1538550222, '10-2018', 1538979607, '', '', '', '', 1, '', '0.00', 0, 10, 0, 1, '', 0, 0),
(18, 'popular.developer@gmail.com', '$2a$12$XRynxOonLsoPepslV8xnK.LRUu.qB.fPBSEtp2cdYmKo3NtZGJ8X6', '0af1a0af0fd0a21d71edc5aead22cc81', '157.32.147.244', 'populardev', 'Popular', 'Developer', 'default.png', 1538550225, '10-2018', 1538551583, '', '', '', '', 1, '', '0.00', 0, 10, 0, 1, '', 0, 0),
(19, 'nadeem@gmail.com', '$2a$12$qIttNSm3l3HKVAmP9M5YJeuczAVpYwcMGWFE0V9Eq9xGYhbiEVIvu', 'abe5816c97c0bdacce8eda32b35fae2e', '39.55.140.108', 'nadeem', 'nadeem', 'ijaz', 'default.png', 1538550621, '10-2018', 1538550957, '', '', '', '', 1, '', '0.00', 0, 10, 0, 1, '', 0, 0),
(20, 'thanisheun@gmail.com', '$2a$12$onynMCJXnnWYDGwXdgJtkuJ0UN6.cOFVrJM/OfOaRZjoUsXlh7RGq', 'a45ca94ada8609f5dd05b4604791ccab', '197.211.61.75', 'tinswap', 'thani', 'sheun', 'default.png', 1538551267, '10-2018', 1538551277, '', '', '', '', 1, '', '0.00', 0, 10, 0, 1, '', 0, 0),
(21, 'mohan.wijesena@msn.com', '$2a$12$bqX0746X9vV3ni6x3.CojupZCXb53E8uM4poo9.DG8HI7hKllaF3m', '6ef2ced7d93ca5f4e5111099fdcd4186', '175.157.52.40', 'mohanw', 'Mohan', 'W', 'default.png', 1538554646, '10-2018', 1538554674, '', '', '', '', 1, '', '0.00', 0, 10, 0, 1, '', 0, 0),
(22, 'albertcsefe@gmail.com', '$2a$12$MEK9vOY160/PmSG7WKbzUudMlZ2OlK1yW7wV4s0fVlgxkrOpvYw82', '4b028fcbb9eea62d9f13710eb8dc0be4', '89.165.142.126', 'albertf', 'aa', 'AFF', 'default.png', 1538557104, '10-2018', 1538557110, '', '', '', '', 1, '', '0.00', 0, 10, 0, 1, '', 0, 0),
(23, 'gogo@gmail.com', '$2a$12$PVQmG4gkpVSRazuuvBTe.unMzctwx7aec65pmXI5fGN5tATwdtC16', 'd97a9a6b7071181e84d1357a1e1d9cfa', '62.4.55.212', 'Gogo', 'Dzon', 'Doznis', 'default.png', 1538557658, '10-2018', 1538557667, '', '', '', '', 1, '', '0.00', 0, 10, 0, 1, '', 0, 0),
(24, 'sarki805@gmail.com', '$2a$12$53PamA.mQwB2uRaZiLeSZ.x3Ho0GRbkVcUU8LDtx9wmIn.9k0GNMq', '0ef749baef832fdb0e128a11a129c6b4', '119.160.118.55', 'Ayan', 'Ayan', 'Ali', 'default.png', 1538566550, '10-2018', 1538566568, '', '', '', '', 1, '', '0.00', 0, 10, 0, 1, '', 0, 0),
(25, 'andrey.shaban@yandex.ru', '$2a$12$2/JTveLIvzVBnj9arnAH4u.8SOzG5jLVzbyTmu7LzUTMeeWsc4Qna', '23c90bcffdb19f6aa8749d2cfeb5a569', '93.85.14.200', 'andrew312', 'Andrew', 'Shaban', 'default.png', 1538567162, '10-2018', 1538567632, '', '', '', '', 1, '', '0.00', 0, 10, 0, 1, '', 0, 0),
(26, 'jason@ogrelogic.com', '$2a$12$lKnxrwUvdTDqdVxTQQDcaennCfPElTkLqONq9bEQnlCLgfTby/G3C', 'd5fbbf2137e2a6f42bafd1f2cd821331', '14.102.127.90', 'jason199669', 'Jason', 'Cooper', 'default.png', 1538598919, '10-2018', 1538598927, '', '', '', '', 1, '', '0.00', 0, 10, 0, 1, '', 0, 0),
(27, 'kapilgulati19@gmail.com', '$2a$12$ymzpK9uth6um5hqGCkAGJ.erqoXhf0MRiZqm/0lHyS5cFseqNpXA2', '', '117.224.103.228', 'kapilgulati19', 'Kapil', 'Gulati', 'default.png', 1538826918, '10-2018', 0, '', '', '', '', 1, '', '0.00', 0, 10, 0, 1, '', 0, 0),
(28, 'test@gmail.com', '$2a$12$A3KVS5QDKOrXsV4PYXeGkusOj5EdVzKpO8QCpgMRWnArG6kS6Z3yu', 'b17d11ad811f12e76eb2e5bfbb5a7f65', '124.170.81.48', 'janderson', 'Jarrod', 'Anderson', 'default.png', 1539148574, '10-2018', 1541128456, '', '', '', '', 1, '', '0.00', 0, 10, 0, 1, '', 0, 0),
(29, '1@1.com', '$2a$12$mEDX4QWNOhp/EGkKrfnvCOtsRfpKtqw.LXe.rseShmWrP.PD3coIq', '1312410521fc22e4f102e4a9f26fdaca', '103.6.219.0', 'bbb', 'b', 'bb', 'default.png', 1541649402, '11-2018', 1541649411, '', '', '', '', 1, '', '0.00', 0, 10, 0, 1, '', 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `user_custom_fields`
--

CREATE TABLE `user_custom_fields` (
  `ID` int(11) NOT NULL,
  `userid` int(11) NOT NULL,
  `fieldid` int(11) NOT NULL,
  `value` text COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `user_events`
--

CREATE TABLE `user_events` (
  `ID` int(11) NOT NULL,
  `IP` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `event` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `timestamp` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `user_groups`
--

CREATE TABLE `user_groups` (
  `ID` int(11) NOT NULL,
  `name` varchar(40) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `default` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `user_groups`
--

INSERT INTO `user_groups` (`ID`, `name`, `default`) VALUES
(1, 'Default Group', 1);

-- --------------------------------------------------------

--
-- Table structure for table `user_group_users`
--

CREATE TABLE `user_group_users` (
  `ID` int(11) NOT NULL,
  `groupid` int(11) NOT NULL DEFAULT '0',
  `userid` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `user_group_users`
--

INSERT INTO `user_group_users` (`ID`, `groupid`, `userid`) VALUES
(1, 1, 2),
(2, 1, 3),
(3, 1, 4),
(4, 1, 5),
(5, 1, 6),
(6, 1, 7),
(7, 1, 8),
(8, 1, 9),
(9, 1, 10),
(10, 1, 11),
(11, 1, 12),
(12, 1, 13),
(13, 1, 14),
(14, 1, 15),
(15, 1, 16),
(16, 1, 17),
(17, 1, 18),
(18, 1, 19),
(19, 1, 20),
(20, 1, 21),
(21, 1, 22),
(22, 1, 23),
(23, 1, 24),
(24, 1, 25),
(25, 1, 26),
(26, 1, 27),
(27, 1, 28),
(28, 1, 29);

-- --------------------------------------------------------

--
-- Table structure for table `user_notifications`
--

CREATE TABLE `user_notifications` (
  `ID` int(11) NOT NULL,
  `userid` int(11) NOT NULL,
  `url` varchar(1000) COLLATE utf8_unicode_ci NOT NULL,
  `timestamp` int(11) NOT NULL,
  `status` int(11) NOT NULL,
  `message` varchar(1000) COLLATE utf8_unicode_ci NOT NULL,
  `fromid` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `user_notifications`
--

INSERT INTO `user_notifications` (`ID`, `userid`, `url`, `timestamp`, `status`, `message`, `fromid`) VALUES
(1, 3, 'client/view_job/12', 1537275068, 1, 'has replied to your Job and awaits your response.', 1),
(2, 5, 'client/view_job/34', 1538011808, 0, 'has replied to your Job and awaits your response.', 1),
(3, 5, 'client/view_job/44', 1538527903, 0, 'has replied to your Job and awaits your response.', 1),
(4, 5, 'client/view_job/42', 1538528014, 0, 'has replied to your Job and awaits your response.', 1),
(5, 5, 'client/view_job/43', 1538528100, 0, 'has replied to your Job and awaits your response.', 1),
(6, 5, 'client/view_job/45', 1538537559, 0, 'has replied to your Job and awaits your response.', 1),
(7, 5, 'client/view_job/46', 1538537846, 0, 'has replied to your Job and awaits your response.', 1),
(8, 5, 'client/view_job/41', 1538623298, 0, 'has replied to your Job and awaits your response.', 1),
(9, 5, 'client/view_job/40', 1538623346, 0, 'has replied to your Job and awaits your response.', 1),
(10, 5, 'client/view_job/44', 1538962456, 0, 'has replied to your Job and awaits your response.', 1),
(11, 5, 'client/view_job/40', 1538967194, 0, 'has replied to your Job and awaits your response.', 1),
(12, 5, 'client/view_job/40', 1538967453, 0, 'has replied to your Job and awaits your response.', 1),
(13, 5, 'client/view_job/40', 1538968084, 0, 'has replied to your Job and awaits your response.', 1),
(14, 5, 'client/view_job/40', 1538969857, 0, 'has replied to your Job and awaits your response.', 1),
(15, 5, 'client/view_job/40', 1538970038, 1, 'has replied to your Job and awaits your response.', 1),
(16, 5, 'client/view_job/49', 1539048351, 0, 'has replied to your Job and awaits your response.', 1),
(17, 5, 'client/view_job/54', 1539063363, 0, 'has replied to your Job and awaits your response.', 1),
(18, 5, 'client/view_job/54', 1539150328, 0, 'has replied to your Job and awaits your response.', 1),
(19, 5, 'client/view_job/55', 1539652145, 0, 'has replied to your Job and awaits your response.', 1),
(20, 5, 'client/view_job/59', 1539667446, 0, 'has replied to your Job and awaits your response.', 1),
(21, 5, 'client/view_job/62', 1539765886, 0, 'has replied to your Job and awaits your response.', 1),
(22, 5, 'client/view_job/61', 1539765952, 0, 'has replied to your Job and awaits your response.', 1),
(23, 5, 'client/view_job/60', 1539766003, 0, 'has replied to your Job and awaits your response.', 1),
(24, 5, 'client/view_job/58', 1539825253, 0, 'has replied to your Job and awaits your response.', 1),
(25, 5, 'client/view_job/64', 1539848493, 0, 'has replied to your Job and awaits your response.', 1),
(26, 5, 'client/view_job/63', 1539910524, 0, 'has replied to your Job and awaits your response.', 1),
(27, 5, 'client/view_job/66', 1539930417, 0, 'has replied to your Job and awaits your response.', 1),
(28, 5, 'client/view_job/65', 1539931989, 0, 'has replied to your Job and awaits your response.', 1),
(29, 5, 'client/view_job/69', 1540166202, 0, 'has replied to your Job and awaits your response.', 1),
(30, 5, 'client/view_job/68', 1540166351, 0, 'has replied to your Job and awaits your response.', 1),
(31, 5, 'client/view_job/73', 1540352109, 0, 'has replied to your Job and awaits your response.', 1),
(32, 5, 'client/view_job/76', 1540352163, 0, 'has replied to your Job and awaits your response.', 1),
(33, 5, 'client/view_job/70', 1540416045, 0, 'has replied to your Job and awaits your response.', 1),
(34, 5, 'client/view_job/77', 1540515338, 0, 'has replied to your Job and awaits your response.', 1),
(35, 5, 'client/view_job/67', 1540689884, 0, 'has replied to your Job and awaits your response.', 1),
(36, 5, 'client/view_job/74', 1540695550, 0, 'has replied to your Job and awaits your response.', 1),
(37, 5, 'client/view_job/79', 1540850858, 0, 'has replied to your Job and awaits your response.', 1),
(38, 5, 'client/view_job/78', 1540850907, 0, 'has replied to your Job and awaits your response.', 1),
(39, 5, 'client/view_job/75', 1541041273, 0, 'has replied to your Job and awaits your response.', 1),
(40, 5, 'client/view_job/72', 1541041307, 0, 'has replied to your Job and awaits your response.', 1),
(41, 5, 'client/view_job/80', 1541389471, 0, 'has replied to your Job and awaits your response.', 1),
(42, 5, 'client/view_job/81', 1541559622, 0, 'has replied to your Job and awaits your response.', 1),
(43, 5, 'client/view_job/66', 1541559682, 0, 'has replied to your Job and awaits your response.', 1);

-- --------------------------------------------------------

--
-- Table structure for table `user_roles`
--

CREATE TABLE `user_roles` (
  `ID` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `admin` int(11) NOT NULL DEFAULT '0',
  `admin_settings` int(11) NOT NULL DEFAULT '0',
  `admin_members` int(11) NOT NULL DEFAULT '0',
  `admin_payment` int(11) NOT NULL DEFAULT '0',
  `admin_announcements` int(11) NOT NULL,
  `banned` int(11) NOT NULL,
  `job_manager` int(11) NOT NULL,
  `job_worker` int(11) NOT NULL,
  `knowledge_manager` int(11) NOT NULL,
  `client` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `user_roles`
--

INSERT INTO `user_roles` (`ID`, `name`, `admin`, `admin_settings`, `admin_members`, `admin_payment`, `admin_announcements`, `banned`, `job_manager`, `job_worker`, `knowledge_manager`, `client`) VALUES
(1, 'Admin', 1, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(2, 'Member Manager', 0, 0, 1, 0, 0, 0, 0, 0, 0, 0),
(3, 'Admin Settings', 0, 1, 0, 0, 0, 0, 0, 0, 0, 0),
(4, 'Admin Payments', 0, 0, 0, 1, 0, 0, 0, 0, 0, 0),
(5, 'Member', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(6, 'Banned', 0, 0, 0, 0, 0, 1, 0, 0, 0, 0),
(7, 'Job Manager', 0, 0, 0, 0, 0, 0, 1, 0, 0, 0),
(8, 'Job Worker', 0, 0, 0, 0, 0, 0, 0, 1, 0, 0),
(9, 'Knowledge Manager', 0, 0, 0, 0, 0, 0, 0, 0, 1, 0),
(10, 'User', 0, 0, 0, 0, 0, 0, 0, 0, 0, 1);

-- --------------------------------------------------------

--
-- Table structure for table `user_role_permissions`
--

CREATE TABLE `user_role_permissions` (
  `ID` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(500) COLLATE utf8_unicode_ci NOT NULL,
  `classname` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `hook` varchar(255) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `user_role_permissions`
--

INSERT INTO `user_role_permissions` (`ID`, `name`, `description`, `classname`, `hook`) VALUES
(1, 'ctn_308', 'ctn_308', 'admin', 'admin'),
(2, 'ctn_309', 'ctn_309', 'admin', 'admin_settings'),
(3, 'ctn_310', 'ctn_310', 'admin', 'admin_members'),
(4, 'ctn_311', 'ctn_311', 'admin', 'admin_payment'),
(5, 'ctn_33', 'ctn_33', 'banned', 'banned'),
(6, 'ctn_397', 'ctn_398', 'job', 'job_manager'),
(7, 'ctn_399', 'ctn_400', 'job', 'job_worker'),
(8, 'ctn_401', 'ctn_402', 'knowledge', 'knowledge_manager'),
(9, 'ctn_403', 'ctn_404', 'client', 'client');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `announcements`
--
ALTER TABLE `announcements`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `canned_responses`
--
ALTER TABLE `canned_responses`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `custom_fields`
--
ALTER TABLE `custom_fields`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `custom_views`
--
ALTER TABLE `custom_views`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `email_templates`
--
ALTER TABLE `email_templates`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `home_stats`
--
ALTER TABLE `home_stats`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `ipn_log`
--
ALTER TABLE `ipn_log`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `ip_block`
--
ALTER TABLE `ip_block`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `job_categories`
--
ALTER TABLE `job_categories`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `job_category_groups`
--
ALTER TABLE `job_category_groups`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `job_custom_fields`
--
ALTER TABLE `job_custom_fields`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `job_custom_field_cats`
--
ALTER TABLE `job_custom_field_cats`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `job_files`
--
ALTER TABLE `job_files`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `job_history`
--
ALTER TABLE `job_history`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `job_replies`
--
ALTER TABLE `job_replies`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `job_user_custom_fields`
--
ALTER TABLE `job_user_custom_fields`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `knowledge_articles`
--
ALTER TABLE `knowledge_articles`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `knowledge_categories`
--
ALTER TABLE `knowledge_categories`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `login_attempts`
--
ALTER TABLE `login_attempts`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `password_reset`
--
ALTER TABLE `password_reset`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `payment_logs`
--
ALTER TABLE `payment_logs`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `payment_plans`
--
ALTER TABLE `payment_plans`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `reset_log`
--
ALTER TABLE `reset_log`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `site_layouts`
--
ALTER TABLE `site_layouts`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `site_settings`
--
ALTER TABLE `site_settings`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `user_custom_fields`
--
ALTER TABLE `user_custom_fields`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `user_events`
--
ALTER TABLE `user_events`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `user_groups`
--
ALTER TABLE `user_groups`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `user_group_users`
--
ALTER TABLE `user_group_users`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `user_notifications`
--
ALTER TABLE `user_notifications`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `user_roles`
--
ALTER TABLE `user_roles`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `user_role_permissions`
--
ALTER TABLE `user_role_permissions`
  ADD PRIMARY KEY (`ID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `announcements`
--
ALTER TABLE `announcements`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `canned_responses`
--
ALTER TABLE `canned_responses`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `custom_fields`
--
ALTER TABLE `custom_fields`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `custom_views`
--
ALTER TABLE `custom_views`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `email_templates`
--
ALTER TABLE `email_templates`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `home_stats`
--
ALTER TABLE `home_stats`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `ipn_log`
--
ALTER TABLE `ipn_log`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ip_block`
--
ALTER TABLE `ip_block`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=82;

--
-- AUTO_INCREMENT for table `job_categories`
--
ALTER TABLE `job_categories`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `job_category_groups`
--
ALTER TABLE `job_category_groups`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `job_custom_fields`
--
ALTER TABLE `job_custom_fields`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `job_custom_field_cats`
--
ALTER TABLE `job_custom_field_cats`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=44;

--
-- AUTO_INCREMENT for table `job_files`
--
ALTER TABLE `job_files`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=98;

--
-- AUTO_INCREMENT for table `job_history`
--
ALTER TABLE `job_history`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=212;

--
-- AUTO_INCREMENT for table `job_replies`
--
ALTER TABLE `job_replies`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=44;

--
-- AUTO_INCREMENT for table `job_user_custom_fields`
--
ALTER TABLE `job_user_custom_fields`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=700;

--
-- AUTO_INCREMENT for table `knowledge_articles`
--
ALTER TABLE `knowledge_articles`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `knowledge_categories`
--
ALTER TABLE `knowledge_categories`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `login_attempts`
--
ALTER TABLE `login_attempts`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT for table `password_reset`
--
ALTER TABLE `password_reset`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `payment_logs`
--
ALTER TABLE `payment_logs`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `payment_plans`
--
ALTER TABLE `payment_plans`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `reset_log`
--
ALTER TABLE `reset_log`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `site_layouts`
--
ALTER TABLE `site_layouts`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `site_settings`
--
ALTER TABLE `site_settings`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT for table `user_custom_fields`
--
ALTER TABLE `user_custom_fields`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `user_events`
--
ALTER TABLE `user_events`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `user_groups`
--
ALTER TABLE `user_groups`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `user_group_users`
--
ALTER TABLE `user_group_users`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT for table `user_notifications`
--
ALTER TABLE `user_notifications`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=44;

--
-- AUTO_INCREMENT for table `user_roles`
--
ALTER TABLE `user_roles`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `user_role_permissions`
--
ALTER TABLE `user_role_permissions`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
