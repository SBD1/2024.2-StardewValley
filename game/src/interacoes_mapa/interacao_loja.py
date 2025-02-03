from setup.database import get_connection
from src.criar_excluir_itens import criar_item, remover_item_inventario
import os

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

def vender_item(jogador):
    clear_terminal()
    try:
        conn = get_connection()
        cursor = conn.cursor()

        localizacao_jogador = jogador[4]  # Loja onde o jogador está
        
        # Buscar os itens que a loja atual aceita comprar
        cursor.execute(
            "SELECT fk_id_item FROM vw_catalogo_loja WHERE fk_id_loja = %s",
            (localizacao_jogador,)
        )
        itens_loja = {item[0] for item in cursor.fetchall()}  # Set de itens aceitos na loja

        # Buscar os itens do inventário do jogador (sem quantidade, apenas listando cada um)
        cursor.execute("""
            SELECT DISTINCT fk_id_item, nome_item, tipo_item,quantidade, preco_item 
            FROM vw_inventario_jogador 
            WHERE id_jogador = %s
        """, (jogador[0],))
        inventario = cursor.fetchall()

        if not inventario:
            print("❌ Você não tem itens para vender.")
            input("🔄 Pressione Enter para continuar...")
            return
        
        print(f"\n💰 Suas moedas: {jogador[11]}\n")
        print("🛒 Itens no seu inventário:")
        print("=" * 60)
        print(f"{'Nº':<5} {'Nome':<20} {'Tipo':<15} {'Qtd.':<10} {'Preço':<10}")
        print("=" * 60)

        index_to_item = {}  # Mapeia a escolha para o ID do item
        index = 1

        for item in inventario:
            fk_id_item, nome, tipo,quantidade, preco = item

            # Verifica se o item pode ser vendido nesta loja
            if fk_id_item not in itens_loja:
                continue

            print(f"{index:<5} {nome:<20} {tipo:<15} {quantidade:<10} {preco:<10.2f}")
            index_to_item[index] = (fk_id_item, preco)
            index += 1

        if not index_to_item:
            print("❌ Nenhum dos seus itens pode ser vendido nesta loja.")
            input("🔄 Pressione Enter para continuar...")
            return

        print("=" * 60)
        escolha = input("🛍️ Digite o número do item que deseja vender ou 's' para sair: ")

        if escolha.lower() == 's':
            return
        
        try:
            escolha = int(escolha)
            if escolha not in index_to_item:
                print("❌ Escolha inválida!")
                input("🔄 Pressione Enter para continuar...")
                return vender_item(jogador)
        except ValueError:
            print("❌ Entrada inválida! Digite um número válido ou 's' para sair.")
            input("🔄 Pressione Enter para continuar...")
            return vender_item(jogador)

        fk_id_item, preco_item = index_to_item[escolha]

        # Atualizar as moedas do jogador
        cursor.execute("UPDATE Jogador SET moedas = moedas + %s WHERE id_jogador = %s", (preco_item, jogador[0]))

        # Chamar a função para remover apenas UMA instância do item do inventário
        remover_item_inventario(jogador, fk_id_item)

        conn.commit()  # Confirmar alterações no banco

        print(f"✅ Você vendeu 1x '{inventario[escolha - 1][1]}' por {preco_item:.2f} moedas!")
        input("🔄 Pressione Enter para continuar...")

    except Exception as error:
        print(f"❌ Ocorreu um erro ao vender o item: {error}")
    finally:
        if cursor:
            cursor.close()
        if conn:
            conn.close()


def comprar_item(jogador):
    clear_terminal()
    try:
        connection = get_connection()
        cursor = connection.cursor()
        
        localizacao_jogador = jogador[4]
        
        cursor.execute("SELECT fk_id_item, nome_item, tipo_item, preco_item FROM vw_catalogo_loja WHERE fk_id_loja = %s", (localizacao_jogador,))  
        catalogo = cursor.fetchall()
        
        if not catalogo:
            print("❌ Não há itens na loja.")
            input("🔄 Pressione Enter para continuar...")
            interacao_loja(jogador)
            return
        
        print(f"\n💰 Suas moedas: {jogador[11]}\n")
        
        print("🛒 Itens disponíveis para compra:")
        print("=" * 50)
        print(f"{'Nº':<5} {'Nome':<20} {'Tipo':<15} {'Preço':<10}")
        print("=" * 50)

        index_to_item = {}  
        for index, item in enumerate(catalogo, start=1):
            fk_id_item, nome, tipo, preco = item
            print(f"{index:<5} {nome:<20} {tipo:<15} {preco:<10.2f}")
            index_to_item[index] = fk_id_item  
        
        print("=" * 50)
        escolha = input("🛍️ Digite o número do item que deseja comprar ou 's' para sair: ")

        if escolha.lower() == 's':
            return
        
        # Verifica se a escolha é válida
        try:
            escolha = int(escolha)
            if escolha not in index_to_item:
                print("❌ Escolha inválida!")
                input("🔄 Pressione Enter para continuar...")
                return comprar_item(jogador)
        except ValueError:
            print("❌ Entrada inválida! Digite um número válido ou 's' para sair.")
            input("🔄 Pressione Enter para continuar...")
            return comprar_item(jogador)

        fk_id_item = index_to_item[escolha]

        # Buscar o preço do item selecionado
        cursor.execute("SELECT preco_item FROM vw_catalogo_loja WHERE fk_id_item = %s", (fk_id_item,))
        preco_item = cursor.fetchone()[0]

        # Verificar se o jogador tem moedas suficientes
        if jogador[11] < preco_item:
            print("❌ Você não tem moedas suficientes para comprar esse item.")
            input("🔄 Pressione Enter para continuar...")
            return comprar_item(jogador)

        # Descontar moedas do jogador
        cursor.execute("UPDATE Jogador SET moedas = moedas - %s WHERE id_jogador = %s", (preco_item, jogador[0]))
        connection.commit()

        # Criar o item no inventário do jogador
        criar_item(jogador, fk_id_item)

        print(f"✅ Você comprou '{catalogo[escolha - 1][1]}' por {preco_item:.2f} moedas!")

        input("🔄 Pressione Enter para continuar...")

    except Exception as error:
        print(f"❌ Ocorreu um erro ao listar os itens da loja: {error}")
    finally:
        if cursor:
            cursor.close()
        if connection:
            connection.close()


def interacao_loja(jogador):
    loja_infos = ambiente_info(jogador[4])
    while True:
        carregar_personagem(jogador[0])
        clear_terminal()
        print(f"Bem-vindo a {loja_infos[2]}\n{loja_infos[3]}\n")
        print("Suas opções:")
        opcoes_menu = [
            "1 - Comprar itens",
            "2 - Vender itens",
            "9 - Voltar ao menu"
        ]
        
        for op in opcoes_menu:
            print(op)

        escolha = int(input("\nO que você deseja fazer? (Digite o número da opção desejada)\n> "))
        
        if escolha == 1:
            comprar_item(jogador)
        if escolha == 2:
            vender_item(jogador)
        elif escolha == 9:
            break
        jogador = carregar_personagem(jogador[0])