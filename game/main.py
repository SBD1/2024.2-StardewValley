from setup.database import setup_database, get_connection

import os

DDL_FILE_PATH = os.path.join(os.path.dirname(__file__), "db/ddl.sql")
DML_FILE_PATH = os.path.join(os.path.dirname(__file__), "db/dml.sql")

def clear_terminal():
    os.system('cls' if os.name == 'nt' else 'clear')

def criar_personagem():
    nome = input("Digite o nome do seu personagem: ").strip()
    try:
        conn = get_connection()
        cursor = conn.cursor()
        cursor.execute(
            """
            INSERT INTO Jogador (nome) VALUES (%s)
            RETURNING id_jogador;
            """,
            (nome,)
        )
        jogador_id = cursor.fetchone()[0]
        conn.commit()
        print(f"Personagem '{nome}' criado com sucesso!")
        return jogador_id
    except Exception as e:
        print(f"Erro ao criar personagem: {e}")
    finally:
        cursor.close()
        conn.close()

def listar_personagens():
    try:
        conn = get_connection()
        cursor = conn.cursor()
        cursor.execute("SELECT id_jogador, nome FROM Jogador")
        personagens = cursor.fetchall()
        if not personagens:
            print("Nenhum personagem encontrado. Você precisa criar um novo.")
            return None
        print("\nPersonagens disponíveis:")
        for personagem in personagens:
            print(f"{personagem[0]} - {personagem[1]}")
        return personagens
    except Exception as e:
        print(f"Erro ao listar personagens: {e}")
    finally:
        cursor.close()
        conn.close()

def obter_localizacao_jogador(jogador):
    try:
        conn = get_connection()
        cursor = conn.cursor()
        cursor.execute("SELECT * FROM Ambiente WHERE fk_jogador_id = %s", (jogador[0],))
        localizacao = cursor.fetchone()
        if localizacao: 
            return localizacao
        else:
            print("Localizacao não encontrado.")
            return None
    except Exception as e:
        print(f"Erro ao carregar localizacao: {e}")

def ambiente_info(id_ambiente):
    try:
        conn = get_connection()
        cursor = conn.cursor()
        cursor.execute("SELECT * FROM Ambiente WHERE id_ambiente = %s", (id_ambiente,))
        infos = cursor.fetchone()
        if infos: 
            return infos
        else:
            print("Ambiente não encontrado.")
            return None
    except Exception as e:
        print(f"Erro ao carregar ambiente: {e}")

def andar_no_mapa(jogador, localizacao_atual):
    clear_terminal()
    print(f"Você está em {localizacao_atual[1]}\nAs opções para andar são:\n")
    index=1
    
    ambiente_opcoes = {}  # Dicionário para mapear a escolha ao id do ambiente

    for ambiente in localizacao_atual[5:]:
        if ambiente is not None:
            ambiente_dados = ambiente_info(ambiente)
            print(f'{index} - {ambiente_dados[1]}')
            ambiente_opcoes[index] = ambiente_dados[0]  # Mapeia a escolha ao id do ambiente
            index += 1
    
    print(f'{index} - Cancelar ação de andar\n')
    ambiente_opcoes[index] = None 
    
    try:
        escolha = int(input("Para qual ambiente você deseja seguir?\n> "))
        if escolha not in ambiente_opcoes:
            print("Escolha inválida. Tente novamente.")
            return None

        # Verifica se o usuário escolheu cancelar
        if ambiente_opcoes[escolha] is None:
            print("Ação cancelada.")
            return None
        
        conn = get_connection()
        cursor = conn.cursor()
        cursor.execute("UPDATE Ambiente SET fk_jogador_id = %s WHERE id_ambiente = %s", (jogador[0],ambiente_opcoes[escolha]))
        conn.commit()
        
        id_loc_atual = localizacao_atual[0]
        cursor.execute("UPDATE Ambiente SET fk_jogador_id = NULL WHERE id_ambiente = %s", (id_loc_atual,))
        conn.commit()
        
    except Exception as e:
        print(f"Erro ao carregar ambiente: {e}")
    
    finally:
        cursor.close()
        conn.close()
    
def menu_jogo(jogador):
    clear_terminal()
    while True:
        
        dia_atual = jogador[2]
        tempo_atual = jogador[3]
        vida_maxima = jogador[4]
        vida_atual = jogador[5]
        nome_player = jogador[1]
        xp_mineracao = jogador[6]
        xp_cultivo = jogador[7]
        xp_combate = jogador[8]
        dano_ataque = jogador[9]
        localizacao_atual = obter_localizacao_jogador(jogador)
    
        # Exibindo informações do jogador
        print(("\t"*10)+"\n##### Stardew Valley 🌾 #####\n")
        print(f"Dia: {dia_atual} | Tempo: {tempo_atual}")
        print(f"Fazendeiro(a): {nome_player}")
        print(f"Vida 🖤: {vida_atual}/{vida_maxima}")
        print(f"Dano de Ataque ⚔️: {dano_ataque}")
        print(f"XP Mineração ⛏️ : {xp_mineracao}")
        print(f"XP Cultivo 🌱 : {xp_cultivo}")
        print(f"XP Combate 🛡️ : {xp_combate}\n")
        
        #Exibindo a localizaçao atual do jogador
        print(f'Você está em {localizacao_atual[1]}\n{localizacao_atual[4]}\n')

        print("Suas opções:")
        opcoes_menu = [
            "1 - Andar no mapa",
            "9 - Sair do jogo"
        ]
        
        for op in opcoes_menu:
            print(op)

        escolha = int(input("\nO que você deseja fazer? (Digite o número da opção desejada)\n> "))

        if escolha == 1:
            andar_no_mapa(jogador, localizacao_atual)
        elif escolha == 9:
            break
        # break
    
    
def carregar_personagem(jogador_id):
    try:
        conn = get_connection()
        cursor = conn.cursor()
        cursor.execute("SELECT * FROM Jogador WHERE id_jogador = %s", (jogador_id,))
        jogador = cursor.fetchone()
        if jogador:
            print(f"\nBem-vindo de volta, {jogador[5]}!")
            return jogador
        else:
            print("Personagem não encontrado.")
            return None
    except Exception as e:
        print(f"Erro ao carregar personagem: {e}")
    finally:
        cursor.close()
        conn.close()

def menu_inicial():
    clear_terminal()
    while True:
        print("\n##### Stardew Valley 🌾 #####\n")
        print("1. Criar novo personagem")
        print("2. Continuar com um personagem existente")
        print("3. Sair")
        escolha = input("Escolha uma opção: ").strip()

        if escolha == "1":
            player_id = criar_personagem()
            return player_id
        elif escolha == "2":
            personagens = listar_personagens()
            if personagens:
                escolha_personagem = input("Digite o ID do personagem para continuar: ").strip()
                for personagem in personagens:
                    if str(personagem[0]) == escolha_personagem:
                        return carregar_personagem(personagem[0])
                print("ID inválido. Tente novamente.")
            else:
                continue
        elif escolha == "3":
            print("Até logo!")
            exit()
        else:
            print("Opção inválida. Tente novamente.")


if __name__ == "__main__":
    print("Inicializando o banco de dados...")
    #setup_database(DDL_FILE_PATH,DML_FILE_PATH)  

    jogador = menu_inicial()
    if jogador:
        print(f"\nVocê está pronto para começar, {jogador[5]}!")
        clear_terminal()
        menu_jogo(jogador)