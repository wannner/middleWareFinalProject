package com.example.finalproject.controller;

import com.example.finalproject.service.impl.ManagerServiceImpl;
import com.example.finalproject.vo.*;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.apache.ibatis.annotations.Param;
import org.springframework.amqp.rabbit.core.RabbitTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.finalproject.vo.Class;
import java.math.BigDecimal;
import java.util.List;

@Controller
public class ManagerController {
    @Autowired
    RabbitTemplate rabbitTemplate;

    @Autowired
    HttpServletResponse response;

    @Autowired
    HttpSession session;
    @Autowired
    ManagerServiceImpl managerService;

    @RequestMapping("/managerSpace")
    public String managerSpace() {
        return "manager/ManagerSpace";
    }

    @RequestMapping("/manager/addStudent")//增加学生页面
    public String addStudent(Model model) {
        List<Class> classes = managerService.getAllClass();
        model.addAttribute("class", classes);
        return "manager/AddStudent";
    }

    @PostMapping(value = "/manager/addStudentCheck", consumes = "application/json")
    public void addStudentCheck(@RequestBody List<Student> students, HttpServletResponse response) {
        rabbitTemplate.convertAndSend("exchange","managerStudent",students);
    }


    @RequestMapping("/manager/addTeacher")//增加老师
    public String addTeacher() {
        return "manager/AddTeacher";
    }

    @PostMapping(value = "/manager/addTeacherCheck", consumes = "application/json")
    public void addTeacherCheck(@RequestBody List<Teacher> teachers, HttpServletResponse response) {
        teachers.remove(0);
        rabbitTemplate.convertAndSend("exchange","managerTeacher",teachers);
    }

    @RequestMapping("/manager/addCourse")//增加课程
    public String addCourse() {
        return "manager/AddCourse";
    }

    @PostMapping(value = "/manager/addCourseCheck", consumes = "application/json")
    public void addCourseCheck(@RequestBody List<Course> courses, HttpServletResponse response) {
        courses.remove(0);
        rabbitTemplate.convertAndSend("exchange","managerCourse",courses);
    }

    @RequestMapping("/manager/addClass")//增加班级
    public String addClass() {
        return "manager/AddClass";
    }

    @PostMapping(value = "/manager/addClassCheck", consumes = "application/json")
    public void addClassCheck(@RequestBody List<Class> classes,
                              HttpServletResponse response) {
        classes.remove(0);
//        managerService.addClassCheck(classes);
        rabbitTemplate.convertAndSend("exchange","managerClass",classes);

    }


    @RequestMapping("/manager/addCourse_Class")//增加开课班级
    public String addCourse_Class(Model model) {
        List<Course> courses = managerService.showAllCourse();
        List<Teacher> teachers = managerService.showAllTeacher();
        model.addAttribute("course", courses);
        model.addAttribute("teacher", teachers);
        return "manager/AddCourse_Class";
    }

    @PostMapping(value = "/manager/addCourse_ClassCheck")
    public void addCourse_ClassCheck(@RequestBody List<Course_Class> course_Classes, HttpServletResponse response) {
        rabbitTemplate.convertAndSend("exchange","managerCourse_Class",course_Classes);

    }

    @RequestMapping("manager/showAllClassAndStudent")
    public String showAllClassAndStudent(Model model) {
        List<Class> classes = managerService.showAllClassAndStudent();
        model.addAttribute("class", classes);
        return "manager/ShowAllClassAndStudent";
    }

    @RequestMapping("manager/showAllCourse")
    public String showAllCourse(Model model) {
        List<Course> courses = managerService.showAllCourse();
        model.addAttribute("course", courses);
        return "manager/ShowAllCourse";
    }

    @RequestMapping("manager/showAllTeacher")
    public String showAllTeacher(Model model) {
        List<Teacher> teachers = managerService.showAllTeacher();
        model.addAttribute("teacher", teachers);
        return "manager/ShowAllTeacher";
    }

    @RequestMapping("manager/showAllCourse_Class")
    public String showAllCourse_Class(Model model) {
        List<Course_Class> courseClasses = managerService.showAllCourse_Class();
        model.addAttribute("course_Class", courseClasses);
        return "manager/ShowAllCourse_Class";
    }

    @RequestMapping("/manager/deleteCourseByCourseId")
    public String deleteCourseByCourseId(@RequestParam("courseId") int courseId, Model model) {
        managerService.deleteCourseByCourseId(courseId);
        return "redirect:/manager/showAllCourse";

    }

    @RequestMapping("/manager/deleteCourse_ClassByCourse_ClassId")
    public String deleteCourse_ClassByCourse_ClassId(
            @RequestParam("course_ClassId") int course_ClassId,
            Model model) {
        managerService.deleteCourse_ClassByCourse_ClassId(course_ClassId);
        model.addAttribute("message", "删除开课班级成功!");
        return "redirect:/manager/showAllCourse_Class";
    }

    @RequestMapping("/manager/generateGradeReport")//在报表的页面选择学期，展示所有的课程
    public String generateGradeReportSelect(@Param("term") String term, Model model, HttpSession session) {
        if (term != null) {
            List<Course_Class> courseClassByTerm = managerService.findCourse_ClassByTerm(term);
            model.addAttribute("course_Class", courseClassByTerm);
            model.addAttribute("term",term);
            System.out.println(courseClassByTerm);
        }
        return "manager/GenerateGradeReport";
    }

    @RequestMapping("/manager/generateGradeReport/showAllStudentGradeByCourse_ClassId")
//报表页面，选择课程，展示所有的学生成绩信息，总人数，不及格人数，平均分
    public String showAllStudentGradeByCourse_ClassId(
            @RequestParam("course_ClassId") int course_ClassId,
            Model model) {
        //获取这个班级的所有学生信息
        List<Course_Select> studentSelect = managerService.showAllStudentGradeByCourse_ClassId(course_ClassId);
        //获取这个班级学生的人数
        int studentNu = managerService.getStudentNuByCourse_ClassId(course_ClassId);
        //获取这个班的平均分
        BigDecimal averageGrade = managerService.getAverageGradeByCourse_ClassId(course_ClassId);
        //获取不及格人数
        int failedStudentsCount = managerService.getFailedStudentsCountByCourse_ClassId(course_ClassId);
        model.addAttribute("studentSelect", studentSelect);
        model.addAttribute("studentNu", studentNu);
        model.addAttribute("averageGrade", averageGrade);
        model.addAttribute("failedStudentsCount", failedStudentsCount);
        return "manager/ShowAllStudentGrade";
    }

    @RequestMapping("/manager/generateGradeReport1")//在报表的页面选择学期，展示所有的课程
    public String generateGradeReportSelect1(@Param("term") String term, Model model, HttpSession session) {
        if (term != null) {
            List<String> courseName = managerService.getCoursenameByTerm(term);
            model.addAttribute("courseName",courseName);
            model.addAttribute("term",term);
        }
        return "manager/GenerateGradeReport1";
    }

    @RequestMapping("/manager/generateGradeReport1/showFailedStudentGradeByCourseName")
    public String showFailedStudentGradeByCourse_ClassId(
            @Param("courseName") String courseName,
            @Param("term") String term,
            Model model) {
        List<Course_Select> studentsWithGradeLessThan60 = managerService.getStudentsWithGradeLessThan60(term, courseName);
        System.out.println(term);
        System.out.println(courseName);
        System.out.println(studentsWithGradeLessThan60);
        model.addAttribute("student",studentsWithGradeLessThan60);
        return "manager/ShowFailedStudentGrade";
    }

}
