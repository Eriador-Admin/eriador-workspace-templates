using UnityEngine;

/// <summary>
/// Basic player movement controller.
/// Supports WASD/arrow keys for 2D or 3D movement.
/// Attach to a GameObject with a Rigidbody or Rigidbody2D.
/// </summary>
public class PlayerController : MonoBehaviour
{
    [Header("Movement")]
    [SerializeField] private float moveSpeed = 5f;
    [SerializeField] private float jumpForce = 10f;
    [SerializeField] private bool use2DPhysics = true;

    [Header("Ground Check")]
    [SerializeField] private Transform groundCheck;
    [SerializeField] private float groundCheckRadius = 0.2f;
    [SerializeField] private LayerMask groundLayer;

    private Rigidbody2D _rb2D;
    private Rigidbody _rb3D;
    private bool _isGrounded;
    private Vector2 _moveInput;

    private void Awake()
    {
        if (use2DPhysics)
            _rb2D = GetComponent<Rigidbody2D>();
        else
            _rb3D = GetComponent<Rigidbody>();
    }

    private void Update()
    {
        _moveInput.x = Input.GetAxisRaw("Horizontal");
        _moveInput.y = Input.GetAxisRaw("Vertical");

        if (Input.GetButtonDown("Jump") && _isGrounded)
        {
            Jump();
        }
    }

    private void FixedUpdate()
    {
        CheckGround();

        if (use2DPhysics && _rb2D != null)
        {
            _rb2D.linearVelocity = new Vector2(
                _moveInput.x * moveSpeed,
                _rb2D.linearVelocity.y
            );
        }
        else if (_rb3D != null)
        {
            Vector3 movement = new Vector3(_moveInput.x, 0f, _moveInput.y) * moveSpeed;
            _rb3D.linearVelocity = new Vector3(movement.x, _rb3D.linearVelocity.y, movement.z);
        }
    }

    private void Jump()
    {
        if (use2DPhysics && _rb2D != null)
            _rb2D.AddForce(Vector2.up * jumpForce, ForceMode2D.Impulse);
        else if (_rb3D != null)
            _rb3D.AddForce(Vector3.up * jumpForce, ForceMode.Impulse);
    }

    private void CheckGround()
    {
        if (groundCheck == null) return;

        _isGrounded = Physics2D.OverlapCircle(
            groundCheck.position, groundCheckRadius, groundLayer
        );
    }
}
