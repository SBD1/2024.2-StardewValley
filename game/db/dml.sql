
-- Inserir uma habilidade básica
INSERT INTO Habilidade (id_habilidade, tipo)
VALUES
    (1, 'mineracao'),
    (2, 'mineracao'),
    (3, 'mineracao'),
    (4, 'mineracao'),
    (5, 'mineracao'),
    (6, 'mineracao'),
    (7, 'mineracao'),
    (8, 'mineracao'),
    (9, 'mineracao'),
    (10, 'mineracao'),
    (11, 'combate'),
    (12, 'combate'),
    (13, 'combate'),
    (14, 'combate'),
    (15, 'combate'),
    (16, 'combate'),
    (17, 'combate'),
    (18, 'combate'),
    (19, 'combate'),
    (20, 'combate'),
    (21, 'cultivo'),
    (22, 'cultivo'),
    (23, 'cultivo'),
    (24, 'cultivo'),
    (25, 'cultivo'),
    (26, 'cultivo'),
    (27, 'cultivo'),
    (28, 'cultivo'),
    (29, 'cultivo'),
    (30, 'cultivo');

-- Inserir registros relacionados nas tabelas habMineracao, habCombate e habCultivo
INSERT INTO habMineracao (fk_Habilidade_id, reducaoEnergiaMinera, minerioBonus, nivel, xpMin, xpMax)
VALUES
    (1, 0, 0, 1, 0, 100),
    (2, 2, 0, 2, 101, 200),
    (3, 4, 0, 3, 201, 300),
    (4, 6, 0, 4, 301, 400),
    (5, 8, 1, 5, 401, 500),
    (6, 10, 1, 6, 501, 600),
    (7, 12, 1, 7, 601, 700),
    (8, 14, 1, 8, 701, 800),
    (9, 16, 1, 9, 801, 900),
    (10, 18, 2, 10, 901, 1000);

-- Preencher habCombate com os valores correspondentes
INSERT INTO habCombate (fk_Habilidade_id, vidaBonus, danoBonus, nivel, xpMin, xpMax)
VALUES
    (11, 0, 0, 1, 0, 100),
    (12, 5, 1, 2, 101, 200),
    (13, 10, 2, 3, 201, 300),
    (14, 15, 3, 4, 301, 400),
    (15, 20, 4, 5, 401, 500),
    (16, 25, 5, 6, 501, 600),
    (17, 30, 6, 7, 601, 700),
    (18, 35, 7, 8, 701, 800),
    (19, 40, 8, 9, 801, 900),
    (20, 45, 9, 10, 901, 1000);

-- Preencher habCultivo com os valores correspondentes
INSERT INTO habCultivo (fk_Habilidade_id, cultivoBonus, reducaoEnergiaCultiva, nivel, xpMin, xpMax)
VALUES
    (21, 0, 0, 1, 0, 100),
    (22, 0, 2, 2, 101, 200),
    (23, 0, 4, 3, 201, 300),
    (24, 0, 6, 4, 301, 400),
    (25, 0, 8, 5, 401, 500),
    (26, 1, 10, 6, 501, 600),
    (27, 1, 12, 7, 601, 700),
    (28, 1, 14, 8, 701, 800),
    (29, 1, 16, 9, 801, 900),
    (30, 2, 18, 10, 901, 1000);

INSERT INTO Jogador (id_jogador, nome, fk_habMineracao_fk_Habilidade_id, fk_habCombate_fk_Habilidade_id, fk_habCultivo_fk_Habilidade_id)
VALUES
    (0, 'teste', 1, 11, 21);

INSERT INTO Animal (id_animal, nome_animal, diasTotalDropar, tipo_animal, itemDrop, preco)
VALUES
    (1, 'vaca', 7, 'vaca', 14, 50),
    (2, 'galinha', 3, 'galinha', 13, 30),
    (3, 'porco', 5, 'porco', 3, 40);--mudar o item  para o id do carne!!! 

INSERT INTO inimigo (id_inimigo, nome, tipo, vidaMax, dano) VALUES
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

INSERT INTO Mapa (id_mapa, nome) VALUES
    (1, 'mundo');

