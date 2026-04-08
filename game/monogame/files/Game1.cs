using System;
using System.Collections.Generic;
using Microsoft.Xna.Framework;
using Microsoft.Xna.Framework.Graphics;
using Microsoft.Xna.Framework.Input;

namespace {{PROJECT_NAME}};

public class Game1 : Game
{
    private GraphicsDeviceManager _graphics;
    private SpriteBatch _spriteBatch;
    private SpriteFont _font;

    private const int ScreenWidth = 800;
    private const int ScreenHeight = 600;

    private Player _player;
    private List<Enemy> _enemies = new();
    private List<Bullet> _bullets = new();
    private int _score;

    private float _enemySpawnTimer;
    private const float SpawnInterval = 1.5f;

    private Random _random = new();
    private Texture2D _pixel;

    public Game1()
    {
        _graphics = new GraphicsDeviceManager(this)
        {
            PreferredBackBufferWidth = ScreenWidth,
            PreferredBackBufferHeight = ScreenHeight
        };
        Content.RootDirectory = "Content";
        IsMouseVisible = true;
        Window.Title = "{{PROJECT_NAME}}";
    }

    protected override void Initialize()
    {
        _player = new Player(ScreenWidth / 2 - 16, ScreenHeight - 60);
        base.Initialize();
    }

    protected override void LoadContent()
    {
        _spriteBatch = new SpriteBatch(GraphicsDevice);

        // Create a 1x1 white pixel texture for drawing rectangles
        _pixel = new Texture2D(GraphicsDevice, 1, 1);
        _pixel.SetData(new[] { Color.White });
    }

    protected override void Update(GameTime gameTime)
    {
        var kb = Keyboard.GetState();
        float dt = (float)gameTime.ElapsedGameTime.TotalSeconds;

        if (kb.IsKeyDown(Keys.Escape))
            Exit();

        _player.Update(dt, kb, ScreenWidth, ScreenHeight);

        // Shooting
        if (kb.IsKeyDown(Keys.Space))
            _player.TryShoot(dt, _bullets);

        // Update bullets
        for (int i = _bullets.Count - 1; i >= 0; i--)
        {
            _bullets[i].Update(dt);
            if (_bullets[i].Y < -10) _bullets.RemoveAt(i);
        }

        // Spawn enemies
        _enemySpawnTimer += dt;
        if (_enemySpawnTimer >= SpawnInterval)
        {
            _enemySpawnTimer = 0;
            _enemies.Add(new Enemy(_random.Next(0, ScreenWidth - 28), -28, 100 + _random.Next(60)));
        }

        // Update enemies
        for (int i = _enemies.Count - 1; i >= 0; i--)
        {
            _enemies[i].Update(dt);
            if (_enemies[i].Y > ScreenHeight + 28) _enemies.RemoveAt(i);
        }

        // Bullet-enemy collision
        for (int i = _bullets.Count - 1; i >= 0; i--)
        {
            for (int j = _enemies.Count - 1; j >= 0; j--)
            {
                if (_bullets[i].Bounds.Intersects(_enemies[j].Bounds))
                {
                    _bullets.RemoveAt(i);
                    _enemies.RemoveAt(j);
                    _score += 10;
                    break;
                }
            }
        }

        // Player-enemy collision
        for (int i = _enemies.Count - 1; i >= 0; i--)
        {
            if (_player.Bounds.Intersects(_enemies[i].Bounds))
            {
                _enemies.RemoveAt(i);
                _score = Math.Max(0, _score - 5);
            }
        }

        base.Update(gameTime);
    }

    protected override void Draw(GameTime gameTime)
    {
        GraphicsDevice.Clear(new Color(20, 20, 30));

        _spriteBatch.Begin();

        // Player
        _spriteBatch.Draw(_pixel, _player.Bounds, new Color(50, 200, 80));

        // Bullets
        foreach (var b in _bullets)
            _spriteBatch.Draw(_pixel, b.Bounds, new Color(240, 230, 50));

        // Enemies
        foreach (var e in _enemies)
            _spriteBatch.Draw(_pixel, e.Bounds, new Color(220, 50, 50));

        _spriteBatch.End();

        base.Draw(gameTime);
    }
}
