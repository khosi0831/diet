package com.diet.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.diet.entity.Question;
import com.diet.repository.QuestionRepository;

@Service
@Transactional

public class QuestionService {
	 @Autowired
	 QuestionRepository repository;
	   
	  public List<Question> selectAll() {
	    return repository.findAll();
	  }
	  
	  public void deleteAll() {
	      repository.deleteAll();
	  }
	  public Question save(Question question) {
	      return repository.save(question);
	  }

}
