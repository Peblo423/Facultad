INSERT INTO SocioPeriodo (fechaDesde, fechaHasta, motivoBaja, numSocio) VALUES
('2024-01-01', '2024-06-30', NULL, 1),
('2024-07-01', '2024-12-31', 'Cambio de residencia', 3),
('2024-08-01', NULL, NULL, 5),
('2024-05-01', '2024-10-31', 'Se atrasó muchas cuotas', 6),
('2024-07-01', NULL, NULL, 1);

CREATE OR REPLACE FUNCTION marcar_socio_inactivo()
RETURNS TRIGGER AS $$
BEGIN
	IF OLD.fechahasta IS NULL THEN
		UPDATE Socio
		SET estado = 'Inactivo'
		WHERE numSocio = NEW.numSocio
		OR numSocio IN 
		(select idAdherente from adherente as A where A.idtitular=OLD.numsocio);
	END IF;    
	RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_marcar_socio_inactivo
AFTER UPDATE OF fechaHasta 
ON SocioPeriodo
FOR EACH ROW
EXECUTE FUNCTION marcar_socio_inactivo();

CREATE OR REPLACE FUNCTION marcar_socio_activo()
RETURNS TRIGGER AS $$
BEGIN
		UPDATE Socio
		SET estado = 'Activo'
		WHERE numSocio = NEW.numSocio;
	RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_marcar_socio_activo
AFTER INSERT 
ON SocioPeriodo
FOR EACH ROW
EXECUTE FUNCTION marcar_socio_activo();

SELECT * FROM ADHERENTE;

select idAdherente from adherente as A where A.idtitular=1;

UPDATE socioperiodo SET fechahasta = '2024-08-10' WHERE numsocio = 1 and fechahasta = '2024-08-21';

INSERT into socioperiodo (fechadesde, fechahasta, motivobaja, numsocio) values
	(current_date, NULL, NULL, 8);

UPDATE socioperiodo SET fechahasta = '2024-08-28' WHERE numsocio = 8 and fechahasta is null;
select * from socioperiodo order by numsocio;
select * from socio order by numsocio;