

O Modelo Entidade Relacionamento para bancos de dados é um modelo que descreve os objetos (entidades) envolvidos em um negócio, com suas características (atributos) e como elas se relacionam entre si (relacionamentos).

=== "<a href="#anchor-link-modulo1" tabindex="-1">Módulo 1</a>"

    ## 1. Entidades

    - **Ambiente**
        - **caverna**
        - **casaJogador**
        - **celeiro**

    - **Animal**

    - **Caixa de mensagem**

    - **Estoque**

    - **Inimigo**

    - **InstâciaAnimal**

    - **InstânciaInimigo**

    - **InstanciaMissão**

    - **InstanciaPlanta**

    - **Inventário**

    - **Jogador**

    - **Loja**

    - **Mapa**

    - **Minerio_bruto**

    - **Plantação**

    - **Recompensa**

    - **Recurso**

    - **Semente**

    - **Solo**

    - **Habilidade**
        - **HabCombate**
        - **HabCultivo**
        - **HabMineração**

    - **Item**
        - **Consumivel**
        - **Semente**
        - **Utensilio**
            - **arma**
            - **Ferramenta**

    - **Missão**
        - **Coleta**
        - **Combate**

    ## 2. Atributos

    - **Ambiente**: <ins>id_ambiente</ins>, `tipo`

    - **Animal**: <ins>id</ins>, `nome`, `diasTotalDropar`, `tipo`, `itemDrop`, `preço`

    - **Arma**: <ins>tipo_arma</ins>, `dano`

    - **Caixa de Mensagem**: <ins>id_caixa</ins>

    - **CasaJogador**: <ins>id</ins>, `id_jogador`

    - **Caverna**: <ins>andar</ins>, `quantidade_mobs`, `minérios`, `item_recompensa`

    - **Celeiro**: <ins>id_celeiro</ins>, `qtd_animais`

    - **Coleta**: <ins>tipoMaterial</ins>, `tipoMaterial`, `quantidade`, `valorTotal`

    - **Combate**: <ins>tipoInimigo</ins>, `tipoInimigo`, `quantidadeInimigo`

    - **Consumível**: <ins>tipo_consumível</ins>, `duração`, `efeito`

    - **Estoque**: <ins>produto</ins>, `preço`

    - **Ferramenta**: <ins>tipo_ferramenta</ins>, `eficiência`

    - **HabCombate**: <ins>id</ins>, `vidaBonus`, `danoBonus`

    - **HabCultivo**: <ins>id</ins>, `reducaoEnergiaCultivar`, `cultivoBonus`

    - **Habilidade**: <ins>id</ins>, `nível`, `tipo`, `xpMin`, `xpMax`

    - **HabMineração**: <ins>id</ins>, `reducaoEnergiaMinerar`, `minerioBonus`

    - **Inimigo**: <ins>id</ins>, `nome`, `tipo`, `vida`, `dano`

    - **InstânciaAnimal**: <ins>id</ins>, `diaAtual`, `prontoDropar`

    - **InstânciaInimigo**: <ins>id</ins>, `id_inimigo`, `vidaAtual`

    - **InstânciaMissão**: <ins>id</ins>, `dataInicio`, `dataFinalização`, `status`

    - **InstânciaPlanta**: <ins>id</ins>, `nome`, `diaDropar`, `plantaDrop`

    - **Inventário**: <ins>id</ins>, `quantidade_item`

    - **Item**: <ins>id_item</ins>, `nome`, `descrição`, `id_categoria`, `tipo_item`, `quantidade`

    - **Jogador**: <ins>id</ins>, `nome`, `vidaAtual`, `vidaMax`, `dano_ataque`, `tempo`, `xp_combate`, `dia`, `xp_cultivo`

    - **Loja**: <ins>id_loja</ins>, `proprietário`, `nome`, `descrição`

    - **Mapa**: <ins>idMapa</ins>, `nome`

    - **Mineral**: <ins>tipo_minério</ins>, `preço`

    - **Minério_Bruto**: <ins>id_minerio_bruto</ins>, ` bool_minerado`

    - **Missão**: <ins>tipo</ins>, `nome`, `descrição`, `tipo`

    - **Plantação**: `qtd_plantas`

    - **Recompensa**: <ins>id</ins>, `tipoItem`, `quantidade`

    - **Recurso**: <ins>tipo_recurso</ins>

    - **Semente**: <ins>id</ins>, `bool_regou`, `bool_livre`,`diaAtual`, `diaDropar`, `prontoColher`

    - **Solo**: <ins>tipo_recurso</ins>

    - **Utensilio**: <ins>tipo_utensílio</ins>, `nível`


    ## 3. Relacionamentos

    **Missão possui InstânciaMissão**

    -   Uma missão pode possuir nenhuma ou várias instâncias (0, n), mas uma instância de missão está relacionada apenas a uma missão (1, 1)

    **Animal possui InstâciaAnimal**

    -   Um tipo de animal pode possuir nenhuma ou várias instâncias (0, n), mas uma instância de animal está relacionada a apenas um tipo de animal (1, 1).

    **Inventario contém Item**

    -   Um inventário pode conter nenhum ou vários itens (0, n), mas um item está contido em apenas um inventário por vez (1,1) 

    **Minerio Bruto <ins>dropa</ins> Mineral**

    - Um minério bruto <ins>dropa</ins> apenas um tipo de mineral (1, 1) e um mineral pode ser <ins>dropado</ins> por nenhum ou vários minérios brutos (0, n) 

    **Instancia De Planta <ins>dropa</ins> Consumivel**

    - Uma instância de planta <ins>dropa</ins> nenhum ou vários consumíveis (0, n) e um consumível pode ser <ins>dropado</ins> por nenhuma ou vários instâncias de planta(0, n).

    **Jogador quebra Minerio Bruto**

    - Um jogador pode quebrar nenhum ou vários minérios brutos (0, n) e um minério bruto é quebrado apenas por um jogador (1, 1)

    **Jogador completa InstânciaMissão**

    - Um jogador pode completar nenhuma ou várias instâncias de missões (0, n) e uma instância de missão é completada apenas por um jogador (1, 1) 

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

    **Jogador planta Semente**

    - Um jogador pode plantar nenhuma ou várias sementes (0, n) e uma semente é plantada apenas por um jogador (1, 1)

    **Jogador rega Solo**

    - Um jogador pode regar nenhum ou vários solos (0, n) e um solo é regado apenas por um jogador (1, 1) 

    **Inimigo possui InstânciaInimigo**

    - Um inimigo pode possuir nenhuma ou várias instâncias e uma instância de inimigo (0, n) é atreladada a apenas um tipo de inimigo (1, 1)

    **InstânciaInimigo pertence Caverna**

    - Uma instância de inimigo pertence a apenas uma caverna (1, 1) e uma caverna tem nenhuma ou várias instâncias de inimigo (0, n)  

    **Caixa De Mensagem contém InstânciaMissão**

    - Uma caixa de mensagem contém nenhuma ou várias instãncias de missões (0, n) e uma instância de missão pode estar contida ou não em uma caixa de mensagem (0, 1) 

    **Caverna contém Minerio Bruto**

    - Uma caverna contém nenhum ou vários minérios brutos (0, n) e um minério bruto pode estar contido em nenhuma ou várias cavernas (0, n) 

    **Estoque possui Item**

    - Um estoque possui nenhum ou vários itens (0, n) e um item está contido em apenas um estoque (1, 1)

    **Semente gera InstanciaPlanta**

    - Uma semente gera apenas uma instancia de planta (1, 1) e uma instancia de planta gerar por nenhuma ou várias sementes (0, n)

    **Mapa possui Ambiente**

    - Um mapa possuí nenhum ou vários ambientes (0, n) e um ambiente é possuído por apenas um mapa (1, 1)  

    **Plantação possui Solo**

    - Uma plantação possui nenhum ou vários solos (0, n) e um solo é possído apenas por uma plantação (1, 1)  

    **CasaJogador possui Caixa De Mensagem**

    - Uma casa do jogador possui nenhuma ou apenas uma (0, 1) caixa de mensagem e uma caixa de mensagem é possuida apenas por uma casa do jogador (1, 1)

    **InstâciaAnimal está Celeiro**

    - Uma instância de animal pode estar apenas em um celeiro (1, 1) e um celeiro pode ter nenhuma oou várias instâncias de animais (0, n)   

    **Loja possui Estoque**

    - Uma loja possui nenhum ou apenas um estoque (0, 1) e um estoque é possuido por apenas uma loja (1, 1)

    **Loja melhora Utensílio**

    -   Uma loja melhora nenhum ou vários untensílios (0, n) e um utensílio é melhorado apenas por uma loja (1, 1)

