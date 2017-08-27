package com.diet.repository;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.namedparam.BeanPropertySqlParameterSource;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.jdbc.core.namedparam.SqlParameterSource;
import org.springframework.jdbc.core.simple.SimpleJdbcInsert;
import org.springframework.stereotype.Repository;

import com.diet.entity.Customer;



@Repository
public class CustomerRepository {

    @Autowired
    private NamedParameterJdbcTemplate jdbcTemplate;

    public List<Customer> findAll() {

        return jdbcTemplate.query(
                "SELECT * FROM customer ORDER BY id desc",
                new BeanPropertyRowMapper<Customer>(Customer.class));
    }
     
    public List<Customer> search(String startDate, String name, String keyword) {
        SqlParameterSource param = new MapSqlParameterSource().addValue("startDate", startDate)
        .addValue("name", "%" + name + "%")
        .addValue("keyword", "%" + keyword + "%");

    	StringBuilder sb = new StringBuilder();
    	sb.append("SELECT * FROM customer");
    	sb.append(" where 1 = 1 ");
    	if ( name != null && name.length() > 0) {
    		//String str = String.format(" and name like '%%s%'", name);
    		String str = " and name like '%" + name + "%'";
        	sb.append(str);
    	}
    	if ( startDate != null && startDate.length() > 0) {
        	String str = String.format(" and to_date(startdate, 'yyyy/mm/dd') >= to_date('%s', 'yyyy/mm/dd')", startDate);
        	sb.append(str);
    	}
    	if ( keyword != null && keyword.length() > 0) {
    		String str = " and memo like '%" + keyword + "%'";
        	sb.append(str);
    	}
//    	String.format("and to_date(startdate, 'yyyy/mm/dd') > to_date('%s', 'yyyy/mm/dd')", startDate);
//    	String str = "select * from customer where to_date(startdate, 'yyyy/mm/dd') > to_date('2017/08/01', 'yyyy/mm/dd')";
//        return jdbcTemplate.query(
//                "SELECT * FROM customer ORDER BY id desc",
//                new BeanPropertyRowMapper<Customer>(Customer.class));
        return jdbcTemplate.query(
        		sb.toString(),
                param,
                new BeanPropertyRowMapper<Customer>(Customer.class));
        
    }

    public Customer findOne(Integer id) {

        SqlParameterSource param = new MapSqlParameterSource().addValue("id", id);

        try {
            return jdbcTemplate.queryForObject(
                    "SELECT * FROM customer WHERE id = :id",
                    param,
                    new BeanPropertyRowMapper<Customer>(Customer.class));
        } catch (EmptyResultDataAccessException e) {
            return null;
        }
    }

    public Customer findOne(String name) {

        SqlParameterSource param = new MapSqlParameterSource().addValue("name", name);

        try {
            return jdbcTemplate.queryForObject(
                    "SELECT * FROM customer WHERE name = :name",
                    param,
                    new BeanPropertyRowMapper<Customer>(Customer.class));
        } catch (EmptyResultDataAccessException e) {
            return null;
        }
    }
    
    public Customer save(Customer customer) {

        SqlParameterSource param = new BeanPropertySqlParameterSource(customer);

        Date now = new Date();
        if (customer.getId() == null) {
  		  customer.setCreatedate(now);
  		  customer.setUpdate(now);
  		  customer.setId(1);
            SimpleJdbcInsert insert =
                    new SimpleJdbcInsert((JdbcTemplate) jdbcTemplate.getJdbcOperations())
                            .withTableName("customer")
                            .usingGeneratedKeyColumns("id");

            Number key = insert.executeAndReturnKey(param);
            customer.setId(key.intValue());
        } else {
    		customer.setUpdate(now);
        	StringBuilder sb = new StringBuilder();
        	sb.append("UPDATE customer SET ");
        	sb.append("name = :name"); 
        	sb.append(",email = :email"); 
        	sb.append(",address = :address");
        	sb.append(",startdate = :startdate");
        	sb.append(",memo = :memo");
        	sb.append(",favorite = :favorite");
        	sb.append(",createdate = :createdate");
        	sb.append(",update = :update");
        	sb.append(" where id = :id");
            jdbcTemplate.update(sb.toString(),param);
        }

        return customer;
    }

    public void delete(Integer id) {

        SqlParameterSource param = new MapSqlParameterSource().addValue("id", id);

        jdbcTemplate.update(
                "DELETE FROM customer WHERE id = :id",
                param);
    }


    public void deleteAll() {

        jdbcTemplate.update("DELETE FROM customer", new HashMap<>());
    }
}