package com.courseportal.servlet;

import com.courseportal.dao.EnrollmentDAO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class EnrollmentServlet extends HttpServlet {
    private EnrollmentDAO enrollmentDAO;
    
    @Override
    public void init() throws ServletException {
        enrollmentDAO = new EnrollmentDAO();
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Check if user is logged in
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("username") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        
        String action = request.getParameter("action");
        String courseIdParam = request.getParameter("courseId");
        Integer studentId = (Integer) session.getAttribute("userId");
        String userRole = (String) session.getAttribute("role");
        
        // Only students can enroll
        if (!"student".equals(userRole)) {
            response.sendRedirect(request.getContextPath() + "/courses?error=Only students can enroll in courses");
            return;
        }
        
        if (courseIdParam != null && studentId != null) {
            try {
                int courseId = Integer.parseInt(courseIdParam);
                
                if ("enroll".equals(action)) {
                    // Enroll student
                    if (enrollmentDAO.enrollStudent(studentId, courseId)) {
                        response.sendRedirect(request.getContextPath() + "/courses?success=Successfully enrolled in course!");
                    } else {
                        response.sendRedirect(request.getContextPath() + "/courses?error=Failed to enroll in course");
                    }
                    
                } else if ("unenroll".equals(action)) {
                    // Unenroll student
                    if (enrollmentDAO.unenrollStudent(studentId, courseId)) {
                        response.sendRedirect(request.getContextPath() + "/my-courses?success=Successfully unenrolled from course");
                    } else {
                        response.sendRedirect(request.getContextPath() + "/my-courses?error=Failed to unenroll from course");
                    }
                }
                
            } catch (NumberFormatException e) {
                response.sendRedirect(request.getContextPath() + "/courses?error=Invalid course ID");
            }
        } else {
            response.sendRedirect(request.getContextPath() + "/courses?error=Missing required parameters");
        }
    }
}