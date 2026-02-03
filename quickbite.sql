-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Gép: 127.0.0.1
-- Létrehozás ideje: 2026. Feb 03. 12:33
-- Kiszolgáló verziója: 10.4.32-MariaDB
-- PHP verzió: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Adatbázis: `quickbite`
--
CREATE DATABASE IF NOT EXISTS `quickbite` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `quickbite`;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `categories`
--

DROP TABLE IF EXISTS `categories`;
CREATE TABLE IF NOT EXISTS `categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` text NOT NULL,
  `icon` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

--
-- A tábla adatainak kiíratása `categories`
--

INSERT INTO `categories` (`id`, `name`, `icon`) VALUES
(1, 'Olasz', '🍝'),
(2, 'Magyar', '🍲'),
(3, 'Pub', '🍺'),
(4, 'Ázsiai', '🍜'),
(5, 'Mexikói', '🌮'),
(6, 'Görög', '🥙');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `coupons`
--

DROP TABLE IF EXISTS `coupons`;
CREATE TABLE IF NOT EXISTS `coupons` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(50) NOT NULL,
  `description` text DEFAULT NULL,
  `discount_type` enum('percentage','fixed_amount') NOT NULL,
  `discount_value` decimal(10,2) NOT NULL,
  `min_order_amount` decimal(10,2) DEFAULT NULL,
  `max_discount_amount` decimal(10,2) DEFAULT NULL,
  `usage_limit` int(11) DEFAULT NULL,
  `usage_count` int(11) DEFAULT 0,
  `per_user_limit` int(11) DEFAULT 1,
  `valid_from` datetime NOT NULL,
  `valid_until` datetime NOT NULL,
  `is_active` tinyint(1) DEFAULT 1,
  `restaurant_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `code` (`code`),
  KEY `restaurant_id` (`restaurant_id`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

--
-- A tábla adatainak kiíratása `coupons`
--

INSERT INTO `coupons` (`id`, `code`, `description`, `discount_type`, `discount_value`, `min_order_amount`, `max_discount_amount`, `usage_limit`, `usage_count`, `per_user_limit`, `valid_from`, `valid_until`, `is_active`, `restaurant_id`, `created_at`) VALUES
(17, 'MARTIN99', 'Martin speciális kuponja – 99% kedvezmény', 'percentage', 99.00, 2000.00, 99999999.99, 100, 1, 1, '2026-01-01 00:00:00', '2026-12-31 00:00:00', 1, NULL, '2026-02-03 12:22:35'),
(18, 'PATRIK99', 'Patrik speciális kuponja – 99% kedvezmény', 'percentage', 99.00, 2000.00, 99999999.99, 100, 0, 1, '2026-01-01 00:00:00', '2026-12-31 00:00:00', 1, NULL, '2026-02-03 12:22:35'),
(19, 'DANI99', 'Dani speciális kuponja – 99% kedvezmény', 'percentage', 99.00, 2000.00, 99999999.99, 100, 0, 1, '2026-01-01 00:00:00', '2026-12-31 00:00:00', 1, NULL, '2026-02-03 12:22:35'),
(20, 'WELCOME10', '10% kedvezmény első rendelésre', 'percentage', 10.00, 2500.00, 2000.00, 5000, 0, 1, '2026-01-01 00:00:00', '2026-12-31 00:00:00', 1, NULL, '2026-02-03 12:22:35'),
(21, 'WELCOME20', '20% kedvezmény új felhasználóknak', 'percentage', 20.00, 4000.00, 3000.00, 2000, 0, 1, '2026-01-01 00:00:00', '2026-06-30 00:00:00', 1, NULL, '2026-02-03 12:22:35'),
(22, 'ORDER15', '15% kedvezmény bármely rendelésre', 'percentage', 15.00, 3500.00, 2500.00, 3000, 0, 1, '2026-01-01 00:00:00', '2026-05-31 00:00:00', 1, NULL, '2026-02-03 12:22:35'),
(23, 'BIGORDER25', '25% kedvezmény nagy rendelés esetén', 'percentage', 25.00, 8000.00, 5000.00, 1000, 0, 1, '2026-02-01 00:00:00', '2026-07-31 00:00:00', 1, NULL, '2026-02-03 12:22:35'),
(24, 'WEEKEND10', '10% hétvégi kedvezmény', 'percentage', 10.00, 3000.00, 1800.00, 4000, 0, 2, '2026-01-01 00:00:00', '2026-12-31 00:00:00', 1, NULL, '2026-02-03 12:22:35'),
(25, 'NIGHTEAT15', '15% kedvezmény esti rendelésre', 'percentage', 15.00, 3000.00, 2200.00, 2000, 0, 1, '2026-01-15 00:00:00', '2026-06-30 00:00:00', 1, NULL, '2026-02-03 12:22:35'),
(26, 'SPRING20', '20% tavaszi akció', 'percentage', 20.00, 4500.00, 3500.00, 1500, 0, 1, '2026-03-01 00:00:00', '2026-05-31 00:00:00', 1, NULL, '2026-02-03 12:22:35'),
(27, 'SUMMER15', '15% nyári kedvezmény', 'percentage', 15.00, 4000.00, 3000.00, 2000, 0, 1, '2026-06-01 00:00:00', '2026-08-31 00:00:00', 1, NULL, '2026-02-03 12:22:35'),
(28, 'LOYAL10', '10% kedvezmény visszatérő vásárlóknak', 'percentage', 10.00, 2500.00, 2000.00, 5000, 0, 5, '2026-01-01 00:00:00', '2026-12-31 00:00:00', 1, NULL, '2026-02-03 12:22:35'),
(29, 'FLASH30', '30% villámakció – limitált ideig', 'percentage', 30.00, 5000.00, 4000.00, 300, 0, 1, '2026-02-01 00:00:00', '2026-02-15 00:00:00', 1, NULL, '2026-02-03 12:22:35');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `coupon_usages`
--

DROP TABLE IF EXISTS `coupon_usages`;
CREATE TABLE IF NOT EXISTS `coupon_usages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `coupon_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `order_id` int(11) DEFAULT NULL,
  `discount_amount` decimal(10,2) NOT NULL,
  `used_at` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `coupon_id` (`coupon_id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

--
-- A tábla adatainak kiíratása `coupon_usages`
--

INSERT INTO `coupon_usages` (`id`, `coupon_id`, `user_id`, `order_id`, `discount_amount`, `used_at`) VALUES
(2, 17, 4, NULL, 48014.01, '2026-02-03 12:26:42');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `menu_items`
--

DROP TABLE IF EXISTS `menu_items`;
CREATE TABLE IF NOT EXISTS `menu_items` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `restaurant_id` int(11) NOT NULL,
  `name` text NOT NULL,
  `description` text DEFAULT NULL,
  `price` int(11) NOT NULL,
  `image_url` text DEFAULT NULL,
  `category` text DEFAULT NULL,
  `is_available` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `idx_menu_items_restaurant_id` (`restaurant_id`)
) ENGINE=InnoDB AUTO_INCREMENT=245 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

--
-- A tábla adatainak kiíratása `menu_items`
--

