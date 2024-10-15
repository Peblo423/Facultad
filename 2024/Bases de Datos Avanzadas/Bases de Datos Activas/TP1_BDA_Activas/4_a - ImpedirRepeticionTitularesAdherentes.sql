CREATE OR REPLACE FUNCTION verificar_Adherente_unico()
RETURNS TRIGGER AS $$
BEGIN
    IF EXISTS (SELECT 1 FROM Titular WHERE idTitular = NEW.idAdherente) THEN
        RAISE EXCEPTION 'El socio con id % ya está registrado como titular', NEW.idAdherente;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_verificar_adherente_unico
BEFORE INSERT OR UPDATE ON Adherente
FOR EACH ROW
EXECUTE FUNCTION verificar_Adherente_unico();

CREATE OR REPLACE FUNCTION verificar_Titular_unico()
RETURNS TRIGGER AS $$
BEGIN
    IF EXISTS (SELECT 1 FROM Adherente WHERE idAdherente = NEW.idTitular) THEN
        RAISE EXCEPTION 'El socio con id % ya está registrado como adherente', NEW.idtitular;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_verificar_titular_unico
BEFORE INSERT OR UPDATE ON Titular
FOR EACH ROW
EXECUTE FUNCTION verificar_Titular_unico();

SELECT * FROM SOCIO;
select * from adherente;
select * from titular;