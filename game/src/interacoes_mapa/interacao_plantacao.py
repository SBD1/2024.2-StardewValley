from setup.database import get_connection
from ..utils.animacao_escrita import print_animado
import os


DDL_FILE_PATH = os.path.join(os.path.dirname(__file__), "db/ddl.sql")
DML_FILE_PATH = os.path.join(os.path.dirname(__file__), "db/dml.sql")

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

def interacao_plantacao(jogador):
    while True:
        clear_terminal()
        try:
            connection = get_connection()
            cursor = connection.cursor()
            ambiente_atual = jogador[4]  
            jogador = carregar_personagem(jogador[0])

            if jogador is None:
                print("Erro ao carregar o jogador. Saindo da interação.")
                break

            cursor.execute("SELECT COUNT(*) FROM Instancia_de_Planta WHERE fk_id_jogador = %s", (jogador[0],))
            qtd_plantas = cursor.fetchone()[0]

            cursor.execute("SELECT qtd_plantas_max FROM Plantacao WHERE fk_id_ambiente = %s", (ambiente_atual,))
            qtd_plantas_max = cursor.fetchone()

            if not qtd_plantas_max:
                print("Você não possui uma plantação neste ambiente.")
                return
            
            qtd_plantas_max = qtd_plantas_max[0]  

            print("Você está na plantação.")
            print(f"\nVocê tem {qtd_plantas} plantas de um total máximo de {qtd_plantas_max}.")
            print("\n1 - Comprar planta")
            print("2 - Ver plantas")
            print("3 - Voltar")
            opcao = input("Escolha uma opção: ")
            if opcao == "1":
                comprar_planta(jogador)
            elif opcao == "2":
                ver_plantas(jogador)
            elif opcao == "3":
                break
            else:
                print("Opção inválida.")
        except Exception as error:
            print(f"Ocorreu um erro ao interagir com a plantação: {error}")
        finally:
            if cursor:
                cursor.close()
            if connection:
                connection.close()

def comprar_planta(jogador):
    clear_terminal()
    plantas = exibir_plantas_disponiveis()
    conn = None
    cursor = None

    try:
        conn = get_connection()
        cursor = conn.cursor()
        jogador = carregar_personagem(jogador[0])

        if jogador is None:
            print("Erro ao carregar o jogador. Saindo da compra.")
            return

        cursor.execute("SELECT moedas FROM Jogador WHERE id_jogador = %s", (jogador[0],))
        moedas = cursor.fetchone()[0]  
        print(f"Você tem {moedas} moedas.")
        
        if not plantas:
            return  

        escolha = int(input("Digite o ID da planta que você deseja comprar (ou 0 para cancelar): "))
        
        if escolha == 0:
            print("Compra cancelada.")
            return

        planta_selecionada = next((planta for planta in plantas if planta[0] == escolha), None)
        if not planta_selecionada:
            print("Planta inválida. Tente novamente.")
            return
        
        preco_planta = planta_selecionada[2]
        if moedas < preco_planta:
            print("Você não tem moedas suficientes para comprar esta planta.")
            return

        nome_planta = planta_selecionada[1]
        adicionar_planta_plantacao(jogador, escolha, nome_planta)
        
        cursor.execute("UPDATE Jogador SET moedas = moedas - %s WHERE id_jogador = %s", (preco_planta, jogador[0]))
        conn.commit()
        clear_terminal()
        print_animado(f"Você comprou um(a) {nome_planta} por {preco_planta} moedas!")
        input("\nPressione Enter para continuar...")
    except Exception as e:
        print(f"Erro ao comprar planta: {e}")
        
    
    finally:
        if cursor:
            cursor.close()
        if conn:
            conn.close()

