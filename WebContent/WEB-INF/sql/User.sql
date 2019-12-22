-- login page --

SELECT COUNT(*) cnt FROM users WHERE username = 'rray' AND PASSWORD = 'passwordfsdf';

SELECT * FROM patients WHERE login = 'rray';

SELECT * FROM users;

SELECT * FROM patients;

SELECT * FROM practitioners;

SELECT IFNULL(null, "W3Schools.com");

SELECT * FROM patients WHERE login= 'rray';

SELECT a.username, a.role, b.FirstName, b.lastname
  FROM users a, patients b
 WHERE a.username = b.login
   AND a.username = 'rray' ;

SELECT * FROM patients;

INSERT INTO patients (OHIPNumber, OHIPVersion, FirstName, MiddleInitials, LastName, Login, Gender, DateOfBirth) 
VALUES (8039039039, 'PL', 'Melissa', NULL, 'Black', 'mblack', 'F', '1985-03-01');

SELECT * FROM users;

INSERT INTO users (username, role, PASSWORD, dateoflastlogin) VALUES (?,?,?,?);

UPDATE patients SET OHIPVersion = ?, FirstName = ?, LastName = ? WHERE OHIPNumber = ?;

SELECT * FROM users;

UPDATE users SET PASSWORD = ? WHERE username = ?;

SELECT * FROM phonenumbers;

UPDATE phonenumbers SET phonenumber = ? WHERE username = ?;

SELECT u.username, u.password, p.OHIPNumber, p.OHIPVersion, p.FirstName, p.LastName, p.Gender, p.DateOfBirth 
  FROM users u, patients p
 WHERE u.username = p.Login
   AND u.username = 'rray';
   
SELECT * FROM phonenumbers	 
	 WHERE username = 'rray';
	 
SELECT * FROM visit;
  
INSERT INTO visit VALUES (physician, datetimeofvisit, bloodpressuresystolic, temperature, bloodpressurediastolic, isvisitcomplete, medicaldiagnosis, physiciannotes, appointment)
  VALUES (81852, '2019-11-30', );
  
SELECT * FROM phonenumbers;

INSERT INTO phonenumbers (phonenumber, username, phonetype) VALUES (?,?,?);

SELECT distinct ohipversion FROM patients;

SELECT COUNT(*) cnt FROM users WHERE username = '';
	 
SELECT * FROM phonenumbers WHERE username = 'rray';
	 
UPDATE phonenumbers SET phonenumber = ''  WHERE username = 'rray' AND phoneType = 'Home';

   


