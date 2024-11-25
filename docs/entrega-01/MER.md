## Versionamento

| Data | Versão | Autor | Alterações | 
| :--: | :----: | ----- | ---------- | 
| 23/11/2024 |  1.0 |  [Manuella Valadares](https://github.com/manuvaladares)| Criação do documento MER | 
| 23/11/2024 |  1.1 |  [Gabriel Fernando](https://github.com/MMcLovin)| Preenche [entidades](#1-entidades) e [atributos](#2-atributos) | 
| 24/11/2024 |  1.1 |  [Gabriel Fernando](https://github.com/MMcLovin)| atualiza [entidades](#1-entidades), [atributos](#2-atributos) e preenche [relacionamentos](#3-relacionamentos) | 


# Modelo Entidade-Relacionamento

O Modelo Entidade Relacionamento para bancos de dados é um modelo que descreve os objetos (entidades) envolvidos em um negócio, com suas características (atributos) e como elas se relacionam entre si (relacionamentos).

## 1. Entidades

- **Ambiente**
    - **caverna**
    - **CasaJogador**
    - **celeiro**
    - **Mapa**

- **Animal**

- **Caixa de mensagem**

- **Estoque**

- **Inimigo**

- **InstanciaAnimal**

- **InstanciaInimigo**

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

- **Jogador**: <ins>id</ins>, `nome`, `vidaAtual`, `vidaMax`, `estamina`, `nível`, `experiência`

- **Loja**: <ins>id_loja</ins>, `proprietário`, `nome`, `descrição`

- **Mapa**: <ins>idMapa</ins>, `nome`

- **Mineral**: <ins>tipo_minério</ins>, `preço`

- **Minério_Bruto**: <ins> </ins>, `***********`

- **Missão**: <ins>tipo</ins>, `nome`, `descrição`, `tipo`

- **Plantação**: `qtd_plantas`

- **Recompensa**: <ins>id</ins>, `tipoItem`, `quantidade`

- **Recurso**: <ins>tipo_recurso</ins>

- **Semente**: <ins>id</ins>, `bool_regou`, `bool_livre`,`diaAtual`, `diaDropar`, `prontoColher`

- **Solo**: <ins>tipo_recurso</ins>

- **Utensilio**: <ins>tipo_utensílio</ins>, `nível`


## 3. Relacionamentos

**Missão possui Instanciamissao**

-   

**Animal possui Instanciaanimal**

-   

**Inventario contem Item**

-   

**Minerio Bruto dropa Mineral**

-   

**Instancia De Planta dropa Consumivel**

-   

**Jogador quebra Minerio Bruto**

-   

**Jogador completa Instanciamissao**

-   

**Jogador possui Inventario**

-   

**Jogador possui Habmineração**

-   

**Jogador possui Habcombate**

-   

**Jogador possui Habcultivo**

-   

**Jogador interage Instanciaanimal**

-   

**Jogador esta Ambiente**

-   

**Jogador ataca Instanciainimigo**

-   

**Jogador planta Semente**

-   

**Jogador rega Solo**

-   

**Inimigo possui Instanciainimigo**

-   

**Instanciainimigo pertence Caverna**

-   

**Caixa De Mensagem contem Instanciamissao**

-   

**Caverna contem Minerio Bruto**

-   

**Estoque possui Item**

-   

**Semente gera Instanciaplanta**

-   

**Mapa possui Ambiente**

-   

**Plantação possui Solo**

-   

**Casajogador possui Caixa De Mensagem**

-   

**Instaciaanimal está Celeiro**

-   

**Loja possui Estoque**

-   

**Loja melhora Estoque**

-   

