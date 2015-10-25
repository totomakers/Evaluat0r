/*
SQLyog Community v12.12 (64 bit)
MySQL - 10.0.21-MariaDB : Database - evaluat0r
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
/*Table structure for table `template_theme` */

DROP TABLE IF EXISTS `template_theme`;

CREATE TABLE `template_theme` (
  `template_id` int(10) unsigned NOT NULL COMMENT 'Identifiant du template',
  `theme_id` int(10) unsigned NOT NULL COMMENT 'Identifiant du theme',
  `question_count` int(10) unsigned NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`template_id`,`theme_id`),
  KEY `question_count` (`question_count`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
