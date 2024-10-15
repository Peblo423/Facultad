-- Tabla Precio de las Cuotas
CREATE TABLE PRECIOCUOTA(
	TipoSocio CHAR PRIMARY KEY,
	Precio FLOAT
);

INSERT INTO PRECIOCUOTA VALUES ('T', 400);
INSERT INTO PRECIOCUOTA VALUES ('A', 150);

-- Tabla Direccion
CREATE TABLE Direccion (
    idDireccion INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    calle VARCHAR(100) NOT NULL,
    numero INT NOT NULL,
    piso INT,
    depto VARCHAR(10),
    CP INT NOT NULL,
    localidad VARCHAR(100) NOT NULL,
    provincia VARCHAR(100) NOT NULL
);
-- Tabla Socio
CREATE TABLE Socio (
    numSocio INT PRIMARY KEY,
    DNI INT NOT NULL,
    nomYApell VARCHAR(100) NOT NULL,
    fechaNac DATE NOT NULL,
    sexo CHAR(1),
    estado VARCHAR(50) NOT NULL,
	idDirec INT,
    FOREIGN KEY (idDirec) REFERENCES Direccion(idDireccion)
);
-- Tabla Titular (herencia de Socio)
CREATE TABLE Titular (
    idTitular INT PRIMARY KEY,
    fechaInscrip DATE NOT NULL,
    estatura FLOAT,
    tipoPlan VARCHAR(50) NOT NULL,
    tipoSocio VARCHAR(50) NOT NULL,
    FOREIGN KEY (idTitular) REFERENCES Socio(numSocio)
);
-- Tabla Adherente (herencia de Socio)
CREATE TABLE Adherente (
    idAdherente INT PRIMARY KEY,
    idTitular INT NOT NULL,
    gradoParentesco VARCHAR(50) NOT NULL,
    FOREIGN KEY (idAdherente) REFERENCES Socio(numSocio),
    FOREIGN KEY (idTitular) REFERENCES Titular(idTitular)
);
-- Tabla Deporte
CREATE TABLE Deporte (
    codDeporte INT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    Federacion VARCHAR(100)
);
-- Tabla SocioDeporte
CREATE TABLE SocioDeporte (
	numSocio INT,
	codDep INT,
	federado VARCHAR(2),
	PRIMARY KEY (numSocio, codDep),
	FOREIGN KEY (numSocio) REFERENCES Socio(numSocio),
    FOREIGN KEY (codDep) REFERENCES Deporte(codDeporte)
);
-- Tabla SocioPeriodo
CREATE TABLE SocioPeriodo (
    idPeriodo INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    fechaDesde DATE NOT NULL,
    fechaHasta DATE,
    motivoBaja VARCHAR(255),
    numSocio INT NOT NULL,
    FOREIGN KEY (numSocio) REFERENCES Socio(numSocio)
);
-- Tabla Cuota
CREATE TABLE Cuota (
    idCuota INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY, 
	fechaVto DATE NOT NULL,
    messiAnio CHAR(6) NOT NULL,
    importe DECIMAL(10, 2) NOT NULL,
	idTitular INT NOT NULL,
    FOREIGN KEY (idTitular) REFERENCES Titular(idTitular)
);
-- Tabla Beca
CREATE TABLE Beca (
    idBeca INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    fechaDesde DATE NOT NULL,
    fechaHasta DATE,
    porcentajeCuota DECIMAL(5, 2) NOT NULL,
    idSocio INT NOT NULL,
    FOREIGN KEY (idSocio) REFERENCES Socio(numSocio)
);

-- Tabla CuotaDetalle
CREATE TABLE CuotaDetalle (
    idCuota INT NOT NULL,
    idSocio INT,
    monto DECIMAL(10, 2) NOT NULL,
	PRIMARY KEY (idCuota, idSocio),
    FOREIGN KEY (idCuota) REFERENCES Cuota(idCuota),
    FOREIGN KEY (idSocio) REFERENCES Socio(numSocio)
);

-- Tabla PagoCuota
CREATE TABLE PagoCuota (
    idPagoCuota INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    fechaPago DATE NOT NULL,
    montoRecargo DECIMAL(10, 2) DEFAULT 0,
	idcuota INT,
	idtitular INT,
    FOREIGN KEY (idtitular) REFERENCES Titular(idtitular),
	FOREIGN KEY (idcuota) REFERENCES Cuota(idcuota)
);

-- Tabla Empleado
CREATE TABLE Empleado (
    cuil BIGINT PRIMARY KEY,
    nomYApell VARCHAR(100) NOT NULL,
    fechaIngreso DATE NOT NULL,
    cargo VARCHAR(100) NOT NULL,
	cuilJefe BIGINT,
	FOREIGN KEY (cuilJefe) REFERENCES Empleado(cuil)
);
