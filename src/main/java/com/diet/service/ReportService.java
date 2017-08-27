package com.diet.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.diet.entity.Report;
import com.diet.repository.ReportRepository;

@Service
@Transactional
public class ReportService {
	 @Autowired
	 ReportRepository repository;
	   
	  public List<Report> selectAll() {
	    return repository.findAll();
	  }
	  
	  public List<Report> get(int id) {
		  return repository.find(id);
		    //return repository.getOne(id);
	  }
	  
	  public Report save(Report report) {
	      return repository.save(report);
	  }

}
