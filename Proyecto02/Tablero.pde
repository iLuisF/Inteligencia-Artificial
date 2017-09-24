/**
 * Representación de un tablero del juego Reversi/Othello.
 * La representación del tablero es mediante un arreglo bidimensional de enteros
 * que representan: 0 = casilla vacia, 1 = disco del jugador 1, 2 = disco del jugador 2.
 * @author  Rodrigo Colín
 * @version %I%, %G%
 */
class Tablero {
  int ancho;
  int alto;
  int tamano;
  int[][] mundo;
  color p1Color = color(205, 150, 0);
  color p2Color = color(110, 230, 200);

  /**
   * Constructor por default de un Tablero de 8x8 con tamaño de casilla 100px.
   */
  Tablero() {
    this(8, 8, 100);
  }

  /**
   * Constructor por default de un Tablero de 8x8.
   * @param tamano tamaño en pixeles de cada casilla cuadrada del tablero
   */
  Tablero(int tamano) {
    this(8, 8, tamano);
  }

  /**
   * Constructor principal de un tablero.
   * @param  ancho  anchura, en casillas, del tablero
   * @param  alto   altura, en casillas, del tablero
   * @param  tamano tamaño en pixeles de cada casilla cuadrada del tablero
   */
  Tablero(int ancho, int alto, int tamano) {
    this.ancho = ancho;
    this.alto = alto;
    this.tamano = tamano;
    mundo = new int[alto][ancho];
    for (int i = 0; i < this.alto; i++) {
      for (int j = 0; j < this.ancho; j++) {
        mundo[i][j] = 0;
      }
    }
    // Configuración inicial
    mundo[alto/2][ancho/2] = 1;
    mundo[alto/2-1][ancho/2] = 2;
    mundo[alto/2][ancho/2-1] = 2;
    mundo[alto/2-1][ancho/2-1] = 1;
  }

  /**
   * Constructor de copia para un Tablero.
   * @param mundo representa la configutación que será copiada para crear el nuevo Tablero
   */
  Tablero(int[][] mundo) {
    this(mundo, 100);
  }

  /**
   * Constructor de copia para un Tablero con tamaño de casilla personalizado.
   * @param mundo  representa la configutación que será copiada para crear el nuevo Tablero
   * @param tamano tamaño en pixeles de cada casilla cuadrada del tablero
   */
  Tablero(int[][] mundo, int tamano) {
    ancho = mundo[0].length;
    alto = mundo.length;
    this.tamano = tamano; 
    this.mundo = new int[mundo.length][mundo[0].length];
    for (int i = 0; i < alto; i++) {
      for (int j = 0; j < ancho; j++) {
        this.mundo[i][j] = mundo[i][j];
      }
    }
  }

  /**
   * Conversor de pixel a número de casilla dentro de un Tablero.
   * Útil al dar clic sobre la pantalla y determinar la posición (x ó y) en el Tablero.
   * @param n valor en pixel con respecto a la ventana
   * @return  entero que representa el número de casilla en el Tablero
   */
  int toTileInt(int n) {
    return floor(n/tamano);
  }

  /**
   * Cuenta la cantidad de discos/fichas de un determinado jugador en el Tablero.
   * @param  player identificador del jugador, es decir: 1 = Jugador 1, 2 = Jugador 2
   * @return        cantidad de discos/fichas en el tablero del jugador dado como parámetro 
   */
  int count(int player) {
    int total = 0;
    for (int i = 0; i < alto; i++) {
      for (int j = 0; j < ancho; j++) {
        if (mundo[i][j] == player) {
          total += 1;
        }
      }
    }
    return total;
  }
  
  /**
   * Establece o cambia un disco/ficha del tablero en la posición indicada.
   * Nota: no se realiza ninguna verificación sobre la posición o cambios en los demás discos
   * @param x      posición X en coordenadas del tablero (no en pixeles) donde se estable el disco
   * @param y      posición Y en coordenadas del tablero (no en pixeles) donde se estable el disco
   * @param player identificador del jugador, es decir: 1 = Jugador 1, 2 = Jugador 2
   */
  void setDisk(int x, int y, int player) {
    mundo[y][x] = player;
  }

