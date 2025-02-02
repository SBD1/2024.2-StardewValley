from setup.database import get_connection
import time

def avancar_tempo(jogador, minutos):
    try:
        conn = get_connection()
        cursor = conn.cursor()
        cursor.execute("SET client_min_messages = 'NOTICE';")
        cursor.execute(
            """
            UPDATE Jogador SET tempo = tempo + INTERVAL '(%s) minutes'
            WHERE id_jogador = %s;
            """,
            (minutos,jogador[0])
        )
        
        conn.commit()
        
        for notice in conn.notices:
            print("💤", notice.strip())
<<<<<<< HEAD
<<<<<<< HEAD
            input("\nDigite 1 para retornar ao menu\n> ")
        
=======
        
        input("\nDigite 1 para retornar ao menu\n> ")
>>>>>>> 44b69ef (criando opção de exibir inventario do jogador no menu do jogo)
=======
            time.sleep(7)
>>>>>>> 61adce5 (Merge branch 'refactor/ajustes_ddl' of github.com:SBD1/2024.2-StardewValley into refactor/ajustes_ddl)
        
    except Exception as e:
        print(f"Erro ao passar o tempo: {e}")
    finally:
        cursor.close()
        conn.close()