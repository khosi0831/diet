package com.diet.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.diet.entity.Plan;
import com.diet.repository.PlanRepository;


@Service
@Transactional
public class PlanService {
	 @Autowired
	 PlanRepository repository;
	   
	  public List<Plan> selectAll() {
	    return repository.findAll();
	  }
	  
	  public List<Plan> get(int id) {
		  return repository.find(id);
		    //return repository.getOne(id);
	  }

	  public Plan save(Plan plan) {
	      return repository.save(plan);
	  }
	  
}
