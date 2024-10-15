call pagar_cuota(24,8,1);
call pagar_cuota(24,8,2);
call pagar_cuota(24,8,3);
call pagar_cuota(24,8,4);

select * from pagocuota;
select * from cuota;
select * from socio;
select * from titular;
select * from beca;

INSERT INTO Beca (fechaDesde, fechaHasta, porcentajeCuota, idSocio) Values
('2023-01-01', '2024-12-31', 20.15, 1),
('2024-06-01', '2024-12-31', 30.00, 2),
('2024-01-01', NULL, 12.00, 3),
('2024-03-01', '2024-09-30', 25.50, 4);

select * from historialCuotas;
CREATE OR REPLACE VIEW historialCuotas AS
SELECT 
	dni, 
	nomyapell, 
	fechanac, 
	sexo, 
	estatura, 
	(select count (*) from Adherente as AD where AD.idtitular = S.numsocio) AS cantAdherentes,
	messianio,
	importe, 
	estado.Paga AS estado_paga,
	estado.Estado AS estado_actividad,
	importe_en_palabras(C.importe) AS importeEnPalabras,
	calcular_recargo(CURRENT_DATE, c.fechavto, c.importe) as recargo,
	TRUNC(importe * COALESCE((SELECT porcentajeCuota FROM Beca AS b WHERE b.idSocio = S.numsocio), 0) / 100, 2) AS montoBecado
FROM SOCIO AS S LEFT JOIN TITULAR AS T 
ON S.numsocio = T.idtitular
INNER JOIN CUOTA AS C 
ON C.idtitular = S.numsocio
CROSS JOIN LATERAL estado_cuota(C.idcuota) AS estado
ORDER BY numsocio;

--Como no puedo llamar a un SP dentro de un select tengo que hacer esto
CREATE OR REPLACE FUNCTION importe_en_palabras(importe NUMERIC)
RETURNS TEXT AS $$
DECLARE
    importeEnPalabras TEXT;
BEGIN
    CALL sp_numero_letras(importe, importeEnPalabras);
    RETURN importeEnPalabras;
END;
$$ LANGUAGE plpgsql;


--Para obtener el estado de la cuota
CREATE OR REPLACE FUNCTION estado_cuota(id_cuota INTEGER)
RETURNS TABLE(Paga TEXT, Estado TEXT) AS $$
BEGIN
    RETURN QUERY 
    SELECT 
        CASE 
            WHEN EXISTS (
                SELECT 1
                FROM PagoCuota
                WHERE idCuota = id_cuota
            ) THEN 'Paga'
            ELSE 'Impaga'
        END AS Paga,
        CASE 
            WHEN EXISTS (
                SELECT 1
                FROM PagoCuota
                WHERE idCuota = id_cuota
            ) THEN NULL
            WHEN (
                SELECT fechavto 
                FROM Cuota 
                WHERE idCuota = id_cuota
            ) < CURRENT_DATE THEN 'Vencida'
            ELSE 'Activa'
        END AS Estado;
END;
$$ LANGUAGE plpgsql;

