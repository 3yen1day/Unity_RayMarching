using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CameraMove : MonoBehaviour
{
    public float Speed = 0.1f;
    private Vector3 p;
    // Start is called before the first frame update
    void Start()
    {
     p = this.transform.position;   
    }

    // Update is called once per frame
    void Update()
    {
        p.z+=Speed;
        this.transform.position = p;
    }
}
