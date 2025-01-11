-- Inserir uma habilidade básica
INSERT INTO Habilidade (id, nivel, tipo, xpMin, xpMax)
VALUES   -- Mineração
    (1, 1, 'mineracao', 0, 100),
    (2, 2, 'mineracao', 101, 200),
    (3, 3, 'mineracao', 201, 300),
    (4, 4, 'mineracao', 301, 400),
    (5, 5, 'mineracao', 401, 500),
    (6, 6, 'mineracao', 501, 600),
    (7, 7, 'mineracao', 601, 700),
    (8, 8, 'mineracao', 701, 800),
    (9, 9, 'mineracao', 801, 900),
    (10, 10, 'mineracao', 901, 1000),

    -- Combate
    (11, 1, 'combate', 0, 100),
    (12, 2, 'combate', 101, 200),
    (13, 3, 'combate', 201, 300),
    (14, 4, 'combate', 301, 400),
    (15, 5, 'combate', 401, 500),
    (16, 6, 'combate', 501, 600),
    (17, 7, 'combate', 601, 700),
    (18, 8, 'combate', 701, 800),
    (19, 9, 'combate', 801, 900),
    (20, 10, 'combate', 901, 1000),

    -- Cultivo
    (21, 1, 'cultivo', 0, 100),
    (22, 2, 'cultivo', 101, 200),
    (23, 3, 'cultivo', 201, 300),
    (24, 4, 'cultivo', 301, 400),
    (25, 5, 'cultivo', 401, 500),
    (26, 6, 'cultivo', 501, 600),
    (27, 7, 'cultivo', 601, 700),
    (28, 8, 'cultivo', 701, 800),
    (29, 9, 'cultivo', 801, 900),
    (30, 10, 'cultivo', 901, 1000);


-- Inserir registros relacionados nas tabelas habMineracao, habCombate e habCultivo
INSERT INTO habMineracao (fk_Habilidade_id, reducaoEnergiaMinera, minerioBonus)
VALUES
    (1, 0, 0),
    (2, 2, 0),
    (3, 4, 0),
    (4, 6, 0),
    (5, 8, 1),
    (6, 10, 1),
    (7, 12, 1),
    (8, 14, 1),
    (9, 16, 1),
    (10, 18, 2);

INSERT INTO habCombate (fk_Habilidade_id, vidaBonus, danoBonus)
VALUES
    (11, 0, 0),
    (12, 5, 1),
    (13, 10, 2),
    (14, 15, 3),
    (15, 20, 4),
    (16, 25, 5),
    (17, 30, 6),
    (18, 35, 7),
    (19, 40, 8),
    (20, 45, 9);

INSERT INTO habCultivo (fk_Habilidade_id, cultivoBonus, reducaoEnergiaCultiva)
VALUES
    (21, 0, 0),
    (22, 0, 2),
    (23, 0, 4),
    (24, 0, 6),
    (25, 0, 8),
    (26, 1, 10),
    (27, 1, 12),
    (28, 1, 14),
    (29, 1, 16),
    (30, 2, 18);

INSERT INTO Animal (id, nome, diasTotalDropar, tipo, itemDrop, preco)
VALUES
    (1, 'vaca', 7, 'vaca', 1, 50),--mudar o item drop para o id do leite!!!
    (2, 'galinha', 3, 'galinha', 2, 30),--mudar o item drop para o id do ovo!!!
    (3, 'porco', 5, 'porco', 3, 40);--mudar o item  para o id do carne!!!

INSERT INTO inimigo (id, nome, tipo, vidaMax, dano) VALUES
    (1, 'Morcego da Caverna', 'caverna', 30, 5),
    (2, 'Aranha das Sombras', 'caverna', 20, 7),
    (3, 'Golem de Pedras', 'caverna', 50, 10),
    (4, 'Rato Gigante', 'caverna', 15, 3),
    (5, 'Fantasma Errante', 'caverna', 10, 8),
    (6, 'Slime Escuro', 'caverna', 40, 6),
    (7, 'Escorpião Caverneiro', 'caverna', 25, 4),
    (8, 'Serpente Rochosa', 'caverna', 35, 9),
    (9, 'Fungo Venenoso', 'caverna', 5, 2),
    (10, 'Lagarto Albino', 'caverna', 45, 10);
