package com.courseportal.servlet;

import com.courseportal.dao.CourseDAO;
import com.courseportal.model.Course;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class CourseServlet extends HttpServlet {
    private CourseDAO courseDAO;
    
    @Override
    public void init() throws ServletException {
        courseDAO = new CourseDAO();
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Check if user is logged in using session attributes
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("username") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        
        String action = request.getParameter("action");
        System.out.println("CourseServlet - Action: " + action + ", ID: " + request.getParameter("id"));
        
        if ("view".equals(action)) {
            // View single course details
            String courseIdParam = request.getParameter("id");
            if (courseIdParam != null) {
                try {
                    int courseId = Integer.parseInt(courseIdParam);
                    Course course = courseDAO.getCourseById(courseId);
                    if (course != null) {
                        System.out.println("Course found: " + course.getTitle());
                        request.setAttribute("course", course);
                        request.getRequestDispatcher("/pages/course-details.jsp").forward(request, response);
                        return;
                    } else {
                        System.out.println("Course not found for ID: " + courseId);
                    }
                } catch (NumberFormatException e) {
                    System.out.println("Invalid course ID: " + courseIdParam);
                    e.printStackTrace();
                }
            }
            response.sendRedirect(request.getContextPath() + "/courses");
            
        } else {
            // List all courses
        	// List all courses with enrollment status
            Integer studentId = (Integer) session.getAttribute("userId");
            String userRole = (String) session.getAttribute("role");
            
            List<Course> courses;
            if ("student".equals(userRole) && studentId != null) {
                // Get courses with enrollment status for students
                courses = courseDAO.getCoursesWithEnrollmentStatus(studentId);
            } else {
                // Get all courses for non-students
                courses = courseDAO.getAllCourses();
            }
            
            request.setAttribute("courses", courses);
            request.getRequestDispatcher("/pages/courses.jsp").forward(request, response);
        }
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Check if user is logged in
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("username") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        
        // Add new course logic
        String title = request.getParameter("title");
        String description = request.getParameter("description");
        String category = request.getParameter("category");
        String instructorIdParam = request.getParameter("instructor_id");
        String priceParam = request.getParameter("price");
        String durationParam = request.getParameter("duration");
        
        try {
            int instructorId = Integer.parseInt(instructorIdParam);
            double price = Double.parseDouble(priceParam);
            int duration = Integer.parseInt(durationParam);
            
            Course course = new Course(title, description, category, instructorId, price, duration);
            
            if (courseDAO.addCourse(course)) {
                response.sendRedirect(request.getContextPath() + "/courses?success=Course added successfully");
            } else {
                response.sendRedirect(request.getContextPath() + "/pages/add-course.jsp?error=Failed to add course");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/pages/add-course.jsp?error=Invalid input data");
        }
    }
}