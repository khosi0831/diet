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

import com.diet.entity.Photo;


@Repository
public class PhotoRepository {

    @Autowired
    private NamedParameterJdbcTemplate jdbcTemplate;

    public List<Photo> findAll() {

        return jdbcTemplate.query(
                "SELECT * FROM photo ORDER BY id desc",
                new BeanPropertyRowMapper<Photo>(Photo.class));
    }

    public Photo findOne(Integer id) {

        SqlParameterSource param = new MapSqlParameterSource().addValue("id", id);

        try {
            return jdbcTemplate.queryForObject(
                    "SELECT * FROM photo WHERE id = :id",
                    param,
                    new BeanPropertyRowMapper<Photo>(Photo.class));
        } catch (EmptyResultDataAccessException e) {
            return null;
        }
    }
    public List<Photo> get(Integer id, Integer week) {

        SqlParameterSource param = new MapSqlParameterSource()
        		.addValue("userid", id)
				.addValue("week", week);

        try {
            return jdbcTemplate.query(
                    "SELECT * FROM photo WHERE userId = :userid and week = :week",
                    param,
                    new BeanPropertyRowMapper<Photo>(Photo.class));
        } catch (EmptyResultDataAccessException e) {
            return null;
        }
    }

    public Photo save(Photo photo) {

        SqlParameterSource param = new BeanPropertySqlParameterSource(photo);

        if (photo.getId() == null) {

            SimpleJdbcInsert insert =
                    new SimpleJdbcInsert((JdbcTemplate) jdbcTemplate.getJdbcOperations())
                            .withTableName("photo")
                            .usingGeneratedKeyColumns("id");

            Number key = insert.executeAndReturnKey(param);
            photo.setId(key.intValue());
        } else {
        	StringBuilder sb = new StringBuilder();
        	sb.append("UPDATE photo SET ");
        	sb.append(",userId = :userId"); 
        	sb.append(",dspweek = :dspweek");
        	sb.append(",seqno = :seqno");
        	sb.append(",photo = :photo");
            jdbcTemplate.update(sb.toString(),param);            
        }

        return photo;
    }

    public void delete(Integer id) {

        SqlParameterSource param = new MapSqlParameterSource().addValue("id", id);

        jdbcTemplate.update(
                "DELETE FROM photo WHERE id = :id",
                param);
    }


    public void deleteAll() {

        jdbcTemplate.update("DELETE FROM photo", new HashMap<>());
    }


}
