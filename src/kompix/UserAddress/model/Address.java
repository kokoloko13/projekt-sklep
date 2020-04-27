package kompix.UserAddress.model;

public class Address {
    private String zip;
    private String city;
    private String street;

    public Address() {
        this.zip = "00000";
        this.city = "None";
        this.street = "None";
    }

    public Address(String zip, String city, String street) {
        this.zip = zip;
        this.city = city;
        this.street = street;
    }



    public String getZip() {
        return zip;
    }

    public String getCity() {
        return city;
    }

    public String getStreet() {
        return street;
    }
}
