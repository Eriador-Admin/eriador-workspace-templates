#pragma once
#include <SFML/Graphics.hpp>

class Player {
public:
    Player(float x, float y);
    void update(float dt, const sf::Vector2f& direction);
    void draw(sf::RenderWindow& window);
    sf::Vector2f getPosition() const;
    bool canShoot() const;
    void resetShootTimer();
    void updateShootTimer(float dt);

private:
    sf::RectangleShape shape;
    float speed;
    float shootTimer;
    float shootCooldown;
};
