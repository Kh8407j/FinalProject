// KHOGDEN 001115381
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace entity
{
    public class Bullet : MonoBehaviour
    {
        [SerializeField] float moveSpeed = 10f;
        [SerializeField] float lifeTime = 5f;

        private Rigidbody rb;
        private Health health;

        // Called before 'void Start()'.
        private void Awake()
        {
            rb = GetComponent<Rigidbody>();
            health = GetComponent<Health>();
        }

        // Start is called before the first frame update
        void Start()
        {
            Invoke("DestroyBullet", lifeTime);
        }

        // Update is called once per frame
        void Update()
        {

        }

        // Called when entering a trigger collider.
        private void OnTriggerEnter(Collider other)
        {
            // Check that the bullet collided into a barrier.
            if (other.gameObject.CompareTag("Barrier"))
                health.Kill();
        }

        // Called on a constant timeline.
        private void FixedUpdate()
        {
            rb.velocity = (Vector3.forward * moveSpeed * 50f) * Time.fixedDeltaTime;

            if (health.GetHealth() == 0f)
                Destroy(gameObject);
        }

        // Destroy the bullet.
        void DestroyBullet()
        {
            health.Kill();
        }
    }
}