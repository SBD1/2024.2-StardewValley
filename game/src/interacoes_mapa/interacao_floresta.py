from setup.database import get_connection
from ..utils.animacao_escrita import print_animado
from ..mineracao_precisao import barra_de_precisao_floresta
import os


DDL_FILE_PATH = os.path.join(os.path.dirname(__file__), "db/ddl.sql")
DML_FILE_PATH = os.path.join(os.path.dirname(__file__), "db/dml.sql")

def clear_terminal():
    os.system('cls' if os.name == 'nt' else 'clear')

def carregar_personagem(jogador):
    try:
        conn = get_connection()
        cursor = conn.cursor()
        cursor.execute("SELECT * FROM Jogador WHERE id_jogador = %s", (jogador,))
        jogador = cursor.fetchone()
        if jogador:
            return jogador
        else:
            print("Personagem não encontrado.")
            return None
    except Exception as e:
        print(f"Erro ao carregar personagem: {e}")
    finally:
        cursor.close()
        conn.close()

import random

def procurar_floresta(jogador):
    conn = None
    cursor = None
    clear_terminal()
    try:
        conn = get_connection()
        cursor = conn.cursor()
        print_animado("Você começou a procurar por recursos na floresta e achou uma árvore.\n")
        print("\nDeseja coletar madeira da árvore?\n")

        print("1 - Sim")
        print("2 - Não")
        opcao = input("Escolha uma opção: ")
        
        if opcao == "1":
            clear_terminal()
            if barra_de_precisao_floresta():
                clear_terminal()
                
                # Determina aleatoriamente se a madeira é normal (112) ou de lei (114)
                tipo_madeira = random.choice([112, 114])  # 112 = madeira normal, 114 = madeira de lei
                
                cursor.execute("""
                               SELECT id_inventario 
                               FROM inventario 
                               WHERE fk_id_jogador = %s""", (jogador[0],))
                inventario = cursor.fetchone()
                
                # Insere a madeira coletada no inventário
                cursor.execute("""
                    INSERT INTO instancia_de_item (fk_id_jogador, fk_id_item, fk_id_inventario) 
                    VALUES (%s, %s, %s)
                """, (jogador[0], tipo_madeira, inventario[0]))  # Certifique-se de usar inventario[0] para obter o ID
                conn.commit()
                cursor.execute("""
                    SELECT nome
                    FROM Mineral 
                    WHERE fk_id_item = %s""", (tipo_madeira,))
                madeira_coletada = cursor.fetchone()
                print(f"Você coletou uma {madeira_coletada[0]}")

                input("Aperte enter para continuar...")
            else:
                clear_terminal()
                print("Você não conseguiu coletar madeira.")
                input("Aperte enter para continuar...")
        elif opcao == "2":
            print("Voltando para a cidade...")
        else:
            print("Opção inválida. Tente novamente.")
    except Exception as e:
        print(f"Erro ao coletar a madeira: {e}")
        input("Pressione Enter para continuar...")
    finally:
        if cursor:
            cursor.close()
        if conn:
            conn.close()
        

# Atualize a função interacao_floresta para chamar procurar_floresta
def interacao_floresta(jogador):
    while True:
        clear_terminal()
        print_animado("Você está na floresta. O que deseja fazer?")
        print("1 - Procurar por recursos")
        print("2 - Voltar")
        opcao = input("Escolha uma opção: ")

        if opcao == "1":
            procurar_floresta(jogador)
        elif opcao == "2":
            print("Voltando para a cidade...")
            break
        else:
            print("Opção inválida. Tente novamente.")
        carregar_personagem(jogador)