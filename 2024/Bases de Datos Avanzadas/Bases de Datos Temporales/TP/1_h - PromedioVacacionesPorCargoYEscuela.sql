-- Promedio anual de días de vacaciones tomados por cargo y por escuela.
-- Considerar para el promedio 160 días trabajo.

SELECT 
    T.EscuelaNro,
    T.Cargo,
    YEAR(I.Fecha) AS Año,
    COUNT(I.idInasistencia) AS TotalVacaciones,
    COUNT(DISTINCT I.CUIL) AS TotalDocentes,
    -- Promedio anual de días de vacaciones por cargo y escuela
    CAST((COUNT(I.idInasistencia) * 100.0) / (COUNT(DISTINCT I.CUIL) * 160.0) AS DECIMAL(10,2)) AS PromedioVacaciones
FROM 
    Inasistencia I
INNER JOIN 
    Justificacion J ON I.idJustificacion = J.idJustificacion
INNER JOIN 
    Trayectoria T ON I.CUIL = T.CUIL
WHERE 
    J.Descripcion = 'Vacaciones'
GROUP BY 
    T.EscuelaNro, 
    T.Cargo, 
    YEAR(I.Fecha)
ORDER BY 
    Año, 
    EscuelaNro, 
    Cargo;
