using Microsoft.Xna.Framework;

namespace {{PROJECT_NAME}};

public class Enemy
{
    public float X, Y;
    public int Width = 28, Height = 28;
    private float _speed;

    public Rectangle Bounds => new((int)X, (int)Y, Width, Height);

    public Enemy(float x, float y, float speed)
    {
        X = x;
        Y = y;
        _speed = speed;
    }

    public void Update(float dt)
    {
        Y += _speed * dt;
    }
}
