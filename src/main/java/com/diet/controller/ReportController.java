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

import com.diet.entity.Report;
import com.diet.service.ReportService;

@RestController
@RequestMapping("/report")

public class ReportController {
	  @Autowired
	  ReportService service;
	   
	  // 一覧表示
	  @RequestMapping(value="/selectall", method=RequestMethod.GET)
	  public List<Report> counterSelectAll() {
	    return service.selectAll(); 
	  }

	  @RequestMapping(value = "{id}", method = RequestMethod.GET)
	  public List<Report> get(@PathVariable int id) {
	    List<Report> reports = service.get(id);
	    for(Report report : reports) {
	    	if ( report.getAnswer() == null ) {
	    		report.setAnswer("");
	    	}
	    }
	    return reports;
	  }
	  
	  @RequestMapping(value="/save",method=RequestMethod.POST)
	  public List<Report> save(@Validated @RequestBody List<Report> reports) {
		  List<Report> reports1 = new ArrayList<Report>();
		  for(Report report : reports) {
			  reports1.add(service.save(report));
		  }
		  return reports1;
	  }

}
