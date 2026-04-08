package com.game;

import com.badlogic.gdx.ApplicationAdapter;
import com.badlogic.gdx.Gdx;
import com.badlogic.gdx.Input;
import com.badlogic.gdx.graphics.Color;
import com.badlogic.gdx.graphics.GL20;
import com.badlogic.gdx.graphics.g2d.BitmapFont;
import com.badlogic.gdx.graphics.g2d.SpriteBatch;
import com.badlogic.gdx.graphics.glutils.ShapeRenderer;
import com.badlogic.gdx.math.MathUtils;
import com.badlogic.gdx.math.Rectangle;
import com.badlogic.gdx.utils.Array;

public class MyGame extends ApplicationAdapter {
    public static final int WIDTH = 800;
    public static final int HEIGHT = 600;

    private ShapeRenderer shapeRenderer;
    private SpriteBatch batch;
    private BitmapFont font;

    private Player player;
    private Array<Bullet> bullets;
    private Array<Enemy> enemies;
    private int score;

    private float enemySpawnTimer;
    private static final float SPAWN_INTERVAL = 1.5f;

    private float shootCooldown;
    private static final float SHOOT_INTERVAL = 0.25f;

    @Override
    public void create() {
        shapeRenderer = new ShapeRenderer();
        batch = new SpriteBatch();
        font = new BitmapFont();
        font.setColor(Color.WHITE);

        player = new Player(WIDTH / 2f - 16, 40);
        bullets = new Array<>();
        enemies = new Array<>();
        score = 0;
    }

    @Override
    public void render() {
        float dt = Gdx.graphics.getDeltaTime();

        if (Gdx.input.isKeyPressed(Input.Keys.ESCAPE)) {
            Gdx.app.exit();
        }

        update(dt);

        Gdx.gl.glClearColor(0.08f, 0.08f, 0.12f, 1);
        Gdx.gl.glClear(GL20.GL_COLOR_BUFFER_BIT);

        shapeRenderer.begin(ShapeRenderer.ShapeType.Filled);
        player.draw(shapeRenderer);
        for (Bullet b : bullets) b.draw(shapeRenderer);
        for (Enemy e : enemies) e.draw(shapeRenderer);
        shapeRenderer.end();

        batch.begin();
        font.draw(batch, "Score: " + score, 10, HEIGHT - 10);
        batch.end();
    }

    private void update(float dt) {
        player.update(dt);

        // Shooting
        shootCooldown -= dt;
        if (Gdx.input.isKeyPressed(Input.Keys.SPACE) && shootCooldown <= 0) {
            bullets.add(new Bullet(player.x + player.width / 2 - 3, player.y + player.height));
            shootCooldown = SHOOT_INTERVAL;
        }

        // Update bullets
        for (int i = bullets.size - 1; i >= 0; i--) {
            bullets.get(i).update(dt);
            if (bullets.get(i).y > HEIGHT) bullets.removeIndex(i);
        }

        // Spawn enemies
        enemySpawnTimer += dt;
        if (enemySpawnTimer >= SPAWN_INTERVAL) {
            enemySpawnTimer = 0;
            float x = MathUtils.random(0, WIDTH - 28);
            enemies.add(new Enemy(x, HEIGHT));
        }

        // Update enemies
        for (int i = enemies.size - 1; i >= 0; i--) {
            enemies.get(i).update(dt);
            if (enemies.get(i).y < -28) enemies.removeIndex(i);
        }

        // Bullet-enemy collision
        for (int i = bullets.size - 1; i >= 0; i--) {
            Rectangle br = bullets.get(i).getBounds();
            for (int j = enemies.size - 1; j >= 0; j--) {
                if (br.overlaps(enemies.get(j).getBounds())) {
                    bullets.removeIndex(i);
                    enemies.removeIndex(j);
                    score += 10;
                    break;
                }
            }
        }

        // Player-enemy collision
        Rectangle pr = player.getBounds();
        for (int i = enemies.size - 1; i >= 0; i--) {
            if (pr.overlaps(enemies.get(i).getBounds())) {
                enemies.removeIndex(i);
                score = Math.max(0, score - 5);
            }
        }
    }

    @Override
    public void dispose() {
        shapeRenderer.dispose();
        batch.dispose();
        font.dispose();
    }
}
