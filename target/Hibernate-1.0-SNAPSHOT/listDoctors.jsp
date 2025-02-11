<%@ page import="java.util.List" %>
<%@ page import="kratos.model.Doctor" %>
<%@ page import="kratos.dao.DoctorDao" %>
<%
    DoctorDao doctorDao = new DoctorDao();
    List<Doctor> doctors = doctorDao.getAllDoctors();
%>
<html>
<head>
    <title>Available Doctors</title>
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
        h2 {
            text-align: center;
            color: #333;
            font-size: 28px;
            font-weight: 600;
            margin-bottom: 30px;
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
            font-weight: 600;
        }
        tr:nth-child(even) {
            background-color: #f9f9f9;
        }
        .icon {
            margin-right: 10px;
            color: #007BFF;
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
        .btn-secondary {
            display: flex;
            background-color: #007BFF; /* Blue background */
            color: white; /* White text */
        }
        .btn-secondary:hover {
            background-color: #0056b3; /* Darker blue on hover */
        }
        .back-button {
            padding: 11px 20px;
            position: absolute;
            right: 186px; /* Adjust as needed */
            bottom: 666px;
        }
    </style>
</head>
<body>
    <div class="container">
        <a href="patientDashboard.jsp" class="btn btn-secondary back-button">Back to Dashboard</a>                            
        <h2><i class="fas fa-user-md icon"></i>Available Doctors</h2>
        <table>
            <thead>
                <tr>
                    <th>Name</th>
                    <th>Specialization</th>
                    <th>Fee</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <%
                    for (Doctor doctor : doctors) {
                %>
                <tr>
                    <td><%= doctor.getName() %></td>
                    <td><%= doctor.getSpecialization() %></td>
                    <td><%= doctor.getFee() %></td>
                    <td>
                        <form action="BookAppointmentServlet" method="post" style="display: inline;">
                            <input type="hidden" name="doctorId" value="<%= doctor.getId() %>">
                            <button type="submit" class="btn btn-primary">Book Appointment</button>
                        </form>
                    </td>
                </tr>
                <%
                    }
                %>
            </tbody>
        </table>
    </div>
</body>
</html>