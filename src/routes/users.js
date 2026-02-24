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

const allowedPreferenceFields = ['theme', 'language', 'notifications'];
const validThemes = ['light', 'dark'];
const isValidLanguageCode = (language) =>
  typeof language === 'string' && /^[a-z]{2}$/.test(language);

const validatePreferences = (payload) => {
  const unknownFields = Object.keys(payload).filter(
    (field) => !allowedPreferenceFields.includes(field)
  );

  if (unknownFields.length) {
    return `Unknown field(s): ${unknownFields.join(', ')}`;
  }

  if (Object.keys(payload).length === 0) {
    return 'No preference fields provided';
  }

  if (payload.theme !== undefined) {
    if (typeof payload.theme !== 'string' || !validThemes.includes(payload.theme)) {
      return 'Invalid theme. Allowed values: light, dark';
    }
  }

  if (payload.language !== undefined) {
    if (!isValidLanguageCode(payload.language)) {
      return 'Invalid language. Use a 2-letter ISO 639-1 code (e.g., en, fr)';
    }
  }

  if (payload.notifications !== undefined) {
    if (typeof payload.notifications !== 'boolean') {
      return 'Invalid notifications value. Must be boolean';
    }
  }

  return null;
};

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

  const validationError = validatePreferences(req.body);

  if (validationError) {
    return res.status(400).json({ error: validationError });
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
