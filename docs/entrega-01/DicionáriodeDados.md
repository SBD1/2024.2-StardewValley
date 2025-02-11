

> Um Dicionário de Dados é o conjunto dos vocábulos ou dos termos utilizados na descrição dos objetos modelados para o banco de dados. Os termos são dispostos com o seu respectivo significado para apresentar uma descrição textual da estrutura lógica e física do banco de dados.


## Entidades
### Habilidade 

**Descrição:** Representa as habilidades do jogador no jogo.

**Campos:**


| Nome | Descrição | Tipo de dado | Tamanho | Restrições de domínio (PK, FK, NOT NULL, Unique, Identity, intervalo de valores) |
| :---: | :---: | :---: | :---: | :---: |
| id_habilidade | Identificador único | SERIAL | - | PK, NOT NULL, Unique |
| tipo | Tipo da habilidade | VARCHAR | 50 | NOT NULL |


---

### Inimigo 

**Descrição:** Representa os inimigos encontrados no jogo.

**Campos:**


| Nome | Descrição | Tipo de dado | Tamanho | Restrições de domínio (PK, FK, NOT NULL, Unique, Identity, intervalo de valores) |
| :---: | :---: | :---: | :---: | :---: |
| id_inimigo | Identificador único do inimigo | SERIAL | - | PK, NOT NULL, Unique |
| nome | Nome do inimigo | VARCHAR | 100 | NOT NULL |
| tipo | Tipo de inimigo | VARCHAR | 50 | NOT NULL |
| vidaMax | Quantidade de vida do inimigo | INT | - | NOT NULL |
| dano | Dano causado pelo inimigo | INT | - | NOT NULL |
| xp_recompensa | Recompensa que o jogador ganha em xp ao derrotar o inimigo | INT | - | NOT NULL |

---

### Animal 

**Descrição:** Representa os animais do jogo.

**Campos:**


| Nome | Descrição | Tipo de dado | Tamanho | Restrições de domínio (PK, FK, NOT NULL, Unique, Identity, intervalo de valores) |
| :---: | :---: | :---: | :---: | :---: |
| id_animal | Identificador único do animal | SERIAL | - | PK, NOT NULL, Unique |
| diasTotalDropar | Dias até o animal gerar item | INT | - | NOT NULL |
| tipo_animal | Tipo do animal | VARCHAR | 50 | NOT NULL |
| itemDrop | Item gerado pelo animal | VARCHAR | 100 | NOT NULL |
| preco | Valor do animal | FLOAT | - | NOT NULL |

---

### HabMineração 

**Descrição:** Representa habilidades relacionadas à mineração.

**Campos:**


| Nome | Descrição | Tipo de dado | Tamanho | Restrições de domínio (PK, FK, NOT NULL, Unique, Identity, intervalo de valores) |
| :---: | :---: | :---: | :---: | :---: |
| fk_Habilidade_id | Identificador único | INT | - | PK, FK, NOT NULL, Unique |
| nivel | Nivel atual da habilidade | INT | - | NOT NULL |
| xp_min | Experiência mínima necessária | INT | - | NOT NULL |
| xp_max | Experiência máxima necessária | INT | - | NOT NULL |
| reducaoEnergiaMinerar | Redução da energia necessária na mineração | INT | - | NOT NULL |
| minerioBonus | Bônus de mineração | INT | - | NOT NULL |

---

### HabCombate 

**Descrição:** Representa habilidades de combate do jogador.

**Campos:**


| Nome | Descrição | Tipo de dado | Tamanho | Restrições de domínio (PK, FK, NOT NULL, Unique, Identity, intervalo de valores) |
| :---: | :---: | :---: | :---: | :---: |
| fk_Habilidade_id | Identificador único da habilidade | INT | - | PK, FK, NOT NULL, Unique |
| nivel | Nivel atual da habilidade | INT | - | NOT NULL |
| xp_min | Experiência mínima necessária | INT | - | NOT NULL |
| xp_max | Experiência máxima necessária | INT | - | NOT NULL |
| vidaBonus | Bônus de vida | INT | - | NOT NULL |
| danoBonus | Bônus de dano | INT | - | NOT NULL |

---

### HabCultivo 

**Descrição:** Representa habilidades relacionadas ao cultivo.

**Campos:**


