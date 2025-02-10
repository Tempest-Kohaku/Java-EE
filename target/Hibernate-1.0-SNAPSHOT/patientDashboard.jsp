<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="kratos.dao.AppointmentDao" %>
<%@ page import="kratos.model.Appointment" %>
<%@ page import="kratos.dao.PrescriptionDao" %>
<%@ page import="kratos.model.Prescription" %>
<%@ page import="kratos.model.User" %>
<%@ page import="java.util.List" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<%
    // Use the implicit session object
    if (session == null || session.getAttribute("user") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    User user = (User) session.getAttribute("user");
    
    // Retrieve the user's appointments
    AppointmentDao appointmentDao = new AppointmentDao();
    List<Appointment> appointments = appointmentDao.getAppointmentsByPatient(user.getId());
    
    // Retrieve the user's prescription history
    PrescriptionDao prescriptionDao = new PrescriptionDao();
    List<Prescription> prescriptions = prescriptionDao.getPrescriptionsByPatient(user.getId());
%>
<html>
<head>
    <title>Patient Dashboard</title>
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
            background-color: #007BFF; /* Blue background */
            color: white;
        }
        .btn-primary:hover {
            background-color: #0056b3; /* Darker blue on hover */
        }
        .btn-secondary {
            background-color: #6c757d;
            color: white;
        }
        .btn-secondary:hover {
            background-color: #5a6268;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            margin-bottom: 30px; /* Add space below the table */
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
            color: inherit;
        }
        .alert {
            padding: 15px;
            margin-bottom: 20px;
            border-radius: 8px;
            background-color: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }
        .prescription-section {
            margin-top: 40px; /* Add space above the Prescription History section */
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1><i class="fas fa-user-circle icon"></i>Welcome, <%= user.getUsername() %></h1>
            <!-- Logout button -->
            <a href="LogoutServlet" class="btn btn-primary btn-sm">Logout</a>
        </div>
        <% if (request.getParameter("message") != null) { %>
            <div class="alert">
                <%= request.getParameter("message") %>
            </div>
        <% } %>
        <!-- Appointments Section -->
        <h2><i class="fas fa-calendar-alt icon"></i>Your Appointments</h2>
        <table>
            <thead>
                <tr>
                    <th>Doctor Name</th>
                    <th>Appointment Date</th>
                    <th>Status</th>
                </tr>
            </thead>
            <tbody>
                <% for (Appointment app : appointments) { %>
                    <tr>
                        <td><%= app.getDoctor().getName() %></td>
                        <td><%= app.getAppointmentDate() %></td>
                        <td><%= app.getStatus() %></td>
                    </tr>
                <% } %>
            </tbody>
        </table>
        <!-- Link to list doctors and book new appointments -->
        <a href="listDoctors.jsp" class="btn btn-primary mt-3">
            <i class="fas fa-plus icon"></i> Book New Appointment
        </a>   
        <!-- Prescription History Section -->
        <div class="prescription-section">
            <h2><i class="fas fa-prescription-bottle-alt icon"></i>Your Prescription History</h2>
            <table>
                <thead>
                    <tr>
                        <th>Prescription Date</th>
                        <th>Prescribed By</th>
                        <th>Description</th>
                        <th>Fee</th>
                    </tr>
                </thead>
                <tbody>
                    <% for (Prescription p : prescriptions) { %>
                        <tr>
                            <td><%= p.getPrescriptionDate() %></td>
                            <td><%= (p.getDoctor() != null ? p.getDoctor().getName() : "N/A") %></td>
                            <td><%= p.getDescription() %></td>
                            <td><%= p.getFee() %></td>
                        </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>
