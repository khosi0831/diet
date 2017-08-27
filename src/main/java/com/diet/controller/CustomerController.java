package com.diet.controller;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.diet.entity.Customer;
import com.diet.entity.Result;
import com.diet.service.CustomerService;

import java.io.UnsupportedEncodingException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;

@RestController
@RequestMapping("/customer")

public class CustomerController {
	  @Autowired
	  CustomerService service;
	   
	  // 一覧表示
	  @RequestMapping(value="/selectall", method=RequestMethod.GET)
	  public List<Customer> counterSelectAll() {
	    List<Customer> customers = service.selectAll(); 
	    for(Customer customer : customers ) {
	    	customer.setStatus("4週目");
	    	customer.setSite("/" + customer.getId());
	    	customer.setPlan("aaa");
	    }
	    return customers;
	  }
	  // 検索
//	  @RequestMapping(value="/search", method=RequestMethod.GET)
	  @RequestMapping(value="/search",method=RequestMethod.POST)
//	  public List<Result> search(@RequestParam("startDate") String startDate
//			  ,@RequestParam("name") String name
//			  ,@RequestParam("keyword") String keyword
//			  , Model model) throws ParseException, UnsupportedEncodingException {	
		public List<Result> search(@Validated @RequestBody Customer customer) throws ParseException {
	  //public List<Result> search() {
		  List<Customer> customers = service.search(customer.getStartdate(), customer.getName(), customer.getMemo()); 
		  List<Result> results = new ArrayList<Result>();
		  for(Customer customer1 : customers) {
			  Result result = new Result(customer1);
			  
			  result.setFrom(customer1.getStartdate());
			  result.setTo(endDate(customer1.getStartdate()));
			  result.setState(state(customer1.getStartdate()));
			  results.add(result);
		  }
		  return results;
	  }
	  
	  @RequestMapping(value = "{id}", method = RequestMethod.GET)
	  public Customer get(@PathVariable int id) {
		  return service.findOne(id);
	  }
	  
	  @RequestMapping(value="/save",method=RequestMethod.POST)
	  public Customer createUser(@Validated @RequestBody Customer customer) {
	      return service.save(customer);
	  }

	  @RequestMapping(value="/delete",method=RequestMethod.POST)
	  public Customer del(@Validated @RequestBody List<Customer> customers) {
		for(Customer customer : customers) {
		    service.delete(customer.getId());
		}
		Customer customer = new Customer();
		return customer;
	  }
	  
