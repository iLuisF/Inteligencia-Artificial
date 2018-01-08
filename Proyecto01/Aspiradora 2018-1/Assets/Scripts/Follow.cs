using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Follow : MonoBehaviour {

	public GameObject target; // GameObject a seguir
	public Vector3 offset = new Vector3(0.0f, 6.0f, -5.0f); // Separación con respecto a "target"

	// Update is called once per frame
	void Update () {
		transform.position = target.transform.position + offset;
		transform.LookAt(target.transform);
	}
}
