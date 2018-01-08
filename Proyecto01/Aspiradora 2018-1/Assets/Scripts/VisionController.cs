using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class VisionController : MonoBehaviour {

    public  bool cercaBasura;
    private GameObject basura;

    void OnTriggerStay(Collider other) {
		if(other.gameObject.CompareTag("Basura")){
         	Debug.Log("Cerca de basura");
            cercaBasura = true;
            basura = other.gameObject;
		}
	}

	void OnTriggerExit(Collider other) {
	    if(other.gameObject.CompareTag("Basura")){
     	    Debug.Log("Lejos de basura");
            cercaBasura = false;
		}
	}

     public bool EstaCercaBasura()
    {
        return cercaBasura;
    }

    public GameObject getBasura()
    {
        return basura;
    }
}
