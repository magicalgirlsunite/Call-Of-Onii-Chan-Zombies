using UdonSharp;
using UnityEngine;
using VRC.SDKBase;
using VRC.Udon;

public class DashAndDoubleJump : UdonSharpBehaviour
{
    [Header("Dash Variables")] // Dash Variables
    public float dashSpeed = 8.0f; // Dash speed
    public float dashDuration = 0.2f; // Dash duration
    public float dashCooldownTime = 2.0f; // Cooldown duration
    public float dashDoubleTapThreshold = 0.3f; // Max time between taps to activate dash
    [SerializeField] private AudioSource dashAudioSource; // Dash sound
    [SerializeField] private AudioSource dashReadyAudioSource; // Dash ready sound

    [Header("Double Jump Variables")] // Double Jump Variables
    public float jumpForce = 3.5f; // Jump force
    [SerializeField] public int maxJumps = 2; // Maximum jumps
    private int jumpCount = 0; // Keeps track of jumps
    [SerializeField] private AudioSource jumpAudioSource; // Double jump sound

    private VRCPlayerApi localPlayer;
    private bool canDash = true;
    private bool isDashing = false;
    private bool firstDashTap = false;
    private float lastDashTapTime = 0f;
    private bool keyReleased = true;

    void Start()
    {
        localPlayer = Networking.LocalPlayer;

        if (localPlayer == null)
        {
            UnityEngine.Debug.LogError("Local Player not found!");
            return;
        }

        if (dashAudioSource == null || dashReadyAudioSource == null || jumpAudioSource == null)
        {
            UnityEngine.Debug.LogError("One or more AudioSources are not assigned!");
        }
    }

    void Update()
    {
        if (localPlayer == null || isDashing) return;

        bool forwardPressed = Input.GetKeyDown(KeyCode.W);
        bool forwardReleased = Input.GetKeyUp(KeyCode.W);

        float vrForwardAxis = Input.GetAxisRaw("Vertical");
        bool vrForwardPressed = vrForwardAxis > 0.9f;
        bool vrForwardReleased = vrForwardAxis < 0.1f;

        if (forwardReleased || vrForwardReleased)
        {
            keyReleased = true;
        }

        if ((forwardPressed || vrForwardPressed) && keyReleased)
        {
            keyReleased = false;
            float currentTime = Time.time;

            if (firstDashTap && (currentTime - lastDashTapTime) <= dashDoubleTapThreshold)
            {
                StartDash();
                firstDashTap = false;
            }
            else
            {
                firstDashTap = true;
                lastDashTapTime = currentTime;
            }
        }

        if (localPlayer.IsPlayerGrounded())
        {
            jumpCount = 0;
        }
    }

    private void StartDash()
    {
        if (!canDash) return;

        Vector3 dashDirection = localPlayer.GetRotation() * Vector3.forward;
        isDashing = true;
        canDash = false;

        localPlayer.SetVelocity(dashDirection * dashSpeed);

        if (dashAudioSource != null)
        {
            dashAudioSource.Play();
        }
        else
        {
            UnityEngine.Debug.LogError("Dash AudioSource not assigned, unable to play sound!");
        }

        SendCustomEventDelayedSeconds(nameof(StopDash), dashDuration);

        SendCustomEventDelayedSeconds(nameof(ResetDash), dashCooldownTime);
    }

    public void StopDash()
    {
        isDashing = false;
    }

    public void ResetDash()
    {
        canDash = true;

        if (dashReadyAudioSource != null)
        {
            dashReadyAudioSource.Play();
        }
        else
        {
            UnityEngine.Debug.LogError("Dash Ready AudioSource not assigned, unable to play sound!");
        }
    }

    public override void InputJump(bool value, VRC.Udon.Common.UdonInputEventArgs args)
    {
        if (!value || localPlayer == null) return;

        if (jumpCount < maxJumps)
        {
            Jump();
        }
    }

    private void Jump()
    {
        Vector3 velocity = localPlayer.GetVelocity();
        velocity.y = jumpForce;
        localPlayer.SetVelocity(velocity);

        jumpCount++;
        jumpAudioSource.Play();
    }
}
