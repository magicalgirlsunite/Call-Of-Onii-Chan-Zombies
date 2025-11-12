/*
--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
  ______                       __              _______   __                        __                         
 /      \                     /  |            /       \ /  |                      /  |                        
/$$$$$$  |  ______    _______ $$ |____        $$$$$$$  |$$ |  ______    _______  _$$ |_     ______    ______  
$$ |  $$/  /      \  /       |$$      \       $$ |__$$ |$$ | /      \  /       |/ $$   |   /      \  /      \ 
$$ |       $$$$$$  |/$$$$$$$/ $$$$$$$  |      $$    $$< $$ | $$$$$$  |/$$$$$$$/ $$$$$$/   /$$$$$$  |/$$$$$$  |
$$ |   __  /    $$ |$$      \ $$ |  $$ |      $$$$$$$  |$$ | /    $$ |$$      \   $$ | __ $$    $$ |$$ |  $$/ 
$$ \__/  |/$$$$$$$ | $$$$$$  |$$ |  $$ |      $$ |__$$ |$$ |/$$$$$$$ | $$$$$$  |  $$ |/  |$$$$$$$$/ $$ |      
$$    $$/ $$    $$ |/     $$/ $$ |  $$ |      $$    $$/ $$ |$$    $$ |/     $$/   $$  $$/ $$       |$$ |      
 $$$$$$/   $$$$$$$/ $$$$$$$/  $$/   $$/       $$$$$$$/  $$/  $$$$$$$/ $$$$$$$/     $$$$/   $$$$$$$/ $$/         

ver0.1
Copyright © 2021 VirtualFoxDesignStudio. All Rights Reserved.
--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------

 */


using UdonSharp;
using UnityEngine;
using VRC.SDKBase;
using VRC.Udon;
using UnityEngine.UI;
using UCS;

public class CashBlaster : UdonSharpBehaviour
{
    [Header("----------------------System-------------------------")]
    [SerializeField] Animator animator;
    [SerializeField] AudioSource audioSource_gunFire;
    [SerializeField] AudioSource audioSource_gunCoking;
    [SerializeField] private Text text_money;
    [SerializeField] private ParticleSystem particle;
    [SerializeField] private ParticleSystem globalParticle;
    [SerializeField] private float maxAudioDistance;
    [HideInInspector] public VRCPlayerApi localPlayer;

    private UdonChips udonChips;
    private Gun_RestrictedArea gun_RestrictedArea;

    [Space(20)]
    [Header("----------------------Money-------------------------")]
    [SerializeField] private float moneyCost = 5.0f;
    [SerializeField] private bool debugMode = false;
    private float displayMoney = 0;
    private bool moneySameTrigger;

    [Space(20)]
    [Header("----------------------Haptics-------------------------")]
    [SerializeField] private float hapticsTime = 30f;
    private float hapticsDuration = 1.0f;
    private float hapticsAmplitude = 1.0f;
    private float hapticsFrequency = 1.0f;
    private bool hapticsRightIsActive = false;
    private bool hapticsLeftIsActive = false;
    private float hapCountRight = 0f;
    private float hapCountLeft = 0f;


    private void Start()
    {
        udonChips = GameObject.Find("UdonChips").GetComponent<UdonChips>();
        gun_RestrictedArea = GameObject.Find("Gun_RestrictedArea").GetComponent<Gun_RestrictedArea>();
        displayMoney = udonChips.money;
        text_money.text = Mathf.Round(displayMoney) + "";

        localPlayer = Networking.LocalPlayer;
    }



    private void Update()
    {
        #region テキスト描画系
        if (displayMoney != udonChips.money)    //変更が無いときはテキストを更新しない
        {
            text_money.text = Mathf.Round(displayMoney) + "";
        }
        else
        {
            if (moneySameTrigger)
            {
                moneySameTrigger = false;
                text_money.text = Mathf.Round(displayMoney) + "";
            }
        }

        if (displayMoney != udonChips.money)
        {
            moneySameTrigger = true;
            if (udonChips.money < displayMoney)
            {
                displayMoney -= 1;
            }

            if (udonChips.money > displayMoney)
            {
                displayMoney += 1;
            }
        }
        #endregion


        #region ハプティクス
        if (hapticsRightIsActive == true)
        {
            hapCountRight = hapCountRight + 1.0f;

            //右手を振動
            Networking.LocalPlayer.PlayHapticEventInHand(VRC_Pickup.PickupHand.Right, hapticsDuration, hapticsAmplitude, hapticsFrequency);

            //継続時間を計測
            if (hapCountRight > hapticsTime)
            {
                hapticsRightIsActive = false;
                hapCountRight = 0;
            }
        }


        if (hapticsLeftIsActive == true)
        {
            hapCountLeft = hapCountLeft + 1.0f;

            //左手を振動
            Networking.LocalPlayer.PlayHapticEventInHand(VRC_Pickup.PickupHand.Left, hapticsDuration, hapticsAmplitude, hapticsFrequency);

            //継続時間を計測
            if (hapCountLeft > hapticsTime)
            {
                hapticsLeftIsActive = false;
                hapCountLeft = 0;
            }
        }
        #endregion
    }


