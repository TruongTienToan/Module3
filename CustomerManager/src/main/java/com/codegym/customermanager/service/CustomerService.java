package com.codegym.customermanager.service;

import com.codegym.customermanager.model.Customer;

import java.util.List;

public interface CustomerService {
    List<Customer> findAll();
    void save(Customer customer);
    Customer findById(long id);
    void update(long id, Customer customer);
    void remove(long id);
    long maxId();
}
