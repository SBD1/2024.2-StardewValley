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

INSERT INTO item (id_item, tipo_item, fk_estoque_produto, fk_inventario_id) VALUES
(1, 'consumivel', 0, 0),
(2, 'consumivel', 0, 0),
(3, 'consumivel', 0, 0),
(4, 'consumivel', 0, 0),
(5, 'consumivel', 0, 0),
(6, 'consumivel', 0, 0),
(7, 'consumivel', 0, 0),
(8, 'consumivel', 0, 0),
(9, 'consumivel', 0, 0),
(10, 'consumivel', 0, 0),
(11, 'consumivel', 0, 0),
(12, 'consumivel', 0, 0),
(13, 'consumivel', 0, 0),
(14, 'consumivel', 0, 0),
(15, 'consumivel', 0, 0),
(16, 'consumivel', 0, 0),
(17, 'consumivel', 0, 0),
(18, 'consumivel', 0, 0),
(19, 'consumivel', 0, 0),
(20, 'consumivel', 0, 0),
(21, 'consumivel', 0, 0),
(22, 'consumivel', 0, 0),
(23, 'consumivel', 0, 0),
(24, 'consumivel', 0, 0),
(25, 'consumivel', 0, 0),
(26, 'consumivel', 0, 0),
(27, 'consumivel', 0, 0),
(28, 'consumivel', 0, 0),
(29, 'mineral', 0, 0),
(30, 'mineral', 0, 0),
(31, 'mineral', 0, 0),
(32, 'mineral', 0, 0),
(33, 'mineral', 0, 0),
(34, 'mineral', 0, 0),
(35, 'mineral', 0, 0),
(36, 'mineral', 0, 0),
(37, 'mineral', 0, 0),
(38, 'mineral', 0, 0),
(39, 'mineral', 0, 0),
(40, 'mineral', 0, 0),
(41, 'mineral', 0, 0),
(42, 'mineral', 0, 0),
(43, 'mineral', 0, 0),
(44, 'mineral', 0, 0),
(45, 'recurso', 0, 0),
(46, 'recurso', 0, 0),
(47, 'recurso', 0, 0),
(48, 'recurso', 0, 0),
(49, 'recurso', 0, 0),
(50, 'recurso', 0, 0),
(51, 'recurso', 0, 0),
(52, 'recurso', 0, 0),
(53, 'recurso', 0, 0),
(54, 'mineral', 0, 0),
(55, 'mineral', 0, 0),
(56, 'mineral', 0, 0);

INSERT INTO consumivel (fk_id_item, nome, descricao, efeito_vida) VALUES
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

INSERT INTO mineral (fk_id_item, nome, descricao, resistencia, preco) VALUES
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

INSERT INTO recurso (fk_id_item, nome, descricao, preco) VALUES
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
