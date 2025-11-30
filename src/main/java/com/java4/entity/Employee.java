package com.java4.entity;

public class Employee {
    private String manv;
    private String hoTen;
    private boolean gioiTinh;
    private double luong;

    public Employee() {
    }

    public Employee(String manv, String hoTen, boolean gioiTinh, double luong) {
        this.manv = manv;
        this.hoTen = hoTen;
        this.gioiTinh = gioiTinh;
        this.luong = luong;
    }

    public String getManv() {
        return manv;
    }

    public void setManv(String manv) {
        this.manv = manv;
    }

    public String getHoTen() {
        return hoTen;
    }

    public void setHoTen(String hoTen) {
        this.hoTen = hoTen;
    }

    public boolean isGioiTinh() {
        return gioiTinh;
    }

    public void setGioiTinh(boolean gioiTinh) {
        this.gioiTinh = gioiTinh;
    }

    public double getLuong() {
        return luong;
    }

    public void setLuong(double luong) {
        this.luong = luong;
    }

    public String toJson() {
        return String.format(
            "{\"manv\":\"%s\",\"hoTen\":\"%s\",\"gioiTinh\":%b,\"luong\":%.2f}",
            escapeJson(manv),
            escapeJson(hoTen),
            gioiTinh,
            luong
        );
    }

    private String escapeJson(String str) {
        if (str == null) return "";
        return str.replace("\\", "\\\\")
                  .replace("\"", "\\\"")
                  .replace("\n", "\\n")
                  .replace("\r", "\\r")
                  .replace("\t", "\\t");
    }
}
