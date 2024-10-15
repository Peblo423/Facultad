
INSERT INTO Empleado (cuil, nomYApell, fechaIngreso, cargo, cuiljefe) VALUES 
(20334567895, 'Juan Perez', '2020-01-15', 'Entrenador de Fútbol', 23406789014),
(23406789014, 'Ana Gomez', '2021-03-20', 'Coordinador de Eventos', 27390123455),
(24367890129, 'Carlos Lopez', '2019-11-05', 'Analista de Marketing', 23406789014),
(25378901237, 'Marta Diaz', '2022-07-11', 'Coordinador', 27390123455),
(26389012345, 'Pedro Sanchez', '2020-10-23', 'Gerente Deportivo', 25378901237),
(27390123455, 'Laura Rodriguez', '2020-05-10', 'Gerente General', NULL);

select * from empleado;

//-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-


CREATE OR REPLACE FUNCTION ObtenerSubordinados(cuilIngresado BIGINT)
RETURNS TABLE (EmpleadoID BIGINT, Nombre VARCHAR(100), EmpleadoSuperiorID BIGINT) AS $$
BEGIN
    -- CTE recursivo para obtener todos los subordinados
    RETURN QUERY
    WITH RECURSIVE EmpleadosCTE AS (
        -- Anchor member: Empleados que reportan directamente al empleado dado
        SELECT 
            cuil AS EmpleadoID, 
            nomYApell AS Nombre, 
            cuilJefe AS EmpleadoSuperiorID
        FROM 
            Empleado
        WHERE 
            cuilJefe = cuilIngresado

        UNION ALL

        -- Recursive member: Empleados que reportan a los empleados seleccionados anteriormente
        SELECT 
            e.cuil AS EmpleadoID, 
            e.nomYApell AS Nombre, 
            e.cuilJefe AS EmpleadoSuperiorID
        FROM 
            Empleado e
        INNER JOIN 
            EmpleadosCTE ecte ON e.cuilJefe = ecte.EmpleadoID
    )
    SELECT * FROM EmpleadosCTE;
END;
$$ LANGUAGE plpgsql;


select * from ObtenerSubordinados(27390123455);
