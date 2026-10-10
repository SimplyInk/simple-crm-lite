package com.example.simple_crm_lite.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.example.simple_crm_lite.model.Customer;

@Repository
public interface CustomerRepository extends JpaRepository<Customer, Long> {
}    