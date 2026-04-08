"""Main game class — init, loop, events, update, draw."""

import sys
import pygame
from src.settings import (
    SCREEN_WIDTH, SCREEN_HEIGHT, FPS, TITLE,
    BLACK, WHITE, ENEMY_SPAWN_RATE,
)
from src.player import Player
from src.enemy import Enemy


class Game:
    def __init__(self):
        pygame.init()
        self.screen = pygame.display.set_mode((SCREEN_WIDTH, SCREEN_HEIGHT))
        pygame.display.set_caption(TITLE)
        self.clock = pygame.time.Clock()

        self.all_sprites = pygame.sprite.Group()
        self.enemies = pygame.sprite.Group()
        self.bullets = pygame.sprite.Group()

        self.player = Player(self)
        self.all_sprites.add(self.player)

        self.score = 0
        self.font = pygame.font.Font(None, 36)
        self.running = True

        self.last_enemy_spawn = pygame.time.get_ticks()

    def run(self):
        while self.running:
            self.clock.tick(FPS)
            self._handle_events()
            self._update()
            self._draw()
        pygame.quit()
        sys.exit()

    def _handle_events(self):
        for event in pygame.event.get():
            if event.type == pygame.QUIT:
                self.running = False
            elif event.type == pygame.KEYDOWN:
                if event.key == pygame.K_ESCAPE:
                    self.running = False

    def _update(self):
        self.all_sprites.update()

        # Spawn enemies
        now = pygame.time.get_ticks()
        if now - self.last_enemy_spawn > ENEMY_SPAWN_RATE:
            enemy = Enemy(self)
            self.all_sprites.add(enemy)
            self.enemies.add(enemy)
            self.last_enemy_spawn = now

        # Bullet-enemy collisions
        hits = pygame.sprite.groupcollide(self.bullets, self.enemies, True, True)
        for hit in hits:
            self.score += 10

        # Player-enemy collisions
        if pygame.sprite.spritecollide(self.player, self.enemies, True):
            self.score = max(0, self.score - 5)

    def _draw(self):
        self.screen.fill(BLACK)
        self.all_sprites.draw(self.screen)

        # HUD
        score_text = self.font.render(f"Score: {self.score}", True, WHITE)
        self.screen.blit(score_text, (10, 10))

        pygame.display.flip()
