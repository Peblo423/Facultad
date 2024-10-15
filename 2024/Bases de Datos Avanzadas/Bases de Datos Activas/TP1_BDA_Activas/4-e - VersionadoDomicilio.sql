CREATE TABLE historialDomicilio (
    idHistorial INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    numsocio INTEGER NOT NULL,
    idDireccion INTEGER,
    fechaActualizacion TIMESTAMP NOT NULL DEFAULT NOW(),
    usuario TEXT,
	FOREIGN KEY (idDireccion) REFERENCES Direccion(idDireccion)
);

CREATE OR REPLACE FUNCTION registrar_cambio_domicilio()
RETURNS TRIGGER AS $$
BEGIN
	    -- Inserta un registro en la tabla historialdomicilio
	    INSERT INTO historialdomicilio (numsocio, iddireccion, fechaActualizacion, usuario)
	    VALUES (OLD.numsocio, OLD.iddirec, NOW(), current_user);
RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_registrar_cambio_domicilio
AFTER UPDATE ON socio
FOR EACH ROW
WHEN (OLD.iddirec IS DISTINCT FROM NEW.iddirec)
EXECUTE FUNCTION registrar_cambio_domicilio();

UPDATE socio 
	SET dni = 33333333, 
	 iddirec = 1
WHERE numsocio = 1;

SELECT * FROM historialdomicilio;

