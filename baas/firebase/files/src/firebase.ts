import { initializeApp, cert, type ServiceAccount } from "firebase-admin/app";
import { getFirestore } from "firebase-admin/firestore";
import { getAuth } from "firebase-admin/auth";

const projectId = process.env.FIREBASE_PROJECT_ID || "demo-project";

if (process.env.GOOGLE_APPLICATION_CREDENTIALS) {
  initializeApp({ credential: cert(process.env.GOOGLE_APPLICATION_CREDENTIALS as unknown as ServiceAccount) });
} else {
  initializeApp({ projectId });
}

export const db = getFirestore();
export const auth = getAuth();
