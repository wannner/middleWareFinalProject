package com.example.finalproject.vo;

import java.math.BigDecimal;

public class Course_Select {
    int course_SelectId;

    int course_ClassId;

    BigDecimal grade;

    String studentId;

    String courseName;

    Student student;

    @Override
    public String toString() {
        return "Course_Select{" +
                "course_SelectId=" + course_SelectId +
                ", course_ClassId=" + course_ClassId +
                ", grade=" + grade +
                ", studentId='" + studentId + '\'' +
                ", courseName='" + courseName + '\'' +
                ", student=" + student +
                '}';
    }

    public String getCourseName() {
        return courseName;
    }

    public void setCourseName(String courseName) {
        this.courseName = courseName;
    }

    public Course_Select(int course_SelectId, int course_ClassId, BigDecimal grade, String studentId, String courseName, Student student) {
        this.course_SelectId = course_SelectId;
        this.course_ClassId = course_ClassId;
        this.grade = grade;
        this.studentId = studentId;
        this.courseName = courseName;
        this.student = student;
    }

    public Student getStudent() {
        return student;
    }

    public void setStudent(Student student) {
        this.student = student;
    }

    public int getCourse_SelectId() {
        return course_SelectId;
    }

    public void setCourse_SelectId(int course_SelectId) {
        this.course_SelectId = course_SelectId;
    }

    public int getCourse_ClassId() {
        return course_ClassId;
    }

    public void setCourse_ClassId(int course_ClassId) {
        this.course_ClassId = course_ClassId;
    }

    public BigDecimal getGrade() {
        return grade;
    }

    public void setGrade(BigDecimal grade) {
        this.grade = grade;
    }

    public String getStudentId() {
        return studentId;
    }

    public void setStudentId(String studentId) {
        this.studentId = studentId;
    }

    public Course_Select() {
    }

}
