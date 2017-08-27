package com.diet.entity;

import lombok.Data;
import org.springframework.security.core.authority.AuthorityUtils;


public class LoginUserDetails extends org.springframework.security.core.userdetails.User {

	private final User user;
    public User getUser() {
		return user;
	}

    public LoginUserDetails(User user) {
        super(user.getUsername(), user.getEncodedPassword(), AuthorityUtils.createAuthorityList("ROLE_USER"));
        this.user = user;
    }
}