| Nome | Descrição | Tipo de dado | Tamanho | Restrições de domínio (PK, FK, NOT NULL, Unique, Identity, intervalo de valores) |
| :---: | :---: | :---: | :---: | :---: |
| fk_Habilidade_id | Identificador único | INT | - | PK, FK, NOT NULL, Unique |
| nivel | Nivel atual da habilidade | INT | - | NOT NULL |
| xp_min | Experiência mínima necessária | INT | - | NOT NULL |
| xp_max | Experiência máxima necessária | INT | - | NOT NULL |
| reducaoEnergiaCultivar | Redução de energia no cultivo | INT | - | NOT NULL |
| cultivoBonus | Bônus de cultivo | INT | - | NOT NULL |

---

### Jogador 

**Descrição:** Personagem principal, será manuseado pelo jogador.

**Campos:**


| Nome | Descrição | Tipo de dado | Tamanho | Restrições de domínio (PK, FK, NOT NULL, Unique, Identity, intervalo de valores) |
| :---: | :---: | :---: | :---: | :---: |
| id_jogador | Identificador único do jogador | SERIAL | - | PK, NOT NULL, Identity |
| nome | Nome do jogador | VARCHAR | 255 | NOT NULL |
| dia | dia atual do jogo | INT | - | NOT NULL, DEFALT 0 |
| tempo | tempo atual do jogo | INT | - | NOT NULL, DEFALT '06:00' |
| localizacao_atual | INT | - | NOT NULL, DEFALT 1 |
| vidaAtual | Quantidade atual de vida | FLOAT | - | NOT NULL, DEFALT 100.0|
| vidaMax | Quantidade máxima de vida | FLOAT | - | NOT NULL, DEFALT 100.0|
| xp_mineracao | Experiência em mineração | FLOAT | - | NOT NULL, DEFALT 0.0|
| xp_cultivo | Experiência em cultivo  | FLOAT | - | NOT NULL, DEFALT 0.0 |
| xp_combate | Experiência em combate | FLOAT | - | NOT NULL, DEFALT 0.0 |
| dano_ataque | dano causado pelo jogador | FLOAT | - | NOT NULL, DEFALT 10.0 |
| moedas | dinheiro que o jogador carrega | FLOAT | - | NOT NULL, DEFALT 1000.0 |
| fk_habMineracao_fk_Habilidade_id | Identificador único da habilidade | INT | - | FK, Unique |
| fk_habCombate_fk_Habilidade_id | Identificador único da habilidade | INT | - | FK, Unique |
| fk_habCultivo_fk_Habilidade_id | Identificador único da habilidade | INT | - | FK, Unique |

---

### Ambiente 

**Descrição:** Representa os locais do jogo.

**Campos:**


| Nome | Descrição | Tipo de dado | Tamanho | Restrições de domínio (PK, FK, NOT NULL, Unique, Identity, intervalo de valores) |
| :---: | :---: | :---: | :---: | :---: |
| id_ambiente | Identificador único do ambiente | INT | - | PK, NOT NULL, Identity |
| tipo | Tipo do ambiente | VARCHAR | 50 | - |
| nome | Nome do ambiente | VARCHAR | 50 | - |
| descricao | Descrição do ambiente | TEXT | - | NOT NULL |
| eh_casa | Define qual casa é o do jogador | BOOLEAN | - | NOT NULL |
| transitar_1 | armazena o id do primeiro ambiente para o qual o jogador pode ir | INT | - | FK |
| transitar_2 | armazena o id do segundo ambiente para o qual o jogador pode ir | INT | - | FK |
| transitar_3 | armazena o id do terceiro ambiente para o qual o jogador pode ir | INT | - | FK |
| transitar_4 | armazena o id do quarto ambiente para o qual o jogador pode ir | INT | - | FK |
| transitar_5 | armazena o id do quinto ambiente para o qual o jogador pode ir | INT | - | FK |
| transitar_6 | armazena o id do sexto ambiente para o qual o jogador pode ir | INT | - | FK |

---

### CasaJogador 

**Descrição:** Representa a casa do jogador.

**Campos:**


| Nome | Descrição | Tipo de dado | Tamanho | Restrições de domínio (PK, FK, NOT NULL, Unique, Identity, intervalo de valores) |
| :---: | :---: | :---: | :---: | :---: |
| fk_id_ambiente | Identificador único do ambiente | INT | - | FK, Unique, NOT NULL |
| fk_id_caixa_mensagem | Identificador único da caixa de mensagem | INT | - | FK, Unique, NOT NULL |

---

### Caverna 

**Descrição:** Representa as cavernas exploráveis no jogo.

**Campos:**


