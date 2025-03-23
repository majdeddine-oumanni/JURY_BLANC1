package controlers;

import DAO.ProjetDAO;
import DAO.TacheDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import models.Projet;
import models.Tache;

import java.io.IOException;
import java.sql.Date;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/tache")
public class TacheServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        try {
            switch (action){
                case "list":
                    afficherTache(req,resp);
                    break;

                case "add":
                    int id = Integer.parseInt(req.getParameter("projetId"));
                    Projet projet = ProjetDAO.getProjetById(id);
                    req.setAttribute("projet", projet);
                    req.getRequestDispatcher("/tache/ajoutTache.jsp").forward(req,resp);
                    break;

                case "update":
                    int tacheId = Integer.parseInt(req.getParameter("id"));
                    int projet_id = Integer.parseInt(req.getParameter("projetId"));
                    Projet projet1 = ProjetDAO.getProjetById(projet_id);
                    Tache tache = TacheDAO.getTacheById(tacheId);
                    req.setAttribute("tache", tache);
                    req.setAttribute("projet", projet1);
                    req.getRequestDispatcher("/tache/modifierTache.jsp").forward(req,resp);
                    break;

                case "delete":
                    suprimerTache(req,resp);
                    break;

                default:
                    resp.sendRedirect("error.jsp");
                    break;
            }
        }catch (SQLException e) {
            e.printStackTrace();
            resp.sendRedirect("error.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        try {
            switch (action){
                case "add":
                    ajouterTache(request,response);
                    break;
                case "update":
                    modifierTache(request,response);
                    break;
                default:
                    response.sendRedirect("error.jsp");
                    break;
            }
        }catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }

    private void afficherTache(HttpServletRequest request, HttpServletResponse response) throws SQLException, ServletException, IOException {
        int projetId = Integer.parseInt(request.getParameter("projetId"));
        List<Tache> tacheList = TacheDAO.getTacheList(projetId);
        Projet projet1 = ProjetDAO.getProjetById(projetId);
        request.setAttribute("tacheList", tacheList);
        request.setAttribute("projet", projet1);
        request.getRequestDispatcher("/tache/tacheList.jsp").forward(request,response);
    }

    private void ajouterTache(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException, SQLException {
        int projetId = Integer.parseInt(req.getParameter("projetId"));
        String description = req.getParameter("description");
        String dateDebut = req.getParameter("dateDebut");
        String dateFin = req.getParameter("dateFin");
        Tache tache = new Tache();
        tache.setprojetId(projetId);
        tache.setDescription(description);
        tache.setDateDebut(Date.valueOf(dateDebut));
        tache.setDateFin(Date.valueOf(dateFin));
        TacheDAO.ajouterTache(tache);

        resp.sendRedirect("tache?action=list&projetId=" + projetId);
    }
    private void modifierTache(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException, SQLException {
        int id = Integer.parseInt(req.getParameter("id"));
        int projetId = Integer.parseInt(req.getParameter("projetId"));
        String description = req.getParameter("description");
        String dateDebut = req.getParameter("dateDebut");
        String dateFin = req.getParameter("dateFin");
        Tache tache = new Tache();
        tache.setId(id);
        tache.setDescription(description);
        tache.setDateDebut(Date.valueOf(dateDebut));
        tache.setDateFin(Date.valueOf(dateFin));
        TacheDAO.modifierTache(tache);
        resp.sendRedirect("tache?action=list&projetId=" + projetId);
    }

    private void suprimerTache(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException, SQLException {
        int tacheID = Integer.parseInt(req.getParameter("id"));
        int projetId = Integer.parseInt(req.getParameter("projetId"));
        TacheDAO.suprimerTache(tacheID);
        resp.sendRedirect("tache?action=list&projetId=" + projetId);
    }
}

