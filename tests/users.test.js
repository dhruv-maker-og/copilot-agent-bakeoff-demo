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
  it('should return user preferences', async () => {
    const res = await request(app).get('/users/1/preferences');

    expect(res.statusCode).toBe(200);
    expect(res.body).toEqual({
      theme: 'light',
      language: 'en',
      notifications: true,
    });
  });

  it('should return 404 for non-existent user', async () => {
    const res = await request(app).get('/users/999/preferences');

    expect(res.statusCode).toBe(404);
    expect(res.body).toHaveProperty('error');
  });
});

describe('PUT /users/:id/preferences', () => {
  it('should update user preferences with valid input', async () => {
    const res = await request(app)
      .put('/users/1/preferences')
      .send({ theme: 'dark', language: 'fr', notifications: false });

    expect(res.statusCode).toBe(200);
    expect(res.body).toEqual({
      theme: 'dark',
      language: 'fr',
      notifications: false,
    });
  });

  it('should update partial preferences', async () => {
    const res = await request(app)
      .put('/users/1/preferences')
      .send({ theme: 'light' });

    expect(res.statusCode).toBe(200);
    expect(res.body.theme).toBe('light');
  });

  it('should return 400 for invalid theme', async () => {
    const res = await request(app)
      .put('/users/1/preferences')
      .send({ theme: 'blue' });

    expect(res.statusCode).toBe(400);
    expect(res.body).toHaveProperty('error');
    expect(res.body.error).toContain('theme');
  });

  it('should return 400 for invalid theme type', async () => {
    const res = await request(app)
      .put('/users/1/preferences')
      .send({ theme: 123 });

    expect(res.statusCode).toBe(400);
    expect(res.body).toHaveProperty('error');
    expect(res.body.error).toContain('theme');
  });

  it('should return 400 for invalid language', async () => {
    const res = await request(app)
      .put('/users/1/preferences')
      .send({ language: 'invalid' });

    expect(res.statusCode).toBe(400);
    expect(res.body).toHaveProperty('error');
    expect(res.body.error).toContain('language');
  });

  it('should return 400 for invalid language type', async () => {
    const res = await request(app)
      .put('/users/1/preferences')
      .send({ language: 123 });

    expect(res.statusCode).toBe(400);
    expect(res.body).toHaveProperty('error');
    expect(res.body.error).toContain('language');
  });

  it('should return 400 for invalid notifications type', async () => {
    const res = await request(app)
      .put('/users/1/preferences')
      .send({ notifications: 'yes' });

    expect(res.statusCode).toBe(400);
    expect(res.body).toHaveProperty('error');
    expect(res.body.error).toContain('notifications');
  });

  it('should return 400 for unknown field', async () => {
    const res = await request(app)
      .put('/users/1/preferences')
      .send({ theme: 'dark', unknownField: 'value' });

    expect(res.statusCode).toBe(400);
    expect(res.body).toHaveProperty('error');
    expect(res.body.error).toContain('Unknown field');
  });

  it('should return 404 for non-existent user', async () => {
    const res = await request(app)
      .put('/users/999/preferences')
      .send({ theme: 'dark' });

    expect(res.statusCode).toBe(404);
    expect(res.body).toHaveProperty('error');
  });
});
