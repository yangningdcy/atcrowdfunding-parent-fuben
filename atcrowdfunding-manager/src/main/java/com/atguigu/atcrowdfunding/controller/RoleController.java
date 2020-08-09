package com.atguigu.atcrowdfunding.controller;

import com.atguigu.atcrowdfunding.bean.TPermission;
import com.atguigu.atcrowdfunding.bean.TRole;
import com.atguigu.atcrowdfunding.service.RoleService;
import com.atguigu.atcrowdfunding.service.TPermissionService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.apache.commons.collections.map.HashedMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class RoleController {
    @Autowired
    RoleService roleService;

    @Autowired
    TPermissionService permisionService;



    @ResponseBody
    @GetMapping("/menu/menu_permission")
    public List<TPermission> getPermissionByMenuid(@RequestParam("menuid") Integer mid) {
// 查询出当前菜单能被哪些权限（自定义标识）操作
        return permisionService.getPermissionByMenuid(mid);
    }



    /**
     * 为菜单分配权限 {mid: "3", perIds: "1,2,4,5,6"}
     */
    @ResponseBody
    @PostMapping("/permission/assignPermissionToMenu")
    public String assignPermissionToMenu(@RequestParam("mid") Integer mid, @RequestParam("perIds") String perIds) {
// 权限id的集合
        List<Integer> perIdArray = new ArrayList<>();
        String[] split = perIds.split(",");
        for (String str : split) {
            int id;
            try {
                id = Integer.parseInt(str);
                perIdArray.add(id);
            } catch (NumberFormatException e) {
            }
        }
// 1、将菜单和权限id集合的关系保存起来
        permisionService.assignPermissionToMenu(mid, perIdArray);
        return "ok";
    }


    /*回显角色对应的所有权限
     * @param id  传入角色id*/
    @ResponseBody
    @GetMapping("/permission/role_permission")
    public List<TPermission> getRolePermissions(@RequestParam("rid")Integer id){
        return permisionService.getAllPermissionsByRoleid(id);
    }

    //{rid: "3", perId: "1,2,3"}
//为角色分配权限
    @ResponseBody
    @PostMapping("/permission/assign/assignPermissionToRole")
    public String assignPermissionToRole(@RequestParam("rid")Integer rid,@RequestParam("perId")String perIds){
        List<Integer> perIdArray = new ArrayList<>();
        String[] split = perIds.split(",");
        for (String str : split) {
            int id;
            try {
                id = Integer.parseInt(str);
                perIdArray.add(id);
            } catch (NumberFormatException e) {
            }
        }
        permisionService.assignPermissionToRole(rid,perIdArray);
        return "ok";
    }



    @ResponseBody
    @RequestMapping("/role/deleteBatch")
    public String deleteBatch(String ids,Integer pageNum){
        roleService.deleteBatch(ids);
//        return "redirect:/role/index";//同步请求不跳回当前页码，不加@Response
        return "ok";//异步请求且跳回当前页码
    }

    @ResponseBody
    @RequestMapping("/role/doDelete")
    public String delete(Integer id){
        roleService.deleteRoleById(id);
        return "ok";
    }

    @ResponseBody
    @RequestMapping("/role/doUpdate")
    public String doUpdate(TRole role){
        roleService.updateRole(role);
        return "ok";
    }

    @ResponseBody
    @RequestMapping("/role/getRoleById")
    public TRole get(Integer id){
        return roleService.getRoleById(id);
    }


    @RequestMapping("/role/doAdd")
    @ResponseBody
    public String doAdd(TRole role){
        roleService.saveRole(role);
        return "ok";
    }




    //StringHttpMessageConverter将字符串原样返回，不进行视图解析

    @ResponseBody//告诉框架，采用HttpMessageConverter组件（将bean对象转换为json）//MappingJackson2HttpMessageConverter将
    @RequestMapping("/role/loadData")
    public PageInfo<TRole> loadData(@RequestParam(value = "pageNum",required = false,defaultValue = "1") Integer pageNum,
                       @RequestParam(value = "pageSize",required = false,defaultValue = "2") Integer pageSize,
                       @RequestParam(value = "condition",required = false,defaultValue = "") String condition){

        PageHelper.startPage(pageNum,pageSize);

        Map<String,Object> paramMap = new HashMap<String,Object>();
        paramMap.put("condition",condition);
        PageInfo<TRole> pageInfo=roleService.listPage(paramMap);
        return pageInfo;//不在跳转页面，而是将数据以json格式返回
    }

    @RequestMapping("role/index")
    public String index(){

        return "role/index";
    }
}
