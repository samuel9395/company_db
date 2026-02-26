# 🏢 Banco de Dados Company

## 📌 Descrição do Projeto

Este projeto consiste na criação completa do banco de dados **Company**, incluindo:

- Criação do banco
- Criação das tabelas
- Definição de chaves primárias
- Definição de chaves estrangeiras
- Integridade referencial
- Criação de View

O objetivo é modelar um ambiente corporativo contendo departamentos, funcionários, projetos e seus relacionamentos.

---

## 🧱 Estrutura do Banco de Dados

O banco foi estruturado com foco em:

- Organização empresarial
- Controle de funcionários e supervisores
- Gerenciamento de projetos
- Registro de dependentes
- Log de alterações salariais
- Mensagens vinculadas a funcionários

---

## 📊 Tabelas Criadas

### 📌 department
Armazena os departamentos da empresa.

| Campo | Tipo |
|-------|------|
| dnumber | INT (PK) |
| dname | VARCHAR(15) (UNIQUE) |
| mgr_ssn | CHAR(9) |
| mgr_start_date | DATE |

---

### 👨‍💼 employee
Armazena os funcionários da empresa.

| Campo | Tipo |
|-------|------|
| ssn | CHAR(9) (PK) |
| fname | VARCHAR(15) |
| lname | VARCHAR(15) |
| salary | DECIMAL(10,2) |
| dno | INT (FK) |
| super_ssn | CHAR(9) (FK - auto relacionamento) |

Relacionamentos:
- Um funcionário pertence a um departamento.
- Um funcionário pode ter um supervisor (auto-relacionamento).

---

### 📍 dept_locations
Define as localizações de cada departamento.

Chave primária composta:
- (dnumber, dlocation)

---

### 📁 project
Armazena os projetos da empresa.

Relacionamento:
- Cada projeto pertence a um departamento.

---

### ⏱ works_on
Relaciona funcionários e projetos (tabela associativa).

Chave primária composta:
- (essn, pno)

---

### 👨‍👩‍👧 dependent
Armazena dependentes dos funcionários.

Chave primária composta:
- (essn, dependent_name)

---

### 💰 salary_log
Registra alterações salariais.

---

### 💬 user_msg
Armazena mensagens vinculadas a funcionários.

---

## 👁 View Criada

### employees_salary_2700_view

Exibe funcionários com salário superior a 2700.

```sql
SELECT CONCAT(fname, ' ', lname) AS nome,
       salary AS salario,
       dno AS numero_departamento
FROM employee
WHERE salary > 2700;
