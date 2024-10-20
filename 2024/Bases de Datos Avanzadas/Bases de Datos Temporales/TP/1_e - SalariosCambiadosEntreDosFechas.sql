-- Información de los empleados que cambiaron su salario entre dos fechas
-- Para esta actividad consideramos aquellos salarios nuevos como un cambio, 
-- aunque no hayan tenido un salario anterior
DECLARE @fechaInicial DATETIME2 = '2024-10-16';
DECLARE @fechaFin DATETIME2 = '2025-06-11';

SELECT 
	Docente.CUIL, 
	Docente.NomyApell,
	Docente.FechaNac,
	Docente.TelCelular,
	Trayectoria.SysStartTime, 
	Trayectoria.SysEndTime, 
	SalarioBruto
FROM Trayectoria INNER JOIN Docente ON Docente.CUIL = Trayectoria.CUIL
WHERE
Trayectoria.CUIL = Docente.CUIL
AND (
    (Trayectoria.SysStartTime <= @fechaInicial AND (@fechaInicial < Trayectoria.SysEndTime OR Trayectoria.SysEndTime IS NULL)
        AND NOT (Trayectoria.SysStartTime <= @fechaFin AND (@fechaFin < Trayectoria.SysEndTime OR Trayectoria.SysEndTime IS NULL)))
    OR
    (Trayectoria.SysStartTime <= @fechaFin AND (@fechaFin < Trayectoria.SysEndTime OR Trayectoria.SysEndTime IS NULL)
        AND NOT (Trayectoria.SysStartTime <= @fechaInicial AND (@fechaInicial < Trayectoria.SysEndTime OR Trayectoria.SysEndTime IS NULL)))
);

select * from Docente;
select CUIL, EscuelaNro, Cargo, Suplente_titular, SalarioBruto, SysStartTime, SysEndTime from Trayectoria FOR SYSTEM_TIME ALL;
