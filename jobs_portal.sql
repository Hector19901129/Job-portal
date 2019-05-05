-- phpMyAdmin SQL Dump
-- version 4.2.11
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: May 05, 2019 at 08:24 PM
-- Server version: 5.6.21
-- PHP Version: 5.6.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `jobs_portal`
--

-- --------------------------------------------------------

--
-- Table structure for table `announcements`
--

CREATE TABLE IF NOT EXISTS `announcements` (
`ID` int(11) NOT NULL,
  `title` varchar(500) COLLATE utf8_unicode_ci NOT NULL,
  `body` mediumtext COLLATE utf8_unicode_ci NOT NULL,
  `status` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `artwork_status`
--

CREATE TABLE IF NOT EXISTS `artwork_status` (
`ID` int(11) NOT NULL,
  `name` varchar(30) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `artwork_status`
--

INSERT INTO `artwork_status` (`ID`, `name`) VALUES
(1, 'new'),
(2, 'approved'),
(3, 'declined');

-- --------------------------------------------------------

--
-- Table structure for table `canned_responses`
--

CREATE TABLE IF NOT EXISTS `canned_responses` (
`ID` int(11) NOT NULL,
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `body` mediumtext COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `custom_fields`
--

CREATE TABLE IF NOT EXISTS `custom_fields` (
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

CREATE TABLE IF NOT EXISTS `custom_views` (
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

CREATE TABLE IF NOT EXISTS `email_templates` (
`ID` int(11) NOT NULL,
  `title` varchar(500) COLLATE utf8_unicode_ci NOT NULL,
  `message` text COLLATE utf8_unicode_ci NOT NULL,
  `hook` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `language` varchar(255) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `email_templates`
--

INSERT INTO `email_templates` (`ID`, `title`, `message`, `hook`, `language`) VALUES
(1, 'Forgot Your Password', '<p>Dear [NAME],<br /><br />Someone (hopefully you) requested a password reset at [SITE_URL].<br /><br />To reset your password, please follow the following link: [EMAIL_LINK]<br /><br />If you did not reset your password, please kindly ignore this email.<br /><br />Yours,<br />[SITE_NAME]</p>', 'forgot_password', 'english'),
(2, 'Email Activation', '<p>Dear [NAME],<br />\r\n<br />\r\nSomeone (hopefully you) has registered an account on [SITE_NAME] using this email address.<br />\r\n<br />\r\nPlease activate the account by following this link: [EMAIL_LINK]<br />\r\n<br />\r\nIf you did not register an account, please kindly ignore this email.<br />\r\n<br />\r\nYours,<br />\r\n[SITE_NAME]</p>\r\n', 'email_activation', 'english'),
(3, 'Support Job Reply', '<p>[IMAP_TICKET_REPLY_STRING]<br />\r\n<br />\r\nDear [NAME],<br />\r\n<br />\r\nA new reply was posted on your job:<br />\r\n<br />\r\n[TICKET_BODY]<br />\r\n<br />\r\nJob was generated here: [SITE_URL]<br />\r\n<br />\r\n[IMAP_TICKET_ID] [TICKET_ID]<br />\r\n<br />\r\n[SITE_NAME]</p>\r\n', 'job_reply', 'english'),
(4, 'Support Job Creation', '<p>[IMAP_TICKET_REPLY_STRING]<br />\r\n<br />\r\nDear [NAME],<br />\r\n<br />\r\nThanks for creating a job at our site: [SITE_URL]<br />\r\n<br />\r\nYour message:<br />\r\n<br />\r\n[TICKET_BODY]<br />\r\n<br />\r\nWe&#39;ll be in touch shortly.<br />\r\n<br />\r\n[IMAP_TICKET_ID] [TICKET_ID]<br />\r\n<br />\r\nYours,<br />\r\n[SITE_NAME]</p>\r\n', 'job_creation', 'english'),
(5, 'Support Guest Job Creation', '<p>[IMAP_TICKET_REPLY_STRING]<br />\r\n<br />\r\nDear [NAME],<br />\r\n<br />\r\nThanks for creating a job at our site: [SITE_URL]<br />\r\n<br />\r\nYour message:<br />\r\n<br />\r\n[TICKET_BODY]<br />\r\n<br />\r\nTo view your job, use these Guest Login details:<br />\r\nEmail: [GUEST_EMAIL]<br />\r\nPassword: [GUEST_PASS]<br />\r\n<br />\r\nGuests Login Here: [GUEST_LOGIN]<br />\r\n<br />\r\nWe&#39;ll be in touch shortly.<br />\r\n<br />\r\n[IMAP_TICKET_ID] [TICKET_ID]<br />\r\n<br />\r\nYours,<br />\r\n[SITE_NAME]</p>\r\n', 'guest_job_creation', 'english'),
(7, 'Job Reminder', '<p>Dear [USER],<br />\r\n<br />\r\nThis is a reminder that you currently have an open job that needs your attention.<br />\r\n<br />\r\nPlease login to your job at:<br />\r\n<br />\r\n[SITE_URL]<br />\r\n<br />\r\nEmail Login: [USER]<br />\r\nJob Password: [GUEST_PASS]<br />\r\n<br />\r\nYours,<br />\r\n[SITE_NAME]</p>\r\n', 'job_reminder', 'english'),
(8, 'Artwork for', '<p>Dear [USERNAME]<br /><br />Please follow the link to see the artwork for the above address<br /><br /> [USER_PAGE_LINK]<br /><br />If you have any further questions please contact your project manager </p>[SITE_NAME]', 'new_artwork', 'english'),
(9, 'Notification to Admin', '<p>Dear<br /><br />This is confirm Email.<br /><br /></p>', 'confirm_email', 'english');

-- --------------------------------------------------------

--
-- Table structure for table `home_stats`
--

CREATE TABLE IF NOT EXISTS `home_stats` (
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `home_stats`
--

INSERT INTO `home_stats` (`ID`, `google_members`, `facebook_members`, `twitter_members`, `total_members`, `new_members`, `active_today`, `timestamp`, `total_jobs`, `total_assigned_jobs`, `jobs_today`) VALUES
(1, 0, 0, 0, 1, 1, 1, 1556518027, 155, 50, 0);

-- --------------------------------------------------------

--
-- Table structure for table `ipn_log`
--

CREATE TABLE IF NOT EXISTS `ipn_log` (
`ID` int(11) NOT NULL,
  `data` text COLLATE utf8_unicode_ci,
  `timestamp` int(11) NOT NULL DEFAULT '0',
  `IP` varchar(500) COLLATE utf8_unicode_ci NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ip_block`
--

CREATE TABLE IF NOT EXISTS `ip_block` (
`ID` int(11) NOT NULL,
  `IP` varchar(500) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `timestamp` int(11) NOT NULL DEFAULT '0',
  `reason` varchar(1000) COLLATE utf8_unicode_ci NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `jobs`
--

CREATE TABLE IF NOT EXISTS `jobs` (
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
  `close_job_date` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `visible` tinyint(1) NOT NULL DEFAULT '1',
  `printable` tinyint(1) NOT NULL DEFAULT '0',
  `is_artwork` int(11) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=211 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `jobs`
--

INSERT INTO `jobs` (`ID`, `title`, `body`, `userid`, `assignedid`, `timestamp`, `categoryid`, `status`, `priority`, `last_reply_timestamp`, `last_reply_userid`, `notes`, `message_id_hash`, `guest_email`, `guest_password`, `last_reply_string`, `rating`, `job_date`, `close_job_date`, `visible`, `printable`, `is_artwork`) VALUES
(40, '2/34 Thompson Street, Bowen Hills', '<p>This is a new job</p>\r\n', 5, 1, 1538096961, 1, 2, 2, 1538970038, 1, '', '8cd73d420ba2ab6d24c4da7b8407292d', '', 'Pf3AsHRXr9yN4', '08/10/2018 01:40', 0, '28-9-2018', '04-10-2018', 1, 0, NULL),
(41, '6 Allison Street, Bowen Hills', '<p>This is a new job</p>\r\n', 5, 1, 1538097172, 1, 2, 2, 1538623298, 1, '', '66153a45a5bd6cb92903006446887996', '', 'gpkenoak2mi7', '04/10/2018 01:21', 0, '28-9-2018', '04-10-2018', 1, 0, NULL),
(42, '749 Kingsford Smith Drive, Eagle Farm', '<p>This is a new job</p>\r\n', 5, 1, 1538438892, 1, 2, 2, 1538528014, 1, '', '62e47dc8a0efabde3d5fa007956e3f3f', '', 'KS1v9bi4ms1RoQ1', '03/10/2018 10:53', 0, '02-10-2018', '03-10-2018', 1, 0, NULL),
(43, '121 Main Beach Road, Pinkenba', '<p>This is a new job</p>\r\n', 5, 1, 1538439019, 1, 2, 2, 1538528100, 1, '', 'af13331ec199475e379d83d57470ca4c', '', 'b5qmr1OE1bzHb', '03/10/2018 10:55', 0, '02-10-2018', '03-10-2018', 1, 0, NULL),
(44, 'Unit 1&amp;4/ 482 Kingsford Smith Drive, Hamilton', '<p>This is a new job</p>\r\n', 5, 1, 1538439143, 1, 2, 2, 1538962456, 1, '', 'd15aa93c969f88d1c66d6822f9685361', '', 'YE6R4O8bp6qu2F3D', '08/10/2018 11:34', 0, '02-10-2018', '03-10-2018', 1, 0, NULL),
(45, '1/353 MacDonnell Road, Clontarf', '<p>This is a new job</p>\r\n', 5, 1, 1538453147, 1, 2, 2, 1538537559, 1, '', '5fc1e701b9fb7a1f7a6556adb7fb6bb8', '', 'YwN9G7Uj8a5QcN', '03/10/2018 01:32', 0, '02-10-2018', '03-10-2018', 1, 0, NULL),
(46, 'Shop 14 1477 Anzac Avenue, Kallangur', '<p>This is a new job</p>\r\n', 5, 1, 1538537735, 1, 2, 2, 1538537846, 1, '', '2cf5a3e41265437b6ad81b96510326b0', '', 'D5e7fK4VbpQQY2', '03/10/2018 01:37', 0, '03-10-2018', '03-10-2018', 1, 0, NULL),
(49, '18 Austin Street, Newstead', '<p>This is a new job</p>\r\n', 5, 1, 1538720353, 1, 2, 2, 1539048351, 1, '', '0d551fac974a0852839d86889de620f7', '', 'UX9Ib5gl2w9JQV1', '09/10/2018 11:25', 0, '05-10-2018', '09-10-2018', 1, 0, NULL),
(54, '67 Depot St, Banyo', '<p>This is a new job</p>\r\n', 5, 1, 1539031409, 1, 2, 2, 1539150328, 1, '', '1f99a4ec70206ec4c6d136c833e4c88b', '', 'bsfTwXX1p3tS', '10/10/2018 03:45', 0, '09-10-2018', '09-10-2018', 1, 0, NULL),
(55, '201 Wickham Terrace, Spring Hill', '<p>This is a new job</p>\r\n', 5, 1, 1539213999, 1, 2, 2, 1539652145, 1, '', '13c48a10e88a1946c83d109d209432c2', '', 'sFUaX5kn4l9jh', '16/10/2018 11:09', 0, '11-10-2018', '16-10-2018', 1, 0, NULL),
(58, '250 St Vincent Parade, Banyo', '<p>This is a new job</p>\r\n', 5, 1, 1539315013, 1, 2, 2, 1539825253, 1, '', '63e585a4e4630bca36a0ca82b28464df', '', 'l4B9h6aM2Mt4PPV', '18/10/2018 11:14', 0, '12-10-2018', '18-10-2018', 1, 0, NULL),
(59, '4 Noble Avenue, Northgate', '<p>This is a new job</p>\r\n', 5, 1, 1539562589, 1, 2, 2, 1539667446, 1, '', 'd357829274586b4f7e7a06839f08c465', '', 'hi6SWXuqqlQ', '16/10/2018 03:24', 0, '15-10-2018', '16-10-2018', 1, 0, NULL),
(60, '344 Bilsen Road, Geebung', '<p>This is a new job</p>\r\n', 5, 1, 1539578313, 1, 2, 2, 1539766003, 1, '', 'af6a18e7e16c7b243ca2ac17d67e64da', '', 'i5Ya2PGC4JQE7a2', '17/10/2018 06:46', 0, '15-10-2018', '17-10-2018', 1, 0, NULL),
(61, '6/50 Northlink Place, Virginia', '<p>This is a new job</p>\r\n', 5, 1, 1539578448, 1, 2, 2, 1539765952, 1, '', '3159d25e14df6cd4bbd476bb13963c2e', '', 'P9KTuPi1sc5vN', '17/10/2018 06:45', 0, '15-10-2018', '17-10-2018', 1, 0, NULL),
(62, '6/84 Newmarket Road, Windsor', '<p>This is a new job</p>\r\n', 5, 1, 1539653871, 1, 2, 2, 1539765886, 1, '', '76cdd261f4e9f7e095157af18e8b2f89', '', 'IdK5Oxo2Q1PKF', '17/10/2018 06:44', 0, '16-10-2018', '17-10-2018', 1, 0, NULL),
(63, '30 Blackwood Street, Mitchelton', '<p>This is a new job</p>\r\n', 5, 1, 1539732127, 1, 2, 2, 1539910524, 1, '', '31b572f182e5b40471b8728d0c0fc19b', '', 'MH8Z4z6kzPd5iM', '19/10/2018 10:55', 0, '17-10-2018', '19-10-2018', 1, 0, NULL),
(64, '200 Moggill Road, Taringa', '<p>This is a new job</p>\r\n', 5, 1, 1539734472, 1, 2, 2, 1539848493, 1, '', '62c8bfb22e1f3190fe9c0b6fa000ab69', '', 'Ja2Yy7Ioq1g7J5b', '18/10/2018 05:41', 0, '17-10-2018', '18-10-2018', 1, 0, NULL),
(65, '4/482 Stafford Road, Stafford', '<p>This is a new job</p>\r\n', 5, 1, 1539831193, 1, 2, 2, 1539931989, 1, '', 'bfcda55a0576d0a838405fb5a1e2658d', '', 'oOC5K4E3E9T9Ih7I', '19/10/2018 04:53', 0, '18-10-2018', '19-10-2018', 1, 0, NULL),
(66, '18 Boothby Street, Kedron', '<p>This is a new job</p>\r\n', 5, 1, 1539831277, 1, 2, 2, 1541559682, 1, '', '21c42e6b2c6665c286b036bf30a65c97', '', 'tX2I2spEI3atP', '07/11/2018 01:01', 0, '18-10-2018', '19-10-2018', 1, 0, NULL),
(67, '15 Lang Parade, Milton', '<p>This is a new job</p>\r\n', 5, 1, 1539831391, 1, 2, 2, 1540689884, 1, '', '4ab185fd0e83b188510e8423e234a32f', '', 'RsaI9m2WByiD', '28/10/2018 11:24', 0, '18-10-2018', '28-10-2018', 1, 0, NULL),
(68, '18/23 Ashtan Place, Banyo', '<p>This is a new job</p>\r\n', 5, 1, 1539920460, 1, 2, 2, 1540166351, 1, '', 'da05372ab487602ef01a7086b36109b0', '', 'y7Jq2JYtx6w6cU3', '22/10/2018 09:59', 0, '19-10-2018', '22-10-2018', 1, 0, NULL),
(69, '616 Rode Road, Chermside', '<p>This is a new job</p>\r\n', 5, 1, 1539920545, 1, 2, 2, 1540166202, 1, '', '3b2c4be49f9d71faf31ef29f09d9b828', '', 'JBWU7lG9DUSO', '22/10/2018 09:56', 0, '19-10-2018', '22-10-2018', 1, 0, NULL),
(70, '15 Lang Parade, Milton', '<p>This is a new job</p>\r\n', 5, 1, 1540169719, 1, 2, 2, 1540416045, 1, '', '76000d438193e1b2002ecbd7751f9b8e', '', 'zi8NsuHTS3U1s', '25/10/2018 07:20', 0, '22-10-2018', '25-10-2018', 1, 0, NULL),
(71, '38 Buchanan Road, Banyo', '<p>This is a new job</p>\r\n', 5, 0, 1540169848, 1, 2, 2, 1542929622, 1, '', '95fb8dc93a40f6e09d30ee15cd57afa4', '', 'wde3dU8J3th5fP', '23/11/2018 09:33', 0, '22-10-2018', '23-11-2018', 1, 0, NULL),
(72, '71 Wilgarning Street, Stafford', '<p>This is a new job</p>\r\n', 5, 1, 1540170019, 1, 2, 2, 1541041307, 1, '', '01869b88c30a7c1671b7d73d5b615c69', '', 'j1w8mc7fpm4zZk', '01/11/2018 01:01', 0, '22-10-2018', '01-11-2018', 1, 0, NULL),
(73, '252 Kelvin Grove Road, Kelvin Grove', '<p>This is a new job</p>\r\n', 5, 1, 1540175806, 1, 2, 2, 1540352109, 1, '', 'efc9f45ae206ab78b60308ebdf9357fd', '', 'kD2GnrUxc5Nw', '24/10/2018 01:35', 0, '22-10-2018', '24-10-2018', 1, 0, NULL),
(74, '19 Thompson Street, Bowen Hills', '<p>This is a new job</p>\r\n', 5, 1, 1540177109, 1, 2, 2, 1540695550, 1, '', '21eeed01e7e77a8dc7d83a52c87ddac9', '', 'ROd6uuG4f1uVK1', '28/10/2018 12:59', 0, '22-10-2018', '28-10-2018', 1, 0, NULL),
(75, '470 Upper Roma Street, Brisbane', '<p>This is a new job</p>\r\n', 5, 1, 1540195177, 1, 2, 2, 1541041273, 1, '', 'a176142554f08f53ea4c1bf6940b7218', '', 'vb6dfdhaJXZ', '01/11/2018 01:01', 0, '22-10-2018', '01-11-2018', 1, 0, NULL),
(76, '12 Blackwood Street, Mitchelton', '<p>This is a new job</p>\r\n', 5, 1, 1540254320, 1, 2, 2, 1540352163, 1, '', '1dd0d6dd43ac0ddd134a36f6ae68e278', '', 'AChHc1W7Ap4W5M', '24/10/2018 01:36', 0, '23-10-2018', '24-10-2018', 1, 0, NULL),
(77, '2/445 Upper Edward Street, Spring Hill', '<p>This is a new job</p>\r\n', 5, 1, 1540428792, 1, 2, 2, 1540515338, 1, '', 'df0e32da5dbd0dab9ee56e1d77a75164', '', 'SHsAQn6cDH1V', '26/10/2018 10:55', 0, '25-10-2018', '26-10-2018', 1, 0, NULL),
(78, '730 South Pine Road, Everton Park', '<p>This is a new job</p>\r\n', 5, 1, 1540519016, 1, 2, 2, 1540850907, 1, '', 'f269df7b5ba5db00c49c66f85df3d3b1', '', 'd3r7xm4XtNDu2m8', '30/10/2018 08:08', 0, '26-10-2018', '30-10-2018', 1, 0, NULL),
(79, '1 Windsor Road, Red Hill', '<p>This is a new job</p>\r\n', 5, 1, 1540519489, 1, 2, 2, 1540850858, 1, '', '3d6555c5052b154a269ad5fd09e13dc9', '', 'Jn8l2Wklsz9ZW3', '30/10/2018 08:07', 0, '26-10-2018', '30-10-2018', 1, 0, NULL),
(80, '6a/68 Racecourse Road, Hamilton', '<p>This is a new job</p>\r\n', 5, 1, 1540959702, 1, 2, 2, 1541389471, 1, '', 'ca082c9afa8477853d577d4b0ce22fce', '', 'hPWXEP8Qpfn9', '05/11/2018 01:44', 0, '31-10-2018', '05-11-2018', 1, 0, NULL),
(81, '4 Noble Avenue, Northgate', '<p>This is a new removal</p>\r\n', 5, 1, 1541473381, 2, 3, 2, 1541559622, 1, '', '51bc2db27915e94a228f88cc3ff46846', '', 'JCwlqzbj4k5u', '07/11/2018 01:00', 0, '06-11-2018', '', 1, 0, NULL),
(82, '1/292 Newmarket Road, Wilston', '<p>This is a new job</p>\r\n', 5, 1, 1541978356, 1, 2, 2, 1542057590, 1, '', '434020c3fc72ec821cc589ed42ac0dbe', '', 'i2Pa6InZjnd6S', '13/11/2018 07:19', 0, '12-11-2018', '13-11-2018', 1, 0, NULL),
(84, '151 Baroona Rd, Paddington', '<p>This is a new job</p>\r\n', 5, 1, 1542084473, 1, 2, 2, 1542158518, 1, '', 'a7670d0eca27e30a192373256d070be5', '', 'T8FB5CUr2dOyy', '14/11/2018 11:21', 0, '13-11-2018', '14-11-2018', 1, 0, NULL),
(85, 'Test', '<p>This is a new job</p>\r\n', 1, 0, 1542267529, 1, 2, 2, 1542268129, 1, '', '7d9e55daf3b3074598015478be5cef7f', '', 'e3lxZi5N5rm4xq6', '15/11/2018 05:48', 0, '15-11-2018', '15-11-2018', 1, 0, NULL),
(86, 'test', '<p>This is a new job</p>\r\n', 30, 1, 1542515430, 1, 2, 2, 1542515708, 1, '', 'f6e987267754c733618e652fa01b5638', '', 'Byr6lAcy7quA', '18/11/2018 02:35', 0, '18-11-2018', '18-11-2018', 1, 0, NULL),
(87, 'test', '<p>This is a new job</p>\r\n', 30, 1, 1542515444, 1, 2, 2, 1542559085, 1, '', 'b9c71efa4cb6aa23e4dcc7f0cfbdbf6e', '', 'X1LQZ7xNtG1M4P2', '19/11/2018 02:38', 0, '18-11-2018', '19-11-2018', 1, 0, NULL),
(88, 'test', '<p>This is a new job</p>\r\n', 1, 1, 1542538118, 1, 0, 2, 1542667661, 1, '', '9c991782cad3514d9db3e5c824848270', '', 't9WO2de8Gu2JHm8', '20/11/2018 08:47', 0, '18-11-2018', '', 1, 0, NULL),
(89, '1311/25', '<p>This is a new job</p>\r\n', 4, 1, 1542582380, 1, 0, 2, 1542582558, 1, '', '563b320ddf40e0e1fa806c910b322d81', '', 'U4x3Cc2me4lv9Y1F3', '19/11/2018 09:09', 0, '19-11-2018', '', 1, 0, NULL),
(90, 'test', '<p>This is a new job</p>\r\n', 30, 0, 1542583452, 1, 0, 2, 1542583452, 0, '', '164cd79b91ea7c0e925db80fc66dd158', '', 'F4q1GD8P7dPPl1Z', '19/11/2018 09:24', 0, '19-11-2018', '', 1, 0, NULL),
(91, 'test', '<p>This is a new job</p>\r\n', 30, 0, 1542587229, 1, 0, 2, 1542587229, 0, '', '79444d5c0c608bc3a4db8c0729463eae', '', 'xLTRWJql9hf', '19/11/2018 10:27', 0, '19-11-2018', '', 1, 0, NULL),
(92, '9/10 prosperity', '<p>This is a new job</p>\r\n', 30, 0, 1542587444, 1, 0, 2, 1542587444, 0, '', 'f81ea26b041a7f09f590d010a7e69fcc', '', 'M2N5at3pQIzCV', '19/11/2018 10:30', 0, '19-11-2018', '', 1, 0, NULL),
(93, '1311', '<p>This is a new job</p>\r\n', 4, 1, 1542603436, 1, 2, 2, 1542604073, 1, '', '7af25922d40254f018e61be09b52e4da', '', 'aE5sWdp2Bpwc', '19/11/2018 03:07', 0, '19-11-2018', '19-11-2018', 1, 0, NULL),
(94, 'test', '<p>This is a new job</p>\r\n', 29, 0, 1542611220, 1, 0, 2, 1542611220, 0, '', '2ae9f7bb2a0f59baf4d496e2fab8bdd6', '', 'FwwucTolBj', '19/11/2018 05:07', 0, '19-11-2018', '', 1, 0, NULL),
(95, 'test', '<p>This is a new job</p>\r\n', 30, 0, 1542613219, 1, 0, 2, 1542613219, 0, '', '34bff530ab40307fdee202c4d95aa732', '', 'cA2jbsrJza1Q', '19/11/2018 05:40', 0, '19-11-2018', '', 1, 0, NULL),
(96, '25', '<p>This is a new job</p>\r\n', 4, 1, 1542613399, 1, 0, 2, 1542685191, 1, '', 'ee199ac0679df1c3fc0c9f5e6cbf5f0b', '', 'T1ik4zl3gGvhf6', '20/11/2018 01:39', 0, '19-11-2018', '', 1, 0, NULL),
(97, 'testttttttttt', '<p>This is a new job</p>\r\n', 1, 1, 1542668349, 1, 0, 2, 1542668367, 1, '', 'baf45b4dab97022c03117f8777c7a8df', '', 'Rjh4U4v3C6hExb', '20/11/2018 08:59', 0, '20-11-2018', '', 1, 0, NULL),
(98, '283 Given Terrace, Paddington', '<p>This is a new job</p>\r\n', 5, 0, 1542673987, 1, 2, 2, 1542922512, 1, '', 'ee391ce252a957163db594b639f14793', '', 'D5M2ARoSl9a3Q1M', '23/11/2018 07:35', 0, '20-11-2018', '23-11-2018', 1, 0, NULL),
(99, '273 Stafford Road, Stafford', '<p>This is a new job</p>\r\n', 5, 0, 1542674245, 1, 2, 2, 1542922456, 1, '', 'b3ce9e679ede3ebe74eff64fa8f0660f', '', 'HZP9tdIooA2K', '23/11/2018 07:34', 0, '20-11-2018', '23-11-2018', 1, 0, NULL),
(100, '2/162 Petrie Terrace, Petrie Terrace', '<p>This is a new job</p>\r\n', 5, 1, 1542841996, 1, 2, 2, 1543449931, 1, '', 'c368cfab7e7cd889318d8c40a87ccdc4', '', 'n7v9am3w1M1JmDq', '29/11/2018 10:05', 0, '22-11-2018', '29-11-2018', 1, 0, NULL),
(101, '1/385 Gympie Road, Kedron', '<p>This is a new job</p>\r\n', 5, 0, 1543275590, 1, 2, 2, 1543442406, 1, '', '5553af84ee539a60a7944e70af1c1c8c', '', 'UtL1hALRZ7vX', '29/11/2018 08:00', 0, '27-11-2018', '29-11-2018', 1, 0, NULL),
(102, '276 Petrie Terrace, Petrie Terrace', '<p>This is a new job</p>\r\n', 5, 0, 1543275722, 1, 2, 2, 1543382348, 1, '', 'e807b4dcab879069f3c5d0645f85d4f1', '', 'I5gI5Gazuu6m3M', '28/11/2018 03:19', 0, '27-11-2018', '28-11-2018', 1, 0, NULL),
(103, '69/283 GIven Terrace, Paddington', '<p>This is a new task</p>\r\n', 5, 0, 1543460013, 3, 2, 2, 1543472104, 1, '', 'e4700939805c1fc9a4cf52d9a8e1ddeb', '', 'VHncyO9P6X6rr', '29/11/2018 04:15', 0, '29-11-2018', '29-11-2018', 1, 0, NULL),
(104, '470 Upper Roma Street, Brisbane', '<p>This is a new task</p>\r\n', 5, 0, 1543460062, 3, 2, 2, 1543815795, 1, '', '4378987fce5b290c9ade15c7b3e9596f', '', 'C5iuiZkKhX6U', '03/12/2018 03:43', 0, '29-11-2018', '03-12-2018', 1, 0, NULL),
(105, '38 Buchanan Road, Banyo', '<p>This is a new removal</p>\r\n', 5, 0, 1543474592, 2, 3, 2, 1543474592, 0, '', '56a518edc30ffef79cea7a125f0b17bc', '', 'x6hPGeNAR2Wy', '29/11/2018 04:56', 0, '29-11-2018', '', 1, 0, NULL),
(106, '439 Lutwyche Road, Lutwyche', '<p>This is a new job</p>\r\n', 5, 0, 1543545715, 1, 2, 2, 1543814695, 1, '', '668dc5c79eda7e601a41c3ce4974cab2', '', 'wvHP3G2W5dRqU', '03/12/2018 03:24', 0, '30-11-2018', '03-12-2018', 1, 0, NULL),
(107, '135 Sandgate Road, Albion', '<p>This is a new job</p>\r\n', 5, 0, 1543545783, 1, 2, 2, 1543818763, 1, '', '4e7a2980719acfce6387c62cde3cceac', '', 'rAhMC7B5x2zbS6', '03/12/2018 04:32', 0, '30-11-2018', '03-12-2018', 1, 0, NULL),
(108, '1499 Anzac Avenue, Kallangur', '<p>This is a new job</p>\r\n', 5, 0, 1543546186, 1, 2, 2, 1543904765, 1, '', 'a8fa603cf1e843ee4004b811556a4569', '', 'wm3NU6z7KeT6nF', '04/12/2018 04:26', 0, '30-11-2018', '04-12-2018', 1, 0, NULL),
(109, '15 Filmer Street, Clontarf', '<p>This is a new job</p>\r\n', 5, 0, 1543546264, 1, 2, 2, 1543883542, 1, '', '20353d0c3a6f779ccd7eb590e0bb9390', '', 'LU5hnbbCWCk', '04/12/2018 10:32', 0, '30-11-2018', '04-12-2018', 1, 0, NULL),
(110, '665-685 Gympie Road, Lawnton', '<p>This is a new job</p>\r\n', 5, 0, 1543546346, 1, 2, 2, 1543906414, 1, '', '96246a7ba7a5a7d7b1b30b78eb846f29', '', 'O5GFM8wJ5Fx7sj2', '04/12/2018 04:53', 0, '30-11-2018', '04-12-2018', 1, 0, NULL),
(111, '81 Kempster Street, Sandgate', '<p>This is a new job</p>\r\n', 5, 0, 1543561548, 1, 2, 2, 1543908192, 1, '', '75996d5655dccbfa4e9e96749d06cc13', '', 'cHyMFDPz4u8R7', '04/12/2018 05:23', 0, '30-11-2018', '04-12-2018', 1, 0, NULL),
(112, '50 Northlink Place, Virginia', '<p>This is a new job</p>\r\n', 5, 0, 1543561711, 1, 2, 2, 1543811669, 1, '', '9285897486c738b632086f5a51e99664', '', 'UtV2u7l4gBh1Jf', '03/12/2018 02:34', 0, '30-11-2018', '03-12-2018', 1, 0, NULL),
(113, '61 Toombul Road, Northgate', '<p>This is a new job</p>\r\n', 5, 0, 1543561781, 1, 2, 2, 1543810913, 1, '', 'd2e4e9224626b6bfd0b13d3c6068c91c', '', 'LLI9eRaj1hj3n3', '03/12/2018 02:21', 0, '30-11-2018', '03-12-2018', 1, 0, NULL),
(114, '300 Cullen Avenue, Eagle Farm', '<p>This is a new job</p>\r\n', 5, 0, 1543561962, 1, 2, 2, 1543818843, 1, '', 'e0af59d6e3cec100debbd3609c47e693', '', 'G2Jiyf2d9VJDF4', '03/12/2018 04:34', 0, '30-11-2018', '03-12-2018', 1, 0, NULL),
(115, '13-15 Storie Street, Clontarf', '<p>This is a new job</p>\r\n', 5, 0, 1543562029, 1, 2, 2, 1543889318, 1, '', '44058434c432287c4566f6427ef4503d', '', 'sg2WqW5WPgR6F', '04/12/2018 12:08', 0, '30-11-2018', '04-12-2018', 1, 0, NULL),
(116, '10 Storie Street, Clontarf', '<p>This is a new job</p>\r\n', 5, 1, 1543562110, 1, 2, 2, 1543889271, 1, '', '1d897d214a05d9f2698de0f74e4b2745', '', 'C7Zqv9cxfI2IP6', '04/12/2018 12:07', 0, '30-11-2018', '04-12-2018', 1, 0, NULL),
(117, '1/601 Nudgee Road, Hendra', '<p>This is a new job</p>\r\n', 5, 0, 1543818255, 1, 2, 2, 1543970245, 1, '', 'a8eb5be8e17fba45cccabdb7ee576115', '', 'CiPn7XqMqpQ7', '05/12/2018 10:37', 0, '03-12-2018', '05-12-2018', 1, 0, NULL),
(118, '71 Basalt Street, Geebung', '<p>This is a new job</p>\r\n', 5, 0, 1543818325, 1, 2, 2, 1543986452, 1, '', '28f51131b4aa2898843be87e37208a38', '', 'l9h3c9LL2lHi1rp', '05/12/2018 03:07', 0, '03-12-2018', '05-12-2018', 1, 0, NULL),
(119, '70 Buchanan Road, Banyo', '<p>This is a new job</p>\r\n', 5, 0, 1543818410, 1, 2, 2, 1543969084, 1, '', '0ecd7cb174a3a31c30123c626b0e4d08', '', 'ItuV3LHcjnM', '05/12/2018 10:18', 0, '03-12-2018', '05-12-2018', 1, 0, NULL),
(120, '19 Thompson Street, Bowen Hills', '<p>This is a new task</p>\r\n', 5, 0, 1543876577, 3, 2, 2, 1543958812, 1, '', '1edbf31c4bb12f30f75e3384933e6907', '', 'LC8J5U8DsBTsU', '05/12/2018 07:26', 0, '04-12-2018', '05-12-2018', 1, 0, NULL),
(121, '91 Basalt Street, Geebung', '<p>This is a new job</p>\r\n', 5, 0, 1543887193, 1, 2, 2, 1543987399, 1, '', 'eab1c9629ff89862ce3569a80fc3ea38', '', 'g8v2R4G9gTKM7Oq', '05/12/2018 03:23', 0, '04-12-2018', '05-12-2018', 1, 0, NULL),
(122, '151 Baroona Rd, Paddington', '<p>This is a new removal</p>\r\n', 5, 0, 1543898588, 2, 3, 2, 1543960151, 1, '', '9c35df951a5cb4ca73d1209d6642bfc0', '', 'vf5Q5dl6I4ltlK', '05/12/2018 07:49', 0, '04-12-2018', '', 1, 0, NULL),
(123, '1499 Anzac Avenue, Kallangur', '<p>This is a new task</p>\r\n', 5, 0, 1544050472, 3, 2, 2, 1544395874, 1, '', 'f523cee91d624fe851428633bf833a0e', '', 'XC5s8gZ3hMR8mM', '10/12/2018 08:51', 0, '06-12-2018', '10-12-2018', 1, 0, NULL),
(124, '203/32 Nathan Ave Ashgrove', '<p>This is a new job</p>\r\n', 32, 0, 1544146191, 1, 2, 2, 1544226261, 1, '', '9a127c10c638e3214f0e5b58d874aca5', '', 'tPvzP5B9V3I9LS8', '08/12/2018 09:44', 0, '07-12-2018', '08-12-2018', 1, 0, NULL),
(125, '5/36 Cambridge St CARINA HEIGHTS', '<p>This is a new job</p>\r\n', 32, 0, 1544146305, 1, 2, 2, 1544227855, 1, '', '439e5dd8881e9b06d57b1fc668a8109f', '', 'Qx7Zn2AmFK1iH9', '08/12/2018 10:10', 0, '07-12-2018', '08-12-2018', 1, 0, NULL),
(126, '24 Don Street DEEBING HEIGHTS', '<p>This is a new job</p>\r\n', 32, 0, 1544146356, 1, 2, 2, 1544230242, 1, '', '5ea773a0a03e5759c84cd787b7d32a85', '', 'O5WtKLY5W7vjI', '08/12/2018 10:50', 0, '07-12-2018', '08-12-2018', 1, 0, NULL),
(127, '8/19 Balmoral Terrace EAST BRISBANE', '<p>This is a new job</p>\r\n', 32, 0, 1544146420, 1, 2, 2, 1544226296, 1, '', '94ef80f067bffbb30663b96fe06a5d78', '', 'B4v6H2VloJr8Yc', '08/12/2018 09:44', 0, '07-12-2018', '08-12-2018', 1, 0, NULL),
(128, '9 Ashfield St EAST BRISBANE', '<p>This is a new job</p>\r\n', 32, 0, 1544146496, 1, 2, 2, 1544226326, 1, '', '349917aa88292630f5526a5fcfed9a49', '', 'TkN4k8X8Khju7a', '08/12/2018 09:45', 0, '07-12-2018', '08-12-2018', 1, 0, NULL),
(129, '1/75 Vale St MOOROOKA', '<p>This is a new job</p>\r\n', 32, 0, 1544146554, 1, 2, 2, 1544227794, 1, '', '4c2fc31624df6a07eea3d4c203536803', '', 'MIAM9zY8yZhV', '08/12/2018 10:09', 0, '07-12-2018', '08-12-2018', 1, 0, NULL),
(130, '2/9 Bartlett St MORNINGSIDE', '<p>This is a new job</p>\r\n', 32, 0, 1544146610, 1, 2, 2, 1544226822, 1, '', 'cf5853e834b38e7256e98f01192a3800', '', 'ik1i4cnGz3W1w5a4', '08/12/2018 09:53', 0, '07-12-2018', '08-12-2018', 1, 0, NULL),
(131, '7/10 Depot Street, Banyo', '<p>This is a new job</p>\r\n', 5, 0, 1544413676, 1, 2, 2, 1544472519, 1, '', '9ad2408ebe01d319475ec74542f0806f', '', 'DU8IMGE7HQ8O5v', '11/12/2018 06:08', 0, '10-12-2018', '11-12-2018', 1, 0, NULL),
(132, '10 Prosperity Place, Geebung', '<p>This is a new job</p>\r\n', 5, 0, 1544413765, 1, 2, 2, 1545194267, 1, '', '43db2389dabdbcfbd86ec08ef4960f26', '', 'zSh3EPn9NNK7J', '19/12/2018 02:37', 0, '10-12-2018', '19-12-2018', 1, 0, NULL),
(133, '260 Waterworks Road, Ashgrove', '<p>This is a new job</p>\r\n', 5, 0, 1544496159, 1, 2, 2, 1545183820, 1, '', '6b5aadd629036b6caef380a9b23c1880', '', 'ype9tnm2vg5G2i2', '19/12/2018 11:43', 0, '11-12-2018', '19-12-2018', 1, 0, NULL),
(134, '73 Delta Street, Geebung', '<p>This is a new job</p>\r\n', 5, 0, 1544594154, 1, 2, 2, 1545194297, 1, '', 'ffb7c1cd8cb5f2f9c0fafbb48825742e', '', 'uP6J9vzKaYrb', '19/12/2018 02:38', 0, '12-12-2018', '19-12-2018', 1, 0, NULL),
(135, '11/159 Watson Street CAMP HILL', '<p>This is a new job</p>\r\n', 32, 0, 1544658000, 1, 2, 2, 1545201793, 1, '', '1fdd1b664d31c2cc7a70ce1211726210', '', 'F3fK7m1Tp2Y6tO7r', '19/12/2018 04:43', 0, '13-12-2018', '19-12-2018', 1, 0, NULL),
(136, '2/25 Young Street MILTON', '<p>This is a new job</p>\r\n', 32, 0, 1544658074, 1, 2, 2, 1545199260, 1, '', '3d347934ae536c65881e6d505e248c05', '', 'H3fVGv1JH6c6qU2', '19/12/2018 04:01', 0, '13-12-2018', '19-12-2018', 1, 0, NULL),
(137, '11/10 Pashen St MORNINGSIDE', '<p>This is a new job</p>\r\n', 32, 0, 1544658133, 1, 2, 2, 1545200902, 1, '', 'f802bb33731c5814812fcab5e486cea6', '', 'nKls9Ugf3bg1A4', '19/12/2018 04:28', 0, '13-12-2018', '19-12-2018', 1, 0, NULL),
(138, '35 Kitchener Road, Kedron', '<p>This is a new job</p>\r\n', 5, 0, 1544678629, 1, 2, 2, 1545195717, 1, '', '18619a58dba6d231ba798d5aad1edcb7', '', 'YcKTO1Oh4dn1l', '19/12/2018 03:01', 0, '13-12-2018', '19-12-2018', 1, 0, NULL),
(139, '300 Cullen Avenue, Eagle Farm', '<p>This is a new task</p>\r\n', 5, 0, 1545002304, 3, 4, 2, 1545002304, 0, '', 'b672b61cfc7e9f24d387c027a52d523e', '', 'svdm8ZW5c8p6uA', '17/12/2018 09:18', 0, '17-12-2018', '', 1, 0, NULL),
(140, '276 Petrie Terrace, Petrie Terrace', '<p>This is a new task</p>\r\n', 5, 0, 1545023018, 3, 2, 2, 1545340211, 1, '', '20300bf4c820f80b70fecec2a364184b', '', 'gKdlBtrTEJ', '21/12/2018 07:10', 0, '17-12-2018', '21-12-2018', 1, 0, NULL),
(141, '160 Musgrave Road, Red Hill', '<p>This is a new job</p>\r\n', 5, 0, 1545089496, 1, 2, 2, 1545342306, 1, '', '7708aae0a511632a9c8d570882a20b53', '', 'O4yWiXeRMQZ6', '21/12/2018 07:45', 0, '18-12-2018', '21-12-2018', 1, 0, NULL),
(142, '3/321 Kelvin Grove Road, Kelvin Grove', '<p>This is a new job</p>\r\n', 5, 0, 1545089710, 1, 2, 2, 1545351392, 1, '', 'fcbf1b97a80108da52ea34f0870ce287', '', 'gv5NxI6YPKDW', '21/12/2018 10:16', 0, '18-12-2018', '21-12-2018', 1, 0, NULL),
(143, '8/6 Oxley Street, North Lakes', '<p>This is a new job</p>\r\n', 5, 1, 1545096893, 1, 2, 2, 1546806054, 1, '', '2a725d23bd7a6c16902421e0664d9400', '', 'y1ST8JbYz6Pqb5', '07/01/2019 06:20', 0, '18-12-2018', '07-1-2019', 1, 0, NULL),
(144, '9 Trout Street, Ashgrove', '<p>This is a new job</p>\r\n', 5, 1, 1545097041, 1, 2, 2, 1546806005, 1, '', '4b39f6914c3f360758b38febf11179b3', '', 'rUXG6cbWnT8T', '07/01/2019 06:20', 0, '18-12-2018', '07-1-2019', 1, 0, NULL),
(145, '9 Ashfield St EAST BRISBANE', '<p>This is a new removal</p>\r\n', 32, 0, 1545172985, 2, 3, 2, 1545347245, 1, '', 'd16dbeed6bcaf938f5e96b758290d424', '', 'QBIyLrmFR5C', '21/12/2018 09:07', 0, '19-12-2018', '', 1, 0, NULL),
(146, '203/32 Nathan Ave ASHGROVE', '<p>This is a new removal</p>\r\n', 32, 0, 1545173024, 2, 3, 2, 1545173024, 0, '', '072da27aabd8c8b0a2c1b4fa20219626', '', 'lu9i2CymuAaZ', '19/12/2018 08:43', 0, '19-12-2018', '', 1, 0, NULL),
(147, '122A Watson St CAMP HILL', '<p>This is a new job</p>\r\n', 32, 0, 1545173113, 1, 2, 2, 1545348002, 1, '', '7b51c4e61ea680b5d1f488b5725a0393', '', 'ii7FCx5n8yJht', '21/12/2018 09:20', 0, '19-12-2018', '21-12-2018', 1, 0, NULL),
(148, '15 Tourmaline Road LOGAN RESERVE', '<p>This is a new job</p>\r\n', 32, 0, 1545173199, 1, 2, 2, 1545352610, 1, '', '4e2b802ac303241672763b269677d6d3', '', 'byG7R4ek1y2k1th7', '21/12/2018 10:36', 0, '19-12-2018', '21-12-2018', 1, 0, NULL),
(149, '1/15 Raffles St MOUNT GRAVATT EAST', '<p>This is a new job</p>\r\n', 32, 0, 1545173261, 1, 2, 2, 1545349331, 1, '', '30f41366b87354b65e2cd92ffc41a0fe', '', 'fz2OI5rWO7zu7C7', '21/12/2018 09:42', 0, '19-12-2018', '21-12-2018', 1, 0, NULL),
(150, '6/5 Julius St NEW FARM', '<p>This is a new job</p>\r\n', 32, 0, 1545173393, 1, 2, 2, 1545364123, 1, '', 'bbf73148c930083532394f9504fe1a4d', '', 'B9l2U4cn8eSsTl', '21/12/2018 01:48', 0, '19-12-2018', '21-12-2018', 1, 0, NULL),
(151, '82/260 Vulture St SOUTH BRISBANE', '<p>This is a new job</p>\r\n', 32, 0, 1545173571, 1, 2, 2, 1545347205, 1, '', 'aff699626b0c12f9fe5b98d96a76642b', '', 'L5tU4fL6gwCO3D3', '21/12/2018 09:06', 0, '19-12-2018', '21-12-2018', 1, 0, NULL),
(152, '51 Kangaroo Crescent SPRINGFIELD LAKES', '<p>This is a new job</p>\r\n', 32, 0, 1545173637, 1, 2, 2, 1545173637, 0, '', '5d8a014ee73f8cdd3cacd6fe51e4ffdd', '', 's9oZCLPRZn7w', '19/12/2018 08:53', 0, '19-12-2018', '03-1-2019', 1, 0, NULL),
(153, '276 Petrie Terrace, Petrie Terrace', '<p>This is a new job</p>\r\n', 5, 0, 1545174026, 1, 2, 2, 1545340169, 1, '', '24fec24b6a70d8af6b505278de8d1116', '', 'TZ3t9Sn6kbtXp', '21/12/2018 07:09', 0, '19-12-2018', '21-12-2018', 1, 0, NULL),
(154, '242 Hawken Drive, St Lucia', '<p>This is a new job</p>\r\n', 5, 1, 1545188784, 1, 2, 2, 1546805967, 1, '', '19364217459bcf05fca480ebeedb195c', '', 'UGaxLLrl3km', '07/01/2019 06:19', 0, '19-12-2018', '07-1-2019', 1, 0, NULL),
(155, '8/19 Balmoral Terrace EAST BRISBANE', '<p>This is a new removal</p>\r\n', 32, 0, 1545196896, 2, 3, 2, 1545196896, 0, '', '39d7ed5a843ee88f0d1c18a7f10595ee', '', 'r3yC8i1N5TlsWq', '19/12/2018 03:21', 0, '19-12-2018', '', 1, 0, NULL),
(156, '3 Abington Street SPRING MOUNTAIN', '<p>This is a new job</p>\r\n', 32, 0, 1545196980, 1, 0, 2, 1545196980, 0, '', 'b22f017fbdc6f0da29a5df9bf49faecc', '', 'qjRmpEfC9ZJ', '19/12/2018 03:23', 0, '19-12-2018', '', 1, 0, NULL),
(157, '41 Frederick Street, Northgate', '<p>This is a new job</p>\r\n', 5, 1, 1545197857, 1, 2, 2, 1546805923, 1, '', '0d1e6258e5398abc72db67f67dd3467f', '', 's3kDTI5wQdH6r', '07/01/2019 06:18', 0, '19-12-2018', '07-1-2019', 1, 0, NULL),
(158, '82/260 Vulture Street SOUTH BRISBANE', '<p>This is a new removal</p>\r\n', 32, 0, 1545354722, 2, 3, 2, 1545354722, 0, '', 'e3adb3370536dd31451bbfaa0ec34736', '', 'sa8QXND6krr3g9', '21/12/2018 11:12', 0, '21-12-2018', '', 1, 0, NULL),
(159, '365 St Pauls Tce, Fortitude Valley', '<p>This is a new job</p>\r\n', 5, 1, 1546806151, 1, 2, 2, 1546806249, 1, '', '0b3b99ebc935de3a9686a6ca4f49bc2a', '', 'Ek5JUqBwF3tR', '07/01/2019 06:24', 0, '07-1-2019', '07-1-2019', 1, 0, NULL),
(160, '135 Sandgate Road, Albion', '<p>This is a new task</p>\r\n', 5, 0, 1546818214, 3, 2, 2, 1547165629, 1, '', '721d35f15cbbf137f89f091f5914f413', '', 'J2O7yGjZ8dyHG2', '11/01/2019 10:13', 0, '07-1-2019', '11-1-2019', 1, 0, NULL),
(161, '70 Telford Street, Virginia', '<p>This is a new job</p>\r\n', 5, 0, 1546905103, 1, 2, 2, 1547094149, 1, '', 'c965b2cd9edce85d6b3346598a04f4b0', '', 'Fx3SO4j1xD9o4qd', '10/01/2019 02:22', 0, '08-1-2019', '10-1-2019', 1, 0, NULL),
(162, '82/260 Vulture St South Brisbane', '<p>This is a new removal</p>\r\n', 32, 0, 1546908336, 2, 3, 2, 1546908336, 0, '', '971834e3c27d3cc9b6e80b6cb552cdc0', '', 'Mm2pAy7ulnR3C', '08/01/2019 10:45', 0, '08-1-2019', '', 1, 0, NULL),
(163, '24 Don Street Deebing Heights', '<p>This is a new removal</p>\r\n', 32, 0, 1546908382, 2, 3, 2, 1547162897, 1, '', '49ced0d6d46ecfcd3267c3095436899b', '', 'S3d3F2nV4zd5USn5', '11/01/2019 09:28', 0, '08-1-2019', '', 0, 0, NULL),
(164, '203/32 Nathan Ave Ashgrove', '<p>This is a new removal</p>\r\n', 32, 0, 1546908418, 2, 3, 2, 1546995435, 1, '', 'e94eca95e449cb6b257ae2793d9268dc', '', 'BFXD4b8AD3J4bT', '09/01/2019 10:57', 0, '08-1-2019', '', 1, 0, NULL),
(165, '3 Abington Street Spring Mountain', '<p>This is a new removal</p>\r\n', 32, 0, 1546908453, 2, 3, 2, 1546908453, 0, '', '8bd306db88186ce3b79659dca7f4e6b8', '', 'lPrtOw3Vowl', '08/01/2019 10:47', 0, '08-1-2019', '', 0, 0, NULL),
(166, '1/15 Raffles Street Mount Gravatt East', '<p>This is a new task</p>\r\n', 32, 0, 1546908587, 3, 2, 2, 1546992383, 1, '', '879d4833ec57ee54bbe50129d59f1712', '', 'zQ2B5ykS6byD4I', '09/01/2019 10:06', 0, '08-1-2019', '09-1-2019', 1, 0, NULL),
(167, '11/110 Pashen St Morningside', '<p>This is a new task</p>\r\n', 32, 0, 1546908634, 3, 2, 2, 1546992419, 1, '', '8df201a532a778f8bf9a26d92e4b1cd2', '', 'w5hr8yF5BBmd7M', '09/01/2019 10:06', 0, '08-1-2019', '09-1-2019', 1, 0, NULL),
(168, '11/159 Watson St Camp Hill', '<p>This is a new task</p>\r\n', 32, 0, 1546908659, 3, 2, 2, 1546992158, 1, '', 'b1f71c60ee546febc38003ece5432afb', '', 'bRPdj2HMHa3a9', '09/01/2019 10:02', 0, '08-1-2019', '09-1-2019', 1, 0, NULL),
(169, '9 Ashfield St East Brisbane', '<p>This is a new task</p>\r\n', 32, 0, 1546908693, 3, 0, 2, 1546908693, 0, '', 'd8107f331c51cad0e2e35c4956106aa7', '', 'ZWLdWX2N5W9F1z', '08/01/2019 10:51', 0, '08-1-2019', '', 1, 0, NULL),
(170, '8/19 Balmoral Terrace East Brisbane', '<p>This is a new task</p>\r\n', 32, 0, 1546908723, 3, 0, 2, 1546908723, 0, '', '25d9d0ddc37ae75d600e20439070d732', '', 'BP7hbrM1z5N3NN', '08/01/2019 10:52', 0, '08-1-2019', '', 1, 0, NULL),
(171, '13 Bayes Road LOGAN RESERVE', '<p>This is a new job</p>\r\n', 32, 0, 1546908861, 1, 2, 2, 1546995052, 1, '', '28506026459d3c7cd9f18077cbd0ce76', '', 'L8n2Z9Wj9s6sWB3u', '09/01/2019 10:50', 0, '08-1-2019', '09-1-2019', 1, 0, NULL),
(172, '116 Sugargum Avenue MOUNT COTTON', '<p>This is a new job</p>\r\n', 32, 0, 1546908933, 1, 2, 2, 1546998053, 1, '', 'cd12e8288ca6688f59001ed756d71513', '', 'P9pNCLWeDVh', '09/01/2019 11:40', 0, '08-1-2019', '09-1-2019', 1, 0, NULL),
(173, '3/30 Sankey Street CARINA', '<p>This is a new job</p>\r\n', 32, 0, 1546908987, 1, 2, 2, 1546991322, 1, '', '313d28200cd4dfe09fbe7d77df800106', '', 'RL5p4gmarhKX4', '09/01/2019 09:48', 0, '08-1-2019', '09-1-2019', 1, 0, NULL),
(174, '80 Nudgee Rd HAMILTON', '<p>This is a new job</p>\r\n', 32, 0, 1546909041, 1, 2, 2, 1547000740, 1, '', '4ab759c078aac07e502cd53ef97709b8', '', 'w9hcPk8L8NWZy5', '09/01/2019 12:25', 0, '08-1-2019', '09-1-2019', 1, 0, NULL),
(175, '23 Tourmaline Road LOGAN RESERVE', '<p>This is a new job</p>\r\n', 32, 0, 1546909098, 1, 2, 2, 1546995792, 1, '', '281d3dda9757ddeb6b6c6a4522fbf5e3', '', 'f2rXUnvOn6hw', '09/01/2019 11:03', 0, '08-1-2019', '09-1-2019', 1, 0, NULL),
(176, '6/6 Ovendean St YERONGA', '<p>This is a new job</p>\r\n', 32, 0, 1546909182, 1, 2, 2, 1546991364, 1, '', '0f47c26ec0261bdee28c69d304c5c859', '', 'TSh8p4azlEmD', '09/01/2019 09:49', 0, '08-1-2019', '09-1-2019', 1, 0, NULL),
(177, '51 Kangaroo Crescent SPRINGFIELD LAKES', '<p>This is a new task</p>\r\n', 32, 0, 1546909293, 3, 2, 2, 1547161591, 1, '', 'ea473eba3968c302ffa2f3c194fac28e', '', 'WH3GaR8oGkcu9', '11/01/2019 09:06', 0, '08-1-2019', '11-1-2019', 1, 0, NULL),
(178, '15 Lang Parade, Milton', '<p>This is a new removal</p>\r\n', 5, 0, 1546988625, 2, 0, 2, 1546988625, 0, '', '40cf7343034583126aa593dcd084cda0', '', 'z1gag2Iv2Hb1Ml', '09/01/2019 09:03', 0, '09-1-2019', '', 1, 0, NULL),
(179, '243 Lutwyche Road, Windsor', '<p>This is a new job</p>\r\n', 5, 0, 1547424966, 1, 1, 2, 1547424966, 0, '', '6ef49996973aaec19c3838fe0a4ef735', '', 'GMIYR5JshzG1', '14/01/2019 10:16', 0, '14-1-2019', '', 1, 0, NULL),
(180, '71 Wilgarning Street, Stafford', '<p>This is a new removal</p>\r\n', 5, 0, 1547435649, 2, 1, 2, 1547435649, 0, '', '0a44f279e56689da8b6a4e77931ad380', '', 'NodrdMrFzk6', '14/01/2019 01:14', 0, '14-1-2019', '', 1, 0, NULL),
(181, '240 Stafford Road, Stafford', '<p>This is a new job</p>\r\n', 5, 0, 1547517658, 1, 0, 2, 1547517658, 0, '', 'f7096a2ba36cbf3220161f39f358954b', '', 'szO3Dv4rQB5G8B7', '15/01/2019 12:00', 0, '15-1-2019', '', 1, 0, NULL),
(182, '13 Bayes Rd LOGAN RESERVE', 'This is a new removal', 32, 0, 1547518255, 2, 0, 2, 1547518255, 0, '', '76091328890c90fd1ee76bc58188fd4e', '', 'TduwBBM3oOC9', '15/01/2019 12:10', 0, '15-1-2019', '', 1, 0, NULL),
(183, '15 Tourmaline Road LOGAN RESERVE', 'This is a new removal', 32, 1, 1547518294, 2, 0, 2, 1547518294, 0, '', '4414a0d27123dd33b08e870c05557e14', '', 'r2ZxGQ1nxgG9t', '15/01/2019 12:11', 0, '15-1-2019', '', 1, 0, NULL),
(184, '3/30 Sankey St CARINA', 'This is a new task', 32, 0, 1547518344, 3, 0, 2, 1547518344, 0, '', '31cd64237187625f8d9d212aeea01bf4', '', 'Spxk7XaF4BBm', '15/01/2019 12:12', 0, '15-1-2019', '', 1, 0, NULL),
(185, '3/30 Sankey St CARINA', '<p>This is a new task</p>\r\n', 32, 0, 1547518432, 3, 0, 2, 1547518432, 0, '', '32c6eea10e0cd2fe0daa25114d1acb40', '', 'i5K3kc7F8I1eg6lw', '15/01/2019 12:13', 0, '15-1-2019', '', 0, 0, NULL),
(186, '122a Watson St CAMP HILL', '<p>This is a new task</p>\r\n', 32, 0, 1547518471, 3, 0, 2, 1547518471, 0, '', '8347f46fb1bb4cb2fa30411a6896e8e0', '', 'Bm6M7Gy4Ht5tns', '15/01/2019 12:14', 0, '15-1-2019', '', 0, 0, NULL),
(187, '2/9 Bartlett St MORNINGSIDE', '<p>This is a new task</p>\r\n', 32, 0, 1547518515, 3, 0, 2, 1547518515, 0, '', 'a2162293e39ab48cbd8c4528087d8f0e', '', 'ILeBa7do1adF', '15/01/2019 12:15', 0, '15-1-2019', '', 1, 0, NULL),
(188, '5/36 Cambridge St CARINA HEIGHTS', '<p>This is a new task</p>\r\n', 32, 0, 1547518551, 3, 0, 2, 1547518551, 0, '', 'd3bde4106d6e3c9a7a5a53f01335d164', '', 'phR7d7dMG6fVp', '15/01/2019 12:15', 0, '15-1-2019', '', 1, 0, NULL),
(189, '4/90 Lamington Avenue ASCOT', '<p>This is a new job</p>\r\n', 32, 0, 1547518629, 1, 0, 2, 1548006923, 1, '', 'dc50b41e9230b0f93b942c860081ae72', '', 'ozPQ4RtbHgD5', '21/01/2019 03:55', 0, '15-1-2019', '', 1, 0, NULL),
(190, '53 High Street MOUNT GRAVATT', '<p>This is a new job</p>\r\n', 32, 0, 1547518704, 1, 0, 2, 1547518704, 0, '', '6005a57396dd4c676e0050acfcca69d2', '', 'a2B3H7p3npFv9L4X', '15/01/2019 12:18', 0, '15-1-2019', '', 0, 0, NULL),
(191, 't4st1223443434', '<p>This is a new job</p>\r\n', 1, 0, 1547542283, 1, 0, 2, 1547542283, 0, '', '186cd1de0152a7bdd894bbbdfd5ae311', '', 'YcXoDKZCht', '15/01/2019 06:51', 0, '15-1-2019', '', 1, 0, NULL),
(192, 'fdsafdasfdsa', '<p>This is a new job</p>\r\n', 1, 0, 1548197269, 1, 0, 2, 1548197269, 0, '', '62a5c82d0cba98376825b40a87ba7340', '', 'rTFywpENxJ', '23/01/2019 08:47', 0, '23-1-2019', '', 1, 0, NULL),
(193, 'fdasfds', '<p>This is a new job</p>\r\n', 1, 0, 1548197422, 1, 0, 2, 1548197422, 0, '', 'c561651dd71c89553d1b8d0ea915d2a0', '', 'pih3E2DsO6gro8', '23/01/2019 08:50', 0, '23-1-2019', '', 1, 0, NULL),
(200, 'new york', '', 1, 0, 1555976149, 0, 0, 0, 1555976149, 0, '', '96fbfe0e3208abb7d27925f5e5f4b9f0', 'sandybux99@gmail.com', 'VHFLoh2xE4K4a', '23/04/2019 09:35', 0, '23-4-2019', '', 1, 0, 1),
(202, 'new york', '', 1, 0, 1556125622, 0, 0, 0, 1556125622, 0, '', '5e2f745b30a6c3e8c7c5447d5cdf33b1', 'fdafdsafdsaf', 'FUBTg8XhRSm', '25/04/2019 03:07', 0, '25-4-2019', '', 1, 0, 1),
(203, 'new york', '', 1, 0, 1556125744, 0, 0, 0, 1556125744, 0, '', 'f1c412efc6c959db16a41bacd023c227', 'fdafdsafdsaf', 'dH7X6Lwdxx5Ev', '25/04/2019 03:09', 0, '25-4-2019', '', 1, 0, 1),
(204, 'new york', '', 1, 0, 1556125890, 1, 0, 0, 1556125890, 0, '', 'b4a35b6e10a7d36b8ae0e034a702e34c', 'sandybux99@gmail.com', 'NG1UFwXCX4T2D', '25/04/2019 03:11', 0, '25-4-2019', '', 1, 0, 1),
(205, 'new york', '', 1, 0, 1556126219, 1, 0, 0, 1556126219, 0, '', '39aed939ef49d1b078983e06f41afea9', 'fdasfdsa', 'UI4a5Q9Br1TN8c6E', '25/04/2019 03:16', 0, '25-4-2019', '', 1, 0, 1),
(206, 'new york', '', 1, 0, 1556126300, 0, 0, 0, 1556126300, 0, '', '941c35d195d54416ed447f46c9eb0ceb', 'sandybux99@gmail.com', 'FOiydOsPkw', '25/04/2019 03:18', 0, '25-4-2019', '', 1, 0, 1),
(207, 'new york', '', 1, 0, 1556126448, 0, 0, 0, 1556126448, 0, '', '771ae9eff5f8309fd619846efe059661', 'sandybux99@gmail.com', 'X2zqEGLlbGZ', '25/04/2019 03:20', 0, '25-4-2019', '', 1, 0, 1),
(208, 'new york', '', 1, 0, 1556126584, 0, 0, 0, 1556126584, 0, '', '71632cbb7a778ca7953396b791b0102c', 'sandybux99@gmail.com', 'U5GE2X3oW5o6p8js', '25/04/2019 03:23', 0, '25-4-2019', '', 1, 0, 1),
(209, 'new york', '', 1, 0, 1556145169, 1, 0, 0, 1556145169, 0, '', '73ac0190753771ccf9c9cd40199e15e3', 'sandybux99@gmail.com', 'Sn7MT8z7Sh2DZw', '25/04/2019 08:32', 0, '25-4-2019', '', 1, 0, 1),
(210, 'new york', '', 1, 0, 1556145314, 0, 0, 0, 1556145314, 0, '', '3bb89503872da5d84fa7d66d66c72485', 'sandybux99@gmail.com', 'hgM1BUTL9h6gu', '25/04/2019 08:35', 0, '25-4-2019', '', 1, 0, 1);

-- --------------------------------------------------------

--
-- Table structure for table `job_categories`
--

CREATE TABLE IF NOT EXISTS `job_categories` (
`ID` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` mediumtext COLLATE utf8_unicode_ci NOT NULL,
  `cat_parent` int(11) NOT NULL,
  `image` varchar(1000) COLLATE utf8_unicode_ci NOT NULL,
  `no_jobs` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

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

CREATE TABLE IF NOT EXISTS `job_category_groups` (
`ID` int(11) NOT NULL,
  `groupid` int(11) NOT NULL,
  `catid` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `job_custom_fields`
--

CREATE TABLE IF NOT EXISTS `job_custom_fields` (
`ID` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `type` int(11) NOT NULL,
  `options` varchar(2000) COLLATE utf8_unicode_ci NOT NULL,
  `help_text` varchar(1000) COLLATE utf8_unicode_ci NOT NULL,
  `required` int(11) NOT NULL,
  `all_cats` int(11) NOT NULL,
  `hide_clientside` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `job_custom_fields`
--

INSERT INTO `job_custom_fields` (`ID`, `name`, `type`, `options`, `help_text`, `required`, `all_cats`, `hide_clientside`) VALUES
(2, 'Property Type', 4, 'Office,Retail,Industrial,Residential,Land,Other', '', 0, 0, 0),
(3, 'Orientation', 4, 'Portrait,Landscape,NA', '', 0, 0, 0),
(4, 'Sign Type', 4, 'Stockboard,Text Board,Photoboard,Window Graphic,Banner,Corflute,Other', '', 0, 0, 0),
(5, 'Size', 4, '900x600mm,1200x900mm,1800x1200mm,2400x1800mm,Other', '', 0, 0, 0),
(6, 'Quantity', 0, '', '', 1, 0, 0),
(7, 'V Board', 4, 'No,Yes', '', 0, 0, 0),
(8, 'Sale Method', 4, 'Sale,Lease,Sale/Lease,Auction', '', 0, 0, 0),
(9, 'Nameplate 2', 4, 'Trent Bruce 0423 591 528,Brad Weston 0478 352 346,Brandon Mertz 0423 591 533,David Kettle 0423 591 541,David Miller 0423 591 111,Hudson Dale 0423 591 529,James Doyle 0423 591 530,Lawrence Temple 0423 591 534,Michael Richardson 0478 352 341,Michael Schafferius 0423 591 540,Vaughn Smart 0423 591 531, NA', '', 0, 0, 0),
(10, 'Nameplate', 4, 'Trent Bruce 0423 591 528,Brad Weston 0478 352 346,Brandon Mertz 0423 591 533,David Kettle 0423 591 541,David Miller 0423 591 111,Hudson Dale 0423 591 529,James Doyle 0423 591 530,Lawrence Temple 0423 591 534,Michael Richardson 0478 352 341,Michael Schafferius 0423 591 540,Vaughn Smart 0423 591 531', '', 0, 0, 0),
(11, 'Install Notes', 1, '', '', 0, 0, 0),
(12, 'Task', 4, 'New/Additional Decal or Nameplate,Remove Graffiti,Relocate,Other,Standard Sold Sticker,Standard Leased Sticker,Sold By Sticker,Leased By Sticker', '', 0, 0, 0),
(13, 'Notes', 1, '', '', 0, 0, 0),
(14, 'Overlays', 0, '', '', 0, 0, 0),
(15, 'Agent Details', 0, '', '', 0, 0, 0),
(16, 'Accessories', 4, 'NA,Sale Sticker,Lease Sticker,Flag Holder,Other', '', 0, 0, 0),
(19, 'Textboard Information', 0, '', '', 0, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `job_custom_field_cats`
--

CREATE TABLE IF NOT EXISTS `job_custom_field_cats` (
`ID` int(11) NOT NULL,
  `fieldid` int(11) NOT NULL,
  `catid` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `job_custom_field_cats`
--

INSERT INTO `job_custom_field_cats` (`ID`, `fieldid`, `catid`) VALUES
(1, 2, 1),
(2, 3, 1),
(3, 4, 1),
(4, 5, 1),
(5, 6, 1),
(6, 7, 1),
(7, 8, 1),
(25, 12, 3),
(27, 10, 1),
(29, 9, 1),
(30, 15, 1),
(31, 16, 1),
(36, 14, 1),
(37, 11, 1),
(38, 13, 2),
(39, 13, 3);

-- --------------------------------------------------------

--
-- Table structure for table `job_files`
--

CREATE TABLE IF NOT EXISTS `job_files` (
`ID` int(11) NOT NULL,
  `jobid` int(11) NOT NULL,
  `upload_file_name` varchar(500) COLLATE utf8_unicode_ci NOT NULL,
  `file_type` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `extension` varchar(12) COLLATE utf8_unicode_ci NOT NULL,
  `file_size` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `timestamp` int(11) NOT NULL,
  `replyid` int(11) NOT NULL,
  `userid` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=246 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

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
(97, 66, '4af01c796fff08f7aad6a52746ccec9b.JPG', 'image/jpeg', '.JPG', '139.79', 1541559682, 43, 1),
(98, 82, '78707922733ebfbbb3befbd99476a087.pdf', 'application/pdf', '.pdf', '363.38', 1541978356, 0, 5),
(99, 82, '018ad507348568dc54ef1d64e3177d32.JPG', 'image/jpeg', '.JPG', '908.76', 1542057590, 44, 1),
(100, 83, '3c11ced3bb07becd1339cbdf6aec4965.pdf', 'application/pdf', '.pdf', '388.17', 1542082410, 0, 5),
(101, 84, 'e54d5655a17e9cba8783a94966c6d398.pdf', 'application/pdf', '.pdf', '388.17', 1542084473, 0, 5),
(102, 84, '0878cc0a8798b7e0d5cca0e19735bb4e.JPG', 'image/jpeg', '.JPG', '646.06', 1542158518, 45, 1),
(103, 85, '696aeeef791488539618d6bf3f5d3821.jpg', 'image/jpeg', '.jpg', '1466.84', 1542268129, 0, 1),
(113, 88, 'd176accdf8ae758072e2720f6dec1247.png', 'image/png', '.png', '120.43', 1542538165, 60, 1),
(116, 88, '1152089a51f8545c50ce3af5815870b4.png', 'image/png', '.png', '105.36', 1542539138, 63, 1),
(118, 88, '87f9c054e54054a45601af1f4aa1d75c.jpg', 'image/jpeg', '.jpg', '3725.16', 1542539881, 0, 1),
(119, 88, 'ea38e846a24686732ee09c25fa342360.png', 'image/png', '.png', '110.18', 1542540196, 66, 1),
(128, 87, '1eba47bff1f8fd571a5e988ef9717d42.png', 'image/png', '.png', '111.74', 1542557896, 76, 1),
(129, 87, 'c5a15bf1d09412185317f394a812fa4d.png', 'image/png', '.png', '111.74', 1542559085, 79, 1),
(130, 88, '371356ed6fcaf56ae72c18d16ad324a8.jpg', 'image/jpeg', '.jpg', '1716.51', 1542576896, 80, 1),
(131, 88, 'f3c76a823762cbb388ec9ec2bb4672ea.jpg', 'image/jpeg', '.jpg', '1335.49', 1542577373, 82, 1),
(132, 88, '538c156fc4c9a53f87188881abf4b2d4.JPG', 'image/jpeg', '.JPG', '777.92', 1542666293, 85, 1),
(133, 88, '1820f75b8d7e6ec69df07b04a26cd476.jpeg', 'image/jpeg', '.jpeg', '823.82', 1542667661, 86, 1),
(134, 98, '60e5ec61bde76d8496435314a2749662.pdf', 'application/pdf', '.pdf', '448.2', 1542673987, 0, 5),
(135, 99, '3c21bfab649518bf15ad98a34d7f04cc.pdf', 'application/pdf', '.pdf', '450.59', 1542674245, 0, 5),
(136, 100, '011fcfedeb37901d09bd02bea3a307ab.pdf', 'application/pdf', '.pdf', '391.97', 1542841996, 0, 5),
(137, 99, '836bdc74237d7ee4f0014e9b967c3ffa.jpeg', 'image/jpeg', '.jpeg', '1132.53', 1542922456, 89, 1),
(138, 98, '1d9976986471dba5dee2cfd20a9811dc.jpeg', 'image/jpeg', '.jpeg', '1434.81', 1542922512, 90, 1),
(139, 71, '2533594d9270a1bc9cb43a6c66e3c889.jpg', 'image/jpeg', '.jpg', '1917.09', 1542929622, 91, 1),
(140, 101, 'd7074d2c802ceebd5aec915e746bd55a.pdf', 'application/pdf', '.pdf', '394.87', 1543275590, 0, 5),
(141, 102, '9d28313ab5a3befb35fd5e07128e8ac4.pdf', 'application/pdf', '.pdf', '279.82', 1543275722, 0, 5),
(142, 102, '04dcd5769dcd7cd2edd2298f1aa8008e.jpeg', 'image/jpeg', '.jpeg', '2066.97', 1543382348, 92, 1),
(143, 101, 'e8ade1682d38947c44651b76310c5712.jpeg', 'image/jpeg', '.jpeg', '3264.84', 1543442406, 93, 1),
(144, 100, '74b9e10f4205459689638b3f117afcd6.jpg', 'image/jpeg', '.jpg', '306.64', 1543449931, 94, 1),
(145, 103, 'cef2f3cb286c976bcaf75652b00538de.jpg', 'image/jpeg', '.jpg', '2688.7', 1543460011, 0, 5),
(146, 103, '967f0cde5963646fe3543d6b2205f835.jpg', 'image/jpeg', '.jpg', '1559.38', 1543460013, 0, 5),
(147, 103, 'e2685758627ec17c46d4a0f8269bb7b8.jpeg', 'image/jpeg', '.jpeg', '4879.43', 1543472104, 95, 1),
(148, 106, '5e1b3359db241b21184592ab1699fe25.pdf', 'application/pdf', '.pdf', '434.44', 1543545715, 0, 5),
(149, 107, '9aa33e12a8f2143ff235ee019f1a9f0a.pdf', 'application/pdf', '.pdf', '370.61', 1543545783, 0, 5),
(150, 108, '994da5c828624122db48bed19e931662.pdf', 'application/pdf', '.pdf', '192.31', 1543546186, 0, 5),
(151, 109, '58afecaa3eb336b6f45a22aaa802ca34.pdf', 'application/pdf', '.pdf', '192.27', 1543546264, 0, 5),
(152, 110, '9a6c657d572a883d777ed421d21a3450.pdf', 'application/pdf', '.pdf', '183.69', 1543546346, 0, 5),
(153, 111, '3eb65f90f8fe722b60d73b0f39f5e58c.pdf', 'application/pdf', '.pdf', '1758.77', 1543561548, 0, 5),
(154, 112, 'c70a65f30ab6917cb64fd9c936dc6646.pdf', 'application/pdf', '.pdf', '601.78', 1543561711, 0, 5),
(155, 113, 'e2641a14eca322e9a64bb11e3283fe0a.pdf', 'application/pdf', '.pdf', '565.31', 1543561781, 0, 5),
(156, 114, '5f4de188e948b42a2f3dfded1e36c9e9.pdf', 'application/pdf', '.pdf', '231.44', 1543561962, 0, 5),
(157, 115, 'd3ce3ab0e1c78c8ca53e7f0780dfe4dc.pdf', 'application/pdf', '.pdf', '221.36', 1543562029, 0, 5),
(158, 116, '01cd4037e871b4188e6fc3965af3e67a.pdf', 'application/pdf', '.pdf', '223.01', 1543562110, 0, 5),
(159, 113, '19f82e18a01e71bf8bd502b2ca09b436.jpg', 'image/jpeg', '.jpg', '2683.18', 1543810913, 96, 1),
(160, 112, '2f02e2d067c286b2038fde8435ce7236.jpg', 'image/jpeg', '.jpg', '4170.61', 1543811669, 97, 1),
(161, 106, '2f13195c80a61d66528fa89aa63573ae.jpg', 'image/jpeg', '.jpg', '3123.62', 1543814695, 98, 1),
(162, 117, '50d9db66b947b38916227d9c68857845.pdf', 'application/pdf', '.pdf', '551.87', 1543818255, 0, 5),
(163, 118, '237310676b9a90e5fe2db6a16bfd54fb.pdf', 'application/pdf', '.pdf', '490.6', 1543818325, 0, 5),
(164, 119, '2e21015bb96b11f9b1b243712ab5134d.pdf', 'application/pdf', '.pdf', '450.18', 1543818410, 0, 5),
(165, 107, '4cacbd258708b984bbb2ca986dac5776.jpeg', 'image/jpeg', '.jpeg', '3696.01', 1543818763, 100, 1),
(166, 114, 'e5fcf7337358254e11dae952981e3ad0.jpeg', 'image/jpeg', '.jpeg', '3965.85', 1543818843, 101, 1),
(167, 109, 'dc6635a2a4767ea165d84ef79902a17c.jpeg', 'image/jpeg', '.jpeg', '3977.85', 1543883542, 102, 1),
(168, 121, 'cb27ec3070266ac1b6394cfe55f50b1c.pdf', 'application/pdf', '.pdf', '533.53', 1543887193, 0, 5),
(169, 116, 'fa234fcc4e6c6a5e414f1d38fc9852fb.jpg', 'image/jpeg', '.jpg', '121.48', 1543889271, 103, 1),
(170, 115, 'cd2e32e79340d4e481e0e598614b587f.jpeg', 'image/jpeg', '.jpeg', '4388.32', 1543889318, 104, 1),
(171, 108, 'b4b2d89f3fe0b108315c81342d205151.jpeg', 'image/jpeg', '.jpeg', '3815.36', 1543904765, 105, 1),
(172, 110, 'cc53a240497609930c9ac62c235bf51b.jpg', 'image/jpeg', '.jpg', '2486.14', 1543906414, 106, 1),
(173, 111, '341dac05c30fddfdc12905fe9de98b70.jpg', 'image/jpeg', '.jpg', '2825.71', 1543908192, 107, 1),
(174, 120, 'ce6ac9a40a00b7a81550bcdafe242a53.jpg', 'image/jpeg', '.jpg', '2672.08', 1543958812, 108, 1),
(175, 122, '856362f95bb5aabda8b9a89840c3a590.jpeg', 'image/jpeg', '.jpeg', '2792.74', 1543960151, 109, 1),
(176, 119, '1238191555b844ab7e726c45901612d7.jpg', 'image/jpeg', '.jpg', '2619.77', 1543969083, 110, 1),
(177, 117, 'ae5ede2fda43da400f6e0e14735a7ddf.jpg', 'image/jpeg', '.jpg', '3623.71', 1543970245, 111, 1),
(178, 118, 'f900dc7e12c85034b11665d17e0debcd.jpg', 'image/jpeg', '.jpg', '3983.92', 1543986452, 112, 1),
(179, 121, '7a9d1d744d3ec14f11c09cb1669c41da.jpeg', 'image/jpeg', '.jpeg', '3069.22', 1543987399, 113, 1),
(180, 124, 'ccb19b0faabcc0dc88a490a1250f6ce8.jpeg', 'image/jpeg', '.jpeg', '4709.58', 1544226261, 114, 1),
(181, 127, 'f5aa7e7d99d9bf7000267ace32791176.jpeg', 'image/jpeg', '.jpeg', '5195.15', 1544226296, 115, 1),
(182, 128, '6a0f7bf5590241956e69890f1930a6b5.jpeg', 'image/jpeg', '.jpeg', '4012.61', 1544226326, 116, 1),
(183, 130, '9999274dc0c63ddf2c42458fb6e28237.jpeg', 'image/jpeg', '.jpeg', '3672.85', 1544226822, 117, 1),
(184, 129, 'ed7d70606e63d0a5816f1edd83083861.jpg', 'image/jpeg', '.jpg', '4443.59', 1544227794, 118, 1),
(185, 125, 'b20573703aafd2d7cdafee6b8681dcd8.jpeg', 'image/jpeg', '.jpeg', '2826.33', 1544227855, 119, 1),
(186, 126, '4e34f1169a9917140e469040e6542344.jpg', 'image/jpeg', '.jpg', '4189.63', 1544230242, 120, 1),
(187, 123, '87cc7f22e8e8e568a4ab5d742716b16f.jpeg', 'image/jpeg', '.jpeg', '4042.88', 1544395874, 121, 1),
(188, 131, '9a5edf17a8ad6f8c2bb15704bf18b205.pdf', 'application/pdf', '.pdf', '548.36', 1544413676, 0, 5),
(189, 132, '30d2714eee08f7392cb681c8a0d5a1c0.pdf', 'application/pdf', '.pdf', '523.34', 1544413765, 0, 5),
(190, 131, '9630673f7c789944ffe766d08b832349.jpeg', 'image/jpeg', '.jpeg', '2218.8', 1544472519, 122, 1),
(191, 133, '253bdbcd09fb25320a7f5955a9f411fc.pdf', 'application/pdf', '.pdf', '520.61', 1544496159, 0, 5),
(192, 134, 'd3ca26dddc189ba58bc5df189df23010.pdf', 'application/pdf', '.pdf', '682.41', 1544594154, 0, 5),
(193, 138, 'df62c3f45edd0005e96810df18e261ed.pdf', 'application/pdf', '.pdf', '390.61', 1544678629, 0, 5),
(194, 141, '6aacb2544c32d8c09bd7a520529fb9ac.pdf', 'application/pdf', '.pdf', '345.97', 1545089496, 0, 5),
(195, 141, '70292cfe0c8fecc3ecbc0b5c33760949.pdf', 'application/pdf', '.pdf', '51.79', 1545089496, 0, 5),
(196, 142, 'de2403d5417b74b9b7b4164742a50542.pdf', 'application/pdf', '.pdf', '373.85', 1545089710, 0, 5),
(197, 143, '03495c09870f35d790a4bc57e64ae6d4.pdf', 'application/pdf', '.pdf', '188.71', 1545096893, 0, 5),
(198, 144, '25f1409c805cbe674bcbb8acbf03fa9a.pdf', 'application/pdf', '.pdf', '369.19', 1545097041, 0, 5),
(199, 153, 'f072e8b917c57166389e2c639893fdf3.pdf', 'application/pdf', '.pdf', '399.67', 1545174026, 0, 5),
(200, 133, '5ec6acdf549f39a8d1924c55c6b52688.jpeg', 'image/jpeg', '.jpeg', '2180.18', 1545183820, 123, 1),
(201, 154, 'f89a9bbb53776c2257a0bb28d87f38d3.pdf', 'application/pdf', '.pdf', '389.25', 1545188784, 0, 5),
(202, 132, '9e65073c6a2ab5447c8f1e63a19891e3.jpeg', 'image/jpeg', '.jpeg', '4659.05', 1545194267, 124, 1),
(203, 134, 'a9c488d6b3c7236f5a6534eb81d0b4a4.jpeg', 'image/jpeg', '.jpeg', '4384.96', 1545194297, 125, 1),
(204, 138, 'd379c4f4ed10afc2e9102cf7be491b4e.jpeg', 'image/jpeg', '.jpeg', '3327.7', 1545195717, 126, 1),
(205, 157, '53b6a6542fc175a348459d01c5e891c2.pdf', 'application/pdf', '.pdf', '829.1', 1545197857, 0, 5),
(206, 136, '65535002f935c36a831374c9a1ab57c9.jpeg', 'image/jpeg', '.jpeg', '3277.49', 1545199260, 127, 1),
(207, 137, '307dbf4b42c116f4e439bb6c22971d1c.jpeg', 'image/jpeg', '.jpeg', '3277.49', 1545200902, 128, 1),
(208, 135, '731c084427a578c7e0ef36b3e19ceef7.jpeg', 'image/jpeg', '.jpeg', '3774.19', 1545201793, 129, 1),
(210, 153, 'e63e6c21b332d3330541c0e909610669.jpeg', 'image/jpeg', '.jpeg', '2526.07', 1545340169, 131, 1),
(211, 140, '99b6624a1032272e538d76cfe4cd4cce.jpeg', 'image/jpeg', '.jpeg', '2206.75', 1545340211, 132, 1),
(212, 141, '89e36be32a51cd83202c547608474bf2.jpeg', 'image/jpeg', '.jpeg', '2370.96', 1545342306, 133, 1),
(213, 151, '00452be634a41e9051c9b7644e92b9f2.jpeg', 'image/jpeg', '.jpeg', '3391.86', 1545347205, 134, 1),
(214, 145, '50e15cf4c6d76a204112c4721ce6083f.jpeg', 'image/jpeg', '.jpeg', '3642.45', 1545347245, 135, 1),
(215, 147, '246facb7d58cbfc2e3daebf6eeddc5a4.jpeg', 'image/jpeg', '.jpeg', '4778.97', 1545348002, 136, 1),
(216, 149, 'ebe6a414bdce31853d05de5a7d5128c1.jpeg', 'image/jpeg', '.jpeg', '3404.62', 1545349331, 137, 1),
(217, 142, 'bd07be427da6b7c09b8ba3b7631c413b.jpeg', 'image/jpeg', '.jpeg', '2103.13', 1545351392, 138, 1),
(218, 148, '80a924a419c3f4970cc42598c67f228b.jpeg', 'image/jpeg', '.jpeg', '4539.06', 1545352610, 139, 1),
(219, 150, 'f374a8a7dff61ef4197830bb066a49d3.jpeg', 'image/jpeg', '.jpeg', '4212.53', 1545364109, 140, 1),
(220, 150, '8f4a777274243e50d56424ff4d5d4d25.jpeg', 'image/jpeg', '.jpeg', '4212.53', 1545364123, 141, 1),
(221, 157, 'f54396c5fbab0f1c01fbb17900c80c34.jpg', 'image/jpeg', '.jpg', '145.67', 1546805923, 142, 1),
(222, 154, 'b7b124362728251b57cf9c26151bdc44.jpg', 'image/jpeg', '.jpg', '123.61', 1546805967, 143, 1),
(223, 144, 'e01bde52419232b0c108f05026ff352c.jpg', 'image/jpeg', '.jpg', '114.71', 1546806005, 144, 1),
(224, 143, '7259c565dd11effe897e9410f7b73abe.jpg', 'image/jpeg', '.jpg', '120.55', 1546806054, 145, 1),
(225, 159, '7a3585569b326044b3c776439d31037b.jpg', 'image/jpeg', '.jpg', '93.05', 1546806249, 146, 1),
(226, 161, '7cd35d83fdbf8b451841d9416183c14d.pdf', 'application/pdf', '.pdf', '536.14', 1546905103, 0, 5),
(227, 173, '293295efd7ff263605d990bb86ca1edb.jpeg', 'image/jpeg', '.jpeg', '4954.38', 1546991322, 147, 1),
(228, 176, 'c23d48947a195c48403aef8ce5155e72.jpeg', 'image/jpeg', '.jpeg', '3140.93', 1546991364, 148, 1),
(229, 168, '2d0d2becc77e61f11bf470dd8255b8a8.jpeg', 'image/jpeg', '.jpeg', '3441.79', 1546992158, 149, 1),
(230, 166, 'bc31054d14b8dfd46df09d9b88be8bb2.jpeg', 'image/jpeg', '.jpeg', '3258.92', 1546992383, 150, 1),
(231, 167, '4192cb03e65cbf1a0674382ac0b37d42.jpeg', 'image/jpeg', '.jpeg', '4569.5', 1546992419, 151, 1),
(232, 171, '8d1ae73fbce6c5d78a1d057ee69469a5.jpeg', 'image/jpeg', '.jpeg', '3877.89', 1546995052, 152, 1),
(233, 175, 'd348c9cd648b5dc609d95f50593c1165.jpeg', 'image/jpeg', '.jpeg', '4606.98', 1546995399, 153, 1),
(234, 164, '7d5540921fc7531abc761ad80f428d36.jpeg', 'image/jpeg', '.jpeg', '4134.06', 1546995435, 154, 1),
(235, 175, '57a808e0c9ab639abeeedf6d15514ab6.jpeg', 'image/jpeg', '.jpeg', '3927.04', 1546995792, 155, 1),
(236, 172, '64c2ed7db6ea6944281d8d87d1cc92c3.jpeg', 'image/jpeg', '.jpeg', '3887.11', 1546998053, 156, 1),
(237, 174, '1549dbf4c002f09163d051bc611d0285.jpeg', 'image/jpeg', '.jpeg', '4122.21', 1547000740, 157, 1),
(238, 161, '46bcfe5ec46be8b9eed50497a87f94d0.jpg', 'image/jpeg', '.jpg', '3972.28', 1547094149, 158, 1),
(239, 177, '4dee793bbf84ddfe69517f1ab91c9d25.jpeg', 'image/jpeg', '.jpeg', '4918.94', 1547161591, 159, 1),
(240, 163, '65608419df109e88a4cf17df27591d7d.jpeg', 'image/jpeg', '.jpeg', '5101.04', 1547162897, 160, 1),
(241, 160, 'a270b6b753422983c08e3c34ce35c900.jpeg', 'image/jpeg', '.jpeg', '4001.26', 1547165629, 161, 1),
(242, 179, 'c6be640798780e2906e0d537f416befb.pdf', 'application/pdf', '.pdf', '1010.06', 1547424966, 0, 5),
(243, 181, 'fe395a23978fcf7ae465dcd288749b8e.pdf', 'application/pdf', '.pdf', '851.05', 1547517658, 0, 5),
(244, 210, '091c64a6c299802226dc1018ef712c64.jpeg', 'image/jpeg', '.jpeg', '172.02', 1556145314, 0, 1),
(245, 211, '01a95e5d35a9d06af39de89e2dc5e21c.pdf', 'application/pdf', '.pdf', '91.15', 1556145649, 0, 1);

-- --------------------------------------------------------

--
-- Table structure for table `job_history`
--

CREATE TABLE IF NOT EXISTS `job_history` (
`ID` int(11) NOT NULL,
  `jobid` int(11) NOT NULL,
  `userid` int(11) NOT NULL,
  `message` varchar(500) COLLATE utf8_unicode_ci NOT NULL,
  `timestamp` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=680 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

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
(211, 66, 1, 'Replied to the job.', 1541559682),
(212, 82, 5, 'Job was created [CLIENT].', 1541978356),
(213, 83, 1, 'Job was created [CLIENT].', 1541981141),
(214, 82, 1, 'Job status was changed to In Progress', 1541984696),
(215, 82, 1, 'Job status was changed to Installed', 1542057548),
(216, 82, 1, 'Replied to the job.', 1542057590),
(217, 83, 5, 'Job was created [CLIENT].', 1542082410),
(218, 84, 5, 'Job was created [CLIENT].', 1542084473),
(219, 84, 1, 'Job status was changed to In Progress', 1542087539),
(220, 84, 1, 'Job status was changed to Installed', 1542158456),
(221, 84, 1, 'Replied to the job.', 1542158518),
(222, 85, 1, 'Job was created [CLIENT].', 1542267529),
(223, 85, 1, 'Job status was changed to Installed', 1542267571),
(224, 85, 1, 'Job status was changed to Installed', 1542268129),
(225, 85, 1, 'Replied to the job.', 1542268129),
(226, 86, 30, 'Job was created [CLIENT].', 1542515430),
(227, 87, 30, 'Job was created [CLIENT].', 1542515444),
(228, 87, 1, 'Replied to the job.', 1542515485),
(229, 86, 1, 'Job status was changed to Installed', 1542515704),
(230, 86, 1, 'Replied to the job.', 1542515709),
(231, 87, 1, 'Job reply was deleted: <p>test</p>\r\n', 1542516578),
(232, 87, 1, 'Replied to the job.', 1542516591),
(233, 87, 1, 'Job reply was deleted: <p>2</p>\r\n', 1542516626),
(234, 87, 1, 'Replied to the job.', 1542516759),
(235, 87, 1, 'Job reply was deleted: <p>2</p>\r\n', 1542529073),
(236, 87, 1, 'Replied to the job.', 1542529086),
(237, 87, 1, 'Job reply was deleted: <p>er</p>\r\n', 1542529187),
(238, 87, 1, 'Replied to the job.', 1542529343),
(239, 87, 1, 'Deleted a job file attachment.', 1542529449),
(240, 87, 1, 'Deleted a job file attachment.', 1542529452),
(241, 87, 1, 'Job reply was deleted: <p>e</p>\r\n', 1542529504),
(242, 87, 1, 'Replied to the job.', 1542529538),
(243, 87, 1, 'Deleted a job file attachment.', 1542529613),
(244, 87, 1, 'Job reply was deleted: <p>fgfg</p>\r\n', 1542529619),
(245, 87, 1, 'Replied to the job.', 1542529704),
(246, 87, 1, 'Deleted a job file attachment.', 1542529809),
(247, 87, 1, 'Job reply was deleted: <p>fdasfdasfdsa</p>\r\n', 1542529813),
(248, 87, 1, 'Replied to the job.', 1542530463),
(249, 87, 1, 'Deleted a job file attachment.', 1542530564),
(250, 87, 1, 'Job reply was deleted: <p>e</p>\r\n', 1542530569),
(251, 87, 1, 'Replied to the job.', 1542530584),
(252, 87, 1, 'Deleted a job file attachment.', 1542530822),
(253, 87, 1, 'Job reply was deleted: <p>ee</p>\r\n', 1542530827),
(254, 87, 1, 'Replied to the job.', 1542530944),
(255, 87, 1, 'Deleted a job file attachment.', 1542531309),
(256, 87, 1, 'Job reply was deleted: <p>fdsafdsa</p>\r\n', 1542531315),
(257, 87, 1, 'Replied to the job.', 1542531338),
(258, 87, 1, 'Deleted a job file attachment.', 1542531525),
(259, 87, 1, 'Job reply was deleted: <p>fdfdsa</p>\r\n', 1542531529),
(260, 87, 1, 'Replied to the job.', 1542531685),
(261, 88, 1, 'Job was created [CLIENT].', 1542538118),
(262, 88, 1, 'Replied to the job.', 1542538165),
(263, 87, 1, 'Job reply was deleted: <p>bbb</p>\r\n', 1542538682),
(264, 87, 1, 'Deleted a job file attachment.', 1542538685),
(265, 87, 1, 'Replied to the job.', 1542538702),
(266, 87, 1, 'Deleted a job file attachment.', 1542538962),
(267, 87, 1, 'Job reply was deleted: <p>dsa</p>\r\n', 1542538967),
(268, 87, 1, 'Replied to the job.', 1542538983),
(269, 87, 1, 'Deleted a job file attachment.', 1542539027),
(270, 88, 1, 'Replied to the job.', 1542539138),
(271, 87, 1, 'Job reply was deleted: <p>123213</p>\r\n', 1542539277),
(272, 87, 1, 'Replied to the job.', 1542539296),
(273, 88, 1, 'Job status was changed to New', 1542539878),
(274, 88, 1, 'Replied to the job.', 1542539881),
(275, 88, 1, 'Replied to the job.', 1542540196),
(276, 88, 1, 'Job status was changed to New', 1542540594),
(277, 88, 1, 'Job status was changed to New', 1542540811),
(278, 88, 1, 'Job status was changed to New', 1542540967),
(279, 87, 1, 'Deleted a job file attachment.', 1542547556),
(280, 87, 1, 'Job reply was deleted: <p>ffdsafdsafdsa</p>\r\n', 1542547560),
(281, 87, 1, 'Replied to the job.', 1542547576),
(282, 87, 1, 'Deleted a job file attachment.', 1542548948),
(283, 87, 1, 'Job reply was deleted: ', 1542548952),
(284, 87, 1, 'Replied to the job.', 1542548970),
(285, 87, 1, 'Job reply was deleted: ', 1542549252),
(286, 87, 1, 'Job status was changed to New', 1542549371),
(287, 87, 1, 'Replied to the job.', 1542549371),
(288, 87, 1, 'Deleted a job file attachment.', 1542549465),
(289, 87, 1, 'Job reply was deleted: ', 1542549470),
(290, 87, 1, 'Replied to the job.', 1542549498),
(291, 87, 1, 'Replied to the job.', 1542555741),
(292, 87, 1, 'Job status was changed to Removed', 1542555897),
(293, 87, 1, 'Replied to the job.', 1542555897),
(294, 87, 1, 'Deleted a job file attachment.', 1542556320),
(295, 87, 1, 'Deleted a job file attachment.', 1542556322),
(296, 87, 1, 'Deleted a job file attachment.', 1542556324),
(297, 87, 1, 'Job reply was deleted: ', 1542556328),
(298, 87, 1, 'Job reply was deleted: <p>fdsafdsa</p>\r\n', 1542556332),
(299, 87, 1, 'Job reply was deleted: ', 1542556336),
(300, 87, 1, 'Job status was changed to Installed', 1542556363),
(301, 87, 1, 'Replied to the job.', 1542556364),
(302, 87, 1, 'Job status was changed to Installed', 1542557622),
(303, 87, 1, 'Replied to the job.', 1542557622),
(304, 87, 1, 'Job status was changed to Installed', 1542557796),
(305, 87, 1, 'Replied to the job.', 1542557797),
(306, 87, 1, 'Deleted a job file attachment.', 1542557807),
(307, 87, 1, 'Deleted a job file attachment.', 1542557810),
(308, 87, 1, 'Deleted a job file attachment.', 1542557811),
(309, 87, 1, 'Job reply was deleted: ', 1542557817),
(310, 87, 1, 'Job reply was deleted: ', 1542557820),
(311, 87, 1, 'Job reply was deleted: ', 1542557824),
(312, 87, 1, 'Job status was changed to Installed', 1542557896),
(313, 87, 1, 'Replied to the job.', 1542557896),
(314, 87, 1, 'Job status was changed to Installed', 1542558450),
(315, 87, 1, 'Replied to the job.', 1542558450),
(316, 87, 1, 'Job status was changed to Installed', 1542558803),
(317, 87, 1, 'Replied to the job.', 1542558804),
(318, 87, 1, 'Job status was changed to Installed', 1542559085),
(319, 87, 1, 'Replied to the job.', 1542559085),
(320, 88, 1, 'Job status was changed to New', 1542576896),
(321, 88, 1, 'Replied to the job.', 1542576896),
(322, 88, 1, 'Job status was changed to New', 1542577085),
(323, 88, 1, 'Replied to the job.', 1542577085),
(324, 88, 1, 'Job status was changed to New', 1542577373),
(325, 88, 1, 'Replied to the job.', 1542577373),
(326, 89, 4, 'Job was created [CLIENT].', 1542582380),
(327, 89, 1, 'Replied to the job.', 1542582558),
(328, 90, 30, 'Job was created [CLIENT].', 1542583452),
(329, 91, 30, 'Job was created [CLIENT].', 1542587229),
(330, 92, 30, 'Job was created [CLIENT].', 1542587444),
(331, 93, 4, 'Job was created [CLIENT].', 1542603436),
(332, 93, 1, 'Job status was changed to Installed', 1542604065),
(333, 93, 1, 'Replied to the job.', 1542604073),
(334, 94, 29, 'Job was created [CLIENT].', 1542611220),
(335, 95, 30, 'Job was created [CLIENT].', 1542613219),
(336, 96, 4, 'Job was created [CLIENT].', 1542613399),
(337, 88, 1, 'Replied to the job.', 1542666293),
(338, 88, 1, 'Replied to the job.', 1542667661),
(339, 97, 1, 'Job was created [CLIENT].', 1542668349),
(340, 97, 1, 'Replied to the job.', 1542668367),
(341, 98, 5, 'Job was created [CLIENT].', 1542673987),
(342, 99, 5, 'Job was created [CLIENT].', 1542674245),
(343, 96, 1, 'Replied to the job.', 1542685191),
(344, 99, 1, 'Job status was changed to In Progress', 1542751298),
(345, 98, 1, 'Job status was changed to In Progress', 1542751304),
(346, 100, 5, 'Job was created [CLIENT].', 1542841996),
(347, 100, 1, 'Job status was changed to Installed', 1542846959),
(348, 100, 1, 'Job status was changed to In Progress', 1542846970),
(349, 99, 1, 'Job status was changed to Installed', 1542922453),
(350, 99, 1, 'Replied to the job.', 1542922456),
(351, 98, 1, 'Job status was changed to Installed', 1542922512),
(352, 98, 1, 'Replied to the job.', 1542922512),
(353, 71, 1, 'Job status was changed to Installed', 1542929620),
(354, 71, 1, 'Replied to the job.', 1542929622),
(355, 71, 1, 'Deleted a job file attachment.', 1543002429),
(356, 101, 5, 'Job was created [CLIENT].', 1543275590),
(357, 102, 5, 'Job was created [CLIENT].', 1543275722),
(358, 101, 1, 'Job status was changed to In Progress', 1543301664),
(359, 102, 1, 'Job status was changed to In Progress', 1543301710),
(360, 102, 1, 'Job status was changed to Installed', 1543382348),
(361, 102, 1, 'Replied to the job.', 1543382348),
(362, 101, 1, 'Job status was changed to Installed', 1543442406),
(363, 101, 1, 'Replied to the job.', 1543442406),
(364, 100, 1, 'Job status was changed to In Progress', 1543449830),
(365, 100, 1, 'Replied to the job.', 1543449931),
(366, 100, 1, 'Job status was changed to Installed', 1543449939),
(367, 103, 5, 'Job was created [CLIENT].', 1543460013),
(368, 104, 5, 'Job was created [CLIENT].', 1543460062),
(369, 103, 1, 'Job status was changed to Installed', 1543472103),
(370, 103, 1, 'Replied to the job.', 1543472104),
(371, 105, 5, 'Job was created [CLIENT].', 1543474592),
(372, 105, 1, 'Job status was changed to In Progress', 1543524904),
(373, 104, 1, 'Job status was changed to In Progress', 1543524915),
(374, 106, 5, 'Job was created [CLIENT].', 1543545716),
(375, 107, 5, 'Job was created [CLIENT].', 1543545783),
(376, 108, 5, 'Job was created [CLIENT].', 1543546186),
(377, 109, 5, 'Job was created [CLIENT].', 1543546264),
(378, 110, 5, 'Job was created [CLIENT].', 1543546346),
(379, 106, 1, 'Job status was changed to In Progress', 1543551565),
(380, 107, 1, 'Job status was changed to In Progress', 1543551591),
(381, 108, 1, 'Job status was changed to In Progress', 1543551652),
(382, 109, 1, 'Job status was changed to In Progress', 1543551662),
(383, 110, 1, 'Job status was changed to In Progress', 1543552164),
(384, 111, 5, 'Job was created [CLIENT].', 1543561548),
(385, 112, 5, 'Job was created [CLIENT].', 1543561711),
(386, 113, 5, 'Job was created [CLIENT].', 1543561781),
(387, 114, 5, 'Job was created [CLIENT].', 1543561962),
(388, 115, 5, 'Job was created [CLIENT].', 1543562029),
(389, 116, 5, 'Job was created [CLIENT].', 1543562110),
(390, 111, 1, 'Job status was changed to In Progress', 1543784158),
(391, 112, 1, 'Job status was changed to In Progress', 1543784268),
(392, 113, 1, 'Job status was changed to In Progress', 1543784311),
(393, 114, 1, 'Job status was changed to In Progress', 1543784350),
(394, 115, 1, 'Job status was changed to In Progress', 1543784385),
(395, 116, 1, 'Job status was changed to In Progress', 1543784583),
(396, 113, 1, 'Job status was changed to Installed', 1543810913),
(397, 113, 1, 'Replied to the job.', 1543810913),
(398, 112, 1, 'Job status was changed to Installed', 1543811663),
(399, 112, 1, 'Replied to the job.', 1543811669),
(400, 106, 1, 'Job status was changed to Installed', 1543814693),
(401, 106, 1, 'Replied to the job.', 1543814695),
(402, 104, 1, 'Job status was changed to Installed', 1543815795),
(403, 104, 1, 'Replied to the job.', 1543815795),
(404, 117, 5, 'Job was created [CLIENT].', 1543818255),
(405, 118, 5, 'Job was created [CLIENT].', 1543818325),
(406, 119, 5, 'Job was created [CLIENT].', 1543818410),
(407, 107, 1, 'Job status was changed to Installed', 1543818763),
(408, 107, 1, 'Replied to the job.', 1543818763),
(409, 114, 1, 'Job status was changed to Installed', 1543818841),
(410, 114, 1, 'Replied to the job.', 1543818843),
(411, 120, 5, 'Job was created [CLIENT].', 1543876577),
(412, 109, 1, 'Job status was changed to Installed', 1543883541),
(413, 109, 1, 'Replied to the job.', 1543883542),
(414, 121, 5, 'Job was created [CLIENT].', 1543887193),
(415, 117, 1, 'Job status was changed to In Progress', 1543889011),
(416, 118, 1, 'Job status was changed to In Progress', 1543889101),
(417, 119, 1, 'Job status was changed to In Progress', 1543889123),
(418, 116, 1, 'Job status was changed to Installed', 1543889238),
(419, 116, 1, 'Replied to the job.', 1543889271),
(420, 115, 1, 'Job status was changed to Installed', 1543889312),
(421, 115, 1, 'Replied to the job.', 1543889318),
(422, 105, 1, 'Job status was changed to Removed', 1543889751),
(423, 122, 5, 'Job was created [CLIENT].', 1543898588),
(424, 108, 1, 'Job status was changed to Installed', 1543904762),
(425, 108, 1, 'Replied to the job.', 1543904765),
(426, 110, 1, 'Job status was changed to Installed', 1543906414),
(427, 110, 1, 'Replied to the job.', 1543906414),
(428, 111, 1, 'Job status was changed to Installed', 1543908189),
(429, 111, 1, 'Replied to the job.', 1543908192),
(430, 121, 1, 'Job status was changed to In Progress', 1543955273),
(431, 120, 1, 'Job status was changed to Installed', 1543958812),
(432, 120, 1, 'Replied to the job.', 1543958812),
(433, 122, 1, 'Job status was changed to Removed', 1543960148),
(434, 122, 1, 'Replied to the job.', 1543960151),
(435, 119, 1, 'Job status was changed to Installed', 1543969083),
(436, 119, 1, 'Replied to the job.', 1543969084),
(437, 117, 1, 'Job status was changed to Installed', 1543970242),
(438, 117, 1, 'Replied to the job.', 1543970245),
(439, 118, 1, 'Job status was changed to Installed', 1543986451),
(440, 118, 1, 'Replied to the job.', 1543986452),
(441, 121, 1, 'Job status was changed to Installed', 1543987397),
(442, 121, 1, 'Replied to the job.', 1543987399),
(443, 123, 5, 'Job was created [CLIENT].', 1544050472),
(444, 123, 1, 'Job status was changed to In Progress', 1544058209),
(445, 124, 32, 'Job was created [CLIENT].', 1544146191),
(446, 125, 32, 'Job was created [CLIENT].', 1544146305),
(447, 126, 32, 'Job was created [CLIENT].', 1544146356),
(448, 127, 32, 'Job was created [CLIENT].', 1544146420),
(449, 128, 32, 'Job was created [CLIENT].', 1544146496),
(450, 129, 32, 'Job was created [CLIENT].', 1544146554),
(451, 130, 32, 'Job was created [CLIENT].', 1544146610),
(452, 130, 1, 'Job status was changed to In Progress', 1544157583),
(453, 129, 1, 'Job status was changed to In Progress', 1544157589),
(454, 128, 1, 'Job status was changed to In Progress', 1544157595),
(455, 127, 1, 'Job status was changed to In Progress', 1544157602),
(456, 126, 1, 'Job status was changed to In Progress', 1544157608),
(457, 125, 1, 'Job status was changed to In Progress', 1544157617),
(458, 124, 1, 'Job status was changed to In Progress', 1544157624),
(459, 124, 1, 'Job status was changed to Installed', 1544226259),
(460, 124, 1, 'Replied to the job.', 1544226261),
(461, 127, 1, 'Job status was changed to Installed', 1544226289),
(462, 127, 1, 'Replied to the job.', 1544226296),
(463, 128, 1, 'Job status was changed to Installed', 1544226326),
(464, 128, 1, 'Replied to the job.', 1544226326),
(465, 130, 1, 'Job status was changed to Installed', 1544226819),
(466, 130, 1, 'Replied to the job.', 1544226822),
(467, 129, 1, 'Job status was changed to Installed', 1544227788),
(468, 129, 1, 'Replied to the job.', 1544227794),
(469, 125, 1, 'Job status was changed to Installed', 1544227855),
(470, 125, 1, 'Replied to the job.', 1544227855),
(471, 126, 1, 'Job status was changed to Installed', 1544230239),
(472, 126, 1, 'Replied to the job.', 1544230242),
(473, 123, 1, 'Job status was changed to Installed', 1544395870),
(474, 123, 1, 'Replied to the job.', 1544395874),
(475, 131, 5, 'Job was created [CLIENT].', 1544413676),
(476, 132, 5, 'Job was created [CLIENT].', 1544413765),
(477, 131, 1, 'Job status was changed to Installed', 1544472518),
(478, 131, 1, 'Replied to the job.', 1544472519),
(479, 133, 5, 'Job was created [CLIENT].', 1544496159),
(480, 132, 1, 'Job status was changed to In Progress', 1544578980),
(481, 133, 1, 'Job status was changed to In Progress', 1544578987),
(482, 134, 5, 'Job was created [CLIENT].', 1544594154),
(483, 134, 1, 'Job status was changed to In Progress', 1544653243),
(484, 135, 32, 'Job was created [CLIENT].', 1544658000),
(485, 136, 32, 'Job was created [CLIENT].', 1544658074),
(486, 137, 32, 'Job was created [CLIENT].', 1544658133),
(487, 138, 5, 'Job was created [CLIENT].', 1544678629),
(488, 135, 1, 'Job status was changed to In Progress', 1544998904),
(489, 137, 1, 'Job status was changed to Installed', 1544998921),
(490, 136, 1, 'Job status was changed to In Progress', 1544998929),
(491, 138, 1, 'Job status was changed to In Progress', 1544998935),
(492, 137, 1, 'Job status was changed to In Progress', 1544998944),
(493, 139, 5, 'Job was created [CLIENT].', 1545002304),
(494, 140, 5, 'Job was created [CLIENT].', 1545023018),
(495, 141, 5, 'Job was created [CLIENT].', 1545089496),
(496, 142, 5, 'Job was created [CLIENT].', 1545089710),
(497, 143, 5, 'Job was created [CLIENT].', 1545096893),
(498, 144, 5, 'Job was created [CLIENT].', 1545097041),
(499, 145, 32, 'Job was created [CLIENT].', 1545172985),
(500, 146, 32, 'Job was created [CLIENT].', 1545173024),
(501, 147, 32, 'Job was created [CLIENT].', 1545173113),
(502, 148, 32, 'Job was created [CLIENT].', 1545173199),
(503, 149, 32, 'Job was created [CLIENT].', 1545173261),
(504, 150, 32, 'Job was created [CLIENT].', 1545173393),
(505, 151, 32, 'Job was created [CLIENT].', 1545173571),
(506, 152, 32, 'Job was created [CLIENT].', 1545173637),
(507, 153, 5, 'Job was created [CLIENT].', 1545174026),
(508, 133, 1, 'Job status was changed to Installed', 1545183820),
(509, 133, 1, 'Replied to the job.', 1545183820),
(510, 154, 5, 'Job was created [CLIENT].', 1545188784),
(511, 132, 1, 'Job status was changed to Installed', 1545194264),
(512, 132, 1, 'Replied to the job.', 1545194267),
(513, 134, 1, 'Job status was changed to Installed', 1545194291),
(514, 134, 1, 'Replied to the job.', 1545194297),
(515, 138, 1, 'Job status was changed to Installed', 1545195713),
(516, 138, 1, 'Replied to the job.', 1545195717),
(517, 155, 32, 'Job was created [CLIENT].', 1545196896),
(518, 156, 32, 'Job was created [CLIENT].', 1545196980),
(519, 157, 5, 'Job was created [CLIENT].', 1545197857),
(520, 136, 1, 'Job status was changed to Installed', 1545199257),
(521, 136, 1, 'Replied to the job.', 1545199260),
(522, 137, 1, 'Job status was changed to Installed', 1545200899),
(523, 137, 1, 'Replied to the job.', 1545200902),
(524, 135, 1, 'Job status was changed to Installed', 1545201792),
(525, 135, 1, 'Replied to the job.', 1545201793),
(526, 154, 1, 'Job status was changed to In Progress', 1545256933),
(527, 157, 1, 'Job status was changed to In Progress', 1545256967),
(528, 144, 1, 'Job status was changed to In Progress', 1545256996),
(529, 143, 1, 'Job status was changed to In Progress', 1545257015),
(530, 142, 1, 'Job status was changed to In Progress', 1545257038),
(531, 139, 1, 'Job status was changed to In Progress', 1545257457),
(532, 141, 1, 'Job status was changed to In Progress', 1545257488),
(533, 140, 1, 'Job status was changed to In Progress', 1545257500),
(534, 153, 1, 'Job status was changed to Installed', 1545340127),
(535, 153, 1, 'Replied to the job.', 1545340129),
(536, 153, 1, 'Deleted a job file attachment.', 1545340151),
(537, 153, 1, 'Job status was changed to Installed', 1545340169),
(538, 153, 1, 'Replied to the job.', 1545340169),
(539, 140, 1, 'Job status was changed to Installed', 1545340209),
(540, 140, 1, 'Replied to the job.', 1545340211),
(541, 141, 1, 'Job status was changed to Installed', 1545342306),
(542, 141, 1, 'Replied to the job.', 1545342306),
(543, 151, 1, 'Job status was changed to Installed', 1545347202),
(544, 151, 1, 'Replied to the job.', 1545347205),
(545, 145, 1, 'Job status was changed to Removed', 1545347245),
(546, 145, 1, 'Replied to the job.', 1545347245),
(547, 147, 1, 'Job status was changed to Installed', 1545347996),
(548, 147, 1, 'Replied to the job.', 1545348002),
(549, 149, 1, 'Job status was changed to Installed', 1545349329),
(550, 149, 1, 'Replied to the job.', 1545349331),
(551, 142, 1, 'Job status was changed to Installed', 1545351392),
(552, 142, 1, 'Replied to the job.', 1545351392),
(553, 148, 1, 'Job status was changed to Installed', 1545352607),
(554, 148, 1, 'Replied to the job.', 1545352610),
(555, 158, 32, 'Job was created [CLIENT].', 1545354722),
(556, 150, 1, 'Job status was changed to Installed', 1545364108),
(557, 150, 1, 'Replied to the job.', 1545364109),
(558, 150, 1, 'Job status was changed to Installed', 1545364119),
(559, 150, 1, 'Replied to the job.', 1545364123),
(560, 158, 1, 'Job status was changed to Removed', 1546489736),
(561, 155, 1, 'Job status was changed to Removed', 1546489758),
(562, 152, 1, 'Job status was changed to Installed', 1546489774),
(563, 146, 1, 'Job status was changed to Removed', 1546489788),
(564, 157, 1, 'Job status was changed to Installed', 1546805884),
(565, 157, 1, 'Replied to the job.', 1546805923),
(566, 154, 1, 'Job status was changed to Installed', 1546805941),
(567, 154, 1, 'Replied to the job.', 1546805967),
(568, 144, 1, 'Job status was changed to Installed', 1546805985),
(569, 144, 1, 'Replied to the job.', 1546806005),
(570, 143, 1, 'Job status was changed to In Progress', 1546806037),
(571, 143, 1, 'Replied to the job.', 1546806054),
(572, 139, 1, 'Job status was changed to Completed', 1546806065),
(573, 159, 5, 'Job was created [CLIENT].', 1546806151),
(574, 143, 1, 'Job status was changed to Installed', 1546806195),
(575, 159, 1, 'Job status was changed to Installed', 1546806244),
(576, 159, 1, 'Replied to the job.', 1546806249),
(577, 160, 5, 'Job was created [CLIENT].', 1546818214),
(578, 160, 1, 'Job status was changed to In Progress', 1546826418),
(579, 161, 5, 'Job was created [CLIENT].', 1546905103),
(580, 161, 1, 'Job status was changed to In Progress', 1546908285),
(581, 162, 32, 'Job was created [CLIENT].', 1546908336),
(582, 163, 32, 'Job was created [CLIENT].', 1546908382),
(583, 164, 32, 'Job was created [CLIENT].', 1546908418),
(584, 165, 32, 'Job was created [CLIENT].', 1546908453),
(585, 166, 32, 'Job was created [CLIENT].', 1546908587),
(586, 167, 32, 'Job was created [CLIENT].', 1546908634),
(587, 168, 32, 'Job was created [CLIENT].', 1546908659),
(588, 169, 32, 'Job was created [CLIENT].', 1546908693),
(589, 170, 32, 'Job was created [CLIENT].', 1546908723),
(590, 171, 32, 'Job was created [CLIENT].', 1546908861),
(591, 172, 32, 'Job was created [CLIENT].', 1546908933),
(592, 173, 32, 'Job was created [CLIENT].', 1546908987),
(593, 174, 32, 'Job was created [CLIENT].', 1546909041),
(594, 175, 32, 'Job was created [CLIENT].', 1546909098),
(595, 176, 32, 'Job was created [CLIENT].', 1546909182),
(596, 177, 32, 'Job was created [CLIENT].', 1546909293),
(597, 178, 5, 'Job was created [CLIENT].', 1546988625),
(598, 173, 1, 'Job status was changed to Installed', 1546991319),
(599, 173, 1, 'Replied to the job.', 1546991322),
(600, 176, 1, 'Job status was changed to Installed', 1546991361),
(601, 176, 1, 'Replied to the job.', 1546991364),
(602, 168, 1, 'Job status was changed to Installed', 1546992156),
(603, 168, 1, 'Replied to the job.', 1546992158),
(604, 166, 1, 'Job status was changed to Installed', 1546992381),
(605, 166, 1, 'Replied to the job.', 1546992383),
(606, 167, 1, 'Job status was changed to Installed', 1546992419),
(607, 167, 1, 'Replied to the job.', 1546992419),
(608, 171, 1, 'Job status was changed to Installed', 1546995049),
(609, 171, 1, 'Replied to the job.', 1546995052),
(610, 175, 1, 'Job status was changed to Installed', 1546995398),
(611, 175, 1, 'Replied to the job.', 1546995399),
(612, 164, 1, 'Job status was changed to Removed', 1546995432),
(613, 164, 1, 'Replied to the job.', 1546995435),
(614, 175, 1, 'Job status was changed to Installed', 1546995790),
(615, 175, 1, 'Replied to the job.', 1546995792),
(616, 172, 1, 'Job status was changed to Installed', 1546998053),
(617, 172, 1, 'Replied to the job.', 1546998053),
(618, 174, 1, 'Job status was changed to Installed', 1547000735),
(619, 174, 1, 'Replied to the job.', 1547000740),
(620, 162, 1, 'Job status was changed to Removed', 1547001519),
(621, 165, 1, 'Job status was changed to Removed', 1547001639),
(622, 161, 1, 'Job status was changed to Installed', 1547094149),
(623, 161, 1, 'Replied to the job.', 1547094149),
(624, 177, 1, 'Job status was changed to Installed', 1547161588),
(625, 177, 1, 'Replied to the job.', 1547161591),
(626, 163, 1, 'Job status was changed to Removed', 1547162891),
(627, 163, 1, 'Replied to the job.', 1547162897),
(628, 160, 1, 'Job status was changed to Installed', 1547165626),
(629, 160, 1, 'Replied to the job.', 1547165629),
(630, 179, 5, 'Job was created [CLIENT].', 1547424966),
(631, 180, 5, 'Job was created [CLIENT].', 1547435649),
(632, 179, 1, 'Job status was changed to In Progress', 1547512924),
(633, 180, 1, 'Job status was changed to In Progress', 1547512931),
(634, 181, 5, 'Job was created [CLIENT].', 1547517658),
(635, 182, 32, 'Job was created [CLIENT].', 1547518255),
(636, 183, 32, 'Job was created [CLIENT].', 1547518294),
(637, 184, 32, 'Job was created [CLIENT].', 1547518344),
(638, 185, 32, 'Job was created [CLIENT].', 1547518432),
(639, 186, 32, 'Job was created [CLIENT].', 1547518471),
(640, 187, 32, 'Job was created [CLIENT].', 1547518515),
(641, 188, 32, 'Job was created [CLIENT].', 1547518551),
(642, 189, 32, 'Job was created [CLIENT].', 1547518629),
(643, 190, 32, 'Job was created [CLIENT].', 1547518704),
(644, 191, 1, 'Job was created [CLIENT].', 1547542283),
(645, 189, 1, 'Job status was changed to New', 1548006923),
(646, 189, 1, 'Replied to the job.', 1548006923),
(647, 183, 1, 'Administrator was assigned to job.', 1548035207),
(648, 192, 1, 'Job was created [CLIENT].', 1548197270),
(649, 193, 1, 'Job was created [CLIENT].', 1548197423),
(650, 197, 1, 'Job was created [ADMIN]', 1555972735),
(651, 198, 1, 'Job was created [ADMIN]', 1555973673),
(652, 199, 1, 'Job was created [ADMIN]', 1555973752),
(653, 200, 1, 'Job was created [ADMIN]', 1555976149),
(654, 201, 1, 'Job was created [ADMIN]', 1556080132),
(655, 202, 1, 'Job was created [ADMIN]', 1556125622),
(656, 203, 1, 'Job was created [ADMIN]', 1556125744),
(657, 204, 1, 'Job was created [ADMIN]', 1556125890),
(658, 205, 1, 'Job was created [ADMIN]', 1556126219),
(659, 206, 1, 'Job was created [ADMIN]', 1556126300),
(660, 207, 1, 'Job was created [ADMIN]', 1556126448),
(661, 208, 1, 'Job was created [ADMIN]', 1556126584),
(662, 209, 1, 'Job was created [ADMIN]', 1556145169),
(663, 211, 1, 'Job was created [ADMIN]', 1556145649),
(664, 211, 1, 'Job was modified in Edit area.', 1556149323),
(665, 197, 1, 'Job was modified in Edit area.', 1556149384),
(666, 197, 1, 'Job was modified in Edit area.', 1556149409),
(667, 197, 1, 'Job was modified in Edit area.', 1556149497),
(668, 197, 1, 'Job was modified in Edit area.', 1556149510),
(669, 197, 1, 'Job was modified in Edit area.', 1556149592),
(670, 197, 1, 'Job was modified in Edit area.', 1556149598),
(671, 197, 1, 'Job was modified in Edit area.', 1556149608),
(672, 197, 1, 'Job was modified in Edit area.', 1556149662),
(673, 197, 1, 'Job was modified in Edit area.', 1556149669),
(674, 197, 1, 'Job was modified in Edit area.', 1556149680),
(675, 197, 1, 'Job was modified in Edit area.', 1556149687),
(676, 197, 1, 'Job was modified in Edit area.', 1556149714),
(677, 197, 1, 'Job was modified in Edit area.', 1556149723),
(678, 197, 1, 'Job was modified in Edit area.', 1556149729),
(679, 211, 1, 'Job was modified in Edit area.', 1556150975);

-- --------------------------------------------------------

--
-- Table structure for table `job_replies`
--

CREATE TABLE IF NOT EXISTS `job_replies` (
`ID` int(11) NOT NULL,
  `jobid` int(11) NOT NULL,
  `userid` int(11) NOT NULL,
  `body` mediumtext COLLATE utf8_unicode_ci NOT NULL,
  `timestamp` int(11) NOT NULL,
  `replyid` int(11) NOT NULL,
  `files` int(11) NOT NULL,
  `hash` varchar(255) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=163 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

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
(43, 66, 1, '<p>&nbsp;Relocated as instructed to face Gympie Road</p>\r\n', 1541559682, 0, 1, 'c2d001c47ab99f3237a4d37ae177a616'),
(44, 82, 1, '<p>Installed</p>\r\n', 1542057590, 0, 1, '11a7518ad49fe5ff54a964ac966ce79e'),
(45, 84, 1, '<p>Installed</p>\r\n', 1542158518, 0, 1, '17b1cd0b9c4773e8bbc928011946eb32'),
(46, 85, 1, '', 1542268129, 0, 1, 'd28b54842d2553c84f94e2bcc3f7b0c6'),
(48, 86, 1, '<p>test installed</p>\r\n', 1542515708, 0, 0, 'a1762a9fd65bfc323de61e95d68579f6'),
(60, 88, 1, '<p>Installed</p>\r\n', 1542538165, 0, 1, '4ad16ca7a54c333f7978b07803dbff1c'),
(63, 88, 1, '<p>test</p>\r\n', 1542539138, 0, 1, '6196770e42100d0d7426b0825dd62099'),
(65, 88, 1, '', 1542539881, 0, 1, 'bebc5c794703ceb93cd5b992a0f570ae'),
(66, 88, 1, '<p>test</p>\r\n', 1542540196, 0, 1, '13604600bcac499aebf1c74c31f354a2'),
(76, 87, 1, '', 1542557896, 0, 1, '867a3124f16c690c8de317407be27bdb'),
(77, 87, 1, '', 1542558450, 0, 0, '5c87c402b5d9f33b4755e346a64085dd'),
(78, 87, 1, '', 1542558803, 0, 0, 'c784110f4b5d4772e8b2e9a51984647a'),
(79, 87, 1, '', 1542559085, 0, 1, '912baba4911ff5b59f8046dec1531674'),
(80, 88, 1, '', 1542576896, 0, 1, '907ee67d3b7d69d8d1cc43fec5a47514'),
(81, 88, 1, '', 1542577085, 0, 0, '74d5bd9fb166e6d4b594ceb719c6a601'),
(82, 88, 1, '', 1542577373, 0, 1, 'e13779c9f9b6c077aade0e9fa4fbe198'),
(83, 89, 1, '<p>test</p>\r\n', 1542582558, 0, 0, 'c2c4938c95d63f4097bdd44529dd7cd7'),
(84, 93, 1, '<p>test</p>\r\n', 1542604073, 0, 0, 'd75494f8989256a98554d5eecb154154'),
(85, 88, 1, '<p>test</p>\r\n', 1542666293, 0, 1, '42c45c936de64bcce9680df3651a0489'),
(86, 88, 1, '<p>test</p>\r\n', 1542667661, 0, 1, 'a1651a27fb930c178250d4a0fe6b3672'),
(87, 97, 1, '<p>test</p>\r\n', 1542668367, 0, 0, 'c6c0ea7318004eacb80a6016bc630073'),
(88, 96, 1, '<p>tet</p>\r\n', 1542685191, 0, 0, '8ff771d0364bbb6e26511c0d06ecca66'),
(89, 99, 1, '', 1542922456, 0, 1, '4fff691655c076e5ac05cabe55934dcc'),
(90, 98, 1, '', 1542922512, 0, 1, 'fdaa4b8ee934835b9a2b0e9baf314d79'),
(91, 71, 1, '', 1542929622, 0, 1, 'd31e2009f5a9fd33978c3b26468ac8f6'),
(92, 102, 1, '', 1543382348, 0, 1, '94636ded5839f21f2add4f61b6e4863f'),
(93, 101, 1, '', 1543442406, 0, 1, '6185ddf2ea3d1a579f76ef4c70e0e31e'),
(94, 100, 1, '<p>Installed</p>\r\n', 1543449931, 0, 1, '0e7b148acfecc63f1ac907572e50038a'),
(95, 103, 1, '', 1543472104, 0, 1, '952893ce8532e2b5879230d482062364'),
(96, 113, 1, '', 1543810913, 0, 1, '6af279b5385f57d6a2e0af29b4bcdf30'),
(97, 112, 1, '', 1543811669, 0, 1, 'c1b83e2dbd651211d50f79e5a46ecfbd'),
(98, 106, 1, '', 1543814695, 0, 1, 'fa45cb9fbea1cf3c629296ecc50b414a'),
(99, 104, 1, '', 1543815795, 0, 0, '352ee9ec3f0c5518044d1c534357ba42'),
(100, 107, 1, '', 1543818763, 0, 1, 'b599e883eff7006bb85057d7f6988398'),
(101, 114, 1, '', 1543818843, 0, 1, '320d27018c7c09a17c548228b482c91b'),
(102, 109, 1, '', 1543883542, 0, 1, '6962e0e0305f24a072b1126ede5ab809'),
(103, 116, 1, '', 1543889271, 0, 1, '53f5caf5fc1773d50f77502b0e45c3ba'),
(104, 115, 1, '', 1543889318, 0, 1, '494676f242a422892032e1226e2acf8a'),
(105, 108, 1, '', 1543904765, 0, 1, '92299e2b2e19c28d914bd409bf9039a1'),
(106, 110, 1, '', 1543906414, 0, 1, '1f66d592cebb5297b15e156a14f35cc9'),
(107, 111, 1, '', 1543908192, 0, 1, '7bd4fb3f2efd38d53b74ff0f4198e7b0'),
(108, 120, 1, '', 1543958812, 0, 1, 'debd1b79580bf0e23b2b4c3596fde59d'),
(109, 122, 1, '', 1543960151, 0, 1, 'a73ba3a7d9da0c5fe1ef3d5c29e7f420'),
(110, 119, 1, '', 1543969084, 0, 1, '9ac48e036e21d32b72030830b6a7146a'),
(111, 117, 1, '', 1543970245, 0, 1, '6efbd2407c9304ea85c65dd61ec6c50d'),
(112, 118, 1, '', 1543986452, 0, 1, 'e297b837387566da1ec2e633e9f48938'),
(113, 121, 1, '', 1543987399, 0, 1, '8995b6aa13452b31151929e8dc418687'),
(114, 124, 1, '', 1544226261, 0, 1, '717093bc82963e2689afe5161a5b54ca'),
(115, 127, 1, '', 1544226296, 0, 1, 'd36d10c08fe17f6c2e7cfe0e5cacbed2'),
(116, 128, 1, '', 1544226326, 0, 1, 'e95c7c7ba782c15f423648b473b202ab'),
(117, 130, 1, '', 1544226822, 0, 1, '3b85ea28311881e1fcf1d76870a8dd0a'),
(118, 129, 1, '', 1544227794, 0, 1, 'b995a52a8610fafe9061ca26185e6026'),
(119, 125, 1, '', 1544227855, 0, 1, '7fdfe86cfdce45b3e6de7d2bf4ea3ccf'),
(120, 126, 1, '', 1544230242, 0, 1, '98e8347f12e2a367601530f8d6de2a8d'),
(121, 123, 1, '', 1544395874, 0, 1, '83e81a6f412c94f11ec3ad3d799c7e55'),
(122, 131, 1, '', 1544472519, 0, 1, '6ae6d02a724b9dbe0a3048e9365d6093'),
(123, 133, 1, '', 1545183820, 0, 1, '437d1fa76f24716a8e4daa3403b10b69'),
(124, 132, 1, '', 1545194267, 0, 1, 'c2c4d01e322f1620791ccbe5fda2588f'),
(125, 134, 1, '', 1545194297, 0, 1, '6e99a093016528f1b832c9c41f29d378'),
(126, 138, 1, '', 1545195717, 0, 1, '0078ee0e23e99836db571127b488972e'),
(127, 136, 1, '', 1545199260, 0, 1, '7151fe8e552ad41b2aa61446fc199800'),
(128, 137, 1, '', 1545200902, 0, 1, '6b611c247e8630c4ceb66229b79d9fc2'),
(129, 135, 1, '', 1545201793, 0, 1, 'bd27c2001dc2818d2fb978ece41c132f'),
(130, 153, 1, '', 1545340129, 0, 1, '1e661bcd2acc72d17e6abc9785f53dc6'),
(131, 153, 1, '', 1545340169, 0, 1, '2a2d904877bf1047ec299d04da4b1414'),
(132, 140, 1, '', 1545340211, 0, 1, '25bd5105a001b38c0549f855813489ad'),
(133, 141, 1, '', 1545342306, 0, 1, 'ae503ee3505cbf11e4f8eb6efd0b3c48'),
(134, 151, 1, '', 1545347205, 0, 1, '54a85143e7b77917ca37910e21acf235'),
(135, 145, 1, '', 1545347245, 0, 1, 'b6fb6cf3ed4a47ec08df8fd18520e753'),
(136, 147, 1, '', 1545348002, 0, 1, '96b8755dfe473781605d6dcffd2deb37'),
(137, 149, 1, '', 1545349331, 0, 1, 'fb370bd5fd545c329e754e7b2a3a0000'),
(138, 142, 1, '', 1545351392, 0, 1, 'ef4da7cd7b1d977832003fdf59041a5f'),
(139, 148, 1, '', 1545352610, 0, 1, '797ffb10544b6441a0db13cbc039d68c'),
(140, 150, 1, '', 1545364109, 0, 1, '87cd31ad11ff0fa90dae31d4571aaee2'),
(141, 150, 1, '', 1545364123, 0, 1, '813fdca8517da7596cb50b4dd7da6741'),
(142, 157, 1, '<p>Installed</p>\r\n', 1546805923, 0, 1, '7e002b3058aa9777d764834475ad2aa6'),
(143, 154, 1, '<p>Installed</p>\r\n', 1546805967, 0, 1, '73a11750df07ee6c933fc6b8fa3bd1c2'),
(144, 144, 1, '<p>Installed</p>\r\n', 1546806005, 0, 1, '1abd7fcf41887ce176489a26332fa295'),
(145, 143, 1, '<p>Installed</p>\r\n', 1546806054, 0, 1, 'c97853b2c41144deaabb22e7802068c9'),
(146, 159, 1, '<p>Installed</p>\r\n', 1546806249, 0, 1, 'a8ea3fae060f5f177e9c976bb25919c7'),
(147, 173, 1, '', 1546991322, 0, 1, 'b1be63a52be293c812e6228f1179e42e'),
(148, 176, 1, '', 1546991364, 0, 1, 'aed9aca85f246b3517cdcc9d95b588cf'),
(149, 168, 1, '', 1546992158, 0, 1, '060b11626b5586f517c263d3fc0ae7ee'),
(150, 166, 1, '', 1546992383, 0, 1, '7b523e9ca75268e87fe4021aeb5bb151'),
(151, 167, 1, '', 1546992419, 0, 1, 'd058708df5e301ad89e2cd129382a37c'),
(152, 171, 1, '', 1546995052, 0, 1, '5844cd52df6e193d3d1492097942d0ce'),
(153, 175, 1, '', 1546995399, 0, 1, 'd4a5eadb4aab588fd05bfc975e147226'),
(154, 164, 1, '', 1546995435, 0, 1, 'd24c1c3fbbe9399b2455bc957d0636e4'),
(155, 175, 1, '', 1546995792, 0, 1, 'd0ea015f30ad2195be16b7a5473a65cc'),
(156, 172, 1, '', 1546998053, 0, 1, '7ff934ba0e2e400ae8920ff4a216db79'),
(157, 174, 1, '', 1547000740, 0, 1, '72a4e735cae90a1feea31c48bed31b4e'),
(158, 161, 1, '', 1547094149, 0, 1, '4e0dad12d9b3a090f1c8c89a8959fa16'),
(159, 177, 1, '', 1547161591, 0, 1, 'e90629b176023baf543d263728806582'),
(160, 163, 1, '', 1547162897, 0, 1, 'd282ab0565259590edde99f561e31abe'),
(161, 160, 1, '', 1547165629, 0, 1, 'e8e72528a875c9d222287c7791cba891'),
(162, 189, 1, '', 1548006923, 0, 0, '0a58940422ed583585f784153976bc28');

-- --------------------------------------------------------

--
-- Table structure for table `job_user_custom_fields`
--

CREATE TABLE IF NOT EXISTS `job_user_custom_fields` (
`ID` int(11) NOT NULL,
  `fieldid` int(11) NOT NULL,
  `jobid` int(11) NOT NULL,
  `value` mediumtext COLLATE utf8_unicode_ci NOT NULL,
  `itemname` varchar(500) COLLATE utf8_unicode_ci NOT NULL,
  `support` int(11) NOT NULL,
  `error` varchar(1000) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=1806 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

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
(699, 13, 81, '<p>Please remove signage.&nbsp;</p>\r\n', '', 0, ''),
(700, 2, 82, 'Office', '', 0, ''),
(701, 3, 82, 'Portrait', '', 0, ''),
(702, 4, 82, 'Stockboard', '', 0, ''),
(703, 5, 82, '1800x1200mm', '', 0, ''),
(704, 6, 82, '1', '', 0, ''),
(705, 7, 82, 'No', '', 0, ''),
(706, 8, 82, 'Lease', '', 0, ''),
(707, 10, 82, 'Hudson Dale 0423 591 529', '', 0, ''),
(708, 9, 82, ' NA', '', 0, ''),
(709, 15, 82, '', '', 0, ''),
(710, 16, 82, 'NA', '', 0, ''),
(711, 14, 82, 'Unit 1', '', 0, ''),
(712, 11, 82, '<p>Please place infornt of the hedge directly infront of &quot;Little Real Estate&quot; unit.</p>\r\n', '', 0, ''),
(713, 2, 83, 'Office', '', 0, ''),
(714, 3, 83, 'Portrait', '', 0, ''),
(715, 4, 83, 'Stockboard', '', 0, ''),
(716, 5, 83, '900x600mm', '', 0, ''),
(717, 6, 83, 'fdsa', '', 0, ''),
(718, 7, 83, 'No', '', 0, ''),
(719, 8, 83, 'Sale', '', 0, ''),
(720, 10, 83, 'Trent Bruce 0423 591 528', '', 0, ''),
(721, 9, 83, 'Trent Bruce 0423 591 528', '', 0, ''),
(722, 15, 83, '', '', 0, ''),
(723, 16, 83, 'NA', '', 0, ''),
(724, 14, 83, 'f', '', 0, ''),
(725, 11, 83, '<p>dsafdsa</p>\r\n', '', 0, ''),
(726, 2, 83, 'Retail', '', 0, ''),
(727, 3, 83, 'Portrait', '', 0, ''),
(728, 4, 83, 'Stockboard', '', 0, ''),
(729, 5, 83, '1800x1200mm', '', 0, ''),
(730, 6, 83, '1', '', 0, ''),
(731, 7, 83, 'No', '', 0, ''),
(732, 8, 83, 'Lease', '', 0, ''),
(733, 10, 83, 'David Kettle 0423 591 541', '', 0, ''),
(734, 9, 83, ' NA', '', 0, ''),
(735, 15, 83, '', '', 0, ''),
(736, 16, 83, 'NA', '', 0, ''),
(737, 14, 83, '', '', 0, ''),
(738, 11, 83, '<p>Please place signage to the right hand side of the stairs in the garden bed as per the diagram sent to you.</p>\r\n', '', 0, ''),
(739, 2, 84, 'Retail', '', 0, ''),
(740, 3, 84, 'Portrait', '', 0, ''),
(741, 4, 84, 'Stockboard', '', 0, ''),
(742, 5, 84, '1200x900mm', '', 0, ''),
(743, 6, 84, '1', '', 0, ''),
(744, 7, 84, 'No', '', 0, ''),
(745, 8, 84, 'Lease', '', 0, ''),
(746, 10, 84, 'David Kettle 0423 591 541', '', 0, ''),
(747, 9, 84, ' NA', '', 0, ''),
(748, 15, 84, '', '', 0, ''),
(749, 16, 84, 'NA', '', 0, ''),
(750, 14, 84, '', '', 0, ''),
(751, 11, 84, '<p>Please place as shown in picutre</p>\r\n', '', 0, ''),
(752, 2, 85, 'Office', '', 0, ''),
(753, 3, 85, 'Portrait', '', 0, ''),
(754, 4, 85, 'Stockboard', '', 0, ''),
(755, 5, 85, '900x600mm', '', 0, ''),
(756, 6, 85, '1', '', 0, ''),
(757, 7, 85, 'No', '', 0, ''),
(758, 8, 85, 'Sale', '', 0, ''),
(759, 10, 85, 'Trent Bruce 0423 591 528', '', 0, ''),
(760, 9, 85, 'Trent Bruce 0423 591 528', '', 0, ''),
(761, 15, 85, '', '', 0, ''),
(762, 16, 85, 'NA', '', 0, ''),
(763, 14, 85, '', '', 0, ''),
(764, 11, 85, '', '', 0, ''),
(765, 2, 86, 'Office', '', 0, ''),
(766, 3, 86, 'Portrait', '', 0, ''),
(767, 4, 86, 'Stockboard', '', 0, ''),
(768, 5, 86, '900x600mm', '', 0, ''),
(769, 6, 86, '1', '', 0, ''),
(770, 7, 86, 'No', '', 0, ''),
(771, 8, 86, 'Sale', '', 0, ''),
(772, 10, 86, 'Trent Bruce 0423 591 528', '', 0, ''),
(773, 9, 86, 'Trent Bruce 0423 591 528', '', 0, ''),
(774, 15, 86, '', '', 0, ''),
(775, 16, 86, 'NA', '', 0, ''),
(776, 14, 86, '', '', 0, ''),
(777, 11, 86, '', '', 0, ''),
(778, 2, 87, 'Office', '', 0, ''),
(779, 3, 87, 'Portrait', '', 0, ''),
(780, 4, 87, 'Stockboard', '', 0, ''),
(781, 5, 87, '900x600mm', '', 0, ''),
(782, 6, 87, '1', '', 0, ''),
(783, 7, 87, 'No', '', 0, ''),
(784, 8, 87, 'Sale', '', 0, ''),
(785, 10, 87, 'Trent Bruce 0423 591 528', '', 0, ''),
(786, 9, 87, 'Trent Bruce 0423 591 528', '', 0, ''),
(787, 15, 87, '', '', 0, ''),
(788, 16, 87, 'NA', '', 0, ''),
(789, 14, 87, '', '', 0, ''),
(790, 11, 87, '', '', 0, ''),
(791, 2, 88, 'Office', '', 0, ''),
(792, 3, 88, 'Portrait', '', 0, ''),
(793, 4, 88, 'Stockboard', '', 0, ''),
(794, 5, 88, '900x600mm', '', 0, ''),
(795, 6, 88, '1', '', 0, ''),
(796, 7, 88, 'No', '', 0, ''),
(797, 8, 88, 'Sale', '', 0, ''),
(798, 10, 88, 'Trent Bruce 0423 591 528', '', 0, ''),
(799, 9, 88, 'Trent Bruce 0423 591 528', '', 0, ''),
(800, 15, 88, '', '', 0, ''),
(801, 16, 88, 'NA', '', 0, ''),
(802, 14, 88, '', '', 0, ''),
(803, 11, 88, '', '', 0, ''),
(804, 2, 89, 'Office', '', 0, ''),
(805, 3, 89, 'Portrait', '', 0, ''),
(806, 4, 89, 'Stockboard', '', 0, ''),
(807, 5, 89, '900x600mm', '', 0, ''),
(808, 6, 89, '1', '', 0, ''),
(809, 7, 89, 'No', '', 0, ''),
(810, 8, 89, 'Sale', '', 0, ''),
(811, 10, 89, 'Trent Bruce 0423 591 528', '', 0, ''),
(812, 9, 89, 'Trent Bruce 0423 591 528', '', 0, ''),
(813, 15, 89, '', '', 0, ''),
(814, 16, 89, 'NA', '', 0, ''),
(815, 14, 89, '', '', 0, ''),
(816, 11, 89, '', '', 0, ''),
(817, 2, 90, 'Office', '', 0, ''),
(818, 3, 90, 'Portrait', '', 0, ''),
(819, 4, 90, 'Stockboard', '', 0, ''),
(820, 5, 90, '900x600mm', '', 0, ''),
(821, 6, 90, '1', '', 0, ''),
(822, 7, 90, 'No', '', 0, ''),
(823, 8, 90, 'Sale', '', 0, ''),
(824, 10, 90, 'Trent Bruce 0423 591 528', '', 0, ''),
(825, 9, 90, 'Trent Bruce 0423 591 528', '', 0, ''),
(826, 15, 90, '', '', 0, ''),
(827, 16, 90, 'NA', '', 0, ''),
(828, 14, 90, '', '', 0, ''),
(829, 11, 90, '', '', 0, ''),
(830, 2, 91, 'Office', '', 0, ''),
(831, 3, 91, 'Portrait', '', 0, ''),
(832, 4, 91, 'Stockboard', '', 0, ''),
(833, 5, 91, '900x600mm', '', 0, ''),
(834, 6, 91, '1', '', 0, ''),
(835, 7, 91, 'No', '', 0, ''),
(836, 8, 91, 'Sale', '', 0, ''),
(837, 10, 91, 'Trent Bruce 0423 591 528', '', 0, ''),
(838, 9, 91, 'Trent Bruce 0423 591 528', '', 0, ''),
(839, 15, 91, '', '', 0, ''),
(840, 16, 91, 'NA', '', 0, ''),
(841, 14, 91, '', '', 0, ''),
(842, 11, 91, '', '', 0, ''),
(843, 2, 92, 'Office', '', 0, ''),
(844, 3, 92, 'Portrait', '', 0, ''),
(845, 4, 92, 'Stockboard', '', 0, ''),
(846, 5, 92, '900x600mm', '', 0, ''),
(847, 6, 92, '1', '', 0, ''),
(848, 7, 92, 'No', '', 0, ''),
(849, 8, 92, 'Sale', '', 0, ''),
(850, 10, 92, 'Trent Bruce 0423 591 528', '', 0, ''),
(851, 9, 92, 'Trent Bruce 0423 591 528', '', 0, ''),
(852, 15, 92, '', '', 0, ''),
(853, 16, 92, 'NA', '', 0, ''),
(854, 14, 92, '', '', 0, ''),
(855, 11, 92, '', '', 0, ''),
(856, 2, 93, 'Office', '', 0, ''),
(857, 3, 93, 'Portrait', '', 0, ''),
(858, 4, 93, 'Stockboard', '', 0, ''),
(859, 5, 93, '900x600mm', '', 0, ''),
(860, 6, 93, '1', '', 0, ''),
(861, 7, 93, 'No', '', 0, ''),
(862, 8, 93, 'Sale', '', 0, ''),
(863, 10, 93, 'Trent Bruce 0423 591 528', '', 0, ''),
(864, 9, 93, 'Trent Bruce 0423 591 528', '', 0, ''),
(865, 15, 93, '', '', 0, ''),
(866, 16, 93, 'NA', '', 0, ''),
(867, 14, 93, '', '', 0, ''),
(868, 11, 93, '', '', 0, ''),
(869, 2, 94, 'Office', '', 0, ''),
(870, 3, 94, 'Portrait', '', 0, ''),
(871, 4, 94, 'Stockboard', '', 0, ''),
(872, 5, 94, '900x600mm', '', 0, ''),
(873, 6, 94, '1', '', 0, ''),
(874, 7, 94, 'No', '', 0, ''),
(875, 8, 94, 'Sale', '', 0, ''),
(876, 10, 94, 'Trent Bruce 0423 591 528', '', 0, ''),
(877, 9, 94, 'Trent Bruce 0423 591 528', '', 0, ''),
(878, 15, 94, '', '', 0, ''),
(879, 16, 94, 'NA', '', 0, ''),
(880, 14, 94, '', '', 0, ''),
(881, 11, 94, '', '', 0, ''),
(882, 2, 95, 'Office', '', 0, ''),
(883, 3, 95, 'Portrait', '', 0, ''),
(884, 4, 95, 'Stockboard', '', 0, ''),
(885, 5, 95, '900x600mm', '', 0, ''),
(886, 6, 95, '1', '', 0, ''),
(887, 7, 95, 'No', '', 0, ''),
(888, 8, 95, 'Sale', '', 0, ''),
(889, 10, 95, 'Trent Bruce 0423 591 528', '', 0, ''),
(890, 9, 95, 'Trent Bruce 0423 591 528', '', 0, ''),
(891, 15, 95, '', '', 0, ''),
(892, 16, 95, 'NA', '', 0, ''),
(893, 14, 95, '', '', 0, ''),
(894, 11, 95, '', '', 0, ''),
(895, 2, 96, 'Office', '', 0, ''),
(896, 3, 96, 'Portrait', '', 0, ''),
(897, 4, 96, 'Stockboard', '', 0, ''),
(898, 5, 96, '900x600mm', '', 0, ''),
(899, 6, 96, '1', '', 0, ''),
(900, 7, 96, 'No', '', 0, ''),
(901, 8, 96, 'Sale', '', 0, ''),
(902, 10, 96, 'Trent Bruce 0423 591 528', '', 0, ''),
(903, 9, 96, 'Trent Bruce 0423 591 528', '', 0, ''),
(904, 15, 96, '', '', 0, ''),
(905, 16, 96, 'NA', '', 0, ''),
(906, 14, 96, '', '', 0, ''),
(907, 11, 96, '', '', 0, ''),
(908, 2, 97, 'Office', '', 0, ''),
(909, 3, 97, 'Portrait', '', 0, ''),
(910, 4, 97, 'Stockboard', '', 0, ''),
(911, 5, 97, '900x600mm', '', 0, ''),
(912, 6, 97, '1', '', 0, ''),
(913, 7, 97, 'No', '', 0, ''),
(914, 8, 97, 'Sale', '', 0, ''),
(915, 10, 97, 'Trent Bruce 0423 591 528', '', 0, ''),
(916, 9, 97, 'Trent Bruce 0423 591 528', '', 0, ''),
(917, 15, 97, '', '', 0, ''),
(918, 16, 97, 'NA', '', 0, ''),
(919, 14, 97, '', '', 0, ''),
(920, 11, 97, '', '', 0, ''),
(921, 2, 98, 'Office', '', 0, ''),
(922, 3, 98, 'Portrait', '', 0, ''),
(923, 4, 98, 'Stockboard', '', 0, ''),
(924, 5, 98, '1800x1200mm', '', 0, ''),
(925, 6, 98, '1', '', 0, ''),
(926, 7, 98, 'No', '', 0, ''),
(927, 8, 98, 'Sale', '', 0, ''),
(928, 10, 98, 'David Kettle 0423 591 541', '', 0, ''),
(929, 9, 98, ' NA', '', 0, ''),
(930, 15, 98, '', '', 0, ''),
(931, 16, 98, 'NA', '', 0, ''),
(932, 14, 98, 'Exclusive Agent, 81sqm Fitted office space, Two car parks', '', 0, ''),
(933, 11, 98, '<p>Please place sign in the garden bed to the left of the stairs as shown in image sent to you. Please call David 0423 591 541 if you have any issues.</p>\r\n', '', 0, ''),
(934, 2, 99, 'Office', '', 0, ''),
(935, 3, 99, 'Portrait', '', 0, ''),
(936, 4, 99, 'Stockboard', '', 0, ''),
(937, 5, 99, '1800x1200mm', '', 0, ''),
(938, 6, 99, '2', '', 0, ''),
(939, 7, 99, 'Yes', '', 0, ''),
(940, 8, 99, 'Lease', '', 0, ''),
(941, 10, 99, 'David Miller 0423 591 111', '', 0, ''),
(942, 9, 99, 'Hudson Dale 0423 591 529', '', 0, ''),
(943, 15, 99, '', '', 0, ''),
(944, 16, 99, 'NA', '', 0, ''),
(945, 14, 99, '', '', 0, ''),
(946, 11, 99, '<p>Please place V-board on roof, to be clearly seen by traffic travelling in both directions on Stafford Rd. The owner has requested you ensure that the roof is not permeable to water after installation is complete.</p>\r\n', '', 0, ''),
(947, 2, 100, 'Office', '', 0, ''),
(948, 3, 100, 'Portrait', '', 0, ''),
(949, 4, 100, 'Stockboard', '', 0, ''),
(950, 5, 100, '1800x1200mm', '', 0, ''),
(951, 6, 100, '1', '', 0, ''),
(952, 7, 100, 'No', '', 0, ''),
(953, 8, 100, 'Lease', '', 0, ''),
(954, 10, 100, 'Vaughn Smart 0423 591 531', '', 0, ''),
(955, 9, 100, 'David Kettle 0423 591 541', '', 0, ''),
(956, 15, 100, '', '', 0, ''),
(957, 16, 100, 'NA', '', 0, ''),
(958, 14, 100, 'Exclusive Agent', '', 0, ''),
(959, 11, 100, '<p>Please install sigange in the garden bed. Please ensure sign is installed facing towards direction of traffic on petrie terrace.</p>\r\n', '', 0, ''),
(960, 2, 101, 'Retail', '', 0, ''),
(961, 3, 101, 'Portrait', '', 0, ''),
(962, 4, 101, 'Stockboard', '', 0, ''),
(963, 5, 101, '1800x1200mm', '', 0, ''),
(964, 6, 101, '2', '', 0, ''),
(965, 7, 101, 'Yes', '', 0, ''),
(966, 8, 101, 'Lease', '', 0, ''),
(967, 10, 101, 'Trent Bruce 0423 591 528', '', 0, ''),
(968, 9, 101, 'Hudson Dale 0423 591 529', '', 0, ''),
(969, 15, 101, '', '', 0, ''),
(970, 16, 101, 'NA', '', 0, ''),
(971, 14, 101, '', '', 0, ''),
(972, 11, 101, '<p>Please install in a V board at the end of the property towards the northern end of the complex - in line with Weight Watchers tenancy. To be visable by both north &amp; southbound traffic</p>\r\n', '', 0, ''),
(973, 2, 102, 'Retail', '', 0, ''),
(974, 3, 102, 'Portrait', '', 0, ''),
(975, 4, 102, 'Stockboard', '', 0, ''),
(976, 5, 102, '1800x1200mm', '', 0, ''),
(977, 6, 102, '1', '', 0, ''),
(978, 7, 102, 'No', '', 0, ''),
(979, 8, 102, 'Lease', '', 0, ''),
(980, 10, 102, 'Vaughn Smart 0423 591 531', '', 0, ''),
(981, 9, 102, 'David Kettle 0423 591 541', '', 0, ''),
(982, 15, 102, '', '', 0, ''),
(983, 16, 102, 'NA', '', 0, ''),
(984, 14, 102, '', '', 0, ''),
(985, 11, 102, '<p>Please place on the awning on the end of the builidng as per the diagram</p>\r\n', '', 0, ''),
(986, 12, 103, 'Other', '', 0, ''),
(987, 13, 103, '<p>Someone has pulled our sign down at the above address &amp; it is now laying beside the building as per the attached image.</p>\r\n\r\n<p>We are thinking one of the current tenants may have possibly pulled it out.</p>\r\n\r\n<p>Can we please have it re-erected but in the location as per attached this time?</p>\r\n', '', 0, ''),
(988, 12, 104, 'Other', '', 0, ''),
(989, 13, 104, '<p>The banner we have installed at the above address has blown down. The owner advised that the cable tie has snapped and an eyelet possibly pulled out.</p>\r\n\r\n<p>They have asked if it could be re-attached more securely than last time as they said it wasn&amp;rsquo;t very well installed.</p>\r\n', '', 0, ''),
(990, 13, 105, '', '', 0, ''),
(991, 2, 106, 'Office', '', 0, ''),
(992, 3, 106, 'Portrait', '', 0, ''),
(993, 4, 106, 'Stockboard', '', 0, ''),
(994, 5, 106, '1800x1200mm', '', 0, ''),
(995, 6, 106, '1', '', 0, ''),
(996, 7, 106, 'No', '', 0, ''),
(997, 8, 106, 'Lease', '', 0, ''),
(998, 10, 106, 'David Miller 0423 591 111', '', 0, ''),
(999, 9, 106, 'Hudson Dale 0423 591 529', '', 0, ''),
(1000, 15, 106, '', '', 0, ''),
(1001, 16, 106, 'NA', '', 0, ''),
(1002, 14, 106, '', '', 0, ''),
(1003, 11, 106, '<p>Please install signage as per the diagram</p>\r\n', '', 0, ''),
(1004, 2, 107, 'Industrial', '', 0, ''),
(1005, 3, 107, 'Portrait', '', 0, ''),
(1006, 4, 107, 'Stockboard', '', 0, ''),
(1007, 5, 107, '1800x1200mm', '', 0, ''),
(1008, 6, 107, '1', '', 0, ''),
(1009, 7, 107, 'No', '', 0, ''),
(1010, 8, 107, 'Lease', '', 0, ''),
(1011, 10, 107, 'Vaughn Smart 0423 591 531', '', 0, ''),
(1012, 9, 107, 'Brandon Mertz 0423 591 533', '', 0, ''),
(1013, 15, 107, '', '', 0, ''),
(1014, 16, 107, 'NA', '', 0, ''),
(1015, 14, 107, '', '', 0, ''),
(1016, 11, 107, '<p>Please install to the right of the driveway as shown</p>\r\n', '', 0, ''),
(1017, 2, 108, 'Retail', '', 0, ''),
(1018, 3, 108, 'Portrait', '', 0, ''),
(1019, 4, 108, 'Stockboard', '', 0, ''),
(1020, 5, 108, '1800x1200mm', '', 0, ''),
(1021, 6, 108, '1', '', 0, ''),
(1022, 7, 108, 'No', '', 0, ''),
(1023, 8, 108, 'Lease', '', 0, ''),
(1024, 10, 108, 'Michael Schafferius 0423 591 540', '', 0, ''),
(1025, 9, 108, ' NA', '', 0, ''),
(1026, 15, 108, '', '', 0, ''),
(1027, 16, 108, 'NA', '', 0, ''),
(1028, 14, 108, '', '', 0, ''),
(1029, 11, 108, '<p>Please place signage to the right hand side of the driveway facing Anzac Avenue as per the diagram</p>\r\n', '', 0, ''),
(1030, 2, 109, 'Industrial', '', 0, ''),
(1031, 3, 109, 'Portrait', '', 0, ''),
(1032, 4, 109, 'Stockboard', '', 0, ''),
(1033, 5, 109, '1800x1200mm', '', 0, ''),
(1034, 6, 109, '1', '', 0, ''),
(1035, 7, 109, 'No', '', 0, ''),
(1036, 8, 109, 'Lease', '', 0, ''),
(1037, 10, 109, 'Michael Schafferius 0423 591 540', '', 0, ''),
(1038, 9, 109, 'Lawrence Temple 0423 591 534', '', 0, ''),
(1039, 15, 109, '', '', 0, ''),
(1040, 16, 109, 'NA', '', 0, ''),
(1041, 14, 109, '', '', 0, ''),
(1042, 11, 109, '<p>Please place signage facing Filmer Street to the left hand side of the driveway. Do not attach to the fence</p>\r\n', '', 0, ''),
(1043, 2, 110, 'Retail', '', 0, ''),
(1044, 3, 110, 'Portrait', '', 0, ''),
(1045, 4, 110, 'Stockboard', '', 0, ''),
(1046, 5, 110, '1800x1200mm', '', 0, ''),
(1047, 6, 110, '1', '', 0, ''),
(1048, 7, 110, 'No', '', 0, ''),
(1049, 8, 110, 'Lease', '', 0, ''),
(1050, 10, 110, 'Michael Schafferius 0423 591 540', '', 0, ''),
(1051, 9, 110, ' NA', '', 0, ''),
(1052, 15, 110, '', '', 0, ''),
(1053, 16, 110, 'NA', '', 0, ''),
(1054, 14, 110, '', '', 0, ''),
(1055, 11, 110, '<p>Please place signage in the far left corner facing Gympie Road, in garden bed.</p>\r\n', '', 0, ''),
(1056, 2, 111, 'Retail', '', 0, ''),
(1057, 3, 111, 'Portrait', '', 0, ''),
(1058, 4, 111, 'Stockboard', '', 0, ''),
(1059, 5, 111, '1800x1200mm', '', 0, ''),
(1060, 6, 111, '1', '', 0, ''),
(1061, 7, 111, 'No', '', 0, ''),
(1062, 8, 111, 'Lease', '', 0, ''),
(1063, 10, 111, 'Lawrence Temple 0423 591 534', '', 0, ''),
(1064, 9, 111, ' NA', '', 0, ''),
(1065, 15, 111, '', '', 0, ''),
(1066, 16, 111, 'NA', '', 0, ''),
(1067, 14, 111, 'Exclusive Agent', '', 0, ''),
(1068, 11, 111, '<p>Please place sign on the right hand side of the building as shown in image sent to you.</p>\r\n', '', 0, ''),
(1069, 2, 112, 'Office', '', 0, ''),
(1070, 3, 112, 'Portrait', '', 0, ''),
(1071, 4, 112, 'Stockboard', '', 0, ''),
(1072, 5, 112, '1800x1200mm', '', 0, ''),
(1073, 6, 112, '1', '', 0, ''),
(1074, 7, 112, 'No', '', 0, ''),
(1075, 8, 112, 'Sale/Lease', '', 0, ''),
(1076, 10, 112, 'Lawrence Temple 0423 591 534', '', 0, ''),
(1077, 9, 112, 'Michael Schafferius 0423 591 540', '', 0, ''),
(1078, 15, 112, '', '', 0, ''),
(1079, 16, 112, 'NA', '', 0, ''),
(1080, 14, 112, 'Exclusive Agent, Multiple Units', '', 0, ''),
(1081, 11, 112, '<p>Please place board on the left hand side of the driveway, angled facing the left as shown in image sent to you.</p>\r\n', '', 0, ''),
(1082, 2, 113, 'Industrial', '', 0, ''),
(1083, 3, 113, 'Portrait', '', 0, ''),
(1084, 4, 113, 'Stockboard', '', 0, ''),
(1085, 5, 113, '1800x1200mm', '', 0, ''),
(1086, 6, 113, '1', '', 0, ''),
(1087, 7, 113, 'No', '', 0, ''),
(1088, 8, 113, 'Sale', '', 0, ''),
(1089, 10, 113, 'Lawrence Temple 0423 591 534', '', 0, ''),
(1090, 9, 113, ' NA', '', 0, ''),
(1091, 15, 113, '', '', 0, ''),
(1092, 16, 113, 'NA', '', 0, ''),
(1093, 14, 113, 'Exclusive Agent', '', 0, ''),
(1094, 11, 113, '<p>Please place sign on the right hand side of the driveway.</p>\r\n', '', 0, ''),
(1095, 2, 114, 'Office', '', 0, ''),
(1096, 3, 114, 'Portrait', '', 0, ''),
(1097, 4, 114, 'Stockboard', '', 0, ''),
(1098, 5, 114, '1800x1200mm', '', 0, ''),
(1099, 6, 114, '1', '', 0, ''),
(1100, 7, 114, 'No', '', 0, ''),
(1101, 8, 114, 'Lease', '', 0, ''),
(1102, 10, 114, 'James Doyle 0423 591 530', '', 0, ''),
(1103, 9, 114, 'Lawrence Temple 0423 591 534', '', 0, ''),
(1104, 15, 114, '', '', 0, ''),
(1105, 16, 114, 'NA', '', 0, ''),
(1106, 14, 114, 'Exclusive Agent', '', 0, ''),
(1107, 11, 114, '<p>Please place sign on the right hand side of the driveway, directly facing the road.</p>\r\n', '', 0, ''),
(1108, 2, 115, 'Industrial', '', 0, ''),
(1109, 3, 115, 'Portrait', '', 0, ''),
(1110, 4, 115, 'Stockboard', '', 0, ''),
(1111, 5, 115, '1800x1200mm', '', 0, ''),
(1112, 6, 115, '1', '', 0, ''),
(1113, 7, 115, 'No', '', 0, ''),
(1114, 8, 115, 'Sale', '', 0, ''),
(1115, 10, 115, 'Michael Schafferius 0423 591 540', '', 0, ''),
(1116, 9, 115, 'Lawrence Temple 0423 591 534', '', 0, ''),
(1117, 15, 115, '', '', 0, ''),
(1118, 16, 115, 'NA', '', 0, ''),
(1119, 14, 115, '', '', 0, ''),
(1120, 11, 115, '<p>Please place sign on the left hand side of the driveway. Please do not attach to the fence.</p>\r\n', '', 0, ''),
(1121, 2, 116, 'Industrial', '', 0, ''),
(1122, 3, 116, 'Portrait', '', 0, ''),
(1123, 4, 116, 'Stockboard', '', 0, ''),
(1124, 5, 116, '1800x1200mm', '', 0, ''),
(1125, 6, 116, '1', '', 0, ''),
(1126, 7, 116, 'No', '', 0, ''),
(1127, 8, 116, 'Lease', '', 0, ''),
(1128, 10, 116, 'Michael Schafferius 0423 591 540', '', 0, ''),
(1129, 9, 116, 'Lawrence Temple 0423 591 534', '', 0, ''),
(1130, 15, 116, '', '', 0, ''),
(1131, 16, 116, 'NA', '', 0, ''),
(1132, 14, 116, '', '', 0, ''),
(1133, 11, 116, '<p>Please place sign to the right hand side of the drive way. Please do not attach to the fence.</p>\r\n', '', 0, ''),
(1134, 2, 117, 'Office', '', 0, ''),
(1135, 3, 117, 'Portrait', '', 0, ''),
(1136, 4, 117, 'Stockboard', '', 0, ''),
(1137, 5, 117, '1800x1200mm', '', 0, ''),
(1138, 6, 117, '1', '', 0, ''),
(1139, 7, 117, 'No', '', 0, ''),
(1140, 8, 117, 'Lease', '', 0, ''),
(1141, 10, 117, 'Lawrence Temple 0423 591 534', '', 0, ''),
(1142, 9, 117, 'James Doyle 0423 591 530', '', 0, ''),
(1143, 15, 117, '', '', 0, ''),
(1144, 16, 117, 'NA', '', 0, ''),
(1145, 14, 117, '', '', 0, ''),
(1146, 11, 117, '<p>Please place sign in the garden bed in front of the building as shown in image sent to you.</p>\r\n', '', 0, ''),
(1147, 2, 118, 'Industrial', '', 0, ''),
(1148, 3, 118, 'Portrait', '', 0, ''),
(1149, 4, 118, 'Stockboard', '', 0, ''),
(1150, 5, 118, '1800x1200mm', '', 0, ''),
(1151, 6, 118, '1', '', 0, ''),
(1152, 7, 118, 'No', '', 0, ''),
(1153, 8, 118, 'Sale', '', 0, ''),
(1154, 10, 118, 'Lawrence Temple 0423 591 534', '', 0, ''),
(1155, 9, 118, ' NA', '', 0, ''),
(1156, 15, 118, '', '', 0, ''),
(1157, 16, 118, 'NA', '', 0, ''),
(1158, 14, 118, 'UNDER OFFER', '', 0, ''),
(1159, 11, 118, '<p>Please place sign on the right hand side of the driveway as shown in image sent to you.</p>\r\n', '', 0, ''),
(1160, 2, 119, 'Industrial', '', 0, ''),
(1161, 3, 119, 'Portrait', '', 0, ''),
(1162, 4, 119, 'Stockboard', '', 0, ''),
(1163, 5, 119, '1800x1200mm', '', 0, ''),
(1164, 6, 119, '1', '', 0, ''),
(1165, 7, 119, 'No', '', 0, '');
INSERT INTO `job_user_custom_fields` (`ID`, `fieldid`, `jobid`, `value`, `itemname`, `support`, `error`) VALUES
(1166, 8, 119, 'Lease', '', 0, ''),
(1167, 10, 119, 'Lawrence Temple 0423 591 534', '', 0, ''),
(1168, 9, 119, ' NA', '', 0, ''),
(1169, 15, 119, '', '', 0, ''),
(1170, 16, 119, 'NA', '', 0, ''),
(1171, 14, 119, '', '', 0, ''),
(1172, 11, 119, '<p>Please place sign on the left hand side of the driveway as shown in image sent to you.</p>\r\n', '', 0, ''),
(1173, 12, 120, 'Other', '', 0, ''),
(1174, 13, 120, '<p>Re-errect Please</p>\r\n', '', 0, ''),
(1175, 2, 121, 'Industrial', '', 0, ''),
(1176, 3, 121, 'Portrait', '', 0, ''),
(1177, 4, 121, 'Stockboard', '', 0, ''),
(1178, 5, 121, '1800x1200mm', '', 0, ''),
(1179, 6, 121, '1', '', 0, ''),
(1180, 7, 121, 'No', '', 0, ''),
(1181, 8, 121, 'Sale', '', 0, ''),
(1182, 10, 121, 'Lawrence Temple 0423 591 534', '', 0, ''),
(1183, 9, 121, ' NA', '', 0, ''),
(1184, 15, 121, '', '', 0, ''),
(1185, 16, 121, 'NA', '', 0, ''),
(1186, 14, 121, 'Exclusive Agent', '', 0, ''),
(1187, 11, 121, '<p>Please place sign on the left hand side of the driveway as shown in image to you.</p>\r\n', '', 0, ''),
(1188, 13, 122, '<p>Please remove</p>\r\n', '', 0, ''),
(1189, 12, 123, 'Other', '', 0, ''),
(1190, 13, 123, '<p>We have a board installed at the address that the brace has become un-attached. Please re-errect</p>\r\n\r\n<p>Thanks</p>\r\n', '', 0, ''),
(1191, 2, 124, 'Residential', '', 0, ''),
(1192, 3, 124, 'Portrait', '', 0, ''),
(1193, 4, 124, 'Stockboard', '', 0, ''),
(1194, 5, 124, '1200x900mm', '', 0, ''),
(1195, 6, 124, '1', '', 0, ''),
(1196, 7, 124, 'No', '', 0, ''),
(1197, 8, 124, 'Lease', '', 0, ''),
(1198, 10, 124, 'Trent Bruce 0423 591 528', '', 0, ''),
(1199, 9, 124, 'Trent Bruce 0423 591 528', '', 0, ''),
(1200, 15, 124, '', '', 0, ''),
(1201, 16, 124, 'NA', '', 0, ''),
(1202, 14, 124, '', '', 0, ''),
(1203, 11, 124, '<p>Standard Installation</p>\r\n', '', 0, ''),
(1204, 2, 125, 'Residential', '', 0, ''),
(1205, 3, 125, 'Portrait', '', 0, ''),
(1206, 4, 125, 'Stockboard', '', 0, ''),
(1207, 5, 125, '1200x900mm', '', 0, ''),
(1208, 6, 125, '1', '', 0, ''),
(1209, 7, 125, 'No', '', 0, ''),
(1210, 8, 125, 'Lease', '', 0, ''),
(1211, 10, 125, 'Trent Bruce 0423 591 528', '', 0, ''),
(1212, 9, 125, 'Trent Bruce 0423 591 528', '', 0, ''),
(1213, 15, 125, '', '', 0, ''),
(1214, 16, 125, 'NA', '', 0, ''),
(1215, 14, 125, '', '', 0, ''),
(1216, 11, 125, '<p>Standard Installation</p>\r\n', '', 0, ''),
(1217, 2, 126, 'Residential', '', 0, ''),
(1218, 3, 126, 'Portrait', '', 0, ''),
(1219, 4, 126, 'Stockboard', '', 0, ''),
(1220, 5, 126, '1200x900mm', '', 0, ''),
(1221, 6, 126, '1', '', 0, ''),
(1222, 7, 126, 'No', '', 0, ''),
(1223, 8, 126, 'Lease', '', 0, ''),
(1224, 10, 126, 'Trent Bruce 0423 591 528', '', 0, ''),
(1225, 9, 126, 'Trent Bruce 0423 591 528', '', 0, ''),
(1226, 15, 126, '', '', 0, ''),
(1227, 16, 126, 'NA', '', 0, ''),
(1228, 14, 126, '', '', 0, ''),
(1229, 11, 126, '<p>Standard Installation</p>\r\n', '', 0, ''),
(1230, 2, 127, 'Residential', '', 0, ''),
(1231, 3, 127, 'Portrait', '', 0, ''),
(1232, 4, 127, 'Stockboard', '', 0, ''),
(1233, 5, 127, '1200x900mm', '', 0, ''),
(1234, 6, 127, '1', '', 0, ''),
(1235, 7, 127, 'No', '', 0, ''),
(1236, 8, 127, 'Lease', '', 0, ''),
(1237, 10, 127, 'Trent Bruce 0423 591 528', '', 0, ''),
(1238, 9, 127, 'Trent Bruce 0423 591 528', '', 0, ''),
(1239, 15, 127, '', '', 0, ''),
(1240, 16, 127, 'NA', '', 0, ''),
(1241, 14, 127, '', '', 0, ''),
(1242, 11, 127, '<p>Standard Installation</p>\r\n', '', 0, ''),
(1243, 2, 128, 'Residential', '', 0, ''),
(1244, 3, 128, 'Portrait', '', 0, ''),
(1245, 4, 128, 'Stockboard', '', 0, ''),
(1246, 5, 128, '1200x900mm', '', 0, ''),
(1247, 6, 128, '1', '', 0, ''),
(1248, 7, 128, 'No', '', 0, ''),
(1249, 8, 128, 'Lease', '', 0, ''),
(1250, 10, 128, 'Trent Bruce 0423 591 528', '', 0, ''),
(1251, 9, 128, 'Trent Bruce 0423 591 528', '', 0, ''),
(1252, 15, 128, '', '', 0, ''),
(1253, 16, 128, 'NA', '', 0, ''),
(1254, 14, 128, '', '', 0, ''),
(1255, 11, 128, '<p>Standard Installation</p>\r\n', '', 0, ''),
(1256, 2, 129, 'Residential', '', 0, ''),
(1257, 3, 129, 'Portrait', '', 0, ''),
(1258, 4, 129, 'Stockboard', '', 0, ''),
(1259, 5, 129, '1200x900mm', '', 0, ''),
(1260, 6, 129, '1', '', 0, ''),
(1261, 7, 129, 'No', '', 0, ''),
(1262, 8, 129, 'Lease', '', 0, ''),
(1263, 10, 129, 'Trent Bruce 0423 591 528', '', 0, ''),
(1264, 9, 129, 'Trent Bruce 0423 591 528', '', 0, ''),
(1265, 15, 129, '', '', 0, ''),
(1266, 16, 129, 'NA', '', 0, ''),
(1267, 14, 129, '', '', 0, ''),
(1268, 11, 129, '<p>Standard Installation</p>\r\n', '', 0, ''),
(1269, 2, 130, 'Residential', '', 0, ''),
(1270, 3, 130, 'Portrait', '', 0, ''),
(1271, 4, 130, 'Stockboard', '', 0, ''),
(1272, 5, 130, '1200x900mm', '', 0, ''),
(1273, 6, 130, '1', '', 0, ''),
(1274, 7, 130, 'No', '', 0, ''),
(1275, 8, 130, 'Lease', '', 0, ''),
(1276, 10, 130, 'Trent Bruce 0423 591 528', '', 0, ''),
(1277, 9, 130, 'Trent Bruce 0423 591 528', '', 0, ''),
(1278, 15, 130, '', '', 0, ''),
(1279, 16, 130, 'NA', '', 0, ''),
(1280, 14, 130, '', '', 0, ''),
(1281, 11, 130, '<p>Standard Installation</p>\r\n', '', 0, ''),
(1282, 2, 131, 'Office', '', 0, ''),
(1283, 3, 131, 'Portrait', '', 0, ''),
(1284, 4, 131, 'Stockboard', '', 0, ''),
(1285, 5, 131, '1800x1200mm', '', 0, ''),
(1286, 6, 131, '1', '', 0, ''),
(1287, 7, 131, 'No', '', 0, ''),
(1288, 8, 131, 'Sale', '', 0, ''),
(1289, 10, 131, 'Lawrence Temple 0423 591 534', '', 0, ''),
(1290, 9, 131, 'James Doyle 0423 591 530', '', 0, ''),
(1291, 15, 131, '', '', 0, ''),
(1292, 16, 131, 'NA', '', 0, ''),
(1293, 14, 131, 'Unit 7, Investment', '', 0, ''),
(1294, 11, 131, '<p>Please place sign on the right hand side of the driveway.</p>\r\n', '', 0, ''),
(1295, 2, 132, 'Industrial', '', 0, ''),
(1296, 3, 132, 'Portrait', '', 0, ''),
(1297, 4, 132, 'Stockboard', '', 0, ''),
(1298, 5, 132, '1800x1200mm', '', 0, ''),
(1299, 6, 132, '1', '', 0, ''),
(1300, 7, 132, 'No', '', 0, ''),
(1301, 8, 132, 'Lease', '', 0, ''),
(1302, 10, 132, 'James Doyle 0423 591 530', '', 0, ''),
(1303, 9, 132, 'Lawrence Temple 0423 591 534', '', 0, ''),
(1304, 15, 132, '', '', 0, ''),
(1305, 16, 132, 'NA', '', 0, ''),
(1306, 14, 132, '', '', 0, ''),
(1307, 11, 132, '<p>Please place sign on the right hand side of the driveway in garden bed.</p>\r\n', '', 0, ''),
(1308, 2, 133, 'Office', '', 0, ''),
(1309, 3, 133, 'Portrait', '', 0, ''),
(1310, 4, 133, 'Stockboard', '', 0, ''),
(1311, 5, 133, '1800x1200mm', '', 0, ''),
(1312, 6, 133, '1', '', 0, ''),
(1313, 7, 133, 'No', '', 0, ''),
(1314, 8, 133, 'Lease', '', 0, ''),
(1315, 10, 133, 'David Kettle 0423 591 541', '', 0, ''),
(1316, 9, 133, ' NA', '', 0, ''),
(1317, 15, 133, '', '', 0, ''),
(1318, 16, 133, 'NA', '', 0, ''),
(1319, 14, 133, '', '', 0, ''),
(1320, 11, 133, '<p>Please place sign on roof as shown in image sent to you. Please make sure David&#39;s name plate is not placed too low on the bottom of the sign, need to ensure passing traffic can see the name plate.</p>\r\n', '', 0, ''),
(1321, 2, 134, 'Industrial', '', 0, ''),
(1322, 3, 134, 'Portrait', '', 0, ''),
(1323, 4, 134, 'Stockboard', '', 0, ''),
(1324, 5, 134, '1800x1200mm', '', 0, ''),
(1325, 6, 134, '1', '', 0, ''),
(1326, 7, 134, 'No', '', 0, ''),
(1327, 8, 134, 'Lease', '', 0, ''),
(1328, 10, 134, 'Lawrence Temple 0423 591 534', '', 0, ''),
(1329, 9, 134, ' NA', '', 0, ''),
(1330, 15, 134, '', '', 0, ''),
(1331, 16, 134, 'NA', '', 0, ''),
(1332, 14, 134, '', '', 0, ''),
(1333, 11, 134, '<p>Please place on the left hand side of the driveway as shown in image sent to you. Please remove Sale Board that is currently on site.</p>\r\n', '', 0, ''),
(1334, 2, 135, 'Residential', '', 0, ''),
(1335, 3, 135, 'Portrait', '', 0, ''),
(1336, 4, 135, 'Stockboard', '', 0, ''),
(1337, 5, 135, '1200x900mm', '', 0, ''),
(1338, 6, 135, '1', '', 0, ''),
(1339, 7, 135, 'No', '', 0, ''),
(1340, 8, 135, 'Lease', '', 0, ''),
(1341, 10, 135, 'Trent Bruce 0423 591 528', '', 0, ''),
(1342, 9, 135, 'Trent Bruce 0423 591 528', '', 0, ''),
(1343, 15, 135, '', '', 0, ''),
(1344, 16, 135, 'NA', '', 0, ''),
(1345, 14, 135, '', '', 0, ''),
(1346, 11, 135, '<p>Standard Installation</p>\r\n', '', 0, ''),
(1347, 2, 136, 'Residential', '', 0, ''),
(1348, 3, 136, 'Portrait', '', 0, ''),
(1349, 4, 136, 'Stockboard', '', 0, ''),
(1350, 5, 136, '1200x900mm', '', 0, ''),
(1351, 6, 136, '1', '', 0, ''),
(1352, 7, 136, 'No', '', 0, ''),
(1353, 8, 136, 'Lease', '', 0, ''),
(1354, 10, 136, 'Trent Bruce 0423 591 528', '', 0, ''),
(1355, 9, 136, 'Trent Bruce 0423 591 528', '', 0, ''),
(1356, 15, 136, '', '', 0, ''),
(1357, 16, 136, 'NA', '', 0, ''),
(1358, 14, 136, '', '', 0, ''),
(1359, 11, 136, '<p>Standard Installation</p>\r\n', '', 0, ''),
(1360, 2, 137, 'Residential', '', 0, ''),
(1361, 3, 137, 'Portrait', '', 0, ''),
(1362, 4, 137, 'Stockboard', '', 0, ''),
(1363, 5, 137, '1200x900mm', '', 0, ''),
(1364, 6, 137, '1', '', 0, ''),
(1365, 7, 137, 'No', '', 0, ''),
(1366, 8, 137, 'Lease', '', 0, ''),
(1367, 10, 137, 'Trent Bruce 0423 591 528', '', 0, ''),
(1368, 9, 137, 'Trent Bruce 0423 591 528', '', 0, ''),
(1369, 15, 137, '', '', 0, ''),
(1370, 16, 137, 'NA', '', 0, ''),
(1371, 14, 137, '', '', 0, ''),
(1372, 11, 137, '<p>Standard Installation</p>\r\n', '', 0, ''),
(1373, 2, 138, 'Industrial', '', 0, ''),
(1374, 3, 138, 'Portrait', '', 0, ''),
(1375, 4, 138, 'Stockboard', '', 0, ''),
(1376, 5, 138, '1800x1200mm', '', 0, ''),
(1377, 6, 138, '1', '', 0, ''),
(1378, 7, 138, 'No', '', 0, ''),
(1379, 8, 138, 'Lease', '', 0, ''),
(1380, 10, 138, 'Trent Bruce 0423 591 528', '', 0, ''),
(1381, 9, 138, 'Hudson Dale 0423 591 529', '', 0, ''),
(1382, 15, 138, '', '', 0, ''),
(1383, 16, 138, 'NA', '', 0, ''),
(1384, 14, 138, 'Exclusive Agent', '', 0, ''),
(1385, 11, 138, '<p>Please place in the hedge/garden bed area at the front of the building where possible to stay stable</p>\r\n', '', 0, ''),
(1386, 12, 139, 'Relocate', '', 0, ''),
(1387, 13, 139, '<p>Move to left hand side of driveway as requested by Kass</p>\r\n', '', 0, ''),
(1388, 12, 140, 'Standard Leased Sticker', '', 0, ''),
(1389, 13, 140, '<p>Please install LEASED sticker on board</p>\r\n', '', 0, ''),
(1390, 2, 141, 'Retail', '', 0, ''),
(1391, 3, 141, 'Portrait', '', 0, ''),
(1392, 4, 141, 'Text Board', '', 0, ''),
(1393, 5, 141, '2400x1800mm', '', 0, ''),
(1394, 6, 141, '1', '', 0, ''),
(1395, 7, 141, 'No', '', 0, ''),
(1396, 8, 141, 'Lease', '', 0, ''),
(1397, 10, 141, 'David Kettle 0423 591 541', '', 0, ''),
(1398, 9, 141, 'Brandon Mertz 0423 591 533', '', 0, ''),
(1399, 15, 141, '', '', 0, ''),
(1400, 16, 141, 'NA', '', 0, ''),
(1401, 14, 141, '', '', 0, ''),
(1402, 11, 141, '<p>Please install on the awning above Cat Cuddle Cafe as per the diagram</p>\r\n', '', 0, ''),
(1403, 2, 142, 'Office', '', 0, ''),
(1404, 3, 142, 'Portrait', '', 0, ''),
(1405, 4, 142, 'Stockboard', '', 0, ''),
(1406, 5, 142, '1800x1200mm', '', 0, ''),
(1407, 6, 142, '1', '', 0, ''),
(1408, 7, 142, 'No', '', 0, ''),
(1409, 8, 142, 'Lease', '', 0, ''),
(1410, 10, 142, 'Vaughn Smart 0423 591 531', '', 0, ''),
(1411, 9, 142, 'Brandon Mertz 0423 591 533', '', 0, ''),
(1412, 15, 142, '', '', 0, ''),
(1413, 16, 142, 'NA', '', 0, ''),
(1414, 14, 142, 'Exclusive Agent', '', 0, ''),
(1415, 11, 142, '<p>Please install signage to the left of the pathway as per the diagram</p>\r\n', '', 0, ''),
(1416, 2, 143, 'Industrial', '', 0, ''),
(1417, 3, 143, 'Portrait', '', 0, ''),
(1418, 4, 143, 'Stockboard', '', 0, ''),
(1419, 5, 143, '1800x1200mm', '', 0, ''),
(1420, 6, 143, '1', '', 0, ''),
(1421, 7, 143, 'No', '', 0, ''),
(1422, 8, 143, 'Lease', '', 0, ''),
(1423, 10, 143, 'Michael Schafferius 0423 591 540', '', 0, ''),
(1424, 9, 143, ' NA', '', 0, ''),
(1425, 15, 143, '', '', 0, ''),
(1426, 16, 143, 'NA', '', 0, ''),
(1427, 14, 143, 'Exclusive Agent', '', 0, ''),
(1428, 11, 143, '<p>Please place signage to the left hand side of the driveway as per the diagram.</p>\r\n', '', 0, ''),
(1429, 2, 144, 'Office', '', 0, ''),
(1430, 3, 144, 'Portrait', '', 0, ''),
(1431, 4, 144, 'Stockboard', '', 0, ''),
(1432, 5, 144, '1800x1200mm', '', 0, ''),
(1433, 6, 144, '1', '', 0, ''),
(1434, 7, 144, 'No', '', 0, ''),
(1435, 8, 144, 'Lease', '', 0, ''),
(1436, 10, 144, 'David Kettle 0423 591 541', '', 0, ''),
(1437, 9, 144, ' NA', '', 0, ''),
(1438, 15, 144, '', '', 0, ''),
(1439, 16, 144, 'NA', '', 0, ''),
(1440, 14, 144, 'Exclusive Agent, 75sqm Professional office space', '', 0, ''),
(1441, 11, 144, '<p>Please place signage on the fence as per the diagram sent to you. Any issue please call 0423 591 541</p>\r\n', '', 0, ''),
(1442, 13, 145, '', '', 0, ''),
(1443, 13, 146, '', '', 0, ''),
(1444, 2, 147, 'Residential', '', 0, ''),
(1445, 3, 147, 'Portrait', '', 0, ''),
(1446, 4, 147, 'Stockboard', '', 0, ''),
(1447, 5, 147, '1200x900mm', '', 0, ''),
(1448, 6, 147, '1', '', 0, ''),
(1449, 7, 147, 'No', '', 0, ''),
(1450, 8, 147, 'Lease', '', 0, ''),
(1451, 10, 147, 'Trent Bruce 0423 591 528', '', 0, ''),
(1452, 9, 147, 'Trent Bruce 0423 591 528', '', 0, ''),
(1453, 15, 147, '', '', 0, ''),
(1454, 16, 147, 'NA', '', 0, ''),
(1455, 14, 147, '', '', 0, ''),
(1456, 11, 147, '<p>Standard Installation</p>\r\n', '', 0, ''),
(1457, 2, 148, 'Residential', '', 0, ''),
(1458, 3, 148, 'Portrait', '', 0, ''),
(1459, 4, 148, 'Stockboard', '', 0, ''),
(1460, 5, 148, '1200x900mm', '', 0, ''),
(1461, 6, 148, '1', '', 0, ''),
(1462, 7, 148, 'No', '', 0, ''),
(1463, 8, 148, 'Lease', '', 0, ''),
(1464, 10, 148, 'Trent Bruce 0423 591 528', '', 0, ''),
(1465, 9, 148, 'Trent Bruce 0423 591 528', '', 0, ''),
(1466, 15, 148, '', '', 0, ''),
(1467, 16, 148, 'NA', '', 0, ''),
(1468, 14, 148, '', '', 0, ''),
(1469, 11, 148, '<p>Standard Installation</p>\r\n', '', 0, ''),
(1470, 2, 149, 'Residential', '', 0, ''),
(1471, 3, 149, 'Portrait', '', 0, ''),
(1472, 4, 149, 'Stockboard', '', 0, ''),
(1473, 5, 149, '1200x900mm', '', 0, ''),
(1474, 6, 149, '1', '', 0, ''),
(1475, 7, 149, 'No', '', 0, ''),
(1476, 8, 149, 'Lease', '', 0, ''),
(1477, 10, 149, 'Trent Bruce 0423 591 528', '', 0, ''),
(1478, 9, 149, 'Trent Bruce 0423 591 528', '', 0, ''),
(1479, 15, 149, '', '', 0, ''),
(1480, 16, 149, 'NA', '', 0, ''),
(1481, 14, 149, '', '', 0, ''),
(1482, 11, 149, '<p>Standard Installation</p>\r\n', '', 0, ''),
(1483, 2, 150, 'Residential', '', 0, ''),
(1484, 3, 150, 'Portrait', '', 0, ''),
(1485, 4, 150, 'Stockboard', '', 0, ''),
(1486, 5, 150, '1200x900mm', '', 0, ''),
(1487, 6, 150, '1', '', 0, ''),
(1488, 7, 150, 'No', '', 0, ''),
(1489, 8, 150, 'Lease', '', 0, ''),
(1490, 10, 150, 'Trent Bruce 0423 591 528', '', 0, ''),
(1491, 9, 150, 'Trent Bruce 0423 591 528', '', 0, ''),
(1492, 15, 150, '', '', 0, ''),
(1493, 16, 150, 'NA', '', 0, ''),
(1494, 14, 150, '', '', 0, ''),
(1495, 11, 150, '<p>Narrow entrance to property. Best location for sign is above letter boxes.</p>\r\n', '', 0, ''),
(1496, 2, 151, 'Residential', '', 0, ''),
(1497, 3, 151, 'Portrait', '', 0, ''),
(1498, 4, 151, 'Stockboard', '', 0, ''),
(1499, 5, 151, '1200x900mm', '', 0, ''),
(1500, 6, 151, '1', '', 0, ''),
(1501, 7, 151, 'No', '', 0, ''),
(1502, 8, 151, 'Lease', '', 0, ''),
(1503, 10, 151, 'Trent Bruce 0423 591 528', '', 0, ''),
(1504, 9, 151, 'Trent Bruce 0423 591 528', '', 0, ''),
(1505, 15, 151, '', '', 0, ''),
(1506, 16, 151, 'NA', '', 0, ''),
(1507, 14, 151, '', '', 0, ''),
(1508, 11, 151, '<p>Large complex, install near main entrance.</p>\r\n', '', 0, ''),
(1509, 2, 152, 'Residential', '', 0, ''),
(1510, 3, 152, 'Portrait', '', 0, ''),
(1511, 4, 152, 'Stockboard', '', 0, ''),
(1512, 5, 152, '1200x900mm', '', 0, ''),
(1513, 6, 152, '1', '', 0, ''),
(1514, 7, 152, 'No', '', 0, ''),
(1515, 8, 152, 'Lease', '', 0, ''),
(1516, 10, 152, 'Trent Bruce 0423 591 528', '', 0, ''),
(1517, 9, 152, 'Trent Bruce 0423 591 528', '', 0, ''),
(1518, 15, 152, '', '', 0, ''),
(1519, 16, 152, 'NA', '', 0, ''),
(1520, 14, 152, '', '', 0, ''),
(1521, 11, 152, '<p>Standard Installation</p>\r\n', '', 0, ''),
(1522, 2, 153, 'Retail', '', 0, ''),
(1523, 3, 153, 'Portrait', '', 0, ''),
(1524, 4, 153, 'Stockboard', '', 0, ''),
(1525, 5, 153, '1800x1200mm', '', 0, ''),
(1526, 6, 153, '1', '', 0, ''),
(1527, 7, 153, 'No', '', 0, ''),
(1528, 8, 153, 'Lease', '', 0, ''),
(1529, 10, 153, 'Vaughn Smart 0423 591 531', '', 0, ''),
(1530, 9, 153, 'David Kettle 0423 591 541', '', 0, ''),
(1531, 15, 153, '', '', 0, ''),
(1532, 16, 153, 'NA', '', 0, ''),
(1533, 14, 153, 'LEASED sticker', '', 0, ''),
(1534, 11, 153, '<p>Please install signage on the awning as per the diagram. Please ensure signage is installed with a LEASED sticker on it.</p>\r\n', '', 0, ''),
(1535, 2, 154, 'Retail', '', 0, ''),
(1536, 3, 154, 'Portrait', '', 0, ''),
(1537, 4, 154, 'Stockboard', '', 0, ''),
(1538, 5, 154, '1800x1200mm', '', 0, ''),
(1539, 6, 154, '1', '', 0, ''),
(1540, 7, 154, 'No', '', 0, ''),
(1541, 8, 154, 'Lease', '', 0, ''),
(1542, 10, 154, 'David Kettle 0423 591 541', '', 0, ''),
(1543, 9, 154, ' NA', '', 0, ''),
(1544, 15, 154, '', '', 0, ''),
(1545, 16, 154, 'NA', '', 0, ''),
(1546, 14, 154, 'Exclusive Agent, 53sqm Fully fitted hairdresser', '', 0, ''),
(1547, 11, 154, '<p>Please place signage on the corner infront of the hedges as per the digram sent to you. Please phone David if there is any issues on 0423 591 541</p>\r\n', '', 0, ''),
(1548, 13, 155, '', '', 0, ''),
(1549, 2, 156, 'Residential', '', 0, ''),
(1550, 3, 156, 'Portrait', '', 0, ''),
(1551, 4, 156, 'Stockboard', '', 0, ''),
(1552, 5, 156, '1200x900mm', '', 0, ''),
(1553, 6, 156, '1', '', 0, ''),
(1554, 7, 156, 'No', '', 0, ''),
(1555, 8, 156, 'Lease', '', 0, ''),
(1556, 10, 156, 'Trent Bruce 0423 591 528', '', 0, ''),
(1557, 9, 156, 'Trent Bruce 0423 591 528', '', 0, ''),
(1558, 15, 156, '', '', 0, ''),
(1559, 16, 156, 'NA', '', 0, ''),
(1560, 14, 156, '', '', 0, ''),
(1561, 11, 156, '<p>Standard Installation</p>\r\n', '', 0, ''),
(1562, 2, 157, 'Industrial', '', 0, ''),
(1563, 3, 157, 'Portrait', '', 0, ''),
(1564, 4, 157, 'Stockboard', '', 0, ''),
(1565, 5, 157, '1800x1200mm', '', 0, ''),
(1566, 6, 157, '1', '', 0, ''),
(1567, 7, 157, 'No', '', 0, ''),
(1568, 8, 157, 'Sale/Lease', '', 0, ''),
(1569, 10, 157, 'Lawrence Temple 0423 591 534', '', 0, ''),
(1570, 9, 157, ' NA', '', 0, ''),
(1571, 15, 157, '', '', 0, ''),
(1572, 16, 157, 'NA', '', 0, ''),
(1573, 14, 157, '', '', 0, ''),
(1574, 11, 157, '<p>Please place sign to the right of the property in garden bed.</p>\r\n', '', 0, ''),
(1575, 13, 158, '<p>Bodt Corporate said to remove sign</p>\r\n', '', 0, ''),
(1576, 2, 159, 'Other', '', 0, ''),
(1577, 3, 159, 'NA', '', 0, ''),
(1578, 4, 159, 'Window Graphic', '', 0, ''),
(1579, 5, 159, 'Other', '', 0, ''),
(1580, 6, 159, '1', '', 0, ''),
(1581, 7, 159, 'No', '', 0, ''),
(1582, 8, 159, 'Sale', '', 0, ''),
(1583, 10, 159, 'Brandon Mertz 0423 591 533', '', 0, ''),
(1584, 9, 159, ' NA', '', 0, ''),
(1585, 15, 159, '', '', 0, ''),
(1586, 16, 159, 'NA', '', 0, ''),
(1587, 14, 159, '', '', 0, ''),
(1588, 11, 159, '<p>Install as per artwork</p>\r\n', '', 0, ''),
(1589, 12, 160, 'Other', '', 0, ''),
(1590, 13, 160, '<p>Please re-errect the signage. It has blown over.</p>\r\n', '', 0, ''),
(1591, 2, 161, 'Industrial', '', 0, ''),
(1592, 3, 161, 'Portrait', '', 0, ''),
(1593, 4, 161, 'Stockboard', '', 0, ''),
(1594, 5, 161, '1800x1200mm', '', 0, ''),
(1595, 6, 161, '1', '', 0, ''),
(1596, 7, 161, 'No', '', 0, ''),
(1597, 8, 161, 'Lease', '', 0, ''),
(1598, 10, 161, 'Lawrence Temple 0423 591 534', '', 0, ''),
(1599, 9, 161, ' NA', '', 0, ''),
(1600, 15, 161, '', '', 0, ''),
(1601, 16, 161, 'NA', '', 0, ''),
(1602, 14, 161, 'Exclusive Agent', '', 0, ''),
(1603, 11, 161, '<p>Please place sign on the right hand side of the driveway as shown in image sent to you.</p>\r\n', '', 0, ''),
(1604, 13, 162, '', '', 0, ''),
(1605, 13, 163, '', '', 0, ''),
(1606, 13, 164, '', '', 0, ''),
(1607, 13, 165, '', '', 0, ''),
(1608, 12, 166, 'New/Additional Decal or Nameplate', '', 0, ''),
(1609, 13, 166, '<p>Add LEASED sticker then please remove sign between 7 to 10 days after.</p>\r\n', '', 0, ''),
(1610, 12, 167, 'New/Additional Decal or Nameplate', '', 0, ''),
(1611, 13, 167, '<p>Add LEASED sticker then please remove sign between 7 to 10 days after.</p>\r\n', '', 0, ''),
(1612, 12, 168, 'New/Additional Decal or Nameplate', '', 0, ''),
(1613, 13, 168, '<p>Add LEASED sticker then please remove sign between 7 to 10 days after.</p>\r\n', '', 0, ''),
(1614, 12, 169, 'New/Additional Decal or Nameplate', '', 0, ''),
(1615, 13, 169, '<p>Add LEASED sticker then please remove sign between 7 to 10 days after.</p>\r\n', '', 0, ''),
(1616, 12, 170, 'New/Additional Decal or Nameplate', '', 0, ''),
(1617, 13, 170, '<p>Add LEASED sticker then please remove sign between 7 to 10 days after.</p>\r\n', '', 0, ''),
(1618, 2, 171, 'Residential', '', 0, ''),
(1619, 3, 171, 'Portrait', '', 0, ''),
(1620, 4, 171, 'Stockboard', '', 0, ''),
(1621, 5, 171, '1200x900mm', '', 0, ''),
(1622, 6, 171, '1', '', 0, ''),
(1623, 7, 171, 'No', '', 0, ''),
(1624, 8, 171, 'Lease', '', 0, ''),
(1625, 10, 171, 'Trent Bruce 0423 591 528', '', 0, ''),
(1626, 9, 171, 'Trent Bruce 0423 591 528', '', 0, ''),
(1627, 15, 171, '', '', 0, ''),
(1628, 16, 171, 'NA', '', 0, ''),
(1629, 14, 171, '', '', 0, ''),
(1630, 11, 171, '<p>Standard Position One installation</p>\r\n', '', 0, ''),
(1631, 2, 172, 'Residential', '', 0, ''),
(1632, 3, 172, 'Portrait', '', 0, ''),
(1633, 4, 172, 'Stockboard', '', 0, ''),
(1634, 5, 172, '1200x900mm', '', 0, ''),
(1635, 6, 172, '1', '', 0, ''),
(1636, 7, 172, 'No', '', 0, ''),
(1637, 8, 172, 'Lease', '', 0, ''),
(1638, 10, 172, 'Trent Bruce 0423 591 528', '', 0, ''),
(1639, 9, 172, 'Trent Bruce 0423 591 528', '', 0, ''),
(1640, 15, 172, '', '', 0, ''),
(1641, 16, 172, 'NA', '', 0, ''),
(1642, 14, 172, '', '', 0, ''),
(1643, 11, 172, '<p>Standard Position One installation</p>\r\n', '', 0, ''),
(1644, 2, 173, 'Residential', '', 0, ''),
(1645, 3, 173, 'Portrait', '', 0, ''),
(1646, 4, 173, 'Stockboard', '', 0, ''),
(1647, 5, 173, '1200x900mm', '', 0, ''),
(1648, 6, 173, '1', '', 0, ''),
(1649, 7, 173, 'No', '', 0, ''),
(1650, 8, 173, 'Lease', '', 0, ''),
(1651, 10, 173, 'Trent Bruce 0423 591 528', '', 0, ''),
(1652, 9, 173, 'Trent Bruce 0423 591 528', '', 0, ''),
(1653, 15, 173, '', '', 0, ''),
(1654, 16, 173, 'NA', '', 0, ''),
(1655, 14, 173, '', '', 0, ''),
(1656, 11, 173, '<p>Standard Position One installation</p>\r\n', '', 0, ''),
(1657, 2, 174, 'Residential', '', 0, ''),
(1658, 3, 174, 'Portrait', '', 0, ''),
(1659, 4, 174, 'Stockboard', '', 0, ''),
(1660, 5, 174, '1200x900mm', '', 0, ''),
(1661, 6, 174, '1', '', 0, ''),
(1662, 7, 174, 'No', '', 0, ''),
(1663, 8, 174, 'Lease', '', 0, ''),
(1664, 10, 174, 'Trent Bruce 0423 591 528', '', 0, ''),
(1665, 9, 174, 'Trent Bruce 0423 591 528', '', 0, ''),
(1666, 15, 174, '', '', 0, ''),
(1667, 16, 174, 'NA', '', 0, ''),
(1668, 14, 174, '', '', 0, ''),
(1669, 11, 174, '<p>Standard Position One installation</p>\r\n', '', 0, ''),
(1670, 2, 175, 'Residential', '', 0, ''),
(1671, 3, 175, 'Portrait', '', 0, ''),
(1672, 4, 175, 'Stockboard', '', 0, ''),
(1673, 5, 175, '1200x900mm', '', 0, ''),
(1674, 6, 175, '1', '', 0, ''),
(1675, 7, 175, 'No', '', 0, ''),
(1676, 8, 175, 'Lease', '', 0, ''),
(1677, 10, 175, 'Trent Bruce 0423 591 528', '', 0, ''),
(1678, 9, 175, 'Trent Bruce 0423 591 528', '', 0, ''),
(1679, 15, 175, '', '', 0, ''),
(1680, 16, 175, 'NA', '', 0, ''),
(1681, 14, 175, '', '', 0, ''),
(1682, 11, 175, '<p>Standard Position One installation</p>\r\n', '', 0, ''),
(1683, 2, 176, 'Residential', '', 0, ''),
(1684, 3, 176, 'Portrait', '', 0, ''),
(1685, 4, 176, 'Stockboard', '', 0, ''),
(1686, 5, 176, '1200x900mm', '', 0, ''),
(1687, 6, 176, '1', '', 0, ''),
(1688, 7, 176, 'No', '', 0, ''),
(1689, 8, 176, 'Lease', '', 0, ''),
(1690, 10, 176, 'Trent Bruce 0423 591 528', '', 0, ''),
(1691, 9, 176, 'Trent Bruce 0423 591 528', '', 0, ''),
(1692, 15, 176, '', '', 0, ''),
(1693, 16, 176, 'NA', '', 0, ''),
(1694, 14, 176, '', '', 0, ''),
(1695, 11, 176, '<p>Standard Position One installation</p>\r\n', '', 0, ''),
(1696, 12, 177, 'New/Additional Decal or Nameplate', '', 0, ''),
(1697, 13, 177, '<p>Lease sign has been knocked over, currently in the garden. Can you please re-install sign.</p>\r\n', '', 0, ''),
(1698, 13, 178, '<p>JOB ID 67 &amp; 70 - So both boards as the address.&nbsp;</p>\r\n\r\n<p>Thank you - RJ&nbsp;</p>\r\n', '', 0, ''),
(1699, 2, 179, 'Office', '', 0, ''),
(1700, 3, 179, 'Portrait', '', 0, ''),
(1701, 4, 179, 'Stockboard', '', 0, ''),
(1702, 5, 179, '1800x1200mm', '', 0, ''),
(1703, 6, 179, '2', '', 0, ''),
(1704, 7, 179, 'Yes', '', 0, ''),
(1705, 8, 179, 'Lease', '', 0, ''),
(1706, 10, 179, 'David Miller 0423 591 111', '', 0, ''),
(1707, 9, 179, 'Hudson Dale 0423 591 529', '', 0, ''),
(1708, 15, 179, '', '', 0, ''),
(1709, 16, 179, 'NA', '', 0, ''),
(1710, 14, 179, '', '', 0, ''),
(1711, 11, 179, '<p>Please place signage in a V board on the awning so the signage is facing both directions of traffic.</p>\r\n', '', 0, ''),
(1712, 13, 180, '<p>Can we please have this removed Urgently.</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>Thankyou</p>\r\n', '', 0, ''),
(1713, 2, 181, 'Office', '', 0, ''),
(1714, 3, 181, 'Portrait', '', 0, ''),
(1715, 4, 181, 'Stockboard', '', 0, ''),
(1716, 5, 181, '1800x1200mm', '', 0, ''),
(1717, 6, 181, '2', '', 0, ''),
(1718, 7, 181, 'Yes', '', 0, ''),
(1719, 8, 181, 'Lease', '', 0, ''),
(1720, 10, 181, 'Hudson Dale 0423 591 529', '', 0, ''),
(1721, 9, 181, 'David Miller 0423 591 111', '', 0, ''),
(1722, 15, 181, '', '', 0, ''),
(1723, 16, 181, 'NA', '', 0, ''),
(1724, 14, 181, 'Exclusive Agent', '', 0, ''),
(1725, 11, 181, '<p>Please install signage to the left hand side of the pylon signage n a V board facing both directions.</p>\r\n', '', 0, ''),
(1726, 13, 182, '', '', 0, ''),
(1727, 13, 183, '', '', 0, ''),
(1728, 12, 184, 'New/Additional Decal or Nameplate', '', 0, ''),
(1729, 13, 184, '', '', 0, ''),
(1730, 12, 185, 'New/Additional Decal or Nameplate', '', 0, ''),
(1731, 13, 185, '<p>add LEASED sticker, remove job after 7 to 10 days</p>\r\n', '', 0, ''),
(1732, 12, 186, 'New/Additional Decal or Nameplate', '', 0, ''),
(1733, 13, 186, '<p>add LEASED sticker, remove job after 7 to 10 days</p>\r\n', '', 0, ''),
(1734, 12, 187, 'New/Additional Decal or Nameplate', '', 0, ''),
(1735, 13, 187, '<p>add LEASED sticker, remove job after 7 to 10 days</p>\r\n', '', 0, ''),
(1736, 12, 188, 'New/Additional Decal or Nameplate', '', 0, ''),
(1737, 13, 188, '<p>add LEASED sticker, remove job after 7 to 10 days</p>\r\n', '', 0, ''),
(1738, 2, 189, 'Residential', '', 0, ''),
(1739, 3, 189, 'Portrait', '', 0, ''),
(1740, 4, 189, 'Stockboard', '', 0, ''),
(1741, 5, 189, '1200x900mm', '', 0, ''),
(1742, 6, 189, '1', '', 0, ''),
(1743, 7, 189, 'No', '', 0, ''),
(1744, 8, 189, 'Lease', '', 0, ''),
(1745, 10, 189, 'Trent Bruce 0423 591 528', '', 0, ''),
(1746, 9, 189, 'Trent Bruce 0423 591 528', '', 0, ''),
(1747, 15, 189, '', '', 0, ''),
(1748, 16, 189, 'NA', '', 0, ''),
(1749, 14, 189, '', '', 0, ''),
(1750, 11, 189, '<p>Standard Installation</p>\r\n', '', 0, ''),
(1751, 2, 190, 'Residential', '', 0, ''),
(1752, 3, 190, 'Portrait', '', 0, ''),
(1753, 4, 190, 'Stockboard', '', 0, ''),
(1754, 5, 190, '1200x900mm', '', 0, ''),
(1755, 6, 190, '1', '', 0, ''),
(1756, 7, 190, 'No', '', 0, ''),
(1757, 8, 190, 'Lease', '', 0, ''),
(1758, 10, 190, 'Trent Bruce 0423 591 528', '', 0, ''),
(1759, 9, 190, 'Trent Bruce 0423 591 528', '', 0, ''),
(1760, 15, 190, '', '', 0, ''),
(1761, 16, 190, 'NA', '', 0, ''),
(1762, 14, 190, '', '', 0, ''),
(1763, 11, 190, '<p>Standard Installation</p>\r\n', '', 0, ''),
(1764, 2, 191, 'Office', '', 0, ''),
(1765, 3, 191, 'Portrait', '', 0, ''),
(1766, 4, 191, 'Stockboard', '', 0, ''),
(1767, 5, 191, '900x600mm', '', 0, ''),
(1768, 6, 191, '1', '', 0, ''),
(1769, 7, 191, 'No', '', 0, ''),
(1770, 8, 191, 'Sale', '', 0, ''),
(1771, 10, 191, 'Trent Bruce 0423 591 528', '', 0, ''),
(1772, 9, 191, 'Trent Bruce 0423 591 528', '', 0, ''),
(1773, 15, 191, '', '', 0, ''),
(1774, 16, 191, 'NA', '', 0, ''),
(1775, 14, 191, '', '', 0, ''),
(1776, 11, 191, '', '', 0, ''),
(1777, 17, 192, '', '', 0, ''),
(1778, 2, 192, 'Office', '', 0, ''),
(1779, 3, 192, 'Portrait', '', 0, ''),
(1780, 4, 192, 'Stockboard', '', 0, ''),
(1781, 5, 192, '900x600mm', '', 0, ''),
(1782, 6, 192, '1', '', 0, ''),
(1783, 7, 192, 'No', '', 0, ''),
(1784, 8, 192, 'Sale', '', 0, ''),
(1785, 10, 192, 'Trent Bruce 0423 591 528', '', 0, ''),
(1786, 9, 192, 'Trent Bruce 0423 591 528', '', 0, ''),
(1787, 15, 192, '', '', 0, ''),
(1788, 16, 192, 'NA', '', 0, ''),
(1789, 14, 192, '', '', 0, ''),
(1790, 11, 192, '', '', 0, ''),
(1791, 17, 193, '', '', 0, ''),
(1792, 18, 193, 'Exclusive Agent', '', 0, ''),
(1793, 2, 193, 'Office', '', 0, ''),
(1794, 3, 193, 'Portrait', '', 0, ''),
(1795, 4, 193, 'Stockboard', '', 0, ''),
(1796, 5, 193, '900x600mm', '', 0, ''),
(1797, 6, 193, '2', '', 0, ''),
(1798, 7, 193, 'No', '', 0, ''),
(1799, 8, 193, 'Sale', '', 0, ''),
(1800, 10, 193, 'Trent Bruce 0423 591 528', '', 0, ''),
(1801, 9, 193, 'Trent Bruce 0423 591 528', '', 0, ''),
(1802, 15, 193, '', '', 0, ''),
(1803, 16, 193, 'NA', '', 0, ''),
(1804, 14, 193, '', '', 0, ''),
(1805, 11, 193, '', '', 0, '');

-- --------------------------------------------------------

--
-- Table structure for table `knowledge_articles`
--

CREATE TABLE IF NOT EXISTS `knowledge_articles` (
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

CREATE TABLE IF NOT EXISTS `knowledge_categories` (
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

CREATE TABLE IF NOT EXISTS `login_attempts` (
`ID` int(11) NOT NULL,
  `IP` varchar(500) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `username` varchar(500) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `count` int(11) NOT NULL DEFAULT '0',
  `timestamp` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

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
(13, '119.160.118.55', '" or ''''="', 1, 1538566298),
(14, '119.160.118.55', '" or ""="', 1, 1538566365),
(15, '119.160.118.55', '''or ''''=''', 1, 1538566393),
(16, '119.160.118.55', '''or ""=''', 1, 1538566413),
(17, '119.160.118.55', '" or ""="', 1, 1538566698),
(18, '119.160.118.55', '"" or ""=""', 1, 1538566746),
(19, '119.160.118.55', '105 OR 1=1', 1, 1538566953),
(20, '119.160.118.55', '"or""="', 1, 1538567024),
(21, '203.206.84.254', 'free.tunisian.me@gmail.com', 1, 1538640762),
(22, '203.206.84.254', 'free.tunisian.me@gmail.com', 1, 1538647986),
(23, '1.129.106.103', 'free.tunisian.me@gmail.com', 1, 1538774911),
(24, '117.224.42.136', 'par.caresu@gmail.com', 1, 1538796493),
(25, '157.36.210.251', 'Administartor', 3, 1538984622),
(26, '124.170.81.48', 'ap@signcreators.com.au', 1, 1539036976),
(27, '1.132.106.118', 'ap@signcreators.com.au', 1, 1539158225),
(28, '103.6.219.0', 'subhash1120@gmail.com', 4, 1541649560),
(29, '103.6.219.0', 'ap@signcreators.com.au', 2, 1541649577),
(30, '139.99.141.145', 'ap@signcreators.com.au', 1, 1541839621),
(31, '58.6.114.147', 'ap@signcreators.com.au', 1, 1542087520),
(32, '58.6.114.147', 'hector19901234@hotmail.com', 1, 1542587204),
(33, '1.132.110.217', 'ap@signcreators.com.au', 1, 1543471787),
(34, '196.178.91.1', 'ap@signcreators.com.au', 1, 1543517076),
(35, '36.67.35.123', 'ad', 1, 1545013017),
(36, '36.67.35.123', 'ap@signcreators.com.au', 1, 1545013023),
(37, '36.67.35.123', 'firstassestmanagement', 2, 1545013094),
(38, '127.0.0.1', 'ap@signcreators.com.au', 5, 1547524859),
(39, '127.0.0.1', 'rainehorne', 1, 1547542193),
(40, '127.0.0.1', 'marketing@rhcommercial.com', 1, 1547542219),
(41, '127.0.0.1', 'administration', 1, 1547941692),
(42, '127.0.0.1', 'ap@signcreators.com.au', 1, 1547941704);

-- --------------------------------------------------------

--
-- Table structure for table `password_reset`
--

CREATE TABLE IF NOT EXISTS `password_reset` (
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

CREATE TABLE IF NOT EXISTS `payment_logs` (
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

CREATE TABLE IF NOT EXISTS `payment_plans` (
`ID` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `hexcolor` varchar(6) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `fontcolor` varchar(6) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `cost` decimal(10,2) NOT NULL DEFAULT '0.00',
  `days` int(11) NOT NULL DEFAULT '0',
  `sales` int(11) NOT NULL DEFAULT '0',
  `description` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `icon` varchar(255) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

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

CREATE TABLE IF NOT EXISTS `reset_log` (
`ID` int(11) NOT NULL,
  `IP` varchar(500) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `timestamp` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `site_layouts`
--

CREATE TABLE IF NOT EXISTS `site_layouts` (
`ID` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `layout_path` varchar(500) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

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

CREATE TABLE IF NOT EXISTS `site_settings` (
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
  `cache_time` int(11) NOT NULL DEFAULT '3600',
  `field_order` varchar(255) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `site_settings`
--

INSERT INTO `site_settings` (`ID`, `site_name`, `site_desc`, `upload_path`, `upload_path_relative`, `site_email`, `site_logo`, `register`, `disable_captcha`, `date_format`, `avatar_upload`, `file_types`, `twitter_consumer_key`, `twitter_consumer_secret`, `disable_social_login`, `facebook_app_id`, `facebook_app_secret`, `google_client_id`, `google_client_secret`, `file_size`, `paypal_email`, `paypal_currency`, `payment_enabled`, `payment_symbol`, `global_premium`, `install`, `login_protect`, `activate_account`, `default_user_role`, `secure_login`, `stripe_secret_key`, `stripe_publish_key`, `enable_job_uploads`, `enable_job_guests`, `enable_job_edit`, `require_login`, `protocol`, `protocol_path`, `protocol_email`, `protocol_password`, `job_title`, `protocol_ssl`, `job_rating`, `notes`, `google_recaptcha`, `google_recaptcha_secret`, `google_recaptcha_key`, `logo_option`, `avatar_height`, `avatar_width`, `default_category`, `checkout2_accountno`, `checkout2_secret`, `layout`, `imap_job_string`, `imap_reply_string`, `captcha_job`, `envato_personal_token`, `cache_time`, `field_order`) VALUES
(1, 'Sign Creators Real Estate Portal', 'Sign Creators Real Estate Portal', '/home/mt40isswwava/public_html/uploads', 'uploads', 'info@signcreators.com.au', 'logo3.png', 0, 1, 'd/m/Y h:i', 1, 'gif|png|jpg|jpeg|pdf', '', '', 1, '', '', '', '', 20560, '', 'USD', 0, '$', 0, 0, 1, 0, 10, 0, '', '', 1, 1, 0, 1, 1, 'imap.gmail.com:993', '', '', 'Support Job', 1, 1, '', 0, '', '', 1, 100, 100, 1, 0, '', 'layout/themes/titan_layout.php', '## Job ID:', '## - REPLY ABOVE THIS LINE - ##', 0, '', 3600, '17,18,16,15,14,13,12,11,10,9,8,7,6,5,4,3,2,');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE IF NOT EXISTS `users` (
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
  `custom_view` int(11) NOT NULL,
  `custom_fields` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT ','
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`ID`, `email`, `password`, `token`, `IP`, `username`, `first_name`, `last_name`, `avatar`, `joined`, `joined_date`, `online_timestamp`, `oauth_provider`, `oauth_id`, `oauth_token`, `oauth_secret`, `email_notification`, `aboutme`, `points`, `premium_time`, `user_role`, `premium_planid`, `active`, `activate_code`, `noti_count`, `custom_view`, `custom_fields`) VALUES
(1, 'ap@signcreators.com.au', '$2a$12$rQuox4DGQMaPmLPQGhFIve7zNXeMhadYRBSTZ6s3sI.gE9RUa97Fi', 'ea62063b6673fbf24e9ff293508c9803', '::1', 'Administrator', 'Admin', 'User', 'default.png', 1537116931, '9-2018', 1556552591, '', '', '', '', 0, '', '0.00', 0, 1, 0, 1, '', 6, 0, '14,13,12,11,10,9,8,7,6,5,4,3,2,'),
(2, 'eagle.free.me@gmail.com', '$2a$12$pvPXyGzIK.gngMd/QaN7U.sCwiBrNsvOzIqZqC4.P2fNOb5AvIH4a', 'f08713fab5bdc59a2b2a1924ea1f0c9b', '::1', 'lou_tuni', 'Lotfi', 'Ben Taleb', 'default.png', 1537126184, '9-2018', 1537273354, '', '', '', '', 1, '', '0.00', 0, 10, 0, 1, '', 0, 0, ','),
(3, 'murrayid2001@gmail.com', '$2a$12$BQJIhk2eXvfNHT3q5clcA.x/VMCzwYKvyawfHBxJ2OfgUOYyAEVlG', 'a3e17a025fc07e543d6dcb47bba6482f', '103.239.252.22', 'murrayid2001', 'Omar', 'Faruk', 'default.png', 1537143281, '9-2018', 1538437621, '', '', '', '', 1, '', '0.00', 0, 10, 0, 1, '', 0, 0, ','),
(4, 'bowlesdeidre@gmail.com', '$2a$12$6UNY3UUQepcW4vjY9UGlQuY1zBMMtnviV4cNxMwyhKgyylhNrPNJy', '84ab938bb82ef908e903a7ebc8bef70c', '124.170.81.48', 'dbowles', 'Deidre', 'Bowles', 'default.png', 1537867957, '9-2018', 1542618415, '', '', '', '', 0, '', '0.00', 0, 10, 0, 1, '', 3, 0, '16,15,11,7,6,5,4,'),
(5, 'marketing@rhcommercial.com', '$2a$12$SR55eeeYcG/s2OurU/Rw9OBdiDyDudf2J3CBfIhr3bRe0iRpNRh1.', '61b271b608328fdd8515bef941a3124a', '124.170.81.48', 'Rhcommercial', 'Raine Horne', 'Commercial', 'default.png', 1538004345, '9-2018', 1547517414, '', '', '', '', 0, '', '0.00', 0, 10, 0, 1, '', 86, 0, '14,13,12,11,10,9,8,7,6,5,4,3,2,'),
(6, 'andrew@signcreators.com.au', '$2a$12$7zvtWd3Qnvxu6DRtdwhX1eeLgOVOb7G7gsLcZEsCemdY7bNqmbaO.', '', '124.170.81.48', 'SignCreators', 'Sign', 'Creators', 'default.png', 1538011996, '9-2018', 0, '', '', '', '', 1, '', '0.00', 0, 10, 0, 1, '', 0, 0, ','),
(7, 'ping.waqas@gmail.com', '$2a$12$BE7ie5dzOGeR6v6RVmBpqeAtzdqE71cbEyJJFdcesa3kN1ArXHjS6', '4e253fa0d73f3b75235c6c7ce964a317', '116.58.35.116', 'waqas93', 'Waqas', 'Ali', 'default.png', 1538549027, '10-2018', 1538549038, '', '', '', '', 1, '', '0.00', 0, 10, 0, 1, '', 0, 0, ','),
(8, 'tarikgenrosys@gmail.com', '$2a$12$ZAZbbuo5i8ToaRpW0jKooOFBt3uMuk34nkEkqyiWPCDOO9rDHChG6', 'dc74e5382c1650df30a28511a60a03d9', '122.160.97.131', 'Tarik', 'Tarik', 'Khanna', 'default.png', 1538549269, '10-2018', 1538549300, '', '', '', '', 1, '', '0.00', 0, 10, 0, 1, '', 0, 0, ','),
(9, 'subhash1120@gmail.com', '$2a$12$UHWOh6CmN.8vF9eBYoQfLeHbHCedN1KTgsUs0O1BmPFq72Iqd5U.i', 'f2b2661ca7389b6f95f393c0bf57f887', '122.173.195.51', 'admin', 'Subhash', 'Chand', 'default.png', 1538549274, '10-2018', 1538549286, '', '', '', '', 1, '', '0.00', 0, 10, 0, 1, '', 0, 0, ','),
(10, 'bunnysusheel@gmail.com', '$2a$12$nH2o66BYOnDmM4nNxXda/.kVUqOhMQYDuEed7DEdNzUzCp1k16zC.', 'b5cd8e134b18dbfe74d5e56998ae83b5', '42.104.97.18', 'SusheelAdirala', 'susheel', 'adirala', 'default.png', 1538549329, '10-2018', 1538549340, '', '', '', '', 1, '', '0.00', 0, 10, 0, 1, '', 0, 0, ','),
(11, 'davidmullerx825@gmail.com', '$2a$12$2BXbH4jX7vYblc.mwXDb6uphztDzQH7ysG.CofWW8HWhZ3/Xr7qo2', '353d791170ed68125858d3050d414116', '167.88.108.136', 'davidmullerx', 'David', 'Muller', 'default.png', 1538549423, '10-2018', 1538549449, '', '', '', '', 1, '', '0.00', 0, 10, 0, 1, '', 0, 0, ','),
(12, 'naveengautam62@gmail.com', '$2a$12$bd038sh20yVzM01E1aAnyemcBcO4k0Yrw0fol3Vlj4ZhQ8QUmphfa', '6e5681fbb4f6dcc761d8182c36babaf2', '116.193.163.50', 'ngautam90', 'Naveen', 'Gautam', 'default.png', 1538549503, '10-2018', 1538549508, '', '', '', '', 1, '', '0.00', 0, 10, 0, 1, '', 0, 0, ','),
(13, 'skshahnawaz2909@gmail.com', '$2a$12$XYYgH4k/FykJFEPyU/jkruHmVKtEFyHVAuiba4aItD2DLfefc9Sr6', 'ce5c8f7e935fade71508766a98343333', '116.193.133.231', 'sks', 'sk', 'sh', 'default.png', 1538549573, '10-2018', 1538553260, '', '', '', '', 1, '', '0.00', 0, 10, 0, 1, '', 0, 0, ','),
(14, 'aliasgar.vanak@gmail.com', '$2a$12$EOqD6bQeA7aG8HBOyyV0FO7y9KVphOOoaICHOR9tRxh6b5K0y8cS.', '96ff9a5ce645e529f0132e32cafecbd9', '43.230.46.198', 'aliasgarvanak', 'Aliasgar', 'Vanak', 'default.png', 1538549648, '10-2018', 1538549660, '', '', '', '', 1, '', '0.00', 0, 10, 0, 1, '', 0, 0, ','),
(15, 'breakout.soul@gmail.com', '$2a$12$ctZDT56t//zDfTgMDHGMGetIsftWmRIrcbpUTYWal.DtEt0ShSpCa', 'e9579bdd7590a6efd766bed449d9a9db', '119.30.45.82', 'Shimul22', 'Ihteshamul', 'Alam', 'default.png', 1538549866, '10-2018', 1538549872, '', '', '', '', 1, '', '0.00', 0, 10, 0, 1, '', 0, 0, ','),
(16, 'yogesh.more@itoolsolutions.com', '$2a$12$yhux398UU4HFEsZfjovmd.WARQFO1A5Zb9wHzhe11VlR8iHC/1NOq', '0900dd3c5e5de5e37071f69e59b2ea30', '219.91.239.202', 'yogesh_more', 'yogesh', 'more', 'default.png', 1538549977, '10-2018', 1538549985, '', '', '', '', 1, '', '0.00', 0, 10, 0, 1, '', 0, 0, ','),
(17, 'par.caresu@gmail.com', '$2a$12$0rWvNGnWAS6olNmEABr7IufTNIrxQTqa/U6APBTtc3g/3fR.MGS.u', 'cad222fe310e4b84a61acfe2845fef29', '122.173.103.85', 'pardeep2370', 'Pardeep', 'Kumar', 'default.png', 1538550222, '10-2018', 1538979607, '', '', '', '', 1, '', '0.00', 0, 10, 0, 1, '', 0, 0, ','),
(18, 'popular.developer@gmail.com', '$2a$12$XRynxOonLsoPepslV8xnK.LRUu.qB.fPBSEtp2cdYmKo3NtZGJ8X6', '0af1a0af0fd0a21d71edc5aead22cc81', '157.32.147.244', 'populardev', 'Popular', 'Developer', 'default.png', 1538550225, '10-2018', 1538551583, '', '', '', '', 1, '', '0.00', 0, 10, 0, 1, '', 0, 0, ','),
(19, 'nadeem@gmail.com', '$2a$12$qIttNSm3l3HKVAmP9M5YJeuczAVpYwcMGWFE0V9Eq9xGYhbiEVIvu', 'abe5816c97c0bdacce8eda32b35fae2e', '39.55.140.108', 'nadeem', 'nadeem', 'ijaz', 'default.png', 1538550621, '10-2018', 1538550957, '', '', '', '', 1, '', '0.00', 0, 10, 0, 1, '', 0, 0, ','),
(20, 'thanisheun@gmail.com', '$2a$12$onynMCJXnnWYDGwXdgJtkuJ0UN6.cOFVrJM/OfOaRZjoUsXlh7RGq', 'a45ca94ada8609f5dd05b4604791ccab', '197.211.61.75', 'tinswap', 'thani', 'sheun', 'default.png', 1538551267, '10-2018', 1538551277, '', '', '', '', 1, '', '0.00', 0, 10, 0, 1, '', 0, 0, ','),
(21, 'mohan.wijesena@msn.com', '$2a$12$bqX0746X9vV3ni6x3.CojupZCXb53E8uM4poo9.DG8HI7hKllaF3m', '6ef2ced7d93ca5f4e5111099fdcd4186', '175.157.52.40', 'mohanw', 'Mohan', 'W', 'default.png', 1538554646, '10-2018', 1538554674, '', '', '', '', 1, '', '0.00', 0, 10, 0, 1, '', 0, 0, ','),
(22, 'albertcsefe@gmail.com', '$2a$12$MEK9vOY160/PmSG7WKbzUudMlZ2OlK1yW7wV4s0fVlgxkrOpvYw82', '4b028fcbb9eea62d9f13710eb8dc0be4', '89.165.142.126', 'albertf', 'aa', 'AFF', 'default.png', 1538557104, '10-2018', 1538557110, '', '', '', '', 1, '', '0.00', 0, 10, 0, 1, '', 0, 0, ','),
(23, 'gogo@gmail.com', '$2a$12$PVQmG4gkpVSRazuuvBTe.unMzctwx7aec65pmXI5fGN5tATwdtC16', 'd97a9a6b7071181e84d1357a1e1d9cfa', '62.4.55.212', 'Gogo', 'Dzon', 'Doznis', 'default.png', 1538557658, '10-2018', 1538557667, '', '', '', '', 1, '', '0.00', 0, 10, 0, 1, '', 0, 0, ','),
(24, 'sarki805@gmail.com', '$2a$12$53PamA.mQwB2uRaZiLeSZ.x3Ho0GRbkVcUU8LDtx9wmIn.9k0GNMq', '0ef749baef832fdb0e128a11a129c6b4', '119.160.118.55', 'Ayan', 'Ayan', 'Ali', 'default.png', 1538566550, '10-2018', 1538566568, '', '', '', '', 1, '', '0.00', 0, 10, 0, 1, '', 0, 0, ','),
(25, 'andrey.shaban@yandex.ru', '$2a$12$2/JTveLIvzVBnj9arnAH4u.8SOzG5jLVzbyTmu7LzUTMeeWsc4Qna', '23c90bcffdb19f6aa8749d2cfeb5a569', '93.85.14.200', 'andrew312', 'Andrew', 'Shaban', 'default.png', 1538567162, '10-2018', 1538567632, '', '', '', '', 1, '', '0.00', 0, 10, 0, 1, '', 0, 0, ','),
(26, 'jason@ogrelogic.com', '$2a$12$lKnxrwUvdTDqdVxTQQDcaennCfPElTkLqONq9bEQnlCLgfTby/G3C', 'd5fbbf2137e2a6f42bafd1f2cd821331', '14.102.127.90', 'jason199669', 'Jason', 'Cooper', 'default.png', 1538598919, '10-2018', 1538598927, '', '', '', '', 1, '', '0.00', 0, 10, 0, 1, '', 0, 0, ','),
(27, 'kapilgulati19@gmail.com', '$2a$12$ymzpK9uth6um5hqGCkAGJ.erqoXhf0MRiZqm/0lHyS5cFseqNpXA2', '', '117.224.103.228', 'kapilgulati19', 'Kapil', 'Gulati', 'default.png', 1538826918, '10-2018', 0, '', '', '', '', 1, '', '0.00', 0, 10, 0, 1, '', 0, 0, ','),
(28, 'test@gmail.com', '$2a$12$A3KVS5QDKOrXsV4PYXeGkusOj5EdVzKpO8QCpgMRWnArG6kS6Z3yu', 'b17d11ad811f12e76eb2e5bfbb5a7f65', '124.170.81.48', 'janderson', 'Jarrod', 'Anderson', 'default.png', 1539148574, '10-2018', 1541128456, '', '', '', '', 1, '', '0.00', 0, 10, 0, 1, '', 0, 0, ','),
(29, '1@1.com', '$2a$12$mEDX4QWNOhp/EGkKrfnvCOtsRfpKtqw.LXe.rseShmWrP.PD3coIq', '1312410521fc22e4f102e4a9f26fdaca', '103.6.219.0', 'bbb', 'b', 'bb', 'default.png', 1541649402, '11-2018', 1543002366, '', '', '', '', 1, '', '0.00', 0, 10, 0, 1, '', 0, 0, '8,7,6,'),
(30, 'hector19901234@hotmail.com', '$2a$12$b7zw58edJdf4ytzjCixDOufu0iIjBmTqgVC1a6AjvJaheqMH.WWku', 'dfae37087e62faa0347192cd5b418ff1', '168.1.83.136', 'testaccount', 'test', 'test', 'default.png', 1542515305, '11-2018', 1542623088, '', '', '', '', 1, '', '0.00', 0, 10, 0, 1, '', 29, 0, '16,14,6,'),
(31, 'me@thyago.in', '$2a$12$KGXng.A39WM/WFOU2UtP.uPj3ZZ6qoAkpwTZBvZNlXuST/hxh3QTm', '45246e836cd9894bd9cd2a0a2a30b892', '179.238.194.54', 'tbdsilva', 'Thyago', 'Silva', 'default.png', 1542641305, '11-2018', 1542641313, '', '', '', '', 0, '', '0.00', 0, 10, 0, 1, '', 0, 0, ','),
(32, 'luc@positionone.com.au', '$2a$12$svNi/hSrzW5OE2FsW6DGUeB4gA.7IHkLTU77D9q0CL29PcYd/0Omq', '9f713555ed9a05b7adc1c31ccffcf47e', '118.210.219.66', 'Positionone', 'Luc', 'Iovenitti', 'default.png', 1544059309, '12-2018', 1547518527, '', '', '', '', 0, '', '0.00', 0, 10, 0, 1, '', 31, 0, '13,11,8,6,5,4,2,'),
(33, 'michael@firstassetmanagement.com.au', '$2a$12$6U2ZRbIX4GGD5g6UsHu/QuZYtBF0VIFZQDewYBaL.EajxN6hA7G/G', '3200751dfad34c87473203481b91b80d', '36.67.35.123', 'firstassetmanagement', 'Michael', 'Greenup', 'default.png', 1545013010, '12-2018', 1545029710, '', '', '', '', 1, '', '0.00', 0, 10, 0, 1, '', 0, 0, '15,14,11,8,7,6,5,4,3,2,'),
(34, 'sharon@bluecommercial.com.au', '$2a$12$mucbRv4B5CpIrGOWuz19P.ndRtDTGbmgyx7WyDFdzWnKCy7MmjrxC', 'b6f0ddc386e0bb5055e756b2660e5dd1', '118.210.219.66', 'Bluecommercial', 'Sharon', 'O&#039;Sullivan', 'default.png', 1547415329, '1-2019', 1547425361, '', '', '', '', 0, '', '0.00', 0, 10, 0, 1, '', 0, 0, '16,15,14,13,12,11,8,7,6,5,4,3,2,');

-- --------------------------------------------------------

--
-- Table structure for table `user_custom_fields`
--

CREATE TABLE IF NOT EXISTS `user_custom_fields` (
`ID` int(11) NOT NULL,
  `userid` int(11) NOT NULL,
  `fieldid` int(11) NOT NULL,
  `value` text COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `user_events`
--

CREATE TABLE IF NOT EXISTS `user_events` (
`ID` int(11) NOT NULL,
  `IP` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `event` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `timestamp` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `user_groups`
--

CREATE TABLE IF NOT EXISTS `user_groups` (
`ID` int(11) NOT NULL,
  `name` varchar(40) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `default` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `user_groups`
--

INSERT INTO `user_groups` (`ID`, `name`, `default`) VALUES
(1, 'Default Group', 1);

-- --------------------------------------------------------

--
-- Table structure for table `user_group_users`
--

CREATE TABLE IF NOT EXISTS `user_group_users` (
`ID` int(11) NOT NULL,
  `groupid` int(11) NOT NULL DEFAULT '0',
  `userid` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

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
(28, 1, 29),
(29, 1, 30),
(30, 1, 31),
(31, 1, 32),
(32, 1, 33),
(33, 1, 34);

-- --------------------------------------------------------

--
-- Table structure for table `user_notifications`
--

CREATE TABLE IF NOT EXISTS `user_notifications` (
`ID` int(11) NOT NULL,
  `userid` int(11) NOT NULL,
  `url` varchar(1000) COLLATE utf8_unicode_ci NOT NULL,
  `timestamp` int(11) NOT NULL,
  `status` int(11) NOT NULL,
  `message` varchar(1000) COLLATE utf8_unicode_ci NOT NULL,
  `fromid` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=160 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

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
(43, 5, 'client/view_job/66', 1541559682, 0, 'has replied to your Job and awaits your response.', 1),
(44, 5, 'client/view_job/82', 1542057590, 0, 'has replied to your Job and awaits your response.', 1),
(45, 5, 'client/view_job/84', 1542158518, 0, 'has replied to your Job and awaits your response.', 1),
(46, 30, 'client/view_job/87', 1542515485, 0, 'has replied to your Job and awaits your response.', 1),
(47, 30, 'client/view_job/86', 1542515708, 0, 'has replied to your Job and awaits your response.', 1),
(48, 30, 'client/view_job/87', 1542516591, 0, 'has replied to your Job and awaits your response.', 1),
(49, 30, 'client/view_job/87', 1542516758, 0, 'has replied to your Job and awaits your response.', 1),
(50, 30, 'client/view_job/87', 1542529085, 0, 'has replied to your Job and awaits your response.', 1),
(51, 30, 'client/view_job/87', 1542529343, 0, 'has replied to your Job and awaits your response.', 1),
(52, 30, 'client/view_job/87', 1542529538, 0, 'has replied to your Job and awaits your response.', 1),
(53, 30, 'client/view_job/87', 1542529704, 0, 'has replied to your Job and awaits your response.', 1),
(54, 30, 'client/view_job/87', 1542530463, 0, 'has replied to your Job and awaits your response.', 1),
(55, 30, 'client/view_job/87', 1542530584, 0, 'has replied to your Job and awaits your response.', 1),
(56, 30, 'client/view_job/87', 1542530943, 0, 'has replied to your Job and awaits your response.', 1),
(57, 30, 'client/view_job/87', 1542531338, 0, 'has replied to your Job and awaits your response.', 1),
(58, 30, 'client/view_job/87', 1542531685, 0, 'has replied to your Job and awaits your response.', 1),
(59, 30, 'client/view_job/87', 1542538702, 0, 'has replied to your Job and awaits your response.', 1),
(60, 30, 'client/view_job/87', 1542538983, 0, 'has replied to your Job and awaits your response.', 1),
(61, 1, 'jobs/view/88', 1542539138, 1, 'has replied to your Job and awaits your response.', 1),
(62, 30, 'client/view_job/87', 1542539296, 0, 'has replied to your Job and awaits your response.', 1),
(63, 1, 'jobs/view/88', 1542539881, 0, 'has replied to your Job and awaits your response.', 1),
(64, 1, 'jobs/view/88', 1542540196, 1, 'has replied to your Job and awaits your response.', 1),
(65, 30, 'client/view_job/87', 1542547576, 0, 'has replied to your Job and awaits your response.', 1),
(66, 30, 'client/view_job/87', 1542548970, 0, 'has replied to your Job and awaits your response.', 1),
(67, 30, 'client/view_job/87', 1542549371, 0, 'has replied to your Job and awaits your response.', 1),
(68, 30, 'client/view_job/87', 1542549497, 0, 'has replied to your Job and awaits your response.', 1),
(69, 30, 'client/view_job/87', 1542555741, 0, 'has replied to your Job and awaits your response.', 1),
(70, 30, 'client/view_job/87', 1542555897, 0, 'has replied to your Job and awaits your response.', 1),
(71, 30, 'client/view_job/87', 1542556363, 0, 'has replied to your Job and awaits your response.', 1),
(72, 30, 'client/view_job/87', 1542557622, 0, 'has replied to your Job and awaits your response.', 1),
(73, 30, 'client/view_job/87', 1542557796, 0, 'has replied to your Job and awaits your response.', 1),
(74, 30, 'client/view_job/87', 1542557896, 0, 'has replied to your Job and awaits your response.', 1),
(75, 30, 'client/view_job/87', 1542558450, 0, 'has replied to your Job and awaits your response.', 1),
(76, 30, 'client/view_job/87', 1542558803, 0, 'has replied to your Job and awaits your response.', 1),
(77, 30, 'client/view_job/87', 1542559085, 0, 'has replied to your Job and awaits your response.', 1),
(78, 1, 'jobs/view/88', 1542576896, 0, 'has replied to your Job and awaits your response.', 1),
(79, 1, 'jobs/view/88', 1542577085, 0, 'has replied to your Job and awaits your response.', 1),
(80, 1, 'jobs/view/88', 1542577373, 0, 'has replied to your Job and awaits your response.', 1),
(81, 4, 'client/view_job/89', 1542582558, 0, 'has replied to your Job and awaits your response.', 1),
(82, 4, 'client/view_job/93', 1542604073, 0, 'has replied to your Job and awaits your response.', 1),
(83, 1, 'jobs/view/88', 1542666293, 0, 'has replied to your Job and awaits your response.', 1),
(84, 1, 'jobs/view/88', 1542667661, 0, 'has replied to your Job and awaits your response.', 1),
(85, 4, 'client/view_job/96', 1542685191, 0, 'has replied to your Job and awaits your response.', 1),
(86, 5, 'client/view_job/99', 1542922456, 0, 'has replied to your Job and awaits your response.', 1),
(87, 5, 'client/view_job/98', 1542922512, 0, 'has replied to your Job and awaits your response.', 1),
(88, 5, 'client/view_job/71', 1542929622, 0, 'has replied to your Job and awaits your response.', 1),
(89, 5, 'client/view_job/102', 1543382348, 0, 'has replied to your Job and awaits your response.', 1),
(90, 5, 'client/view_job/101', 1543442406, 0, 'has replied to your Job and awaits your response.', 1),
(91, 5, 'client/view_job/100', 1543449931, 0, 'has replied to your Job and awaits your response.', 1),
(92, 5, 'client/view_job/103', 1543472104, 0, 'has replied to your Job and awaits your response.', 1),
(93, 5, 'client/view_job/113', 1543810913, 0, 'has replied to your Job and awaits your response.', 1),
(94, 5, 'client/view_job/112', 1543811669, 0, 'has replied to your Job and awaits your response.', 1),
(95, 5, 'client/view_job/106', 1543814695, 0, 'has replied to your Job and awaits your response.', 1),
(96, 5, 'client/view_job/104', 1543815795, 0, 'has replied to your Job and awaits your response.', 1),
(97, 5, 'client/view_job/107', 1543818763, 0, 'has replied to your Job and awaits your response.', 1),
(98, 5, 'client/view_job/114', 1543818843, 0, 'has replied to your Job and awaits your response.', 1),
(99, 5, 'client/view_job/109', 1543883542, 0, 'has replied to your Job and awaits your response.', 1),
(100, 5, 'client/view_job/116', 1543889271, 0, 'has replied to your Job and awaits your response.', 1),
(101, 5, 'client/view_job/115', 1543889318, 0, 'has replied to your Job and awaits your response.', 1),
(102, 5, 'client/view_job/108', 1543904765, 0, 'has replied to your Job and awaits your response.', 1),
(103, 5, 'client/view_job/110', 1543906414, 0, 'has replied to your Job and awaits your response.', 1),
(104, 5, 'client/view_job/111', 1543908192, 0, 'has replied to your Job and awaits your response.', 1),
(105, 5, 'client/view_job/120', 1543958812, 0, 'has replied to your Job and awaits your response.', 1),
(106, 5, 'client/view_job/122', 1543960151, 0, 'has replied to your Job and awaits your response.', 1),
(107, 5, 'client/view_job/119', 1543969084, 0, 'has replied to your Job and awaits your response.', 1),
(108, 5, 'client/view_job/117', 1543970245, 0, 'has replied to your Job and awaits your response.', 1),
(109, 5, 'client/view_job/118', 1543986452, 0, 'has replied to your Job and awaits your response.', 1),
(110, 5, 'client/view_job/121', 1543987399, 0, 'has replied to your Job and awaits your response.', 1),
(111, 32, 'client/view_job/124', 1544226261, 0, 'has replied to your Job and awaits your response.', 1),
(112, 32, 'client/view_job/127', 1544226296, 0, 'has replied to your Job and awaits your response.', 1),
(113, 32, 'client/view_job/128', 1544226326, 0, 'has replied to your Job and awaits your response.', 1),
(114, 32, 'client/view_job/130', 1544226822, 0, 'has replied to your Job and awaits your response.', 1),
(115, 32, 'client/view_job/129', 1544227794, 0, 'has replied to your Job and awaits your response.', 1),
(116, 32, 'client/view_job/125', 1544227855, 0, 'has replied to your Job and awaits your response.', 1),
(117, 32, 'client/view_job/126', 1544230242, 0, 'has replied to your Job and awaits your response.', 1),
(118, 5, 'client/view_job/123', 1544395874, 0, 'has replied to your Job and awaits your response.', 1),
(119, 5, 'client/view_job/131', 1544472519, 0, 'has replied to your Job and awaits your response.', 1),
(120, 5, 'client/view_job/133', 1545183820, 0, 'has replied to your Job and awaits your response.', 1),
(121, 5, 'client/view_job/132', 1545194267, 0, 'has replied to your Job and awaits your response.', 1),
(122, 5, 'client/view_job/134', 1545194297, 0, 'has replied to your Job and awaits your response.', 1),
(123, 5, 'client/view_job/138', 1545195717, 0, 'has replied to your Job and awaits your response.', 1),
(124, 32, 'client/view_job/136', 1545199260, 0, 'has replied to your Job and awaits your response.', 1),
(125, 32, 'client/view_job/137', 1545200902, 0, 'has replied to your Job and awaits your response.', 1),
(126, 32, 'client/view_job/135', 1545201793, 0, 'has replied to your Job and awaits your response.', 1),
(127, 5, 'client/view_job/153', 1545340129, 0, 'has replied to your Job and awaits your response.', 1),
(128, 5, 'client/view_job/153', 1545340169, 0, 'has replied to your Job and awaits your response.', 1),
(129, 5, 'client/view_job/140', 1545340211, 0, 'has replied to your Job and awaits your response.', 1),
(130, 5, 'client/view_job/141', 1545342306, 0, 'has replied to your Job and awaits your response.', 1),
(131, 32, 'client/view_job/151', 1545347205, 0, 'has replied to your Job and awaits your response.', 1),
(132, 32, 'client/view_job/145', 1545347245, 0, 'has replied to your Job and awaits your response.', 1),
(133, 32, 'client/view_job/147', 1545348002, 0, 'has replied to your Job and awaits your response.', 1),
(134, 32, 'client/view_job/149', 1545349331, 0, 'has replied to your Job and awaits your response.', 1),
(135, 5, 'client/view_job/142', 1545351392, 0, 'has replied to your Job and awaits your response.', 1),
(136, 32, 'client/view_job/148', 1545352610, 0, 'has replied to your Job and awaits your response.', 1),
(137, 32, 'client/view_job/150', 1545364109, 0, 'has replied to your Job and awaits your response.', 1),
(138, 32, 'client/view_job/150', 1545364123, 0, 'has replied to your Job and awaits your response.', 1),
(139, 5, 'client/view_job/157', 1546805923, 0, 'has replied to your Job and awaits your response.', 1),
(140, 5, 'client/view_job/154', 1546805967, 0, 'has replied to your Job and awaits your response.', 1),
(141, 5, 'client/view_job/144', 1546806005, 0, 'has replied to your Job and awaits your response.', 1),
(142, 5, 'client/view_job/143', 1546806054, 0, 'has replied to your Job and awaits your response.', 1),
(143, 5, 'client/view_job/159', 1546806249, 0, 'has replied to your Job and awaits your response.', 1),
(144, 32, 'client/view_job/173', 1546991322, 0, 'has replied to your Job and awaits your response.', 1),
(145, 32, 'client/view_job/176', 1546991364, 0, 'has replied to your Job and awaits your response.', 1),
(146, 32, 'client/view_job/168', 1546992158, 0, 'has replied to your Job and awaits your response.', 1),
(147, 32, 'client/view_job/166', 1546992383, 0, 'has replied to your Job and awaits your response.', 1),
(148, 32, 'client/view_job/167', 1546992419, 0, 'has replied to your Job and awaits your response.', 1),
(149, 32, 'client/view_job/171', 1546995052, 0, 'has replied to your Job and awaits your response.', 1),
(150, 32, 'client/view_job/175', 1546995399, 0, 'has replied to your Job and awaits your response.', 1),
(151, 32, 'client/view_job/164', 1546995435, 0, 'has replied to your Job and awaits your response.', 1),
(152, 32, 'client/view_job/175', 1546995792, 0, 'has replied to your Job and awaits your response.', 1),
(153, 32, 'client/view_job/172', 1546998053, 0, 'has replied to your Job and awaits your response.', 1),
(154, 32, 'client/view_job/174', 1547000740, 0, 'has replied to your Job and awaits your response.', 1),
(155, 5, 'client/view_job/161', 1547094149, 0, 'has replied to your Job and awaits your response.', 1),
(156, 32, 'client/view_job/177', 1547161591, 0, 'has replied to your Job and awaits your response.', 1),
(157, 32, 'client/view_job/163', 1547162897, 0, 'has replied to your Job and awaits your response.', 1),
(158, 5, 'client/view_job/160', 1547165629, 0, 'has replied to your Job and awaits your response.', 1),
(159, 32, 'client/view_job/189', 1548006923, 0, 'has replied to your Job and awaits your response.', 1);

-- --------------------------------------------------------

--
-- Table structure for table `user_roles`
--

CREATE TABLE IF NOT EXISTS `user_roles` (
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
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

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

CREATE TABLE IF NOT EXISTS `user_role_permissions` (
`ID` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(500) COLLATE utf8_unicode_ci NOT NULL,
  `classname` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `hook` varchar(255) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

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
-- Indexes for table `artwork_status`
--
ALTER TABLE `artwork_status`
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
-- AUTO_INCREMENT for table `artwork_status`
--
ALTER TABLE `artwork_status`
MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=4;
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
MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=10;
--
-- AUTO_INCREMENT for table `home_stats`
--
ALTER TABLE `home_stats`
MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
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
MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=211;
--
-- AUTO_INCREMENT for table `job_categories`
--
ALTER TABLE `job_categories`
MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `job_category_groups`
--
ALTER TABLE `job_category_groups`
MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `job_custom_fields`
--
ALTER TABLE `job_custom_fields`
MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=20;
--
-- AUTO_INCREMENT for table `job_custom_field_cats`
--
ALTER TABLE `job_custom_field_cats`
MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=40;
--
-- AUTO_INCREMENT for table `job_files`
--
ALTER TABLE `job_files`
MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=246;
--
-- AUTO_INCREMENT for table `job_history`
--
ALTER TABLE `job_history`
MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=680;
--
-- AUTO_INCREMENT for table `job_replies`
--
ALTER TABLE `job_replies`
MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=163;
--
-- AUTO_INCREMENT for table `job_user_custom_fields`
--
ALTER TABLE `job_user_custom_fields`
MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=1806;
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
MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=43;
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
MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `reset_log`
--
ALTER TABLE `reset_log`
MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `site_layouts`
--
ALTER TABLE `site_layouts`
MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `site_settings`
--
ALTER TABLE `site_settings`
MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=35;
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
MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `user_group_users`
--
ALTER TABLE `user_group_users`
MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=34;
--
-- AUTO_INCREMENT for table `user_notifications`
--
ALTER TABLE `user_notifications`
MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=160;
--
-- AUTO_INCREMENT for table `user_roles`
--
ALTER TABLE `user_roles`
MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=11;
--
-- AUTO_INCREMENT for table `user_role_permissions`
--
ALTER TABLE `user_role_permissions`
MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=10;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
