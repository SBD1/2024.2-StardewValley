from setup.database import setup_database, get_connection

import os

DDL_FILE_PATH = os.path.join(os.path.dirname(__file__), "db/ddl.sql")

def criar_personagem():
    nome = input("Digite o nome do seu personagem: ").strip()
    try:
        conn = get_connection()
        cursor = conn.cursor()
        cursor.execute(
            """
            INSERT INTO Jogador (nome) VALUES (%s)
            RETURNING id;
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
        cursor.execute("SELECT id, nome FROM Jogador")
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

def carregar_personagem(jogador_id):
    try:
        conn = get_connection()
        cursor = conn.cursor()
        cursor.execute("SELECT * FROM Jogador WHERE id = %s", (jogador_id,))
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
    while True:
        print("\nBem-vindo ao Stardew Valley!")
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
    setup_database(DDL_FILE_PATH)  

    jogador = menu_inicial()
    if jogador:
        print(f"\nVocê está pronto para começar, {jogador[5]}!")
