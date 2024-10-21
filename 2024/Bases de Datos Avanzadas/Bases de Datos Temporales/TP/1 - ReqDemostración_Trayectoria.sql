-- Inserciones iniciales
Select * from Docente;
Select * from Escuela;
INSERT INTO Trayectoria (CUIL, EscuelaNro, Cargo, Suplente_titular, SalarioBruto)
VALUES 
('20444444445', 101, 'Profesor de Matemáticas', 'T', 50000.00), -- Juan Pérez
('27367654324', 102, 'Profesora de Historia', 'S', 45000.00), -- María García
('20333333333', 103, 'Profesor de Física', 'S', 48000.00); -- Carlos López

-- Pasó un tiempo y ahora Juan Pérez recibió un aumento de sueldo, 
-- María García adquirió la titularidad y Carlos López ahora trabaja en la misma escuela que Juan

-- Vamos a actualizar los datos, lo que pasará es que se crearán nuevos registros,
-- que pasarán a la tabla actual y los registros anteriores pasarán a la tabla histórica

UPDATE Trayectoria
SET SalarioBruto = 85000.00
WHERE CUIL = '20444444445' 
  AND EscuelaNro = 101 
  AND Suplente_titular = 'T';

UPDATE Trayectoria
SET Suplente_titular = 'T',
    SalarioBruto = 55000.00
WHERE CUIL = '27367654324'
  AND EscuelaNro = 102
  AND Suplente_titular = 'S';

UPDATE Trayectoria
SET EscuelaNro = 101
WHERE CUIL = '20333333333'
  AND EscuelaNro = 103;


select CUIL, EscuelaNro, Cargo, Suplente_titular, SalarioBruto, SysStartTime, SysEndTime from Trayectoria;

SELECT *
FROM TemporalHistory.Trayectoria_History;