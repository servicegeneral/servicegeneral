-- MySQL Script generated by MySQL Workbench
-- Tue 30 Mar 2021 03:56:56 PM EDT
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`User`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`User` (
  `idUser` INT NOT NULL AUTO_INCREMENT,
  `UserFirstName` VARCHAR(45) NULL,
  `UserLastName` VARCHAR(45) NULL,
  `UserUsername` VARCHAR(45) NULL,
  `UserPassword` VARCHAR(45) NULL,
  `UserEmail` TEXT NULL,
  `UserStreet1` VARCHAR(45) NULL,
  `UserStreet2` VARCHAR(45) NULL,
  `UserZip` VARCHAR(10) NULL,
  `UserState` VARCHAR(45) NULL,
  `UserCity` VARCHAR(45) NULL,
  `UserPhoneNumber` VARCHAR(45) NULL,
  `UserLocation` TEXT NULL,
  `UserCreatedOn` TIMESTAMP NULL,
  `UserUpdatedOn` TIMESTAMP NULL,
  PRIMARY KEY (`idUser`))
ENGINE = MyISAM;


-- -----------------------------------------------------
-- Table `mydb`.`Service`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Service` (
  `idService` INT NOT NULL AUTO_INCREMENT,
  `ServiceName` VARCHAR(45) NULL,
  PRIMARY KEY (`idService`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`ServiceProvider`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`ServiceProvider` (
  `idServiceProvider` INT NOT NULL AUTO_INCREMENT,
  `Service_idService` INT NOT NULL,
  `User_idUser` INT NOT NULL,
  PRIMARY KEY (`idServiceProvider`),
  INDEX `fk_ServiceProvider_Service1_idx` (`Service_idService` ASC) VISIBLE,
  INDEX `fk_ServiceProvider_User1_idx` (`User_idUser` ASC) VISIBLE,
  CONSTRAINT `fk_ServiceProvider_Service1`
    FOREIGN KEY (`Service_idService`)
    REFERENCES `mydb`.`Service` (`idService`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ServiceProvider_User1`
    FOREIGN KEY (`User_idUser`)
    REFERENCES `mydb`.`User` (`idUser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Consumer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Consumer` (
  `idConsumer` INT NOT NULL,
  `ConsumerName` VARCHAR(45) NULL,
  `User_idUser` INT NOT NULL,
  PRIMARY KEY (`idConsumer`),
  INDEX `fk_Consumer_User1_idx` (`User_idUser` ASC) VISIBLE,
  CONSTRAINT `fk_Consumer_User1`
    FOREIGN KEY (`User_idUser`)
    REFERENCES `mydb`.`User` (`idUser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`CreditCard`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`CreditCard` (
  `idCreditCard` INT NOT NULL,
  `CreditCardNumber` VARCHAR(16) NULL,
  `CreditCardType` ENUM("MASTER", "VISA") NULL,
  `CreditCardExpiredAt` DATE NULL,
  `CreditCardSecurity` VARCHAR(4) NULL,
  `User_idUser` INT NOT NULL,
  PRIMARY KEY (`idCreditCard`),
  INDEX `fk_CreditCard_User_idx` (`User_idUser` ASC) VISIBLE,
  CONSTRAINT `fk_CreditCard_User`
    FOREIGN KEY (`User_idUser`)
    REFERENCES `mydb`.`User` (`idUser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`ManagerAdmin`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`ManagerAdmin` (
  `idManagerAdmin` INT NOT NULL,
  `ManagerAdminName` VARCHAR(45) NULL,
  `User_idUser` INT NOT NULL,
  PRIMARY KEY (`idManagerAdmin`),
  INDEX `fk_ManagerAdmin_User1_idx` (`User_idUser` ASC) VISIBLE,
  CONSTRAINT `fk_ManagerAdmin_User1`
    FOREIGN KEY (`User_idUser`)
    REFERENCES `mydb`.`User` (`idUser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Advertisement`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Advertisement` (
  `idAdvertisement` INT NOT NULL,
  `AdvertisementName` VARCHAR(45) NULL,
  `AdvertisementLength` VARCHAR(45) NULL,
  `AdvertisementType` VARCHAR(45) NULL,
  `AdvertisementBlock` VARCHAR(45) NULL,
  `AdvertisementLocation` VARCHAR(45) NULL,
  `User_idUser` INT NOT NULL,
  PRIMARY KEY (`idAdvertisement`),
  INDEX `fk_Advertisement_User1_idx` (`User_idUser` ASC) VISIBLE,
  CONSTRAINT `fk_Advertisement_User1`
    FOREIGN KEY (`User_idUser`)
    REFERENCES `mydb`.`User` (`idUser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Subscription`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Subscription` (
  `idSubscription` INT NOT NULL,
  `SubscriptionExpiryAt` DATETIME NULL,
  `User_idUser` INT NOT NULL,
  `Service_idService` INT NOT NULL,
  PRIMARY KEY (`idSubscription`),
  INDEX `fk_Subscription_User1_idx` (`User_idUser` ASC) VISIBLE,
  INDEX `fk_Subscription_Service1_idx` (`Service_idService` ASC) VISIBLE,
  CONSTRAINT `fk_Subscription_User1`
    FOREIGN KEY (`User_idUser`)
    REFERENCES `mydb`.`User` (`idUser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Subscription_Service1`
    FOREIGN KEY (`Service_idService`)
    REFERENCES `mydb`.`Service` (`idService`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Feedback`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Feedback` (
  `idFeedback` INT NOT NULL,
  `FeedbackMessage` TEXT NULL,
  `FeedbackCreatedOn` DATETIME NULL,
  `Consumer_idConsumer` INT NOT NULL,
  PRIMARY KEY (`idFeedback`),
  INDEX `fk_Feedback_Consumer1_idx` (`Consumer_idConsumer` ASC) VISIBLE,
  CONSTRAINT `fk_Feedback_Consumer1`
    FOREIGN KEY (`Consumer_idConsumer`)
    REFERENCES `mydb`.`Consumer` (`idConsumer`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
