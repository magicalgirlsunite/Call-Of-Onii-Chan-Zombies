using UdonSharp;
using UnityEngine;
using VRC.SDKBase;

[UdonBehaviourSyncMode(BehaviourSyncMode.Manual)]
public class Enemy : UdonSharpBehaviour
{
    public ParticleSystem deathParticles;
    public GameObject liveObject;
    public float maxHealth;
    [UdonSynced]
    private float _currentHealth;

    private void Start()
    {
        Live();
    }

    // This function makes the enemy "alive" again by setting its health to maxHealth and enabling the liveObject
    public void Live()
    {
        if (!Networking.IsOwner(gameObject)) return;
        
        _currentHealth = maxHealth;
        liveObject.SetActive(true);
        RequestSerialization();
        ApplySerialization();
    }
    
    // This function is called to deal damage to the enemy. It returns true if the enemy has died.
    public bool Damage(float damage)
    {
        _currentHealth -= damage;
        Networking.SetOwner(Networking.LocalPlayer, gameObject);
        RequestSerialization();
        ApplySerialization();
        
        return (_currentHealth <= 0);
    }

    public override void OnDeserialization()
    {
        ApplySerialization();
    }

    public void ApplySerialization()
    {
        if (_currentHealth <= 0)
        {
            Die();
        }
        else
        {
            liveObject.SetActive(true);
        }
    }

    // This function "kills" the enemy by disabling the liveObject and playing the deathParticles. It also schedules the enemy to respawn after a random delay.
    public void Die()
    {
        liveObject.SetActive(false);
        deathParticles.Play();
        SendCustomEventDelayedSeconds(nameof(Live), Random.Range(10, 15));
    }
}
