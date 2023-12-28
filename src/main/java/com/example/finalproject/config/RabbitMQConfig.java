package com.example.finalproject.config;

import org.springframework.amqp.core.*;
import org.springframework.amqp.rabbit.connection.CachingConnectionFactory;
import org.springframework.amqp.rabbit.connection.ConnectionFactory;
import org.springframework.amqp.rabbit.core.RabbitTemplate;
import org.springframework.amqp.support.converter.Jackson2JsonMessageConverter;
import org.springframework.amqp.support.converter.MessageConverter;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class RabbitMQConfig {
    private String rabbitMqHost = "localhost";
    private String rabbitMqUsername = "guest";
    private String rabbitMqPassword = "guest";
    private String rabbitMqVirtualHost = "/test";
    @Bean
    public ConnectionFactory connectionFactory() {
        CachingConnectionFactory connectionFactory = new CachingConnectionFactory();
        connectionFactory.setAddresses(rabbitMqHost);
        connectionFactory.setUsername(rabbitMqUsername);
        connectionFactory.setPassword(rabbitMqPassword);
        connectionFactory.setVirtualHost(rabbitMqVirtualHost);
        return connectionFactory;
    }

    @Bean
    public RabbitTemplate rabbitTemplate(ConnectionFactory connectionFactory, MessageConverter messageConverter) {
        RabbitTemplate rabbitTemplate = new RabbitTemplate(connectionFactory);
        rabbitTemplate.setMessageConverter(messageConverter);
        return rabbitTemplate;
    }

    //新增班级信息
    @Bean("exchange")  //定义交换机Bean，可以很多个
    public Exchange exchange(){
        return new DirectExchange("exchange");
    }


    @Bean("managerClassQueue")     //定义消息队列
    public Queue managerClassQueue(){
       return new Queue("managerClassQueue");
    }

    @Bean
    public Binding managerClassBinding(@Qualifier("managerClassQueue") Queue directQueue, @Qualifier("exchange") Exchange directExchange) {
        return BindingBuilder.bind(directQueue).to(directExchange).with("managerClass").noargs();
    }


    //新增课程信息
    @Bean("managerCourseQueue")     //定义消息队列
    public Queue managerCourseQueue(){
        return new Queue("managerCourseQueue");
    }

    @Bean
    public Binding managerCoursequeueBinding(@Qualifier("managerCourseQueue") Queue directQueue, @Qualifier("exchange") Exchange directExchange) {
        return BindingBuilder.bind(directQueue).to(directExchange).with("managerCourse").noargs();
    }

    //新增教师信息
    @Bean("managerTeacherQueue")     //定义消息队列
    public Queue managerTeacherQueue(){
        return new Queue("managerTeacherQueue");
    }

    @Bean
    public Binding managerTeacherQueueBinding(@Qualifier("managerTeacherQueue") Queue directQueue, @Qualifier("exchange") Exchange directExchange) {
        return BindingBuilder.bind(directQueue).to(directExchange).with("managerTeacher").noargs();
    }

    //新增学生信息
    @Bean("managerStudentQueue")     //定义消息队列
    public Queue managerStudentQueue(){
        return new Queue("managerStudentQueue");
    }

    @Bean
    public Binding managerStudentQueueBinding(@Qualifier("managerStudentQueue") Queue directQueue, @Qualifier("exchange") Exchange directExchange) {
        return BindingBuilder.bind(directQueue).to(directExchange).with("managerStudent").noargs();
    }

    //新增开课班级
    @Bean("managerCourse_ClassQueue")     //定义消息队列
    public Queue managerCourse_ClassQueue(){
        return new Queue("managerCourse_ClassQueue");
    }

    @Bean
    public Binding managerCourse_ClassQueueBinding(@Qualifier("managerCourse_ClassQueue") Queue directQueue, @Qualifier("exchange") Exchange directExchange) {
        return BindingBuilder.bind(directQueue).to(directExchange).with("managerCourse_Class").noargs();
    }

    //录入学生成绩
    @Bean("insertQueue")     //定义消息队列
    public Queue insertQueue(){
        return new Queue("insertQueue");
    }

    @Bean
    public Binding insertQueueBinding(@Qualifier("insertQueue") Queue directQueue, @Qualifier("exchange") Exchange directExchange) {
        return BindingBuilder.bind(directQueue).to(directExchange).with("insert").noargs();
    }

    @Bean
    public MessageConverter messageConverter() {
        return new Jackson2JsonMessageConverter();
    }

}
