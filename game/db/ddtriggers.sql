----------------- Triggers/Funções da tabela Habilidade -----------------

  -- inserir_habilidade()
    -- Tabelas afetadas: Habilidade, habMineracao, habCombate, habCultivo 
------------ Triggers/Funções da tabela Instancia_de_Inimigo ------------

  -- spawnar_inimigos()
    -- Tabelas afetadas: Instancia_de_Inimigo
      CREATE OR REPLACE FUNCTION spawnar_inimigos(jogador_id INT)
      RETURNS VOID AS $spawnar_inimigos$
      DECLARE
          vida_morcego FLOAT;
          vida_aranha FLOAT;
          vida_rato FLOAT;
          vida_escorpiao FLOAT;
          vida_serpente FLOAT;
          vida_fantasma FLOAT;
          vida_golem FLOAT;
          vida_slime FLOAT;
          vida_lagarto FLOAT;
          vida_fungo FLOAT;
      BEGIN
        RAISE NOTICE 'Spawnando inimigos para o jogador %', jogador_id;
          -- Valida se o jogador existe
          IF NOT EXISTS (SELECT 1 FROM Jogador WHERE id_jogador = jogador_id) THEN
              RAISE EXCEPTION 'Jogador com id % não encontrado.', jogador_id;
          END IF;

          -- Busca os valores de vidaMax dos inimigos
          SELECT vidaMax INTO vida_morcego FROM Inimigo WHERE id_inimigo = 1;
          SELECT vidaMax INTO vida_aranha FROM Inimigo WHERE id_inimigo = 2;
          SELECT vidaMax INTO vida_golem FROM Inimigo WHERE id_inimigo = 3;
          SELECT vidaMax INTO vida_rato FROM Inimigo WHERE id_inimigo = 4;
          SELECT vidaMax INTO vida_fantasma FROM Inimigo WHERE id_inimigo = 5;
          SELECT vidaMax INTO vida_slime FROM Inimigo WHERE id_inimigo = 6;
          SELECT vidaMax INTO vida_escorpiao FROM Inimigo WHERE id_inimigo = 7;
          SELECT vidaMax INTO vida_serpente FROM Inimigo WHERE id_inimigo = 8;
          SELECT vidaMax INTO vida_fungo FROM Inimigo WHERE id_inimigo = 9;
          SELECT vidaMax INTO vida_lagarto FROM Inimigo WHERE id_inimigo = 10;

          BEGIN
            RAISE NOTICE 'Spawnando inimigos para o jogador %', jogador_id;
              -- Andar 1: 8 mobs
              INSERT INTO Instancia_de_Inimigo (vidaAtual, fk_id_ambiente, fk_inimigo_id, fk_jogador_id) VALUES
              (vida_morcego, 16, 1, jogador_id),  -- Morcego da Caverna
              (vida_morcego, 16, 1, jogador_id),  -- Morcego da Caverna
              --(vida_morcego, 16, 1, jogador_id),  -- Morcego da Caverna
              --(vida_morcego, 16, 1, jogador_id),  -- Morcego da Caverna
              (vida_aranha, 16, 2, jogador_id),   -- Aranha das Sombras
              --(vida_rato, 16, 4, jogador_id),     -- Rato Gigante
              --(vida_escorpiao, 16, 7, jogador_id),-- Escorpião Caverneiro
              (vida_serpente, 16, 8, jogador_id); -- Serpente Rochosa*/

              -- Andar 2: 2 mobs
              INSERT INTO Instancia_de_Inimigo (vidaAtual, fk_id_ambiente, fk_inimigo_id, fk_jogador_id) VALUES
              (vida_morcego, 17, 1, jogador_id),  -- Morcego da Caverna
              (vida_aranha, 17, 2, jogador_id);   -- Aranha das Sombras

              -- Andar 3: 4 mobs
              INSERT INTO Instancia_de_Inimigo (vidaAtual, fk_id_ambiente, fk_inimigo_id, fk_jogador_id) VALUES
              (vida_rato, 18, 4, jogador_id),     -- Rato Gigante
              (vida_escorpiao, 18, 7, jogador_id),-- Escorpião Caverneiro
              (vida_serpente, 18, 8, jogador_id), -- Serpente Rochosa
              (vida_fantasma, 18, 5, jogador_id); -- Fantasma Errante

              -- Andar 4: 3 mobs
              INSERT INTO Instancia_de_Inimigo (vidaAtual, fk_id_ambiente, fk_inimigo_id, fk_jogador_id) VALUES
              (vida_golem, 19, 3, jogador_id),    -- Golem de Pedras
              (vida_slime, 19, 6, jogador_id),    -- Slime Escuro
              (vida_lagarto, 19, 10, jogador_id); -- Lagarto Albino

              -- Andar 5: 10 mobs
              INSERT INTO Instancia_de_Inimigo (vidaAtual, fk_id_ambiente, fk_inimigo_id, fk_jogador_id) VALUES
              (vida_morcego, 20, 1, jogador_id),  -- Morcego da Caverna
              (vida_aranha, 20, 2, jogador_id),   -- Aranha das Sombras
              (vida_rato, 20, 4, jogador_id),     -- Rato Gigante
              (vida_escorpiao, 20, 7, jogador_id),-- Escorpião Caverneiro
              (vida_serpente, 20, 8, jogador_id), -- Serpente Rochosa
              (vida_fantasma, 20, 5, jogador_id), -- Fantasma Errante
              (vida_golem, 20, 3, jogador_id),    -- Golem de Pedras
              (vida_slime, 20, 6, jogador_id),    -- Slime Escuro
              (vida_lagarto, 20, 10, jogador_id), -- Lagarto Albino
              (vida_fungo, 20, 9, jogador_id);    -- Fungo Venenoso

              -- Andar 6: 8 mobs
              INSERT INTO Instancia_de_Inimigo (vidaAtual, fk_id_ambiente, fk_inimigo_id, fk_jogador_id) VALUES
              (vida_morcego, 21, 1, jogador_id),  -- Morcego da Caverna
              (vida_aranha, 21, 2, jogador_id),   -- Aranha das Sombras
              (vida_rato, 21, 4, jogador_id),     -- Rato Gigante
              (vida_escorpiao, 21, 7, jogador_id),-- Escorpião Caverneiro
              (vida_serpente, 21, 8, jogador_id), -- Serpente Rochosa
              (vida_fantasma, 21, 5, jogador_id), -- Fantasma Errante
              (vida_golem, 21, 3, jogador_id),    -- Golem de Pedras
              (vida_slime, 21, 6, jogador_id);    -- Slime Escuro
          END;
      END;
      $spawnar_inimigos$ LANGUAGE plpgsql;

  -- excluir_inimigos_mortos()
    -- Tabelas afetadas: Instancia_de_Inimigo
      CREATE OR REPLACE FUNCTION excluir_inimigos_mortos()
      RETURNS TRIGGER AS $excluir_inimigos_mortos$
      BEGIN
        IF NEW.vidaAtual <= 0 THEN
          DELETE FROM Instancia_de_Inimigo 
          WHERE id_instancia_de_inimigo = OLD.id_instancia_de_inimigo;
          RAISE NOTICE 'Inimigo de id % morto, excluindo', OLD.id_instancia_de_inimigo;
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

  -- atualizar_quantidade_mobs() 
  /*
    -- Tabelas afetadas: Caverna (ficou inútil essa trigger)
        CREATE OR REPLACE FUNCTION atualizar_quantidade_mobs()
        RETURNS TRIGGER AS $atualizar_quantidade_mobs$
        BEGIN
          IF TG_OP = 'DELETE' THEN
            -- Decrementa a quantidade de mobs na caverna, garantindo que seja no mínimo 0
            UPDATE Caverna
            SET quantidade_mobs = GREATEST(quantidade_mobs - 1, 0)
            WHERE fk_id_ambiente = OLD.fk_id_ambiente;
          ELSIF TG_OP = 'INSERT' THEN
            -- Incrementa a quantidade de mobs na caverna
            UPDATE Caverna
            SET quantidade_mobs = quantidade_mobs + 1
            WHERE fk_id_ambiente = NEW.fk_id_ambiente;
          END IF;

          RETURN OLD; -- Retorna a linha deletada para operações AFTER DELETE
        END;
        $atualizar_quantidade_mobs$ LANGUAGE plpgsql;

        CREATE TRIGGER trigger_atualizar_quantidade_mobs
        AFTER DELETE OR INSERT
        ON Instancia_de_Inimigo
        FOR EACH ROW
        EXECUTE FUNCTION atualizar_quantidade_mobs();
  */
  
  -- adiciona_xp_combate()
    -- Tabelas afetadas: Jogador, tá grande pra krl, mas fdse, FUNCIONA
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
        FROM Instancia_de_Inimigo
        WHERE fk_jogador_id = OLD.fk_jogador_id;

        RAISE NOTICE 'Adicionando % de xp de combate para o jogador %', jogador_id, (SELECT xp_recompensa FROM Inimigo WHERE id_inimigo = OLD.fk_Inimigo_id);
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
        WHERE xp_combate_jogador >= xpMin AND xp_combate_jogador <= xpMax
        LIMIT 1;

        -- Pega a habilidade atual do jogador
        SELECT fk_habCombate_fk_Habilidade_id INTO habilidade_atual
        FROM Jogador
        WHERE id_jogador = jogador_id;

        RAISE NOTICE 'Habilidade atual: %, Nova habilidade: %', habilidade_atual, nova_habilidade;
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