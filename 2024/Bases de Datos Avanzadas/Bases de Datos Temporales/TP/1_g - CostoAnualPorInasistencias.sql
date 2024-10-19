-- Información de costo asociado por inasistencias en general por año.
-- Considerar 30 días por mes para calcular el sueldo diario de cada docente

WITH InasistenciasMensuales AS (
    SELECT 
        YEAR(I.Fecha) AS Año,
        I.CUIL,
        COUNT(I.idInasistencia) AS InasistenciasEnMes
    FROM 
        Inasistencia I
    WHERE 
        I.Fecha BETWEEN '2022-01-01' AND '2024-12-31'
    GROUP BY 
        YEAR(I.Fecha),
        I.CUIL
),
SalarioMensual AS (
    SELECT 
        T.CUIL,
        SUM(T.SalarioBruto) AS SalarioBrutoTotal
    FROM 
        Trayectoria T
    WHERE 
        T.SysStartTime <= '2024-12-31' AND T.SysEndTime >= '2022-01-01'
    GROUP BY 
        T.CUIL
)
SELECT 
    IM.Año,
    IM.CUIL,
    SUM((SM.SalarioBrutoTotal / 30) * IM.InasistenciasEnMes) AS CostoAnualAsociado
FROM 
    InasistenciasMensuales IM
INNER JOIN 
    SalarioMensual SM ON SM.CUIL = IM.CUIL
GROUP BY 
    IM.Año,
    IM.CUIL
ORDER BY 
    IM.Año,
    IM.CUIL;
