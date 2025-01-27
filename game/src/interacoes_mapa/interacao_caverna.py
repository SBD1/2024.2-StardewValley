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
    dano = tipo_inimigo[3]
    resultado = random.randint(0, 100)
    peso = 0.05 + andar # precisao dos inimigos aumenta conforme o andar
    
    if (25 / peso) <= resultado <= (75 * peso):
        return dano
    return  0

def exibir_status_combate(jogador, vida_jogador, vida_inimigo, tipo_inimigo):
    clear_terminal()

    if vida_jogador < 0:
        vida_jogador = 0
    if vida_inimigo < 0:
        vida_inimigo = 0

    print("⚔️  " * 7, "COMBATE", "⚔️  " * 7)
    print(f"\nStatus do jogador {jogador[1]}")
    barra_status_vida(vida_jogador, jogador[4])
    print(f"\nPoções de vida: x #TODO: ")
    print(f"\nStatus do {tipo_inimigo[1]}")
    barra_status_vida(vida_inimigo, tipo_inimigo[2])

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

def info_andar(ambiente, andar):
    print(f"\n{ambiente[5]}")  # Exibe a descrição do ambiente

    lista_instancias_inimigos = None
    quantidade_mobs = None

    try:
        connection = get_connection()
        cursor = connection.cursor()

        cursor.execute("""
            SELECT i.id_inimigo, i.nome, i.vidamax, i.dano, COUNT(*) AS quantidade
            FROM Instancia_de_Inimigo ii
            JOIN inimigo i ON ii.fk_inimigo_id = i.id_inimigo
            WHERE ii.fk_caverna_andar = %s
            GROUP BY i.id_inimigo, i.nome, i.vidamax, i.dano
            ORDER BY quantidade DESC
        """, (andar[0],))
        # lista_instancias_inimigos[x] = (nome, id_instancia_de_inimigo, vidaMax, quantidade)
        lista_instancias_inimigos = cursor.fetchall()

        cursor.execute("""
            SELECT quantidade_mobs
            FROM Caverna
            WHERE fk_id_ambiente = %s
        """, (ambiente[0],))
        quantidade_mobs = cursor.fetchone()

        # TODO:  fazer o mesmo para minerios
        
        return {
            "lista_instancias_inimigos": lista_instancias_inimigos,
            "quantidade_mobs": quantidade_mobs[0] if quantidade_mobs else None
        }
    except Exception as error:
        print(f"Ocorreu um erro ao listar os inimigos em info_andar(): {error}")
        input("\nPressione enter para continuar...")
    finally:
        if connection:
            cursor.close()
            connection.close()

def resultado_combate(jogador, vida_jogador, vida_inimigo, tipo_inimigo, instancia_inimigo):
    try:
        connection = get_connection()
        cursor = connection.cursor()

        exibir_status_combate(jogador, vida_jogador, vida_inimigo, tipo_inimigo)

        cursor.execute("UPDATE Jogador SET vidaAtual = %s WHERE id_jogador = %s", (vida_jogador, jogador[0]))
        connection.commit()

        cursor.execute("UPDATE Instancia_de_Inimigo SET vidaAtual = %s WHERE id_instancia_de_inimigo = %s", (vida_inimigo, instancia_inimigo[0]))
        connection.commit()
        
        # neste ponto, uma trigger no banco de dados é acionada para remover inimiogos mortos e atualizar a quantidade de mobs

        if vida_jogador <= 0:
            print("\nVocê foi derrotado 💀.")
            resultado = "derrota"
        elif vida_inimigo <= 0:
                #TODO: adiciona a recompensa do inimigo ao jogador
                #TODO: adiciona xp à habilidade de combate do jogador    
            print(f"\nVocê derrotou o(a) {tipo_inimigo[1]}!")
            resultado =  "vitoria"

        input("\nPressione qualquer tecla para continuar...")
        return resultado
    except Exception as error:
        print(f"Ocorreu um erro ao exibir o resultado do combate: {error}")
        input("\nPressione enter para continuar...")
    finally:
        if connection:
            cursor.close()
            connection.close()

