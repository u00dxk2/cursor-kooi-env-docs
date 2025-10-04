// Simple Express server example
require('dotenv').config();
const express = require('express');

const app = express();
const PORT = process.env.PORT || 3000;

// Middleware
app.use(express.json());

// Routes
app.get('/', (req, res) => {
  res.json({
    message: 'Welcome to the Node.js Express example!',
    docs: 'This project uses Cursor Environment Docs',
    tip: 'Check .cursor/project-environment.md for environment details'
  });
});

app.get('/health', (req, res) => {
  res.json({ status: 'healthy', timestamp: new Date().toISOString() });
});

app.get('/env', (req, res) => {
  res.json({
    nodeVersion: process.version,
    environment: process.env.NODE_ENV || 'development',
    port: PORT
  });
});

// Start server
app.listen(PORT, () => {
  console.log(`🚀 Server running on http://localhost:${PORT}`);
  console.log(`📚 Environment docs: .cursor/project-environment.md`);
  console.log(`🔍 Check staleness: ./.cursor/check-env-docs.sh (or .ps1)`);
});

