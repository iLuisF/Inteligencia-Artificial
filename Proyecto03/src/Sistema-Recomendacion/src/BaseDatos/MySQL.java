/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package BaseDatos;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Permite hacer la conexión al abase de datos.
 *
 * @author Flores González Luis.
 */
public class MySQL {

    private final String user;
    private final String pass;
    private final String nameDB;
    private Connection conexion;

    /**
     *
     * @param user Usuario de la base de datos.
     * @param pass Contraseña de la base de datos.
     * @param nameDB Nombre de la base de datos.
     */
    public MySQL(String user, String pass, String nameDB) {
        this.user = user;
        this.pass = pass;
        this.nameDB = nameDB;
    }

    /**
     * Antes de hacer las consultas se necesita conectar a la base de datos.
     */
    public void conectar() {
        try {
            Class.forName("com.mysql.jdbc.Driver");
            conexion = DriverManager.getConnection("jdbc:mysql://localhost:3306/"
                    + nameDB, user, pass);
            System.out.println("Conexión exitiosa.");
        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(MySQL.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Cuando se acabe de usar la base de datos se necesita desconectar.
     */
    public void desconectar() {
        try {
            conexion.close();
            System.out.println("Se ha finalizado la conexión con el servidor");
        } catch (SQLException ex) {
            Logger.getLogger(MySQL.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Para usar la base de datos se necesita hacer uso de la conexión.
     * @return 
     */    
    public Connection getConexion() {
        return this.conexion;
    }

}
