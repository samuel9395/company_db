-- ==========================================================
-- PROJETO: VIEWS + PERMISSÕES + TRIGGERS
-- BANCO: company
-- ==========================================================

USE company;

-- ==========================================================
-- =======================
-- PARTE 1 - VIEWS
-- =======================
-- ==========================================================

-- Número de empregados por departamento e localidade
CREATE OR REPLACE VIEW vw_empregados_por_departamento_localidade AS
SELECT 
    d.dname AS departamento,
    dl.dlocation AS localidade,
    COUNT(e.ssn) AS total_empregados
FROM department d
JOIN dept_locations dl ON d.dnumber = dl.dnumber
LEFT JOIN employee e ON e.dno = d.dnumber
GROUP BY d.dname, dl.dlocation;


-- Lista de departamentos e seus gerentes
CREATE OR REPLACE VIEW vw_departamentos_gerentes AS
SELECT 
    d.dname AS departamento,
    CONCAT(e.fname, ' ', e.lname) AS gerente,
    d.mgr_start_date AS inicio_gerencia
FROM department d
LEFT JOIN employee e ON d.mgr_ssn = e.ssn;


-- Projetos com maior número de empregados
CREATE OR REPLACE VIEW vw_projetos_maior_num_empregados AS
SELECT 
    p.pname AS projeto,
    COUNT(w.essn) AS total_empregados
FROM project p
LEFT JOIN works_on w ON p.pnumber = w.pno
GROUP BY p.pname
ORDER BY total_empregados DESC;


-- Lista de projetos, departamentos e gerentes
CREATE OR REPLACE VIEW vw_projetos_departamentos_gerentes AS
SELECT 
    p.pname AS projeto,
    d.dname AS departamento,
    CONCAT(e.fname, ' ', e.lname) AS gerente
FROM project p
JOIN department d ON p.dnum = d.dnumber
LEFT JOIN employee e ON d.mgr_ssn = e.ssn;


-- Empregados que possuem dependentes e se são gerentes
CREATE OR REPLACE VIEW vw_empregados_dependentes_gerentes AS
SELECT 
    CONCAT(e.fname, ' ', e.lname) AS empregado,
    COUNT(dep.dependent_name) AS total_dependentes,
    CASE 
        WHEN e.ssn IN (SELECT mgr_ssn FROM department)
        THEN 'Sim'
        ELSE 'Não'
    END AS eh_gerente
FROM employee e
LEFT JOIN dependent dep ON e.ssn = dep.essn
GROUP BY e.ssn;


-- ==========================================================
-- =======================
-- PARTE 2 - PERMISSÕES
-- =======================
-- ==========================================================

-- Removendo usuários se já existirem
DROP USER IF EXISTS 'gerente'@'localhost';
DROP USER IF EXISTS 'funcionario'@'localhost';

-- Criando usuários
CREATE USER 'gerente'@'localhost' IDENTIFIED BY '123456';
CREATE USER 'funcionario'@'localhost' IDENTIFIED BY '123456';

-- Permissões para GERENTE
GRANT SELECT ON company.employee TO 'gerente'@'localhost';
GRANT SELECT ON company.department TO 'gerente'@'localhost';
GRANT SELECT ON company.project TO 'gerente'@'localhost';
GRANT SELECT ON company.works_on TO 'gerente'@'localhost';
GRANT SELECT ON company.dependent TO 'gerente'@'localhost';

-- Permissões para FUNCIONÁRIO (restrito)
GRANT SELECT ON company.employee TO 'funcionario'@'localhost';

-- Garante que funcionário NÃO acesse departamentos
REVOKE SELECT ON company.department FROM 'funcionario'@'localhost';

FLUSH PRIVILEGES;


-- ==========================================================
-- =======================
-- PARTE 3 - TRIGGERS
-- =======================
-- ==========================================================

-- BEFORE DELETE
-- Log de empregados removidos

CREATE TABLE IF NOT EXISTS employee_deleted_log (
    ssn CHAR(9),
    fname VARCHAR(50),
    lname VARCHAR(50),
    deleted_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

DELIMITER $$

CREATE TRIGGER trg_before_delete_employee
BEFORE DELETE ON employee
FOR EACH ROW
BEGIN
    INSERT INTO employee_deleted_log (ssn, fname, lname)
    VALUES (OLD.ssn, OLD.fname, OLD.lname);
END $$

DELIMITER ;


-- BEFORE UPDATE
-- Log de alteração salarial

CREATE TABLE IF NOT EXISTS salary_update_log (
    id INT AUTO_INCREMENT PRIMARY KEY,
    ssn CHAR(9),
    salario_antigo DECIMAL(10,2),
    salario_novo DECIMAL(10,2),
    data_alteracao DATETIME DEFAULT CURRENT_TIMESTAMP
);

DELIMITER $$

CREATE TRIGGER trg_before_update_salary
BEFORE UPDATE ON employee
FOR EACH ROW
BEGIN
    IF OLD.salary <> NEW.salary THEN
        INSERT INTO salary_update_log (ssn, salario_antigo, salario_novo)
        VALUES (OLD.ssn, OLD.salary, NEW.salary);
    END IF;
END $$

DELIMITER ;


-- ==========================================================
-- FIM DO SCRIPT
-- ==========================================================