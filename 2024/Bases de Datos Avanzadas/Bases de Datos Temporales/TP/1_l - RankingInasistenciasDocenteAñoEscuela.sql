-- Ranking de ausencias de docentes por año y escuela.

SELECT 
    YEAR(I.Fecha) AS Año,
    T.EscuelaNro,
    D.CUIL,
    COUNT(I.idInasistencia) AS TotalInasistencias,
    RANK() OVER (PARTITION BY YEAR(I.Fecha), T.EscuelaNro ORDER BY COUNT(I.idInasistencia) DESC) AS RankingInasistencias
FROM 
    Inasistencia I
INNER JOIN 
    Docente D ON I.CUIL = D.CUIL
INNER JOIN 
    Trayectoria T ON D.CUIL = T.CUIL
GROUP BY 
    YEAR(I.Fecha),
    T.EscuelaNro,
    D.CUIL
ORDER BY 
    Año,
    EscuelaNro,
	RankingInasistencias;
