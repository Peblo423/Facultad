CREATE OR REPLACE PROCEDURE pagar_cuota(anio INTEGER, mes INTEGER, id_titular INTEGER)
LANGUAGE plpgsql
AS $$
DECLARE
	mes_y_Anio CHAR(5);
	cuotapaga BOOLEAN;
BEGIN
	mes_y_anio := TO_CHAR(mes, 'FM00') || '/' || RIGHT(TO_CHAR(anio, '9999'), 2);
	
	SELECT EXISTS (
            SELECT 1 FROM PAGOCUOTA as P inner join CUOTA as C ON P.idcuota = (select idcuota from CUOTA as C where C.idTitular = id_titular and C.messianio = mes_y_anio)
        ) INTO cuotapaga; 

	IF NOT cuotapaga THEN
		INSERT INTO PAGOCUOTA (fechaPago, idCuota, idTitular)  VALUES
		(CURRENT_DATE,(select idcuota from CUOTA as C where C.idTitular = id_titular and C.messianio = mes_y_anio), id_titular);
	ELSE
		RAISE NOTICE 'La cuota ya se pagó o no existe';
	END IF;
END;
$$;

select idcuota from CUOTA as C where C.idTitular = 1 and C.messianio = '08/24';

select * from cuota;
select * from pagocuota;
delete from pagocuota;

call pagar_cuota(24, 8, 1);