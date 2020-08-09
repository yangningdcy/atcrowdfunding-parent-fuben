package com.atguigu.atcrowdfunding.controller;

import com.atguigu.atcrowdfunding.bean.Datas;
import com.atguigu.atcrowdfunding.bean.TAdmin;
import com.atguigu.atcrowdfunding.bean.TRole;
import com.atguigu.atcrowdfunding.service.AdminService;
import com.atguigu.atcrowdfunding.service.TRoleService;
import com.atguigu.atcrowdfunding.uitl.Const;
import com.atguigu.atcrowdfunding.uitl.DateUtil;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.*;

@Controller
public class AdminController {

    @Autowired
    AdminService adminService;
    @Autowired
    TRoleService tRoleService;


    @ResponseBody
    @RequestMapping("/admin/unassign")
    public String unassign(Integer adminId, Datas ds) {
        adminService.deleteAdminRole(adminId,ds.getIds());
        return "ok";
    }
    @ResponseBody
    @RequestMapping("/admin/assign")
    public String assign(Integer adminId,Datas ds) {
        adminService.insertAdminRole(adminId,ds.getIds());
        return "ok";
    }




    @GetMapping("/admin/toAssignRole")
    public String toAssignRole(Integer adminId,Map<String,Object> map) {
// 查询所有角色
        List<TRole> allRole = tRoleService.queryAll();
//查询已经分配给管理员的角色id
        List<Integer> roleId = adminService.queryRoleIdsByAdminId(adminId);
// 未分配角色
        List<TRole> unassign = new ArrayList<TRole>();
// 已分配角色
        List<TRole> assign = new ArrayList<TRole>();
        for (TRole role : allRole) {
            if(roleId.contains(role.getId())){
                assign.add(role);
            }else{
                unassign.add(role);
            }
        }
        map.put("unassign", unassign);
        map.put("assign", assign);
        return "admin/assginRole";
    }


    @RequestMapping("/admin/deleteBatch")
    public String doBatchDelete(String ids,Integer pageNum){
        adminService.deleteBatch(ids);
        return "redirect:/admin/index?pageNum="+pageNum;
    }

    @RequestMapping("/admin/doDelete")
    public String doDelete(Integer id,Integer pageNum){
        adminService.deleteAdminById(id);
        return "redirect:/admin/index?pageNum="+pageNum;
    }


    @RequestMapping("/admin/doUpdate")
    public String doUpdate(TAdmin admin,Integer pageNum){
        adminService.updateAdmin(admin);
        return "redirect:/admin/index?pageNum="+pageNum;
    }

    @RequestMapping("admin/toUpdate")
    public String toUpdate(Integer id,Model model){
       TAdmin admin= adminService.getAdminById(id);
       model.addAttribute("admin",admin);
        return "admin/update";
    }

    /*用户添加功能*/
    @RequestMapping("/admin/doAdd")
    public String doAdd(TAdmin admin){
        //补充数据
        admin.setUserpswd(new BCryptPasswordEncoder().encode(Const.DEFALUT_PASSWORD));
        //日期格式转换
        admin.setCreatetime(DateUtil.format(new Date(),"yyyy-MM-dd HH:mm:ss"));

        adminService.saveAdmin(admin);
        //添加后跳转到最后一页，根据分页合理化，指定一个不存在页，就会分页合理化
        return "redirect:/admin/index?pageNum="+Integer.MAX_VALUE;//保存数据后，重定向分页查询
    }
    @RequestMapping("/admin/toAdd")
    public String toAdd(){
        return "admin/add";
    }



//    @PreAuthorize("hasRole('学徒')")
    @RequestMapping("/admin/index")
    public String index(@RequestParam(value = "pageNum",required = false,defaultValue = "1") Integer pageNum,
                        @RequestParam(value = "pageSize",required = false,defaultValue = "2")Integer pageSize,
                        @RequestParam(value = "condition",required = false,defaultValue = "")String condition
                        , Model model){
        //1.开启分页插件功能
        //Thread-> ThreadLocalMap
        PageHelper.startPage(pageNum,pageSize);//将数据通过ThreadLocal将数据绑定到线程上，传递给后续的流程

        //2.获取分页数据，业务层调用dao层获取数据，并封装成分页对象返回
        Map<String ,Object> paramMap=new HashMap<String,Object>();
        paramMap.put("condition",condition);

        PageInfo<TAdmin> page=adminService.listPage(paramMap);

        //3.数据存储model底层封装的是request域
        model.addAttribute("page",page);
        //4.跳转页面，转发
        return "admin/index";
    }
}
