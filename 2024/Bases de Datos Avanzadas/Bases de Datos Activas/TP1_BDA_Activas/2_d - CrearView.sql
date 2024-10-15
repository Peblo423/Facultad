CREATE VIEW VistaSocios AS
SELECT 
    s.numSocio,
    s.nomYApell AS nombreSocio,
    'T' AS tipoSocio,
    NULL AS nombreTitular
FROM 
    Socio s
JOIN 
    Titular t ON s.numSocio = t.idTitular
UNION ALL
SELECT 
    a.idTitular as numSocio,
    s.nomYApell AS nombreSocio,
    'A' AS tipoSocio,
    (SELECT nomYApell FROM Socio WHERE numSocio = a.idTitular) AS nombreTitular
FROM 
    Socio s
JOIN 
    Adherente a ON s.numSocio = a.idAdherente
ORDER BY numSocio;


-- Insertar datos en Direccion
INSERT INTO Direccion (calle, numero, piso, depto, CP, localidad, provincia) 
VALUES 
('Calle Falsa', 123, 1, 'A', 1000, 'Ciudad', 'Provincia');

-- Insertar datos en Socio
INSERT INTO Socio (numSocio, DNI, nomYApell, fechaNac, sexo, estado, idDirec) 
VALUES 
(1, 12345678, 'Juan Perez', '1990-01-01', 'M', 'Activo', 1);

INSERT INTO Socio (numSocio, DNI, nomYApell, fechaNac, sexo, estado, idDirec) 
VALUES 
(2, 87654321, 'Maria Gomez', '1985-05-10', 'F', 'Activo', 1);

INSERT INTO Socio (numSocio, DNI, nomYApell, fechaNac, sexo, estado, idDirec) 
VALUES 
(3, 56789012, 'Pedro Lopez', '2000-03-15', 'M', 'Activo', 1);

INSERT INTO Socio (numSocio, DNI, nomYApell, fechaNac, sexo, estado, idDirec) 
VALUES 
(4, 21098765, 'Ana Martinez', '1995-07-20', 'F', 'Activo', 1);



-- Insertar datos en Titular
INSERT INTO Titular (idTitular, fechaInscrip, estatura, tipoPlan, tipoSocio) 
VALUES 
(1, '2022-01-01', 1.75, 'Plan A', 'Socio Activo');

INSERT INTO Titular (idTitular, fechaInscrip, estatura, tipoPlan, tipoSocio) 
VALUES 
(2, '2022-01-01', 1.65, 'Plan B', 'Socio Activo');

-- Insertar datos en Adherente
INSERT INTO Adherente (idAdherente, idTitular, gradoParentesco) 
VALUES 
(3, 1, 'Hijo');

INSERT INTO Adherente (idAdherente, idTitular, gradoParentesco) 
VALUES 
(4, 1, 'Primo');


select * from VistaSocios;