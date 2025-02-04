from setup.database import get_connection


def criar_item(jogador, id_item):
    try:
        conn = get_connection()
        cursor = conn.cursor()

        # Buscar o ID do inventário do jogador
        cursor.execute("SELECT id_inventario FROM inventario WHERE fk_id_jogador = %s", (jogador[0],))
        inventario = cursor.fetchone()
        
        if not inventario:
            print("❌ Inventário do jogador não encontrado.")
            return
        
        id_inventario = inventario[0]

        # Inserir o item no inventário do jogador
        cursor.execute(
            "INSERT INTO instancia_de_item (fk_id_jogador, fk_id_item, fk_id_inventario) VALUES (%s, %s, %s)",
            (jogador[0], id_item, id_inventario)
        )
        conn.commit()  # Confirma a transação


    except Exception as e:
        print(f"❌ Erro ao adicionar item ao inventário: {e}")
    finally:
        if cursor:
            cursor.close()
        if conn:
            conn.close()
            
def remover_item_inventario(jogador, fk_id_item):
    """Remove uma única instância do item do inventário do jogador."""
    try:
        conn = get_connection()
        cursor = conn.cursor()

        # Buscar o ID de UMA instância específica do item para remover
        cursor.execute("""
            SELECT id_instancia_de_item FROM instancia_de_item 
            WHERE fk_id_jogador = %s AND fk_id_item = %s 
            ORDER BY id_instancia_de_item ASC
            LIMIT 1
        """, (jogador[0], fk_id_item))

        instancia = cursor.fetchone()

        if not instancia:
            print("❌ O item não está no seu inventário.")
            return

        id_instancia = instancia[0]

        # Remover APENAS a instância encontrada
        cursor.execute("DELETE FROM instancia_de_item WHERE id_instancia_de_item = %s", (id_instancia,))

        conn.commit()
        print("✅ 1 unidade do item removida do inventário.")

    except Exception as error:
        print(f"❌ Erro ao remover item do inventário: {error}")
    finally:
        if cursor:
            cursor.close()
        if conn:
            conn.close()

