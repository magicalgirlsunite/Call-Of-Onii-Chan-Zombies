
using UdonSharp;
using UnityEngine;
using VRC.SDKBase;
using VRC.Udon;

public class FootstepInteraction : UdonSharpBehaviour
{
    private AudioSource footstep_sound;
    private VRCPlayerApi Local_Player;
    private float PlayerVelocity_X;
    private float PlayerVelocity_Z;

    void Start()
    {
        Local_Player = Networking.LocalPlayer;
    }

    //When the tracking cube collides with a surface, if it has an audio component attached, it will play the sound
    private void OnCollisionStay(Collision target)
    {
        //Stops the sound from the previous surface you were walking on from playing
        //if you walk onto a new surface with a different sound
        if (footstep_sound != null && footstep_sound != target.gameObject.GetComponent<AudioSource>())
        {
            footstep_sound.Stop();
        }

        //Grabs the audio component from the surface being walked on
        footstep_sound = target.gameObject.GetComponent<AudioSource>();

        //Block of code executes if there's a valid sound stored and the player is moving
        if (footstep_sound != null && PlayerVelocity_X != 0 && PlayerVelocity_Z != 0)
        {
            //If the player is running, the sound will be altered to sound twice as fast
            if (PlayerVelocity_X >= 2 | PlayerVelocity_X <= -2 | PlayerVelocity_Z >= 2 | PlayerVelocity_Z <= -2)
            {
                if (footstep_sound.pitch == 1)
                {
                    footstep_sound.Stop();
                }
                footstep_sound.pitch = 1.5f;
            }
            //If the player is walking normally, the sound will be altered to sound normal
            else
            {
                if (footstep_sound.pitch == 1.5)
                {
                    footstep_sound.Stop();
                }
                footstep_sound.pitch = 1;
            }
            //If the sound is not playing, then play the sound
            //(I know this seems redundent and silly, but the code won't work without it)
            if (!footstep_sound.isPlaying)
            {
                footstep_sound.Play();
            }
            
        }
        //If there's a valid sound stored but the player is not moving, stop playing the sound
        else if (footstep_sound != null && PlayerVelocity_X == 0 && PlayerVelocity_Z == 0)
        {
            footstep_sound.Stop();
        }
    }

    //Continuously keeps track of the player's velocity/movement
    private void Update()
    {
        PlayerVelocity_X = Local_Player.GetVelocity().x;
        PlayerVelocity_Z = Local_Player.GetVelocity().z;
    }
}
