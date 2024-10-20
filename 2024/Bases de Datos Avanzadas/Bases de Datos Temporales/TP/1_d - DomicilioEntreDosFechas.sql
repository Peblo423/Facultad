--Información del domicilio de un empleado entre dos fechas.

DECLARE @fechaDesdeDada DATETIME2 = '2024-09-05';
DECLARE @fechaHastaDada DATETIME2 = '2024-11-04';

SELECT 
	Docente.idDomicilio,
	Docente.CUIL,
	Domicilio.ciudad,
	Domicilio.calle,
	Domicilio.Número
FROM Docente FOR SYSTEM_TIME BETWEEN @fechaDesdeDada AND @fechaHastaDada
INNER JOIN Domicilio
ON Domicilio.idDomicilio = Docente.idDomicilio;

SELECT * FROM Domicilio;
SELECT CUIL, idDomicilio, NomyApell, SysStartTime, SysEndTime FROM DOCENTE;

SELECT * FROM Docente;