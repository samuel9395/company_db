-- ==========================================================
-- PROJETO: OTIMIZAÇÃO DE CONSULTAS - BANCO COMPANY
-- ==========================================================
-- Objetivo:
-- Melhorar a performance das consultas através da criação
-- estratégica de índices nas tabelas envolvidas.
--
-- Critérios considerados:
-- - Colunas utilizadas em JOIN
-- - Colunas utilizadas em GROUP BY
-- - Colunas utilizadas em ORDER BY
-- - Dados mais acessados no contexto (employee e department)
--
-- Tipo de índice utilizado:
-- B-TREE (padrão do MySQL)
-- Motivo:
-- Ideal para igualdade (=), JOIN, GROUP BY e ORDER BY.
-- ==========================================================

USE company;

-- ==========================================================
-- PERGUNTA 1
-- Qual o departamento com maior número de pessoas?
-- ==========================================================

-- Índice necessário:
-- employee.dno é utilizado em JOIN com department.dnumber
-- PRIMARY KEY já existe em department.dnumber
CREATE INDEX idx_employee_dno 
ON employee(dno);

-- Query
SELECT d.dname, 
       d.dnumber, 
       COUNT(e.ssn) AS total_empregados
FROM department d
JOIN employee e ON e.dno = d.dnumber
GROUP BY d.dname, d.dnumber
ORDER BY total_empregados DESC
LIMIT 1;


-- ==========================================================
-- PERGUNTA 2
-- Quais são os departamentos por cidade?
-- ==========================================================

-- Índice para JOIN
CREATE INDEX idx_dept_locations_dnumber 
ON dept_locations(dnumber);

-- Índice para ORDER BY e possíveis filtros por cidade
CREATE INDEX idx_dept_locations_location 
ON dept_locations(dlocation);

-- Query
SELECT d.dname, 
       dl.dlocation
FROM department d
JOIN dept_locations dl 
     ON dl.dnumber = d.dnumber
ORDER BY dl.dlocation;


-- ==========================================================
-- PERGUNTA 3
-- Relação de empregados por departamento
-- ==========================================================

-- O índice idx_employee_dno já criado anteriormente
-- será reaproveitado aqui.

-- Query
SELECT d.dname, 
       e.fname, 
       e.lname, 
       e.salary
FROM employee e
JOIN department d 
     ON e.dno = d.dnumber
ORDER BY d.dname;


-- ==========================================================
-- OBSERVAÇÕES IMPORTANTES
-- ==========================================================
-- NÃO foram criados índices nas seguintes colunas:
--
-- department.dnumber  -> já é PRIMARY KEY
-- employee.ssn        -> já é PRIMARY KEY
-- project.pnumber     -> já é PRIMARY KEY
-- works_on (essn,pno) -> já é PRIMARY KEY composta
--
-- Criar índices duplicados aumentaria:
-- - Custo de INSERT
-- - Custo de UPDATE
-- - Uso de armazenamento
--
-- Foco foi manter equilíbrio entre performance de leitura
-- e custo de escrita.
-- ==========================================================