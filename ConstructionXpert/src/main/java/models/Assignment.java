package models;

public class Assignment {
    private int id;
    private int tacheId;
    private int ressourceId;
    private int quantiteUtilise;
    private String resourceNom; // For display purposes
    private String resourceType; // For display purposes

    public Assignment(int id, int tacheId, int ressourceId, int quantiteUtilise) {
        this.id = id;
        this.tacheId = tacheId;
        this.ressourceId = ressourceId;
        this.quantiteUtilise = quantiteUtilise;
    }

    public Assignment() {}

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getTacheId() {
        return tacheId;
    }

    public void setTacheId(int tacheId) {
        this.tacheId = tacheId;
    }

    public int getRessourceId() {
        return ressourceId;
    }

    public void setRessourceId(int ressourceId) {
        this.ressourceId = ressourceId;
    }

    public int getQuantiteUtilise() {
        return quantiteUtilise;
    }

    public void setQuantiteUtilise(int quantiteUtilise) {
        this.quantiteUtilise = quantiteUtilise;
    }

    public String getResourceNom() {
        return resourceNom;
    }

    public void setResourceNom(String resourceNom) {
        this.resourceNom = resourceNom;
    }

    public String getResourceType() {
        return resourceType;
    }

    public void setResourceType(String resourceType) {
        this.resourceType = resourceType;
    }
}
