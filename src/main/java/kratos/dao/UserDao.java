package kratos.dao;

import kratos.model.User;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import java.util.List;

public class UserDao {
    private static final EntityManagerFactory entityManagerFactory = 
        Persistence.createEntityManagerFactory("my_persistence_unit");
    
    public List<User> getAllUsers() {
    EntityManager em = entityManagerFactory.createEntityManager();
    List<User> users = em.createQuery("SELECT u FROM User u", User.class).getResultList();
    em.close();
    return users;
}

    
    public void registerUser(User user) {
        EntityManager em = entityManagerFactory.createEntityManager();
        em.getTransaction().begin();
        em.persist(user);
        em.getTransaction().commit();
        em.close();
    }

    public User getUserByUsername(String username) {
        EntityManager em = entityManagerFactory.createEntityManager();
        User user = null;
        try {
            user = em.createQuery("SELECT u FROM User u WHERE u.username = :username", User.class)
                     .setParameter("username", username)
                     .getSingleResult();
        } catch (Exception e) {
            System.out.println("User not found");
        }
        em.close();
        return user;
    }
    
    public User getUserById(Long id) {
    EntityManager em = entityManagerFactory.createEntityManager();
    User user = null;
    try {
        user = em.find(User.class, id);
    } finally {
        em.close();
    }
    return user;
    }
}
