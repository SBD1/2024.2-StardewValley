# Definição e Apresentação do DDL

## O que é DDL?

DDL (“Data Definition Language”) é uma linguagem usada para definir e manipular a estrutura de dados em um banco de dados. Com ela, podemos criar, alterar e excluir tabelas, índices e outras estruturas relacionadas à organização dos dados.

No contexto deste projeto, o DDL foi usado para criar as tabelas necessárias para representar entidades, relações e suas dependências. Abaixo, apresentamos as definições das tabelas com descrições organizadas.

---

## Tabelas Criadas

### 1. Tabelas Base (Sem Dependências)

#### **Habilidade**

```sql
CREATE TABLE IF NOT EXISTS Habilidade (
    id_habilidade SERIAL PRIMARY KEY,
    tipo VARCHAR(50) NOT NULL
);
```

#### **Mapa**

```sql
CREATE TABLE IF NOT EXISTS Mapa (
    id_mapa SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL
);
```

#### **Inimigo**

```sql
CREATE TABLE IF NOT EXISTS Inimigo (
    id_inimigo SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    tipo VARCHAR(50) NOT NULL,
    vidaMax INT NOT NULL, 
    dano INT NOT NULL
);
```

#### **Animal**

```sql
CREATE TABLE IF NOT EXISTS Animal (
    id_animal SERIAL PRIMARY KEY,
    nome_animal VARCHAR(100),
    diasTotalDropar INT NOT NULL,
    tipo_animal VARCHAR(50) NOT NULL,
    itemDrop VARCHAR(100) NOT NULL,
    preco FLOAT NOT NULL
);
```

### 2. Tabelas com Dependências Diretas

#### **habMineracao**

```sql
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
```

#### **habCombate**

```sql
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
```

#### **habCultivo**

```sql
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
```

#### **Jogador**

```sql
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
```

#### **Estoque**

```sql
CREATE TABLE IF NOT EXISTS estoque (
    id_estoque SERIAL PRIMARY KEY
);
```

#### **Item**

```sql
CREATE TABLE IF NOT EXISTS item (
    id_item SERIAL PRIMARY KEY,
    tipo_item VARCHAR(20) NOT NULL,
    fk_estoque INTEGER DEFAULT 0,
    fk_inventario_id INTEGER DEFAULT 0,
    FOREIGN KEY (fk_inventario_id) REFERENCES inventario(id_inventario),
    FOREIGN KEY (fk_estoque) REFERENCES estoque(id_estoque)
);
```

#### **Mineral**

```sql
CREATE TABLE IF NOT EXISTS mineral (
    id_item INTEGER PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    descricao VARCHAR(100) NOT NULL,
    resistencia INTEGER NOT NULL,
    preco DECIMAL NOT NULL,
    FOREIGN KEY (id_item) REFERENCES item(id_item)
);
```

#### **Caverna**

```sql
CREATE TABLE IF NOT EXISTS Caverna (
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
```

#### **Celeiro**

```sql
CREATE TABLE IF NOT EXISTS Celeiro (
    id_celeiro SERIAL PRIMARY KEY,
    qtd_animais INT NOT NULL DEFAULT 0,
    qtd_max_animais INT NOT NULL DEFAULT 10,
    fk_id_ambiente INT NOT NULL,
    FOREIGN KEY (fk_id_ambiente) REFERENCES Ambiente(id_ambiente)
);
```

#### **Plantação**

```sql
CREATE TABLE IF NOT EXISTS Plantacao (
    id_plantacao SERIAL PRIMARY KEY,
    qtd_plantas INT NOT NULL DEFAULT 0,
    qtd_plantas_max INT NOT NULL DEFAULT 10,
    fk_id_ambiente INT NOT NULL,
    FOREIGN KEY (fk_id_ambiente) REFERENCES Ambiente(id_ambiente)
);
```

#### **Loja**

```sql
CREATE TABLE IF NOT EXISTS loja (
    id_loja INT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    proprietario VARCHAR(100) NOT NULL,
    fk_id_ambiente INT NOT NULL,
    fk_id_estoque INT NOT NULL,
    FOREIGN KEY (fk_id_ambiente) REFERENCES Ambiente(id_ambiente),
    FOREIGN KEY (fk_id_estoque) REFERENCES estoque(id_estoque)
);
```

#### **Consumível**

```sql
CREATE TABLE IF NOT EXISTS consumivel (
    id_item INTEGER PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    descricao TEXT NOT NULL,
    efeito_vida INT NOT NULL,
    FOREIGN KEY (id_item) REFERENCES item(id_item)
);
```

#### **Utensílio**

```sql
CREATE TABLE IF NOT EXISTS utensilio (
    id_item INTEGER PRIMARY KEY,
    tipo_utensilio VARCHAR(100) NOT NULL,
    FOREIGN KEY (id_item) REFERENCES item(id_item)
);
```

#### **Ferramenta**

```sql
CREATE TABLE IF NOT EXISTS ferramenta (
    id_item INTEGER PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    descricao VARCHAR(100) NOT NULL,
    fk_id_utensilio INTEGER NOT NULL,
    eficiencia INTEGER NOT NULL,
    nivel INTEGER NOT NULL,
    FOREIGN KEY (id_item) REFERENCES item(id_item),
    FOREIGN KEY (fk_id_utensilio) REFERENCES utensilio(id_item)
);
```

