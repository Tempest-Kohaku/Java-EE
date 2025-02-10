package kratos.dao;

import kratos.model.Prescription;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import java.util.List;

public class PrescriptionDao {
    private static final EntityManagerFactory emf = 
            Persistence.createEntityManagerFactory("my_persistence_unit");

    public void addPrescription(Prescription prescription) {
        EntityManager em = emf.createEntityManager();
        em.getTransaction().begin();
        em.persist(prescription);
        em.getTransaction().commit();
        em.close();
    }

    public List<Prescription> getPrescriptionsByPatient(Long patientId) {
        EntityManager em = emf.createEntityManager();
        List<Prescription> prescriptions = em.createQuery(
                "SELECT p FROM Prescription p WHERE p.patient.id = :patientId", Prescription.class)
                .setParameter("patientId", patientId)
                .getResultList();
        em.close();
        return prescriptions;
    }
    
    public List<Prescription> getPrescriptionsByDoctor(Long doctorId) {
        EntityManager em = emf.createEntityManager();
        List<Prescription> prescriptions = em.createQuery(
                "SELECT p FROM Prescription p WHERE p.doctor.id = :doctorId", Prescription.class)
                .setParameter("doctorId", doctorId)
                .getResultList();
        em.close();
        return prescriptions;
    }
    
        public List<Prescription> getAllPrescriptions() {
        EntityManager em = emf.createEntityManager();
        List<Prescription> prescriptions = em.createQuery("SELECT p FROM Prescription p", Prescription.class)
                                               .getResultList();
        em.close();
        return prescriptions;
    }
}
