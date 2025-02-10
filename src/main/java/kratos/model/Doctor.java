package kratos.model;

import jakarta.persistence.*;

@Entity
@Table(name = "DOCTORS")
public class Doctor {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ID")
    private Long id;

    @Column(name = "username", nullable = false, unique = true)
    private String username;
    
    @Column(name = "password", nullable = false)
    private String password;
    
    @Column(name = "name", nullable = false)
    private String name;
    
    @Column(name = "specialization")
    private String specialization;
    
    @Column(name = "fee")
    private Double fee;

    // Constructors
    public Doctor() {}

    public Doctor(String username, String password, String name, String specialization, Double fee) {
        this.username = username;
        this.password = password;
        this.name = name;
        this.specialization = specialization;
        this.fee = fee;
    }

    // Getters and Setters
    public Long getId() {
        return id;
    }
    public void setId(Long id) {
        this.id = id;
    }
    public String getUsername() {
        return username;
    }
    public void setUsername(String username) {
        this.username = username;
    }
    public String getPassword() {
        return password;
    }
    public void setPassword(String password) {
        this.password = password;
    }
    public String getName() {
        return name;
    }
    public void setName(String name) {
        this.name = name;
    }
    public String getSpecialization() {
        return specialization;
    }
    public void setSpecialization(String specialization) {
        this.specialization = specialization;
    }
    public Double getFee() {
        return fee;
    }
    public void setFee(Double fee) {
        this.fee = fee;
    }
}
