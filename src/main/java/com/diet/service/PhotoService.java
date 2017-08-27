package com.diet.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.diet.entity.Photo;
import com.diet.repository.PhotoRepository;


@Service
@Transactional
public class PhotoService {
	 @Autowired
	  PhotoRepository repository;
	   
	  public List<Photo> selectAll() {
	    return repository.findAll();
	  }
	  public List<Photo> get(int id, int week) {
		  return repository.get(id, week);
		    //return repository.getOne(id);
	  }
	  public Photo findOne(int id) {
		  return repository.findOne(id);
		    //return repository.getOne(id);
	  }
	  public Photo save(Photo photo) {
		    return repository.save(photo);
	  }
	  public void delete(int id) {
		  repository.delete(id);
	  }
	  

}
