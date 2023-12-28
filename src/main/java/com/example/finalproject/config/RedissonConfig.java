package com.example.finalproject.config;

import org.redisson.Redisson;
import org.redisson.api.RedissonClient;
import org.redisson.config.Config;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class RedissonConfig {

    @Bean
    public RedissonClient redissonClient() {
        // 这里可以根据你的实际情况配置 Redisson 的连接信息
        Config config = new Config();
        config.useSingleServer().setAddress("redis://localhost:6379");
        // 设置 notify-keyspace-events
        return Redisson.create(config);
    }

}
