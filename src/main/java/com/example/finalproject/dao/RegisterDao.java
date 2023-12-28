package com.example.finalproject.dao;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

@Mapper
public interface RegisterDao {

    @Select("SELECT * FROM USER WHERE ID = #{id}")
    public Boolean findUserById(@Param("id") String id);

    @Update("UPDATE USER SET password=#{password} WHERE ID=#{id}")
    public Boolean updateUserPassword(@Param("id") String id,@Param("password") String password);
}
