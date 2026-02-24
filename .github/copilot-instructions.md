# Project Conventions

## Code Style
- Use `const` for variables that are not reassigned; use `let` otherwise. Never use `var`.
- Use arrow functions for callbacks and inline functions.
- Use template literals for string interpolation.
- Use early returns to reduce nesting.

## Project Structure
- All source code lives in `src/`.
- Routes go in `src/routes/` — one file per resource (e.g., `users.js`).
- Middleware goes in `src/middleware/`.
- Tests live in `tests/` and mirror the source structure.

## API Conventions
- All endpoints return JSON.
- Use proper HTTP status codes: 200 (success), 201 (created), 400 (bad request), 404 (not found), 500 (server error).
- Error responses use the format: `{ "error": "descriptive message" }`.
- Use `parseInt(req.params.id, 10)` for parsing numeric route parameters.

## Testing
- Use Jest as the test runner and Supertest for HTTP assertions.
- Each test file should import `app` from `../src/app` (not `server`).
- Group related tests with `describe` blocks.
- Test both success and error paths.

## Data
- This is a demo app — data is stored in-memory (no database).
- User data is defined as an array in `src/routes/users.js`.
