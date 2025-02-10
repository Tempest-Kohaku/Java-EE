package kratos.servlet;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kratos.dao.DoctorDao;
import kratos.model.Doctor;

public class AdminAddDoctorServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final DoctorDao doctorDao = new DoctorDao();

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Optionally, add a session check to ensure only admin users can add doctors
        if (request.getSession(false) == null || request.getSession(false).getAttribute("user") == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String name = request.getParameter("name");
        String specialization = request.getParameter("specialization");
        Double fee = Double.parseDouble(request.getParameter("fee"));
        
        // Create and add the new doctor
        Doctor newDoctor = new Doctor(username, password, name, specialization, fee);
        doctorDao.addDoctor(newDoctor);
        
        response.sendRedirect("adminDashboard.jsp?message=Doctor added successfully");
    }
}
