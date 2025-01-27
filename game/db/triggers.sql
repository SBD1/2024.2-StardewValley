CREATE OR REPLACE FUNCTION excluir_inimigos_mortos()
RETURNS TRIGGER AS $$
BEGIN
  DELETE FROM Instancia_de_Inimigo
  WHERE vidaAtual <= 0;

  -- Retorna NULL porque essa trigger é AFTER
  RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_excluir_inimigos_mortos
AFTER UPDATE
ON Instancia_de_Inimigo 
FOR EACH ROW
EXECUTE FUNCTION excluir_inimigos_mortos();

CREATE OR REPLACE FUNCTION atualizar_quantidade_mobs()
RETURNS TRIGGER AS $$
BEGIN
  UPDATE Caverna
  SET quantidade_mobs = quantidade_mobs - 1
  WHERE andar = OLD.fk_Caverna_andar;

  RETURN OLD; -- Retorna a linha deletada para operações AFTER DELETE
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_atualizar_quantidade_mobs
AFTER DELETE
ON Instancia_de_Inimigo
FOR EACH ROW
EXECUTE FUNCTION atualizar_quantidade_mobs();