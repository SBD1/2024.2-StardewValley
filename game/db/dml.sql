-- Inserir uma habilidade básica
INSERT INTO Habilidade (id, nivel, tipo, xpMin, xpMax)
VALUES (1, 1, 'Teste', 0, 100);

-- Inserir registros relacionados nas tabelas habMineracao, habCombate e habCultivo
INSERT INTO habMineracao (fk_Habilidade_id, reducaoEnergiaMinera, minerioBonus)
VALUES (1, 5, 10);

INSERT INTO habCombate (fk_Habilidade_id, vidaBonus, danoBonus)
VALUES (1, 20, 10);

INSERT INTO habCultivo (fk_Habilidade_id, cultivoBonus, reducaoEnergiaCultiva)
VALUES (1, 15, 5);
