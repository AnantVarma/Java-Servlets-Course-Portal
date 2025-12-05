<img width="1645" height="887" alt="image" src="https://github.com/user-attachments/assets/25451671-1335-4d72-8b07-d44c3778736f" /># 🎓 Course Registration Portal | Java Servlets + JSP + JDBC

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

##▶️ Run the Project

Install Apache Tomcat (9+)
Copy this project into webapps folder
Paste mysql-connector.jar in WEB-INF/lib
Start Tomcat
Open Browser:
      http://localhost:8080/CourseRegistrationPortal/

---

📸 Screenshots!
![pro1](https://github.com/user-attachments/assets/3b5264d2-f8b5-44d6-83df-e1f077932c2d)
![pro2](https://github.com/user-attachments/assets/8d32a1ef-29fd-44b3-925a-0ba954d6ef4f)

[pro3](https://github.com/user-attachments/assets/9209d21c-4208-489a-a3e3-c23b86110659)


##👨‍💻 Author

Perecherla Anant Varma — Java Full Stack Developer
📌 Feel free to contribute or suggest improvements!

⭐ If you like this project
  Give it a ⭐ on GitHub!