#### **Arma**

```sql
CREATE TABLE IF NOT EXISTS arma (
    id_item INTEGER PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    descricao VARCHAR(100) NOT NULL,
    fk_id_utensilio INTEGER NOT NULL, 
    FOREIGN KEY (id_item) REFERENCES item(id_item),
    FOREIGN KEY (fk_id_utensilio) REFERENCES utensilio(id_item)
);
```

#### **Recurso**

```sql
CREATE TABLE IF NOT EXISTS recurso (
    id_item INTEGER PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    descricao VARCHAR(100) NOT NULL,
    preco DECIMAL NOT NULL,
    FOREIGN KEY (id_item) REFERENCES item(id_item)
);
```

#### **Instância de Inimigo**

```sql
CREATE TABLE IF NOT EXISTS Instancia_de_Inimigo (
    id_instancia_de_inimigo SERIAL PRIMARY KEY,
    vidaAtual FLOAT NOT NULL,
    fk_Caverna_andar INT,
    fk_inimigo_id INT NOT NULL,
    FOREIGN KEY (fk_inimigo_id) REFERENCES Inimigo(id_inimigo),
    FOREIGN KEY (fk_Caverna_andar) REFERENCES Caverna(andar)
);
```

#### **Instância de Animal**

```sql
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

#### **Semente**

```sql
CREATE TABLE IF NOT EXISTS semente (
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
```

#### **Solo**

```sql
CREATE TABLE IF NOT EXISTS solo (
    id_solo SERIAL PRIMARY KEY,
    tipo_recurso VARCHAR(50) NOT NULL,
    fk_id_plantacao INT NOT NULL,
    bool_regou BOOLEAN NOT NULL,
    bool_livre BOOLEAN NOT NULL,
    FOREIGN KEY (fk_id_plantacao) REFERENCES Plantacao(id_plantacao)
);
```

#### **Missão**

```sql
CREATE TABLE IF NOT EXISTS Missao (
    id_missao SERIAL PRIMARY KEY, 
    tipo VARCHAR(50) NOT NULL
);
```

#### **Missão de Combate**

```sql
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
```

#### **Missão de Coleta**

```sql
CREATE TABLE IF NOT EXISTS missao_coleta (
    fk_id_missao INT NOT NULL PRIMARY KEY,
    fk_id_minerio INT NOT NULL,
    nome VARCHAR(255) NOT NULL,
    descricao TEXT NOT NULL,
    dataInicio INT NOT NULL,
    dataFinalizacao INT,
    FOREIGN KEY (fk_id_minerio) REFERENCES mineral(id_item),
    FOREIGN KEY (fk_id_missao) REFERENCES Missao(id_missao)
);
```

#### **Instância de Missão**

```sql
CREATE TABLE IF NOT EXISTS Instancia_Missao (
    id_Instancia_Missao SERIAL PRIMARY KEY,
    fk_id_jogador INT NOT NULL,
    fk_Missao INT NOT NULL,
    missao_finalizada BOOLEAN NOT NULL DEFAULT false,
    FOREIGN KEY (fk_Missao) REFERENCES Missao(id_missao),
    FOREIGN KEY (fk_id_jogador) REFERENCES Jogador(id_jogador)
);
```

#### **Recompensa**

```sql
CREATE TABLE IF NOT EXISTS Recompensa (
    id_Recompensa  SERIAL PRIMARY KEY,
    fk_Jogador_id INT NOT NULL,
    id_item INT NOT NULL,
    fk_Instancia_Missao INT NOT NULL,
    quantidade INT NOT NULL,
    FOREIGN KEY (fk_Jogador_id) REFERENCES Jogador(id_jogador),
    FOREIGN KEY (id_item) REFERENCES item(id_item),
    FOREIGN KEY (fk_Instancia_Missao) REFERENCES Instancia_Missao(id_Instancia_Missao)
);
```

#### **Caixa de Mensagem**

```sql
CREATE TABLE IF NOT EXISTS Caixa_Mensagem (
    fk_Jogador_id INT NOT NULL,
    id_Caixa_Mensagem SERIAL PRIMARY KEY,
    fk_Instancia_Missao INT NOT NULL,
    FOREIGN KEY (fk_Instancia_Missao) REFERENCES Instancia_Missao(id_Instancia_Missao),
    FOREIGN KEY (fk_Jogador_id) REFERENCES Jogador(id_jogador)
);
```

#### **Casa do Jogador**

```sql
CREATE TABLE IF NOT EXISTS Casa_Jogador (
    fk_id_ambiente INT NOT NULL,
    fk_id_caixa_mensagem INT NOT NULL,
    FOREIGN KEY (fk_id_ambiente) REFERENCES Ambiente(id_ambiente),
    FOREIGN KEY (fk_id_caixa_mensagem) REFERENCES Caixa_Mensagem(id_Caixa_Mensagem)
);
```

| Data | Versão | Autor | Alterações |
| :--: | :----: | ----- | ---------- |
| 13/01/2024 | `1.0` | [Marcos Vieira Marinho](https://github.com/devMarcosVM)| Versão inicial do documento |
