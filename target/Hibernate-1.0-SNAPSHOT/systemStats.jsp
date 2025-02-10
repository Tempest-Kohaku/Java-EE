<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="kratos.dao.UserDao" %>
<%@ page import="kratos.dao.DoctorDao" %>
<%@ page import="kratos.dao.AppointmentDao" %>
<%@ page import="kratos.dao.PrescriptionDao" %>
<%@ page import="kratos.model.User" %>
<%@ page import="java.util.List" %>
<%
    // Verify that the admin is logged in.
    if (session == null || session.getAttribute("user") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    User admin = (User) session.getAttribute("user");
    if (!"ADMIN".equalsIgnoreCase(admin.getRole())) {
        response.sendRedirect("login.jsp");
        return;
    }
    
    // Create DAO instances and retrieve statistics.
    UserDao userDao = new UserDao();
    List<User> allUsers = userDao.getAllUsers();
    
    DoctorDao doctorDao = new DoctorDao();
    List<?> allDoctors = doctorDao.getAllDoctors();
    
    AppointmentDao appointmentDao = new AppointmentDao();
    List<?> allAppointments = appointmentDao.getAllAppointments();
    
    PrescriptionDao prescriptionDao = new PrescriptionDao();
    List<?> allPrescriptions = prescriptionDao.getAllPrescriptions();
%>
<html>
<head>
    <title>System Statistics</title>
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
        .stats {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
            justify-content: center;
            margin-bottom: 30px;
        }
        .stat-card {
            background-color: #f8f9fa;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.05);
            text-align: center;
            width: 200px;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }
        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.1);
        }
        .stat-card i {
            font-size: 40px;
            color: #007BFF;
            margin-bottom: 10px;
        }
        .stat-card p {
            font-size: 18px;
            font-weight: 600;
            color: #333;
            margin: 0;
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
        .back-button {
            display: block;
            margin: 0 auto;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1><i class="fas fa-chart-bar icon"></i>System Statistics</h1>
        <div class="stats">
            <div class="stat-card">
                <i class="fas fa-users"></i>
                <p>Total Users: <%= allUsers.size() %></p>
            </div>
            <div class="stat-card">
                <i class="fas fa-user-md"></i>
                <p>Total Doctors: <%= allDoctors.size() %></p>
            </div>
            <div class="stat-card">
                <i class="fas fa-calendar-alt"></i>
                <p>Total Appointments: <%= allAppointments.size() %></p>
            </div>
            <div class="stat-card">
                <i class="fas fa-prescription-bottle-alt"></i>
                <p>Total Prescriptions: <%= allPrescriptions.size() %></p>
            </div>
        </div>
        <a href="adminDashboard.jsp" class="btn btn-primary back-button">Back to Dashboard</a>
    </div>
</body>
</html>