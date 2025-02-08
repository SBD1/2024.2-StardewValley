from setup.database import get_connection
from src.interacoes_mapa.interacao_caverna import interacao_caverna
from src.interacoes_mapa.interacao_celeiro import interacao_celeiro
from src.interacoes_mapa.interacao_plantacao import interacao_plantacao
from src.avancar_tempo import avancar_tempo
from src.interacoes_mapa.interacao_floresta import interacao_floresta
from src.utils.animacao_escrita import print_animado
from src.interacoes_mapa.interacao_loja import interacao_loja
from src.interacoes_mapa.interacao_cabana import interacao_cabana
import os
import pygame
import time

DDL_FILE_PATH = os.path.join(os.path.dirname(__file__), "db/ddl.sql")
DML_FILE_PATH = os.path.join(os.path.dirname(__file__), "db/dml.sql")

def clear_terminal():
    os.system('cls' if os.name == 'nt' else 'clear')

def iniciar_musica():
    pygame.mixer.init()
    pygame.mixer.music.load(os.path.join(os.path.dirname(__file__), "src/music-stardew.mp3"))
    pygame.mixer.music.set_volume(0.3)  # Ajusta o volume (0.0 a 1.0)
    pygame.mixer.music.play(-1)  # "-1" faz a música tocar em loop

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

        # Criar um inventário para o novo jogador
        cursor.execute(
            """
            INSERT INTO inventario (fk_id_jogador) VALUES (%s);
            """,
            (jogador_id,)
        )
        conn.commit()
        clear_terminal()
        print_animado(f"Personagem '{nome}' criado com sucesso!")
        input("Pressione Enter para continuar...")
        clear_terminal()
        print_animado(f"Olá, {nome}! Bem-vindo ao Stardew Valley! 🌾\n")
        input("Pressione Enter para continuar...")

        ## História do jogo
        clear_terminal()
        print_animado("Após anos vivendo a rotina exaustiva da cidade grande, onde os dias se confundiam em uma monotonia cinzenta, você finalmente decidiu seguir o chamado de seu destino.\n")
        input("Pressione Enter para continuar...")
        clear_terminal()
        print_animado("Um antigo envelope, deixado por seu avô em seu leito de morte, continha palavras que ecoavam em sua mente até hoje:")
        input("Pressione Enter para continuar...")
        clear_terminal()
        print_animado("\"Querido(a) neto(a),\n Um dia você sentirá que a vida moderna já não lhe traz satisfação. Quando esse momento chegar, pegue esta carta... Ela guarda a chave para um novo começo.\"\n")
        input("Pressione Enter para continuar...")
        clear_terminal()
        print_animado("Com as mãos trêmulas, você abriu o envelope e descobriu a herança deixada por ele: uma pequena fazenda em um vale distante, um lugar onde a terra é fértil, o ar é puro e a vida segue o ritmo das estações. Era sua chance de recomeçar, de deixar para trás o peso da cidade e encontrar um propósito na simplicidade do campo.\n")
        input("Pressione Enter para continuar...")

        clear_terminal()
        print_animado("E assim, com uma mochila leve, mas um coração cheio de esperança, você embarcou na jornada até Stardew Valley. \n Agora, de pé diante da porteira desgastada, observa a paisagem à sua frente: campos selvagens tomados pelo tempo, uma casa modesta mas acolhedora, e ao fundo, o som das árvores balançando ao vento. \n Sua nova vida começa agora.\n")
        input("Pressione Enter para continuar...")

        return carregar_personagem(jogador_id)  # Retorna o jogador completo
    except Exception as e:
        print_animado(f"Erro ao criar personagem: {e}")
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
        print_animado("\nPersonagens disponíveis:")
        for personagem in personagens:
            print(f"{personagem[0]} - {personagem[1]}")
        return personagens
    except Exception as e:
        print_animado(f"Erro ao listar personagens: {e}")
    finally:
        cursor.close()
        conn.close()

def exibir_habilidades_jogador(jogador):
    clear_terminal()
    
    try:
        conn = get_connection()
        cursor = conn.cursor()
        cursor.execute("SELECT * FROM Habilidade WHERE id_habilidade in (%s,%s,%s)", (jogador[12],jogador[13],jogador[14]))
        
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
        print_animado(f"Erro ao carregar habilidades: {e}")


