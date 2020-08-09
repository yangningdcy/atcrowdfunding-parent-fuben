package com.atguigu.atcrowdfunding.service;

import com.atguigu.atcrowdfunding.LoginException;
import com.atguigu.atcrowdfunding.bean.TAdmin;
import com.atguigu.atcrowdfunding.bean.TMenu;
import com.github.pagehelper.PageInfo;

import java.util.List;
import java.util.Map;

public interface AdminService {
    TAdmin getAdminByLogin(String loginacct, String userpswd)throws LoginException;

    PageInfo<TAdmin> listPage(Map<String, Object> paramMap);

    void saveAdmin(TAdmin admin);

    TAdmin getAdminById(Integer id);

    void updateAdmin(TAdmin admin);

    void deleteAdminById(Integer id);

    void deleteBatch(String ids);

    List<Integer> queryRoleIdsByAdminId(Integer adminId);

    void deleteAdminRole(Integer adminId, List<Integer> ids);

    void insertAdminRole(Integer adminId, List<Integer> ids);
}
