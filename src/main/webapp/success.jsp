<%@page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="kratos.model.User" %>

<%
    if (session == null || session.getAttribute("user") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    User user = (User) session.getAttribute("user");
%>

<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Welcome</title>

        <!-- Bootstrap CSS -->
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-pzjw8f+ua7Kw1TIq0XzURPzX2lB9v5ftA5e5nF7q8t3t6bK2HcdX6PjNkxjXqTbz" crossorigin="anonymous">
        <style>
            body {
                background-color: #f4f4f9;
            }

            .welcome-container {
                margin-top: 50px;
                text-align: center;
            }

            .welcome-message {
                font-size: 30px;
                font-weight: bold;
            }

            .btn-logout {
                background-color: #007BFF;
                color: white;
                font-size: 18px;
                padding: 10px 20px;
                border-radius: 5px;
                text-decoration: none;
            }

            .btn-logout:hover {
                background-color: #0056b3;
            }
            </style>
        </head>
    <body>

        <div class="container welcome-container">
            <div class="row">
                <div class="col-12">
                    <h2 class="welcome-message">Welcome, <%= user.getEmail() %>!</h2>
                    <p class="lead">You are successfully logged in.</p>
                    <a href="login.jsp" class="btn-logout">Logout</a>
                </div>
            </div>
        </div>

        <!-- Bootstrap JS and Popper.js (optional, for interactive components) -->
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zyu8t7I5jRr59AexQ5z8A1uJfakFPskvXusvfa0b" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9gV5YfX9Xz0w6FpyJKU+gFz4vLJgkTKkXaSC+uOpHT9l3ccGZ6Zffy9Tyy0k7Ht6" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js" integrity="sha384-pzjw8f+ua7Kw1TIq0XzURPzX2lB9v5ftA5e5nF7q8t3t6bK2HcdX6PjNkxjXqTbz" crossorigin="anonymous"></script>
    </body>
</html>
