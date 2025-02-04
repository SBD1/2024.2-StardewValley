-- ---------------------------------------------------------------------------------------------------------------
-- Data de Criação ........: 03/02/2025                                                                         --
-- Autor(es) ..............: Gabriel Silva, Gabriel Zaranza, Isaac Batista, Manuella Valadares, Marcos Marinho  --
-- Versão .................: 1.2                                                                                --
-- Banco de Dados .........: PostgreSQL                                                                         --
-- Descrição ..............: Adicona Triggers e restrições                                                      --
-- ---------------------------------------------------------------------------------------------------------------

BEGIN;

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

-- Trigger para garantir exclusividade entre ferramenta, arma, consumivel, mineral e recurso

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

CREATE TRIGGER exclusividade_tipo_item_trigger
BEFORE INSERT ON item
FOR EACH ROW EXECUTE FUNCTION exclusividade_tipo_item();

CREATE OR REPLACE FUNCTION avancar_dia_se_passar_meia_noite()
RETURNS TRIGGER AS $$
DECLARE
    tempo_atual TIME;
    novo_tempo TIME;
BEGIN
    SELECT tempo INTO tempo_atual FROM Jogador WHERE id_jogador = NEW.id_jogador;
    
    novo_tempo := NEW.tempo;

    IF novo_tempo < tempo_atual THEN
        NEW.dia := NEW.dia + 1;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

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

CREATE TRIGGER excluir_item_trigger
BEFORE DELETE ON item
FOR EACH ROW EXECUTE FUNCTION excluir_item_relacionado();

CREATE OR REPLACE FUNCTION impedir_update_tipo_item()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.tipo_item <> OLD.tipo_item THEN
        RAISE EXCEPTION 'Não é permitido alterar o tipo do item.';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER impedir_update_tipo_item_trigger
BEFORE UPDATE ON item
FOR EACH ROW EXECUTE FUNCTION impedir_update_tipo_item();

CREATE TRIGGER trigger_avancar_dia
BEFORE UPDATE ON Jogador
FOR EACH ROW
WHEN (NEW.tempo < OLD.tempo)  
EXECUTE FUNCTION avancar_dia_se_passar_meia_noite();

CREATE OR REPLACE FUNCTION forcar_jogador_a_dormir()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.tempo > '02:00' AND NEW.tempo < '06:00' THEN
        NEW.localizacao_atual := 1;
        NEW.tempo := '06:00';
        NEW.dia := NEW.dia + 1;
        NEW.moedas := NEW.moedas * 0.95;
        RAISE NOTICE 'O jogador % foi forçado a dormir e acordou às 06:00!', NEW.id_jogador;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_forcar_dormir
BEFORE UPDATE ON Jogador
FOR EACH ROW
WHEN (NEW.tempo > '02:00')
EXECUTE FUNCTION forcar_jogador_a_dormir();

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
        EXIT WHEN NOT FOUND; -- 🔹 Evita loop infinito

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

CREATE TRIGGER trigger_animal_avancar_dia
BEFORE UPDATE ON Jogador
FOR EACH ROW
WHEN (NEW.tempo = '06:00')
EXECUTE FUNCTION animal_avancar_dia();

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
        EXIT WHEN NOT FOUND; -- 🔹 Evita loop infinito

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

CREATE TRIGGER trigger_planta_avancar_dia
BEFORE UPDATE ON Jogador
FOR EACH ROW
WHEN (NEW.tempo = '06:00')
EXECUTE FUNCTION planta_avancar_dia();

COMMIT;