import React from 'react';
import QueryInterface from './components/QueryInterface';
import ServiceAssignment from './components/ServiceAssignment';
import SalesRecord from './components/SalesRecord';
import './App.css';

function App() {
  return (
    <div className="App">
      <div className="app-container">
        <nav className="app-nav">
          <h1>Sistema de Gestión de Taller Mecánico</h1>
        </nav>

        <main className="app-main">
          <div className="component-container">
            <QueryInterface />
          </div>

          <div className="component-container">
            <ServiceAssignment />
          </div>

          <div className="component-container">
            <SalesRecord />
          </div>
        </main>
      </div>
    </div>
  );
}

export default App; 