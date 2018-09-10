-- MySQL dump 10.13  Distrib 5.7.12, for Win64 (x86_64)
--
-- Host: localhost    Database: zy_crm
-- ------------------------------------------------------
-- Server version	5.7.17-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `customer`
--

DROP TABLE IF EXISTS `customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `customer` (
  `customer_id` int(11) NOT NULL AUTO_INCREMENT,
  `customer_state_id` int(11) DEFAULT NULL,
  `customer_source_id` int(11) DEFAULT NULL,
  `customer_category_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `customer_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `customer_is_male` bit(1) DEFAULT NULL,
  `customer_mobile` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `customer_qq` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `customer_address` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `customer_email` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `customer_remark` varchar(500) COLLATE utf8_unicode_ci DEFAULT NULL,
  `customer_position` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `customer_blog` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `customer_tel` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `customer_birth` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `customer_company` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `status` tinyint(4) DEFAULT NULL,
  `remark` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `creater` int(11) DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `updater` int(11) DEFAULT NULL,
  PRIMARY KEY (`customer_id`),
  KEY `fk_customer_state` (`customer_state_id`),
  KEY `fk_customer_source` (`customer_source_id`),
  KEY `fk_customer_category` (`customer_category_id`),
  CONSTRAINT `fk_customer_category` FOREIGN KEY (`customer_category_id`) REFERENCES `customer_category` (`customer_category_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_customer_source` FOREIGN KEY (`customer_source_id`) REFERENCES `customer_source` (`customer_source_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_customer_state` FOREIGN KEY (`customer_state_id`) REFERENCES `customer_state` (`customer_state_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer`
--

LOCK TABLES `customer` WRITE;
/*!40000 ALTER TABLE `customer` DISABLE KEYS */;
/*!40000 ALTER TABLE `customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer_care`
--

DROP TABLE IF EXISTS `customer_care`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `customer_care` (
  `customer_care_id` int(11) NOT NULL AUTO_INCREMENT,
  `customer_id` int(11) DEFAULT NULL,
  `subject` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `type` tinyint(4) DEFAULT NULL,
  `next_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `status` tinyint(4) DEFAULT NULL,
  `remark` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `creater` int(11) DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `updater` int(11) DEFAULT NULL,
  PRIMARY KEY (`customer_care_id`),
  KEY `fk_customer_care` (`customer_id`),
  CONSTRAINT `fk_customer_care` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer_care`
--

LOCK TABLES `customer_care` WRITE;
/*!40000 ALTER TABLE `customer_care` DISABLE KEYS */;
/*!40000 ALTER TABLE `customer_care` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer_category`
--

DROP TABLE IF EXISTS `customer_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `customer_category` (
  `customer_category_id` int(11) NOT NULL AUTO_INCREMENT,
  `customer_category_name` varchar(15) COLLATE utf8_unicode_ci DEFAULT NULL,
  `customer_category_desc` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `status` tinyint(4) DEFAULT NULL,
  `remark` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `creater` int(11) DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `updater` int(11) DEFAULT NULL,
  PRIMARY KEY (`customer_category_id`),
  KEY `customer_category_desc` (`customer_category_desc`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer_category`
--

