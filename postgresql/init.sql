-- Drop existing tables if any
DROP TABLE IF EXISTS salaries, addresses, employees, departments CASCADE;

-- 1. Departments
CREATE TABLE departments (
  department_id SERIAL PRIMARY KEY,
  name VARCHAR(100) NOT NULL
);

INSERT INTO departments (name) VALUES
  ('Engineering'),
  ('HR'),
  ('Sales'),
  ('Finance');

-- 2. Employees
CREATE TABLE employees (
  employee_id SERIAL PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  email VARCHAR(100) UNIQUE NOT NULL,
  department_id INT REFERENCES departments(department_id),
  hire_date DATE NOT NULL
);

INSERT INTO employees (name, email, department_id, hire_date) VALUES
  ('Alice Smith', 'alice@example.com', 1, '2020-01-15'),
  ('Bob Johnson', 'bob@example.com', 2, '2019-03-22'),
  ('Carol Lee', 'carol@example.com', 1, '2021-07-01'),
  ('David Kim', 'david@example.com', 3, '2018-11-11'),
  ('Eve Patel', 'eve@example.com', 4, '2022-05-05');

-- 3. Addresses
CREATE TABLE addresses (
  address_id SERIAL PRIMARY KEY,
  employee_id INT REFERENCES employees(employee_id),
  street VARCHAR(200),
  city VARCHAR(100),
  state VARCHAR(50),
  postal_code VARCHAR(20)
);

INSERT INTO addresses (employee_id, street, city, state, postal_code) VALUES
  (1, '123 Maple St', 'New York', 'NY', '10001'),
  (2, '456 Oak Ave', 'Los Angeles', 'CA', '90001'),
  (3, '789 Pine Rd', 'Chicago', 'IL', '60601'),
  (4, '321 Birch Ln', 'Houston', 'TX', '77001'),
  (5, '654 Cedar Blvd', 'Miami', 'FL', '33101');

-- 4. Salaries
CREATE TABLE salaries (
  salary_id SERIAL PRIMARY KEY,
  employee_id INT REFERENCES employees(employee_id),
  amount NUMERIC(10, 2),
  effective_date DATE NOT NULL
);

INSERT INTO salaries (employee_id, amount, effective_date) VALUES
  (1, 75000.00, '2023-01-01'),
  (2, 60000.00, '2023-01-01'),
  (3, 85000.00, '2023-01-01'),
  (4, 55000.00, '2023-01-01'),
  (5, 70000.00, '2023-01-01');