def adicionar_planta_plantacao(jogador, id_planta, nome_planta):
    conn = None
    cursor = None
    
    try:
        conn = get_connection()
        cursor = conn.cursor()
        
        cursor.execute("SELECT COUNT(*) FROM Instancia_de_Planta WHERE fk_id_jogador = %s", (jogador[0],))
        qtd_plantas = cursor.fetchone()[0]
        
        cursor.execute("SELECT qtd_plantas_max FROM Plantacao WHERE fk_id_ambiente = %s", (jogador[4],))
        qtd_plantas_max = cursor.fetchone()[0]
        
        if qtd_plantas >= qtd_plantas_max:
            print("Você atingiu o limite de plantas na plantação.")
            return
        
        cursor.execute("INSERT INTO Instancia_de_Planta (fk_id_planta, fk_id_jogador, nome, prontoColher, diaAtual) VALUES (%s, %s, %s, %s, %s)", (id_planta, jogador[0], nome_planta, False, 0))
        conn.commit()
        
        print(f"Você plantou um(a) {nome_planta}!")
    
    except Exception as e:
        print(f"Erro ao adicionar planta na plantação: {e}")
    
    finally:
        if cursor:
            cursor.close()
        if conn:
            conn.close()

def exibir_plantas_disponiveis():
    clear_terminal()
    try:
        conn = get_connection()
        cursor = conn.cursor()
        cursor.execute("SELECT id_planta, nome, preco FROM Planta")
        plantas = cursor.fetchall()
        
        if not plantas:
            print("Nenhuma planta disponível para compra.")
            return None
        
        print("\nPlantas disponíveis para compra:")
        for planta in plantas:
            print(f"{planta[0]} - {planta[1]} - Preço: {planta[2]} moedas")
        
        return plantas
    except Exception as e:
        print(f"Erro ao carregar as plantas disponíveis: {e}")
    finally:
        if cursor:
            cursor.close()
        if conn:
            conn.close()

def ver_plantas(jogador):
    clear_terminal()
    conn = None
    cursor = None
    try:
        conn = get_connection()
        cursor = conn.cursor()

        cursor.execute("SELECT id_instancia_de_planta, nome, prontoColher, diaAtual FROM Instancia_de_Planta WHERE fk_id_jogador = %s", (jogador[0],))
        
        plantas = cursor.fetchall()
        
        if not plantas:
            print("Você não possui plantas na plantação.")
            input("Pressione Enter para continuar...")
            return
        
        print("Plantas na plantação:")
        for planta in plantas:
            id_planta, nome_planta, pronto_colher, dia_atual = planta
            estado = "pronta para colher" if pronto_colher else "não está pronta para colher"
            print(f"{id_planta} - {nome_planta} - {estado} (Dia: {dia_atual})")
        print("\nO que você gostaria de fazer?")
        print("1 - Colher planta")
        print("2 - Vender planta")
        print("3 - Sair da plantação")
        escolha = int(input("Digite o número da opção desejada: "))
        if escolha == 1:
            colher_planta(jogador)  # Chama a função para coletar item do animal
        elif escolha == 2:
            excluir_planta_da_plantacao(jogador)  # Chama a função para vender um animal
        elif escolha == 3:
            print("Saindo do celeiro...")
            return
        else:
            print("Opção inválida. Tente novamente.")
    except Exception as e:
        print(f"Erro ao carregar as plantas do jogador: {e}")
    
    finally:
        if cursor:
            cursor.close()
        if conn:
            conn.close()

def excluir_planta_da_plantacao(jogador):
    clear_terminal()
    conn = None
    cursor = None
    try:
        conn = get_connection()
        cursor = conn.cursor()
        
        # Obter as plantas do jogador
        cursor.execute("""
            SELECT ins.id_instancia_de_planta, ins.nome, pp.preco 
            FROM Instancia_de_Planta ins 
            INNER JOIN Planta pp ON ins.fk_id_planta = pp.id_planta 
            WHERE ins.fk_id_jogador = %s
        """, (jogador[0],))
        plantas = cursor.fetchall()
        
        if not plantas:
            print("Você não possui plantas na plantação.")
            return
        
        # Exibir plantas disponíveis
        print("\nPlantas na plantação:")
        for planta in plantas:
            print(f"{planta[0]} - {planta[1]} - Preço: {planta[2]} moedas")
        
        # Solicitar a escolha do jogador
        escolha = int(input("Digite o ID da planta que você deseja vender (ou 0 para cancelar): "))
        if escolha == 0:
            print("Venda cancelada.")
            return
        
        # Verifica se a planta escolhida existe
        planta_selecionada = next((planta for planta in plantas if planta[0] == escolha), None)
        if not planta_selecionada:
            print("Planta inválida. Tente novamente.")
            return
        
        # Obter o preço da planta diretamente da seleção
        preco_planta = planta_selecionada[2]
        
        # Excluir a planta
        cursor.execute("DELETE FROM Instancia_de_Planta WHERE id_instancia_de_planta = %s", (escolha,))
        conn.commit()
        
        # Atualiza as moedas do jogador
        cursor.execute("UPDATE Jogador SET moedas = moedas + %s WHERE id_jogador = %s", (preco_planta, jogador[0]))
        conn.commit()
        
        print(f"Planta {planta_selecionada[1]} vendida com sucesso! Você recebeu {preco_planta} moedas.")
    
    except Exception as e:
        print(f"Erro ao vender planta: {e}")
    
    finally:
        if cursor:
            cursor.close()
        if conn:
            conn.close()