| Nome | Descrição | Tipo de dado | Tamanho | Restrições de domínio (PK, FK, NOT NULL, Unique, Identity, intervalo de valores) |
| :---: | :---: | :---: | :---: | :---: |
| andar | Andar específico da caverna | SERIAL | - | PK, NOT NULL, Unique |
| quantidade_mobs | Quantidade de inimigos no andar | INT | - | NOT NULL |
| qtd_minerio | Quantidade de minérios disponíveis | INT | - | NOT NULL |
| fk_item_recompensa | Recompensa obtida na exploração | VARCHAR | - | FK, Unique, NOT NULL |
| fk_id_ambiente | Identificador único do ambiente | INT | - | FK, Unique, NOT NULL |
| fk_id_minerio | Identificador único do minério predominante | INT | - | FK, Unique, NOT NULL |

---

### Celeiro 

**Descrição:** Local para alojar os animais do jogador.

**Campos:**


| Nome | Descrição | Tipo de dado | Tamanho | Restrições de domínio (PK, FK, NOT NULL, Unique, Identity, intervalo de valores) |
| :---: | :---: | :---: | :---: | :---: |
| fk_id_ambiente | Identificador único do celeiro | SERIAL | - | FK, NOT NULL, Unique |
| qtd_max_animais | Quantidade máxima de animais alojados | INT | - | NOT NULL |

---

### Plantação 

**Descrição:** Representa as áreas cultiváveis no jogo.

**Campos:**


| Nome | Descrição | Tipo de dado | Tamanho | Restrições de domínio (PK, FK, NOT NULL, Unique, Identity, intervalo de valores) |
| :---: | :---: | :---: | :---: | :---: |
| qtd_plantas_max | Quantidade de plantas máximas cultivadas | INT | - | NOT NULL |
| fk_id_ambiente | Identificador único do ambiente | INT | - | FK, NOT NULL, Unique |

---

### Loja 

**Descrição:** Local onde os jogadores podem comprar e vender itens.

**Campos:**


| Nome | Descrição | Tipo de dado | Tamanho | Restrições de domínio (PK, FK, NOT NULL, Unique, Identity, intervalo de valores) |
| :---: | :---: | :---: | :---: | :---: |
| fk_id_ambiente | Identificador único da loja | INT | - | FK, PK |
| proprietário | Nome do proprietário da loja | VARCHAR | 100 | NOT NULL |
| nome | Nome da loja | VARCHAR | 100 | NOT NULL |


---

### Estoque 

**Descrição:** Representa os itens disponíveis no estoque da loja ou do jogador.

**Campos:**


| Nome | Descrição | Tipo de dado | Tamanho | Restrições de domínio (PK, FK, NOT NULL, Unique, Identity, intervalo de valores) |
| :---: | :---: | :---: | :---: | :---: |
| fk_id_loja | Identificador único do da loja que o estoque é associado | INT | - | FK, NOT NULL |
| fk_id_Item | Identificador único do item | INT | - | FK, NOT NULL |

---

### Inventário 

**Descrição:** Armazena os itens coletados ou adquiridos pelo jogador.

**Campos:**


| Nome | Descrição | Tipo de dado | Tamanho | Restrições de domínio (PK, FK, NOT NULL, Unique, Identity, intervalo de valores) |
| :---: | :---: | :---: | :---: | :---: |
| id_inventario | Identificador único do inventário | SERIAL | - | PK, NOT NULL, Unique |
| fk_id_jogador | Identificador do jogador | INT | - | FK, NOT NULL |

---

### Item 

**Descrição:** Representa qualquer item do jogo.

**Campos:**


| Nome | Descrição | Tipo de dado | Tamanho | Restrições de domínio (PK, FK, NOT NULL, Unique, Identity, intervalo de valores) |
| :---: | :---: | :---: | :---: | :---: |
| id_item | Identificador do item | SERIAL | - | PK, NOT NULL, Identity |
| tipo_item | Tipo do item | VARCHAR | 20 | NOT NULL |

---

### InstanciaItem 

**Descrição:** Representa qualquer instância de item do jogo.

**Campos:**

| Nome | Descrição | Tipo de dado | Tamanho | Restrições de domínio (PK, FK, NOT NULL, Unique, Identity, intervalo de valores) |
| :---: | :---: | :---: | :---: | :---: |
| id_instancia_de_item | Identificador da istância do item | SERIAL | - | PK, NOT NULL, Identity |
| fk_id_jogador | Associa um item a um jogador unico | INT | - | NOT NULL |
| fk_id_item | Identificador do item | INT | - | NOT NULL |
| fk_id_inventario | INT | - | - |
| is_equipado | BOOLEAN | - | DEFALT FALSE |

