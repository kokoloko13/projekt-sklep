package kompix.login.model;

public class LoginUser {
    private String email;
    private String passwd;

    public LoginUser(String email, String passwd){
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
