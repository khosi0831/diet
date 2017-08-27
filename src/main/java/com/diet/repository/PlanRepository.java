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

import com.diet.entity.Plan;

@Repository
public class PlanRepository {

    @Autowired
    private NamedParameterJdbcTemplate jdbcTemplate;

    public List<Plan> findAll() {

        return jdbcTemplate.query(
                "SELECT * FROM plan ORDER BY id desc",
                new BeanPropertyRowMapper<Plan>(Plan.class));
    }

    public List<Plan> find(Integer id) {

        SqlParameterSource param = new MapSqlParameterSource().addValue("userid", id);

        try {
            return jdbcTemplate.query(
                    "SELECT * FROM plan WHERE userid = :userid order by id",
                    param,
                    new BeanPropertyRowMapper<Plan>(Plan.class));
        } catch (EmptyResultDataAccessException e) {
            return null;
        }
    }

    public Plan save(Plan plan) {

        SqlParameterSource param = new BeanPropertySqlParameterSource(plan);

        if (plan.getId() == null) {

            SimpleJdbcInsert insert =
                    new SimpleJdbcInsert((JdbcTemplate) jdbcTemplate.getJdbcOperations())
                            .withTableName("plan")
                            .usingGeneratedKeyColumns("id");

            Number key = insert.executeAndReturnKey(param);
            plan.setId(key.intValue());
        } else {
        	StringBuilder sb = new StringBuilder();
        	sb.append("UPDATE plan SET ");
        	sb.append("userId = :userId"); 
        	sb.append(",week = :week"); 
        	sb.append(",plan = :plan");
        	sb.append(" where id = :id ");
            jdbcTemplate.update(sb.toString(),param);
        }

        return plan;
    }

    public void delete(Integer id) {

        SqlParameterSource param = new MapSqlParameterSource().addValue("id", id);

        jdbcTemplate.update(
                "DELETE FROM plan WHERE userid = :id",
                param);
    }


    public void deleteAll() {

        jdbcTemplate.update("DELETE FROM plan", new HashMap<>());
    }

}
