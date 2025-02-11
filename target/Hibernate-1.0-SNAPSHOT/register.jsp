<%@page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register</title>
    <!-- Import Google Font -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
    <!-- Import Font Awesome for Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        /* Ripple Background Container */
        .ripple-container {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            z-index: -1; /* Place behind other content */
            overflow: hidden;
        }
        .ripple-container::before {
            content: "";
            position: absolute;
            top: 50%;
            left: 50%;
            width: 250px;
            height: 250px;
            background: radial-gradient(circle, #ff0000 10%, transparent 70%);
            transform: translate(-50%, -50%) scale(1);
            /* Two animations: one for ripple expansion and one for changing colors */
            animation: ripple 4s infinite, changeColor 12s infinite;
        }
        @keyframes ripple {
            0% {
                transform: translate(-50%, -50%) scale(0.5);
                opacity: 1;
            }
            100% {
                transform: translate(-50%, -50%) scale(4);
                opacity: 0;
            }
        }
        @keyframes changeColor {
            0%   { background: radial-gradient(circle, #ff0000 10%, transparent 70%); }
            33%  { background: radial-gradient(circle, #00ff00 10%, transparent 70%); }
            66%  { background: radial-gradient(circle, #0000ff 10%, transparent 70%); }
            100% { background: radial-gradient(circle, #ff0000 10%, transparent 70%); }
        }
        
        /* General Body Styling */
        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #f5f7fa, #c3cfe2);
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }
        /* General Body Styling */
        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #f5f7fa, #c3cfe2);
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }

        /* Container Styling */
        .container {
            background-color: white;
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0 6px 15px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 400px;
            text-align: center;
        }

        /* Header Styling */
        h2 {
            margin-bottom: 25px;
            font-size: 28px;
            color: #333;
            font-weight: 600;
        }

        /* Input Group Styling */
        .input-group {
            position: relative;
            margin-bottom: 20px;
        }

        .input-group i {
            position: absolute;
            left: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: #007BFF;
        }

        input {
            width: 130%;
            padding: 12px 15px 12px 45px;
            border: 1px solid #ccc;
            border-radius: 8px;
            font-size: 16px;
            transition: border-color 0.3s ease;
        }

        input:focus {
            border-color: #007BFF;
            outline: none;
        }

        /* Tooltip Styling */
        .tooltip {
            position: relative;
            left: -70px;
            top: 50%;
            display: inline-block;
        }

        .tooltip .tooltiptext {
            visibility: hidden;
            width: 200px;
            background-color: rgba(13, 71, 161, 0.8);
            color: #fff;
            text-align: center;
            border-radius: 6px;
            padding: 5px;
            position: absolute;
            z-index: 1;
            top: 50%;
            left: 150%;
            transform: translateY(-50%);
            opacity: 0;
            transition: opacity 0.3s;
        }

        .tooltip .tooltiptext::after {
            content: '';
            position: absolute;
            top: 50%;
            right: 100%;
            margin-top: -5px;
            border-width: 5px;
            border-style: solid;
            border-color: transparent rgba(13, 71, 161, 0.8) transparent transparent;
        }

        .tooltip:hover .tooltiptext {
            visibility: visible;
            opacity: 0.9;
        }

        /* Button Styling */
        button {
            width: 100%;
            padding: 14px;
            background-color: #007BFF;
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 18px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        button:hover {
            background-color: #0056b3;
        }

        /* Links Styling */
        .links {
            margin-top: 25px;
        }

        .links a {
            color: #007BFF;
            text-decoration: none;
            font-size: 16px;
            transition: text-decoration 0.3s ease;
        }

        .links a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="ripple-container"></div>
    <div class="container">
        <h2>Create an Account</h2>
        <form action="RegisterServlet" method="post" onsubmit="return validateForm()">
            <!-- Username Field with Tooltip -->
            <div class="input-group tooltip">
                <i class="fas fa-user"></i>
                <input type="text" name="username" placeholder="Enter Username" required aria-label="Username">
                <span class="tooltiptext">Please enter a valid username (e.g., john_doe)</span>
            </div>

            <!-- Email Field with Tooltip -->
            <div class="input-group tooltip">
                <i class="fas fa-envelope"></i>
                <input type="email" id="email" name="email" placeholder="Enter Email" required aria-label="Email">
                <span class="tooltiptext">Please enter a valid email address</span>
            </div>

            <!-- Password Field -->
            <div class="input-group tooltip">
                <i class="fas fa-lock"></i>
                <input type="password" id="password" name="password" placeholder="Enter Password" required aria-label="Password">
                <span class="tooltiptext">Remember Your Password you Input</span>
            </div>

            <!-- Confirm Password Field with Tooltip -->
            <div class="input-group tooltip">
                <i class="fas fa-lock"></i>
                <input type="password" id="confirm-password" placeholder="Confirm Password" required aria-label="Confirm Password">
                <span class="tooltiptext">Enter the password you typed</span>
            </div>

            <!-- Submit Button -->
            <button type="submit">Register</button>
        </form>

        <!-- Login Link -->
        <div class="links">
            <p>Already have an account? <a href="login.jsp">Login here</a></p>
        </div>
    </div>

    <script>
        // Client-side form validation
        function validateForm() {
            const email = document.getElementById('email').value;
            const password = document.getElementById('password').value;
            const confirmPassword = document.getElementById('confirm-password').value;
            const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

            if (!emailRegex.test(email)) {
                alert('Please enter a valid email address.');
                return false;
            }

            if (password !== confirmPassword) {
                alert('Passwords do not match.');
                return false;
            }

            return true;
        }
    </script>
</body>
</html>