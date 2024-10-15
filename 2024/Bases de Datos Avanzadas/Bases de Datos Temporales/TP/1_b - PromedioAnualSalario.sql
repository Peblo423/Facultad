--Promedio anual del salario de un docente (sumatoria de sus salarios mensuales / 12)
CREATE FUNCTION PromedioAnual(@CUIL VARCHAR(11), @AÑO INT)
RETURNS TABLE 
AS
RETURN
(
    WITH Salarios AS (
        SELECT 
            CUIL,
            SalarioBrutoTotal,
            CASE 
                WHEN YEAR(Desde) = @AÑO AND YEAR(Hasta) = @AÑO THEN DATEDIFF(MONTH, Desde, Hasta)
                WHEN YEAR(Desde) = @AÑO AND YEAR(Hasta) > @AÑO THEN DATEDIFF(MONTH, Desde, DATEFROMPARTS(@AÑO, 12, 31)) + 1
                WHEN YEAR(Desde) < @AÑO AND YEAR(Hasta) = @AÑO THEN DATEDIFF(MONTH, DATEFROMPARTS(@AÑO, 1, 1), Hasta) + 1
                WHEN YEAR(Hasta) < @AÑO OR YEAR(Desde) > @AÑO THEN 0
                ELSE 12
            END AS MesesTrabajados
        FROM Trayectoria
        WHERE CUIL = @CUIL
    )
    SELECT 
        CUIL,
		@AÑO AS Año,
        SUM(SalarioBrutoTotal * MesesTrabajados) / 12.0 AS PromedioAnual
    FROM Salarios
	GROUP BY CUIL
);

drop function PromedioAnual;
SELECT * 
FROM PromedioAnual('20444444445', 2022);

select * from Trayectoria;