package DAO;

import DBUtils.Connector;
import models.Ressource;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class RessourceDAO {
    public static List<Ressource> getAllRessource() throws SQLException {
        List<Ressource> ressourceList = new ArrayList<>();
        String sql = "SELECT * FROM ressource";
        Connection con = Connector.getConnection();
        PreparedStatement ps = con.prepareStatement(sql);
        ResultSet rs = ps.executeQuery();
        while (rs.next()){
            Ressource ressource = new Ressource(
                    rs.getInt("id"),
                    rs.getString("fournisseur"),
                    rs.getString("nom"),
                    rs.getString("type"),
                    rs.getInt("quantite")
            );
            ressourceList.add(ressource);
        }
        return ressourceList;
    }

    public static Ressource getRessourceById(int id) throws SQLException {
        String sql = "SELECT * FROM ressource WHERE id = ?";
        Connection con = Connector.getConnection();
        PreparedStatement ps = con.prepareStatement(sql);
        ps.setInt(1,id);
        ResultSet rs = ps.executeQuery();
        Ressource ressource = new Ressource();
        if(rs.next()){
            ressource.setId(rs.getInt("id"));
            ressource.setFournisseur(rs.getString("fournisseur"));
            ressource.setNom(rs.getString("nom"));
            ressource.setType(rs.getString("type"));
            ressource.setQuantite(rs.getInt("quantite"));
        }
        return ressource;
    }

    public static void addRessource(Ressource ressource) throws SQLException {
        String sql = "INSERT INTO ressource(fournisseur, nom, type,quantite) VALUES(?,?,?,?)";
        Connection con = Connector.getConnection();
        PreparedStatement ps = con.prepareStatement(sql);
        ps.setString(1, ressource.getFournisseur());
        ps.setString(2, ressource.getNom());
        ps.setString(3, ressource.getType());
        ps.setInt(4, ressource.getQuantite());
        ps.executeUpdate();
    }
    public static void updateRessource(Ressource ressource) throws SQLException {
        String sql = "UPDATE ressource SET fournisseur = ?, nom = ?,type = ?,quantite = ? WHERE id = ?";
        Connection con = Connector.getConnection();
        PreparedStatement ps = con.prepareStatement(sql);
        ps.setString(1, ressource.getFournisseur());
        ps.setString(2, ressource.getNom());
        ps.setString(3, ressource.getType());
        ps.setInt(4, ressource.getQuantite());
        ps.setInt(5, ressource.getId());
        ps.executeUpdate();
    }
    public static void deleteRessource(int id) throws SQLException {
        String sql = "DELETE FROM ressource WHERE id = ?";
        Connection con = Connector.getConnection();
        PreparedStatement ps = con.prepareStatement(sql);
        ps.setInt(1,id);
        ps.executeUpdate();
    }
}
