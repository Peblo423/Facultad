-- Promedio anual de días de vacaciones tomados por cargo y por escuela.
-- Considerar para el promedio 160 días trabajo.

WITH VacacionesPorAñoPorDocente AS (
    SELECT 
        YEAR(I.Fecha) AS Año,
        D.CUIL,
        T.Cargo,
        T.EscuelaNro,
        COUNT(I.idInasistencia) AS DíasDeVacaciones
    FROM 
        Inasistencia I
    INNER JOIN 
        Justificacion J ON I.idJustificacion = J.idJustificacion
    INNER JOIN 
        Docente D ON I.CUIL = D.CUIL
    INNER JOIN 
        Trayectoria T ON D.CUIL = T.CUIL
    WHERE 
        J.Descripcion = 'Vacaciones'
    GROUP BY 
        YEAR(I.Fecha),
        D.CUIL,
        T.Cargo,
        T.EscuelaNro
),
VacacionesPorAñoPorCargoPorEscuelaPeroNoPorDocente AS (
    SELECT 
        Año,
        Cargo,
        EscuelaNro,
        SUM(DíasDeVacaciones) AS TotalVacaciones,
        COUNT(DISTINCT CUIL) AS TotalDocentes
    FROM 
        VacacionesPorAñoPorDocente
    GROUP BY 
        Año,
        Cargo,
        EscuelaNro
)
SELECT 
    Año,
    Cargo,
    EscuelaNro,
    CASE 
        WHEN TotalDocentes > 0 THEN CAST(TotalVacaciones AS FLOAT) * 100 / (TotalDocentes * 160)
        ELSE 0 
    END AS PromedioVacacionesPorCargoEscuela
FROM 
    VacacionesPorAñoPorCargoPorEscuelaPeroNoPorDocente
ORDER BY 
    Año,
    Cargo,
    EscuelaNro;
