// KHOGDEN 001115381
using audio;
using managers;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace entity
{
    public class Explosion : MonoBehaviour
    {
        [SerializeField] float damage = 15f;
        [SerializeField] float lifeTime = 0.5f;
        private bool shrink;
        private Animator anim;

        // Called before 'void Start()'.
        private void Awake()
        {
            anim = GetComponent<Animator>();
        }

        // Start is called before the first frame update
        void Start()
        {
            StartCoroutine(AnimateExplosion());
            Destroy(gameObject, lifeTime);

            // Play the explosion sound.
            NextSoundAttributes s = ScriptableObject.CreateInstance<NextSoundAttributes>();
            s.Position = transform.position;
            s.Pitch = Random.Range(0.85f, 1.15f);
            AudioManager.control.PlayAudio("Explosion", s);
        }

        // Called when entering a trigger collider.
        private void OnTriggerEnter(Collider other)
        {
            // Check that the bullet hit something damageable.
            Health trigHealth = other.gameObject.GetComponent<Health>();
            if (trigHealth != null)
                trigHealth.ChangeHealth(-damage);
        }

        IEnumerator AnimateExplosion()
        {
            yield return new WaitForSeconds(0.25f);

            shrink = true;
        }
    }
}