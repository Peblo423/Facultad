CREATE OR REPLACE FUNCTION calcular_recargo(fecha_pago DATE, fecha_vto DATE, importe DECIMAL)
RETURNS DECIMAL AS $$
DECLARE
    dias_retraso INT;
    recargo DECIMAL;
BEGIN
	--para no pasarme de los días del mes de retraso
    dias_retraso := LEAST(fecha_pago - fecha_vto, 15);

	RAISE NOTICE 'La fecha de pago es %', fecha_pago;
	RAISE NOTICE 'La fecha de vto es %', fecha_vto;
	
    IF dias_retraso > 0 THEN
        recargo := dias_retraso * 0.01 * importe;
    ELSE
        recargo := 0;
    END IF;

    RETURN recargo;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION trigger_calcular_recargo()
RETURNS TRIGGER AS $$
BEGIN
	IF NOT EXISTS(select 1 from PAGOCUOTA as P where P.idcuota=NEW.idcuota) THEN
    	NEW.montoRecargo := calcular_recargo(NEW.fechaPago, (SELECT fechaVto FROM Cuota WHERE idCuota = NEW.idCuota), (SELECT importe FROM Cuota WHERE idCuota = NEW.idCuota));
    ELSE 
		RAISE NOTICE 'Esa cuota ya se pagó';
	END IF;
	RETURN NEW;
END;
$$ LANGUAGE plpgsql;

SELECT * FROM pagocuota;
 
call pagar_cuota(24,8,2);
CREATE TRIGGER before_insert_pago_cuota
BEFORE INSERT ON pagocuota
FOR EACH ROW
EXECUTE FUNCTION trigger_calcular_recargo();