using UnityEngine;

/// <summary>
/// Singleton game manager that persists across scenes.
/// Handles game state, score, and level management.
/// </summary>
public class GameManager : MonoBehaviour
{
    public static GameManager Instance { get; private set; }

    [Header("Game State")]
    [SerializeField] private int startingLives = 3;

    private int _score;
    private int _lives;
    private bool _isGameOver;

    public int Score => _score;
    public int Lives => _lives;
    public bool IsGameOver => _isGameOver;

    private void Awake()
    {
        if (Instance != null && Instance != this)
        {
            Destroy(gameObject);
            return;
        }

        Instance = this;
        DontDestroyOnLoad(gameObject);
        InitializeGame();
    }

    public void InitializeGame()
    {
        _score = 0;
        _lives = startingLives;
        _isGameOver = false;
        Debug.Log("Game initialized");
    }

    public void AddScore(int points)
    {
        if (_isGameOver) return;
        _score += points;
        Debug.Log($"Score: {_score}");
    }

    public void LoseLife()
    {
        if (_isGameOver) return;
        _lives--;
        Debug.Log($"Lives remaining: {_lives}");

        if (_lives <= 0)
        {
            GameOver();
        }
    }

    private void GameOver()
    {
        _isGameOver = true;
        Debug.Log($"Game Over! Final score: {_score}");
    }

    public void RestartGame()
    {
        InitializeGame();
        UnityEngine.SceneManagement.SceneManager.LoadScene(
            UnityEngine.SceneManagement.SceneManager.GetActiveScene().buildIndex
        );
    }
}
