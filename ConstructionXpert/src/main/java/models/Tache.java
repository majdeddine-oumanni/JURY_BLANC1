package models;

import java.sql.Date;

public class Tache {
    private int id;
    private int projetId;
    private String description;
    private Date dateDebut, dateFin;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getprojetId() {
        return projetId;
    }

    public void setprojetId(int projetId) {
        this.projetId = projetId;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Date getDateDebut() {
        return dateDebut;
    }

    public void setDateDebut(Date dateDebut) {
        this.dateDebut = dateDebut;
    }

    public Date getDateFin() {
        return dateFin;
    }

    public void setDateFin(Date dateFin) {
        this.dateFin = dateFin;
    }

    public Tache(){};

    public Tache(int id, int projetId, String description, Date dateDebut, Date dateFin) {
        this.id = id;
        this.projetId = projetId;
        this.description = description;
        this.dateDebut = dateDebut;
        this.dateFin = dateFin;
    }

    public Tache(int projetId, String description, Date dateDebut, Date dateFin) {
        this.projetId = projetId;
        this.description = description;
        this.dateDebut = dateDebut;
        this.dateFin = dateFin;
    }
}
