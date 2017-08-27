package com.diet.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.diet.entity.Advice;
import com.diet.service.AdviceService;


@RestController
@RequestMapping("/advice")
public class AdviceController {
	  @Autowired
	  AdviceService service;
	   
	  // 一覧表示
	  @RequestMapping(value="/selectall", method=RequestMethod.GET)
	  public List<Advice> counterSelectAll() {
	    return service.selectAll(); 
	  }
	  
	  @RequestMapping(value = "{id}", method = RequestMethod.GET)
//	  public String get(@RequestParam("week") String week ,Model model, @PathVariable int id) {	
	  
	  public Advice get(@RequestParam("week") String week,Model model, @PathVariable int id) {	
	  //public Advice get(@PathVariable int id) {
		Advice advice = service.get(id, Integer.parseInt(week));
	    return advice;
	  }
	  
	  @RequestMapping(value="/save",method=RequestMethod.POST)
	  public Advice save(@Validated @RequestBody Advice advice) {
		  try {
			  return service.save(advice);
		  } catch(Exception e) {
			  e.printStackTrace();
		  } finally{
			  return advice;
		  }
	  }
	  
}
