-- Profil bővítés: users tábla új oszlopok
-- Futtasd a quickbite adatbázison (pl. phpMyAdmin vagy mysql klienst)

USE quickbite;

ALTER TABLE users
  ADD COLUMN updated_at datetime DEFAULT NULL AFTER created_at,
  ADD COLUMN phone varchar(30) DEFAULT NULL AFTER updated_at,
  ADD COLUMN avatar_url text DEFAULT NULL AFTER phone,
  ADD COLUMN address_line text DEFAULT NULL AFTER avatar_url,
  ADD COLUMN city varchar(100) DEFAULT NULL AFTER address_line,
  ADD COLUMN zip_code varchar(10) DEFAULT NULL AFTER city;