INSERT INTO Ambiente (id_ambiente, tipo, nome, fk_id_mapa, fk_jogador_id, descricao, transitar_1, transitar_2, transitar_3, transitar_4, transitar_5, transitar_6) VALUES
    (1, 'CasaJogador','Cabana', 1, 0, 'Casa de troncos herdada pelo seu avô. Um lugar aconchegante para descansar após um longo dia de trabalho.', 2, 3, 4, 5, NULL, NULL),
    (2, 'Plantação', 'Plantação', 1, NULL, 'Uma vasta área de terra cercada por montanhas. Aqui, você pode plantar sementes.', 1, NULL, NULL, NULL, NULL, NULL),
    (3, 'Celeiro', 'Celeiro', 1, NULL, 'Um amplo celeiro de madeira com cheiro de feno fresco.', 1, NULL, NULL, NULL, NULL, NULL),
    (4, 'Normal', 'Floresta', 1, NULL, 'Uma floresta densa e vibrante, onde o som dos pássaros e o farfalhar das folhas criam uma melodia serena. Recursos valiosos e segredos aguardam entre as árvores sombrias.', 1, 6, 8, 15, NULL, NULL),
    (5, 'Normal','Praça da Vila', 1, NULL, 'O coração da vila, cercado por jardins coloridos e bancos confortáveis. É o lugar perfeito para festivais, encontros e compartilhar histórias com os moradores.', 1, 9, 13, 12, 11, 10),
    (6, 'Loja','Guilda dos Aventureiros', 1, NULL, 'Um refúgio para os bravos. Aqui, aventureiros se reúnem para relatar suas conquistas, comprar equipamentos e aceitar novos desafios.', 4, NULL, NULL, NULL, NULL, NULL),
    (7, 'Loja','Comércio do Deserto', 1, NULL, 'Um mercado exótico no meio do deserto, onde mercadores misteriosos vendem itens raros e valiosos.', 8, NULL, NULL, NULL, NULL, NULL),
    (8, 'Normal','Deserto', 1, NULL, 'Um vasto mar de areia escaldante, onde o vento sopra histórias antigas e tesouros esquecidos podem ser desenterrados.', 7, 4, NULL, NULL, NULL, NULL),
    (9, 'Normal','Centro Comunitário', 1, NULL, 'Um edifício abandonado com um charme nostálgico. Restaurá-lo trará benefícios para toda a vila.', 14, 5, NULL, NULL, NULL, NULL),
    (10, 'Normal','Praia', 1, NULL, 'Uma orla tranquila, onde as ondas acariciam a areia. É o lugar perfeito para pescar, relaxar ou encontrar tesouros marítimos.', 5, NULL, NULL, NULL, NULL, NULL),
    (11, 'Loja', 'Armazém do Pierre', 1, NULL, 'O local favorito dos moradores para adquirir sementes, alimentos frescos e outros suprimentos agrícolas.', 5, NULL, NULL, NULL, NULL, NULL),
    (12, 'Normal', 'Clínica do Harvey', 1, NULL, 'Um pequeno consultório médico onde Harvey cuida da saúde dos moradores com atenção e dedicação.', 5, NULL, NULL, NULL, NULL, NULL),
    (13, 'Loja', 'Ferreiro', 1, NULL, 'Um local quente e barulhento onde ferramentas ganham vida e minérios são transformados em itens essenciais.', 5, NULL, NULL, NULL, NULL, NULL),
    (14, 'Loja', 'Mercado Joja', 1, NULL, 'Uma megaloja moderna e impessoal, onde tudo está à venda... ao custo do espírito comunitário.', 9, NULL, NULL, NULL, NULL, NULL),
    (15, 'Caverna', 'Caverna', 1, NULL, 'As paredes são cobertas por musgo e pequenas pedras brilham na escuridão. Um lugar ideal para começar a coletar minérios',  4, 16,   NULL, NULL, NULL, NULL),
    (16, 'Caverna', 'Andar 1', 1, NULL, 'O ar torna-se mais úmido, com estalactites pendendo do teto e o som distante de gotas de água ecoando. Rochas raras começam a aparecer', 15, 17,   NULL, NULL, NULL, NULL),
    (17, 'Caverna', 'Andar 2', 1, NULL, 'A iluminação natural diminui, revelando cristais luminescentes que iluminam o caminho. Inimigos mais desafiadores espreitam nas sombras.', 16, 18,   NULL, NULL, NULL, NULL),
    (18, 'Caverna', 'Andar 3', 1, NULL, 'ma camada de gelo cobre o chão, e o ar é frio o suficiente para ver sua respiração. Inimigos gelados patrulham este nível.', 17, 19,   NULL, NULL, NULL, NULL),
    (19, 'Caverna', 'Andar 4', 1, NULL, 'Formações rochosas complexas e minerais valiosos são abundantes aqui. O ambiente é silencioso, mas a sensação de ser observado é constante.', 18, 20,   NULL, NULL, NULL, NULL),
    (20, 'Caverna', 'Andar 5', 1, NULL, 'Poças de lava iluminam o ambiente com um brilho avermelhado. O calor é intenso, e criaturas flamejantes guardam os tesouros deste andar.', 19, 21,   NULL, NULL, NULL, NULL),
    (21, 'Caverna', 'Andar 6', 1, NULL, 'Uma escuridão profunda envolve tudo, quebrada apenas por minerais raros que emitem uma luz própria. Apenas os aventureiros mais corajosos chegam tão longe.', 20, NULL, NULL, NULL, NULL, NULL);

