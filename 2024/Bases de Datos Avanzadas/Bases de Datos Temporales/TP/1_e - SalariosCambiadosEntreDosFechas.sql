--Información de los empleados que cambiaron su salario entre dos fechas

DECLARE @fechaInicial DATETIME2 = '2024-10-16';
DECLARE @fechaFin DATETIME2 = '2025-06-11';
DECLARE @cuil DATETIME2 = '20444444445';

SELECT Docente.CUIL, Docente.NomyApell, Trayectoria.SysStartTime, Trayectoria.SysEndTime, SalarioBrutoTotal
FROM Trayectoria INNER JOIN Docente ON Docente.CUIL = Trayectoria.CUIL
WHERE
Trayectoria.CUIL = @cuil
AND (
    (Trayectoria.SysStartTime <= @fechaInicial AND (@fechaInicial < Trayectoria.SysEndTime OR Trayectoria.SysEndTime IS NULL)
        AND NOT (Trayectoria.SysStartTime <= @fechaFin AND (@fechaFin < Trayectoria.SysEndTime OR Trayectoria.SysEndTime IS NULL)))
    OR
    (Trayectoria.SysStartTime <= @fechaFin AND (@fechaFin < Trayectoria.SysEndTime OR Trayectoria.SysEndTime IS NULL)
        AND NOT (Trayectoria.SysStartTime <= @fechaInicial AND (@fechaInicial < Trayectoria.SysEndTime OR Trayectoria.SysEndTime IS NULL)))
);

select * from Docente;
select * from Trayectoria;
select * from Trayectoria FOR SYSTEM_TIME ALL;
delete from Trayectoria where Trayectoria.idTrayectoria>7;
INSERT INTO Trayectoria (CUIL, EscuelaNro, Cargo, Suplente_titular, SalarioBrutoTotal)
VALUES ('20444444445', 101, 'Profesor de Matemáticas', 'T', 50000.00),
('20444444445', 102, 'Profesor de Física', 'S', 15000.00),
('20444444445', 102, 'Profesor de Quimioterapia', 'S', 110000.00),
('20987654321', 101, 'Profesor de Historia del LoL', 'T', 4000.00),
('20987654321', 103, 'Profesor de Grafos', 'T', 59099.00),
('20333333333', 104, 'Profesor de Recreo', 'T', 999999.00);