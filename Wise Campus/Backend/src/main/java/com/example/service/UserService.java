package com.example.service;

import com.example.dao.UserDao;
import com.example.entity.User;

public class UserService {
    private UserDao userDao =new UserDao();
    public User login(User user)
    {
        User dbUser=userDao.getUserByName(user.getUsername());
        if(dbUser!=null&&dbUser.getPassword().equals(user.getPassword())){
            return dbUser;
        }
        return null;
    }
}