def colher_planta(jogador):
    clear_terminal()
    conn = None
    cursor = None
    try:
        conn = get_connection()
        cursor = conn.cursor()
        
        # Obter o inventário do jogador
        cursor.execute("SELECT id_inventario FROM inventario WHERE fk_id_jogador = %s", (jogador[0],))
        inventario = cursor.fetchone()
        
        if not inventario:
            print("O jogador não possui um inventário.")
            input("Pressione Enter para continuar...")
            return
        
        id_inventario = inventario[0]
        
        # Obter as plantas do jogador
        cursor.execute("""
            SELECT ins.id_instancia_de_planta, ins.nome, ins.prontoColher, pp.id_planta, pp.itemDrop 
            FROM Instancia_de_Planta ins 
            INNER JOIN Planta pp ON ins.fk_id_planta = pp.id_planta 
            WHERE ins.fk_id_jogador = %s
        """, (jogador[0],))
        plantas = cursor.fetchall()
        
        if not plantas:
            print("Você não possui plantas na plantação.")
            input("Pressione Enter para continuar...")
            return
        
        print("\nPlantas na plantação:")
        for planta in plantas:
            id_planta, nome_planta, pronto_colher, id_planta_ref, item_drop = planta
            estado = "pronta para colher" if pronto_colher else "não está pronta para colher"
            print(f"{id_planta} - {nome_planta} - {estado}")
        
        escolha = int(input("Digite o ID da planta que você deseja colher (ou 0 para cancelar): "))
        if escolha == 0:
            print("Coleta cancelada.")
            input("Pressione Enter para continuar...")
            return
        
        # Verifica se a planta escolhida existe e está pronta para colher
        planta_selecionada = next((planta for planta in plantas if planta[0] == escolha), None)
        if not planta_selecionada:
            print("Planta inválida. Tente novamente.")
            input("Pressione Enter para continuar...")
            return
        
        if not planta_selecionada[2]:  # Se não estiver pronta para colher
            print(f"A planta {planta_selecionada[1]} não está pronta para colher.")
            input("Pressione Enter para continuar...")
            return
        
        # Adiciona o item ao inventário do jogador
        cursor.execute("""
            INSERT INTO instancia_de_item (fk_id_jogador, fk_id_item, fk_id_inventario, nome) 
            VALUES (%s, %s, %s, %s)
        """, (jogador[0], planta_selecionada[4], id_inventario, planta_selecionada[1]))

        # Atualiza o estado da planta para não pronta para colher e reseta o diaAtual
        try:
            cursor.execute("UPDATE Instancia_de_Planta SET prontoColher = FALSE, diaAtual = 0 WHERE id_instancia_de_planta = %s", (escolha,))
            conn.commit()
            print("O estado da planta foi atualizado com sucesso.")
        except Exception as e:
            print(f"Erro ao atualizar o estado da planta: {e}")

        clear_terminal()
        print(f"Você colheu a planta {planta_selecionada[1]}!")
        print(f"O item foi adicionado ao seu inventário!\n")
        input("Pressione Enter para continuar...")
        
    except Exception as e:
        print(f"Erro ao colher planta: {e}")
        input("Pressione Enter para continuar...")
    
    finally:
        if cursor:
            cursor.close()
        if conn:
            conn.close()