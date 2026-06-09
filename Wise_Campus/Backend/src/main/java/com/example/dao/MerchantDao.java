package com.example.dao;

import com.example.entity.Merchant;
import com.example.util.BaseDAO;

import java.sql.SQLException;
import java.util.List;

/**
 * 作者：Crizzy
 * 日期：2026/6/8
 * 功能描述：
 */
public class MerchantDao extends BaseDAO {
    public List<Merchant> queryAll(){
        String sql = "SELECT id, merchant_no, name, logo, images, intro, address, business_hours, avg_rating, monthly_sales, delivery_time_minutes, min_order_amount, avg_price_per_person, status, gmt_create, gmt_modified FROM merchant WHERE is_delete = 0;";
        try {
            return super.getBeanList(Merchant.class, sql);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
