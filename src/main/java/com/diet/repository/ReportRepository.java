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

import com.diet.entity.Report;


@Repository
public class ReportRepository {

    @Autowired
    private NamedParameterJdbcTemplate jdbcTemplate;

    public List<Report> findAll() {

        return jdbcTemplate.query(
                "SELECT * FROM report ORDER BY id desc",
                new BeanPropertyRowMapper<Report>(Report.class));
    }

    public List<Report> find(Integer id) {

        SqlParameterSource param = new MapSqlParameterSource().addValue("userid", id);

        try {
            return jdbcTemplate.query(
                    "SELECT * FROM report WHERE userid = :userid order by seqno",
                    param,
                    new BeanPropertyRowMapper<Report>(Report.class));
        } catch (EmptyResultDataAccessException e) {
            return null;
        }
    }
    
    public Report findOne(Integer id) {

        SqlParameterSource param = new MapSqlParameterSource().addValue("id", id);

        try {
            return jdbcTemplate.queryForObject(
                    "SELECT * FROM report WHERE id = :id",
                    param,
                    new BeanPropertyRowMapper<Report>(Report.class));
        } catch (EmptyResultDataAccessException e) {
            return null;
        }
    }

    public Report save(Report report) {

        SqlParameterSource param = new BeanPropertySqlParameterSource(report);

        if (report.getId() == null) {

            SimpleJdbcInsert insert =
                    new SimpleJdbcInsert((JdbcTemplate) jdbcTemplate.getJdbcOperations())
                            .withTableName("report")
                            .usingGeneratedKeyColumns("id");

            Number key = insert.executeAndReturnKey(param);
            report.setId(key.intValue());
        } else {
        	StringBuilder sb = new StringBuilder();
        	sb.append("UPDATE report SET ");
        	sb.append("userId = :userId"); 
        	sb.append(",seqno = :seqno"); 
        	sb.append(",question = :question");
        	sb.append(",answer = :answer");
        	sb.append(" where id = :id ");
            jdbcTemplate.update(sb.toString(),param);            
        }

        return report;
    }

    public void delete(Integer id) {

        SqlParameterSource param = new MapSqlParameterSource().addValue("id", id);

        jdbcTemplate.update(
                "DELETE FROM report WHERE userid = :id",
                param);
    }


    public void deleteAll() {

        jdbcTemplate.update("DELETE FROM report", new HashMap<>());
    }

}
