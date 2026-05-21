import React, { useEffect, useState } from 'react';

const API_BASE = '/api';

export default function App() {
  const [users, setUsers] = useState([]);
  const [name, setName] = useState('');

  async function load() {
    const res = await fetch(`${API_BASE}/users`);
    const data = await res.json();
    setUsers(data);
  }

  useEffect(() => { load(); }, []);

  async function addUser(e) {
    e.preventDefault();
    if (!name) return;
    await fetch(`${API_BASE}/users`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ name })
    });
    setName('');
    load();
  }

  return (
    <div style={{ fontFamily: 'Arial, sans-serif', padding: 20 }}>
      <h1>Three Tier Demo</h1>
      <form onSubmit={addUser}>
        <input value={name} onChange={e => setName(e.target.value)} placeholder="New user name" />
        <button type="submit">Add</button>
      </form>
      <h2>Users</h2>
      <ul>
        {users.map(u => <li key={u.id}>{u.name} (#{u.id})</li>)}
      </ul>
    </div>
  );
}
