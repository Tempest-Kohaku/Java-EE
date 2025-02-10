package kratos.dao;

import kratos.model.Appointment;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import java.util.List;

public class AppointmentDao {
    private static final EntityManagerFactory emf = 
            Persistence.createEntityManagerFactory("my_persistence_unit");

    public void addAppointment(Appointment appointment) {
        EntityManager em = emf.createEntityManager();
        em.getTransaction().begin();
        em.persist(appointment);
        em.getTransaction().commit();
        em.close();
    }

    public Appointment getAppointmentById(Long id) {
        EntityManager em = emf.createEntityManager();
        Appointment appointment = em.find(Appointment.class, id);
        em.close();
        return appointment;
    }

    public List<Appointment> getAppointmentsByDoctor(Long doctorId) {
        EntityManager em = emf.createEntityManager();
        List<Appointment> appointments = em.createQuery(
                "SELECT a FROM Appointment a WHERE a.doctor.id = :doctorId", Appointment.class)
                .setParameter("doctorId", doctorId)
                .getResultList();
        em.close();
        return appointments;
    }

    public List<Appointment> getAppointmentsByPatient(Long patientId) {
        EntityManager em = emf.createEntityManager();
        List<Appointment> appointments = em.createQuery(
                "SELECT a FROM Appointment a WHERE a.patient.id = :patientId", Appointment.class)
                .setParameter("patientId", patientId)
                .getResultList();
        em.close();
        return appointments;
    }

    public void updateAppointment(Appointment appointment) {
        EntityManager em = emf.createEntityManager();
        em.getTransaction().begin();
        em.merge(appointment);
        em.getTransaction().commit();
        em.close();
    }
    
    public List<Appointment> getAllAppointments() {
        EntityManager em = emf.createEntityManager();
        List<Appointment> appointments = em.createQuery("SELECT a FROM Appointment a", Appointment.class)
                                             .getResultList();
        em.close();
        return appointments;
    }
}
