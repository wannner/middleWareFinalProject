package com.example.finalproject;

import com.example.finalproject.dao.StudentDao;
import com.example.finalproject.vo.Course_Class;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.ApplicationArguments;
import org.springframework.boot.ApplicationRunner;
import org.springframework.data.redis.core.HashOperations;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.stereotype.Component;

import java.util.List;

@Component
public class DataInitializer implements ApplicationRunner {
    @Autowired
    private StudentDao studentDao;

    @Autowired
    private StringRedisTemplate stringRedisTemplate;


    @Override
    public void run(ApplicationArguments args) throws JsonProcessingException {
        initProductData();

    }

    private void initProductData() throws JsonProcessingException {
        /**
         * 获取
         * @return orderId
         */

        // 在存储之前清理 Redis 集合
        stringRedisTemplate.getConnectionFactory().getConnection().flushAll();


        // 从 MySQL 获取选课信息
        List<Course_Class> courseClasses = studentDao.getAllCourseClass();

        // 存储到 Redis
        for (Course_Class courseClass : courseClasses) {
            String key="course_Class";
            HashOperations<String, String, String> stringObjectObjectHashOperations = stringRedisTemplate.opsForHash();
            stringObjectObjectHashOperations.put(key, courseClass.getCourse_ClassID().toString(), courseClass.getMax_number().toString());
        }

    }
}
