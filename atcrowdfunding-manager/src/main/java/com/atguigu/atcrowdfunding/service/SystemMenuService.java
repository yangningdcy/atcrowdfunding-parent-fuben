package com.atguigu.atcrowdfunding.service;

import com.atguigu.atcrowdfunding.bean.TMenu;



public interface SystemMenuService {
    void saveMenu(TMenu menu);

    void editMenu(TMenu menu);

    TMenu getMenuById(Integer id);

    void deleteMenu(Integer id);
}
