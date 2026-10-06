import sqlite3
import os

db_path = r"c:\Users\mvmacedo\Documents\Python\01_SQL_Fundamentos\empresa_vendas.db"

conn = sqlite3.connect(db_path)
cursor = conn.cursor()

# 1. Tabela Clientes
cursor.execute("""
CREATE TABLE IF NOT EXISTS clientes (
    cliente_id INTEGER PRIMARY KEY,
    nome TEXT NOT NULL,
    estado TEXT NOT NULL,
    segmento TEXT NOT NULL
);
""")

# 2. Tabela Pedidos
cursor.execute("""
CREATE TABLE IF NOT EXISTS pedidos (
    pedido_id INTEGER PRIMARY KEY,
    cliente_id INTEGER,
    data_pedido DATE NOT NULL,
    valor_total REAL NOT NULL,
    status TEXT NOT NULL,
    FOREIGN KEY (cliente_id) REFERENCES clientes (cliente_id)
);
""")

# 3. Tabela Itens_Pedido
cursor.execute("""
CREATE TABLE IF NOT EXISTS itens_pedido (
    item_id INTEGER PRIMARY KEY,
    pedido_id INTEGER,
    produto TEXT NOT NULL,
    categoria TEXT NOT NULL,
    quantidade INTEGER NOT NULL,
    preco_unitario REAL NOT NULL,
    FOREIGN KEY (pedido_id) REFERENCES pedidos (pedido_id)
);
""")

# Dados de Clientes
clientes = [
    (1, "Ana Silva", "SP", "Varejo"),
    (2, "Bruno Souza", "RJ", "Corporativo"),
    (3, "Carla Dias", "MG", "Varejo"),
    (4, "Diego Lima", "SP", "Corporativo"),
    (5, "Eduardo Gomes", "PR", "Varejo"),
    (6, "Fernanda Costa", "RS", "Corporativo"),
    (7, "Gabriel Alves", "SP", "Varejo"),
    (8, "Helena Ramos", "BA", "Varejo")  # Cliente sem pedidos de propósito
]
cursor.executemany("INSERT OR IGNORE INTO clientes VALUES (?, ?, ?, ?)", clientes)

# Dados de Pedidos
pedidos = [
    (101, 1, "2026-01-10", 350.00, "Entregue"),
    (102, 1, "2026-02-15", 120.00, "Entregue"),
    (103, 2, "2026-01-20", 890.00, "Entregue"),
    (104, 3, "2026-02-01", 210.00, "Cancelado"),
    (105, 4, "2026-02-18", 1500.00, "Entregue"),
    (106, 5, "2026-03-05", 450.00, "Entregue"),
    (107, 2, "2026-03-12", 670.00, "Processando"),
    (108, 6, "2026-03-22", 95.00, "Entregue"),
    (109, 7, "2026-04-02", 520.00, "Entregue"),
    (110, 4, "2026-04-10", 310.00, "Entregue")
]
cursor.executemany("INSERT OR IGNORE INTO pedidos VALUES (?, ?, ?, ?, ?)", pedidos)

# Dados de Itens
itens = [
    (1, 101, "Teclado Mecanico", "Informatica", 1, 200.00),
    (2, 101, "Mouse Gamer", "Informatica", 1, 150.00),
    (3, 102, "Headset Basico", "Audio", 1, 120.00),
    (4, 103, "Monitor 24pol", "Informatica", 1, 890.00),
    (5, 104, "Cadeira Office", "Moveis", 1, 210.00),
    (6, 105, "Notebook i5", "Informatica", 1, 1500.00),
    (7, 106, "Mesa Digitalizadora", "Informatica", 1, 450.00),
    (8, 107, "Cadeira Gamer", "Moveis", 1, 670.00),
    (9, 108, "Cabo HDMI 2.0", "Acessorios", 2, 47.50),
    (10, 109, "Monitor 19pol", "Informatica", 1, 520.00),
    (11, 110, "Teclado Sem Fio", "Informatica", 1, 310.00)
]
cursor.executemany("INSERT OR IGNORE INTO itens_pedido VALUES (?, ?, ?, ?, ?, ?)", itens)

conn.commit()
conn.close()
print("Banco empresa_vendas.db criado com sucesso!")
