-- ---------------------------------------------------------------------------------------------------------------
-- Data de Criação ........: 03/02/2025                                                                         --
-- Autor(es) ..............: Gabriel Silva, Gabriel Zaranza, Isaac Batista, Manuella Valadares, Marcos Marinho  --
-- Versão .................: 1.9                                                                                --
-- Banco de Dados .........: PostgreSQL                                                                         --
-- Descrição ..............: Criação das tabelas para o jogo Stardew Valley                                     --
-- ---------------------------------------------------------------------------------------------------------------
BEGIN TRANSACTION;
CREATE TYPE tipo_item AS ENUM('ferramenta', 'arma', 'consumivel', 'mineral', 'recurso');

CREATE TABLE IF NOT EXISTS Habilidade (
    id_habilidade SERIAL PRIMARY KEY,
    tipo VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS Inimigo (
    id_inimigo SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    tipo VARCHAR(50) NOT NULL,
    vidaMax FLOAT NOT NULL, 
    dano FLOAT NOT NULL,
    xp_recompensa INT NOT NULL
);

CREATE TABLE IF NOT EXISTS habMineracao (
    fk_Habilidade_id INT,
    reducaoEnergiaMinera INT NOT NULL,
    minerioBonus INT NOT NULL,
    nivel INT NOT NULL DEFAULT 1,
    xpMin INT NOT NULL DEFAULT 0,
    xpMax INT NOT NULL DEFAULT 10,
    PRIMARY KEY (fk_Habilidade_id),
    FOREIGN KEY (fk_Habilidade_id) REFERENCES Habilidade(id_habilidade)
);

CREATE TABLE IF NOT EXISTS habCombate (
    fk_Habilidade_id INT,
    nivel INT NOT NULL DEFAULT 1,
    xpMin INT NOT NULL DEFAULT 0,
    xpMax INT NOT NULL DEFAULT 10,
    vidaBonus INT NOT NULL,
    danoBonus INT NOT NULL,
    PRIMARY KEY (fk_Habilidade_id),
    FOREIGN KEY (fk_Habilidade_id) REFERENCES Habilidade(id_habilidade)
);

CREATE TABLE IF NOT EXISTS habCultivo (
    fk_Habilidade_id INT,
    nivel INT NOT NULL DEFAULT 1,
    xpMin INT NOT NULL DEFAULT 0,
    xpMax INT NOT NULL DEFAULT 10,
    cultivoBonus INT NOT NULL,
    reducaoEnergiaCultiva INT NOT NULL,
    PRIMARY KEY (fk_Habilidade_id),
    FOREIGN KEY (fk_Habilidade_id) REFERENCES Habilidade(id_habilidade)
);

CREATE TABLE IF NOT EXISTS Jogador (
    id_jogador SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,                  
    dia INT NOT NULL DEFAULT 0,                   
    tempo TIME NOT NULL DEFAULT '06:00',
    localizacao_atual INT NOT NULL DEFAULT 1,                
    vidaMax FLOAT NOT NULL DEFAULT 100.0,         
    vidaAtual FLOAT NOT NULL DEFAULT 100.0,       
    xp_mineracao FLOAT NOT NULL DEFAULT 0.0,     
    xp_cultivo FLOAT NOT NULL DEFAULT 0.0,       
    xp_combate FLOAT NOT NULL DEFAULT 0.0,       
    dano_ataque FLOAT NOT NULL DEFAULT 10.0,
    moedas DECIMAL NOT NULL DEFAULT 1000.0,       
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

CREATE TABLE IF NOT EXISTS Ambiente (
    id_ambiente INT PRIMARY KEY,
    tipo VARCHAR(50),
    nome VARCHAR(50),
    descricao TEXT NOT NULL,
    eh_casa BOOLEAN NOT NULL,
    transitar_1 INT,
    transitar_2 INT,
    transitar_3 INT,
    transitar_4 INT,
    transitar_5 INT,
    transitar_6 INT
);

CREATE TABLE IF NOT EXISTS loja (
    fk_id_ambiente INTEGER NOT NULL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    proprietario VARCHAR(100) NOT NULL,
    FOREIGN KEY (fk_id_ambiente) REFERENCES Ambiente(id_ambiente)
);


CREATE TABLE IF NOT EXISTS item (
    id_item SERIAL PRIMARY KEY,
    tipo_item VARCHAR(20) NOT NULL
);

CREATE TABLE IF NOT EXISTS Animal (
    id_animal SERIAL PRIMARY KEY,
    tipo_animal VARCHAR(50) NOT NULL,
    diasTotalDropar INT NOT NULL,
    itemDrop INTEGER,
    preco FLOAT NOT NULL,
    FOREIGN KEY (itemDrop) REFERENCES item(id_item)
);

CREATE TABLE IF NOT EXISTS instancia_de_item(
    id_instancia_de_item SERIAL PRIMARY KEY,
    fk_id_jogador INT NOT NULL,
    fk_id_item INT NOT NULL,
    fk_id_inventario INTEGER, 
    is_equipado BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (fk_id_item) REFERENCES item(id_item),
    FOREIGN KEY (fk_id_inventario) REFERENCES inventario(id_inventario),
    FOREIGN KEY (fk_id_jogador) REFERENCES jogador(id_jogador)
);

CREATE TABLE IF NOT EXISTS mineral (
    fk_id_item INTEGER PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    descricao VARCHAR(100) NOT NULL,
    resistencia INTEGER NOT NULL,
    preco DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (fk_id_item) REFERENCES item(id_item)
);

CREATE TABLE IF NOT EXISTS Caverna(
    fk_id_ambiente INT NOT NULL PRIMARY KEY,
    andar INT NOT NULL,
    quantidade_mobs INT DEFAULT 0,
    qtd_minerio INT NOT NULL,
    fk_id_minerio_item INT NOT NULL,
    fk_id_item_recompensa INT NOT NULL,
    FOREIGN KEY (fk_id_ambiente) REFERENCES Ambiente(id_ambiente),
    FOREIGN KEY (fk_id_minerio_item) REFERENCES mineral(fk_id_item),
    FOREIGN KEY (fk_id_item_recompensa) REFERENCES item(id_item)
);

CREATE TABLE IF NOT EXISTS Celeiro (
    fk_id_ambiente INT NOT NULL PRIMARY KEY,
    qtd_max_animais INT NOT NULL DEFAULT 10,
    FOREIGN KEY (fk_id_ambiente) REFERENCES Ambiente(id_ambiente)
);

CREATE TABLE IF NOT EXISTS Plantacao (
    fk_id_ambiente INT NOT NULL PRIMARY KEY,
    qtd_plantas_max INT NOT NULL DEFAULT 15,
    FOREIGN KEY (fk_id_ambiente) REFERENCES Ambiente(id_ambiente)
);

CREATE TABLE IF NOT EXISTS consumivel (
    fk_id_item INTEGER PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    descricao TEXT NOT NULL, -- add
    efeito_vida INT NOT NULL,
    preco DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (fk_id_item) REFERENCES item(id_item)
);


CREATE TABLE IF NOT EXISTS ferramenta (
    fk_id_item INTEGER PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    descricao VARCHAR(100) NOT NULL,
    eficiencia INTEGER NOT NULL,
    preco DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (fk_id_item) REFERENCES item(id_item)
);


CREATE TABLE IF NOT EXISTS arma (
    fk_id_item INTEGER PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    descricao VARCHAR(100) NOT NULL,
    dano_arma INTEGER,
    preco DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (fk_id_item) REFERENCES item(id_item)
);

CREATE TABLE IF NOT EXISTS recurso (
    fk_id_item INTEGER PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    descricao VARCHAR(100) NOT NULL,
    preco DECIMAL(10,2) NOT NULL,
    raridade INTEGER NOT NULL,
    FOREIGN KEY (fk_id_item) REFERENCES item(id_item)
);

CREATE TABLE IF NOT EXISTS Instancia_de_Inimigo (
    id_instancia_de_inimigo SERIAL PRIMARY KEY,
    vidaAtual FLOAT NOT NULL,
    fk_id_ambiente INT,
    fk_inimigo_id INT NOT NULL,
    fk_jogador_id INT NOT NULL,
    FOREIGN KEY (fk_inimigo_id) REFERENCES Inimigo(id_inimigo),
    FOREIGN KEY (fk_id_ambiente) REFERENCES Caverna(fk_id_ambiente),
    FOREIGN KEY (fk_jogador_id) REFERENCES Jogador(id_jogador)
);


CREATE TABLE IF NOT EXISTS Instancia_de_Animal (
    id_instancia_de_animal SERIAL PRIMARY KEY,
    nome_animal VARCHAR(100) NOT NULL,
    prontoDropa BOOLEAN NOT NULL,
    diaAtual INT NOT NULL,
    fk_Animal_id INT NOT NULL,
    fk_Jogador_id INT,
    fk_Celeiro_id INT,
    FOREIGN KEY (fk_Animal_id) REFERENCES Animal(id_animal),
    FOREIGN KEY (fk_Jogador_id) REFERENCES Jogador(id_jogador),
    FOREIGN KEY (fk_Celeiro_id) REFERENCES Celeiro(fk_id_ambiente)
);

CREATE TABLE IF NOT EXISTS Planta (
    id_planta SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    descricao VARCHAR(100) NOT NULL,
    diaDropar INT NOT NULL,
    preco DECIMAL(10,2) NOT NULL,
    itemDrop INTEGER,
    FOREIGN KEY (itemDrop) REFERENCES item(id_item)
);

CREATE TABLE IF NOT EXISTS Instancia_de_Planta (
    id_instancia_de_planta SERIAL PRIMARY KEY,
    fk_id_planta INT NOT NULL,
    fk_id_jogador INT NOT NULL,
    nome VARCHAR(50) NOT NULL,
    prontoColher BOOLEAN NOT NULL,
    diaAtual INT NOT NULL DEFAULT 0,
    FOREIGN KEY (fk_id_planta) REFERENCES Planta(id_planta),
    FOREIGN KEY (fk_id_jogador) REFERENCES Jogador(id_jogador)
);


CREATE TABLE IF NOT EXISTS estoque(
    fk_id_loja INTEGER NOT NULL,
    fk_id_item INTEGER NOT NULL,
    FOREIGN KEY (fk_id_loja) REFERENCES loja(fk_id_ambiente),
    FOREIGN KEY (fk_id_item) REFERENCES Item(id_item)
);

CREATE TABLE IF NOT EXISTS Historia(
    dia INT PRIMARY KEY,
    historia TEXT NOT NULL
);
COMMIT; 