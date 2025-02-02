
-- Inserir uma habilidade básica (tem 10 de cada tipo)
INSERT INTO Habilidade (tipo)
VALUES
    ('mineracao'),
    ('mineracao'),
    ('mineracao'),
    ('mineracao'),
    ('mineracao'),
    ('mineracao'),
    ('mineracao'),
    ('mineracao'),
    ('mineracao'),
    ('mineracao'),
    ('combate'),
    ('combate'),
    ('combate'),
    ('combate'),
    ('combate'),
    ('combate'),
    ('combate'),
    ('combate'),
    ('combate'),
    ('combate'),
    ('cultivo'),
    ('cultivo'),
    ('cultivo'),
    ('cultivo'),
    ('cultivo'),
    ('cultivo'),
    ('cultivo'),
    ('cultivo'),
    ('cultivo'),
    ('cultivo');

-- Inserir registros relacionados nas tabelas habMineracao, habCombate e habCultivo
-- TODO: Trigger pra inserir fk_Habilidade_id 
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
    (11,  0, 0,  1,   0,  100),
    (12,  5, 1,  2, 101,  200),
    (13, 10, 2,  3, 201,  300),
    (14, 15, 3,  4, 301,  400),
    (15, 20, 4,  5, 401,  500),
    (16, 25, 5,  6, 501,  600),
    (17, 30, 6,  7, 601,  700),
    (18, 35, 7,  8, 701,  800),
    (19, 40, 8,  9, 801,  900),
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

INSERT INTO Animal (nome_animal, diasTotalDropar, tipo_animal, itemDrop, preco)
VALUES
    ('vaca', 7, 'vaca', 14, 50),
    ('galinha', 3, 'galinha', 13, 30),
    ('porco', 5, 'porco', 3, 40);--mudar o item  para o id do carne!!! 

INSERT INTO inimigo (id_inimigo, nome, tipo, vidaMax, dano, xp_recompensa) VALUES
    (1, 'Morcego da Caverna',   'caverna', 20.0,  4, 120),
    (2, 'Aranha das Sombras',   'caverna', 20.0,  7,   5),
    (3, 'Golem de Pedras',      'caverna', 50.0, 16,  20),
    (4, 'Rato Gigante',         'caverna', 15.0,  3,   7),
    (5, 'Fantasma Errante',     'caverna', 20.0, 10,   8),
    (6, 'Slime Escuro',         'caverna', 30.0,  6,   3),
    (7, 'Escorpião Caverneiro', 'caverna', 25.0,  9,   9),
    (8, 'Serpente Rochosa',     'caverna', 45.0, 12,  13),
    (9, 'Fungo Venenoso',       'caverna',  5.0,  3,   4),
    (10, 'Lagarto Albino',      'caverna', 35.0,  7,  10);

INSERT INTO Ambiente(id_ambiente,tipo,nome,descricao,eh_casa,transitar_1,transitar_2,transitar_3,transitar_4,transitar_5,transitar_6)
VALUES
(1, 'CasaJogador','Cabana',
 'Casa de troncos herdada pelo seu avô. Um lugar aconchegante para descansar após um longo dia de trabalho.',
 TRUE,  -- É a casa do jogador
 2, 3, 4, 5, NULL, NULL),

(2, 'Plantação','Plantação',
 'Uma vasta área de terra cercada por montanhas. Aqui, você pode plantar sementes.',
 FALSE,
 1, NULL, NULL, NULL, NULL, NULL),

(3, 'Celeiro','Celeiro',
 'Um amplo celeiro de madeira com cheiro de feno fresco.',
 FALSE,
 1, NULL, NULL, NULL, NULL, NULL),

(4, 'Normal','Floresta',
 'Uma floresta densa e vibrante, onde o som dos pássaros e o farfalhar das folhas criam uma melodia serena. Recursos valiosos e segredos aguardam entre as árvores sombrias.',
 FALSE,
 1, 6, 8, 15, NULL, NULL),

