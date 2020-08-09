package com.atguigu.atcrowdfunding.listener;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
/*监听服务器启动和销毁时，触发事件。重点监听ServletContext对象的创建和销毁*/
public class StartSystemInitListener implements ServletContextListener {
    //服务器启动时执行事件处理
    @Override
    public void contextInitialized(ServletContextEvent servletContextEvent) {
        System.out.println("startSystemInitListener-contextInitialized");
        ServletContext application = servletContextEvent.getServletContext();
        String contextPath = application.getContextPath();
        application.setAttribute("PATH",contextPath);
        System.out.println("contextPath="+contextPath);
    }
    //服务器停止时执行事件处理
    @Override
    public void contextDestroyed(ServletContextEvent servletContextEvent) {
        System.out.println("startSystemInitListener-contextDestroy");

    }
}
