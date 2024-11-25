# Dicionário de Dados
<p style="text-align: justify"> É o conjunto dos vocábulos ou dos termos utilizados na descrição dos objetos modelados para o banco de dados. Os termos são dispostos com o seu respectivo significado para apresentar uma descrição textual da estrutura lógica e física do banco de dados.
</p>

<br/>

### Entidade: Jogador
#### Descrição: Personagem principal, será manuseado pelo jogador.

#### Campos:
| Nome          | Descrição                  | Tipo de dado | Tamanho | Restrições de domínio (PK, FK, NOT NULL, Unique, Identity, intervalo de valores) |
| :-----------: | :-----------------------:  | :----------: | :-----: | :----------------------------------------------------------------------------:   |
| id            | Identificador único do jogador | INT         | -       | PK, NOT NULL, Identity                                                             |
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
| id_ambiente   | Identificador único do ambiente | INT         | -       | PK, NOT NULL, Identity                                                            |
| tipo          | Tipo do ambiente               | VARCHAR      | 50      | NOT NULL                                                                          |
| idMapa        | Identificador único do mapa    | INT          |         | FK, NOT NULL,Unique|
|Jogador_id     | identificador único do jogador | INT          |         |FK, NOT NULL, Unique|
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
| idMinérioBruto| Identificador do minério| INT|         | PK, NOT NULL, Identity                                                                                |
| bool_minerado | Verificação de extração | BOOLEAN  || NOT NULL
|tipo_minério | Tipo do mínerio           | VARCHAR | 50|FK, NOT NULL |
|Jogador_id | Identificador único do Jogador | INT | | FK, NOT NULL, Unique|
---

### Entidade: Loja
#### Descrição: Local onde os jogadores podem comprar e vender itens.

#### Campos:
| Nome          | Descrição                      | Tipo de dado | Tamanho | Restrições de domínio (PK, FK, NOT NULL, Unique, Identity, intervalo de valores) |
| :-----------: | :---------------------------: | :----------: | :-----: | :----------------------------------------------------------------------------:   |
| id_loja       | Identificador único da loja   | INT          | -       | PK, NOT NULL, Identity                                                           |
| proprietário  | Nome do proprietário da loja  | VARCHAR      | 255     | NOT NULL                                                                          |
| nome          | Nome da loja                  | VARCHAR      | 255     | NOT NULL                                                                          |
| descrição     | Breve descrição da loja       | TEXT         | -       | NOT NULL                                                                          |
| id_ambiente    | Identificador único do ambiente       | INT          | -       | FK, Unique, NOT NULL                                                                          |

### Entidade: Caverna  
#### Descrição: Representa as cavernas exploráveis no jogo.  

#### Campos:  
| Nome               | Descrição                          | Tipo de dado | Tamanho | Restrições de domínio (PK, FK, NOT NULL, Unique, Identity, intervalo de valores) |  
| :-----------------: | :-------------------------------: | :----------: | :-----: | :----------------------------------------------------------------------------:   |  
| andar              | Andar específico da caverna       | INT          | -       | PK, NOT NULL, Unique                                                                          |  
| quantidade_mobs    | Quantidade de inimigos no andar   | INT          | -       | NOT NULL                                                                          |  
| minérios           | Tipos de minérios disponíveis     | VARCHAR      | 255     | NOT NULL                                                                          |  
| item_recompensa    | Recompensa obtida na exploração   | VARCHAR      | 255     |                                                                                  |  
| id_ambiente    | Identificador único do ambiente       | INT          | -       | FK, Unique, NOT NULL                                                                          |
---

### Entidade: CasaJogador  
#### Descrição: Representa a casa do jogador.  

#### Campos:  
| Nome               | Descrição                           | Tipo de dado | Tamanho | Restrições de domínio (PK, FK, NOT NULL, Unique, Identity, intervalo de valores) |  
| :-----------------: | :--------------------------------: | :----------: | :-----: | :----------------------------------------------------------------------------:   |
| id_ambiente    | Identificador único do ambiente       | INT          | -       | FK, Unique, NOT NULL                                                                          |
---

### Entidade: Celeiro  
#### Descrição: Local para alojar os animais do jogador.  

