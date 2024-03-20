// KHOGDEN 001115381
using entity;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace managers
{
    public class SessionManager : MonoBehaviour
    {
        public static SessionManager control;
        private bool sessionFinished;

        private GameObject player;
        private Health health;
        private int bonusScore;
        private float currentHealth;
        private bool playerDied;

        // Called before 'void Start()'.
        void Awake()
        {
            control = this;
            player = GameObject.FindGameObjectWithTag("Player");
            health = player.GetComponent<Health>();
        }

        // Called upon first frame.
        private void Start()
        {
            Timer.control.PauseTime(false);
        }

        // Update is called once per frame
        void Update()
        {
            // Check if the session has reached the time limit.
            if(Timer.control.GetTime() == 0f)
            {
                if(!sessionFinished)
                {
                    sessionFinished = true;
                    bonusScore = Mathf.RoundToInt(currentHealth) * 25;
                    Score.control.IncreaseScore(bonusScore);
                    ClearEnemies();
                    Invoke("ResetGame", 8f);
                }
            }

            // Display game over when the player dies.
            if (player != null)
            {
                currentHealth = health.GetHealth();
                if (currentHealth == 0f && !playerDied)
                {
                    playerDied = true;
                    Invoke("ResetGame", 8f);
                }
            }
        }

        // Clear the scene from all enemies.
        public void ClearEnemies()
        {
            Health[] killables = FindObjectsOfType<Health>();
            foreach (Health h in killables)
            {
                Bullet bulletScript = h.gameObject.GetComponent<Bullet>();
                if (h.gameObject.CompareTag("Enemy") || bulletScript != null)
                    h.Kill();
            }
        }

        // Made for calling through invokes, giving a delay before resetting.
        void ResetGame()
        {
            GameManager.control.ResetGame();
        }

        public bool SessionFinished()
        {
            return sessionFinished;
        }

        public int GetBonusScore()
        {
            return bonusScore;
        }
    }
}