def iniciar_combate(jogador, dicionario_inimigos, ambiente):
    try:
        connection = get_connection()
        cursor = connection.cursor()

        id_inimigo = int(input(f"\nQual inimigo deseja combater (digite o ID correspondente)?\n > "))
        
        if id_inimigo not in [inimigo[0] for inimigo in dicionario_inimigos["lista_instancias_inimigos"]]:
            input("\nID inválido. Pressione qualquer tecla para tentar novamente...")
            return 

        instancia_inimigo = get_instancia_inimigo(id_inimigo) # será a tupla da instancia do inimigo com o menor id_instancia_de_inimigo

        for inimigo in dicionario_inimigos["lista_instancias_inimigos"]:
            if inimigo[0] == id_inimigo:
                tipo_inimigo = inimigo
                break

        dano_jogador = jogador[9]
        vida_jogador = jogador[5]
        vida_inimigo = instancia_inimigo[1]

        while vida_inimigo > 0 and vida_jogador > 0:        
            exibir_status_combate(jogador, vida_jogador, vida_inimigo, tipo_inimigo)

            opcao = int(input("\nO que deseja fazer?\n 1 - Atacar\n 2 - Usar poção de vida\n 3 - Fugir\n> "))

            match opcao:
                case 1:
                    #TODO: usar a barra de precisão
                    vida_inimigo -= dano_jogador
                    dano_inimigo = ataque_inimigo(ambiente, tipo_inimigo)

                    print(f"\nVocê atacou o {tipo_inimigo[1]} e causou {dano_jogador} de dano.")
                    
                    if dano_inimigo > 0:
                        print(f"O {tipo_inimigo[1]} te atacou e causou {dano_inimigo} de dano.")
                        vida_jogador -= dano_inimigo
                    else:
                        print(f"O {tipo_inimigo[1]} tentou te atacar, mas você desviou do ataque!")

                    input("\nPressione qualquer tecla para continuar...")
                case 2:
                    #TODO: Usar poção de vida
                    # só para motivos de teste
                    vida_jogador = jogador[4]
                    vida_inimigo += 10 
                    pass
                case 3:
                    return
                case _:
                    pass
        
        resultado_combate(jogador, vida_jogador, vida_inimigo, tipo_inimigo, instancia_inimigo)
    except Exception as error:
        print(f"Ocorreu um erro ao iniciar o combate: {error}")
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
        andar = cursor.fetchone()

        while True:
            clear_terminal()

            if ambiente[0] == 15:
                print("Não há nada para fazer na entrada da caverna.")
                input("\nPressione enter para voltar ao menu...")
                return

            # Exibe o cabeçalho do andar
            print(f"{'=' * 30} {ambiente[1]}: {ambiente[0] - 15}º andar {'=' * 30}")

            dicionario_inimigos = info_andar(ambiente, andar)

            if dicionario_inimigos["quantidade_mobs"] == 0:
                print("\nNão há inimigos neste andar.")
            else:
                print(f"\nVocê olha ao seu redor e enxerga {dicionario_inimigos['quantidade_mobs']} inimigos:")
                for inimigo in dicionario_inimigos["lista_instancias_inimigos"]:
                    print(f"- {inimigo[4]}x {inimigo[1]} (ID: {inimigo[0]})")

            if dicionario_inimigos["quantidade_mobs"] == 0:
                opcao = int(input("\nO que deseja fazer?\n 2 - Coletar Minérios\n 3 - Voltar\n> "))
            else:
                opcao = int(input("\nO que deseja fazer?\n 1 - Iniciar combate\n 2 - Coletar Minérios\n 3 - Voltar\n> "))

            if opcao == 1:
                if dicionario_inimigos["quantidade_mobs"] == 0:
                    print("\nNão há inimigos para combater neste andar.")
                    input("Pressione enter para continuar...")
                    continue
                
                resultado = iniciar_combate(jogador, dicionario_inimigos, ambiente)

                if resultado == "vitoria":
                    print("Você venceu o combate!")
                    # TODO: Atualizar a tupla de jogador 
                elif resultado == "derrota":
                    print("Você foi derrotado!")
                    # TODO: O que fazer em caso de derrota 
                    return

            elif opcao == 2:
                print("\nFuncionalidade de coleta de minérios ainda não implementada.")
                input("Pressione enter para continuar...")

            elif opcao == 3:
                return  # Volta ao menu anterior

            else:
                print("\nOpção inválida. Tente novamente.")
                input("Pressione enter para continuar...")

    except Exception as error:
        print(f"Ocorreu um erro durante a interação com a caverna: {error}")
        input("\nPressione enter para voltar ao menu...")
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