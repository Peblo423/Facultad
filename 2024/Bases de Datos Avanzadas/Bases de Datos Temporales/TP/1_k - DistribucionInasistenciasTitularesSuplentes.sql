-- Porcentaje de distribución de inasistencias por año y titular / suplentes.

SELECT 
    YEAR(I.Fecha) AS Año,
    T.Suplente_titular,
    COUNT(I.idInasistencia) AS TotalInasistencias,
	(
	(COUNT(I.idInasistencia) * 100.0) / --Inasistencias de este T/S
	(
		SELECT COUNT(I2.idInasistencia) --Dividido total de inasistencias (TyS)
		FROM Inasistencia I2 INNER JOIN Trayectoria T2 ON I2.CUIL = T2.CUIL
		WHERE YEAR(I2.Fecha) = YEAR(I.Fecha)
	))AS PorcentajeInasistencias
FROM 
    Inasistencia I
INNER JOIN 
    Trayectoria T ON I.CUIL = T.CUIL
GROUP BY 
    YEAR(I.Fecha),
    T.Suplente_titular
ORDER BY 
    Año, 
    T.Suplente_titular;
