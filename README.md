# 🎓 Course Registration Portal | Java Servlets + JSP + JDBC

A **web-based course enrollment system** built using **Java Servlets**, **JSP**, and **JDBC**.  
This application allows students to **register, view available courses, and enroll** through a secure login system.

---

## 🛠 Tech Stack

| Component | Technology |
|----------|------------|
| Frontend | HTML, CSS, JSP |
| Backend | Java Servlets |
| Database | MySQL |
| Web Server | Apache Tomcat |
| Build Tool | Manual (No Maven) |

---

## 📌 Features

✔ Student Login & Registration  
✔ View Available Courses  
✔ Enroll into Courses  
✔ Prevent Duplicate Enrollment  
✔ View My Enrolled Courses  
✔ Logout Session  
✔ JDBC Database Connectivity  

---

## 🗂️ Project Structure

Course-Registration-Portal/
│── src/ (Servlet classes)
│── web/ (JSP pages + HTML + CSS)
│── database/ (courseportal.sql)
│── WEB-INF/
│ ├── web.xml (Servlet Mapping)
│ └── lib/ (JDBC Connector)


---

## 🛢️ Database Setup (MySQL)

Create a database and import the SQL script:
```sql
CREATE DATABASE courseportal;
USE courseportal;

📌 Import courseportal.sql (provided inside project folder).

---

▶️ Run the Project

Install Apache Tomcat (9+)
Copy this project into webapps folder
Paste mysql-connector.jar in WEB-INF/lib
Start Tomcat
Open Browser:
      http://localhost:8080/CourseRegistrationPortal/

---

👨‍💻 Author

Perecherla Anant Varma — Java Full Stack Developer
📌 Feel free to contribute or suggest improvements!

---

⭐ If you like this project
  Give it a ⭐ on GitHub!