  /**
   * Determina si la casilla seleccionada es válida para colocar un disco/ficha.
   * TODO: Realizar una validación más exhaustiva, por el momento solo revisa si la casilla es vacia
   * Inferior: Dada la posición en que se quiere tirar, hacía abajo debe haber al menos una ficha 
   * contrincante y al final de estas lineas debe haber una ficha igual de la que se quiere tirar. 
   * Superior:
   * Derecho:
   * Izquierdo:
   * Diagonal superior derecha:
   * Diagonal superior izquierda:
   * Diagonal inferior derecha:
   * Diagonal inferior izquierda: 
   * @param x posición X en coordenadas del tablero (no en pixeles) donde se valida la casilla
   * @param y posición Y en coordenadas del tablero (no en pixeles) donde se valida la casilla
   */
  boolean isValid(int x, int y, int playerCode) {
    System.out.println(x + " " + y);
    if (mundo[y][x] == 0){ //¿Es espacio libre?
      
      //Para evitar el corto circuito que provoca el or.
      
      boolean uno = esAdyacenciaVerticalInferiorValida(x, y, playerCode);
      boolean dos = esAdyacenciaVerticalSuperiorValida(x, y, playerCode);
      boolean tres = esAdyacenciaHorizontalDerechaValida(x, y, playerCode);
      boolean cuatro = esAdyacenciaHorizontalIzquierdaValida(x, y, playerCode);
      boolean cinco = esAdyacenciaDiagonalInferiorIzquierdaValida(x, y, playerCode);
      boolean seis = esAdyacenciaDiagonalInferiorDerechaValida(x, y, playerCode);
      boolean siete = esAdyacenciaDiagonalSuperiorDerechaValida(x, y, playerCode);
      boolean ocho = esAdyacenciaDiagonalSuperiorIzquierdaValida(x, y, playerCode);
                 
      return uno || dos || tres || cuatro || cinco || seis || siete || ocho;
    } else {
      return false;
    }        
  }

  /**
   * Verifica que la adyacencia vertical inferior tenga al menos en la siguiente casilla
   * una ficha del contricante ó que no sea vacia, que al final tenga la misma ficha que 
   * se quiere tirar.
   * @return Si cumple con las condiciones, es valida.
   */
  private boolean esAdyacenciaVerticalInferiorValida(int x, int y, int playerCode){          
      boolean esValido = false;
      int tmpY = y;
      //Para evitar problemas con los indices.
      if(y == this.alto - 1){
        return false;
      }
      if(mundo[y+1][x] == playerCode || mundo[y+1][x] == 0){
        esValido = false;
        return esValido;
      }
      for(; y < this.alto; y++){                  
         if(mundo[y][x] == (((playerCode + 1)%2) + 1)){
           //Asignamos fichas.
           //for(int i = tmpY; i <= y; i++){
           while(tmpY <= y){
             setDisk(x, tmpY, (((playerCode + 1)%2) + 1));
             tmpY++;
           }
           esValido = true;
           return esValido;
         }
      }
      return esValido;
  }
      
  private boolean esAdyacenciaVerticalSuperiorValida(int x, int y, int playerCode){
    boolean esValido = false;
    int tmpY = y;
    //Si se encuentra hasta arriba, esto para prevenir error fuera de indices.
    if(y == 0){
      esValido = false;
      return esValido;
    }
    if(mundo[y-1][x] == playerCode || mundo[y-1][x] == 0){
        esValido = false;
        return esValido;
      }  
      while(y != 0){
        if(mundo[y][x] == (((playerCode + 1)%2) + 1)){
          //Asignamos fichas.           
           while(tmpY != y){
             setDisk(x, tmpY, (((playerCode + 1)%2) + 1));
             tmpY--;
           } 
          esValido = true;
           return esValido;
         }
        y--;
      }
    return esValido;
  }

  private boolean esAdyacenciaHorizontalDerechaValida(int x, int y, int playerCode){
    boolean esValido = false;
    int tmpX = x;
    //Si se encuentra hasta la derecha, esto para prevenir error fuera de indices.
    if(x == this.ancho - 1){
      esValido = false;
      return esValido;
    }
    if(mundo[y][x + 1] == playerCode || mundo[y][x+1] == 0){
        esValido = false;
        return esValido;
      }  
      for(; x < this.ancho; x++){         
         if(mundo[y][x] == (((playerCode + 1)%2) + 1)){
           //Asignamos fichas.
           //for(int i = tmpY; i <= y; i++){
           while(tmpX <= x){
             setDisk(tmpX, y, (((playerCode + 1)%2) + 1));
             tmpX++;
           }
           esValido = true;
           return esValido;
         }
      }
    return esValido;
  }
  
  private boolean esAdyacenciaHorizontalIzquierdaValida(int x, int y, int playerCode){   
    //Si se encuentra hasta la derecha, esto para prevenir error fuera de indices.
    int tmpX = x;
    if(x == 0){      
      return false;
    }
    if(mundo[y][x - 1] == playerCode || mundo[y][x - 1] == 0){        
        return false;
      }  
      while(x != 0){
        if(mundo[y][x] == (((playerCode + 1)%2) + 1)){
          //Asignamos fichas.           
           while(tmpX != x){
             setDisk(tmpX, y, (((playerCode + 1)%2) + 1));
             tmpX--;
           }
           return true;
         }
        x--;
      }
    return false;
  }

