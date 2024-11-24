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

()***** = entidade sem atributos até então :(

- **Jogador**: <ins>id</ins>, `nome`, `vidaAtual`, `vidaMax`, `estamina`, `nível`, `experiência`

- **Missão**: <ins>tipo</ins>, `nome`, `descrição`, `tipo`

- **InstânciaMissão**: <ins>id</ins>, `dataInicio`, `dataFinalização`, `status`

- **Recompensa**: <ins>id</ins>, `tipoItem`, `quantidade`

- **Item**: <ins>id_item</ins>, `nome`, `descrição`, `id_categoria`, `tipo_item`, `quantidade`

- **Animal**: <ins>id</ins>, `nome`, `diasTotalDropar`, `tipo`, `itemDrop`, `preço`

- **InstânciaAnimal**: <ins>id</ins>, `diasAtual`, `prontoDropar`

- **Combate**: <ins>tipo</ins>, `tipoInimigo`, `quantidadeInimigo`

- **Coleta**: <ins>tipo</ins>, `tipoMaterial`, `quantidade`, `valorTotal`

- **Inimigo**: <ins>id</ins>, `nome`, `tipo`, `vida`, `dano`

- **InstânciaInimigo**: <ins>id</ins>, `id_inimigo`, `vidaAtual`

- **Habilidade**: <ins>id</ins>, `nível`, `tipo`, `xpMin`, `xpMax`

- **HabMineração**: <ins>id</ins>, `reducaoEnergiaMinerar`, `minerioBonus`

- **HabCombate**: <ins>id</ins>, `vidaBonus`, `danoBonus`

- **HabCultivo**: <ins>id</ins>, `reducaoEnergiaCultivar`, `cultivoBonus`

- **Semente**: <ins>id</ins>, `bool_regou`, `diaAtual`, `diaDropar`, `prontoColher`

- **InstânciaPlanta**: <ins>id</ins>, `nome`, `diaDropar`, `plantaDrop`

- **Ambiente**: <ins>id_ambiente</ins>, `tipo`

- **Mapa**: <ins>idMapa</ins>, `nome`

- **Caverna**: <ins>andar</ins>, `quantidade_mobs`, `minérios`, `item_recompensa`

- **Plantação**: `qtd_plantas`

- **CasaJogador**: <ins>id</ins>, `id_jogador`********************

- **Loja**: <ins>id_loja</ins>, `proprietário`, `nome`, `descrição`

- **Celeiro**: <ins>id_celeiro</ins>, `qtd_animais`

- **Inventário**: <ins>id</ins>, `quantidade_item`

## 3. Relacionamentos

**Personagem possui Inventário**
- descrição
