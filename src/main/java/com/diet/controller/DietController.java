package com.diet.controller;

import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.diet.ComUtils;
import com.diet.entity.Customer;
import com.diet.service.CustomerService;

import java.text.ParseException;
import java.util.Locale;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
@Controller

public class DietController {

	@Autowired
	CustomerService service;
	
	@RequestMapping(value="/admin", method=RequestMethod.GET)
	public String index(Locale locale, Model model) throws ParseException {
		
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();

		String username = "";
		if (principal instanceof UserDetails) {
		  username = ((UserDetails)principal).getUsername();
		} else {
		  username = principal.toString();
		}
		int id = Integer.parseInt(username);
		Customer customer = service.findOne(id);
		if ( "user1".equals(customer.getName())) {
			model.addAttribute("role", "admin" );
			model.addAttribute("login", customer.getName());
			return "test01";
		} else {
			model.addAttribute("role", "user" );
			model.addAttribute("id", customer.getId() );
			model.addAttribute("week",  ComUtils.passweek(customer.getStartdate()));
			model.addAttribute("login", customer.getName());
			return "person2";
		}
//		return "person2";
//		return "diet3";
//		return "diet";
//		return "index";
	}
	@RequestMapping(value = "/{id}", method = RequestMethod.GET)
	public String hello(@RequestParam("week") String week ,Model model, @PathVariable int id) {	
//	public String customer(Locale locale, Model model, @PathVariable int id) {
		String username = "";
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		if (principal instanceof UserDetails) {
		  username = ((UserDetails)principal).getUsername();
		} else {
		  username = principal.toString();
		}
		int userid = Integer.parseInt(username);
		Customer customer = service.findOne(userid);
		String role = customer.getName().equals("user1") ? "admin" : "user";
		model.addAttribute("id", id );
		model.addAttribute("week", week );
		model.addAttribute("role", role );
		model.addAttribute("login", customer.getName());
		return "person2";
//		return "ctest";
	}
	
}