#### Campos:  
| Nome               | Descrição                           | Tipo de dado | Tamanho | Restrições de domínio (PK, FK, NOT NULL, Unique, Identity, intervalo de valores) |  
| :-----------------: | :--------------------------------: | :----------: | :-----: | :----------------------------------------------------------------------------:   |  
| id_celeiro         | Identificador único do celeiro     | INT          | -       | PK, NOT NULL, Unique                                                              |  
| qtd_animais        | Quantidade de animais alojados     | INT          | -       | NOT NULL                                                                          |  
| id_ambiente        | Identificador único do ambiente       | INT          | -       | FK, Unique, NOT NULL                                                           |
---

### Entidade: Missão  
#### Descrição: Representa as missões disponíveis no jogo.  

#### Campos:  
| Nome               | Descrição                           | Tipo de dado | Tamanho | Restrições de domínio (PK, FK, NOT NULL, Unique, Identity, intervalo de valores) |  
| :-----------------: | :--------------------------------: | :----------: | :-----: | :----------------------------------------------------------------------------:   |  
| id_missão    | Identificador único da missão      | INT          | -       | PK, Identity, NOT NULL                                                                          | 
| tipo               | Tipo da missão (combate ou coleta) | VARCHAR      | 50      | NOT NULL                                                                          |  
| nome               | Nome da missão                     | VARCHAR      | 255     | NOT NULL                                                                          |  
| descrição          | Descrição da missão                | TEXT         | -       |                                                                                  | 

---
### Entidade: Instância Missão  
#### Descrição: Representa unitariamente as missões do jogo.  

#### Campos:  
| Nome               | Descrição                           | Tipo de dado | Tamanho | Restrições de domínio (PK, FK, NOT NULL, Unique, Identity, intervalo de valores) |  
| :-----------------: | :--------------------------------: | :----------: | :-----: | :----------------------------------------------------------------------------:   |  
| Missão    | Identificador da missão      | INT          | -       | FK, NOT NULL                                                                          | 
| id               | Identificador único da missão | INT      | -      | PK, NOT NULL                                                                          |  
| dataInicio               | Dia do início da missão     |INT       | -     | NOT NULL                                                                          |  
| dataFinalização          | Dia do conclusão da missão                | INT        | -       |                       | 

---

### Entidade: Inventário  
#### Descrição: Armazena os itens coletados ou adquiridos pelo jogador.  

#### Campos:  
| Nome               | Descrição                           | Tipo de dado | Tamanho | Restrições de domínio (PK, FK, NOT NULL, Unique, Identity, intervalo de valores) |  
| :-----------------: | :--------------------------------: | :----------: | :-----: | :----------------------------------------------------------------------------:   |  
| id                 | Identificador único do inventário  | INT          | -       | PK, NOT NULL, Unique                                                              |  
| quantidade_item    | Quantidade de um determinado item  | INT          | -       | NOT NULL                                                                          |  
|Jogador_id | Identificador único do Jogador | INT | | FK, NOT NULL, Unique|
|Instância de Inimigo_id | Identificador único da Instância de Inimigo | INT | | FK, NOT NULL, Unique|
---

### Entidade: Item  
#### Descrição: Representa qualquer item do jogo.  

#### Campos:  
| Nome               | Descrição                           | Tipo de dado | Tamanho | Restrições de domínio (PK, FK, NOT NULL, Unique, Identity, intervalo de valores) |  
| :-----------------: | :--------------------------------: | :----------: | :-----: | :----------------------------------------------------------------------------:   |  
| id_item            | Identificador único do item        | INT          | -       | PK, NOT NULL, Identity                                                             |  
| nome               | Nome do item                       | VARCHAR      | 255     | NOT NULL                                                                          |  
| descrição          | Descrição do item                  | TEXT         | -       |                                                                                  |  
| id_categoria       | Categoria do item                  | INT          | -       | Unique, NOT NULL                                                             |  
| tipo_item          | Tipo do item                       | VARCHAR      | 50      | NOT NULL                                                                          |  
| quantidade         | Quantidade disponível do item      | INT          | -       | NOT NULL                                                                          |  
| Inventario_id         | Agrupamento de Itens      | VARCHAR          | 255      | FK                                                                         |
| Estoque_produto         | Itens em venda      | VARCHAR          | 255      | FK                                                                         |  
---

### Entidade: Plantação  
#### Descrição: Representa as áreas cultiváveis no jogo.  

