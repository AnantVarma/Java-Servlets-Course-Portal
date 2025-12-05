<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String addcourse_username = (String) session.getAttribute("username");
    String addcourse_role = (String) session.getAttribute("role");
    Integer addcourse_userId = (Integer) session.getAttribute("userId");
    
    if (addcourse_username == null) {
        response.sendRedirect("../login.jsp");
        return;
    }
    if (!"instructor".equals(addcourse_role) && !"admin".equals(addcourse_role)) {
        response.sendRedirect("../dashboard.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add Course - Course Portal</title>
    <link rel="stylesheet" type="text/css" href="../css/style.css">
    <style>
        .page-header {
            margin-bottom: 2rem;
        }
        
        .course-form {
            background: white;
            padding: 2rem;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
            max-width: 700px;
            margin: 0 auto;
        }
        
        .form-group {
            margin-bottom: 1.5rem;
        }
        
        .form-group label {
            display: block;
            margin-bottom: 0.5rem;
            color: #2c3e50;
            font-weight: bold;
            font-size: 1rem;
        }
        
        .form-group input, 
        .form-group textarea, 
        .form-group select {
            width: 100%;
            padding: 0.8rem;
            border: 2px solid #e0e0e0;
            border-radius: 6px;
            font-size: 1rem;
            transition: border-color 0.3s ease;
            box-sizing: border-box;
        }
        
        .form-group input:focus, 
        .form-group textarea:focus, 
        .form-group select:focus {
            border-color: #3498db;
            outline: none;
            box-shadow: 0 0 0 3px rgba(52, 152, 219, 0.1);
        }
        
        .form-group textarea {
            resize: vertical;
            min-height: 100px;
        }
        
        .btn-primary {
            background: linear-gradient(135deg, #27ae60, #219653);
            color: white;
            padding: 1rem 2rem;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-size: 1.1rem;
            font-weight: bold;
            transition: all 0.3s ease;
            display: inline-block;
            text-decoration: none;
            width: 100%;
            box-sizing: border-box;
        }
        
        .btn-primary:hover {
            background: linear-gradient(135deg, #219653, #1e8449);
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(39, 174, 96, 0.3);
        }
        
        .btn-secondary {
            background: #95a5a6;
            color: white;
            padding: 0.8rem 1.5rem;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-size: 1rem;
            text-decoration: none;
            display: inline-block;
            transition: all 0.3s ease;
            text-align: center;
            margin-right: 1rem;
        }
        
        .btn-secondary:hover {
            background: #7f8c8d;
            text-decoration: none;
        }
        
        .form-actions {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: 2rem;
        }
        
        .error-message {
            background: #f8d7da;
            color: #721c24;
            padding: 1rem;
            border-radius: 6px;
            margin-bottom: 1.5rem;
            border: 1px solid #f5c6cb;
        }
        
        .success-message {
            background: #d4edda;
            color: #155724;
            padding: 1rem;
            border-radius: 6px;
            margin-bottom: 1.5rem;
            border: 1px solid #c3e6cb;
        }
        
        .input-hint {
            font-size: 0.85rem;
            color: #7f8c8d;
            margin-top: 0.25rem;
        }
        
        .required::after {
            content: " *";
            color: #e74c3c;
        }
    </style>
</head>
<body>
    <%@ include file="../includes/header.jsp" %>
    
    <div class="container">
        <div class="page-header">
            <h2>Add New Course</h2>
            <a href="../courses" class="btn-secondary">← Back to Courses</a>
        </div>
        
        <%-- Display error message if present --%>
        <% if (request.getParameter("error") != null) { %>
            <div class="error-message">
                ❌ <%= request.getParameter("error") %>
            </div>
        <% } %>
        
        <%-- Display success message if present --%>
        <% if (request.getParameter("success") != null) { %>
            <div class="success-message">
                ✅ <%= request.getParameter("success") %>
            </div>
        <% } %>
        
        <div class="course-form">
            <form action="../courses" method="post" id="courseForm">
                <div class="form-group">
                    <label for="title" class="required">Course Title</label>
                    <input type="text" id="title" name="title" required 
                           placeholder="Enter course title (e.g., Java Programming)">
                    <div class="input-hint">Make it descriptive and engaging</div>
                </div>
                
                <div class="form-group">
                    <label for="description" class="required">Course Description</label>
                    <textarea id="description" name="description" required 
                              placeholder="Describe what students will learn in this course..."></textarea>
                    <div class="input-hint">Be detailed about the course content and learning outcomes</div>
                </div>
                
                <div class="form-group">
                    <label for="category" class="required">Category</label>
                    <input type="text" id="category" name="category" required 
                           placeholder="Enter category (e.g., Programming, Web Development)">
                    <div class="input-hint">Helps students find relevant courses</div>
                </div>
                
                <div class="form-group">
                    <label for="instructor_id" class="required">Instructor ID</label>
                    <input type="number" id="instructor_id" name="instructor_id" 
                           value="<%= addcourse_userId != null ? addcourse_userId : "" %>" 
                           readonly style="background-color: #f8f9fa;">
                    <div class="input-hint">Your instructor ID (automatically filled)</div>
                </div>
                
                <div class="form-group">
                    <label for="price" class="required">Price ($)</label>
                    <input type="number" id="price" name="price" step="0.01" min="0" required 
                           placeholder="0.00">
                    <div class="input-hint">Set the course price in USD</div>
                </div>
                
                <div class="form-group">
                    <label for="duration" class="required">Duration (hours)</label>
                    <input type="number" id="duration" name="duration" min="1" required 
                           placeholder="Enter course duration in hours">
                    <div class="input-hint">Total estimated learning time</div>
                </div>
                
                <div class="form-actions">
                    <a href="../courses" class="btn-secondary">Cancel</a>
                    <button type="submit" class="btn-primary" id="submitBtn">
                        🚀 Create Course
                    </button>
                </div>
            </form>
        </div>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            console.log('Add Course page loaded successfully');
            
            const form = document.getElementById('courseForm');
            const submitBtn = document.getElementById('submitBtn');
            
            // Form validation
            form.addEventListener('submit', function(e) {
                let isValid = true;
                const inputs = form.querySelectorAll('input[required], textarea[required]');
                
                inputs.forEach(input => {
                    if (!input.value.trim()) {
                        isValid = false;
                        input.style.borderColor = '#e74c3c';
                    } else {
                        input.style.borderColor = '#27ae60';
                    }
                });
                
                // Validate price
                const priceInput = document.getElementById('price');
                if (priceInput.value && parseFloat(priceInput.value) < 0) {
                    isValid = false;
                    priceInput.style.borderColor = '#e74c3c';
                    alert('Price cannot be negative');
                }
                
                // Validate duration
                const durationInput = document.getElementById('duration');
                if (durationInput.value && parseInt(durationInput.value) < 1) {
                    isValid = false;
                    durationInput.style.borderColor = '#e74c3c';
                    alert('Duration must be at least 1 hour');
                }
                
                if (!isValid) {
                    e.preventDefault();
                    alert('Please fill in all required fields correctly.');
                } else {
                    // Show loading state
                    submitBtn.innerHTML = '⏳ Creating Course...';
                    submitBtn.disabled = true;
                }
            });
            
            // Real-time validation
            const inputs = form.querySelectorAll('input, textarea');
            inputs.forEach(input => {
                input.addEventListener('input', function() {
                    if (this.value.trim()) {
                        this.style.borderColor = '#27ae60';
                    } else {
                        this.style.borderColor = '#e0e0e0';
                    }
                });
            });
            
            // Add character counter for description
            const descriptionTextarea = document.getElementById('description');
            const charCount = document.createElement('div');
            charCount.className = 'input-hint';
            charCount.style.textAlign = 'right';
            charCount.innerHTML = 'Characters: <span id="charCount">0</span>';
            descriptionTextarea.parentNode.appendChild(charCount);
            
            descriptionTextarea.addEventListener('input', function() {
                document.getElementById('charCount').textContent = this.value.length;
            });
        });
    </script>
</body>
</html>