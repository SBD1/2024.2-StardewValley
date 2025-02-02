from setup.database import get_connection
from src.interacoes_mapa.interacao_caverna import interacao_caverna
from src.interacoes_mapa.interacao_celeiro import interacao_celeiro
from src.avancar_tempo import avancar_tempo
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
        return carregar_personagem(jogador_id)  # Retorna o jogador completo
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

def exibir_habilidades_jogador(jogador):
    clear_terminal()
    
    try:
        conn = get_connection()
        cursor = conn.cursor()
        cursor.execute("SELECT * FROM Habilidade WHERE id_habilidade in (%s,%s,%s)", (jogador[11],jogador[12],jogador[13]))
        
        habilidades = cursor.fetchall()
        

       #habilidade mineracao
        conn = get_connection()
        cursor = conn.cursor()
        cursor.execute("SELECT fk_Habilidade_id, nivel, reducaoEnergiaMinera,minerioBonus,xpMin,xpMax FROM habMineracao WHERE fk_Habilidade_id = %s",(habilidades[0][0],))
        habMineracao = cursor.fetchone()
        
        #habilidade combate
        conn = get_connection()
        cursor = conn.cursor()
        cursor.execute("SELECT fk_Habilidade_id,nivel, vidaBonus,danoBonus,xpMin,xpMax FROM habCombate WHERE fk_Habilidade_id = %s",(int(habilidades[1][0]),))
        habCombate = cursor.fetchone()
        
        #habilidade cultivo
        conn = get_connection()
        cursor = conn.cursor()
        cursor.execute("SELECT fk_Habilidade_id,nivel, cultivoBonus,reducaoEnergiaCultiva,xpMin,xpMax FROM habCultivo WHERE fk_Habilidade_id = %s",(habilidades[2][0],))
        habCultivo = cursor.fetchone()
        
        print("\n============= Habilidades do Jogador =============\n")
        
        print("-" * 50)
        print(f"Habilidade Mineração: ")
        print(f"  Nível: {habMineracao[1]}")    
        print(f"  Redução de Energia ao Minerar: {habMineracao[2]}%")
        print(f"  Bônus de Minérios: {habMineracao[3]}")
        print("-" * 50)
        
        print(f"Habilidade Combate: ")
        print(f"  Nível: {habCombate[1]}") 
        print(f"  Vida Extra: {habCombate[2]}")
        print(f"  Dano Extra: {habCombate[3]}")
        print("-" * 50)
        
        print(f"Habilidade Cultivo: ")
        print(f"  Nível: {habCultivo[1]}")
        print(f"  Redução de Energia ao Cultivar: {habCultivo[3]}%")
        print(f"  Bônus de Cultivo:: {habCultivo[2]}")
        print("-" * 50)
        
        input("\nDigite 1 para retornar ao menu\n>")
        
    except Exception as e:
        print(f"Erro ao carregar habilidades: {e}")


