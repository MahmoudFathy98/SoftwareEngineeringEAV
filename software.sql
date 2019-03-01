-- phpMyAdmin SQL Dump
-- version 4.7.9
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Mar 01, 2019 at 08:54 PM
-- Server version: 5.7.21
-- PHP Version: 5.6.35

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `software`
--

-- --------------------------------------------------------

--
-- Table structure for table `activities`
--

DROP TABLE IF EXISTS `activities`;
CREATE TABLE IF NOT EXISTS `activities` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `categoryID` int(11) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `links`
--

DROP TABLE IF EXISTS `links`;
CREATE TABLE IF NOT EXISTS `links` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `pageID` int(11) NOT NULL,
  `typeID` int(11) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `typeID` (`typeID`),
  KEY `pageID` (`pageID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `pages`
--

DROP TABLE IF EXISTS `pages`;
CREATE TABLE IF NOT EXISTS `pages` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `URL` varchar(300) NOT NULL,
  `friendlyURL` varchar(300) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
CREATE TABLE IF NOT EXISTS `user` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `usertypeID` int(11) NOT NULL,
  `isdeleted` int(5) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM AUTO_INCREMENT=49 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`ID`, `usertypeID`, `isdeleted`) VALUES
(48, 1, 0);

-- --------------------------------------------------------

--
-- Table structure for table `useroptions`
--

DROP TABLE IF EXISTS `useroptions`;
CREATE TABLE IF NOT EXISTS `useroptions` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(300) NOT NULL,
  `Type` varchar(300) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `useroptions`
--

INSERT INTO `useroptions` (`ID`, `Name`, `Type`) VALUES
(1, 'الاسم الاول', 'text'),
(2, 'اسم الاب', 'text'),
(3, 'اسم العائلة', 'text'),
(4, 'اسم الجد', 'text'),
(5, 'اسم المستخدم', 'text'),
(6, 'كلمة السر', 'text'),
(7, 'الجنس', 'text'),
(8, 'تاريخ الميلاد', 'text'),
(9, 'رقم البطاقة', 'text'),
(10, 'رقم الهاتف المحمول', 'text'),
(11, 'البريد الالكتروني', 'text'),
(12, 'الجنسية', 'text'),
(13, 'العنوان', 'text'),
(14, 'المحافظة', 'text'),
(15, 'افضل طريقة للتواصل', 'text');

-- --------------------------------------------------------

--
-- Table structure for table `usertype`
--

DROP TABLE IF EXISTS `usertype`;
CREATE TABLE IF NOT EXISTS `usertype` (
  `ID` int(50) NOT NULL AUTO_INCREMENT,
  `Name` varchar(40) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `usertype`
--

INSERT INTO `usertype` (`ID`, `Name`) VALUES
(1, 'volunteer');

-- --------------------------------------------------------

--
-- Table structure for table `usertypeoptions`
--

DROP TABLE IF EXISTS `usertypeoptions`;
CREATE TABLE IF NOT EXISTS `usertypeoptions` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `usertypeID` int(11) NOT NULL,
  `optionID` int(11) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `usertypeoptions`
--

INSERT INTO `usertypeoptions` (`ID`, `usertypeID`, `optionID`) VALUES
(1, 1, 1),
(2, 1, 2),
(3, 1, 3),
(4, 1, 4),
(5, 1, 5),
(6, 1, 6),
(7, 1, 7),
(8, 1, 8),
(9, 1, 9),
(10, 1, 10),
(11, 1, 11),
(12, 1, 12),
(13, 1, 13);

-- --------------------------------------------------------

--
-- Table structure for table `uservalues`
--

DROP TABLE IF EXISTS `uservalues`;
CREATE TABLE IF NOT EXISTS `uservalues` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `userID` int(11) NOT NULL,
  `usertypeoptionsID` int(11) NOT NULL,
  `value` varchar(300) NOT NULL,
  `isdeleted` int(5) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM AUTO_INCREMENT=119 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `uservalues`
--

INSERT INTO `uservalues` (`ID`, `userID`, `usertypeoptionsID`, `value`, `isdeleted`) VALUES
(118, 48, 13, 'sheraton', 0),
(117, 48, 12, 'egyptionnos', 0),
(116, 48, 11, 'sarah@gmail.com', 0),
(115, 48, 10, '01143507334', 0),
(114, 48, 9, '0123456', 0),
(113, 48, 8, '171199', 0),
(112, 48, 7, 'female', 0),
(111, 48, 6, '123', 0),
(109, 48, 4, 'سعد', 0),
(110, 48, 5, 'sarah', 0),
(108, 48, 3, 'محمد علي', 0),
(106, 48, 1, 'سارة', 0),
(107, 48, 2, 'فؤاد', 0);

-- --------------------------------------------------------

--
-- Table structure for table `voldetails`
--

DROP TABLE IF EXISTS `voldetails`;
CREATE TABLE IF NOT EXISTS `voldetails` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `activityID` int(11) NOT NULL,
  `volID` int(11) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `activityID` (`activityID`),
  KEY `volID` (`volID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `volunteerism`
--

DROP TABLE IF EXISTS `volunteerism`;
CREATE TABLE IF NOT EXISTS `volunteerism` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `userID` int(11) NOT NULL,
  `activityID` int(11) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `userID` (`userID`),
  KEY `activityID` (`activityID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
