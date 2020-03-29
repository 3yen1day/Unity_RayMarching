using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CameraMove : MonoBehaviour
{
    public float Speed = 1.0f;
    private Vector3 p;
	private Transform tr;
	Camera_Move_Rotate c;
	// Start is called before the first frame update
	void Start()
    {
     p = this.transform.position;
	 tr = GetComponent<Transform>();
	 c = new Camera_Move_Rotate();
	}

    // Update is called once per frame
    void Update()
    {
        p.z+=Speed*Time.deltaTime;
		tr.position = p;

		c.Rotare(tr);
	}
}
