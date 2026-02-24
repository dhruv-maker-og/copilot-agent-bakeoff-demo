const express = require('express');
const router = express.Router();

// In-memory user store (for demo purposes)
const users = [
  { id: 1, name: 'Alice Johnson', email: 'alice@example.com' },
  { id: 2, name: 'Bob Smith', email: 'bob@example.com' },
  { id: 3, name: 'Charlie Lee', email: 'charlie@example.com' },
];

const defaultPreferences = { theme: 'light', language: 'en', notifications: true };

const userPreferences = {
  1: { ...defaultPreferences },
  2: { ...defaultPreferences },
  3: { ...defaultPreferences },
};

const isValidLanguage = (code) => typeof code === 'string' && /^[a-z]{2}$/i.test(code);

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

// GET /users/:id/preferences — get a user's preferences
router.get('/:id/preferences', (req, res) => {
  const id = parseInt(req.params.id, 10);
  const user = users.find((u) => u.id === id);

  if (!user) {
    return res.status(404).json({ error: `User with id ${id} not found` });
  }

  res.json(userPreferences[id] || { ...defaultPreferences });
});

// PUT /users/:id/preferences — update a user's preferences
router.put('/:id/preferences', (req, res) => {
  const id = parseInt(req.params.id, 10);
  const user = users.find((u) => u.id === id);

  if (!user) {
    return res.status(404).json({ error: `User with id ${id} not found` });
  }

  const payload = req.body;
  const allowedFields = ['theme', 'language', 'notifications'];
  const unknownField = Object.keys(payload).find((key) => !allowedFields.includes(key));

  if (unknownField) {
    return res.status(400).json({ error: `Unknown field: ${unknownField}` });
  }

  if (payload.theme !== undefined && (typeof payload.theme !== 'string' || !['light', 'dark'].includes(payload.theme))) {
    return res.status(400).json({ error: 'Invalid theme: must be "light" or "dark"' });
  }

  if (payload.language !== undefined && !isValidLanguage(payload.language)) {
    return res.status(400).json({ error: 'Invalid language: must be a two-letter ISO 639-1 code' });
  }

  if (payload.notifications !== undefined && typeof payload.notifications !== 'boolean') {
    return res.status(400).json({ error: 'Invalid notifications: must be a boolean' });
  }

  userPreferences[id] = {
    ...userPreferences[id],
    ...payload,
  };

  res.json(userPreferences[id]);
});

module.exports = router;
