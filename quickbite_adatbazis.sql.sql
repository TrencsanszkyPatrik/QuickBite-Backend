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
(18, 'Trófea Grill Étterem', 'Király utca 30-32.', 'Budapest', 'Korlátlan étel- és italfogyasztás', 'Magyarország egyik legnépszerűbb „all you can eat” étterme prémium húsokkal, friss salátabárral, desszertekkel és korlátlan házi limonádéval, sörrel, borral.', '/img/etteremkepek/trofea.jpg', 0, 0, 1, 2, 47, 19, '2025-12-11 09:05:15'),
(19, 'Sushi Sei', 'Andrássy út 85.', 'Budapest', 'Prémium japán étterem', 'Hagyományos és modern japán fogások, friss sashimi, nigiri készítés élőben a vendégek előtt. Az ország egyik legjobb értékelésű sushi helye.', '/img/etteremkepek/sushu-sei.jpg', 10, 1, 1, 4, 48, 19, '2025-12-11 09:05:15'),
(20, 'Tacos Miguel', 'Kazinczy utca 7.', 'Budapest', 'Hangulatos mexikói bisztró a Gozsdu udvarban', 'Friss, eredeti mexikói alapanyagokból készült fogások: házilag darált kukoricalisztből készült tortilla, marha barbacoa, cochinita pibil, al pastor, ceviche és pico de gallo. Kiváló napi taco- és burrito-menü, házi készítésű horchata, jamaica, margarita és több mint 30-féle tequila és mezcal. Reggel chilaquiles-szel indul, este pedig late-night tacóval zár – egész nap tökéletes választás.', '/img/etteremkepek/tacos.jpg', 5, 0, 1, 5, 47, 19, '2025-12-11 09:05:15');

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
-- A tábla indexei `reviews`
--
ALTER TABLE `reviews`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_reviews_user` (`user_id`),
  ADD KEY `fk_reviews_restaurant` (`restaurant_id`);

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
-- AUTO_INCREMENT a táblához `reviews`
--
ALTER TABLE `reviews`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

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
-- Megkötések a táblához `reviews`
--
ALTER TABLE `reviews`
  ADD CONSTRAINT `fk_reviews_restaurant` FOREIGN KEY (`restaurant_id`) REFERENCES `restaurants` (`id`),
  ADD CONSTRAINT `fk_reviews_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
