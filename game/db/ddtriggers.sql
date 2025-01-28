------------------------------ Triggers na tabela Instancia_de_Inimigo ------------------------------

  -- Tabela afetada: Instancia_de_Inimigo
    CREATE OR REPLACE FUNCTION excluir_inimigos_mortos()
    RETURNS TRIGGER AS $excluir_inimigos_mortos$
    BEGIN
      IF NEW.vidaAtual <= 0 THEN
        DELETE FROM Instancia_de_Inimigo 
        WHERE id_instancia_de_inimigo = OLD.id_instancia_de_inimigo;
      END IF;

      -- Retorna NULL pq é AFTER 
      RETURN NULL;
    END;
    $excluir_inimigos_mortos$ LANGUAGE plpgsql;

    CREATE TRIGGER trigger_excluir_inimigos_mortos
    AFTER UPDATE
    ON Instancia_de_Inimigo 
    FOR EACH ROW
    EXECUTE FUNCTION excluir_inimigos_mortos();

  -- Tabela afetada: Caverna
    CREATE OR REPLACE FUNCTION atualizar_quantidade_mobs()
    RETURNS TRIGGER AS $atualizar_quantidade_mobs$
    BEGIN
      IF TG_OP = 'DELETE' THEN
        -- Decrementa a quantidade de mobs na caverna, garantindo que seja no mínimo 0
        UPDATE Caverna
        SET quantidade_mobs = GREATEST(quantidade_mobs - 1, 0)
        WHERE andar = OLD.fk_Caverna_andar;
      ELSIF TG_OP = 'INSERT' THEN
        -- Incrementa a quantidade de mobs na caverna
        UPDATE Caverna
        SET quantidade_mobs = quantidade_mobs + 1
        WHERE andar = NEW.fk_Caverna_andar;
      END IF;

      RETURN OLD; -- Retorna a linha deletada para operações AFTER DELETE
    END;
    $atualizar_quantidade_mobs$ LANGUAGE plpgsql;

    CREATE TRIGGER trigger_atualizar_quantidade_mobs
    AFTER DELETE OR INSERT
    ON Instancia_de_Inimigo
    FOR EACH ROW
    EXECUTE FUNCTION atualizar_quantidade_mobs();

  -- Tabela afetada: Jogador, tá grande pra krl, mas fdse, FUNCIONA
  CREATE OR REPLACE FUNCTION adiciona_xp_combate()
  RETURNS TRIGGER AS $adiciona_xp$
  DECLARE
      jogador_id INTEGER;
      xp_combate_jogador INTEGER;
      nova_habilidade INTEGER;
      habilidade_atual INTEGER;
  BEGIN
      -- Pega o id do jogador
      SELECT fk_jogador_id INTO jogador_id
      FROM Ambiente
      WHERE fk_jogador_id IS NOT NULL;

      -- Atualiza o xp_combate do jogador
      UPDATE Jogador
      SET xp_combate = xp_combate + (
          SELECT xp_recompensa
          FROM Inimigo
          WHERE id_inimigo = OLD.fk_Inimigo_id
      )
      WHERE id_jogador = jogador_id
      RETURNING xp_combate INTO xp_combate_jogador;

      -- Verifica se é necessário subir de nível
      SELECT fk_Habilidade_id INTO nova_habilidade
      FROM habCombate
      WHERE xp_combate_jogador >= xpMin AND xp_combate_jogador < xpMax
      LIMIT 1;

      -- Pega a habilidade atual do jogador
      SELECT fk_habCombate_fk_Habilidade_id INTO habilidade_atual
      FROM Jogador
      WHERE id_jogador = jogador_id;

      -- Atualiza os atributos do jogador se a habilidade mudar
      IF nova_habilidade <> habilidade_atual THEN
          UPDATE Jogador
          SET fk_habCombate_fk_Habilidade_id = nova_habilidade,
              dano_ataque = dano_ataque + (
                  SELECT danoBonus
                  FROM habCombate
                  WHERE fk_Habilidade_id = nova_habilidade
              ),
              vidaMax = vidaMax + (
                  SELECT vidaBonus
                  FROM habCombate
                  WHERE fk_Habilidade_id = nova_habilidade
              )
          WHERE id_jogador = jogador_id;
      END IF;

      RETURN NULL;  
  END;
  $adiciona_xp$ LANGUAGE plpgsql;

  CREATE OR REPLACE TRIGGER trigger_adiciona_xp
  AFTER DELETE
  ON Instancia_de_Inimigo
  FOR EACH ROW
  EXECUTE FUNCTION adiciona_xp_combate();