package models;

public class Ressource {
    private int id;
    private String fournisseur;
    private String nom;
    private String type;
    private int quantite;

    public Ressource(int id, String fournisseur, String nom, String type, int quantite) {
        this.id = id;
        this.fournisseur = fournisseur;
        this.nom = nom;
        this.type = type;
        this.quantite = quantite;
    }
    public Ressource(String fournisseur, String nom, String type, int quantite) {
        this.fournisseur = fournisseur;
        this.nom = nom;
        this.type = type;
        this.quantite = quantite;
    }
    public Ressource() {}

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getFournisseur() {
        return fournisseur;
    }

    public void setFournisseur(String fournisseur) {
        this.fournisseur = fournisseur;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public int getQuantite() {
        return quantite;
    }

    public void setQuantite(int quantite) {
        this.quantite = quantite;
    }
}
