/**
 * Juego de Reversi/Othello usando Processing
 */
int ancho = 8, 
  alto = 8, 
  tamano = 64;
boolean p1Turn = true;
int playerCode;
Tablero tablero; 
boolean bandera = true;
//Variable para detener el juego
int detener=0;
Heuristica heuristica;
//Variable que representa la profundidad máxima del árbol.
int depth;
//Esto representa dónde va a tirar el agente
Coordenada corj2;
private int x;
private int y;

// Inicial para establecer tamaño de ventana con variables
void settings() {
  size((ancho * tamano)+1, (alto * tamano)+1);
}

// Inicialización
void setup() {
  println("Va el jugador 1");
  tablero = new Tablero(ancho, alto, tamano);
  playerCode = 1;
  tablero.calculaValido(playerCode);
  heuristica = new Heuristica();
  //La profundidad del árbol será 4. 
  depth = 4;  
}

// Update. Continuamente ejecuta y dibuja el código contenido en él
void draw() {
  
  if(bandera){
    // parte del codigo donde tira el agente
    if(playerCode == 2){
     corj2 = tira();
     x = corj2.getX();
     y = corj2.getY();
     tablero.setDisk(x, y, playerCode);
       tablero.cambiaMundo(x , y , playerCode);
      
       tablero.Limpia();
       p1Turn = !p1Turn;
       if (p1Turn) {
          playerCode = 1;
       } else {
          playerCode = 2;
       }   
    }  
    tablero.calculaValido(playerCode);
    bandera = false;
  }
  
  if(tablero.casillas_validas.isEmpty()){
    if(tablero.tieneCasillasLibres(playerCode)){
       bandera = true;
        println("el jugador " + playerCode + " no pudo va a tirar ");
        p1Turn = !p1Turn;
        if (p1Turn) {
           playerCode = 1;
        } else {
           playerCode = 2;
       }   
       println("tira el siguiente jugador" + playerCode);
    }else{
      if(tablero.count(1)>=tablero.count(2)){
          if(tablero.count(1) == tablero.count(2)){
            println("Empate");
          }else{
            println("Ganó el jugador 1");
          }
           
      }else{
         println("Ganó el agente");
      }
      stop();
    }
   }
  tablero.display();
}

// Callback. Evento que ocurre después de presionar el botón del mouse
void mouseClicked() {

  x=0;
  y=0;

  if(playerCode==1){
    x = tablero.toTileInt(mouseX);
    y = tablero.toTileInt(mouseY);
  }

  // Colocar un disco/ficha en el tablero:
  if(tablero.isValid(x , y )){
       tablero.setDisk(x, y, playerCode);
       tablero.cambiaMundo(x , y , playerCode);
      
       tablero.Limpia();
       p1Turn = !p1Turn;
       if (p1Turn) {
          playerCode = 1;
       } else {
          playerCode = 2;
       }        
       bandera = true;
       
       //La variable para detener se reinicia.
       detener=0;
       println("Va el jugador "+playerCode);
  }
}//Aquí termina mouseClicked

//Función para que tire el agente
public Coordenada tira(){
   Agente ag1 = new Agente(tablero);
   ag1.calculaArbol(playerCode, ag1.arbol_decision , depth);
   Coordenada cor = ag1.miniMax(ag1.arbol_decision);
   println("el agente tiro en " + cor);
   return cor;
}