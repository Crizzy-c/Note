package com.example.service;

import com.example.dao.CanteenDao;

import java.util.List;

/**
 * 作者：Crizzy
 * 日期：2026/6/8
 * 功能描述：
 */
public class MerchantService {
    private CanteenDao canteenDao=new CanteenDao();
    public List<Canteen> queryAll(){
        return canteenDao.queryAll();
    }
}
