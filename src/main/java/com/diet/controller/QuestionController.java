package com.diet.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.diet.entity.Question;
import com.diet.service.QuestionService;


@RestController
@RequestMapping("/question")

public class QuestionController {
	  @Autowired
	  QuestionService service;
	   
	  // 一覧表示
	  @RequestMapping(value="/selectall", method=RequestMethod.GET)
	  public List<Question> counterSelectAll() {
	    return service.selectAll(); 
	  }

	  @RequestMapping(value="/save",method=RequestMethod.POST)
	  public List<Question> createUser(@Validated @RequestBody List<Question> questions) {
		  List<Question> questions1 = new ArrayList<Question>();
		  service.deleteAll();
		  for(Question question : questions) {
			  questions1.add(service.save(question));
		  }
		  return questions1;
	  }
	  
}
