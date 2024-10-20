-- Crear esquema para tablas temporales

CREATE SCHEMA TemporalHistory;

-- Tabla Docente
CREATE TABLE Docente (
    CUIL VARCHAR(11) PRIMARY KEY,
    DNI VARCHAR(8) NOT NULL,
    NomyApell VARCHAR(100) NOT NULL,
    Sexo CHAR(1),
    FechaNac DATE,
    TelFijo VARCHAR(15),
    TelCelular VARCHAR(15),
    Mail VARCHAR(100),
    idDomicilio INT,
    SysStartTime DATETIME2 GENERATED ALWAYS AS ROW START HIDDEN NOT NULL,
    SysEndTime DATETIME2 GENERATED ALWAYS AS ROW END HIDDEN NOT NULL,
    PERIOD FOR SYSTEM_TIME (SysStartTime, SysEndTime)
) WITH (SYSTEM_VERSIONING = ON (HISTORY_TABLE = TemporalHistory.Docente_History));


-- Tabla Conviviente
CREATE TABLE Conviviente (
    DNI VARCHAR(8) PRIMARY KEY,
    Nombre VARCHAR(100),
    Parentesco VARCHAR(50),
    Sexo CHAR(1),
    FechaNac DATE,
    idDomicilio INT,
    SysStartTime DATETIME2 GENERATED ALWAYS AS ROW START HIDDEN NOT NULL,
    SysEndTime DATETIME2 GENERATED ALWAYS AS ROW END HIDDEN NOT NULL,
    PERIOD FOR SYSTEM_TIME (SysStartTime, SysEndTime)
) WITH (SYSTEM_VERSIONING = ON (HISTORY_TABLE = TemporalHistory.Conviviente_History));

--Tabla Escuela
CREATE TABLE Escuela (
    EscuelaNro INT PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL,
    Direccion VARCHAR(200)
);
--Tabla Domicilio
CREATE TABLE Domicilio (
    idDomicilio INT PRIMARY KEY IDENTITY(1,1),
    Ciudad VARCHAR(100) NOT NULL,
    Calle VARCHAR(100) NOT NULL,
    Número VARCHAR(10) NOT NULL
);

--Tabla Trayectoria
CREATE TABLE Trayectoria (
    CUIL VARCHAR(11) NOT NULL,
	EscuelaNro INT NOT NULL,
    Cargo VARCHAR(100) NOT NULL,
    Suplente_titular CHAR(1) NOT NULL, -- 'S' para suplente, 'T' para titular
    SalarioBruto DECIMAL(10,2) NOT NULL,
    SysStartTime DATETIME2 GENERATED ALWAYS AS ROW START HIDDEN NOT NULL,
    SysEndTime DATETIME2 GENERATED ALWAYS AS ROW END HIDDEN NOT NULL,
    PERIOD FOR SYSTEM_TIME (SysStartTime, SysEndTime),
    CONSTRAINT PK_Trayectoria PRIMARY KEY (CUIL, EscuelaNro, SysStartTime),
    FOREIGN KEY (CUIL) REFERENCES Docente(CUIL),
    FOREIGN KEY (EscuelaNro) REFERENCES Escuela(EscuelaNro)
) WITH (SYSTEM_VERSIONING = ON (HISTORY_TABLE = TemporalHistory.Trayectoria_History));

-- Tabla Justificación de inasistencias
CREATE TABLE Justificacion (
	idJustificacion INT PRIMARY KEY,
	Descripcion VARCHAR (100)
);

--Tabla Inasistencia
CREATE TABLE Inasistencia (
    idInasistencia INT PRIMARY KEY IDENTITY(1,1),
    Fecha DATE NOT NULL,
    CUIL VARCHAR(11) NOT NULL,
	idJustificacion INT,
    SysStartTime DATETIME2 GENERATED ALWAYS AS ROW START HIDDEN NOT NULL,
    SysEndTime DATETIME2 GENERATED ALWAYS AS ROW END HIDDEN NOT NULL,
    PERIOD FOR SYSTEM_TIME (SysStartTime, SysEndTime),
    FOREIGN KEY (CUIL) REFERENCES Docente(CUIL),
	FOREIGN KEY (idJustificacion) REFERENCES Justificacion (idJustificacion)
) WITH (SYSTEM_VERSIONING = ON (HISTORY_TABLE = TemporalHistory.Inasistencia_History));



