const express = require('express');
const router = express.Router();

// In-memory user store (for demo purposes)
const users = [
  { id: 1, name: 'Alice Johnson', email: 'alice@example.com' },
  { id: 2, name: 'Bob Smith', email: 'bob@example.com' },
  { id: 3, name: 'Charlie Lee', email: 'charlie@example.com' },
];

// GET /users — list all users
router.get('/', (req, res) => {
  res.json(users);
});

// GET /users/:id — get a single user by ID
router.get('/:id', (req, res) => {
  const id = parseInt(req.params.id, 10);
  const user = users.find((u) => u.id === id);

  if (!user) {
    return res.status(404).json({ error: `User with id ${id} not found` });
  }

  res.json(user);
});

module.exports = router;
