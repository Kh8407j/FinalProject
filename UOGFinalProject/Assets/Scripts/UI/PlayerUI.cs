// KHOGDEN 001115381
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using managers;
using entity;

namespace ui
{
    public class PlayerUI : MonoBehaviour
    {
        [SerializeField] Text statistics;
        [SerializeField] Slider healthSlider;
        [SerializeField] GameObject gameOver;
        [SerializeField] Text win;
        [SerializeField] float healthBarDampRate = 5f;

        private GameObject player;
        private Health health;
        private float currentHealth;
        private bool playerDied;
        private bool playerWon;

        // Called before 'void Start()'.
        private void Awake()
        {
            player = GameObject.FindGameObjectWithTag("Player");
            health = player.GetComponent<Health>();
            healthSlider.maxValue = health.GetMaxHealth();
        }

        // Update is called once per frame
        void Update()
        {
            // Display the player's score and the time left.
            statistics.text = Score.control.ScoreDisplay() + "\n" + Timer.control.TimeDisplay();

            // Player's health.
            if (player != null)
                currentHealth = health.GetHealth();

            healthSlider.value = Mathf.Lerp(healthSlider.value, currentHealth, healthBarDampRate * Time.deltaTime);

            // Display game over when the player dies.
            if(currentHealth == 0f && !playerDied)
            {
                playerDied = true;
                StartCoroutine(GameOver());
            }

            // Display win screen when player wins.
            if(Timer.control.GetTime() == 0f && !playerWon)
            {
                playerWon = true;
                StartCoroutine(Win());
            }
        }

        // Animate the game over screen.
        IEnumerator GameOver()
        {
            yield return new WaitForSeconds(1f);

            for (int i = 0; i < 4; i++)
            {
                gameOver.SetActive(false);

                yield return new WaitForSeconds(0.1f);

                gameOver.SetActive(true);

                yield return new WaitForSeconds(0.1f);
            }
        }

        // Animate the win screen.
        IEnumerator Win()
        {
            for (int i = 0; i < 4; i++)
            {
                win.gameObject.SetActive(false);

                yield return new WaitForSeconds(0.1f);

                win.gameObject.SetActive(true);

                yield return new WaitForSeconds(0.1f);
            }

            win.text += "\n" + "BONUS: " + SessionManager.control.GetBonusScore();
            win.text += "\n" + "FINAL SCORE: " + Score.control.ScoreDisplay();
        }
    }
}