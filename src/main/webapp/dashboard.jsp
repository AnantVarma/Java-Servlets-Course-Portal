<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, com.courseportal.model.Course, com.courseportal.dao.CourseDAO, com.courseportal.dao.EnrollmentDAO" %>
<%
    String dashboard_username = (String) session.getAttribute("username");
    String dashboard_fullName = (String) session.getAttribute("fullName");
    String dashboard_role = (String) session.getAttribute("role");
    
    if (dashboard_username == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Dashboard - Course Portal</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
    <style>
        .welcome-section {
            margin-bottom: 2rem;
        }
        
        .stats { 
            display: grid; 
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); 
            gap: 20px; 
            margin: 20px 0; 
        }
        
        .stat-card { 
            background: white; 
            padding: 1.5rem; 
            border-radius: 8px; 
            box-shadow: 0 2px 5px rgba(0,0,0,0.1); 
            text-align: center; 
            border-left: 4px solid #3498db;
        }
        
        .stat-card h3 {
            color: #7f8c8d;
            font-size: 0.9rem;
            margin-bottom: 0.5rem;
            text-transform: uppercase;
        }
        
        .stat-card p {
            color: #2c3e50;
            font-size: 2rem;
            font-weight: bold;
            margin: 0;
        }
        
        .btn-primary { 
            background: #3498db; 
            color: white; 
            padding: 0.75rem 1.5rem; 
            border-radius: 4px; 
            text-decoration: none; 
            display: inline-block;
            transition: background 0.3s;
        }
        
        .btn-primary:hover {
            background: #2980b9;
            text-decoration: none;
        }
        
        .btn-success {
            background: #27ae60;
            color: white;
            padding: 0.75rem 1.5rem;
            border-radius: 4px;
            text-decoration: none;
            display: inline-block;
            transition: background 0.3s;
        }
        
        .btn-success:hover {
            background: #219653;
            text-decoration: none;
        }
        
        .recent-courses {
            background: white;
            padding: 1.5rem;
            border-radius: 8px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            margin-top: 2rem;
        }
    </style>
</head>
<body>
    <%@ include file="includes/header.jsp" %>
    
    <div class="container">
        <div class="welcome-section">
            <h2>Welcome, <%= dashboard_fullName %>!</h2>
            <p>Your role: <strong><%= dashboard_role %></strong></p>
        </div>
        
        <div class="stats">
            <div class="stat-card">
                <h3>Available Courses</h3>
                <p>3</p>
            </div>
            <div class="stat-card">
                <h3>Your Role</h3>
                <p><%= dashboard_role %></p>
            </div>
            <div class="stat-card">
                <h3>Status</h3>
                <p>Active</p>
            </div>
        </div>
        
        <!-- Quick Actions -->
        <div style="margin-top: 1.5rem;">
            <a href="courses" class="btn-primary" style="margin-right: 10px;">View All Courses</a>
            <% if ("instructor".equals(dashboard_role) || "admin".equals(dashboard_role)) { %>
                <a href="pages/add-course.jsp" class="btn-success">Add New Course</a>
            <% } %>
        </div>
        
        <!-- Student-specific section -->
        <% if ("student".equals(dashboard_role)) { 
            CourseDAO courseDAO = new CourseDAO();
            EnrollmentDAO enrollmentDAO = new EnrollmentDAO();
            Integer userId = (Integer) session.getAttribute("userId");
            List<Course> enrolledCourses = null;
            int enrollmentCount = 0;
            int completedCount = 0;
            double avgProgress = 0;
            
            if (userId != null) {
                enrolledCourses = courseDAO.getEnrolledCourses(userId);
                enrollmentCount = enrolledCourses != null ? enrolledCourses.size() : 0;
                
                // Calculate completed courses and average progress
                if (enrolledCourses != null && !enrolledCourses.isEmpty()) {
                    completedCount = 0;
                    double totalProgress = 0;
                    
                    for (Course course : enrolledCourses) {
                        if (course.getProgress() == 100) {
                            completedCount++;
                        }
                        totalProgress += course.getProgress();
                    }
                    avgProgress = totalProgress / enrolledCourses.size();
                }
            }
        %>
            <div class="recent-courses">
                <h3>My Learning Journey 🎓</h3>
                <div class="stats">
                    <div class="stat-card">
                        <h3>Enrolled Courses</h3>
                        <p><%= enrollmentCount %></p>
                    </div>
                    <div class="stat-card">
                        <h3>Courses Completed</h3>
                        <p><%= completedCount %></p>
                    </div>
                    <div class="stat-card">
                        <h3>Learning Progress</h3>
                        <p><%= String.format("%.1f", avgProgress) %>%</p>
                    </div>
                </div>
                
                <div style="margin-top: 1.5rem;">
                    <a href="courses" class="btn-primary" style="margin-right: 10px;">Browse Courses</a>
                    <a href="my-courses" class="btn-success">My Courses</a>
                </div>
                
                <% if (enrolledCourses != null && !enrolledCourses.isEmpty()) { %>
                    <div style="margin-top: 1.5rem;">
                        <h4>Recently Enrolled Courses:</h4>
                        <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(250px, 1fr)); gap: 15px; margin-top: 1rem;">
                            <% 
                                // Show only first 3 courses
                                int count = 0;
                                for (Course course : enrolledCourses) {
                                    if (count >= 3) break;
                            %>
                                <div style="background: #f8f9fa; padding: 1rem; border-radius: 6px; border-left: 4px solid #3498db;">
                                    <h5 style="margin: 0 0 0.5rem 0;"><%= course.getTitle() %></h5>
                                    <p style="margin: 0; font-size: 0.9rem; color: #666;">
                                        Progress: <strong><%= course.getProgress() %>%</strong>
                                    </p>
                                </div>
                            <% 
                                    count++;
                                } 
                            %>
                        </div>
                    </div>
                <% } %>
            </div>
        <% } %>
    </div>
</body>
</html>