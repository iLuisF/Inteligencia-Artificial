
/**
 *
 * @author Flores González Luis.
 * @version 1.0 - Febrero 2017
 */
public class Celda {

    private boolean paredIzquierda;
    private boolean paredDerecha;
    private boolean paredArriba;
    private boolean paredAbajo;
    private boolean visitada;
    private boolean actual;
    private int x;
    private int y;

    public Celda(boolean esVisitada, int x, int y) {
        this.visitada = esVisitada;
        this.actual = false;
        this.paredIzquierda = false;
        this.paredDerecha = false;
        this.paredArriba = false;
        this.paredAbajo = false;
        this.x = x;
        this.y = y;
    }

    public boolean isParedIzquierda() {
        return paredIzquierda;
    }

    public void setParedIzquierda(boolean paredIzquierda) {
        this.paredIzquierda = paredIzquierda;
    }

    public boolean isParedDerecha() {
        return paredDerecha;
    }

    public void setParedDerecha(boolean paredDerecha) {
        this.paredDerecha = paredDerecha;
    }

    public boolean isParedArriba() {
        return paredArriba;
    }

    public void setParedArriba(boolean paredArriba) {
        this.paredArriba = paredArriba;
    }

    public boolean isParedAbajo() {
        return paredAbajo;
    }

    public void setParedAbajo(boolean paredAbajo) {
        this.paredAbajo = paredAbajo;
    }

    public boolean isVisitada() {
        return visitada;
    }

    public void setVisitada(boolean visitada) {
        this.visitada = visitada;
    }

    public boolean isActual() {
        return actual;
    }

    public void setActual(boolean actual) {
        this.actual = actual;
    }

    public int getX() {
        return x;
    }

    public void setX(int x) {
        this.x = x;
    }

    public int getY() {
        return y;
    }

    public void setY(int y) {
        this.y = y;
    }

}
