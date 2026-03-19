from fastapi import FastAPI, Depends, HTTPException, Security
from fastapi.middleware.cors import CORSMiddleware
from fastapi.security import HTTPBearer, HTTPAuthorizationCredentials
import os
import hmac
from dotenv import load_dotenv
from app.routes import router

load_dotenv()

app = FastAPI(title="{{APP_NAME}}", version="1.0.0")

# ── Authentication dependency ──
# Set API_TOKEN in your .env file. All /api/* routes require a valid Bearer token.
_security = HTTPBearer()

def verify_token(credentials: HTTPAuthorizationCredentials = Security(_security)):
    api_token = os.environ.get("API_TOKEN")
    if not api_token:
        raise HTTPException(status_code=500, detail="API_TOKEN not configured")
    if not hmac.compare_digest(credentials.credentials, api_token):
        raise HTTPException(status_code=401, detail="Invalid or expired token")
    return credentials.credentials

app.add_middleware(
    CORSMiddleware,
    allow_origins=[os.environ.get("CORS_ORIGIN", "http://localhost:5173")],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

app.include_router(router, prefix="/api", dependencies=[Depends(verify_token)])

@app.get("/health")
def health():
    return {"status": "ok"}
