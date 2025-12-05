<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Register - Course Portal</title>
    <link rel="stylesheet" type="text/css" href="../css/style.css">
    <style>
        .register-container {
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            padding: 20px;
        }
        
        .register-form {
            background: white;
            padding: 2rem;
            border-radius: 8px;
            box-shadow: 0 0 20px rgba(0,0,0,0.1);
            width: 100%;
            max-width: 500px;
        }
        
        .register-form h2 {
            text-align: center;
            margin-bottom: 0.5rem;
            color: #2c3e50;
        }
        
        .register-form h3 {
            text-align: center;
            margin-bottom: 1.5rem;
            color: #7f8c8d;
        }
        
        .form-group {
            margin-bottom: 1rem;
        }
        
        .form-group label {
            display: block;
            margin-bottom: 0.5rem;
            color: #2c3e50;
            font-weight: bold;
        }
        
        .form-group input, .form-group select {
            width: 100%;
            padding: 0.75rem;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 1rem;
        }
        
        .form-group input:focus, .form-group select:focus {
            border-color: #3498db;
            outline: none;
            box-shadow: 0 0 5px rgba(52, 152, 219, 0.3);
        }
        
        .btn-primary {
            background: #3498db;
            color: white;
            padding: 0.75rem 1.5rem;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 1rem;
            width: 100%;
            margin-top: 1rem;
        }
        
        .btn-primary:hover {
            background: #2980b9;
        }
        
        .login-link {
            text-align: center;
            margin-top: 1.5rem;
            padding-top: 1rem;
            border-top: 1px solid #eee;
        }
        
        .login-link a {
            color: #3498db;
            text-decoration: none;
        }
        
        .login-link a:hover {
            text-decoration: underline;
        }
        
        .success-message {
            background: #27ae60;
            color: white;
            padding: 0.75rem;
            border-radius: 4px;
            margin-bottom: 1rem;
            text-align: center;
        }
        
        .error-message {
            background: #e74c3c;
            color: white;
            padding: 0.75rem;
            border-radius: 4px;
            margin-bottom: 1rem;
            text-align: center;
        }
        
        .role-description {
            font-size: 0.9rem;
            color: #7f8c8d;
            margin-top: 0.25rem;
        }
    </style>
</head>
<body>
    <div class="register-container">
        <div class="register-form">
            <h2>Course Registration Portal</h2>
            <h3>Create New Account</h3>
            
            <%-- Display success message if registration was successful --%>
            <% if (request.getParameter("success") != null) { %>
                <div class="success-message">
                    <%= request.getParameter("success") %>
                </div>
            <% } %>
            
            <%-- Display error message if registration failed --%>
            <% if (request.getParameter("error") != null) { %>
                <div class="error-message">
                    <%= request.getParameter("error") %>
                </div>
            <% } %>
            
            <form action="../RegisterServlet" method="post">
                <div class="form-group">
                    <label for="fullName">Full Name:</label>
                    <input type="text" id="fullName" name="fullName" required 
                           placeholder="Enter your full name">
                </div>
                
                <div class="form-group">
                    <label for="username">Username:</label>
                    <input type="text" id="username" name="username" required 
                           placeholder="Choose a username">
                </div>
                
                <div class="form-group">
                    <label for="email">Email:</label>
                    <input type="email" id="email" name="email" required 
                           placeholder="Enter your email address">
                </div>
                
                <div class="form-group">
                    <label for="password">Password:</label>
                    <input type="password" id="password" name="password" required 
                           placeholder="Create a password">
                </div>
                
                <div class="form-group">
                    <label for="confirmPassword">Confirm Password:</label>
                    <input type="password" id="confirmPassword" name="confirmPassword" required 
                           placeholder="Confirm your password">
                </div>
                
                <div class="form-group">
                    <label for="role">Account Type:</label>
                    <select id="role" name="role" required>
                        <option value="">Select your role</option>
                        <option value="student">Student</option>
                        <option value="instructor">Instructor</option>
                    </select>
                    <div class="role-description">
                        <strong>Student:</strong> Can browse and enroll in courses<br>
                        <strong>Instructor:</strong> Can create and manage courses
                    </div>
                </div>
                
                <button type="submit" class="btn-primary" onclick="return validateForm()">Create Account</button>
            </form>
            
            <div class="login-link">
                <p>Already have an account? <a href="../login.jsp">Login here</a></p>
            </div>
        </div>
    </div>

    <script>
        function validateForm() {
            var password = document.getElementById("password").value;
            var confirmPassword = document.getElementById("confirmPassword").value;
            var username = document.getElementById("username").value;
            var email = document.getElementById("email").value;
            
            // Check if passwords match
            if (password !== confirmPassword) {
                alert("Passwords do not match!");
                return false;
            }
            
            // Check password length
            if (password.length < 6) {
                alert("Password must be at least 6 characters long!");
                return false;
            }
            
            // Check username length
            if (username.length < 3) {
                alert("Username must be at least 3 characters long!");
                return false;
            }
            
            // Basic email validation
            var emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            if (!emailPattern.test(email)) {
                alert("Please enter a valid email address!");
                return false;
            }
            
            return true;
        }
        
        // Real-time password confirmation check
        document.getElementById('confirmPassword').addEventListener('input', function() {
            var password = document.getElementById('password').value;
            var confirmPassword = this.value;
            var confirmInput = this;
            
            if (confirmPassword !== '') {
                if (password !== confirmPassword) {
                    confirmInput.style.borderColor = '#e74c3c';
                    confirmInput.style.boxShadow = '0 0 5px rgba(231, 76, 60, 0.3)';
                } else {
                    confirmInput.style.borderColor = '#27ae60';
                    confirmInput.style.boxShadow = '0 0 5px rgba(39, 174, 96, 0.3)';
                }
            } else {
                confirmInput.style.borderColor = '#ddd';
                confirmInput.style.boxShadow = 'none';
            }
        });
    </script>
</body>
</html>