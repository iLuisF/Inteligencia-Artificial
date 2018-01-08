using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Sensores : MonoBehaviour {

    public bool tocarb;
    private bool tocarp;
    public VisionController vision;
    public  GameObject basura;
    public float maxDistanceRay;
    public  RaycastHit hit;
    public bool tocare;

    private void Start()
    {
        vision = transform.Find("Vision").gameObject.GetComponent<VisionController>();
    }

    public bool TocandoBasura()
    {       
        return tocarb;
	}

    void OnCollisionEnter(Collision other)
    {
        if (other.gameObject.CompareTag("Basura"))
        {
            tocarb = true;
            basura = other.gameObject;
        }
        if (other.gameObject.CompareTag("Pared"))
        {
            tocarp = true;
        }
        if (other.gameObject.CompareTag("EstacionDeCarga"))
        {
            tocare = true;
        }
    }

    void OnCollisionExit(Collision other)
    {
        if (other.gameObject.CompareTag("Basura"))
        {
            tocarb = false;
        }
        if (other.gameObject.CompareTag("Pared"))
        {
            tocarp = false;
        }
        if (other.gameObject.CompareTag("EstacionDeCarga"))
        {
            tocare = false;
        }
    }

    //Con este si funciona.
    private void OnTriggerStay(Collider other)
    {
        if (other.gameObject.CompareTag("EstacionDeCarga"))
        {
            if (GetComponent<Comportamiento>().bateria < 60)
            {
                GetComponent<Comportamiento>().bateria += 2 * Time.deltaTime;                
            }            
        }
    }

    //Si la estación de carga es atravesable, se usa este método.
    /*
    private void OnCollisionStay(Collision other)
    {
        if (other.gameObject.CompareTag("EstacionDeCarga"))
        {
            GetComponent<Comportamiento>().bateria += 2 * Time.deltaTime;
        }
    }
    */

    public bool TocandoPared()
    {
		return tocarp;
	}

	public bool CercaDeBasura()
    {
        
		return vision.EstaCercaBasura();
	}

    public bool TocandoEstacionCarga()
    {
        return tocare;
    }


    private void FixedUpdate()
    {
        //VeralFrente con rayo.
        
       
        if (Physics.Raycast(transform.position, transform.forward, out hit, maxDistanceRay))
        {
            Debug.DrawLine(transform.position, transform.position + transform.forward * maxDistanceRay);
        }                
    }


}
