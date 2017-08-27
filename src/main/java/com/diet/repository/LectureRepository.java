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

import com.diet.entity.Lecture;

@Repository
public class LectureRepository {

    @Autowired
    private NamedParameterJdbcTemplate jdbcTemplate;

    public List<Lecture> findAll() {

        return jdbcTemplate.query(
                "SELECT * FROM lecture ORDER BY id desc",
                new BeanPropertyRowMapper<Lecture>(Lecture.class));
    }

    public Lecture findOne(Integer id) {

        SqlParameterSource param = new MapSqlParameterSource().addValue("id", id);

        try {
            return jdbcTemplate.queryForObject(
                    "SELECT * FROM lecture WHERE id = :id",
                    param,
                    new BeanPropertyRowMapper<Lecture>(Lecture.class));
        } catch (EmptyResultDataAccessException e) {
            return null;
        }
    }

    public Lecture get(Integer id) {

        SqlParameterSource param = new MapSqlParameterSource().addValue("userid", id);

        try {
            return jdbcTemplate.queryForObject(
                    "SELECT * FROM lecture WHERE userId = :userid",
                    param,
                    new BeanPropertyRowMapper<Lecture>(Lecture.class));
        } catch (EmptyResultDataAccessException e) {
            return null;
        }
    }
    
    public Lecture get(Integer id, Integer week) {

        SqlParameterSource param = new MapSqlParameterSource()
        		.addValue("userid", id)
				.addValue("week", week);

        try {
            return jdbcTemplate.queryForObject(
                    "SELECT * FROM lecture WHERE userId = :userid and week = :week",
                    param,
                    new BeanPropertyRowMapper<Lecture>(Lecture.class));
        } catch (EmptyResultDataAccessException e) {
            return new Lecture();
        }
    }
    
    public Lecture save(Lecture lecture) {

        SqlParameterSource param = new BeanPropertySqlParameterSource(lecture);

        if (lecture.getId() == null) {

            SimpleJdbcInsert insert =
                    new SimpleJdbcInsert((JdbcTemplate) jdbcTemplate.getJdbcOperations())
                            .withTableName("lecture")
                            .usingGeneratedKeyColumns("id");

            Number key = insert.executeAndReturnKey(param);
            lecture.setId(key.intValue());
        } else {
        	StringBuilder sb = new StringBuilder();
        	sb.append("UPDATE lecture SET ");
        	sb.append("userId = :userId"); 
        	sb.append(",week = :week");
        	sb.append(",memo = :memo");
        	sb.append(" where id = :id");
            jdbcTemplate.update(sb.toString(),param);            
        }

        return lecture;
    }

    public void delete(Integer id) {

        SqlParameterSource param = new MapSqlParameterSource().addValue("id", id);

        jdbcTemplate.update(
                "DELETE FROM lecture WHERE userid = :id",
                param);
    }


    public void deleteAll() {

        jdbcTemplate.update("DELETE FROM lecture", new HashMap<>());
    }

}
