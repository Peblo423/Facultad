--Informaci�n del domicilio de un empleado entre dos fechas.

DECLARE @fechaDesdeDada DATETIME2 = '2024-09-05';
DECLARE @fechaHastaDada DATETIME2 = '2024-11-04';

SELECT 
Docente.idDomicilio,
Domicilio.ciudad,
Domicilio.calle,
Domicilio.N�mero
FROM Docente FOR SYSTEM_TIME BETWEEN @fechaDesdeDada AND @fechaHastaDada
INNER JOIN Domicilio
ON Domicilio.idDomicilio = Docente.idDomicilio;

SELECT * FROM Domicilio;
SELECT CUIL, idDomicilio, NomyApell, SysStartTime, SysEndTime FROM DOCENTE;


INSERT INTO Domicilio (Ciudad, Calle, N�mero)
VALUES 
('Buenos Aires', 'Avenida Siempre Viva', '742'),
('C�rdoba', 'Calle Falsa', '123'),
('Rosario', 'Boulevard Oro�o', '2156'),
('Mendoza', 'San Mart�n', '4321'),
('Salta', 'Mitre', '987'),
('Neuqu�n', 'Sarmiento', '654'),
('Tucum�n', 'Rivadavia', '1050'),
('Mar del Plata', 'Col�n', '789');