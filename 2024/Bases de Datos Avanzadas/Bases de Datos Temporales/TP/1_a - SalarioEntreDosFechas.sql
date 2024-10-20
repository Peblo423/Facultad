/*a) Información del salario de un docente entre dos fechas.*/
DECLARE @fechaUno DATETIME2 = '2024-01-01';
DECLARE @fechaDos DATETIME2 = '2027-12-31';
DECLARE @cuilDado VARCHAR(11) = '20444444445';

SELECT CUIL, SalarioBruto
FROM Trayectoria
FOR SYSTEM_TIME BETWEEN @fechaUno AND @fechaDos
WHERE CUIL = @cuilDado;

