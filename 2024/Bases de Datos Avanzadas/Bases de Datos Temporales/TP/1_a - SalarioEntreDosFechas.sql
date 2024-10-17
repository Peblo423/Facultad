/*a) Información **d**el salario de un docente entre dos fechas.*/
--CUIL
--FechaDesde
--FechaHasta



SELECT CUIL, SalarioBrutoTotal
FROM Trayectoria
WHERE CUIL = '20444444445'
AND (
    (Desde <= '2023-12-31' AND (Hasta >= '2023-01-01' OR Hasta IS NULL))
);

--'2023-01-01'
--'2023-12-31'
INSERT INTO Trayectoria (CUIL, EscuelaNro, Desde, Hasta, Cargo, Suplente_titular, SalarioBrutoTotal)
VALUES ('20444444445', 101, '2022-03-01', '2023-02-28', 'Profesor de Matemáticas', 'T', 50000.00),
('20444444445', 102, '2023-03-01', '2024-02-28', 'Profesor de Física', 'S', 52000.00),
('20444444445', 102, '2022-03-01', '2024-02-28', 'Profesor de Física', 'S', 120.00),
('20444444445', 102, '2022-04-01', '2023-02-28', 'Profesor de Física', 'S', 130.00),
('20987654321', 101, '2021-01-01', '2022-12-31', 'Profesor de Historia', 'T', 48000.00),
('20987654321', 103, '2023-01-01', '2023-12-31', 'Profesor de Geografía', 'T', 51000.00),
('20333333333', 104, '2020-01-01', NULL, 'Profesor de Literatura', 'T', 60000.00);

INSERT INTO Docente (CUIL, DNI, NomyApell, Sexo, FechaNac, TelFijo, TelCelular, Mail, idDomicilio)
VALUES ('20444444445', '12345678', 'Juan Pérez', 'M', '1980-04-15', '011-1234-5678', '011-9876-5432', 'juan.perez@example.com', 1),
('27367654324',	'36765432',	'María García', 'F', '1975-08-20', '011-2233-4455', '011-5566-7788', 'maria.garcia@example.com', 2);
('20333333333', '33333333', 'Carlos López', 'M', '1990-12-10', '011-3344-5566', '011-6677-8899', 'carlos.lopez@example.com', 3);

INSERT INTO Escuela (EscuelaNro, Nombre, Direccion)
VALUES (101, 'Escuela Secundaria N° 1', 'Av. Siempreviva 742, Ciudad A'),
(102, 'Escuela Técnica N° 2', 'Calle Falsa 123, Ciudad B'),
(103, 'Colegio Nacional N° 3', 'Boulevard Principal 456, Ciudad C'),
(104, 'Escuela de Artes N° 4', 'Ruta 1 Km 23, Ciudad D');
