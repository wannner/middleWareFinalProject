package com.example.finalproject.service.impl;

import com.example.finalproject.dao.TeacherDao;
import com.example.finalproject.service.TeacherService;
import com.example.finalproject.vo.Course;
import com.example.finalproject.vo.Course_Class;
import com.example.finalproject.vo.Course_Select;
import com.example.finalproject.vo.Teacher;
import org.springframework.amqp.rabbit.annotation.RabbitListener;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


import java.math.BigDecimal;
import java.util.List;

@Service
public class TeacherServiceImpl implements TeacherService {

    @Autowired
    TeacherDao teacherDao;

    @Override
    public Teacher findTeachertByTeacherId(String id) {
        return teacherDao.findTeacherByTeacherId(id);
    }

    @Override
    public List<Course_Class> findTeacherCourse_ClassByTerm(String teacherId, String term) {
        return teacherDao.findTeacherCourse_ClassByTerm(teacherId, term);
    }

    @Override
    public List<Course_Select> getStudentsWithNullGrade(int course_ClassId) {
        return teacherDao.getStudentsWithNullGrade(course_ClassId);
    }

    @RabbitListener(queues = "insertQueue", messageConverter = "messageConverter", ackMode = "AUTO")
    public Boolean updateGradeByStudentIdAndCourse_ClassId(Course_Select courseSelect) {
        BigDecimal grade=courseSelect.getGrade();
        String studentId=courseSelect.getStudentId();
        int course_ClassId=courseSelect.getCourse_ClassId();
        return teacherDao.updateGradeByStudentIdAndCourse_ClassId(grade, studentId, course_ClassId);
    }

//    @Override
//    public Boolean updateGradeByStudentIdAndCourse_ClassId(Course_Select courseSelect) {
//        BigDecimal grade=courseSelect.getGrade();
//        String studentId=courseSelect.getStudentId();
//        int course_ClassId=courseSelect.getCourse_ClassId();
//        teacherService.updateGradeByStudentIdAndCourse_ClassId(courseSelect.getGrade(), courseSelect.getStudentId(), courseClassId);
//        return teacherDao.updateGradeByStudentIdAndCourse_ClassId(grade, studentId, course_ClassId);
//    }


}
