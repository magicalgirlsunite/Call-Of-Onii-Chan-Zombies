using UdonSharp;
using UnityEngine;
using UnityEngine.UI;
using VRC.SDKBase;

public class HealthBar : UdonSharpBehaviour
{
    // The health of the player
    [UdonSynced]
    private float health = 100f;
    // The maximum health of the player
    [SerializeField]
    public float _maxHealth = 100f;
    // The offset of the healthbar above the player's head
    [SerializeField]
    private Vector3 _offsetAboaveHead = new Vector3(0, 0.5f, 0);
    // The healthbar slider for visual representation
    [SerializeField]
    private Slider _healthBarSlider;
    
    // The owner of the healthbar
    private VRCPlayerApi _owner;
    
    public void Start()
    {
        _owner = Networking.GetOwner(gameObject);
        _healthBarSlider.minValue = 0;
        _healthBarSlider.maxValue = 1;
        UpdateHealth();
    }

    public void Update()
    {
        if (!Utilities.IsValid(_owner))
        {
            return;
        }
        
        if(!Utilities.IsValid(Networking.LocalPlayer))
        {
            return;
        }
        
        // Get the head tracking data of the owner and the local player
        VRCPlayerApi.TrackingData headReference = _owner.GetTrackingData(VRCPlayerApi.TrackingDataType.Head);
        VRCPlayerApi.TrackingData localHeadReference = Networking.LocalPlayer.GetTrackingData(VRCPlayerApi.TrackingDataType.Head);
        
        // Place the healthbar above the head of the owner
        transform.position = headReference.position + _offsetAboaveHead;
        transform.rotation = Quaternion.LookRotation(_owner.isLocal ? Vector3.down :localHeadReference.position - headReference.position, _owner.isLocal ? localHeadReference.rotation * Vector3.forward : Vector3.up);
    }

    public override void OnDeserialization()
    {
        UpdateHealth();
    }

    private void UpdateHealth()
    {
        // Update the healthbar slider
        _healthBarSlider.value = health / _maxHealth;
    }
    
    public void TakeDamage(float damage)
    {
        // Apply damage to the health
        health -= damage;
        // Make sure the health is within the bounds of 0 and the max health
        health = Mathf.Clamp(health, 0, _maxHealth);
        // If the health is 0 or below, die
        if(health <= 0)
        {
            Die();
            return;
        }
        // Request serialization to update the health on all clients
        RequestSerialization();
        UpdateHealth();
    }

    // Respawn the player and reset the health
    private void Die()
    {
        _owner.Respawn();
        health = _maxHealth;
        RequestSerialization();
        UpdateHealth();
    }
}