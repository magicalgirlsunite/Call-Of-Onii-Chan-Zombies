
using UdonSharp;
using UnityEngine;
using VRC.SDKBase;
using VRC.Udon;

public class Gun_RestrictedArea : UdonSharpBehaviour
{
    [HideInInspector] public bool inRestrictedArea = false;

    public override void OnPlayerTriggerEnter(VRCPlayerApi player)
    {
        if (Networking.LocalPlayer == player)
        {
            inRestrictedArea = true;
        }
    }
    public override void OnPlayerTriggerExit(VRCPlayerApi player)
    {
        if (Networking.LocalPlayer == player)
        {
            inRestrictedArea = false;
        }
    }
}
