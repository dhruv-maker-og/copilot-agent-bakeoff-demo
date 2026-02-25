const express = require('express');
const router = express.Router();

// In-memory user store (for demo purposes)
const users = [
  { id: 1, name: 'Alice Johnson', email: 'alice@example.com' },
  { id: 2, name: 'Bob Smith', email: 'bob@example.com' },
  { id: 3, name: 'Charlie Lee', email: 'charlie@example.com' },
];

// In-memory preferences store (for demo purposes)
const preferences = {
  1: { theme: 'light', language: 'en', notifications: true },
  2: { theme: 'light', language: 'en', notifications: true },
  3: { theme: 'light', language: 'en', notifications: true },
};

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

// GET /users/:id/preferences — get user preferences
router.get('/:id/preferences', (req, res) => {
  const id = parseInt(req.params.id, 10);
  const user = users.find((u) => u.id === id);

  if (!user) {
    return res.status(404).json({ error: `User with id ${id} not found` });
  }

  res.json(preferences[id]);
});

// PUT /users/:id/preferences — update user preferences
router.put('/:id/preferences', (req, res) => {
  const id = parseInt(req.params.id, 10);
  const user = users.find((u) => u.id === id);

  if (!user) {
    return res.status(404).json({ error: `User with id ${id} not found` });
  }

  const { theme, language, notifications } = req.body;

  // Validate theme
  if (theme !== undefined) {
    if (typeof theme !== 'string') {
      return res.status(400).json({ error: 'theme must be a string' });
    }
    if (theme !== 'light' && theme !== 'dark') {
      return res.status(400).json({ error: 'theme must be either "light" or "dark"' });
    }
  }

  // Validate language
  if (language !== undefined) {
    if (typeof language !== 'string') {
      return res.status(400).json({ error: 'language must be a string' });
    }
    // Basic ISO 639-1 validation (2-letter code)
    if (!/^[a-z]{2}$/.test(language)) {
      return res.status(400).json({ error: 'language must be a valid ISO 639-1 language code (e.g., "en", "fr", "es")' });
    }
  }

  // Validate notifications
  if (notifications !== undefined) {
    if (typeof notifications !== 'boolean') {
      return res.status(400).json({ error: 'notifications must be a boolean' });
    }
  }

  // Check for unknown fields
  const allowedFields = ['theme', 'language', 'notifications'];
  const providedFields = Object.keys(req.body);
  const unknownFields = providedFields.filter((field) => !allowedFields.includes(field));

  if (unknownFields.length > 0) {
    return res.status(400).json({ error: `Unknown field(s): ${unknownFields.join(', ')}` });
  }

  // Update preferences
  if (theme !== undefined) preferences[id].theme = theme;
  if (language !== undefined) preferences[id].language = language;
  if (notifications !== undefined) preferences[id].notifications = notifications;

  res.json(preferences[id]);
});

module.exports = router;
