from setup.database import get_connection
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

def interacao_celeiro(jogador):

    while True:
        clear_terminal() 
        try:
            connection = get_connection()
            cursor = connection.cursor()
            ambiente_atual = jogador[4]  
            jogador = carregar_personagem(jogador[0])
            # Contar quantos animais o jogador tem no celeiro
            cursor.execute("SELECT COUNT(*) FROM Instancia_de_Animal WHERE fk_Jogador_id = %s", (jogador[0],))
            qtd_animais = cursor.fetchone()[0]  # Pega o primeiro elemento da tupla retornada
            
            # Obter o máximo de animais permitidos no celeiro
            cursor.execute("SELECT qtd_max_animais FROM Celeiro WHERE fk_id_ambiente = %s", (ambiente_atual,))
            qtd_max_animais = cursor.fetchone()
            
            if not qtd_max_animais:
                print("Você não possui um celeiro neste ambiente.")
                return
            
            qtd_max_animais = qtd_max_animais[0]  # Pega o primeiro elemento da tupla retornada
            
            print(f"Você tem {qtd_animais} animais no celeiro de um total máximo de {qtd_max_animais}.")
            
            # Adicionar opções de interação
            print("\nO que você gostaria de fazer?")
            print("1 - Comprar um animal")
            print("2 - Ver animais no celeiro")
            print("3 - Sair do celeiro")
            
            escolha = int(input("Digite o número da opção desejada: "))
            
            if escolha == 1:
                comprar_animal(jogador)  # Chama a função para comprar um animal
            elif escolha == 2:
                ver_animais_no_celeiro(jogador)  # Chama a função para ver os animais no celeiro
            elif escolha == 3:
                print("Saindo do celeiro...")
                break
            else:
                print("Opção inválida. Tente novamente.")
        
        except Exception as error:
            print(f"Ocorreu um erro ao interagir com o celeiro: {error}")
        finally:
            if cursor:
                cursor.close()
            if connection:
                connection.close()
        carregar_personagem(jogador[0])    
        
def ver_animais_no_celeiro(jogador):
    clear_terminal()
    try:
        connection = get_connection()
        cursor = connection.cursor()
        
        # Obter os animais no celeiro do jogador
        cursor.execute("SELECT id_instancia_de_animal, nome_animal, prontoDropa FROM Instancia_de_Animal WHERE fk_Jogador_id = %s", (jogador[0],))  # Corrigido para usar jogador[0]
        animais = cursor.fetchall()
        
        if not animais:
            print("Não há animais no celeiro.")
            input("Pressione Enter para continuar...")
            interacao_celeiro(jogador)
            return
        
        print("\nAnimais no celeiro:")
        for animal in animais:
            id_instancia_de_animal, nome_animal, pronto_dropar = animal
            estado = "pronto para dropar" if pronto_dropar else "não está pronto para dropar"
            print(f"{nome_animal} - {estado}")

        print("\nO que você gostaria de fazer?")
        print("1 - Coletar item de animal")
        print("2 - Vender Animal")
        print("3 - Sair do celeiro")
        escolha = int(input("Digite o número da opção desejada: "))
        if escolha == 1:
            coletar_item_do_animal(jogador)  # Chama a função para coletar item do animal
        elif escolha == 2:
            excluir_animal_do_celeiro(jogador)  # Chama a função para vender um animal
        elif escolha == 3:
            print("Saindo do celeiro...")
            return
        else:
            print("Opção inválida. Tente novamente.")

    except Exception as error:
        print(f"Ocorreu um erro ao listar os animais no celeiro: {error}")
    finally:
        if cursor:
            cursor.close()
        if connection:
            connection.close()

def exibir_animais_disponiveis():
    clear_terminal()
    try:
        conn = get_connection()
        cursor = conn.cursor()
        cursor.execute("SELECT id_animal, tipo_animal, preco FROM Animal")
        animais = cursor.fetchall()
        
        if not animais:
            print("Nenhum animal disponível para compra.")
            return None
        
        print("\nAnimais disponíveis para compra:")
        for animal in animais:
            print(f"{animal[0]} - {animal[1]} - Preço: {animal[2]} moedas")
        
        return animais
    except Exception as e:
        print(f"Erro ao carregar animais disponíveis: {e}")
    finally:
        if cursor:
            cursor.close()
        if conn:
            conn.close()
    
