package com.example.filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Tomcat 10+ 专用 CORS 跨域过滤器
 * 解决 Vue 访问后端接口跨域问题
 */
@WebFilter("/*")
public class CorsFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // 初始化
        System.out.println("***********跨域过滤器************");
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletResponse resp = (HttpServletResponse) response;
        HttpServletRequest req = (HttpServletRequest) request;

        // 允许所有域名（开发环境）注意：这里的url是前端的，不是后端的
        resp.setHeader("Access-Control-Allow-Origin", "http://127.0.0.1:8848");
        // 关键：允许携带 Cookie
        resp.setHeader("Access-Control-Allow-Credentials", "true");

        // 允许的请求头
        resp.setHeader("Access-Control-Allow-Headers",
                "Origin, X-Requested-With, Content-Type, Accept, Authorization, token");

        // 允许的请求方法
        resp.setHeader("Access-Control-Allow-Methods",
                "GET, POST, PUT, DELETE, OPTIONS, HEAD");

        // 预检缓存 1 小时
        resp.setHeader("Access-Control-Max-Age", "3600");


        // OPTIONS 预检请求直接返回成功
        if ("OPTIONS".equalsIgnoreCase(req.getMethod())) {
            resp.setStatus(HttpServletResponse.SC_OK);
            return;
        }

        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {
    }
}