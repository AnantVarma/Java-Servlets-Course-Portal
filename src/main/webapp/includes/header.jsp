<%
    // Get user details from session
    String header_username = (String) session.getAttribute("username");
    String header_fullName = (String) session.getAttribute("fullName");
    String header_role = (String) session.getAttribute("role");
    
    if (header_username == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }

    String contextPath = request.getContextPath();
%>

<!-- CSS FILES HERE -->
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">

<div class="header">
    <div class="container">
        <h1>Course Registration Portal</h1>
        <div class="user-info">
            Welcome, <%= header_fullName %> (<%= header_role %>) |
            <a href="<%= contextPath %>/logout.jsp">Logout</a>
        </div>
    </div>
</div>

<div class="navbar">
    <div class="container">
        <a href="<%= contextPath %>/dashboard.jsp">Dashboard</a>
        <a href="<%= contextPath %>/courses">All Courses</a>
        <% if ("student".equals(header_role)) { %>
            <a href="<%= contextPath %>/pages/my-courses.jsp">My Courses</a>
        <% } %>
        <% if ("instructor".equals(header_role) || "admin".equals(header_role)) { %>
            <a href="<%= contextPath %>/pages/add-course.jsp">Add Course</a>
        <% } %>
    </div>
</div>
