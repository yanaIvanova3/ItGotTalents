-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`StudentCV`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`StudentCV` (
  `id` INT NOT NULL COMMENT '',
  `SomeDescription` TEXT NOT NULL COMMENT '',
  PRIMARY KEY (`id`)  COMMENT '')
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Students`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Students` (
  `Id` INT NOT NULL AUTO_INCREMENT COMMENT '',
  `FullName` NVARCHAR(100) NOT NULL COMMENT '',
  `Username` VARCHAR(45) NOT NULL COMMENT '',
  `Email` VARCHAR(60) NOT NULL COMMENT '',
  `Password` NVARCHAR(200) NOT NULL COMMENT '',
  `Gender` VARCHAR(6) NULL COMMENT '',
  `Photo` MEDIUMBLOB NULL COMMENT '',
  `RegistrationDate` DATE NOT NULL COMMENT '',
  `DateOfBirth` DATE NULL COMMENT '',
  `Grade` NVARCHAR(50) NULL COMMENT '',
  `StudentCVId` INT NOT NULL COMMENT '',
  PRIMARY KEY (`Id`, `StudentCVId`)  COMMENT '',
  UNIQUE INDEX `idStudents_UNIQUE` (`Id` ASC)  COMMENT '',
  UNIQUE INDEX `Username_UNIQUE` (`Username` ASC)  COMMENT '',
  UNIQUE INDEX `Email_UNIQUE` (`Email` ASC)  COMMENT '',
  INDEX `fk_Students_StudentCV1_idx` (`StudentCVId` ASC)  COMMENT '',
  UNIQUE INDEX `StudentCVId_UNIQUE` (`StudentCVId` ASC)  COMMENT '',
  CONSTRAINT `fk_Students_StudentCV1`
    FOREIGN KEY (`StudentCVId`)
    REFERENCES `mydb`.`StudentCV` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`ProjectPhotos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`ProjectPhotos` (
  `Id` INT NOT NULL COMMENT '',
  `FirstPhoto` VARCHAR(250) NOT NULL COMMENT '',
  `SecondPhoto` VARCHAR(250) NOT NULL COMMENT '',
  `ThirdPhoto` VARCHAR(250) NOT NULL COMMENT '',
  PRIMARY KEY (`Id`)  COMMENT '')
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Projects`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Projects` (
  `Id` INT NOT NULL AUTO_INCREMENT COMMENT '',
  `Name` NVARCHAR(50) NOT NULL COMMENT '',
  `GitHubURL` VARCHAR(200) NOT NULL COMMENT '',
  `VideoURL` VARCHAR(200) NULL COMMENT '',
  `Description` TEXT NULL COMMENT '',
  `ProjectPhotosId` INT NOT NULL COMMENT '',
  PRIMARY KEY (`Id`, `ProjectPhotosId`)  COMMENT '',
  UNIQUE INDEX `Name_UNIQUE` (`Name` ASC)  COMMENT '',
  UNIQUE INDEX `GitHub_UNIQUE` (`GitHubURL` ASC)  COMMENT '',
  INDEX `fk_Projects_ProjectPhotos1_idx` (`ProjectPhotosId` ASC)  COMMENT '',
  UNIQUE INDEX `ProjectPhotosId_UNIQUE` (`ProjectPhotosId` ASC)  COMMENT '',
  CONSTRAINT `fk_Projects_ProjectPhotos1`
    FOREIGN KEY (`ProjectPhotosId`)
    REFERENCES `mydb`.`ProjectPhotos` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`StudentsProjects`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`StudentsProjects` (
  `ProjectsId` INT NOT NULL COMMENT '',
  `StudentsId` INT NOT NULL COMMENT '',
  PRIMARY KEY (`ProjectsId`, `StudentsId`)  COMMENT '',
  INDEX `fk_Projects_has_Students_Students1_idx` (`StudentsId` ASC)  COMMENT '',
  INDEX `fk_Projects_has_Students_Projects1_idx` (`ProjectsId` ASC)  COMMENT '',
  CONSTRAINT `fk_Projects_has_Students_Projects1`
    FOREIGN KEY (`ProjectsId`)
    REFERENCES `mydb`.`Projects` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Projects_has_Students_Students1`
    FOREIGN KEY (`StudentsId`)
    REFERENCES `mydb`.`Students` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Courses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Courses` (
  `Id` INT NOT NULL AUTO_INCREMENT COMMENT '',
  `Name` VARCHAR(45) NULL COMMENT '',
  `CreatedOn` DATE NOT NULL COMMENT '',
  `Description` TEXT NULL COMMENT '',
  PRIMARY KEY (`Id`)  COMMENT '',
  UNIQUE INDEX `Name_UNIQUE` (`Name` ASC)  COMMENT '')
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`StudentsCourses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`StudentsCourses` (
  `StudentsId` INT NOT NULL COMMENT '',
  `CoursesId` INT NOT NULL COMMENT '',
  PRIMARY KEY (`StudentsId`, `CoursesId`)  COMMENT '',
  INDEX `fk_Students_has_Courses_Courses1_idx` (`CoursesId` ASC)  COMMENT '',
  INDEX `fk_Students_has_Courses_Students1_idx` (`StudentsId` ASC)  COMMENT '',
  CONSTRAINT `fk_Students_has_Courses_Students1`
    FOREIGN KEY (`StudentsId`)
    REFERENCES `mydb`.`Students` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Students_has_Courses_Courses1`
    FOREIGN KEY (`CoursesId`)
    REFERENCES `mydb`.`Courses` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
