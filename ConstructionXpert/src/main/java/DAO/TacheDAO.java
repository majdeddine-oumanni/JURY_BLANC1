package DAO;

import DBUtils.Connector;
import models.Tache;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import static DBUtils.Connector.getConnection;

public class TacheDAO {


    public static void ajouterTache(Tache tache) throws SQLException {
        String sql = "INSERT INTO tache(projetId, description, dateDebut, dateFin) VALUES (?,?,?,?)";
        Connection con = getConnection();
        PreparedStatement ps = con.prepareStatement(sql);
        ps.setInt(1, tache.getprojetId());
        ps.setString(2, tache.getDescription());
        ps.setDate(3, tache.getDateDebut());
        ps.setDate(4, tache.getDateFin());
        ps.executeUpdate();
    }

    public static void modifierTache(Tache tache) throws SQLException {
        String sql = "UPDATE tache SET description=?, dateDebut=?, dateFin=? WHERE id = ?";
        Connection con = getConnection();
        PreparedStatement ps = con.prepareStatement(sql);
        ps.setString(2, tache.getDescription());
        ps.setDate(3, tache.getDateDebut());
        ps.setDate(4, tache.getDateFin());
        ps.executeUpdate();
    }

    public static Tache getTacheById(int id) throws SQLException {
        String sql = "SELECT * FROM tache WHERE id = ?";
        Connection con = getConnection();
        PreparedStatement ps = con.prepareStatement(sql);
        ps.setInt(1, id);
        ResultSet rs = ps.executeQuery();
        Tache tache = new Tache();
        if (rs.next()){
            tache.setId(rs.getInt("id"));
            tache.setprojetId(rs.getInt("projetId"));
            tache.setDescription(rs.getString("description"));
            tache.setDateDebut(rs.getDate("dateDebut"));
            tache.setDateFin(rs.getDate("dateFin"));
        }
        return tache;
    }

    public static void suprimerTache(int id) throws SQLException {
        String sql = "DELETE tache WHERE id = ?";
        Connection con = Connector.getConnection();
        PreparedStatement ps = con.prepareStatement(sql);
        ps.setInt(1, id);
        ps.executeUpdate();
    }
}
