<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="kratos.dao.AppointmentDao" %>
<%@ page import="kratos.model.Appointment" %>
<%@ page import="kratos.model.Doctor" %>
<%@ page import="java.util.List" %>
<%
    // Use the implicit session object. Make sure the doctor is logged in.
    if(session == null || session.getAttribute("doctor") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    Doctor doctor = (Doctor) session.getAttribute("doctor");
    AppointmentDao appointmentDao = new AppointmentDao();
    List<Appointment> appointments = appointmentDao.getAppointmentsByDoctor(doctor.getId());
%>
<html>
<head>
    <title>Doctor Dashboard</title>
    <!-- Import Google Font -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
    <!-- Import Font Awesome for Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #f5f7fa, #c3cfe2);
            margin: 0;
            padding: 0;
        }
        .container {
            background-color: white;
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0 6px 15px rgba(0, 0, 0, 0.1);
            width: 90%;
            max-width: 1200px;
            margin: 40px auto;
        }
        h1, h2 {
            color: #333;
            font-weight: 600;
        }
        h1 {
            font-size: 28px;
        }
        h2 {
            font-size: 24px;
            margin-top: 30px;
        }
        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
        }
        .btn {
            padding: 10px 20px;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }
        .btn-primary {
            background-color: #007BFF;
            color: white;
        }
        .btn-primary:hover {
            background-color: #0056b3;
        }
        .btn-success {
            background-color: #28a745;
            color: white;
        }
        .btn-success:hover {
            background-color: #1e7e34;
        }
        .btn-info {
            background-color: #17a2b8;
            color: white;
        }
        .btn-info:hover {
            background-color: #117a8b;
        }
        .btn-warning {
            background-color: #ffc107;
            color: white;
        }
        .btn-warning:hover {
            background-color: #d39e00;
        }
        /* Small Buttons for Table */
        .btn-sm {
            padding: 5px 10px; /* Reduced padding */
            font-size: 14px;   /* Smaller font size */
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            padding: 12px;
            text-align: left;
            border: 1px solid #ddd;
        }
        th {
            background-color: #f8f9fa;
            color: #333;
        }
        tr:nth-child(even) {
            background-color: #f9f9f9;
        }
        .icon {
            margin-right: 10px;
            color: #007BFF;
        }
        .alert {
            padding: 15px;
            margin-bottom: 20px;
            border-radius: 8px;
            background-color: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1><i class="fas fa-user-md icon"></i>Welcome, Dr. <%= doctor.getName() %></h1>
            <!-- Logout button -->
            <a href="LogoutServlet" class="btn btn-primary">Logout</a>
        </div>
        <% if(request.getParameter("message") != null) { %>
            <div class="alert">
                <%= request.getParameter("message") %>
            </div>
        <% } %>
        <h2><i class="fas fa-calendar-alt icon"></i>Your Appointments</h2>
        <table>
            <thead>
                <tr>
                    <th>Patient</th>
                    <th>Appointment Date</th>
                    <th>Status</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <% for(Appointment app : appointments) { %>
                    <tr>
                        <td><%= app.getPatient().getUsername() %></td>
                        <td><%= app.getAppointmentDate() %></td>
                        <td><%= app.getStatus() %></td>
                        <td>
                            <% if("Pending".equalsIgnoreCase(app.getStatus())) { %>
                                <form action="ConfirmAppointmentServlet" method="post" style="display:inline;">
                                    <input type="hidden" name="appointmentId" value="<%= app.getId() %>">
                                    <button type="submit" class="btn btn-success btn-sm">Confirm</button>
                                </form>
                            <% } %>
                            <a href="viewPatientHistory.jsp?patientId=<%= app.getPatient().getId() %>" class="btn btn-info btn-sm">History</a>
                            <a href="addPrescription.jsp?patientId=<%= app.getPatient().getId() %>" class="btn btn-warning btn-sm">Prescribe</a>
                        </td>
                    </tr>
                <% } %>
            </tbody>
        </table>
    </div>
</body>
</html>