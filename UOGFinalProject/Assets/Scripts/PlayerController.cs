// KHOGDEN 001115381
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace controllers
{
    public class PlayerController : MonoBehaviour
    {
        // Axis values.
        private float hor;
        private float ver;

        // Button values.
        private bool fire;
        private bool altFire;

        // References.
        private Motor motor;

        // Called before 'void Start()'.
        private void Awake()
        {
            motor = GetComponent<Motor>();
        }

        // Called upon a constant timeline.
        private void FixedUpdate()
        {
            CalculateInput();
            UpdateMotor();
        }

        // Check to see if the player is giving in any device input.
        void CalculateInput()
        {
            hor = Input.GetAxisRaw("Horizontal");
            ver = Input.GetAxisRaw("Vertical");
            fire = Input.GetButton("Fire1");
            altFire = Input.GetButton("Fire2");
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