// KHOGDEN 001115381
using entity;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace controllers
{
    public class Motor : MonoBehaviour
    {
        [Header("Properties")]
        [SerializeField] float moveSpeed = 5f;

        private float hor;
        private float ver;
        private bool holdingFire;
        private bool holdingAltFire;

        private Rigidbody rb;
        private Health health;

        // Called before 'void Start()'.
        private void Awake()
        {
            rb = GetComponent<Rigidbody>();
            health = GetComponent<Health>();
        }

        // Called on a constant timeline.
        private void FixedUpdate()
        {
            if(health.GetHealth() > 0f)
                Move();
        }

        // Make the motor moved based on outputted values.
        public void Move()
        {
            // Calculate where the motor will be.
            Vector3 pos = transform.position;
            Vector3 moveTo = new Vector3(hor * moveSpeed * 50f, 0f, ver * moveSpeed * 50f) * Time.fixedDeltaTime;

            // Move the motor rigidbody.
            rb.velocity = moveTo;
        }

        // Methods for updating the output values.
        #region
        public float Hor
        {
            get { return hor; }
            set { hor = value; }
        }

        public float Ver
        {
            get { return ver; }
            set { ver = value; }
        }

        public bool HoldingFire
        {
            get { return holdingFire; }
            set { holdingFire = value; }
        }

        public bool HoldingAltFire
        {
            get { return holdingAltFire; }
            set { holdingAltFire = value; }
        }
        #endregion
    }
}