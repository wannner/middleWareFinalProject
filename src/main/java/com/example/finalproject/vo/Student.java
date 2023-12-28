package com.example.finalproject.vo;

public class Student {
    private String studentId;
    private String studentName;

    private Integer admission_year;

    private String className;

    @Override
    public String toString() {
        return "Student{" +
                "studentId='" + studentId + '\'' +
                ", studentName='" + studentName + '\'' +
                ", admission_year=" + admission_year +
                ", className='" + className + '\'' +
                '}';
    }

    public String getStudentId() {
        return studentId;
    }

    public void setStudentId(String studentId) {
        this.studentId = studentId;
    }

    public String getStudentName() {
        return studentName;
    }

    public void setStudentName(String studentName) {
        this.studentName = studentName;
    }

    public Integer getAdmission_year() {
        return admission_year;
    }

    public void setAdmission_year(Integer admission_year) {
        this.admission_year = admission_year;
    }

    public String getClassName() {
        return className;
    }

    public void setClassName(String className) {
        this.className = className;
    }

    public Student() {
    }

    public Student(String studentId, String studentName, Integer admission_year, String className) {
        this.studentId = studentId;
        this.studentName = studentName;
        this.admission_year = admission_year;
        this.className = className;
    }
}
