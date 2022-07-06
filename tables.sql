DROP DATEBASE IF EXISTS `team4`;
SET default_storage_engine=InnoDB;
SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE DATEBASE IF NOT EXISTS `team4`;
  DEFAULT CHARACTER SET utf8mb4;
  DEFAULT COLLATE utf8mb4_unicode_ci;
USE team4;

CREATE USER IF NOT EXISTS `team4`@`localhost`
SET PASSWORD FOR `team4`@`localhost`=`1234`;
GRANT ALL PRIVILEGES ON `team4`.* TO `team4`@`localhost` WITH GRANT OPTION;

CREATE USER IF NOT EXISTS `team4`@`%`;
SET PASSWORD FOR `team4`@`%` = `1234`;
GRANT ALL PRIVILEGES ON `team4`.* TO `team4`@`%` WITH GRANT OPTION;

GRANT ALL PRIVILEGES ON `team4`.* TO `team4`@`localhost`;

FLUSH PRIVILEGES;


-- Tables  

DROP TABLE `user`;
CREATE TABLE `user` (
  `id` int  NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(45) NOT NULL,
  `displayName` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`));

INSERT INTO `user` VALUES ('1','cat1','admin1',  'cat1');
INSERT INTO `user` VALUES ('2','cat2','admin2',  'cat2');
INSERT INTO `user` VALUES ('3','cat3','admin3',  'cat3');

INSERT INTO `user` VALUES ('4','cat4', 'provider1', 'cat4');
INSERT INTO `user` VALUES ('5','cat5', 'provider2', 'cat5');
INSERT INTO `user` VALUES ('6','cat6', 'provider3', 'cat6');

INSERT INTO `user` VALUES ('7','cat7', 'cimtUser1', 'cat7');
INSERT INTO `user` VALUES ('8','cat8', 'cimtUser2', 'cat8');
INSERT INTO `user` VALUES ('9','cat9', 'cimtUser3', 'cat9');


DROP TABLE `admin`;
CREATE TABLE `admin` (
  `id` int NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `userId` INT NOT NULL,
  `email` VARCHAR(65) NOT NULL,
  FOREIGN KEY (`userId`) REFERENCES `user`(`id`) ON DELETE CASCADE);


INSERT INTO `admin` (`id`, `userId`, `email`) VALUES ('1', '1', 'admin1@team4.com');
INSERT INTO `admin` (`id`, `userId`, `email`) VALUES ('2', '2', 'admin2@team4.com');
INSERT INTO `admin` (`id`, `userId`, `email`) VALUES ('3', '3', 'admin3@team4.com');


DROP TABLE `provider`;
CREATE TABLE `provider` (
  `id` int NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `userId` INT NOT NULL,
  `address` VARCHAR(100) NOT NULL,
  FOREIGN KEY (`userId`) REFERENCES `user`(`id`) ON DELETE CASCADE);



INSERT INTO `provider` (`id`, `userId`, `address`) VALUES ('1', '4', '111 Street, Some City, Some State, 11111');
INSERT INTO `provider` (`id`, `userId`, `address`) VALUES ('2', '5', '222 Street, Some City, Some State, 22222');
INSERT INTO `provider` (`id`, `userId`, `address`) VALUES ('3', '6', '333 Street, Some City, Some State, 33333');


DROP TABLE `cimtUser`;
CREATE TABLE `cimtUser` (
  `id` int NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `userId` INT NOT NULL,
  `phone` VARCHAR(45) NOT NULL,
   FOREIGN KEY (`userId`) REFERENCES `user`(`id`) ON DELETE CASCADE);



INSERT INTO `cimtuser` (`id`, `userId`, `phone`) VALUES ('1', '7', '111-111-1111');
INSERT INTO `cimtuser` (`id`, `userId`, `phone`) VALUES ('2', '8', '222-222-2222');
INSERT INTO `cimtuser` (`id`, `userId`, `phone`) VALUES ('3', '9', '333-333-3333');


DROP TABLE `resource`;
CREATE TABLE `resource` (
  `id` int NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `userId` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `description` TEXT(255) NULL,
  `capability` TEXT(1000) NULL,
  `distance` DECIMAL(1) NULL,
  `cost` DECIMAL(2) NOT NULL,
  `unitId` INT NOT NULL,
  FOREIGN KEY (`userId`) REFERENCES `user`(`id`),
  FOREIGN KEY (`unitId`) REFERENCES `unit`(`id`));



  DROP TABLE `resourceFunction`;
  CREATE TABLE `resourceFunction` (
  `id` int NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `description` VARCHAR(100) NOT NULL,
   UNIQUE KEY `description` (`description`));


INSERT INTO `resourceFunction` (`id`, `description`) VALUES ('1', '#1: transportation');
INSERT INTO `resourceFunction` (`id`, `description`) VALUES ('2', '#2: communications');
INSERT INTO `resourceFunction` (`id`, `description`) VALUES ('3', '#3: engineering');
INSERT INTO `resourceFunction` (`id`, `description`) VALUES ('4', '#4: search and rescue');
INSERT INTO `resourceFunction` (`id`, `description`) VALUES ('5', '#5: education');
INSERT INTO `resourceFunction` (`id`, `description`) VALUES ('6', '#6: energy');
INSERT INTO `resourceFunction` (`id`, `description`) VALUES ('7', '#7: firefighting');
INSERT INTO `resourceFunction` (`id`, `description`) VALUES ('8', '#8: human services');


DROP TABLE `functionType`;
CREATE TABLE `functionType` (
  `id` int NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `typeName` VARCHAR(45) NOT NULL,
   UNIQUE KEY `typeName` (`typeName`));


INSERT INTO `functionType` (`id`, `TypeName`) VALUES ('1', 'primary');
INSERT INTO `functionType` (`id`, `TypeName`) VALUES ('2', 'secondary');


DROP TABLE `function_type_resource`;
CREATE TABLE `function_type_resource` (
  `resourceId` int NOT NULL,
  `functionId` int NOT NULL,
  `functionTypeId` int NOT NULL,
  PRIMARY KEY (resourceId,functionId,functionTypeId),
  FOREIGN KEY (`resourceId`) REFERENCES `resource`(`id`),
  FOREIGN KEY (`functionId`) REFERENCES `resourceFunction`(`id`),
  FOREIGN KEY (`functionTypeId`) REFERENCES `functionType`(`id`));

 
DROP TABLE `unit`;
CREATE TABLE `unit` (
  `id` int NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `typeName` VARCHAR(45) NOT NULL,
  UNIQUE KEY `typeName` (`typeName`));

INSERT INTO `unit` (`id`, `typeName`) VALUES ('1', 'hour');
INSERT INTO `unit` (`id`, `typeName`) VALUES ('2', 'day');
INSERT INTO `unit` (`id`, `typeName`) VALUES ('3', 'week');
INSERT INTO `unit` (`id`, `typeName`) VALUES ('4', 'each');
INSERT INTO `unit` (`id`, `typeName`) VALUES ('5', 'use');


DROP TABLE `incident`;
CREATE TABLE `incident` (
  `id` int NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `categoryId` VARCHAR(16) NOT NULL,
  `date` DATETIME NOT NULL,
  `description` VARCHAR(100) NOT NULL,
  `userId` int NOT NULL,
  FOREIGN KEY (`userId`) REFERENCES `user`(`id`),
  FOREIGN KEY (`categoryId`) REFERENCES `category`(`id`));

  

DROP TABLE `category`;
CREATE TABLE `category` (
  `id` VARCHAR(16) NOT NULL PRIMARY KEY,
  `description` VARCHAR(100) NOT NULL,
  UNIQUE KEY `description` (`description`));


INSERT INTO `category` (`id`, `description`) VALUES ('c1', 'must evac, secure lockdown');
INSERT INTO `category` (`id`, `description`) VALUES ('c2', 'may evac, secure lockdown');
INSERT INTO `category` (`id`, `description`) VALUES ('c3', 'no evac, limited lockdownc');
INSERT INTO `category` (`id`, `description`) VALUES ('c4', 'no evac, no lockdown');




