package com.atguigu.atcrowdfunding.service;

import com.atguigu.atcrowdfunding.bean.TPermission;

import java.util.List;

public interface TPermissionService {
    List<TPermission> getAllPermissions();

    void savePermission(TPermission permission);

    void deletePermission(Integer id);

    void editPermission(TPermission permission);

    TPermission getPermissionById(Integer id);

    void assignPermissionToRole(Integer rid, List<Integer> perIdArray);

    /*查询某个角色的所有系统中的权限标识
     * @param id 角色id*/
    List<TPermission> getAllPermissionsByRoleid(Integer id);

    void assignPermissionToMenu(Integer mid, List<Integer> perIdArray);

    List<TPermission> getPermissionByMenuid(Integer mid);
}
