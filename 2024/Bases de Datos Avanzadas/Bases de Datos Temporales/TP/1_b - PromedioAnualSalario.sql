--Promedio anual del salario de un docente (sumatoria de sus salarios mensuales / 12)
CREATE FUNCTION PromedioAnual(@CUIL VARCHAR(11), @A�O INT)
RETURNS TABLE 
AS
RETURN
(
    WITH Salarios AS (
        SELECT 
            CUIL,
            SalarioBruto,
            CASE 
                -- Si todo el registro existe dentro del a�o @A�O
                WHEN YEAR(SysStartTime) = @A�O AND YEAR(SysEndTime) = @A�O THEN DATEDIFF(MONTH, SysStartTime, SysEndTime)
                -- Si el registro empieza en el a�o @A�O pero termina despu�s
                WHEN YEAR(SysStartTime) = @A�O AND YEAR(SysEndTime) > @A�O THEN DATEDIFF(MONTH, SysStartTime, '12-31-' + CAST(@A�O AS VARCHAR)) + 1
                -- Si el registro empieza antes del a�o @A�O pero termina en @A�O
                WHEN YEAR(SysStartTime) < @A�O AND YEAR(SysEndTime) = @A�O THEN DATEDIFF(MONTH, '01-01-' + CAST(@A�O AS VARCHAR), SysEndTime) + 1
                -- Si el registro no pertenece al a�o @A�O
                WHEN YEAR(SysEndTime) < @A�O OR YEAR(SysStartTime) > @A�O THEN 0
                -- Si el registro cubre todo el a�o
                ELSE 12
            END AS MesesTrabajados
        FROM Trayectoria
        FOR SYSTEM_TIME ALL
        WHERE CUIL = @CUIL
    )
    SELECT 
        CUIL,
        @A�O AS A�o,
        SUM(SalarioBruto * MesesTrabajados) / 12.0 AS PromedioAnual
    FROM Salarios
    GROUP BY CUIL
);

drop function PromedioAnual;
SELECT * 
FROM PromedioAnual('20444444445', 2022);

select * from Trayectoria;