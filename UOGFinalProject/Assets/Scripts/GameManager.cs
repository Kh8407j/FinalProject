// KHOGDEN 001115381
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using misc;
using UnityEngine.SceneManagement;

namespace managers
{
    public class GameManager : MonoBehaviour
    {
        public static GameManager control;
        private Pause pause;

        // Called before 'void Start()'.
        private void Awake()
        {
            // Destroy any duplicate game manager gameobjects created from transferring scenes.
            if (control == null)
            {
                control = this;
                DontDestroyOnLoad(gameObject);
            }
            else if (control != this)
                Destroy(gameObject);
        }

        // Called upon every frame.
        private void Update()
        {
            if (Input.GetKeyDown(KeyCode.F5))
                ResetGame();

            if (Input.GetKeyDown(KeyCode.F11))
                ToggleFullScreen();
        }

        // Reset the game and statistics.
        public void ResetGame()
        {
            Score.control.ResetScore();
            Timer.control.PauseTime(true);
            Timer.control.ResetTime();
            SceneManager.LoadScene("Menu");
        }

        // Toggle whether the game is in fullscreen or not.
        public void ToggleFullScreen()
        {
            if (Screen.fullScreen)
                Screen.SetResolution(800, 400, false);
            else
                Screen.SetResolution(Screen.currentResolution.width, Screen.currentResolution.height, true);
        }

        // Method to access the pause system.
        public Pause PauseSystem()
        {
            return pause;
        }
    }
}