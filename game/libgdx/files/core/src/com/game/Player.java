package com.game;

import com.badlogic.gdx.Gdx;
import com.badlogic.gdx.Input;
import com.badlogic.gdx.graphics.Color;
import com.badlogic.gdx.graphics.glutils.ShapeRenderer;
import com.badlogic.gdx.math.Rectangle;

public class Player {
    public float x, y;
    public float width = 32, height = 32;
    private static final float SPEED = 300f;

    public Player(float x, float y) {
        this.x = x;
        this.y = y;
    }

    public void update(float dt) {
        if (Gdx.input.isKeyPressed(Input.Keys.A) || Gdx.input.isKeyPressed(Input.Keys.LEFT))
            x -= SPEED * dt;
        if (Gdx.input.isKeyPressed(Input.Keys.D) || Gdx.input.isKeyPressed(Input.Keys.RIGHT))
            x += SPEED * dt;
        if (Gdx.input.isKeyPressed(Input.Keys.W) || Gdx.input.isKeyPressed(Input.Keys.UP))
            y += SPEED * dt;
        if (Gdx.input.isKeyPressed(Input.Keys.S) || Gdx.input.isKeyPressed(Input.Keys.DOWN))
            y -= SPEED * dt;

        x = Math.max(0, Math.min(x, MyGame.WIDTH - width));
        y = Math.max(0, Math.min(y, MyGame.HEIGHT - height));
    }

    public void draw(ShapeRenderer sr) {
        sr.setColor(0.2f, 0.8f, 0.3f, 1);
        sr.rect(x, y, width, height);
    }

    public Rectangle getBounds() {
        return new Rectangle(x, y, width, height);
    }
}