INSERT INTO loja (id_loja, nome, proprietario, fk_id_ambiente)
VALUES --fk_id_estoque com números aleatórios
(1, 'Armazém do Pierre', 'Pierre', 11),
(2, 'Mercado Joja', 'Gerente Joja', 14),
(3, 'Ferreiro', 'Clint', 13), 
(5, 'Comércio do Deserto', 'Sandy', 7);

INSERT INTO estoque(id_estoque, fk_id_loja) VALUES
    (1, 1),
    (2, 2),
    (3, 3),
    (5, 5);

UPDATE loja
SET fk_id_estoque = (SELECT id_estoque FROM estoque WHERE fk_id_loja = loja.id_loja);

-- Adicione as restrições de FK
ALTER TABLE loja
    ADD CONSTRAINT fk_loja_estoque FOREIGN KEY (fk_id_estoque) REFERENCES estoque(id_estoque);

ALTER TABLE estoque
    ADD CONSTRAINT fk_estoque_loja FOREIGN KEY (fk_id_loja) REFERENCES loja(id_loja);

ALTER TABLE item
    ADD CONSTRAINT fk_item_estoque FOREIGN KEY (fk_estoque) REFERENCES estoque(id_estoque),
    ADD CONSTRAINT fk_item_inventario FOREIGN KEY (fk_inventario_id) REFERENCES inventario(id_inventario);

INSERT INTO item (id_item, tipo_item, fk_estoque, fk_inventario_id) VALUES
(1, 'consumivel', 1, NULL),
(2, 'consumivel', 1, NULL),
(3, 'consumivel', 1, NULL),
(4, 'consumivel', 1, NULL),
(5, 'consumivel', 1, NULL),
(6, 'consumivel', 1, NULL),
(7, 'consumivel', 1, NULL),
(8, 'consumivel', 1, NULL),
(9, 'consumivel', 1, NULL),
(10, 'consumivel', 1, NULL),
(11, 'consumivel', 1, NULL),
(12, 'consumivel', 1, NULL),
(13, 'consumivel', 1, NULL),
(14, 'consumivel', 1, NULL),
(15, 'consumivel', 1, NULL),
(16, 'consumivel', 1, NULL),
(17, 'consumivel', 1, NULL),
(18, 'consumivel', 1, NULL),
(19, 'consumivel', 1, NULL),
(20, 'consumivel', 1, NULL),
(21, 'consumivel', 1, NULL),
(22, 'consumivel', 1, NULL),
(23, 'consumivel', 1, NULL),
(24, 'consumivel', 1, NULL),
(25, 'consumivel', 1, NULL),
(26, 'consumivel', 1, NULL),
(27, 'consumivel', 1, NULL),
(28, 'consumivel', 1, NULL),
(29, 'mineral', 1, NULL),
(30, 'mineral', 1, NULL),
(31, 'mineral', 1, NULL),
(32, 'mineral', 1, NULL),
(33, 'mineral', 1, NULL),
(34, 'mineral', 1, NULL),
(35, 'mineral', 1, NULL),
(36, 'mineral', 1, NULL),
(37, 'mineral', 1, NULL),
(38, 'mineral', 1, NULL),
(39, 'mineral', 1, NULL),
(40, 'mineral', 1, NULL),
(41, 'mineral', 1, NULL),
(42, 'mineral', 1, NULL),
(43, 'mineral', 1, NULL),
(44, 'mineral', 1, NULL),
(45, 'recurso', 1, NULL),
(46, 'recurso', 1, NULL),
(47, 'recurso', 1, NULL),
(48, 'recurso', 1, NULL),
(49, 'recurso', 1, NULL),
(50, 'recurso', 1, NULL),
(51, 'recurso', 1, NULL),
(52, 'recurso', 1, NULL),
(53, 'recurso', 1, NULL),
(54, 'mineral', 1, NULL),
(55, 'mineral', 1, NULL),
(56, 'mineral', 1, NULL),

