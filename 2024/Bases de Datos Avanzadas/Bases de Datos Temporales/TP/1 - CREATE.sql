-- Crear esquema para tablas temporales
CREATE SCHEMA TemporalHistory;

-- Configuraci�n de la base de datos para permitir tablas temporales
ALTER DATABASE tpbdaprueba
SET MEMORY_OPTIMIZED_ELEVATE_TO_SNAPSHOT = ON;

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
--ALTER TABLE dbo.Docente SET (SYSTEM_VERSIONING = OFF);
--drop table docente;

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

--ALTER TABLE dbo.Conviviente SET (SYSTEM_VERSIONING = OFF);
--drop table Conviviente;

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
    N�mero VARCHAR(10) NOT NULL,
);

--Tabla Trayectoria
CREATE TABLE Trayectoria (
    CUIL VARCHAR(11) NOT NULL,
	EscuelaNro INT NOT NULL,
    Desde DATE NOT NULL,
    Hasta DATE,
    Cargo VARCHAR(100) NOT NULL,
    Suplente_titular CHAR(1) NOT NULL, -- 'S' para suplente, 'T' para titular
    SalarioBrutoTotal DECIMAL(10,2) NOT NULL,
    SysStartTime DATETIME2 GENERATED ALWAYS AS ROW START HIDDEN NOT NULL,
    SysEndTime DATETIME2 GENERATED ALWAYS AS ROW END HIDDEN NOT NULL,
    PERIOD FOR SYSTEM_TIME (SysStartTime, SysEndTime),
    CONSTRAINT PK_Trayectoria PRIMARY KEY (CUIL, EscuelaNro, Desde),
    FOREIGN KEY (CUIL) REFERENCES Docente(CUIL),
    FOREIGN KEY (EscuelaNro) REFERENCES Escuela(EscuelaNro)
) WITH (SYSTEM_VERSIONING = ON (HISTORY_TABLE = TemporalHistory.Trayectoria_History));
--ALTER TABLE dbo.Trayectoria SET (SYSTEM_VERSIONING = OFF);
--drop table Trayectoria;

--Tabla Licencia
CREATE TABLE Licencia (
    idLicencia INT PRIMARY KEY IDENTITY(1,1),
    tipo VARCHAR(100) NOT NULL,
    Desde DATE NOT NULL,
    Hasta DATE
);
--ALTER TABLE dbo.Licencia SET (SYSTEM_VERSIONING = OFF);
--drop table Licencia;

--Tabla Inasistencia
CREATE TABLE Inasistencia (
    idInasistencia INT PRIMARY KEY IDENTITY(1,1),
    Fecha DATE NOT NULL,
    CUIL VARCHAR(11) NOT NULL,
    Justifica CHAR(2),
    SysStartTime DATETIME2 GENERATED ALWAYS AS ROW START HIDDEN NOT NULL,
    SysEndTime DATETIME2 GENERATED ALWAYS AS ROW END HIDDEN NOT NULL,
    PERIOD FOR SYSTEM_TIME (SysStartTime, SysEndTime),
    FOREIGN KEY (CUIL) REFERENCES Docente(CUIL)
) WITH (SYSTEM_VERSIONING = ON (HISTORY_TABLE = TemporalHistory.Inasistencia_History));