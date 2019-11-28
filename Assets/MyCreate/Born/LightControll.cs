using System.Collections;
using System.Collections.Generic;
using UnityEngine;



public class LightControll : MonoBehaviour
{
    public GameObject slight;
    public GameObject slight2;
    public GameObject slight3;
    public GameObject slight4;
    public GameObject slight5;
    public GameObject slight6;
float lightsyoki;
float LIntensity;
    // Start is called before the first frame update
    void Start()
    {
        lightsyoki = slight.GetComponent<Light>().intensity;
    }

    // Update is called once per frame
    void Update()
    {
        LIntensity = Mathf.Pow(Mathf.Sin(Time.time*5.0f) ,2) ;
        slight.GetComponent<Light>().intensity = LIntensity;
        slight2.GetComponent<Light>().intensity = LIntensity;
        slight3.GetComponent<Light>().intensity = LIntensity;
        slight4.GetComponent<Light>().intensity = LIntensity;
        slight5.GetComponent<Light>().intensity = LIntensity;
        slight6.GetComponent<Light>().intensity = LIntensity;
        Debug.Log(LIntensity);
    }
}
