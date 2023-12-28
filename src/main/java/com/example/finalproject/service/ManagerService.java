package com.example.finalproject.service;

import com.example.finalproject.vo.*;

import com.example.finalproject.vo.Class;
import java.math.BigDecimal;
import java.util.List;

public interface ManagerService {

    public Manager findManagerByManagerId(String id);

    public List<Class> showAllClassAndStudent();

    public List<Course> showAllCourse();

    public List<Teacher> showAllTeacher();

    public List<Course_Class> showAllCourse_Class();

    public Boolean deleteCourseByCourseId(int courseId);

    public Boolean deleteCourse_ClassByCourse_ClassId(int course_ClassId);

    public List<Course_Class> findCourse_ClassByTerm(String term);

    public List<Course_Select> showAllStudentGradeByCourse_ClassId(int course_ClassId);

    public int getStudentNuByCourse_ClassId(int course_ClassId);

    public BigDecimal getAverageGradeByCourse_ClassId(int course_ClassId);

    public int getFailedStudentsCountByCourse_ClassId(int course_ClassId);

    public List<Course_Select> showFailedStudentGradeByCourseName(int course_ClassId);

    public List<Class> getAllClass();

    List<String> getCoursenameByTerm(String term);

    List<Course_Select> getStudentsWithGradeLessThan60(String term,String coursename);


}
