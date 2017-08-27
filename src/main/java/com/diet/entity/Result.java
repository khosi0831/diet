package com.diet.entity;


public class Result  {
	private Integer id;
	private String name;
	private String password;
	private String email;
	private String address;
	private String startdate;
	private String birth;
	private String memo;
	private String favorite;
	private String site;
	private String from;
	private String to;
	
	private String state;
	
	public Result(Customer customer) {
		this.id = customer.getId();
		this.name = customer.getName();
		this.password = customer.getPassword();
		this.email = customer.getEmail();
		this.address = customer.getAddress();
		this.startdate = customer.getStartdate();
		this.birth = customer.getBirth();
		this.memo = customer.getMemo();
		this.favorite = customer.getFavorite();
		this.site = customer.getSite();
	}
	
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getStartdate() {
		return startdate;
	}
	public void setStartdate(String startdate) {
		this.startdate = startdate;
	}
	public String getBirth() {
		return birth;
	}
	public void setBirth(String birth) {
		this.birth = birth;
	}
	public String getMemo() {
		return memo;
	}
	public void setMemo(String memo) {
		this.memo = memo;
	}
	public String getFavorite() {
		return favorite;
	}
	public void setFavorite(String favorite) {
		this.favorite = favorite;
	}
	public String getSite() {
		return site;
	}
	public void setSite(String site) {
		this.site = site;
	}
	public String getFrom() {
		return from;
	}
	public void setFrom(String from) {
		this.from = from;
	}
	public String getTo() {
		return to;
	}
	public void setTo(String to) {
		this.to = to;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	
}
