-- Inserciones iniciales
Select * from Docente;
Select * from Escuela;
INSERT INTO Trayectoria (CUIL, EscuelaNro, Cargo, Suplente_titular, SalarioBruto)
VALUES 
('20444444445', 101, 'Profesor de Matem�ticas', 'T', 50000.00), -- Juan P�rez
('27367654324', 102, 'Profesora de Historia', 'S', 45000.00), -- Mar�a Garc�a
('20333333333', 103, 'Profesor de F�sica', 'S', 48000.00); -- Carlos L�pez

-- Pas� un tiempo y ahora Juan P�rez recibi� un aumento de sueldo, 
-- Mar�a Garc�a adquiri� la titularidad y Carlos L�pez ahora trabaja en la misma escuela que Juan

-- Vamos a actualizar los datos, lo que pasar� es que se crear�n nuevos registros,
-- que pasar�n a la tabla actual y los registros anteriores pasar�n a la tabla hist�rica

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