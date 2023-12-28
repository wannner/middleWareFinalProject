package com.example.finalproject;

import com.example.finalproject.dao.StudentDao;
import com.example.finalproject.vo.Student;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.HashOperations;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import java.util.Map;

@Component
public class ScheduledTasks {
    @Autowired
    StudentDao studentDao;

    @Autowired
    StringRedisTemplate stringRedisTemplate;
    @Autowired
    RedisTemplate redisTemplate;

    // 每隔一段时间执行一次库存同步任务


    @Scheduled(fixedDelay = 2000) // 2秒执行一次,把剩余课程的库存和学生选课信息添加到数据库
    public void syncSeckillStock() {
        //插入选课信息
        HashOperations<String, String, String> hashOps = stringRedisTemplate.opsForHash();
        Map<String, String> student = hashOps.entries("student");
        if (!student.isEmpty()) {
            for (Map.Entry<String, String> entry : student.entrySet()) {
                studentDao.addCourseSelection(Integer.parseInt(entry.getKey()), entry.getValue());
            }
            stringRedisTemplate.delete("student");//删除redis中的记录选课信息的hash
        }

        //更新课程库存
        HashOperations<String, String, String> hashOps1 = stringRedisTemplate.opsForHash();
        Map<String, String> course_Class = hashOps1.entries("course_Class");
        for (Map.Entry<String, String> entry : course_Class.entrySet()) {
            studentDao.updateMaxNumber(Integer.parseInt(entry.getKey()), Integer.parseInt(entry.getValue()));
        }
        System.out.println("更新了一次");
    }
}
