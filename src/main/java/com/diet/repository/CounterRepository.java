package com.diet.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.diet.entity.Counter;

public interface CounterRepository extends JpaRepository<Counter, Integer> {
}
