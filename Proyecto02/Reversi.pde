/**
 * Juego de Reversi/Othello usando Processing
 */
int ancho = 8, 
  alto = 6, 
  tamano = 64;
boolean p1Turn = true;
int playerCode;
Tablero tablero; 

// Inicial para establecer tamaño de ventana con variables
void settings() {
  size((ancho * tamano)+1, (alto * tamano)+1);
}

// Inicialización
void setup() {
  tablero = new Tablero(ancho, alto, tamano);
}

// Update. Continuamente ejecuta y dibuja el código contenido en él
void draw() {
  tablero.display();
}

// Callback. Evento que ocurre después de presionar el botón del mouse
void mouseClicked() {
  if (p1Turn) {
    playerCode = 1;
  } else {
    playerCode = 2;
  }
  // Colocar un disco/ficha en el tablero:
  if(tablero.isValid(tablero.toTileInt(mouseX), tablero.toTileInt(mouseY), playerCode)){
    tablero.setDisk(tablero.toTileInt(mouseX), tablero.toTileInt(mouseY), playerCode);
    p1Turn = !p1Turn;
  }
  // Conteo de discos/fichas
  println("Player " + playerCode + " discs: " + tablero.count(playerCode));
}