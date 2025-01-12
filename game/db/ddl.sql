-- Tabelas base sem dependências
CREATE TABLE IF NOT EXISTS Habilidade (
    id_habilidade SERIAL PRIMARY KEY,
    tipo VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS Mapa (
    id_mapa SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS Inimigo (
    id_inimigo SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    tipo VARCHAR(50) NOT NULL,
    vidaMax INT NOT NULL, 
    dano INT NOT NULL
);

CREATE TABLE IF NOT EXISTS Animal (
    id_animal SERIAL PRIMARY KEY,
    nome_animal VARCHAR(100),
    diasTotalDropar INT NOT NULL,
    tipo_animal VARCHAR(50) NOT NULL,
    itemDrop VARCHAR(100) NOT NULL,
    preco FLOAT NOT NULL
);

CREATE TABLE IF NOT EXISTS habMineracao (
    fk_Habilidade_id INT,
    reducaoEnergiaMinera INT NOT NULL,
    minerioBonus INT NOT NULL,
    nivel INT NOT NULL,
    xpMin INT NOT NULL,
    xpMax INT NOT NULL,
    PRIMARY KEY (fk_Habilidade_id),
    FOREIGN KEY (fk_Habilidade_id) REFERENCES Habilidade(id_habilidade)
);

CREATE TABLE IF NOT EXISTS habCombate (
    fk_Habilidade_id INT,
    nivel INT NOT NULL,
    xpMin INT NOT NULL,
    xpMax INT NOT NULL,
    vidaBonus INT NOT NULL,
    danoBonus INT NOT NULL,
    PRIMARY KEY (fk_Habilidade_id),
    FOREIGN KEY (fk_Habilidade_id) REFERENCES Habilidade(id_habilidade)
);

CREATE TABLE IF NOT EXISTS habCultivo (
    fk_Habilidade_id INT,
    nivel INT NOT NULL,
    xpMin INT NOT NULL,
    xpMax INT NOT NULL,
    cultivoBonus INT NOT NULL,
    reducaoEnergiaCultiva INT NOT NULL,
    PRIMARY KEY (fk_Habilidade_id),
    FOREIGN KEY (fk_Habilidade_id) REFERENCES Habilidade(id_habilidade)
);

CREATE TABLE IF NOT EXISTS Jogador (
    id_jogador SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,                  
    dia INT NOT NULL DEFAULT 0,                   
    tempo INT NOT NULL DEFAULT 0,                
    vidaMax FLOAT NOT NULL DEFAULT 10.0,         
    vidaAtual FLOAT NOT NULL DEFAULT 10.0,       
    xp_mineracao FLOAT NOT NULL DEFAULT 0.0,     
    xp_cultivo FLOAT NOT NULL DEFAULT 0.0,       
    xp_combate FLOAT NOT NULL DEFAULT 0.0,       
    dano_ataque FLOAT NOT NULL DEFAULT 10.0,     
    fk_habMineracao_fk_Habilidade_id INT DEFAULT 1, 
    fk_habCombate_fk_Habilidade_id INT DEFAULT 11,   
    fk_habCultivo_fk_Habilidade_id INT DEFAULT 21,   
    CONSTRAINT fk_Jogador_habMineracao FOREIGN KEY (fk_habMineracao_fk_Habilidade_id)
        REFERENCES habMineracao (fk_Habilidade_id),
    CONSTRAINT fk_Jogador_habCombate FOREIGN KEY (fk_habCombate_fk_Habilidade_id)
        REFERENCES habCombate (fk_Habilidade_id),
    CONSTRAINT fk_Jogador_habCultivo FOREIGN KEY (fk_habCultivo_fk_Habilidade_id)
        REFERENCES habCultivo (fk_Habilidade_id)
);

CREATE TABLE IF NOT EXISTS inventario (
    id_inventario SERIAL PRIMARY KEY,
    fk_id_jogador INTEGER NOT NULL,
    FOREIGN KEY (fk_id_jogador) REFERENCES Jogador(id_jogador)
);

-- Tabelas dependentes de outras tabelas

CREATE TABLE IF NOT EXISTS Ambiente (--popular Manuella
    id_ambiente INT PRIMARY KEY,
    tipo VARCHAR(50),
    fk_id_mapa INT NOT NULL,
    fk_jogador_id INT,
    descricao TEXT NOT NULL,
    transitar_1 INT,
    transitar_2 INT,
    transitar_3 INT,
    transitar_4 INT,
    transitar_5 INT,
    transitar_6 INT,
    FOREIGN KEY(fk_id_mapa) REFERENCES Mapa(id_mapa),
    FOREIGN KEY (fk_jogador_id) REFERENCES Jogador(id_jogador)
);

CREATE TABLE IF NOT EXISTS estoque (--popular Isaac
    id_estoque SERIAL PRIMARY KEY--,
    --id_item INT NOT NULL,
    --preco DECIMAL NOT NULL,
    --FOREIGN KEY (id_item) REFERENCES Item(id_item)
);

CREATE TABLE IF NOT EXISTS item (--popular Marcos
    id_item SERIAL PRIMARY KEY,
    tipo_item VARCHAR(20) NOT NULL,
    fk_estoque INTEGER DEFAULT 0,
    fk_inventario_id INTEGER DEFAULT 0,
    FOREIGN KEY (fk_inventario_id) REFERENCES inventario(id_inventario),
    FOREIGN KEY (fk_estoque) REFERENCES estoque(id_estoque)
);

CREATE TABLE IF NOT EXISTS mineral (--popular Marcos
    id_item INTEGER PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    descricao VARCHAR(100) NOT NULL,
    resistencia INTEGER NOT NULL,
    preco DECIMAL NOT NULL,
    FOREIGN KEY (id_item) REFERENCES item(id_item)
);

CREATE TABLE IF NOT EXISTS Caverna(--popular Manuella
    andar SERIAL PRIMARY KEY,
    fk_id_ambiente INT NOT NULL,
    quantidade_mobs INT NOT NULL,
    qtd_minerio INT NOT NULL,
    fk_id_minerio_item INT NOT NULL,
    fk_id_item_recompensa INT NOT NULL,
    FOREIGN KEY (fk_id_ambiente) REFERENCES Ambiente(id_ambiente),
    FOREIGN KEY (fk_id_minerio_item) REFERENCES mineral(id_item),
    FOREIGN KEY (fk_id_item_recompensa) REFERENCES item(id_item)
);

CREATE TABLE IF NOT EXISTS Celeiro (
    id_celeiro SERIAL PRIMARY KEY,
    qtd_animais INT NOT NULL DEFAULT 0,
    qtd_max_animais INT NOT NULL DEFAULT 10,
    fk_id_ambiente INT NOT NULL,
    FOREIGN KEY (fk_id_ambiente) REFERENCES Ambiente(id_ambiente)
);

CREATE TABLE IF NOT EXISTS Plantacao (
    id_plantacao SERIAL PRIMARY KEY,
    qtd_plantas INT NOT NULL DEFAULT 0,
    qtd_plantas_max INT NOT NULL DEFAULT 10,
    fk_id_ambiente INT NOT NULL,
    FOREIGN KEY (fk_id_ambiente) REFERENCES Ambiente(id_ambiente)
);

CREATE TABLE IF NOT EXISTS loja (--popular Manuella
    id_loja INT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    proprietario VARCHAR(100) NOT NULL,
    fk_id_ambiente INT NOT NULL,
    fk_id_estoque INT NOT NULL,
    FOREIGN KEY (fk_id_ambiente) REFERENCES Ambiente(id_ambiente),
    FOREIGN KEY (fk_id_estoque) REFERENCES estoque(id_estoque)
);

<<<<<<< HEAD
=======
CREATE TABLE IF NOT EXISTS estoque (
    id_estoque SERIAL PRIMARY KEY,
    fk_id_item INT NOT NULL,
    preco DECIMAL NOT NULL,
    FOREIGN KEY (fk_id_item) REFERENCES Item(id_item)
);
>>>>>>> origin/main

CREATE TABLE IF NOT EXISTS inventario (
    id_inventario SERIAL PRIMARY KEY,
    fk_id_jogador INTEGER NOT NULL,
    FOREIGN KEY (fk_id_jogador) REFERENCES Jogador(id_jogador)
);

CREATE TABLE IF NOT EXISTS item (--popular Marcos
    id_item SERIAL PRIMARY KEY,
    tipo_item VARCHAR(20) NOT NULL,
    fk_estoque INTEGER DEFAULT 0,
    fk_inventario_id INTEGER DEFAULT 0,
    FOREIGN KEY (fk_inventario_id) REFERENCES inventario(id_inventario),
    FOREIGN KEY (fk_estoque) REFERENCES estoque(id_estoque)
);

CREATE TABLE IF NOT EXISTS consumivel (--popular Marcos
    id_item INTEGER PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    descricao TEXT NOT NULL, -- add
    efeito_vida INT NOT NULL,
    FOREIGN KEY (id_item) REFERENCES item(id_item)
);

<<<<<<< HEAD
CREATE TABLE IF NOT EXISTS utensilio (--popular Isaac 
    id_item INTEGER PRIMARY KEY,
=======
CREATE TABLE IF NOT EXISTS utensilio ( 
    fk_id_item INTEGER PRIMARY KEY,
>>>>>>> origin/main
    tipo_utensilio VARCHAR(100) NOT NULL,
    FOREIGN KEY (id_item) REFERENCES item(id_item)
);

<<<<<<< HEAD
CREATE TABLE IF NOT EXISTS ferramenta (--popular isaac
    id_item INTEGER PRIMARY KEY,
=======
CREATE TABLE IF NOT EXISTS ferramenta (
    fk_id_item INTEGER PRIMARY KEY,
>>>>>>> origin/main
    nome VARCHAR(100) NOT NULL,
    descricao VARCHAR(100) NOT NULL,
    fk_id_utensilio INTEGER NOT NULL,
    eficiencia INTEGER NOT NULL,
    nivel INTEGER NOT NULL,
    FOREIGN KEY (id_item) REFERENCES item(id_item),
    FOREIGN KEY (fk_id_utensilio) REFERENCES utensilio(id_item)
);

<<<<<<< HEAD
CREATE TABLE IF NOT EXISTS arma (--popular Isaac
    id_item INTEGER PRIMARY KEY,
=======
CREATE TABLE IF NOT EXISTS arma (
    fk_id_item INTEGER PRIMARY KEY,
>>>>>>> origin/main
    nome VARCHAR(100) NOT NULL,
    descricao VARCHAR(100) NOT NULL,
    fk_id_utensilio INTEGER NOT NULL,    
    FOREIGN KEY (fk_id_utensilio) REFERENCES utensilio(id_item)
);

CREATE TABLE IF NOT EXISTS recurso (--popular Marcos
    id_item INTEGER PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    descricao VARCHAR(100) NOT NULL,
    preco DECIMAL NOT NULL,
    FOREIGN KEY (id_item) REFERENCES item(id_item)
);

CREATE TABLE IF NOT EXISTS Instancia_de_Inimigo (
    id_instancia_de_inimigo SERIAL PRIMARY KEY,
    vidaAtual FLOAT NOT NULL,
    fk_Caverna_andar INT,
    fk_inimigo_id INT NOT NULL,
    FOREIGN KEY (fk_inimigo_id) REFERENCES Inimigo(id_inimigo),
    FOREIGN KEY (fk_Caverna_andar) REFERENCES Caverna(andar)
);


CREATE TABLE IF NOT EXISTS Instancia_de_Animal (
    id_instancia_de_animal SERIAL PRIMARY KEY,
    prontoDropa BOOLEAN NOT NULL,
    diaAtual INT NOT NULL,
    fk_Animal_id INT NOT NULL,
    fk_Jogador_id INT,
    fk_Celeiro_id INT,
    FOREIGN KEY (fk_Animal_id) REFERENCES Animal(id_animal),
    FOREIGN KEY (fk_Jogador_id) REFERENCES Jogador(id_jogador),
    FOREIGN KEY (fk_Celeiro_id) REFERENCES Celeiro(id_celeiro)
);


CREATE TABLE IF NOT EXISTS Instancia_de_Planta (
    id_instancia_de_planta INT PRIMARY KEY,
    nome VARCHAR(50) NOT NULL,
    diaDropar INT NOT NULL,
    plantaDrop VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS semente (--popular zaranza
    id_semente INT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    descricao VARCHAR(100) NOT NULL,
    diaAtual INT NOT NULL DEFAULT 0,
    prontoColher BOOLEAN NOT NULL,
    id_item SERIAL NOT NULL,
    fk_instancia_planta_id INT NOT NULL,
    FOREIGN KEY (fk_instancia_planta_id) REFERENCES Instancia_de_Planta(id_instancia_de_planta),
    FOREIGN KEY (id_item) REFERENCES item(id_item)
);

CREATE TABLE IF NOT EXISTS solo (--popular zaranza
    id_solo SERIAL PRIMARY KEY,
    tipo_recurso VARCHAR(50) NOT NULL,
    fk_id_plantacao INT NOT NULL,
    bool_regou BOOLEAN NOT NULL,
    bool_livre BOOLEAN NOT NULL,
    FOREIGN KEY (fk_id_plantacao) REFERENCES Plantacao(id_plantacao)
);

CREATE TABLE IF NOT EXISTS Missao (--popular Manuella
    id_missao SERIAL PRIMARY KEY, 
    tipo VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS missao_combate (--popular
    fk_id_missao INT NOT NULL PRIMARY KEY,
    fk_id_Inimigo INT NOT NULL,
    nome VARCHAR(255) NOT NULL,
    descricao TEXT NOT NULL,
    dataInicio INT NOT NULL,
    dataFinalizacao INT,
    FOREIGN KEY (fk_id_Inimigo) REFERENCES Inimigo(id_inimigo),
    FOREIGN KEY (fk_id_missao) REFERENCES Missao(id_missao)
);

CREATE TABLE IF NOT EXISTS missao_coleta (--popular
    fk_id_missao INT NOT NULL PRIMARY KEY,
    fk_id_minerio INT NOT NULL,
    nome VARCHAR(255) NOT NULL,
    descricao TEXT NOT NULL,
    dataInicio INT NOT NULL,
    dataFinalizacao INT,
    FOREIGN KEY (fk_id_minerio) REFERENCES mineral(id_item),
    FOREIGN KEY (fk_id_missao) REFERENCES Missao(id_missao)
);

CREATE TABLE IF NOT EXISTS Instancia_Missao (
    id_Instancia_Missao SERIAL PRIMARY KEY,
    fk_id_jogador INT NOT NULL,
    fk_Missao INT NOT NULL,
    missao_finalizada BOOLEAN NOT NULL DEFAULT false,
    FOREIGN KEY (fk_Missao) REFERENCES Missao(id_missao),
    FOREIGN KEY (fk_id_jogador) REFERENCES Jogador(id_jogador)
);


CREATE TABLE IF NOT EXISTS Recompensa (--popular manuella
    id_Recompensa  SERIAL PRIMARY KEY,
    fk_Jogador_id INT NOT NULL,
    id_item INT NOT NULL,
    fk_Instancia_Missao INT NOT NULL,
    quantidade INT NOT NULL,
    FOREIGN KEY (fk_Jogador_id) REFERENCES Jogador(id_jogador),
    FOREIGN KEY (id_item) REFERENCES item(id_item),
    FOREIGN KEY (fk_Instancia_Missao) REFERENCES Instancia_Missao(id_Instancia_Missao)
);

CREATE TABLE IF NOT EXISTS Caixa_Mensagem (
    fk_Jogador_id INT NOT NULL,
    id_Caixa_Mensagem SERIAL PRIMARY KEY,
    fk_Instancia_Missao INT NOT NULL,
    --fk_casa_jogador INT NOT NULL,
    FOREIGN KEY (fk_Instancia_Missao) REFERENCES Instancia_Missao(id_Instancia_Missao),
    FOREIGN KEY (fk_Jogador_id) REFERENCES Jogador(id_jogador)--,
    --FOREIGN KEY (fk_casa_jogador) REFERENCES Casa_Jogador(id_Casa_jogador)
);

CREATE TABLE IF NOT EXISTS Casa_Jogador(
    fk_id_ambiente INT NOT NULL,
    fk_id_caixa_mensagem INT NOT NULL,
    FOREIGN KEY (fk_id_ambiente) REFERENCES Ambiente(id_ambiente),
    FOREIGN KEY (fk_id_caixa_mensagem) REFERENCES Caixa_Mensagem(id_Caixa_Mensagem)
);