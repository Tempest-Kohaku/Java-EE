package kratos.servlet;

import java.io.IOException;
import java.util.Date;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import kratos.dao.AppointmentDao;
import kratos.dao.DoctorDao;
import kratos.model.Appointment;
import kratos.model.Doctor;
import kratos.model.User;

public class BookAppointmentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final AppointmentDao appointmentDao = new AppointmentDao();
    private final DoctorDao doctorDao = new DoctorDao();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        User patient = (User) session.getAttribute("user");

        // Retrieve the doctor ID from the form parameter
        Long doctorId = Long.parseLong(request.getParameter("doctorId"));
        Doctor doctor = doctorDao.getDoctorById(doctorId);
        if (doctor == null) {
            response.sendRedirect("listDoctors.jsp?error=Doctor not found");
            return;
        }

        // Set the appointment date to now (you can modify this to use a date selected by the patient)
        Date appointmentDate = new Date();

        Appointment appointment = new Appointment();
        appointment.setPatient(patient);
        appointment.setDoctor(doctor);
        appointment.setAppointmentDate(appointmentDate);
        appointment.setStatus("Pending");

        appointmentDao.addAppointment(appointment);
        response.sendRedirect("patientDashboard.jsp?message=Appointment booked successfully");
    }
}
