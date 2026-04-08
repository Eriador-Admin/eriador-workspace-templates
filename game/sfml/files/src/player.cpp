#include "player.h"
#include <cmath>

Player::Player(float x, float y)
    : speed(300.f)
    , shootTimer(0.f)
    , shootCooldown(0.25f)
{
    shape.setSize(sf::Vector2f(32.f, 32.f));
    shape.setOrigin(16.f, 16.f);
    shape.setPosition(x, y);
    shape.setFillColor(sf::Color::Green);
}

void Player::update(float dt, const sf::Vector2f& direction) {
    sf::Vector2f dir = direction;
    float len = std::sqrt(dir.x * dir.x + dir.y * dir.y);
    if (len > 0.f) {
        dir /= len;
    }

    sf::Vector2f pos = shape.getPosition() + dir * speed * dt;
    pos.x = std::max(16.f, std::min(pos.x, 784.f));
    pos.y = std::max(16.f, std::min(pos.y, 584.f));
    shape.setPosition(pos);
}

void Player::draw(sf::RenderWindow& window) {
    window.draw(shape);
}

sf::Vector2f Player::getPosition() const {
    return shape.getPosition();
}

bool Player::canShoot() const {
    return shootTimer <= 0.f;
}

void Player::resetShootTimer() {
    shootTimer = shootCooldown;
}

void Player::updateShootTimer(float dt) {
    if (shootTimer > 0.f)
        shootTimer -= dt;
}
