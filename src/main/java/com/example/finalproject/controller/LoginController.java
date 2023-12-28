package com.example.finalproject.controller;

import com.example.finalproject.service.impl.*;
import com.example.finalproject.vo.User;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;


import java.util.Objects;


@Controller
public class LoginController {
    @Autowired
    HttpSession session;

    @Autowired
    RegisterServiceImpl registerService;
    @Autowired
    LoginServiceImpl loginService;
    @Autowired
    StudentServiceImpl studentService;
    @Autowired
    TeacherServiceImpl teacherService;

    @Autowired
    ManagerServiceImpl managerService;

    @RequestMapping("/login")
    public String login() {
        return "login/Login";
    }

    @RequestMapping("/loginCheck")
    public String loginCheck(@RequestParam("id") String id,
                             @RequestParam("password") String password,
                             Model model) {
        User user = loginService.loginCheck(id, password);
        if (Objects.equals(null, user)) {//没有查询到用户
            model.addAttribute("message", "登录失败!");
        } else {
            if (Objects.equals(null, user.getPassword())) {
                //密码为null说明还没有注册用户（有学号但是网站还没注册）
                model.addAttribute("message", "您还没有注册，请注册!");
            } else {
                model.addAttribute("message", "登录成功!");
                session.setAttribute("user", user);
                switch (user.getRole()) {
                    case "管理员": {
                        session.setAttribute("manager", managerService.findManagerByManagerId(user.getId()));
                        break;
                    }
                    case "老师": {
                        session.setAttribute("teacher", teacherService.findTeachertByTeacherId(user.getId()));
                        System.out.println(teacherService.findTeachertByTeacherId(user.getId()));
                        break;
                    }
                    case "学生": {//获取student信息，传入session
                        session.setAttribute("student", studentService.findStudentByStudentId(user.getId()));
                        break;
                    }
                }
            }
        }
        return "Middle";
    }

    @RequestMapping("/changePassword")
    public String changePassword(){
        return "login/ChangePassword";
    }

    @RequestMapping("/changePasswordCheck")
    public String changePasswordCheck(@RequestParam("id") String id,
                                      @RequestParam("password") String password,
                                      Model model) {
        registerService.updateUserPassword(id, password);
        Integer s=Integer.valueOf("8");
        Integer sss=1;
        model.addAttribute("message","修改密码成功!");
        return "Middle";
    }

    @RequestMapping("/blank")
    public String blank() {
        return "blank";
    }


}


