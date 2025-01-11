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
    preco FLOAT NOT NULL,
    itemDrop VARCHAR(100) NOT NULL,
    tipo_animal VARCHAR(50) NOT NULL,
    diasTotalDropar INT NOT NULL,
    nome_animal VARCHAR(100)
);

CREATE TABLE IF NOT EXISTS habMineracao (
    fk_Habilidade_id INT,
    nivel INT NOT NULL,
    xpMin INT NOT NULL,
    xpMax INT NOT NULL,
    reducaoEnergiaMinera INT NOT NULL,
    minerioBonus INT NOT NULL,
    PRIMARY KEY (fk_Habilidade_id),
    FOREIGN KEY (fk_Habilidade_id) REFERENCES Habilidade(id)
);

CREATE TABLE IF NOT EXISTS habCombate (
    fk_Habilidade_id INT,
    nivel INT NOT NULL,
    xpMin INT NOT NULL,
    xpMax INT NOT NULL,
    vidaBonus INT NOT NULL,
    danoBonus INT NOT NULL,
    PRIMARY KEY (fk_Habilidade_id),
    FOREIGN KEY (fk_Habilidade_id) REFERENCES Habilidade(id)
);

CREATE TABLE IF NOT EXISTS habCultivo (
    fk_Habilidade_id INT,
    nivel INT NOT NULL,
    xpMin INT NOT NULL,
    xpMax INT NOT NULL,
    cultivoBonus INT NOT NULL,
    reducaoEnergiaCultiva INT NOT NULL,
    PRIMARY KEY (fk_Habilidade_id),
    FOREIGN KEY (fk_Habilidade_id) REFERENCES Habilidade(id)
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
    fk_habCombate_fk_Habilidade_id INT DEFAULT 1,   
    fk_habCultivo_fk_Habilidade_id INT DEFAULT 1,   
    CONSTRAINT fk_Jogador_habMineracao FOREIGN KEY (fk_habMineracao_fk_Habilidade_id)
        REFERENCES habMineracao (fk_Habilidade_id),
    CONSTRAINT fk_Jogador_habCombate FOREIGN KEY (fk_habCombate_fk_Habilidade_id)
        REFERENCES habCombate (fk_Habilidade_id),
    CONSTRAINT fk_Jogador_habCultivo FOREIGN KEY (fk_habCultivo_fk_Habilidade_id)
        REFERENCES habCultivo (fk_Habilidade_id)
);

-- Tabelas dependentes de outras tabelas

CREATE TABLE IF NOT EXISTS Ambiente (
    id_ambiente INT PRIMARY KEY,
    tipo VARCHAR(50) NOT NULL,
    fk_idMapa INT NOT NULL,
    fk_jogador_id INT,
    descricao TEXT NOT NULL,
    transitar_1 INT,
    transitar_2 INT,
    transitar_3 INT,
    transitar_4 INT,
    transitar_5 INT,
    transitar_6 INT,
    FOREIGN KEY (fk_idMapa) REFERENCES Mapa(idMapa),
    FOREIGN KEY (fk_jogador_id) REFERENCES Jogador(id)
);

CREATE TABLE IF NOT EXISTS Caverna (
    andar SERIAL PRIMARY KEY,
    fk_id_ambiente INT NOT NULL,
    quantidade_mobs INT NOT NULL,
    qtd_minerio INT NOT NULL,
    fk_id_minerio_item INT NOT NULL,
    fk_item_recompensa INT NOT NULL,
    FOREIGN KEY (fk_id_ambiente) REFERENCES Ambiente(id_ambiente)
    FOREIGN KEY (fk_id_minerio_item) REFERENCES mineral(id_item)
    FOREIGN KEY (fk_id_item_recompensa) REFERENCES item(id_item)
);

CREATE TABLE IF NOT EXISTS Celeiro (
    id_celeiro SERIAL PRIMARY KEY,
    qtd_animais INT NOT NULL,
    fk_id_ambiente INT NOT NULL,
    FOREIGN KEY (fk_id_ambiente) REFERENCES Ambiente(id_ambiente)
);

CREATE TABLE IF NOT EXISTS Plantacao (
    qtd_plantas INT NOT NULL,
    fk_id_ambiente INT NOT NULL,
    FOREIGN KEY (fk_id_ambiente) REFERENCES Ambiente(id_ambiente)
);