    /// <summary>
    /// エディタでのデバッグ用
    /// </summary>
    public override void Interact()
    {
        if (debugMode)
        {
            if (udonChips.money >= moneyCost)
            {
                udonChips.money -= moneyCost;

                GunFire_Local();
            }
        }
    }


    public override void OnPickup()
    {
        animator.SetBool("isPickUp", true);

        if (audioSource_gunCoking != null)
        {
            audioSource_gunCoking.Play();
        }
    }

    public override void OnDrop()
    {
        animator.SetBool("isPickUp", false);
    }

    public override void OnPickupUseDown()
    {
        if (gun_RestrictedArea != null)
        {
            if (!gun_RestrictedArea.inRestrictedArea)
            {
                GunUse();
            }
        }
        else //gun_RestrictedAreaがない場合
        {
            GunUse();
        }
    }


    /// <summary>
    /// 銃を撃つ関数。お金が足りている場合お金を減らし、演出を起動
    /// </summary>
    private void GunUse()
    {
        if (udonChips.money >= moneyCost)
        {
            animator.SetBool("isError", false);
            animator.SetTrigger("Trigger");

            udonChips.money -= moneyCost;

            SendCustomNetworkEvent(VRC.Udon.Common.Interfaces.NetworkEventTarget.All, "GunFire");
            Haptics(gameObject);
        }
        else
        {
            animator.SetBool("isError", true);
            animator.SetTrigger("Trigger");
        }
    }

    /// <summary>
    /// 銃を撃ったときの演出。パーティクルを出し、音を鳴らす。
    /// ローカルかどうかを判定して実行。
    /// </summary>
    public void GunFire()
    {
        //ローカルのプレーヤーIDとゲームオブジェクトのプレーヤーIDを比較
        if (Networking.LocalPlayer.playerId == Networking.GetOwner(this.gameObject).playerId)
        {
            GunFire_Local();
        }
        else
        {
            GunFire_Global();
        }
    }


    /// <summary>
    /// ローカル上での銃の演出。パーティクルを出し、音を鳴らす。
    /// </summary>
    private void GunFire_Local()
    {
        particle.Play(true);

        if (audioSource_gunFire != null)
        {
            audioSource_gunFire.Play();
        }
    }

    /// <summary>
    /// 見た目だけの銃の演出。当たり判定のないパーティクルを出し、音を鳴らす。
    /// </summary>
    private void GunFire_Global()
    {
        globalParticle.Play(true);

        //範囲外のプレイヤーに一瞬音が鳴るバグを回避
        float playerDistance = Vector3.Distance(localPlayer.GetPosition(), this.transform.position);


        if (playerDistance < maxAudioDistance)
        {
            if (audioSource_gunFire != null)
            {
                audioSource_gunFire.Play();
            }
        }
    }

    /// <summary>
    /// 振動を発生させる
    /// </summary>
    private void Haptics(GameObject gameObject)

    {
        VRC_Pickup rightPickupObject;
        rightPickupObject = Networking.LocalPlayer.GetPickupInHand(VRC_Pickup.PickupHand.Right);

        if (rightPickupObject != null)
        {
            if (rightPickupObject.gameObject.name == gameObject.name)
            {
                hapticsRightIsActive = true;
            }
        }

        VRC_Pickup leftPickupObject;
        leftPickupObject = Networking.LocalPlayer.GetPickupInHand(VRC_Pickup.PickupHand.Left);

        if (leftPickupObject != null)
        {
            if (leftPickupObject.gameObject.name == gameObject.name)
            {
                hapticsLeftIsActive = true;
            }
        }
    }


}
