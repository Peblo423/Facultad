--
-- PostgreSQL database dump
--

-- Dumped from database version 9.2.1
-- Dumped by pg_dump version 9.2.1
-- Started on 2013-08-24 13:21:26

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = public, pg_catalog;

--
-- TOC entry 530 (class 1247 OID 24664)
-- Name: cuit; Type: DOMAIN; Schema: public; Owner: postgres
--

CREATE DOMAIN cuit AS character varying(11);


ALTER DOMAIN public.cuit OWNER TO postgres;

--
-- TOC entry 531 (class 1247 OID 24665)
-- Name: d_mes; Type: DOMAIN; Schema: public; Owner: postgres
--

CREATE DOMAIN d_mes AS smallint
	CONSTRAINT d_mes_check CHECK (((VALUE >= 1) OR (VALUE <= 12)));


ALTER DOMAIN public.d_mes OWNER TO postgres;

--
-- TOC entry 533 (class 1247 OID 24667)
-- Name: tipo_facturas; Type: DOMAIN; Schema: public; Owner: postgres
--

CREATE DOMAIN tipo_facturas AS character varying(3)
	CONSTRAINT tipo_facturas_check CHECK (((VALUE)::text = ANY (ARRAY[('A'::character varying)::text, ('B'::character varying)::text, ('NCA'::character varying)::text, ('NCB'::character varying)::text])));


ALTER DOMAIN public.tipo_facturas OWNER TO postgres;

--
-- TOC entry 535 (class 1247 OID 24669)
-- Name: tipo_persona; Type: DOMAIN; Schema: public; Owner: postgres
--

CREATE DOMAIN tipo_persona AS character varying(1)
	CONSTRAINT tipo_persona_check CHECK (((VALUE)::text = ANY (ARRAY[('F'::character varying)::text, ('J'::character varying)::text])));


ALTER DOMAIN public.tipo_persona OWNER TO postgres;

--
-- TOC entry 529 (class 1247 OID 24663)
-- Name: usuario; Type: DOMAIN; Schema: public; Owner: postgres
--

CREATE DOMAIN usuario AS character varying(20) DEFAULT "current_user"();


ALTER DOMAIN public.usuario OWNER TO postgres;

--
-- TOC entry 196 (class 1255 OID 16397)
-- Name: filasdetabla(character varying); Type: FUNCTION; Schema: public; Owner: postgres
--


CREATE TABLE clientes (
    cuit cuit NOT NULL,
    nombre character varying(40) NOT NULL,
    situacion_iva character varying(2),
    tipo_persona character varying(1),
    calle character varying(30) NOT NULL,
    numero_puerta character varying(6),
    piso character varying(2),
    dpto character varying(2),
    codigo_postal character varying(8),
    fecha_baja date
);


ALTER TABLE public.clientes OWNER TO postgres;

--
-- TOC entry 181 (class 1259 OID 24797)
-- Name: clientes_baja; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE clientes_baja (
    cuit cuit NOT NULL,
    nombre character varying(40) NOT NULL,
    situacion_iva character varying(2),
    tipo_persona character varying(1),
    calle character varying(30) NOT NULL,
    numero_puerta character varying(6),
    piso character varying(2),
    dpto character varying(2),
    codigo_postal character varying(8),
    fecha_baja date
);


ALTER TABLE public.clientes_baja OWNER TO postgres;

--
-- TOC entry 173 (class 1259 OID 24710)
-- Name: facturas; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE facturas (
    tipo smallint NOT NULL,
    numero integer NOT NULL,
    fecha date,
    cuit cuit
);


ALTER TABLE public.facturas OWNER TO postgres;

--
-- TOC entry 174 (class 1259 OID 24718)
-- Name: facturas_items; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE facturas_items (
    factura_tipo smallint NOT NULL,
    factura_numero integer NOT NULL,
    producto_codigo smallint NOT NULL,
    cantidad numeric(8,2) NOT NULL,
    precio numeric(8,2) NOT NULL,
    descuento_porcentaje numeric(5,2)
);


ALTER TABLE public.facturas_items OWNER TO postgres;

--
-- TOC entry 175 (class 1259 OID 24723)
-- Name: localidades; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE localidades (
    codigo_postal character varying(8) NOT NULL,
    localidad character varying(25) NOT NULL,
    provincia_id smallint NOT NULL
);


