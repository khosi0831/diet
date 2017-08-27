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

import com.diet.entity.Weight;


@Repository
public class WeightRepository {

    @Autowired
    private NamedParameterJdbcTemplate jdbcTemplate;

    public List<Weight> findAll() {

        return jdbcTemplate.query(
                "SELECT * FROM weight ORDER BY id desc",
                new BeanPropertyRowMapper<Weight>(Weight.class));
    }

    public Weight findOne(Integer id) {

        SqlParameterSource param = new MapSqlParameterSource().addValue("id", id);

        try {
            return jdbcTemplate.queryForObject(
                    "SELECT * FROM weight WHERE id = :id",
                    param,
                    new BeanPropertyRowMapper<Weight>(Weight.class));
        } catch (EmptyResultDataAccessException e) {
            return null;
        }
    }

    public Weight find(Integer id) {

        SqlParameterSource param = new MapSqlParameterSource().addValue("userid", id);

        try {
            return jdbcTemplate.queryForObject(
                    "SELECT * FROM weight WHERE userid = :userid",
                    param,
                    new BeanPropertyRowMapper<Weight>(Weight.class));
        } catch (EmptyResultDataAccessException e) {
            return null;
        }
    }

    public Weight save(Weight weight) {

        SqlParameterSource param = new BeanPropertySqlParameterSource(weight);

        if (weight.getId() == null) {

            SimpleJdbcInsert insert =
                    new SimpleJdbcInsert((JdbcTemplate) jdbcTemplate.getJdbcOperations())
                            .withTableName("weight")
                            .usingGeneratedKeyColumns("id");

            Number key = insert.executeAndReturnKey(param);
            weight.setId(key.intValue());
        } else {
        	StringBuilder sb = new StringBuilder();
        	sb.append("UPDATE weight SET ");
        	sb.append("userId = :userId"); 
        	sb.append(",w0 = :w0");
        	sb.append(",w1 = :w1");
        	sb.append(",w2 = :w2");
        	sb.append(",w3 = :w3");
        	sb.append(",w4 = :w4");
        	sb.append(",w5 = :w5");
        	sb.append(",w6 = :w6");
        	sb.append(",w7 = :w7");
        	sb.append(",w8 = :w8");
        	sb.append(",w9 = :w9");
        	sb.append(",w10 = :w10");
        	sb.append(",w11 = :w11");
        	sb.append(",w12 = :w12");
          	sb.append(",wmax1 = :wmax1");
          	sb.append(",wmax2 = :wmax2");
          	sb.append(",wmax3 = :wmax3");
          	sb.append(",wmax4 = :wmax4");
          	sb.append(",wmax5 = :wmax5");
          	sb.append(",wmax6 = :wmax6");
          	sb.append(",wmax7 = :wmax7");
          	sb.append(",wmax8 = :wmax8");
          	sb.append(",wmax9 = :wmax9");
          	sb.append(",wmax10 = :wmax10");
          	sb.append(",wmax11 = :wmax11");
          	sb.append(",wmax12 = :wmax12");
            sb.append(",wmin1 = :wmin1");
            sb.append(",wmin2 = :wmin2");
            sb.append(",wmin3 = :wmin3");
            sb.append(",wmin4 = :wmin4");
            sb.append(",wmin5 = :wmin5");
            sb.append(",wmin6 = :wmin6");
            sb.append(",wmin7 = :wmin7");
            sb.append(",wmin8 = :wmin8");
            sb.append(",wmin9 = :wmin9");
            sb.append(",wmin10 = :wmin10");
            sb.append(",wmin11 = :wmin11");
            sb.append(",wmin12 = :wmin12");
            sb.append(",wscale1 = :wscale1");
            sb.append(",wscale2 = :wscale2");
            sb.append(",wscale3 = :wscale3");
            sb.append(",wscale4 = :wscale4");
            sb.append(",wscale5 = :wscale5");
            sb.append(",wscale6 = :wscale6");
            sb.append(",wscale7 = :wscale7");
            sb.append(",wscale8 = :wscale8");
            sb.append(",wscale9 = :wscale9");
            sb.append(",wscale10 = :wscale10");
            sb.append(",wscale11 = :wscale11");
            sb.append(",wscale12 = :wscale12");
        	sb.append(",m0 = :m0");
        	sb.append(",m1 = :m1");
        	sb.append(",m2 = :m2");
        	sb.append(",m3 = :m3");
        	sb.append(",m4 = :m4");
        	sb.append(",m5 = :m5");
        	sb.append(",m6 = :m6");
        	sb.append(",m7 = :m7");
        	sb.append(",m8 = :m8");
        	sb.append(",m9 = :m9");
        	sb.append(",m10 = :m10");
        	sb.append(",m11 = :m11");
        	sb.append(",m12 = :m12");
          	sb.append(",mmax1 = :mmax1");
          	sb.append(",mmax2 = :mmax2");
          	sb.append(",mmax3 = :mmax3");
          	sb.append(",mmax4 = :mmax4");
          	sb.append(",mmax5 = :mmax5");
          	sb.append(",mmax6 = :mmax6");
          	sb.append(",mmax7 = :mmax7");
          	sb.append(",mmax8 = :mmax8");
          	sb.append(",mmax9 = :mmax9");
          	sb.append(",mmax10 = :mmax10");
          	sb.append(",mmax11 = :mmax11");
          	sb.append(",mmax12 = :mmax12");
            sb.append(",mmin1 = :mmin1");
            sb.append(",mmin2 = :mmin2");
            sb.append(",mmin3 = :mmin3");
            sb.append(",mmin4 = :mmin4");
            sb.append(",mmin5 = :mmin5");
            sb.append(",mmin6 = :mmin6");
            sb.append(",mmin7 = :mmin7");
            sb.append(",mmin8 = :mmin8");
            sb.append(",mmin9 = :mmin9");
            sb.append(",mmin10 = :mmin10");
            sb.append(",mmin11 = :mmin11");
            sb.append(",mmin12 = :mmin12");
            sb.append(",mscale1 = :mscale1");
            sb.append(",mscale2 = :mscale2");
            sb.append(",mscale3 = :mscale3");
            sb.append(",mscale4 = :mscale4");
            sb.append(",mscale5 = :mscale5");
            sb.append(",mscale6 = :mscale6");
            sb.append(",mscale7 = :mscale7");
            sb.append(",mscale8 = :mscale8");
            sb.append(",mscale9 = :mscale9");
            sb.append(",mscale10 = :mscale10");
            sb.append(",mscale11 = :mscale11");
            sb.append(",mscale12 = :mscale12");
        	sb.append(" where id = :id");
            jdbcTemplate.update(sb.toString(),param);            
        }

        return weight;
    }

    public void delete(Integer id) {

        SqlParameterSource param = new MapSqlParameterSource().addValue("id", id);

        jdbcTemplate.update(
                "DELETE FROM weight WHERE userid = :id",
                param);
    }


    public void deleteAll() {

        jdbcTemplate.update("DELETE FROM weight", new HashMap<>());
    }

}
