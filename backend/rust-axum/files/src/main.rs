use axum::{routing::{get, post}, http::StatusCode, Json, Router};
use serde::{Deserialize, Serialize};
use std::sync::{Arc, Mutex};
use std::sync::atomic::{AtomicUsize, Ordering};
use tower_http::cors::{CorsLayer, Any};
use std::env;

#[derive(Serialize, Clone)]
struct Item {
    id: usize,
    name: String,
}

#[derive(Deserialize)]
struct CreateItemRequest {
    name: String,
}

struct SharedState {
    items: Mutex<Vec<Item>>,
    next_id: AtomicUsize,
}

type AppState = Arc<SharedState>;

async fn list_items(state: axum::extract::State<AppState>) -> Result<Json<Vec<Item>>, StatusCode> {
    let items = state.items.lock().map_err(|_| StatusCode::INTERNAL_SERVER_ERROR)?;
    Ok(Json(items.clone()))
}

async fn create_item(
    state: axum::extract::State<AppState>,
    Json(input): Json<CreateItemRequest>,
) -> Result<Json<Item>, StatusCode> {
    if input.name.trim().is_empty() {
        return Err(StatusCode::BAD_REQUEST);
    }
    let mut items = state.items.lock().map_err(|_| StatusCode::INTERNAL_SERVER_ERROR)?;
    let item = Item {
        id: state.next_id.fetch_add(1, Ordering::SeqCst) + 1,
        name: input.name,
    };
    items.push(item.clone());
    Ok(Json(item))
}

#[tokio::main]
async fn main() {
    let _ = dotenvy::dotenv();
    let state: AppState = Arc::new(SharedState {
        items: Mutex::new(Vec::new()),
        next_id: AtomicUsize::new(0),
    });
    let cors_origin = env::var("CORS_ORIGIN").unwrap_or_else(|_| "http://localhost:5173".to_string());
    let cors = CorsLayer::new()
        .allow_origin(cors_origin.parse::<axum::http::HeaderValue>().unwrap_or_else(|_| {
            eprintln!("WARN: invalid CORS_ORIGIN '{}', falling back to localhost", cors_origin);
            "http://localhost:5173".parse().unwrap()
        }))
        .allow_methods(Any)
        .allow_headers(Any);

    let app = Router::new()
        .route("/health", get(|| async { Json(serde_json::json!({"status": "ok"})) }))
        .route("/api/items", get(list_items).post(create_item))
        .layer(cors)
        .with_state(state);
    let port = env::var("PORT").unwrap_or_else(|_| "3000".to_string());
    let addr = format!("0.0.0.0:{}", port);
    let listener = tokio::net::TcpListener::bind(&addr).await.expect("Failed to bind address");
    println!("Listening on :{}", port);
    axum::serve(listener, app).await.expect("Server error");
}
