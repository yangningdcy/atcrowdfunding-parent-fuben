package com.atguigu.atcrowdfunding.service.impl;

import com.atguigu.atcrowdfunding.bean.TRole;
import com.atguigu.atcrowdfunding.dao.TRoleMapper;
import com.atguigu.atcrowdfunding.service.TRoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;


@Service
public class TRoleServiceImpl implements TRoleService {

    @Autowired
    TRoleMapper tRoleMapper;
    @Override
    public List<TRole> queryAll() {
        return tRoleMapper.selectByExample(null);
    }
}