#### Campos:  
| Nome               | Descrição                           | Tipo de dado | Tamanho | Restrições de domínio (PK, FK, NOT NULL, Unique, Identity, intervalo de valores) |  
| :-----------------: | :--------------------------------: | :----------: | :-----: | :----------------------------------------------------------------------------:   |  
| qtd_plantas        | Quantidade de plantas cultivadas   | INT          | -       | NOT NULL                                                                          |  
| id_ambiente        | Identificador único do ambiente       | INT          | -       | FK, Unique, NOT NULL                                                           |
---

### Entidade: Instância de Planta
#### Descrição: Representa as sementes plantáveis no jogo.  

#### Campos:  
| Nome               | Descrição                           | Tipo de dado | Tamanho | Restrições de domínio (PK, FK, NOT NULL, Unique, Identity, intervalo de valores) |  
| :-----------------: | :--------------------------------: | :----------: | :-----: | :----------------------------------------------------------------------------:   |  
| id                 | Identificador da instância de planta     | INT          | -       | PK, NOT NULL, Unique                                                              |  
| nome         | nome da planta a ser cultivada      | VARCHAR     | 50       | NOT NULL                                                                          |  
| diaDropar         | dia final do crescimento| INT      | -       | NOT NULL                                                                          |  
| plantaDrop          | consumível gerado               | VARCHAR         | 50       | NOT NULL                                                                          |  
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
| prontoColher       | Indica se está pronta para colher  | BOOLEAN      | -       | NOT NULL                                                                          |  
|Jogador_id | Identificador único do Jogador | INT | | FK, NOT NULL, Unique|
|Instancia de planta_id | Identificador da planta | INT | | FK, NOT NULL, Unique|
---

---

### Entidade: Recompensa  
#### Descrição: Representa as recompensas obtidas no jogo.  

#### Campos:  
| Nome               | Descrição                           | Tipo de dado | Tamanho | Restrições de domínio (PK, FK, NOT NULL, Unique, Identity, intervalo de valores) |  
| :-----------------: | :--------------------------------: | :----------: | :-----: | :----------------------------------------------------------------------------:   |  
| id                 | Identificador único da recompensa  | INT          | -       | PK, NOT NULL, Unique                                                              |  
| tipoItem           | Tipo do item da recompensa         | VARCHAR      | 50      | NOT NULL                                                                          |  
| quantidade         | Quantidade do item                 | INT          | -       | NOT NULL                                                                          |  
|Jogador_id | Identificador único do Jogador | INT | | FK, NOT NULL, Unique|
|Instância Missão | Identificador único da missão | INT | | FK, NOT NULL, Unique|
---

### Entidade: InstânciaAnimal  
#### Descrição: Representa uma instância específica de um animal no jogo.  

#### Campos:  
| Nome               | Descrição                           | Tipo de dado | Tamanho | Restrições de domínio (PK, FK, NOT NULL, Unique, Identity, intervalo de valores) |  
| :-----------------: | :--------------------------------: | :----------: | :-----: | :----------------------------------------------------------------------------:   |  
| id                 | Identificador único da instância   | INT          | -       | PK, NOT NULL, Identity                                                            |  
| diaAtual           | Dia atual da instância do animal   | INT          | -       | NOT NULL                                                                          |  
| prontoDropar       | Indica se está pronto para dropar  | BOOLEAN      | -       | NOT NULL                                                                          |  
|Jogador_id | Identificador único do Jogador | INT | | FK, NOT NULL, Unique|
| Animal_id             | Identificador único do animal   | INT          | -       | FK, NOT NULL, Unique                                                              |
| id_celeiro         | Identificador único do celeiro     | INT          | -       | FK, NOT NULL, Unique                                                              |  
---

### Entidade: Inimigo  
#### Descrição: Representa os inimigos encontrados no jogo.  

#### Campos:  
| Nome               | Descrição                           | Tipo de dado | Tamanho | Restrições de domínio (PK, FK, NOT NULL, Unique, Identity, intervalo de valores) |  
| :-----------------: | :--------------------------------: | :----------: | :-----: | :----------------------------------------------------------------------------:   |  
| id                 | Identificador único do inimigo     | INT          | -       | PK, NOT NULL, Unique                                                              |  
| nome               | Nome do inimigo                    | VARCHAR      | 255     | NOT NULL                                                                          |  
| tipo               | Tipo de inimigo                    | VARCHAR      | 50      | NOT NULL                                                                          |  
| vidaMax            | Quantidade de vida do inimigo      | INT          | -       | NOT NULL                                                                          |  
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
| tipo               | Tipo de inimigo                    | VARCHAR      | 50      | NOT NULL                                                                          |  


