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
//        String username = req.getParameter("username");
//        String password = req.getParameter("password");
//
//        User user = new User();
//        user.setUsername(username);
//        user.setPassword(password);

        try {
            //String json="{'name':'Crizzy','password':'123','role'={'rid'=1001,'name':'管理员'}}";
            //1.获取参数2.封装实体类
            User user= getParam(req,User.class);
            //3.调用业务层
            User loginUser = userService.login(user);
            //4.返回结果
            if(loginUser!=null){
                req.getSession().setAttribute("user",loginUser);
                loginUser.setPassword(null);//不返回密码到浏览器
                //返回JSON格式
                success(resp,"登录成功",loginUser);
            }else {
                error(resp,"用户名或密码错误");
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }


    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        super.doGet(req, resp);
    }
}
