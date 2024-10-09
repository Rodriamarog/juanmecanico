const express = require('express');
const mysql = require('mysql2/promise');
const cors = require('cors');
require('dotenv').config();  

const app = express();
const port = 3001;

app.use(cors());
app.use(express.json());

const pool = mysql.createPool({
  host: 'localhost',
  user: 'root',
  password: process.env.DB_PASSWORD,
  database: 'juanmecanico',
  waitForConnections: true,
  connectionLimit: 10,
  queueLimit: 0
});

app.post('/api/query', async (req, res) => {
  const { queryId, startDate, endDate, departmentId } = req.body;
  let query, params;

  switch(queryId) {
    case '3':
      query = `SELECT ID_Parte, Descripcion, Precio_Unitario, Stock, ID_Departamento FROM parte`;
      break;
    case '9':
      query = `SELECT c.ID_Cliente, c.Nombre AS NombreCliente, a.ID_Automovil, a.Marca, a.Modelo, a.Anio
               FROM cliente c
               LEFT JOIN automovil a ON c.ID_Cliente = a.ID_Cliente`;
      break;
    case '12':
      query = `SELECT ID_Promocion, Descripcion, Descuento, Fecha_Inicio, Fecha_Fin
               FROM promocion
               WHERE Fecha_Inicio <= ? AND Fecha_Fin >= ?`;
      params = [endDate, startDate];
      break;
    case '18':
      query = `SELECT e.ID_Empleado, e.Nombre, e.Cargo, d.Nombre AS NombreDepartamento
               FROM empleado e
               JOIN departamento d ON e.ID_Departamento = d.ID_Departamento
               ORDER BY d.Nombre, e.Nombre`;
      break;
    case '4':
      query = `SELECT v.ID_Venta, v.Fecha, vd.Importe, vd.Total
               FROM ventas v
               JOIN venta_diagnostico vd ON v.ID_Venta = vd.ID_Venta`;
      break;
    case '5':
      query = `SELECT d.Nombre AS NombreDepartamento, COUNT(ot.ID_Orden_Trabajo) AS NumeroAtenciones
               FROM departamento d
               LEFT JOIN empleado e ON d.ID_Departamento = e.ID_Departamento
               LEFT JOIN asignacion a ON e.ID_Empleado = a.ID_Empleado
               LEFT JOIN orden_trabajo ot ON a.ID_Orden_Trabajo = ot.ID_Orden_Trabajo
               WHERE ot.Fecha_Ingreso BETWEEN ? AND ?
               GROUP BY d.ID_Departamento, d.Nombre`;
      params = [startDate, endDate];
      break;
    case '8':
      query = `SELECT d.Nombre AS NombreDepartamento, 
                      e1.Nombre AS Supervisor, 
                      e2.Nombre AS Supervisado
               FROM departamento d
               JOIN empleado e1 ON d.Supervisor = e1.ID_Empleado
               JOIN empleado e2 ON d.ID_Departamento = e2.ID_Departamento
               WHERE d.ID_Departamento = ? AND e1.ID_Empleado != e2.ID_Empleado`;
      params = [departmentId];
      break;
    case '10':
      query = `SELECT s.Descripcion, COUNT(*) AS Frecuencia
               FROM servicio s
               JOIN asignacion a ON s.ID_Servicio = a.ID_Servicio
               JOIN empleado e ON a.ID_Empleado = e.ID_Empleado
               WHERE e.ID_Departamento = ?
               GROUP BY s.ID_Servicio, s.Descripcion
               ORDER BY Frecuencia DESC
               LIMIT 5`;
      params = [departmentId];
      break;
    case '16':
      query = `SELECT d.Nombre AS NombreDepartamento, p.Descripcion, SUM(vp.Cantidad) AS CantidadConsumida
               FROM departamento d
               JOIN parte p ON d.ID_Departamento = p.ID_Departamento
               JOIN venta_parte vp ON p.ID_Parte = vp.ID_Parte
               GROUP BY d.ID_Departamento, d.Nombre, p.ID_Parte, p.Descripcion
               ORDER BY d.Nombre, CantidadConsumida DESC`;
      break;
    case '17':
      query = `SELECT SUM(Total) AS GananciasTotal
               FROM ventas
               WHERE Fecha BETWEEN ? AND ?`;
      params = [startDate, endDate];
      break;
    case '19':
      query = `SELECT a.ID_Automovil, a.Marca, a.Modelo, a.Anio, a.Vin, ot.Fecha_Ingreso
               FROM automovil a
               JOIN orden_trabajo ot ON a.ID_Automovil = ot.ID_Automovil
               WHERE ot.Fecha_Ingreso BETWEEN ? AND ?`;
      params = [startDate, endDate];
      break;
    case '20':
      query = `SELECT DISTINCT c.ID_Cliente, c.Nombre
               FROM cliente c
               JOIN diagnostico d ON c.ID_Cliente = d.ID_Cliente
               LEFT JOIN orden_trabajo ot ON d.ID_Orden_Trabajo = ot.ID_Orden_Trabajo
               WHERE d.Fecha BETWEEN ? AND ?
                 AND NOT EXISTS (
                   SELECT 1
                   FROM orden_trabajo ot2
                   WHERE ot2.ID_Cliente = c.ID_Cliente
                     AND ot2.Fecha_Ingreso BETWEEN ? AND ?
                     AND ot2.ID_Orden_Trabajo != d.ID_Orden_Trabajo
                 )`;
      params = [startDate, endDate, startDate, endDate];
      break;
    case '23':
      query = `SELECT p.ID_Parte, p.Descripcion, SUM(vp.Cantidad) AS CantidadVendida, 
                      SUM(vp.Total) AS GananciaTotal
               FROM parte p
               JOIN venta_parte vp ON p.ID_Parte = vp.ID_Parte
               WHERE p.ID_Departamento = 'DP0005'
               GROUP BY p.ID_Parte, p.Descripcion
               ORDER BY CantidadVendida DESC
               LIMIT 1`;
      break;
    case '26':
      query = `SELECT p.ID_Promocion, p.Descripcion, COUNT(*) AS VecesAplicada
               FROM promocion p
               JOIN ventas v ON p.ID_Promocion = v.ID_Promocion
               WHERE v.Fecha BETWEEN ? AND ?
               GROUP BY p.ID_Promocion, p.Descripcion
               ORDER BY VecesAplicada DESC
               LIMIT 1`;
      params = [startDate, endDate];
      break;
    case '27':
      query = `SELECT COUNT(*) AS PromocionesVencidas
               FROM promocion
               WHERE Fecha_Fin BETWEEN ? AND ?`;
      params = [startDate, endDate];
      break;
    default:
      return res.status(400).json({ error: 'Invalid query ID' });
  }

  try {
    const [results] = await pool.query(query, params);
    res.json(results);
  } catch (error) {
    console.error('Error executing query:', error);
    res.status(500).json({ error: 'An error occurred while executing the query' });
  }
});

app.listen(port, () => {
  console.log(`Server running on port ${port}`);
});