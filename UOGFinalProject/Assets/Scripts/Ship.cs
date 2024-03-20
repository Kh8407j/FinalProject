// KHOGDEN 001115381
using audio;
using controllers;
using managers;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace entity
{
    public class Ship : MonoBehaviour
    {
        private bool destroyed;
        private bool playExplosionSounds;
        private float explosionSoundTimer;

        private Health health;
        private Motor motor;
        private Animator anim;

        // Called before 'void Start()'.
        private void Awake()
        {
            health = GetComponent<Health>();
            motor = GetComponent<Motor>();
            anim = GetComponent<Animator>();
        }

        // Update is called once per frame
        void Update()
        {
            anim.SetFloat("Hor", motor.Hor);
            anim.SetInteger("Health", Mathf.RoundToInt(health.GetHealth()));

            if(health.GetHealth() == 0f && !destroyed)
            {
                if(gameObject.CompareTag("Player"))
                    Timer.control.PauseTime(true);

                destroyed = true;
                StartCoroutine(Destroy());
            }

            if(playExplosionSounds)
            {
                // Decrease the timer until it reaches zero.
                if (explosionSoundTimer > 0f)
                    explosionSoundTimer -= Time.deltaTime;
                else
                {
                    explosionSoundTimer = 0.12f;

                    // Play the explosion sound.
                    NextSoundAttributes s = ScriptableObject.CreateInstance<NextSoundAttributes>();
                    s.Position = transform.position;
                    s.Pitch = Random.Range(0.85f, 1.15f);
                    AudioManager.control.PlayAudio("Explosion", s);
                }
            }
        }

        // Called upon entering a trigger collider.
        private void OnTriggerEnter(Collider other)
        {
            // The player ship will be destroyed on collision with a enemy ship.
            if (other.gameObject.CompareTag("Enemy") && !gameObject.CompareTag("Enemy"))
            {
                // Don't destroy the player ship if the enemy ship is already destroyed.
                Health trigHealth = other.gameObject.GetComponent<Health>();
                if(trigHealth.GetHealth() > 0f)
                    health.Kill();
            }
        }

        // Coding animation to support the 'Destroy' animation clip for the ship.
        IEnumerator Destroy()
        {
            playExplosionSounds = true;

            yield return new WaitForSeconds(1f);

            Destroy(gameObject);
        }
    }
}