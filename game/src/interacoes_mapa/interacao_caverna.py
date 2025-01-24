from ..mineracao_precisao import barra_de_precisao
from setup.database import get_connection
import os

DDL_FILE_PATH = os.path.join(os.path.dirname(__file__), "db/ddl.sql")
DML_FILE_PATH = os.path.join(os.path.dirname(__file__), "db/dml.sql")

def interacao_caverna(jogador):
    try:
        connection = get_connection()
        cursor = connection.cursor()
        cursor.execute("SELECT * FROM caverna")
        andar = cursor.fetchall()
        print(andar)
    except Exception as error:
        print(f"Ocorreu um erro ao listar o andar: {error}")
    print("Você está no andar 1")
    barra_de_precisao()
    # Antes minerar, você precisa 
    # Adicionar view para possiveis recompensas
    # assim que o jogador derrotar todos os mobs expecíficados em "quantidade_mobs"
    # ele liberará a opção de minerar e coletar a recompensa da caverna
    # a recompensa poderá ser tanto poções de vida que ajudam o jogador a continuar na caverna
    # ou itens pré determinados na "view" de recompensas, decretados por um random()