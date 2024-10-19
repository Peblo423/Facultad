/*a) Información **d**el salario de un docente entre dos fechas.*/
DECLARE @fechaUno DATETIME2 = '2023-01-01';
DECLARE @fechaDos DATETIME2 = '2023-12-31';
DECLARE @cuilDado VARCHAR(11) = '20444444445';

SELECT CUIL, SalarioBruto
FROM Trayectoria
FOR SYSTEM_TIME BETWEEN @fechaUno AND @fechaDos
WHERE CUIL = @cuilDado;

INSERT INTO Trayectoria (CUIL, EscuelaNro, Cargo, Suplente_titular, SalarioBruto) VALUES
('20444444445', 102, 'Profesora de Quimioterapia', 'T', 110000.00),
('27367654324', 101, 'Profesor de Historia del LoL', 'S', 4000.00),
('20333333333', 104, 'Profesora de Recreo', 'T', 999999.00);

INSERT INTO Docente (CUIL, DNI, NomyApell, Sexo, FechaNac, TelFijo, TelCelular, Mail, idDomicilio)
VALUES ('20444444445', '12345678', 'Juan Pérez', 'M', '1980-04-15', '011-1234-5678', '011-9876-5432', 'juan.perez@example.com', 1),
('27367654324',	'36765432',	'María García', 'F', '1975-08-20', '011-2233-4455', '011-5566-7788', 'maria.garcia@example.com', 2),
('20333333333', '33333333', 'Carlos López', 'M', '1990-12-10', '011-3344-5566', '011-6677-8899', 'carlos.lopez@example.com', 3);

INSERT INTO Escuela (EscuelaNro, Nombre, Direccion)
VALUES (101, 'Escuela Secundaria N° 1', 'Av. Siempreviva 742, Ciudad A'),
(102, 'Escuela Técnica N° 2', 'Calle Falsa 123, Ciudad B'),
(103, 'Colegio Nacional N° 3', 'Boulevard Principal 456, Ciudad C'),
(104, 'Escuela de Artes N° 4', 'Ruta 1 Km 23, Ciudad D');
