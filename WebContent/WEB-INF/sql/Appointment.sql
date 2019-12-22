-- appointment --

SELECT * FROM appointments ;

SELECT * FROM users WHERE username = 'rray';

SELECT * FROM patients;

SELECT a.Patient, a.reasonforvisit, DATE_FORMAT(a.datetime, "%Y%m%d") date, DATE_FORMAT(a.datetime, "%H:%i:%s") time, a.IsPatientCheckedIn
  FROM USERs u, patients p, appointments a
 WHERE u.username = p.login
   AND p.OHIPNumber = a.patient
   AND u.username = 'rray';



SELECT DATE_FORMAT("2017-06-15", "%H:%i:%s");

SELECT * FROM appointments WHERE patient = 8123123123;

INSERT INTO appointments (Patient, ReasonForVisit, DATETIME, IsPatientCheckedIn) VALUES ('8123123123','headackes','2019-11-27 00:11:26',0);
;

SELECT * FROM appointments;

SELECT   TOP (10) [CUSTOMERID], 
         CONVERT(VARCHAR(20), NOW(), 101) AS DATEPART,
         CONVERT(VARCHAR(20), NOW(), 108) AS TIMEPART
FROM     [TP_CUSTOMERTRIPS] 
GROUP BY [CUSTOMERID],[ENTRYTRIPDATETIME] 
HAVING   COUNT(*) > 2;