def exibir_inventario_jogador(jogador):
    clear_terminal()
    try:
        conn = get_connection()
        cursor = conn.cursor()
        cursor.execute("SELECT nome_item, tipo_item, quantidade, preco_item FROM vw_inventario_jogador WHERE id_jogador = %s", (jogador[0],))
        
        inventario = cursor.fetchall()

        if not inventario:
            print_animado("\n📦 O inventário está vazio!\n")
        else:
            print("\n🎒 Inventário do Jogador 🎒\n")
            print(f"{'Nome do Item':<20} {'Tipo':<15} {'Qtd':<5} {'Preço':<8}")
            print("=" * 50)

            for item in inventario:
                nome, tipo, quantidade, preco = item
                # Verifica se quantidade e preco não são None antes de formatar
                quantidade = quantidade if quantidade is not None else 0
                preco = preco if preco is not None else 0.0
                print(f"{nome:<20} {tipo:<15} {quantidade:<5} {preco:<8.2f}")

        input("\nDigite 1 para retornar ao menu\n> ")
        
    except Exception as e:
        print_animado(f"❌ Erro ao carregar inventário: {e}")
        input("\nPressione Enter para continuar...\n> ")


def obter_localizacao_jogador(jogador):
    try:
        conn = get_connection()
        cursor = conn.cursor()
        cursor.execute("SELECT * FROM Ambiente WHERE fk_jogador_id = %s", (jogador[0],))
        localizacao = cursor.fetchone()
        if localizacao: 
            return localizacao
        else:
            print_animado("Localizacao não encontrada.")
            return None
    except Exception as e:
        print_animado(f"Erro ao carregar localizacao: {e}")

def ambiente_info(id_ambiente):
    try:
        conn = get_connection()
        cursor = conn.cursor()
        cursor.execute("SELECT * FROM Ambiente WHERE id_ambiente = %s", (id_ambiente,))
        infos = cursor.fetchone()
        if infos: 
            return infos
        else:
            print_animado("Ambiente não encontrado.")
            return None
    except Exception as e:
        print_animado(f"Erro ao carregar ambiente: {e}")

def conferir_caverna(jogador, localizacao_atual, escolha=None):
    try:
        conn = get_connection()
        cursor = conn.cursor()
        
        # jogador está tentando ir para o próximo andar
        if escolha == 2:
            cursor.execute("""
                SELECT COUNT(*)
                FROM instancia_de_inimigo 
                WHERE fk_id_ambiente = %s AND fk_jogador_id = %s;""",
            (localizacao_atual[0], jogador[0]))
            mobs_andar_atual = cursor.fetchone()

            if mobs_andar_atual[0] != 0 and localizacao_atual[0] > 15:
                print("\nVocê não pode prosseguir para o próximo andar enquanto houver inimigos no andar atual. Interaja com o ambiente para derrotá-los.")
                input("\nPressione qualquer tecla para continuar...")
                return True
        elif escolha is None:
            cursor.execute("SELECT COUNT(*) FROM instancia_de_inimigo WHERE fk_jogador_id = %s;", (jogador[0],))
            mobs_totais = cursor.fetchone()

            if mobs_totais[0] == 0 and localizacao_atual[0] == 15:
                cursor.execute("SELECT spawnar_inimigos(%s);", (jogador[0],))
                conn.commit()
                print("\n Você ouve sons abafados ecoando pelas paredes da caverna... algo está se movendo nas sombras. Cuidado ao tentar avançar pelos andares da caverna!")
                input("\nPressione enter para continuar...")
        else:
            return False
    except Exception as e:
        print(f"Erro ao conferir a caverna: {e}")
        input("\nPressione qualquer tecla para continuar...")
    finally:
        if cursor:
            cursor.close()
        if conn:
            conn.close()

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
        conn = get_connection()
        cursor = conn.cursor()

        escolha = int(input("Para qual ambiente você deseja seguir?\n> "))
        if escolha not in ambiente_opcoes:
            print_animado("Escolha inválida. Tente novamente.")
            return None

        # verifica se pode prosseguir para o próximo andar 
        if localizacao_atual[1] == 'Caverna' and conferir_caverna(jogador, localizacao_atual, escolha):
            return None

        # Verifica se o usuário escolheu cancelar
        if ambiente_opcoes[escolha] is None:
            print_animado("Ação cancelada.")
            return None
        
        #print(ambiente_opcoes[escolha])
        
        conn = get_connection()
        cursor = conn.cursor()
        cursor.execute("""UPDATE Jogador SET localizacao_atual= %s WHERE id_jogador = %s
                        RETURNING localizacao_atual""",
                       (ambiente_opcoes[escolha],jogador[0]))
        conn.commit()
        localizacao_atual = cursor.fetchone()
        
        # verifica se é necessário spawnar inimigos
        if localizacao_atual[0] == 15:
            conferir_caverna(jogador, localizacao_atual)

        #id_loc_atual = localizacao_atual[0]
        #cursor.execute("UPDATE Ambiente SET fk_jogador_id = NULL WHERE id_ambiente = %s",
        #               (id_loc_atual,))
        #conn.commit()
        
    except Exception as e:
        print_animado(f"Erro ao carregar ambiente: {e}")
    
    finally:
        if cursor:
            cursor.close()
        if conn:
            conn.close()

