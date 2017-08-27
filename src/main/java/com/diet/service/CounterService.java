package com.diet.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.diet.entity.Counter;
import com.diet.repository.CounterRepository;
 
@Service
@Transactional
public class CounterService {
 
  @Autowired
  CounterRepository repository;
   
  public List<Counter> selectAll() {
    return repository.findAll(new Sort(Sort.Direction.ASC, "id"));
  }
  public Counter get(int id) {
	  return repository.findOne(id);
	    //return repository.getOne(id);
  }
  public Counter save(Counter counter) {
      return repository.save(counter);
      
  }
  public void delete(int id) {
	  repository.delete(id);
  }
  
   
}
