package kratos.model;

import jakarta.persistence.*;
import java.util.Date;

@Entity
@Table(name = "PRESCRIPTIONS")
public class Prescription {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ID")
    private Long id;

    // The doctor who prescribed
    @ManyToOne
    @JoinColumn(name = "doctor_id", nullable = false)
    private Doctor doctor;

    // The patient receiving the prescription
    @ManyToOne
    @JoinColumn(name = "patient_id", nullable = false)
    private User patient;

    @Column(name = "description")
    private String description;

    @Column(name = "prescription_date")
    @Temporal(TemporalType.TIMESTAMP)
    private Date prescriptionDate;
    
    // You can use this field to store the fee (if it differs from the doctor's fee)
    @Column(name = "fee")
    private Double fee;

    // Constructors
    public Prescription() {}

    // Getters and Setters
    public Long getId() {
        return id;
    }
    public void setId(Long id) {
        this.id = id;
    }
    public Doctor getDoctor() {
        return doctor;
    }
    public void setDoctor(Doctor doctor) {
        this.doctor = doctor;
    }
    public User getPatient() {
        return patient;
    }
    public void setPatient(User patient) {
        this.patient = patient;
    }
    public String getDescription() {
        return description;
    }
    public void setDescription(String description) {
        this.description = description;
    }
    public Date getPrescriptionDate() {
        return prescriptionDate;
    }
    public void setPrescriptionDate(Date prescriptionDate) {
        this.prescriptionDate = prescriptionDate;
    }
    public Double getFee() {
        return fee;
    }
    public void setFee(Double fee) {
        this.fee = fee;
    }
}
