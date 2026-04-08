#include "bullet.h"

Bullet::Bullet(float x, float y)
    : speed(500.f)
{
    shape.setSize(sf::Vector2f(6.f, 14.f));
    shape.setOrigin(3.f, 7.f);
    shape.setPosition(x, y);
    shape.setFillColor(sf::Color::Yellow);
}

void Bullet::update(float dt) {
    shape.move(0.f, -speed * dt);
}

void Bullet::draw(sf::RenderWindow& window) {
    window.draw(shape);
}

bool Bullet::isOffScreen() const {
    return shape.getPosition().y < -20.f;
}

sf::FloatRect Bullet::getBounds() const {
    return shape.getGlobalBounds();
}
