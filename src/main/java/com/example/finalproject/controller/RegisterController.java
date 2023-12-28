package com.example.finalproject.controller;

import com.example.finalproject.service.impl.RegisterServiceImpl;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;


@Controller
public class RegisterController {

    @Autowired
    HttpSession session;
    @Autowired
    RegisterServiceImpl registerService;

    @RequestMapping("/register")
    public String register() {
        return "register/Register";
    }
    @RequestMapping("/registerCheck")
    public String registerCheck(@RequestParam("id") String id,
                                @RequestParam("password") String password,
                                HttpSession session,
                                Model model) {
        if (registerService.findUserById(id)==null) {//系统不存在这个学号
            model.addAttribute("message","您的学号不存在，请联系辅导员!");
        }
        else{
            registerService.updateUserPassword(id, password);
            model.addAttribute("message","注册成功!");
        }
        return "Middle";
    }


}
