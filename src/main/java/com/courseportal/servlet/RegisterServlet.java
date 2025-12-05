package com.courseportal.servlet;

import com.courseportal.dao.UserDAO;
import com.courseportal.model.User;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

// REMOVE THIS LINE: @WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
    private UserDAO userDAO;
    
    @Override
    public void init() throws ServletException {
        userDAO = new UserDAO();
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String fullName = request.getParameter("fullName");
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String role = request.getParameter("role");
        
        User newUser = new User(username, password, email, role, fullName);
        
        boolean isRegistered = userDAO.register(newUser);
        
        if (isRegistered) {
        	response.sendRedirect("login.jsp?success=Registration successful! Please login.");
        } else {
            response.sendRedirect("../pages/register.jsp?error=Registration failed! Username or email may already exist.");
        }
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        response.sendRedirect("../pages/register.jsp");
    }
}