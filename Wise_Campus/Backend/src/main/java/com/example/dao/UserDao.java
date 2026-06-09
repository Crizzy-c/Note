package com.example.dao;

import com.example.entity.User;
import com.example.util.BaseDAO;

import java.sql.SQLException;

public class UserDao extends BaseDAO {
    /**
     * 添加用户
     *
     * @param user
     */
    public void add(User user) {
        String sql = "insert into user (user_no,name,phone,password,avatar) values(?,?,?,?,?)";
        try {
            //获取参数
            Object[] params = {user.getUserNo(),user.getName(), user.getPhone(), user.getPassword(), user.getAvatar()};
            super.update(sql, params);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public User getUserByName(String name){
        System.out.println(">>>>>>>username:"+name);
        String sql = "select id,user_no,name,phone,password,avatar from user where name=?";
            try {
                User user = super.getBean(User.class, sql, name);
                return user;
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
    }
    public User getUserById(Long id) {
        String sql = "select id,user_no,name,phone,password,avatar from user where id=?";
        try {
            User user = super.getBean(User.class, sql, id);
            return user;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public User getUserByUserNo(String userNo) {
        String sql = "select id,user_no,name,phone,password,avatar from user where user_no=?";
        try {
            User user = super.getBean(User.class, sql, userNo);
            return user;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
