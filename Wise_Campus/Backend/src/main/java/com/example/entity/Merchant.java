package com.example.entity;

import java.math.BigDecimal;
import java.time.LocalDateTime;

/**
 * 作者：Crizzy
 * 日期：2026/6/8
 * 功能描述：商家实体类（对应表 merchant）
 */
public class Merchant {
    private Long id;
    private String merchantNo;          // merchant_no
    private String name;
    private String logo;
    private String images;              // images（新增）
    private String intro;
    private String address;
    private String businessHours;       // business_hours，JSON 字符串
    private BigDecimal avgRating;       // avg_rating
    private Integer status;
    private Integer isDelete;           // is_delete
    private LocalDateTime gmtCreate;    // gmt_create
    private LocalDateTime gmtModified;  // gmt_modified
    private Integer monthlySales;       // monthly_sales
    private Integer deliveryTimeMinutes;// delivery_time_minutes
    private BigDecimal minOrderAmount;  // min_order_amount
    private BigDecimal avgPricePerPerson;// avg_price_per_person

    // ---------- getter / setter ----------
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getMerchantNo() {
        return merchantNo;
    }

    public void setMerchantNo(String merchantNo) {
        this.merchantNo = merchantNo;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getLogo() {
        return logo;
    }

    public void setLogo(String logo) {
        this.logo = logo;
    }

    public String getImages() {
        return images;
    }

    public void setImages(String images) {
        this.images = images;
    }

    public String getIntro() {
        return intro;
    }

    public void setIntro(String intro) {
        this.intro = intro;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getBusinessHours() {
        return businessHours;
    }

    public void setBusinessHours(String businessHours) {
        this.businessHours = businessHours;
    }

    public BigDecimal getAvgRating() {
        return avgRating;
    }

    public void setAvgRating(BigDecimal avgRating) {
        this.avgRating = avgRating;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public Integer getIsDelete() {
        return isDelete;
    }

    public void setIsDelete(Integer isDelete) {
        this.isDelete = isDelete;
    }

    public LocalDateTime getGmtCreate() {
        return gmtCreate;
    }

    public void setGmtCreate(LocalDateTime gmtCreate) {
        this.gmtCreate = gmtCreate;
    }

    public LocalDateTime getGmtModified() {
        return gmtModified;
    }

    public void setGmtModified(LocalDateTime gmtModified) {
        this.gmtModified = gmtModified;
    }

    public Integer getMonthlySales() {
        return monthlySales;
    }

    public void setMonthlySales(Integer monthlySales) {
        this.monthlySales = monthlySales;
    }

    public Integer getDeliveryTimeMinutes() {
        return deliveryTimeMinutes;
    }

    public void setDeliveryTimeMinutes(Integer deliveryTimeMinutes) {
        this.deliveryTimeMinutes = deliveryTimeMinutes;
    }

    public BigDecimal getMinOrderAmount() {
        return minOrderAmount;
    }

    public void setMinOrderAmount(BigDecimal minOrderAmount) {
        this.minOrderAmount = minOrderAmount;
    }

    public BigDecimal getAvgPricePerPerson() {
        return avgPricePerPerson;
    }

    public void setAvgPricePerPerson(BigDecimal avgPricePerPerson) {
        this.avgPricePerPerson = avgPricePerPerson;
    }
}