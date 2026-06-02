package com.example;

import com.example.dao.UserDao;
import com.example.entity.User;
import com.example.util.BaseDAO;

import java.sql.SQLException;
import java.util.Date;

public class TestDB {
    public static void main(String[] args) throws SQLException {
//        BaseDAO baseDAO = new BaseDAO();
//        String sql = "select username,password,email from usertbl where username=?";
//        User user = baseDAO.getBean(User.class, sql, "admin");
////        System.out.println("查询结果: " + user);  // 调试输出
////        if (user == null) {
////            System.out.println("未查询到用户，请检查数据库中的数据或查询条件");
////            return;
////        }
////        String password = user.getPassword();
//        System.out.println(user.getPassword()+"===="+user.getEmail());

        UserDao userDao = new UserDao();
        User user = new User();
        user.setUsername("crizzy");
        user.setPassword("123456");
        user.setEmail("jfwno@qq.com");
        user.setRegDate(new Date());

        userDao.add(user);


        User user1 = userDao.getUserByName("crizzy");

    }
}
