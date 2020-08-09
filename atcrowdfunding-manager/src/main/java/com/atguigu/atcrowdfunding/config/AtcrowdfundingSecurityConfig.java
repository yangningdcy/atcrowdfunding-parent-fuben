package com.atguigu.atcrowdfunding.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.access.AccessDeniedHandler;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@Configuration//配置类
@EnableWebSecurity//开启权限框架功能
@EnableGlobalMethodSecurity(prePostEnabled = true)//开启全局方法级别的细粒度权限控制
public class AtcrowdfundingSecurityConfig extends WebSecurityConfigurerAdapter {
   @Autowired
   UserDetailsService userDetailsService;

    @Override
    protected void configure(AuthenticationManagerBuilder auth) throws Exception {
//        super.configure(auth);
        auth.userDetailsService(userDetailsService).passwordEncoder(new BCryptPasswordEncoder());

    }

    @Override
    protected void configure(HttpSecurity http) throws Exception {
//        super.configure(http);

        //1.授权静态资源和首页
        http.authorizeRequests()
                .antMatchers("/static/**","/login.jsp").permitAll()
                .anyRequest().authenticated();
        //2.授权登录页面
        http.formLogin()
                .loginPage("/login.jsp")
                .loginProcessingUrl("/login")
                .usernameParameter("loginacct")
                .passwordParameter("userpswd")
                .defaultSuccessUrl("/main");
        //3.授权注销 需要禁用csrf
        http.logout().logoutUrl("/logout").logoutSuccessUrl("/login.jsp");


        //4.设置错误页面
        http.exceptionHandling().accessDeniedHandler(new AccessDeniedHandler() {
            @Override
            public void handle(HttpServletRequest request, HttpServletResponse response, AccessDeniedException accessDeniedException) throws IOException, ServletException {
                String s = request.getHeader("X-Requested-With");
                if("XMLHttpRequest".endsWith(s)){ //异步
                    response.getWriter().print("403");
                }else{//同步
                    request.getRequestDispatcher("/WEB-INF/jsp/error/error403.jsp")
                            .forward(request,response);
                }            }
        });

        //5.授权记住我功能-cookie版    需要提交一个remember-me
        http.rememberMe();
        http.csrf().disable();
    }
}
