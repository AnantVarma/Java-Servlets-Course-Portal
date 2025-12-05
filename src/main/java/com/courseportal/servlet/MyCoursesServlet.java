package com.courseportal.servlet;

import com.courseportal.dao.CourseDAO;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class MyCoursesServlet extends HttpServlet {
    private CourseDAO courseDAO;
    
    @Override
    public void init() throws ServletException {
        courseDAO = new CourseDAO();
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Check if user is logged in
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("username") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        
        Integer studentId = (Integer) session.getAttribute("userId");
        String userRole = (String) session.getAttribute("role");
        
        // Only students can access this page
        if (!"student".equals(userRole)) {
            response.sendRedirect(request.getContextPath() + "/dashboard.jsp");
            return;
        }
        
        if (studentId != null) {
            List<com.courseportal.model.Course> enrolledCourses = courseDAO.getEnrolledCourses(studentId);
            request.setAttribute("enrolledCourses", enrolledCourses);
            request.getRequestDispatcher("/pages/my-courses.jsp").forward(request, response);
        } else {
            response.sendRedirect(request.getContextPath() + "/courses?error=Student ID not found");
        }
    }
}