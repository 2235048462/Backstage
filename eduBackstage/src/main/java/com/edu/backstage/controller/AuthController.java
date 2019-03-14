package com.edu.backstage.controller;

import com.edu.backstage.service.StaffService;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("auth")
public class AuthController{

    @SuppressWarnings("unused")
    @Autowired
    private StaffService staffService;


    /**
     * 用户登陆
     *
     * @return
     */
    @RequestMapping("login")
    public String login(){
        System.err.println("loginXXX");
        return "index";
    }


    @RequestMapping("code")
    public void getCode(@RequestParam(required = true, defaultValue = "100") Integer wid,@RequestParam(required = true, defaultValue = "50") Integer hig,HttpServletRequest request,HttpServletResponse response){
    }


    @RequestMapping("logout")
    public String logout(){
        return "index";
    }
}