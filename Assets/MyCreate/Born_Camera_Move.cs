﻿using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Born_Camera_Move : MonoBehaviour
{
	private Transform tr;
	Camera_Move_Rotate c;
	void Start()
    {
		tr = GetComponent<Transform>();
		c = new Camera_Move_Rotate();
	}

    void Update()
    {
		c.Rotare(tr);
		c.speed = 2.0f;
		c.Move(tr, c.speed);
    }
}
