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
      expect(user).toHaveProperty('preferences');
      expect(user.preferences).toHaveProperty('theme');
      expect(user.preferences).toHaveProperty('language');
      expect(user.preferences).toHaveProperty('notifications');
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
      preferences: { theme: 'light', language: 'en', notifications: true },
    });
  });

  it('should return 404 for a non-existent user', async () => {
    const res = await request(app).get('/users/999');

    expect(res.statusCode).toBe(404);
    expect(res.body).toHaveProperty('error');
  });
});

describe('GET /health', () => {
  it('should return health status', async () => {
    const res = await request(app).get('/health');

    expect(res.statusCode).toBe(200);
    expect(res.body).toEqual({ status: 'ok' });
  });
});

describe('GET /users/:id/preferences', () => {
  it('should return preferences for an existing user', async () => {
    const res = await request(app).get('/users/1/preferences');

    expect(res.statusCode).toBe(200);
    expect(res.body).toEqual({ theme: 'light', language: 'en', notifications: true });
  });

  it('should return 404 for a non-existent user', async () => {
    const res = await request(app).get('/users/999/preferences');

    expect(res.statusCode).toBe(404);
    expect(res.body).toHaveProperty('error');
  });
});

describe('PUT /users/:id/preferences', () => {
  it('should update preferences when input is valid', async () => {
    const res = await request(app)
      .put('/users/2/preferences')
      .send({ theme: 'dark', language: 'fr', notifications: false });

    expect(res.statusCode).toBe(200);
    expect(res.body).toEqual({ theme: 'dark', language: 'fr', notifications: false });
  });

  it('should return 400 for an invalid theme', async () => {
    const res = await request(app)
      .put('/users/1/preferences')
      .send({ theme: 'blue' });

    expect(res.statusCode).toBe(400);
    expect(res.body.error).toMatch(/theme/i);
  });

  it('should return 400 for an invalid language code', async () => {
    const res = await request(app)
      .put('/users/1/preferences')
      .send({ language: 'eng' });

    expect(res.statusCode).toBe(400);
    expect(res.body.error).toMatch(/language/i);
  });

  it('should return 400 when notifications is not boolean', async () => {
    const res = await request(app)
      .put('/users/1/preferences')
      .send({ notifications: 'yes' });

    expect(res.statusCode).toBe(400);
    expect(res.body.error).toMatch(/notifications/i);
  });

  it('should return 400 for unknown preference fields', async () => {
    const res = await request(app)
      .put('/users/1/preferences')
      .send({ color: 'red' });

    expect(res.statusCode).toBe(400);
    expect(res.body.error).toMatch(/unknown/i);
  });

  it('should return 404 for a non-existent user', async () => {
    const res = await request(app)
      .put('/users/999/preferences')
      .send({ theme: 'light', language: 'en', notifications: true });

    expect(res.statusCode).toBe(404);
    expect(res.body).toHaveProperty('error');
  });
});