ALTER TABLE public.localidades OWNER TO postgres;

--
-- TOC entry 176 (class 1259 OID 24731)
-- Name: productos; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE productos (
    codigo smallint NOT NULL,
    nombre character varying(20) NOT NULL,
    familia character varying(1) NOT NULL,
    precio numeric(8,2),
    cantidad_bulto smallint,
    CONSTRAINT productos_familia_check CHECK (((familia)::text = ANY ((ARRAY['A'::character varying, 'B'::character varying, 'C'::character varying])::text[]))),
    CONSTRAINT productos_familia_check1 CHECK (((familia)::text = ANY ((ARRAY['A'::character varying, 'B'::character varying, 'C'::character varying])::text[])))
);


ALTER TABLE public.productos OWNER TO postgres;

--
-- TOC entry 177 (class 1259 OID 24736)
-- Name: provincias; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE provincias (
    id smallint NOT NULL,
    nombre character varying(20) NOT NULL
);


ALTER TABLE public.provincias OWNER TO postgres;

--
-- TOC entry 171 (class 1259 OID 24687)
-- Name: situaciones_iva; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE situaciones_iva (
    abreviatura character varying(2) NOT NULL,
    descripcion character varying(30) NOT NULL
);


ALTER TABLE public.situaciones_iva OWNER TO postgres;

--
-- TOC entry 1992 (class 0 OID 24692)
-- Dependencies: 172
-- Data for Name: clientes; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO clientes VALUES ('20165851254', 'FONTANA MARIA EMILIA', 'I', 'F', 'SAN MARTIN', '918', '2', 'C', '3000', NULL);
INSERT INTO clientes VALUES ('20170446667', 'NOBLES JUAN', 'M', 'F', 'PANAMA', '645', NULL, NULL, '3100', NULL);
INSERT INTO clientes VALUES ('20356165552', 'TODO CASERO', 'I', 'J', 'SAN JUAN', '12', NULL, NULL, '3100', NULL);


--
-- TOC entry 1998 (class 0 OID 24797)
-- Dependencies: 181
-- Data for Name: clientes_baja; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 1993 (class 0 OID 24710)
-- Dependencies: 173
-- Data for Name: facturas; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO facturas VALUES (1, 12, '2003-08-29', '20170446667');
INSERT INTO facturas VALUES (1, 1050, '2003-01-09', '20170446667');
INSERT INTO facturas VALUES (2, 12, '2003-01-08', '20165851254');


--
-- TOC entry 1994 (class 0 OID 24718)
-- Dependencies: 174
-- Data for Name: facturas_items; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO facturas_items VALUES (1, 12, 1, 12.00, 20.00, 0.00);
INSERT INTO facturas_items VALUES (1, 12, 2, 2.00, 4.50, 10.00);
INSERT INTO facturas_items VALUES (1, 12, 5, 1.00, 17.00, 0.00);
INSERT INTO facturas_items VALUES (1, 1050, 3, 1.00, 12.50, 0.00);
INSERT INTO facturas_items VALUES (2, 12, 4, 1.00, 45.00, 5.00);


--
-- TOC entry 1995 (class 0 OID 24723)
-- Dependencies: 175
-- Data for Name: localidades; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO localidades VALUES ('3000', 'SANTA FE', 2);
INSERT INTO localidades VALUES ('3100', 'PARANA', 1);


