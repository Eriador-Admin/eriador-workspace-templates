#include "game.h"
#include <stdlib.h>

static void SpawnEnemy(GameState *state);
static void SpawnBullet(GameState *state);
static bool CheckCollision(Entity *a, Entity *b);

void GameInit(GameState *state) {
    state->player.position = (Vector2){SCREEN_WIDTH / 2.0f - PLAYER_SIZE / 2.0f,
                                        SCREEN_HEIGHT - PLAYER_SIZE - 20.0f};
    state->player.size = (Vector2){PLAYER_SIZE, PLAYER_SIZE};
    state->player.active = true;
    state->score = 0;
    state->enemySpawnTimer = 0.0f;
    state->shootCooldown = 0.0f;

    for (int i = 0; i < MAX_BULLETS; i++) state->bullets[i].active = false;
    for (int i = 0; i < MAX_ENEMIES; i++) state->enemies[i].active = false;
}

void GameUpdate(GameState *state, float dt) {
    /* Player movement */
    float dx = 0, dy = 0;
    if (IsKeyDown(KEY_A) || IsKeyDown(KEY_LEFT))  dx -= 1;
    if (IsKeyDown(KEY_D) || IsKeyDown(KEY_RIGHT)) dx += 1;
    if (IsKeyDown(KEY_W) || IsKeyDown(KEY_UP))    dy -= 1;
    if (IsKeyDown(KEY_S) || IsKeyDown(KEY_DOWN))  dy += 1;

    state->player.position.x += dx * PLAYER_SPEED * dt;
    state->player.position.y += dy * PLAYER_SPEED * dt;

    /* Clamp */
    if (state->player.position.x < 0) state->player.position.x = 0;
    if (state->player.position.x > SCREEN_WIDTH - PLAYER_SIZE)
        state->player.position.x = SCREEN_WIDTH - PLAYER_SIZE;
    if (state->player.position.y < 0) state->player.position.y = 0;
    if (state->player.position.y > SCREEN_HEIGHT - PLAYER_SIZE)
        state->player.position.y = SCREEN_HEIGHT - PLAYER_SIZE;

    /* Shooting */
    state->shootCooldown -= dt;
    if (IsKeyDown(KEY_SPACE) && state->shootCooldown <= 0) {
        SpawnBullet(state);
        state->shootCooldown = 0.25f;
    }

    /* Update bullets */
    for (int i = 0; i < MAX_BULLETS; i++) {
        if (!state->bullets[i].active) continue;
        state->bullets[i].position.y -= BULLET_SPEED * dt;
        if (state->bullets[i].position.y < -BULLET_SIZE)
            state->bullets[i].active = false;
    }

    /* Spawn enemies */
    state->enemySpawnTimer += dt;
    if (state->enemySpawnTimer >= ENEMY_SPAWN_INTERVAL) {
        state->enemySpawnTimer = 0;
        SpawnEnemy(state);
    }

    /* Update enemies */
    for (int i = 0; i < MAX_ENEMIES; i++) {
        if (!state->enemies[i].active) continue;
        state->enemies[i].position.y += (ENEMY_BASE_SPEED + (i % 3) * 20.0f) * dt;
        if (state->enemies[i].position.y > SCREEN_HEIGHT + ENEMY_SIZE)
            state->enemies[i].active = false;
    }

    /* Bullet-enemy collisions */
    for (int i = 0; i < MAX_BULLETS; i++) {
        if (!state->bullets[i].active) continue;
        for (int j = 0; j < MAX_ENEMIES; j++) {
            if (!state->enemies[j].active) continue;
            if (CheckCollision(&state->bullets[i], &state->enemies[j])) {
                state->bullets[i].active = false;
                state->enemies[j].active = false;
                state->score += 10;
                break;
            }
        }
    }

    /* Player-enemy collisions */
    for (int i = 0; i < MAX_ENEMIES; i++) {
        if (!state->enemies[i].active) continue;
        if (CheckCollision(&state->player, &state->enemies[i])) {
            state->enemies[i].active = false;
            state->score -= 5;
            if (state->score < 0) state->score = 0;
        }
    }
}

void GameDraw(const GameState *state) {
    /* Player */
    DrawRectangle((int)state->player.position.x, (int)state->player.position.y,
                  PLAYER_SIZE, PLAYER_SIZE, GREEN);

    /* Bullets */
    for (int i = 0; i < MAX_BULLETS; i++) {
        if (!state->bullets[i].active) continue;
        DrawRectangle((int)state->bullets[i].position.x,
                      (int)state->bullets[i].position.y,
                      BULLET_SIZE, BULLET_SIZE, YELLOW);
    }

    /* Enemies */
    for (int i = 0; i < MAX_ENEMIES; i++) {
        if (!state->enemies[i].active) continue;
        DrawRectangle((int)state->enemies[i].position.x,
                      (int)state->enemies[i].position.y,
                      ENEMY_SIZE, ENEMY_SIZE, RED);
    }

    /* HUD */
    DrawText(TextFormat("Score: %d", state->score), 10, 10, 24, WHITE);
}

static void SpawnBullet(GameState *state) {
    for (int i = 0; i < MAX_BULLETS; i++) {
        if (state->bullets[i].active) continue;
        state->bullets[i].position = (Vector2){
            state->player.position.x + PLAYER_SIZE / 2.0f - BULLET_SIZE / 2.0f,
            state->player.position.y
        };
        state->bullets[i].size = (Vector2){BULLET_SIZE, BULLET_SIZE};
        state->bullets[i].active = true;
        return;
    }
}

static void SpawnEnemy(GameState *state) {
    for (int i = 0; i < MAX_ENEMIES; i++) {
        if (state->enemies[i].active) continue;
        state->enemies[i].position = (Vector2){
            (float)(rand() % (SCREEN_WIDTH - ENEMY_SIZE)),
            -ENEMY_SIZE
        };
        state->enemies[i].size = (Vector2){ENEMY_SIZE, ENEMY_SIZE};
        state->enemies[i].active = true;
        return;
    }
}

static bool CheckCollision(Entity *a, Entity *b) {
    return a->position.x < b->position.x + b->size.x &&
           a->position.x + a->size.x > b->position.x &&
           a->position.y < b->position.y + b->size.y &&
           a->position.y + a->size.y > b->position.y;
}