def interagir_ambiente(jogador, localizacao_atual):
    if localizacao_atual[1] == 'Caverna':
        interacao_caverna(jogador, localizacao_atual)
    elif localizacao_atual[1] == 'Celeiro':
        interacao_celeiro(jogador)
    elif localizacao_atual[1] == 'Plantação':
        interacao_plantacao(jogador)
    elif localizacao_atual[2] == 'Floresta':
        interacao_floresta(jogador)
    elif localizacao_atual[1] == 'Loja':
        interacao_loja(jogador)
    elif localizacao_atual[1] == 'CasaJogador':
        interacao_cabana(jogador)

def abrir_mapa():
    clear_terminal()
    print(""" 
    [Comércio do Deserto]     [Caverna]
                \              /
            [Deserto]───[Floresta]───[Guilda dos Aventureiros]
                             │                          
            [Plantação]──[Cabana]───[Celeiro]     [Ferreiro]
                             │                       /
[Armazém do Pierre]──[Praça da Vila]───[Centro Comunitário]───[Mercado Joja]
                            │                     │
                         [Praia]        [Clínica do Harvey]
                                        
          """)
    input("\nDigite 1 para retornar ao menu\n>")

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
            "5 - Abrir mapa da Vila",
            "9 - Sair do jogo"
        ]
        
        for op in opcoes_menu:
            print(op)

        try:
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
            elif escolha == 5:
                abrir_mapa()
            elif escolha == 9:
                break
            jogador = carregar_personagem(id_jogador)

        except ValueError:
            print("\nOpção inválida. Tente novamente.")
            input("Pressione qualquer tecla para continuar...")
            continue
        
    
    
def carregar_personagem(jogador_id):
    try:
        conn = get_connection()
        cursor = conn.cursor()
        cursor.execute("SELECT * FROM Jogador WHERE id_jogador = %s", (jogador_id,))
        jogador = cursor.fetchone()
        if jogador:
            return jogador
        else:
            print_animado("Personagem não encontrado.")
            return None
    except Exception as e:
        print_animado(f"Erro ao carregar personagem: {e}")
    finally:
        cursor.close()
        conn.close()

