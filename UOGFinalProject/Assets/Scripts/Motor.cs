// KHOGDEN 001115381
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

        private Rigidbody rb;

        // Called before 'void Start()'.
        private void Awake()
        {
            rb = GetComponent<Rigidbody>();
        }

        // Start is called before the first frame update
        void Start()
        {

        }

        // Update is called once per frame
        void Update()
        {

        }

        // Called on a constant timeline.
        private void FixedUpdate()
        {
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
        #endregion
    }
}