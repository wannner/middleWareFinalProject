package com.example.finalproject.service.impl;


import com.example.finalproject.dao.CourseDao;
import com.example.finalproject.dao.ManagerDao;
import com.example.finalproject.service.ManagerService;
import com.example.finalproject.vo.*;
import org.springframework.amqp.rabbit.annotation.RabbitListener;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


import com.example.finalproject.vo.Class;

import java.math.BigDecimal;
import java.util.List;

@Service
public class ManagerServiceImpl implements ManagerService {

    @Autowired
    ManagerDao managerDao;

    @Autowired
    CourseDao courseDao;

    @RabbitListener(queues = "managerStudentQueue", messageConverter = "messageConverter", ackMode = "AUTO")
    public Boolean addStudent(List<Student> students) {

        return managerDao.addStudent(students);
    }

//    @Override
//    public Boolean addStudent(List<Student> students) {
//        return managerDao.addStudent(students);
//    }


    @RabbitListener(queues = "managerTeacherQueue", messageConverter = "messageConverter", ackMode = "AUTO")
    public Boolean addTeacher(List<Teacher> teachers) {

        return managerDao.addTeacher(teachers);
    }

//    @Override
//    public Boolean addTeacher(List<Teacher> teachers) {
//        return managerDao.addTeacher(teachers);
//    }

    @RabbitListener(queues = "managerCourseQueue", messageConverter = "messageConverter", ackMode = "AUTO")
    public boolean addCourse(List<Course> courses) {

        return managerDao.addCourse(courses);
    }


//    @Override
//    public Boolean addCourse(List<Course> courses) {
//        return managerDao.addCourse(courses);
//    }

    @RabbitListener(queues = "managerCourse_ClassQueue", messageConverter = "messageConverter", ackMode = "AUTO")
    public Boolean addCourse_Class(List<Course_Class> course_Classes) {

        return managerDao.addCourse_Class(course_Classes);
    }
//    @Override
//    public Boolean addCourse_Class(List<Course_Class> course_Classes) {
//        return managerDao.addCourse_Class(course_Classes);
//    }

//    @Override
//    public Boolean addClassCheck(List<Class> classes) {
//        return managerDao.addClassCheck(classes);
//    }


    @RabbitListener(queues = "managerClassQueue", messageConverter = "messageConverter", ackMode = "AUTO")
    public boolean addClassCheck(List<Class> classes) {

        return managerDao.addClassCheck(classes);
    }


    @Override
    public Manager findManagerByManagerId(String id) {
        return managerDao.findManagerByManagerId(id);
    }

    @Override
    public List<Class> showAllClassAndStudent() {
        return managerDao.showAllClassAndStudent();
    }

    @Override
    public List<Course> showAllCourse() {
        return managerDao.showAllCourse();
    }

    @Override
    public List<Teacher> showAllTeacher() {
        return managerDao.showAllTeacher();
    }

    @Override
    public List<Course_Class> showAllCourse_Class() {
        return managerDao.showAllCourse_Class();
    }

    @Override
    public Boolean deleteCourseByCourseId(int courseId) {
        return managerDao.deleteCourseByCourseId(courseId);
    }

    @Override
    public Boolean deleteCourse_ClassByCourse_ClassId(int course_ClassId) {
        return managerDao.deleteCourse_ClassByCourse_ClassId(course_ClassId);
    }

    @Override
    public List<Course_Class> findCourse_ClassByTerm(String term) {
        return courseDao.findCourse_ClassByTerm(term);
    }

    @Override
    public List<Course_Select> showAllStudentGradeByCourse_ClassId(int course_ClassId) {
        return courseDao.showAllStudentGradeByCourse_ClassId(course_ClassId);
    }

    @Override
    public int getStudentNuByCourse_ClassId(int course_ClassId) {
        return courseDao.getStudentNuByCourse_ClassId(course_ClassId);
    }

    @Override
    public BigDecimal getAverageGradeByCourse_ClassId(int course_ClassId) {
        return courseDao.getAverageGradeByCourse_ClassId(course_ClassId);
    }

    @Override
    public int getFailedStudentsCountByCourse_ClassId(int course_ClassId) {
        return courseDao.getFailedStudentsCountByCourse_ClassId(course_ClassId);
    }

    @Override
    public List<Course_Select> showFailedStudentGradeByCourseName(int course_ClassId) {
        return courseDao.showFailedStudentGradeByCourseName(course_ClassId);
    }

    @Override
    public List<Class> getAllClass() {
        return managerDao.getAllClass();
    }

    @Override
    public List<String> getCoursenameByTerm(String term) {
        return managerDao.getCoursenameByTerm(term);
    }

    @Override
    public List<Course_Select> getStudentsWithGradeLessThan60(String term, String coursename) {
        return managerDao.getStudentsWithGradeLessThan60(term, coursename);
    }


}
