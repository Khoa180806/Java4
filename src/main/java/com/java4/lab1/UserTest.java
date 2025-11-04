package com.java4.lab1;

public class UserTest {
    public static void main(String[] args) {
        UserManager userManager = new UserManager();
        System.out.println("---Tạo mới User---");
        userManager.create();
        System.out.println("---Hiển thị danh sách User---");
        userManager.findAll();
        System.out.println("---Cập nhật User---");
        userManager.update();
        System.out.println("---Hiển thị danh sách User---");
        userManager.findAll();
        System.out.println("---Xóa User---");
        userManager.deleteById();
        System.out.println("---Hiển thị danh sách User---");
        userManager.findAll();
        System.out.println("---Hiển thị danh sách User theo Id---");
        userManager.findById();
        System.out.println("---Hiển thị danh sách User theo Email---");
        userManager.findByEmail();
        System.out.println("---Hiển thị danh sách User ở trang 3---");
        userManager.page();
    }
}
