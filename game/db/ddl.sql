CREATE TABLE IF NOT EXISTS Celeiro (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    localizacao TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS Habilidade (
    id SERIAL PRIMARY KEY,
    nivel INT NOT NULL,
    tipo VARCHAR(50) NOT NULL,
    xpMin INT NOT NULL,
    xpMax INT NOT NULL
);

CREATE TABLE IF NOT EXISTS habMineracao (
    reducaoEnergiaMinera INT NOT NULL,
    minerioBonus INT NOT NULL,
    fk_Habilidade_id INT,
    PRIMARY KEY (fk_Habilidade_id),
    FOREIGN KEY (fk_Habilidade_id) REFERENCES Habilidade(id)
);

CREATE TABLE IF NOT EXISTS habCombate (
    vidaBonus INT NOT NULL,
    danoBonus INT NOT NULL,
    fk_Habilidade_id INT,
    PRIMARY KEY (fk_Habilidade_id),
    FOREIGN KEY (fk_Habilidade_id) REFERENCES Habilidade(id)
);

CREATE TABLE IF NOT EXISTS habCultivo (
    cultivoBonus INT NOT NULL,
    reducaoEnergiaCultiva INT NOT NULL,
    fk_Habilidade_id INT,
    PRIMARY KEY (fk_Habilidade_id),
    FOREIGN KEY (fk_Habilidade_id) REFERENCES Habilidade(id)
);

CREATE TABLE IF NOT EXISTS categoria (
    id_categoria SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    descricao TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS loja (
    id_loja SERIAL PRIMARY KEY,
    proprietario VARCHAR(255) NOT NULL,
    nome VARCHAR(100) NOT NULL,
    descricao TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS Jogador (
    id SERIAL PRIMARY KEY,
    dia INT NOT NULL DEFAULT 0,                   
    tempo INT NOT NULL DEFAULT 0,                
    vidaMax FLOAT NOT NULL DEFAULT 10.0,         
    vidaAtual FLOAT NOT NULL DEFAULT 10.0,       
    nome VARCHAR(100) NOT NULL,                  
    xp_mineracao FLOAT NOT NULL DEFAULT 0.0,     
    xp_cultivo FLOAT NOT NULL DEFAULT 0.0,       
    xp_combate FLOAT NOT NULL DEFAULT 0.0,       
    dano_ataque FLOAT NOT NULL DEFAULT 10.0,     
    fk_habMineracao_fk_Habilidade_id INT DEFAULT 1, 
    fk_habCombate_fk_Habilidade_id INT DEFAULT 1,   
    fk_habCultivo_fk_Habilidade_id INT DEFAULT 1,   
    CONSTRAINT fk_Jogador_habMineracao FOREIGN KEY (fk_habMineracao_fk_Habilidade_id)
        REFERENCES habMineracao (fk_Habilidade_id),
    CONSTRAINT fk_Jogador_habCombate FOREIGN KEY (fk_habCombate_fk_Habilidade_id)
        REFERENCES habCombate (fk_Habilidade_id),
    CONSTRAINT fk_Jogador_habCultivo FOREIGN KEY (fk_habCultivo_fk_Habilidade_id)
        REFERENCES habCultivo (fk_Habilidade_id)
);

CREATE TABLE IF NOT EXISTS estoque_produto (
    id_estoque_produto SERIAL PRIMARY KEY,
    produto VARCHAR(255) NOT NULL,
    preco DECIMAL NOT NULL
);

CREATE TABLE IF NOT EXISTS inventario (
    id_inventario SERIAL PRIMARY KEY,
    id_jogador INTEGER NOT NULL,
    quantidade_item INTEGER NOT NULL,
    FOREIGN KEY (id_jogador) REFERENCES Jogador(id)
);

CREATE TABLE IF NOT EXISTS item (
    id_item SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    descricao TEXT NOT NULL,
    id_categoria INTEGER NOT NULL,
    quantidade INTEGER NOT NULL,
    inventario_id INTEGER NOT NULL,
    estoque_produto INTEGER NOT NULL,
    FOREIGN KEY (id_categoria) REFERENCES categoria(id_categoria),
    FOREIGN KEY (inventario_id) REFERENCES inventario(id_inventario),
    FOREIGN KEY (estoque_produto) REFERENCES estoque_produto(id_estoque_produto)
);

CREATE TABLE IF NOT EXISTS consumivel (
    id_item INTEGER PRIMARY KEY,
    tipo_consumivel VARCHAR(50) NOT NULL,
    duracao INTEGER NOT NULL,
    efeito VARCHAR(255) NOT NULL,
    FOREIGN KEY (id_item) REFERENCES item(id_item)
);

CREATE TABLE IF NOT EXISTS utensilio (
    id_item INTEGER PRIMARY KEY,
    tipo_utensilio VARCHAR(100) NOT NULL,
    nivel INTEGER NOT NULL,
    id_loja INTEGER NOT NULL,
    FOREIGN KEY (id_item) REFERENCES item(id_item),
    FOREIGN KEY (id_loja) REFERENCES loja(id_loja)
);

CREATE TABLE IF NOT EXISTS ferramenta (
    id_item INTEGER PRIMARY KEY,
    tipo_ferramenta VARCHAR(100) NOT NULL,
    id_utensilio INTEGER NOT NULL,
    eficiencia INTEGER NOT NULL,
    FOREIGN KEY (id_item) REFERENCES item(id_item),
    FOREIGN KEY (id_utensilio) REFERENCES utensilio(id_item)
);

CREATE TABLE IF NOT EXISTS arma (
    id_item INTEGER PRIMARY KEY,
    tipo_arma VARCHAR(100) NOT NULL,
    id_utensilio INTEGER NOT NULL,
    dano INTEGER NOT NULL,
    FOREIGN KEY (id_item) REFERENCES item(id_item),
    FOREIGN KEY (id_utensilio) REFERENCES utensilio(id_item)
);

CREATE TABLE IF NOT EXISTS mineral (
    id_item INTEGER PRIMARY KEY,
    tipo_minerio VARCHAR(50) NOT NULL,
    preco DECIMAL NOT NULL,
    FOREIGN KEY (id_item) REFERENCES item(id_item)
);

CREATE TABLE IF NOT EXISTS recurso (
    id_item INTEGER PRIMARY KEY,
    tipo_recurso VARCHAR(50) NOT NULL,
    preco DECIMAL NOT NULL,
    FOREIGN KEY (id_item) REFERENCES item(id_item)
);

CREATE TABLE IF NOT EXISTS Inimigo (
    id SERIAL PRIMARY KEY,
    vidaMax FLOAT NOT NULL,
    tipo VARCHAR(50) NOT NULL,
    dano FLOAT NOT NULL,
    nome VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS Instancia_de_Inimigo (
    id SERIAL PRIMARY KEY,
    tipo VARCHAR(50) NOT NULL,
    vidaAtual FLOAT NOT NULL,
    fk_Caverna_andar INT,
    fk_inimigo_id INT NOT NULL,
    FOREIGN KEY (fk_inimigo_id) REFERENCES Inimigo(id)
);

CREATE TABLE IF NOT EXISTS ataca (
    fk_Jogador_id INT NOT NULL,
    fk_Instancia_de_Inimigo_id INT NOT NULL,
    PRIMARY KEY (fk_Jogador_id, fk_Instancia_de_Inimigo_id),
    FOREIGN KEY (fk_Jogador_id) REFERENCES Jogador(id),
    FOREIGN KEY (fk_Instancia_de_Inimigo_id) REFERENCES Instancia_de_Inimigo(id)
);

CREATE TABLE IF NOT EXISTS Animal (
    id SERIAL PRIMARY KEY,
    preco FLOAT NOT NULL,
    itemDrop VARCHAR(100) NOT NULL,
    tipo VARCHAR(50) NOT NULL,
    diasTotalDropar INT NOT NULL,
    nome VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS Instancia_de_Animal (
    id SERIAL PRIMARY KEY,
    prontoDropa BOOLEAN NOT NULL,
    diaAtual INT NOT NULL,
    fk_Animal_id INT NOT NULL,
    fk_Jogador_id INT,
    fk_Celeiro_id INT,
    FOREIGN KEY (fk_Animal_id) REFERENCES Animal(id),
    FOREIGN KEY (fk_Jogador_id) REFERENCES Jogador(id),
    FOREIGN KEY (fk_Celeiro_id) REFERENCES Celeiro(id)
);
