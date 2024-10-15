ALTER TABLE Titular ADD COLUMN saldoDeudor DECIMAL(10, 2) DEFAULT 0;


CREATE TRIGGER trigger_sumar_saldo_deudor
AFTER INSERT ON Cuota
FOR EACH ROW
EXECUTE FUNCTION suma_saldo_deudor();


CREATE OR REPLACE FUNCTION suma_saldo_deudor()
RETURNS TRIGGER AS
$$
BEGIN
	IF (select estado from socio as s inner join titular as t on s.numsocio = t.idtitular and t.idtitular = new.idtitular) = 'Activo' THEN
		UPDATE titular
		SET saldodeudor = saldodeudor + new.importe
		WHERE idtitular = new.idtitular;
		RETURN NULL;
	END IF;
END;
$$
LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER trigger_restar_saldo_deudor
AFTER INSERT ON PagoCuota
FOR EACH ROW
EXECUTE FUNCTION resta_saldo_deudor();

CREATE OR REPLACE FUNCTION resta_saldo_deudor()
RETURNS TRIGGER AS
$$
DECLARE
	importe_pagado DECIMAL(10,2);
	nuevo_importe DECIMAL(10,2);
BEGIN
	importe_pagado := (select C.importe FROM Cuota C WHERE C.idtitular = new.idtitular AND C.messianio = TO_CHAR(new.fechapago, 'MM/YY'));
	nuevo_importe := (select saldodeudor from titular where idtitular = new.idtitular);
	IF nuevo_importe = importe_pagado THEN
		nuevo_importe := 0;
	ELSE 
		nuevo_importe := nuevo_importe - importe_pagado;
	END IF;
	UPDATE titular
	SET saldodeudor = nuevo_importe
	WHERE idtitular = new.idtitular;
	RETURN NULL;
END;
$$
LANGUAGE plpgsql;

