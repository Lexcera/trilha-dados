import sqlite3
import sys

db_path = r"c:\Users\mvmacedo\Documents\Python\01_SQL_Fundamentos\empresa_vendas.db"

def executar(query):
    try:
        conn = sqlite3.connect(db_path)
        cursor = conn.cursor()
        cursor.execute(query)
        colunas = [desc[0] for desc in cursor.description]
        linhas = cursor.fetchall()
        
        print("\n" + "="*60)
        print("RESULTADO DA QUERY:")
        print("="*60)
        print(" | ".join(f"{col:15}" for col in colunas))
        print("-" * (18 * len(colunas)))
        for linha in linhas:
            print(" | ".join(f"{str(val):15}" for val in linha))
        print("="*60)
        print(f"Total de registros retornados: {len(linhas)}\n")
        conn.close()
    except Exception as e:
        print(f"\n[ERRO SQL]: {e}\n")

if __name__ == "__main__":
    if len(sys.argv) > 1:
        query_teste = " ".join(sys.argv[1:])
    else:
        # Exemplo de teste padrão
        query_teste = "SELECT * FROM clientes LIMIT 5;"
    
    print(f"Executando: {query_teste}")
    executar(query_teste)
