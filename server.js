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
  user: process.env.DB_USER || 'juanmecanico_user',
  password: process.env.DB_PASSWORD,
  database: 'juanmecanico',
  waitForConnections: true,
  connectionLimit: 10,
  queueLimit: 0
});

app.post('/api/query', async (req, res) => {
  const { queryId, startDate, endDate, departmentId } = req.body;
  let query, params;

  try {
    console.log('Received query request:', { queryId, startDate, endDate, departmentId });

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

    console.log('Executing query:', query, 'with params:', params);

    const [results] = await pool.query(query, params);
    
    console.log('Query results:', results);
    
    res.json(results);
  } catch (error) {
    console.error('Error executing query:', error);
    res.status(500).json({ 
      error: 'An error occurred while executing the query',
      details: error.message
    });
  }
});

app.get('/api/employees', async (req, res) => {
  try {
    const [rows] = await pool.query('SELECT ID_Empleado, Nombre FROM empleado');
    res.json(rows);
  } catch (error) {
    console.error('Error fetching employees:', error);
    res.status(500).json({ error: 'Error fetching employees' });
  }
});

app.get('/api/services', async (req, res) => {
  try {
    const [rows] = await pool.query('SELECT ID_Servicio, Descripcion FROM servicio');
    res.json(rows);
  } catch (error) {
    console.error('Error fetching services:', error);
    res.status(500).json({ error: 'Error fetching services' });
  }
});

app.get('/api/parts', async (req, res) => {
  try {
    const [rows] = await pool.query('SELECT * FROM parte');
    res.json(rows);
  } catch (error) {
    console.error('Error fetching parts:', error);
    res.status(500).json({ error: 'Error fetching parts' });
  }
});

app.post('/api/assignments', async (req, res) => {
  try {
    // Get the last assignment ID
    const [lastAssignment] = await pool.query(
      'SELECT ID_Asignacion FROM asignacion ORDER BY ID_Asignacion DESC LIMIT 1'
    );
    
    // Generate new ID (AS0021 if last was AS0020)
    const lastNum = lastAssignment.length > 0 
      ? parseInt(lastAssignment[0].ID_Asignacion.substring(2)) 
      : 0;
    const newId = `AS${String(lastNum + 1).padStart(4, '0')}`;

    // Insert new assignment with Fecha_Inicio instead of assignmentDate
    const [result] = await pool.execute(
      'INSERT INTO asignacion (ID_Asignacion, ID_Empleado, ID_Servicio, ID_Orden_Trabajo, Fecha_Inicio) VALUES (?, ?, ?, ?, ?)',
      [newId, req.body.employeeId, req.body.serviceId, req.body.workOrderId, req.body.assignmentDate]
    );
    
    res.json({
      success: true,
      assignmentId: newId,
      triggerMessage: 'Asignación creada exitosamente'
    });
  } catch (error) {
    console.error('Error en asignación:', error);
    res.status(400).json({
      success: false,
      message: error.message
    });
  }
});

app.post('/api/sales', async (req, res) => {
  try {
    const connection = await pool.getConnection();
    const { total, paymentMethod } = req.body;
    
    // Convert total to number and validate
    const numericTotal = parseFloat(total);
    if (isNaN(numericTotal)) {
      throw new Error('Total must be a valid number');
    }
    
    // Debug log
    console.log('Values being passed to stored procedure:', {
      numericTotal: numericTotal,
      type: typeof numericTotal,
      paymentMethod: paymentMethod,
      paymentType: typeof paymentMethod,
      rawTotal: total,
      rawPaymentMethod: req.body.paymentMethod
    });

    try {
      // Call the stored procedure with explicit type casting
      const [result] = await connection.execute(
        'CALL registrar_venta(?, ?)',
        [numericTotal.toFixed(2), String(paymentMethod)]  // Explicit type conversion
      );

      const saleId = result[0][0].ID_Venta;
      
      res.json({ 
        success: true, 
        saleId: saleId,
        message: 'Venta registrada exitosamente'
      });
    } catch (error) {
      console.error('Error in stored procedure:', error);
      res.status(400).json({ 
        success: false,
        message: error.message || 'Error al registrar la venta' 
      });
    } finally {
      connection.release();
    }
  } catch (error) {
    console.error('Connection error:', error);
    res.status(500).json({ 
      success: false,
      message: 'Error de conexión con la base de datos' 
    });
  }
});

app.get('/api/sales/:saleId', async (req, res) => {
  try {
    const [rows] = await pool.execute(
      'SELECT * FROM ventas WHERE ID_Venta = ?',
      [req.params.saleId]
    );
    res.json(rows[0]);
  } catch (error) {
    console.error('Error fetching sale:', error);
    res.status(400).json({ 
      success: false,
      message: error.message || 'Error al obtener la venta' 
    });
  }
});
app.listen(port, () => {
  console.log(`Server running on port ${port}`);
});