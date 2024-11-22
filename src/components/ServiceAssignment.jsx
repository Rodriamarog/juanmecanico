import React, { useState, useEffect } from 'react';
import axios from 'axios';
import './ServiceAssignment.css';
import { API_URL } from '../config';

const ServiceAssignment = () => {
  const [employees, setEmployees] = useState([]);
  const [services, setServices] = useState([]);
  const [formData, setFormData] = useState({
    employeeId: '',
    serviceId: '',
    workOrderId: '',
    assignmentDate: ''
  });
  const [message, setMessage] = useState({ type: '', text: '' });

  useEffect(() => {
    // Fetch employees and services on component mount
    const fetchData = async () => {
      try {
        const [empResponse, servResponse] = await Promise.all([
          axios.get(`${API_URL}/api/employees`),
          axios.get(`${API_URL}/api/services`)
        ]);
        setEmployees(empResponse.data);
        setServices(servResponse.data);
      } catch (error) {
        setMessage({ type: 'error', text: 'Error loading data' });
      }
    };
    fetchData();
  }, []);

  const handleSubmit = async (e) => {
    e.preventDefault();
    try {
      const response = await axios.post(`${API_URL}/api/assignments`, formData);
      setMessage({ 
        type: 'success', 
        text: 'Service assignment created successfully!' 
      });
      // Reset form
      setFormData({
        employeeId: '',
        serviceId: '',
        workOrderId: '',
        assignmentDate: ''
      });
    } catch (error) {
      setMessage({ 
        type: 'error', 
        text: error.response?.data?.message || 'Error creating assignment' 
      });
    }
  };

  return (
    <div className="service-assignment">
      <h2>Assign Employee to Service</h2>
      
      {message.text && (
        <div className={`message ${message.type}`}>
          {message.text}
        </div>
      )}

      <form onSubmit={handleSubmit}>
        <div className="form-group">
          <label>Employee:</label>
          <select
            value={formData.employeeId}
            onChange={(e) => setFormData({
              ...formData,
              employeeId: e.target.value
            })}
            required
          >
            <option value="">Select Employee</option>
            {employees.map(emp => (
              <option key={emp.ID_Empleado} value={emp.ID_Empleado}>
                {emp.Nombre}
              </option>
            ))}
          </select>
        </div>

        <div className="form-group">
          <label>Service:</label>
          <select
            value={formData.serviceId}
            onChange={(e) => setFormData({
              ...formData,
              serviceId: e.target.value
            })}
            required
          >
            <option value="">Select Service</option>
            {services.map(service => (
              <option key={service.ID_Servicio} value={service.ID_Servicio}>
                {service.Descripcion}
              </option>
            ))}
          </select>
        </div>

        <div className="form-group">
          <label>Work Order ID:</label>
          <input
            type="text"
            value={formData.workOrderId}
            onChange={(e) => setFormData({
              ...formData,
              workOrderId: e.target.value
            })}
            required
          />
        </div>

        <div className="form-group">
          <label>Assignment Date:</label>
          <input
            type="date"
            value={formData.assignmentDate}
            onChange={(e) => setFormData({
              ...formData,
              assignmentDate: e.target.value
            })}
            required
          />
        </div>

        <button type="submit">Assign Service</button>
      </form>
    </div>
  );
};

export default ServiceAssignment;