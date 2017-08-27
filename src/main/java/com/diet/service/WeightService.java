package com.diet.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.diet.entity.Weight;
import com.diet.repository.WeightRepository;


@Service
@Transactional

public class WeightService {
	 @Autowired
	 WeightRepository repository;
	   
	  public List<Weight> selectAll() {
	    return repository.findAll();
	  }

	  public Weight get(int id) {
		  return repository.find(id);
		    //return repository.getOne(id);
	  }

	  public Weight save(Weight weight) {
	      return repository.save(weight);
	  }
	  
}
