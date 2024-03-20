// KHOGDEN 001115381
using audio;
using System.Collections;
using System.Collections.Generic;
using managers;
using UnityEngine;

namespace entity
{
    public class Health : MonoBehaviour
    {
        private float health = 100f;
        [SerializeField] float maxHealth = 100f;
        [SerializeField] string playSoundOnDamage = "Damage";

        [Header("Score")]
        [SerializeField] int scoreIncreaseOnDamage = 10;
        [SerializeField] int scoreIncreaseOnKill = 100;

        private bool dead;

        // Called before 'void Start()'.
        private void Awake()
        {
            health = maxHealth;
        }

        // Add or remove health from 'health' by the inputted value in 'amount'.
        public void ChangeHealth(float amount)
        {
            if (!dead)
            {
                // Store the value of health before altering it.
                float prevHealth = health;

                // Add the inputted amount of health being given to 'health'.
                health += amount;

                // Prevent health going over maximum/minimum.
                if (health > maxHealth)
                    health = maxHealth;
                else if (health < 0f)
                    health = 0f;

                // Check that the entity died/got destroyed.
                if (health == 0f && !dead)
                    dead = true;

                // Check that health went down or up.
                if (prevHealth > health)
                {
                    if (playSoundOnDamage != "")
                    {
                        // Play the entity's damage sound.
                        NextSoundAttributes s = ScriptableObject.CreateInstance<NextSoundAttributes>();
                        s.Position = transform.position;
                        s.Pitch = Random.Range(0.85f, 1.15f);
                        AudioManager.control.PlayAudio(playSoundOnDamage, s);
                    }

                    // Increase the player's score for damaging/killing.
                    if (dead)
                        Score.control.IncreaseScore(scoreIncreaseOnKill);
                    else
                        Score.control.IncreaseScore(scoreIncreaseOnDamage);
                }
                else
                {

                }
            }
        }

        // Use 'ChangeHealth()' to instantly kill the entity.
        public void Kill()
        {
            ChangeHealth(-health);
        }

        // Method to get the value of 'health'.
        public float GetHealth()
        {
            return health;
        }

        // Method to get the value of 'maxHealth'.
        public float GetMaxHealth()
        {
            return maxHealth;
        }
    }
}
