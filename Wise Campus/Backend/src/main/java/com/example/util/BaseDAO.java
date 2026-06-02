package com.example.util;

import com.example.util.DruidUtils;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanHandler;
import org.apache.commons.dbutils.handlers.BeanListHandler;
import java.sql.SQLException;
import java.util.Arrays;
import java.util.List;

public class BaseDAO {
    private final QueryRunner qr = new QueryRunner(DruidUtils.getDataSource());

    public int update(String sql, Object... params) throws SQLException {
        System.out.println(">>>=====SQL:"+sql);
        System.out.println(">>>==Params:"+ Arrays.toString(params));
        return qr.update(sql, params);
    }

    public <T> T getBean(Class<T> clazz, String sql, Object... params) throws SQLException {
        System.out.println(">>>=====SQL:"+sql);
        System.out.println(">>>==Params:"+ Arrays.toString(params));
        return qr.query(sql, new BeanHandler<>(clazz), params);
    }

    public <T> List<T> getBeanList(Class<T> clazz, String sql, Object... params) throws SQLException {
        System.out.println(">>>=====SQL:"+sql);
        System.out.println(">>>==Params:"+ Arrays.toString(params));
        return qr.query(sql, new BeanListHandler<>(clazz), params);
    }
}
