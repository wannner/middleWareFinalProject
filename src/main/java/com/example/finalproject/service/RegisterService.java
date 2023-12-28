package com.example.finalproject.service;

public interface RegisterService {
    public Boolean findUserById(String id);

    public Boolean updateUserPassword(String id, String password);

}
