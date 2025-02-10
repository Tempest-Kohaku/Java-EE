package kratos.model;

import jakarta.persistence.*;
import java.util.Date;

@Entity
@Table(name = "APPOINTMENTS")
public class Appointment {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ID")
    private Long id;

    // Link to the patient (User)
    @ManyToOne
    @JoinColumn(name = "patient_id", nullable = false)
    private User patient;

    // Link to the doctor
    @ManyToOne
    @JoinColumn(name = "doctor_id", nullable = false)
    private Doctor doctor;

    @Column(name = "appointment_date")
    @Temporal(TemporalType.TIMESTAMP)
    private Date appointmentDate;

    @Column(name = "status")
    private String status; // e.g., "Pending", "Confirmed", "Cancelled"

    // Constructors
    public Appointment() {}
    
    // Getters and Setters
    public Long getId() {
        return id;
    }
    public void setId(Long id) {
        this.id = id;
    }
    public User getPatient() {
        return patient;
    }
    public void setPatient(User patient) {
        this.patient = patient;
    }
    public Doctor getDoctor() {
        return doctor;
    }
    public void setDoctor(Doctor doctor) {
        this.doctor = doctor;
    }
    public Date getAppointmentDate() {
        return appointmentDate;
    }
    public void setAppointmentDate(Date appointmentDate) {
        this.appointmentDate = appointmentDate;
    }
    public String getStatus() {
        return status;
    }
    public void setStatus(String status) {
        this.status = status;
    }
}
