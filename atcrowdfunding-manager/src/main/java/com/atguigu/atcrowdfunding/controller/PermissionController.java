package com.atguigu.atcrowdfunding.controller;

import com.atguigu.atcrowdfunding.bean.TPermission;
import com.atguigu.atcrowdfunding.service.TPermissionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/permission")
public class PermissionController {

    @Autowired
    TPermissionService permisionService;



    @ResponseBody
    @PostMapping("/add")
    public String addPermission(TPermission permission){
        permisionService.savePermission(permission);
        return "ok";
    }

    @ResponseBody
    @DeleteMapping("/delete")
    public String deletePermission(Integer id){
        permisionService.deletePermission(id);
        return "ok";
    }

    @ResponseBody
    @PostMapping("/edit")
    public String editPermission(TPermission permission){
        permisionService.editPermission(permission);
        return "ok";
    }

    @ResponseBody
    @GetMapping("/get")
    public TPermission getPermission(Integer id){
        return permisionService.getPermissionById(id);
    }


    @GetMapping("/index")
    public String index() {
    return "permission/index";
    }

    @ResponseBody
    @GetMapping("/listAllPermissionTree")
    public List<TPermission> getAllPermissions() {
    return permisionService.getAllPermissions();
    }
}