using System.Collections.Generic;
using Microsoft.Xna.Framework;
using Microsoft.Xna.Framework.Input;

namespace {{PROJECT_NAME}};

public class Player
{
    public float X, Y;
    public int Width = 32, Height = 32;
    private const float Speed = 300f;
    private float _shootCooldown;
    private const float ShootInterval = 0.25f;

    public Rectangle Bounds => new((int)X, (int)Y, Width, Height);

    public Player(float x, float y)
    {
        X = x;
        Y = y;
    }

    public void Update(float dt, KeyboardState kb, int screenW, int screenH)
    {
        if (kb.IsKeyDown(Keys.A) || kb.IsKeyDown(Keys.Left)) X -= Speed * dt;
        if (kb.IsKeyDown(Keys.D) || kb.IsKeyDown(Keys.Right)) X += Speed * dt;
        if (kb.IsKeyDown(Keys.W) || kb.IsKeyDown(Keys.Up)) Y -= Speed * dt;
        if (kb.IsKeyDown(Keys.S) || kb.IsKeyDown(Keys.Down)) Y += Speed * dt;

        X = MathHelper.Clamp(X, 0, screenW - Width);
        Y = MathHelper.Clamp(Y, 0, screenH - Height);

        _shootCooldown -= dt;
    }

    public void TryShoot(float dt, List<Bullet> bullets)
    {
        if (_shootCooldown > 0) return;
        _shootCooldown = ShootInterval;
        bullets.Add(new Bullet(X + Width / 2f - 3, Y));
    }
}
