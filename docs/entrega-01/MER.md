## Versionamento

| Data | Versão | Autor | Alterações | 
| :--: | :----: | ----- | ---------- | 
| 23/11/2024 |  1.0 |  [Manuella Valadares](https://github.com/manuvaladares)| Criação do documento MER | 
| 23/11/2024 |  1.1 |  [Gabriel Fernando](https://github.com/MMcLovin)| [Preenche entidades](#1-entidades) e [atributos](#2-atributos) | 


# Modelo Entidade-Relacionamento

O Modelo Entidade Relacionamento para bancos de dados é um modelo que descreve os objetos (entidades) envolvidos em um negócio, com suas características (atributos) e como elas se relacionam entre si (relacionamentos).

## 1. Entidades

- **Jogador**

- **Missão**
    - **combate**
    - **coleta**

- **InstânciaMissão**

- **Recompensa**

- **inventário**

- **InstânciaItem**

- **Item**
    - **utensílio**
        - **ferramenta**
        - **armas**
    - **Equipamento**
        - **Arma**
        - **Armadura**
        - **Acessório**
    - **Consumível**

- **Minério**

- **Animal**

- **InstânciaAnimal**

- **Inimigo**

- **InstânciaInimigo**

- **Habilidade**
    - **HabMineração**
    - **HabCombate**
    - **HabCultivo**

- **Mapa**

- **Ambiente**
    - **Caverna**
    - **Plantação**
    - **CasaJogador**
    - **Loja**
    - **Celeiro**

- **solo**

- **Semente**

- **InstânciaPlanta**

- **caixa de mensagem**

- **inventário "estoque"**

- **Andar**

## 2. Atributos

- **Jogador**: <ins>id</ins>, `nome`, `vidaAtual`, `vidaMax`, `estamina`, `nível`, `experiência`

- **Missão**: <ins>tipo</ins>, `nome`, `descrição`, `tipo`

- **InstânciaMissão**: <ins>id</ins>, `dataInicio`, `dataFinalização`, `status`

- **Recompensa**: <ins>id</ins>, `tipoItem`, `quantidade`

- **Item**: <ins>id_item</ins>, `nome`, `descrição`, `id_categoria`, `tipo_item`, `quantidade`

- **Animal**: <ins>id</ins>, `nome`, `diasTotalDropar`, `tipo`, `itemDrop`, `preço`

- **InstânciaAnimal**: <ins>id</ins>, `diasAtual`, `prontoDropar`

- **Combate**: <ins>tipo</ins>, `tipoInimigo`, `quantidadeInimigo`

- **Coleta**: <ins>tipo</ins>, `tipoMaterial`, `quantidade`, `valorTotal`

- **Inimigo**: <ins>id</ins>, (`nome`, `tipo`, `vida`, `dano`, `experiência`)*****

- **InstânciaInimigo**: <ins>id</ins>, (`id_inimigo`, `vidaAtual`)*****

- **Habilidade**: <ins>id</ins>, `nível`, `tipo`, `xpMin`, `xpMax`

- **HabMineração**: <ins>id</ins>, `reducaoEnergiaMinerar`, `minerioBonus`

- **HabCombate**: <ins>id</ins>, `vidaBonus`, `danoBonus`

- **HabCultivo**: <ins>id</ins>, `reducaoEnergiaCultivar`, `cultivoBonus`

- **Semente**: <ins>id</ins>, `bool_regou`, `diaAtual`, `diaDropar`, `prontoColher`

- **InstânciaPlanta**: <ins>id</ins>, `nome`, `diaDropar`, `plantaDrop`

- **Ambiente**: <ins>id</ins>, (`nome`, `tipo`)*****

- **Mapa**: <ins>id</ins>, (`nome`)*****

- **Caverna**: <ins>id</ins>, (`nome`)*****

- **Plantação**: <ins>id</ins>, (`nome`, `qtd_plantas`)*****

- **CasaJogador**: <ins>id</ins>, (`id_jogador`)*****

- **Loja**: <ins>id</ins>()*****

- **Celeiro**: <ins>id</ins>, (`id_jogador`, `qtd_animais`)*****

- **Inventário**: <ins>id</ins>, (`id_jogador`, `estoque`, `capacidade`)*****

## 3. Relacionamentos

**Personagem possui Inventário**
- descrição