=== "<a href="#anchor-link-modulo2" tabindex="-1">Módulo 2</a>"

    ## 1. Entidades

    - **Ambiente**
        - **caverna**
        - **casaJogador**
        - **celeiro**

    - **Animal**

    - **Caixa de mensagem**

    - **Estoque**

    - **Inimigo**

    - **InstâciaAnimal**

    - **InstânciaInimigo**

    - **InstanciaMissão**

    - **InstanciaPlanta**

    - **Inventário**

    - **Jogador**

    - **Loja**

    - **Mapa**

    - **Mineral**

    - **Plantação**

    - **Recompensa**

    - **Recurso**

    - **Semente**

    - **Solo**

    - **Habilidade**
        - **HabCombate**
        - **HabCultivo**
        - **HabMineração**

    - **Item**
        - **Consumivel**
        - **Semente**
        - **Utensilio**
            - **arma**
            - **Ferramenta**

    - **Missão**
        - **Coleta**
        - **Combate**

    ## 2. Atributos

    **Ambiente**: <ins>id_ambiente</ins>, `tipo`, `fk_id_mapa`, `fk_jogador_id`, `descricao`, `transitar_1`, `transitar_2`, `transitar_3`, `transitar_4`, `transitar_5`, `transitar_6`

    **Animal**: <ins>id_animal</ins>, `nome_animal`, `diasTotalDropar`, `tipo_animal`, `itemDrop`, `preco`

    **arma**: <ins>id_item</ins>, `nome`, `descricao`, `fk_id_utensilio`

    **Caixa de Mensagem**: <ins>id_Caixa_Mensagem</ins>, `fk_Jogador_id`, `fk_Instancia_Missao`

    **casaJJogador**: `fk_id_ambiente`, `fk_id_caixa_mensagem`

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

    **Mapa**: <ins>id_mapa</ins>, `nome`

    **Mineral**: <ins>id_item</ins>, `nome`, `descricao`, `resistencia`, `preco`

    **MissaoCombate**: <ins>fk_id_missao</ins>, `fk_id_Inimigo`, `nome`, `descricao`, `dataInicio`, `dataFinalizacao`

    **MissaoColeta**: <ins>fk_id_missao</ins>, `fk_id_minerio`, `nome`, `descricao`, `dataInicio`, `dataFinalizacao`

    **Missao**: <ins>id_missao</ins>, `tipo`

    **Plantacao**: <ins>id_plantacao</ins>, `qtd_plantas`, `qtd_plantas_max`, `fk_id_ambiente`

    **Recurso**: <ins>id_item</ins>, `nome`, `descricao`, `preco`

    **Recompensa**: <ins>id_Recompensa</ins>, `fk_Jogador_id`, `id_item`, `fk_Instancia_Missao`, `quantidade`

    **Semente**: <ins>id_semente</ins>, `nome`, `descricao`, `diaAtual`, `prontoColher`, `id_item`, `fk_instancia_planta_id`

    **Solo**: <ins>id_solo</ins>, `tipo_recurso`, `fk_id_plantacao`, `bool_regou`, `bool_livre`

    **Utensilio**: <ins>id_item</ins>, `tipo_utensilio`


    ## 3. Relacionamentos

    **Missão possui InstânciaMissão**

    -   Uma missão pode possuir nenhuma ou várias instâncias (0, n), mas uma instância de missão está relacionada apenas a uma missão (1, 1)

    **Animal possui InstâciaAnimal**

    -   Um tipo de animal pode possuir nenhuma ou várias instâncias (0, n), mas uma instância de animal está relacionada a apenas um tipo de animal (1, 1).

    **Inventario contém Item**

    -   Um inventário pode conter nenhum ou vários itens (0, n), mas um item está contido em apenas um inventário por vez (1,1) 

    **Minerio Bruto <ins>dropa</ins> Mineral**

    - Um minério bruto <ins>dropa</ins> apenas um tipo de mineral (1, 1) e um mineral pode ser <ins>dropado</ins> por nenhum ou vários minérios brutos (0, n) 

    **Instancia De Planta <ins>dropa</ins> Consumivel**

    - Uma instância de planta <ins>dropa</ins> nenhum ou vários consumíveis (0, n) e um consumível pode ser <ins>dropado</ins> por nenhuma ou vários instâncias de planta(0, n).

    **Jogador quebra Minerio Bruto**

    - Um jogador pode quebrar nenhum ou vários minérios brutos (0, n) e um minério bruto é quebrado apenas por um jogador (1, 1)

    **Jogador completa InstânciaMissão**

    - Um jogador pode completar nenhuma ou várias instâncias de missões (0, n) e uma instância de missão é completada apenas por um jogador (1, 1) 

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

    **Jogador planta Semente**

    - Um jogador pode plantar nenhuma ou várias sementes (0, n) e uma semente é plantada apenas por um jogador (1, 1)

    **Jogador rega Solo**

    - Um jogador pode regar nenhum ou vários solos (0, n) e um solo é regado apenas por um jogador (1, 1) 

    **Inimigo possui InstânciaInimigo**

    - Um inimigo pode possuir nenhuma ou várias instâncias e uma instância de inimigo (0, n) é atreladada a apenas um tipo de inimigo (1, 1)

    **InstânciaInimigo pertence Caverna**

    - Uma instância de inimigo pertence a apenas uma caverna (1, 1) e uma caverna tem nenhuma ou várias instâncias de inimigo (0, n)  

    **Caixa De Mensagem contém InstânciaMissão**

    - Uma caixa de mensagem contém nenhuma ou várias instãncias de missões (0, n) e uma instância de missão pode estar contida ou não em uma caixa de mensagem (0, 1) 

    **Caverna contém Minerio Bruto**

    - Uma caverna contém nenhum ou vários minérios brutos (0, n) e um minério bruto pode estar contido em nenhuma ou várias cavernas (0, n) 

    **Estoque possui Item**

    - Um estoque possui nenhum ou vários itens (0, n) e um item está contido em apenas um estoque (1, 1)

    **Semente gera InstanciaPlanta**

    - Uma semente gera apenas uma instancia de planta (1, 1) e uma instancia de planta gerar por nenhuma ou várias sementes (0, n)

    **Mapa possui Ambiente**

    - Um mapa possuí nenhum ou vários ambientes (0, n) e um ambiente é possuído por apenas um mapa (1, 1)  

    **Plantação possui Solo**

    - Uma plantação possui nenhum ou vários solos (0, n) e um solo é possído apenas por uma plantação (1, 1)  

    **CasaJogador possui Caixa De Mensagem**

    - Uma casa do jogador possui nenhuma ou apenas uma (0, 1) caixa de mensagem e uma caixa de mensagem é possuida apenas por uma casa do jogador (1, 1)

    **InstâciaAnimal está Celeiro**

    - Uma instância de animal pode estar apenas em um celeiro (1, 1) e um celeiro pode ter nenhuma oou várias instâncias de animais (0, n)   

    **Loja possui Estoque**

    - Uma loja possui nenhum ou apenas um estoque (0, 1) e um estoque é possuido por apenas uma loja (1, 1)

    **Loja melhora Utensílio**

    -   Uma loja melhora nenhum ou vários untensílios (0, n) e um utensílio é melhorado apenas por uma loja (1, 1)

## Versionamento

| Data | Versão | Autor | Alterações | 
| :--: | :----: | ----- | ---------- | 
| 23/11/2024 |  `1.0` |  [Manuella Valadares](https://github.com/manuvaladares)| Criação do documento MER | 
| 23/11/2024 |  `1.1` |  [Gabriel Fernando](https://github.com/MMcLovin)| Preenche [entidades](#1-entidades) e [atributos](#2-atributos) | 
| 24/11/2024 |  `1.2` |  [Gabriel Fernando](https://github.com/MMcLovin)| atualiza [entidades](#1-entidades), [atributos](#2-atributos) e preenche [relacionamentos](#3-relacionamentos) | 
| 25/11/2024 |  `1.3` |  [Isaac Batista](https://github.com/isaacbatista26)| Retira [mapa](#1-entidades) da entidade 'ambiente' | 
| 25/11/2024 |  `1.4` |  [Gabriel Fernando](https://github.com/MMcLovin)| Corrige atributos de [jogador](#2-atributos) e [minério bruto](#2-atributos) | 
| 12/01/2025 |  `1.5` |  [Gabriel Fernando](https://github.com/MMcLovin)| Atualiza entidades e atributos | 