<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.courseportal.model.Course" %>
<%
    // Check session - use different variable name to avoid conflicts
    String detailsUser = (String) session.getAttribute("username");
    if (detailsUser == null) {
        System.out.println("course-details.jsp: User not logged in, redirecting to login");
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
    
    System.out.println("course-details.jsp: User " + detailsUser + " accessing course details");
    
    Course course = (Course) request.getAttribute("course");
    if (course == null) {
        System.out.println("course-details.jsp: No course found in request, redirecting to courses");
        response.sendRedirect(request.getContextPath() + "/courses");
        return;
    }
    
    System.out.println("course-details.jsp: Displaying course - " + course.getTitle());
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title><%= course.getTitle() %> - Course Portal</title>
    <link rel="stylesheet" type="text/css" href="../css/style.css">
    <style>
        .course-details-container {
            background: white;
            padding: 2rem;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
            max-width: 800px;
            margin: 0 auto;
        }
        
        .course-header {
            border-bottom: 3px solid #3498db;
            padding-bottom: 1rem;
            margin-bottom: 2rem;
        }
        
        .course-header h2 {
            color: #2c3e50;
            margin-bottom: 0.5rem;
        }
        
        .course-category {
            color: #7f8c8d;
            font-style: italic;
            font-size: 1.1rem;
        }
        
        .course-description {
            color: #34495e;
            line-height: 1.6;
            margin-bottom: 2rem;
            font-size: 1.1rem;
        }
        
        .course-info-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 1.5rem;
            margin-bottom: 2rem;
        }
        
        .info-card {
            background: #f8f9fa;
            padding: 1.5rem;
            border-radius: 8px;
            border-left: 4px solid #3498db;
        }
        
        .info-card h4 {
            color: #2c3e50;
            margin-bottom: 0.5rem;
            font-size: 1rem;
        }
        
        .info-card p {
            color: #34495e;
            font-size: 1.2rem;
            font-weight: bold;
            margin: 0;
        }
        
        .price-tag {
            color: #27ae60;
            font-size: 1.5rem !important;
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
        }
        
        .btn-primary:hover {
            background: linear-gradient(135deg, #2980b9, #2471a3);
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(52, 152, 219, 0.3);
            text-decoration: none;
        }
        
        .action-buttons {
            display: flex;
            gap: 1rem;
            margin-top: 2rem;
        }
    </style>
</head>
<body>
    <%@ include file="../includes/header.jsp" %>
    
    <div class="container">
        <div class="course-details-container">
            <div class="course-header">
                <h2><%= course.getTitle() %></h2>
                <p class="course-category">📁 <%= course.getCategory() %></p>
            </div>
            
            <div class="course-description">
                <p><%= course.getDescription() %></p>
            </div>
            
            <div class="course-info-grid">
                <div class="info-card">
                    <h4>👨‍🏫 Instructor</h4>
                    <p><%= course.getInstructorName() != null ? course.getInstructorName() : "Unknown" %></p>
                </div>
                
                <div class="info-card">
                    <h4>⏱️ Duration</h4>
                    <p><%= course.getDuration() %> hours</p>
                </div>
                
                <div class="info-card">
                    <h4>💰 Price</h4>
                    <p class="price-tag">₹<%= String.format("%.2f", course.getPrice()) %></p>
                </div>
                
                <div class="info-card">
                    <h4>📅 Created</h4>
                    <p><%= course.getCreatedAt() != null ? course.getCreatedAt() : "Unknown" %></p>
                </div>
            </div>
            <%-- Add this after the course-info-grid div --%>
<%
    String userRole = (String) session.getAttribute("role");
    boolean isStudent = "student".equals(userRole);
    Integer userId = (Integer) session.getAttribute("userId");
    
    // Check if student is enrolled (you'll need to pass this from servlet)
    boolean isEnrolled = false;
    if (isStudent && userId != null) {
        com.courseportal.dao.EnrollmentDAO enrollmentDAO = new com.courseportal.dao.EnrollmentDAO();
        isEnrolled = enrollmentDAO.isStudentEnrolled(userId, course.getId());
    }
%>

<div class="action-buttons">
    <a href="<%= request.getContextPath() %>/courses" class="btn-primary">← Back to Courses</a>
    
    <% if (isStudent) { %>
        <% if (isEnrolled) { %>
            <form action="<%= request.getContextPath() %>/enroll" method="post" style="display: inline;">
                <input type="hidden" name="action" value="unenroll">
                <input type="hidden" name="courseId" value="<%= course.getId() %>">
                <button type="submit" class="btn-danger" 
                        onclick="return confirm('Are you sure you want to unenroll from this course?')">
                    🗑️ Unenroll
                </button>
            </form>
            <button class="btn-success">
                ✅ Enrolled - Continue Learning
            </button>
        <% } else { %>
            <form action="<%= request.getContextPath() %>/enroll" method="post" style="display: inline;">
                <input type="hidden" name="action" value="enroll">
                <input type="hidden" name="courseId" value="<%= course.getId() %>">
                <button type="submit" class="btn-success">
                    🎯 Enroll Now
                </button>
            </form>
        <% } %>
    <% } else if ("instructor".equals(userRole) || "admin".equals(userRole)) { %>
        <button class="btn-primary">
            👨‍🏫 Manage Course
        </button>
    <% } %>
</div>
            
            <div class="action-buttons">
                <a href="<%= request.getContextPath() %>/courses" class="btn-primary">← Back to Courses</a>
                <button class="btn-primary" style="background: linear-gradient(135deg, #27ae60, #219653);">
                    🎯 Enroll Now
                </button>
            </div>
        </div>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            console.log('Course details page loaded for: <%= course.getTitle() %>');
            console.log('User: <%= session.getAttribute("username") %>');
        });
    </script>
</body>
</html>