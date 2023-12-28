package com.example.finalproject.controller;

import com.example.finalproject.service.impl.TeacherServiceImpl;
import com.example.finalproject.vo.Course_Class;
import com.example.finalproject.vo.Course_Select;
import com.example.finalproject.vo.User;
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


import java.util.List;

@Controller
public class TeacherController {
    @Autowired
    RabbitTemplate rabbitTemplate;

    @Autowired
    HttpServletResponse response;
    @Autowired
    HttpSession session;

    @Autowired
    TeacherServiceImpl teacherService;

    @RequestMapping("/teacherSpace")
    public String managerSpace() {
        return "teacher/TeacherSpace";
    }

    @RequestMapping("/teacher/showAllCourse")
    public String showAllCourse(
            @Param("term") String term,
            Model model,
            HttpSession session) {
        User user = (User) session.getAttribute("user");
        List<Course_Class> course_classes = teacherService.findTeacherCourse_ClassByTerm(user.getId(), term);
        model.addAttribute("course", course_classes);
        model.addAttribute("term", term);
        return"/teacher/ShowAllCourse";
    }

    @RequestMapping("/teacher/showAllCourse_Grade")
    public String showAllCourse_Grade(
            @Param("term") String term,
            Model model,
            HttpSession session) {
        User user = (User) session.getAttribute("user");
        List<Course_Class> course_classes = teacherService.findTeacherCourse_ClassByTerm(user.getId(), term);
        model.addAttribute("course", course_classes);
        model.addAttribute("term", term);
        return"/teacher/ShowAllCourse_Grade";
    }



    @RequestMapping("/teacher/updateStudentGrade")
    public String updateStudentGrade(
            @Param("course_ClassId") Integer course_ClassId,
            HttpSession session,
            Model model
            ){
        session.setAttribute("course_ClassId",course_ClassId);
        List<Course_Select> studentsWithNullGrade = teacherService.getStudentsWithNullGrade(course_ClassId);
        model.addAttribute("course",studentsWithNullGrade);
        return "teacher/UpdateStudentGrade";

    }


    @PostMapping(value = "/teacher/updateStudentGradeCheck")
    public void updateStudentGrade(
            @RequestBody List<Course_Select> course_selects,
            HttpSession session,
            HttpServletResponse response) {
        int courseClassId = (int) session.getAttribute("course_ClassId");
        for (Course_Select courseSelect : course_selects) {
            courseSelect.setCourse_ClassId(courseClassId);
            rabbitTemplate.convertAndSend("exchange","insert",courseSelect);
        }
    }


}
