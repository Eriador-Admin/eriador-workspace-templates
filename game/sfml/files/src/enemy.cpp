#include "enemy.h"

Enemy::Enemy(float x, float y, float speed)
    : speed(speed)
{
    shape.setSize(sf::Vector2f(28.f, 28.f));
    shape.setOrigin(14.f, 14.f);
    shape.setPosition(x, y);
    shape.setFillColor(sf::Color::Red);
}

void Enemy::update(float dt) {
    shape.move(0.f, speed * dt);
}

void Enemy::draw(sf::RenderWindow& window) {
    window.draw(shape);
}

bool Enemy::isOffScreen() const {
    return shape.getPosition().y > 630.f;
}

sf::FloatRect Enemy::getBounds() const {
    return shape.getGlobalBounds();
}
