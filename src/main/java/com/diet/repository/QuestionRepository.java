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

import com.diet.entity.Question;


@Repository
public class QuestionRepository {

    @Autowired
    private NamedParameterJdbcTemplate jdbcTemplate;

    public List<Question> findAll() {

        return jdbcTemplate.query(
                "SELECT * FROM question order by seqno",
                new BeanPropertyRowMapper<Question>(Question.class));
    }

    public Question findOne(Integer id) {

        SqlParameterSource param = new MapSqlParameterSource().addValue("id", id);

        try {
            return jdbcTemplate.queryForObject(
                    "SELECT * FROM question WHERE id = :id order by seqno",
                    param,
                    new BeanPropertyRowMapper<Question>(Question.class));
        } catch (EmptyResultDataAccessException e) {
            return null;
        }
    }

    public Question save(Question question) {

        SqlParameterSource param = new BeanPropertySqlParameterSource(question);

        if (question.getId() == null) {

            SimpleJdbcInsert insert =
                    new SimpleJdbcInsert((JdbcTemplate) jdbcTemplate.getJdbcOperations())
                            .withTableName("question")
                            .usingGeneratedKeyColumns("id");

            Number key = insert.executeAndReturnKey(param);
            question.setId(key.intValue());
        } else {
        	StringBuilder sb = new StringBuilder();
        	sb.append("UPDATE question SET ");
        	sb.append(",seqno = :seqno"); 
        	sb.append(",question = :question");
        	sb.append(" where id = :id");
            jdbcTemplate.update(sb.toString(),param);            
        }

        return question;
    }

    public void delete(Integer id) {

        SqlParameterSource param = new MapSqlParameterSource().addValue("id", id);

        jdbcTemplate.update(
                "DELETE FROM question WHERE id = :id",
                param);
    }


    public void deleteAll() {

        jdbcTemplate.update("DELETE FROM question", new HashMap<>());
    }
}