INSERT INTO `menu_items` (`id`, `restaurant_id`, `name`, `description`, `price`, `image_url`, `category`, `is_available`, `created_at`) VALUES
(1, 1, 'Margherita pizza', 'Paradicsomos, mozzarellás klasszikus.', 2490, '/img/EtelKepek/MargaretaPizza.png', 'Pizza', 1, '2026-01-23 21:23:21'),
(2, 1, 'Carbonara spagetti', 'Krémes, szalonnás tészta.', 2890, '/img/EtelKepek/CarbonaraSpagetti.png', 'Tészta', 1, '2026-01-23 21:23:21'),
(3, 1, 'Tiramisu', 'Olasz desszert, kávéval és mascarponéval.', 1690, '/img/EtelKepek/Tiramisu.png', 'Desszert', 1, '2026-01-23 21:23:21'),
(4, 1, 'Quattro Stagioni pizza', 'Négy évszak íze: sonka, gomba, articsóka, olajbogyó.', 3290, '/img/EtelKepek/QUATTRO-STAGIONI-PIZZA-4.jpg', 'Pizza', 1, '2026-01-23 21:23:21'),
(5, 1, 'Lasagne', 'Hagyományos olasz tésztaétel, hússal és besamel mártással.', 3190, '/img/EtelKepek/Lasagna.jpg', 'Tészta', 1, '2026-01-23 21:23:21'),
(6, 1, 'Penne Arrabbiata', 'Csípős paradicsomos szósz, fokhagymával és petrezselyemmel.', 2690, '/img/EtelKepek/penne-allarrabbiata-provehu.jpg', 'Tészta', 1, '2026-01-23 21:23:21'),
(7, 1, 'Bolognai spagetti', 'Marhahúsos paradicsomos szósz, parmezánnal.', 2790, '/img/EtelKepek/bolognai.jpg', 'Tészta', 1, '2026-01-23 21:23:21'),
(8, 1, 'Prosciutto e Funghi pizza', 'Sonka és gomba, mozzarellával.', 2990, '/img/EtelKepek/ProsciuttoEFunghiPizza.jpg', 'Pizza', 1, '2026-01-23 21:23:21'),
(9, 1, 'Panna Cotta', 'Krémes olasz desszert, bogyós gyümölcsökkel.', 1490, '/img/EtelKepek/PannaCotta.webp', 'Desszert', 1, '2026-01-23 21:23:21'),
(10, 1, 'Cannoli', 'Ropogós tészta, édes töltelékkel.', 1290, '/img/EtelKepek/Desktop-Cannoli-with-Ricotta.jpg', 'Desszert', 1, '2026-01-23 21:23:21'),
(11, 2, 'Rántott hús', 'Ropogós panír, friss köret.', 2990, '/img/EtelKepek/Rantotthus.png', 'Főétel', 1, '2026-01-23 21:23:21'),
(12, 2, 'Gulyásleves', 'Hagyományos magyar leves.', 1990, '/img/EtelKepek/Gulyasleves.png', 'Leves', 1, '2026-01-23 21:23:21'),
(13, 2, 'Somlói galuska', 'Kedvelt magyar desszert.', 1490, '/img/EtelKepek/SomloiGaluska.png', 'Desszert', 1, '2026-01-23 21:23:21'),
(14, 2, 'Libamáj', 'Sült libamáj, hagymás körettel.', 3890, '/img/EtelKepek/16.-LIBAMÁJ-02.jpg', 'Főétel', 1, '2026-01-23 21:23:21'),
(15, 2, 'Töltött káposzta', 'Hagyományos magyar fogás, tejföllel.', 2490, '/img/EtelKepek/toltottkaposzta.jpg', 'Főétel', 1, '2026-01-23 21:23:21'),
(16, 2, 'Halászlé', 'Fűszeres halászlé, friss halból.', 3290, '/img/EtelKepek/szegedi-halaszle-filezett-halak.jpg', 'Leves', 1, '2026-01-23 21:23:21'),
(17, 2, 'Pörkölt', 'Marha vagy sertés pörkölt, galuskával.', 2790, '/img/EtelKepek/Sertesporkolt.jpg', 'Főétel', 1, '2026-01-23 21:23:21'),
(18, 2, 'Rakott krumpli', 'Házias rakott krumpli, kolbásszal.', 2190, '/img/EtelKepek/RakottKrumpli.jpg', 'Főétel', 1, '2026-01-23 21:23:21'),
(19, 2, 'Túrós csusza', 'Friss túróval és szalonnával.', 1990, '/img/EtelKepek/Túrós-csusza-scaled.jpg', 'Főétel', 1, '2026-01-23 21:23:21'),
(20, 2, 'Dobos torta', 'Klasszikus magyar torta.', 1290, '/img/EtelKepek/dobostorta.jpg', 'Desszert', 1, '2026-01-23 21:23:21'),
(21, 2, 'Rétes', 'Almás vagy túrós rétes.', 990, '/img/EtelKepek/retes.jpg', 'Desszert', 1, '2026-01-23 21:23:21'),
(22, 3, 'BBQ burger', 'Füstös BBQ szósz, szaftos hús.', 3190, '/img/EtelKepek/BbqBurger.png', 'Burger', 1, '2026-01-23 21:23:21'),
(23, 3, 'Sült krumpli', 'Ropogós, aranybarna.', 990, '/img/EtelKepek/Sultkrumpli.png', 'Köret', 1, '2026-01-23 21:23:21'),
(24, 3, 'Kézműves sör', 'Helyben főzött sör.', 1290, '/img/EtelKepek/kezmuves-sor-Kandallo-1024x683.jpg', 'Ital', 1, '2026-01-23 21:23:21'),
(25, 3, 'Classic burger', 'Marhahús, saláta, paradicsom, hagyma, sajt.', 2790, '/img/EtelKepek/ClassicHamburger.jpg', 'Burger', 1, '2026-01-23 21:23:21'),
(26, 3, 'Chili burger', 'Csípős chili szósz, jalapeño, cheddar sajt.', 3290, '/img/EtelKepek/Chili-Burger.jpg', 'Burger', 1, '2026-01-23 21:23:21'),
(27, 3, 'Vegán burger', 'Növényi alapú húspótló, friss zöldségekkel.', 2590, '/img/EtelKepek/vegan.jpg', 'Burger', 1, '2026-01-23 21:23:21'),
(28, 3, 'Csirkeszárny', 'Fűszeres sült csirkeszárny, BBQ mártással.', 2490, '/img/EtelKepek/csirkeszarny.jpg', 'Főétel', 1, '2026-01-23 21:23:21'),
(29, 3, 'Nachos', 'Ropogós tortilla chips, sajttal és jalapeñóval.', 1890, '/img/EtelKepek/Nachos.jpg', 'Előétel', 1, '2026-01-23 21:23:21'),
(30, 3, 'Sült hagyma karikák', 'Ropogós panírozott hagyma, mártással.', 1490, '/img/EtelKepek/sulthagymakarikak.jpg', 'Előétel', 1, '2026-01-23 21:23:21'),
(31, 3, 'IPA sör', 'Keserű, aromás IPA sör.', 1390, '/img/EtelKepek/IpaSor.png', 'Ital', 1, '2026-01-23 21:23:21'),
(32, 3, 'Stout sör', 'Sötét, krémes stout sör.', 1390, '/img/EtelKepek/Stadin_Panimo_Double_Oat_Malt_Stout.jpg', 'Ital', 1, '2026-01-23 21:23:21'),
(33, 4, 'Húsleves', 'Házi, gazdag húsleves.', 1790, '/img/EtelKepek/Husleves.png', 'Leves', 1, '2026-01-23 21:23:21'),
(34, 4, 'Palacsinta', 'Töltött, édes palacsinta.', 990, '/img/EtelKepek/Palacsinta.png', 'Desszert', 1, '2026-01-23 21:23:21'),
(35, 4, 'Bableves', 'Hagyományos bableves, füstölt hússal.', 1890, '/img/EtelKepek/Bableves.jpg', 'Leves', 1, '2026-01-23 21:23:21'),
(36, 4, 'Sertésszelet', 'Sült sertésszelet, sült burgonyával.', 2690, '/img/EtelKepek/Sertesszelet.jpg', 'Főétel', 1, '2026-01-23 21:23:21'),
(37, 4, 'Lecsó', 'Friss zöldségekből készült lecsó, tojással.', 1990, '/img/EtelKepek/Lecso.webp', 'Főétel', 1, '2026-01-23 21:23:21'),
(38, 4, 'Rántott sajt', 'Ropogós rántott sajt, tartármártással.', 2190, '/img/EtelKepek/rantottsajt.jpg', 'Főétel', 1, '2026-01-23 21:23:21'),
(39, 4, 'Káposztás tészta', 'Friss káposztával készült tészta.', 1790, '/img/EtelKepek/KaposztasTeszta.webp', 'Főétel', 1, '2026-01-23 21:23:21'),
(40, 4, 'Gesztenyepüré', 'Édes gesztenyepüré, tejszínhabbal.', 1190, '/img/EtelKepek/gesztenyepure.jpg', 'Desszert', 1, '2026-01-23 21:23:21'),
(41, 17, 'Mangalica pörkölt', 'Prémium mangalica hús, galuskával.', 4290, '/img/EtelKepek/MangalicaPorkolt.jpg', 'Főétel', 1, '2026-01-23 21:23:21'),
(42, 17, 'Libamáj', 'Sült libamáj, hagymás körettel.', 3890, '/img/EtelKepek/libamaj.jpg', 'Főétel', 1, '2026-01-23 21:23:21'),
(43, 17, 'Kacsacomb', 'Sült kacsacomb, vörös káposztával.', 4490, '/img/EtelKepek/Kacsacomb.jpg', 'Főétel', 1, '2026-01-23 21:23:21'),
(44, 17, 'Házi kolbász', 'Füstölt házi kolbász, mustárral.', 2790, '/img/EtelKepek/erdelyi-kolbasz.webp', 'Főétel', 1, '2026-01-23 21:23:21'),
(45, 17, 'Borleves', 'Hagyományos borleves, fahéjjal.', 1890, '/img/EtelKepek/BorLeves.jpg', 'Leves', 1, '2026-01-23 21:23:21'),
(46, 17, 'Kézműves sör', 'Helyi kézműves sör.', 1490, '/img/EtelKepek/kezmuves-sor-Kandallo-1024x683.jpg', 'Ital', 1, '2026-01-23 21:23:21'),
(47, 18, 'Grillezett marhahús', 'Prémium marhahús, friss zöldségekkel.', 4990, '/img/EtelKepek/GrillezettMarhahús.webp', 'Főétel', 1, '2026-01-23 21:23:21'),
(48, 18, 'Grillezett csirkemell', 'Fűszeres grillezett csirkemell.', 3290, '/img/EtelKepek/grillicsirkecsecs.jpg', 'Főétel', 1, '2026-01-23 21:23:21'),
(49, 18, 'Friss salátabár', 'Választékos salátabár, többféle öntettel.', 2490, '/img/EtelKepek/SalátaBar.png', 'Előétel', 1, '2026-01-23 21:23:21'),
(50, 18, 'Sushi tál', 'Választékos sushi keverék.', 22790, '/img/EtelKepek/SushiBar.png', 'Főétel', 1, '2026-01-23 21:23:21'),
(51, 18, 'Desszert bár', 'Különféle desszertek választéka.', 1990, '/img/EtelKepek/DesszertBar.png', 'Desszert', 1, '2026-01-23 21:23:21'),
(52, 18, 'Korlátlan házi limonádé', 'Friss házi limonádé. Kizárólag helyben fogyasztás esetén korlátlan.', 990, '/img/EtelKepek/házi limonádé.jpg', 'Ital', 1, '2026-01-23 21:23:21'),
(53, 19, 'Sashimi mix', 'Friss sashimi választék: tonhal, lazac, tengeri sügér.', 4590, '/img/EtelKepek/sashimi.jpg', 'Főétel', 1, '2026-01-23 21:23:21'),
(54, 19, 'Nigiri mix', 'Különféle nigiri: tonhal, lazac, rák, tintahal.', 4290, '/img/EtelKepek/nigiri-mix.jpg', 'Főétel', 1, '2026-01-23 21:23:21'),
(55, 19, 'California roll', 'Rák, avokádó, uborka, kaviár.', 2890, '/img/EtelKepek/californiarolls.jpg', 'Főétel', 1, '2026-01-23 21:23:21'),
(56, 19, 'Philadelphia roll', 'Lazac, sajt, avokádó.', 3190, '/img/EtelKepek/PhiladelphiaRoll.jpg', 'Főétel', 1, '2026-01-23 21:23:21'),
(57, 19, 'Tempura rák', 'Ropogós tempura rák, szójamártással.', 3490, '/img/EtelKepek/Tempurarak.png', 'Főétel', 1, '2026-01-23 21:23:21'),
(58, 19, 'Miso leves', 'Hagyományos miso leves, tofuval.', 1490, '/img/EtelKepek/miso-soup-a-japan-konyha-gyongyszeme-milestone66.jpg', 'Leves', 1, '2026-01-23 21:23:21'),
(59, 19, 'Edamame', 'Főtt szójabab, sóval.', 1190, '/img/EtelKepek/edameme.jpg', 'Előétel', 1, '2026-01-23 21:23:21'),
(60, 19, 'Zöld tea', 'Autentikus japán zöld tea.', 890, '/img/EtelKepek/zoldtea.jpg', 'Ital', 1, '2026-01-23 21:23:21'),
(61, 20, 'Taco mix', '3 db taco: marha, csirke, sertés.', 3290, '/img/EtelKepek/TacoMix.png', 'Főétel', 1, '2026-01-23 21:23:21'),
(62, 20, 'Burrito', 'Nagy burrito, marhahússal, babbal, rizzsel.', 2790, '/img/EtelKepek/burrito.jpg', 'Főétel', 1, '2026-01-23 21:23:21'),
(63, 20, 'Quesadilla', 'Sült tortilla, sajttal és csirkével.', 2490, '/img/EtelKepek/quesadilla.jpeg', 'Főétel', 1, '2026-01-23 21:23:21'),
(64, 20, 'Guacamole', 'Friss avokádó, lime-dzsel és fokhagymával.', 1490, '/img/EtelKepek/Guacamole.jpg', 'Előétel', 1, '2026-01-23 21:23:21'),
(65, 20, 'Ceviche', 'Friss hal, lime-dzsel, hagymával és korianderrel.', 3290, '/img/EtelKepek/ceviche.jpg', 'Előétel', 1, '2026-01-23 21:23:21'),
(66, 20, 'Chilaquiles', 'Ropogós tortilla chips, tojással és szósszal.', 2190, '/img/EtelKepek/Chilaquiles.jpg', 'Főétel', 1, '2026-01-23 21:23:21'),
(67, 20, 'Horchata', 'Házi készítésű horchata.', 1190, '/img/EtelKepek/horchata.jpg', 'Ital', 1, '2026-01-23 21:23:21'),
(68, 20, 'Margarita', 'Klasszikus margarita koktél.', 1890, '/img/EtelKepek/margarita.jpg', 'Ital', 1, '2026-01-23 21:23:21'),
(69, 31, 'Guacamole fresco', 'klasszikus avokádókrém lime-mal, korianderrel, hagymával + opcionális habanero vagy chile de árbol a nagyon csípős verzióhoz', 3500, '/img/EtelKepek/Guacamole.png', 'Előétel', 1, '2026-01-27 18:01:46'),
(70, 31, 'Esquites', 'Grillezett kukorica pohárban majonézzel, cotija sajttal, chili porral és lime-mal (kérhető csípősen)', 2800, '/img/EtelKepek/Esquites.png', 'Előétel', 1, '2026-01-27 18:05:36'),
(71, 31, 'Tostadas de ceviche de camarón', 'Ropogós kukoricatortilla friss rákcevichéval, lime-mal, chilivel és avokádóval', 4200, '/img/EtelKepek/Tostadas.png', 'Előétel', 1, '2026-01-27 18:05:36'),
(72, 31, 'Chiles toreados', 'Grillezett jalapeño és serrano paprikák lime-mal és sóval – egyszerű, de extrém csípős sörkorcsolya', 2200, '/img/EtelKepek/Chiles.png', 'Előétel', 1, '2026-01-27 18:05:36'),
(73, 31, 'Memelas oaxaqueñas', 'Vastag, kézzel nyomott kukoricatortilla babbal, oaxaca sajttal és salsa verde vagy roja szósszal', 3600, '/img/EtelKepek/Memelas.png', 'Előétel', 1, '2026-01-27 18:05:36'),
(74, 31, 'Queso fundido con rajas y chorizo', 'Olvadt sajt poblano paprikával és csípős chorizóval, tortilla chips-szel', 3900, '/img/EtelKepek/QuesoFundido.png', 'Előétel', 1, '2026-01-27 18:05:36'),
(75, 31, 'Tacos al pastor', 'Ananásszal marinált, tromposon sült sertéshús friss korianderrel és hagymával', 5200, '/img/EtelKepek/TacosAlPastor.png', 'Főétel', 1, '2026-01-27 18:06:29'),
(76, 31, 'Enchiladas verdes o rojas', 'Csirkés vagy sajtos enchilada zöld vagy piros szószban, crema-val és sajttal', 4800, '/img/EtelKepek/Enchiladas.png', 'Főétel', 1, '2026-01-27 18:06:29'),
(77, 31, 'Pozole rojo', 'Hagyományos csípős hominy leves sertéshússal, oregánóval, retekkel és lime-mal', 4600, '/img/EtelKepek/PozoleRojo.png', 'Főétel', 1, '2026-01-27 18:06:29'),
(78, 31, 'Tlayudas oaxaqueñas', 'Óriás ropogós tortilla babbal, oaxaca sajttal, chorizóval vagy carne asadával és salsa macha-val', 5900, '/img/EtelKepek/Tlayudas.png', 'Főétel', 1, '2026-01-27 18:06:29'),
(79, 31, 'Chilaquiles divorciados', 'Kukoricachips zöld és piros salsa-val elválasztva, tojással, crema-val', 4400, '/img/EtelKepek/ChilaquilesDivorciados.png', 'Főétel', 1, '2026-01-27 18:06:29'),
(80, 31, 'Mole coloradito', 'Oaxacai könnyedebb mole szósz csirkével, mély, fűszeres ízvilággal', 6200, '/img/EtelKepek/MoleColoradito.png', 'Főétel', 1, '2026-01-27 18:06:29'),
(81, 31, 'Cochinita pibil', 'Achiote-ban pácolt, banánlevélben sült sertéshús habanero salsával', 5800, '/img/EtelKepek/Cochinita.png', 'Főétel', 1, '2026-01-27 18:06:29'),
(82, 31, 'Chileatole de pollo', 'Csípős kukoricaleves csirkével, epazote-tal és zöld chilivel', 4300, '/img/EtelKepek/Chileatole.png', 'Főétel', 1, '2026-01-27 18:06:29'),
(83, 31, 'Entomatadas', 'Paradicsomos mártásban tálalt tortilla hagymával, sajttal és crema-val', 4100, '/img/EtelKepek/Entomatadas.png', 'Főétel', 1, '2026-01-27 18:06:29'),
(84, 31, 'Barbacoa de borrego', 'Lassan sült birka agave levélben, consommé-vel és salsa borracha-val', 6900, '/img/EtelKepek/Barbacoa.png', 'Főétel', 1, '2026-01-27 18:06:29'),
(85, 31, 'Tikin xic', 'Achiote és narancs marinált grillezett halfilé pikáns habanero salsával', 6400, '/img/EtelKepek/TikinXic.png', 'Főétel', 1, '2026-01-27 18:06:29'),
(86, 31, 'Flan de cajeta', 'Kecsketejes karamellás flan', 2600, '/img/EtelKepek/Flan.png', 'Desszert', 1, '2026-01-27 18:07:11'),
(87, 31, 'Arroz con leche mexicano', 'Fahéjas rizspuding vaníliával és lime héjjal', 2400, '/img/EtelKepek/ArrozCon.png', 'Desszert', 1, '2026-01-27 18:07:11'),
(88, 31, 'Churros con cajeta y chile', 'Fahéjas churros karamellmártással és opcionális chile porral', 2800, '/img/EtelKepek/Churros.png', 'Desszert', 1, '2026-01-27 18:07:11'),
(89, 31, 'Plátanos fritos con crema y piloncillo', 'Karamellizált sült banán tejszínnel és panelával', 2500, '/img/EtelKepek/Plátanos.png', 'Desszert', 1, '2026-01-27 18:07:11'),
(90, 31, 'Nicuatole', 'Krémes oaxacai kukoricás puding kókusszal vagy fahéjjal', 2700, '/img/EtelKepek/Nicuatole.png', 'Desszert', 1, '2026-01-27 18:07:11'),
(91, 31, 'Agua fresca', 'Házi frissítő ital: jamaica, horchata vagy tamarindo', 1800, '/img/EtelKepek/AgueFrescaa.png', 'Ital', 1, '2026-01-27 18:07:21'),
(92, 31, 'Michelada clásica', 'Sör lime-mal, sóval, chilivel és worcestershire szósszal', 2900, '/img/EtelKepek/Michelada.png', 'Ital', 1, '2026-01-27 18:07:21'),
(93, 31, 'Margarita de mezcal y chile', 'Füstös mezcal margarita chile só peremmel', 3600, '/img/EtelKepek/MargaritaChile.png', 'Ital', 1, '2026-01-27 18:07:21'),
(94, 31, 'Tepache', 'Fermentált ananász ital, enyhén savanykás és frissítő', 2100, '/img/EtelKepek/Tepache.png', 'Ital', 1, '2026-01-27 18:07:21'),
(95, 31, 'Café de olla', 'Fahéjas, panelás mexikói kávé', 1900, '/img/EtelKepek/CaféDeOlla.png', 'Ital', 1, '2026-01-27 18:07:21'),
(96, 31, 'Mezcal flight', '3–4 féle artisán mezcal kóstoló chilito sóval', 7200, '/img/EtelKepek/MezcalFlight.png', 'Ital', 1, '2026-01-27 18:07:21'),
(97, 31, 'Paloma picante', 'Tequila, grapefruit és lime jalapeño vagy habanero infúzióval', 3400, '/img/EtelKepek/Paloma.png', 'Ital', 1, '2026-01-27 18:07:21'),
(98, 30, 'Gyoza', 'Kézzel hajtott sertés-zöldség dumplings pirítva, yuzu ponzu vagy chili oil mártással (extra csípős opcióval)', 3200, '/img/EtelKepek/Gyoza.png', 'Előétel', 1, '2026-01-27 18:09:49'),
(99, 30, 'Kimchi jeon', 'Fermentált káposztás koreai palacsinta zöldhagymával, gochujang mártással (extra csípős verzióval)', 3000, '/img/EtelKepek/kimchi.png', 'Előétel', 1, '2026-01-27 18:09:49'),
(100, 30, 'Satay ayam', 'Grillezett csirkepálcikák kókuszos-földimogyorós szósszal, sambal kísérettel', 3400, '/img/EtelKepek/SatayAyam.png', 'Előétel', 1, '2026-01-27 18:09:49'),
(101, 30, 'Bánh xèo', 'Ropogós vietnami rizstészta palacsinta rákkal, babcsírával, friss fűszernövényekkel és nuoc cham szósszal', 3900, '/img/EtelKepek/BanhXeo.png', 'Előétel', 1, '2026-01-27 18:09:49'),
(102, 30, 'Sichuan dan dan mian (mini)', 'Fűszeres sertéshúsos tészta Sichuan pepperrel és chili olajjal (numbing & spicy)', 3500, '/img/EtelKepek/SichuanDanDanMian.png', 'Előétel', 1, '2026-01-27 18:09:49'),
(103, 30, 'Rojak', 'Friss gyümölcs-zöldség saláta tamarindos-mogyorós édes-csípős dresszinggel', 2800, '/img/EtelKepek/Rojak.png', 'Előétel', 1, '2026-01-27 18:09:49'),
(104, 30, 'Edamame', 'Párolt szójabab tengeri sóval vagy spicy miso chili szósszal', 2200, '/img/EtelKepek/Edamame.png', 'Előétel', 1, '2026-01-27 18:09:49'),
(105, 30, 'Pad Thai', 'Thaiföldi rizstészta rákkal vagy tojással, tamarinddal, földimogyoróval (kérhető csípősen)', 5200, '/img/EtelKepek/Padthai.png', 'Főétel', 1, '2026-01-27 18:10:08'),
(106, 30, 'Bibimbap', 'Koreai rizses tál zöldségekkel, gochujanggal, bulgogival és tojással', 5400, '/img/EtelKepek/Bibimbap.png', 'Főétel', 1, '2026-01-27 18:10:08'),
(107, 30, 'Pho bo', 'Vietnami marhahúsleves rizstésztával, fűszernövényekkel, lime-mal és chili-vel', 5100, '/img/EtelKepek/PhoBo.png', 'Főétel', 1, '2026-01-27 18:10:08'),
(108, 30, 'Laksa', 'Kókuszos curry leves rizstésztával, rákkal vagy csirkével, intenzív chili pasztával', 5600, '/img/EtelKepek/laksa.png', 'Főétel', 1, '2026-01-27 18:10:08'),
(109, 30, 'Tom Yum Goong', 'Thai savanyú-csípős garnélarák leves citromfűvel, galangállal és kaffir lime-mal', 5400, '/img/EtelKepek/TomYumGoong.png', 'Főétel', 1, '2026-01-27 18:10:08'),
(110, 30, 'Mapo tofu', 'Sichuan-i puha tofu darált sertéshússal, chili bean pasztával és Sichuan pepperrel', 4900, '/img/EtelKepek/MapoTofu.png', 'Főétel', 1, '2026-01-27 18:10:08'),
(111, 30, 'Rendang daging', 'Indonéz lassan főtt marha kókusztejben, intenzív fűszerezéssel és chili-vel', 6200, '/img/EtelKepek/RendangDaging.png', 'Főétel', 1, '2026-01-27 18:10:08'),
(112, 30, 'Cao lầu', 'Hoi An-i vastag rizstészta grillezett sertéshússal, zöldfűszerekkel és chili ecettel', 5500, '/img/EtelKepek/CaoLau.png', 'Főétel', 1, '2026-01-27 18:10:08'),
(113, 30, 'Three Cup Chicken', 'Bazsalikomos-fokhagymás csirke szójaszószban, csillagánizzsal', 5600, '/img/EtelKepek/threecupchicken.png', 'Főétel', 1, '2026-01-27 18:10:08'),
(114, 30, 'Nasi goreng kampung', 'Maláj falusi sült rizs szardellával, tojással és nagyon csípős samballal', 4800, '/img/EtelKepek/NasiGoreng.png', 'Főétel', 1, '2026-01-27 18:10:08'),
(115, 30, 'Suan cai yu', 'Sichuan-i savanyú káposztás hal chili olajjal, erősen fűszeres', 6100, '/img/EtelKepek/suancai.png', 'Főétel', 1, '2026-01-27 18:10:08'),
(116, 30, 'Bò lúc lắc', 'Vietnami „rázkódó” marhahús hagymával, vajjal és borssal', 5900, '/img/EtelKepek/Boluc.png', 'Főétel', 1, '2026-01-27 18:10:08'),
(117, 30, 'Mangós ragadós rizs', 'Thai ragacsos rizs friss mangóval és kókusztejjel', 2900, '/img/EtelKepek/MangoStickyRice.png', 'Desszert', 1, '2026-01-27 18:10:16'),
(118, 30, 'Matcha mochi fagylalt', 'Japán matchás mochi jégkrémmel töltve', 2600, '/img/EtelKepek/MatchaMochi.png', 'Desszert', 1, '2026-01-27 18:10:16'),
(119, 30, 'Cendol', 'Kókusztejes desszert pandan zselével, vörös babbal és pálmacukorral', 2800, '/img/EtelKepek/Cendol.png', 'Desszert', 1, '2026-01-27 18:10:16'),
(120, 30, 'Bingsu patbingsu', 'Koreai jégkása vörös babbal, gyümölccsel és sűrített tejjel', 3200, '/img/EtelKepek/Bingsu.png', 'Desszert', 1, '2026-01-27 18:10:16'),
(121, 30, 'Halo-halo', 'Fülöp-szigeteki kevert jégdesszert gyümölcsökkel, zselével és ube-val', 3400, '/img/EtelKepek/HaloHalo.png', 'Desszert', 1, '2026-01-27 18:10:16'),
(122, 30, 'Durian chè', 'Vietnami duriános rizspuding kókusztejjel (szezonális)', 3600, '/img/EtelKepek/Durian.png', 'Desszert', 1, '2026-01-27 18:10:16'),
(123, 30, 'Thai jegestea', 'Erős thai tea sűrített tejjel és jéggel', 2200, '/img/EtelKepek/ThaiJegesTea.png', 'Ital', 1, '2026-01-27 18:10:22'),
(124, 30, 'Vietnámi jegeskávé', 'Robusta kávé sűrített tejjel, jéggel', 2300, '/img/EtelKepek/VietnamJegesKave.png', 'Ital', 1, '2026-01-27 18:10:22'),
(125, 30, 'Soju vagy makgeolli', 'Koreai rizsalkohol – shot vagy pohár', 2600, '/img/EtelKepek/Soju.png', 'Ital', 1, '2026-01-27 18:10:22'),
(126, 30, 'Calpico', 'Japán üdítő', 2000, '/img/EtelKepek/Calpico.png', 'Ital', 1, '2026-01-27 18:10:22'),
(127, 30, 'Bandung', 'Maláj rózsás ital sűrített tejjel és jéggel', 2100, '/img/EtelKepek/Bandung.png', 'Ital', 1, '2026-01-27 18:10:22'),
(128, 30, 'Uborka lime agua fresca', 'Lime limonádé ubroka infúzióval', 1900, '/img/EtelKepek/AguaFresca.png', 'Ital', 1, '2026-01-27 18:10:22'),
(129, 30, 'Yakult shot', 'Fermentált japán joghurtital', 1800, '/img/EtelKepek/Yakult.png', 'Ital', 1, '2026-01-27 18:10:22'),
(130, 30, 'Sake flight vagy shochu', 'Japán párlat- és sake válogatás', 6800, '/img/EtelKepek/Parlat.png', 'Ital', 1, '2026-01-27 18:10:22'),
(131, 30, 'Lychee martini', 'Martini friss licsivel', 3400, '/img/EtelKepek/Lychee.png', 'Ital', 1, '2026-01-27 18:10:22'),
(132, 21, 'Házi lepény trio', 'Három mini házi lepény: fokhagymás vajjal, paradicsomos-mozzarellás mini pizza stílusban és spenótos-feta krémmel', 3200, '/img/EtelKepek/LepenyTrio.png', 'Előétel', 1, '2026-01-27 18:12:43'),
(133, 21, 'Lepény falatkák', 'Apró házi lepénykék avokádókrémmel, buggyantott fürjtojással, chilivel vagy bacon morzsával', 3400, '/img/EtelKepek/LepenyFalatok.png', 'Előétel', 1, '2026-01-27 18:12:43'),
(134, 21, 'Brunch deviled eggs', 'Töltött tojás házi majonézzel és mustárral, opcionális füstölt lazaccal vagy kimchivel', 2600, '/img/EtelKepek/DeviledEggs.jpg', 'Előétel', 1, '2026-01-27 18:12:43'),
(135, 21, 'Sült camembert lepényen', 'Grillezett házi lepényen tálalt olvadt camembert mézzel, dióval és rukkolával', 3600, '/img/EtelKepek/SultCamembert.png', 'Előétel', 1, '2026-01-27 18:12:43'),
(136, 21, 'Házi savanyúság tál', 'Uborka, répa, lilahagyma és chili – könnyű starter sör mellé', 2400, '/img/EtelKepek/Savanyusag.png', 'Előétel', 1, '2026-01-27 18:12:43'),
(137, 21, 'Lepény pizza', 'Ropogós lepény pirított tojással, baconnel, cheddarral, avokádóval és chilivel', 4800, '/img/EtelKepek/FlatbreadPizza.png', 'Főétel', 1, '2026-01-27 18:13:03'),
(138, 21, 'Mediterrán lepény', 'Házi lepény tzatzikivel, grillezett zöldségekkel, fetával és olívabogyóval', 4500, '/img/EtelKepek/MediterranLepeny.png', 'Főétel', 1, '2026-01-27 18:13:03'),
(139, 21, 'Pulled pork lepény', 'BBQ-s lassan főtt sertéshús coleslaw-val és jalapeñóval házi lepényen', 5200, '/img/EtelKepek/PulledPorkFlatbread.png', 'Főétel', 1, '2026-01-27 18:13:03'),
(140, 21, 'Kecskesajtos-céklás lepény', 'Kecskesajtos-sült céklás lepény rukkolával és balzsamecettel', 4700, '/img/EtelKepek/KecskeCeklalepeny.png', 'Főétel', 1, '2026-01-27 18:13:03'),
(141, 21, 'Pestos csirke', 'Grillezett csirkemell pestós krémmel, cherry paradicsommal és mozzarellával', 5100, '/img/EtelKepek/PestoChicken.png', 'Főétel', 1, '2026-01-27 18:13:03'),
(142, 21, 'Shakshuka pub style', 'Fűszeres paradicsomos szószban sült tojások fetával és korianderrel, házi lepénnyel', 4400, '/img/EtelKepek/Shakshuka.png', 'Főétel', 1, '2026-01-27 18:13:25'),
(143, 21, 'Eggs Benedict variációk', 'Buggyantott tojás házi hollandi mártással – sonkás, lazacos vagy spenótos-gombás verzió', 5200, '/img/EtelKepek/EggsBenedict.png', 'Főétel', 1, '2026-01-27 18:13:25'),
(144, 21, 'Full English breakfast', 'Kisebb angol reggeli kolbásszal, baconnel, tojással és házi lepénnyel', 5400, '/img/EtelKepek/FullEnglish.png', 'Főétel', 1, '2026-01-27 18:13:25'),
(145, 21, 'Avocado toast deluxe', 'Avokádós toast chilivel és buggyantott tojással, opcionális lazaccal vagy chorizóval', 4600, '/img/EtelKepek/AvocadeDeluxe.png', 'Főétel', 1, '2026-01-27 18:13:25'),
(146, 21, '\"Hangover hash\"', 'Sült krumpli hagymával, paprikával, baconnel vagy chorizóval, tükörtojással', 4900, '/img/EtelKepek/Hangoverhash.png', 'Főétel', 1, '2026-01-27 18:13:25'),
(147, 21, 'Veggie bowl', 'Quinoa vagy bulgur grillezett zöldségekkel, tojással, fetával és tahini dresszinggel', 4300, '/img/EtelKepek/veggiebowl.png', 'Főétel', 1, '2026-01-27 18:13:25'),
(148, 21, 'Házi lepény Nutellával', 'Meleg házi lepény Nutellával, banánnal és porcukorral', 2600, '/img/EtelKepek/NutellaLepeny.png', 'Desszert', 1, '2026-01-27 18:13:33'),
(149, 21, 'French toast lepény', 'Fahéjas-tojásos bundában sült lepény bogyós gyümölcsökkel és juharsziruppal', 2900, '/img/EtelKepek/FrenchToast.png', 'Desszert', 1, '2026-01-27 18:13:33'),
(151, 21, 'Fahéjas tekercs', 'Mini fahéjas tekercs krémsajtos mázzal', 2800, '/img/EtelKepek/CinnamonRoll.png', 'Desszert', 1, '2026-01-27 18:13:33'),
(152, 21, 'Sós karamellás brownie', 'Kis adag brownie sós karamellel és vaníliafagyival', 3000, '/img/EtelKepek/SoskaramellasBrownie.png', 'Desszert', 1, '2026-01-27 18:13:33'),
(153, 21, 'Mimosa', 'Prosecco narancs- vagy őszibaracklével (időszakos ajánlat)', 5900, '/img/EtelKepek/Mimosa.png', 'Ital', 1, '2026-01-27 18:13:40'),
(154, 21, 'Bloody Mary', 'Házi fűszeres paradicsomlé vodkával, tabascóval és worcestershire-rel', 3400, '/img/EtelKepek/BloodyMary.png', 'Ital', 1, '2026-01-27 18:13:40'),
(155, 21, 'Ír kávé', 'Forró kávé ír whiskyvel és tejszínhabbal', 3200, '/img/EtelKepek/Irkave.png', 'Ital', 1, '2026-01-27 18:13:40'),
(156, 21, 'Flat white', 'Specialty kávé selymes tejhabbal', 1900, '/img/EtelKepek/Flatwhite.png', 'Ital', 1, '2026-01-27 18:13:40'),
(157, 21, 'Házi limonádé', 'Citromos alap eperrel, bazsalikommal vagy levendulával', 2000, '/img/EtelKepek/Limonade.png', 'Ital', 1, '2026-01-27 18:13:40'),
(158, 21, 'Craft sörök', '3–4 féle könnyű craft sör brunchhoz', 3600, '/img/EtelKepek/CraftSör.png', 'Ital', 1, '2026-01-27 18:13:40'),
(159, 21, 'Aperol spritz', 'Aperol, prosecco és szóda lime-mal', 3300, '/img/EtelKepek/AperolSpritz.png', 'Ital', 1, '2026-01-27 18:13:40'),
(160, 21, 'Matcha latte vagy chai latte', 'Tejes specialty ital matchából vagy chai fűszerkeverékből', 2400, '/img/EtelKepek/MatchaLatte.png', 'Ital', 1, '2026-01-27 18:13:40'),
(161, 21, 'Citromos túró desszert', 'Joghurtos desszert citromos túróval, friss bogyókkal és granolával', 2700, '/img/EtelKepek/LemonCurdBerry.png', 'Desszert', 1, '2026-01-27 18:13:33'),
(162, 32, 'Burrata al Tartufo', 'Krémes burrata friss szarvasgombával és extra szűz olívaolajjal', 3490, '/img/EtelKepek/Burrata.png', 'Előétel', 1, '2026-02-02 11:19:16'),
(163, 32, 'Vitello Tonnato', 'Vékonyra szeletelt borjúhús tonhalas-kapris krémmel', 3690, '/img/EtelKepek/Vitello.png', 'Előétel', 1, '2026-02-02 11:19:16'),
(164, 32, 'Caponata Siciliana', 'Szicíliai édes-savanyú padlizsánragu zöldségekkel', 2990, '/img/EtelKepek/Caponata.png', 'Előétel', 1, '2026-02-02 11:19:16'),
(165, 32, 'Frittelle di Baccalà', 'Ropogós tőkehalfalatok citromos aiolival', 3290, '/img/EtelKepek/Bacatta.png', 'Előétel', 1, '2026-02-02 11:19:16'),
(166, 32, 'Insalata di Polpo', 'Citromos-olívaolajos polipsaláta friss petrezselyemmel', 3890, '/img/EtelKepek/Insalata.png', 'Előétel', 1, '2026-02-02 11:19:16'),
(167, 32, 'Arancini al Ragù', 'Sicíliai töltött rizsgolyók húsos paradicsommártással', 3190, '/img/EtelKepek/Arancini.png', 'Előétel', 1, '2026-02-02 11:19:16'),
(168, 32, 'Pappardelle al Cinghiale', 'Széles metélt házi vadmalacraguval', 5490, '/img/EtelKepek/Pappardelle.png', 'Főétel', 1, '2026-02-02 11:19:16'),
(169, 32, 'Risotto al Nero di Seppia', 'Tintahalas rizottó tintahal tintájával', 5290, '/img/EtelKepek/Risotto.png', 'Főétel', 1, '2026-02-02 11:19:16'),
(170, 32, 'Orecchiette con Cime di Rapa', 'Pugliai tészta brokkolirabe-val és szardellával', 4690, '/img/EtelKepek/Orecchiette.png', 'Főétel', 1, '2026-02-02 11:19:16'),
(171, 32, 'Gnocchi alla Sorrentina', 'Paradicsomszósz, mozzarella és friss bazsalikom', 4790, '/img/EtelKepek/Gnocchi.png', 'Főétel', 1, '2026-02-02 11:19:16'),
(172, 32, 'Spaghetti alla Bottarga', 'Szardíniai tészta szárított ikrával és citromhéjjal', 5190, '/img/EtelKepek/spaghetti.png', 'Főétel', 1, '2026-02-02 11:19:16'),
(173, 32, 'Lasagna Bianca ai Funghi', 'Fehér lasagne erdei gombákkal és besamellel', 5090, '/img/EtelKepek/Lasagne.png', 'Főétel', 1, '2026-02-02 11:19:16'),
(174, 32, 'Saltimbocca alla Romana', 'Borjúkaraj prosciuttóval és zsályával', 5790, '/img/EtelKepek/Saltimbocca.png', 'Főétel', 1, '2026-02-02 11:19:16'),
(175, 32, 'Pollo alla Cacciatora', 'Vadász módra készült csirke boros-paradicsomos mártásban', 5190, '/img/EtelKepek/Pollo.png', 'Főétel', 1, '2026-02-02 11:19:16'),
(176, 32, 'Ossobuco alla Milanese', 'Hosszan párolt borjúlábszár gremolatával', 6990, '/img/EtelKepek/Ossobuco.png', 'Főétel', 1, '2026-02-02 11:19:16'),
(177, 32, 'Branzino al Forno', 'Egészben sült tengeri sügér citrommal', 6490, '/img/EtelKepek/Branzino.png', 'Főétel', 1, '2026-02-02 11:19:16'),
(178, 32, 'Margherita DOP', 'San Marzano paradicsom, bivalymozzarella, bazsalikom', 3790, '/img/EtelKepek/MargheritaDop.png', 'Pizza', 1, '2026-02-02 11:19:16'),
(179, 32, 'Diavola', 'Csípős szalámi, paradicsomszósz és mozzarella', 4290, '/img/EtelKepek/Diavola.png', 'Pizza', 1, '2026-02-02 11:19:16'),
(180, 32, 'Pizza Gorgonzola e Pere', 'Gorgonzola, körte és dió fehér alapon', 4990, '/img/EtelKepek/Gorgonzola.png', 'Pizza', 1, '2026-02-02 11:19:16'),
(181, 32, 'Salsiccia e Friarielli', 'Olasz kolbász és brokkolirabe nápolyi stílusban', 5190, '/img/EtelKepek/Salsiccia.png', 'Pizza', 1, '2026-02-02 11:19:16'),
(182, 32, 'Tiramisu Classico', 'Mascarponés krém kávéval és kakaóval', 2890, '/img/EtelKepek/Tiramisu2.png', 'Desszert', 1, '2026-02-02 11:19:16'),
(183, 32, 'Torta Caprese', 'Lisztmentes csokoládés-mandulás torta', 2690, '/img/EtelKepek/TortaCaprese.png', 'Desszert', 1, '2026-02-02 11:19:16'),
(184, 32, 'Cannoli Siciliani', 'Ropogós cső ricottakrémmel és pisztáciával', 2990, '/img/EtelKepek/Sicilian.png', 'Desszert', 1, '2026-02-02 11:19:16'),
(185, 32, 'Panna Cotta al Pistacchio', 'Pisztáciás panna cotta', 2790, '/img/EtelKepek/PannaCotta.png', 'Desszert', 1, '2026-02-02 11:19:16'),
(186, 32, 'Affogato al Caffè', 'Vaníliafagylalt forró eszpresszóval', 2490, '/img/EtelKepek/Affogato.png', 'Desszert', 1, '2026-02-02 11:19:16'),
(187, 32, 'Espresso Italiano', 'Olasz eszpresszó', 690, '/img/EtelKepek/Italian.png', 'Ital', 1, '2026-02-02 11:19:16'),
(188, 32, 'Cappuccino', 'Eszpresszó gőzölt tejhabbal', 890, '/img/EtelKepek/Cappuccino.png', 'Ital', 1, '2026-02-02 11:19:16'),
(189, 32, 'Aperol Spritz', 'Aperol, prosecco és szóda', 1990, '/img/EtelKepek/AperolSpritz2.png', 'Ital', 1, '2026-02-02 11:19:16'),
(190, 32, 'Campari Soda', 'Campari szódával', 1790, '/img/EtelKepek/Campari.png', 'Ital', 1, '2026-02-02 11:19:16'),
(191, 32, 'Limoncello', 'Hagyományos olasz citromlikőr', 1390, '/img/EtelKepek/Limoncello.png', 'Ital', 1, '2026-02-02 11:19:16'),
(192, 32, 'Montepulciano d’Abruzzo', 'Gyümölcsös olasz vörösbor (1 dl)', 1190, '/img/EtelKepek/Montepulciano.png', 'Bor', 1, '2026-02-02 11:19:16'),
(193, 32, 'Vermentino di Sardegna', 'Ásványos, citrusos olasz fehérbor (1 dl)', 1290, '/img/EtelKepek/Vermentino.png', 'Bor', 1, '2026-02-02 11:19:16'),
(194, 34, 'Tzatziki pita kenyérrel', 'Hagyományos joghurtos uborkakrém friss pitával.', 1490, 'img/EtelKepek/default.jpg', 'Előétel', 1, '2026-02-03 11:49:50'),
(195, 34, 'Dolmades', 'Szőlőlevélbe töltött fűszeres rizs joghurtos mártogatóssal.', 1690, 'img/EtelKepek/default.jpg', 'Előétel', 1, '2026-02-03 11:49:50'),
(196, 34, 'Feta saganaki', 'Rántott feta sajt szezámmaggal és mézzel.', 1790, 'img/EtelKepek/default.jpg', 'Előétel', 1, '2026-02-03 11:49:50'),
(197, 34, 'Görög saláta', 'Paradicsom, uborka, olívabogyó, feta sajt.', 1990, 'img/EtelKepek/default.jpg', 'Saláta', 1, '2026-02-03 11:49:50'),
(198, 34, 'Mediterrán csirkesaláta', 'Grillezett csirkemell, friss zöldségek, olívaolaj.', 2490, 'img/EtelKepek/default.jpg', 'Saláta', 1, '2026-02-03 11:49:50'),
(199, 34, 'Csirkés gyros pitában', 'Grillezett csirkehús, tzatziki, friss zöldségek.', 2790, 'img/EtelKepek/default.jpg', 'Főétel', 1, '2026-02-03 11:49:50'),
(200, 34, 'Sertés gyros pitában', 'Fűszeres sertéshús klasszikus görög módra.', 2890, 'img/EtelKepek/default.jpg', 'Főétel', 1, '2026-02-03 11:49:50'),
(201, 34, 'Gyros tál csirkéből', 'Csirkegyros sült krumplival és salátával.', 3290, 'img/EtelKepek/default.jpg', 'Főétel', 1, '2026-02-03 11:49:50'),
(202, 34, 'Gyros tál sertésből', 'Sertésgyros pitával és házi szósszal.', 3390, 'img/EtelKepek/default.jpg', 'Főétel', 1, '2026-02-03 11:49:50'),
(203, 34, 'Csirkés souvlaki', 'Nyárson grillezett csirkemell steak körettel.', 3590, 'img/EtelKepek/default.jpg', 'Főétel', 1, '2026-02-03 11:49:50'),
(204, 34, 'Sertés souvlaki', 'Pácolt sertéshús nyárson, görög fűszerekkel.', 3690, 'img/EtelKepek/default.jpg', 'Főétel', 1, '2026-02-03 11:49:50'),
(205, 34, 'Moussaka', 'Padlizsános rakott étel darált hússal és besamellel.', 3490, 'img/EtelKepek/default.jpg', 'Főétel', 1, '2026-02-03 11:49:50'),
(206, 34, 'Grillezett halloumi tál', 'Pirított halloumi sajt salátával és pitával.', 3290, 'img/EtelKepek/default.jpg', 'Főétel', 1, '2026-02-03 11:49:50'),
(207, 34, 'Baklava', 'Réteslapos sütemény dióval és mézzel.', 1590, 'img/EtelKepek/default.jpg', 'Desszert', 1, '2026-02-03 11:49:50'),
(208, 34, 'Galaktoboureko', 'Grízes krémmel töltött sütemény citromos sziruppal.', 1690, 'img/EtelKepek/default.jpg', 'Desszert', 1, '2026-02-03 11:49:50'),
(209, 34, 'Görög joghurt mézzel és dióval', 'Könnyű, friss desszert.', 1390, 'img/EtelKepek/default.jpg', 'Desszert', 1, '2026-02-03 11:49:50'),
(210, 34, 'Narancsos görög sütemény', 'Szirupos narancsos piskóta.', 1490, 'img/EtelKepek/default.jpg', 'Desszert', 1, '2026-02-03 11:49:50'),
(211, 34, 'Mythos sör 0,33l', 'Eredeti görög világos sör.', 1290, 'img/EtelKepek/default.jpg', 'Alkoholos ital', 1, '2026-02-03 11:49:50'),
(212, 34, 'Ouzo 4cl', 'Hagyományos ánizsos görög párlat.', 1190, 'img/EtelKepek/default.jpg', 'Alkoholos ital', 1, '2026-02-03 11:49:50'),
(213, 34, 'Görög vörösbor 1dl', 'Száraz, testes görög bor.', 1090, 'img/EtelKepek/default.jpg', 'Alkoholos ital', 1, '2026-02-03 11:49:50'),
(214, 34, 'Coca-Cola 0,33l', 'Szénsavas üdítőital.', 690, 'img/EtelKepek/default.jpg', 'Üdítő', 1, '2026-02-03 11:49:50'),
(215, 34, 'Fanta Narancs 0,33l', 'Narancsízű szénsavas üdítő.', 690, 'img/EtelKepek/default.jpg', 'Üdítő', 1, '2026-02-03 11:49:50'),
(216, 34, 'Ásványvíz 0,5l', 'Szénsavmentes ásványvíz.', 590, 'img/EtelKepek/default.jpg', 'Üdítő', 1, '2026-02-03 11:49:50'),
(217, 33, 'Souvlaki', 'Grillezett hús nyárs, friss pita kenyérrel, tzatziki szósszal és salátával.', 1500, 'https://example.com/images/souvlaki.jpg', 'Előétel', 1, '2026-02-03 12:10:07'),
(218, 33, 'Tzatziki', 'Görög joghurt, uborka, fokhagyma, olívaolaj és friss fűszerek keveréke.', 800, 'https://example.com/images/tzatziki.jpg', 'Előétel', 1, '2026-02-03 12:10:07'),
(219, 33, 'Dolmadakia', 'Szőlőlevelekbe tekert rizses töltelék, fűszerezve kaporral, fokhagymával, és citromlével.', 1200, 'https://example.com/images/dolmadakia.jpg', 'Előétel', 1, '2026-02-03 12:10:07'),
(220, 33, 'Spanakopita', 'Görög spenótos pite phyllo tésztában, feta sajttal és friss fűszerekkel töltve.', 1400, 'https://example.com/images/spanakopita.jpg', 'Előétel', 1, '2026-02-03 12:10:07'),
(221, 33, 'Keftedes', 'Görög húsgombócok, fűszeres paradicsom szósszal, friss pita kenyérrel.', 1600, 'https://example.com/images/keftedes.jpg', 'Előétel', 1, '2026-02-03 12:10:07'),
(222, 33, 'Saganaki', 'Olvasztott feta sajt, olívaolajjal és friss citromlével tálalva.', 1800, 'https://example.com/images/saganaki.jpg', 'Előétel', 1, '2026-02-03 12:10:07'),
(223, 33, 'Moussaka', 'Rakott padlizsán, darált hús, béchamel mártás, friss fűszerekkel.', 2500, 'https://example.com/images/moussaka.jpg', 'Főétel', 1, '2026-02-03 12:10:07'),
(224, 33, 'Gyro', 'Friss pita, grillezett hús (csirke vagy sertés), tzatziki és zöldségek.', 2000, 'https://example.com/images/gyro.jpg', 'Főétel', 1, '2026-02-03 12:10:07'),
(225, 33, 'Kleftiko', 'Török eredetű, lassan sült bárányhús, citrommal, fokhagymával, olívaolajjal, és friss fűszerekkel.', 3000, 'https://example.com/images/kleftiko.jpg', 'Főétel', 1, '2026-02-03 12:10:07'),
(226, 33, 'Pastitsio', 'Hagyományos görög rakott tészta, darált húsos raguval és béchamellel.', 2200, 'https://example.com/images/pastitsio.jpg', 'Főétel', 1, '2026-02-03 12:10:07'),
(227, 33, 'Kalamari', 'Grillezett vagy ropogósra sült tintahal, citromos-olívaolajos öntettel.', 2500, 'https://example.com/images/kalamari.jpg', 'Főétel', 1, '2026-02-03 12:10:07'),
(228, 33, 'Souvlaki Platter', 'Nyársra húzott grillezett húsok (csirke, sertés, bárány), friss saláta és tzatziki.', 2800, 'https://example.com/images/souvlaki_platter.jpg', 'Főétel', 1, '2026-02-03 12:10:07'),
(229, 33, 'Greek Village Salad (Horiatiki)', 'Friss zöldségek, feta sajt, kalamata olíva, oregánó és olívaolaj.', 1500, 'https://example.com/images/horiatiki.jpg', 'Saláta', 1, '2026-02-03 12:10:07'),
(230, 33, 'Fattoush Saláta', 'Színes zöldségek, pirított pita, citromos öntet, friss fűszerekkel.', 1600, 'https://example.com/images/fattoush.jpg', 'Saláta', 1, '2026-02-03 12:10:07'),
(231, 33, 'Tabbouleh Saláta', 'Finomra vágott petrezselyem, bulgur, paradicsom, uborka és friss menta.', 1700, 'https://example.com/images/tabbouleh.jpg', 'Saláta', 1, '2026-02-03 12:10:07'),
(232, 33, 'Baklava', 'Phyllo tésztában sült, dióval, mézzel és fahéjjal.', 1200, 'https://example.com/images/baklava.jpg', 'Desszert', 1, '2026-02-03 12:10:07'),
(233, 33, 'Loukoumades', 'Görög fánk, mézzel és fahéjjal megöntözve, apró adagokban tálalva.', 1300, 'https://example.com/images/loukoumades.jpg', 'Desszert', 1, '2026-02-03 12:10:07'),
(234, 33, 'Galaktoboureko', 'Krémes tejpuding phyllo tésztában, sziruppal leöntve.', 1500, 'https://example.com/images/galaktoboureko.jpg', 'Desszert', 1, '2026-02-03 12:10:07'),
(235, 33, 'Kataifi', 'Édes, csavart tészták, belül dióval, kívül cukros sziruppal.', 1400, 'https://example.com/images/kataifi.jpg', 'Desszert', 1, '2026-02-03 12:10:07'),
(236, 33, 'Rizogalo', 'Görög rizs puding, fahéjjal és citromhéjjal ízesítve.', 1000, 'https://example.com/images/rizogalo.jpg', 'Desszert', 1, '2026-02-03 12:10:07'),
(237, 33, 'Ouzo', 'Klasszikus görög anízos ital, jéggel vagy vízzel.', 1500, 'https://example.com/images/ouzo.jpg', 'Italok', 1, '2026-02-03 12:17:06'),
(238, 33, 'Retsina', 'Hagyományos görög bor, fenyőgyanta ízesítéssel.', 2000, 'https://example.com/images/retsina.jpg', 'Italok', 1, '2026-02-03 12:17:06'),
(239, 33, 'Metaxa', 'Görög brandy, aromás fűszerekkel és mézzel.', 2500, 'https://example.com/images/metaxa.jpg', 'Italok', 1, '2026-02-03 12:17:06'),
(240, 33, 'Frappe', 'Jégkockával készített, habosított, erős görög kávé.', 1000, 'https://example.com/images/frappe.jpg', 'Italok', 1, '2026-02-03 12:17:06'),
(241, 33, 'Ásványvíz', 'Szénsavas vagy szénsavmentes ásványvíz.', 1500, 'https://example.com/images/ouzo.jpg', 'Italok', 1, '2026-02-03 12:17:06'),
(242, 33, 'Pepsi', 'Hideg Pepsi', 1500, 'https://example.com/images/ouzo.jpg', 'Italok', 1, '2026-02-03 12:17:06'),
(243, 33, 'Sprite', 'Hideg Sprite', 1500, 'https://example.com/images/ouzo.jpg', 'Italok', 1, '2026-02-03 12:17:06'),
(244, 33, 'Görög Sör (Alfa)', 'Friss, aromás görög sör, tökéletes választás étkezés mellé.', 1200, 'https://example.com/images/alfa.jpg', 'Italok', 1, '2026-02-03 12:17:06');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `quickbite_reviews`
--

