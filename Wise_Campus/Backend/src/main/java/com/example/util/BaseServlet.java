package com.example.util;


import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.lang.reflect.Field;
import java.util.Map;

public abstract class BaseServlet extends HttpServlet {
    protected static final ObjectMapper MAPPER = new ObjectMapper();

    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("application/json;charset=UTF-8");
        response.setCharacterEncoding("UTF-8");
        super.service(request, response);
    }

    protected <T> T readJson(HttpServletRequest request, Class<T> clazz) throws IOException {
        return MAPPER.readValue(request.getInputStream(), clazz);
    }
    private static final ObjectMapper OBJECT_MAPPER = new ObjectMapper();
    private static final String CONTENT_TYPE_JSON = "application/json";
    private static final String CONTENT_TYPE_FORM = "application/x-www-form-urlencoded";
    private static final String CONTENT_TYPE_FORM_DATA = "multipart/form-data";

    /**
     * 统一入口：自动根据请求头封装实体对象
     * @param request 请求对象
     * @param clazz 目标实体类
     * @return 封装好的实体对象
     */
    protected <T> T getParam(HttpServletRequest request, Class<T> clazz) throws Exception {
        String contentType = request.getContentType();

        // 1. 如果是 JSON 请求
        if (contentType != null && contentType.contains(CONTENT_TYPE_JSON)) {
            return OBJECT_MAPPER.readValue(request.getInputStream(), clazz);
        }

        // 2. 如果是 表单/普通参数
        if ((contentType != null && contentType.contains(CONTENT_TYPE_FORM))
                || contentType == null
                || contentType.contains(CONTENT_TYPE_FORM_DATA)) {
            return formToBean(request, clazz);
        }

        // 默认：尝试表单方式
        return formToBean(request, clazz);
    }

    /**
     * 自动把 request 所有参数封装成 JavaBean（反射实现）
     */
    private <T> T formToBean(HttpServletRequest request, Class<T> clazz) throws Exception {
        // 创建对象
        T bean = clazz.newInstance();

        // 获取所有参数
        Map<String, String[]> paramMap = request.getParameterMap();

        // 获取所有字段
        Field[] fields = clazz.getDeclaredFields();

        for (Field field : fields) {
            field.setAccessible(true); // 允许访问私有字段
            String fieldName = field.getName();

            if (paramMap.containsKey(fieldName)) {
                String value = paramMap.get(fieldName)[0]; // 取第一个值
                setFieldValue(bean, field, value);
            }
        }
        return bean;
    }

    /**
     * 自动类型转换：String → 字段类型
     */
    private void setFieldValue(Object bean, Field field, String value) throws IllegalAccessException {
        Class<?> type = field.getType();

        if (type == String.class) {
            field.set(bean, value);
        } else if (type == Integer.class || type == int.class) {
            field.set(bean, Integer.parseInt(value));
        } else if (type == Long.class || type == long.class) {
            field.set(bean, Long.parseLong(value));
        } else if (type == Boolean.class || type == boolean.class) {
            field.set(bean, Boolean.parseBoolean(value));
        } else if (type == Double.class || type == double.class) {
            field.set(bean, Double.parseDouble(value));
        }
        // 可继续扩展 Date 等类型
    }
    protected void writeJson(HttpServletResponse response, Object obj) throws IOException {
        MAPPER.writeValue(response.getWriter(), obj);
    }

    protected void success(HttpServletResponse response, String msg) throws IOException {
        writeJson(response, new Result(200, msg, null));
    }

    protected void success(HttpServletResponse response, String msg, Object data) throws IOException {
        writeJson(response, new Result(200, msg, data));
    }

    protected void error(HttpServletResponse response, String msg) throws IOException {
        writeJson(response, new Result(500, msg, null));
    }

    protected void unauthorized(HttpServletResponse response) throws IOException {
        writeJson(response, new Result(401, "未登录", null));
    }

    static class Result {
        private Integer code;
        private String msg;
        private Object data;

        public Result(Integer code, String msg, Object data) {
            this.code = code;
            this.msg = msg;
            this.data = data;
        }

        public Integer getCode() {return code;}
        public String getMsg() {return msg;}
        public Object getData() {return data;}
    }
}
