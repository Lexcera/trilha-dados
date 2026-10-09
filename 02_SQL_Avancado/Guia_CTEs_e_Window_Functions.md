# 🧠 Guia Visual & Prático: CTEs e Window Functions no SQL

Este material foi preparado sob medida para você entender a lógica e a mecânica por trás de **CTEs** e **Window Functions**, sem decoreba, usando analogias do dia a dia corporativo.

---

## 1. O que é uma CTE (`WITH ... AS`)?

**CTE** significa *Common Table Expression* (Expressão de Tabela Comum).

### A analogia:
Pense na CTE como uma **"tabela temporária na memória"** ou um **"rascunho"** que você cria no topo da sua consulta para organizar o raciocínio.

No SQL tradicional, quando você precisava fazer uma consulta dentro de outra (Subquery), o código ficava cheio de parênteses aninhados, difícil de ler e manter:

```sql
-- JEITO ANTIGO (Subquery aninhada - Difícil de ler):
SELECT nome, total_gasto
FROM (
    SELECT c.nome, SUM(p.valor_total) AS total_gasto
    FROM clientes c
    JOIN pedidos p ON c.cliente_id = p.cliente_id
    GROUP BY c.nome
) AS tabela_temporaria_confusa
WHERE total_gasto > 500;
```

### O Jeito Moderno e Elegante: Usando `WITH` (CTE)
Com uma CTE, você declara seu "bloco de rascunho" primeiro, dá um nome claro para ele, e depois faz o `SELECT` final nele como se fosse uma tabela comum:

```sql
WITH clientes_gastos AS (
    SELECT 
        c.nome, 
        SUM(p.valor_total) AS total_gasto
    FROM clientes c
    JOIN pedidos p ON c.cliente_id = p.cliente_id
    GROUP BY c.nome
)
-- Agora consultamos o nosso "rascunho":
SELECT nome, total_gasto
FROM clientes_gastos
WHERE total_gasto > 500;
```

> **Por que usar CTE?**
> 1. Legibilidade: qualquer pessoa (e recrutador) lê de cima para baixo como uma história lógica.
> 2. Manutenção: você pode encadear vários blocos com vírgula (`WITH tabela1 AS (...), tabela2 AS (...) SELECT ...`).

---

## 2. O que são Window Functions (Funções de Janela)?

### A diferença crucial entre `GROUP BY` e `Window Function`:
* **`GROUP BY` (Colapsa as linhas):** Se você tem 10 pedidos e agrupa por cliente, o SQL "espreme" as linhas e devolve apenas 1 linha por cliente. Os detalhes individuais do pedido desaparecem.
* **`Window Function` (Mantém as linhas intactas):** O SQL olha para uma "janela" de linhas, faz um cálculo ou numeração, **mas mantém todas as linhas individuais na tela**!

A estrutura mágica de qualquer Window Function é sempre:
```sql
FUNCAO() OVER (PARTITION BY coluna_que_agrupa ORDER BY coluna_que_ordena)
```

### Anatomia da sintaxe:
1. **`OVER`**: Diz ao banco: *"Isso aqui não é uma função comum, é uma função de janela!"*
2. **`PARTITION BY`**: É o equivalente ao `GROUP BY`, mas sem colapsar as linhas. (Ex: divida as janelas por cliente).
3. **`ORDER BY`**: Como o banco deve olhar as linhas dentro daquela janela para numerar ou calcular (Ex: do mais antigo para o mais novo).

---

## 3. A Função Rainha: `ROW_NUMBER()`

A função `ROW_NUMBER()` cria uma numeração sequencial (1, 2, 3...) dentro de cada partição.

### Exemplo Prático com a nossa base:
Imagine a tabela de pedidos:
* Ana Silva fez o Pedido 101 em 10/01 e o Pedido 102 em 15/02.
* Diego Lima fez o Pedido 105 em 18/02 e o Pedido 110 em 10/04.

Se rodarmos:
```sql
SELECT 
    cliente_id,
    pedido_id,
    data_pedido,
    valor_total,
    ROW_NUMBER() OVER (PARTITION BY cliente_id ORDER BY data_pedido ASC) AS numero_do_pedido
FROM pedidos;
```

**Veja como o banco devolve:**
| cliente_id | pedido_id | data_pedido | valor_total | numero_do_pedido |
| :---: | :---: | :---: | :---: | :---: |
| **1 (Ana)** | 101 | 2026-01-10 | 350.0 | **1** (Primeiro pedido da Ana) |
| **1 (Ana)** | 102 | 2026-02-15 | 120.0 | **2** (Segundo pedido da Ana) |
| **2 (Bruno)** | 103 | 2026-01-20 | 890.0 | **1** (Primeiro pedido do Bruno) |
| **2 (Bruno)** | 107 | 2026-03-12 | 670.0 | **2** (Segundo pedido do Bruno) |
| **4 (Diego)** | 105 | 2026-02-18 | 1500.0 | **1** (Primeiro pedido do Diego) |
| **4 (Diego)** | 110 | 2026-04-10 | 310.0 | **2** (Segundo pedido do Diego) |

*(Repare que o contador reinicia no 1 a cada novo `cliente_id`, porque definimos `PARTITION BY cliente_id`!)*

---

## 4. Juntando os dois superpoderes: CTE + `ROW_NUMBER()`

Agora veja como responder à pergunta clássica de entrevista:
> *"Qual foi o primeiro pedido realizado por cada cliente?"*

Não podemos filtrar um `ROW_NUMBER()` direto no `WHERE` na mesma query. Por isso, usamos uma **CTE**:

```sql
WITH pedidos_ranqueados AS (
    SELECT 
        cliente_id,
        pedido_id,
        data_pedido,
        valor_total,
        ROW_NUMBER() OVER (PARTITION BY cliente_id ORDER BY data_pedido ASC) AS ranking
    FROM pedidos
)
SELECT cliente_id, pedido_id, data_pedido, valor_total
FROM pedidos_ranqueados
WHERE ranking = 1; -- Traz apenas o primeiro pedido de cada um!
```

---

## 5. Próximos Passos de Estudo nas suas Plataformas:

Quando abrir a **DNC** ou a **Udemy**, procure exatamente por essas aulas:
* **Na Udemy / DNC:**
  - *"Common Table Expressions (CTE) e cláusula WITH"*
  - *"Window Functions: ROW_NUMBER, RANK e DENSE_RANK"*
  - *"Diferença entre PARTITION BY e GROUP BY"*

Esse guia está salvo na sua pasta `02_SQL_Avancado` para você reler quando quiser!
