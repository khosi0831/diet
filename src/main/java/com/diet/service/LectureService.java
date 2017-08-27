package com.diet.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.diet.entity.Lecture;
import com.diet.repository.LectureRepository;

@Service
@Transactional

public class LectureService {
	 @Autowired
	 LectureRepository repository;
	   
	  public List<Lecture> selectAll() {
	    return repository.findAll();
	  }
	  
	  public Lecture get(int id) {
		  return repository.get(id);
		    //return repository.getOne(id);
	  }

	  public Lecture get(int id, int week) {
		  return repository.get(id, week);
		    //return repository.getOne(id);
	  }
	  
	  public Lecture save(Lecture lecture) {
		    return repository.save(lecture);
	  }

}
