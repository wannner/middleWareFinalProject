package com.example.finalproject.dao;

import com.example.finalproject.vo.User;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;


@Mapper
public interface LoginDao {
    @Select("SELECT * FROM USER WHERE ID = #{id} AND PASSWORD = #{password}")
    public User loginCheck(@Param("id") String id, @Param("password") String password);

}
