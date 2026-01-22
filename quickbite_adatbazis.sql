-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Gép: 127.0.0.1
-- Létrehozás ideje: 2025. Dec 11. 10:02
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

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `categories`
--

CREATE TABLE `categories` (
  `id` int(11) NOT NULL,
  `name` text NOT NULL,
  `icon` text NOT NULL
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

--
-- Tábla szerkezet ehhez a táblához `quickbite_reviews`
--

CREATE TABLE `quickbite_reviews` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `name` varchar(100) NOT NULL,
  `text` text NOT NULL,
  `stars` tinyint(4) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

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
(11, 'novaklaci', 'Novák Laci', 'Ez a hely ien volt 3 csilagos', 5, '2025-12-11 08:45:18');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `restaurants`
--

CREATE TABLE `restaurants` (
  `id` int(11) NOT NULL,
  `name` text NOT NULL,
  `address` text NOT NULL,
  `city` text NOT NULL,
  `description` text NOT NULL,
  `description_long` text NOT NULL,
  `image_url` text NOT NULL,
  `discount` int(11) NOT NULL,
  `free_delivery` tinyint(1) NOT NULL,
  `accept_cards` tinyint(1) NOT NULL,
  `cuisine_id` int(11) NOT NULL,
  `latitude` decimal(10,0) NOT NULL,
  `longitude` decimal(10,0) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

--
-- A tábla adatainak kiíratása `restaurants`
--

INSERT INTO `restaurants` (`id`, `name`, `address`, `city`, `description`, `description_long`, `image_url`, `discount`, `free_delivery`, `accept_cards`, `cuisine_id`, `latitude`, `longitude`, `created_at`) VALUES
(1, 'Anyukám Mondta', 'Petőfi Sándor út 57.', 'Encs', 'Kedvelt olasz étterem Miskolc közelében.', 'Autentikus olasz tészták, pizzák és desszertek, családias hangulatban.', '/img/etteremkepek/anyukam.jpg', 20, 0, 1, 1, 48, 21, '2025-12-04 07:51:21'),
(2, 'Végállomás Bistorant', 'Dorottya u. 1.', 'Miskolc', 'Modern magyar konyha, helyi alapanyagokkal.', 'Fine dining élmény, újragondolt magyar fogásokkal és kiváló borlappal.', '/img/etteremkepek/vegallomas.jpg', 10, 1, 1, 2, 48, 21, '2025-12-04 07:51:21'),
(3, 'Zip\'s Brewhouse', 'Arany János tér 1.', 'Miskolc', 'Kézműves sörök és gasztro pub.', 'Saját főzésű sörök, pub klasszikusok és street food modern tálalásban.', '/img/etteremkepek/zip.jpg', 0, 1, 1, 3, 48, 21, '2025-12-04 07:51:21'),
(4, 'Calypso Kisvendéglő', 'Görgey Artúr u. 23.', 'Miskolc', 'Hagyományos magyar ételek barátságos környezetben.', 'Családias vendéglő, házias ízek, nagy adagok, kedvező árak.', '/img/etteremkepek/calypso.jpg', 0, 1, 1, 2, 48, 21, '2025-12-04 07:51:21'),
(17, 'Pesti Disznó', 'Kossuth Lajos utca 12.', 'Budapest', 'Hagyományos magyar bisztró modern köntösben', 'A Pesti Disznó a magyar konyha újragondolt változata: mangalica, libamáj, kacsacomb, házi kolbászok és kézműves sörök. Hangulatos belvárosi hely tökéletes ebédre vagy vacsorára.', '/img/etteremkepek/pesti-diszno.jpg', 15, 1, 1, 1, 47, 19, '2025-12-11 09:05:15'),
(18, 'Trófea Grill Étterem', 'Király utca 30-32.', 'Budapest', 'Korlátlan étel- és italfogyasztás', 'Magyarország egyik legnépszerűbb „all you can eat" étterme prémium húsokkal, friss salátabárral, desszertekkel és korlátlan házi limonádéval, sörrel, borral.', '/img/etteremkepek/trofea.jpg', 0, 0, 1, 2, 47, 19, '2025-12-11 09:05:15'),
(19, 'Sushi Sei', 'Andrássy út 85.', 'Budapest', 'Prémium japán étterem', 'Hagyományos és modern japán fogások, friss sashimi, nigiri készítés élőben a vendégek előtt. Az ország egyik legjobb értékelésű sushi helye.', '/img/etteremkepek/sushu-sei.jpg', 10, 1, 1, 4, 48, 19, '2025-12-11 09:05:15'),
(20, 'Tacos Miguel', 'Kazinczy utca 7.', 'Budapest', 'Hangulatos mexikói bisztró a Gozsdu udvarban', 'Friss, eredeti mexikói alapanyagokból készült fogások: házilag darált kukoricalisztből készült tortilla, marha barbacoa, cochinita pibil, al pastor, ceviche és pico de gallo. Kiváló napi taco- és burrito-menü, házi készítésű horchata, jamaica, margarita és több mint 30-féle tequila és mezcal. Reggel chilaquiles-szel indul, este pedig late-night tacóval zár – egész nap tökéletes választás.', '/img/etteremkepek/tacos.jpg', 5, 0, 1, 5, 47, 19, '2025-12-11 09:05:15');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `menu_items`
--

CREATE TABLE `menu_items` (
  `id` int(11) NOT NULL,
  `restaurant_id` int(11) NOT NULL,
  `name` text NOT NULL,
  `description` text DEFAULT NULL,
  `price` int(11) NOT NULL,
  `image_url` text DEFAULT NULL,
  `category` text DEFAULT NULL,
  `is_available` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

--
-- A tábla adatainak kiíratása `menu_items`
--

INSERT INTO `menu_items` (`id`, `restaurant_id`, `name`, `description`, `price`, `image_url`, `category`, `is_available`) VALUES
(1, 1, 'Margherita pizza', 'Paradicsomos, mozzarellás klasszikus.', 2490, '/img/EtelKepek/MargaretaPizza.png', 'Pizza', 1),
(2, 1, 'Carbonara spagetti', 'Krémes, szalonnás tészta.', 2890, '/img/EtelKepek/CarbonaraSpagetti.png', 'Tészta', 1),
(3, 1, 'Tiramisu', 'Olasz desszert, kávéval és mascarponéval.', 1690, '/img/EtelKepek/Tiramisu.png', 'Desszert', 1),
(4, 1, 'Quattro Stagioni pizza', 'Négy évszak íze: sonka, gomba, articsóka, olajbogyó.', 3290, '/img/EtelKepek/default.png', 'Pizza', 1),
(5, 1, 'Lasagne', 'Hagyományos olasz tésztaétel, hússal és besamel mártással.', 3190, '/img/EtelKepek/default.png', 'Tészta', 1),
(6, 1, 'Penne Arrabbiata', 'Csípős paradicsomos szósz, fokhagymával és petrezselyemmel.', 2690, '/img/EtelKepek/default.png', 'Tészta', 1),
(7, 1, 'Bolognai spagetti', 'Marhahúsos paradicsomos szósz, parmezánnal.', 2790, '/img/EtelKepek/default.png', 'Tészta', 1),
(8, 1, 'Prosciutto e Funghi pizza', 'Sonka és gomba, mozzarellával.', 2990, '/img/EtelKepek/default.png', 'Pizza', 1),
(9, 1, 'Panna Cotta', 'Krémes olasz desszert, bogyós gyümölcsökkel.', 1490, '/img/EtelKepek/default.png', 'Desszert', 1),
(10, 1, 'Cannoli', 'Ropogós tészta, édes töltelékkel.', 1290, '/img/EtelKepek/default.png', 'Desszert', 1),
(11, 2, 'Rántott hús', 'Ropogós panír, friss köret.', 2990, '/img/EtelKepek/Rantotthus.png', 'Főétel', 1),
(12, 2, 'Gulyásleves', 'Hagyományos magyar leves.', 1990, '/img/EtelKepek/Gulyasleves.png', 'Leves', 1),
(13, 2, 'Somlói galuska', 'Kedvelt magyar desszert.', 1490, '/img/EtelKepek/SomloiGaluska.png', 'Desszert', 1),
(14, 2, 'Libamáj', 'Sült libamáj, hagymás körettel.', 3890, '/img/EtelKepek/default.png', 'Főétel', 1),
(15, 2, 'Töltött káposzta', 'Hagyományos magyar fogás, tejföllel.', 2490, '/img/EtelKepek/default.png', 'Főétel', 1),
(16, 2, 'Halászlé', 'Fűszeres halászlé, friss halból.', 3290, '/img/EtelKepek/default.png', 'Leves', 1),
(17, 2, 'Pörkölt', 'Marha vagy sertés pörkölt, galuskával.', 2790, '/img/EtelKepek/default.png', 'Főétel', 1),
(18, 2, 'Rakott krumpli', 'Házias rakott krumpli, kolbásszal.', 2190, '/img/EtelKepek/default.png', 'Főétel', 1),
(19, 2, 'Túrós csusza', 'Friss túróval és szalonnával.', 1990, '/img/EtelKepek/default.png', 'Főétel', 1),
(20, 2, 'Dobos torta', 'Klasszikus magyar torta.', 1290, '/img/EtelKepek/default.png', 'Desszert', 1),
(21, 2, 'Rétes', 'Almás vagy túrós rétes.', 990, '/img/EtelKepek/default.png', 'Desszert', 1),
(22, 3, 'BBQ burger', 'Füstös BBQ szósz, szaftos hús.', 3190, '/img/EtelKepek/BbqBurger.png', 'Burger', 1),
(23, 3, 'Sült krumpli', 'Ropogós, aranybarna.', 990, '/img/EtelKepek/Sultkrumpli.png', 'Köret', 1),
(24, 3, 'Kézműves sör', 'Helyben főzött sör.', 1290, '/img/EtelKepek/KezmuvesSor.png', 'Ital', 1),
(25, 3, 'Classic burger', 'Marhahús, saláta, paradicsom, hagyma, sajt.', 2790, '/img/EtelKepek/default.png', 'Burger', 1),
(26, 3, 'Chili burger', 'Csípős chili szósz, jalapeño, cheddar sajt.', 3290, '/img/EtelKepek/default.png', 'Burger', 1),
(27, 3, 'Vegán burger', 'Növényi alapú húspótló, friss zöldségekkel.', 2590, '/img/EtelKepek/default.png', 'Burger', 1),
(28, 3, 'Csirkeszárny', 'Fűszeres sült csirkeszárny, BBQ mártással.', 2490, '/img/EtelKepek/default.png', 'Főétel', 1),
(29, 3, 'Nachos', 'Ropogós tortilla chips, sajttal és jalapeñóval.', 1890, '/img/EtelKepek/default.png', 'Előétel', 1),
(30, 3, 'Sült hagyma karikák', 'Ropogós panírozott hagyma, mártással.', 1490, '/img/EtelKepek/default.png', 'Előétel', 1),
(31, 3, 'IPA sör', 'Keserű, aromás IPA sör.', 1390, '/img/EtelKepek/default.png', 'Ital', 1),
(32, 3, 'Stout sör', 'Sötét, krémes stout sör.', 1390, '/img/EtelKepek/default.png', 'Ital', 1),
(33, 4, 'Húsleves', 'Házi, gazdag húsleves.', 1790, '/img/EtelKepek/Husleves.png', 'Leves', 1),
(34, 4, 'Palacsinta', 'Töltött, édes palacsinta.', 990, '/img/EtelKepek/Palacsinta.png', 'Desszert', 1),
(35, 4, 'Bableves', 'Hagyományos bableves, füstölt hússal.', 1890, '/img/EtelKepek/default.png', 'Leves', 1),
(36, 4, 'Sertésszelet', 'Sült sertésszelet, sült burgonyával.', 2690, '/img/EtelKepek/default.png', 'Főétel', 1),
(37, 4, 'Lecsó', 'Friss zöldségekből készült lecsó, tojással.', 1990, '/img/EtelKepek/default.png', 'Főétel', 1),
(38, 4, 'Rántott sajt', 'Ropogós rántott sajt, tartármártással.', 2190, '/img/EtelKepek/default.png', 'Főétel', 1),
(39, 4, 'Káposztás tészta', 'Friss káposztával készült tészta.', 1790, '/img/EtelKepek/default.png', 'Főétel', 1),
(40, 4, 'Gesztenyepüré', 'Édes gesztenyepüré, tejszínhabbal.', 1190, '/img/EtelKepek/default.png', 'Desszert', 1),
(41, 17, 'Mangalica pörkölt', 'Prémium mangalica hús, galuskával.', 4290, '/img/EtelKepek/default.png', 'Főétel', 1),
(42, 17, 'Libamáj', 'Sült libamáj, hagymás körettel.', 3890, '/img/EtelKepek/default.png', 'Főétel', 1),
(43, 17, 'Kacsacomb', 'Sült kacsacomb, vörös káposztával.', 4490, '/img/EtelKepek/default.png', 'Főétel', 1),
(44, 17, 'Házi kolbász', 'Füstölt házi kolbász, mustárral.', 2790, '/img/EtelKepek/default.png', 'Főétel', 1),
(45, 17, 'Borleves', 'Hagyományos borleves, fahéjjal.', 1890, '/img/EtelKepek/default.png', 'Leves', 1),
(46, 17, 'Kézműves sör', 'Helyi kézműves sör.', 1490, '/img/EtelKepek/default.png', 'Ital', 1),
(47, 18, 'Grillezett marhahús', 'Prémium marhahús, friss zöldségekkel.', 4990, '/img/EtelKepek/default.png', 'Főétel', 1),
(48, 18, 'Grillezett csirkemell', 'Fűszeres grillezett csirkemell.', 3290, '/img/EtelKepek/default.png', 'Főétel', 1),
(49, 18, 'Friss salátabár', 'Választékos salátabár, többféle öntettel.', 2490, '/img/EtelKepek/default.png', 'Előétel', 1),
(50, 18, 'Sushi tál', 'Választékos sushi keverék.', 3890, '/img/EtelKepek/default.png', 'Főétel', 1),
(51, 18, 'Desszert bár', 'Különféle desszertek választéka.', 1990, '/img/EtelKepek/default.png', 'Desszert', 1),
(52, 18, 'Korlátlan házi limonádé', 'Friss házi limonádé.', 990, '/img/EtelKepek/default.png', 'Ital', 1),
(53, 19, 'Sashimi mix', 'Friss sashimi választék: tonhal, lazac, tengeri sügér.', 4590, '/img/EtelKepek/default.png', 'Főétel', 1),
(54, 19, 'Nigiri mix', 'Különféle nigiri: tonhal, lazac, rák, tintahal.', 4290, '/img/EtelKepek/default.png', 'Főétel', 1),
(55, 19, 'California roll', 'Rák, avokádó, uborka, kaviár.', 2890, '/img/EtelKepek/default.png', 'Főétel', 1),
(56, 19, 'Philadelphia roll', 'Lazac, sajt, avokádó.', 3190, '/img/EtelKepek/default.png', 'Főétel', 1),
(57, 19, 'Tempura rák', 'Ropogós tempura rák, szójamártással.', 3490, '/img/EtelKepek/default.png', 'Főétel', 1),
(58, 19, 'Miso leves', 'Hagyományos miso leves, tofuval.', 1490, '/img/EtelKepek/default.png', 'Leves', 1),
(59, 19, 'Edamame', 'Főtt szójabab, sóval.', 1190, '/img/EtelKepek/default.png', 'Előétel', 1),
(60, 19, 'Zöld tea', 'Autentikus japán zöld tea.', 890, '/img/EtelKepek/default.png', 'Ital', 1),
(61, 20, 'Taco mix', '3 db taco: marha, csirke, sertés.', 3290, '/img/EtelKepek/default.png', 'Főétel', 1),
(62, 20, 'Burrito', 'Nagy burrito, marhahússal, babbal, rizzsel.', 2790, '/img/EtelKepek/default.png', 'Főétel', 1),
(63, 20, 'Quesadilla', 'Sült tortilla, sajttal és csirkével.', 2490, '/img/EtelKepek/default.png', 'Főétel', 1),
(64, 20, 'Guacamole', 'Friss avokádó, lime-dzsel és fokhagymával.', 1490, '/img/EtelKepek/default.png', 'Előétel', 1),
(65, 20, 'Ceviche', 'Friss hal, lime-dzsel, hagymával és korianderrel.', 3290, '/img/EtelKepek/default.png', 'Előétel', 1),
(66, 20, 'Chilaquiles', 'Ropogós tortilla chips, tojással és szósszal.', 2190, '/img/EtelKepek/default.png', 'Főétel', 1),
(67, 20, 'Horchata', 'Házi készítésű horchata.', 1190, '/img/EtelKepek/default.png', 'Ital', 1),
(68, 20, 'Margarita', 'Klasszikus margarita koktél.', 1890, '/img/EtelKepek/default.png', 'Ital', 1);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `reviews`
--

CREATE TABLE `reviews` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `restaurant_id` int(11) NOT NULL,
  `rating` tinyint(4) NOT NULL,
  `comment` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

--
-- A tábla adatainak kiíratása `reviews`
--

INSERT INTO `reviews` (`id`, `user_id`, `restaurant_id`, `rating`, `comment`, `created_at`) VALUES
(1, 1, 1, 5, 'Fantasztikus tészták és kedves személyzet.', '2025-12-04 06:51:21'),
(2, 2, 2, 4, 'Nagyon finom ételek, kicsit drágább árak.', '2025-12-04 06:51:21'),
(3, 3, 3, 5, 'Klassz sörök, remek hangulat.', '2025-12-04 06:51:21'),
(4, 1, 4, 4, 'Tipikus magyar fogások, nagy adagok.', '2025-12-04 06:51:21');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `menu_items`
--

CREATE TABLE `menu_items` (
  `id` int(11) NOT NULL,
  `label` text NOT NULL,
  `path` text NOT NULL,
  `sort_order` int(11) NOT NULL DEFAULT 0,
  `icon` text DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

--
-- A tábla adatainak kiíratása `menu_items`
--

INSERT INTO `menu_items` (`id`, `label`, `path`, `sort_order`, `icon`, `is_active`) VALUES
(1, 'Vásárlók véleményei', '/velemenyek', 1, NULL, 1),
(2, 'Kapcsolat', '/kapcsolat', 2, NULL, 1),
(3, 'Rólunk', '/rolunk', 3, NULL, 1);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `name` text NOT NULL,
  `email` text NOT NULL,
  `password` text NOT NULL,
  `created_at` date NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

--
-- A tábla adatainak kiíratása `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `password`, `created_at`) VALUES
(1, 'Kiss Anna', 'anna@example.com', '$2a$10$dummyhash1', '2025-12-04'),
(2, 'Nagy Péter', 'peter@example.com', '$2a$10$dummyhash2', '2025-12-04'),
(3, 'Szabó Luca', 'luca@example.com', '$2a$10$dummyhash3', '2025-12-04');

--
-- Indexek a kiírt táblákhoz
--

--
-- A tábla indexei `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`);

--
-- A tábla indexei `quickbite_reviews`
--
ALTER TABLE `quickbite_reviews`
  ADD PRIMARY KEY (`id`);

--
-- A tábla indexei `restaurants`
--
ALTER TABLE `restaurants`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_restaurants_category` (`cuisine_id`);

--
-- A tábla indexei `menu_items`
--
ALTER TABLE `menu_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_menu_items_restaurant` (`restaurant_id`);

--
-- A tábla indexei `reviews`
--
ALTER TABLE `reviews`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_reviews_user` (`user_id`),
  ADD KEY `fk_reviews_restaurant` (`restaurant_id`);

--
-- A tábla indexei `menu_items`
--
ALTER TABLE `menu_items`
  ADD PRIMARY KEY (`id`);

--
-- A tábla indexei `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`) USING HASH;

--
-- A kiírt táblák AUTO_INCREMENT értéke
--

--
-- AUTO_INCREMENT a táblához `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT a táblához `quickbite_reviews`
--
ALTER TABLE `quickbite_reviews`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT a táblához `restaurants`
--
ALTER TABLE `restaurants`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT a táblához `menu_items`
--
ALTER TABLE `menu_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=69;

--
-- AUTO_INCREMENT a táblához `reviews`
--
ALTER TABLE `reviews`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT a táblához `menu_items`
--
ALTER TABLE `menu_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT a táblához `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Megkötések a kiírt táblákhoz
--

--
-- Megkötések a táblához `restaurants`
--
ALTER TABLE `restaurants`
  ADD CONSTRAINT `fk_restaurants_category` FOREIGN KEY (`cuisine_id`) REFERENCES `categories` (`id`) ON UPDATE CASCADE;

--
-- Megkötések a táblához `menu_items`
--
ALTER TABLE `menu_items`
  ADD CONSTRAINT `fk_menu_items_restaurant` FOREIGN KEY (`restaurant_id`) REFERENCES `restaurants` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Megkötések a táblához `reviews`
--
ALTER TABLE `reviews`
  ADD CONSTRAINT `fk_reviews_restaurant` FOREIGN KEY (`restaurant_id`) REFERENCES `restaurants` (`id`),
  ADD CONSTRAINT `fk_reviews_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
