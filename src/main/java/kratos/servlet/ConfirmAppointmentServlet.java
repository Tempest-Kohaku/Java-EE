package kratos.servlet;

import java.io.IOException;
import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kratos.ejb.AppointmentService;

public class ConfirmAppointmentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // Inject the EJB instead of using a DAO directly.
    @EJB
    private AppointmentService appointmentService;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Long appointmentId = Long.parseLong(request.getParameter("appointmentId"));
        appointmentService.confirmAppointment(appointmentId);
        response.sendRedirect("doctorDashboard.jsp?message=Appointment confirmed successfully");
    }
}