def excluir_animal_do_celeiro(jogador):
    clear_terminal()
    cursor = None
    conn = None
    try:
        conn = get_connection()
        cursor = conn.cursor()
        
        
        # Obter o celeiro do jogador
        cursor.execute("SELECT fk_id_ambiente FROM Celeiro WHERE fk_id_ambiente = %s", (jogador[4],))
        celeiro = cursor.fetchone()
        
        if not celeiro:
            print("Você não possui um celeiro.")
            return
        
        fk_id_ambiente = celeiro[0]
        
        # Obter os animais no celeiro
        cursor.execute("SELECT ins.id_instancia_de_animal, ins.nome_animal, hpp.preco FROM Instancia_de_Animal ins INNER JOIN Animal hpp ON ins.fk_animal_id = hpp.id_animal WHERE fk_jogador_id = %s", (jogador[0],))
        animais = cursor.fetchall()
        
        if not animais:
            print("Não há animais no celeiro.")
            return
        
        print("\nAnimais no celeiro:")
        for animal in animais:
            print(f"{animal[0]} - {animal[1]} - Preço: {animal[2]} moedas")
        
        escolha = int(input("Digite o ID do animal que você deseja vender (ou 0 para cancelar): "))
        if escolha == 0:
            print("Venda cancelada.")
            return
        
        # Verifica se o animal escolhido existe
        animal_selecionado = next((animal for animal in animais if animal[0] == escolha), None)
        if not animal_selecionado:
            print("Animal inválido. Tente novamente.")
            return
        
        # Obter o preço do animal
        cursor.execute("SELECT preco FROM Animal WHERE id_animal = %s", (escolha,))
        preco_animal = cursor.fetchone()
        
        if not preco_animal:
            print("Erro ao obter o preço do animal.")
            return
        
        # Excluir o animal
        cursor.execute("DELETE FROM Instancia_de_Animal WHERE id_instancia_de_animal = %s", (escolha,))
        conn.commit()
        
        # Atualiza as moedas do jogador
        cursor.execute("UPDATE Jogador SET moedas = moedas + %s WHERE id_jogador = %s", (preco_animal[0], jogador[0]))
        conn.commit()
        
        print(f"Animal {animal_selecionado[1]} vendido com sucesso! Você recebeu {preco_animal[0]} moedas.")
    except Exception as e:
        print(f"Erro ao vender animal: {e}")
    finally:
        if cursor:
            cursor.close()
        if conn:
            conn.close()

def coletar_item_do_animal(jogador):
    clear_terminal()
    conn = None
    cursor = None
    try:
        conn = get_connection()
        cursor = conn.cursor()
        
        # Obter os animais no celeiro
        cursor.execute("""
            SELECT id_instancia_de_animal, nome_animal, prontoDropa, fk_animal_id 
            FROM Instancia_de_Animal 
            WHERE fk_Jogador_id = %s
        """, (jogador[0],))
        animais = cursor.fetchall()
        
        if not animais:
            print("Não há animais no celeiro.")
            input("Pressione Enter para continuar...")
            return
        
        # Obter o inventário do jogador
        cursor.execute("SELECT id_inventario FROM inventario WHERE fk_id_jogador = %s", (jogador[0],))
        inventario = cursor.fetchone()
        
        if not inventario:
            print("O jogador não possui um inventário.")
            input("Pressione Enter para continuar...")
            return
        
        id_inventario = inventario[0]
        
        print("\nAnimais no celeiro:")
        for animal in animais:
            estado = 'pronto para dropar' if animal[2] else 'não está pronto para dropar'
            print(f"{animal[0]} - {animal[1]} - {estado}")
        
        escolha = int(input("Digite o ID do animal do qual você deseja coletar itens (ou 0 para cancelar): "))
        if escolha == 0:
            print("Coleta cancelada.")
            input("Pressione Enter para continuar...")
            return
        
        # Verifica se o animal escolhido existe e está pronto para dropar
        animal_selecionado = next((animal for animal in animais if animal[0] == escolha), None)
        if not animal_selecionado:
            print("Animal inválido. Tente novamente.")
            input("Pressione Enter para continuar...")
            return
        
        if not animal_selecionado[2]:  # Se não estiver pronto para dropar
            print(f"O animal {animal_selecionado[1]} não está pronto para dropar.")
            input("Pressione Enter para continuar...")
            return
        
        # Obter o item que o animal pode dropar
        cursor.execute("""
            SELECT itemDrop 
            FROM Animal 
            WHERE id_animal = %s
        """, (animal_selecionado[3],))  # Use o índice 3 para fk_animal_id
        itemDrop = cursor.fetchone()
        
        if not itemDrop or itemDrop[0] is None:
            print("Erro ao obter o item do animal.")
            input("Pressione Enter para continuar...")
            return
        
        # Adiciona o item ao inventário do jogador
        cursor.execute("""
            INSERT INTO instancia_de_item (fk_id_jogador, fk_id_item, fk_id_inventario) 
            VALUES (%s, %s, %s)
        """, (jogador[0], itemDrop[0], id_inventario))

        
        # Atualiza o estado do animal para não pronto para dropar
        cursor.execute("UPDATE Instancia_de_Animal SET prontoDropa = FALSE, diaAtual = 0 WHERE id_instancia_de_animal = %s", (escolha,))
        conn.commit()
        clear_terminal()
        print(f"Você coletou um item do animal {animal_selecionado[1]} !")
        print(f"O item foi adicionado ao seu inventário !\n")
        input("Pressione Enter para continuar...")
        
    except Exception as e:
        print(f"Erro ao coletar item do animal: {e}")
        input("Pressione Enter para continuar...")
    finally:
        if cursor:
            cursor.close()
        if conn:
            conn.close()