---

### Consumível 

**Descrição:** Representa itens consumíveis no jogo.

**Campos:**


| Nome | Descrição | Tipo de dado | Tamanho | Restrições de domínio (PK, FK, NOT NULL, Unique, Identity, intervalo de valores) |
| :---: | :---: | :---: | :---: | :---: |
| fk_id_item | Identificador único do item | INT | - | PK, FK, NOT NULL |
| nome | Nome do consumível | VARCHAR | 100 | NOT NULL |
| descricao | Descrição do consumível | TEXT | - | NOT NULL |
| efeito_vida | Efeito causado pelo item sobre a vida | INT | - | NOT NULL |
| preco | Valor do item consumível | FLOAT | - | NOT NULL |

---

### Ferramenta 

**Descrição:** Representa os utensílios do tipo ferramenta

**Campos:**


| Nome | Descrição | Tipo de dado | Tamanho | Restrições de domínio (PK, FK, NOT NULL, Unique, Identity, intervalo de valores) |
| :---: | :---: | :---: | :---: | :---: |
| fk_id_item | Identificador do item | INT | - | PK, FK, NOT NULL |
| nome | Nome da missão | VARCHAR | 255 | NOT NULL |
| descricao | Descrição da missão | TEXT | - | NOT NULL |
| eficiencia | Afinidade da ferramenta | INT | - | NOT NULL |
| preco | Valor da ferramenta | FLOAT | - | NOT NULL |

---

### Arma 

**Descrição:** Representa os utensílios do tipo arma

**Campos:**


| Nome | Descrição | Tipo de dado | Tamanho | Restrições de domínio (PK, FK, NOT NULL, Unique, Identity, intervalo de valores) |
| :---: | :---: | :---: | :---: | :---: |
| fk_id_item | Identificador do item | INT | - | PK, FK, Identity, NOT NULL |
| nome | Nome da missão | VARCHAR | 255 | NOT NULL |
| descricao | Descrição da missão | TEXT | - | NOT NULL |
| preco | Valor da arma | FLOAT | - | NOT NULL |
| dano_arma | Dano que é aumentado no combate | FLOAT | - | NOT NULL |

---

### Mineral 

**Descrição:** Representa os minerais coletáveis no jogo.

**Campos:**


| Nome | Descrição | Tipo de dado | Tamanho | Restrições de domínio (PK, FK, NOT NULL, Unique, Identity, intervalo de valores) |
| :---: | :---: | :---: | :---: | :---: |
| fk_id_item | Identificador único do item | INT | - | PK, FK, NOT NULL |
| nome | Nome do minério | VARCHAR | 100 | NOT NULL |
| descricao | Descrição do mineral | VARCHAR | 100 | NOT NULL |
| resistencia | Resistência do mineral para ser minerado | INTEGER | - | NOT NULL |
| preco | Preço do minério | FLOAT | - | NOT NULL |

---

### Recurso 

**Descrição:** Representa os recursos coletáveis ou utilizáveis no jogo.

**Campos:**


| Nome | Descrição | Tipo de dado | Tamanho | Restrições de domínio (PK, FK, NOT NULL, Unique, Identity, intervalo de valores) |
| :---: | :---: | :---: | :---: | :---: |
| fk_id_item | Identificador único do item | INT | - | FK, PK, NOT NULL |
| nome | Nome do recurso | VARCHAR | 100 | NOT NULL |
| descricao | Descrição do recurso | VARCHAR | 100 | NOT NULL |
| preco | Valor do recurso | FLOAT | - | NOT NULL |
| raridade | o nível de raridade do recurso | FLOAT | - | NOT NULL |

---

### InstânciaInimigo 

**Descrição:** Representa uma instância específica de um inimigo no jogo.

**Campos:**


| Nome | Descrição | Tipo de dado | Tamanho | Restrições de domínio (PK, FK, NOT NULL, Unique, Identity, intervalo de valores) |
| :---: | :---: | :---: | :---: | :---: |
| id_instancia_inimigo | Identificador único da instância | SERIAL | - | PK, NOT NULL, Unique |
| vidaAtual | Quantidade de vida atual | FLOAT | - | NOT NULL |
| fk_id_ambiente | Andar da caverna que o inimigo pertence | INT | - | FK, NOT NULL |
| fk_id_inimigo | Referência ao inimigo base | INT | - | FK, NOT NULL |
| fk_jogador_id | Referência ao jogador | INT | - | FK, NOT NULL |

