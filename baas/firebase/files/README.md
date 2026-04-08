# {{PROJECT_NAME}}

[Firebase](https://firebase.google.com/) starter with Firestore, Auth, and Cloud Functions.

## Getting Started

```bash
bash init.sh    # install deps + Firebase emulators
bash run.sh     # start emulators + API
bash stop.sh    # stop everything
```

## Endpoints

| Method | URL | Description |
|--------|-----|-------------|
| POST | `/auth/signup` | Register with email/password |
| POST | `/auth/login` | Sign in and get ID token |
| GET | `/notes` | List user's notes (requires auth) |
| POST | `/notes` | Create a note (requires auth) |
| DELETE | `/notes/:id` | Delete a note (requires auth) |
| GET | `/health` | Health check |

## Firebase Emulators

When running locally, Firebase Emulators provide:
- **Auth Emulator**: `http://localhost:9099`
- **Firestore Emulator**: `http://localhost:8080`
- **Emulator UI**: `http://localhost:4000`

## Project Structure

```
src/
  app.ts              # Express API
  firebase.ts         # Firebase Admin SDK setup
  middleware/auth.ts   # Firebase ID token verification
  routes/auth.ts      # Auth routes
  routes/notes.ts     # Firestore CRUD routes
firebase.json         # Firebase project config
firestore.rules       # Security rules
```

## Requirements

- Node.js 18+
- Java 11+ (for Firebase Emulators)
- Firebase CLI (`npm install -g firebase-tools`)
