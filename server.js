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
      query = `SELECT * FROM vista_inventario`;
      break;
    case '4':
      query = `SELECT * FROM vista_ventas_diagnosticos`;
      break;
    case '5':
      query = `SELECT * FROM vista_atenciones_por_departamento 
               WHERE EXISTS (
                 SELECT 1 FROM orden_trabajo ot 
                 WHERE ot.Fecha_Ingreso BETWEEN ? AND ?
               )`;
      params = [startDate, endDate];
      break;
    case '8':
      query = `SELECT * FROM vista_supervisores_supervisados WHERE ID_Departamento = ?`;
      params = [departmentId];
      break;
    case '9':
      query = `SELECT * FROM vista_clientes_automoviles`;
      break;
    case '10':
      query = `SELECT Descripcion, Frecuencia 
               FROM vista_reparaciones_frecuentes 
               WHERE ID_Departamento = ?
               ORDER BY Frecuencia DESC
               LIMIT 5`;
      params = [departmentId];
      break;
    case '12':
      query = `SELECT * FROM vista_promociones_vigentes WHERE Fecha_Inicio <= ? AND Fecha_Fin >= ?`;
      params = [endDate, startDate];
      break;
    case '16':
      query = `SELECT * FROM vista_consumo_refacciones`;
      break;
    case '17':
      query = `SELECT SUM(Total) AS GananciasTotal
               FROM vista_ganancias_taller
               WHERE Fecha BETWEEN ? AND ?`;
      params = [startDate, endDate];
      break;
    case '18':
      query = `SELECT * FROM vista_empleados_por_departamento`;
      break;
    case '19':
      query = `SELECT * FROM vista_automoviles_registrados WHERE Fecha_Ingreso BETWEEN ? AND ?`;
      params = [startDate, endDate];
      break;
    case '20':
      query = `SELECT * FROM vista_clientes_solo_diagnostico`;
      break;
    case '23':
      query = `SELECT * FROM vista_refaccion_mas_vendida ORDER BY CantidadVendida DESC LIMIT 1`;
      break;
    case '26':
      query = `SELECT * FROM vista_promocion_mas_aplicada
               WHERE ID_Promocion IN (
                 SELECT ID_Promocion
                 FROM ventas
                 WHERE Fecha BETWEEN ? AND ?
               )
               ORDER BY VecesAplicada DESC
               LIMIT 1`;
      params = [startDate, endDate];
      break;
    case '27':
      query = `SELECT COUNT(*) AS PromocionesVencidas
               FROM vista_promociones_vencidas
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