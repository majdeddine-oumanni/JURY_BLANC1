package controlers;

import DAO.AssignmentDAO;
import DAO.RessourceDAO;
import DAO.TacheDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import models.Assignment;
import models.Ressource;
import models.Tache;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/assign")
public class AssignmentServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        switch (action){
            case "add":
                int tacheId = Integer.parseInt(req.getParameter("tacheId"));
                try {
                    Tache tache = TacheDAO.getTacheById(tacheId);
                    List<Ressource> ressourceList = RessourceDAO.getAllRessource();
                    req.setAttribute("tache", tache);
                    req.setAttribute("ressourceList", ressourceList);
                    req.getRequestDispatcher("/tache/assignRessTache.jsp").forward(req,resp);
                } catch (SQLException e) {
                    throw new RuntimeException(e);
                }
                break;
            case "list":
                int id = Integer.parseInt(req.getParameter("id"));
                try {
                    Tache tache = TacheDAO.getTacheById(id);
                    List<Assignment> assignmentList = AssignmentDAO.getAssignmentsByTacheId(id);
                    req.setAttribute("assignmentList", assignmentList);
                    req.setAttribute("tache", tache);
                    req.getRequestDispatcher("/tache/afficherAssign.jsp").forward(req,resp);
                } catch (SQLException e) {
                    throw new RuntimeException(e);
                }
            case "delete":
                try {
                    delete(req,resp);
                } catch (SQLException e) {
                    throw new RuntimeException(e);
                }

        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        switch (action){
            case "add":
                try {
                    affecte(req,resp);
                } catch (SQLException e) {
                    throw new RuntimeException(e);
                }
        }
    }


    protected void affecte(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException, SQLException {
        int ressourceId = Integer.parseInt(req.getParameter("ressource"));
        int quantite = Integer.parseInt(req.getParameter("quantiteSelected"));
        int tacheId = Integer.parseInt(req.getParameter("tacheId"));
        Assignment assignment = new Assignment(
                tacheId,
                ressourceId,
                quantite
        );
        AssignmentDAO.ajouterAssignment(assignment);
        req.setAttribute("id", tacheId);
        resp.sendRedirect("assign?action=list");
    }


    protected void delete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException, SQLException {
        int id = Integer.parseInt(req.getParameter("id"));
        AssignmentDAO.supprimerAssignment(id);
        req.setAttribute("id", id);
        resp.sendRedirect("assign?action=list");
    }
}
