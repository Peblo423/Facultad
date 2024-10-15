CREATE OR REPLACE PROCEDURE mes_a_facturar(anio INTEGER, mes INTEGER)
LANGUAGE plpgsql
AS $$
DECLARE
    messiAnioAInsertar CHAR(5);
    fechaVTO CHAR(8);
    idTitularAux INTEGER;
    mesActual INTEGER;
    anioActual INTEGER;
    filas_insertadas INTEGER;
	existeCuota BOOLEAN;

BEGIN
    filas_insertadas := 0;
    mesActual := EXTRACT(MONTH FROM NOW());
    anioActual := EXTRACT(YEAR FROM NOW()) % 100;

    RAISE NOTICE 'Año actual: %', anioActual;
    RAISE NOTICE 'Mes actual: %', mesActual;

	-- Construir las cadenas para el mes y año
        messiAnioAInsertar := TO_CHAR(mes, 'FM00') || '/' || RIGHT(TO_CHAR(anio, '9999'), 2);
        fechaVTO := '15/' || messiAnioAInsertar;
	
	-- Comprobar si el mes ya ha sido facturado
        SELECT EXISTS (
            SELECT 1 FROM CUOTA WHERE messiAnio = messiAnioAInsertar
        ) INTO existeCuota;

    IF ((mes = 1 AND mesActual = 12 AND anio = anioActual + 1) OR
       (mes > mesActual AND anio = anioActual)) AND NOT existeCuota THEN  

        DROP TABLE IF EXISTS TitularesTemp;

        -- Crear tabla temporal
        CREATE TEMPORARY TABLE TitularesTemp (
            idTitularTemp INTEGER PRIMARY KEY
        );

        -- Insertar los idTitular activos en la tabla temporal
        INSERT INTO TitularesTemp (idTitularTemp)
        SELECT idTitular FROM Titular AS T INNER JOIN Socio AS S 
		ON T.idTitular = S.numsocio and S.estado = 'Activo'
		ORDER BY idTitular;

        -- Loop para procesar cada titular
        WHILE EXISTS (SELECT 1 FROM TitularesTemp) LOOP
            -- Obtener el primer idTitularTemp
            SELECT idTitularTemp INTO idTitularAux 
            FROM TitularesTemp 
            LIMIT 1;

            -- Insertar la cuota correspondiente
            INSERT INTO CUOTA (fechaVto, messiAnio, importe, idTitular)
            VALUES (TO_DATE(fechaVTO, 'DD/MM/YY'), messiAnioAInsertar, (
                SELECT ((COUNT(*) * (SELECT Precio FROM PRECIOCUOTA WHERE TipoSocio = 'A')) + 
                    (SELECT Precio FROM PRECIOCUOTA WHERE TipoSocio = 'T'))
                FROM Titular T
                INNER JOIN Adherente A ON T.idTitular = A.idTitular
                WHERE T.idTitular = idTitularAux
            ), idTitularAux);

            -- Acumular filas insertadas
            filas_insertadas := filas_insertadas + 1;

            -- Borrar el titular procesado
            DELETE FROM TitularesTemp
            WHERE idTitularTemp = idTitularAux;
        END LOOP;

        RAISE NOTICE 'Cantidad de filas insertadas: %', filas_insertadas;

    ELSE
		IF existeCuota THEN
			RAISE NOTICE 'Mes ya facturado';
		ELSE
        	RAISE NOTICE 'Mes o año no válido: %/%', mes, anio;
		END IF;
    END IF;

EXCEPTION
    WHEN OTHERS THEN
        RAISE NOTICE 'Ocurrió un error: %', SQLERRM;
END;
$$;
delete from CUOTA;
call mes_a_facturar(28,9);
select * from CUOTA;
