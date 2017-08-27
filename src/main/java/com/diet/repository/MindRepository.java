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

import com.diet.entity.Mind;


@Repository
public class MindRepository {
    @Autowired
    private NamedParameterJdbcTemplate jdbcTemplate;

    public List<Mind> findAll() {

        return jdbcTemplate.query(
                "SELECT * FROM mind ORDER BY id desc",
                new BeanPropertyRowMapper<Mind>(Mind.class));
    }

    public Mind findOne(Integer id) {

        SqlParameterSource param = new MapSqlParameterSource().addValue("id", id);

        try {
            return jdbcTemplate.queryForObject(
                    "SELECT * FROM mind WHERE id = :id",
                    param,
                    new BeanPropertyRowMapper<Mind>(Mind.class));
        } catch (EmptyResultDataAccessException e) {
            return null;
        }
    }

    public Mind get(Integer id) {

        SqlParameterSource param = new MapSqlParameterSource().addValue("userid", id);

        try {
            return jdbcTemplate.queryForObject(
                    "SELECT * FROM mind WHERE userId = :userid",
                    param,
                    new BeanPropertyRowMapper<Mind>(Mind.class));
        } catch (EmptyResultDataAccessException e) {
            return null;
        }
    }
    
    public Mind get(Integer id, Integer week) {

        SqlParameterSource param = new MapSqlParameterSource()
        		.addValue("userid", id)
				.addValue("week", week);

        try {
            return jdbcTemplate.queryForObject(
                    "SELECT * FROM mind WHERE userId = :userid and week = :week",
                    param,
                    new BeanPropertyRowMapper<Mind>(Mind.class));
        } catch (EmptyResultDataAccessException e) {
            return new Mind();
        }
    }
    
    
    public Mind save(Mind mind) {

        SqlParameterSource param = new BeanPropertySqlParameterSource(mind);

        if (mind.getId() == null) {

            SimpleJdbcInsert insert =
                    new SimpleJdbcInsert((JdbcTemplate) jdbcTemplate.getJdbcOperations())
                            .withTableName("mind")
                            .usingGeneratedKeyColumns("id");

            Number key = insert.executeAndReturnKey(param);
            mind.setId(key.intValue());
        } else {
        	StringBuilder sb = new StringBuilder();
        	sb.append("UPDATE mind SET ");
        	sb.append("userId = :userId"); 
        	sb.append(",week = :week");
        	sb.append(",memo = :memo");
        	sb.append(" where id = :id");
            jdbcTemplate.update(sb.toString(),param);
        }

        return mind;
    }

    public void delete(Integer id) {

        SqlParameterSource param = new MapSqlParameterSource().addValue("id", id);

        jdbcTemplate.update(
                "DELETE FROM mind WHERE userid = :id",
                param);
    }


    public void deleteAll() {

        jdbcTemplate.update("DELETE FROM mind", new HashMap<>());
    }

}
