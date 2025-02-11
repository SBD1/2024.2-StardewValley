

O Modelo Entidade Relacionamento para bancos de dados é um modelo que descreve os objetos (entidades) envolvidos em um negócio, com suas características (atributos) e como elas se relacionam entre si (relacionamentos).

### 1. Entidades

- **Ambiente**
    - **caverna**
    - **plantação**
    - **celeiro**
    - **loja**

- **Animal**

- **Estoque**

- **Inimigo**

- **InstâciaAnimal**

- **InstânciaInimigo**

- **InstanciaPlanta**

- **Inventário**

- **Jogador**

- **Loja**

- **Mineral**

- **Plantação**

- **Recurso**

- **InstanciaItem**

- **Planta**

- **Historia**

- **Habilidade**
    - **HabCombate**
    - **HabCultivo**
    - **HabMineração**

- **Item**
    - **Consumivel**
    - **Semente**
    - **arma**
    - **Ferramenta**

### 2. Atributos

**Ambiente**: <ins>id_ambiente</ins>, `tipo`, `descricao`, `nome`, `eh_casa`,`transitar_1`, `transitar_2`, `transitar_3`, `transitar_4`, `transitar_5`, `transitar_6`

**Animal**: <ins>id_animal</ins>, `diasTotalDropar`, `tipo_animal`, `itemDrop`, `preco`

**arma**: <ins>id_item</ins>, `nome`, `descricao`, `dano`, `preco`

**caverna**: <ins>fk_id_ambiente</ins>, `andar`, `quantidade_mobs`, `qtd_minerio`, `fk_id_minerio_item`, `fk_id_item_recompensa`

**celeiro**: <ins>fk_id_ambiente</ins>, `qtd_max_animais`

**Consumivel**: <ins>fk_id_item</ins>, `nome`, `descricao`, `efeito_vida`, `preco`

**Estoque**: `fk_id_loja`, `fk_id_item`

**Ferramenta**: <ins>fk_id_item</ins>, `nome`, `descricao`,`eficiencia`, `preco`

**Habilidade**: <ins>id_habilidade</ins>, `tipo`

**HabCombate**: <ins>fk_Habilidade_id</ins>, `nivel`, `xpMin`, `xpMax`, `vidaBonus`, `danoBonus`

**HabCultivo**: <ins>fk_Habilidade_id</ins>, `nivel`, `xpMin`, `xpMax`, `cultivoBonus`, `reducaoEnergiaCultiva`

**HabMineracao**: <ins>fk_Habilidade_id</ins>, `reducaoEnergiaMinera`, `minerioBonus`, `nivel`, `xpMin`, `xpMax`

**Inimigo**: <ins>id_inimigo</ins>, `nome`, `tipo`, `vidaMax`, `dano`, `xp_recompensa`

**InstanciaAnimal**: <ins>id_instancia_de_animal</ins>, `nome_animal`, `prontoDropa`, `diaAtual`, `fk_Animal_id`, `fk_Jogador_id`, `fk_Celeiro_id`

**InstanciaInimigo**: <ins>id_instancia_de_inimigo</ins>, `vidaAtual`, `fk_Caverna_andar`, `fk_inimigo_id`, `fk_Jogador_id`, `fk_id_ambiente`

**InstanciaPlanta**: <ins>id_instancia_de_planta</ins>, `nome`, `ProntoColher`, `diaAtual`,`fk_id_planta`, `fk_Jogador_id`

**Inventário**: <ins>id_inventario</ins>, `fk_id_jogador`

**Item**: <ins>id_item</ins>, `tipo_item`

**Jogador**: <ins>id_jogador</ins>, `nome`, `dia`, `tempo`, `localizacao_atual`, `vidaMax`, `vidaAtual`, `xp_mineracao`, `xp_cultivo`, `xp_combate`, `dano_ataque`, `moedas`,`fk_habMineracao_fk_Habilidade_id`, `fk_habCombate_fk_Habilidade_id`, `fk_habCultivo_fk_Habilidade_id`

**Loja**: <ins>fk_id_ambiente</ins>, `nome`, `proprietario`

**Mineral**: <ins>fk_id_item</ins>, `nome`, `descricao`, `resistencia`, `preco`

**Plantacao**: <ins>fk_id_ambiente</ins>, `qtd_plantas_max`

**Recurso**: <ins>fk_id_item</ins>, `nome`, `descricao`, `preco`, `raridade`

**Planta**: <ins>id_planta</ins>, `nome`, `descricao`, `diaDropar`, `itemDrp`, `preco`

**Historia**: <ins>dia</ins>, `historia`


### 3. Relacionamentos

**Animal possui InstâciaAnimal**

-   Um tipo de animal pode possuir nenhuma ou várias instâncias (0, n), mas uma instância de animal está relacionada a apenas um tipo de animal (1, 1).

