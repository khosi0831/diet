package com.diet.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.security.crypto.password.Pbkdf2PasswordEncoder;
import org.springframework.security.crypto.password.StandardPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.diet.entity.Customer;
import com.diet.entity.Plan;
import com.diet.entity.Question;
import com.diet.entity.Report;
import com.diet.entity.Weight;
import com.diet.repository.AdviceRepository;
import com.diet.repository.CustomerRepository;
import com.diet.repository.LectureRepository;
import com.diet.repository.MindRepository;
import com.diet.repository.PlanRepository;
import com.diet.repository.QuestionRepository;
import com.diet.repository.ReportRepository;
import com.diet.repository.WeightRepository;


@Service
@Transactional

public class CustomerService {
	 @Autowired
	 CustomerRepository repository;
	 @Autowired
	 PlanRepository repositoryPlan;
	 @Autowired
	 QuestionRepository repositoryQuestion;
	 @Autowired
	 ReportRepository repositoryReport;
	 @Autowired
	 WeightRepository repositoryWeight;
	 
	 @Autowired
	 AdviceRepository repositoryAdvice;
	 
	 @Autowired
	 LectureRepository repositoryLecture;
	  
	 @Autowired
	 MindRepository repositoryMind;
	  
	 @Autowired
	 MindRepository repositoryPhoto;
	  
	  
	 
	 
	  public List<Customer> selectAll() {
	    return repository.findAll();
	  }
	  public List<Customer> search(String startDate, String name, String keyword) {
		    return repository.search(startDate, name, keyword);
	  }
	  public Customer findOne(int id) {
		  return repository.findOne(id);
	  }
	  public Customer findOne(String name) {
		  return repository.findOne(name);
	  }
	  public Customer save(Customer customer) {
		  boolean create = customer.getId() == null ? true : false;
		  repository.save(customer);
		  if ( create ) {
			  //計画の追加
			  for(int i = 0; i < 12; i++) {
				  Plan plan = new Plan();
				  plan.setUserId(customer.getId());
				  plan.setWeek(i+1);
				  repositoryPlan.save(plan);
			  }
			  List<Question> questions = repositoryQuestion.findAll();
			  for(Question question : questions) {
				  Report report = new Report();
				  report.setUserId(customer.getId());
				  report.setSeqno(question.getSeqno());
				  report.setQuestion(question.getQuestion());
				  repositoryReport.save(report);
			  }
			  Weight weight = new Weight();
			  weight.setUserId(customer.getId());
			  repositoryWeight.save(weight);
		  } 
		  return customer;
	  }	  
	  public void delete(int id) {
		  repository.delete(id);
		  repositoryPlan.delete(id);
		  repositoryReport.delete(id);
		  repositoryWeight.delete(id);
		  repositoryAdvice.delete(id);
		  repositoryLecture.delete(id);
		  repositoryMind.delete(id);
		  repositoryPhoto.delete(id);
	  }
	  
}
