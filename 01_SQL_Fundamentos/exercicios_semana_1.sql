/*
=============================================================================
  SEMANA 1 - EXERCÍCIOS PRÁTICOS DE SQL (JOINS, FILTROS E AGRUPAMENTOS)
  Banco de Dados: empresa_vendas.db (SQLite)
=============================================================================

ESTRUTURA DAS TABELAS:
  • clientes (cliente_id, nome, estado, segmento)
  • pedidos (pedido_id, cliente_id, data_pedido, valor_total, status)
  • itens_pedido (item_id, pedido_id, produto, categoria, quantidade, preco_unitario)

COMO TESTAR:
  Você pode rodar suas queries usando a extensão SQLite Viewer no VS Code/IDE,
  DBeaver ou executando via script python `testar_query.py` que criei para você.
=============================================================================
*/

-- EXERCÍCIO 1 (INNER JOIN básico com filtro):
-- Enunciado: Liste o nome do cliente, o pedido_id, a data_pedido e o valor_total 
-- apenas dos pedidos com status 'Entregue'.
-- ESCREVA SUA QUERY ABAIXO:

select c.nome, p.pedido_id, p.data_pedido, valor_total from clientes as c
left join pedidos as p on c.cliente_id = p.cliente_id
where status = 'Entregue';


-- EXERCÍCIO 2 (LEFT JOIN para identificar clientes sem compras):
-- Enunciado: Liste todos os clientes cadastrados (cliente_id e nome) e identifique 
-- quais deles NUNCA realizaram nenhum pedido.
-- ESCREVA SUA QUERY ABAIXO:

select c.cliente_id, c.nome from clientes as c
left join pedidos as p on c.cliente_id = p.cliente_id
where pedido_id is null;


-- EXERCÍCIO 3 (Agrupamento com GROUP BY e ORDER BY):
-- Enunciado: Calcule a quantidade de pedidos e o faturamento total por 'estado'. 
-- Considere apenas os pedidos com status 'Entregue' e ordene pelo maior faturamento.
-- ESCREVA SUA QUERY ABAIXO:




-- EXERCÍCIO 4 (Cruzamento triplo com cálculo de itens):
-- Enunciado: Descubra qual é a 'categoria' de produtos mais vendida em quantidade 
-- de itens e o valor total faturado por categoria (cruzando pedidos e itens_pedido).
-- ESCREVA SUA QUERY ABAIXO:




-- EXERCÍCIO 5 (Filtro de Agrupamento com HAVING):
-- Enunciado: Liste o nome dos clientes e o valor total acumulado que eles já gastaram, 
-- mas traga APENAS aqueles clientes cujo gasto total seja superior a R$ 500,00.
-- Dica: O filtro do total deve ser feito com HAVING, após o agrupamento.
-- ESCREVA SUA QUERY ABAIXO:

