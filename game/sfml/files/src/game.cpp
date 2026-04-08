#include "game.h"
#include <cstdlib>
#include <ctime>
#include <sstream>

Game::Game()
    : window(sf::VideoMode(800, 600), "{{PROJECT_NAME}}")
    , player(400.f, 550.f)
    , spawnTimer(0.f)
    , spawnInterval(1.5f)
    , score(0)
{
    window.setFramerateLimit(60);
    std::srand(static_cast<unsigned>(std::time(nullptr)));
}

void Game::run() {
    while (window.isOpen()) {
        float dt = clock.restart().asSeconds();
        processEvents();
        update(dt);
        render();
    }
}

void Game::processEvents() {
    sf::Event event;
    while (window.pollEvent(event)) {
        if (event.type == sf::Event::Closed)
            window.close();
        if (event.type == sf::Event::KeyPressed && event.key.code == sf::Keyboard::Escape)
            window.close();
    }
}

void Game::update(float dt) {
    // Player movement
    sf::Vector2f dir(0.f, 0.f);
    if (sf::Keyboard::isKeyPressed(sf::Keyboard::A) || sf::Keyboard::isKeyPressed(sf::Keyboard::Left))
        dir.x -= 1.f;
    if (sf::Keyboard::isKeyPressed(sf::Keyboard::D) || sf::Keyboard::isKeyPressed(sf::Keyboard::Right))
        dir.x += 1.f;
    if (sf::Keyboard::isKeyPressed(sf::Keyboard::W) || sf::Keyboard::isKeyPressed(sf::Keyboard::Up))
        dir.y -= 1.f;
    if (sf::Keyboard::isKeyPressed(sf::Keyboard::S) || sf::Keyboard::isKeyPressed(sf::Keyboard::Down))
        dir.y += 1.f;
    player.update(dt, dir);

    // Shooting
    if (sf::Keyboard::isKeyPressed(sf::Keyboard::Space)) {
        if (player.canShoot()) {
            sf::Vector2f pos = player.getPosition();
            bullets.emplace_back(pos.x, pos.y - 20.f);
            player.resetShootTimer();
        }
    }
    player.updateShootTimer(dt);

    // Update bullets
    for (auto& b : bullets)
        b.update(dt);
    bullets.erase(
        std::remove_if(bullets.begin(), bullets.end(),
            [](const Bullet& b) { return b.isOffScreen(); }),
        bullets.end());

    // Spawn enemies
    spawnTimer += dt;
    if (spawnTimer >= spawnInterval) {
        spawnTimer = 0.f;
        spawnEnemy();
    }

    // Update enemies
    for (auto& e : enemies)
        e.update(dt);
    enemies.erase(
        std::remove_if(enemies.begin(), enemies.end(),
            [](const Enemy& e) { return e.isOffScreen(); }),
        enemies.end());

    // Collision: bullets vs enemies
    for (auto bit = bullets.begin(); bit != bullets.end();) {
        bool hit = false;
        for (auto eit = enemies.begin(); eit != enemies.end();) {
            if (bit->getBounds().intersects(eit->getBounds())) {
                eit = enemies.erase(eit);
                hit = true;
                score += 10;
                break;
            } else {
                ++eit;
            }
        }
        if (hit)
            bit = bullets.erase(bit);
        else
            ++bit;
    }
}

void Game::render() {
    window.clear(sf::Color(20, 20, 30));
    player.draw(window);
    for (auto& b : bullets) b.draw(window);
    for (auto& e : enemies) e.draw(window);
    window.display();
}

void Game::spawnEnemy() {
    float x = static_cast<float>(30 + std::rand() % 740);
    float speed = 100.f + static_cast<float>(std::rand() % 80);
    enemies.emplace_back(x, -30.f, speed);
}
