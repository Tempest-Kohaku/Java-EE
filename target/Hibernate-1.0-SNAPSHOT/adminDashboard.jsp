<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%-- No need to redeclare session since it's an implicit object --%>
<% 
    if (session == null || session.getAttribute("user") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    // Ensure the logged-in user is an admin
    kratos.model.User user = (kratos.model.User) session.getAttribute("user");
    if (!"ADMIN".equalsIgnoreCase(user.getRole())) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<html>
<head>
    <title>Admin Dashboard</title>
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
        .btn {
            padding: 12px 20px;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s ease;
            margin-right: 10px;
        }
        .btn-primary {
            background-color: #007BFF;
            color: white;
        }
        .btn-primary:hover {
            background-color: #0056b3;
        }
        .btn-secondary {
            background-color: #6c757d;
            color: white;
        }
        .btn-secondary:hover {
            background-color: #5a6268;
        }
        .alert {
            padding: 15px;
            margin-bottom: 20px;
            border-radius: 8px;
            background-color: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }
        .admin-section {
            margin-top: 30px;
        }
        .admin-section h2 {
            font-size: 24px;
            color: #333;
            margin-bottom: 20px;
        }
        .admin-section ul {
            list-style-type: none;
            padding: 0;
        }
        .admin-section li {
            margin-bottom: 10px;
        }
        .admin-section a {
            text-decoration: none;
            color: #007BFF;
            font-size: 16px;
        }
        .admin-section a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1><i class="fas fa-user-shield icon"></i>Welcome, Admin <%= user.getUsername() %></h1>
        <% if (request.getParameter("message") != null) { %>
            <div class="alert">
                <%= request.getParameter("message") %>
            </div>
        <% } %>
        <div class="d-flex justify-content-between align-items-center mb-4">
            <a href="addDoctor.jsp" class="btn btn-primary">Add Doctor</a>
            <a href="LogoutServlet" class="btn btn-primary">Logout</a>
        </div>
        <!-- Admin Functionalities Section -->
        <div class="admin-section">
            <h2><i class="fas fa-tasks icon"></i>Admin Functionalities</h2>
            <ul>
                <li><a href="manageDoctors.jsp"><i class="fas fa-user-md icon"></i>View All Doctors</a></li>
                <li><a href="manageUsers.jsp"><i class="fas fa-users icon"></i>Manage Users</a></li>
                <li><a href="systemStats.jsp"><i class="fas fa-chart-bar icon"></i>View System Statistics</a></li>
                <li><a href="appointmentsOverview.jsp"><i class="fas fa-calendar-alt icon"></i>Appointments Overview</a></li>
            </ul>
        </div>
    </div>
</body>
</html>