def adicionar_animal_ao_celeiro(jogador, fk_animal_id, nome_animal):
    conn = None
    cursor = None
    try:
        # Obter o celeiro do jogador
        conn = get_connection()
        cursor = conn.cursor()
        cursor.execute("SELECT fk_id_ambiente, qtd_max_animais FROM Celeiro WHERE fk_id_ambiente = %s", (jogador[4],))  # Use índice inteiro
        celeiro = cursor.fetchone()
        
        if not celeiro:
            print("Você não possui um celeiro.")
            return

        qtd_max_animais = celeiro[1]
        # Contar quantos animais o jogador tem no celeiro
        cursor.execute("SELECT COUNT(*) FROM Instancia_de_Animal WHERE fk_Jogador_id = %s", (jogador[0],))
        qtd_animais = cursor.fetchone()[0]  # Pega o primeiro elemento da tupla retornada

        
        if qtd_animais >= qtd_max_animais:
            print("O celeiro está cheio. Não é possível adicionar mais animais.")
            return
        
        # Adicionar o animal
        cursor.execute("""
            INSERT INTO Instancia_de_Animal (nome_animal, prontoDropa, diaAtual, fk_Animal_id, fk_Jogador_id, fk_Celeiro_id)
            VALUES (%s, %s, %s, %s, %s, %s)
        """, (nome_animal, False, 0, fk_animal_id, jogador[0], celeiro[0]))  # Use índice inteiro
        conn.commit()
        
        print("Animal adicionado ao celeiro com sucesso!")
    except Exception as e:
        print(f"Erro ao adicionar animal ao celeiro: {e}")
    finally:
        if cursor:  # Verifica se o cursor foi criado
            cursor.close()
        if conn:  # Verifica se a conexão foi criada
            conn.close()

def comprar_animal(jogador):
    clear_terminal()
    animais = exibir_animais_disponiveis()
    conn = None
    cursor = None

    try:
        conn = get_connection()
        cursor = conn.cursor()
        jogador = carregar_personagem(jogador[0])
        # Obter as moedas do jogador
        cursor.execute("SELECT moedas FROM Jogador WHERE id_jogador = %s", (jogador[0],))
        moedas = cursor.fetchone()[0]  # Pega o primeiro elemento da tupla retornada
        print(f"Você tem {moedas} moedas.")
        
        if not animais:
            return  # Se não houver animais, sai da função

        escolha = int(input("Digite o ID do animal que você deseja comprar (ou 0 para cancelar): "))
        
        if escolha == 0:
            print("Compra cancelada.")
            return
        
        # Verifica se o animal escolhido existe
        animal_selecionado = next((animal for animal in animais if animal[0] == escolha), None)
        if not animal_selecionado:
            print("Animal inválido. Tente novamente.")
            return
        
        # Verifica se o jogador tem moedas suficientes
        preco_animal = animal_selecionado[2]
        if moedas < preco_animal:  # Use a variável de moedas obtida
            print("Você não tem moedas suficientes para comprar este animal.")
            return
        jogador[0]
        # Solicita o nome do animal
        nome_animal = input("Digite o nome do animal: ").strip()
        
        # Adiciona o animal ao celeiro
        adicionar_animal_ao_celeiro(jogador, escolha, nome_animal)
        
        # Atualiza as moedas do jogador
        cursor.execute("UPDATE Jogador SET moedas = moedas - %s WHERE id_jogador = %s", (preco_animal, jogador[0]))  # Use índice inteiro
        conn.commit()
        
        print(f"Você comprou um {animal_selecionado[1]} chamado {nome_animal} por {preco_animal} moedas!")
    
    except Exception as e:
        print(f"Erro ao comprar animal: {e}")
    
    finally:
        if cursor:  # Verifica se o cursor foi criado
            cursor.close()
        if conn:  # Verifica se a conexão foi criada
            conn.close()