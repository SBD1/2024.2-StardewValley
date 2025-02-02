from ..mineracao_precisao import barra_de_precisao
from ..Barra_status import barra_status_vida
from setup.database import get_connection
import os
import random
import time

DDL_FILE_PATH = os.path.join(os.path.dirname(__file__), "db/ddl.sql")
DML_FILE_PATH = os.path.join(os.path.dirname(__file__), "db/dml.sql")

def clear_terminal():
    os.system('cls' if os.name == 'nt' else 'clear')

def ataque_inimigo(ambiente, tipo_inimigo):
    andar = ambiente[0] - 15
    dano = tipo_inimigo[4]
    resultado = random.randint(0, 100)
    peso = 0.05 + andar # precisao dos inimigos aumenta conforme o andar
    
    if (25 / peso) <= resultado <= (75 * peso):
        return dano
    return  0

def exibir_status_combate(jogador_dict, inimigo_dict):
    clear_terminal()

    # Garantindo que não pegue um valor negativo de vida
    vida_jogador = max(jogador_dict['vidaAtual'], 0)
    vida_inimigo = max(inimigo_dict['vida'], 0)

    print("⚔️  " * 7, " COMBATE ", "⚔️  " * 7)
    print(f"\nStatus do jogador {jogador_dict['nome']}")
    barra_status_vida(vida_jogador, jogador_dict['vidaMax'])  
    print(f"\nPoções de vida: x (implementar consulta) ")
    print(f"\nStatus do {inimigo_dict['tipo'][1]}")
    barra_status_vida(vida_inimigo, inimigo_dict['tipo'][3])  

def get_instancia_inimigo(id_instancia_inimigo):
    try:
        connection = get_connection()
        cursor = connection.cursor()

        cursor.execute("""SELECT * FROM Instancia_de_Inimigo 
                    WHERE fk_inimigo_id = %s 
                    ORDER BY id_instancia_de_inimigo""", (id_instancia_inimigo,))
        instancia_inimigo = cursor.fetchone()

        return instancia_inimigo
    except Exception as error:
        print(f"Ocorreu um erro ao buscar a instância do inimigo: {error}")
        input("\nPressione enter para continuar...")
    finally:
        if connection:
            cursor.close()
            connection.close()

def info_andar(ambiente, caverna_andar, jogador_dict):
    print(f"\n{ambiente[3]}")  # Exibe a descrição do ambiente

    lista_instancias_inimigos = None
    quantidade_mobs = None

    try:
        connection = get_connection()
        cursor = connection.cursor()

        # TODO: listar apenas os inimigos do "save" do jogador, ou seja, filtrar pelo fk_jogador_id e fk_id_ambiente (andar da caverna)
        cursor.execute("""
            SELECT i.*, COUNT(*) AS quantidade
            FROM Instancia_de_Inimigo ii
            JOIN inimigo i ON ii.fk_inimigo_id = i.id_inimigo
            WHERE ii.fk_id_ambiente = %s AND ii.fk_jogador_id = %s
            GROUP BY i.id_inimigo, i.nome, i.vidamax, i.dano
            ORDER BY quantidade DESC
        """, (caverna_andar[0], jogador_dict['id_jogador']))
        # lista_instancias_inimigos[x] = (nome, id_instancia_de_inimigo, vidaMax, quantidade)
        lista_instancias_inimigos = cursor.fetchall()

        cursor.execute("""
            SELECT quantidade_mobs
            FROM Caverna
            WHERE fk_id_ambiente = %s
        """, (ambiente[0],))
        quantidade_mobs = cursor.fetchone()

        inimigos_dict = {
            "lista_instancias_inimigos": lista_instancias_inimigos,
            "quantidade_mobs": quantidade_mobs[0] if quantidade_mobs else None
        }
        # TODO:  fazer o mesmo para minerios
        
        return inimigos_dict
    except Exception as error:
        print(f"Ocorreu um erro ao listar os inimigos em info_andar(): {error}")
        input("\nPressione enter para continuar...")
    finally:
        if connection:
            cursor.close()
            connection.close()

def verificar_nivel_habilidade(jogador_dict, habilidade_antiga):
    try:
        connection = get_connection()
        cursor = connection.cursor()
        cursor.execute("""SELECT * FROM habCombate WHERE fk_Habilidade_id = (
                            SELECT fk_habCombate_fk_Habilidade_id FROM jogador WHERE    id_jogador = %s
                       )""", (jogador_dict["id_jogador"],))
        habilidade_nova = cursor.fetchone()

        if habilidade_nova[1] > habilidade_antiga[1]:
            print(f"\nParabéns! Sua habilidade de combate subiu para o nível {habilidade_nova[1]}!")
            print(f"""Você ganhou +{habilidade_nova[4]} de vida e +{habilidade_nova[5]} de dano!""")

    except Exception as error:
        print(f"\nOcorreu um erro ao verificar o nível da habilidade: {error}")
        input("\Pressione enter para continuar...")
    finally:
        if connection:
            cursor.close()
            connection.close()