(5, 'Normal','Praça da Vila',
 'O coração da vila, cercado por jardins coloridos e bancos confortáveis. É o lugar perfeito para festivais, encontros e compartilhar histórias com os moradores.',
 FALSE,
 1, 9, 13, 12, 11, 10),

(6, 'Loja','Guilda dos Aventureiros',
 'Um refúgio para os bravos. Aqui, aventureiros se reúnem para relatar suas conquistas, comprar equipamentos e aceitar novos desafios.',
 FALSE,
 4, NULL, NULL, NULL, NULL, NULL),

(7, 'Loja','Comércio do Deserto',
 'Um mercado exótico no meio do deserto, onde mercadores misteriosos vendem itens raros e valiosos.',
 FALSE,
 8, NULL, NULL, NULL, NULL, NULL),

(8, 'Normal','Deserto',
 'Um vasto mar de areia escaldante, onde o vento sopra histórias antigas e tesouros esquecidos podem ser desenterrados.',
 FALSE,
 7, 4, NULL, NULL, NULL, NULL),

(9, 'Normal','Centro Comunitário',
 'Um edifício abandonado com um charme nostálgico. Restaurá-lo trará benefícios para toda a vila.',
 FALSE,
 14, 5, NULL, NULL, NULL, NULL),

(10, 'Normal','Praia',
 'Uma orla tranquila, onde as ondas acariciam a areia. É o lugar perfeito para pescar, relaxar ou encontrar tesouros marítimos.',
 FALSE,
 5, NULL, NULL, NULL, NULL, NULL),

(11, 'Loja','Armazém do Pierre',
 'O local favorito dos moradores para adquirir sementes, alimentos frescos e outros suprimentos agrícolas.',
 FALSE,
 5, NULL, NULL, NULL, NULL, NULL),

(12, 'Normal','Clínica do Harvey',
 'Um pequeno consultório médico onde Harvey cuida da saúde dos moradores com atenção e dedicação.',
 FALSE,
 5, NULL, NULL, NULL, NULL, NULL),

(13, 'Loja','Ferreiro',
 'Um local quente e barulhento onde ferramentas ganham vida e minérios são transformados em itens essenciais.',
 FALSE,
 5, NULL, NULL, NULL, NULL, NULL),

(14, 'Loja','Mercado Joja',
 'Uma megaloja moderna e impessoal, onde tudo está à venda... ao custo do espírito comunitário.',
 FALSE,
 9, NULL, NULL, NULL, NULL, NULL),

(15, 'Caverna', 'Caverna',
 'As paredes são cobertas por musgo e pequenas pedras brilham na escuridão. Um lugar ideal para começar a coletar minérios',  
 FALSE,
 4, 16,   NULL, NULL, NULL, NULL),

(16, 'Caverna', 'Andar 1',
 'O ar torna-se mais úmido, com estalactites pendendo do teto e o som distante de gotas de água ecoando. Rochas raras começam a aparecer',
 FALSE,
 15, 17,   NULL, NULL, NULL, NULL),

(17, 'Caverna', 'Andar 2',
 'A iluminação natural diminui, revelando cristais luminescentes que iluminam o caminho. Inimigos mais desafiadores espreitam nas sombras.',
 FALSE,
 16, 18,   NULL, NULL, NULL, NULL),

(18, 'Caverna', 'Andar 3',
 'ma camada de gelo cobre o chão, e o ar é frio o suficiente para ver sua respiração. Inimigos gelados patrulham este nível.',
 FALSE,
 17, 19,   NULL, NULL, NULL, NULL),

(19, 'Caverna', 'Andar 4',
 'Formações rochosas complexas e minerais valiosos são abundantes aqui. O ambiente é silencioso, mas a sensação de ser observado é constante.',
 FALSE,
 18, 20,   NULL, NULL, NULL, NULL),

(20, 'Caverna', 'Andar 5',
 'Poças de lava iluminam o ambiente com um brilho avermelhado. O calor é intenso, e criaturas flamejantes guardam os tesouros deste andar.', 
 FALSE,
 19, 21,   NULL, NULL, NULL, NULL),

