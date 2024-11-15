import React, { useState, useEffect } from 'react';
import axios from 'axios';
import './SalesRecord.css';

const SalesRecord = () => {
  const [sale, setSale] = useState({
    clientId: '',
    workOrderId: '',
    total: '',
    paymentMethod: '',
    parts: []
  });
  const [auditLog, setAuditLog] = useState(null);
  const [message, setMessage] = useState({ type: '', text: '' });
  const [parts, setParts] = useState([]);

  useEffect(() => {
    // Fetch available parts
    const fetchParts = async () => {
      try {
        const response = await axios.get('/api/parts');
        setParts(response.data);
      } catch (error) {
        setMessage({ type: 'error', text: 'Error loading parts' });
      }
    };
    fetchParts();
  }, []);

  const handleSubmit = async (e) => {
    e.preventDefault();
    try {
      const response = await axios.post('/api/sales', sale);
      setMessage({ type: 'success', text: 'Sale recorded successfully!' });
      // Fetch and display the audit log
      const auditResponse = await axios.get(`/api/sales/audit/${response.data.saleId}`);
      setAuditLog(auditResponse.data);
      // Reset form
      setSale({
        clientId: '',
        workOrderId: '',
        total: '',
        paymentMethod: '',
        parts: []
      });
    } catch (error) {
      setMessage({ 
        type: 'error', 
        text: error.response?.data?.message || 'Error recording sale' 
      });
    }
  };

  return (
    <div className="sales-record">
      <h2>Record New Sale</h2>

      {message.text && (
        <div className={`message ${message.type}`}>
          {message.text}
        </div>
      )}

      <form onSubmit={handleSubmit}>
        <div className="form-group">
          <label>Client ID:</label>
          <input
            type="text"
            value={sale.clientId}
            onChange={(e) => setSale({...sale, clientId: e.target.value})}
            required
          />
        </div>

        <div className="form-group">
          <label>Work Order ID:</label>
          <input
            type="text"
            value={sale.workOrderId}
            onChange={(e) => setSale({...sale, workOrderId: e.target.value})}
            required
          />
        </div>

        <div className="form-group">
          <label>Total Amount:</label>
          <input
            type="number"
            value={sale.total}
            onChange={(e) => setSale({...sale, total: e.target.value})}
            required
          />
        </div>

        <div className="form-group">
          <label>Payment Method:</label>
          <select
            value={sale.paymentMethod}
            onChange={(e) => setSale({...sale, paymentMethod: e.target.value})}
            required
          >
            <option value="">Select Payment Method</option>
            <option value="cash">Cash</option>
            <option value="card">Card</option>
            <option value="transfer">Bank Transfer</option>
          </select>
        </div>

        <button type="submit">Record Sale</button>
      </form>

      {auditLog && (
        <div className="audit-log">
          <h3>Sale Audit Log</h3>
          <pre>{JSON.stringify(auditLog, null, 2)}</pre>
        </div>
      )}
    </div>
  );
};

export default SalesRecord; 