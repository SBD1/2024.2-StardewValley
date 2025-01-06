import psycopg2
from psycopg2 import sql
import os

# Conexão com o banco de dados PostgreSQL no Docker
def get_connection():
    return psycopg2.connect(
        dbname=os.getenv("DB_NAME", "stardew_db"),
        user=os.getenv("DB_USER", "stardew_user"),
        password=os.getenv("DB_PASSWORD", "stardew_pass"),
        host=os.getenv("DB_HOST", "localhost"),
        port=os.getenv("DB_PORT", 5432)
    )

def populate_data(cursor):
    # Inserir dados na tabela Habilidade
    cursor.execute("""
        INSERT INTO Habilidade (id, nivel, tipo, xpMin, xpMax)
        VALUES (1, 1, 'Teste', 0, 100)
        ON CONFLICT (id) DO NOTHING;
    """)

    # Inserir dados na tabela habMineracao
    cursor.execute("""
        INSERT INTO habMineracao (fk_Habilidade_id, reducaoEnergiaMinera, minerioBonus)
        VALUES (1, 5, 10)
        ON CONFLICT (fk_Habilidade_id) DO NOTHING;
    """)

    # Inserir dados na tabela habCombate
    cursor.execute("""
        INSERT INTO habCombate (fk_Habilidade_id, vidaBonus, danoBonus)
        VALUES (1, 20, 10)
        ON CONFLICT (fk_Habilidade_id) DO NOTHING;
    """)

    # Inserir dados na tabela habCultivo
    cursor.execute("""
        INSERT INTO habCultivo (fk_Habilidade_id, cultivoBonus, reducaoEnergiaCultiva)
        VALUES (1, 15, 5)
        ON CONFLICT (fk_Habilidade_id) DO NOTHING;
    """)

# Função para rodar o DDL no banco de dados
def setup_database(ddl_file_path):
    try:
        conn = get_connection()
        cursor = conn.cursor()

        # Ler o arquivo DDL
        with open(ddl_file_path, "r") as ddl_file:
            ddl_script = ddl_file.read()

        # Executar o DDL no banco de dados
        cursor.execute(ddl_script)
        conn.commit()


        print("Banco de dados configurado com sucesso.")
        
        populate_data(cursor)
        conn.commit()
        print("Dados iniciais inseridos com sucesso.")
        
    except Exception as e:
        print(f"Erro ao configurar o banco de dados: {e}")
    finally:
        cursor.close()
        conn.close()
