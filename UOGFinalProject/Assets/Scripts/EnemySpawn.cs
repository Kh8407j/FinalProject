// KHOGDEN 001115381
using managers;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Experimental.AI;

namespace entity
{
    public class EnemySpawn : MonoBehaviour
    {
        [SerializeField] GameObject enemyBlueprint;

        [SerializeField][Range(0f, 60f)] float spawnFirstTime = 10f;
        private float spawnFirstTimer;
        private bool spawnedFirst;

        [SerializeField][Range(0f, 60f)] float spawnDelayTime = 10f;
        private float spawnDelayTimer;
        private bool spawnDelayTimerPause = true;

        private int spawnQuantity = 1;
        [SerializeField][Range(0f, 60f)] float increaseQuantityTime = 10f;
        private float increaseQuantityTimer;

        private void Awake()
        {
            spawnDelayTimer = spawnDelayTime;
            spawnFirstTimer = spawnFirstTime;
            increaseQuantityTimer = increaseQuantityTime;
        }

        // Update is called once per frame
        void Update()
        {
            // Decrease the timers until they reach zero.
            if (!spawnedFirst)
            {
                if (spawnFirstTimer > 0f)
                    spawnFirstTimer -= Time.deltaTime;
                else if (spawnFirstTimer < 0f)
                    spawnFirstTimer = 0f;
            }

            if (spawnDelayTimer > 0f && !spawnDelayTimerPause)
                spawnDelayTimer -= Time.deltaTime;
            else if (spawnDelayTimer < 0f)
                spawnDelayTimer = 0f;

            if (increaseQuantityTimer > 0f)
                increaseQuantityTimer -= Time.deltaTime;
            else if (increaseQuantityTimer < 0f)
                increaseQuantityTimer = 0f;

            if (spawnFirstTimer == 0f && !spawnedFirst)
            {
                spawnedFirst = true;
                spawnDelayTimerPause = false;
                spawnDelayTimer = 0f;
            }

            if (spawnDelayTimer == 0f)
            {
                spawnDelayTimer = spawnDelayTime;
                StartCoroutine(SpawnGroups());
            }

            if(increaseQuantityTimer == 0f)
            {
                increaseQuantityTimer = increaseQuantityTime;
                spawnQuantity++;
            }
        }

        // Spawn a group of enemies based on the quantity value.
        IEnumerator SpawnGroups()
        {
            for(int i = 0; i < spawnQuantity; i++)
            {
                Spawn();

                yield return new WaitForSeconds(1f);
            }
        }

        // Spawn a singular enemy.
        void Spawn()
        {
            if(!SessionManager.control.SessionFinished())
                Instantiate(enemyBlueprint, transform.position, Quaternion.identity);
        }
    }
}