package com.diet.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.diet.entity.Advice;
import com.diet.repository.AdviceRepository;


@Service
@Transactional
public class AdviceService {
	 @Autowired
	 AdviceRepository repository;
	   
	  public List<Advice> selectAll() {
	    return repository.findAll();
	  }

	  public Advice get(int id) {
		  return repository.get(id);
		    //return repository.getOne(id);
	  }

	  public Advice get(int id, int week) {
		  return repository.get(id, week);
		    //return repository.getOne(id);
	  }
	  
	  public Advice save(Advice lecture) {
		    return repository.save(lecture);
	  }
	  
}
