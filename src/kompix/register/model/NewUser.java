package kompix.register.model;

public class NewUser {
    private String email;
    private String passwd;
    private String name = "None";
    private String lastName = "None";
    private String phoneNr = "None";
    private int admin = 0;
    private int isActive = 1;
    private String rulesAccepted = "off";
    private String newsletter = "off";

    public void setRulesAccepted(String rulesAccepted) {
        this.rulesAccepted = rulesAccepted;
    }

    public void setNewsletter(String news) {
            this.newsletter = news;
    }


    public String getRulesAccepted() {
        return rulesAccepted;
    }

    public String getNewsletter() {
        return newsletter;
    }


    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPasswd() {
        return passwd;
    }

    public void setPasswd(String passwd) {
        this.passwd = passwd;
    }

    public String getName() {
        return name;
    }

    public String getLastName() {
        return lastName;
    }


    public String getPhoneNr() {
        return phoneNr;
    }


    public int getAdmin() {
        return admin;
    }


    public int getIsActive() {
        return isActive;
    }

}
