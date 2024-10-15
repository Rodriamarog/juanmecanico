-- View for Query 3: Inventory information
CREATE OR REPLACE VIEW vista_inventario AS
SELECT ID_Parte, Descripcion, Precio_Unitario, Stock, ID_Departamento
FROM parte;

-- View for Query 4: Sales obtained from diagnostic services
CREATE OR REPLACE VIEW vista_ventas_diagnosticos AS
SELECT v.ID_Venta, v.Fecha, vd.Importe, vd.Total
FROM ventas v
JOIN venta_diagnostico vd ON v.ID_Venta = vd.ID_Venta;

-- View for Query 5: Number of services for each department
CREATE OR REPLACE VIEW vista_atenciones_por_departamento AS
SELECT d.Nombre AS NombreDepartamento, COUNT(ot.ID_Orden_Trabajo) AS NumeroAtenciones
FROM departamento d
LEFT JOIN empleado e ON d.ID_Departamento = e.ID_Departamento
LEFT JOIN asignacion a ON e.ID_Empleado = a.ID_Empleado
LEFT JOIN orden_trabajo ot ON a.ID_Orden_Trabajo = ot.ID_Orden_Trabajo
GROUP BY d.ID_Departamento, d.Nombre;

-- View for Query 8: Supervisors and supervised employees
CREATE OR REPLACE VIEW vista_supervisores_supervisados AS
SELECT d.ID_Departamento, d.Nombre AS NombreDepartamento, 
       e1.Nombre AS Supervisor, 
       e2.Nombre AS Supervisado
FROM departamento d
JOIN empleado e1 ON d.Supervisor = e1.ID_Empleado
JOIN empleado e2 ON d.ID_Departamento = e2.ID_Departamento
WHERE e1.ID_Empleado != e2.ID_Empleado;

-- View for Query 9: Customers and their registered automobiles
CREATE OR REPLACE VIEW vista_clientes_automoviles AS
SELECT c.ID_Cliente, c.Nombre AS NombreCliente, a.ID_Automovil, a.Marca, a.Modelo, a.Anio
FROM cliente c
LEFT JOIN automovil a ON c.ID_Cliente = a.ID_Cliente;

-- View for Query 10: Most common repairs by department
CREATE OR REPLACE VIEW vista_reparaciones_frecuentes AS
SELECT e.ID_Departamento, s.Descripcion, COUNT(*) AS Frecuencia
FROM servicio s
JOIN asignacion a ON s.ID_Servicio = a.ID_Servicio
JOIN empleado e ON a.ID_Empleado = e.ID_Empleado
GROUP BY e.ID_Departamento, s.ID_Servicio, s.Descripcion;

-- View for Query 12: Active promotions
CREATE OR REPLACE VIEW vista_promociones_vigentes AS
SELECT ID_Promocion, Descripcion, Descuento, Fecha_Inicio, Fecha_Fin
FROM promocion
WHERE Fecha_Fin >= CURDATE();

-- View for Query 16: Spare parts consumption by department
CREATE OR REPLACE VIEW vista_consumo_refacciones AS
SELECT d.Nombre AS NombreDepartamento, p.Descripcion, SUM(vp.Cantidad) AS CantidadConsumida
FROM departamento d
JOIN parte p ON d.ID_Departamento = p.ID_Departamento
JOIN venta_parte vp ON p.ID_Parte = vp.ID_Parte
GROUP BY d.ID_Departamento, d.Nombre, p.ID_Parte, p.Descripcion
ORDER BY d.Nombre, CantidadConsumida DESC;

-- View for Query 17: Workshop earnings
CREATE OR REPLACE VIEW vista_ganancias_taller AS
SELECT Fecha, Total
FROM ventas;

-- View for Query 18: Employees classified by department
CREATE OR REPLACE VIEW vista_empleados_por_departamento AS
SELECT e.ID_Empleado, e.Nombre, e.Cargo, d.Nombre AS NombreDepartamento
FROM empleado e
JOIN departamento d ON e.ID_Departamento = d.ID_Departamento
ORDER BY d.Nombre, e.Nombre;

-- View for Query 19: Registered automobiles
CREATE OR REPLACE VIEW vista_automoviles_registrados AS
SELECT DISTINCT a.ID_Automovil, a.Marca, a.Modelo, a.Anio, a.Vin, d.Fecha AS Fecha_Ingreso
FROM automovil a
JOIN diagnostico d ON a.ID_Automovil = d.ID_Automovil;

-- View for Query 20: Clients with only diagnostic services
CREATE OR REPLACE VIEW vista_clientes_solo_diagnostico AS
SELECT DISTINCT c.ID_Cliente, c.Nombre
FROM cliente c
JOIN diagnostico d ON c.ID_Cliente = d.ID_Cliente
LEFT JOIN orden_trabajo ot ON d.ID_Orden_Trabajo = ot.ID_Orden_Trabajo
WHERE ot.ID_Orden_Trabajo IS NULL;

-- View for Query 23: Most sold spare part in the spare parts department
CREATE OR REPLACE VIEW vista_refaccion_mas_vendida AS
SELECT p.ID_Parte, p.Descripcion, SUM(vp.Cantidad) AS CantidadVendida, 
       SUM(vp.Total) AS GananciaTotal
FROM parte p
JOIN venta_parte vp ON p.ID_Parte = vp.ID_Parte
WHERE p.ID_Departamento = 'DP0005' -- Assuming 'DP0005' is the ID for the spare parts department
GROUP BY p.ID_Parte, p.Descripcion;

-- View for Query 26: Most applied promotion
CREATE OR REPLACE VIEW vista_promocion_mas_aplicada AS
SELECT p.ID_Promocion, p.Descripcion, COUNT(*) AS VecesAplicada
FROM promocion p
JOIN ventas v ON p.ID_Promocion = v.ID_Promocion
GROUP BY p.ID_Promocion, p.Descripcion;

-- View for Query 27: Expired promotions
CREATE OR REPLACE VIEW vista_promociones_vencidas AS
SELECT ID_Promocion, Descripcion, Fecha_Fin
FROM promocion
WHERE Fecha_Fin < CURDATE();