### Entidade: Mineral  
#### Descrição: Representa os minerais coletáveis no jogo.  

#### Campos:  
| Nome               | Descrição                           | Tipo de dado | Tamanho | Restrições de domínio (PK, FK, NOT NULL, Unique, Identity, intervalo de valores) |  
| :-----------------: | :--------------------------------: | :----------: | :-----: | :----------------------------------------------------------------------------:   |  
| tipo_minério       | Tipo de minério                    | VARCHAR      | 50      | NOT NULL                                                                          |  
| preço              | Preço do minério                   | DECIMAL      | -       | NOT NULL                                                                          |  
| id_item              | Identificador único do item                   | INT      | -       | FK, NOT NULL                                                     |  

---

### Entidade: Caixa de Mensagem  
#### Descrição: Representa as caixas de mensagem usadas no jogo.  

#### Campos:  
| Nome               | Descrição                           | Tipo de dado | Tamanho | Restrições de domínio (PK, FK, NOT NULL, Unique, Identity, intervalo de valores) |  
| :-----------------: | :--------------------------------: | :----------: | :-----: | :----------------------------------------------------------------------------:   |  
| id_caixa           | Identificador único da caixa       | INT          | -       | PK, NOT NULL, Identity                                                           |
| Instância Missão           | Identificador único da missão       | INT          | -       | FK, NOT NULL, Unique                                                              |  

---  

### Entidade: Mapa  
#### Descrição: Representa os mapas disponíveis no jogo, onde as ações podem ocorrer.  

#### Campos:  
| Nome       | Descrição                   | Tipo de dado | Tamanho | Restrições de domínio (PK, FK, NOT NULL, Unique, Identity, intervalo de valores) |  
| :--------: | :-------------------------: | :----------: | :-----: | :----------------------------------------------------------------------------:   |  
| idMapa     | Identificador único do mapa | INT          | -       | PK, NOT NULL, Unique                                                              |  
| nome       | Nome do mapa                | VARCHAR      | 255     | NOT NULL                                                                          |  

---

### Entidade: Estoque  
#### Descrição: Representa os itens disponíveis no estoque da loja ou do jogador.  

#### Campos:  
| Nome       | Descrição                        | Tipo de dado | Tamanho | Restrições de domínio (PK, FK, NOT NULL, Unique, Identity, intervalo de valores) |  
| :--------: | :------------------------------: | :----------: | :-----: | :----------------------------------------------------------------------------:   |  
| produto    | Nome do produto no estoque       | VARCHAR      | 255     | NOT NULL                                                                          |  
| preço      | Preço do produto no estoque      | DECIMAL      | -       | NOT NULL                                                                          |  

### Entidade: Recurso  
#### Descrição: Representa os recursos coletáveis ou utilizáveis no jogo.  

#### Campos:  
| Nome         | Descrição                   | Tipo de dado | Tamanho | Restrições de domínio (PK, FK, NOT NULL, Unique, Identity, intervalo de valores) |  
| :----------: | :-------------------------: | :----------: | :-----: | :----------------------------------------------------------------------------:   |  
| tipo_recurso | Tipo do recurso             | VARCHAR      | 50      | NOT NULL                                                                          |  
| id_item              | Identificador único do item                   | INT      | -       | FK, NOT NULL                                                     |  

---

### Entidade: Solo  
#### Descrição: Representa solo para cultivo no jogo.  

#### Campos:  
| Nome         | Descrição                   | Tipo de dado | Tamanho | Restrições de domínio (PK, FK, NOT NULL, Unique, Identity, intervalo de valores) |  
| :----------: | :-------------------------: | :----------: | :-----: | :----------------------------------------------------------------------------:   |  
| tipo_recurso | Tipo de recurso associado  | VARCHAR      | 50      | NOT NULL                                                                          |  
|Jogador_id | Identificador único do Jogador | INT | | FK, NOT NULL, Unique|
---