DROP TABLE IF EXISTS `quickbite_reviews`;
CREATE TABLE IF NOT EXISTS `quickbite_reviews` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `name` varchar(100) NOT NULL,
  `text` text NOT NULL,
  `stars` tinyint(4) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

--
-- A tábla adatainak kiíratása `quickbite_reviews`
--

INSERT INTO `quickbite_reviews` (`id`, `username`, `name`, `text`, `stars`, `created_at`) VALUES
(1, 'nagy.zoltan', 'Nagy Zoltán', 'Nagyon gyors kiszállítás és finom ételek! Biztosan rendelek még.', 5, '2025-12-10 10:15:00'),
(2, 'reka.kovacs', 'Kovács Réka', 'A kedvenc éttermem itt találtam meg, minden mindig friss.', 4, '2025-12-09 18:30:00'),
(3, 'levente.toth', 'Tóth Levente', 'Kicsit hosszú volt a kiszállítás, de az étel kárpótolt.', 3, '2025-12-08 12:45:00'),
(4, 'anna.kis', 'Kis Anna', 'Imádom a vegetáriánus menüket, mindig frissek az alapanyagok.', 5, '2025-12-07 14:20:00'),
(5, 'peter.nagy', 'Nagy Péter', 'A rendelés folyamata egyszerű és gyors. Nagyon elégedett vagyok.', 4, '2025-12-06 11:10:00'),
(6, 'zsuzsa.farkas', 'Farkas Zsuzsa', 'Az étel finom volt, de a csomagolás lehetne környezetbarátabb.', 4, '2025-12-05 16:05:00'),
(7, 'martin.takacs', 'Takács Márton', 'Nagyon jó ár-érték arány, gyors kiszállítás. Csak ajánlani tudom!', 5, '2025-12-04 13:55:00'),
(8, 'emese.nemeth', 'Németh Emese', 'Sajnos a leves hideg volt, de a főétel kiváló volt.', 3, '2025-12-03 17:40:00'),
(9, 'daniel.sipos', 'Sipos Dániel', 'Mindig friss és ízletes. A kiszállítás is pontos.', 5, '2025-12-02 12:25:00'),
(10, 'zsombi.karoly', 'Károly Zsombor', 'Jó választék és könnyen használható weboldal. Csak így tovább!', 4, '2025-12-01 15:30:00'),
(11, 'novaklaci', 'Novák Laci', 'Ez a hely ien volt 3 csilagos', 5, '2025-12-11 08:45:18'),
(12, 'korizoltan1965', 'Kori Zoltán', 'Áttekinthető, könnyen kezelhető webshop, gyors rendelési folyamattal. A kínálat jól strukturált, az ételek leírása érthető, a fizetés pedig zökkenőmentes. Összességében kényelmes és felhasználóbarát megoldás ételrendeléshez.', 5, '2026-01-26 10:57:27'),
(13, 'korizoltan1965', 'Kori Zoltán', 'A webshop modern megjelenésű és jól átlátható, a rendelés leadása gyors és egyszerű. Az ételek részletesen vannak bemutatva, a felület pedig gördülékenyen működik. Kellemes élmény az online rendelés.', 5, '2026-01-26 10:58:26'),
(25, 'korizoltan1965', 'Kori Zoltán', 'A webshop modern megjelenésű és jól átlátható, a rendelés leadása gyors és egyszerű. Az ételek részletesen vannak bemutatva, a felület pedig gördülékenyen működik. Kellemes élmény az online rendelés.', 5, '2026-01-26 10:59:01'),
(26, 'padmin', 'Patrik Admin', 'Nagyon szuper weboldal!', 5, '2026-01-26 13:46:58'),
(27, 'korizoltan1965', 'Kori Zoltán', 'Nagyon elégedett voltam mindennel!', 5, '2026-01-26 16:25:51'),
(28, 'madmin', 'Martin Papa', 'Ez az oldal maga a jövő! Tökéletes, precíz weboldal nagyon hasznos funkcióval!', 5, '2026-01-27 10:30:13'),
(29, 'madmin', 'Martin Papa', 'Kurva nagy oldal tiszta vagány', 5, '2026-02-03 10:58:02');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `restaurants`
--

