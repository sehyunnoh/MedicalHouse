SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

DROP SCHEMA IF EXISTS `mercury` ;
CREATE SCHEMA IF NOT EXISTS `mercury` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `mercury` ;

-- -----------------------------------------------------
-- Table `mercury`.`Roles`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mercury`.`Roles` ;

CREATE  TABLE IF NOT EXISTS `mercury`.`Roles` (
  `code` INT NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(45) NULL ,
  PRIMARY KEY (`code`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mercury`.`Users`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mercury`.`Users` ;

CREATE  TABLE IF NOT EXISTS `mercury`.`Users` (
  `username` VARCHAR(12) NOT NULL ,
  `role` INT NULL DEFAULT 2 ,
  `password` VARCHAR(45) NULL ,
  `dateOfLastLogin` DATETIME NULL ,
  UNIQUE INDEX `username_UNIQUE` (`username` ASC) ,
  INDEX `UserRole_idx` (`role` ASC) ,
  PRIMARY KEY (`username`) ,
  CONSTRAINT `UserRole`
    FOREIGN KEY (`role` )
    REFERENCES `mercury`.`Roles` (`code` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mercury`.`Patients`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mercury`.`Patients` ;

CREATE  TABLE IF NOT EXISTS `mercury`.`Patients` (
  `OHIPNumber` BIGINT(10) NOT NULL ,
  `OHIPVersion` VARCHAR(2) NOT NULL ,
  `FirstName` VARCHAR(45) NOT NULL ,
  `MiddleInitials` VARCHAR(3) NULL ,
  `LastName` VARCHAR(45) NOT NULL ,
  `Login` VARCHAR(45) NULL ,
  `Gender` CHAR(1) NULL ,
  `DateOfBirth` DATE NULL ,
  PRIMARY KEY (`OHIPNumber`) ,
  INDEX `Login_idx` (`Login` ASC) ,
  CONSTRAINT `Login`
    FOREIGN KEY (`Login` )
    REFERENCES `mercury`.`Users` (`username` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mercury`.`Provinces`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mercury`.`Provinces` ;

CREATE  TABLE IF NOT EXISTS `mercury`.`Provinces` (
  `provinceCode` VARCHAR(2) NOT NULL ,
  `province` VARCHAR(45) NULL ,
  PRIMARY KEY (`provinceCode`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mercury`.`Addresses`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mercury`.`Addresses` ;

CREATE  TABLE IF NOT EXISTS `mercury`.`Addresses` (
  `addressId` INT NOT NULL AUTO_INCREMENT ,
  `streetLine1` VARCHAR(65) NOT NULL ,
  `streetLine2` VARCHAR(45) NULL ,
  `aptOrUnitNumber` VARCHAR(5) NULL ,
  `city` VARCHAR(45) NOT NULL ,
  `province` VARCHAR(2) NOT NULL DEFAULT 'ON' ,
  `postalCode` VARCHAR(6) NULL ,
  `type` VARCHAR(10) NULL DEFAULT 'Home' ,
  `occupant` VARCHAR(15) NOT NULL ,
  PRIMARY KEY (`addressId`) ,
  INDEX `Occupant_idx` (`occupant` ASC) ,
  INDEX `ProvinceCode_idx` (`province` ASC) ,
  CONSTRAINT `Occupant`
    FOREIGN KEY (`occupant` )
    REFERENCES `mercury`.`Users` (`username` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `ProvinceCode`
    FOREIGN KEY (`province` )
    REFERENCES `mercury`.`Provinces` (`provinceCode` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mercury`.`Practitioners`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mercury`.`Practitioners` ;

CREATE  TABLE IF NOT EXISTS `mercury`.`Practitioners` (
  `CPSO` INT NOT NULL ,
  `FirstName` VARCHAR(45) NOT NULL ,
  `MiddleInitials` VARCHAR(3) NULL ,
  `LastName` VARCHAR(45) NOT NULL ,
  `Login` VARCHAR(12) NOT NULL ,
  `PrimaryPracticeAddress` INT NOT NULL ,
  `PracticeName` VARCHAR(60) NULL ,
  PRIMARY KEY (`CPSO`) ,
  INDEX `LoginName_idx` (`Login` ASC) ,
  INDEX `PrimaryPracticeLocation_idx` (`PrimaryPracticeAddress` ASC) ,
  CONSTRAINT `LoginName`
    FOREIGN KEY (`Login` )
    REFERENCES `mercury`.`Users` (`username` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `PrimaryPracticeLocation`
    FOREIGN KEY (`PrimaryPracticeAddress` )
    REFERENCES `mercury`.`Addresses` (`addressId` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mercury`.`Appointments`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mercury`.`Appointments` ;

CREATE  TABLE IF NOT EXISTS `mercury`.`Appointments` (
  `ApptNumber` INT NOT NULL AUTO_INCREMENT ,
  `Patient` BIGINT(10) NOT NULL ,
  `ReasonForVisit` VARCHAR(80) NULL ,
  `DateTime` DATETIME NOT NULL ,
  `IsPatientCheckedIn` TINYINT(1) NULL ,
  PRIMARY KEY (`ApptNumber`) ,
  INDEX `Patient_idx` (`Patient` ASC) ,
  CONSTRAINT `Patient`
    FOREIGN KEY (`Patient` )
    REFERENCES `mercury`.`Patients` (`OHIPNumber` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mercury`.`Visit`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mercury`.`Visit` ;

CREATE  TABLE IF NOT EXISTS `mercury`.`Visit` (
  `VisitNumber` INT NOT NULL AUTO_INCREMENT ,
  `Physician` INT NOT NULL ,
  `DateTimeOfVisit` DATETIME NOT NULL ,
  `BloodPressureSystolic` INT(3) NULL ,
  `Temperature` DECIMAL(3,1) NULL ,
  `BloodPressureDiastolic` INT(2) NULL ,
  `IsVisitComplete` TINYINT(1) NULL ,
  `MedicalDiagnosis` LONGTEXT NULL ,
  `PhysicianNotes` LONGTEXT NULL ,
  `Appointment` INT NULL ,
  PRIMARY KEY (`VisitNumber`) ,
  INDEX `AttendingPhysician_idx` (`Physician` ASC) ,
  INDEX `ScheduledAppt_idx` (`Appointment` ASC) ,
  CONSTRAINT `AttendingPhysician`
    FOREIGN KEY (`Physician` )
    REFERENCES `mercury`.`Practitioners` (`CPSO` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `ScheduledAppt`
    FOREIGN KEY (`Appointment` )
    REFERENCES `mercury`.`Appointments` (`ApptNumber` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mercury`.`Prescription`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mercury`.`Prescription` ;

CREATE  TABLE IF NOT EXISTS `mercury`.`Prescription` (
  `Number` INT NOT NULL AUTO_INCREMENT ,
  `MedicationName` VARCHAR(45) NOT NULL ,
  `Orders` VARCHAR(45) NOT NULL ,
  `NumRepeats` INT NOT NULL DEFAULT 0 ,
  `PatientVisit` INT NOT NULL ,
  PRIMARY KEY (`Number`) ,
  INDEX `PatientVisit_idx` (`PatientVisit` ASC) ,
  CONSTRAINT `PatientVisit`
    FOREIGN KEY (`PatientVisit` )
    REFERENCES `mercury`.`Visit` (`VisitNumber` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mercury`.`MedicalTest`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mercury`.`MedicalTest` ;

CREATE  TABLE IF NOT EXISTS `mercury`.`MedicalTest` (
  `TestID` INT NOT NULL AUTO_INCREMENT ,
  `TestName` VARCHAR(45) NOT NULL ,
  `TestType` VARCHAR(45) NULL ,
  `KeyIndicators` VARCHAR(45) NULL ,
  `TestingDate` DATETIME NULL ,
  `TestingPractitioner` INT NULL ,
  `TestOrderInfo` INT NULL ,
  PRIMARY KEY (`TestID`) ,
  INDEX `Tester_idx` (`TestingPractitioner` ASC) ,
  INDEX `OrderInfo_idx` (`TestOrderInfo` ASC) ,
  CONSTRAINT `Tester`
    FOREIGN KEY (`TestingPractitioner` )
    REFERENCES `mercury`.`Practitioners` (`CPSO` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `OrderInfo`
    FOREIGN KEY (`TestOrderInfo` )
    REFERENCES `mercury`.`Visit` (`VisitNumber` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mercury`.`PhoneNumbers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mercury`.`PhoneNumbers` ;

