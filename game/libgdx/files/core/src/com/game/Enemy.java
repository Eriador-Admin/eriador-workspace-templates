package com.game;

import com.badlogic.gdx.graphics.glutils.ShapeRenderer;
import com.badlogic.gdx.math.Rectangle;

public class Enemy {
    public float x, y;
    public float width = 28, height = 28;
    private float speed;

    public Enemy(float x, float y) {
        this.x = x;
        this.y = y;
        this.speed = 120 + (float)(Math.random() * 60);
    }

    public void update(float dt) {
        y -= speed * dt;
    }

    public void draw(ShapeRenderer sr) {
        sr.setColor(0.85f, 0.2f, 0.2f, 1);
        sr.rect(x, y, width, height);
    }

    public Rectangle getBounds() {
        return new Rectangle(x, y, width, height);
    }
}
