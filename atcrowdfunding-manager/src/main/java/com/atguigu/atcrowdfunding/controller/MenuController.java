package com.atguigu.atcrowdfunding.controller;

import com.atguigu.atcrowdfunding.bean.TMenu;
import com.atguigu.atcrowdfunding.service.MenuService;
import com.atguigu.atcrowdfunding.service.SystemMenuService;
import com.atguigu.atcrowdfunding.service.TPermissionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;

@Controller
public class MenuController {

    @Autowired
    MenuService menuService;

    @Autowired
    SystemMenuService systemMenuService;







    @ResponseBody
    @DeleteMapping("/menu/delete")
    public String deleteMenu(Integer id){
        systemMenuService.deleteMenu(id);
        return "ok";
    }


    @ResponseBody
    @PostMapping("/menu/edit")
    public String editMenu(TMenu menu){
        systemMenuService.editMenu(menu);
        return "ok";
    }

    @ResponseBody
    @GetMapping("/menu/get")
    public TMenu getMenu(Integer id){
        return systemMenuService.getMenuById(id);
    }



    @ResponseBody
    @PostMapping("/menu/add")
    public String addMenu(TMenu menu){
        systemMenuService.saveMenu(menu);
        return "ok";
    }


    @ResponseBody
    @RequestMapping("menu/loadTree")
    public List<TMenu> loadTree(){
      return  menuService.listAllMenusTree();
    }


    @RequestMapping("menu/index")
    public String index(){
        return "menu/index";
    }
}
