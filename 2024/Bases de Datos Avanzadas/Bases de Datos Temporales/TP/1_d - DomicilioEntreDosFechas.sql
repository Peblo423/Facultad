--Información del domicilio de un empleado entre dos fechas.

DECLARE @fechaDesdeDada DATETIME2 = '2024-09-05';
DECLARE @fechaHastaDada DATETIME2 = '2024-11-04';

SELECT 
Docente.idDomicilio,
Domicilio.ciudad,
Domicilio.calle,
Domicilio.Número
FROM Docente FOR SYSTEM_TIME BETWEEN @fechaDesdeDada AND @fechaHastaDada
INNER JOIN Domicilio
ON Domicilio.idDomicilio = Docente.idDomicilio;

SELECT * FROM Domicilio;
SELECT CUIL, idDomicilio, NomyApell, SysStartTime, SysEndTime FROM DOCENTE;


INSERT INTO Domicilio (Ciudad, Calle, Número)
VALUES 
('Buenos Aires', 'Avenida Siempre Viva', '742'),
('Córdoba', 'Calle Falsa', '123'),
('Rosario', 'Boulevard Oroño', '2156'),
('Mendoza', 'San Martín', '4321'),
('Salta', 'Mitre', '987'),
('Neuquén', 'Sarmiento', '654'),
('Tucumán', 'Rivadavia', '1050'),
('Mar del Plata', 'Colón', '789');