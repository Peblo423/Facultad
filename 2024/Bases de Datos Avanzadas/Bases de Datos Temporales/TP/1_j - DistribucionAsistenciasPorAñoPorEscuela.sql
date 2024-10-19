-- Porcentaje de distribución de asistencia, inasistencia por año y escuela.

SELECT 
	YEAR(I.Fecha) AS Año,
	T.EscuelaNro,
	COUNT(I.idInasistencia) AS TotalInasistencia,
	CAST((COUNT(I.idInasistencia) * 100.0 / (COUNT(DISTINCT I.Cuil) * 160.0)) AS DECIMAL(10,2)) AS porcentajeInasistencias,
	(100.0 - (CAST((COUNT(I.idInasistencia) * 100.0 / (COUNT(DISTINCT I.Cuil) * 160.0)) AS DECIMAL(10,2)))) AS porcentajeAsistencias
FROM Trayectoria T INNER JOIN Inasistencia I
ON T.CUIL = I.CUIL
GROUP BY 
	YEAR(I.Fecha),
	T.EscuelaNro
ORDER BY
	YEAR(I.Fecha),
	T.EscuelaNro;

