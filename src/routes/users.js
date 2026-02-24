const express = require('express');
const router = express.Router();

// In-memory user store (for demo purposes)
const users = [
  { id: 1, name: 'Alice Johnson', email: 'alice@example.com' },
  { id: 2, name: 'Bob Smith', email: 'bob@example.com' },
  { id: 3, name: 'Charlie Lee', email: 'charlie@example.com' },
];

// In-memory preferences store keyed by user ID
const preferences = {
  1: { theme: 'light', language: 'en', notifications: true },
  2: { theme: 'light', language: 'en', notifications: true },
  3: { theme: 'light', language: 'en', notifications: true },
};

const VALID_THEMES = ['light', 'dark'];
const VALID_LANGUAGE_REGEX = /^[a-z]{2}$/;

const DEFAULT_PREFERENCES = () => ({ theme: 'light', language: 'en', notifications: true });

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

// GET /users/:id/preferences — get preferences for a user
router.get('/:id/preferences', (req, res) => {
  const id = parseInt(req.params.id, 10);
  const user = users.find((u) => u.id === id);

  if (!user) {
    return res.status(404).json({ error: `User with id ${id} not found` });
  }

  if (!preferences[id]) {
    preferences[id] = DEFAULT_PREFERENCES();
  }

  res.json(preferences[id]);
});

// PUT /users/:id/preferences — update preferences for a user
router.put('/:id/preferences', (req, res) => {
  const id = parseInt(req.params.id, 10);
  const user = users.find((u) => u.id === id);

  if (!user) {
    return res.status(404).json({ error: `User with id ${id} not found` });
  }

  const allowed = new Set(['theme', 'language', 'notifications']);
  const body = req.body;

  for (const key of Object.keys(body)) {
    if (!allowed.has(key)) {
      return res.status(400).json({ error: `Unknown preference field: ${key}` });
    }
  }

  if ('theme' in body) {
    if (!VALID_THEMES.includes(body.theme)) {
      return res.status(400).json({ error: `Invalid theme: must be "light" or "dark"` });
    }
  }

  if ('language' in body) {
    if (typeof body.language !== 'string' || !VALID_LANGUAGE_REGEX.test(body.language)) {
      return res.status(400).json({ error: 'Invalid language: must be a 2-letter ISO 639-1 code' });
    }
  }

  if ('notifications' in body) {
    if (typeof body.notifications !== 'boolean') {
      return res.status(400).json({ error: 'Invalid notifications: must be a boolean' });
    }
  }

  if (!preferences[id]) {
    preferences[id] = DEFAULT_PREFERENCES();
  }

  Object.assign(preferences[id], body);
  res.json(preferences[id]);
});

module.exports = router;
