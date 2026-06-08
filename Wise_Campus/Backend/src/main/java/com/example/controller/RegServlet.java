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
 * 功能描述：用户注册（重名校验）
 */
@WebServlet("/reg")
public class RegServlet extends BaseServlet {
    private UserService userService = new UserService();
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        //1.获取参数，封装成实体类
        try {
            User user = getParam(req, User.class);
            //2.调用业务层
            userService.add(user);
            success(resp, "注册成功");
        } catch (Exception e) {
            error(resp,e.getMessage());
        }

    }
}
