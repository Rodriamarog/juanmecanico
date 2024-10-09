-- Query 3: Mostrar la información del inventario de refacciones que tiene cada producto registrado.
SELECT ID_Parte, Descripcion, Precio_Unitario, Stock, ID_Departamento
FROM parte;

-- Query 9: Mostrar el listado de clientes registrados junto con los automoviles que tiene registrados en sistema.
SELECT c.ID_Cliente, c.Nombre AS NombreCliente, a.ID_Automovil, a.Marca, a.Modelo, a.Anio
FROM cliente c
LEFT JOIN automovil a ON c.ID_Cliente = a.ID_Cliente;

-- Query 12: Mostrar las promociones vigentes por un rango de fechas determinado.
SELECT ID_Promocion, Descripcion, Descuento, Fecha_Inicio, Fecha_Fin
FROM promocion
WHERE Fecha_Inicio <= :fecha_fin AND Fecha_Fin >= :fecha_inicio;

-- Query 18: Mostrar el listado de empleados clasificado por departamentos.
SELECT e.ID_Empleado, e.Nombre, e.Cargo, d.Nombre AS NombreDepartamento
FROM empleado e
JOIN departamento d ON e.ID_Departamento = d.ID_Departamento
ORDER BY d.Nombre, e.Nombre;

-- Query 4: Mostrar las ventas obtenidas con respecto al serivicio de solo diagnósticos.
SELECT v.ID_Venta, v.Fecha, vd.Importe, vd.Total
FROM ventas v
JOIN venta_diagnostico vd ON v.ID_Venta = vd.ID_Venta;

-- Query 5: Mostrar entre el periodo de rango de fechas el numero de atenciones para cada departamento del taller.
SELECT d.Nombre AS NombreDepartamento, COUNT(ot.ID_Orden_Trabajo) AS NumeroAtenciones
FROM departamento d
LEFT JOIN empleado e ON d.ID_Departamento = e.ID_Departamento
LEFT JOIN asignacion a ON e.ID_Empleado = a.ID_Empleado
LEFT JOIN orden_trabajo ot ON a.ID_Orden_Trabajo = ot.ID_Orden_Trabajo
WHERE ot.Fecha_Ingreso BETWEEN :fecha_inicio AND :fecha_fin
GROUP BY d.ID_Departamento, d.Nombre;

-- Query 8: Mostrar e listado de supervisores y sus supervisados en base a un departamento específico.
SELECT d.Nombre AS NombreDepartamento, 
       e1.Nombre AS Supervisor, 
       e2.Nombre AS Supervisado
FROM departamento d
JOIN empleado e1 ON d.Supervisor = e1.ID_Empleado
JOIN empleado e2 ON d.ID_Departamento = e2.ID_Departamento
WHERE d.ID_Departamento = :id_departamento AND e1.ID_Empleado != e2.ID_Empleado;

-- Query 10: Mostrar las reparaciones mas concurrentes en base a un departamento especifico.
SELECT s.Descripcion, COUNT(*) AS Frecuencia
FROM servicio s
JOIN asignacion a ON s.ID_Servicio = a.ID_Servicio
JOIN empleado e ON a.ID_Empleado = e.ID_Empleado
WHERE e.ID_Departamento = :id_departamento
GROUP BY s.ID_Servicio, s.Descripcion
ORDER BY Frecuencia DESC
LIMIT 5;

-- Query 16: Mostrar el consumo de refacciones clasificado por departamento.
SELECT d.Nombre AS NombreDepartamento, p.Descripcion, SUM(vp.Cantidad) AS CantidadConsumida
FROM departamento d
JOIN parte p ON d.ID_Departamento = p.ID_Departamento
JOIN venta_parte vp ON p.ID_Parte = vp.ID_Parte
GROUP BY d.ID_Departamento, d.Nombre, p.ID_Parte, p.Descripcion
ORDER BY d.Nombre, CantidadConsumida DESC;

-- Query 17: Mostrar las ganacias obtenidas del taller por un rango de fechas determinado.
SELECT SUM(Total) AS GananciasTotal
FROM ventas
WHERE Fecha BETWEEN :fecha_inicio AND :fecha_fin;

-- Query 19: Mostrar el las características de los automóviles registrado en un periodo de tiempo determinado.
SELECT a.ID_Automovil, a.Marca, a.Modelo, a.Anio, a.Vin, ot.Fecha_Ingreso
FROM automovil a
JOIN orden_trabajo ot ON a.ID_Automovil = ot.ID_Automovil
WHERE ot.Fecha_Ingreso BETWEEN :fecha_inicio AND :fecha_fin;

-- Query 20: Mostrar los clientes que solo realizaron servicios de diagnóstico en un periodo de fecha determinado.
SELECT DISTINCT c.ID_Cliente, c.Nombre
FROM cliente c
JOIN diagnostico d ON c.ID_Cliente = d.ID_Cliente
LEFT JOIN orden_trabajo ot ON d.ID_Orden_Trabajo = ot.ID_Orden_Trabajo
WHERE d.Fecha BETWEEN :fecha_inicio AND :fecha_fin
  AND NOT EXISTS (
    SELECT 1
    FROM orden_trabajo ot2
    WHERE ot2.ID_Cliente = c.ID_Cliente
      AND ot2.Fecha_Ingreso BETWEEN :fecha_inicio AND :fecha_fin
      AND ot2.ID_Orden_Trabajo != d.ID_Orden_Trabajo
  );

-- Query 23: Mostrar cual es la refacción mas vendida del departamento de refacciones y cuanto genera de ganancia.
SELECT p.ID_Parte, p.Descripcion, SUM(vp.Cantidad) AS CantidadVendida, 
       SUM(vp.Total) AS GananciaTotal
FROM parte p
JOIN venta_parte vp ON p.ID_Parte = vp.ID_Parte
WHERE p.ID_Departamento = 'DP0005' -- Asumiendo que 'DP0005' es el ID del departamento de refacciones
GROUP BY p.ID_Parte, p.Descripcion
ORDER BY CantidadVendida DESC
LIMIT 1;

-- Query 26: Mostrar la promoción mas aplicada en un rango de fechas determinado.
SELECT p.ID_Promocion, p.Descripcion, COUNT(*) AS VecesAplicada
FROM promocion p
JOIN ventas v ON p.ID_Promocion = v.ID_Promocion
WHERE v.Fecha BETWEEN :fecha_inicio AND :fecha_fin
GROUP BY p.ID_Promocion, p.Descripcion
ORDER BY VecesAplicada DESC
LIMIT 1;

-- Query 27: Mostrar el número de promociones vencidas en un rango de fechas determinado.
SELECT COUNT(*) AS PromocionesVencidas
FROM promocion
WHERE Fecha_Fin BETWEEN :fecha_inicio AND :fecha_fin;