  ## Versionamento
  |Data|Versão|Autor|Alteração| 
  |----|------|---------|-----|
  |23/11/2024|1.0| [Manuella Valadares](https://github.com/manuvaladares)| Versão Inicial do Dicionário de Dados|
  |24/11/2024|1.1| [Gabriel Zaranza](https://github.com/GZaranza)| Ajustando colunas das tabelas|
  |24/11/2024|1.2| [Manuella Valadares](https://github.com/manuvaladares)| Principais relações feitas|
 
# Dicionário de Dados
<p style="text-align: justify"> É o conjunto dos vocábulos ou dos termos utilizados na descrição dos objetos modelados para o banco de dados. Os termos são dispostos com o seu respectivo significado para apresentar uma descrição textual da estrutura lógica e física do banco de dados.
</p>

<br/>

### Entidade: Jogador
#### Descrição: Personagem principal, será manuseado pelo jogador.

#### Campos:
| Nome          | Descrição                  | Tipo de dado | Tamanho | Restrições de domínio (PK, FK, NOT NULL, Unique, Identity, intervalo de valores) |
| :-----------: | :-----------------------:  | :----------: | :-----: | :----------------------------------------------------------------------------:   |
| id            | Identificador único do jogador | INT         | -       | PK, NOT NULL, Unique                                                              |
| nome          | Nome do jogador            | VARCHAR      | 255     | NOT NULL                                                                          |
| vidaAtual     | Quantidade atual de vida   | INT          | -       | NOT NULL                                                                          |
| vidaMax       | Quantidade máxima de vida  | INT          | -       | NOT NULL                                                                          |
| estamina      | Quantidade de energia      | INT          | -       | NOT NULL                                                                          |
| nível         | Nível atual do jogador     | INT          | -       | NOT NULL                                                                          |
| experiência   | Experiência acumulada      | INT          | -       | NOT NULL                                                                          |

---

### Entidade: Ambiente
#### Descrição: Representa os locais do jogo.

#### Campos:
| Nome          | Descrição                      | Tipo de dado | Tamanho | Restrições de domínio (PK, FK, NOT NULL, Unique, Identity, intervalo de valores) |
| :-----------: | :---------------------------: | :----------: | :-----: | :----------------------------------------------------------------------------:   |
| id_ambiente   | Identificador único do ambiente | INT         | -       | PK, NOT NULL, Unique                                                              |
| tipo          | Tipo do ambiente               | VARCHAR      | 50      | NOT NULL                                                                          |

---

### Entidade: Animal
#### Descrição: Representa os animais do jogo.

#### Campos:
| Nome           | Descrição                        | Tipo de dado | Tamanho | Restrições de domínio (PK, FK, NOT NULL, Unique, Identity, intervalo de valores) |
| :------------: | :-----------------------------: | :----------: | :-----: | :----------------------------------------------------------------------------:   |
| id             | Identificador único do animal   | INT          | -       | PK, NOT NULL, Unique                                                              |
| nome           | Nome do animal                  | VARCHAR      | 255     | NOT NULL                                                                          |
| diasTotalDropar| Dias até o animal gerar item    | INT          | -       | NOT NULL                                                                          |
| tipo           | Tipo do animal                  | VARCHAR      | 50      | NOT NULL                                                                          |
| itemDrop       | Item gerado pelo animal         | VARCHAR      | 255     | NOT NULL                                                                          |
| preço          | Valor do animal                 | FLOAT        | -       | NOT NULL                                                                          |

---

### Entidade: Minério_Bruto
#### Descrição: Representa os minérios brutos coletados no jogo.

#### Campos:
| Nome          | Descrição | Tipo de dado | Tamanho | Restrições de domínio (PK, FK, NOT NULL, Unique, Identity, intervalo de valores) |
| :-----------: | :-------: | :----------: | :-----: | :----------------------------------------------------------------------------:   |
|               |           |              |         |                                                                                  |

---

### Entidade: Loja
#### Descrição: Local onde os jogadores podem comprar e vender itens.

#### Campos:
| Nome          | Descrição                      | Tipo de dado | Tamanho | Restrições de domínio (PK, FK, NOT NULL, Unique, Identity, intervalo de valores) |
| :-----------: | :---------------------------: | :----------: | :-----: | :----------------------------------------------------------------------------:   |
| id_loja       | Identificador único da loja   | INT          | -       | PK, NOT NULL, Unique                                                              |
| proprietário  | Nome do proprietário da loja  | VARCHAR      | 255     | NOT NULL                                                                          |
| nome          | Nome da loja                  | VARCHAR      | 255     | NOT NULL                                                                          |
| descrição     | Breve descrição da loja       | TEXT         | -       | NOT NULL                                                                          |

### Entidade: Caverna  
#### Descrição: Representa as cavernas exploráveis no jogo.  

#### Campos:  
| Nome               | Descrição                          | Tipo de dado | Tamanho | Restrições de domínio (PK, FK, NOT NULL, Unique, Identity, intervalo de valores) |  
| :-----------------: | :-------------------------------: | :----------: | :-----: | :----------------------------------------------------------------------------:   |  
| andar              | Andar específico da caverna       | INT          | -       | NOT NULL                                                                          |  
| quantidade_mobs    | Quantidade de inimigos no andar   | INT          | -       | NOT NULL                                                                          |  
| minérios           | Tipos de minérios disponíveis     | VARCHAR      | 255     | NOT NULL                                                                          |  
| item_recompensa    | Recompensa obtida na exploração   | VARCHAR      | 255     |                                                                                  |  

---

### Entidade: CasaJogador  
#### Descrição: Representa a casa do jogador.  

#### Campos:  
| Nome               | Descrição                           | Tipo de dado | Tamanho | Restrições de domínio (PK, FK, NOT NULL, Unique, Identity, intervalo de valores) |  
| :-----------------: | :--------------------------------: | :----------: | :-----: | :----------------------------------------------------------------------------:   |  
| id                 | Identificador único da casa        | INT          | -       | PK, NOT NULL, Unique                                                              |  
| id_jogador         | Referência ao jogador proprietário | INT          | -       | FK, NOT NULL                                                                      |  

---

### Entidade: Celeiro  
#### Descrição: Local para alojar os animais do jogador.  

#### Campos:  
| Nome               | Descrição                           | Tipo de dado | Tamanho | Restrições de domínio (PK, FK, NOT NULL, Unique, Identity, intervalo de valores) |  
| :-----------------: | :--------------------------------: | :----------: | :-----: | :----------------------------------------------------------------------------:   |  
| id_celeiro         | Identificador único do celeiro     | INT          | -       | PK, NOT NULL, Unique                                                              |  
| qtd_animais        | Quantidade de animais alojados     | INT          | -       | NOT NULL                                                                          |  

---

### Entidade: Missão  
#### Descrição: Representa as missões disponíveis no jogo.  

#### Campos:  
| Nome               | Descrição                           | Tipo de dado | Tamanho | Restrições de domínio (PK, FK, NOT NULL, Unique, Identity, intervalo de valores) |  
| :-----------------: | :--------------------------------: | :----------: | :-----: | :----------------------------------------------------------------------------:   |  
| tipo               | Tipo da missão (combate ou coleta) | VARCHAR      | 50      | NOT NULL                                                                          |  
| nome               | Nome da missão                     | VARCHAR      | 255     | NOT NULL                                                                          |  
| descrição          | Descrição da missão                | TEXT         | -       |                                                                                  |  

---

### Entidade: Inventário  
#### Descrição: Armazena os itens coletados ou adquiridos pelo jogador.  

#### Campos:  
| Nome               | Descrição                           | Tipo de dado | Tamanho | Restrições de domínio (PK, FK, NOT NULL, Unique, Identity, intervalo de valores) |  
| :-----------------: | :--------------------------------: | :----------: | :-----: | :----------------------------------------------------------------------------:   |  
| id                 | Identificador único do inventário  | INT          | -       | PK, NOT NULL, Unique                                                              |  
| quantidade_item    | Quantidade de um determinado item  | INT          | -       | NOT NULL                                                                          |  

---

### Entidade: Item  
#### Descrição: Representa qualquer item do jogo.  

#### Campos:  
| Nome               | Descrição                           | Tipo de dado | Tamanho | Restrições de domínio (PK, FK, NOT NULL, Unique, Identity, intervalo de valores) |  
| :-----------------: | :--------------------------------: | :----------: | :-----: | :----------------------------------------------------------------------------:   |  
| id_item            | Identificador único do item        | INT          | -       | PK, NOT NULL, Unique                                                              |  
| nome               | Nome do item                       | VARCHAR      | 255     | NOT NULL                                                                          |  
| descrição          | Descrição do item                  | TEXT         | -       |                                                                                  |  
| id_categoria       | Categoria do item                  | INT          | -       | FK                                                                                |  
| tipo_item          | Tipo do item                       | VARCHAR      | 50      | NOT NULL                                                                          |  
| quantidade         | Quantidade disponível do item      | INT          | -       | NOT NULL                                                                          |  

---

### Entidade: Plantação  
#### Descrição: Representa as áreas cultiváveis no jogo.  

#### Campos:  
| Nome               | Descrição                           | Tipo de dado | Tamanho | Restrições de domínio (PK, FK, NOT NULL, Unique, Identity, intervalo de valores) |  
| :-----------------: | :--------------------------------: | :----------: | :-----: | :----------------------------------------------------------------------------:   |  
| qtd_plantas        | Quantidade de plantas cultivadas   | INT          | -       | NOT NULL                                                                          |  

---

### Entidade: Semente  
#### Descrição: Representa as sementes plantáveis no jogo.  

#### Campos:  
| Nome               | Descrição                           | Tipo de dado | Tamanho | Restrições de domínio (PK, FK, NOT NULL, Unique, Identity, intervalo de valores) |  
| :-----------------: | :--------------------------------: | :----------: | :-----: | :----------------------------------------------------------------------------:   |  
| id                 | Identificador único da semente     | INT          | -       | PK, NOT NULL, Unique                                                              |  
| bool_regou         | Indica se a planta foi regada      | BOOLEAN      | -       | NOT NULL                                                                          |  
| bool_livre         | Indica se a semente pode ser colhida| BOOLEAN      | -       | NOT NULL                                                                          |  
| diaAtual           | Dia atual da semente               | INT          | -       | NOT NULL                                                                          |  
| diaDropar          | Dia previsto para colheita         | INT          | -       | NOT NULL                                                                          |  
| prontoColher       | Indica se está pronta para colher  | BOOLEAN      | -       | NOT NULL                                                                          |  

---
### Entidade: Recompensa  
#### Descrição: Representa as recompensas obtidas no jogo.  

#### Campos:  
| Nome               | Descrição                           | Tipo de dado | Tamanho | Restrições de domínio (PK, FK, NOT NULL, Unique, Identity, intervalo de valores) |  
| :-----------------: | :--------------------------------: | :----------: | :-----: | :----------------------------------------------------------------------------:   |  
| id                 | Identificador único da recompensa  | INT          | -       | PK, NOT NULL, Unique                                                              |  
| tipoItem           | Tipo do item da recompensa         | VARCHAR      | 50      | NOT NULL                                                                          |  
| quantidade         | Quantidade do item                 | INT          | -       | NOT NULL                                                                          |  

---

### Entidade: Animal  
#### Descrição: Representa os animais do jogo.  

#### Campos:  
| Nome               | Descrição                           | Tipo de dado | Tamanho | Restrições de domínio (PK, FK, NOT NULL, Unique, Identity, intervalo de valores) |  
| :-----------------: | :--------------------------------: | :----------: | :-----: | :----------------------------------------------------------------------------:   |  
| id                 | Identificador único do animal      | INT          | -       | PK, NOT NULL, Unique                                                              |  
| nome               | Nome do animal                     | VARCHAR      | 255     | NOT NULL                                                                          |  
| diasTotalDropar    | Dias necessários para dropar itens | INT          | -       | NOT NULL                                                                          |  
| tipo               | Tipo do animal                     | VARCHAR      | 50      | NOT NULL                                                                          |  
| itemDrop           | Item que o animal fornece          | VARCHAR      | 255     | NOT NULL                                                                          |  
| preço              | Preço do animal                    | DECIMAL      | -       |                                                                                  |  

---

### Entidade: InstânciaAnimal  
#### Descrição: Representa uma instância específica de um animal no jogo.  

#### Campos:  
| Nome               | Descrição                           | Tipo de dado | Tamanho | Restrições de domínio (PK, FK, NOT NULL, Unique, Identity, intervalo de valores) |  
| :-----------------: | :--------------------------------: | :----------: | :-----: | :----------------------------------------------------------------------------:   |  
| id                 | Identificador único da instância   | INT          | -       | PK, NOT NULL, Unique                                                              |  
| diaAtual           | Dia atual da instância do animal   | INT          | -       | NOT NULL                                                                          |  
| prontoDropar       | Indica se está pronto para dropar  | BOOLEAN      | -       | NOT NULL                                                                          |  

---

### Entidade: Inimigo  
#### Descrição: Representa os inimigos encontrados no jogo.  

#### Campos:  
| Nome               | Descrição                           | Tipo de dado | Tamanho | Restrições de domínio (PK, FK, NOT NULL, Unique, Identity, intervalo de valores) |  
| :-----------------: | :--------------------------------: | :----------: | :-----: | :----------------------------------------------------------------------------:   |  
| id                 | Identificador único do inimigo     | INT          | -       | PK, NOT NULL, Unique                                                              |  
| nome               | Nome do inimigo                    | VARCHAR      | 255     | NOT NULL                                                                          |  
| tipo               | Tipo de inimigo                    | VARCHAR      | 50      | NOT NULL                                                                          |  
| vida               | Quantidade de vida do inimigo      | INT          | -       | NOT NULL                                                                          |  
| dano               | Dano causado pelo inimigo          | INT          | -       | NOT NULL                                                                          |  

---

### Entidade: InstânciaInimigo  
#### Descrição: Representa uma instância específica de um inimigo no jogo.  

#### Campos:  
| Nome               | Descrição                           | Tipo de dado | Tamanho | Restrições de domínio (PK, FK, NOT NULL, Unique, Identity, intervalo de valores) |  
| :-----------------: | :--------------------------------: | :----------: | :-----: | :----------------------------------------------------------------------------:   |  
| id                 | Identificador único da instância   | INT          | -       | PK, NOT NULL, Unique                                                              |  
| id_inimigo         | Referência ao inimigo base         | INT          | -       | FK, NOT NULL                                                                      |  
| vidaAtual          | Quantidade de vida atual           | INT          | -       | NOT NULL                                                                          |  

---

### Entidade: Loja  
#### Descrição: Representa as lojas disponíveis no jogo.  

#### Campos:  
| Nome               | Descrição                           | Tipo de dado | Tamanho | Restrições de domínio (PK, FK, NOT NULL, Unique, Identity, intervalo de valores) |  
| :-----------------: | :--------------------------------: | :----------: | :-----: | :----------------------------------------------------------------------------:   |  
| id_loja            | Identificador único da loja        | INT          | -       | PK, NOT NULL, Unique                                                              |  
| proprietário       | Proprietário da loja               | VARCHAR      | 255     | NOT NULL                                                                          |  
| nome               | Nome da loja                       | VARCHAR      | 255     | NOT NULL                                                                          |  
| descrição          | Descrição da loja                  | TEXT         | -       |                                                                                  |  

---

### Entidade: Mineral  
#### Descrição: Representa os minerais coletáveis no jogo.  

#### Campos:  
| Nome               | Descrição                           | Tipo de dado | Tamanho | Restrições de domínio (PK, FK, NOT NULL, Unique, Identity, intervalo de valores) |  
| :-----------------: | :--------------------------------: | :----------: | :-----: | :----------------------------------------------------------------------------:   |  
| tipo_minério       | Tipo de minério                    | VARCHAR      | 50      | NOT NULL                                                                          |  
| preço              | Preço do minério                   | DECIMAL      | -       | NOT NULL                                                                          |  

---

### Entidade: Caixa de Mensagem  
#### Descrição: Representa as caixas de mensagem usadas no jogo.  

#### Campos:  
| Nome               | Descrição                           | Tipo de dado | Tamanho | Restrições de domínio (PK, FK, NOT NULL, Unique, Identity, intervalo de valores) |  
| :-----------------: | :--------------------------------: | :----------: | :-----: | :----------------------------------------------------------------------------:   |  
| id_caixa           | Identificador único da caixa       | INT          | -       | PK, NOT NULL, Unique                                                              |  

---  

