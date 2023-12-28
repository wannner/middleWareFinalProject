package com.example.finalproject.vo;

public class Course_Class {
    private Integer course_ClassID;

    private String course_ClassName;

    private Integer courseId;

    private String statue;

    private String term;

    private String teacherId;
    private String teacherName;

    private Integer max_number;


    public Course_Class() {
    }

    public Course_Class(Integer course_ClassID, String course_ClassName, Integer courseId, String statue, String term, String teacherId, String teacherName, Integer max_number) {
        this.course_ClassID = course_ClassID;
        this.course_ClassName = course_ClassName;
        this.courseId = courseId;
        this.statue = statue;
        this.term = term;
        this.teacherId = teacherId;
        this.teacherName = teacherName;
        this.max_number = max_number;
    }

    /**
     * 获取
     * @return course_ClassID
     */
    public Integer getCourse_ClassID() {
        return course_ClassID;
    }

    /**
     * 设置
     * @param course_ClassID
     */
    public void setCourse_ClassID(Integer course_ClassID) {
        this.course_ClassID = course_ClassID;
    }

    /**
     * 获取
     * @return course_ClassName
     */
    public String getCourse_ClassName() {
        return course_ClassName;
    }

    /**
     * 设置
     * @param course_ClassName
     */
    public void setCourse_ClassName(String course_ClassName) {
        this.course_ClassName = course_ClassName;
    }

    /**
     * 获取
     * @return courseId
     */
    public Integer getCourseId() {
        return courseId;
    }

    /**
     * 设置
     * @param courseId
     */
    public void setCourseId(Integer courseId) {
        this.courseId = courseId;
    }

    /**
     * 获取
     * @return statue
     */
    public String getStatue() {
        return statue;
    }

    /**
     * 设置
     * @param statue
     */
    public void setStatue(String statue) {
        this.statue = statue;
    }

    /**
     * 获取
     * @return term
     */
    public String getTerm() {
        return term;
    }

    /**
     * 设置
     * @param term
     */
    public void setTerm(String term) {
        this.term = term;
    }

    /**
     * 获取
     * @return teacherId
     */
    public String getTeacherId() {
        return teacherId;
    }

    /**
     * 设置
     * @param teacherId
     */
    public void setTeacherId(String teacherId) {
        this.teacherId = teacherId;
    }

    /**
     * 获取
     * @return teacherName
     */
    public String getTeacherName() {
        return teacherName;
    }

    /**
     * 设置
     * @param teacherName
     */
    public void setTeacherName(String teacherName) {
        this.teacherName = teacherName;
    }

    /**
     * 获取
     * @return max_number
     */
    public Integer getMax_number() {
        return max_number;
    }

    /**
     * 设置
     * @param max_number
     */
    public void setMax_number(Integer max_number) {
        this.max_number = max_number;
    }

    public String toString() {
        return "Course_Class{course_ClassID = " + course_ClassID + ", course_ClassName = " + course_ClassName + ", courseId = " + courseId + ", statue = " + statue + ", term = " + term + ", teacherId = " + teacherId + ", teacherName = " + teacherName + ", max_number = " + max_number + "}";
    }
}
