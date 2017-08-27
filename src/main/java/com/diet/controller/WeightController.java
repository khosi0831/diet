package com.diet.controller;

import java.util.ArrayList;
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

import com.diet.entity.Weight;
import com.diet.service.WeightService;


@RestController
@RequestMapping("/weight")
public class WeightController {
	  @Autowired
	  WeightService service;
	   
	  // 一覧表示
	  @RequestMapping(value="/selectall", method=RequestMethod.GET)
	  public List<Weight> counterSelectAll() {
	    return service.selectAll(); 
	  }
	  
	  @RequestMapping(value = "{id}", method = RequestMethod.GET)
	  public Weight get(@PathVariable int id) {
	    return service.get(id);
	  }
	  
	  
	  @RequestMapping(value="/save",method=RequestMethod.POST)
	  public Weight save(@Validated @RequestBody Weight weight) {
		  return service.save(weight);
	  }
	  

}
