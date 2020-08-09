package com.atguigu.atcrowdfunding.service;

        import com.atguigu.atcrowdfunding.bean.TMenu;

        import java.util.List;

public interface MenuService {
    //查询所有父，含有孩子属性，侧边栏，组装好父子关系后，返回
    List<TMenu> listAllmenus();

    List<TMenu> listAllMenusTree();
}
