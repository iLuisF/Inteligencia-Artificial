using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Actuadores : MonoBehaviour {

    public  float  velocidad = 20f;
    public float velocidadr = 0;
    public int contador;

	// Mueve (Translate) al objeto en la direccion hacia adelante con respecto a su vector de direccion (forward)
	public void MoverAdelante(){
        transform.Translate(0, 0, Time.deltaTime * velocidad);
    }

	// Mueve (Translate) al objeto en la direccion hacia atrás con respecto a su vector de direccion (forward)
	public void MoverAtras(){
        transform.Translate(0, 0, Time.deltaTime * velocidad * -1);
    }

	// Gira (Rotate) al objeto hacia la derecha con respecto a su posicion actual
	public void GirarDerecha(){
        transform.Rotate(0, Time.deltaTime * velocidadr, 0);

	}

	// Gira (Rotate) al objeto hacia la izquierda con respecto a su posicion actual
	public void GirarIzquierda(){
        transform.Rotate(0, Time.deltaTime * velocidadr * -1, 0);
    }

    public void Aspirar(GameObject basura)
    {
        
        Destroy(basura);

        contador++;       
    }

    public void MoverHaciaBateria()
    {
        float step = velocidad * Time.deltaTime;
        Transform target = GameObject.FindGameObjectWithTag("EstacionDeCarga").transform;
        transform.position = Vector3.MoveTowards(transform.position, target.position, step);
    }
}
