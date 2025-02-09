

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

**Ambiente**: <ins>id_ambiente</ins>, `tipo`, `fk_id_mapa`, `fk_jogador_id`, `descricao`, `transitar_1`, `transitar_2`, `transitar_3`, `transitar_4`, `transitar_5`, `transitar_6`

**Animal**: <ins>id_animal</ins>, `nome_animal`, `diasTotalDropar`, `tipo_animal`, `itemDrop`, `preco`

**arma**: <ins>id_item</ins>, `nome`, `descricao`, `fk_id_utensilio`

**caverna**: <ins>andar</ins>, `fk_id_ambiente`, `quantidade_mobs`, `qtd_minerio`, `fk_id_minerio_item`, `fk_id_item_recompensa`

**celeiro**: <ins>id_celeiro</ins>, `qtd_animais`, `qtd_max_animais`, `fk_id_ambiente`

**Consumivel**: <ins>id_item</ins>, `nome`, `descricao`, `efeito_vida`

**Estoque**: <ins>id_estoque</ins>

**Ferramenta**: <ins>id_item</ins>, `nome`, `descricao`, `fk_id_utensilio`, `eficiencia`, `nivel`

**Habilidade**: <ins>id_habilidade</ins>, `tipo`

**HabCombate**: <ins>fk_Habilidade_id</ins>, `nivel`, `xpMin`, `xpMax`, `vidaBonus`, `danoBonus`

**HabCultivo**: <ins>fk_Habilidade_id</ins>, `nivel`, `xpMin`, `xpMax`, `cultivoBonus`, `reducaoEnergiaCultiva`

**HabMineracao**: <ins>fk_Habilidade_id</ins>, `reducaoEnergiaMinera`, `minerioBonus`, `nivel`, `xpMin`, `xpMax`

**Inimigo**: <ins>id_inimigo</ins>, `nome`, `tipo`, `vidaMax`, `dano`

**InstanciaAnimal**: <ins>id_instancia_de_animal</ins>, `prontoDropa`, `diaAtual`, `fk_Animal_id`, `fk_Jogador_id`, `fk_Celeiro_id`

**InstanciaInimigo**: <ins>id_instancia_de_inimigo</ins>, `vidaAtual`, `fk_Caverna_andar`, `fk_inimigo_id`

**InstanciaPlanta**: <ins>id_instancia_de_planta</ins>, `nome`, `diaDropar`, `plantaDrop`

**InstanciaMissao**: <ins>id_Instancia_Missao</ins>, `fk_id_jogador`, `fk_Missao`, `missao_finalizada`

**Inventário**: <ins>id_inventario</ins>, `fk_id_jogador`

**Item**: <ins>id_item</ins>, `tipo_item`, `fk_estoque`, `fk_inventario_id`

**Jogador**: <ins>id_jogador</ins>, `nome`, `dia`, `tempo`, `vidaMax`, `vidaAtual`, `xp_mineracao`, `xp_cultivo`, `xp_combate`, `dano_ataque`, `fk_habMineracao_fk_Habilidade_id`, `fk_habCombate_fk_Habilidade_id`, `fk_habCultivo_fk_Habilidade_id`

**Loja**: <ins>id_loja</ins>, `nome`, `proprietario`, `fk_id_ambiente`, `fk_id_estoque`

**Mineral**: <ins>id_item</ins>, `nome`, `descricao`, `resistencia`, `preco`

**Plantacao**: <ins>id_plantacao</ins>, `qtd_plantas`, `qtd_plantas_max`, `fk_id_ambiente`

**Recurso**: <ins>id_item</ins>, `nome`, `descricao`, `preco`

**Planta**: <ins>id_semente</ins>, `nome`, `descricao`, `diaAtual`, `prontoColher`, `id_item`, `fk_instancia_planta_id`

**Historia**: <ins>dia</ins>, `historia`


### 3. Relacionamentos

**Animal possui InstâciaAnimal**

-   Um tipo de animal pode possuir nenhuma ou várias instâncias (0, n), mas uma instância de animal está relacionada a apenas um tipo de animal (1, 1).

**Inventario contém Item**

-   Um inventário pode conter nenhum ou vários itens (0, n), mas um item está contido em apenas um inventário por vez (1,1) 


**Instancia De Planta <ins>dropa</ins> Consumivel**

- Uma instância de planta <ins>dropa</ins> nenhum ou vários consumíveis (0, n) e um consumível pode ser <ins>dropado</ins> por nenhuma ou vários instâncias de planta(0, n).

**Jogador quebra Minerio**

- Um jogador pode quebrar nenhum ou vários minérios brutos (0, n) e um minério bruto é quebrado apenas por um jogador (1, 1)


**Jogador possui Inventario**

- Um jogador possui nenhum ou apenas um inventário (0, 1) e um inventário é possuído apenas por um um jogador (1, 1)

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