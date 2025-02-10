<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="kratos.dao.AppointmentDao" %>
<%@ page import="kratos.model.Appointment" %>
<%@ page import="kratos.model.User" %>
<%@ page import="java.util.List" %>
<%
    // Ensure that an admin is logged in.
    if (session == null || session.getAttribute("user") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    kratos.model.User admin = (kratos.model.User) session.getAttribute("user");
    if (!"ADMIN".equalsIgnoreCase(admin.getRole())) {
        response.sendRedirect("login.jsp");
        return;
    }
    
    // Retrieve all appointments using AppointmentDao
    AppointmentDao appointmentDao = new AppointmentDao();
    List<Appointment> appointments = appointmentDao.getAllAppointments();
%>
<html>
<head>
    <title>Appointments Overview</title>
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
        h1 {
            color: #333;
            font-size: 28px;
            font-weight: 600;
            margin-bottom: 30px;
            text-align: center;
        }
        .icon {
            margin-right: 10px;
            color: #007BFF;
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
            color: white; /* White text */
        }
        .btn-primary:hover {
            background-color: #0056b3; /* Darker blue on hover */
        }
        .alert {
            padding: 15px;
            margin-bottom: 20px;
            border-radius: 8px;
        }
        .alert-success {
            background-color: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }
        .alert-danger {
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }
        .back-button {
            margin-top: 30px;
            display: inline-block;
        }
        p {
            font-size: 18px;
            color: #333;
            margin-bottom: 20px;
        }
    </style>
</head>
    <body>
        <div class="container">
            <h1><i class="fas fa-calendar-alt icon"></i>Appointments Overview</h1>
            <% if (request.getParameter("message") != null) { %>
                <div class="alert alert-success">
                    <%= request.getParameter("message") %>
                </div>
            <% } %>
            <% if (request.getParameter("error") != null) { %>
                <div class="alert alert-danger">
                    <%= request.getParameter("error") %>
                </div>
            <% } %>

            <!-- Display total number of appointments -->
            <p><strong>Total Appointments:</strong> <%= appointments.size() %></p>

            <!-- Display the appointments in a table -->
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Patient</th>
                        <th>Doctor</th>
                        <th>Appointment Date</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody>
                    <% for (Appointment app : appointments) { %>
                        <tr>
                            <td><%= app.getId() %></td>
                            <td>
                                <%-- If patient is lazily loaded, ensure it's available. --%>
                                <%= (app.getPatient() != null ? app.getPatient().getUsername() : "N/A") %>
                            </td>
                            <td>
                                <%-- If doctor is lazily loaded, ensure it's available. --%>
                                <%= (app.getDoctor() != null ? app.getDoctor().getName() : "N/A") %>
                            </td>
                            <td><%= app.getAppointmentDate() %></td>
                            <td><%= app.getStatus() %></td>
                        </tr>
                    <% } %>
                </tbody>
            </table>
            <a href="adminDashboard.jsp" class="btn btn-primary back-button">Back to Dashboard</a>
        </div>
    </body>
</html>