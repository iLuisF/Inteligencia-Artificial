using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Comportamiento : MonoBehaviour {

	private Sensores sensor;
	private Actuadores actuador;
	public float bateria; // tiempo de vida del agente
    private int contador = 0;
    private bool ir_basura = false; //¿Esta llendo ya por una basura?
    int cuadrante = 0; //Cuadrante en el que esta la basura detectada por la visión.
    private bool termine = true;
    private float posBasuraX; 
    private float posBasuraZ;
    private bool combustible_optimo; //¿Se termino de cargar?
    private bool esquivando; //¿Esta esquivando despues de haber tocado una pared?
    private bool esta_adelante; //¿La pared esta adelante?
    private bool elegido = false; //Calcula una vez la opción de giro cuando esquiva.
    int opcione = 0; //Hacia donde va a girar cuando esquiva.

    // Use this for initialization
    void Start () {
		sensor = GetComponent<Sensores>();
		actuador = GetComponent<Actuadores>();
	}

	// Update is called once per frame
	void Update () {   
        if (bateria > 0 && !ir_basura){
			//bateria -= Time.deltaTime; // disminuir la bateria con respecto al tiempo

			if(Input.GetKeyDown(KeyCode.UpArrow) || Input.GetAxis("Vertical") == 1){
				actuador.MoverAdelante();
			}
			if(Input.GetKeyDown(KeyCode.DownArrow) || Input.GetAxis("Vertical") == -1){
				actuador.MoverAtras();
			}
			if(Input.GetKeyDown(KeyCode.RightArrow) || Input.GetAxis("Horizontal") == 1){
				actuador.GirarDerecha();
			}
			if(Input.GetKeyDown(KeyCode.LeftArrow) || Input.GetAxis("Horizontal") == -1){
				actuador.GirarIzquierda();
			}

			if(sensor.TocandoPared()){
				Debug.Log("Tocando pared");
			}
			if(sensor.TocandoBasura()){
				Debug.Log("Tocando basura");
			}
			if(sensor.CercaDeBasura()){
				Debug.Log("Cerca de basura");
			}
		}
        if (sensor.TocandoBasura())
        {
            actuador.Aspirar(sensor.basura);
            ir_basura = false;
            sensor.vision.cercaBasura = false;
            sensor.tocarb = false;
            cuadrante = 0;
            
            
        }
        
    }

    public void FixedUpdate()
    {
        // posicion agente
        float posAgenteX = this.GetComponent<Rigidbody>().position.x;
        float posAgenteZ = this.GetComponent<Rigidbody>().position.z;
        float random = Random.Range(1, 5);
        int opcion = (int)random;
        int rotacion = (int)(Quaternion.Euler(0, 180, 0).y * 100);
        int ry;
        

        float rotacionAgenteY = this.transform.rotation.y;

        if(bateria > 0)
        {
            if (!sensor.TocandoPared() || esquivando)
            {
                if(sensor.TocandoEstacionCarga() && bateria > 40 && combustible_optimo)
                {
                    esquivando = true;
                }
                if (esquivando)
                {
                    if (esta_adelante)
                    {
                        actuador.MoverAtras();
                        actuador.MoverAtras();
                        actuador.MoverAtras();
                        esta_adelante = false;
                    }
                    else
                    {
                        if (!elegido)
                        {
                            opcione = opcion;
                            elegido = true;
                        }

                        switch (opcione)
                        {
                            case 1:
                                rotacion = (int)(Quaternion.Euler(0, 20, 0).y * 100);
                                break;
                            case 2:
                                rotacion = (int)(Quaternion.Euler(0, 110, 0).y * 100);
                                break;
                            case 3:
                                rotacion = (int)(Quaternion.Euler(0, -110, 0).y * 100);
                                break;
                            case 4:
                                rotacion = (int)(Quaternion.Euler(0, 170, 0).y * 100);
                                break;
                        }
                        ry = (int)(rotacionAgenteY * 100);

                        if (ry != rotacion)
                        {

                            if (ry > rotacion)
                            {
                                actuador.GirarIzquierda();

                            }
                            else
                            {
                                if (ry < rotacion)
                                {
                                    actuador.GirarDerecha();
                                }
                            }

                        }
                        else
                        {
                            elegido = false;
                            esquivando = false;
                            ir_basura = false;
                            cuadrante = 0;
                        }
                        bateria -= Time.deltaTime;
                    }
                }
                else
                {
                    if (!sensor.TocandoEstacionCarga() && bateria < 30)
                    {

                        actuador.MoverHaciaBateria();
                        combustible_optimo = false;
                    }
                    else
                    {
                        if (combustible_optimo)
                        {

                            if (contador > 10)
                            {

                                if (sensor.CercaDeBasura())
                                {
                                    if (!ir_basura)
                                    {

                                        ry = (int)(rotacionAgenteY * 100);
                                        rotacion = (int)(Quaternion.Euler(0, 0, 0).y * 100);
                                        if (ry != rotacion)
                                        {

                                            if (ry > rotacion)
                                            {
                                                actuador.GirarIzquierda();

                                            }
                                            else
                                            {
                                                if (ry < rotacion)
                                                {
                                                    actuador.GirarDerecha();
                                                }
                                            }

                                        }
                                        else
                                        {
                                            ir_basura = true;
                                            // posisicon basura
                                            posBasuraX = sensor.vision.getBasura().GetComponent<Rigidbody>().position.x;
                                            posBasuraZ = sensor.vision.getBasura().GetComponent<Rigidbody>().position.z;

                                            //calculamos el cuadrante  en donde esta la basura
                                            cuadrante = cuadranteBasura();

                                            Debug.Log("el cuadrante es :" + cuadrante);
                                        }

                                    }
                                    else
                                    {
                                        ry = (int)(rotacionAgenteY * 100);
                                        switch (cuadrante)
                                        {
                                            case 2:
                                            case 1:
                                                if (posAgenteZ < posBasuraZ)
                                                {
                                                    actuador.MoverAdelante();
                                                }
                                                else
                                                {
                                                    if (cuadrante == 1)
                                                    {
                                                        rotacion = (int)(Quaternion.Euler(0, 90, 0).y * 100);
                                                    }
                                                    else
                                                    {
                                                        rotacion = (int)(Quaternion.Euler(0, -90, 0).y * 100);
                                                    }


                                                    if (ry != rotacion)
                                                    {
                                                        if (cuadrante == 1)
                                                        {
                                                            actuador.GirarDerecha();
                                                        }
                                                        else
                                                        {
                                                            actuador.GirarIzquierda();
                                                        }
                                                    }
                                                    else
                                                    {
                                                        if (posAgenteX != posBasuraX)
                                                        {
                                                            actuador.MoverAdelante();
                                                        }
                                                    }
                                                }
                                                break;

                                            case 3:
                                            case 4:
                                                if (posAgenteZ > posBasuraZ)
                                                {
                                                    actuador.MoverAtras();
                                                    //Debug.LogError("entre");
                                                }
                                                else
                                                {
                                                    if (cuadrante == 4)
                                                    {
                                                        rotacion = (int)(Quaternion.Euler(0, 90, 0).y * 100);
                                                    }
                                                    else
                                                    {
                                                        rotacion = (int)(Quaternion.Euler(0, -90, 0).y * 100);
                                                    }

                                                    if (ry != rotacion)
                                                    {
                                                        if (cuadrante == 4)
                                                        {
                                                            actuador.GirarDerecha();
                                                        }
                                                        else
                                                        {
                                                            actuador.GirarIzquierda();
                                                        }

                                                    }
                                                    else
                                                    {
                                                        if (posAgenteX != posBasuraX)
                                                        {
                                                            actuador.MoverAdelante();
                                                        }
                                                    }
                                                }
                                                break;
                                        }
                                    }
                                }
                                else
                                {
                                    switch (opcion)
                                    {
                                        case 4:
                                        case 1:
                                            actuador.MoverAdelante();
                                            actuador.MoverAdelante();
                                            break;
                                        case 2:
                                            actuador.GirarIzquierda();
                                            actuador.GirarIzquierda();
                                            break;
                                        case 3:
                                            actuador.GirarDerecha();
                                            actuador.GirarDerecha();
                                            break;

                                    }
                                    contador = 0;
                                }

                            }
                            contador++;
                            bateria -= Time.deltaTime;
                        }
                        else
                        {
                            if (bateria >= 60)
                            {
                                combustible_optimo = true;
                            }
                        }
                    }
                }
            }
            else
            {
                double puntoColX = sensor.hit.point.x - 0.5;
                double puntoColZ = sensor.hit.point.z;

                if (puntoColX < posAgenteX || puntoColZ < posAgenteZ)
                {
                    esta_adelante = true;
                }


                //Debug.LogError("aproximando auna pard en el punto: (" + puntoColX + " , " + puntoColZ + ")");

                bateria -= Time.deltaTime;
                esquivando = true;
            }
        }
        
    }

    private int cuadranteBasura()
    {
        // posicion agente
        float posAgenteX = this.GetComponent<Rigidbody>().position.x;
        float posAgenteZ = this.GetComponent<Rigidbody>().position.z;

        if(posAgenteX < posBasuraX)
        {
            if(posAgenteZ < posBasuraZ)
            {
                return 1;
            }
            else{
                return 4;
            }
            
        }else
        {
            if (posAgenteZ < posBasuraZ)
            {
                return 2;
            }
            else
            {
                return 3;
            }
        }

        
    }

   
}
