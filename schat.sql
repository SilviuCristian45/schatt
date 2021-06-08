-- phpMyAdmin SQL Dump
-- version 5.1.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 19, 2021 at 01:13 PM
-- Server version: 10.4.19-MariaDB
-- PHP Version: 7.3.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `schat`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `gradUser` (IN `idUser` INT)  BEGIN
	SELECT ranks.name from ranks where ranks.id = idUser;
    
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `mesajeGlobaleSaptamana` ()  BEGIN
         SELECT * FROM messages WHERE  DATEDIFF(CURRENT_TIMESTAMP,messages.timestampp) <= 7 ORDER BY messages.timestampp DESC;
             
   END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `mesajUserGlobal` (IN `username` VARCHAR(50))  BEGIN
       	 DECLARE idUser INT;
         SELECT users.id INTO idUser FROM users WHERE users.username = username;
         SELECT messages.id,messages.timestampp,messages.content FROM messages where messages.userfrom = idUser;
       END$$

--
-- Functions
--
CREATE DEFINER=`root`@`localhost` FUNCTION `complaintState` (`idComplaint` INT) RETURNS VARCHAR(15) CHARSET utf8mb4 BEGIN
 DECLARE done int;
  SELECT contact.done into done FROM contact WHERE contact.id = idComplaint;
  IF done = 1 THEN
  		RETURN "Adevarat";
  ELSE
    	RETURN "False";
  END IF;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `numberUsers` () RETURNS INT(11) BEGIN
 DECLARE result int;
  Select COUNT(*)into result FROM users; 
  RETURN result;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Stand-in structure for view `admini`
-- (See below for the actual view)
--
CREATE TABLE `admini` (
`username` varchar(50)
,`id` int(11)
);

-- --------------------------------------------------------

--
-- Table structure for table `contact`
--

