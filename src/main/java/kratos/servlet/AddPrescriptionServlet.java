package kratos.servlet;

import java.io.IOException;
import java.util.Date;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kratos.dao.PrescriptionDao;
import kratos.dao.DoctorDao;
import kratos.dao.UserDao;
import kratos.model.Prescription;
import kratos.model.Doctor;
import kratos.model.User;

public class AddPrescriptionServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private PrescriptionDao PrescriptionDao = new PrescriptionDao();
    private DoctorDao DoctorDao = new DoctorDao();
    private UserDao UserDao = new UserDao();  // Ensure you have a method to get user by ID

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Long patientId = Long.parseLong(request.getParameter("patientId"));
        Long doctorId = Long.parseLong(request.getParameter("doctorId"));
        String description = request.getParameter("description");

        // Retrieve the Doctor and Patient objects from their DAOs
        Doctor doctor = DoctorDao.getDoctorById(doctorId);
        User patient = UserDao.getUserById(patientId);  // Make sure you implement getUserById in UserDao

        if(doctor == null || patient == null) {
            response.sendRedirect("doctorDashboard.jsp?error=Invalid doctor or patient ID");
            return;
        }

        Prescription prescription = new Prescription();
        prescription.setDoctor(doctor);
        prescription.setPatient(patient);
        prescription.setDescription(description);
        prescription.setPrescriptionDate(new Date());
        // Optionally, set the fee (for example, based on doctor.getFee())
        prescription.setFee(doctor.getFee());

        PrescriptionDao.addPrescription(prescription);
        response.sendRedirect("doctorDashboard.jsp?message=Prescription added successfully");
    }
}
