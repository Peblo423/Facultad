-- Promedio anual de d�as de vacaciones tomados por cargo y por escuela.
-- Considerar para el promedio 160 d�as trabajo.

WITH VacacionesPorA�oPorDocente AS (
    SELECT 
        YEAR(I.Fecha) AS A�o,
        D.CUIL,
        T.Cargo,
        T.EscuelaNro,
        COUNT(I.idInasistencia) AS D�asDeVacaciones
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
VacacionesPorA�oPorCargoPorEscuelaPeroNoPorDocente AS (
    SELECT 
        A�o,
        Cargo,
        EscuelaNro,
        SUM(D�asDeVacaciones) AS TotalVacaciones,
        COUNT(DISTINCT CUIL) AS TotalDocentes
    FROM 
        VacacionesPorA�oPorDocente
    GROUP BY 
        A�o,
        Cargo,
        EscuelaNro
)
SELECT 
    A�o,
    Cargo,
    EscuelaNro,
    CASE 
        WHEN TotalDocentes > 0 THEN CAST(TotalVacaciones AS FLOAT) * 100 / (TotalDocentes * 160)
        ELSE 0 
    END AS PromedioVacacionesPorCargoEscuela
FROM 
    VacacionesPorA�oPorCargoPorEscuelaPeroNoPorDocente
ORDER BY 
    A�o,
    Cargo,
    EscuelaNro;