def menu_inicial():
    while True:
        clear_terminal()
        print("""
╚═════╝░░░░╚═╝░░░╚═╝░░╚═╝╚═╝░░╚═╝╚═════╝░╚══════╝░░░╚═╝░░░╚═╝░░  ░░░╚═╝░░░╚═╝░░╚═╝╚══════╝╚══════╝╚══════╝░░░╚═╝░░░
              """)
        time.sleep(1)
        clear_terminal()
        print("""
██████╔╝░░░██║░░░██║░░██║██║░░██║██████╔╝███████╗░░╚██╔╝░╚██╔╝░  ░░╚██╔╝░░██║░░██║███████╗███████╗███████╗░░░██║░░░
╚═════╝░░░░╚═╝░░░╚═╝░░╚═╝╚═╝░░╚═╝╚═════╝░╚══════╝░░░╚═╝░░░╚═╝░░  ░░░╚═╝░░░╚═╝░░╚═╝╚══════╝╚══════╝╚══════╝░░░╚═╝░░░
              """)
        time.sleep(1)
        clear_terminal()
        print("""
░╚═══██╗░░░██║░░░██╔══██║██╔══██╗██║░░██║██╔══╝░░░░████╔═████║░  ░╚████╔╝░██╔══██║██║░░░░░██║░░░░░██╔══╝░░░░╚██╔╝░░
██████╔╝░░░██║░░░██║░░██║██║░░██║██████╔╝███████╗░░╚██╔╝░╚██╔╝░  ░░╚██╔╝░░██║░░██║███████╗███████╗███████╗░░░██║░░░
╚═════╝░░░░╚═╝░░░╚═╝░░╚═╝╚═╝░░╚═╝╚═════╝░╚══════╝░░░╚═╝░░░╚═╝░░  ░░░╚═╝░░░╚═╝░░╚═╝╚══════╝╚══════╝╚══════╝░░░╚═╝░░░
              """)
        time.sleep(1)
        clear_terminal()
        print("""
╚█████╗░░░░██║░░░███████║██████╔╝██║░░██║█████╗░░░╚██╗████╗██╔╝  ╚██╗░██╔╝███████║██║░░░░░██║░░░░░█████╗░░░╚████╔╝░
░╚═══██╗░░░██║░░░██╔══██║██╔══██╗██║░░██║██╔══╝░░░░████╔═████║░  ░╚████╔╝░██╔══██║██║░░░░░██║░░░░░██╔══╝░░░░╚██╔╝░░
██████╔╝░░░██║░░░██║░░██║██║░░██║██████╔╝███████╗░░╚██╔╝░╚██╔╝░  ░░╚██╔╝░░██║░░██║███████╗███████╗███████╗░░░██║░░░
╚═════╝░░░░╚═╝░░░╚═╝░░╚═╝╚═╝░░╚═╝╚═════╝░╚══════╝░░░╚═╝░░░╚═╝░░  ░░░╚═╝░░░╚═╝░░╚═╝╚══════╝╚══════╝╚══════╝░░░╚═╝░░░
              """)
        time.sleep(1)
        clear_terminal()
        print("""
██╔════╝╚══██╔══╝██╔══██╗██╔══██╗██╔══██╗██╔════╝░██║░░██╗░░██║  ██║░░░██║██╔══██╗██║░░░░░██║░░░░░██╔════╝╚██╗░██╔╝
╚█████╗░░░░██║░░░███████║██████╔╝██║░░██║█████╗░░░╚██╗████╗██╔╝  ╚██╗░██╔╝███████║██║░░░░░██║░░░░░█████╗░░░╚████╔╝░
░╚═══██╗░░░██║░░░██╔══██║██╔══██╗██║░░██║██╔══╝░░░░████╔═████║░  ░╚████╔╝░██╔══██║██║░░░░░██║░░░░░██╔══╝░░░░╚██╔╝░░
██████╔╝░░░██║░░░██║░░██║██║░░██║██████╔╝███████╗░░╚██╔╝░╚██╔╝░  ░░╚██╔╝░░██║░░██║███████╗███████╗███████╗░░░██║░░░
╚═════╝░░░░╚═╝░░░╚═╝░░╚═╝╚═╝░░╚═╝╚═════╝░╚══════╝░░░╚═╝░░░╚═╝░░  ░░░╚═╝░░░╚═╝░░╚═╝╚══════╝╚══════╝╚══════╝░░░╚═╝░░░
              """)
        time.sleep(1)
        clear_terminal()
        print("""
░██████╗████████╗░█████╗░██████╗░██████╗░███████╗░██╗░░░░░░░██╗  ██╗░░░██╗░█████╗░██╗░░░░░██╗░░░░░███████╗██╗░░░██╗
██╔════╝╚══██╔══╝██╔══██╗██╔══██╗██╔══██╗██╔════╝░██║░░██╗░░██║  ██║░░░██║██╔══██╗██║░░░░░██║░░░░░██╔════╝╚██╗░██╔╝
╚█████╗░░░░██║░░░███████║██████╔╝██║░░██║█████╗░░░╚██╗████╗██╔╝  ╚██╗░██╔╝███████║██║░░░░░██║░░░░░█████╗░░░╚████╔╝░
░╚═══██╗░░░██║░░░██╔══██║██╔══██╗██║░░██║██╔══╝░░░░████╔═████║░  ░╚████╔╝░██╔══██║██║░░░░░██║░░░░░██╔══╝░░░░╚██╔╝░░
██████╔╝░░░██║░░░██║░░██║██║░░██║██████╔╝███████╗░░╚██╔╝░╚██╔╝░  ░░╚██╔╝░░██║░░██║███████╗███████╗███████╗░░░██║░░░
╚═════╝░░░░╚═╝░░░╚═╝░░╚═╝╚═╝░░╚═╝╚═════╝░╚══════╝░░░╚═╝░░░╚═╝░░  ░░░╚═╝░░░╚═╝░░╚═╝╚══════╝╚══════╝╚══════╝░░░╚═╝░░░
              """)
        print_animado("\n1. Criar novo personagem")
        time.sleep(0.5)
        print_animado("2. Continuar com um personagem existente")
        time.sleep(0.5)
        print_animado("3. Sair")
        time.sleep(1.2)
        escolha = input("Escolha uma opção: ").strip()

        if escolha == "1":
            jogador = criar_personagem()
            return jogador
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
    iniciar_musica()
    #setup_database(DDL_FILE_PATH,DML_FILE_PATH)  

    jogador = menu_inicial()
    if jogador:
        print(f"\nVocê está pronto para começar, {jogador[1]}!")
        input("\nPressione enter para continuar...")
        clear_terminal()
        menu_jogo(jogador)