def exibir_inventario_jogador(jogador):
    clear_terminal()
    try:
        conn = get_connection()
        cursor = conn.cursor()
        cursor.execute("SELECT nome_item, tipo_item ,quantidade, preco_item FROM vw_inventario_jogador WHERE id_jogador = %s ", (jogador[0],))
        
        inventario = cursor.fetchall()

        if not inventario:
            print("\n📦 O inventário está vazio!\n")
        else:
            print("\n🎒 Inventário do Jogador 🎒\n")
            print(f"{'Nome do Item':<20} {'Tipo':<15} {'Qtd':<5} {'Preço':<8}")
            print("=" * 50)

            for item in inventario:
                nome, tipo, quantidade, preco = item
                print(f"{nome:<20} {tipo:<15} {quantidade:<5} {preco:<8.2f}")

        input("\nDigite 1 para retornar ao menu\n> ")
        
    except Exception as e:
        print(f"❌ Erro ao carregar inventário: {e}")


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
    print(f"Você está em {localizacao_atual[2]}\nAs opções para andar são:\n")
    index=1
    
    ambiente_opcoes = {}

    for ambiente in localizacao_atual[5:]:
        if ambiente is not None:
            ambiente_dados = ambiente_info(ambiente)
            print(f'{index} - {ambiente_dados[2]}')
            ambiente_opcoes[index] = ambiente_dados[0]  # Mapeia a escolha ao id do ambiente
            index += 1

    print(f'{index} - Cancelar ação de andar\n')
    ambiente_opcoes[index] = None 
    
    conn = None
    cursor = None
    try:
        escolha = int(input("Para qual ambiente você deseja seguir?\n> "))
        if escolha not in ambiente_opcoes:
            print("Escolha inválida. Tente novamente.")
            return None

        # Verifica se o usuário escolheu cancelar
        if ambiente_opcoes[escolha] is None:
            print("Ação cancelada.")
            return None
        
        #print(ambiente_opcoes[escolha])
        
        conn = get_connection()
        cursor = conn.cursor()
        cursor.execute("UPDATE Jogador SET localizacao_atual= %s WHERE id_jogador = %s",
                       (ambiente_opcoes[escolha],jogador[0]))
        conn.commit()
        
        #id_loc_atual = localizacao_atual[0]
        #cursor.execute("UPDATE Ambiente SET fk_jogador_id = NULL WHERE id_ambiente = %s",
        #               (id_loc_atual,))
        #conn.commit()
        
    except Exception as e:
        print(f"Erro ao carregar ambiente: {e}")
    
    finally:
        if cursor:
            cursor.close()
        if conn:
            conn.close()

def interagir_ambiente(jogador, localizacao_atual):
    if localizacao_atual[1] == 'Caverna':
        interacao_caverna(jogador)
    elif localizacao_atual[1] == 'Celeiro':
        interacao_celeiro(jogador)

def menu_jogo(jogador):
    while True:
        clear_terminal() 
        id_jogador = jogador[0]
        nome_jogador = jogador[1]
        dia_atual = jogador[2]
        tempo_atual = jogador[3]
        localizacao_atual =  ambiente_info(jogador[4])
        vida_maxima = jogador[5]
        vida_atual = jogador[6]
        xp_mineracao = jogador[7]
        xp_cultivo = jogador[8]
        xp_combate = jogador[9]
        dano_ataque = jogador[10]
        moeda = jogador[11]
        print(("\t"*10)+"\n##### Stardew Valley 🌾 #####\n")
        print(f"📅 Dia: {dia_atual} | 🕠 Tempo: {tempo_atual}")
        print(f"Fazendeiro(a): {nome_jogador}\n")
        print(f"Moedas 💰: {moeda}")
        print(f"Vida 🖤: {vida_atual}/{vida_maxima}")
        print(f"Dano de Ataque ⚔️: {dano_ataque}")
        print(f"XP Mineração ⛏️ : {xp_mineracao}")
        print(f"XP Cultivo 🌱 : {xp_cultivo}")
        print(f"XP Combate 🛡️ : {xp_combate}\n")
        
        print(f'Você está em {localizacao_atual[2]}\n{localizacao_atual[3]}\n')

        print("Suas opções:")
        opcoes_menu = [
            "1 - Andar no mapa",
            "2 - Mostrar Habilidades",
            "3 - Interagir com o ambiente",
            "4 - Abrir inventário",
            "9 - Sair do jogo"
        ]
        
        for op in opcoes_menu:
            print(op)

        escolha = int(input("\nO que você deseja fazer? (Digite o número da opção desejada)\n> "))

        if escolha == 1:
            andar_no_mapa(jogador, localizacao_atual)
            avancar_tempo(jogador, 61)
        elif escolha == 2:
            exibir_habilidades_jogador(jogador)
        elif escolha == 3:
            interagir_ambiente(jogador, localizacao_atual)
        elif escolha == 4:
            exibir_inventario_jogador(jogador)
        elif escolha == 9:
            break
        jogador = carregar_personagem(id_jogador)
        
    
    
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
        print(f"\nVocê está pronto para começar, {jogador[1]}!")  # Agora jogador é uma tupla
        clear_terminal()
        menu_jogo(jogador)