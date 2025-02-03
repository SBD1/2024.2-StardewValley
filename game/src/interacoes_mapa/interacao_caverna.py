from ..mineracao_precisao import barra_de_precisao
from setup.database import get_connection
import random
import os
import time

DDL_FILE_PATH = os.path.join(os.path.dirname(__file__), "db/ddl.sql")
DML_FILE_PATH = os.path.join(os.path.dirname(__file__), "db/dml.sql")

# Dicionário de minérios
minerios = {
    101: {"nome": "Pedra", "descricao": "Um material de construção básico."},
    102: {"nome": "Bronze", "descricao": "Um metal utilizado em ferramentas."},
    103: {"nome": "Ferro", "descricao": "Metal resistente e versátil."},
    104: {"nome": "Ouro", "descricao": "Metal precioso e valioso."},
    105: {"nome": "Fragmento Prismatico", "descricao": "Um raro cristal multicolorido."},
    106: {"nome": "Água Marinha", "descricao": "Uma gema azul-esverdeada brilhante."},
    107: {"nome": "Carvão", "descricao": "Material utilizado para fundição."},
    108: {"nome": "Rubi", "descricao": "Uma gema vermelha reluzente."},
    109: {"nome": "Jade", "descricao": "Uma pedra preciosa verde."},
    110: {"nome": "Ametista", "descricao": "Uma gema roxa brilhante."},
    111: {"nome": "Esmeralda", "descricao": "Uma gema verde de rara beleza."},
    113: {"nome": "Diamante", "descricao": "Uma gema preciosa e brilhante."},
}

def clear_terminal():
    os.system('cls' if os.name == 'nt' else 'clear')

def carregar_personagem(jogador_id):
    try:
        conn = get_connection()
        cursor = conn.cursor()
        cursor.execute("SELECT * FROM Jogador WHERE id_jogador = %s", (jogador_id,))
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


def interacao_caverna(jogador):
    try:
    #clear_terminal()
        #clear_terminal()
        connection = get_connection()
        cursor = connection.cursor()
        # ambiente_atual = jogador[4]
        jogador = carregar_personagem(jogador[0])
        andar = 1 #Consultar o banco para descobrir qual o andar atual
        cursor.execute("SELECT * FROM caverna WHERE andar= %s", (andar,))
        result = cursor.fetchone()
        qtd_minerios = result[3]
        if result:
            qtd_mobs = result[2]
        else:
            qtd_mobs = None
        print(f"Voce entrou na caverna e está no andar {andar}");
        if qtd_mobs < 0: # <-- Corrigir para (if qtd_mobs > 0:) quando a lógica de combate for mergeada
            combate(jogador)
            # print("Mate os mobs para conseguir procurar minérios!");
            # print(f"Quantidade de mobs no andar: {qtd_mobs}");

        else:
            print("Ok, não tem mais mobs neste andar, agora você pode minerar!")            
            print("\nO que você gostaria de fazer?")
            print("1 - Minerar")
            print("2 - Ir para o próximo andar")
            print("3 - Sair do andar")
            escolha = int(input("Digite o número da opção desejada: "))
            if escolha == 1:
                minerar(jogador, qtd_minerios)
            elif escolha == 2:
                mudar_andar(jogador, andar+1)
            elif escolha == 3:
                mudar_andar(jogador, andar-1)
            else:
                print("Opção inválida. Tente novamente.")
            
    except Exception as error:
        print(f"Ocorreu um erro ao interagir com a caverna: {error}")
    finally:
        if cursor:
                cursor.close()
        if connection:
            connection.close()

def minerar(jogador, minerios_disponiveis):
    andar = 1  # Consultar o banco para descobrir qual o andar atual
    print("\n")
    
    if minerios_disponiveis <= 0:    
        print("Você não encontrou minérios para minerar...")
        time.sleep(2)
        return
    
    if barra_de_precisao():
        minerio_id = random.choice(list(minerios.keys()))
        minerio = minerios[minerio_id]
        print(f"Parabéns! Você conseguiu minerar e encontrou {minerio['nome']} ({minerio['descricao']})!")
        escolha = int(input("Deseja armazenar o minério? (1 - Sim, 2 - Não) "))
        if escolha == 1:
            connection = get_connection()
            cursor = connection.cursor()
            # cursor.execute("" (,)) (inserir minério na mochila)
            print("Minério armazenado com sucesso!")
            time.sleep(3)
            return minerio
        elif escolha == 2:
            print("Minério descartado...")
            time.sleep(2)
            return
        elif escolha != 1 or escolha != 2:
            print("Opção inválida. Tente novamente.")
            return
    else:
        print("Você quebrou a pedra, mas não encontrou nada de valor :(")
        time.sleep(3)
        return None

def mudar_andar(jogador, andar):
    print("Mudando de andar...")

def combate(jogador):
    print("Combate...")

    # Adicionar view para possiveis recompensas
    # ou itens pré determinados na "view" de recompensas, decretados por um random()