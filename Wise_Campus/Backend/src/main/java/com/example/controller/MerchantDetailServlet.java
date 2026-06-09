package com.example.controller;

import com.example.entity.Merchant;
import com.example.service.MerchantService;
import com.example.util.BaseServlet;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

/**
 * 作者：Crizzy
 * 日期：2026/6/8
 * 功能描述：
 */
@WebServlet("/merchant")
public class MerchantDetailServlet extends BaseServlet {
    private MerchantService merchantService = new MerchantService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Merchant> merchants = merchantService.queryAll();
        success(resp, "查询成功", merchants);

    }
}
