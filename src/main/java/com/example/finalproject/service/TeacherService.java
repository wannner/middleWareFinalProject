package com.example.finalproject.service;

import com.example.finalproject.vo.Course_Class;
import com.example.finalproject.vo.Course_Select;
import com.example.finalproject.vo.Teacher;
import org.springframework.stereotype.Service;


import java.math.BigDecimal;
import java.util.List;

@Service
public interface TeacherService {

    public Teacher findTeachertByTeacherId(String id);

    public List<Course_Class> findTeacherCourse_ClassByTerm(String teacherId, String term);

    List<Course_Select> getStudentsWithNullGrade(int course_ClassId);


}
