#include "game.h"

int main(void) {
    InitWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "{{PROJECT_NAME}}");
    SetTargetFPS(60);

    GameState state;
    GameInit(&state);

    while (!WindowShouldClose()) {
        float dt = GetFrameTime();
        GameUpdate(&state, dt);

        BeginDrawing();
        ClearBackground((Color){20, 20, 30, 255});
        GameDraw(&state);
        EndDrawing();
    }

    CloseWindow();
    return 0;
}
