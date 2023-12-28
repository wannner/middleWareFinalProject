package com.example.finalproject.service.impl;

import com.example.finalproject.dao.StudentDao;
import com.example.finalproject.service.StudentService;
import com.example.finalproject.vo.Course_Class;
import com.example.finalproject.vo.Course_Select;
import com.example.finalproject.vo.Student;
import org.redisson.api.RBloomFilter;
import org.redisson.api.RLock;
import org.redisson.api.RedissonClient;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.HashOperations;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.data.redis.core.ValueOperations;
import org.springframework.stereotype.Service;


import java.util.List;
import java.util.concurrent.TimeUnit;

@Service
public class StudentServiceImpl implements StudentService {

    @Autowired
    RedissonClient redissonClient;

    @Autowired
    StringRedisTemplate stringRedisTemplate;
    @Autowired
    StudentDao studentDao;

    @Override
    public Student findStudentByStudentId(String id) {
        return studentDao.findStudentByStudentId(id);
    }

    @Override
    public List<Course_Class> getUnselectedCoursesByStudentId(String term, String studentId) {
        return studentDao.getUnselectedCoursesByStudentId(term, studentId);
    }

    @Override
    public int addCourseSelection(int courseClassId, String studentId) {
        // 使用Redisson获取分布式锁
        String lockKey = "lockKey";
        RLock lock=redissonClient.getLock(lockKey);
        boolean locked=false;
        try{
            // 使用布隆过滤器检查请求的有效性
            //bloomFilter用来存储恶意注入的学生id
            RBloomFilter<Object> bloomFilter = redissonClient.getBloomFilter("yourBloomFilterName");
            RBloomFilter<Object> bloomFilter1 = redissonClient.getBloomFilter("yourBloomFilterName");
            if (!bloomFilter.isExists()) {
                bloomFilter.tryInit(3000, 0.03);
            }
            boolean mightContain = bloomFilter.contains(String.valueOf(studentId));
            if (mightContain) {
                return -1;// 过滤掉已知无效的请求
            }

            //bloomFilter1验证是否重复选课
            String check=courseClassId+""+studentId;
            System.out.println(courseClassId);
            if (bloomFilter1.contains(check)) {//如果过滤器1中包含，说明学生已经选过该课程
                return 3;
            }
            bloomFilter1.add(courseClassId+""+studentId);//记录选课成功信息到过滤器


            // 尝试获取锁，最多等待10秒
            locked = lock.tryLock(10, TimeUnit.SECONDS);
            if (!locked) {
                return 0;
            }

            HashOperations<String, String, String> stringObjectObjectHashOperations = stringRedisTemplate.opsForHash();
            String s = stringObjectObjectHashOperations.get("course_Class", String.valueOf(courseClassId));
            int number;
            if (s.isEmpty()){
                bloomFilter.add(studentId);//如果缓存中没有这个课程，说明是恶意的请求，加入布隆锁，拉黑
                return -1;
            }else number=Integer.parseInt(s);
            if (number==0)return 2;//说明这个课程已经满了
            number--;

            //选课成功，更新课程库存
            stringRedisTemplate.opsForHash().put("course_Class",String.valueOf(courseClassId),String.valueOf(number));
            //把选课的信息记入缓存
            stringRedisTemplate.opsForHash().put("student",String.valueOf(courseClassId),String.valueOf(studentId));
            //把选课信息计入过滤器
            bloomFilter1.add(courseClassId+""+studentId);
            return 1;
        } catch (InterruptedException e) {
            throw new RuntimeException(e);
        }finally {
            if (lock.isHeldByCurrentThread())
            lock.unlock();
        }
    }

    @Override
    public List<Course_Select> getStudentGradeByTerm(String studentId, String term) {
        return studentDao.getStudentGradeByTerm(studentId, term);
    }
}
