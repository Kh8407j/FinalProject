// KHOGDEN 001115381
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace misc
{
    public class Pause : MonoBehaviour
    {
        [SerializeField] bool paused;
        private bool restrictPausing = true;

        // Update is called once per frame
        void Update()
        {
            // If the user is giving the right input, toggle whether the game is paused or not.
            if (Input.GetButtonDown("Pause"))
                TogglePause(!paused);
        }

        // Toggle whether the game is paused or not. If 'restrictPausing' is true then this void give a error message in the console.
        public void TogglePause(bool pauseGame)
        {
            // Check that pausing isn't restricting before toggling pause.
            if (!restrictPausing)
            {
                // Check if the game was already paused before this void was called.
                if (paused)
                {
                    // Unpause the game and resume time if the game was already paused before this void was called.
                    paused = false;
                    Time.timeScale = 1f;
                }
                else
                {
                    // If the game was unpaused before this void was called, pause the game and freeze time.
                    paused = true;
                    Time.timeScale = 0f;
                }
            }
            else
                Debug.LogError("Pausing is restricted!");
        }

        // Set whether pausing should be restricted or not.
        public void RestrictPausing(bool restrict)
        {
            restrictPausing = restrict;
        }

        // Method to check if the game is paused or not.
        public bool IsPaused()
        {
            return paused;
        }
    }
}