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

INSERT INTO Ambiente (id_ambiente, tipo, fk_id_mapa, fk_jogador_id, descricao, transitar_1, transitar_2, transitar_3, transitar_4, transitar_5, transitar_6) VALUES
(1, 'Cabana', 1, 0, 'Casa de troncos herdada pelo seu avô. Um lugar aconchegante para descansar após um longo dia de trabalho.', 2, 3, 4, 5, NULL, NULL),
(2, 'Plantação', 1, 0, 'Uma vasta área de terra cercada por montanhas. Aqui, você pode plantar sementes.', 1, NULL, NULL, NULL, NULL, NULL),
(3, 'Celeiro', 1, 0, 'Um amplo celeiro de madeira com cheiro de feno fresco.', 1, NULL, NULL, NULL, NULL, NULL),
(4, 'Floresta', 1, 0, 'Uma floresta densa e vibrante, onde o som dos pássaros e o farfalhar das folhas criam uma melodia serena. Recursos valiosos e segredos aguardam entre as árvores sombrias.', 1, 6, 8, 15, NULL, NULL),
(5, 'Praça da Vila', 1, 0, 'O coração da vila, cercado por jardins coloridos e bancos confortáveis. É o lugar perfeito para festivais, encontros e compartilhar histórias com os moradores.', 1, 9, 13, 12, 11, 10),
(6, 'Guilda dos Aventureiros', 1, 0, 'Um refúgio para os bravos. Aqui, aventureiros se reúnem para relatar suas conquistas, comprar equipamentos e aceitar novos desafios.', 4, NULL, NULL, NULL, NULL, NULL),
(7, 'Comércio do Deserto', 1, 0, 'Um mercado exótico no meio do deserto, onde mercadores misteriosos vendem itens raros e valiosos.', 8, NULL, NULL, NULL, NULL, NULL),
(8, 'Deserto', 1, 0, 'Um vasto mar de areia escaldante, onde o vento sopra histórias antigas e tesouros esquecidos podem ser desenterrados.', 7, 4, NULL, NULL, NULL, NULL),
(9, 'Centro Comunitário', 1, 0, 'Um edifício abandonado com um charme nostálgico. Restaurá-lo trará benefícios para toda a vila.', 14, 5, NULL, NULL, NULL, NULL),
(10, 'Praia', 1, 0, 'Uma orla tranquila, onde as ondas acariciam a areia. É o lugar perfeito para pescar, relaxar ou encontrar tesouros marítimos.', 5, NULL, NULL, NULL, NULL, NULL),
(11, 'Armazém do Pierre', 1, 0, 'O local favorito dos moradores para adquirir sementes, alimentos frescos e outros suprimentos agrícolas.', 5, NULL, NULL, NULL, NULL, NULL),
(12, 'Clínica do Harvey', 1, 0, 'Um pequeno consultório médico onde Harvey cuida da saúde dos moradores com atenção e dedicação.', 5, NULL, NULL, NULL, NULL, NULL),
(13, 'Ferreiro', 1, 0, 'Um local quente e barulhento onde ferramentas ganham vida e minérios são transformados em itens essenciais.', 5, NULL, NULL, NULL, NULL, NULL),
(14, 'Mercado Joja', 1, 0, 'Uma megaloja moderna e impessoal, onde tudo está à venda... ao custo do espírito comunitário.', 9, NULL, NULL, NULL, NULL, NULL);
(15, 'Caverna', 1, 0, 'As paredes são cobertas por musgo e pequenas pedras brilham na escuridão. Um lugar ideal para começar a coletar minérios.', 4, NULL, NULL, NULL, NULL, NULL);

INSERT INTO Caverna (andar, fk_id_ambiente, quantidade_mobs, qtd_minerio, fk_id_minerio_item, fk_item_recompensa)
VALUES -- fk_minerio_item e fk_item_recompensa com números aleatórios
(1, 15, 5, 8, 1, 10), 
(2, 15, 7, 12, 2, 11),
(3, 15, 10, 15, 3, 12),
(4, 15, 12, 20, 4, 13),
(5, 15, 15, 25, 5, 14),
(6, 15, 8, 10, 6, 15);

INSERT INTO loja (id_loja, nome, proprietario, fk_id_ambiente, fk_id_estoque)
VALUES --fk_id_estoque com números aleatórios
(1, 'Armazém do Pierre', 'Pierre', 11, 1),
(2, 'Mercado Joja', 'Gerente Joja', 14, 2),
(3, 'Ferreiro', 'Clint', 13, 3), 
(5, 'Comércio do Deserto', 'Sandy', 7, 5);

INSERT INTO Missao (id_missao, tipo)
VALUES
(1, 'Coleta de Recursos'), -- Missão para coletar itens específicos, como madeira ou minério
(2, 'Derrotar Mobs'), -- Eliminar uma quantidade específica de inimigos
(3, 'Cultivo de Plantas'), -- Plantar, cultivar e colher culturas específicas
(4, 'Exploração de Caverna'), -- Explorar níveis da caverna e coletar recompensas