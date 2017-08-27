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

import com.diet.entity.Mind;
import com.diet.service.MindService;


@RestController
@RequestMapping("/mind")

public class MindController {
	  @Autowired
	  MindService service;
	   
	  // 一覧表示
	  @RequestMapping(value="/selectall", method=RequestMethod.GET)
	  public List<Mind> counterSelectAll() {
	    return service.selectAll(); 
	  }

//	  @RequestMapping(value = "{id}", method = RequestMethod.GET)
//	  public Mind get(@PathVariable int id) {
//		Mind mind = service.get(id);
//	    return mind;
//	  }
	  
	  @RequestMapping(value = "{id}", method = RequestMethod.GET)
	  public Mind get(@RequestParam("week") String week,Model model, @PathVariable int id) {	
	  //public Advice get(@PathVariable int id) {
		Mind mind = service.get(id, Integer.parseInt(week));
	    return mind;
	  }
	  
	  
	  @RequestMapping(value="/save",method=RequestMethod.POST)
	  public Mind save(@Validated @RequestBody Mind mind) {
		  try {
			  return service.save(mind);
		  } catch(Exception e) {
			  e.printStackTrace();
		  } finally{
			  return mind;
		  }
	  }

}
