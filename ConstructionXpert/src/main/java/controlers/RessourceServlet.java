package controlers;

import DAO.RessourceDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import models.Ressource;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/ressource")
public class RessourceServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        try {
            switch (action){
                case "list":
                    afficherRessource(request,response);
                    break;

                case "add":
                    request.getRequestDispatcher("/ressource/ajoutRessource.jsp").forward(request,response);
                    break;

                case "update":
                    int id = Integer.parseInt(request.getParameter("id"));
                    Ressource ressource = RessourceDAO.getRessourceById(id);
                    request.setAttribute("ressource", ressource);
                    request.getRequestDispatcher("/ressource/modifierRessource.jsp").forward(request,response);
                    break;

                case "delete":
                    supprimerRessource(request,response);
                    break;
            }
        }catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        try {
            switch (action){
                case "add":
                    ajouterRessource(request,response);
                    break;

                case "update":
                    modifierRessource(request,response);
                    break;
            }
        }catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }

    private void afficherRessource(HttpServletRequest request, HttpServletResponse response) throws SQLException, ServletException, IOException {
        List<Ressource> ressourceList = RessourceDAO.getAllRessource();
        request.setAttribute("ressourceList", ressourceList);
        request.getRequestDispatcher("/ressource/ressourceList.jsp").forward(request,response);
    }

    private void ajouterRessource(HttpServletRequest request, HttpServletResponse response) throws SQLException, ServletException, IOException {
        String nom = request.getParameter("nom");
        String type = request.getParameter("type");
        int quantite = Integer.parseInt(request.getParameter("quantite"));
        String fournisseur = request.getParameter("fournisseur");
        Ressource ressource = new Ressource(
          fournisseur,
          nom,
          type,
          quantite
        );
        RessourceDAO.addRessource(ressource);
        response.sendRedirect("ressource?action=list");
    }
    private void modifierRessource(HttpServletRequest request, HttpServletResponse response) throws SQLException, ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String nom = request.getParameter("nom");
        String type = request.getParameter("type");
        int quantite = Integer.parseInt(request.getParameter("quantite"));
        String fournisseur = request.getParameter("fournisseur");
        Ressource ressource = new Ressource(
                id,
                fournisseur,
                nom,
                type,
                quantite
        );
        RessourceDAO.updateRessource(ressource);
        response.sendRedirect("ressource?action=list");
    }

    private void supprimerRessource(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException, SQLException {
        int id = Integer.parseInt(req.getParameter("id"));
        RessourceDAO.deleteRessource(id);
        resp.sendRedirect("ressource?action=list");
    }
}
