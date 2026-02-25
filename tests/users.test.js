const request = require('supertest');
const app = require('../src/app');

describe('GET /users', () => {
  it('should return a list of all users', async () => {
    const res = await request(app).get('/users');

    expect(res.statusCode).toBe(200);
    expect(Array.isArray(res.body)).toBe(true);
    expect(res.body.length).toBe(3);
  });

  it('should return users with correct structure', async () => {
    const res = await request(app).get('/users');

    res.body.forEach((user) => {
      expect(user).toHaveProperty('id');
      expect(user).toHaveProperty('name');
      expect(user).toHaveProperty('email');
    });
  });
});

describe('GET /users/:id', () => {
  it('should return a single user by ID', async () => {
    const res = await request(app).get('/users/1');

    expect(res.statusCode).toBe(200);
    expect(res.body).toEqual({
      id: 1,
      name: 'Alice Johnson',
      email: 'alice@example.com',
      preferences: {
        theme: 'light',
        language: 'en',
        notifications: true,
      },
    });
  });

  it('should return 404 for a non-existent user', async () => {
    const res = await request(app).get('/users/999');

    expect(res.statusCode).toBe(404);
    expect(res.body).toHaveProperty('error');
  });
});

describe('Preferences endpoints', () => {
  it('should return current preferences for a user', async () => {
    const res = await request(app).get('/users/1/preferences');

    expect(res.statusCode).toBe(200);
    expect(res.body).toEqual({
      theme: 'light',
      language: 'en',
      notifications: true,
    });
  });

  it('should update preferences with valid data', async () => {
    const updateRes = await request(app)
      .put('/users/1/preferences')
      .send({ theme: 'dark', language: 'fr', notifications: false });

    expect(updateRes.statusCode).toBe(200);
    expect(updateRes.body).toEqual({
      theme: 'dark',
      language: 'fr',
      notifications: false,
    });

    const getRes = await request(app).get('/users/1/preferences');

    expect(getRes.statusCode).toBe(200);
    expect(getRes.body).toEqual({
      theme: 'dark',
      language: 'fr',
      notifications: false,
    });
  });

  it('should return 400 for invalid theme', async () => {
    const res = await request(app)
      .put('/users/1/preferences')
      .send({ theme: 'blue' });

    expect(res.statusCode).toBe(400);
    expect(res.body).toEqual({
      error: 'Invalid theme: must be "light" or "dark"',
    });
  });

  it('should return 400 for invalid language', async () => {
    const res = await request(app)
      .put('/users/1/preferences')
      .send({ language: 'english' });

    expect(res.statusCode).toBe(400);
    expect(res.body).toEqual({
      error: 'Invalid language: must be a 2-letter code',
    });
  });

  it('should return 400 for invalid notifications type', async () => {
    const res = await request(app)
      .put('/users/1/preferences')
      .send({ notifications: 'yes' });

    expect(res.statusCode).toBe(400);
    expect(res.body).toEqual({
      error: 'Invalid notifications: must be boolean',
    });
  });

  it('should return 404 for non-existent user preferences', async () => {
    const res = await request(app).get('/users/999/preferences');

    expect(res.statusCode).toBe(404);
    expect(res.body).toEqual({ error: 'User with id 999 not found' });
  });
});

describe('GET /health', () => {
  it('should return health status', async () => {
    const res = await request(app).get('/health');

    expect(res.statusCode).toBe(200);
    expect(res.body).toEqual({ status: 'ok' });
  });
});
