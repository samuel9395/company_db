-- ==========================================================
-- INSERÇÃO INICIAL DE DADOS - BANCO COMPANY
-- ==========================================================

USE company;

-- ==========================================================
-- 1️⃣ DEPARTMENTS
-- ==========================================================

INSERT INTO department (dnumber, dname, mgr_ssn, mgr_start_date)
VALUES
(1, 'Research', NULL, '2022-01-10'),
(2, 'Administration', NULL, '2021-03-15'),
(3, 'IT', NULL, '2023-06-01');


-- ==========================================================
-- 2️⃣ EMPLOYEES (sem supervisor inicialmente)
-- ==========================================================

INSERT INTO employee 
(fname, minit, lname, ssn, bdate, address, sex, salary, super_ssn, dno)
VALUES
('John', 'A', 'Smith', '123456789', '1985-05-15', '123 Main St', 'M', 5000.00, NULL, 1),
('Anna', 'B', 'Brown', '987654321', '1990-08-20', '456 Oak Ave', 'F', 4200.00, NULL, 2),
('Carlos', 'C', 'Silva', '111222333', '1992-11-10', '789 Pine Rd', 'M', 3800.00, NULL, 3),
('Maria', 'D', 'Oliveira', '444555666', '1988-02-25', '321 Cedar Ln', 'F', 3100.00, NULL, 1),
('Lucas', 'E', 'Santos', '777888999', '1995-07-30', '654 Birch St', 'M', 2900.00, NULL, 3);


-- ==========================================================
-- 3️⃣ ATUALIZAR GERENTES DOS DEPARTAMENTOS
-- ==========================================================

UPDATE department SET mgr_ssn = '123456789' WHERE dnumber = 1;
UPDATE department SET mgr_ssn = '987654321' WHERE dnumber = 2;
UPDATE department SET mgr_ssn = '111222333' WHERE dnumber = 3;


-- ==========================================================
-- 4️⃣ DEFINIR SUPERVISORES
-- ==========================================================

UPDATE employee SET super_ssn = '123456789' WHERE ssn = '444555666';
UPDATE employee SET super_ssn = '111222333' WHERE ssn = '777888999';


-- ==========================================================
-- 5️⃣ DEPT LOCATIONS
-- ==========================================================

INSERT INTO dept_locations (dnumber, dlocation)
VALUES
(1, 'New York'),
(1, 'Boston'),
(2, 'Chicago'),
(3, 'San Francisco'),
(3, 'Seattle');


-- ==========================================================
-- 6️⃣ PROJECTS
-- ==========================================================

INSERT INTO project (pname, pnumber, plocation, dnum)
VALUES
('Alpha', 10, 'New York', 1),
('Beta', 20, 'Chicago', 2),
('Gamma', 30, 'San Francisco', 3);


-- ==========================================================
-- 7️⃣ WORKS_ON
-- ==========================================================

INSERT INTO works_on (essn, pno, hours)
VALUES
('123456789', 10, 20.5),
('444555666', 10, 15.0),
('987654321', 20, 30.0),
('111222333', 30, 25.0),
('777888999', 30, 18.5);


-- ==========================================================
-- 8️⃣ DEPENDENTS
-- ==========================================================

INSERT INTO dependent (essn, dependent_name, sex, bdate, relationship)
VALUES
('123456789', 'Emily', 'F', '2015-04-10', 'Daughter'),
('987654321', 'Michael', 'M', '2012-09-05', 'Son'),
('111222333', 'Laura', 'F', '2018-01-20', 'Daughter');


-- ==========================================================
-- 9️⃣ USER MESSAGES
-- ==========================================================

INSERT INTO user_msg (message, ssn)
VALUES
('Welcome to the company portal!', '123456789'),
('Project Beta deadline approaching.', '987654321'),
('System maintenance scheduled.', '111222333');


-- ==========================================================
-- 🔟 SALARY LOG (exemplo manual)
-- ==========================================================

INSERT INTO salary_log (ssn, old_salary, new_salary)
VALUES
('777888999', 2500.00, 2900.00);


-- ==========================================================
-- FIM DA INSERÇÃO INICIAL
-- ==========================================================