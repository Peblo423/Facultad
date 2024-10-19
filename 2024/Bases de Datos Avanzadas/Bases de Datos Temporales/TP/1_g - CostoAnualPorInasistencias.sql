-- Informaci�n de costo asociado por inasistencias en general por a�o.
-- Considerar 30 d�as por mes para calcular el sueldo diario de cada docente

WITH InasistenciasMensuales AS (
    SELECT 
        YEAR(I.Fecha) AS A�o,
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
    IM.A�o,
    IM.CUIL,
    SUM((SM.SalarioBrutoTotal / 30) * IM.InasistenciasEnMes) AS CostoAnualAsociado
FROM 
    InasistenciasMensuales IM
INNER JOIN 
    SalarioMensual SM ON SM.CUIL = IM.CUIL
GROUP BY 
    IM.A�o,
    IM.CUIL
ORDER BY 
    IM.A�o,
    IM.CUIL;
