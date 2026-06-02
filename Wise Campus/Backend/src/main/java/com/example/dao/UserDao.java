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
        String sql = "insert into usertbl (username,password,email,regDate) values(?,?,?,?)";
        try {
            //获取参数
            Object[] params = {user.getUsername(), user.getPassword(), user.getEmail(), user.getRegDate()};
            super.update(sql, params);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public User getUserByName(String name) {
        String sql = "select username,password,email,regDate from usertbl where username=?";
        try {
            User user = super.getBean(User.class, sql, name);
            return user;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
