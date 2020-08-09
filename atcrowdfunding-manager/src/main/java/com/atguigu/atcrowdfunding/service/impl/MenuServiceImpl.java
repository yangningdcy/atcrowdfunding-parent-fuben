package com.atguigu.atcrowdfunding.service.impl;

import com.atguigu.atcrowdfunding.bean.TMenu;
import com.atguigu.atcrowdfunding.dao.TMenuMapper;
import com.atguigu.atcrowdfunding.service.MenuService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class MenuServiceImpl implements MenuService {
    @Autowired
    TMenuMapper menuMapper;

    @Override
    public List<TMenu> listAllmenus() {
        List<TMenu> parentList=new ArrayList<TMenu>();//存放父
        Map<Integer,TMenu> cache = new HashMap<Integer,TMenu>();
        List<TMenu> allList = menuMapper.selectByExample(null);//存放所有菜单

        //找到所有父菜单
        for (TMenu tMenu : allList) {
            Integer pid = tMenu.getPid();
            if (pid==0){
                parentList.add(tMenu);
                cache.put(tMenu.getId(),tMenu);
            }
        }
        //迭代，组合父子关系
        for (TMenu tMenu : allList) {
            Integer pid = tMenu.getPid();
            //过滤出所有子
            if (pid!=0){
                TMenu parent = cache.get(pid);//外键关联
                parent.getChildren().add(tMenu);
            }
        }
        System.out.println("parentList"+parentList);
        return parentList;
    }


    @Override
    public List<TMenu> listAllMenusTree() {
        return menuMapper.selectByExample(null);
    }
}
