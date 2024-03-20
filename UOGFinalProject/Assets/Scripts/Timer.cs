// KHOGDEN 001115381
using UnityEngine;

namespace managers
{
    public class Timer : MonoBehaviour
    {
        public static Timer control;

        [SerializeField] float time = 180f;
        [SerializeField] bool pauseTime = true;
        private float defaultTime;

        // Called before 'void Start()'.
        void Awake()
        {
            control = this;
            defaultTime = time;
        }

        // Called upon every frame.
        void Update()
        {
            // Decrease timer so long as it's not paused.
            if (!pauseTime)
            {
                if (time > 0f)
                    time -= Time.deltaTime;
                else if (time < 0f)
                    time = 0f;
            }
        }

        #region Methods
        // Reset the timer to be what it starts off by.
        public void ResetTime()
        {
            time = defaultTime;
        }

        public void PauseTime(bool pause)
        {
            pauseTime = pause;
        }

        public float GetTime()
        {
            return time;
        }

        // Method for converting a float into a timer. (Thank you to Linus on Unity Forums for this method!)
        public string TimeDisplay()
        {
            int min = Mathf.FloorToInt(GetTime() / 60f);
            int sec = Mathf.FloorToInt(GetTime() % 60f);
            int msec = Mathf.FloorToInt(GetTime() * 1000f);
            msec = msec % 1000;
            return string.Format("{0:00}:{1:00}", min, sec);
        }
        #endregion
    }
}