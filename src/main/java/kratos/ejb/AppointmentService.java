package kratos.ejb;

import jakarta.ejb.Stateless;
import kratos.dao.AppointmentDao;
import kratos.model.Appointment;

@Stateless
public class AppointmentService {
    private AppointmentDao appointmentDao = new AppointmentDao();

    public void confirmAppointment(Long appointmentId) {
        Appointment appointment = appointmentDao.getAppointmentById(appointmentId);
        if (appointment != null) {
            appointment.setStatus("Confirmed");
            appointmentDao.updateAppointment(appointment);
        }
    }

    // You can add more appointment-related business methods here if needed.
}