### Entidade: Habilidade  
#### Descrição: Representa as habilidades do jogador no jogo.  

#### Campos:  
| Nome     | Descrição                   | Tipo de dado | Tamanho | Restrições de domínio (PK, FK, NOT NULL, Unique, Identity, intervalo de valores) |  
| :------: | :-------------------------: | :----------: | :-----: | :----------------------------------------------------------------------------:   |  
| id       | Identificador único         | INT          | -       | PK, NOT NULL, Unique                                                              |  
| nível    | Nível da habilidade         | INT          | -       | NOT NULL                                                                          |  
| tipo     | Tipo da habilidade          | VARCHAR      | 50      | NOT NULL                                                                          |  
| xpMin    | Experiência mínima necessária | INT          | -       |                                                                                  |  
| xpMax    | Experiência máxima necessária | INT          | -       |                                                                                  |  

---

### Entidade: HabCombate  
#### Descrição: Representa habilidades de combate do jogador.  

#### Campos:  
| Nome        | Descrição                   | Tipo de dado | Tamanho | Restrições de domínio (PK, FK, NOT NULL, Unique, Identity, intervalo de valores) |  
| :---------: | :-------------------------: | :----------: | :-----: | :----------------------------------------------------------------------------:   |  
| Habilidade_id          | Identificador único         | INT          | -       | FK, NOT NULL, Unique                                                              |  
| vidaBonus   | Bônus de vida               | INT          | -       |                                                                                  |  
| danoBonus   | Bônus de dano               | INT          | -       |                                                                                  |  

---

### Entidade: HabCultivo  
#### Descrição: Representa habilidades relacionadas ao cultivo.  

#### Campos:  
| Nome                 | Descrição                       | Tipo de dado | Tamanho | Restrições de domínio (PK, FK, NOT NULL, Unique, Identity, intervalo de valores) |  
| :------------------: | :-----------------------------: | :----------: | :-----: | :----------------------------------------------------------------------------:   |  
| reducaoEnergiaCultivar | Redução de energia no cultivo  | INT          | -       |                                                                                  |  
| cultivoBonus         | Bônus de cultivo                | INT          | -       |                                                                                  |  
| Habilidade_id          | Identificador único         | INT          | -       | FK, NOT NULL, Unique                                                              |  

---

### Entidade: HabMineração  
#### Descrição: Representa habilidades relacionadas à mineração.  

#### Campos:  
| Nome                  | Descrição                       | Tipo de dado | Tamanho | Restrições de domínio (PK, FK, NOT NULL, Unique, Identity, intervalo de valores) |  
| :-------------------: | :-----------------------------: | :----------: | :-----: | :----------------------------------------------------------------------------:   |  
| Habilidade_id          | Identificador único         | INT          | -       | FK, NOT NULL, Unique                                                              |  
| reducaoEnergiaMinerar | Redução de energia na mineração | INT          | -       |                                                                                  |  
| minerioBonus          | Bônus de mineração              | INT          | -       |                                                                                  |  

---

### Entidade: Consumível  
#### Descrição: Representa itens consumíveis no jogo.  

#### Campos:  
| Nome           | Descrição                   | Tipo de dado | Tamanho | Restrições de domínio (PK, FK, NOT NULL, Unique, Identity, intervalo de valores) |  
| :------------: | :-------------------------: | :----------: | :-----: | :----------------------------------------------------------------------------:   |  
| tipo_consumível | Tipo do consumível          | VARCHAR      | 50      | NOT NULL                                                                          |  
| duração        | Duração do efeito           | INT          | -       | NOT NULL                                                                          |  
| efeito         | Efeito causado pelo item    | VARCHAR      | 255     |                                                                                  |  
| id_item              | Identificador único do item                   | INT      | -       | FK, NOT NULL                                                     |  

---

### Entidade: Utensílio  
#### Descrição: Representa utensílios utilizados no jogo para diferentes funções.  

#### Campos:  
| Nome           | Descrição                       | Tipo de dado | Tamanho | Restrições de domínio (PK, FK, NOT NULL, Unique, Identity, intervalo de valores) |  
| :------------: | :-----------------------------: | :----------: | :-----: | :----------------------------------------------------------------------------:   |  
| tipo_utensílio | Tipo do utensílio               | VARCHAR      | 100     | PK, NOT NULL                                                                          |  
| nível          | Nível necessário para uso       | INT          | -       | NOT NULL                                                                          |  
| id_item              | Identificador único do item                   | INT      | -       | FK, NOT NULL                                                     |  
| id_loja              | Identificador único da loja                   | INT      | -       | FK, NOT NULL                                                     |  