-- Armas
(729, 'arma', 3, NULL),
(730, 'arma', 3, NULL),
(731, 'arma', 3, NULL),
(732, 'arma', 3, NULL),
(733, 'arma', 3, NULL),
(734, 'arma', 3, NULL),
(735, 'arma', 3, NULL),
(736, 'arma', 3, NULL),
(737, 'arma', 3, NULL),
(738, 'arma', 3, NULL),
(739, 'arma', 3, NULL),
(740, 'arma', 3, NULL),
(741, 'arma', 3, NULL),
(742, 'arma', 3, NULL),
(743, 'arma', 3, NULL),
(744, 'arma', 3, NULL),
(745, 'arma', 3, NULL),
(746, 'arma', 3, NULL),
(747, 'arma', 3, NULL),
(748, 'arma', 3, NULL),
(749, 'arma', 3, NULL),
(750, 'arma', 3, NULL),
(751, 'arma', 3, NULL),
(752, 'arma', 3, NULL),
(753, 'arma', 3, NULL),
(754, 'arma', 3, NULL),
(755, 'arma', 3, NULL),

(601, 'ferramenta',3,NULL),
(602, 'ferramenta',3,NULL),
(603, 'ferramenta',3,NULL),
(604, 'ferramenta',3,NULL),
(605, 'ferramenta',3,NULL),
(606, 'ferramenta',3,NULL),
(607, 'ferramenta',3,NULL),
(608, 'ferramenta',3,NULL),
(609, 'ferramenta',3,NULL),
(610, 'ferramenta',3,NULL),
(611, 'ferramenta',3,NULL),
(612, 'ferramenta',3,NULL),
(613, 'ferramenta',3,NULL),
(614, 'ferramenta',3,NULL),
(615, 'ferramenta',3,NULL),
(616, 'ferramenta',3,NULL),
(617, 'ferramenta',3,NULL),
(618, 'ferramenta',3,NULL),
(619, 'ferramenta',3,NULL),
(620, 'ferramenta',3,NULL),
(621, 'ferramenta',3,NULL),
(622, 'ferramenta',3,NULL),
(623, 'ferramenta',3,NULL),
(624, 'ferramenta',3,NULL),
(625, 'ferramenta',3,NULL),
(626, 'ferramenta',3,NULL),
(627, 'ferramenta',3,NULL),
(628, 'ferramenta',3,NULL),

(629, 'arma',3,NULL),
(630, 'arma',3,NULL),
(631, 'arma',3,NULL),
(632, 'arma',3,NULL),
(633, 'arma',3,NULL),
(634, 'arma',3,NULL),
(635, 'arma',3,NULL),
(636, 'arma',3,NULL),
(637, 'arma',3,NULL),
(638, 'arma',3,NULL),
(639, 'arma',3,NULL),
(640, 'arma',3,NULL),
(641, 'arma',3,NULL),
(642, 'arma',3,NULL),
(643, 'arma',3,NULL),
(644, 'arma',3,NULL),
(645, 'arma',3,NULL),
(646, 'arma',3,NULL),
(647, 'arma',3,NULL),
(648, 'arma',3,NULL),
(649, 'arma',3,NULL),
(650, 'arma',3,NULL),
(651, 'arma',3,NULL),
(652, 'arma',3,NULL),
(653, 'arma',3,NULL),
(654, 'arma',3,NULL),
(655, 'arma',3,NULL);   

