-- Crear BD
create database TP3BDA;

-- Crear extensión postgis, no se necesita tener nada previamente
CREATE EXTENSION postgis;

-- Chequear que esto devuelva algo por las dudas
SELECT PostGIS_Version();

-- Tabla que vamos a usar, con menos columnas que la original
CREATE TABLE CASASLV (
    id SERIAL PRIMARY KEY,
    geom GEOMETRY,
	operation VARCHAR(50),
    type VARCHAR(50),
    bedrooms INT,
    bathrooms INT,
    surface_total FLOAT,
    surface_covered FLOAT,
    price FLOAT,
    currency VARCHAR(10),
    price_period VARCHAR(50),
    title VARCHAR(255),
    description TEXT
);

DROP TABLE casaslosvagos;

-- Metemos en la tabla de acá arriba los datos que queremos
INSERT INTO CASASLV (geom, operation, "type", bedrooms, bathrooms, surface_total, surface_covered, price, currency, price_period, title, description)
select geom, operation, "type" , bedrooms, bathrooms, surface_total, surface_covered, price, currency, price_period, title, description from CASAS_VENTA;

CREATE TABLE RADIOSCENSALESLV(
	id serial4 NOT NULL,
	geom public.geometry(multipolygon, 4326) NULL,
	varon float8 NULL,
	mujer float8 NULL,
	totalpobl float8 NULL,
	hogares float8 NULL,
	PERSONAS_jardin_preescolar int4 NULL,
	PERSONAS_Primario int4 NULL,
	PERSONAS_EGB int4 NULL,
	PERSONAS_Secundario int4 NULL,
	PERSONAS_Polimodal int4 NULL,
	PERSONAS_Superior_no_universitario int4 NULL,
	PERSONAS_Universitario int4 NULL,
	PERSONAS_Post_universitario int4 NULL,
	PERSONAS_Educación_especial int4 NULL
);

INSERT INTO RADIOSCENSALESLV (
    geom,
    varon,
    mujer,
    totalpobl,
    hogares,
    PERSONAS_jardin_preescolar,
    PERSONAS_Primario,
    PERSONAS_EGB,
    PERSONAS_Secundario,
    PERSONAS_Polimodal,
    PERSONAS_Superior_no_universitario,
    PERSONAS_Universitario,
    PERSONAS_Post_universitario,
    PERSONAS_Educación_especial
)
SELECT 
    geom,
    varon,
    mujer,
    totalpobl,
    hogares,
    "PERSONA-P09.csv_1 Inicial (jard�n, preescolar)",
    "PERSONA-P09.csv_2 Primario",
    "PERSONA-P09.csv_3 EGB",
    "PERSONA-P09.csv_4 Secundario",
    "PERSONA-P09.csv_5 Polimodal",
    "PERSONA-P09.csv_6 Superior no universitario",
    "PERSONA-P09.csv_7 Universitario",
    "PERSONA-P09.csv_8 Post universitario",
    "PERSONA-P09.csv_9 Educaci�n especial"
FROM radios_censales_parana; -- Cambia por el nombre real de la tabla de origen

--select * from radios_censales_parana rcp;
--select * from RADIOSCENSALESLV;

CREATE TABLE departamentoParanálv (
	id serial4 NOT NULL,
	geom public.geometry(multipolygon, 4326) NULL,
	gid int8 NULL,
	objeto varchar(50) NULL,
	fna varchar(150) NULL,
	gna varchar(50) NULL,
	nam varchar(100) NULL,
	in1 varchar(6) NULL,
	fdc varchar(100) NULL,
	sag varchar(50) NULL
);

insert into departamentoParanálv
SELECT * FROM departamento d where nam='Paraná';