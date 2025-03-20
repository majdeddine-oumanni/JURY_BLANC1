package DAO;

import DBUtils.Connector;
import models.Projet;
import models.Tache;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import static DBUtils.Connector.getConnection;

public class ProjetDAO {
    public static void ajouterProjet(Projet projet) throws SQLException {
        String sql = "INSERT INTO projet(nom,description,dateDebut,dateFin,budget) VALUES (?,?,?,?,?)";
        Connection con = Connector.getConnection();
        PreparedStatement ps = con.prepareStatement(sql);
        ps.setString(1, projet.getNom());
        ps.setString(2, projet.getDescription());
        ps.setDate(3, projet.getDateDebut());
        ps.setDate(4, projet.getDateFin());
        ps.setDouble(5, projet.getBudget());
        ps.executeUpdate();
    }

    public static List<Projet> getAllProjet() throws SQLException {
        List<Projet> projetList = new ArrayList<>();
        String sql = "SELECT * FROM projet";
        Connection con = Connector.getConnection();
        PreparedStatement ps = con.prepareStatement(sql);
        ResultSet rs = ps.executeQuery();
        while ((rs.next())){
            Projet projet = new Projet();
            projet.setId(rs.getInt("id"));
            projet.setNom(rs.getString("nom"));
            projet.setDateFin(rs.getDate("dateFin"));
            projet.setDateDebut(rs.getDate("dateDebut"));
            projet.setDescription(rs.getString("description"));
            projet.setBudget(rs.getDouble("budget"));
            projetList.add(projet);
        }
        return projetList;
    }

    public static Projet getProjetById(int id) throws SQLException {
        String sql = "SELECT * FROM projet WHERE id = ?";
        Connection con = Connector.getConnection();
        PreparedStatement ps = con.prepareStatement(sql);
        ps.setInt(1, id);
        ResultSet rs = ps.executeQuery();
        Projet projet = new Projet();
        if ((rs.next())){
            projet.setId(rs.getInt("id"));
            projet.setNom(rs.getString("nom"));
            projet.setDateFin(rs.getDate("dateFin"));
            projet.setDateDebut(rs.getDate("dateDebut"));
            projet.setDescription(rs.getString("description"));
            projet.setBudget(rs.getDouble("budget"));
        }
        return projet;
    }

    public static void modifierProjet(Projet projet) throws SQLException {
        String sql = "UPDATE projet SET nom = ? ,description = ?,dateDebut=?,dateFin=?,budget=? WHERE id=?";
        Connection con = Connector.getConnection();
        PreparedStatement ps = con.prepareStatement(sql);
        ps.setString(1, projet.getNom());
        ps.setString(2, projet.getDescription());
        ps.setDate(3, projet.getDateDebut());
        ps.setDate(4, projet.getDateFin());
        ps.setDouble(5, projet.getBudget());
        ps.setInt(6, projet.getId());
        ps.executeUpdate();
    }

    public static void suprimerProjet(int id) throws SQLException {
        String sql = "DELETE FROM projet WHERE id = ?";
        Connection con = Connector.getConnection();
        PreparedStatement ps = con.prepareStatement(sql);
        ps.setInt(1, id);
        ps.executeUpdate();
    }

    public static List<Tache> getTacheList() throws SQLException {
        List<Tache> tacheList = new ArrayList<>();
        String sql = "SELECT * FROM tache";
        Connection con = getConnection();
        PreparedStatement ps = con.prepareStatement(sql);
        ResultSet rs = ps.executeQuery();
        while (rs.next()){
            Tache tache = new Tache(
                    rs.getInt("id"),
                    rs.getInt("projetId"),
                    rs.getString("description"),
                    rs.getDate("dateDebut"),
                    rs.getDate("dateFin")
            );
            tacheList.add(tache);
        }
        return tacheList;
    }
}
