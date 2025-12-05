package com.courseportal.dao;

import com.courseportal.model.Course;
import com.courseportal.util.DatabaseConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CourseDAO {
    
    public List<Course> getAllCourses() {
        List<Course> courses = new ArrayList<>();
        String sql = "SELECT c.*, u.full_name as instructor_name FROM courses c " +
                    "LEFT JOIN users u ON c.instructor_id = u.id";
        
        try (Connection conn = DatabaseConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                Course course = new Course();
                course.setId(rs.getInt("id"));
                course.setTitle(rs.getString("title"));
                course.setDescription(rs.getString("description"));
                course.setCategory(rs.getString("category"));
                course.setInstructorId(rs.getInt("instructor_id"));
                course.setPrice(rs.getDouble("price"));
                course.setDuration(rs.getInt("duration"));
                course.setCreatedAt(rs.getString("created_at"));
                course.setInstructorName(rs.getString("instructor_name"));
                courses.add(course);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return courses;
    }
    
    public boolean addCourse(Course course) {
        String sql = "INSERT INTO courses (title, description, category, instructor_id, price, duration) " +
                    "VALUES (?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, course.getTitle());
            stmt.setString(2, course.getDescription());
            stmt.setString(3, course.getCategory());
            stmt.setInt(4, course.getInstructorId());
            stmt.setDouble(5, course.getPrice());
            stmt.setInt(6, course.getDuration());
            
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public Course getCourseById(int courseId) {
        Course course = null;
        String sql = "SELECT c.*, u.full_name as instructor_name FROM courses c " +
                    "LEFT JOIN users u ON c.instructor_id = u.id WHERE c.id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, courseId);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                course = new Course();
                course.setId(rs.getInt("id"));
                course.setTitle(rs.getString("title"));
                course.setDescription(rs.getString("description"));
                course.setCategory(rs.getString("category"));
                course.setInstructorId(rs.getInt("instructor_id"));
                course.setPrice(rs.getDouble("price"));
                course.setDuration(rs.getInt("duration"));
                course.setCreatedAt(rs.getString("created_at"));
                course.setInstructorName(rs.getString("instructor_name"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return course;
    }
    
    // NEW METHOD: Get courses with enrollment status for a specific student
    public List<Course> getCoursesWithEnrollmentStatus(int studentId) {
        List<Course> courses = new ArrayList<>();
        String sql = "SELECT c.*, u.full_name as instructor_name, " +
                    "CASE WHEN e.student_id IS NOT NULL THEN 1 ELSE 0 END as is_enrolled " +
                    "FROM courses c " +
                    "LEFT JOIN users u ON c.instructor_id = u.id " +
                    "LEFT JOIN enrollments e ON c.id = e.course_id AND e.student_id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, studentId);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                Course course = new Course();
                course.setId(rs.getInt("id"));
                course.setTitle(rs.getString("title"));
                course.setDescription(rs.getString("description"));
                course.setCategory(rs.getString("category"));
                course.setInstructorId(rs.getInt("instructor_id"));
                course.setPrice(rs.getDouble("price"));
                course.setDuration(rs.getInt("duration"));
                course.setCreatedAt(rs.getString("created_at"));
                course.setInstructorName(rs.getString("instructor_name"));
                // Set enrollment status
                course.setEnrolled(rs.getInt("is_enrolled") == 1);
                courses.add(course);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return courses;
    }
    
    // NEW METHOD: Get enrolled courses for a student with progress
    public List<Course> getEnrolledCourses(int studentId) {
        List<Course> courses = new ArrayList<>();
        String sql = "SELECT c.*, u.full_name as instructor_name, e.progress " +
                    "FROM courses c " +
                    "JOIN enrollments e ON c.id = e.course_id " +
                    "LEFT JOIN users u ON c.instructor_id = u.id " +
                    "WHERE e.student_id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, studentId);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                Course course = new Course();
                course.setId(rs.getInt("id"));
                course.setTitle(rs.getString("title"));
                course.setDescription(rs.getString("description"));
                course.setCategory(rs.getString("category"));
                course.setInstructorId(rs.getInt("instructor_id"));
                course.setPrice(rs.getDouble("price"));
                course.setDuration(rs.getInt("duration"));
                course.setCreatedAt(rs.getString("created_at"));
                course.setInstructorName(rs.getString("instructor_name"));
                course.setProgress(rs.getInt("progress"));
                course.setEnrolled(true);
                courses.add(course);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return courses;
    }
    
    // NEW METHOD: Get courses by instructor
    public List<Course> getCoursesByInstructor(int instructorId) {
        List<Course> courses = new ArrayList<>();
        String sql = "SELECT c.*, u.full_name as instructor_name FROM courses c " +
                    "LEFT JOIN users u ON c.instructor_id = u.id " +
                    "WHERE c.instructor_id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, instructorId);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                Course course = new Course();
                course.setId(rs.getInt("id"));
                course.setTitle(rs.getString("title"));
                course.setDescription(rs.getString("description"));
                course.setCategory(rs.getString("category"));
                course.setInstructorId(rs.getInt("instructor_id"));
                course.setPrice(rs.getDouble("price"));
                course.setDuration(rs.getInt("duration"));
                course.setCreatedAt(rs.getString("created_at"));
                course.setInstructorName(rs.getString("instructor_name"));
                courses.add(course);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return courses;
    }
    
    // NEW METHOD: Update course information
    public boolean updateCourse(Course course) {
        String sql = "UPDATE courses SET title = ?, description = ?, category = ?, " +
                    "price = ?, duration = ? WHERE id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, course.getTitle());
            stmt.setString(2, course.getDescription());
            stmt.setString(3, course.getCategory());
            stmt.setDouble(4, course.getPrice());
            stmt.setInt(5, course.getDuration());
            stmt.setInt(6, course.getId());
            
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    // NEW METHOD: Delete course
    public boolean deleteCourse(int courseId) {
        String sql = "DELETE FROM courses WHERE id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, courseId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    // NEW METHOD: Get enrollment count for a course
    public int getEnrollmentCount(int courseId) {
        String sql = "SELECT COUNT(*) as enrollment_count FROM enrollments WHERE course_id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, courseId);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                return rs.getInt("enrollment_count");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
}