BEGIN;
-- spawnar_inimigos()
-- Função que gera inimigos para um jogador em diferentes andares.
CREATE OR REPLACE FUNCTION spawnar_inimigos(jogador_id INT)
RETURNS VOID AS $spawnar_inimigos$
DECLARE
    -- Variáveis para armazenar a vida máxima dos inimigos
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

        -- Inserção de inimigos em diferentes andares com suas respectivas vidas
        -- Andar 1: 8 mobs
        INSERT INTO Instancia_de_Inimigo (vidaAtual, fk_id_ambiente, fk_inimigo_id, fk_jogador_id) VALUES
        (vida_morcego, 16, 1, jogador_id),  -- Morcego da Caverna
        (vida_morcego, 16, 1, jogador_id),  -- Morcego da Caverna
        (vida_aranha, 16, 2, jogador_id),   -- Aranha das Sombras
        (vida_serpente, 16, 8, jogador_id); -- Serpente Rochosa

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
-- Função que exclui inimigos que foram derrotados (vidaAtual <= 0).
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

-- Trigger que chama a função excluir_inimigos_mortos após a atualização da vida de um inimigo.
CREATE TRIGGER trigger_excluir_inimigos_mortos
AFTER UPDATE
ON Instancia_de_Inimigo 
FOR EACH ROW
EXECUTE FUNCTION excluir_inimigos_mortos();

-- atualizar_quantidade_mobs() 
/*
-- Tabelas afetadas: Caverna (ficou inútil essa trigger)
-- Função que atualiza a quantidade de mobs na caverna ao inserir ou excluir inimigos.
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

-- Trigger que chama a função atualizar_quantidade_mobs após a inserção ou exclusão de um inimigo.
CREATE TRIGGER trigger_atualizar_quantidade_mobs
AFTER DELETE OR INSERT
ON Instancia_de_Inimigo
FOR EACH ROW
EXECUTE FUNCTION atualizar_quantidade_mobs();
*/

-- adiciona_xp_combate()
-- Função que adiciona experiência de combate ao jogador após derrotar um inimigo.
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

-- Trigger que chama a função adiciona_xp_combate após a exclusão de um inimigo.
CREATE OR REPLACE TRIGGER trigger_adiciona_xp
AFTER DELETE
ON Instancia_de_Inimigo
FOR EACH ROW
EXECUTE FUNCTION adiciona_xp_combate();

-- inserir_item()
-- Função que insere um novo item na tabela Item e nas tabelas correspondentes (ferramenta, arma, consumível, mineral, recurso).
CREATE FUNCTION inserir_item(
    tipo_item_param VARCHAR(20),
    nome_param VARCHAR(100),
    descricao_param TEXT,
    eficiencia_param INTEGER DEFAULT NULL,
    dano_arma_param INTEGER DEFAULT NULL,
    efeito_vida_param INTEGER DEFAULT NULL,
    resistencia_param INTEGER DEFAULT NULL,
    preco_param DECIMAL DEFAULT NULL
)
RETURNS INTEGER AS $$
DECLARE
    item_id_result INTEGER;
BEGIN
    -- Inserir na tabela Item
    INSERT INTO item (tipo_item) VALUES (tipo_item_param) RETURNING id_item INTO item_id_result;

    -- Inserir na tabela correspondente
    IF tipo_item_param = 'ferramenta' THEN
        INSERT INTO ferramenta (fk_id_item, nome, descricao, eficiencia, nivel)
        VALUES (item_id_result, nome_param, descricao_param, eficiencia_param);
    ELSIF tipo_item_param = 'arma' THEN
        INSERT INTO arma (fk_id_item, nome, descricao, dano_arma)
        VALUES (item_id_result, nome_param, descricao_param, dano_arma_param);
    ELSIF tipo_item_param = 'consumivel' THEN
        INSERT INTO consumivel (fk_id_item, nome, descricao, efeito_vida)
        VALUES (item_id_result, nome_param, descricao_param, efeito_vida_param);
    ELSIF tipo_item_param = 'mineral' THEN
        INSERT INTO mineral (fk_id_item, nome, descricao, resistencia, preco)
        VALUES (item_id_result, nome_param, descricao_param, resistencia_param, preco_param);
    ELSIF tipo_item_param = 'recurso' THEN
        INSERT INTO recurso (fk_id_item, nome, descricao, preco)
        VALUES (item_id_result, nome_param, descricao_param, preco_param);
    END IF;

    RETURN item_id_result;