---

### InstânciaAnimal 

**Descrição:** Representa uma instância específica de um animal no jogo.

**Campos:**


| Nome | Descrição | Tipo de dado | Tamanho | Restrições de domínio (PK, FK, NOT NULL, Unique, Identity, intervalo de valores) |
| :---: | :---: | :---: | :---: | :---: |
| id_instancia_animal | Identificador único da instância | SERIAL | - | PK, NOT NULL, Identity |
| diaAtual | Dia atual da instância do animal | INT | - | NOT NULL |
| prontoDropa | Indica se está pronto para dropar um item | BOOLEAN | - | NOT NULL |
| fk_Jogador_id | Identificador único do Jogador | INT |   | FK, NOT NULL, Unique |
| fk_Animal_id | Identificador único do animal | INT | - | FK, NOT NULL, Unique |
| fk_id_celeiro | Identificador único do celeiro | INT | - | FK, NOT NULL, Unique |
| nome_animal | Nome do animal | VARCHAR | 100 | NOT NULL |

---

### Instância de Planta 

**Descrição:** Representa as sementes plantáveis no jogo.

**Campos:**


| Nome | Descrição | Tipo de dado | Tamanho | Restrições de domínio (PK, FK, NOT NULL, Unique, Identity, intervalo de valores) |
| :---: | :---: | :---: | :---: | :---: |
| id_instancia_planta | Identificador único da instância de planta | INT | - | PK, NOT NULL, Unique |
| fk_id_jogador | Identificador do jogador que a planta é relacionada | INT | - | FK, NOT NULL |
| nome | nome da planta a ser cultivada | VARCHAR | 50 | NOT NULL |
| diaAtual | dia atual da planta desde que foi plantada | INT | - | NOT NULL DEFALT 0 |
| fk_id_planta | qual especie a planta é | INT | 50 | FK, NOT NULL |
| prontoColher | diz se a planta está madura ou não | BOOLEAN | - | NOT NULL |

---


### Planta 

**Descrição:** Representa a planta cultivada no jogo.

**Campos:**


| Nome | Descrição | Tipo de dado | Tamanho | Restrições de domínio (PK, FK, NOT NULL, Unique, Identity, intervalo de valores) |
| :---: | :---: | :---: | :---: | :---: |
| id_planta | Identificador da planta | SERIAL | - | PK, NOT NULL |
| nome | nome da espécie da planta | VARCHAR | 50 | NOT NULL |
| descricao | descrição da planta | VARCHAR | 100 | NOT NULL |
| diaDropar | dia em que a planta dropa um item | INT | - | NOT NULL |
| preco | preco da planta | FLOAT | - | NOT NULL |
| itemDrop | qual item a planta pode produzir | INT | - | FK, NOT NULL |

---

### História 

**Descrição:** Representa as mensagens que o jogador recebe durante o jogo.

**Campos:**


| Nome | Descrição | Tipo de dado | Tamanho | Restrições de domínio (PK, FK, NOT NULL, Unique, Identity, intervalo de valores) |
| :---: | :---: | :---: | :---: | :---: |
| dia | o dia da História | INT | - | PK, NOT NULL |
| historia | texto que o jogador recebe | TEXT | - | NOT NULL |

---


## Versionamento

| Data | Versão | Autor | Alterações |
| --- | --- | --- | --- |
| 23/11/2024 | `1.0` | [Manuella Valadares](https://github.com/manuvaladares) | Versão Inicial do Dicionário de Dados |
| 24/11/2024 | `1.1` | [Gabriel Zaranza](https://github.com/GZaranza) | Ajustando colunas das tabelas |
| 24/11/2024 | `1.2` | [Manuella Valadares](https://github.com/manuvaladares) | Principais relações feitas |
| 25/11/2024 | `1.3` | [Marcos Marinho](https://github.com/devMarcosVM) | ajustando chaves e atributos das tabelas |
| 25/11/2024 | `1.4` | [Marcos Marinho](https://github.com/devMarcosVM) | adicionando atributos faltantes |
| 12/01/2025 | `1.5` | [Gabriel Fernando de Jesus Silva](https://github.com/MMcLovin) | Atualiza entidades e atributos |
| 08/02/2025 | `1.6` | [Gabriel Fernando de Jesus Silva](https://github.com/MMcLovin) | Altera formatação do índice |
| 09/02/2024 | `1.7` | [Manuella Valadares](https://github.com/manuvaladares) | Versão atualizada do DD |