CREATE TABLE `contact` (
  `id` int(11) NOT NULL,
  `email` varchar(255) NOT NULL,
  `content` varchar(1000) NOT NULL,
  `timestampp` datetime DEFAULT current_timestamp(),
  `done` smallint(5) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `contact`
--

INSERT INTO `contact` (`id`, `email`, `content`, `timestampp`, `done`) VALUES
(1, 'temp@yahoo.com', 'nu se incarca dm-urile ', NULL, 1),
(2, 'palala@gmail.com', '123132132das ', NULL, NULL),
(3, 'diana@gmail.com', '123123asdasddasdas ', NULL, 1),
(4, 'diana3223@gmail.com', '123123asdasddasdas ', NULL, 0),
(5, 'policlinica@gmail.com', '123132asddasdas ', NULL, 1),
(6, 'traian@gmail.com', '123312asddasasdgrrt ', NULL, 0),
(7, 'adrianaluminita@gmail.com', '123312dasdasfrefereg ', NULL, 0),
(8, 'popavasile@gmail.com', 'nu merge nimic . sunteti varza ', NULL, 0),
(9, 'panamera@yahoo.com', '123132asdasdads ', NULL, 1),
(10, 'adrianaluminita@gmail.com', 'de ce nu imi raspundeti ', NULL, 0),
(11, 'diana123@yahoo.com', 'Imi dispar mesajele aiurea sunteti retardati ', NULL, 0),
(12, 'daniiii@gmial.com', 'dadada', '2021-05-04 14:12:00', 1),
(13, 'sili@gmail.com', 'ne doare chatul ', '2021-05-16 22:46:04', 1);

-- --------------------------------------------------------

--
-- Table structure for table `direct_messages`
--

CREATE TABLE `direct_messages` (
  `id` int(11) NOT NULL,
  `userfrom` int(50) DEFAULT NULL,
  `userto` int(50) DEFAULT NULL,
  `timestampp` datetime DEFAULT NULL,
  `content` varchar(120) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `direct_messages`
--

INSERT INTO `direct_messages` (`id`, `userfrom`, `userto`, `timestampp`, `content`) VALUES
(1, 3, 2, '2021-04-12 00:00:00', 'Salut diana ce faci ?'),
(2, 3, 1, '2021-04-11 00:00:00', 'Salut silviu ce faci ?'),
(3, 3, 2, '2021-04-01 00:00:00', 'tttttrrrrrrrr'),
(13, 1, 2, '2021-04-13 00:00:00', 'Ce faci diana'),
(14, 1, 3, '2021-04-15 00:00:00', 'mesaj mesaj'),
(15, 1, 2, '2021-04-24 00:00:00', ' heelloo'),
(16, 1, 2, '2021-04-26 00:00:00', 'am ceva de spus'),
(17, 3, 2, '2021-04-26 00:00:00', 'Ai treaba la magazin ?'),
(18, 3, 2, '2021-04-26 00:00:00', 'Ai treaba la magazin ?'),
(19, 3, 2, '2021-04-26 00:00:00', 'Vreau sa ne vedem acolo'),
(20, 3, 2, '2021-04-26 00:00:00', 'Vreau sa vorbesc cu Raul'),
(21, 3, 2, '2021-04-26 00:00:00', 'Am o problema la masina'),
(84, 2, 3, '2021-04-26 00:00:00', 'Pai hai ca vin si eu la magazin'),
(85, 3, 2, '2021-04-26 00:00:00', 'Bine ne vedem atunci'),
(86, 2, 3, '2021-04-26 00:00:00', 'Ok. Ne vedem'),
(87, 3, 2, '2021-04-26 00:00:00', 'Ok'),
(88, 3, 1, '2021-04-27 00:00:00', 'ce ai de spus ?'),
(89, 3, 1, '2021-04-27 00:00:00', 'De ce nu se vede mesajul meu ? '),
(90, 2, 1, '2021-04-27 00:00:00', 'Ce faci silviu'),
(91, 1, 2, '2021-04-27 00:00:00', 'uite bine . vreau sa iesim afara'),
(92, 2, 1, '2021-04-27 00:00:00', 'ok. hai sa mergem'),
(93, 1, 2, '2021-04-27 00:00:00', 'bine. ne vedem la 4'),
(94, 2, 1, '2021-04-27 00:00:00', 'ok. pa pa '),
(95, 1, 2, '2021-04-27 00:00:00', 'ok . pa pa '),
(96, 3, 1, '2021-04-27 00:00:00', 'acum se vede mesajul meu'),
(97, 1, 3, '2021-04-27 00:00:00', 'bine mariuse , te salut . sanatate'),
(98, 1, 2, '2021-04-27 00:00:00', 'Serus dianaaaa '),
(99, 1, 3, '2021-04-27 00:00:00', ' dasads'),
(100, 1, 6, '2021-04-27 00:00:00', ' Salut userule de test. '),
(101, 1, 6, '2021-04-27 00:00:00', ' Salut userule de test. '),
(102, 1, 6, '2021-04-27 00:00:00', ' mesaj de test creare confa'),
(103, 1, 6, '2021-04-27 00:00:00', ' test test test'),
(104, 1, 6, '2021-04-27 00:00:00', ' test test test'),
(105, 6, 1, '2021-04-28 00:00:00', 'salut bros'),
(106, 6, 1, '2021-04-28 00:00:00', 'doar ce am vazut mesajul'),
(107, 1, 6, '2021-04-28 00:00:00', 'bine '),
(108, 2, 1, '2021-04-28 00:00:00', 'Serus silviule'),
(109, 1, 2, '2021-04-28 00:00:00', 'te pwp'),
(110, 2, 1, '2021-04-28 00:00:00', 'bine ma , iti dau seen'),
(111, 1, 20, '2021-04-28 00:00:00', ' serus traiane'),
(112, 20, 1, '2021-04-28 00:00:00', 'serus silviule'),
(113, 1, 20, '2021-04-28 00:00:00', 'telelele'),
(114, 20, 1, '2021-04-28 00:00:00', 'ai deschis confa ej nebun'),
(115, 1, 2, '2021-05-02 00:00:00', 'bun. iti zic ceva acum'),
(116, 2, 1, '2021-05-02 00:00:00', 'ce imi zici ? '),
(117, 1, 2, '2021-05-02 00:00:00', 'nush'),
(118, 2, 1, '2021-05-02 00:00:00', 'ejti bot'),
(119, 1, 2, '2021-05-02 00:00:00', 'bine si tu acuma'),
(120, 2, 1, '2021-05-02 00:00:00', 'Stai ca am intrat de pe tel acuma'),
(121, 2, 1, '2021-05-02 00:00:00', 'E tare ca SCHAT are si varianta de mobil'),
(122, 1, 2, '2021-05-02 00:00:00', 'true . e misto'),
(123, 2, 1, '2021-05-02 00:00:00', 'mi-a disparut mesajul anterior'),
(124, 1, 2, '2021-05-02 00:00:00', 'am observat\ne un bug de la SCHAT'),
(125, 2, 1, '2021-05-02 00:00:00', 'intru pe contact sa le scriu'),
(126, 1, 2, '2021-05-02 00:00:00', 'ok'),
(127, 1, 2, '2021-05-02 00:00:00', 'of doamne'),
(128, 2, 1, '2021-05-02 00:00:00', 'ce zici'),
(129, 1, 2, '2021-05-02 16:56:47', 'blana treaba'),
(130, 2, 1, '2021-05-02 16:57:01', 'sigur ca da'),
(131, 2, 1, '2021-05-03 12:18:24', 'uite un koala silviule'),
(132, 2, 1, '2021-05-03 12:20:01', 'dasdas'),
(133, 2, 1, '2021-05-03 12:23:19', 'koalapufos.JPG'),
(134, 2, 1, '2021-05-03 12:23:19', 'Your message here '),
(135, 2, 1, '2021-05-03 12:25:49', 'koalapufos.JPG'),
(136, 2, 1, '2021-05-03 12:25:49', 'fain koala nu ? '),
(137, 1, 2, '2021-05-03 12:26:43', 'fain tu fata da '),
(138, 1, 2, '2021-05-04 08:56:27', 'salutare'),
(139, 1, 2, '2021-05-04 08:59:30', 'diana uite aici  '),
(140, 1, 2, '2021-05-04 08:59:55', 'odsadas'),
(141, 1, 2, '2021-05-04 09:04:55', 'dasasdads'),
(142, 1, 2, '2021-05-04 09:08:09', 'koalapufos.JPG'),
(143, 1, 2, '2021-05-04 09:08:09', 'hopa'),
(144, 1, 2, '2021-05-04 10:44:16', ''),
(145, 1, 2, '2021-05-04 19:48:13', '16201576686752557758119211373410.jpg'),
(146, 1, 2, '2021-05-04 19:48:13', 'Poza de tel'),
(147, 1, 23, '0000-00-00 00:00:00', ''),
(149, 1, 2, '2021-05-05 08:51:21', ' '),
(151, 1, 2, '2021-05-05 09:38:28', ' '),
(153, 1, 2, '2021-05-05 09:39:16', ' '),
(154, 1, 2, '2021-05-05 09:41:13', '2021-05-0511-50-58.mp4'),
(155, 1, 2, '2021-05-05 09:41:13', ' '),
(156, 1, 2, '2021-05-05 09:43:36', ' salut'),
(157, 1, 2, '2021-05-05 09:43:51', ' asddsa'),
(158, 1, 2, '2021-05-05 09:47:59', 'facem banu vreau un mili'),
(159, 1, 2, '2021-05-05 09:48:29', ' test'),
(160, 2, 1, '2021-05-05 09:51:57', ' gio'),
(161, 2, 1, '2021-05-05 09:53:06', ' adsdsa'),
(162, 2, 1, '2021-05-05 09:53:12', 'xzzxcx'),
(163, 2, 1, '2021-05-05 09:54:01', ' hopa'),
(164, 1, 2, '2021-05-05 09:54:14', ' bien'),
(165, 2, 1, '2021-05-05 09:54:28', 'pwp si tie silviule'),
(166, 1, 2, '2021-05-05 09:54:29', 'pwp'),
(167, 2, 1, '2021-05-14 08:33:56', ' salut silviu'),
(168, 1, 2, '2021-05-14 08:34:27', ' salut diana'),
(169, 1, 2, '2021-05-14 08:40:10', 'ce faci tu diana ?'),
(170, 1, 2, '2021-05-14 08:42:28', ' hello'),
(171, 2, 1, '2021-05-14 08:42:52', ' uite bine , am zis sa vad cum esti'),
(172, 2, 1, '2021-05-14 08:43:03', 'ai fost la sala ?'),
(173, 1, 2, '2021-05-14 08:43:14', 'nu. hai sa mergem impreuna'),
(174, 2, 1, '2021-05-14 08:43:26', 'ok. hai ca ne vedem in jumatate de ora'),
(175, 1, 2, '2021-05-14 08:45:54', 'bine'),
(176, 3, 1, '2021-05-16 13:24:39', ' sallll'),
(177, 3, 2, '2021-05-16 13:25:23', ' salll'),
(178, 2, 3, '2021-05-16 13:25:35', ' salut marius'),
(179, 3, 2, '2021-05-16 13:25:47', 'ce faci ? '),
(180, 2, 3, '2021-05-16 13:25:58', 'bine '),
(181, 3, 2, '2021-05-16 13:26:10', 'ok'),
(182, 2, 3, '2021-05-16 13:26:21', 'paaaa'),
(183, 3, 2, '2021-05-16 13:26:28', 'pa diana'),
(184, 1, 2, '2021-05-16 19:45:22', ' serus dia'),
(185, 2, 1, '2021-05-16 19:45:35', ' serus coaie'),
(186, 25, 1, '2021-05-16 19:48:41', ' salut silviu.'),
(187, 25, 1, '2021-05-16 19:49:22', ' [ce faciiiiiiiii ?');

-- --------------------------------------------------------

--
-- Stand-in structure for view `imagini`
-- (See below for the actual view)
--
CREATE TABLE `imagini` (
`id` int(11)
,`userfrom` int(11)
,`timestampp` datetime
,`content` varchar(120)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `imaginidm`
-- (See below for the actual view)
--
CREATE TABLE `imaginidm` (
`id` int(11)
,`content` varchar(120)
);

-- --------------------------------------------------------

--
-- Table structure for table `messages`
--

CREATE TABLE `messages` (
  `id` int(11) NOT NULL,
  `userfrom` int(11) DEFAULT NULL,
  `timestampp` datetime DEFAULT NULL,
  `content` varchar(120) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `messages`
--

INSERT INTO `messages` (`id`, `userfrom`, `timestampp`, `content`) VALUES
(514, 2, '2021-05-19 11:06:16', 'chat-ul a avut wipe'),
(515, 3, '2021-05-19 11:07:59', 'chat-ul a avut wipe'),
(516, 3, '2021-05-19 11:08:47', 'chat-ul a avut wipe'),
(517, 3, '2021-05-19 11:08:51', 'chat-ul a avut wipe'),
(518, 3, '2021-05-19 11:09:42', ' asdads'),
(519, 2, '2021-05-19 11:09:48', ' dasdasdas'),
(520, 3, '2021-05-19 11:09:55', 'xtttt'),
(521, 2, '2021-05-19 11:09:59', 'taaaaaaaaaa'),
(522, 3, '2021-05-19 11:10:50', ' /clear');

-- --------------------------------------------------------

--
-- Stand-in structure for view `moderatori`
-- (See below for the actual view)
--
CREATE TABLE `moderatori` (
`username` varchar(50)
,`id` int(11)
);

-- --------------------------------------------------------

--
-- Table structure for table `ranks`
--

CREATE TABLE `ranks` (
  `id` int(11) NOT NULL,
  `name` varchar(25) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `ranks`
--

INSERT INTO `ranks` (`id`, `name`) VALUES
(1, 'normal'),
(2, 'moderator'),
(3, 'admin');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(50) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `idgrad` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `password`, `idgrad`) VALUES
(1, 'Silviu12', '$2y$10$j8BApx2tl0o5fT0OBNr9W.y66hx32H5NygVT1GdTLfTUtHZkZDrUy', 1),
(2, 'Diana44', '$2y$10$j8BApx2tl0o5fT0OBNr9W.y66hx32H5NygVT1GdTLfTUtHZkZDrUy', 2),
(3, 'Marius1X', '$2y$10$LO5Hj9o5ZdONRAwjAa9uDuM/gr58tobEMM/psDRjmAj8IDpY30Z3i', 3),
(6, 'test', '12345678', 1),
(10, 'Danezul', '12345678', 1),
(15, 'dana', '32432', 1),
(16, 'andreea33', '1234', 1),
(17, 'DanielaX23', '1234', 1),
(18, 'tudorache', '3112', 1),
(19, 'adela', '1234', 1),
(20, 'traian', 'A3@56a8bxxx', 1),
(21, 'stefan', '123456bA', 1),
(24, 'dasdas', '412asdAAA', 1),
(25, 'siliana', '$2y$10$HcRSedKe5HWZQ2Z.khCaPOaYrByxWVp03TJMu1y8FtBM61NOFFfO.', 1);

-- --------------------------------------------------------

--
-- Stand-in structure for view `videoclipuri`
-- (See below for the actual view)
--
CREATE TABLE `videoclipuri` (
`id` int(11)
,`userfrom` int(11)
,`timestampp` datetime
,`content` varchar(120)
);

-- --------------------------------------------------------

--
-- Structure for view `admini`
--
DROP TABLE IF EXISTS `admini`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `admini`  AS SELECT `users`.`username` AS `username`, `users`.`id` AS `id` FROM (`users` join `ranks` on(`users`.`id` = `ranks`.`id`)) WHERE `ranks`.`id` = 3 ;

-- --------------------------------------------------------

--
-- Structure for view `imagini`
--
DROP TABLE IF EXISTS `imagini`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `imagini`  AS SELECT `messages`.`id` AS `id`, `messages`.`userfrom` AS `userfrom`, `messages`.`timestampp` AS `timestampp`, `messages`.`content` AS `content` FROM `messages` WHERE `messages`.`content` like '%.png%' OR `messages`.`content` like '%.jpg%' OR `messages`.`content` like '%.jpeg%' ;

-- --------------------------------------------------------

--
-- Structure for view `imaginidm`
--
DROP TABLE IF EXISTS `imaginidm`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `imaginidm`  AS SELECT `direct_messages`.`id` AS `id`, `direct_messages`.`content` AS `content` FROM `direct_messages` WHERE `direct_messages`.`content` like '%.png%' OR `direct_messages`.`content` like '%.jpg%' OR `direct_messages`.`content` like '%.jpeg%' ;

-- --------------------------------------------------------

--
-- Structure for view `moderatori`
--
DROP TABLE IF EXISTS `moderatori`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `moderatori`  AS SELECT `users`.`username` AS `username`, `users`.`id` AS `id` FROM (`users` join `ranks` on(`users`.`id` = `ranks`.`id`)) WHERE `ranks`.`id` = 2 ;

-- --------------------------------------------------------

--
-- Structure for view `videoclipuri`
--
DROP TABLE IF EXISTS `videoclipuri`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `videoclipuri`  AS SELECT `messages`.`id` AS `id`, `messages`.`userfrom` AS `userfrom`, `messages`.`timestampp` AS `timestampp`, `messages`.`content` AS `content` FROM `messages` WHERE `messages`.`content` like '%.mp4%' OR `messages`.`content` like '%.m4v%' ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `contact`
--
ALTER TABLE `contact`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `direct_messages`
--
ALTER TABLE `direct_messages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_usertodm` (`userto`),
  ADD KEY `fk_userfromdm` (`userfrom`);

--
-- Indexes for table `messages`
--
ALTER TABLE `messages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_userfromglobal` (`userfrom`);

--
-- Indexes for table `ranks`
--
ALTER TABLE `ranks`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_idgrad` (`idgrad`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `contact`
--
ALTER TABLE `contact`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `direct_messages`
--
ALTER TABLE `direct_messages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=188;

--
-- AUTO_INCREMENT for table `messages`
--
ALTER TABLE `messages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=523;

--
-- AUTO_INCREMENT for table `ranks`
--
ALTER TABLE `ranks`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `direct_messages`
--
ALTER TABLE `direct_messages`
  ADD CONSTRAINT `fk_userfromdm` FOREIGN KEY (`userfrom`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `fk_usertodm` FOREIGN KEY (`userto`) REFERENCES `users` (`id`);

--
-- Constraints for table `messages`
--
ALTER TABLE `messages`
  ADD CONSTRAINT `fk_userfromglobal` FOREIGN KEY (`userfrom`) REFERENCES `users` (`id`);

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `fk_idgrad` FOREIGN KEY (`idgrad`) REFERENCES `ranks` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
