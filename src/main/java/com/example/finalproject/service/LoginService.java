package com.example.finalproject.service;


import com.example.finalproject.vo.User;

public interface LoginService {
    public User loginCheck(String username, String password);

}
