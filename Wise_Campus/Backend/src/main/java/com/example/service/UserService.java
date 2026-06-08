package com.example.service;

import com.example.dao.UserDao;
import com.example.entity.User;

import java.time.LocalDateTime;

public class UserService {
    private UserDao userDao =new UserDao();
    public User login(User user)
    {
        User dbUser=userDao.getUserByUserNo(user.getUserNo());
        if(dbUser!=null&&dbUser.getPassword().equals(user.getPassword())){
            return dbUser;
        }
        return null;
    }


    public void add(User user)
    {
        //检查是否重学号
        User dbUser = userDao.getUserByUserNo(user.getUserNo());
        if(dbUser!=null)
        {
            throw new RuntimeException("用户已存在！请检查你的学号输入是否正确，如遇问题可寻学校管理员！");
        }
        //id在数据库中自增，所以不用设置id
        user.setStatus(1);
        user.setIsDelete(0);
        user.setGmtCreate(LocalDateTime.now());
        user.setGmtModified(LocalDateTime.now());
        userDao.add(user);

    }
}
