package com.example.service;

import com.example.dao.MerchantDao;
import com.example.entity.Merchant;

import java.util.List;

/**
 * 作者：Crizzy
 * 日期：2026/6/8
 * 功能描述：
 */
public class MerchantService {
    private MerchantDao merchantDao =new MerchantDao();
    public List<Merchant> queryAll(){
        return merchantDao.queryAll();
    }
}
