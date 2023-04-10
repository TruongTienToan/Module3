package com.codegym.customermanager.service;

import com.codegym.customermanager.model.Customer;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CustomerServiceMySQL extends DBContext implements CustomerService{


    private static final String SELECT_ALL_CUSTOMER = "SELECT * FROM customer";
    private static final String INSERT_CUSTOMER = "INSERT INTO `customer` (`name`, `address`, `email`, `createat`, `image`, `customer_type`) VALUES (?, ?, ?, ?, ?, ?)";
    private static final String FIND_CUSTOMER_BY_ID = "SELECT * FROM customer where id = ?";
    private static final String UPDATE_CUSTOMER = "UPDATE `customer` SET `name` = ?, `address` = ?, `email` = ?, `createat` = ?, `image` = ?, `customer_type` = ? WHERE (`id` = ?);";
    private static final String DELETE_CUSTOMER = "DELETE FROM `customer` WHERE (`id` = ?);";

    @Override
    public List<Customer> findAll() {
        List<Customer> customers = new ArrayList<>();

        Connection connection = getConnection();

        try {
            PreparedStatement preparedStatement = connection.prepareStatement(SELECT_ALL_CUSTOMER);

            ResultSet rs = preparedStatement.executeQuery();

            while (rs.next()) {
                // Luôn lấy theo column label
                Customer customer = getCustomerFromResultSet(rs);
                customers.add(customer);
            }
        } catch (SQLException e) {
            printSQLException(e);
        }
        return customers;
    }

    private Customer getCustomerFromResultSet(ResultSet rs) throws SQLException {
        long id = rs.getLong("id");
        String name = rs.getString("name");
        String email = rs.getString("email");
        String address = rs.getString("address");
        String image = rs.getString("image");
        java.sql.Date date = rs.getDate("createAt");

        long idCustomerType = rs.getLong("customer_type");

        Date createAt = new Date(date.getTime());

        Customer customer = new Customer(id, name, email, address, image, createAt, idCustomerType);
        return customer;
    }

    @Override
    public void save(Customer customer) {
        Connection connection = getConnection();

//        "INSERT INTO `customer` (`name`, `address`, `email`, `createat`,
//        `image`, `customer_type`) VALUES (?, ?, ?, ?, ?, ?)";
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(INSERT_CUSTOMER);
            preparedStatement.setString(1, customer.getName());
            preparedStatement.setString(2, customer.getAddress());
            preparedStatement.setString(3, customer.getEmail());
            preparedStatement.setDate(4, new java.sql.Date(customer.getCreateAt().getTime()));
            preparedStatement.setString(5, customer.getImage());
            preparedStatement.setLong(6, customer.getCustomerType());

            preparedStatement.executeUpdate();

            preparedStatement.close();
        } catch (SQLException e) {
            printSQLException(e);
        }
    }

    @Override
    public Customer findById(long id) {
        Connection connection = getConnection();
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(FIND_CUSTOMER_BY_ID);
            preparedStatement.setLong(1, id);

            ResultSet rs = preparedStatement.executeQuery();

            while (rs.next()) {
                // Luôn lấy theo column label
                Customer customer = getCustomerFromResultSet(rs);
                return customer;
            }
        } catch (SQLException e) {
            printSQLException(e);
        }
        return null;
    }

    @Override
    public void update(long id, Customer customer) {
        Connection connection = getConnection();

        try {
//            UPDATE `customer` SET `name` = ?, `address` = ?, `email` = ?,
//            `createat` = ?, `image` = ?, `customer_type` = ? WHERE (`id` = ?);";
            PreparedStatement preparedStatement = connection.prepareStatement(UPDATE_CUSTOMER);
            preparedStatement.setString(1, customer.getName());
            preparedStatement.setString(2, customer.getAddress());
            preparedStatement.setString(3, customer.getEmail());
            preparedStatement.setDate(4, (Date) customer.getCreateAt());
            preparedStatement.setString(5, customer.getImage());

            preparedStatement.setLong(6, customer.getCustomerType());
            preparedStatement.setLong(7, customer.getId());

            preparedStatement.executeUpdate();

            preparedStatement.close();
        } catch (SQLException e) {
            printSQLException(e);
        }
    }

    @Override
    public void remove(long id) {
        Connection connection = getConnection();

        try {
            PreparedStatement preparedStatement = connection.prepareStatement(DELETE_CUSTOMER);
            preparedStatement.setLong(1, id);

            preparedStatement.executeUpdate();
            preparedStatement.close();
        } catch (SQLException e) {
            printSQLException(e);
        }
    }

    @Override
    public long maxId() {
        return 0;
    }
}
