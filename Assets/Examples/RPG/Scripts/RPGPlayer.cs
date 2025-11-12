using UdonSharp;
using UnityEngine;
using VRC.SDKBase;
using VRC.Udon.Common;
using VRC.Udon.Common.Interfaces;

public class RPGPlayer : UdonSharpBehaviour
{
    [UdonSynced] private int _currentClass = -1;
    [UdonSynced] private int _currentExperience;
    [UdonSynced] private int _currentLevel = 1;
    [UdonSynced] private Vector3 _currentPosition;
    [UdonSynced] private Quaternion _currentRotation;

    [Tooltip("How long it takes for the player to be able to attack again for each class in seconds.")]
    public float[] classCoolDowns;
    [Tooltip("The particle system for each classes attack. The hit detection is done by the ParticleHitDetector script on these.")]
    public ParticleSystem[] classAttacks;
    [Tooltip("The parent of all the objects that are specific to each class.")]
    public GameObject[] classObjects;
    [Tooltip("The game objects that show up when you are level 1.")]
    public GameObject[] level1Objects;
    [Tooltip("The game objects that show up when you are level 2.")]
    public GameObject[] level2Objects;
    [Tooltip("The game objects that show up when you are level 3.")]
    public GameObject[] level3Objects;

    private float _lastAttackTime;
    private float _autoSerializeTime = 5f;

    private void Update()
    {
        // Ensure that the owner of this GameObject is valid
        VRCPlayerApi owner = Networking.GetOwner(gameObject);
        if (!Utilities.IsValid(owner)) return;
        
        // Moving this to be above the owner since the diamonds showing class and level are attached to this object
        transform.position = owner.GetBonePosition(HumanBodyBones.Head) + new Vector3(0,0.5f,0);
        transform.rotation = owner.GetRotation();
    }

    public override void OnPlayerRestored(VRCPlayerApi player)
    {
        // If the player is not local or is not the owner, aka this RPGPlayer is not the player's own RPGPlayer we don't want to do anything
        if (!player.isLocal || !Networking.IsOwner(gameObject)) return;
        
        // Teleport to the last known position and rotation
        player.TeleportTo(_currentPosition, _currentRotation);
        
        // Calling ApplySerialization to setup the objects now that we have all the data
        ApplySerialization();
        
        SendCustomEventDelayedSeconds(nameof(SavePositionRotation), _autoSerializeTime);
    }

    // This is called every _autoSerializeTime seconds to ensure that the player's position and rotation are always up to date
    public void SavePositionRotation()
    {
        _currentPosition = Networking.LocalPlayer.GetPosition();
        _currentRotation = Networking.LocalPlayer.GetRotation();
        
        // Call this function again in _autoSerializeTime seconds
        SendCustomEventDelayedSeconds(nameof(SavePositionRotation), _autoSerializeTime);
        
        RequestSerialization();
    }

    public override void OnDeserialization()
    {
        ApplySerialization();
    }

    private void ApplySerialization()
    {
        for (int i = 0; i < classObjects.Length; i++)
        {
            classObjects[i].SetActive(i == _currentClass);
        }

        for (int i = 0; i < level1Objects.Length; i++)
        {
            level1Objects[i].SetActive(_currentLevel == 1);
        }

        for (int i = 0; i < level2Objects.Length; i++)
        {
            level2Objects[i].SetActive(_currentLevel == 2);
        }

        for (int i = 0; i < level3Objects.Length; i++)
        {
            level3Objects[i].SetActive(_currentLevel == 3);
        }
    }

    // Sets the class of the player to the class specified by newClass
    public void SetClass(int newClass)
    {
        if (!Networking.IsOwner(gameObject)) return; // If I'm not the owner, don't set the class

        if (_currentClass == newClass) return; // Don't change the class if it matches the current class, this resets progress
        
        Debug.Log($"{name} set class to {newClass}");
        _currentClass = newClass;
        _currentExperience = 0;
        _currentLevel = 1;
        RequestSerialization();
        ApplySerialization();
    }

    // Increases the experience of the player by 1 and levels up the player if they have enough experience. This is called when the player kills an enemy.
    public void AddExperience()
    {
        _currentExperience += 1;
        RequestSerialization();
        
        if (_currentExperience > _currentLevel * 4) //Leveling up requires 4 times the experience points of the current level
        {
            _currentExperience = 0;
            AddLevel();
        }
    }

    // Increases the level of the player by 1 as long as the player is not already at the max level
    public void AddLevel()
    {
        if (_currentLevel >= 3) return; //max level is 3
        
        _currentLevel++;
        RequestSerialization();
        ApplySerialization();
    }

    public override void InputUse(bool value, UdonInputEventArgs args)
    {
        if (_currentClass < 0 || _currentClass >= classCoolDowns.Length) return;
        if (!value) return;
        if (!Networking.IsOwner(gameObject)) return;
        if (_lastAttackTime + classCoolDowns[_currentClass] > Time.realtimeSinceStartup) return;
        
        _lastAttackTime = Time.realtimeSinceStartup;
        SendCustomNetworkEvent(NetworkEventTarget.All, nameof(Attack));
    }

    // This function is called by the InputUse function to play the attack particles depending on the current class
    public void Attack()
    {
        if (_currentClass < 0 || _currentClass >= classAttacks.Length) return;
        
        classAttacks[_currentClass].Play();
    }

    // This function is called by the ParticleHitDetector script on the attack particles to deal damage to an enemy
    public void HitEnemy(Enemy enemy)
    {
        if (!Networking.IsOwner(gameObject)) return;
        if (!Utilities.IsValid(enemy)) return;
        if (enemy.Damage(_currentLevel))
        {
            AddExperience();
        }
    }
}
