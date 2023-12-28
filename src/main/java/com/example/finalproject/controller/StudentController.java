package com.example.finalproject.controller;

import com.example.finalproject.service.impl.StudentServiceImpl;
import com.example.finalproject.vo.Course_Class;
import com.example.finalproject.vo.Course_Select;
import com.example.finalproject.vo.User;
import jakarta.servlet.http.HttpSession;
import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;


import java.util.List;

@Controller
public class StudentController {

    @Autowired
    HttpSession session;
    @Autowired
    StudentServiceImpl studentService;

    @RequestMapping("/studentSpace")
    public String studentSpace() {
        return "student/StudentSpace";
    }

    @RequestMapping("/student/studentSelect")
    public String studentSelect(
            @Param("term") String term,
            Model model,
            HttpSession session) {
        if (term != null) {
            User user = (User) session.getAttribute("user");
            String id = user.getId();
            List<Course_Class> courseClasses = studentService.getUnselectedCoursesByStudentId(term, id);
            model.addAttribute("course_Class", courseClasses);
            model.addAttribute("term", term);
        }
        return "student/StudentSelect";
    }

    @RequestMapping(value = "/student/studentSelectCheck", produces = "text/plain;charset=UTF-8")
    @ResponseBody
    public String studentSelectCheck(
            @Param("course_ClassId") int course_ClassId,
            HttpSession session) {
        User user = (User) session.getAttribute("user");
        String id = user.getId();
        int b=studentService.addCourseSelection(course_ClassId, id);
        switch (b) {
            case -1:return "恶意的请求，你的账号已被拉黑!";
            case 0:return "系统繁忙，请稍后再试";//获取redission锁失败，无法选课
            case 1:return "选课成功!";
            case 2:return "选课失败，该课程已满!";
            case 3:return "选课失败，请勿重复选课!";
        }
        return "error";
    }

    @RequestMapping("/student/showGrade")
    public String studentShowGrade(
            @Param("term") String term,
            Model model,
            HttpSession session) {
        if (term != null) {
            User user = (User) session.getAttribute("user");
            String id = user.getId();
            List<Course_Select> course_selects = studentService.getStudentGradeByTerm(id, term);
            model.addAttribute("course_Select", course_selects);
            model.addAttribute("term", term);
        }
        return "student/ShowGrade";
    }
}
