package kratos.servlet;

import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kratos.dao.DoctorDao;
import kratos.dao.AppointmentDao;
import kratos.dao.PrescriptionDao;
import kratos.model.Appointment;
import kratos.model.Prescription;

public class RemoveDoctorServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private DoctorDao doctorDao = new DoctorDao();
    private AppointmentDao appointmentDao = new AppointmentDao();
    // Make sure you have implemented this method in PrescriptionDao.
    private PrescriptionDao prescriptionDao = new PrescriptionDao();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String doctorIdStr = request.getParameter("doctorId");
        if (doctorIdStr != null) {
            try {
                Long doctorId = Long.parseLong(doctorIdStr);
                
                // Check for existing appointments for this doctor.
                List<Appointment> appointments = appointmentDao.getAppointmentsByDoctor(doctorId);
                // Check for existing prescriptions for this doctor.
                List<Prescription> prescriptions = prescriptionDao.getPrescriptionsByDoctor(doctorId);
                
                if ((appointments != null && !appointments.isEmpty()) ||
                    (prescriptions != null && !prescriptions.isEmpty())) {
                    response.sendRedirect("manageDoctors.jsp?error=Cannot remove doctor with existing appointments or prescriptions");
                    return;
                }
                
                // If no dependencies, remove the doctor.
                doctorDao.removeDoctor(doctorId);
                response.sendRedirect("manageDoctors.jsp?message=Doctor removed successfully");
                return;
            } catch (NumberFormatException e) {
                response.sendRedirect("manageDoctors.jsp?error=Invalid doctor ID");
                return;
            } catch (Exception e) {
                response.sendRedirect("manageDoctors.jsp?error=Error while removing doctor: " + e.getMessage());
                return;
            }
        }
        response.sendRedirect("manageDoctors.jsp?error=Doctor ID not provided");
    }
}
