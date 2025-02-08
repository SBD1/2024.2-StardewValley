from setup.database import get_connection
import os
from datetime import datetime
from ..utils.animacao_escrita import print_animado
DDL_FILE_PATH = os.path.join(os.path.dirname(__file__), "db/ddl.sql")
DML_FILE_PATH = os.path.join(os.path.dirname(__file__), "db/dml.sql")

def clear_terminal():
    os.system('cls' if os.name == 'nt' else 'clear')

def carregar_personagem(jogador):
    try:
        conn = get_connection()
        cursor = conn.cursor()
        cursor.execute("SELECT * FROM Jogador WHERE id_jogador = %s", (jogador[0],))
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

def interacao_cabana(jogador):
    while True:
        clear_terminal()
        print("O que deseja fazer?\n")
        print("1 - Dormir")
        print("2 - Sair")
        opcao = input("Digite a opção desejada: ")

        if opcao == "1":
            dormir(jogador)
        elif opcao == "2":
            break
        else:
            print("Opção inválida")
        carregar_personagem(jogador)

def dormir(jogador):
    connection = get_connection()
    cursor = connection.cursor()

    hora_atual = jogador[3]
    hora_inicio = datetime.strptime("06:00", "%H:%M").time()
    hora_fim = datetime.strptime("18:00", "%H:%M").time()

    if hora_inicio <= hora_atual <= hora_fim:
        clear_terminal
        print_animado("Você não pode dormir agora \n")
        input("Pressione enter para continuar")
        return
    else:
        cursor.execute("""
            UPDATE Jogador SET tempo = '06:00', dia = dia + 1 WHERE id_jogador = %s
        """, (jogador[0],))
        connection.commit()
        cursor.execute("""
            SELECT h.dia, h.historia FROM Historia h 
            JOIN Jogador j ON h.dia = j.dia 
            WHERE j.id_jogador = %s
        """, (jogador[0],))
        historia = cursor.fetchone()
        if historia[0] > 100:
            clear_terminal()
            print("Não há mais histórias disponíveis para dias além do 100.")
        else:
            clear_terminal()
            print_animado("Você dormiu e acordou às 06:00\n")
            input("Pressione enter para continuar")
            return