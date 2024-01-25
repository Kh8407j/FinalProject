// KHOGDEN 001115381
using audio;
using controllers;
using managers;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace entity
{
    public class Gun : MonoBehaviour
    {
        [SerializeField] GameObject bulletBlueprint;
        [SerializeField] Transform firePoint;

        [Header("Fire Settings")]
        [SerializeField][Range(0f, 2f)] float fireDelayTime = 0.1f;
        private float fireDelayTimer;

        private Motor motor;

        // Called before 'void Start()'.
        private void Awake()
        {
            motor = GetComponent<Motor>();
        }

        // Start is called before the first frame update
        void Start()
        {

        }

        // Update is called once per frame
        void Update()
        {
            // Decrease the fire delay timer until it reaches zero.
            if (fireDelayTimer > 0f)
                fireDelayTimer -= Time.deltaTime;
            else if(fireDelayTimer < 0f)
                fireDelayTimer = 0f;

            // Fire the gun once the fire input is held down.
            if (motor.HoldingFire && fireDelayTimer == 0f)
                Fire();
        }

        // Fire a bullet from the gun.
        void Fire()
        {
            fireDelayTimer = fireDelayTime;
            GameObject bullet = Instantiate(bulletBlueprint, firePoint.position, Quaternion.identity);

            // Play the fire sound.
            NextSoundAttributes s = ScriptableObject.CreateInstance<NextSoundAttributes>();
            s.Position = firePoint.position;
            s.Pitch = Random.Range(0.85f, 1.15f);
            AudioManager.control.PlayAudio("Fire", s);
        }
    }
}