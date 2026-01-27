-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Gép: 127.0.0.1
-- Létrehozás ideje: 2026. Jan 27. 12:41
-- Kiszolgáló verziója: 10.4.32-MariaDB
-- PHP verzió: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";
SET FOREIGN_KEY_CHECKS=0;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

--
-- A tábla adatainak kiíratása `categories`
--

INSERT INTO `categories` (`id`, `name`, `icon`) VALUES
(1, 'Olasz', '🍝'),
(2, 'Magyar', '🫕'),
(3, 'Pub', '🍺'),
(4, 'Ázsiai', '🍜'),
(5, 'Mexikói', '🌮');

-- --------------------------------------------------------

-- Tábla szerkezet ehhez a táblához `restaurants`

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
  KEY `idx_restaurants_cuisine_id` (`cuisine_id`),
  CONSTRAINT `fk_restaurants_cuisine` FOREIGN KEY (`cuisine_id`) REFERENCES `categories` (`id`) ON DELETE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

--
-- A tábla adatainak kiíratása `restaurants`
--

INSERT INTO `restaurants` (`id`, `name`, `address`, `city`, `description`, `description_long`, `phonenumber`, `image_url`, `discount`, `free_delivery`, `accept_cards`, `cuisine_id`, `latitude`, `longitude`, `created_at`) VALUES
(1, 'Anyukám Mondta', 'Petőfi Sándor út 57.', 'Encs', 'Kedvelt olasz étterem Miskolc közelében.', 'Autentikus olasz tészták, pizzák és desszertek, családias hangulatban.', '+36301284567', '/img/etteremkepek/anyukam-mondta.jpg', 20, 0, 1, 1, 48, 21, '2025-12-04 07:51:21'),
(2, 'Végállomás Bistorant', 'Dorottya u. 1.', 'Miskolc', 'Modern magyar konyha, helyi alapanyagokkal.', 'Fine dining élmény, újragondolt magyar fogásokkal és kiváló borlappal.', '+36209837451', '/img/etteremkepek/vegallomas.jpg', 10, 1, 1, 2, 48, 21, '2025-12-04 07:51:21'),
(3, 'Zip''s Brewhouse', 'Arany János tér 1.', 'Miskolc', 'Kézműves sörök és gasztro pub.', 'Saját főzésű sörök, pub klasszikusok és street food modern tálalásban.', '+36704561298', '/img/etteremkepek/zip.jpg', 0, 1, 1, 3, 48, 21, '2025-12-04 07:51:21'),
(4, 'Calypso Kisvendéglő', 'Görgey Artúr u. 23.', 'Miskolc', 'Hagyományos magyar ételek barátságos környezetben.', 'Családias vendéglő, házias ízek, nagy adagok, kedvező árak.', '+36307849126', '/img/etteremkepek/calypso.jpg', 0, 1, 1, 2, 48, 21, '2025-12-04 07:51:21'),
(17, 'Pesti Disznó', 'Kossuth Lajos utca 12.', 'Budapest', 'Hagyományos magyar bisztró modern köntösben', 'A Pesti Disznó a magyar konyha újragondolt változata: mangalica, libamáj, kacsacomb, házi kolbászok és kézműves sörök. Hangulatos belvárosi hely tökéletes ebédre vagy vacsorára.', '+36201263984', '/img/etteremkepek/pesti-diszno.jpg', 15, 1, 1, 1, 47, 19, '2025-12-11 09:05:15'),
(18, 'Trófea Grill Étterem', 'Király utca 30-32.', 'Budapest', 'Korlátlan étel- és italfogyasztás', 'Magyarország egyik legnépszerűbb „all you can eat" étterme prémium húsokkal, friss salátabárral, desszertekkel és korlátlan házi limonádéval, sörrel, borral.', '+36708945132', '/img/etteremkepek/trofea.jpg', 0, 0, 1, 2, 47, 19, '2025-12-11 09:05:15'),
(19, 'Sushi Sei', 'Andrássy út 85.', 'Budapest', 'Prémium japán étterem', 'Hagyományos és modern japán fogások, friss sashimi, nigiri készítés élőben a vendégek előtt. Az ország egyik legjobb értékelésű sushi helye.', '+36301492875', '/img/etteremkepek/sushu-sei.jpg', 10, 1, 1, 4, 48, 19, '2025-12-11 09:05:15'),
(20, 'Tacos Miguel', 'Kazinczy utca 7.', 'Budapest', 'Hangulatos mexikói bisztró a Gozsdu udvarban', 'Friss, eredeti mexikói alapanyagokból készült fogások: házilag darált kukoricalisztből készült tortilla, marha barbacoa, cochinita pibil, al pastor, ceviche és pico de gallo. Kiváló napi taco- és burrito-menü, házi készítésű horchata, jamaica, margarita és több mint 30-féle tequila és mezcal. Reggel chilaquiles-szel indul, este pedig late-night tacóval zár – egész nap tökéletes választás.', '+36207851649', '/img/etteremkepek/tacos.jpg', 5, 0, 1, 5, 47, 19, '2025-12-11 09:05:15'),
(21, 'Tűzhely Kávézó & Bisztro', 'Városház tér 3.', 'Miskolc', 'Reggeli-brunch specialitások, házi lepények, könnyű ebéd fogások délután.', 'A Tűzhely Kávézó & Bisztro nem csupán egy hely, ahol reggelit vagy ebédet fogyasztasz – igazi kis oázis a város szívében, ahol a nap bármely szakában otthonosan érzed magad, mintha csak egy jó barát konyhájába léptél volna be.', '+36709876543', '/img/etteremkepek/tuzhely-kavezo-bisztro.jpg', 25, 0, 0, 3, 120, 11, '2026-01-27 10:57:14'),
(30, 'Hajnali Wok & Bao', 'Liszt Ferenc utca 23.', 'Győr', 'Ázsiai fúziós étterem választékos bao, okonomiyaki, matcha ételekkel.', 'Hajnali Wok & Bao egy modern, ázsiai ihletésű bisztró a belvárosban, ahol a reggeli és brunch találkozik a keleti ízekkel – friss, könnyed, de nagyon ízletes formában. Itt a "lepény" ázsiai stílusban érkezik: puha, gőzölt bao bun különféle töltelékekkel (lassú sült kacsahús hoisin mártással, grillezett sertés has bacon-szerűen ropogósra sütve, tofu shiitake gombával vegán verzióban), vagy japán stílusú okonomiyaki (káposztás, tenger gyümölcseivel vagy baconnal, házi okonomiyaki szósszal és bonito pehellyel).', '+36309876543', '/img/etteremkepek/hajnali-wok-bao.jpg', 10, 0, 1, 4, 47, 19, '2026-01-27 11:09:31'),
(31, 'Sabores Perdidos', 'Domb utca 73.', 'Debrecen', 'Autentikus mexikói ízek - taco, enchilada, guacamole, margarita.', 'A Sabores Perdidos egy igazi mexikói hangulatú hely, ahol a fókusz a klasszikus, fűszeres fogásokon van, csakis ízig-vérig mexikói konyha délben és este is.', '+36304567890', '/img/etteremkepek/sabores-perdidos.jpg', 12, 1, 1, 5, 47, 19, '2026-01-27 11:18:45');


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
  KEY `idx_menu_items_restaurant_id` (`restaurant_id`),
  CONSTRAINT `fk_menu_items_restaurant` FOREIGN KEY (`restaurant_id`) REFERENCES `restaurants` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=69 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;



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
(68, 20, 'Margarita', 'Klasszikus margarita koktél.', 1890, '/img/EtelKepek/margarita.jpg', 'Ital', 1, '2026-01-23 21:23:21');

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
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

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
(28, 'madmin', 'Martin Papa', 'Ez az oldal maga a jövő! Tökéletes, precíz weboldal nagyon hasznos funkcióval!', 5, '2026-01-27 10:30:13');

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
  `created_at` date NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  `phone` varchar(30) DEFAULT NULL,
  `avatar_url` text DEFAULT NULL,
  `address_line` text DEFAULT NULL,
  `city` varchar(100) DEFAULT NULL,
  `zip_code` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`(255))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `password`, `created_at`, `updated_at`, `phone`, `avatar_url`, `address_line`, `city`, `zip_code`) VALUES
(4, 'Demo User', 'demo@example.com', '$2y$10$demo-placeholder-hash', '2025-12-01', NULL, NULL, NULL, NULL, NULL, NULL);

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
  KEY `fk_reviews_user` (`user_id`),
  KEY `fk_reviews_restaurant` (`restaurant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
  `is_default` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_user_addresses_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
  `is_default` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_user_payment_methods_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `user_payment_methods`
--

INSERT INTO `user_payment_methods` (`id`, `user_id`, `type`, `display_name`, `last_four_digits`, `is_default`) VALUES
(2, 4, 'cash', 'KÁPÉ', NULL, 1);

--
-- Megkötések a kiírt táblákhoz
--

ALTER TABLE `reviews`
  ADD CONSTRAINT `fk_reviews_restaurant` FOREIGN KEY (`restaurant_id`) REFERENCES `restaurants` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_reviews_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

ALTER TABLE `user_addresses`
  ADD CONSTRAINT `fk_user_addresses_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

ALTER TABLE `user_payment_methods`
  ADD CONSTRAINT `fk_user_payment_methods_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;
SET FOREIGN_KEY_CHECKS=1;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
