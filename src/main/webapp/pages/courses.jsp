<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, com.courseportal.model.Course" %>
<%
    String courses_username = (String) session.getAttribute("username");
    if (courses_username == null) {
        response.sendRedirect("../login.jsp");
        return;
    }
    
    List<Course> courses = (List<Course>) request.getAttribute("courses");
    if (courses == null) {
        response.sendRedirect("../courses");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>All Courses - Course Portal</title>
    <link rel="stylesheet" type="text/css" href="../css/style.css">
    <style>
        .page-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 2rem;
        }
        
        .course-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(320px, 1fr));
            gap: 25px;
            margin-top: 20px;
        }
        
        .course-card {
            background: white;
            padding: 1.5rem;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
            border: 1px solid #e0e0e0;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }
        
        .course-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 15px rgba(0,0,0,0.15);
        }
        
        .course-card h3 {
            color: #2c3e50;
            margin-bottom: 0.5rem;
            font-size: 1.3rem;
            border-bottom: 2px solid #3498db;
            padding-bottom: 0.5rem;
        }
        
        .course-category {
            color: #7f8c8d;
            font-style: italic;
            margin-bottom: 0.8rem;
            font-size: 0.9rem;
        }
        
        .course-description {
            color: #34495e;
            margin-bottom: 1.2rem;
            line-height: 1.5;
        }
        
        .course-info {
            margin-bottom: 1.2rem;
        }
        
        .course-info span {
            display: block;
            margin-bottom: 0.3rem;
            font-size: 0.9rem;
            color: #555;
        }
        
        .price {
            color: #27ae60;
            font-weight: bold;
            font-size: 1.2rem !important;
            margin-top: 0.5rem !important;
        }
        
        .btn-primary {
            background: linear-gradient(135deg, #3498db, #2980b9);
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
            width: 100%;
            box-sizing: border-box;
        }
        
        .btn-primary:hover {
            background: linear-gradient(135deg, #2980b9, #2471a3);
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(52, 152, 219, 0.3);
            text-decoration: none;
        }
        
        .btn-success {
            background: linear-gradient(135deg, #27ae60, #219653);
            color: white;
            padding: 0.7rem 1.2rem;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-size: 0.9rem;
            text-decoration: none;
            display: inline-block;
            transition: all 0.3s ease;
            text-align: center;
            flex: 1;
        }
        
        .btn-success:hover {
            background: linear-gradient(135deg, #219653, #1e8449);
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(39, 174, 96, 0.3);
            text-decoration: none;
        }
        
        .btn-danger {
            background: linear-gradient(135deg, #e74c3c, #c0392b);
            color: white;
            padding: 0.7rem 1.2rem;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-size: 0.9rem;
            text-decoration: none;
            display: inline-block;
            transition: all 0.3s ease;
            text-align: center;
            flex: 1;
        }
        
        .btn-danger:hover {
            background: linear-gradient(135deg, #c0392b, #a93226);
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(231, 76, 60, 0.3);
            text-decoration: none;
        }
        
        .empty-state {
            text-align: center;
            padding: 3rem;
            background: white;
            border-radius: 10px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        
        .empty-state h3 {
            color: #7f8c8d;
            margin-bottom: 1rem;
        }
        
        .success-message {
            background: #d4edda;
            color: #155724;
            padding: 1rem;
            border-radius: 6px;
            margin-bottom: 1.5rem;
            border: 1px solid #c3e6cb;
        }
        
        .error-message {
            background: #f8d7da;
            color: #721c24;
            padding: 1rem;
            border-radius: 6px;
            margin-bottom: 1.5rem;
            border: 1px solid #f5c6cb;
        }
        
        .action-buttons {
            display: flex;
            gap: 10px;
        }
        
        .enrollment-status {
            font-size: 0.9rem;
            padding: 0.3rem 0.8rem;
            border-radius: 4px;
            display: inline-block;
            margin-bottom: 0.5rem;
        }
        
        .enrolled {
            background: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }
        
        .available {
            background: #fff3cd;
            color: #856404;
            border: 1px solid #ffeaa7;
        }
        
        /* Fix for header navigation */
        .navbar {
            background: #34495e;
            padding: 0.5rem 0;
        }
        
        .navbar .container {
            display: flex;
            align-items: center;
        }
        
        .navbar a {
            color: white;
            text-decoration: none;
            padding: 0.5rem 1rem;
            margin-right: 10px;
            border-radius: 3px;
            transition: background-color 0.3s;
            display: inline-block;
        }
        
        .navbar a:hover {
            background: #3498db;
            text-decoration: none;
        }
        
        .header {
            background: #2c3e50;
            color: white;
            padding: 1rem 0;
        }
        
        .header .container {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        
        .user-info {
            font-size: 0.9rem;
        }
        
        .user-info a {
            color: #3498db;
            text-decoration: none;
        }
        
        .user-info a:hover {
            text-decoration: underline;
        }
        
        .container {
            width: 90%;
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }
    </style>
</head>
<body>
    <%@ include file="../includes/header.jsp" %>
    
    <div class="container">
        <div class="page-header">
            <h2>All Courses</h2>
            <div>
                <% 
                    String userRole = (String) session.getAttribute("role");
                    if ("instructor".equals(userRole) || "admin".equals(userRole)) { 
                %>
                    
                <% } %>
                <% if ("student".equals(userRole)) { %>
                    <a href="<%= request.getContextPath() %>/my-courses" class="btn-success" style="width: auto; display: inline-block; margin-left: 10px;">
                        📚 My Courses
                    </a>
                <% } %>
            </div>
        </div>
        
        <%-- Display success message if present --%>
        <% if (request.getParameter("success") != null) { %>
            <div class="success-message">
                ✅ <%= request.getParameter("success") %>
            </div>
        <% } %>
        
        <%-- Display error message if present --%>
        <% if (request.getParameter("error") != null) { %>
            <div class="error-message">
                ❌ <%= request.getParameter("error") %>
            </div>
        <% } %>
        
        <% if (courses.isEmpty()) { %>
            <div class="empty-state">
                <h3>📚 No Courses Available</h3>
                <p>There are no courses available at the moment.</p>
                <% if ("instructor".equals(userRole) || "admin".equals(userRole)) { %>
                    <a href="add-course.jsp" class="btn-primary" style="width: auto; margin-top: 1rem;">
                        Create Your First Course
                    </a>
                <% } %>
            </div>
        <% } else { %>
            <div class="course-grid">
                <% for (Course course : courses) { 
                    // Get enrollment status for students
                    boolean isStudent = "student".equals(userRole);
                    boolean isEnrolled = course.isEnrolled();
                %>
                    <div class="course-card">
                        <h3><%= course.getTitle() %></h3>
                        <p class="course-category">📁 <%= course.getCategory() %></p>
                        <p class="course-description"><%= course.getDescription() %></p>
                        
                        <div class="course-info">
                            <span>👨‍🏫 Instructor: <strong><%= course.getInstructorName() != null ? course.getInstructorName() : "Unknown" %></strong></span>
                            <span>⏱️ Duration: <strong><%= course.getDuration() %> hours</strong></span>
                            <span class="price">Rs <%= String.format("%.2f", course.getPrice()) %></span>
                            
                            <%-- Enrollment status for students --%>
                            <% if (isStudent) { %>
                                <div class="enrollment-status <%= isEnrolled ? "enrolled" : "available" %>">
                                    <% if (isEnrolled) { %>
                                        ✅ <strong>Enrolled</strong>
                                    <% } else { %>
                                        📚 <strong>Available for Enrollment</strong>
                                    <% } %>
                                </div>
                            <% } %>
                        </div>
                        
                        <div class="action-buttons">
                            <a href="<%= request.getContextPath() %>/courses?action=view&id=<%= course.getId() %>" class="btn-primary" style="flex: 2;">
                                🔍 View Details
                            </a>
                            
                            <% if (isStudent) { %>
                                <% if (isEnrolled) { %>
                                    <form action="<%= request.getContextPath() %>/enroll" method="post" style="flex: 1;">
                                        <input type="hidden" name="action" value="unenroll">
                                        <input type="hidden" name="courseId" value="<%= course.getId() %>">
                                        <button type="submit" class="btn-danger" 
                                                onclick="return confirm('Are you sure you want to unenroll from <%= course.getTitle() %>?')">
                                            🗑️
                                        </button>
                                    </form>
                                <% } else { %>
                                    <form action="<%= request.getContextPath() %>/enroll" method="post" style="flex: 1;">
                                        <input type="hidden" name="action" value="enroll">
                                        <input type="hidden" name="courseId" value="<%= course.getId() %>">
                                        <button type="submit" class="btn-success">
                                            🎯 Enroll
                                        </button>
                                    </form>
                                <% } %>
                            <% } %>
                        </div>
                    </div>
                <% } %>
            </div>
        <% } %>
    </div>

    <script>
        // Add some interactivity
        document.addEventListener('DOMContentLoaded', function() {
            console.log('Courses page loaded successfully');
            
            // Add animation to course cards when they come into view
            const courseCards = document.querySelectorAll('.course-card');
            
            courseCards.forEach((card, index) => {
                // Staggered animation
                card.style.opacity = '0';
                card.style.transform = 'translateY(20px)';
                
                setTimeout(() => {
                    card.style.transition = 'all 0.5s ease';
                    card.style.opacity = '1';
                    card.style.transform = 'translateY(0)';
                }, index * 100);
            });
            
            // Add click animation to buttons
            const buttons = document.querySelectorAll('.btn-primary, .btn-success, .btn-danger');
            buttons.forEach(button => {
                button.addEventListener('click', function(e) {
                    console.log('Button clicked:', this.textContent);
                    
                    // Add click animation
                    this.style.transform = 'scale(0.95)';
                    setTimeout(() => {
                        this.style.transform = 'scale(1)';
                    }, 150);
                });
            });
            
            // Debug: Log enrollment status
            const enrolledBadges = document.querySelectorAll('.enrollment-status.enrolled');
            const availableBadges = document.querySelectorAll('.enrollment-status.available');
            console.log('Enrolled courses:', enrolledBadges.length);
            console.log('Available courses:', availableBadges.length);
        });
    </script>
</body>
</html>