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
                case "add":
                    int id = Integer.parseInt(req.getParameter("projetId"));
                    Projet projet = ProjetDAO.getProjetById(id);
                    req.setAttribute("projet", projet);
                    req.getRequestDispatcher("/tache/ajoutTache.jsp").forward(req,resp);
                    break;
                case "list":
                    int projetId = Integer.parseInt(req.getParameter("projetId"));
                    List<Tache> tacheList = ProjetDAO.getTacheList(projetId);
                    Projet projet1 = ProjetDAO.getProjetById(projetId);
                    req.setAttribute("tacheList", tacheList);
                    req.setAttribute("projet", projet1);
                    req.getRequestDispatcher("/tache/projetList.jsp").forward(req,resp);
                    break;
                case "update":
                    int tacheId = Integer.parseInt(req.getParameter("id"));
                    Tache tache = TacheDAO.getTacheById(tacheId);
                    req.setAttribute("tache", tache);
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
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        try {
            switch (action){
                case "create":
                    ajouterTache(req,resp);
                    break;
                case "update":
                    modifierTache(req,resp);
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

    protected void ajouterTache(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException, SQLException {
        int projetId = Integer.parseInt(req.getParameter("projetId"));
        String description = req.getParameter("description");
        Date dateDebut = Date.valueOf(req.getParameter("dateDebut"));
        Date dateFin = Date.valueOf(req.getParameter("dateFin"));
        Tache tache = new Tache(
                projetId,
                description,
                dateDebut,
                dateFin
        );
        TacheDAO.ajouterTache(tache);
        resp.sendRedirect("tache?action=list&projetId=" + projetId);
    }
    protected void modifierTache(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException, SQLException {
        int id = Integer.parseInt(req.getParameter("id"));
        int projetId = Integer.parseInt(req.getParameter("projetId"));
        String description = req.getParameter("description");
        Date dateDebut = Date.valueOf(req.getParameter("dateDebut"));
        Date dateFin = Date.valueOf(req.getParameter("dateFin"));
        Tache tache = new Tache(
                id,
                projetId,
                description,
                dateDebut,
                dateFin
        );
        TacheDAO.modifierTache(tache);
        resp.sendRedirect("tache?action=list");
    }

    protected void suprimerTache(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException, SQLException {
        int tacheID = Integer.parseInt(req.getParameter("id"));
        TacheDAO.suprimerTache(tacheID);
        resp.sendRedirect("tache?action=list");
    }
}
