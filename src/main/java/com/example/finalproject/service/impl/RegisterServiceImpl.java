package com.example.finalproject.service.impl;

import com.example.finalproject.dao.RegisterDao;
import com.example.finalproject.service.RegisterService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class RegisterServiceImpl implements RegisterService {
    @Autowired
    RegisterDao registerDao;

    @Override
    public Boolean findUserById(String id) {
        return registerDao.findUserById(id);
    }

    @Override
    public Boolean updateUserPassword(String id, String password) {
        return registerDao.updateUserPassword(id, password);
    }
}
