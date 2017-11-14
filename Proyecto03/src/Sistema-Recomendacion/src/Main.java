
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Clase que prueba el sistema de recomendación.
 * 
 * @author Flores González Luis.
 */
public class Main {
 
    public static void main(String[] args){
        try {
            Recomendacion prueba = new Recomendacion();
            prueba.getMatriz();
        } catch (SQLException ex) {
            Logger.getLogger(Main.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
}
