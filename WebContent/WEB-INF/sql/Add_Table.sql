CREATE TABLE Medication (
   MedicationName VARCHAR(45) NOT NULL,
   PRIMARY KEY (MedicationName)
);

SELECT * FROM medication;

INSERT INTO Medication (MedicationName) VALUES ('Smedicationeptra');
INSERT INTO Medication (MedicationName) VALUES ('Clindamyacin');

ALTER TABLE prescription ADD FOREIGN KEY (medicationName) REFERENCES medication(medicationName);

CREATE TABLE Orders (
   times VARCHAR(20) NOT NULL
);

INSERT INTO Orders (times) VALUES ('three times a day');
INSERT INTO Orders (times) VALUES ('once at night');

CREATE TABLE TestName (
   tName VARCHAR(20) NOT NULL,
   PRIMARY KEY (tName)
);

CREATE TABLE TestType (
   tType VARCHAR(20) NOT NULL,
   PRIMARY KEY (tType)
);

CREATE TABLE KeyIndicators (
   Indicators VARCHAR(20) NOT NULL,
   PRIMARY KEY (Indicators)
);

ALTER TABLE medicaltest ADD FOREIGN KEY (TestName) REFERENCES TestName(tName);
ALTER TABLE medicaltest ADD FOREIGN KEY (TestType) REFERENCES TestType(tType);
ALTER TABLE medicaltest ADD FOREIGN KEY (KeyIndicators) REFERENCES KeyIndicators(Indicators);
INSERT INTO TestName (tName) VALUES ('uric acid levels');
INSERT INTO TestName (tName) VALUES ('cholesterol');
INSERT INTO TestName (tName) VALUES ('blood cell count');
INSERT INTO TestName (tName) VALUES ('glucose');
INSERT INTO TestType (tType) VALUES ('blood work');
INSERT INTO TestType (tType) VALUES ('X-ray');
INSERT INTO TestType (tType) VALUES ('ultrasound');
INSERT INTO KeyIndicators (Indicators) VALUES ('ankle');
INSERT INTO KeyIndicators (Indicators) VALUES ('abdomen');
INSERT INTO KeyIndicators (Indicators) VALUES ('proteins');
INSERT INTO KeyIndicators (Indicators) VALUES ('glucose');