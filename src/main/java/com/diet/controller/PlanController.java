package com.diet.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.diet.entity.Plan;
import com.diet.service.PlanService;


@RestController
@RequestMapping("/plan")

public class PlanController {
	  @Autowired
	  PlanService service;
	   
	  // 一覧表示
	  @RequestMapping(value="/selectall", method=RequestMethod.GET)
	  public List<Plan> counterSelectAll() {
	    return service.selectAll(); 
	  }
	  
	  @RequestMapping(value = "{id}", method = RequestMethod.GET)
	  public List<Plan> get(@PathVariable int id) {
	    List<Plan> plans = service.get(id);
	    for(Plan plan : plans) {
	    	if ( plan.getPlan() == null ) {
	    		plan.setPlan("");
	    	}
	    }
	    return plans;
	  }
	  
	  @RequestMapping(value="/save",method=RequestMethod.POST)
	  public List<Plan> save(@Validated @RequestBody List<Plan> plans) {
		  List<Plan> plans1 = new ArrayList<Plan>();
		  for(Plan plan : plans) {
			  plans1.add(service.save(plan));
		  }
		  return plans1;
	  }

}
