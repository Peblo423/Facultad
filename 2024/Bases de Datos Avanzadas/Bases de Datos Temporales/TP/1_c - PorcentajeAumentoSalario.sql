--Porcentaje de aumento de salario entre dos fechas
--Declaraciones
DECLARE @cuilDado VARCHAR(11);
DECLARE @fechaInicialDada DATETIME2;
DECLARE @fechaFinalDada DATETIME2;

--Inicializaciones
SET @cuilDado = '20444444445';
SET @fechaInicialDada = '2022-06-02';
SET @fechaFinalDada = '2023-01-02';

--Obtener Salario total de la fecha Desde
DECLARE	@salarioInicial DECIMAL(10,2) = (
SELECT
    SUM(T.SalarioBrutoTotal)
FROM 
    Trayectoria T
WHERE 
    T.CUIL = @cuilDado
    AND @fechaInicialDada BETWEEN T.Desde AND T.Hasta
GROUP BY T.CUIL
);
select @salarioInicial;

--Obtener Salario total de la fecha Hasta
DECLARE	@salarioFinal DECIMAL(10,2) = (
SELECT
    SUM(T.SalarioBrutoTotal)
FROM 
    Trayectoria T
WHERE 
    T.CUIL = @cuilDado
    AND @fechaFinalDada BETWEEN T.Desde AND T.Hasta
GROUP BY T.CUIL
);
select @salarioFinal;

--Calcular porcentaje de aumento
SELECT CAST(ROUND((((@salarioFinal - @salarioInicial) * 100) / @salarioInicial), 2, 1) AS DECIMAL(10, 2)) AS PorcentajeAumento;



--MATERIAL PARA PRUEBAS

select * from Trayectoria where CUIL = '20444444445' and '2023-01-02' BETWEEN Desde AND Hasta;

--select * from Escuela;
--delete from trayectoria;

INSERT INTO Trayectoria (CUIL, EscuelaNro, Desde, Hasta, Cargo, Suplente_titular, SalarioBrutoTotal)
VALUES ('20444444445', 101, '2022-01-01', '2022-06-01', 'Profesor de Matemáticas', 'T', 50000.00),
('20444444445', 102, '2022-06-01', '2023-01-01', 'Profesor de Física', 'S', 15000.00),
('20444444445', 102, '2023-01-01', '2024-06-01', 'Profesor de Física', 'S', 10000.00),
('20444444445', 103, '2022-06-01', '2025-01-01', 'Profesor de Física', 'S', 13000.00),
('20987654321', 101, '2021-01-01', '2022-12-31', 'Profesor de Historia', 'T', 48000.00),
('20987654321', 103, '2023-01-01', '2023-12-31', 'Profesor de Geografía', 'T', 51000.00),
('20333333333', 104, '2020-01-01', NULL, 'Profesor de Literatura', 'T', 60000.00);