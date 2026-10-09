import sqlite3
import sys
import os

# Caminho para o banco da Semana 1 que já possui todos os dados populados
db_path = r"c:\Users\mvmacedo\Documents\Python\01_SQL_Fundamentos\empresa_vendas.db"

def executar(query):
    try:
        conn = sqlite3.connect(db_path)
        cursor = conn.cursor()
        cursor.execute(query)
        colunas = [desc[0] for desc in cursor.description]
        linhas = cursor.fetchall()
        
        print("\n" + "="*65)
        print("RESULTADO DA QUERY:")
        print("="*65)
        print(" | ".join(f"{col:18}" for col in colunas))
        print("-" * (21 * len(colunas)))
        for linha in linhas:
            print(" | ".join(f"{str(val):18}" for val in linha))
        print("="*65)
        print(f"Total de registros retornados: {len(linhas)}\n")
        conn.close()
    except Exception as e:
        print(f"\n[ERRO SQL]: {e}\n")

if __name__ == "__main__":
    if len(sys.argv) > 1:
        query_teste = " ".join(sys.argv[1:])
    else:
        query_teste = "SELECT pedido_id, cliente_id, data_pedido, valor_total FROM pedidos LIMIT 5;"
    
    print(f"Executando no banco empresa_vendas...")
    executar(query_teste)
