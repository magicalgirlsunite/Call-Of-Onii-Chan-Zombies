using UdonSharp;
using UnityEngine;
using VRC.SDKBase;

public class ParticleHitDetector : UdonSharpBehaviour
{
    public RPGPlayer rpgPlayer;

    // This example uses the Particle System's built-in collision detection to detect when the player's attack hits an enemy
    private void OnParticleCollision(GameObject other)
    {
        if (!Utilities.IsValid(other)) return;
        
        Enemy enemy = other.GetComponentInParent<Enemy>();
        if (!Utilities.IsValid(enemy)) return;
        
        rpgPlayer.HitEnemy(enemy);
    }
}
