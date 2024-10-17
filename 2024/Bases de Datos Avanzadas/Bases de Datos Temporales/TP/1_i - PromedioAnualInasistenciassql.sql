--Promedio anual de inasistencias (sin considerar licencia por enfermedad, licencia por cuidado de conviviente).
SELECT * FROM Docente;
SELECT * FROM Inasistencia;

SELECT 
    CUIL,
    YEAR(Fecha) AS Año,
    COUNT(*) AS Total_Inasistencias,
    (COUNT(*) / 160.0) AS Promedio_Inasistencias
FROM 
    Inasistencia
WHERE 
    Justificación NOT IN ('Licencia por enfermedad', 'Licencia por cuidado de conviviente') -- Excluye los tipos de inasistencias no deseados
GROUP BY 
    CUIL, 
    YEAR(Fecha);


--INSERTS AQUÍ

INSERT INTO Inasistencia (Fecha, CUIL, Justificación) VALUES
('2022-01-16', '20333333333', 'Enfermedad'),
('2022-01-17', '20333333333', 'Enfermedad'),
('2022-04-07', '20444444445', 'Licencia por enfermedad'),
('2022-04-08', '20444444445', 'Licencia por enfermedad'),
('2022-04-09', '20444444445', 'Licencia por enfermedad'),
('2022-04-10', '20444444445', 'Licencia por enfermedad'),
('2022-04-11', '20444444445', 'Licencia por enfermedad'),
('2022-04-12', '20444444445', 'Licencia por enfermedad'),
('2023-09-03', '20444444445', 'Licencia por cuidado de conviviente'),
('2023-09-04', '20444444445', 'Licencia por cuidado de conviviente'),
('2023-09-15', '20333333333', 'Trámite personal'),
('2023-11-20', '27367654324', NULL),

('2023-12-17', '20333333333', 'Vacaciones'),
('2023-12-18', '20333333333', 'Vacaciones'),
('2023-12-19', '20333333333', 'Vacaciones'),
('2023-12-20', '20333333333', 'Vacaciones'),
('2023-12-21', '20333333333', 'Vacaciones'),
('2023-12-22', '20333333333', 'Vacaciones'),
('2023-12-23', '20333333333', 'Vacaciones'),
('2023-12-24', '20333333333', 'Vacaciones'),
('2023-12-25', '20333333333', 'Vacaciones'),
('2023-12-26', '20333333333', 'Vacaciones'),
('2023-12-27', '20333333333', 'Vacaciones'),
('2023-12-28', '20333333333', 'Vacaciones'),
('2023-12-29', '20333333333', 'Vacaciones'),
('2023-12-30', '20333333333', 'Vacaciones'),
('2023-12-31', '20333333333', 'Vacaciones'),
('2024-01-01', '20333333333', 'Vacaciones'),
('2024-01-02', '20333333333', 'Vacaciones'),
('2024-01-03', '20333333333', 'Vacaciones'),
('2024-01-04', '20333333333', 'Vacaciones'),
('2024-01-05', '20333333333', 'Vacaciones'),
('2024-01-06', '20333333333', 'Vacaciones'),
('2024-01-07', '20333333333', 'Vacaciones'),
('2024-01-08', '20333333333', 'Vacaciones'),
('2024-01-09', '20333333333', 'Vacaciones'),
('2024-01-10', '20333333333', 'Vacaciones'),

('2023-12-17', '20444444445', 'Vacaciones'),
('2023-12-18', '20444444445', 'Vacaciones'),
('2023-12-19', '20444444445', 'Vacaciones'),
('2023-12-20', '20444444445', 'Vacaciones'),
('2023-12-21', '20444444445', 'Vacaciones'),
('2023-12-22', '20444444445', 'Vacaciones'),
('2023-12-23', '20444444445', 'Vacaciones'),
('2023-12-24', '20444444445', 'Vacaciones'),
('2023-12-25', '20444444445', 'Vacaciones'),
('2023-12-26', '20444444445', 'Vacaciones'),
('2023-12-27', '20444444445', 'Vacaciones'),
('2023-12-28', '20444444445', 'Vacaciones'),
('2023-12-29', '20444444445', 'Vacaciones'),
('2023-12-30', '20444444445', 'Vacaciones'),
('2023-12-31', '20444444445', 'Vacaciones'),
('2024-01-01', '20444444445', 'Vacaciones'),
('2024-01-02', '20444444445', 'Vacaciones'),
('2024-01-03', '20444444445', 'Vacaciones'),
('2024-01-04', '20444444445', 'Vacaciones'),
('2024-01-05', '20444444445', 'Vacaciones'),
('2024-01-06', '20444444445', 'Vacaciones'),
('2024-01-07', '20444444445', 'Vacaciones'),
('2024-01-08', '20444444445', 'Vacaciones'),
('2024-01-09', '20444444445', 'Vacaciones'),
('2024-01-10', '20444444445', 'Vacaciones'),

('2023-12-17', '27367654324', 'Vacaciones'),
('2023-12-18', '27367654324', 'Vacaciones'),
('2023-12-19', '27367654324', 'Vacaciones'),
('2023-12-20', '27367654324', 'Vacaciones'),
('2023-12-21', '27367654324', 'Vacaciones'),
('2023-12-22', '27367654324', 'Vacaciones'),
('2023-12-23', '27367654324', 'Vacaciones'),
('2023-12-24', '27367654324', 'Vacaciones'),
('2023-12-25', '27367654324', 'Vacaciones'),
('2023-12-26', '27367654324', 'Vacaciones'),
('2023-12-27', '27367654324', 'Vacaciones'),
('2023-12-28', '27367654324', 'Vacaciones'),
('2023-12-29', '27367654324', 'Vacaciones'),
('2023-12-30', '27367654324', 'Vacaciones'),
('2023-12-31', '27367654324', 'Vacaciones'),
('2024-01-01', '27367654324', 'Vacaciones'),
('2024-01-02', '27367654324', 'Vacaciones'),
('2024-01-03', '27367654324', 'Vacaciones'),
('2024-01-04', '27367654324', 'Vacaciones'),
('2024-01-05', '27367654324', 'Vacaciones'),
('2024-01-06', '27367654324', 'Vacaciones'),
('2024-01-07', '27367654324', 'Vacaciones'),
('2024-01-08', '27367654324', 'Vacaciones'),
('2024-01-09', '27367654324', 'Vacaciones'),
('2024-01-10', '27367654324', 'Vacaciones'),


('2024-05-01', '27367654324', 'Licencia por enfermedad'),
('2024-05-02', '27367654324', 'Licencia por enfermedad'),
('2024-05-03', '27367654324', 'Licencia por enfermedad'),
('2024-06-11', '20444444445', 'Tratamiento médico'),
('2024-06-20', '20333333333', NULL),
('2024-08-05', '27367654324', 'Reunión en la AFA para quitar descensos'),
('2024-09-01', '27367654324', 'Licencia por cuidado de conviviente'),
('2024-09-02', '27367654324', 'Licencia por cuidado de conviviente'),
('2024-09-05', '27367654324', NULL),
('2024-09-15', '20333333333', NULL),
('2024-11-10', '20333333333', 'Licencia por enfermedad'),
('2024-11-11', '20333333333', 'Licencia por enfermedad');



