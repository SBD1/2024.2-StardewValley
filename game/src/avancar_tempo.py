from setup.database import get_connection


def avancar_tempo(jogador, minutos):
    try:
        conn = get_connection()
        cursor = conn.cursor()
        cursor.execute(
            """
            UPDATE Jogador SET tempo = tempo + INTERVAL '(%s) minutes'
            WHERE id_jogador = %s;
            """,
            (minutos,jogador[0])
        )
        
        conn.commit()
        
    except Exception as e:
        print(f"Erro ao passar o tempo: {e}")
    finally:
        cursor.close()
        conn.close()