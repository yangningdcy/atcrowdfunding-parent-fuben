package com.atguigu.atcrowdfunding.service.impl;

import com.atguigu.atcrowdfunding.bean.TPermission;
import com.atguigu.atcrowdfunding.bean.TPermissionMenuExample;
import com.atguigu.atcrowdfunding.bean.TRolePermissionExample;
import com.atguigu.atcrowdfunding.dao.TPermissionMapper;
import com.atguigu.atcrowdfunding.dao.TPermissionMenuMapper;
import com.atguigu.atcrowdfunding.dao.TRolePermissionMapper;
import com.atguigu.atcrowdfunding.service.TPermissionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class TPermissionServiceImpl implements TPermissionService {

    @Autowired
    TPermissionMapper permissionMapper;
    @Autowired
    TRolePermissionMapper rolePermissionMapper;
    @Autowired
    TPermissionMenuMapper permissionMenuMapper;


    @Override
    public List<TPermission> getPermissionByMenuid(Integer mid) {
        return permissionMapper.getPermissionByMenuid(mid);
    }

    @Override
    public void assignPermissionToMenu(Integer mid, List<Integer> perIdArray) {
// 1、删除之前菜单对应的权限
        TPermissionMenuExample example = new TPermissionMenuExample();
        example.createCriteria().andMenuidEqualTo(mid);
        permissionMenuMapper.deleteByExample(example);
// 2、插入提交过来的新的权限集合
        permissionMenuMapper.insertBatch(mid, perIdArray);
    }

    @Override
    public List<TPermission> getAllPermissionsByRoleid(Integer id) {
        return permissionMapper.getAllPermissionsByRoleid(id);
    }

    @Override
    public void assignPermissionToRole(Integer rid, List<Integer> perIdArray) {
        if(perIdArray.size()>0){
//1、先删除当前角色之前的所有权限
            TRolePermissionExample example = new TRolePermissionExample();
            example.createCriteria().andRoleidEqualTo(rid);
            rolePermissionMapper.deleteByExample(example);

//2、将新传入的所有权限保存进来
            rolePermissionMapper.insertBatch(rid,perIdArray);
        }
    }

    @Override
    public List<TPermission> getAllPermissions() {
        return permissionMapper.selectByExample(null);
    }

    @Override
    public void savePermission(TPermission permission) {
        permissionMapper.insertSelective(permission);
    }

    @Override
    public void deletePermission(Integer id) {
        permissionMapper.deleteByPrimaryKey(id);
    }

    @Override
    public void editPermission(TPermission permission) {
        permissionMapper.updateByPrimaryKeySelective(permission);
    }

    @Override
    public TPermission getPermissionById(Integer id) {
        return permissionMapper.selectByPrimaryKey(id);
    }
}
