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

# Função para rodar o DDL no banco de dados
def setup_database(ddl_file_path, dml_file_path):
    try:
        conn = get_connection()
        cursor = conn.cursor()

        # Ler o arquivo DDL
        with open(ddl_file_path, "r") as ddl_file:
            ddl_script = ddl_file.read()

        # Executar o DDL no banco de dados linha a linha
        ddl_statements = ddl_script.split(";")  # Dividir comandos por ";"
        for i, statement in enumerate(ddl_statements, start=1):
            statement = statement.strip()
            if statement:  # Ignorar comandos vazios
                try:
                    cursor.execute(statement)
                except Exception as ddl_error:
                    print(f"Erro no comando DDL na linha {i}: {ddl_error}")
                    print(f"Comando: {statement}")
                    raise ddl_error
        conn.commit()
        print("Banco de dados configurado com sucesso.")

        # Ler o arquivo DML
        with open(dml_file_path, "r") as dml_file:
            dml_script = dml_file.read()

        # Executar o DML no banco de dados linha a linha
        dml_statements = dml_script.split(";")  # Dividir comandos por ";"
        for i, statement in enumerate(dml_statements, start=1):
            statement = statement.strip()
            if statement:  # Ignorar comandos vazios
                try:
                    cursor.execute(statement)
                except Exception as dml_error:
                    print(f"Erro no comando DML na linha {i}: {dml_error}")
                    print(f"Comando: {statement}")
                    raise dml_error
        conn.commit()
        print("Dados iniciais inseridos com sucesso.")

    except Exception as e:
        print(f"Erro ao configurar o banco de dados: {e}")
    finally:
        if cursor:
            cursor.close()
        if conn:
            conn.close()