--
-- TOC entry 1996 (class 0 OID 24731)
-- Dependencies: 176
-- Data for Name: productos; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO productos VALUES (3, 'LINTERNA 
MEDIANA', 'A', 12.50, 1);
INSERT INTO productos VALUES (7, 'ESPONJA 
A', 'C', 0.90, 1);
INSERT INTO productos VALUES (8, 'JABON 
TOCADOR', 'C', 2.30, 4);
INSERT INTO productos VALUES (9, 'ESPIRALES', 'C', 3.00, 6);
INSERT INTO productos VALUES (4, 'CORTINA mod 23', 'B', 45.00, 1);
INSERT INTO productos VALUES (6, 'CORTINA MOD 20', 'B', 45.00, 1);
INSERT INTO productos VALUES (5, 'CORITNA MOD 6', 'B', 17.00, 1);
INSERT INTO productos VALUES (2, 'PILAS A3', 'A', 4.50, 2);
INSERT INTO productos VALUES (1, 'PILAS A2', 'A', 20.00, 6);


--
-- TOC entry 1997 (class 0 OID 24736)
-- Dependencies: 177
-- Data for Name: provincias; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO provincias VALUES (2, 'SANTA FE');
INSERT INTO provincias VALUES (3, 'CORRIENTES');
INSERT INTO provincias VALUES (1, 'EN RIOS');


--
-- TOC entry 1991 (class 0 OID 24687)
-- Dependencies: 171
-- Data for Name: situaciones_iva; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO situaciones_iva VALUES ('C', 'CONSUMIDOR FINAL');
INSERT INTO situaciones_iva VALUES ('I', 'INSCRIPTO');
INSERT INTO situaciones_iva VALUES ('M', 'MONOTRIBUTO');


--
-- TOC entry 1974 (class 2606 OID 24699)
-- Name: clientes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY clientes
    ADD CONSTRAINT clientes_pkey PRIMARY KEY (cuit);


--
-- TOC entry 1978 (class 2606 OID 24722)
-- Name: facturas_items_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY facturas_items
    ADD CONSTRAINT facturas_items_pkey PRIMARY KEY (factura_tipo, factura_numero, producto_codigo);


--
-- TOC entry 1976 (class 2606 OID 24717)
-- Name: facturas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY facturas
    ADD CONSTRAINT facturas_pkey PRIMARY KEY (tipo, numero);


--
-- TOC entry 1980 (class 2606 OID 24727)
-- Name: localidades_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY localidades
    ADD CONSTRAINT localidades_pkey PRIMARY KEY (codigo_postal);


--
-- TOC entry 1982 (class 2606 OID 24735)
-- Name: productos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY productos
    ADD CONSTRAINT productos_pkey PRIMARY KEY (codigo);


--
-- TOC entry 1984 (class 2606 OID 24740)
-- Name: provincias_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY provincias
    ADD CONSTRAINT provincias_pkey PRIMARY KEY (id);


--
-- TOC entry 1972 (class 2606 OID 24691)
-- Name: situaciones_iva_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY situaciones_iva
    ADD CONSTRAINT situaciones_iva_pkey PRIMARY KEY (abreviatura);


--
-- TOC entry 1985 (class 2606 OID 24700)
-- Name: clientes_situacion_iva_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY clientes
    ADD CONSTRAINT clientes_situacion_iva_fkey FOREIGN KEY (situacion_iva) REFERENCES situaciones_iva(abreviatura) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- TOC entry 1986 (class 2606 OID 24741)
-- Name: clientes_situacion_iva_fkey1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY clientes
    ADD CONSTRAINT clientes_situacion_iva_fkey1 FOREIGN KEY (situacion_iva) REFERENCES situaciones_iva(abreviatura) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- TOC entry 1987 (class 2606 OID 24792)
-- Name: facturas_cuit_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY facturas
    ADD CONSTRAINT facturas_cuit_fkey FOREIGN KEY (cuit) REFERENCES clientes(cuit) ON UPDATE CASCADE;


--
-- TOC entry 1989 (class 2606 OID 24756)
-- Name: facturas_items_factura_tipo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY facturas_items
    ADD CONSTRAINT facturas_items_factura_tipo_fkey FOREIGN KEY (factura_tipo, factura_numero) REFERENCES facturas(tipo, numero) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 1988 (class 2606 OID 24751)
-- Name: facturas_items_producto_codigo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY facturas_items
    ADD CONSTRAINT facturas_items_producto_codigo_fkey FOREIGN KEY (producto_codigo) REFERENCES productos(codigo) ON UPDATE CASCADE;


--
-- TOC entry 1990 (class 2606 OID 24761)
-- Name: localidades_provincia_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY localidades
    ADD CONSTRAINT localidades_provincia_id_fkey FOREIGN KEY (provincia_id) REFERENCES provincias(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- TOC entry 2004 (class 0 OID 0)
-- Dependencies: 5
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2013-08-24 13:21:27

--
-- PostgreSQL database dump complete
--

