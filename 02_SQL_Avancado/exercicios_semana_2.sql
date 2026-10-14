/*
=============================================================================
  SEMANA 2 - EXERCÍCIOS DE SQL AVANÇADO (CTEs E WINDOW FUNCTIONS)
  Banco de Dados: empresa_vendas (MySQL / SQLite)
=============================================================================

ESTRUTURA DAS TABELAS DISPONÍVEIS:
  • clientes (cliente_id, nome, estado, segmento)
  • pedidos (pedido_id, cliente_id, data_pedido, valor_total, status)
  • itens_pedido (item_id, pedido_id, produto, categoria, quantidade, preco_unitario)

DICAS DE SINTAXE:
  - CTE: 
      WITH nome_da_cte AS (
          SELECT ...
      )
      SELECT ... FROM nome_da_cte;
      
  - WINDOW FUNCTION:
      ROW_NUMBER() OVER(PARTITION BY coluna_grupo ORDER BY coluna_ordem DESC/ASC)
=============================================================================
*/

-- =============================================================================
-- EXERCÍCIO 1: CTE Básica para Segmentação de Clientes
-- =============================================================================
-- Enunciado: 
-- 1. Crie uma CTE chamada `resumo_clientes` que calcule o total gasto e a 
--    quantidade de pedidos por cada `cliente_id`.
-- 2. No SELECT final, cruze essa CTE com a tabela `clientes` para exibir:
--    nome do cliente, estado, total gasto e a quantidade de pedidos.
-- 3. Traga apenas os clientes que gastaram mais de R$ 400,00 no total.
-- ESCREVA SUA QUERY ABAIXO:

with resumo_clientes as (
	select cliente_id, Sum(valor_total) as Total_Gasto,count(pedido_id) as Qtd_pedidos from pedidos as p
	group by cliente_id
)

select c.nome, c.estado, rc.Total_gasto, rc.Qtd_pedidos from clientes as c
join resumo_clientes as rc on c.cliente_id = rc.cliente_id
where Total_gasto > 400
order by Total_gasto desc;
-- =============================================================================
-- EXERCÍCIO 2: O Desafio Clássico de Entrevista (Primeiro Pedido por Cliente)
-- =============================================================================
-- Enunciado:
-- Descubra qual foi o PRIMEIRO pedido realizado por cada cliente.
-- 1. Crie uma CTE chamada `pedidos_ranqueados` que use ROW_NUMBER() numerando
--    os pedidos de cada cliente pela data_pedido mais antiga (ASC).
-- 2. No SELECT final, traga o cliente_id, pedido_id, data_pedido e valor_total
--    apenas onde o ranking for igual a 1.
-- ESCREVA SUA QUERY ABAIXO:

with pedidos_ranqueados as (
	select cliente_id, pedido_id, data_pedido, valor_total, row_number() over (partition by cliente_id order by data_pedido asc) as mais_antigo from pedidos
)

select * from pedidos_ranqueados
where mais_antigo = 1;
	
-- =============================================================================
-- EXERCÍCIO 3: Maior Venda por Categoria de Produto
-- =============================================================================
-- Enunciado:
-- Queremos identificar o item mais caro vendido em CADA categoria.
-- 1. Na tabela `itens_pedido`, use ROW_NUMBER() particionando por `categoria`
--    e ordenando por `preco_unitario` do mais caro para o mais barato (DESC).
-- 2. Traga o produto, a categoria e o preco_unitario do item número 1 de cada categoria.
-- ESCREVA SUA QUERY ABAIXO:

with produto_maior_valor as (
select produto, categoria, preco_unitario, row_number() over (partition by categoria order by preco_unitario desc) as ranking from itens_pedido
)

select * from produto_maior_valor
where ranking = 1;

-- =============================================================================
-- EXERCÍCIO 4: CTE Encadeada (Média Comparativa)
-- =============================================================================
-- Enunciado:
-- 1. Crie uma primeira CTE chamada `ticket_medio_geral` que calcule apenas a MÉDIA 
--    do valor_total de todos os pedidos entregues da empresa.
-- 2. No SELECT final, liste os pedidos (pedido_id, cliente_id, valor_total) que 
--    tiveram valor_total ACIMA dessa média geral calculada na CTE.
-- ESCREVA SUA QUERY ABAIXO:

with ticket_medio_geral as (
select avg(valor_total) as Média from pedidos
where status like "Entregue"
)

select p.pedido_id, p.cliente_id, p.valor_total from pedidos as p
where p.valor_total > (select média from ticket_medio_geral)
order by p.valor_total desc;

-- =============================================================================
-- EXERCÍCIO 5: DENSE_RANK() vs ROW_NUMBER() (Ranking Geral de Clientes)
-- =============================================================================
-- Enunciado:
-- 1. Crie uma CTE que agrupe o faturamento total por cliente.
-- 2. No SELECT final, crie um ranking nacional usando DENSE_RANK() ordenando
--    os clientes pelo faturamento do maior para o menor.
-- 3. Exiba: ranking, nome do cliente, estado e faturamento total.
-- ESCREVA SUA QUERY ABAIXO:

with total_pcliente as (
	select cliente_id, sum(valor_total) as faturamento_cliente from pedidos
	group by cliente_id
)

select dense_rank () over (order by tc.faturamento_cliente desc ) as ranking, c.nome, c.estado, tc.faturamento_cliente from clientes as c 
join total_pcliente as tc on c.cliente_id = tc.cliente_id
order by ranking asc