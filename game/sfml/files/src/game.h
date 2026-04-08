#pragma once
#include <SFML/Graphics.hpp>
#include <vector>
#include "player.h"
#include "enemy.h"
#include "bullet.h"

class Game {
public:
    Game();
    void run();

private:
    void processEvents();
    void update(float dt);
    void render();
    void spawnEnemy();

    sf::RenderWindow window;
    Player player;
    std::vector<Bullet> bullets;
    std::vector<Enemy> enemies;

    sf::Clock clock;
    float spawnTimer;
    float spawnInterval;
    int score;
};
