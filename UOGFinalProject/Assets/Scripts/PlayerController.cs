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

        // Output scripts.
        Motor motor;

        // Start is called before the first frame update
        void Start()
        {

        }

        // Update is called once per frame
        void Update()
        {

        }

        // Check to see if the player is giving in any device input.
        void CalculateInput()
        {
            hor = Input.GetAxis("Horizontal");
            ver = Input.GetAxis("Vertical");
            fire = Input.GetButton("Fire1");
        }

        // Output values of this script for the motor to read.
        void UpdateMotor()
        {

        }
    }
}