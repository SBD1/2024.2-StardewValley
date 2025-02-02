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
            time.sleep(7)
        
    except Exception as e:
        print(f"Erro ao passar o tempo: {e}")
    finally:
        cursor.close()
        conn.close()