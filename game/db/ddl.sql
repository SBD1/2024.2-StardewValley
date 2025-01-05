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
  -- id_ambiente (FK)
);


CREATE TABLE IF NOT EXISTS jogador (
  id_jogador SERIAL PRIMARY KEY,
  nome VARCHAR(255) NOT NULL,
  vidaAtual INTEGER NOT NULL,
  vidaMax INTEGER NOT NULL,
  estamina INTEGER NOT NULL,
  nivel INTEGER NOT NULL,
  experiencia INTEGER NOT NULL
);

CREATE TABLE IF NOT EXISTS estoque_produto (
  id_estoque_produto SERIAL PRIMARY KEY,
  produto VARCHAR(255) NOT NULL,
  preço DECIMAL NOT NULL
);

CREATE TABLE IF NOT EXISTS inventario (
  id_inventario SERIAL PRIMARY KEY,
  id_jogador INTEGER NOT NULL,
  quantidade_item INTEGER NOT NULL,
  FOREIGN KEY (id_jogador) REFERENCES jogador(id_jogador)
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
