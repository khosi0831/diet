package com.diet.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller

public class LoginController {
    @GetMapping(path = "loginForm")
    String loginForm() {
        return "loginForm";
    }
    @GetMapping(path = "error")
    String error() {
        return "loginForm";
    }
}