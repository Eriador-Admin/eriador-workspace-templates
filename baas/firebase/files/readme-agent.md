# Agent Instructions — {{PROJECT_NAME}}

This is a Firebase BaaS project.

## Tech Stack
- **BaaS**: Firebase (Firestore, Auth, Storage)
- **App Server**: Express + TypeScript
- **Admin SDK**: firebase-admin
- **Local Dev**: Firebase Emulators

## Key Conventions
- Entry point: `src/app.ts`
- Firebase Admin in `src/firebase.ts`
- Auth middleware verifies Firebase ID tokens
- Firestore security rules in `firestore.rules`
- Use emulators for local development (no billing)
