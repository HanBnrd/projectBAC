-- MySQL Script generated by MySQL Workbench
-- mer. 20 déc. 2017 14:38:19 CET
-- Model: New Model    Version: 1.0
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
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`profil`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`profil` ;

CREATE TABLE IF NOT EXISTS `mydb`.`profil` (
  `serie` VARCHAR(45) NOT NULL,
  `mention` VARCHAR(45) NOT NULL,
  `specialite` VARCHAR(45) NOT NULL,
  `section` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`serie`, `mention`, `specialite`, `section`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`candidat`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`candidat` ;

CREATE TABLE IF NOT EXISTS `mydb`.`candidat` (
  `id` VARCHAR(45) NOT NULL,
  `profil_serie` VARCHAR(45) NOT NULL,
  `profil_mention` VARCHAR(45) NOT NULL,
  `profil_specialite` VARCHAR(45) NOT NULL,
  `profil_section` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_candidat_profil_idx` (`profil_serie` ASC, `profil_mention` ASC, `profil_specialite` ASC, `profil_section` ASC),
  CONSTRAINT `fk_candidat_profil`
    FOREIGN KEY (`profil_serie` , `profil_mention` , `profil_specialite` , `profil_section`)
    REFERENCES `mydb`.`profil` (`serie` , `mention` , `specialite` , `section`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`epreuve`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`epreuve` ;

CREATE TABLE IF NOT EXISTS `mydb`.`epreuve` (
  `code` VARCHAR(10) NOT NULL,
  `libelle` VARCHAR(45) NOT NULL,
  `composition` VARCHAR(10) NULL,
  `rattrapage` VARCHAR(10) NULL,
  PRIMARY KEY (`code`),
  INDEX `fk_epreuve_epreuve1_idx` (`composition` ASC),
  INDEX `fk_epreuve_epreuve2_idx` (`rattrapage` ASC),
  CONSTRAINT `fk_epreuve_epreuve1`
    FOREIGN KEY (`composition`)
    REFERENCES `mydb`.`epreuve` (`code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_epreuve_epreuve2`
    FOREIGN KEY (`rattrapage`)
    REFERENCES `mydb`.`epreuve` (`code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`matiere`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`matiere` ;

CREATE TABLE IF NOT EXISTS `mydb`.`matiere` (
  `code` VARCHAR(10) NOT NULL,
  `libelle` VARCHAR(45) NOT NULL,
  `epreuve_code` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`code`, `epreuve_code`),
  INDEX `fk_matiere_epreuve1_idx` (`epreuve_code` ASC),
  CONSTRAINT `fk_matiere_epreuve1`
    FOREIGN KEY (`epreuve_code`)
    REFERENCES `mydb`.`epreuve` (`code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`note`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`note` ;

CREATE TABLE IF NOT EXISTS `mydb`.`note` (
  `candidat_id` VARCHAR(45) NOT NULL,
  `epreuve_code` VARCHAR(10) NOT NULL,
  `note` VARCHAR(10) NULL,
  `matiere_code` VARCHAR(10) NULL,
  PRIMARY KEY (`candidat_id`, `epreuve_code`),
  INDEX `fk_candidat_has_epreuve_epreuve1_idx` (`epreuve_code` ASC),
  INDEX `fk_candidat_has_epreuve_candidat1_idx` (`candidat_id` ASC),
  INDEX `fk_note_matiere1_idx` (`matiere_code` ASC),
  CONSTRAINT `fk_candidat_has_epreuve_candidat1`
    FOREIGN KEY (`candidat_id`)
    REFERENCES `mydb`.`candidat` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_candidat_has_epreuve_epreuve1`
    FOREIGN KEY (`epreuve_code`)
    REFERENCES `mydb`.`epreuve` (`code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_note_matiere1`
    FOREIGN KEY (`matiere_code`)
    REFERENCES `mydb`.`matiere` (`code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`coeff`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`coeff` ;

CREATE TABLE IF NOT EXISTS `mydb`.`coeff` (
  `profil_serie` VARCHAR(45) NOT NULL,
  `profil_mention` VARCHAR(45) NOT NULL,
  `profil_specialite` VARCHAR(45) NOT NULL,
  `profil_section` VARCHAR(45) NOT NULL,
  `epreuve_code` VARCHAR(10) NOT NULL,
  `coeff` INT NOT NULL,
  `bonus` VARCHAR(45) NULL,
  `facultatif` VARCHAR(45) NULL,
  PRIMARY KEY (`profil_serie`, `profil_mention`, `profil_specialite`, `profil_section`, `epreuve_code`),
  INDEX `fk_profil_has_epreuve_epreuve1_idx` (`epreuve_code` ASC),
  INDEX `fk_profil_has_epreuve_profil1_idx` (`profil_serie` ASC, `profil_mention` ASC, `profil_specialite` ASC, `profil_section` ASC),
  CONSTRAINT `fk_profil_has_epreuve_profil1`
    FOREIGN KEY (`profil_serie` , `profil_mention` , `profil_specialite` , `profil_section`)
    REFERENCES `mydb`.`profil` (`serie` , `mention` , `specialite` , `section`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_profil_has_epreuve_epreuve1`
    FOREIGN KEY (`epreuve_code`)
    REFERENCES `mydb`.`epreuve` (`code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