def commit_vidaAtual(jogador_dict, inimigo_dict):
    try:
        connection = get_connection()
        cursor = connection.cursor()

        cursor.execute("UPDATE Jogador SET vidaAtual = %s WHERE id_jogador = %s", (jogador_dict['vidaAtual'], jogador_dict['id_jogador']))
        connection.commit()

        cursor.execute("UPDATE Instancia_de_Inimigo SET vidaAtual = %s WHERE id_instancia_de_inimigo = %s", (inimigo_dict['vida'], inimigo_dict['instancia'][0]))
        connection.commit()

        return 
    except Exception as error:
        print(f"\nOcorreu um erro ao atualizar a vida atual: {error}")
        input("Pressione enter para continuar...")
    finally:
        if connection:
            cursor.close()
            connection.close()

def resultado_combate(inimigo_dict, jogador_dict):
    try:
        connection = get_connection()
        cursor = connection.cursor()

        exibir_status_combate(jogador_dict, inimigo_dict)

        # vamos precisar da habilidade antiga para comparar com a nova
        cursor.execute("SELECT * FROM habCombate WHERE fk_Habilidade_id = %s", (jogador_dict['fk_habCombate_fk_Habilidade'],))
        habCombate = cursor.fetchone()

        commit_vidaAtual(jogador_dict, inimigo_dict)
        
        # neste ponto, uma trigger no banco de dados é acionada para:
        # remover inimigos mortos
        # atualizar a quantidade de mobs do andar
        # atualizar o xp de combate do jogador e atualizar stats relacionados a habCombate

        if jogador_dict['vidaAtual'] <= 0:
            resultado = "derrota"
            print("\nVocê foi derrotado 💀")
        elif inimigo_dict['vida'] <= 0:
            resultado = "vitoria"
            print(f"\nVocê derrotou o(a) {inimigo_dict['tipo'][1]}!")
            print(f"Você ganhou +{inimigo_dict['tipo'][5]} de xp de combate.")

            verificar_nivel_habilidade(jogador_dict, habCombate)

        input("\nPressione enter para continuar...")
        return resultado
    except Exception as error:
        print(f"Ocorreu um erro ao exibir o resultado do combate: {error}")
        input("\nPressione enter para continuar...")
    finally:
        if connection:
            cursor.close()
            connection.close()

def iniciar_combate(jogador_dict, inimigos_dict, ambiente):
    try:
        connection = get_connection()
        cursor = connection.cursor()

        id_inimigo = int(input(f"\nQual inimigo deseja combater (digite o ID correspondente)?\n > "))
        
        if id_inimigo not in [inimigo[0] for inimigo in inimigos_dict["lista_instancias_inimigos"]]:
            input("\nID inválido. Pressione enter para tentar novamente...")
            return 

        instancia_inimigo = get_instancia_inimigo(id_inimigo) # será a tupla da instancia do inimigo com o menor id_instancia_de_inimigo

        for inimigo in inimigos_dict["lista_instancias_inimigos"]:
            if inimigo[0] == id_inimigo:
                tipo_inimigo = inimigo
                break

        vida_inimigo = instancia_inimigo[1]

        inimigo_dict = {"vida": vida_inimigo, "tipo": tipo_inimigo, "instancia": instancia_inimigo}

        while inimigo_dict["vida"] > 0 and jogador_dict['vidaAtual'] > 0:        
            exibir_status_combate(jogador_dict, inimigo_dict)

            opcao = int(input("\n O que deseja fazer?\n 1 - Atacar\n 2 - Usar poção de vida\n 3 - Fugir\n> """))

            match opcao:
                case 1:
                    inimigo_dict["vida"] -= jogador_dict['dano_ataque']
                    dano_inimigo = ataque_inimigo(ambiente, tipo_inimigo)

                    print(f"\nVocê atacou o(a) {inimigo_dict['tipo'][1]} e causou {jogador_dict['dano_ataque']} de dano.")
                    
                    if dano_inimigo > 0 and inimigo_dict["vida"] > 0:
                        print(f"O {inimigo_dict['tipo'][1]} te atacou e causou {dano_inimigo} de dano.")
                        jogador_dict['vidaAtual'] -= dano_inimigo
                    elif inimigo_dict["vida"] <= 0:
                        print(f"O(A) {inimigo_dict['tipo'][1]} cai no chão e demonstra não ter sinais de vida...")
                    else:
                        print(f"O {inimigo_dict['tipo'][1]} tentou te atacar, mas você desviou do ataque!")

                    input("\nPressione enter para continuar...")
                case 2:
                    #TODO: Usar uma poção de vida do inventário
                    # só para motivos de teste
                    jogador_dict['vidaAtual'] = jogador_dict['vidaMax']
                    inimigo_dict["vida"] = inimigo_dict["tipo"][3] 
                case 3:
                    commit_vidaAtual(jogador_dict, inimigo_dict)

                    return
                case _:
                    pass

        return resultado_combate(inimigo_dict, jogador_dict)
    except Exception as error:
        print(f"Ocorreu um erro ao iniciar o combate: {error}")
        input("\nPressione enter para continuar...")
    finally:
        if connection:
            cursor.close()
            connection.close()

