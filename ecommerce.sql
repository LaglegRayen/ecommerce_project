-- MariaDB dump 10.19  Distrib 10.4.32-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: ecommerce
-- ------------------------------------------------------
-- Server version	10.4.32-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `cart_item`
--

DROP TABLE IF EXISTS `cart_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cart_item` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `product_id` int(11) DEFAULT NULL,
  `quantity` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_F0FE25274584665A` (`product_id`),
  KEY `FK_F0FE2527A76ED395` (`user_id`),
  CONSTRAINT `FK_F0FE25274584665A` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`),
  CONSTRAINT `FK_F0FE2527A76ED395` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cart_item`
--

LOCK TABLES `cart_item` WRITE;
/*!40000 ALTER TABLE `cart_item` DISABLE KEYS */;
INSERT INTO `cart_item` VALUES (2,1,14,1);
/*!40000 ALTER TABLE `cart_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` VALUES (1,'livre arabe'),(2,'livre anglais'),(3,'livre fran├ºais'),(5,'livre allemand');
/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `doctrine_migration_versions`
--

DROP TABLE IF EXISTS `doctrine_migration_versions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `doctrine_migration_versions` (
  `version` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `executed_at` datetime DEFAULT NULL,
  `execution_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `doctrine_migration_versions`
--

LOCK TABLES `doctrine_migration_versions` WRITE;
/*!40000 ALTER TABLE `doctrine_migration_versions` DISABLE KEYS */;
/*!40000 ALTER TABLE `doctrine_migration_versions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `messenger_messages`
--

DROP TABLE IF EXISTS `messenger_messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `messenger_messages` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `body` longtext NOT NULL,
  `headers` longtext NOT NULL,
  `queue_name` varchar(190) NOT NULL,
  `created_at` datetime NOT NULL COMMENT '(DC2Type:datetime_immutable)',
  `available_at` datetime NOT NULL COMMENT '(DC2Type:datetime_immutable)',
  `delivered_at` datetime DEFAULT NULL COMMENT '(DC2Type:datetime_immutable)',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `messenger_messages`
--

LOCK TABLES `messenger_messages` WRITE;
/*!40000 ALTER TABLE `messenger_messages` DISABLE KEYS */;
/*!40000 ALTER TABLE `messenger_messages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order`
--

DROP TABLE IF EXISTS `order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `order` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL COMMENT '(DC2Type:datetime_immutable)',
  `total_price` double DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_F5299398A76ED395` (`user_id`),
  CONSTRAINT `FK_F5299398A76ED395` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order`
--

LOCK TABLES `order` WRITE;
/*!40000 ALTER TABLE `order` DISABLE KEYS */;
/*!40000 ALTER TABLE `order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_item`
--

DROP TABLE IF EXISTS `order_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `order_item` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` int(11) DEFAULT NULL,
  `product_id` int(11) DEFAULT NULL,
  `quantity` int(11) NOT NULL,
  `price` double NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_52EA1F094584665A` (`product_id`),
  KEY `FK_52EA1F098D9F6D38` (`order_id`),
  CONSTRAINT `FK_52EA1F094584665A` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`),
  CONSTRAINT `FK_52EA1F098D9F6D38` FOREIGN KEY (`order_id`) REFERENCES `order` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_item`
--

LOCK TABLES `order_item` WRITE;
/*!40000 ALTER TABLE `order_item` DISABLE KEYS */;
/*!40000 ALTER TABLE `order_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product`
--

DROP TABLE IF EXISTS `product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category_id` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `price` double NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  `stock` int(11) DEFAULT NULL,
  `description` longtext DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_D34A04AD12469DE2` (`category_id`),
  CONSTRAINT `FK_D34A04AD12469DE2` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product`
--

LOCK TABLES `product` WRITE;
/*!40000 ALTER TABLE `product` DISABLE KEYS */;
INSERT INTO `product` VALUES (2,1,'Ïú┘ä┘ü ┘ä┘è┘äÏ® ┘ê┘ä┘è┘äÏ®',18.99,'6839d8f2babef.jpg',12,'┘àÏ¼┘à┘êÏ╣Ï® ┘à┘å Ïº┘äÏ¡┘âÏº┘èÏºÏ¬ Ïº┘äÏ┤Ï╣Ï¿┘èÏ® Ïº┘äÏ¬┘è Ï¬Ï¡┘â┘è┘çÏº Ï┤┘çÏ▒Ï▓ÏºÏ» ┘ä┘ä┘à┘ä┘â Ï┤┘çÏ▒┘èÏºÏ▒Ïî Ï¬Ï¬ÏÂ┘à┘å ┘éÏÁÏÁ┘ïÏº Ï╣┘å Ïº┘äÏ¼┘åÏî ┘êÏº┘äÏ│Ï¡Ï▒Ïî ┘êÏº┘ä┘àÏ║Ïº┘àÏ▒ÏºÏ¬ ┘ü┘è Ï╣Ïº┘ä┘à Ï┤Ï▒┘é┘è Ï«┘èÏº┘ä┘è. ┘âÏ¬ÏºÏ¿ Ï«Ïº┘äÏ» ┘èÏ¼┘àÏ╣ Ï¿┘è┘å Ïº┘äÏ«┘èÏº┘ä ┘êÏº┘äÏ¡┘â┘àÏ®.'),(3,1,'┘à┘êÏ│┘à Ïº┘ä┘çÏ¼Ï▒Ï® ÏÑ┘ä┘ë Ïº┘äÏ┤┘àÏº┘ä ÔÇô Ïº┘äÏÀ┘èÏ¿ ÏÁÏº┘äÏ¡',14.5,'6839d958afc28.jpg',8,'Ï▒┘êÏº┘èÏ® Ï│┘êÏ»Ïº┘å┘èÏ® Ï┤┘ç┘èÏ▒Ï® Ï¬Ï╣┘âÏ│ ÏÁÏ▒ÏºÏ╣ Ïº┘ä┘ç┘ê┘èÏ® Ï¿┘è┘å Ïº┘äÏ┤Ï▒┘é ┘êÏº┘äÏ║Ï▒Ï¿Ïî ┘à┘å Ï«┘äÏº┘ä ┘éÏÁÏ® Ï▒Ï¼┘ä ┘èÏ╣┘êÏ» ÏÑ┘ä┘ë ┘éÏ▒┘èÏ¬┘ç Ï¿Ï╣Ï» Ï»Ï▒ÏºÏ│Ï® ÏÀ┘ê┘è┘äÏ® ┘ü┘è Ïú┘êÏ▒┘êÏ¿Ïº. ┘à┘å ÏúÏ╣Ï©┘à Ï▒┘êÏº┘èÏºÏ¬ Ïº┘äÏúÏ»Ï¿ Ïº┘äÏ╣Ï▒Ï¿┘è Ïº┘äÏ¡Ï»┘èÏ½.'),(4,1,'Ïº┘äÏ«Ï¿Ï▓ Ïº┘äÏ¡Ïº┘ü┘è ÔÇô ┘àÏ¡┘àÏ» Ï┤┘âÏ▒┘è',11,'6839d9af5355b.jpg',5,'Ï│┘èÏ▒Ï® Ï░ÏºÏ¬┘èÏ® ┘é┘ê┘èÏ® ┘ê┘àÏ½┘èÏ▒Ï® ┘ä┘äÏ¼Ï»┘ä Ï¬Ï¡┘â┘è ÏÀ┘ü┘ê┘äÏ® ┘éÏºÏ│┘èÏ® Ï╣ÏºÏ┤┘çÏº Ïº┘ä┘âÏºÏ¬Ï¿ ┘ü┘è ┘àÏ»┘è┘åÏ® ÏÀ┘åÏ¼Ï®. ┘èÏ│┘äÏÀ Ïº┘äÏÂ┘êÏí Ï╣┘ä┘ë Ïº┘ä┘ü┘éÏ▒Ïî Ïº┘äÏ¼┘êÏ╣Ïî ┘êÏº┘äÏº┘å┘ü┘äÏºÏ¬ Ïº┘äÏºÏ¼Ï¬┘àÏºÏ╣┘è.'),(5,1,'Ï▒Ï¼Ïº┘ä ┘ü┘è Ïº┘äÏ┤┘àÏ│ ÔÇô Ï║Ï│Ïº┘å ┘â┘å┘üÏº┘å┘è',9.99,'6839da8e4d2d6.jpg',10,'┘éÏÁÏ® ┘éÏÁ┘èÏ▒Ï® ┘àÏñÏ½Ï▒Ï® Ï¬Ï│┘äÏÀ Ïº┘äÏÂ┘êÏí Ï╣┘ä┘ë ┘àÏ╣Ïº┘åÏºÏ® Ïº┘ä┘äÏºÏ¼Ïª┘è┘å Ïº┘ä┘ü┘äÏ│ÏÀ┘è┘å┘è┘è┘å ┘ü┘è Ï▒Ï¡┘äÏ® Ï¿Ï¡Ï½┘ç┘à Ï╣┘å Ï¡┘èÏºÏ® ┘âÏ▒┘è┘àÏ®. Ï╣┘à┘ä Ï▒┘àÏ▓┘è Ï╣┘à┘è┘é ┘è┘ÅÏ»Ï▒Ï│ ┘ü┘è Ïº┘äÏúÏ»Ï¿ Ïº┘äÏ╣Ï▒Ï¿┘è.'),(6,1,'Ï╣Ï▓ÏºÏ▓┘è┘ä ÔÇô ┘è┘êÏ│┘ü Ï▓┘èÏ»Ïº┘å',17.25,'6839daebe0ce5.jpg',7,'Ï▒┘êÏº┘èÏ® Ï¬ÏºÏ▒┘èÏ«┘èÏ® Ï¬Ï»┘êÏ▒ ÏúÏ¡Ï»ÏºÏ½┘çÏº ┘ü┘è Ïº┘ä┘éÏ▒┘å Ïº┘äÏ«Ïº┘àÏ│ Ïº┘ä┘à┘è┘äÏºÏ»┘èÏî Ï¬┘ÅÏ▒┘ê┘ë Ï╣┘ä┘ë ┘äÏ│Ïº┘å Ï▒Ïº┘çÏ¿ ┘éÏ¿ÏÀ┘è. Ï¬Ï¬┘åÏº┘ê┘ä Ïº┘äÏÁÏ▒ÏºÏ╣ÏºÏ¬ Ïº┘äÏ»┘è┘å┘èÏ® ┘êÏº┘ä┘ü┘âÏ▒┘èÏ® ┘ü┘è Ï¬┘ä┘â Ïº┘ä┘üÏ¬Ï▒Ï®.'),(7,2,'To Kill a Mockingbird ÔÇô Harper Lee',12.99,'6839db5c0055a.jpg',10,'A timeless classic that explores themes of racism, justice, and morality in the American South through the eyes of a young girl, Scout Finch.'),(8,2,'1984 ÔÇô George Orwell',10.5,'6839dbdd0c51f.jpg',15,'A chilling dystopia about surveillance, authoritarianism, and the loss of freedom. OrwellÔÇÖs vision of Big Brother remains strikingly relevant.'),(9,2,'The Great Gatsby ÔÇô F. Scott Fitzgerald',9.99,'6839dc5755081.jpg',7,'A glittering tale of love, wealth, and illusion in the Jazz Age. Follow Jay GatsbyÔÇÖs dream of winning back Daisy Buchanan in this literary masterpiece.'),(10,2,'Atomic Habits ÔÇô James Clear',16.9,'6839dca76d339.jpg',12,'A practical guide to building good habits and breaking bad ones, based on small changes that lead to remarkable results over time.'),(11,2,'Harry Potter and the SorcererÔÇÖs Stone ÔÇô J.K. Rowling',13.5,'6839dcf1b485f.jpg',20,'The first installment in the magical saga of Harry Potter, a young wizard who discovers his destiny at Hogwarts School of Witchcraft and Wizardry.'),(13,3,'L\'├ëtranger ÔÇô Albert Camus',9.5,'6839dd9877d73.jpg',12,'Un roman embl├®matique de lÔÇÖabsurde. Meursault, un homme d├®tach├® de tout, est confront├® ├á la soci├®t├® apr├¿s un meurtre commis sans raison apparente.'),(14,3,'La Peste ÔÇô Albert Camus',11.8,'6839ddd874f9d.jpg',8,'├Ç Oran, une ├®pid├®mie de peste bouleverse la ville. Ce roman symbolique interroge la solidarit├® humaine face ├á lÔÇÖabsurde.'),(15,3,'Les Mis├®rables ÔÇô Victor Hugo',14.99,'6839ddfe81c4d.jpg',10,'Une fresque sociale puissante du XIXe si├¿cle. Suivez Jean Valjean, Cosette et dÔÇÖautres figures marquantes dans leur lutte pour la justice et la dignit├®.'),(16,3,'Ensemble, cÔÇÖest tout ÔÇô Anna Gavalda',13.9,'6839de3eb1cac.png',6,'Une belle histoire dÔÇÖamiti├® et de reconstruction entre quatre personnages que tout oppose. Un roman chaleureux et touchant.'),(17,3,'Le Petit Prince ÔÇô Antoine de Saint-Exup├®ry',9.99,'683cf032d65a7.jpg',10,'Le Petit Prince est un roman fran├ºais. Livre ├á succ├¿s, il est l\'┼ôuvre la plus connue d\'Antoine de Saint-Exup├®ry. Publi├® en fran├ºais en 1943 ├á New York, simultan├®ment ├á sa traduction anglaise, c\'est une ┼ôuvre po├®tique et philosophique sous l\'apparence d\'un conte illustr├® pour enfants.'),(19,5,'german language c1',30,'683cf2bcd5a22.png',14,'livre pour apprendre l\'allemand');
/*!40000 ALTER TABLE `product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(255) NOT NULL,
  `roles` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `password` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'admin1@gmail.com','[\"ROLE_ADMIN\"]','$2y$13$g3i7HDBB9ghT/Fbn33mNDu5aHNxnIVq92ovC7ikG57qeoaJLvxb9G'),(2,'hedi@gmail.com','[\"ROLE_USER\"]','$2y$13$3igKxmmXMssTqS0.6kxf7.TleoKMS8lvOUOI5fg6NwkZ1.oDyKoGu'),(3,'hedi1@gmail.com','[\"ROLE_ADMIN\"]','$2y$13$KQKnmNSDcqRP3LbUXZ1WOe/IVIixJDi6eA.UKNHinYcuxXRBYBhfS'),(4,'hedi123@gmail.com','[\"ROLE_ADMIN\"]','$2y$13$MXw381RIeRAH/t7YeeGOquZD.LwoThmgqf7dzQurPgIf2LiWvdId.');
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

-- Dump completed on 2025-06-02  3:03:29
