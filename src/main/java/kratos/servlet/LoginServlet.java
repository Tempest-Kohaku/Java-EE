package kratos.servlet;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import kratos.dao.UserDao;
import kratos.dao.DoctorDao;
import kratos.model.User;
import kratos.model.Doctor;

public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final UserDao userDao = new UserDao();
    private final DoctorDao doctorDao = new DoctorDao();

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        // First, try to retrieve the user from the USERS table
        User user = userDao.getUserByUsername(username);

        if (user != null && user.getPassword().equals(password)) {
            HttpSession session = request.getSession();
            // If the user is an admin, redirect to admin dashboard
            if ("ADMIN".equalsIgnoreCase(user.getRole())) {
                session.setAttribute("user", user);
                response.sendRedirect("adminDashboard.jsp");
                return;
            }
            // Otherwise, treat it as a patient
            session.setAttribute("user", user);
            response.sendRedirect("patientDashboard.jsp");
        } else {
            // If no matching user was found, try checking the DOCTORS table
            Doctor doctor = doctorDao.getDoctorByUsernameAndPassword(username, password);
            if (doctor != null) {
                HttpSession session = request.getSession();
                session.setAttribute("doctor", doctor);
                response.sendRedirect("doctorDashboard.jsp");
            } else {
                // No match found in either table: invalid credentials
                response.sendRedirect("login.jsp?error=Invalid credentials");
            }
        }
    }
}
