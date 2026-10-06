-- =============================================================================
-- CRIAÇÃO DA BASE DE DADOS PARA O MYSQL WORKBENCH
-- Execute este script inteiro no MySQL Workbench para criar e popular o banco!
-- =============================================================================

CREATE DATABASE IF NOT EXISTS empresa_vendas;
USE empresa_vendas;

-- 1. Tabela Clientes
DROP TABLE IF EXISTS itens_pedido;
DROP TABLE IF EXISTS pedidos;
DROP TABLE IF EXISTS clientes;

CREATE TABLE clientes (
    cliente_id INT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    estado VARCHAR(2) NOT NULL,
    segmento VARCHAR(50) NOT NULL
);

-- 2. Tabela Pedidos
CREATE TABLE pedidos (
    pedido_id INT PRIMARY KEY,
    cliente_id INT,
    data_pedido DATE NOT NULL,
    valor_total DECIMAL(10,2) NOT NULL,
    status VARCHAR(50) NOT NULL,
    FOREIGN KEY (cliente_id) REFERENCES clientes (cliente_id)
);

-- 3. Tabela Itens do Pedido
CREATE TABLE itens_pedido (
    item_id INT PRIMARY KEY,
    pedido_id INT,
    produto VARCHAR(100) NOT NULL,
    categoria VARCHAR(50) NOT NULL,
    quantidade INT NOT NULL,
    preco_unitario DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (pedido_id) REFERENCES pedidos (pedido_id)
);

-- Inserindo Clientes
INSERT INTO clientes VALUES 
(1, 'Ana Silva', 'SP', 'Varejo'),
(2, 'Bruno Souza', 'RJ', 'Corporativo'),
(3, 'Carla Dias', 'MG', 'Varejo'),
(4, 'Diego Lima', 'SP', 'Corporativo'),
(5, 'Eduardo Gomes', 'PR', 'Varejo'),
(6, 'Fernanda Costa', 'RS', 'Corporativo'),
(7, 'Gabriel Alves', 'SP', 'Varejo'),
(8, 'Helena Ramos', 'BA', 'Varejo'); -- Cliente sem compras

-- Inserindo Pedidos
INSERT INTO pedidos VALUES 
(101, 1, '2026-01-10', 350.00, 'Entregue'),
(102, 1, '2026-02-15', 120.00, 'Entregue'),
(103, 2, '2026-01-20', 890.00, 'Entregue'),
(104, 3, '2026-02-01', 210.00, 'Cancelado'),
(105, 4, '2026-02-18', 1500.00, 'Entregue'),
(106, 5, '2026-03-05', 450.00, 'Entregue'),
(107, 2, '2026-03-12', 670.00, 'Processando'),
(108, 6, '2026-03-22', 95.00, 'Entregue'),
(109, 7, '2026-04-02', 520.00, 'Entregue'),
(110, 4, '2026-04-10', 310.00, 'Entregue');

-- Inserindo Itens dos Pedidos
INSERT INTO itens_pedido VALUES 
(1, 101, 'Teclado Mecanico', 'Informatica', 1, 200.00),
(2, 101, 'Mouse Gamer', 'Informatica', 1, 150.00),
(3, 102, 'Headset Basico', 'Audio', 1, 120.00),
(4, 103, 'Monitor 24pol', 'Informatica', 1, 890.00),
(5, 104, 'Cadeira Office', 'Moveis', 1, 210.00),
(6, 105, 'Notebook i5', 'Informatica', 1, 1500.00),
(7, 106, 'Mesa Digitalizadora', 'Informatica', 1, 450.00),
(8, 107, 'Cadeira Gamer', 'Moveis', 1, 670.00),
(9, 108, 'Cabo HDMI 2.0', 'Acessorios', 2, 47.50),
(10, 109, 'Monitor 19pol', 'Informatica', 1, 520.00),
(11, 110, 'Teclado Sem Fio', 'Informatica', 1, 310.00);
