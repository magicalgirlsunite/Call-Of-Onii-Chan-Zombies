using UdonSharp;
using UnityEngine;
using VRC.SDKBase;

public class DamageOnTouch : UdonSharpBehaviour
{
    // The amount of damage to apply per second
    [SerializeField]
    private float _damagePerSecond = 10f;
    
    // Reference to the HealthBar component
    private HealthBar _healthBar;
    
    public void Start()
    {
        // Get the HealthBar component from the local player
        _healthBar = PersistenceUtilities.GetPlayerObjectComponent<HealthBar>(Networking.LocalPlayer);
    }

    public override void OnPlayerTriggerStay(VRCPlayerApi player)
    {
        // If the player is local, apply damage to the health bar
        if (player.isLocal)
        {
            _healthBar.TakeDamage(_damagePerSecond * Time.deltaTime);
        }
    }
}
