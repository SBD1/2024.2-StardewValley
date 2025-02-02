-- Tabelas base sem dependências
CREATE TABLE IF NOT EXISTS Habilidade (
    id_habilidade SERIAL PRIMARY KEY,
    tipo VARCHAR(50) NOT NULL
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
    tipo_animal VARCHAR(50) NOT NULL,
    diasTotalDropar INT NOT NULL,
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
    localizacao_atual INT NOT NULL DEFAULT 1,                
    vidaMax FLOAT NOT NULL DEFAULT 10.0,         
    vidaAtual FLOAT NOT NULL DEFAULT 10.0,       
    xp_mineracao FLOAT NOT NULL DEFAULT 0.0,     
    xp_cultivo FLOAT NOT NULL DEFAULT 0.0,       
    xp_combate FLOAT NOT NULL DEFAULT 0.0,       
    dano_ataque FLOAT NOT NULL DEFAULT 10.0,
    moeda DECIMAL NOT NULL DEFAULT 100.0,       
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

CREATE TABLE IF NOT EXISTS estoque(
    id_estoque SERIAL PRIMARY KEY,
    fk_id_loja INTEGER NOT NULL,
    FOREIGN KEY (fk_id_loja) REFERENCES loja(fk_id_ambiente)
);

CREATE TABLE IF NOT EXISTS item (
    id_item SERIAL PRIMARY KEY,
    tipo_item VARCHAR(20) NOT NULL
);

CREATE TABLE IF NOT EXISTS instancia_de_item(
    id_instancia_de_item SERIAL PRIMARY KEY,
    fk_id_jogador INT NOT NULL,
    fk_id_item INT NOT NULL,
    fk_id_estoque INTEGER,
    fk_id_inventario INTEGER, 
    FOREIGN KEY (fk_id_item) REFERENCES item(id_item),
    FOREIGN KEY (fk_id_estoque) REFERENCES estoque(id_estoque),
    FOREIGN KEY (fk_id_inventario) REFERENCES inventario(id_inventario),
    FOREIGN KEY (fk_id_jogador) REFERENCES jogador(id_jogador)
);

CREATE TABLE IF NOT EXISTS mineral (
    fk_id_item INTEGER PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    descricao VARCHAR(100) NOT NULL,
    resistencia INTEGER NOT NULL,
    preco DECIMAL NOT NULL,
    FOREIGN KEY (fk_id_item) REFERENCES item(id_item)
);

CREATE TABLE IF NOT EXISTS Caverna(
    fk_id_ambiente INT NOT NULL PRIMARY KEY,
    andar INT NOT NULL,
    quantidade_mobs INT NOT NULL,
    qtd_minerio INT NOT NULL,
    fk_id_minerio_item INT NOT NULL,
    fk_id_item_recompensa INT NOT NULL,
    FOREIGN KEY (fk_id_ambiente) REFERENCES Ambiente(id_ambiente),
    FOREIGN KEY (fk_id_minerio_item) REFERENCES mineral(fk_id_item),
    FOREIGN KEY (fk_id_item_recompensa) REFERENCES item(id_item)
);

CREATE TABLE IF NOT EXISTS Celeiro (
    fk_id_ambiente INT NOT NULL PRIMARY KEY,
    qtd_animais INT NOT NULL DEFAULT 0,
    qtd_max_animais INT NOT NULL DEFAULT 10,
    FOREIGN KEY (fk_id_ambiente) REFERENCES Ambiente(id_ambiente)
);

CREATE TABLE IF NOT EXISTS Plantacao (
    fk_id_ambiente INT NOT NULL PRIMARY KEY,
    qtd_plantas INT NOT NULL DEFAULT 0,
    qtd_plantas_max INT NOT NULL DEFAULT 10,
    FOREIGN KEY (fk_id_ambiente) REFERENCES Ambiente(id_ambiente)
);

CREATE TABLE IF NOT EXISTS consumivel (
    fk_id_item INTEGER PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    descricao TEXT NOT NULL, -- add
    efeito_vida INT NOT NULL,
    FOREIGN KEY (fk_id_item) REFERENCES item(id_item)
);


CREATE TABLE IF NOT EXISTS ferramenta (
    fk_id_item INTEGER PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    descricao VARCHAR(100) NOT NULL,
    eficiencia INTEGER NOT NULL,
    FOREIGN KEY (fk_id_item) REFERENCES item(id_item)
);


CREATE TABLE IF NOT EXISTS arma (
    fk_id_item INTEGER PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    descricao VARCHAR(100) NOT NULL,
    dano_arma INTEGER,
    FOREIGN KEY (fk_id_item) REFERENCES item(id_item)
);

CREATE TABLE IF NOT EXISTS recurso (
    fk_id_item INTEGER PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    descricao VARCHAR(100) NOT NULL,
    preco DECIMAL NOT NULL,
    FOREIGN KEY (fk_id_item) REFERENCES item(id_item)
);

CREATE TABLE IF NOT EXISTS Instancia_de_Inimigo (
    id_instancia_de_inimigo SERIAL PRIMARY KEY,
    vidaAtual FLOAT NOT NULL,
    fk_id_ambiente INT,
    fk_inimigo_id INT NOT NULL,
    FOREIGN KEY (fk_inimigo_id) REFERENCES Inimigo(id_inimigo),
    FOREIGN KEY (fk_id_ambiente) REFERENCES Caverna(fk_id_ambiente)
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
    diaDropar INT NOT NULL
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

CREATE TABLE IF NOT EXISTS Missao (
    id_missao SERIAL PRIMARY KEY, 
    tipo VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS missao_combate (
    fk_id_missao INT NOT NULL PRIMARY KEY,
    fk_id_Inimigo INT NOT NULL,
    nome VARCHAR(255) NOT NULL,
    descricao TEXT NOT NULL,
    dataInicio INT NOT NULL,
    dataFinalizacao INT,
    FOREIGN KEY (fk_id_Inimigo) REFERENCES Inimigo(id_inimigo),
    FOREIGN KEY (fk_id_missao) REFERENCES Missao(id_missao)
);

CREATE TABLE IF NOT EXISTS missao_coleta (
    fk_id_missao INT NOT NULL PRIMARY KEY,
    fk_id_minerio INT NOT NULL,
    nome VARCHAR(255) NOT NULL,
    descricao TEXT NOT NULL,
    dataInicio INT NOT NULL,
    dataFinalizacao INT,
    FOREIGN KEY (fk_id_minerio) REFERENCES mineral(fk_id_item),
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

CREATE TABLE IF NOT EXISTS Recompensa (
    id_Recompensa  SERIAL PRIMARY KEY,
    fk_Jogador_id INT NOT NULL,
    fk_id_item INT NOT NULL,
    fk_Instancia_Missao INT NOT NULL,
    quantidade INT NOT NULL,
    FOREIGN KEY (fk_Jogador_id) REFERENCES Jogador(id_jogador),
    FOREIGN KEY (fk_id_item) REFERENCES item(id_item),
    FOREIGN KEY (fk_Instancia_Missao) REFERENCES Instancia_Missao(id_Instancia_Missao)
);


-- Triggers e Stored procedures

-- Trigger para garantir exclusividade entre ferramenta, arma, consumivel, mineral e recurso
-- Função para inserção automática
CREATE FUNCTION inserir_item(
    tipo_item_param VARCHAR(20),
    nome_param VARCHAR(100),
    descricao_param TEXT,
    eficiencia_param INTEGER DEFAULT NULL,
    dano_arma_param INTEGER DEFAULT NULL,
    efeito_vida_param INTEGER DEFAULT NULL,
    resistencia_param INTEGER DEFAULT NULL,
    preco_param DECIMAL DEFAULT NULL
)
RETURNS INTEGER AS $$
DECLARE
    item_id_result INTEGER;
BEGIN
    -- Inserir na tabela Item
    INSERT INTO item (tipo_item) VALUES (tipo_item_param) RETURNING id_item INTO item_id_result;

    -- Inserir na tabela correspondente
    IF tipo_item_param = 'ferramenta' THEN
        INSERT INTO ferramenta (fk_id_item, nome, descricao, eficiencia, nivel)
        VALUES (item_id_result, nome_param, descricao_param, eficiencia_param);
    ELSIF tipo_item_param = 'arma' THEN
        INSERT INTO arma (fk_id_item, nome, descricao, dano_arma)
        VALUES (item_id_result, nome_param, descricao_param, dano_arma_param);
    ELSIF tipo_item_param = 'consumivel' THEN
        INSERT INTO consumivel (fk_id_item, nome, descricao, efeito_vida)
        VALUES (item_id_result, nome_param, descricao_param, efeito_vida_param);
    ELSIF tipo_item_param = 'mineral' THEN
        INSERT INTO mineral (fk_id_item, nome, descricao, resistencia, preco)
        VALUES (item_id_result, nome_param, descricao_param, resistencia_param, preco_param);
    ELSIF tipo_item_param = 'recurso' THEN
        INSERT INTO recurso (fk_id_item, nome, descricao, preco)
        VALUES (item_id_result, nome_param, descricao_param, preco_param);
    END IF;

    RETURN item_id_result;
END;
$$ LANGUAGE plpgsql;

-- Trigger para garantir exclusividade entre ferramenta, arma, consumivel, mineral e recurso

CREATE OR REPLACE FUNCTION exclusividade_tipo_item()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.tipo_item = 'ferramenta' AND EXISTS (SELECT 1 FROM ferramenta WHERE fk_id_item = NEW.id_item) THEN
        RAISE EXCEPTION 'O item já está associado a uma ferramenta.';
    ELSIF NEW.tipo_item = 'arma' AND EXISTS (SELECT 1 FROM arma WHERE fk_id_item = NEW.id_item) THEN
        RAISE EXCEPTION 'O item já está associado a uma arma.';
    ELSIF NEW.tipo_item = 'consumivel' AND EXISTS (SELECT 1 FROM consumivel WHERE fk_id_item = NEW.id_item) THEN
        RAISE EXCEPTION 'O item já está associado a um consumível.';
    ELSIF NEW.tipo_item = 'mineral' AND EXISTS (SELECT 1 FROM mineral WHERE fk_id_item = NEW.id_item) THEN
        RAISE EXCEPTION 'O item já está associado a um mineral.';
    ELSIF NEW.tipo_item = 'recurso' AND EXISTS (SELECT 1 FROM recurso WHERE fk_id_item = NEW.id_item) THEN
        RAISE EXCEPTION 'O item já está associado a um recurso.';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER exclusividade_tipo_item_trigger
BEFORE INSERT ON item
FOR EACH ROW EXECUTE FUNCTION exclusividade_tipo_item();