END;
$$ LANGUAGE plpgsql;

-- exclusividade_tipo_item()
-- Função que garante que um item não pode ser associado a mais de um tipo (ferramenta, arma, consumível, mineral, recurso).
CREATE OR REPLACE FUNCTION exclusividade_tipo_item()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.tipo_item = 'ferramenta' AND EXISTS (SELECT 1 FROM ferramenta WHERE fk_id_item = NEW.id_item) THEN
        RAISE EXCEPTION 'O item já está associado a uma ferramenta.';
    ELSIF NEW.tipo_item = 'arma' AND EXISTS (SELECT 1 FROM arma WHERE fk_id_item = NEW.id_item) THEN
        RAISE EXCEPTION 'O item já está associado a uma arma.';
    ELSIF NEW.tipo_item = 'consumivel' AND EXISTS (SELECT 1 FROM consumivel WHERE fk_id_item = NEW.id_item) THEN
        RAISE EXCEPTION 'O item já está associado a um consumível.';
    ELSIF NEW.tipo_item = 'mineral' AND EXISTS (SELECT 1 FROM mineral WHERE fk_id_item = NEW.id_item) THEN
        RAISE EXCEPTION 'O item já está associado a um mineral.';
    ELSIF NEW.tipo_item = 'recurso' AND EXISTS (SELECT 1 FROM recurso WHERE fk_id_item = NEW.id_item) THEN
        RAISE EXCEPTION 'O item já está associado a um recurso.';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger que chama a função exclusividade_tipo_item antes de inserir um novo item.
CREATE TRIGGER exclusividade_tipo_item_trigger
BEFORE INSERT ON item
FOR EACH ROW EXECUTE FUNCTION exclusividade_tipo_item();

-- avancar_dia_se_passar_meia_noite()
-- Função que avança o dia do jogador se o tempo atual for menor que o tempo anterior.
CREATE OR REPLACE FUNCTION avancar_dia_se_passar_meia_noite()
RETURNS TRIGGER AS $$
DECLARE
    tempo_atual TIME;
    novo_tempo TIME;
BEGIN
    SELECT tempo INTO tempo_atual FROM Jogador WHERE id_jogador = NEW.id_jogador;
    
    novo_tempo := NEW.tempo;

    IF novo_tempo < tempo_atual THEN
        NEW.dia := NEW.dia + 1; -- Avança o dia
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- excluir_item_relacionado()
-- Função que exclui os registros relacionados a um item nas tabelas específicas ao deletar um item.
CREATE OR REPLACE FUNCTION excluir_item_relacionado()
RETURNS TRIGGER AS $$
BEGIN
    DELETE FROM ferramenta WHERE fk_id_item = OLD.id_item;
    DELETE FROM arma WHERE fk_id_item = OLD.id_item;
    DELETE FROM consumivel WHERE fk_id_item = OLD.id_item;
    DELETE FROM mineral WHERE fk_id_item = OLD.id_item;
    DELETE FROM recurso WHERE fk_id_item = OLD.id_item;
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

-- Trigger que chama a função excluir_item_relacionado antes de deletar um item.
CREATE TRIGGER excluir_item_trigger
BEFORE DELETE ON item
FOR EACH ROW EXECUTE FUNCTION excluir_item_relacionado();

-- impedir_update_tipo_item()
-- Função que impede a alteração do tipo de um item após sua criação.
CREATE OR REPLACE FUNCTION impedir_update_tipo_item()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.tipo_item <> OLD.tipo_item THEN
        RAISE EXCEPTION 'Não é permitido alterar o tipo do item.';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger que chama a função impedir_update_tipo_item antes de atualizar um item.
CREATE TRIGGER impedir_update_tipo_item_trigger
BEFORE UPDATE ON item
FOR EACH ROW EXECUTE FUNCTION impedir_update_tipo_item();

-- trigger_avancar_dia
-- Trigger que chama a função avancar_dia_se_passar_meia_noite antes de atualizar o jogador.
CREATE TRIGGER trigger_avancar_dia
BEFORE UPDATE ON Jogador
FOR EACH ROW
WHEN (NEW.tempo < OLD.tempo)  
EXECUTE FUNCTION avancar_dia_se_passar_meia_noite();

