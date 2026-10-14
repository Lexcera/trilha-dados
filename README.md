# 📊 Trilha de Especialização em Análise de Dados & BI

Repositório dedicado ao aprofundamento prático e consolidação de competências em **SQL (Básico ao Avançado)**, **Modelagem Dimensional / DAX (Power BI)** e **Manipulação de Dados com Python (Pandas)**.

Este projeto documenta a resolução de desafios de negócio reais, estruturados em um plano intensivo de 4 semanas voltado para processos seletivos e atuação no mercado corporativo.

---

## 🗂️ Estrutura do Repositório

```text
├── 01_SQL_Fundamentos/       # Semana 1: Relacionamentos, Joins e Agrupamentos
│   ├── exercicios_semana_1.sql
│   ├── criar_banco_mysql.sql
│   └── testar_query.py
│
├── 02_SQL_Avancado/          # Semana 2: CTEs, Window Functions e Subqueries
│   ├── exercicios_semana_2.sql
│   ├── Guia_CTEs_e_Window_Functions.md
│   └── testar_query.py
│
├── 03_PowerBI_DAX/           # Semana 3: Star Schema, Fato vs Dimensão e DAX
│   └── README.md
│
└── 04_Python_Pandas/         # Semana 4: Carga, Limpeza e Análise com Pandas
    └── README.md
```

---

## 🚀 Progresso dos Módulos

### ✅ Semana 1: SQL Fundamentos & Manipulação Relacional
* **Foco:** Domínio de sintaxe relacional, integridade referencial e filtros de agregação.
* **Competências desenvolvidas:**
  - `INNER JOIN` e identificação de registros órfãos com `LEFT JOIN ... WHERE id IS NULL`.
  - Agrupamentos por dimensão geográfica (`GROUP BY`) e ordenações multi-nível (`ORDER BY`).
  - Prevenção de duplicações de métricas em tabelas de itens vs cabeçalhos.
  - Filtros após agregação com `HAVING`.
* 📁 Arquivo: [`01_SQL_Fundamentos/exercicios_semana_1.sql`](01_SQL_Fundamentos/exercicios_semana_1.sql)

---

### ✅ Semana 2: SQL Avançado (CTEs & Window Functions)
* **Foco:** Performance, modularidade e resolução de perguntas complexas de negócio.
* **Competências desenvolvidas:**
  - **Common Table Expressions (`WITH`):** Modularização de queries, legibilidade e reutilização de tabelas temporárias na memória.
  - **`ROW_NUMBER() OVER(PARTITION BY ... ORDER BY ...)`:** Rastreamento do primeiro pedido por cliente e produto de maior valor por categoria.
  - **Média Escalar com CTEs:** Comparação de linhas transacionais contra métricas consolidadas (`AVG`).
  - **`DENSE_RANK()`:** Criação de rankings nacionais de faturamento com tratamento de empates.
* 📁 Arquivo: [`02_SQL_Avancado/exercicios_semana_2.sql`](02_SQL_Avancado/exercicios_semana_2.sql)

---

### ⏳ Semana 3: Power BI & Modelagem Dimensional (Em Andamento)
* **Foco:** Arquitetura de dados para BI e fórmulas DAX.
* **Tópicos:**
  - Modelagem Star Schema (Tabelas Fato vs Tabelas Dimensão).
  - Contexto de Linha vs Contexto de Filtro no VertiPaq.
  - Medidas calculadas (`DIVIDE`, `SUM`, `CALCULATE`, `ALL`).
  - Criação de `dCalendario` e funções de Time Intelligence.

---

### ⏳ Semana 4: Python para Dados (Pandas)
* **Foco:** Automação, ETL e manipulação via código.
* **Tópicos:**
  - Carga de dados (`read_csv`, `read_sql`).
  - Limpeza e tratamento de nulos (`fillna`, `dropna`).
  - Agrupamentos (`groupby`) e cruzamentos (`merge`).
  - Resolução de cases reais de processos seletivos.

---

## 🛠️ Tecnologias & Ferramentas
* **Banco de Dados:** MySQL, SQLite, PostgreSQL
* **Ferramentas de Consulta:** MySQL Workbench, DBeaver, Metabase
* **Business Intelligence:** Power BI Desktop (DAX & Power Query)
* **Linguagens:** SQL, Python (Pandas)
* **Controle de Versão:** Git & GitHub

---

## 👤 Autor
* **Marcus Vinicius Brandão Macedo**
* [LinkedIn](https://www.linkedin.com/in/marcusvmacedo-dados/) | [GitHub](https://github.com/Lexcera)