LOCK TABLES `customer_category` WRITE;
/*!40000 ALTER TABLE `customer_category` DISABLE KEYS */;
INSERT INTO `customer_category` VALUES (1,'客户','员工发展出来的客户',2,NULL,'2017-06-22 16:55:47',2,NULL,NULL),(2,'合作伙伴','有长期的合作关系...',2,NULL,'2017-06-22 16:56:35',2,'2017-06-22 16:56:35',2);
/*!40000 ALTER TABLE `customer_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer_source`
--

DROP TABLE IF EXISTS `customer_source`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `customer_source` (
  `customer_source_id` int(11) NOT NULL AUTO_INCREMENT,
  `customer_source_name` varchar(15) COLLATE utf8_unicode_ci DEFAULT NULL,
  `customer_source_desc` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `status` tinyint(4) DEFAULT NULL,
  `remark` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `creater` int(11) DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `updater` int(11) DEFAULT NULL,
  PRIMARY KEY (`customer_source_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer_source`
--

LOCK TABLES `customer_source` WRITE;
/*!40000 ALTER TABLE `customer_source` DISABLE KEYS */;
INSERT INTO `customer_source` VALUES (1,NULL,NULL,-2,NULL,'2017-06-22 10:38:32',2,'2017-06-22 10:38:32',2),(2,'招生一部','招生一部校招学生...',-2,NULL,'2017-06-22 11:12:02',2,'2017-06-22 11:12:02',2),(3,'招生二部','招生二部校招学生..',2,NULL,'2017-06-22 11:11:57',2,'2017-06-22 11:11:57',2),(4,'招生三部','招生三部...',2,NULL,'2017-06-22 11:12:21',2,NULL,NULL);
/*!40000 ALTER TABLE `customer_source` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer_state`
--

DROP TABLE IF EXISTS `customer_state`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `customer_state` (
  `customer_state_id` int(11) NOT NULL AUTO_INCREMENT,
  `customer_state_name` varchar(15) COLLATE utf8_unicode_ci DEFAULT NULL,
  `customer_state_desc` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `status` tinyint(4) DEFAULT NULL,
  `remark` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `creater` int(11) DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `updater` int(11) DEFAULT NULL,
  PRIMARY KEY (`customer_state_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer_state`
--

LOCK TABLES `customer_state` WRITE;
/*!40000 ALTER TABLE `customer_state` DISABLE KEYS */;
INSERT INTO `customer_state` VALUES (1,'潜在客户','有可能成发展成为交易客户',2,NULL,'2017-06-22 16:21:05',2,NULL,NULL),(2,'意见客户','有意成交的客户',2,NULL,'2017-06-22 16:21:26',2,NULL,NULL),(3,'交易客户','正在交易中的客户',2,NULL,'2017-06-22 16:37:05',2,'2017-06-22 16:37:06',2),(4,'成交客户','已经交易过的老客户',2,NULL,'2017-06-22 16:37:18',2,'2017-06-22 16:37:18',2);
/*!40000 ALTER TABLE `customer_state` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `department`
--

DROP TABLE IF EXISTS `department`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `department` (
  `department_id` int(11) NOT NULL AUTO_INCREMENT,
  `department_name` varchar(15) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '部门名称',
  `department_desc` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '部门描述',
  `status` tinyint(4) DEFAULT NULL COMMENT '部门状态',
  `remark` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `creater` int(11) DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `updater` int(11) DEFAULT NULL,
  PRIMARY KEY (`department_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `department`
--

LOCK TABLES `department` WRITE;
/*!40000 ALTER TABLE `department` DISABLE KEYS */;
INSERT INTO `department` VALUES (1,'教学部','负责教学工作，负责教师工作',2,NULL,'2017-06-22 00:02:28',2,'2017-06-22 00:02:28',2),(2,'招生部','负责招生工作',2,NULL,'2017-06-22 00:03:42',2,'2017-06-22 00:03:42',NULL),(3,'人力资源部','负责招聘，社保工作',2,NULL,'2017-06-22 00:07:06',2,'2017-06-22 00:07:07',2),(4,'行政部','行政部行政部行政部',2,NULL,'2017-06-22 11:50:59',2,NULL,NULL);
/*!40000 ALTER TABLE `department` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `message`
--

DROP TABLE IF EXISTS `message`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `message` (
  `message_id` int(11) NOT NULL AUTO_INCREMENT,
  `subject` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `content` varchar(2000) COLLATE utf8_unicode_ci DEFAULT NULL,
  `sender` int(11) DEFAULT NULL,
  `save_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `send_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `send_delete` tinyint(1) DEFAULT NULL,
  `send_status` tinyint(4) DEFAULT NULL,
  `send_update_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `receiver` int(11) DEFAULT NULL,
  `receive_delete` tinyint(1) DEFAULT NULL,
  `receive_status` tinyint(4) DEFAULT NULL,
  `receive_update_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`message_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `message`
--

LOCK TABLES `message` WRITE;
/*!40000 ALTER TABLE `message` DISABLE KEYS */;
INSERT INTO `message` VALUES (1,'发一个消息给管理员','发一个消息给管理员发一个消息给管理员发一个消息给管理员发一个消息给管理员发一个消息给管理员',2,'2017-06-23 05:32:20','2017-06-23 05:32:20',2,2,'2017-06-23 05:32:20',3,2,0,'2017-06-23 05:32:20'),(2,'发一个消息给管理员','发一个消息给管理员发一个消息给管理员发一个消息给管理员发一个消息给管理员发一个消息给管理员',1,'2017-06-23 04:09:49','2017-06-23 04:09:49',2,0,'2017-06-23 04:09:49',2,2,0,'2017-06-23 04:09:49');
/*!40000 ALTER TABLE `message` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notice`
--

DROP TABLE IF EXISTS `notice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `notice` (
  `notice_id` int(11) NOT NULL AUTO_INCREMENT,
  `receive_id` int(11) NOT NULL DEFAULT '0',
  `subject` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `text` text COLLATE utf8_unicode_ci NOT NULL,
  `pub_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  `expire_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  `status` tinyint(4) NOT NULL DEFAULT '2',
  `remark` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `create_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  `creater` int(11) NOT NULL,
  `update_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `updater` int(11) DEFAULT NULL,
  PRIMARY KEY (`notice_id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notice`
--

LOCK TABLES `notice` WRITE;
/*!40000 ALTER TABLE `notice` DISABLE KEYS */;
INSERT INTO `notice` VALUES (1,0,'欢迎沙僧加入取经团队','沙僧，又叫沙和尚、沙悟净，出自四大名著之《西游记》。在书中也称黄婆，土母、刀圭，五行属土，俗称沙和尚、沙僧。原为天宫玉皇大帝的卷帘大将，因为失手不小心打破了琉璃盏，触犯天条，被贬出天界，在人间流沙河兴风作浪，危害一方，专吃过路人。后经观音点化，赐法号悟净，一心归佛，同八戒、悟空一同保大唐高僧玄奘法师（又称唐三藏或唐僧，俗名陈祎）西天拜佛求取真经。 ','2017-06-18 03:18:57','2017-06-18 03:18:57',-2,NULL,'2017-06-18 03:18:57',2,'2017-06-18 03:18:57',2),(2,0,'欢迎沙僧加入取经团队','沙僧，又叫沙和尚、沙悟净，出自四大名著之《西游记》。在书中也称黄婆，土母、刀圭，五行属土，俗称沙和尚、沙僧。原为天宫玉皇大帝的卷帘大将，因为失手不小心打破了琉璃盏，触犯天条，被贬出天界，在人间流沙河兴风作浪，危害一方，专吃过路人。后经观音点化，赐法号悟净，一心归佛，同八戒、悟空一同保大唐高僧玄奘法师（又称唐三藏或唐僧，俗名陈祎）西天拜佛求取真经。12345678','2017-06-10 04:33:52','2017-06-10 04:33:52',2,NULL,'2017-06-18 03:58:09',2,'2017-06-18 03:58:10',0),(3,0,'欢迎沙僧加入取经团队','沙僧，又叫沙和尚、沙悟净，出自四大名著之《西游记》。在书中也称黄婆，土母、刀圭，五行属土，俗称沙和尚、沙僧。原为天宫玉皇大帝的卷帘大将，因为失手不小心打破了琉璃盏，触犯天条，被贬出天界，在人间流沙河兴风作浪，危害一方，专吃过路人。后经观音点化，赐法号悟净，一心归佛，同八戒、悟空一同保大唐高僧玄奘法师（又称唐三藏或唐僧，俗名陈祎）西天拜佛求取真经。','2017-06-10 04:33:52','2017-06-10 04:33:52',2,NULL,'2017-06-10 04:33:52',2,'2017-06-10 04:33:52',2),(4,0,'欢迎猪八戒加入取经团队','猪八戒是吴承恩所作《西游记》中的角色。又名猪刚鬣，法号悟能，浑名八戒，是唐僧的二徒弟，会三十六天罡变，所持武器为太上老君所造、玉皇大帝亲赐的上宝沁金钯（俗称九齿钉钯）。猪八戒前世为执掌天河八万水军的天蓬元帅。《 西游记》中各路神仙基本借鉴了正统道教神仙录，由高老庄一集猪八戒提及可见，猪八戒的前世天蓬元帅即是水神天河宪节。\r\n因调戏霓裳仙子并且惹来纠察灵官后，又拱倒斗牛宫被贬下凡尘，却又错投猪胎，后受观音点化，成为唐僧的弟子，与孙悟空一同保护唐僧去西天取经，最后被封为净坛使者。','2017-06-10 04:33:52','2017-06-10 04:33:52',2,NULL,'2017-06-10 04:33:52',2,'2017-06-10 04:33:52',2),(5,0,'欢迎猪八戒加入取经团队','猪八戒是吴承恩所作《西游记》中的角色。又名猪刚鬣，法号悟能，浑名八戒，是唐僧的二徒弟，会三十六天罡变，所持武器为太上老君所造、玉皇大帝亲赐的上宝沁金钯（俗称九齿钉钯）。猪八戒前世为执掌天河八万水军的天蓬元帅。《 西游记》中各路神仙基本借鉴了正统道教神仙录，由高老庄一集猪八戒提及可见，猪八戒的前世天蓬元帅即是水神天河宪节。','2017-06-08 10:47:39','2017-06-08 10:47:39',2,NULL,'2017-06-10 04:20:12',2,'2017-06-10 04:20:12',0),(6,0,'欢迎猪八戒加入取经团队','猪八戒是吴承恩所作《西游记》中的角色。又名猪刚鬣，法号悟能，浑名八戒，是唐僧的二徒弟，会三十六天罡变，所持武器为太上老君所造、玉皇大帝亲赐的上宝沁金钯（俗称九齿钉钯）。猪八戒前世为执掌天河八万水军的天蓬元帅。《 西游记》中各路神仙基本借鉴了正统道教神仙录，由高老庄一集猪八戒提及可见，猪八戒的前世天蓬元帅即是水神天河宪节。','2017-06-08 10:47:39','2017-06-08 10:47:39',2,NULL,'2017-06-08 10:47:39',2,'2017-06-08 10:47:39',NULL),(7,0,'欢迎沙僧加入取经团队','沙僧，又叫沙和尚、沙悟净，出自四大名著之《西游记》。在书中也称黄婆，土母、刀圭，五行属土，俗称沙和尚、沙僧。原为天宫玉皇大帝的卷帘大将，因为失手不小心打破了琉璃盏，触犯天条，被贬出天界，在人间流沙河兴风作浪，危害一方，专吃过路人。后经观音点化，赐法号悟净，一心归佛，同八戒、悟空一同保大唐高僧玄奘法师（又称唐三藏或唐僧，俗名陈祎）西天拜佛求取真经。 ','2017-06-08 10:47:39','2017-06-08 10:47:39',2,NULL,'2017-06-08 10:47:39',2,'2017-06-08 10:47:39',NULL),(8,0,'欢迎猪八戒加入取经团队','沙僧，又叫沙和尚、沙悟净，出自四大名著之《西游记》。在书中也称黄婆，土母、刀圭，五行属土，俗称沙和尚、沙僧。原为天宫玉皇大帝的卷帘大将，因为失手不小心打破了琉璃盏，触犯天条，被贬出天界，在人间流沙河兴风作浪，危害一方，专吃过路人。后经观音点化，赐法号悟净，一心归佛，同八戒、悟空一同保大唐高僧玄奘法师（又称唐三藏或唐僧，俗名陈祎）西天拜佛求取真经。 ','2017-06-08 10:47:39','2017-06-08 10:47:39',2,NULL,'2017-06-08 10:47:39',2,'2017-06-08 10:47:39',NULL),(9,0,'欢迎沙僧加入取经团队','沙僧，又叫沙和尚、沙悟净，出自四大名著之《西游记》。在书中也称黄婆，土母、刀圭，五行属土，俗称沙和尚、沙僧。原为天宫玉皇大帝的卷帘大将，因为失手不小心打破了琉璃盏，触犯天条，被贬出天界，在人间流沙河兴风作浪，危害一方，专吃过路人。后经观音点化，赐法号悟净，一心归佛，同八戒、悟空一同保大唐高僧玄奘法师（又称唐三藏或唐僧，俗名陈祎）西天拜佛求取真经。 ','2017-06-08 10:47:39','2017-06-08 10:47:39',2,NULL,'2017-06-08 10:47:39',2,'2017-06-08 10:47:39',NULL),(10,0,'欢迎猪八戒加入取经团队','猪八戒是吴承恩所作《西游记》中的角色。又名猪刚鬣，法号悟能，浑名八戒，是唐僧的二徒弟，会三十六天罡变，所持武器为太上老君所造、玉皇大帝亲赐的上宝沁金钯（俗称九齿钉钯）。猪八戒前世为执掌天河八万水军的天蓬元帅。《 西游记》中各路神仙基本借鉴了正统道教神仙录，由高老庄一集猪八戒提及可见，猪八戒的前世天蓬元帅即是水神天河宪节。','2017-06-18 03:57:56','2017-06-18 03:57:56',-2,NULL,'2017-06-18 03:57:56',2,'2017-06-18 03:57:57',2),(11,0,'欢迎猪八戒加入取经团队','猪八戒是吴承恩所作《西游记》中的角色。又名猪刚鬣，法号悟能，浑名八戒，是唐僧的二徒弟，会三十六天罡变，所持武器为太上老君所造、玉皇大帝亲赐的上宝沁金钯（俗称九齿钉钯）。猪八戒前世为执掌天河八万水军的天蓬元帅。《 西游记》中各路神仙基本借鉴了正统道教神仙录，由高老庄一集猪八戒提及可见，猪八戒的前世天蓬元帅即是水神天河宪节。','2017-06-18 03:19:03','2017-06-18 03:19:03',-2,NULL,'2017-06-18 03:19:03',2,'2017-06-18 03:19:04',2),(12,0,'祝贺西天取经团队组建完成','经过领导和同志们的努力，西天取经团队终于组建完成，我们将日夜兼程更加努力，争取早日成功！感谢大家的支持！','2017-06-10 04:57:29','2017-06-10 04:57:29',-2,NULL,'2017-06-10 04:57:29',2,'2017-06-10 04:57:29',2),(13,0,'欢迎沙僧加入取经团队fasdfasd','fdsasjdhkgjhfgdsafghg','2017-06-22 11:49:29','2017-06-22 11:49:29',-2,NULL,'2017-06-22 11:49:29',2,'2017-06-22 11:49:30',2);
/*!40000 ALTER TABLE `notice` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role`
--

DROP TABLE IF EXISTS `role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `role` (
  `role_id` int(11) NOT NULL AUTO_INCREMENT,
  `role_name` varchar(15) COLLATE utf8_unicode_ci DEFAULT NULL,
  `role_desc` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `role_permission` int(11) DEFAULT NULL,
  `status` tinyint(4) DEFAULT NULL,
  `remark` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `creater` int(11) DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `updater` int(11) DEFAULT NULL,
  PRIMARY KEY (`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role`
--

LOCK TABLES `role` WRITE;
/*!40000 ALTER TABLE `role` DISABLE KEYS */;
INSERT INTO `role` VALUES (1,'教学主任','主管教学部，教学工作，教师工作',NULL,2,NULL,'2017-06-22 01:06:03',2,'2017-06-22 01:06:04',2),(2,'招生部主任','主管招生部工作',NULL,2,NULL,'2017-06-22 07:53:52',2,'2017-06-22 07:53:52',2);
/*!40000 ALTER TABLE `role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(8) COLLATE utf8_unicode_ci NOT NULL COMMENT '用户账号',
  `password` varchar(20) COLLATE utf8_unicode_ci NOT NULL COMMENT '密码',
  `is_admin` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否是管理员',
  `is_system` bit(1) DEFAULT NULL COMMENT '0',
  `department_id` int(11) DEFAULT NULL,
  `role_id` int(11) DEFAULT NULL,
  `is_male` bit(1) DEFAULT NULL,
  `mobile` varchar(11) COLLATE utf8_unicode_ci DEFAULT NULL,
  `address` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `age` int(11) DEFAULT NULL,
  `tel` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `id_num` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `email` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `qq` varchar(15) COLLATE utf8_unicode_ci DEFAULT NULL,
  `hobby` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `education` tinyint(4) DEFAULT NULL,
  `card_num` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `nation` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `marry` tinyint(4) DEFAULT NULL,
  `status` tinyint(4) DEFAULT NULL,
  `remark` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `creater` int(11) DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `updater` int(11) DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  KEY `fk_user_department` (`department_id`),
  KEY `fk_user_role` (`role_id`),
  CONSTRAINT `fk_user_department` FOREIGN KEY (`department_id`) REFERENCES `department` (`department_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_user_role` FOREIGN KEY (`role_id`) REFERENCES `role` (`role_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'admin','123456','','',1,1,'','18638273637','郑州市二七区兴华南街66号',33,NULL,NULL,'changwei@zhiyou100.com',NULL,NULL,NULL,NULL,NULL,NULL,2,NULL,'2017-06-22 03:32:05',NULL,'2017-06-22 03:32:05',NULL),(2,'常伟','654321','','\0',1,1,'','18638273638','郑州市经开区河南通信产业园',30,NULL,NULL,'273263743@qq.com',NULL,NULL,NULL,NULL,NULL,NULL,2,NULL,'2017-06-22 03:33:34',NULL,'2017-06-22 03:33:34',NULL),(3,'吴蛟龙','123456','\0','\0',2,2,'','18611212121','理想城11号',30,'21314231','1231231231231','wujiaolong@qq.com','12323123123','电影',5,'123123213123123123','汉',1,2,'主任1','2017-06-23 05:23:51',0,'2017-06-23 05:23:51',3);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-06-23 13:35:05
