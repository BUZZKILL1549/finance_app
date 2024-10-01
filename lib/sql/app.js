const express = require('express');
const { Client } = require('pg');
const axios = require('axios');  // Or use `node-fetch` if you prefer

const app = express();
const port = 3000;

// PostgreSQL client configuration
const client = new Client({
  host: 'ep-twilight-cell-a1e6sc0c.ap-southeast-1.aws.neon.tech',
  database: 'financedb',
  user: 'financedb_owner',
  password: '8Lm0gTbhVrJO',
  port: 5432,
  ssl: {
    rejectUnauthorized: false
  }
});

// Function to fetch users from PostgreSQL
async function fetchUsers() {
  await client.connect();
  const res = await client.query('SELECT * FROM users');
  await client.end();
  return res.rows;
}

// Endpoint to get users from the database
app.get('/users', async (req, res) => {
  try {
    const users = await fetchUsers();
    res.json(users);
  } catch (error) {
    console.error('Error fetching users', error);
    res.status(500).send('Server Error');
  }
});

// Example of an HTTP GET request to an external API
app.get('/external-api', async (req, res) => {
  try {
    const response = await axios.get('https://jsonplaceholder.typicode.com/todos/1');  // Example API
    res.json(response.data);
  } catch (error) {
    console.error('Error making HTTP request', error);
    res.status(500).send('Server Error');
  }
});

// Start the server
app.listen(port, () => {
  console.log(`Server running at http://localhost:${port}`);
});
