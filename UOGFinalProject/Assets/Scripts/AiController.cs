using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace controllers
{
    public class AiController : MonoBehaviour
    {
        [SerializeField] bool canUseFire = true;
        [SerializeField] bool canUseAltFire = true;

        // Axis values.
        private float hor;
        private float ver;

        // Button values.
        private bool fire;
        private bool altFire;

        // References.
        private Transform player;
        private Motor motor;
        private Vector3 currentPos;
        private Vector3 playerPos;

        // Called before 'void Start()'.
        private void Awake()
        {
            GameObject plr = GameObject.FindGameObjectWithTag("Player");
            if (plr != null)
                player = plr.transform;

            motor = GetComponent<Motor>();
        }

        // Called upon a constant timeline.
        private void FixedUpdate()
        {
            CalculateInput();
            UpdateMotor();
            currentPos = transform.position;

            if(player != null)
                playerPos = player.position;
        }

        // Check to see if the player is giving in any device input.
        void CalculateInput()
        {
            float calcHor = 0f;
            float calcVer = 0f;
            bool calcFire = false;
            bool calcAltFire = false;
            float horOffset = 0.1f;
            float verOffset = 0.1f;
            bool centeredWithPlayer = false;
            bool headDirectIntoPlayer = !canUseFire && !canUseAltFire || canUseFire && canUseAltFire;

            // Calculate whether the AI will move left/right depending on player's position.
            if (currentPos.x > playerPos.x + horOffset)
                calcHor = -1f;
            else if (currentPos.x < playerPos.x - horOffset)
                calcHor = 1f;
            else
                centeredWithPlayer = true;

            // AI is behind player.
            if(currentPos.z < playerPos.z - verOffset)
            {
                if(!canUseFire && canUseAltFire || headDirectIntoPlayer)
                    calcVer = 1f;

                // AI will start firing once in range with player.
                if(centeredWithPlayer && canUseFire)
                    calcFire = true;
            }

            // AI is in front of player.
            if (currentPos.z > playerPos.z + verOffset)
            {
                if (canUseFire && !canUseAltFire || headDirectIntoPlayer)
                    calcVer = -1f;

                // AI will start firing once in range with player.
                if (centeredWithPlayer && canUseAltFire)
                    calcAltFire = true;
            }

            // Apply calculated inputs.
            hor = calcHor;
            ver = calcVer;
            fire = calcFire;
            altFire = calcAltFire;
        }

        // Output values of this script for the motor to read.
        void UpdateMotor()
        {
            motor.Hor = hor;
            motor.Ver = ver;
            motor.HoldingFire = fire;
            motor.HoldingAltFire = altFire;
        }
    }
}