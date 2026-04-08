using Microsoft.Xna.Framework;

namespace {{PROJECT_NAME}};

public class Bullet
{
    public float X, Y;
    public int Width = 6, Height = 6;
    private const float Speed = 500f;

    public Rectangle Bounds => new((int)X, (int)Y, Width, Height);

    public Bullet(float x, float y)
    {
        X = x;
        Y = y;
    }

    public void Update(float dt)
    {
        Y -= Speed * dt;
    }
}
