--La regla de negocio que debes cumplir es que un socio no puede ser titular y adherente al mismo tiempo. 
--Es decir, si una persona es un socio titular, no puede ser un socio adherente, y viceversa.

--Aquí, TG_TABLE_NAME es una variable especial en PostgreSQL que 
--contiene el nombre de la tabla en la que se está ejecutando el trigger (wtf re roto)
CREATE OR REPLACE FUNCTION verificar_r1()
RETURNS TRIGGER AS $$
BEGIN
    -- Verificar si el socio está siendo marcado como titular
    IF TG_TABLE_NAME = 'titular' THEN
        -- Verificar si el socio ya existe en Adherente
        IF EXISTS (SELECT 1 FROM Adherente WHERE idAdherente = NEW.idTitular) THEN
            RAISE EXCEPTION 'El socio % ya está registrado como adherente.', NEW.idTitular;
        END IF;
    ELSIF TG_TABLE_NAME = 'adherente' THEN
        -- Verificar si el socio ya existe en Titular
        IF EXISTS (SELECT 1 FROM Titular WHERE idTitular = NEW.idAdherente) THEN
            RAISE EXCEPTION 'El socio % ya está registrado como titular.', NEW.idAdherente;
        END IF;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger para la tabla Titular
CREATE TRIGGER trigger_verificar_titular
BEFORE INSERT OR UPDATE ON Titular
FOR EACH ROW
EXECUTE FUNCTION verificar_r1();

-- Trigger para la tabla Adherente
CREATE TRIGGER trigger_verificar_adherente
BEFORE INSERT OR UPDATE ON Adherente
FOR EACH ROW
EXECUTE FUNCTION verificar_r1();
