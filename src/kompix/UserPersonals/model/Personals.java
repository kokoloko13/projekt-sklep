package kompix.UserPersonals.model;

import kompix.UserAddress.model.Address;

public class Personals {
    private String name;
    private String lastName;
    private String phoneNr;
    private String email;
    private Address address;

    public Personals(String name, String lastName, String phoneNr, String email, String zipcode, String city, String street) {
        this.name = name;
        this.lastName = lastName;
        this.phoneNr = phoneNr;
        this.email = email;
        this.address = new Address(zipcode, city, street);
    }

    public String getName() {
        return name;
    }

    public String getEmail() {
        return email;
    }

    public String getLastName() {
        return lastName;
    }

    public String getPhoneNr() {
        return phoneNr;
    }

    public Address getAddress() {
        return address;
    }
}
