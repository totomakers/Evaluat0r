/*
SQLyog Community v12.12 (64 bit)
MySQL - 5.6.26 : Database - evaluat0r
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
/*Table structure for table `session_candidate` */

DROP TABLE IF EXISTS `session_candidate`;

CREATE TABLE `session_candidate` (
  `session_id` int(10) unsigned NOT NULL,
  `account_id` int(10) unsigned NOT NULL,
  `created_at` datetime NOT NULL,
  PRIMARY KEY (`session_id`,`account_id`),
  KEY `FK_SESSION_CANDIDATE_ACCOUNT` (`account_id`),
  CONSTRAINT `FK_SESSION_CANDIDATE_ACCOUNT` FOREIGN KEY (`account_id`) REFERENCES `account` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_SESSION_CANDIDATE_SESSION` FOREIGN KEY (`session_id`) REFERENCES `session` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
