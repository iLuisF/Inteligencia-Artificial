
import java.util.LinkedList;
import java.util.Random;


/**
 *
 * @author Flores González Luis.
 * @version 1.0 - Febrero 2017
 * 
 */
public class Laberinto {
 
    private int ancho;
    private int largo;
    private Celda tablero[][];
    private Random aleatorio;
    private Celda actual;
    private int area;
    
    /**
     * Construye un laberinto con las dimensiones dadas.
     */
    public Laberinto(int x, int y, int area){
        this.ancho = y/area;
        this.largo = x/area;
        this.area = area;
        this.aleatorio = new Random();
        this.tablero = new Celda[this.largo][this.ancho];
        for(int i = 0; i < largo; i++){
            for(int j = 0; j < ancho; j++){
                this.tablero[i][j] = new Celda(false, i, j);
            }
        }
        this.actual = tablero[getAleatorio().nextInt(this.largo)]
                [aleatorio.nextInt(this.ancho)];
        this.actual.setActual(true);
    }

    public boolean hayCeldaIzquierda(Celda actual){
        try{
            Celda temp = this.tablero[actual.getX() - 1][actual.getY()];
            return true;
        }catch(Exception e){
            return false;
        }
    }
    
    public boolean hayCeldaDerecha(Celda actual){
        try{
            Celda temp = this.tablero[actual.getX() + 1][actual.getY()];
            return true;
        }catch(Exception e){
            return false;
        }
    }
    
    public boolean hayCeldaArriba(Celda actual){
        try{
            Celda temp = this.tablero[actual.getX() - 1][actual.getY() - 1];
            return true;
        }catch(Exception e){
            return false;
        }
    }
    
    public boolean hayCeldaAbajo(Celda actual){
        try{
            Celda temp = this.tablero[actual.getX() - 1][actual.getY() + 1];
            return true;
        }catch(Exception e){
            return false;
        }
    }
    
    public Celda getVecinoAleatorio(Celda actual){
        try{
            int siguiente = this.getAleatorio().nextInt(4);
            switch(siguiente){                
                case 0:
		    return this.tablero[actual.getX()][actual.getY()+1];
		case 1:
		    return this.tablero[actual.getX()][actual.getY()-1];
		case 2:
		    return this.tablero[actual.getX()+1][actual.getY()];
		case 3:
		    return this.tablero[actual.getX()-1][actual.getY()];
            }
        }catch(Exception e){
            return getVecinoAleatorio(actual);
        }
        return null;
    }
    
	private void quitaPared(Celda actual1, Celda actual2){
	    if(hayCeldaArriba(actual1)){
		if(this.tablero[actual1.getX()][actual1.getY()-1].equals(actual2)){
		    actual1.setParedArriba(false);
		    actual2.setParedAbajo(false);
		}
	    }
	    if(hayCeldaAbajo(actual1)){
		if(this.tablero[actual1.getX()][actual1.getY()+1].equals(actual2)){
		    actual2.setParedArriba(false);
		    actual1.setParedAbajo(false);
		}
	    }
	    if(hayCeldaAbajo(actual1)){
		if(this.tablero[actual1.getX()+1][actual1.getY()].equals(actual2)){
		    actual1.setParedDerecha(false);
		    actual2.setParedIzquierda(false);
		}
	    }
	    if(hayCeldaIzquierda(actual1)){
		if(this.tablero[actual1.getX()-1][actual1.getY()].equals(actual2)){
		    actual2.setParedDerecha(false);
		    actual1.setParedIzquierda(false);
		}
	    }
	}
        
        
    /////Probando
        
/**
	 * Metodo que dada una casilla nos regresa un vecino no visitado.
	 * @param cas - La casilla a verificar sus vecinos.
	 * @return Una casilla que no ha sido visitada.
	 */
	public Celda getVecinoNoVisitado(Celda cas){
	    LinkedList<Celda> visitados = new LinkedList<Celda>();
	    int next = this.getAleatorio().nextInt(4);
	    int next3 = this.getAleatorio().nextInt(3);
	    boolean nextB = this.getAleatorio().nextBoolean();
	    if(hayCeldaArriba(cas))
		if(!this.tablero[cas.getX()][cas.getY()-1].isVisitada())
		    visitados.add(this.tablero[cas.getX()][cas.getY()-1]);
	    if(hayCeldaAbajo(cas))
		if(!this.tablero[cas.getX()][cas.getY()+1].isVisitada())
		    visitados.add(this.tablero[cas.getX()][cas.getY()+1]);
	    if(hayCeldaIzquierda(cas))
		if(!this.tablero[cas.getX()-1][cas.getY()].isVisitada())
		    visitados.add(this.tablero[cas.getX()-1][cas.getY()]);
	    if(hayCeldaDerecha(cas))
		if(!this.tablero[cas.getX()+1][cas.getY()].isVisitada())
		    visitados.add(this.tablero[cas.getX()+1][cas.getY()]);
	    if(visitados.size() == 1){
		return visitados.get(0);
	    }else if(visitados.size() == 2){
		if(nextB)
		    return visitados.get(0);
		return visitados.get(1);
	    }else if(visitados.size() == 3){
		switch(next3){
		case 0:
		    return visitados.get(0);
		case 1:
		    return visitados.get(1);
		case 2:
		    return visitados.get(2);
		}
	    }else if(visitados.size() == 4){
		switch(next){
		case 0:
		    return visitados.get(0);
		case 1:
		    return visitados.get(1);
		case 2:
		    return visitados.get(2);
		case 3:
		    return visitados.get(3);
		}
	    }
	    return null;
	}

	        
    /////Probando
    
    public int getAncho() {
        return ancho;
    }

    public void setAncho(int ancho) {
        this.ancho = ancho;
    }

    public int getLargo() {
        return largo;
    }

    public void setLargo(int largo) {
        this.largo = largo;
    }

    public Celda[][] getTablero() {
        return tablero;
    }

    public void setTablero(Celda[][] tablero) {
        this.tablero = tablero;
    }

    public Random getAleatorio() {
        return aleatorio;
    }

    public void setAleatorio(Random aleatorio) {
        this.aleatorio = aleatorio;
    }

    public Celda getActual() {
        return actual;
    }

    public void setActual(Celda actual) {
        this.actual = actual;
    }

    public int getArea() {
        return area;
    }

    public void setArea(int area) {
        this.area = area;
    }
    
    
}
