package com.atguigu.atcrowdfunding.dao;

import com.atguigu.atcrowdfunding.bean.TPermission;
import com.atguigu.atcrowdfunding.bean.TPermissionExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface TPermissionMapper {
    long countByExample(TPermissionExample example);

    int deleteByExample(TPermissionExample example);

    int deleteByPrimaryKey(Integer id);

    int insert(TPermission record);

    int insertSelective(TPermission record);

    List<TPermission> selectByExample(TPermissionExample example);

    TPermission selectByPrimaryKey(Integer id);

    int updateByExampleSelective(@Param("record") TPermission record, @Param("example") TPermissionExample example);

    int updateByExample(@Param("record") TPermission record, @Param("example") TPermissionExample example);

    int updateByPrimaryKeySelective(TPermission record);

    int updateByPrimaryKey(TPermission record);
    /**获取当前角色对应的所有权限id*/
    List<TPermission> getAllPermissionsByRoleid(Integer id);

    /**
     * 获取当前菜单能对应的所有权限
     * @param mid 菜单id
     * @return
     */
    List<TPermission> getPermissionByMenuid(Integer mid);

    List<TPermission> listPermissionByAdminId(Integer adminId);
}