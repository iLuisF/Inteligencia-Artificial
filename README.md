# Inteligencia-Artificial

## Proyectos ##

### Proyecto 1: aspiradora automática en Unity ###

Se diseño y construyo una aspiradora automátia que esté recorriendo la casa, para ser más especifico la superficie de esta, en busca
de basura. Donde se tiene una pila recargable y una estación de recarga, cada vez que la aspiradora corre el riesgo de quedarse sin
bateria se dirige a la estación de carga y continua con su labor hasta que se acomplete la recarga. Además se tiene una limpieza 
óptima, es decir, aspira la mayor cantidad de basura en un tiempo minimo. Esto se logro con el **procesador de Videojuego Unity**. 
[Leer más](https://github.com/iLuisF/Inteligencia-Artificial/blob/master/Proyecto01/Reporte%20de%20proyecto%201.pdf "Leer más") 
sobre los algoritmos empleados y la solución.

### Proyecto 2: Othello ###
Othello o Reversi es un juego de estrategia de dos jugadores. Se juega sobre un tablero monocolor de 64 casillas, de 8 por 8. 
Los jugadores disponen de 64 fichas bicolores. El objetivo del juego es tener más fichas de nuestro color que el adversario al final
de la partida pero puede ocurrir el caso de llegar a un empate si ambos jugadores se quedan sin futuras jugadas y si el número de 
fichas propietarias es igual al del contrincante. El final se produce cuando ningún jugador puede realizar más movimientos.

El problema que se resuelve con el programa es hacer que la máquina juegue othello de manera óptima pero sin agotar los recursos 
computacionales. Esto se logra con el **algoritmo minimax** que se utiliza para obtener la decisión más óptima en un juego para
el jugador que llamaremos MAX, al otro jugador le llamaremos MIN. Este consiste en expandir un árbol donde se obtienen todas 
las jugadas posibles, donde cada nodo es un estado del juego y sus hijos son todas las jugadas que se pueden obtener en un turno,
salvo que haya terminado el juego. Cuando se llega a las hojas del árbol, o sea al final del juego, se evalúa el juego con una 
función de utilidad y se le asigna un número. Luego se asigna un valor a cada nodo no terminal con la siguiente regla:
- Si tira MAX, entonces elegirá a su hijo con un valor mayor.
- Si tira MIN, entonces elegirá a su hijo con un valor menor.

Cuando el nodo raíz, que es de MAX, tenga su número, tomará la acción que lo lleva al nodo hijo con un valor más grande. Con este
algoritmo se asume que ambos jugadores juegan de forma óptima. El problema con este algoritmo es que crece de forma exponencial, y en juegos con muchas posibles
jugadas y que terminan en muchos turnos se vuelve un problema intratable. Lo que se hace en juegos de este tipo es minimizar el tiempo de ejecución y la memoria utilizada. 
Esto se logra haciendo una optimización del algoritmo llamado **poda alfa-beta** donde no se tienen que revisar todas las ramas si ya 
se ha encontrado un resultado más óptimo, y otra optimización es no llegar al final del juego, sino evaluar un nodo con una función 
que le asigna un número al estado del juego, donde un número mayor significa que MAX tiene mayor probabilidad de ganar.
[Leer más](https://github.com/iLuisF/Inteligencia-Artificial/blob/master/Proyecto02/othello.pdf "Leer más") 
sobre los algoritmos empleados y la solución.

### Proyecto 3: sistema de recomendación ###

Hay diferentes maneras en las que podemos identificar el uso de sistemas de recomendación, pero
una manera clara y sencilla de hacerlo es por medio de una plataforma que indique una nueva película
a un usuario, dado sus gustos previos. Además para lograr hacer esta plataforma se utiliza una base
de conocimientos. 

Esta plataforma se puede entender mejor cómo el funcionamiento que hace Netflix o Youtube para
indicar nuevos artículos a sus usuarios, esta similitud sólo se hace para entender mejor el problema resuelto.

En este proyecto se desarrollo un sistema de recomendación
colaborativo para que este escoja una película dependiendo los gustos de un usuario dado y la
información que proporcionó. Se **recomienda una película con base en el conocimiento que se tiene con los otros
usuarios y lo que les gusta**. [Leer más](https://github.com/iLuisF/Inteligencia-Artificial/blob/master/Proyecto03/Reporte.pdf "Leer más") 
sobre los algoritmos empleados y la solución.

### Proyecto 4: laberinto ###
Se crea un laberinto plano aleatorio y se encuentra un camino desde la esquina superior izquierda hasta la inferior derecha del 
laberinto.

Para crear el laberinto se necesito de un agente porque este lo construye mientras se
mueve en lo que inicialmente es un tablero. Al final existe un camino entre
cualesquiera 2 casillas en el tablero pero no hay ciclos.

Para encontrar un camino entre las 2 esquinas el agente explora el
laberinto hasta encontrar la casilla objetivo. La solución muestra la secuencia
de casillas que unen a la inicial con la final. 

[Leer más](https://github.com/iLuisF/Inteligencia-Artificial/blob/master/Proyecto04/Reporte.pdf "Leer más") 
sobre los algoritmos empleados y la solución.
