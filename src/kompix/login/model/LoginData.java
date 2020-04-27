package kompix.login.model;

public class LoginData {
    private String email;
    private String passwd;

    public LoginData(String email, String passwd){
        this.email = email;
        this.passwd = passwd;
    }

    public String getEmail() {
        return email;
    }

    public String getPasswd() {
        return passwd;
    }
}
