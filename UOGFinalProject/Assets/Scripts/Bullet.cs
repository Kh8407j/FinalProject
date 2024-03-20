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
        [SerializeField] float damage = 15f;

        [System.Serializable]
        public class ExplosionSettings
        {
            [SerializeField] bool explodeOnImpact;
            [SerializeField] GameObject explosionBlueprint;

            public bool GetExplosionOnImpact()
            {
                return explodeOnImpact;
            }

            public GameObject GetExplosionBlueprint()
            {
                return explosionBlueprint;
            }
        }
        [SerializeField] ExplosionSettings explosionSettings = new ExplosionSettings();

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

        // Called when entering a trigger collider.
        private void OnTriggerEnter(Collider other)
        {
            // Check that the bullet collided into a barrier.
            if (other.gameObject.CompareTag("Barrier"))
                health.Kill();

            // Check that the bullet hit something damageable.
            Health trigHealth = other.gameObject.GetComponent<Health>();
            if (trigHealth != null)
            {
                if(explosionSettings.GetExplosionOnImpact())
                {
                    // Instantiate the explosion where the projectile was.
                    GameObject blueprint = explosionSettings.GetExplosionBlueprint();
                    Vector3 pos = transform.position;
                    GameObject explosion = Instantiate(blueprint, pos, Quaternion.identity);
                }

                trigHealth.ChangeHealth(-damage);
                health.Kill();
            }
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