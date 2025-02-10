package kratos.dao;

import kratos.model.Doctor;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import java.util.List;

public class DoctorDao {
    private static final EntityManagerFactory emf = 
            Persistence.createEntityManagerFactory("my_persistence_unit");

    public void addDoctor(Doctor doctor) {
        EntityManager em = emf.createEntityManager();
        em.getTransaction().begin();
        em.persist(doctor);
        em.getTransaction().commit();
        em.close();
    }

    public List<Doctor> getAllDoctors() {
        EntityManager em = emf.createEntityManager();
        List<Doctor> doctors = em.createQuery("SELECT d FROM Doctor d", Doctor.class)
                .getResultList();
        em.close();
        return doctors;
    }

    public Doctor getDoctorById(Long id) {
        EntityManager em = emf.createEntityManager();
        Doctor doctor = em.find(Doctor.class, id);
        em.close();
        return doctor;
    }
    
    public Doctor getDoctorByUsernameAndPassword(String username, String password) {
        EntityManager em = emf.createEntityManager();
        Doctor doctor = null;
        try {
            doctor = em.createQuery(
                    "SELECT d FROM Doctor d WHERE d.username = :username AND d.password = :password", 
                    Doctor.class)
                    .setParameter("username", username)
                    .setParameter("password", password)
                    .getSingleResult();
        } catch (Exception e) {
            System.out.println("Doctor not found: " + e.getMessage());
        }
        em.close();
        return doctor;
    }

    public void removeDoctor(Long doctorId) {
        EntityManager em = emf.createEntityManager();
        try {
            em.getTransaction().begin();
            Doctor doctor = em.find(Doctor.class, doctorId);
            if (doctor != null) {
                em.remove(doctor);
            }
            em.getTransaction().commit();
        } catch(Exception e) {
            em.getTransaction().rollback();
            throw e;
        } finally {
            em.close();
        }
    }
}
