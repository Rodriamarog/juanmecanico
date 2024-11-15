import React, { useState, useEffect } from 'react';
import axios from 'axios';

const UserManagement = () => {
  const [users, setUsers] = useState([]);
  const [newUser, setNewUser] = useState({
    username: '',
    password: '',
    role: 'reader'
  });

  // Fetch users
  useEffect(() => {
    const fetchUsers = async () => {
      const response = await axios.get('/api/users');
      setUsers(response.data);
    };
    fetchUsers();
  }, []);

  // Create new user
  const handleCreateUser = async (e) => {
    e.preventDefault();
    try {
      await axios.post('/api/users', newUser);
      // Refresh users list
      const response = await axios.get('/api/users');
      setUsers(response.data);
      setNewUser({ username: '', password: '', role: 'reader' });
    } catch (error) {
      console.error('Error creating user:', error);
    }
  };

  // Remove user
  const handleRemoveUser = async (username) => {
    try {
      await axios.delete(`/api/users/${username}`);
      setUsers(users.filter(user => user.username !== username));
    } catch (error) {
      console.error('Error removing user:', error);
    }
  };

  return (
    <div className="user-management">
      <h2>User Management</h2>
      
      {/* Create User Form */}
      <form onSubmit={handleCreateUser}>
        <input
          type="text"
          placeholder="Username"
          value={newUser.username}
          onChange={(e) => setNewUser({...newUser, username: e.target.value})}
        />
        <input
          type="password"
          placeholder="Password"
          value={newUser.password}
          onChange={(e) => setNewUser({...newUser, password: e.target.value})}
        />
        <select
          value={newUser.role}
          onChange={(e) => setNewUser({...newUser, role: e.target.value})}
        >
          <option value="reader">Reader</option>
          <option value="data_analyst">Data Analyst</option>
          <option value="administrator">Administrator</option>
        </select>
        <button type="submit">Create User</button>
      </form>

      {/* Users List */}
      <div className="users-list">
        {users.map(user => (
          <div key={user.username} className="user-item">
            <span>{user.username} - {user.role}</span>
            <button onClick={() => handleRemoveUser(user.username)}>
              Remove
            </button>
          </div>
        ))}
      </div>
    </div>
  );
};

export default UserManagement; 