# Definição e Apresentação do DDL


## Tabelas

### 1. Tabelas Base (Sem Dependências)

#### **Habilidade**

```sql
CREATE TABLE IF NOT EXISTS Habilidade (
    id_habilidade SERIAL PRIMARY KEY,
    tipo VARCHAR(50) NOT NULL
);
```

```sql
CREATE TABLE IF NOT EXISTS Historia(
    dia INT PRIMARY KEY,
    historia TEXT NOT NULL
);
```

#### **Inimigo**

```sql
CREATE TABLE IF NOT EXISTS Inimigo (
    id_inimigo SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    tipo VARCHAR(50) NOT NULL,
    vidaMax FLOAT NOT NULL, 
    dano FLOAT NOT NULL,
    xp_recompensa INT NOT NULL
);
```

### 2. Tabelas com Dependências Diretas

#### **Animal**

```sql
CREATE TABLE IF NOT EXISTS Animal (
    id_animal SERIAL PRIMARY KEY,
    tipo_animal VARCHAR(50) NOT NULL,
    diasTotalDropar INT NOT NULL,
    itemDrop INTEGER,
    preco FLOAT NOT NULL,
    FOREIGN KEY (itemDrop) REFERENCES item(id_item)
);
```

#### **habMineracao**

```sql
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
```

#### **habCombate**

```sql
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
```

#### **habCultivo**

```sql
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

```

#### **Jogador**

```sql
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
```

#### **Inventário**

```sql
CREATE TABLE IF NOT EXISTS inventario (
    id_inventario SERIAL PRIMARY KEY,
    fk_id_jogador INTEGER NOT NULL,
    FOREIGN KEY (fk_id_jogador) REFERENCES Jogador(id_jogador)
);
```

### 3. Tabelas com Dependências Complexas

#### **Ambiente**

```sql
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
```

#### **Estoque**

```sql
CREATE TABLE IF NOT EXISTS estoque(
    fk_id_loja INTEGER NOT NULL,
    fk_id_item INTEGER NOT NULL,
    FOREIGN KEY (fk_id_loja) REFERENCES loja(fk_id_ambiente),
    FOREIGN KEY (fk_id_item) REFERENCES Item(id_item)
);
```

#### **Item**

```sql
CREATE TABLE IF NOT EXISTS item (
    id_item SERIAL PRIMARY KEY,
    tipo_item VARCHAR(20) NOT NULL
);
```

#### **Mineral**

```sql
CREATE TABLE IF NOT EXISTS mineral (
    fk_id_item INTEGER PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    descricao VARCHAR(100) NOT NULL,
    resistencia INTEGER NOT NULL,
    preco DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (fk_id_item) REFERENCES item(id_item)
);
```

#### **Caverna**

```sql
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
```

#### **Celeiro**

```sql
CREATE TABLE IF NOT EXISTS Celeiro (
    fk_id_ambiente INT NOT NULL PRIMARY KEY,
    qtd_max_animais INT NOT NULL DEFAULT 10,
    FOREIGN KEY (fk_id_ambiente) REFERENCES Ambiente(id_ambiente)
);
```

#### **Plantação**

```sql
CREATE TABLE IF NOT EXISTS Plantacao (
    fk_id_ambiente INT NOT NULL PRIMARY KEY,
    qtd_plantas_max INT NOT NULL DEFAULT 15,
    FOREIGN KEY (fk_id_ambiente) REFERENCES Ambiente(id_ambiente)
);
```

#### **Loja**

```sql
CREATE TABLE IF NOT EXISTS loja (
    fk_id_ambiente INTEGER NOT NULL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    proprietario VARCHAR(100) NOT NULL,
    FOREIGN KEY (fk_id_ambiente) REFERENCES Ambiente(id_ambiente)
);
```

#### **Consumível**

```sql
CREATE TABLE IF NOT EXISTS consumivel (
    fk_id_item INTEGER PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    descricao TEXT NOT NULL, -- add
    efeito_vida INT NOT NULL,
    preco DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (fk_id_item) REFERENCES item(id_item)
);
```

#### **Ferramenta**

```sql
CREATE TABLE IF NOT EXISTS ferramenta (
    fk_id_item INTEGER PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    descricao VARCHAR(100) NOT NULL,
    eficiencia INTEGER NOT NULL,
    preco DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (fk_id_item) REFERENCES item(id_item)
);
```

#### **Arma**

```sql
CREATE TABLE IF NOT EXISTS arma (
    fk_id_item INTEGER PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    descricao VARCHAR(100) NOT NULL,
    dano_arma INTEGER,
    preco DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (fk_id_item) REFERENCES item(id_item)
);
```

#### **Recurso**

```sql
CREATE TABLE IF NOT EXISTS recurso (
    fk_id_item INTEGER PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    descricao VARCHAR(100) NOT NULL,
    preco DECIMAL(10,2) NOT NULL,
    raridade INTEGER NOT NULL,
    FOREIGN KEY (fk_id_item) REFERENCES item(id_item)
);
```

#### **Instância de Inimigo**

```sql
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
```

#### **Instância de Animal**

```sql
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
```

#### **Instância de Item**

```sql
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
```

#### **Planta**

```sql
CREATE TABLE IF NOT EXISTS Planta (
    id_planta SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    descricao VARCHAR(100) NOT NULL,
    diaDropar INT NOT NULL,
    preco DECIMAL(10,2) NOT NULL,
    itemDrop INTEGER,
    FOREIGN KEY (itemDrop) REFERENCES item(id_item)
);
```

#### **Instância de Planta**

```sql
CREATE TABLE IF NOT EXISTS Instancia_de_Planta (
    id_instancia_de_planta INT PRIMARY KEY,
    nome VARCHAR(50) NOT NULL,
    diaDropar INT NOT NULL,
    plantaDrop VARCHAR(50) NOT NULL
);
```


| Data | Versão | Autor | Alterações |
| :--: | :----: | ----- | ---------- |
| 13/01/2024 | `1.0` | [Marcos Vieira Marinho](https://github.com/devMarcosVM)| Versão inicial do documento |
| 10/02/2024 | `1.1` | [Isaac Batista](https://github.com/isaacbatista26) | Versão final do documento |