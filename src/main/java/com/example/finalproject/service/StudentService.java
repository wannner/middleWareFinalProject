package com.example.finalproject.service;



import com.example.finalproject.vo.Course_Class;
import com.example.finalproject.vo.Course_Select;
import com.example.finalproject.vo.Student;

import java.util.List;

public interface StudentService {
    public Student findStudentByStudentId(String id);

    List<Course_Class> getUnselectedCoursesByStudentId(String term, String studentId);

    int addCourseSelection(int courseClassId,String studentId);

    List<Course_Select> getStudentGradeByTerm(String studentId, String term);


}
