--Porcentaje de aumento de salario entre dos fechas
--Declaraciones
DECLARE @cuilDado VARCHAR(11);
DECLARE @fechaInicialDada DATETIME2;
DECLARE @fechaFinalDada DATETIME2;

--Inicializaciones
SET @cuilDado = '20444444445';
SET @fechaInicialDada = '2024-06-02';
SET @fechaFinalDada = '2024-11-20';

--Obtener Salario total de la fecha Desde
DECLARE @salarioInicial DECIMAL(10,2) = (
    SELECT
        SUM(SalarioBruto)
    FROM 
        Trayectoria
    FOR SYSTEM_TIME ALL
    WHERE 
        CUIL = @cuilDado
        AND @fechaInicialDada BETWEEN SysStartTime AND SysEndTime
    GROUP BY CUIL
);
SELECT @salarioInicial as SalarioInicial;

-- Obtener Salario total de la fecha Hasta
DECLARE @salarioFinal DECIMAL(10,2) = (
    SELECT
        SUM(SalarioBruto)
    FROM 
        Trayectoria
    FOR SYSTEM_TIME ALL
    WHERE 
        CUIL = @cuilDado
        AND @fechaFinalDada BETWEEN SysStartTime AND SysEndTime
    GROUP BY CUIL
);
SELECT @salarioFinal as SalarioFinal;

--Calcular porcentaje de aumento
SELECT CAST(ROUND((((COALESCE(@salarioFinal, 0) - COALESCE(@salarioInicial, 0)) * 100) / @salarioInicial), 2, 1) AS DECIMAL(10, 2)) AS PorcentajeAumento;

--select * from Escuela;
--delete from trayectoria;
