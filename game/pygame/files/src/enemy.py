"""Enemy sprite with basic downward movement."""

import random
import pygame
from src.settings import (
    SCREEN_WIDTH, SCREEN_HEIGHT,
    ENEMY_SPEED, ENEMY_SIZE, ENEMY_COLOR,
)


class Enemy(pygame.sprite.Sprite):
    def __init__(self, game):
        super().__init__()
        self.game = game
        self.image = pygame.Surface((ENEMY_SIZE, ENEMY_SIZE))
        self.image.fill(ENEMY_COLOR)
        self.rect = self.image.get_rect(
            center=(random.randint(ENEMY_SIZE, SCREEN_WIDTH - ENEMY_SIZE), -ENEMY_SIZE)
        )
        self.speed = ENEMY_SPEED + random.uniform(-0.5, 1.0)

    def update(self):
        self.rect.y += self.speed

        # Remove if off screen
        if self.rect.top > SCREEN_HEIGHT:
            self.kill()
