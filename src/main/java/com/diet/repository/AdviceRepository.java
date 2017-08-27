package com.diet.repository;

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

import com.diet.entity.Advice;


@Repository
public class AdviceRepository {
    @Autowired
    private NamedParameterJdbcTemplate jdbcTemplate;

    public List<Advice> findAll() {

        return jdbcTemplate.query(
                "SELECT * FROM advice ORDER BY id desc",
                new BeanPropertyRowMapper<Advice>(Advice.class));
    }

    public Advice findOne(Integer id) {

        SqlParameterSource param = new MapSqlParameterSource().addValue("id", id);

        try {
            return jdbcTemplate.queryForObject(
                    "SELECT * FROM advice WHERE id = :id",
                    param,
                    new BeanPropertyRowMapper<Advice>(Advice.class));
        } catch (EmptyResultDataAccessException e) {
            return null;
        }
    }
    
    public Advice get(Integer id) {

        SqlParameterSource param = new MapSqlParameterSource().addValue("userid", id);

        try {
            return jdbcTemplate.queryForObject(
                    "SELECT * FROM advice WHERE userId = :userid",
                    param,
                    new BeanPropertyRowMapper<Advice>(Advice.class));
        } catch (EmptyResultDataAccessException e) {
            return null;
        }
    }
    
    public Advice get(Integer id, Integer week) {

        SqlParameterSource param = new MapSqlParameterSource()
        		.addValue("userid", id)
				.addValue("week", week);

        try {
            return jdbcTemplate.queryForObject(
                    "SELECT * FROM advice WHERE userId = :userid and week = :week",
                    param,
                    new BeanPropertyRowMapper<Advice>(Advice.class));
        } catch (EmptyResultDataAccessException e) {
            return new Advice();
        }
    }
    

    public Advice save(Advice advice) {

        SqlParameterSource param = new BeanPropertySqlParameterSource(advice);

        if (advice.getId() == null) {

            SimpleJdbcInsert insert =
                    new SimpleJdbcInsert((JdbcTemplate) jdbcTemplate.getJdbcOperations())
                            .withTableName("advice")
                            .usingGeneratedKeyColumns("id");

            Number key = insert.executeAndReturnKey(param);
            advice.setId(key.intValue());
        } else {
        	StringBuilder sb = new StringBuilder();
        	sb.append("UPDATE advice SET ");
        	sb.append("userId = :userId"); 
        	sb.append(",week = :week");
        	sb.append(",memo = :memo");
        	sb.append(" where id = :id");
        	
            jdbcTemplate.update(sb.toString(),param);
        }

        return advice;
    }

    public void delete(Integer id) {

        SqlParameterSource param = new MapSqlParameterSource().addValue("id", id);

        jdbcTemplate.update(
                "DELETE FROM advice WHERE userid = :id",
                param);
    }


    public void deleteAll() {

        jdbcTemplate.update("DELETE FROM advice", new HashMap<>());
    }
}
