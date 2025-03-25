package DAO;

import DBUtils.Connector;
import models.Assignment;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class AssignmentDAO {
    public static void ajouterAssignment(Assignment assignment) throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;
        PreparedStatement updateStmt = null;

        try {
            conn = Connector.getConnection();
            conn.setAutoCommit(false);

            // Check available quantity
            String checkSql = "SELECT quantite FROM ressource WHERE id = ?";
            stmt = conn.prepareStatement(checkSql);
            stmt.setInt(1, assignment.getRessourceId());
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                int availableQuantity = rs.getInt("quantite");
                if (availableQuantity < assignment.getQuantiteUtilise()) {
                    throw new SQLException("Not enough resources available.");
                }
            } else {
                throw new SQLException("Resource not found.");
            }
            rs.close();
            stmt.close(); // Close previous statement

            // Insert into tache_ressource
            String insertSql = "INSERT INTO tache_ressource (ressourceId, tacheId, quantiteUtilise) VALUES (?, ?, ?)";
            stmt = conn.prepareStatement(insertSql);
            stmt.setInt(1, assignment.getRessourceId());
            stmt.setInt(2, assignment.getTacheId());
            stmt.setInt(3, assignment.getQuantiteUtilise());
            stmt.executeUpdate();
            stmt.close(); // Close previous statement

            // Update ressource table
            String updateSql = "UPDATE ressource SET quantite = quantite - ? WHERE id = ?";
            updateStmt = conn.prepareStatement(updateSql);
            updateStmt.setInt(1, assignment.getQuantiteUtilise());
            updateStmt.setInt(2, assignment.getRessourceId());
            updateStmt.executeUpdate();

            conn.commit();
        } catch (SQLException e) {
            if (conn != null) conn.rollback();
            throw e;
        } finally {
            if (stmt != null) stmt.close();
            if (updateStmt != null) updateStmt.close();
            if (conn != null) conn.close();
        }
    }

    public static List<Assignment> getAssignmentsByTacheId(int tacheId) throws SQLException {
        List<Assignment> assignments = new ArrayList<>();
        String query = "SELECT a.id, a.tacheId, a.ressourceId, a.quantiteUtilise, r.nom, r.type " +
                "FROM tache_ressource a " +
                "JOIN ressource r ON a.ressourceId = r.id " +
                "WHERE a.tacheId = ?";

        try (Connection con = Connector.getConnection();
             PreparedStatement prst = con.prepareStatement(query)) {
            prst.setInt(1, tacheId);
            try (ResultSet rs = prst.executeQuery()) {
                while (rs.next()) {
                    Assignment assignment = new Assignment();
                    assignment.setId(rs.getInt("id"));
                    assignment.setTacheId(rs.getInt("tacheId")); // Fixed typo
                    assignment.setRessourceId(rs.getInt("ressourceId"));
                    assignment.setQuantiteUtilise(rs.getInt("quantiteUtilise"));
                    assignment.setResourceNom(rs.getString("nom"));
                    assignment.setResourceType(rs.getString("type"));
                    assignments.add(assignment);
                }
            }
        }
        return assignments;
    }

    public static void supprimerAssignment(int id) throws SQLException {
        String sql = "DELETE FROM tache_ressource WHERE id = ?";
        try (Connection conn = Connector.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            stmt.executeUpdate();
        }
    }
}
