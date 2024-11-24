## Versionamento

| Data | Versão | Autor | Alterações | 
| :--: | :----: | ----- | ---------- | 
| 23/11/2024 |  1.0 |  [Manuella Valadares](https://github.com/manuvaladares)| Criação do documento MER | 
| 23/11/2024 |  1.1 |  [Gabriel Fernando](https://github.com/MMcLovin)| Preenche [entidades](#1-entidades) e [atributos](#2-atributos) | 


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

- **plantação**

- **Recompensa**

- **Recurso**

- **Semente**

- **Solo**

- **Utensilio**

- **Habilidade**
    - **HabCombate**
    - **HabCultivo**
    - **HabMineração**

- **Item**
    - **consumivel**
    - **Semente**
    - **Utensilio**
        - **arma**
        - **ferramenta**

- **Missão**
    - **coleta**
    - **combate**

## 2. Atributos

- **Ambiente**: <ins>id_ambiente</ins>, `tipo`

- **Animal**: <ins>id</ins>, `nome`, `diasTotalDropar`, `tipo`, `itemDrop`, `preço`

- **Arma**: <ins>tipo_arma</ins>, `dano`

- **Caixa de Mensagem**: <ins>id_caixa</ins>

- **CasaJogador**: <ins>id</ins>, `id_jogador`

- **Caverna**: <ins>andar</ins>, `quantidade_mobs`, `minérios`, `item_recompensa`

- **Celeiro**: <ins>id_celeiro</ins>, `qtd_animais`

- **Coleta**: <ins>tipo</ins>, `tipoMaterial`, `quantidade`, `valorTotal`

- **Combate**: <ins>tipo</ins>, `tipoInimigo`, `quantidadeInimigo`

- **Consumível**: <ins>tipo_consumível</ins>, `duração`, `efeito`

- **Estoque**: <ins>produto</ins>, `preço`

- **Ferramenta**: <ins>tipo_ferramenta</ins>, `eficiência`

- **HabCombate**: <ins>id</ins>, `vidaBonus`, `danoBonus`

- **HabCultivo**: <ins>id</ins>, `reducaoEnergiaCultivar`, `cultivoBonus`

- **Habilidade**: <ins>id</ins>, `nível`, `tipo`, `xpMin`, `xpMax`

- **HabMineração**: <ins>id</ins>, `reducaoEnergiaMinerar`, `minerioBonus`

- **Inimigo**: <ins>id</ins>, `nome`, `tipo`, `vida`, `dano`

- **InstânciaAnimal**: <ins>id</ins>, `diasAtual`, `prontoDropar`

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

- **Recurso**: <ins>tipo_recurso</ins>, `***********`

- **Semente**: <ins>id</ins>, `bool_regou`, `diaAtual`, `diaDropar`, `prontoColher`

- **Solo**: <ins>tipo_recurso</ins>

- **Utensilio**: <ins></ins>, `**********`

## 3. Relacionamentos

**Personagem possui Inventário**
- descrição