DROP TABLE IF EXISTS `restaurants`;
CREATE TABLE IF NOT EXISTS `restaurants` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` text NOT NULL,
  `address` text NOT NULL,
  `city` text NOT NULL,
  `description` text NOT NULL,
  `description_long` text NOT NULL,
  `phonenumber` text NOT NULL,
  `image_url` text NOT NULL,
  `discount` int(11) NOT NULL,
  `free_delivery` tinyint(1) NOT NULL,
  `accept_cards` tinyint(1) NOT NULL,
  `cuisine_id` int(11) NOT NULL,
  `latitude` decimal(10,0) NOT NULL,
  `longitude` decimal(10,0) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `idx_restaurants_cuisine_id` (`cuisine_id`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

--
-- A tábla adatainak kiíratása `restaurants`
--

INSERT INTO `restaurants` (`id`, `name`, `address`, `city`, `description`, `description_long`, `phonenumber`, `image_url`, `discount`, `free_delivery`, `accept_cards`, `cuisine_id`, `latitude`, `longitude`, `created_at`) VALUES
(1, 'Anyukám Mondta', 'Petőfi Sándor út 57.', 'Encs', 'Kedvelt olasz étterem Miskolc közelében.', 'Autentikus olasz tészták, pizzák és desszertek, családias hangulatban.', '+36301284567', '/img/etteremkepek/anyukam-mondta.jpg', 20, 0, 1, 1, 48, 21, '2025-12-04 07:51:21'),
(2, 'Végállomás Bistorant', 'Dorottya u. 1.', 'Miskolc', 'Modern magyar konyha, helyi alapanyagokkal.', 'Fine dining élmény, újragondolt magyar fogásokkal és kiváló borlappal.', '+36209837451', '/img/etteremkepek/vegallomas.jpg', 10, 1, 1, 2, 48, 21, '2025-12-04 07:51:21'),
(3, 'Zip\'s Brewhouse', 'Arany János tér 1.', 'Miskolc', 'Kézműves sörök és gasztro pub.', 'Saját főzésű sörök, pub klasszikusok és street food modern tálalásban.', '+36704561298', '/img/etteremkepek/zip.jpg', 0, 1, 1, 3, 48, 21, '2025-12-04 07:51:21'),
(4, 'Calypso Kisvendéglő', 'Görgey Artúr u. 23.', 'Miskolc', 'Hagyományos magyar ételek barátságos környezetben.', 'Családias vendéglő, házias ízek, nagy adagok, kedvező árak.', '+36307849126', '/img/etteremkepek/calypso.jpg', 0, 1, 1, 2, 48, 21, '2025-12-04 07:51:21'),
(17, 'Pesti Disznó', 'Kossuth Lajos utca 12.', 'Budapest', 'Hagyományos magyar bisztró modern köntösben', 'A Pesti Disznó a magyar konyha újragondolt változata: mangalica, libamáj, kacsacomb, házi kolbászok és kézműves sörök. Hangulatos belvárosi hely tökéletes ebédre vagy vacsorára.', '+36201263984', '/img/etteremkepek/pesti-diszno.jpg', 15, 1, 1, 1, 47, 19, '2025-12-11 09:05:15'),
(18, 'Trófea Grill Étterem', 'Király utca 30-32.', 'Budapest', 'Korlátlan étel- és italfogyasztás', 'Magyarország egyik legnépszerűbb „all you can eat\" étterme prémium húsokkal, friss salátabárral, desszertekkel és korlátlan házi limonádéval, sörrel, borral.', '+36708945132', '/img/etteremkepek/trofea.jpg', 0, 0, 1, 2, 47, 19, '2025-12-11 09:05:15'),
(19, 'Sushi Sei', 'Andrássy út 85.', 'Budapest', 'Prémium japán étterem', 'Hagyományos és modern japán fogások, friss sashimi, nigiri készítés élőben a vendégek előtt. Az ország egyik legjobb értékelésű sushi helye.', '+36301492875', '/img/etteremkepek/sushu-sei.jpg', 10, 1, 1, 4, 48, 19, '2025-12-11 09:05:15'),
(20, 'Tacos Miguel', 'Kazinczy utca 7.', 'Budapest', 'Hangulatos mexikói bisztró a Gozsdu udvarban', 'Friss, eredeti mexikói alapanyagokból készült fogások: házilag darált kukoricalisztből készült tortilla, marha barbacoa, cochinita pibil, al pastor, ceviche és pico de gallo. Kiváló napi taco- és burrito-menü, házi készítésű horchata, jamaica, margarita és több mint 30-féle tequila és mezcal. Reggel chilaquiles-szel indul, este pedig late-night tacóval zár – egész nap tökéletes választás.', '+36207851649', '/img/etteremkepek/tacos.jpg', 5, 0, 1, 5, 47, 19, '2025-12-11 09:05:15'),
(21, 'Tűzhely Kávézó & Bisztro', 'Városház tér 3.', 'Miskolc', 'Reggeli-brunch specialitások, házi lepények, könnyű ebéd fogások délután.', 'A Tűzhely Kávézó & Bisztro nem csupán egy hely, ahol reggelit vagy ebédet fogyasztasz – igazi kis oázis a város szívében, ahol a nap bármely szakában otthonosan érzed magad, mintha csak egy jó barát konyhájába léptél volna be.', '+36709876543', '/img/etteremkepek/tuzhely-kavezo-bisztro.jpg', 25, 0, 0, 3, 120, 11, '2026-01-27 10:57:14'),
(30, 'Hajnali Wok & Bao', 'Liszt Ferenc utca 23.', 'Győr', 'Ázsiai fúziós étterem választékos bao, okonomiyaki, matcha ételekkel.', 'Éttermünk az ázsiai konyha legjavát hozza el egy modern, barátságos környezetben. Kínai, thai és japán ízek találkoznak friss alapanyagokból, gondosan elkészítve. Legyen szó gyors ebédről vagy nyugodt vacsoráról, nálunk az autentikus fűszerezés és a különleges fogások igazi kulináris élményt nyújtanak minden vendég számára.', '+36309876543', '/img/etteremkepek/hajnali-wok-bao.jpg', 10, 0, 1, 4, 47, 19, '2026-01-27 11:09:31'),
(31, 'Sabores Perdidos', 'Domb utca 73.', 'Debrecen', 'Autentikus mexikói ízek - taco, enchilada, guacamole, margarita.', 'Éttermünk a mexikói konyha tüzes és színes világába repít. Friss tortillák, szaftos húsok, pikáns szószok és autentikus fűszerek gondoskodnak az igazi latin hangulatról. Legyen szó baráti vacsoráról vagy családi ebédről, nálunk minden fogás tele van ízzel, szenvedéllyel és életörömmel.', '+36304567890', '/img/etteremkepek/sabores-perdidos.jpg', 12, 1, 1, 5, 47, 19, '2026-01-27 11:18:45'),
(32, 'La Strada Italiana', 'Széchenyi István út 38.', 'Miskolc', 'Klasszikus olasz konyha friss alapanyagokból – pizza, pasta, risotto, tiramisu.', 'A La Strada Italiana egy hangulatos olasz étterem Miskolc szívében, ahol a hagyományos olasz receptek állnak a középpontban. Fatüzelésű kemencében sült pizzák, házi készítésű tészták, krémes rizottók és eredeti olasz desszertek várják a vendégeket ebédtől késő estig.', '+36201234567', '/img/etteremkepek/la-strada-italiana.jpg', 10, 1, 1, 1, 48, 20, '2026-01-27 12:15:00'),
(33, 'Greek Freak', '123 Görög Utca', 'Budapest', 'Autentikus görög ízek közvetlenül a város szívében.', 'A Greek Freak a valódi görög ízeket hozza el, tradicionális ételekkel, mint a souvlaki és moussaka, egy hangulatos és vibráló környezetben.', '+36 1 234 5678', '/img/etteremkepek/greekfreak.jpg', 15, 1, 1, 6, 47, 19, '2026-02-03 11:39:14'),
(34, 'Mythos Greek Kitchen', 'Széchenyi István út 12.', 'Miskolc', 'Autentikus görög konyha modern köntösben.', 'A Mythos Greek Kitchen a klasszikus görög ízeket ötvözi modern street food elemekkel. Gyrosok, souvlakik, friss tengeri fogások és házi készítésű szószok várják vendégeinket Miskolc belvárosában.', '+3646123456', '/img/etteremkepek/mythos.jpg', 15, 1, 1, 6, 48, 21, '2026-02-03 11:39:38');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `reviews`
--

DROP TABLE IF EXISTS `reviews`;
CREATE TABLE IF NOT EXISTS `reviews` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `restaurant_id` int(11) NOT NULL,
  `rating` tinyint(4) NOT NULL,
  `comment` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `idx_reviews_user_id` (`user_id`),
  KEY `idx_reviews_restaurant_id` (`restaurant_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

