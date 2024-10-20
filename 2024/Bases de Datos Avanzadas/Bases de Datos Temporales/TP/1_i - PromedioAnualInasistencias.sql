--Promedio anual de inasistencias (sin considerar licencia por enfermedad, licencia por cuidado de conviviente).
SELECT * FROM Docente;
SELECT * FROM Inasistencia;
SELECT * FROM Justificacion;
--
SELECT 
    CUIL,
    YEAR(Fecha) AS Año,
    COUNT(*) AS Total_Inasistencias,
    (COUNT(*) / 160.0) AS Promedio_Inasistencias
FROM 
    Inasistencia I
INNER JOIN 
	Justificacion J ON I.idJustificacion = J.idJustificacion
WHERE
    J.Descripcion IS NULL OR J.Descripcion NOT IN ('Licencia por enfermedad', 'Licencia por cuidado de conviviente') -- Excluye los tipos de inasistencias no deseados
GROUP BY 
    CUIL, 
    YEAR(Fecha);

