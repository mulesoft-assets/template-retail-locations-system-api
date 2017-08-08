CREATE DATABASE `retail_locations` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `retail_locations`;

CREATE TABLE IF NOT EXISTS `Store` (
  `storeId` varchar(45) NOT NULL,
  `name` varchar(45) NOT NULL,
  `description` varchar(45) DEFAULT NULL,
  `notes` varchar(45) DEFAULT NULL,
  `openingHours` varchar(100) NOT NULL,
  `email` varchar(45) DEFAULT NULL,
  `phone` varchar(45) DEFAULT NULL,
  `addressLine1` varchar(45) NOT NULL,
  `addressLine2` varchar(45) DEFAULT NULL,
  `city` varchar(45) NOT NULL,
  `state` varchar(45) NOT NULL,
  `zipCode` varchar(45) NOT NULL,
  `country` varchar(45) NOT NULL,
  `lat` float(10,6) NOT NULL,
  `lng` float(10,6) NOT NULL,
  PRIMARY KEY (`storeId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='street2';


CREATE TABLE IF NOT EXISTS `Product` (
  `productId` varchar(45) NOT NULL,
  `variantId` varchar(45) NOT NULL,
  `name` varchar(45) NOT NULL,
  `size` varchar(45) NOT NULL,
  `color` varchar(45) NOT NULL,
  PRIMARY KEY (`productId`,`variantId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


CREATE TABLE IF NOT EXISTS `Store_Product` (
  `Store_storeId` varchar(45) NOT NULL,
  `Product_productId` varchar(45) NOT NULL,
  `Product_variantId` varchar(45) NOT NULL,
  `availableCount` int(11) DEFAULT NULL,
  PRIMARY KEY (`Store_storeId`,`Product_productId`,`Product_variantId`),
  KEY `fk_Stores_has_Products_Products1_idx` (`Product_productId`,`Product_variantId`),
  KEY `fk_Stores_has_Products_Stores_idx` (`Store_storeId`),
  CONSTRAINT `fk_Stores_has_Products_Products1` FOREIGN KEY (`Product_productId`, `Product_variantId`) REFERENCES `Product` (`productId`, `variantId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Stores_has_Products_Stores` FOREIGN KEY (`Store_storeId`) REFERENCES `Store` (`storeId`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `Reservation` (
  `reservationId` VARCHAR(45) NOT NULL,
  `customerId` VARCHAR(45) NULL,
  `createdAt` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `quantity` INT NULL,
  `Store_storeId` VARCHAR(45) NOT NULL,
  `Product_productId` VARCHAR(45) NOT NULL,
  `Product_variantId` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`reservationId`),
  INDEX `fk_Reservation_Store1_idx` (`Store_storeId` ASC),
  INDEX `fk_Reservation_Product1_idx` (`Product_productId` ASC, `Product_variantId` ASC),
  CONSTRAINT `fk_Reservation_Store1`
    FOREIGN KEY (`Store_storeId`)
    REFERENCES `Store` (`storeId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Reservation_Product1`
    FOREIGN KEY (`Product_productId` , `Product_variantId`)
    REFERENCES `Product` (`productId` , `variantId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB DEFAULT CHARSET=latin1