CREATE  TABLE IF NOT EXISTS `mercury`.`PhoneNumbers` (
  `PhoneNumber` BIGINT(10) NULL ,
  `UserName` VARCHAR(12) NOT NULL ,
  `PhoneType` VARCHAR(10) NOT NULL ,
  PRIMARY KEY (`UserName`, `PhoneType`) ,
  INDEX `UserPhone_idx` (`UserName` ASC) ,
  CONSTRAINT `UserPhone`
    FOREIGN KEY (`UserName` )
    REFERENCES `mercury`.`Users` (`username` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = INNODB;



-- -----------------------------------------------------
-- Table `mercury`.`MenuFunctions`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mercury`.`MenuFunctions` ;

CREATE  TABLE IF NOT EXISTS `mercury`.`MenuFunctions` (
  `Code` VARCHAR(5) NOT NULL ,
  `FunctionName` VARCHAR(45) NOT NULL ,
  `URL` VARCHAR(45) NULL ,
  PRIMARY KEY (`Code`) )
ENGINE = InnoDB;

USE `mercury` ;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `mercury`.`Roles`
-- -----------------------------------------------------
START TRANSACTION;
USE `mercury`;
INSERT INTO `mercury`.`Roles` (`code`, `name`) VALUES (1, 'Doctor');
INSERT INTO `mercury`.`Roles` (`code`, `name`) VALUES (2, 'Patient');
INSERT INTO `mercury`.`Roles` (`code`, `name`) VALUES (3, 'Nurse Practitioner');
INSERT INTO `mercury`.`Roles` (`code`, `name`) VALUES (4, 'Registered Nurse');
INSERT INTO `mercury`.`Roles` (`code`, `name`) VALUES (5, 'Receptionist');
INSERT INTO `mercury`.`Roles` (`code`, `name`) VALUES (6, 'Digital Imaging Tech');
INSERT INTO `mercury`.`Roles` (`code`, `name`) VALUES (7, 'Administrator');

COMMIT;

-- -----------------------------------------------------
-- Data for table `mercury`.`Users`
-- -----------------------------------------------------
START TRANSACTION;
USE `mercury`;
INSERT INTO `mercury`.`Users` (`username`, `role`, `password`, `dateOfLastLogin`) VALUES ('asserali', 1, 'password', NULL);
INSERT INTO `mercury`.`Users` (`username`, `role`, `password`, `dateOfLastLogin`) VALUES ('hventer', 1, 'password', NULL);
INSERT INTO `mercury`.`Users` (`username`, `role`, `password`, `dateOfLastLogin`) VALUES ('lcushnie', 5, 'password', NULL);
INSERT INTO `mercury`.`Users` (`username`, `role`, `password`, `dateOfLastLogin`) VALUES ('bachan', 1, 'password', NULL);
INSERT INTO `mercury`.`Users` (`username`, `role`, `password`, `dateOfLastLogin`) VALUES ('ojones', 2, 'password', NULL);
INSERT INTO `mercury`.`Users` (`username`, `role`, `password`, `dateOfLastLogin`) VALUES ('hburris', 2, 'password', NULL);
INSERT INTO `mercury`.`Users` (`username`, `role`, `password`, `dateOfLastLogin`) VALUES ('afantuz', 2, 'password', NULL);
INSERT INTO `mercury`.`Users` (`username`, `role`, `password`, `dateOfLastLogin`) VALUES ('mblack', 2, 'password', NULL);
INSERT INTO `mercury`.`Users` (`username`, `role`, `password`, `dateOfLastLogin`) VALUES ('rray', 2, 'password', NULL);
INSERT INTO `mercury`.`Users` (`username`, `role`, `password`, `dateOfLastLogin`) VALUES ('cowens', 2, 'password', NULL);

COMMIT;

-- -----------------------------------------------------
-- Data for table `mercury`.`Patients`
-- -----------------------------------------------------
START TRANSACTION;
USE `mercury`;
INSERT INTO `mercury`.`Patients` (`OHIPNumber`, `OHIPVersion`, `FirstName`, `MiddleInitials`, `LastName`, `Login`, `Gender`, `DateOfBirth`) VALUES (8876765765, 'AB', 'Onrea', NULL, 'Jones', 'ojones', 'M', '1983-12-22');
INSERT INTO `mercury`.`Patients` (`OHIPNumber`, `OHIPVersion`, `FirstName`, `MiddleInitials`, `LastName`, `Login`, `Gender`, `DateOfBirth`) VALUES (8754543543, 'QB', 'Henry', NULL, 'Burris', 'hburris', 'M', '1975-06-04');
INSERT INTO `mercury`.`Patients` (`OHIPNumber`, `OHIPVersion`, `FirstName`, `MiddleInitials`, `LastName`, `Login`, `Gender`, `DateOfBirth`) VALUES (8883321321, 'WR', 'Andrew', NULL, 'Fantuz', 'afantuz', 'M', '1983-12-18');
INSERT INTO `mercury`.`Patients` (`OHIPNumber`, `OHIPVersion`, `FirstName`, `MiddleInitials`, `LastName`, `Login`, `Gender`, `DateOfBirth`) VALUES (8123123123, 'CD', 'Rachel', NULL, 'Ray', 'rray', 'F', '1979-10-22');
INSERT INTO `mercury`.`Patients` (`OHIPNumber`, `OHIPVersion`, `FirstName`, `MiddleInitials`, `LastName`, `Login`, `Gender`, `DateOfBirth`) VALUES (8444555666, 'LK', 'Charlotte', NULL, 'Owens', 'cowens', 'F', '1982-04-03');
INSERT INTO `mercury`.`Patients` (`OHIPNumber`, `OHIPVersion`, `FirstName`, `MiddleInitials`, `LastName`, `Login`, `Gender`, `DateOfBirth`) VALUES (8039039039, 'PL', 'Melissa', NULL, 'Black', 'mblack', 'F', '1985-03-01');

COMMIT;

-- -----------------------------------------------------
-- Data for table `mercury`.`Provinces`
-- -----------------------------------------------------
START TRANSACTION;
USE `mercury`;
INSERT INTO `mercury`.`Provinces` (`provinceCode`, `province`) VALUES ('ON', 'Ontario');
INSERT INTO `mercury`.`Provinces` (`provinceCode`, `province`) VALUES ('MB', 'Manitoba');
INSERT INTO `mercury`.`Provinces` (`provinceCode`, `province`) VALUES ('NL', 'Newfoundland');
INSERT INTO `mercury`.`Provinces` (`provinceCode`, `province`) VALUES ('NS', 'Nova Scotia');
INSERT INTO `mercury`.`Provinces` (`provinceCode`, `province`) VALUES ('BC', 'British Columbia');
INSERT INTO `mercury`.`Provinces` (`provinceCode`, `province`) VALUES ('PE', 'Prince Edward Island');
INSERT INTO `mercury`.`Provinces` (`provinceCode`, `province`) VALUES ('QC', 'Quebec');
INSERT INTO `mercury`.`Provinces` (`provinceCode`, `province`) VALUES ('AB', 'Alberta');
INSERT INTO `mercury`.`Provinces` (`provinceCode`, `province`) VALUES ('SK', 'Saskatchewan');
INSERT INTO `mercury`.`Provinces` (`provinceCode`, `province`) VALUES ('NB', 'New Brunswick');
INSERT INTO `mercury`.`Provinces` (`provinceCode`, `province`) VALUES ('YT', 'Yukon Territories');
INSERT INTO `mercury`.`Provinces` (`provinceCode`, `province`) VALUES ('NW', 'Northwest Territories');
INSERT INTO `mercury`.`Provinces` (`provinceCode`, `province`) VALUES ('NU', 'Nunavut');

COMMIT;

-- -----------------------------------------------------
-- Data for table `mercury`.`Addresses`
-- -----------------------------------------------------
START TRANSACTION;
USE `mercury`;
INSERT INTO `mercury`.`Addresses` (`addressId`, `streetLine1`, `streetLine2`, `aptOrUnitNumber`, `city`, `province`, `postalCode`, `type`, `occupant`) VALUES (2, '2 Pancake Lane', 'PO Box 920', NULL, 'Fonthill', 'ON', 'L0S1E0', 'Office', 'hventer');
INSERT INTO `mercury`.`Addresses` (`addressId`, `streetLine1`, `streetLine2`, `aptOrUnitNumber`, `city`, `province`, `postalCode`, `type`, `occupant`) VALUES (1, '346 John St. N.', NULL, '157', 'Arnprior', 'ON', 'K7S2P6', 'Office', 'asserali');
INSERT INTO `mercury`.`Addresses` (`addressId`, `streetLine1`, `streetLine2`, `aptOrUnitNumber`, `city`, `province`, `postalCode`, `type`, `occupant`) VALUES (3, '4190 Finch Ave E', '', '207', 'Scarborough', 'ON', 'M1S4T7', 'Office', 'bachan');
INSERT INTO `mercury`.`Addresses` (`addressId`, `streetLine1`, `streetLine2`, `aptOrUnitNumber`, `city`, `province`, `postalCode`, `type`, `occupant`) VALUES (4, '1 Main St. W.', NULL, NULL, 'Hamilton', 'ON', 'L6G1C7', 'Home', 'hburris');
INSERT INTO `mercury`.`Addresses` (`addressId`, `streetLine1`, `streetLine2`, `aptOrUnitNumber`, `city`, `province`, `postalCode`, `type`, `occupant`) VALUES (5, '2 King St. E.', NULL, NULL, 'Hamilton', 'ON', 'L6C2E5', 'Home', 'ojones');
INSERT INTO `mercury`.`Addresses` (`addressId`, `streetLine1`, `streetLine2`, `aptOrUnitNumber`, `city`, `province`, `postalCode`, `type`, `occupant`) VALUES (6, '3 Cannon St.', NULL, '2', 'Hamilton', 'ON', 'L6Y4E3', 'Home', 'afantuz');
INSERT INTO `mercury`.`Addresses` (`addressId`, `streetLine1`, `streetLine2`, `aptOrUnitNumber`, `city`, `province`, `postalCode`, `type`, `occupant`) VALUES (7, '4 Yonge St.', NULL, '1200', 'Toronto', 'ON', 'M2E3R4', 'Home', 'rray');
INSERT INTO `mercury`.`Addresses` (`addressId`, `streetLine1`, `streetLine2`, `aptOrUnitNumber`, `city`, `province`, `postalCode`, `type`, `occupant`) VALUES (8, '5 Dufferin Ave.', NULL, '4A', 'Toronto', 'ON', 'M5T6Y7', 'Home', 'mblack');
INSERT INTO `mercury`.`Addresses` (`addressId`, `streetLine1`, `streetLine2`, `aptOrUnitNumber`, `city`, `province`, `postalCode`, `type`, `occupant`) VALUES (9, '6 Sheppard Ave. E', NULL, NULL, 'Toronto', 'ON', 'M6Y7J8', 'Home', 'cowens');

COMMIT;

-- -----------------------------------------------------
-- Data for table `mercury`.`Practitioners`
-- -----------------------------------------------------
START TRANSACTION;
USE `mercury`;
INSERT INTO `mercury`.`Practitioners` (`CPSO`, `FirstName`, `MiddleInitials`, `LastName`, `Login`, `PrimaryPracticeAddress`, `PracticeName`) VALUES (89936, 'Asser', 'AA', 'Ali', 'asserali', 1, 'Arnprior Family Health Team');
INSERT INTO `mercury`.`Practitioners` (`CPSO`, `FirstName`, `MiddleInitials`, `LastName`, `Login`, `PrimaryPracticeAddress`, `PracticeName`) VALUES (81852, 'Hendrik', 'L', 'Venter', 'hventer', 2, 'Independent Practice');
INSERT INTO `mercury`.`Practitioners` (`CPSO`, `FirstName`, `MiddleInitials`, `LastName`, `Login`, `PrimaryPracticeAddress`, `PracticeName`) VALUES (99470, 'Brian', 'A', 'Chan', 'bachan', 3, 'Independent Practice');

COMMIT;

-- -----------------------------------------------------
-- Data for table `mercury`.`PhoneNumbers`
-- -----------------------------------------------------
START TRANSACTION;
USE `mercury`;
INSERT INTO `mercury`.`PhoneNumbers` (`PhoneNumber`, `UserName`, `PhoneType`) VALUES (4162983883, 'bachan', 'Office');
INSERT INTO `mercury`.`PhoneNumbers` (`PhoneNumber`, `UserName`, `PhoneType`) VALUES (9058924859, 'hventer', 'Office');
INSERT INTO `mercury`.`PhoneNumbers` (`PhoneNumber`, `UserName`, `PhoneType`) VALUES (9058920394, 'hventer', 'Fax');
INSERT INTO `mercury`.`PhoneNumbers` (`PhoneNumber`, `UserName`, `PhoneType`) VALUES (6136238966, 'asserali', 'Office');
INSERT INTO `mercury`.`PhoneNumbers` (`PhoneNumber`, `UserName`, `PhoneType`) VALUES (6136230143, 'asserali', 'Fax');
INSERT INTO `mercury`.`PhoneNumbers` (`PhoneNumber`, `UserName`, `PhoneType`) VALUES (4165992626, 'cowens', 'Home');
INSERT INTO `mercury`.`PhoneNumbers` (`PhoneNumber`, `UserName`, `PhoneType`) VALUES (4168701245, 'rray', 'Home');
INSERT INTO `mercury`.`PhoneNumbers` (`PhoneNumber`, `UserName`, `PhoneType`) VALUES (4168723336, 'mblack', 'Home');
INSERT INTO `mercury`.`PhoneNumbers` (`PhoneNumber`, `UserName`, `PhoneType`) VALUES (4165996767, 'mblack', 'Work');
INSERT INTO `mercury`.`PhoneNumbers` (`PhoneNumber`, `UserName`, `PhoneType`) VALUES (9055214578, 'hburris', 'Home');
INSERT INTO `mercury`.`PhoneNumbers` (`PhoneNumber`, `UserName`, `PhoneType`) VALUES (9055258761, 'hburris', 'Work');
INSERT INTO `mercury`.`PhoneNumbers` (`PhoneNumber`, `UserName`, `PhoneType`) VALUES (9055228643, 'afantuz', 'Home');
INSERT INTO `mercury`.`PhoneNumbers` (`PhoneNumber`, `UserName`, `PhoneType`) VALUES (9055228899, 'ojones', 'Home');

COMMIT;

-- -----------------------------------------------------
-- Data for table `mercury`.`MenuFunctions`
-- -----------------------------------------------------
START TRANSACTION;
USE `mercury`;
INSERT INTO `mercury`.`MenuFunctions` (`Code`, `FunctionName`, `URL`) VALUES ('VIEW', 'View Upcoming Appointments', NULL);
INSERT INTO `mercury`.`MenuFunctions` (`Code`, `FunctionName`, `URL`) VALUES ('SCHED', 'Schedule an Appointment', NULL);
INSERT INTO `mercury`.`MenuFunctions` (`Code`, `FunctionName`, `URL`) VALUES ('CANCL', 'Cancel an Appointment', NULL);
INSERT INTO `mercury`.`MenuFunctions` (`Code`, `FunctionName`, `URL`) VALUES ('CHKIN', 'Register for Today\'s Appt', NULL);
INSERT INTO `mercury`.`MenuFunctions` (`Code`, `FunctionName`, `URL`) VALUES ('VITAL', 'Monitor Patient Vitals', NULL);
INSERT INTO `mercury`.`MenuFunctions` (`Code`, `FunctionName`, `URL`) VALUES ('DIAGN', 'Diagnose Patient', NULL);
INSERT INTO `mercury`.`MenuFunctions` (`Code`, `FunctionName`, `URL`) VALUES ('PROFL', 'Update User Profile', NULL);
INSERT INTO `mercury`.`MenuFunctions` (`Code`, `FunctionName`, `URL`) VALUES ('HISTR', 'View Patient History', NULL);
INSERT INTO `mercury`.`MenuFunctions` (`Code`, `FunctionName`, `URL`) VALUES ('LOGOF', 'Logout', NULL);
INSERT INTO `mercury`.`MenuFunctions` (`Code`, `FunctionName`, `URL`) VALUES ('LOGON', 'Login', NULL);

COMMIT;