  private boolean esAdyacenciaDiagonalSuperiorDerechaValida(int x, int y, int playerCode){
     boolean esValido = false;
      int tmpY = y;
      int tmpX = x;
      //Para evitar problemas con los indices.
      if(y == 0 || x == this.ancho - 1){
        return false;
      }
      if(mundo[y - 1][x + 1] == playerCode || mundo[y - 1][x + 1] == 0){
        esValido = false;
        return esValido;
      }      
      //Comprueba que haya una ficha para hacer el franqueo.
      while(y  > 0 && x < this.ancho){
        if(mundo[y][x] == (((playerCode + 1)%2) + 1)){
           while(tmpY >= y && tmpX != x){
             setDisk(tmpX, tmpY, (((playerCode + 1)%2) + 1));
             tmpY--;
             tmpX++;
           }
           esValido = true;
           return esValido;
        }
        y--;
        x++;
      }      
      return esValido;
  }
  
  private boolean esAdyacenciaDiagonalSuperiorIzquierdaValida(int x, int y, int playerCode){
      boolean esValido = false;
      int tmpY = y;
      int tmpX = x;
      //Para evitar problemas con los indices.
      if(y == 0 || x == 0){
        return false;
      }
      if(mundo[y - 1][x - 1] == playerCode || mundo[y - 1][x - 1] == 0){
        esValido = false;
        return esValido;
      }      
      //Comprueba que haya una ficha para hacer el franqueo.
      while(y  > 0 && x > 0){
        if(mundo[y][x] == (((playerCode + 1)%2) + 1)){
           while(tmpY >= y && tmpX >= x){
             setDisk(tmpX, tmpY, (((playerCode + 1)%2) + 1));
             tmpY--;
             tmpX--;
           }
           esValido = true;
           return esValido;
        }
        y--;
        x--;
      }      
      return esValido;
  }

  private boolean esAdyacenciaDiagonalInferiorDerechaValida(int x, int y, int playerCode){
      boolean esValido = false;
      int tmpY = y;
      int tmpX = x;
      //Para evitar problemas con los indices.
      if(y == this.alto - 1 || x == this.ancho - 1){
        return false;
      }
      //Revisa la siguiente casilla de la que se tira.
      if(mundo[y + 1][x + 1] == playerCode || mundo[y + 1][x + 1] == 0){
        esValido = false;
        return esValido;
      }      
      //Comprueba que haya una ficha para hacer el franqueo.
      while(y  < this.alto && x < this.ancho){
        if(mundo[y][x] == (((playerCode + 1)%2) + 1)){
           while(tmpY <= y && tmpX <= x){
             setDisk(tmpX, tmpY, (((playerCode + 1)%2) + 1));
             tmpY++;
             tmpX++;
           }
           esValido = true;
           return esValido;
        }
        y++;
        x++;
      }      
      return esValido;
  }
  
  private boolean esAdyacenciaDiagonalInferiorIzquierdaValida(int x, int y, int playerCode){
      boolean esValido = false;
      int tmpY = y;
      int tmpX = x;
      //Para evitar problemas con los indices.
      if(y == this.alto - 1 || x == 0){
        return false;
      }
      if(mundo[y + 1][x - 1] == playerCode || mundo[y + 1][x - 1] == 0){
        esValido = false;
        return esValido;
      }      
      //Comprueba que haya una ficha para hacer el franqueo.
      while(y  < this.alto && x > 0){
        if(mundo[y][x] == (((playerCode + 1)%2) + 1)){
           while(tmpY <= y && tmpX != x){
             setDisk(tmpX, tmpY, (((playerCode + 1)%2) + 1));
             tmpY++;
             tmpX--;
           }
           esValido = true;
           return esValido;
        }
        y++;
        x--;
      }      
      return esValido;
  }
    
  /**
   * Dibuja una representación gráfica del tablero en la ventana de Processing. 
   */
  void display() {
    for (int i = 0; i < alto; i++) {
      for (int j = 0; j < ancho; j++) {
        // Dibujar las casillas del tablero:
        fill(80);
        stroke(255);
        rect(j * tamano, i * tamano, tamano, tamano);
        // Dibujar los discos/fichas del tablero:
        if (mundo[i][j] == 1) {
          fill(p1Color);
          noStroke();
          ellipse((j*tamano)+(tamano/2), (i*tamano)+(tamano/2), tamano/2, tamano/2);
        } else if (mundo[i][j] == 2) {
          fill(p2Color);
          noStroke();
          ellipse((j*tamano)+(tamano/2), (i*tamano)+(tamano/2), tamano/2, tamano/2);
        }
      }
    }
  }
}