--
-- A tábla adatainak kiíratása `reviews`
--

INSERT INTO `reviews` (`id`, `user_id`, `restaurant_id`, `rating`, `comment`, `created_at`) VALUES
(1, 1, 1, 5, 'Fantasztikus tészták és kedves személyzet.', '2025-12-04 06:51:21'),
(3, 3, 3, 5, 'Klassz sörök, remek hangulat.', '2025-12-04 06:51:21'),
(4, 1, 4, 4, 'Tipikus magyar fogások, nagy adagok.', '2025-12-04 06:51:21');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` text NOT NULL,
  `email` text NOT NULL,
  `password` text NOT NULL,
  `created_at` date NOT NULL DEFAULT curdate(),
  `updated_at` datetime DEFAULT NULL,
  `phone` varchar(30) DEFAULT NULL,
  `avatar_url` text DEFAULT NULL,
  `address_line` text DEFAULT NULL,
  `city` varchar(100) DEFAULT NULL,
  `zip_code` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`(255))
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

--
-- A tábla adatainak kiíratása `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `password`, `created_at`, `updated_at`, `phone`, `avatar_url`, `address_line`, `city`, `zip_code`) VALUES
(1, 'Kori Zoltán', 'korizoltan1965@gmail.com', '$2a$12$B8l0hyERs92Larf2AYaDwe28jq.vpzoBt4QlsGr8jC6P72T1zOoGm', '2026-01-26', NULL, NULL, NULL, NULL, NULL, NULL),
(3, 'Patrik', 'padmin@gmail.com', '$2a$12$rmexQsjZ84ZxCq05dLndHOJ6VTfeIaXznnRaQ5teZMokFj79lNYIW', '2026-01-26', '2026-02-03 08:35:18', NULL, 'https://wiki.trashforum.org/images/thumb/b/b2/2929.jpg/300px-2929.jpg', NULL, NULL, NULL),
(4, 'Martin Papa', 'madmin@gmail.com', '$2a$12$SsuWLRHghFfd4IIOEaiUAOGdoNCe/J2sHEhGGndCl7Fh9e9B0Yq1.', '2026-01-26', '2026-01-26 15:38:01', NULL, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRksQSQeMKU32MNydXZtXPew-vGqk53_WDlVw&s', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `user_addresses`
--

DROP TABLE IF EXISTS `user_addresses`;
CREATE TABLE IF NOT EXISTS `user_addresses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `label` varchar(50) NOT NULL,
  `address_line` text NOT NULL,
  `city` varchar(100) NOT NULL,
  `zip_code` varchar(10) NOT NULL,
  `is_default` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `idx_user_addresses_user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `user_addresses`
--

INSERT INTO `user_addresses` (`id`, `user_id`, `label`, `address_line`, `city`, `zip_code`, `is_default`) VALUES
(3, 4, 'Munkahely', 'Mars tér 13, Csillagbörtön', 'Szeged', '6724', 1);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `user_payment_methods`
--

DROP TABLE IF EXISTS `user_payment_methods`;
CREATE TABLE IF NOT EXISTS `user_payment_methods` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `type` varchar(20) NOT NULL,
  `display_name` varchar(100) NOT NULL,
  `last_four_digits` varchar(4) DEFAULT NULL,
  `is_default` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `idx_user_payment_methods_user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `user_payment_methods`
