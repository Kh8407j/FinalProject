// KHOGDEN 001115381
using controllers;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace audio
{
    public class CSoundRealTime : MonoBehaviour
    {
        private CsoundUnity csound;
        private Motor player;

        // Called before 'void Start()'.
        private void Awake()
        {
            csound = GetComponent<CsoundUnity>();
            player = FindObjectOfType<Motor>();
        }

        // Start is called before the first frame update
        void Start()
        {

        }

        // Update is called once per frame
        void Update()
        {
            if (!csound.IsInitialized)
            {
                
            }
        }
    }
}