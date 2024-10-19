-- Información de días de asistencia de un empleado entre dos fechas
-- Declaraciones
DECLARE @cuilDado VARCHAR(11);
DECLARE @fechaInicial DATE;
DECLARE @fechaFinal DATE;
DECLARE @diasTotal INT;
DECLARE @diasInasistencia INT;
DECLARE @diasAsistencia INT;

-- Inicializaciones
SET @cuilDado = '20444444445'; 
SET @fechaInicial = '2024-10-01';
SET @fechaFinal = '2024-11-30'; 

-- Inicializaciones de valores para obtener resultado
SET @diasTotal = DATEDIFF(DAY, @fechaInicial, @fechaFinal) + 1;

SET @diasInasistencia = (
	SELECT 
        COUNT(*) AS TotalInasistencias
    FROM 
        Inasistencia
    WHERE 
        CUIL = @cuilDado
        AND Fecha BETWEEN @fechaInicial AND @fechaFinal
);

-- Resta para obtener resultado
SET @diasAsistencia = @diasTotal - @diasInasistencia;

SELECT @diasAsistencia;
