// KHOGDEN 001115381
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace managers
{
    public class Score : MonoBehaviour
    {
        public static Score control;
        private int score;

        // Called before 'void Start()'.
        void Awake()
        {
            control = this;
        }

        #region Methods
        // Increase the score.
        public void IncreaseScore(int amount)
        {
            score += amount;
        }

        // Reset the player's score back to zero.
        public void ResetScore()
        {
            score = 0;
        }

        // Method to get a string display of the player's score for UI.
        public string ScoreDisplay()
        {
            return score.ToString("00000000");
        }
        #endregion
    }
}