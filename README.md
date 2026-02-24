# Copilot Agent Bake-Off Demo

A simple Node.js / Express REST API used to demonstrate GitHub Copilot's third-party agent capabilities.

## What is this?

This repo contains a minimal API with a single resource (`/users`). It serves as the starting point for a **demo** where three different AI coding agents — **GitHub Copilot**, **Claude**, and **Codex** — are each assigned the same issue and produce competing pull requests.

## Getting Started

```bash
# Install dependencies
npm install

# Start the server
npm start

# Run tests
npm test
```

## API Endpoints

| Method | Endpoint       | Description          |
|--------|----------------|----------------------|
| GET    | `/health`      | Health check         |
| GET    | `/users`       | List all users       |
| GET    | `/users/:id`   | Get a user by ID     |

## Project Structure

```
src/
├── app.js                  # Express app setup
├── server.js               # Server entry point
├── routes/
│   └── users.js            # User routes
└── middleware/
    └── errorHandler.js     # Centralized error handler
tests/
└── users.test.js           # Jest + Supertest tests
```

## Demo: Agent Bake-Off

This repo is designed for a demo comparing how three AI agents approach the same task:

1. A GitHub Issue is created requesting a new `user preferences` endpoint
2. **Copilot**, **Claude**, and **Codex** are each assigned the issue
3. Each agent produces a draft PR with a different approach
4. The audience compares architecture, validation, testing, and design decisions

## License

MIT
