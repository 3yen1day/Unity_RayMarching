using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;

public class SceneTranslate : MonoBehaviour
{
    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
		if (Input.GetKeyDown(KeyCode.RightArrow)|| Input.GetKeyDown(KeyCode.LeftArrow))
		{
			if(SceneManager.GetActiveScene().name.Equals("New Scene")) SceneManager.LoadScene("TestScene");
			else SceneManager.LoadScene("New Scene");
		}
	}
}
