-- Több cím + fizetési módok táblák
-- Futtasd a quickbite adatbázison (pl. phpMyAdmin vagy mysql klienst)

USE quickbite;

-- Címeim (Otthon, Munkahely, stb.)
CREATE TABLE IF NOT EXISTS user_addresses (
  id int(11) NOT NULL AUTO_INCREMENT,
  user_id int(11) NOT NULL,
  label varchar(50) NOT NULL,
  address_line text NOT NULL,
  city varchar(100) NOT NULL,
  zip_code varchar(10) NOT NULL,
  is_default tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (id),
  KEY idx_user_addresses_user_id (user_id),
  CONSTRAINT fk_user_addresses_user FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Fizetési módok (kártya, készpénz, SZÉP)
CREATE TABLE IF NOT EXISTS user_payment_methods (
  id int(11) NOT NULL AUTO_INCREMENT,
  user_id int(11) NOT NULL,
  type varchar(20) NOT NULL,
  display_name varchar(100) NOT NULL,
  last_four_digits varchar(4) DEFAULT NULL,
  is_default tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (id),
  KEY idx_user_payment_methods_user_id (user_id),
  CONSTRAINT fk_user_payment_methods_user FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
