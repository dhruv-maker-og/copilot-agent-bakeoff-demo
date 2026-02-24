---
name: Agent Bake-Off Challenge
about: The issue to assign to Copilot, Claude, and Codex for the demo
title: "Add user preferences API endpoint with validation"
labels: enhancement
---

## Description

Add a new REST API endpoint to manage user preferences. Each user should be able to store and update their preferences for theme, language, and notification settings.

## Requirements

### Endpoints

- **`GET /users/:id/preferences`** — Return the current preferences for a user
- **`PUT /users/:id/preferences`** — Update a user's preferences with input validation

### Preference Fields

| Field           | Type    | Valid Values                          |
|-----------------|---------|---------------------------------------|
| `theme`         | string  | `"light"` or `"dark"`                 |
| `language`      | string  | ISO 639-1 language code (e.g., `"en"`, `"fr"`, `"es"`) |
| `notifications` | boolean | `true` or `false`                     |

### Error Handling

- Return **400** with a descriptive error message for invalid input (wrong type, invalid value, unknown field)
- Return **404** if the user ID does not exist
- Error responses must use the format: `{ "error": "descriptive message" }`

### Testing

- Add unit tests for **both success and error cases**
- Cover at minimum: valid update, invalid theme, invalid language, invalid notifications type, non-existent user

## Acceptance Criteria

- [ ] All new code follows existing patterns in `src/routes/`
- [ ] Tests pass via `npm test`
- [ ] No new dependencies unless justified in the PR description
- [ ] Preferences are stored in-memory (consistent with existing data approach)
