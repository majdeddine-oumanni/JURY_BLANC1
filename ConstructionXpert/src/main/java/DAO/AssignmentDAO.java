package DAO;

import DBUtils.Connector;
import models.Assignment;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class AssignmentDAO{

    public void addRessourceTache(Assignment assignment) throws SQLException {
        String sql = "INSERT INTO tache_ressource (tacheId, ressourceId, quantiteUtilise) VALUES (?, ?, ?)";

        try (Connection conn = Connector.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            pstmt.setInt(1, assignment.getTacheId());
            pstmt.setInt(2, assignment.getRessourceId());
            pstmt.setInt(3, assignment.getQuantiteUtilise());

            int affectedRows = pstmt.executeUpdate();
            if (affectedRows == 0) {
                throw new SQLException("Creating ressource_tache failed, no rows affected.");
            }

            try (ResultSet generatedKeys = pstmt.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    assignment.setId(generatedKeys.getInt(1));
                } else {
                    throw new SQLException("Creating ressource_tache failed, no ID obtained.");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<Assignment> getAllAssignment(int tacheId) throws SQLException {
        List<Assignment> assignmentList = new ArrayList<>();
        String sql = "SELECT * FROM tache_ressource WHERE tacheId = ?";

        try (Connection conn = Connector.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, tacheId);
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    Assignment assignment = new Assignment(
                            rs.getInt("id"),
                            rs.getInt("tacheId"),
                            rs.getInt("ressourceId"),
                            rs.getInt("quantiteUtilise")
                    );
                    assignmentList.add(assignment);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Log and handle the exception
        }
        return assignmentList;
    }
    // Add delete and update if necessary.  Keep it minimal if not used.
    public void deleteRessourceTache(int tacheId, int ressourceId) throws SQLException {
        String sql = "DELETE FROM ressource_tache WHERE tache_id = ? AND ressource_id = ?";

        try (Connection conn = Connector.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, tacheId);
            pstmt.setInt(2, ressourceId);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace(); // Log this properly
        }
    }
}