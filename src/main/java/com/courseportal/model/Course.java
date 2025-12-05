package com.courseportal.model;

public class Course {
    private int id;
    private String title;
    private String description;
    private String category;
    private int instructorId;
    private double price;
    private int duration;
    private String createdAt;
    private String instructorName;
    
    

    private boolean enrolled;
    private int progress;

   
    // Constructors, Getters and Setters
    public Course() {}
    
    public Course(String title, String description, String category, int instructorId, double price, int duration) {
        this.title = title;
        this.description = description;
        this.category = category;
        this.instructorId = instructorId;
        this.price = price;
        this.duration = duration;
    }
    public boolean isEnrolled() {
        return enrolled;
    }

    public void setEnrolled(boolean enrolled) {
        this.enrolled = enrolled;
    }

    public int getProgress() {
        return progress;
    }

    public void setProgress(int progress) {
        this.progress = progress;
    }
    
    // Getters and Setters for all fields
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    
    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }
    
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    
    public String getCategory() { return category; }
    public void setCategory(String category) { this.category = category; }
    
    public int getInstructorId() { return instructorId; }
    public void setInstructorId(int instructorId) { this.instructorId = instructorId; }
    
    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }
    
    public int getDuration() { return duration; }
    public void setDuration(int duration) { this.duration = duration; }
    
    public String getCreatedAt() { return createdAt; }
    public void setCreatedAt(String createdAt) { this.createdAt = createdAt; }
    
    public String getInstructorName() { return instructorName; }
    public void setInstructorName(String instructorName) { this.instructorName = instructorName; }
}