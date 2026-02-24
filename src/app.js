const express = require('express');
const usersRouter = require('./routes/users');
const errorHandler = require('./middleware/errorHandler');

const app = express();

app.use(express.json());

// Routes
app.use('/users', usersRouter);

// Health check
app.get('/health', (req, res) => {
  res.json({ status: 'ok' });
});

// Error handling
app.use(errorHandler);

module.exports = app;
