CREATE DATABASE IF NOT EXISTS `smarthome` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE smarthome;
CREATE TABLE IF NOT EXISTS `users_general` (
  `id` INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `firstname` VARCHAR(50) NOT NULL,
  `lastname` VARCHAR(50) NOT NULL
);
CREATE TABLE IF NOT EXISTS `users_local` (
  `id` INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `email` VARCHAR(50) NOT NULL,
  `password` BLOB NOT NULL,
  `salt` VARCHAR(20) NOT NULL,
  CONSTRAINT unique_salt UNIQUE (`salt`),
  CONSTRAINT fk_id FOREIGN KEY (`id`) REFERENCES `users_general` (`id`) ON UPDATE CASCADE ON DELETE CASCADE
);
CREATE TABLE IF NOT EXISTS `buildings` (
  `id` INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `name` VARCHAR(50) NOT NULL DEFAULT "Home",
  `street` VARCHAR(50) NOT NULL,
  `postcode` VARCHAR(5) NOT NULL,
  `city` VARCHAR(50) NOT NULL,
  `country` VARCHAR(50) NOT NULL DEFAULT "Deutschland"
);
CREATE TABLE IF NOT EXISTS `rooms` (
  `id` INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `name` VARCHAR(50) NOT NULL,
  `building` INT UNSIGNED NOT NULL,
  CONSTRAINT fk_building FOREIGN KEY (`building`) REFERENCES `buildings` (`id`) ON UPDATE CASCADE ON DELETE CASCADE
);
CREATE TABLE IF NOT EXISTS `devices` (
  `id` INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `name` VARCHAR(50) DEFAULT '',
  `type` VARCHAR(3) DEFAULT NULL,
  `description` VARCHAR(500) DEFAULT '',
  `vendor` VARCHAR(100) DEFAULT '',
  `mac` VARCHAR(17) DEFAULT '',
  `local` VARCHAR(20) DEFAULT '',
  `room` INT UNSIGNED,
  CONSTRAINT unique_mac UNIQUE (`mac`),
  CONSTRAINT fk_room FOREIGN KEY (`room`) REFERENCES `rooms` (`id`) ON UPDATE CASCADE ON DELETE
  SET
    NULL
);
CREATE TABLE IF NOT EXISTS `members` (
  `id` INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `user` INT UNSIGNED NOT NULL,
  `building` INT UNSIGNED NOT NULL,
  CONSTRAINT fk_user FOREIGN KEY (`user`) REFERENCES `users_general` (`id`) ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT fk_building_m FOREIGN KEY (`building`) REFERENCES `buildings` (`id`) ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT unique_user_building UNIQUE (`user`, `building`)
);
CREATE TABLE IF NOT EXISTS `shortcuts` (
  `id` INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `building` INT UNSIGNED NOT NULL,
  `device` INT UNSIGNED NOT NULL,
  `description` VARCHAR(50) NOT NULL,
  `command` BLOB NOT NULL,
  CONSTRAINT fk_building_s FOREIGN KEY (`building`) REFERENCES `buildings` (`id`) ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT fk_device_s FOREIGN KEY (`device`) REFERENCES `devices` (`id`) ON UPDATE CASCADE ON DELETE CASCADE
);
-- -- -- -- -- --
--    DATA     --
-- -- -- -- -- --
INSERT INTO
  `users_general` (`firstname`, `lastname`)
VALUES
  ('Jan', 'Bellenberg');
INSERT INTO
  `users_local` (`id`, `email`, `password`, `salt`)
VALUES
  (
    1,
    'janbellenberg.jb@gmail.com',
    '02b1d4a0fa5e97bb2331f134368e350014f133236b8d8b83b04deeece74da653193e3152732d5176b1421170cbe9e7afae572119a6d8d29c22b6cc4adb24a7f3',
    '9c8wvDQ45xFCGTbavTy5'
  );
INSERT INTO
  `buildings` (`name`, `street`, `postcode`, `city`, `country`)
VALUES
  (
    'Zuhause',
    'Fasanenstr. 40',
    '45134',
    'Essen',
    'Deutschland'
  );
INSERT INTO
  `rooms` (`name`, `building`)
VALUES
  ('Wohnzimmer', 1);
INSERT INTO
  `devices` (
    `name`,
    `type`,
    `description`,
    `vendor`,
    `mac`,
    `local`,
    `room`
  )
VALUES
  (
    'D1 Mini',
    'lgt',
    'Test',
    'Jan Bellenberg',
    '',
    NULL,
    1
  );
INSERT INTO
  `members` (`user`, `building`)
VALUES
  (1, 1);
INSERT INTO
  `shortcuts` (`building`, `device`, `description`, `command`)
VALUES
  (1, 1, "Licht an", "on"),
  (1, 1, "Licht aus", "off");
-- -- -- -- -- --
  --    USER     --
  -- -- -- -- -- --
  CREATE USER 'smarthome' @'%' IDENTIFIED BY 'gXg33Ep4urGp6bF2';
REVOKE ALL PRIVILEGES ON *.*
FROM
  'smarthome' @'%';
REVOKE GRANT OPTION ON *.*
FROM
  'smarthome' @'%';
GRANT
SELECT,
INSERT,
UPDATE,
  DELETE ON `smarthome`.* TO 'smarthome' @'%';
FLUSH PRIVILEGES;