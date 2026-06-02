package com.example.controller;

import com.example.entity.User;
import com.example.service.UserService;
import com.example.util.BaseServlet;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

/**
 * 作者：Crizzy
 * 日期：2026/6/2
 * 功能描述：
 */
@WebServlet("/login")
public class LoginServlet extends BaseServlet {
    private UserService userService = new UserService();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getParameter("username");
        String password = req.getParameter("password");

        User user = new User();
        user.setUsername(username);
        user.setPassword(password);

        try {
            User user1= getParam(req,User.class);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }

        if(loginUser!=null){
            req.getSession().setAttribute("user",loginUser);
        }else {
            req.setAttribute("msg","用户名或密码错误");
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        super.doGet(req, resp);
    }
}
