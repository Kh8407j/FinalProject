// KHOGDEN 001115381
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using misc;

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

        // Method to access the pause system.
        public Pause PauseSystem()
        {
            return pause;
        }
    }
}