(21, 'Caverna', 'Andar 6',
 'Uma escuridão profunda envolve tudo, quebrada apenas por minerais raros que emitem uma luz própria. Apenas os aventureiros mais corajosos chegam tão longe.',
 FALSE,
 20, NULL, NULL, NULL, NULL, NULL);

INSERT INTO loja (fk_id_ambiente, nome, proprietario)
VALUES --fk_id_estoque com números aleatórios
(1, 'Armazém do Pierre', 'Pierre'),
(2, 'Mercado Joja', 'Gerente Joja'),
(3, 'Ferreiro', 'Clint'), 
(5, 'Comércio do Deserto', 'Sandy');

INSERT INTO estoque(id_estoque, fk_id_loja) VALUES
    (1, 1),
    (2, 2),
    (3, 3),
    (5, 5);

INSERT INTO item (id_item, tipo_item) VALUES
(1, 'consumivel'),
(2, 'consumivel'),
(3, 'consumivel'),
(4, 'consumivel'),
(5, 'consumivel'),
(6, 'consumivel'),
(7, 'consumivel'),
(8, 'consumivel'),
(9, 'consumivel'),
(10, 'consumivel'),
(11, 'consumivel'),
(12, 'consumivel'),
(13, 'consumivel'),
(14, 'consumivel'),
(15, 'consumivel'),
(16, 'consumivel'),
(17, 'consumivel'),
(18, 'consumivel'),
(19, 'consumivel'),
(20, 'consumivel'),
(21, 'consumivel'),
(22, 'consumivel'),
(23, 'consumivel'),
(24, 'consumivel'),
(25, 'consumivel'),
(26, 'consumivel'),
(27, 'consumivel'),
(28, 'consumivel'),
(29, 'mineral'),
(30, 'mineral'),
(31, 'mineral'),
(32, 'mineral'),
(33, 'mineral'),
(34, 'mineral'),
(35, 'mineral'),
(36, 'mineral'),
(37, 'mineral'),
(38, 'mineral'),
(39, 'mineral'),
(40, 'mineral'),
(41, 'mineral'),
(42, 'mineral'),
(43, 'mineral'),
(44, 'mineral'),
(45, 'recurso'),
(46, 'recurso'),
(47, 'recurso'),
(48, 'recurso'),
(49, 'recurso'),
(50, 'recurso'),
(51, 'recurso'),
(52, 'recurso'),
(53, 'recurso'),
(54, 'mineral'),
(55, 'mineral'),
(56, 'mineral'),

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

INSERT INTO Caverna (fk_id_ambiente, andar, qtd_minerio, fk_id_minerio_item, fk_id_item_recompensa) VALUES
    (15, 0, 0, 29, 10),
    (16, 1, 5, 31,  2),
    (17, 2, 5, 32,  3),
    (18, 3, 5, 33,  4),
    (19, 4, 3, 34,  5),
    (20, 5, 5, 35,  6),
    (21, 6, 3, 36,  7);

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

INSERT INTO Planta (nome, descricao, diaDropar)
VALUES
('Melão', 'Uma fruta doce e suculenta típica do verão.', 10),
('Abóbora', 'Um vegetal grande e alaranjado, cresce melhor no outono.', 15),
('Couve-Flor', 'Um vegetal branco e nutritivo, cresce bem na primavera.', 8),
('Milho', 'Cresce durante o verão e outono, produzindo várias colheitas.', 20),
('Morangos', 'Uma fruta doce da primavera, muito lucrativa.', 13),
('Batata', 'Um tubérculo robusto e nutritivo, colhido na primavera.', 5),
('Girassol', 'Uma flor brilhante que também pode ser usada para produzir óleo.', 12),
('Trigo', 'Uma cultura essencial para fabricação de farinha e cerveja.', 18),
('Rabanete', 'Um vegetal picante e crocante que cresce no verão.', 7),
('Uva', 'Frutas roxas deliciosas, crescem em vinhedos no outono.', 16);
