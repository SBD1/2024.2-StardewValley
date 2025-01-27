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

    print("⚔️  " * 7, "COMBATE", "⚔️  " * 7)
    print(f"\nStatus do jogador {jogador[1]}")
    barra_status_vida(vida_jogador, jogador[4])
    print(f"\nPoções de vida: x #TODO: ")
    print(f"\nStatus do {tipo_inimigo[1]}")
    barra_status_vida(vida_inimigo, tipo_inimigo[3])

def get_info_andar(ambiente, andar, cursor):

    print(f"\n{ambiente[5]}")

    cursor.execute("SELECT fk_inimigo_id FROM Instancia_de_Inimigo WHERE fk_Caverna_andar = %s", (andar[0],))
    fk_inimigo_id = cursor.fetchone()
    cursor.execute("SELECT * FROM Inimigo WHERE id_inimigo = %s", (fk_inimigo_id[0],))
    tipo_inimigo = cursor.fetchone()

    cursor.execute("SELECT * FROM Instancia_de_Inimigo WHERE fk_inimigo_id = %s", (andar[0],))
    instancia_inimigo = cursor.fetchone()

    cursor.execute("SELECT quantidade_mobs FROM Caverna WHERE fk_id_ambiente = %s", (ambiente[0],))
    quantidade_mobs = cursor.fetchone()

    return instancia_inimigo, tipo_inimigo, quantidade_mobs
    # TODO:  fazer o mesmo para minerios

def resultado_combate(jogador, vida_jogador, vida_inimigo, tipo_inimigo, instancia_inimigo, cursor, connection):

    cursor.execute("UPDATE Jogador SET vidaAtual = %s WHERE id_jogador = %s", (vida_jogador, jogador[0]))
    connection.commit()

    cursor.execute("UPDATE Instancia_de_Inimigo SET vidaAtual = %s WHERE id_instancia_de_inimigo = %s", (vida_inimigo, instancia_inimigo[0]))
    connection.commit()
    
    #TODO: criar uma trigger para excluir a instancia de inimigo quando a vida for <= 0

    if vida_jogador <= 0:
        print("\nVocê foi derrotado 💀.")
        resultado = "derrota"
    elif vida_inimigo <= 0:
            #TODO: adiciona a recompensa do inimigo ao jogador

            #TODO: adiciona xp à habilidade de combate do jogador    

        print(f"\nVocê derrotou o {tipo_inimigo[1]}!")
        resultado =  "vitoria"

        cursor.execute("SELECT quantidade_mobs FROM Caverna WHERE andar = %s", (instancia_inimigo[3],))
        quantidade_mobs = cursor.fetchone()[0] - 1
        cursor.execute("UPDATE Caverna SET quantidade_mobs = %s WHERE andar = %s", (quantidade_mobs, instancia_inimigo[3],))

        connection.commit()
        

    input("\nPressione qualquer tecla para continuar...")
    clear_terminal()

    return resultado

def iniciar_combate(jogador, instancia_inimigo, tipo_inimigo, ambiente, cursor, connection):
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
                pass
            case 3:
                return
            case _:
                pass
    
    resultado_combate(jogador, vida_jogador, vida_inimigo, tipo_inimigo, instancia_inimigo, cursor, connection)

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

            print(f"{"="*30} {ambiente[1]}: {ambiente[0] - 15}º andar {"="*30}")

            # to colocando essa porra aqui so pra testar o combate
            cursor.execute("UPDATE Instancia_de_Inimigo SET vidaAtual = %s WHERE id_instancia_de_inimigo = %s", (30.0, 1))
            connection.commit()

            instancia_inimigo, tipo_inimigo, quantidade_inimigos = get_info_andar(ambiente, andar, cursor)

            if not instancia_inimigo:
                print("Não há inimigos neste andar.")
            else:
                print(f"\nVocê olha ao seu redor e enxerga {quantidade_inimigos[0]} inimigos, que parecem ser um(a) {tipo_inimigo[1]}")
                #TODO: listar minerios

                opcao = int(input("\nO que deseja fazer?\n 1 - Iniciar combate\n 2 - Coletar Minérios (implementar)\n> "))
                if opcao == 1:
                    resultado = iniciar_combate(jogador, instancia_inimigo, tipo_inimigo, ambiente, cursor, connection)
                    #TODO: atualizar a tupla de jogador
                    if resultado == "vitoria":
                        pass
                    elif resultado == "derrota":
                        #TODO: o que fazer em caso de derrota
                        return
            
            # coisas sobre mineração

    except Exception as error:
        clear_terminal()
        print(f"Ocorreu um erro ao listar o andar: {error}")
        input("\nPressione enter para voltar ao menu...")
    
    # Antes minerar, você precisa 
    # Adicionar view para possiveis recompensas
    # assim que o jogador derrotar todo:  os mobs expecíficados em "quantidade_mobs"
    # ele liberará a opção de minerar e coletar a recompensa da caverna
    # a recompensa poderá ser tanto poções de vida que ajudam o jogador a continuar na caverna
    # ou itens pré determinados na "view" de recompensas, decretados por um random()