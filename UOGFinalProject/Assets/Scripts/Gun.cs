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
        [SerializeField] GameObject projectileBlueprint;
        [SerializeField] GameObject altProjectileBlueprint;
        [SerializeField] Transform firePoint;
        [SerializeField] Transform altFirePoint;

        [Header("Fire Settings")]
        [SerializeField][Range(0f, 2f)] float fireDelayTime = 0.1f;
        private float fireDelayTimer;
        [SerializeField][Range(0f, 2f)] float altFireDelayTime = 2f;
        private float altFireDelayTimer;

        private Motor motor;

        // Called before 'void Start()'.
        private void Awake()
        {
            motor = GetComponent<Motor>();
        }

        // Update is called once per frame
        void Update()
        {
            // Decrease the fire delay timer until it reaches zero.
            if (fireDelayTimer > 0f)
                fireDelayTimer -= Time.deltaTime;
            else if(fireDelayTimer < 0f)
                fireDelayTimer = 0f;

            if (altFireDelayTimer > 0f)
                altFireDelayTimer -= Time.deltaTime;
            else if (altFireDelayTimer < 0f)
                altFireDelayTimer = 0f;

            // Fire the gun or place bomb once the fire input is held down.
            if (fireDelayTimer == 0f && motor.HoldingFire)
                Fire();
            else if (altFireDelayTimer == 0f && motor.HoldingAltFire)
                AltFire();
        }

        // Fire a bullet from the gun.
        void Fire()
        {
            fireDelayTimer = fireDelayTime;
            GameObject projectile = Instantiate(projectileBlueprint, firePoint.position, Quaternion.identity);

            // Play the fire sound.
            NextSoundAttributes s = ScriptableObject.CreateInstance<NextSoundAttributes>();
            s.Position = firePoint.position;
            s.Pitch = Random.Range(0.85f, 1.15f);
            AudioManager.control.PlayAudio("Fire", s);
        }

        // Place a bomb from behind.
        void AltFire()
        {
            altFireDelayTimer = altFireDelayTime;
            GameObject projectile = Instantiate(altProjectileBlueprint, altFirePoint.position, Quaternion.identity);

            // Play the alt fire sound.
            NextSoundAttributes s = ScriptableObject.CreateInstance<NextSoundAttributes>();
            s.Position = firePoint.position;
            s.Pitch = Random.Range(0.85f, 1.15f);
            AudioManager.control.PlayAudio("Place Bomb", s);
        }
    }
}