def atualizar_jogador(jogador):
    try:
        connection = get_connection()
        cursor = connection.cursor()

        cursor.execute("SELECT * FROM jogador WHERE id_jogador = %s", (jogador[0],))
        jogador = cursor.fetchone()
        jogador_dict = {
            'id_jogador'                    : jogador[0],
            'nome'                          : jogador[1],  
            'dia'                           : jogador[2],          
            'tempo'                         : jogador[3],
            'localizacao_atual'             : jogador[4],                
            'vidaMax'                       : jogador[5],
            'vidaAtual'                     : jogador[6], 
            'xp_mineracao'                  : jogador[7], 
            'xp_cultivo'                    : jogador[8], 
            'xp_combate'                    : jogador[9],
            'dano_ataque'                   : jogador[10],
            'fk_habMineracao_fk_Habilidad'  : jogador[11], 
            'fk_habCombate_fk_Habilidade'   : jogador[12],
            'fk_habCultivo_fk_Habilidade'   : jogador[13],
        }

        return jogador_dict
    except Exception as error:
        print(f"Ocorreu um erro ao atualizar o status do jogador: {error}")
        input("\nPressione enter para continuar...")
    finally:
        if connection:
            cursor.close()
            connection.close()

def interacao_caverna(jogador, ambiente):
    try:
        connection = get_connection()
        cursor = connection.cursor()

        cursor.execute("SELECT * FROM caverna WHERE fk_id_ambiente = %s", (ambiente[0],))
        caverna_andar = cursor.fetchone()

        while True:
            clear_terminal()
            jogador_dict = atualizar_jogador(jogador)

            if ambiente[0] == 15:
                # TODO: spwanar mobs nos andares da caverna
                print("Não há nada para fazer na entrada da caverna.")
                input("\nPressione enter para voltar ao menu...")
                return

            # Exibe o cabeçalho do andar
            print(f"{'=' * 32} {ambiente[1]}: {ambiente[0] - 15}º andar {'=' * 32}")

            inimigos_dict = info_andar(ambiente, caverna_andar, jogador_dict)

            if inimigos_dict["quantidade_mobs"] == 0:
                print("\nNão há inimigos neste andar.")
                opcao = int(input("\nO que deseja fazer?\n 2 - Coletar Minérios\n 3 - Voltar\n> "))
            else:
                print(f"\nVocê olha ao seu redor e enxerga {inimigos_dict['quantidade_mobs']} inimigos:")
                for inimigo in inimigos_dict["lista_instancias_inimigos"]:
                    print(f"- {inimigo[6]}x {inimigo[1]} (ID: {inimigo[0]})")
                
                opcao = int(input("\n O que deseja fazer?\n 1 - Iniciar combate\n 2 - Coletar Minérios\n 3 - Voltar\n> "))

            if opcao == 1:
                if inimigos_dict["quantidade_mobs"] == 0:
                    print("\nNão há inimigos para combater neste andar.")
                    input("Pressione enter para continuar...")
                    continue
                
                resultado = iniciar_combate(jogador_dict, inimigos_dict, ambiente)

                if resultado == "derrota":
                    
                    # TODO: O que fazer em caso de derrota 
                    #cursor.execute("UPDATE Ambiente SET fk_jogador_id = %s WHERE id_ambiente = %s",
                    #(jogador[0], ambiente[0])) # Trocar pelo ambiente de respawn
                    #connection.commit()
                    return
            elif opcao == 2:
                print("\nFuncionalidade de coleta de minérios ainda não implementada.")
                input("Pressione enter para continuar...")
            elif opcao == 3:
                return  
            else:
                print("\nOpção inválida. Tente novamente.")
                input("Pressione enter para continuar...")

    except Exception as error:
        print(f"\nOcorreu um erro durante a interação com a caverna: {error}")
        input("Pressione enter para voltar ao menu...")
    finally:
        if connection:
            cursor.close()
            connection.close()
    
    # Antes minerar, você precisa 
    # Adicionar view para possiveis recompensas
    # assim que o jogador derrotar todo:  os mobs expecíficados em "quantidade_mobs"
    # ele liberará a opção de minerar e coletar a recompensa da caverna
    # a recompensa poderá ser tanto poções de vida que ajudam o jogador a continuar na caverna
    # ou itens pré determinados na "view" de recompensas, decretados por um random()