### Entidade: Coleta  
#### Descrição: Representa missões relacionadas à coleta de materiais no jogo.  

#### Campos:  
| Nome           | Descrição                       | Tipo de dado | Tamanho | Restrições de domínio (PK, FK, NOT NULL, Unique, Identity, intervalo de valores) |  
| :------------: | :-----------------------------: | :----------: | :-----: | :----------------------------------------------------------------------------:   |  
| tipoMaterial   | Tipo de material coletado       | VARCHAR      | 100     | NOT NULL                                                                          |  
| quantidade     | Quantidade necessária           | INT          | -       | NOT NULL                                                                          |  
| valorTotal     | Valor total do material coletado| DECIMAL      | -       |                                                                                  |  
| id_missão    | Identificador único da missão      | INT          | -       | FK, Unique, NOT NULL                                                                          |

---

### Entidade: Combate  
#### Descrição: Representa missões ou interações relacionadas ao combate no jogo.  

#### Campos:  
| Nome           | Descrição                       | Tipo de dado | Tamanho | Restrições de domínio (PK, FK, NOT NULL, Unique, Identity, intervalo de valores) |  
| :------------: | :-----------------------------: | :----------: | :-----: | :----------------------------------------------------------------------------:   |  
| tipoInimigo    | Tipo de inimigo                 | VARCHAR      | 100     | NOT NULL                                                                          |  
| quantidadeInimigo | Quantidade de inimigos        | INT          | -       | NOT NULL                                                                          |  
| id_missão    | Identificador único da missão      | INT          | -       | FK, Unique, NOT NULL                                                                          |

--- 

### Entidade: Ferramenta 
#### Descrição: Representa os utensílios do tipo ferramenta  

#### Campos:  
| Nome           | Descrição                       | Tipo de dado | Tamanho | Restrições de domínio (PK, FK, NOT NULL, Unique, Identity, intervalo de valores) |  
| :------------: | :-----------------------------: | :----------: | :-----: | :----------------------------------------------------------------------------:   |  
| tipo_ferramenta    | tipo da ferramenta                 | VARCHAR      | 100     | PK, Identity, NOT NULL                                         |  
| tipo_utensílio | Tipo do utensílio         | VARCHAR          | 100      | FK                                                                         |  
| eficiência    | Afinidade da ferramenta      | INT          | -       |  NOT NULL                                                                          |

--- 
### Entidade: Arma
#### Descrição: Representa os utensílios do tipo arma 

#### Campos:  
| Nome           | Descrição                       | Tipo de dado | Tamanho | Restrições de domínio (PK, FK, NOT NULL, Unique, Identity, intervalo de valores) |  
| :------------: | :-----------------------------: | :----------: | :-----: | :----------------------------------------------------------------------------:   |  
| tipo_arma    | tipo da arma                | VARCHAR      | 100     | PK, Identity, NOT NULL                                         |  
| tipo_utensílio | Tipo do utensílio         | VARCHAR          | 100      | FK                                                                         |  
| dano    | quantidade de dano da arma      | INT          | -       |  NOT NULL                                                                          |

--- 
<<<<<<< HEAD
=======

## Versionamento
|Data|Versão|Autor|Alteração| 
|----|------|---------|-----|
|23/11/2024|1.0| [Manuella Valadares](https://github.com/manuvaladares)| Versão Inicial do Dicionário de Dados|
|24/11/2024|1.1| [Gabriel Zaranza](https://github.com/GZaranza)| Ajustando colunas das tabelas|
|24/11/2024|1.2| [Manuella Valadares](https://github.com/manuvaladares)| Principais relações feitas|
|25/11/2024|1.3| [Marcos Marinho](https://github.com/devMarcosVM)| ajustando chaves e atributos das tabelas|
|25/11/2024|1.4| [Marcos Marinho](https://github.com/devMarcosVM)| adicionando atributos faltantes|
>>>>>>> 7045239 (conserta tabela de versionamento)
