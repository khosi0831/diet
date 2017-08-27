package com.diet.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.diet.entity.Mind;
import com.diet.repository.MindRepository;

@Service
@Transactional

public class MindService {
	 @Autowired
	 MindRepository repository;
	   
	  public List<Mind> selectAll() {
	    return repository.findAll();
	  }
	  
	  public Mind get(int id) {
		  return repository.get(id);
		    //return repository.getOne(id);
	  }
	  
	  public Mind get(int id, int week) {
		  return repository.get(id, week);
		    //return repository.getOne(id);
	  }
	  
	  public Mind save(Mind mind) {
		    return repository.save(mind);
	  }

}
