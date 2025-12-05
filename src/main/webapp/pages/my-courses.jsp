<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, com.courseportal.model.Course, com.courseportal.dao.CourseDAO, com.courseportal.dao.EnrollmentDAO" %>
<%
    String mycourses_username = (String) session.getAttribute("username");
    String mycourses_fullName = (String) session.getAttribute("fullName");
    String mycourses_role = (String) session.getAttribute("role");
    
    if (mycourses_username == null) {
        response.sendRedirect("../login.jsp");
        return;
    }
    
    if (!"student".equals(mycourses_role)) {
        response.sendRedirect("../dashboard.jsp");
        return;
    }
    
    // Get enrolled courses from request attribute (set by MyCoursesServlet)
    List<Course> enrolledCourses = (List<Course>) request.getAttribute("enrolledCourses");
    if (enrolledCourses == null) {
        // If not set by servlet, get directly from DAO
        Integer userId = (Integer) session.getAttribute("userId");
        if (userId != null) {
            CourseDAO courseDAO = new CourseDAO();
            enrolledCourses = courseDAO.getEnrolledCourses(userId);
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>My Courses - Course Portal</title>
    <link rel="stylesheet" type="text/css" href="../css/style.css">
    <style>
        .page-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 2rem;
        }
        
        .courses-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
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
            position: relative;
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
        
        .progress-container {
            margin: 1.5rem 0;
        }
        
        .progress-bar {
            width: 100%;
            height: 8px;
            background: #ecf0f1;
            border-radius: 4px;
            overflow: hidden;
        }
        
        .progress-fill {
            height: 100%;
            background: linear-gradient(135deg, #27ae60, #219653);
            border-radius: 4px;
            transition: width 0.3s ease;
        }
        
        .progress-text {
            display: flex;
            justify-content: space-between;
            margin-top: 0.5rem;
            font-size: 0.9rem;
            color: #7f8c8d;
        }
        
        .enrollment-badge {
            position: absolute;
            top: 1rem;
            right: 1rem;
            background: #27ae60;
            color: white;
            padding: 0.3rem 0.8rem;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: bold;
        }
        
        .action-buttons {
            display: flex;
            gap: 10px;
            margin-top: 1rem;
        }
        
        .btn-primary {
            background: linear-gradient(135deg, #3498db, #2980b9);
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
        
        .btn-primary:hover {
            background: linear-gradient(135deg, #2980b9, #2471a3);
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(52, 152, 219, 0.3);
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
        
        .stats-cards {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin-bottom: 2rem;
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
    </style>
</head>
<body>
    <%@ include file="../includes/header.jsp" %>
    
    
    <div class="container">
        <div class="page-header">
            <h2>My Courses 🎓</h2>
            <p>Welcome back, <%= mycourses_fullName %>! Continue your learning journey.</p>
        </div>
        
        <%-- Display messages --%>
        <% if (request.getParameter("success") != null) { %>
            <div class="success-message">
                ✅ <%= request.getParameter("success") %>
            </div>
        <% } %>
        
        <% if (request.getParameter("error") != null) { %>
            <div class="error-message">
                ❌ <%= request.getParameter("error") %>
            </div>
        <% } %>
        
        <%-- Statistics --%>
        <%
            int enrollmentCount = enrolledCourses != null ? enrolledCourses.size() : 0;
            int completedCount = 0;
            double avgProgress = 0;
            
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
        %>
        
        <div class="stats-cards">
            <div class="stat-card" style="border-left-color: #3498db;">
                <h3>Enrolled Courses</h3>
                <p><%= enrollmentCount %></p>
            </div>
            <div class="stat-card" style="border-left-color: #27ae60;">
                <h3>Courses Completed</h3>
                <p><%= completedCount %></p>
            </div>
            <div class="stat-card" style="border-left-color: #f39c12;">
                <h3>Average Progress</h3>
                <p><%= String.format("%.1f", avgProgress) %>%</p>
            </div>
        </div>
        
        <% if (enrolledCourses == null || enrolledCourses.isEmpty()) { %>
            <div class="empty-state">
                <h3>📚 No Enrolled Courses</h3>
                <p>You haven't enrolled in any courses yet. Start your learning journey by browsing available courses!</p>
                
            </div>
        <% } else { %>
            <div class="courses-grid">
                <% for (Course course : enrolledCourses) { %>
                    <div class="course-card">
                        <div class="enrollment-badge">ENROLLED</div>
                        
                        <h3><%= course.getTitle() %></h3>
                        <p class="course-category">📁 <%= course.getCategory() %></p>
                        <p class="course-description"><%= course.getDescription() %></p>
                        
                        <div class="course-info">
                            <span>👨‍🏫 Instructor: <strong><%= course.getInstructorName() != null ? course.getInstructorName() : "Unknown" %></strong></span>
                            <span>⏱️ Duration: <strong><%= course.getDuration() %> hours</strong></span>
                            <span>  Price: <strong>₹<%= String.format("%.2f", course.getPrice()) %></strong></span>
                        </div>
                        
                        <% if (course.getProgress() > 0) { %>
                            <div class="progress-container">
                                <div class="progress-bar">
                                    <div class="progress-fill" style="width: <%= course.getProgress() %>%;"></div>
                                </div>
                                <div class="progress-text">
                                    <span>Progress</span>
                                    <span><%= course.getProgress() %>%</span>
                                </div>
                            </div>
                        <% } %>
                        
                        <div class="action-buttons">
                            <a href="../courses?action=view&id=<%= course.getId() %>" class="btn-primary">
                                <% if (course.getProgress() == 0) { %>
                                    🚀 Start Learning
                                <% } else if (course.getProgress() < 100) { %>
                                    ➕ Continue
                                <% } else { %>
                                    ✅ Completed
                                <% } %>
                            </a>
                            
                            
                        </div>
                    </div>
                <% } %>
            </div>
        <% } %>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            console.log('My Courses page loaded successfully');
            
            // Add animation to course cards
            const courseCards = document.querySelectorAll('.course-card');
            courseCards.forEach((card, index) => {
                card.style.opacity = '0';
                card.style.transform = 'translateY(20px)';
                
                setTimeout(() => {
                    card.style.transition = 'all 0.5s ease';
                    card.style.opacity = '1';
                    card.style.transform = 'translateY(0)';
                }, index * 100);
            });
        });
    </script>
</body>
</html>