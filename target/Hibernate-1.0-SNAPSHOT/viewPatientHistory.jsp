<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="kratos.dao.PrescriptionDao" %>
<%@ page import="kratos.model.Prescription" %>
<%@ page import="java.util.List" %>
<%
    // Ensure the doctor is logged in
    if(session == null || session.getAttribute("doctor") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    String patientIdStr = request.getParameter("patientId");
    if(patientIdStr == null) {
        out.println("Patient ID not provided.");
        return;
    }
    Long patientId = Long.parseLong(patientIdStr);
    PrescriptionDao prescriptionDao = new PrescriptionDao();
    List<Prescription> prescriptions = prescriptionDao.getPrescriptionsByPatient(patientId);
%>
<html>
<head>
    <title>Patient History</title>
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
            padding: 12px 20px;
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
        /* Add margin above the Back to Dashboard button */
        .back-button {
            margin-top: 30px; /* Space between the table and the button */
            display: inline-block;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1><i class="fas fa-history icon"></i>Patient History</h1>
        <table>
            <thead>
                <tr>
                    <th>Prescription Date</th>
                    <th>Description</th>
                    <th>Fee</th>
                </tr>
            </thead>
            <tbody>
                <% for(Prescription p : prescriptions) { %>
                    <tr>
                        <td><%= p.getPrescriptionDate() %></td>
                        <td><%= p.getDescription() %></td>
                        <td><%= p.getFee() %></td>
                    </tr>
                <% } %>
            </tbody>
        </table>
        <!-- Back to Dashboard Button -->
        <a href="doctorDashboard.jsp" class="btn btn-primary back-button">Back to Dashboard</a>
    </div>
</body>
</html>