INSERT INTO utensilio (id_item, tipo_utensilio) VALUES
(601, 'ferramenta'),
(602, 'ferramenta'),
(603, 'ferramenta'),
(604, 'ferramenta'),
(605, 'ferramenta'),
(606, 'ferramenta'),
(607, 'ferramenta'),
(608, 'ferramenta'),
(609, 'ferramenta'),
(610, 'ferramenta'),
(611, 'ferramenta'),
(612, 'ferramenta'),
(613, 'ferramenta'),
(614, 'ferramenta'),
(615, 'ferramenta'),
(616, 'ferramenta'),
(617, 'ferramenta'),
(618, 'ferramenta'),
(619, 'ferramenta'),
(620, 'ferramenta'),
(621, 'ferramenta'),
(622, 'ferramenta'),
(623, 'ferramenta'),
(624, 'ferramenta'),
(625, 'ferramenta'),
(626, 'ferramenta'),
(627, 'ferramenta'),
(628, 'ferramenta'),
(629, 'arma'),
(630, 'arma'),
(631, 'arma'),
(632, 'arma'),
(633, 'arma'),
(634, 'arma'),
(635, 'arma'),
(636, 'arma'),
(637, 'arma'),
(638, 'arma'),
(639, 'arma'),
(640, 'arma'),
(641, 'arma'),
(642, 'arma'),
(643, 'arma'),
(644, 'arma'),
(645, 'arma'),
(646, 'arma'),
(647, 'arma'),
(648, 'arma'),
(649, 'arma'),
(650, 'arma'),
(651, 'arma'),
(652, 'arma'),
(653, 'arma'),
(654, 'arma'),
(655, 'arma');

-- INSERT INTO ferramenta (id_item, fk_id_utensilio, nome, descricao, eficiencia, nivel) VALUES
-- (701, 601, 'Enxada Comum', 'Cavar e arar o solo', 1, 1),
-- (702, 602, 'Enxada de Cobre', 'Cavar e arar o solo', 2, 2),
-- (703, 603, 'Enxada de Aço', 'Cavar e arar o solo', 3, 3),
-- (704, 604, 'Enxada de Ouro', 'Cavar e arar o solo', 4, 4),
-- (705, 605, 'Enxada de Irídio', 'Cavar e arar o solo', 5, 5),
-- (706, 606, 'Picareta Comum', 'Quebrar pedras', 1, 1),
-- (707, 607, 'Picareta de Cobre', 'Quebrar pedras', 2, 2),
-- (708, 608, 'Picareta de Aço', 'Quebrar pedras', 3, 3),
-- (709, 609, 'Picareta de Ouro', 'Quebrar pedras', 4, 4),
-- (710, 610, 'Picareta de Irídio', 'Quebrar pedras', 5, 5),
-- (711, 611, 'Machado Comum', 'Cortar madeira', 1, 1),
-- (712, 612, 'Machado de Cobre', 'Cortar madeira', 2, 2),
-- (713, 613, 'Machado de Aço', 'Cortar madeira', 3, 3),
-- (714, 614, 'Machado de Ouro', 'Cortar madeira', 4, 4),
-- (715, 615, 'Machado de Irídio', 'Cortar madeira', 5, 5),
-- (716, 616, 'Regador Comum', 'Regar plantas', 1, 1),
-- (717, 617, 'Regador de Cobre', 'Regar plantas', 2, 2),
-- (718, 618, 'Regador de Aço', 'Regar plantas', 3, 3),
-- (719, 619, 'Regador de Ouro', 'Regar plantas', 4, 4),
-- (720, 620, 'Regador de Irídio', 'Regar plantas', 5, 5),
-- (721, 621, 'Lixeira de Comum', 'Deletar itens do Inventário', 1, 1),
-- (722, 622, 'Lixeira de Cobre', 'Deletar itens do Inventário', 2, 2),
-- (723, 623, 'Lixeira de Aço', 'Deletar itens do Inventário', 2, 2),
-- (724, 624, 'Lixeira de Ouro', 'Deletar itens do Inventário', 3, 3),
-- (725, 625, 'Lixeira de Irídio', 'Deletar itens do Inventário', 4, 4);
-- (726, 626, 'Balde de Leite', 'Coletar Leite de cabra ou vaca', 2, 1),
-- (727, 627, 'Mochila tamanho 25', '12 espaços disponíveis', 12, 1),
-- (728, 628, 'Mochila tamanho 36', '12 espaços disponíveis', 24, 2);

