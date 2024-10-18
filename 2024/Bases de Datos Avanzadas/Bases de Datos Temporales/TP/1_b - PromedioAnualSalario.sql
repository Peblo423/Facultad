--Promedio anual del salario de un docente (sumatoria de sus salarios mensuales / 12)
CREATE FUNCTION PromedioAnual(@CUIL VARCHAR(11), @AÑO INT)
RETURNS TABLE 
AS
RETURN
(
    WITH Salarios AS (
        SELECT 
            CUIL,
            SalarioBruto,
            CASE 
                -- Si todo el registro existe dentro del año @AÑO
                WHEN YEAR(SysStartTime) = @AÑO AND YEAR(SysEndTime) = @AÑO THEN DATEDIFF(MONTH, SysStartTime, SysEndTime)
                -- Si el registro empieza en el año @AÑO pero termina después
                WHEN YEAR(SysStartTime) = @AÑO AND YEAR(SysEndTime) > @AÑO THEN DATEDIFF(MONTH, SysStartTime, '12-31-' + CAST(@AÑO AS VARCHAR)) + 1
                -- Si el registro empieza antes del año @AÑO pero termina en @AÑO
                WHEN YEAR(SysStartTime) < @AÑO AND YEAR(SysEndTime) = @AÑO THEN DATEDIFF(MONTH, '01-01-' + CAST(@AÑO AS VARCHAR), SysEndTime) + 1
                -- Si el registro no pertenece al año @AÑO
                WHEN YEAR(SysEndTime) < @AÑO OR YEAR(SysStartTime) > @AÑO THEN 0
                -- Si el registro cubre todo el año
                ELSE 12
            END AS MesesTrabajados
        FROM Trayectoria
        FOR SYSTEM_TIME ALL
        WHERE CUIL = @CUIL
    )
    SELECT 
        CUIL,
        @AÑO AS Año,
        SUM(SalarioBruto * MesesTrabajados) / 12.0 AS PromedioAnual
    FROM Salarios
    GROUP BY CUIL
);

drop function PromedioAnual;
SELECT * 
FROM PromedioAnual('20444444445', 2022);

select * from Trayectoria;