create SEQUENCE socio_sequence
  START WITH 900,
 increment by 10;

CREATE OR REPLACE FUNCTION manejar_num_socio() RETURNS TRIGGER AS $$
DECLARE
   aux_num_socio INT;
BEGIN
    -- Si se inserta un 'numSocio' nulo
    IF NEW.numSocio IS NULL THEN
        -- Si la tabla no tiene filas, comenzamos con 900
        SELECT INTO aux_num_socio MAX(numSocio) FROM Socio;
        IF aux_num_socio IS NULL THEN
            NEW.numSocio := 900;
        ELSE
            -- De lo contrario, obtenemos el siguiente valor de la secuencia
			NEW.numSocio := nextval('socio_sequence');       
        END IF;
    ELSE
		RAISE NOTICE 'WTF';
        -- Si se inserta un valor para 'numSocio'
        -- Verificar que el número no exista ya en la tabla
        PERFORM 1 FROM Socio WHERE numSocio = NEW.numSocio;
        IF FOUND THEN
            RAISE EXCEPTION 'El número de socio % ya existe.', NEW.numSocio;
        ELSE
            -- Modificar la secuencia
            PERFORM setval('socio_sequence', NEW.numSocio + 2); -- Ajustamos para que el siguiente sea 10 números después
        END IF;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER trg_manejar_num_socio
BEFORE INSERT ON Socio
FOR EACH ROW

EXECUTE FUNCTION manejar_num_socio();

SELECT setval('socio_sequence', 900);

DELETE FROM socio where numsocio > 600;
select * from socio order by numsocio desc;
insert into socio (dni, nomyapell, fechanac, sexo, estado) values
(3434348, 'JuanCarlos6', current_date - interval '30 years' , 'M', 'Activo');
