select * from vistasocios;
UPDATE vistasocios SET nombresocio = 'Juan Perezoso' WHERE numsocio=1;

CREATE OR REPLACE FUNCTION update_socio_nombre()
RETURNS TRIGGER AS $$
BEGIN
    -- Actualiza el nombre del socio en la tabla Socio
    UPDATE Socio
    SET nomyapell = NEW.nombresocio
    WHERE numsocio = OLD.numsocio;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER cambiar_vistaSocios
INSTEAD OF UPDATE ON vistaSocios
FOR EACH ROW
EXECUTE FUNCTION update_socio_nombre();

