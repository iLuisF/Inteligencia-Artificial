
import BaseDatos.MySQL;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.LinkedList;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author Flores González Luis.
 */
public class Recomendacion {

    MySQL conexion = new MySQL("root", "A312218342", "dataset");
    
    /**
     * Regresa una matriz tal que la primer columa representa los identificadores
     * de los usuarios y el primer renglón representa los identificadores de las 
     * preliculas.
     * 
     * Cada m indica la reputacion que le dio ese usuario a esa pelicula.
     * @throws SQLException 
     */
    public void getMatriz() throws SQLException{
        
        Integer[][] matriz;
        
        String userId = "SELECT DISTINCT userId FROM ratings ORDER BY userId;";
        String movieId = "SELECT DISTINCT movieId FROM ratings ORDER BY movieId;";
        
        conexion.conectar();
        Statement st = conexion.getConexion().createStatement();
        //Inicio: userId
        java.sql.ResultSet resultSetUserId;
        resultSetUserId = st.executeQuery(userId);
        LinkedList<Integer> userIds = new LinkedList<>();                
        
        while(resultSetUserId.next()){
            userIds.add(Integer.parseInt(resultSetUserId.getString("userId")));            
        }
        //Fin: userId.
        
        //Inicio: movieId
        java.sql.ResultSet resulSetMovieId;
        resulSetMovieId = st.executeQuery(movieId);
        LinkedList<Integer> movieIds = new LinkedList<>();
        
        while(resulSetMovieId.next()){
            movieIds.add(Integer.parseInt(resulSetMovieId.getString("movieId")));
        }        
        //Fin: movieId
        
        matriz = new Integer[userIds.size() + 1][movieIds.size() + 1];
                        
        conexion.desconectar();
    }
    
}