-- INSERT INTO arma (id_item, fk_id_utensilio, nome, descricao, dano) VALUES
-- (729, 629, 'Espada enferrujada', 'Uma espada enferrujada e cega', 2),
-- (730, 630, 'Espada de madeira', 'Nada mal para um pedaço de madeira.', 5),
-- (731, 631, 'Espada de aço', 'Uma espada padrão.', 6),
-- (732, 632, 'Sabre de prata', 'Folheado com prata para reduzir a ferrugem.', 11),
-- (733, 633, 'Espada de pirata', 'Parece que um pirata a possuía.', 11),
-- (734, 634, 'Sabre', 'Um sabre muito bem feito.', 10),
-- (735, 635, 'Espada da Floresta', 'Feita poderosa mágica da floresta.', 13),
-- (736, 636, 'Lâmina de ferro', 'Uma espada pesada.', 18),
-- (737, 637, 'Cabeça de inseto', 'Não muito agradável de segurar.', 15),
-- (738, 638, 'Gládio de Netuno', 'Herança de além do Mar de Joias.', 27),
-- (739, 639, 'Espada Escocesa', 'É muito pesada.', 26),
-- (740, 640, 'Espada do templário', 'Já pertenceu a um honrado cavaleiro.', 25),
-- (741, 641, 'Espada de ossos', 'Muito leve. Feita de osso polido.', 25),
-- (742, 642, 'Lâmina Ossificada', 'Uma lâmina grande e afiada formada por ossos.', 34),
-- (743, 643, 'Espada de Obsidiana', 'Incrivelmente afiada.', 38),
-- (744, 644, 'Dentes de iete', 'Muito frios ao toque.', 34),
-- (745, 645, 'Espada temperada', 'Parece aguentar qualquer impacto.', 36),
-- (746, 646, 'Cimitarra de metal', 'Leve e poderosa.', 37),
-- (747, 647, 'Espada das trevas', 'Brilha com uma energia misteriosa.', 38),
-- (748, 648, 'Katana de lava', 'Uma lâmina poderosa, forjada em uma piscina de lava.', 60),
-- (749, 649, 'Espada Anã', 'É antiga, mas a lâmina nunca desgasta.', 70),
-- (750, 650, 'Espada da galáxia', 'Diferente de tudo que você já viu.', 70),
-- (751, 651, 'Espada de Dente de Dragão', 'A lâmina foi forjada de um dente mágico.', 83),
-- (752, 652, 'Lâmina do Infinito', 'A verdadeira forma da Espada da Galáxia.', 90),
-- (753, 653, 'Espada sagrada', 'Dá esperança ao segurar.', 23),
-- (754, 654, 'Ferro de passar da Haley', 'Muito quente. Está com cheiro de cabelo da Haley.', 38),
-- (755, 655, 'Cinzel da Leah', 'A ferramenta favorita da Leah para esculpir madeira.', 38);

INSERT INTO Missao (id_missao, tipo)
VALUES
-- (1, 'Coleta de Recursos'), -- Missão para coletar itens específicos, como madeira ou minério
-- (2, 'Derrotar Mobs'), -- Eliminar uma quantidade específica de inimigos
-- (3, 'Cultivo de Plantas'), -- Plantar, cultivar e colher culturas específicas
-- (4, 'Exploração de Caverna'); -- Explorar níveis da caverna e coletar recompensas
(1,'combate'),
(2,'combate'),
(3,'combate'),
(4,'combate'),
(5,'combate'),
(6,'combate'),
(7,'combate'),
(8,'combate'),
(9,'coleta'),
(10,'coleta'),
(11,'coleta'),
(12,'coleta'),
(13,'coleta'),
(14,'coleta'),
(15,'coleta'),
(16,'coleta');


