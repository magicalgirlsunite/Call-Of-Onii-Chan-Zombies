
using UdonSharp;
using UnityEngine;
using VRC.SDKBase;
using VRC.Udon;
using UCS;

public class MoneyTarget : UdonSharpBehaviour
{
    [Header("----------------------System-------------------------")]
    [SerializeField] private Animator animator;
    [SerializeField] private AudioSource audioSource_TargetHit;
    [SerializeField] private AudioSource audioSource_TargetBreak;
    [SerializeField] private ParticleSystem MoneyTarget_ParticleHit1;
    [SerializeField] private ParticleSystem MoneyTarget_ParticleHit2;
    [SerializeField] private ParticleSystem MoneyTarget_ParticleHit3;
    [SerializeField] private ParticleSystem MoneyTarget_ParticleHitSpawn;
    [Header("----------------------Switch-------------------------")]
    [Header("0:TripleTarget")]
    [Header("1:RecoveryTarget")]
    [Header("2:OneShotTarget")]
    [Space(20)]
    [SerializeField] [Range(0, 2)] private int switchID = 0;
    private UdonChips udonChips;
    private BoxCollider targetSpawnArea;
    private bool targetPositionChangeTrigger = false;
    private float targetPositionChangeFrame;

    [Space(20)]
    [Header("----------------------Money-------------------------")]
    [SerializeField] private float moneyTargetScore = 10.0f;

    [Space(20)]
    [Header("----------------------TripleTarget-------------------------")]
    private int targetHitCount = 0;
    [Space(20)]
    [Header("----------------------RecoveryTarget-------------------------")]
    [SerializeField] private float targetLife = 100.0f;
    [SerializeField] private float targetMaxLife = 35.0f;
    [SerializeField] private float targetRecoveryLife = 0.01f;
    [SerializeField] private float targetDamage = 1.0f;

    private float targetLifeMemory;
    //private float lastBulletHit; //最後に弾が当たった時間
    private float animParm;
    //private float moneyCharge;
    //private float moneyBankMax;
    void Start()
    {
        udonChips = GameObject.Find("UdonChips").GetComponent<UdonChips>();
        targetSpawnArea = GameObject.Find("Target_SpawnArea").GetComponent<BoxCollider>();
    }

    private void Update()
    {
        if (targetPositionChangeTrigger)
        {
            if (targetPositionChangeFrame + 0.03 < Time.time)
            {
                targetPositionChangeTrigger = false;
                TargetPositionChange();

                MoneyTarget_ParticleHitSpawn.Play(true);
            }
        }

        if(switchID == 1)
        {
            if (targetLife <= targetMaxLife)
            {
                targetLife = targetLife + targetRecoveryLife * Time.deltaTime;         //毎フレーム回復

                if (targetLife > targetMaxLife)
                {
                    targetLife = targetMaxLife;
                }
            }

            if (targetLifeMemory != targetLife)
            {
                targetLifeMemory = targetLife;
            }

            animator.speed = 0;
            animator.Play("MoneyTarget_CircleParm", 0, animParm); //アニメーションを実行
            animParm = targetLife / targetMaxLife; //100％になったらアニメーションが100％に
        }
    }


    private void OnParticleCollision(GameObject other)
    {
        //アバターのパーティクルがあたったときにヌルポするのを回避
        if (other == null)
        {
            return;
        }

        switch (switchID)
        {
            case 0: //3発で壊れる的

                if (other.name == "CashBlasterParticle_Base")
                {
                    switch (targetHitCount)
                    {
                        case 0:
                            animator.SetInteger("targetHit", 1);
                            targetHitCount = 1;

                            if (audioSource_TargetHit != null)
                            {
                                audioSource_TargetHit.Play();
                            }

                            MoneyTarget_ParticleHit1.Play(true);
                            break;

                        case 1:
                            animator.SetInteger("targetHit", 2);
                            targetHitCount = 2;

                            if (audioSource_TargetHit != null)
                            {
                                audioSource_TargetHit.Play();
                            }

                            MoneyTarget_ParticleHit2.Play(true);
                            break;

                        case 2:
                            animator.SetInteger("targetHit", 0);
                            targetHitCount = 0;

                            if (audioSource_TargetBreak != null)
                            {
                                audioSource_TargetBreak.Play();
                            }

                            MoneyTarget_ParticleHit3.Play(true);

                            //移動タイミングを0.1秒遅らせてパーティクルを元の位置に残すように

                            targetPositionChangeTrigger = true;
                            targetPositionChangeFrame = Time.time;

                            udonChips.money = udonChips.money + moneyTargetScore;
                            break;
                    }
                }

                break;

            case 1: //回復する的

                if (targetLife > 0)
                {
                    if (other.name == "CashBlasterParticle_Base")
                    {
    //                    lastBulletHit = Time.time; //弾が当たった時間を保存////////////////////////////////////////////////////////////////?????????
                        targetLife = targetLife - targetDamage;

                        if (audioSource_TargetHit != null)
                        {
                            audioSource_TargetHit.Play();
                        }
                    }
                }

                if (targetLife < 0) //ライフがなくなった時
                {
                    targetLife = 0;

                    if (audioSource_TargetBreak != null)
                    {
                        audioSource_TargetBreak.Play();
                    }

                    MoneyTarget_ParticleHit3.Play(true);

                    //移動タイミングを0.1秒遅らせてパーティクルを元の位置に残すように

                    targetPositionChangeTrigger = true;
                    targetPositionChangeFrame = Time.time;

                    udonChips.money = udonChips.money + moneyTargetScore;

                   
                }

                    break;

            case 2: //一発で壊せる的

                if (audioSource_TargetBreak != null)
                {
                    audioSource_TargetBreak.Play();
                }

                udonChips.money = udonChips.money + moneyTargetScore;

                //移動タイミングを0.1秒遅らせてパーティクルを元の位置に残すように

                targetPositionChangeTrigger = true;
                targetPositionChangeFrame = Time.time;


                break;
        }
    }

    private void TargetPositionChange()
    {
        Vector3 pos = new Vector3();
        pos.x = Random.Range(targetSpawnArea.bounds.min.x, targetSpawnArea.bounds.max.x);
        pos.y = Random.Range(targetSpawnArea.bounds.min.y, targetSpawnArea.bounds.max.y);
        pos.z = Random.Range(targetSpawnArea.bounds.min.z, targetSpawnArea.bounds.max.z);

        this.transform.position = pos;
    }
}
