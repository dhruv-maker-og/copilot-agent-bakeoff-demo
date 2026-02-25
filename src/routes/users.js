const express = require('express');
const router = express.Router();

// In-memory user store (for demo purposes)
const users = [
  {
    id: 1,
    name: 'Alice Johnson',
    email: 'alice@example.com',
    preferences: { theme: 'light', language: 'en', notifications: true },
  },
  {
    id: 2,
    name: 'Bob Smith',
    email: 'bob@example.com',
    preferences: { theme: 'light', language: 'en', notifications: true },
  },
  {
    id: 3,
    name: 'Charlie Lee',
    email: 'charlie@example.com',
    preferences: { theme: 'light', language: 'en', notifications: true },
  },
];

// GET /users — list all users
router.get('/', (req, res) => {
  res.json(users);
});

// GET /users/:id/preferences — get preferences for a user
router.get('/:id/preferences', (req, res) => {
  const id = parseInt(req.params.id, 10);
  const user = users.find((u) => u.id === id);

  if (!user) {
    return res.status(404).json({ error: `User with id ${id} not found` });
  }

  res.json(user.preferences);
});

// PUT /users/:id/preferences — update preferences with validation
router.put('/:id/preferences', (req, res) => {
  const id = parseInt(req.params.id, 10);
  const user = users.find((u) => u.id === id);

  if (!user) {
    return res.status(404).json({ error: `User with id ${id} not found` });
  }

  const allowedFields = ['theme', 'language', 'notifications'];
  const invalidField = Object.keys(req.body).find(
    (key) => !allowedFields.includes(key),
  );

  if (invalidField) {
    return res.status(400).json({ error: `Invalid field: ${invalidField}` });
  }

  const { theme, language, notifications } = req.body;

  if (theme !== undefined) {
    if (typeof theme !== 'string' || !['light', 'dark'].includes(theme)) {
      return res
        .status(400)
        .json({ error: 'Invalid theme: must be "light" or "dark"' });
    }
  }

  if (language !== undefined) {
    if (typeof language !== 'string' || !/^[a-z]{2}$/i.test(language)) {
      return res
        .status(400)
        .json({ error: 'Invalid language: must be a 2-letter code' });
    }
  }

  if (notifications !== undefined) {
    if (typeof notifications !== 'boolean') {
      return res
        .status(400)
        .json({ error: 'Invalid notifications: must be boolean' });
    }
  }

  user.preferences = {
    ...user.preferences,
    ...req.body,
  };

  res.json(user.preferences);
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
