"""Bullet sprite fired by the player."""

import pygame
from src.settings import BULLET_SPEED, BULLET_SIZE, BULLET_COLOR


class Bullet(pygame.sprite.Sprite):
    def __init__(self, x, y):
        super().__init__()
        self.image = pygame.Surface((BULLET_SIZE, BULLET_SIZE))
        self.image.fill(BULLET_COLOR)
        self.rect = self.image.get_rect(center=(x, y))

    def update(self):
        self.rect.y -= BULLET_SPEED

        # Remove if off screen
        if self.rect.bottom < 0:
            self.kill()
