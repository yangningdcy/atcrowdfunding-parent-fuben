package com.atguigu.atcrowdfunding.controller;

import com.atguigu.atcrowdfunding.LoginException;
import com.atguigu.atcrowdfunding.bean.TAdmin;
import com.atguigu.atcrowdfunding.bean.TMenu;
import com.atguigu.atcrowdfunding.service.AdminService;
import com.atguigu.atcrowdfunding.service.MenuService;
import com.atguigu.atcrowdfunding.uitl.Const;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;
import java.util.List;


@Controller
public class DispatcherController {

    @Autowired
    AdminService adminService;

    @Autowired
    MenuService menuService;

   /* @RequestMapping("/logout")
    public String logout(HttpSession session) {
        if (session != null) {
            session.invalidate();
        }
        return "redirect:/login.jsp";
    }*/

    /*@RequestMapping("/login")
        public String login(String loginacct, String userpswd, HttpSession session, Model model){

        try {
            TAdmin admin=adminService.getAdminByLogin(loginacct,userpswd);
            session.setAttribute(Const.LOGIN_ADMIN,admin);
            return "redirect:/main";
        } catch (LoginException e) {
            e.printStackTrace();
            model.addAttribute("message",e.getMessage());
            return "forward:/login.jsp";
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("message","系统出现问题");
            return "forward:/login.jsp";
        }
        }*/

        @RequestMapping("/main")
        public String main(HttpSession session){
            System.out.println("main...");
            //集合中的父菜单
            List<TMenu> parentMenuList=menuService.listAllmenus();
            session.setAttribute("parentMenuList",parentMenuList);
            return "main";
    }

}
