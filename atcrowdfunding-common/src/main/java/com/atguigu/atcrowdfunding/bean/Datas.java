package com.atguigu.atcrowdfunding.bean;

import java.util.List;

public class Datas {
    private List<Integer> ids;

    public Datas() {
    }

    public Datas(List<Integer> ids) {
        this.ids = ids;
    }

    public List<Integer> getIds() {
        return ids;
    }

    public void setIds(List<Integer> ids) {
        this.ids = ids;
    }

    @Override
    public String toString() {
        return "Data{" +
                "ids=" + ids +
                '}';
    }
}