--

INSERT INTO `user_payment_methods` (`id`, `user_id`, `type`, `display_name`, `last_four_digits`, `is_default`) VALUES
(2, 4, 'cash', 'KÁPÉ', NULL, 1);

--
-- Megkötések a kiírt táblákhoz
--

--
-- Megkötések a táblához `coupons`
--
ALTER TABLE `coupons`
  ADD CONSTRAINT `coupons_ibfk_1` FOREIGN KEY (`restaurant_id`) REFERENCES `restaurants` (`id`);

--
-- Megkötések a táblához `coupon_usages`
--
ALTER TABLE `coupon_usages`
  ADD CONSTRAINT `coupon_usages_ibfk_1` FOREIGN KEY (`coupon_id`) REFERENCES `coupons` (`id`),
  ADD CONSTRAINT `coupon_usages_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Megkötések a táblához `menu_items`
--
ALTER TABLE `menu_items`
  ADD CONSTRAINT `fk_menu_items_restaurants` FOREIGN KEY (`restaurant_id`) REFERENCES `restaurants` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Megkötések a táblához `restaurants`
--
ALTER TABLE `restaurants`
  ADD CONSTRAINT `fk_restaurants_categories_cuisine` FOREIGN KEY (`cuisine_id`) REFERENCES `categories` (`id`) ON UPDATE CASCADE;

--
-- Megkötések a táblához `reviews`
--
ALTER TABLE `reviews`
  ADD CONSTRAINT `fk_reviews_restaurants` FOREIGN KEY (`restaurant_id`) REFERENCES `restaurants` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_reviews_users` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Megkötések a táblához `user_addresses`
--
ALTER TABLE `user_addresses`
  ADD CONSTRAINT `fk_user_addresses_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Megkötések a táblához `user_payment_methods`
--
ALTER TABLE `user_payment_methods`
  ADD CONSTRAINT `fk_user_payment_methods_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