	  @RequestMapping(value="/init", method=RequestMethod.GET)
	  public List<Result> init() throws ParseException {
		  List<Customer> customers = service.search(starMonth(), null, null); 
		  
		  List<Result> results = new ArrayList<Result>();
		  for(Customer customer : customers) {
			  Result result = new Result(customer);
			  result.setFrom(customer.getStartdate());
			  result.setTo(endDate(customer.getStartdate()));
			  result.setState(state(customer.getStartdate()));
			  int pweek = passweek(customer.getStartdate());
			  result.setSite("/" + customer.getId() + "?week=" + pweek);
			  results.add(result);
		  }
		  return results;
	  }
	  private String endDate(String startDate) {
		  String year = startDate.substring(0, 4);
		  String month = startDate.substring(5, 7);
		  String day = startDate.substring(8, 10);
		  
		  Calendar calendar = Calendar.getInstance();
		  calendar.set(Integer.parseInt(year), Integer.parseInt(month), Integer.parseInt(day));			  
		  calendar.add(Calendar.MONTH, 4);
		  return String.format("%04d/%02d/%02d", calendar.get(Calendar.YEAR), calendar.get(Calendar.MONTH) + 1, calendar.get(Calendar.DATE));
		  
	  }
	  private int passweek(String startDate) throws ParseException {
	        Calendar c = Calendar.getInstance();
	        SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy/MM/dd");
			String toDate = sdf1.format(c.getTime());
		    String strform = String.format("%s", startDate);
		    String strto = String.format("%s", toDate);
	        SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
		    //日数の計算
		    //Date frome1 = DateFormat.getDateInstance().parse(strform);
	        Date frome1 = sdf.parse(strform);

		    Calendar calFrom1 = Calendar.getInstance();
		    calFrom1.setTime(frome1);

		    Calendar calTo = Calendar.getInstance(); 
	        Date to1 = sdf.parse(strto);
		    //Date to1 = DateFormat.getDateInstance().parse(strto);
		    calTo.setTime(to1);

		    long diffTime = calTo.getTimeInMillis() - calFrom1.getTimeInMillis();
			long wpass = diffTime / ((1000 * 60 * 60 * 24)*7);
		  return (int)wpass;
	  }
	  private String state(String startDate) throws ParseException {
	        //現在日時を取得する
	        Calendar c = Calendar.getInstance();
	        SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy/MM/dd");
			//月数の計算
			String toDate = sdf1.format(c.getTime());
		    String strform = String.format("%s", startDate);
		    String strto = String.format("%s", toDate);
		    SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
//		    Date from = DateFormat.getDateInstance().parse(strform);
//		    Date to = DateFormat.getDateInstance().parse(strto);
	        Date from = sdf.parse(strform);
	        Date to = sdf.parse(strto);
	        int pasweek = passweek(startDate);
		    long diffTime = to.getTime() - from.getTime();
			long dpass = diffTime -  ( pasweek * (1000 * 60 * 60 * 24 * 7));
			dpass = dpass /  (1000 * 60 * 60 * 24);
		  return String.format("%d週%d日", pasweek, dpass);
	  }
	  private String starMonth() {
		    Calendar calFrom = Calendar.getInstance();
		    calFrom.add(Calendar.MONTH, -3);
	        SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
	        return sdf.format(calFrom.getTime());
	  }
	  //使わない
	  private String state_month(String startDate) throws ParseException {
	        //現在日時を取得する
	        Calendar c = Calendar.getInstance();
	        SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy/MM/dd");
	        
			//月数の計算
			String toDate = sdf1.format(c.getTime());
		    String strform = String.format("%s %s", startDate, "00:00:00");
		    String strto = String.format("%s %s", toDate, "00:00:00");
		    SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
	        Date from = sdf.parse(strform);
	        Date to = sdf.parse(strto);
//		    Date frome = DateFormat.getDateInstance().parse(strform);
//		    Date to = DateFormat.getDateInstance().parse(strto);
		    //Date to = new Date();
		     
		    Calendar calFrom = Calendar.getInstance();
		    calFrom.setTime(from);
		    calFrom.set(Calendar.DATE, 1);
		     
		    Calendar calTo = Calendar.getInstance(); 
		    calTo.setTime(to);
		    calTo.set(Calendar.DATE, 1);
		     
		    int mpass = 0;
		    while (calFrom.before(calTo)) {
		        calFrom.add(Calendar.MONTH, 1);
		        mpass++;
		    }
		    
		    //日数の計算
	        Date frome1 = sdf.parse(strform);
		    //Date frome1 = DateFormat.getDateInstance().parse(strform);
		    Calendar calFrom1 = Calendar.getInstance();
		    calFrom1.setTime(frome1);
//		    calFrom1.set(Calendar.DATE, 1);
		    calFrom1.add(Calendar.MONTH, mpass);

	        Date to1 = sdf.parse(strto);
		    //Date to1 = DateFormat.getDateInstance().parse(strto);
		    //Date to1 = new Date();
		    //Calendar calTo1 = Calendar.getInstance(); 
		    calTo.setTime(to1);
		    
		    long diffTime = calTo.getTimeInMillis() - calFrom1.getTimeInMillis();
			long dpass = diffTime / (1000 * 60 * 60 * 24);

//		    System.out.println( "日数(FROM) : " + sdf.format(frome) );
//		    System.out.println( "日数(TO) : " + sdf.format(to) );
//		    System.out.println( "差分月数 : " + count );
//		    System.out.println( "差分日数 : " + dpass );
		  return String.format("%dヶ月%d日", mpass, dpass);
	  }
}
