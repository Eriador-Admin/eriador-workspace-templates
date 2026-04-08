#ifndef GAME_H
#define GAME_H

#include "raylib.h"

#define SCREEN_WIDTH 800
#define SCREEN_HEIGHT 600
#define MAX_BULLETS 64
#define MAX_ENEMIES 32

#define PLAYER_SIZE 32
#define PLAYER_SPEED 300.0f

#define BULLET_SIZE 6
#define BULLET_SPEED 500.0f

#define ENEMY_SIZE 28
#define ENEMY_BASE_SPEED 120.0f
#define ENEMY_SPAWN_INTERVAL 1.5f

typedef struct {
    Vector2 position;
    Vector2 size;
    bool active;
} Entity;

typedef struct {
    Entity player;
    Entity bullets[MAX_BULLETS];
    Entity enemies[MAX_ENEMIES];
    int score;
    float enemySpawnTimer;
    float shootCooldown;
} GameState;

void GameInit(GameState *state);
void GameUpdate(GameState *state, float dt);
void GameDraw(const GameState *state);

#endif
