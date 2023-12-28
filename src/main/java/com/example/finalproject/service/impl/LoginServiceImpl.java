package com.example.finalproject.service.impl;

import com.example.finalproject.dao.LoginDao;
import com.example.finalproject.service.LoginService;
import com.example.finalproject.vo.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class LoginServiceImpl implements LoginService {
    @Autowired
    LoginDao loginDao;

    @Override
    public User loginCheck(String id, String password) {
        return loginDao.loginCheck(id, password);
    }

}