-- forcar_jogador_a_dormir()
-- Função que força o jogador a dormir se o tempo estiver entre 02:00 e 06:00.
CREATE OR REPLACE FUNCTION forcar_jogador_a_dormir()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.tempo > '02:00' AND NEW.tempo < '06:00' THEN
        NEW.localizacao_atual := 1; -- Define a localização do jogador como a de dormir
        NEW.tempo := '06:00'; -- Define o tempo para 06:00
        NEW.moedas := NEW.moedas * 0.95; -- Deduz 5% das moedas do jogador
        RAISE NOTICE 'O jogador % foi forçado a dormir e acordou às 06:00!', NEW.id_jogador;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger que chama a função forcar_jogador_a_dormir antes de atualizar o jogador.
CREATE TRIGGER trigger_forcar_dormir
BEFORE UPDATE ON Jogador
FOR EACH ROW
WHEN (NEW.tempo > '02:00')
EXECUTE FUNCTION forcar_jogador_a_dormir();

-- animal_avancar_dia()
-- Função que avança o dia dos animais do jogador.
CREATE OR REPLACE FUNCTION animal_avancar_dia()
RETURNS TRIGGER AS $$
DECLARE
    cursor_inst_animal CURSOR FOR 
    SELECT i.id_instancia_de_animal, i.diaAtual, a.diasTotalDropar
    FROM Instancia_de_Animal i 
    JOIN Animal a ON i.fk_Animal_id = a.id_animal 
    WHERE i.fk_Jogador_id = NEW.id_jogador;
    
    animal_row RECORD;
BEGIN
    OPEN cursor_inst_animal;
    
    LOOP
        FETCH cursor_inst_animal INTO animal_row;
        EXIT WHEN NOT FOUND; -- Evita loop infinito

        -- Atualizar os dias do animal
        UPDATE Instancia_de_Animal
        SET 
            diaAtual = diaAtual + 1,
            prontoDropa = (diaAtual + 1 >= animal_row.diasTotalDropar)
        WHERE id_instancia_de_animal = animal_row.id_instancia_de_animal;
    
    END LOOP;

    CLOSE cursor_inst_animal;
    
    RETURN NEW; 
END;
$$ LANGUAGE plpgsql;

-- Trigger que chama a função animal_avancar_dia antes de atualizar o jogador.
CREATE TRIGGER trigger_animal_avancar_dia
BEFORE UPDATE ON Jogador
FOR EACH ROW
WHEN (OLD.dia < NEW.dia)
EXECUTE FUNCTION animal_avancar_dia();

-- planta_avancar_dia()
-- Função que avança o dia das plantas do jogador.
CREATE OR REPLACE FUNCTION planta_avancar_dia()
RETURNS TRIGGER AS $$
DECLARE
    cursor_inst_planta CURSOR FOR 
    SELECT i.id_instancia_de_planta, i.diaAtual, a.diaDropar
    FROM Instancia_de_Planta i 
    JOIN Planta a ON i.fk_id_planta = a.id_planta 
    WHERE i.fk_id_jogador = NEW.id_jogador; 
    
    planta_row RECORD;
BEGIN
    OPEN cursor_inst_planta;
    
    LOOP
        FETCH cursor_inst_planta INTO planta_row;
        EXIT WHEN NOT FOUND; -- Evita loop infinito

        -- Atualizar os dias da planta
        UPDATE Instancia_de_Planta
        SET 
            diaAtual = diaAtual + 1,
            prontoColher = (diaAtual + 1 >= planta_row.diaDropar)
        WHERE id_instancia_de_planta = planta_row.id_instancia_de_planta;
    
    END LOOP;

    CLOSE cursor_inst_planta;
    
    RETURN NEW; 
END;
$$ LANGUAGE plpgsql;

-- Trigger que chama a função planta_avancar_dia antes de atualizar o jogador.
CREATE TRIGGER trigger_planta_avancar_dia
BEFORE UPDATE ON Jogador
FOR EACH ROW
WHEN (OLD.dia < NEW.dia)
EXECUTE FUNCTION planta_avancar_dia();

COMMIT;