#pragma once
#include <SFML/Graphics.hpp>

class Bullet {
public:
    Bullet(float x, float y);
    void update(float dt);
    void draw(sf::RenderWindow& window);
    bool isOffScreen() const;
    sf::FloatRect getBounds() const;

private:
    sf::RectangleShape shape;
    float speed;
};
