--Promedio anual del salario de un docente (sumatoria de sus salarios mensuales / 12)
CREATE FUNCTION PromedioAnual(@CUIL VARCHAR(11), @A�O INT)
RETURNS TABLE 
AS
RETURN
(
    WITH Salarios AS (
        SELECT 
            CUIL,
            SalarioBrutoTotal,
            CASE 
                WHEN YEAR(Desde) = @A�O AND YEAR(Hasta) = @A�O THEN DATEDIFF(MONTH, Desde, Hasta)
                WHEN YEAR(Desde) = @A�O AND YEAR(Hasta) > @A�O THEN DATEDIFF(MONTH, Desde, DATEFROMPARTS(@A�O, 12, 31)) + 1
                WHEN YEAR(Desde) < @A�O AND YEAR(Hasta) = @A�O THEN DATEDIFF(MONTH, DATEFROMPARTS(@A�O, 1, 1), Hasta) + 1
                WHEN YEAR(Hasta) < @A�O OR YEAR(Desde) > @A�O THEN 0
                ELSE 12
            END AS MesesTrabajados
        FROM Trayectoria
        WHERE CUIL = @CUIL
    )
    SELECT 
        CUIL,
		@A�O AS A�o,
        SUM(SalarioBrutoTotal * MesesTrabajados) / 12.0 AS PromedioAnual
    FROM Salarios
	GROUP BY CUIL
);

drop function PromedioAnual;
SELECT * 
FROM PromedioAnual('20444444445', 2022);

select * from Trayectoria;