**Instancia de item está Inventario**

-   Um inventário pode conter nenhum ou várias instancias de itens (0, n), mas um item está contido em apenas um inventário por vez (1,1) 


**Instancia De Planta <ins>dropa</ins> Consumivel**

- Uma instância de planta <ins>dropa</ins> nenhum ou vários consumíveis (0, n) e um consumível pode ser <ins>dropado</ins> por nenhuma ou vários instâncias de planta(0, n).

**Jogador quebra Minerio**

- Um jogador pode quebrar nenhum ou vários minérios (0, n) e um minério bruto é quebrado apenas por um jogador (1, 1)


**Jogador possui Inventario**

- Um jogador possui um ou um inventário (1, 1) e um inventário é possuído apenas por um um jogador (1, 1)

**Jogador possui HabMineração**

- Um jogador possui apenas uma habilidade de mineração e uma habilidade de mineração é possuída apenas por um jogador (1, 1) - arrumar: cardinalidade no DER

**Jogador possui Habcombate**

- Um jogador possui apenas uma habilidade de combate e uma habilidade de combate é possuída apenas por um jogador (1, 1)

**Jogador possui Habcultivo**

- Um jogador possui apenas uma habilidade de cultivo e uma habilidade de cultivo é possuída apenas por um jogador (1, 1)  

**Jogador interage InstâciAanimal**

- Um jogador pode interagir com nenhuma ou várias instâncias de animais (0, n) e uma instância de animal pode interagir apenas com um jogador (1, 1)

**Jogador está Ambiente**

- Um jogador pode estar em nenhum ou apenas um ambiente (0, 1) e um ambiente pode ter apenas um jogador (1, 1) 

**Jogador ataca InstânciaInimigo**

- Um jogador pode atacar nenhuma ou várias instancias de um inimigo (0, n) e uma instância de inimigo pode ser atacada apenas por um jogador (1, 1)


**Inimigo possui InstânciaInimigo**

- Um inimigo pode possuir nenhuma ou várias instâncias e uma instância de inimigo (0, n) é atreladada a apenas um tipo de inimigo (1, 1)

**InstânciaInimigo pertence Caverna**

- Uma instância de inimigo pertence a apenas uma caverna (1, 1) e uma caverna tem nenhuma ou várias instâncias de inimigo (0, n)  

**Caverna contém Minerio**

- Uma caverna contém nenhum ou vários minérios brutos (0, n) e um minério bruto pode estar contido em nenhuma ou várias cavernas (0, n) 

**Estoque possui Item**

- Um estoque possui nenhum ou vários itens (0, n) e um item está contido em apenas um estoque (1, 1) 

**InstâciaAnimal está Celeiro**

- Uma instância de animal pode estar apenas em um celeiro (1, 1) e um celeiro pode ter nenhuma oou várias instâncias de animais (0, n)   

**Loja possui Estoque**

- Uma loja possui nenhum ou apenas um estoque (0, 1) e um estoque é possuido por apenas uma loja (1, 1)

**Aniamal gera Item**

- Um animal pode gerar nenhum ou 1 item e um item pode ser gerado por nenhum ou n animais.

**Jogador lê história**

- Um jogador pode ler 0 a n histórias e uma história só pode ser lida por 1 jogador.

**Item possui Instancia de item**

- Um item pode possuir 0 a n instancias e uma instancia pode ser de 1 item. 

## Versionamento

| Data | Versão | Autor | Alterações | 
| :--: | :----: | ----- | ---------- | 
| 23/11/2024 |  `1.0` |  [Manuella Valadares](https://github.com/manuvaladares)| Criação do documento MER | 
| 23/11/2024 |  `1.1` |  [Gabriel Fernando](https://github.com/MMcLovin)| Preenche [entidades](#1-entidades) e [atributos](#2-atributos) | 
| 24/11/2024 |  `1.2` |  [Gabriel Fernando](https://github.com/MMcLovin)| atualiza [entidades](#1-entidades), [atributos](#2-atributos) e preenche [relacionamentos](#3-relacionamentos) | 
| 25/11/2024 |  `1.3` |  [Isaac Batista](https://github.com/isaacbatista26)| Retira [mapa](#1-entidades) da entidade 'ambiente' | 
| 25/11/2024 |  `1.4` |  [Gabriel Fernando](https://github.com/MMcLovin)| Corrige atributos de [jogador](#2-atributos) e [minério bruto](#2-atributos) | 
| 12/01/2025 |  `1.5` |  [Gabriel Fernando](https://github.com/MMcLovin)| Atualiza entidades e atributos | 
| 09/02/2025 |  `1.6` |  [Manuella Valadares](https://github.com/manuvaladares)| Atualiza entidades | 