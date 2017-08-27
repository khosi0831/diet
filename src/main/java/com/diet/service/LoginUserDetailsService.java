package com.diet.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.encoding.PasswordEncoder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.diet.entity.Customer;
import com.diet.entity.LoginUserDetails;
import com.diet.entity.User;
import com.diet.repository.CustomerRepository;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.Pbkdf2PasswordEncoder;
import org.springframework.security.crypto.password.StandardPasswordEncoder;
@Service
public class LoginUserDetailsService implements UserDetailsService {
	
	
    @Autowired
    CustomerRepository repository;
    
    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
    	int id = 0;
    	try {
        	id = Integer.parseInt(username);
    	} catch(NumberFormatException e) {
            throw new UsernameNotFoundException("The requested user is not found.");
    	}
    	Customer customer = repository.findOne(id);
    	
    	System.out.println(new BCryptPasswordEncoder().encode("demo"));
    	System.out.println(new Pbkdf2PasswordEncoder().encode("demo"));
    	
    	User user = new User();
    	  user.setUsername(username);
//        user.setUsername(username);
//        user.setUserid(customer.getId());
          user.setEncodedPassword(new Pbkdf2PasswordEncoder().encode(customer.getPassword()));
//        user.setUsername("user1");
//        user.setEncodedPassword("fb25585b95427bd955da4ec5624f9f47bbc947cdd985a4383f8a3cf62d1b6b015cd666a9792c6276");
        
//      user.setUsername("user1");
//      user.setEncodedPassword("0c3b8d438e41a84757d22578afc3c6630f8cfdf4a0554f04233e70899abb71d5b782d5139ab97e6e");
        if (user == null) {
            throw new UsernameNotFoundException("The requested user is not found.");
        }
        return new LoginUserDetails(user);
    }
}