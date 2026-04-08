package com.game;

import com.badlogic.gdx.graphics.glutils.ShapeRenderer;
import com.badlogic.gdx.math.Rectangle;

public class Bullet {
    public float x, y;
    public float width = 6, height = 6;
    private static final float SPEED = 500f;

    public Bullet(float x, float y) {
        this.x = x;
        this.y = y;
    }

    public void update(float dt) {
        y += SPEED * dt;
    }

    public void draw(ShapeRenderer sr) {
        sr.setColor(0.95f, 0.9f, 0.2f, 1);
        sr.rect(x, y, width, height);
    }

    public Rectangle getBounds() {
        return new Rectangle(x, y, width, height);
    }
}