INSERT INTO consumivel (id_item, nome, descricao, efeito_vida) VALUES
(1, 'Chirívia', 'Uma raiz crocante e ligeiramente doce.', 25),
(2, 'Batata', 'Tubérculo redondo e versátil.', 30),
(3, 'Couve', 'Vegetal verde e rico em nutrientes.', 35),
(4, 'Alho', 'Bulbo picante com diversos usos.', 20),
(5, 'Tomate', 'Fruta vermelha suculenta.', 25),
(6, 'Melão', 'Fruta grande e doce.', 50),
(7, 'Mirtilo', 'Pequena baga azul cheia de sabor.', 15),
(8, 'Oxicoco', 'Fruta vermelha ácida e rara.', 20),
(9, 'Abóbora', 'Grande vegetal laranja.', 40),
(10, 'Coco', 'Fruta tropical com polpa cremosa.', 35),
(11, 'Maçã', 'Fruta crocante e doce.', 25),
(12, 'Damasco', 'Fruta laranja e macia.', 20),
(13, 'Ovo', 'Fonte básica de proteína.', 15),
(14, 'Leite', 'Líquido cremoso e nutritivo.', 25),
(15, 'Queijo', 'Laticínio envelhecido e saboroso.', 35),
(16, 'Maionese', 'Condimento cremoso.', 20),
(17, 'Café', 'Bebida energizante.', 10),
(18, 'Pão', 'Carboidrato assado e básico.', 20),
(19, 'Ovo frito', 'Ovo cozido na frigideira.', 25),
(20, 'Panquecas', 'Prato doce e macio.', 35),
(21, 'Tortilha', 'Pão achatado e simples.', 20),
(22, 'Omelete', 'Mistura de ovos e outros ingredientes.', 30),
(23, 'Sorvete', 'Sobremesa gelada e doce.', 25),
(24, 'Hambúrguer de Sobrevivência', 'Refeição nutritiva para emergências.', 50),
(25, 'Refeição de Mineiro', 'Alimento energético para mineradores.', 45),
(26, 'Café Expresso Triplo', 'Café mais forte para energia extra.', 30),
(27, 'Cenoura subterrânea', 'Raiz nutritiva encontrada no subsolo.', 25),
(28, 'Peixe', 'Fonte rica de proteínas.', 30);

-- INSERT INTO Semente (id_semente, nome, descricao, diaAtual, prontoColher, id_item, fk_instancia_planta_id) VALUES
-- (1, 'Semente de Chirívia', 'Semente que cresce em Chirívia.', 0, FALSE, 1, NULL),
-- (2, 'Semente de Batata', 'Semente que cresce em Batata.', 0, FALSE, 2, NULL),
-- (3, 'Semente de Couve', 'Semente que cresce em Couve.', 0, FALSE, 3, NULL),
-- (4, 'Semente de Alho', 'Semente que cresce em Alho.', 0, FALSE, 4, NULL),
-- (5, 'Semente de Tomate', 'Semente que cresce em Tomate.', 0, FALSE, 5, NULL),
-- (6, 'Semente de Melão', 'Semente que cresce em Melão.', 0, FALSE, 6, NULL),
-- (7, 'Semente de Mirtilo', 'Semente que cresce em Mirtilo.', 0, FALSE, 7, NULL),
-- (8, 'Semente de Oxicoco', 'Semente que cresce em Oxicoco.', 0, FALSE, 8, NULL),
-- (9, 'Semente de Abóbora', 'Semente que cresce em Abóbora.', 0, FALSE, 9, NULL),
-- (10, 'Semente de Coco', 'Semente que cresce em Coco.', 0, FALSE, 10, NULL);

INSERT INTO mineral (id_item, nome, descricao, resistencia, preco) VALUES
(29, 'Pedra', 'Um material de construção básico.', 10, 2.00),
(30, 'Bronze', 'Um metal utilizado em ferramentas.', 20, 15.00),
(31, 'Ferro', 'Metal resistente e versátil.', 30, 25.00),
(32, 'Ouro', 'Metal precioso e valioso.', 40, 50.00),
(33, 'Fragmento Prismatico', 'Um raro cristal multicolorido.', 50, 200.00),
(34, 'Água Marinha', 'Uma gema azul-esverdeada brilhante.', 35, 80.00),
(35, 'Carvão', 'Material utilizado para fundição.', 15, 10.00),
(36, 'Rubi', 'Uma gema vermelha reluzente.', 45, 150.00),
(37, 'Jade', 'Uma pedra preciosa verde.', 40, 120.00),
(38, 'Ametista', 'Uma gema roxa brilhante.', 35, 100.00),
(39, 'Esmeralda', 'Uma gema verde de rara beleza.', 50, 180.00),
(54, 'Madeira', 'Material básico de construção.', 5, 2.00),
(55, 'Diamante', 'Uma gema preciosa e brilhante.', 60, 300.00),
(56, 'Madeira de Lei', 'Um tipo de madeira mais resistente.', 20, 20.00);

INSERT INTO Caverna (andar, fk_id_ambiente, quantidade_mobs, qtd_minerio, fk_id_minerio_item, fk_id_item_recompensa) VALUES
    (1, 15, 10, 5, 29, 10);
    (2, 16,  5, 5, 31, 2),
    (3, 17,  2, 5, 32, 3),
    (4, 18,  4, 5, 33, 4),
    (5, 19,  3, 3, 34, 5),
    (6, 20, 10, 5, 35, 6),
    (7, 21,  8, 5, 36, 7);