CREATE TABLE IF NOT EXISTS loja (
    id_loja INT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    proprietario VARCHAR(255) NOT NULL,
    fk_id_ambiente INT NOT NULL,
    FOREIGN KEY (fk_id_ambiente) REFERENCES Ambiente(id_ambiente)
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
    -- nome VARCHAR(100) NOT NULL, Inserir em cada tipo de item
    -- descricao TEXT NOT NULL, Inserir em cada tipo de item
    id_categoria INTEGER NOT NULL,
    -- quantidade INTEGER NOT NULL, Inserir em cada tipo de item
    -- inventario_id INTEGER NOT NULL, Inserir em cada tipo de item
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

CREATE TABLE IF NOT EXISTS planta (
    id_planta INT PRIMARY KEY,
    nome VARCHAR(50) NOT NULL,
    diaDropar INT NOT NULL,
    plantaDrop VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS Instancia_de_Planta (
    id INT PRIMARY KEY,
    nome VARCHAR(50) NOT NULL,
    diaDropar INT NOT NULL,
    plantaDrop VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS semente (
    id INT PRIMARY KEY,
    bool_regou BOOLEAN NOT NULL,
    bool_livre BOOLEAN NOT NULL,
    diaAtual INT NOT NULL,
    prontoColher BOOLEAN NOT NULL,
    fk_jogador_id SERIAL NOT NULL,
    fk_instancia_planta_id INT NOT NULL,
    FOREIGN KEY (fk_jogador_id) REFERENCES Jogador(id),
    FOREIGN KEY (fk_instancia_planta_id) REFERENCES Instancia_de_Planta(id)
);

CREATE TABLE IF NOT EXISTS solo (
    tipo_recurso VARCHAR(50) NOT NULL,
    fk_jogador_id SERIAL NOT NULL,
    FOREIGN KEY (fk_jogador_id) REFERENCES Jogador(id)
);

CREATE TABLE IF NOT EXISTS Missao (
    -- MUDANÇA EM RELAÇÃO AO DER/DICIONÁRIO:
    -- remove nome e descrição
    id_missao SERIAL PRIMARY KEY, 
    tipo VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS Combate (
    -- MUDANÇA EM RELAÇÃO AO DER/DICIONÁRIO:
    -- tipoInimigo VARCHAR(100) PRIMARY KEY -> tipo_Inimigo VARCHAR(50) FOREIGN KEY?
    tipo_Inimigo VARCHAR(50) NOT NULL,
    tipo VARCHAR(50) NOT NULL,
    nome VARCHAR(255) NOT NULL,
    descricao TEXT NOT NULL,
    FOREIGN KEY (tipo_Inimigo) REFERENCES Inimigo(tipo)
);

CREATE TABLE IF NOT EXISTS Coleta (
    -- MUDANÇA EM RELAÇÃO AO DER/DICIONÁRIO:
    -- tipoMaterial VARCHAR(100) PRIMARY KEY -> tipo_material VARCHAR(50) FOREIGN KEY?
    fk_tipo_material VARCHAR(50) NOT NULL,
    tipo VARCHAR(50) NOT NULL,
    nome VARCHAR(255) NOT NULL,
    descricao TEXT NOT NULL,
    FOREIGN KEY (tipo_material) REFERENCES mineral(tipo_minerio)
);

CREATE TABLE IF NOT EXISTS Instancia_Missao (
    id_Instancia_Missao  SERIAL PRIMARY KEY,
    fk_Missao INT NOT NULL,
    dataInicio INT NOT NULL,
    dataFinalizacao INT,
    FOREIGN KEY (Missao) REFERENCES Missao(id_missao)
);


CREATE TABLE IF NOT EXISTS Recompensa (
    id_Recompensa  SERIAL PRIMARY KEY,
    tipoItem VARCHAR(50) NOT NULL,
    quantidade INT NOT NULL,
    fk_Jogador_id INT NOT NULL,
    Instancia_Missao INT NOT NULL,
    FOREIGN KEY (Jogador_id) REFERENCES Jogador(id),
    FOREIGN KEY (Instancia_Missao) REFERENCES Instancia_Missao(id)
);

CREATE TABLE IF NOT EXISTS Caixa_Mensagem (
    id_Caixa_Mensagem  SERIAL PRIMARY KEY,
    Instancia_Missao INT NOT NULL,
    FOREIGN KEY (Instancia_Missao) REFERENCES Instancia_Missao(id)
);