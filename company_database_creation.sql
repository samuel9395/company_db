-- ==========================================================
-- SCRIPT DE CRIAÇÃO DO BANCO DE DADOS COMPANY
-- ==========================================================
-- Contém:
-- - Criação do banco
-- - Criação das tabelas
-- - Primary Keys
-- - Foreign Keys
-- ==========================================================

-- ==========================================================
-- CRIAÇÃO DO BANCO
-- ==========================================================

DROP DATABASE IF EXISTS company;
CREATE DATABASE company;
USE company;

-- ==========================================================
-- TABELA: department
-- ==========================================================

CREATE TABLE department (
    dnumber INT NOT NULL,
    dname VARCHAR(15) UNIQUE,
    mgr_ssn CHAR(9),
    mgr_start_date DATE,
    
    PRIMARY KEY (dnumber)
);

-- ==========================================================
-- TABELA: employee
-- ==========================================================

CREATE TABLE employee (
    fname VARCHAR(15) NOT NULL,
    minit CHAR(1),
    lname VARCHAR(15) NOT NULL,
    ssn CHAR(9) NOT NULL,
    bdate DATE,
    address VARCHAR(30),
    sex CHAR(1),
    salary DECIMAL(10,2),
    super_ssn CHAR(9),
    dno INT NOT NULL,
    
    PRIMARY KEY (ssn),
    
    CONSTRAINT fk_employee_department
        FOREIGN KEY (dno)
        REFERENCES department(dnumber)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
        
    CONSTRAINT fk_employee_supervisor
        FOREIGN KEY (super_ssn)
        REFERENCES employee(ssn)
        ON DELETE SET NULL
        ON UPDATE CASCADE
);

-- ==========================================================
-- TABELA: dept_locations
-- ==========================================================

CREATE TABLE dept_locations (
    dnumber INT NOT NULL,
    dlocation VARCHAR(15) NOT NULL,
    
    PRIMARY KEY (dnumber, dlocation),
    
    CONSTRAINT fk_dept_locations_department
        FOREIGN KEY (dnumber)
        REFERENCES department(dnumber)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- ==========================================================
-- TABELA: project
-- ==========================================================

CREATE TABLE project (
    pname VARCHAR(15) UNIQUE NOT NULL,
    pnumber INT NOT NULL,
    plocation VARCHAR(15),
    dnum INT NOT NULL,
    
    PRIMARY KEY (pnumber),
    
    CONSTRAINT fk_project_department
        FOREIGN KEY (dnum)
        REFERENCES department(dnumber)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- ==========================================================
-- TABELA: works_on
-- ==========================================================

CREATE TABLE works_on (
    essn CHAR(9) NOT NULL,
    pno INT NOT NULL,
    hours DECIMAL(3,1),
    
    PRIMARY KEY (essn, pno),
    
    CONSTRAINT fk_works_on_employee
        FOREIGN KEY (essn)
        REFERENCES employee(ssn)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
        
    CONSTRAINT fk_works_on_project
        FOREIGN KEY (pno)
        REFERENCES project(pnumber)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- ==========================================================
-- TABELA: dependent
-- ==========================================================

CREATE TABLE dependent (
    essn CHAR(9) NOT NULL,
    dependent_name VARCHAR(15) NOT NULL,
    sex CHAR(1),
    bdate DATE,
    relationship VARCHAR(8),
    
    PRIMARY KEY (essn, dependent_name),
    
    CONSTRAINT fk_dependent_employee
        FOREIGN KEY (essn)
        REFERENCES employee(ssn)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- ==========================================================
-- TABELA: salary_log
-- ==========================================================

CREATE TABLE salary_log (
    id INT AUTO_INCREMENT,
    ssn CHAR(9),
    old_salary DECIMAL(10,2),
    new_salary DECIMAL(10,2),
    changed_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    
    PRIMARY KEY (id),
    
    CONSTRAINT fk_salary_log_employee
        FOREIGN KEY (ssn)
        REFERENCES employee(ssn)
        ON DELETE SET NULL
        ON UPDATE CASCADE
);

-- ==========================================================
-- TABELA: user_msg
-- ==========================================================

CREATE TABLE user_msg (
    id INT AUTO_INCREMENT,
    message VARCHAR(100),
    ssn CHAR(9),
    
    PRIMARY KEY (id),
    
    CONSTRAINT fk_user_msg_employee
        FOREIGN KEY (ssn)
        REFERENCES employee(ssn)
        ON DELETE SET NULL
        ON UPDATE CASCADE
);

-- ==========================================================
-- VIEW: employees_salary_2700_view
-- ==========================================================

CREATE VIEW employees_salary_2700_view AS
SELECT CONCAT(fname, ' ', lname) AS nome,
       salary AS salario,
       dno AS numero_departamento
FROM employee
WHERE salary > 2700;

-- ==========================================================
-- FIM DO SCRIPT
-- ==========================================================