INSERT INTO Instancia_de_Inimigo (vidaAtual, fk_Caverna_andar, fk_inimigo_id) VALUES
(100, 1, 1),
(100, 2, 2),
(100, 3, 4);

INSERT INTO recurso (id_item, nome, descricao, preco) VALUES
(40, 'Quartzo', 'Um cristal translúcido muito comum.', 25.00),
(41, 'Cristal de terra', 'Um cristal com impurezas de terra.', 40.00),
(42, 'Lágrima congelada', 'Uma gema azul brilhante e gelada.', 75.00),
(43, 'Quartzo de fogo', 'Cristal com tons de vermelho e calor.', 80.00),
(44, 'Fragmentos de estrela', 'Um raro fragmento com brilho celestial.', 200.00),
(45, 'Disco raro', 'Um raro disco para tocar músicas lendárias.', 2.00),
(46, 'Pedra de fada', 'Uma pedra encantada com aura mágica.', 125.00),
(47, 'Obsidiana', 'Rocha negra com bordas afiadas.', 100.00),
(48, 'Geodo', 'Rochas que podem conter minerais no interior.', 50.00),
(49, 'Geodo congelado', 'Geodo formado em ambientes gelados.', 75.00),
(50, 'Geodo de magma', 'Geodo encontrado em áreas vulcânicas.', 100.00),
(51, 'Omnigeodo', 'Um geodo raro com diversos minerais.', 150.00),
(52, 'Tecido', 'Material flexível usado em artesanato.', 50.00),
(53, 'Ovo de dinossauro', 'Um ovo de um dinossauro pré histórico', 200.00);

INSERT INTO missao_combate (fk_id_missao, fk_id_Inimigo, nome, descricao, dataInicio)
VALUES 
(1, 6, 'Iniciação', 'Derrote 10 Slimes Escuros para entrar na Guilda dos Aventureiros.', 1),  
(2, 6, 'Precisa-se de Ajuda: Slimes Escuros', 'Elimine 20 Slimes Escuros.', 10), 
(3, 5, 'Precisa-se de Ajuda: Fantasmas Errantes', 'Derrote 15 Fantasmas Errantes nas cavernas.', 25), 
(4, 5, 'Precisa-se de Ajuda: Fantasmas Errantes', 'Elimine 5 Fantasmas Errantes.', 42), 
(5, 2, 'Precisa-se de Ajuda: Aranhas das Sombras', 'Derrote 30 Aranhas das Sombras.', 78), 
(6, 6, 'Precisa-se de Ajuda: Slimes Escuros', 'Elimine 10 Slimes Escuros.', 91), 
(7, 1, 'Precisa-se de Ajuda: Morcegos da Caverna', 'Derrote 25 Morcegos da Caverna na caverna.', 120), 
(8,  5, 'Precisa-se de Ajuda: Fantasmas Errantes', 'Elimine 40 Fantasmas Errantes no deserto.', 155); 

INSERT INTO missao_coleta (fk_id_missao, fk_id_minerio, nome, descricao, dataInicio)
VALUES 
(9, 30, 'Precisa-se de Ajuda: Bronze', 'Colete 20 unidades de Bronze para Clint.', 5), 
(10, 31, 'Precisa-se de Ajuda: Ferro', 'Colete 40 unidades de Ferro para Clint.', 18), 
(11, 32, 'Precisa-se de Ajuda: Ouro', 'Colete 30 unidades de Ouro para Clint.', 33), 
(12, 54, 'Precisa-se de Ajuda: Madeira', 'Colete 50 unidades de Madeira para Robin.', 48), 
(13, 29, 'Precisa-se de Ajuda: Pedra', 'Colete 75 unidades de Pedra para Robin.', 62), 
(14, 35, 'Precisa-se de Ajuda: Carvão', 'Colete 25 unidades de Carvão para Clint.', 85), 
(15, 54, 'Precisa-se de Ajuda: Madeira', 'Colete 100 unidades de Madeira para Robin.', 105), 
(16, 55, 'Precisa-se de Ajuda: Diamante', 'Colete 10 Diamantes para Clint.', 135); 