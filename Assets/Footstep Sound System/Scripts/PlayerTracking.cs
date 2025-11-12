
using UdonSharp;
using UnityEngine;
using VRC.SDKBase;
using VRC.Udon;

public class PlayerTracking : UdonSharpBehaviour
{
    private VRCPlayerApi Local_Player;
    public GameObject TrackingCube;
    void Start()
    {
        Local_Player = Networking.LocalPlayer;
    }

    //Ensures the tracking cube is always following the player
    public void Update()
    {
        transform.position = Local_Player.GetPosition();
        TrackingCube.transform.localPosition = new Vector3(0.0f, 0.05f, 0.0f);
        TrackingCube.transform.localRotation = new Quaternion();
    }
}
