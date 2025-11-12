using UdonSharp;
using UnityEngine;
using VRC.SDKBase;

public class ClassPicker : UdonSharpBehaviour
{
    public int classToPick;

    public override void OnPlayerTriggerEnter(VRCPlayerApi player)
    {
        // If it was not you who entered the trigger, return
        if (!player.isLocal) return;
        
        // We find the RPGPlayer component from the PlayerObjects and set the class
        RPGPlayer rpgPlayer = PersistenceUtilities.GetPlayerObjectComponent<RPGPlayer>(player);
        if (!Utilities.IsValid(rpgPlayer))
        {
            Debug.Log("Couldn't find rpgPlayer");
            return;
        }
        rpgPlayer.SetClass(classToPick);
    }
}
