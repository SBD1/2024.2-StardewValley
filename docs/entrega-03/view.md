# Views usadas no jogo

Neste documento, você encontrará uma descrição das Views utilizadas no jogo, bem como exemplos de código para cada uma delas.

[Acessar no repositório](https://github.com/SBD1/2024.2-StardewValley)

### vw_inventario_jogador

Essa view exibe o inventário dos jogadores, listando os itens que possuem, suas quantidades e preços.

```sql
CREATE OR REPLACE VIEW vw_inventario_jogador AS
SELECT
    j.id_jogador,
    inst.fk_id_item,
    it.tipo_item,

    CASE
        WHEN it.tipo_item = 'mineral'     THEN mineral.nome
        WHEN it.tipo_item = 'ferramenta'  THEN ferramenta.nome
        WHEN it.tipo_item = 'arma'        THEN arma.nome
        WHEN it.tipo_item = 'consumivel'  THEN consumivel.nome
        WHEN it.tipo_item = 'recurso'     THEN recurso.nome
    END AS nome_item,

    COUNT(inst.fk_id_item) AS quantidade,

    CASE
        WHEN it.tipo_item = 'mineral'     THEN mineral.preco
        WHEN it.tipo_item = 'ferramenta'  THEN ferramenta.preco
        WHEN it.tipo_item = 'arma'        THEN arma.preco
        WHEN it.tipo_item = 'consumivel'  THEN consumivel.preco
        WHEN it.tipo_item = 'recurso'     THEN recurso.preco
    END AS preco_item

FROM Jogador j
JOIN inventario inv 
    ON j.id_jogador = inv.fk_id_jogador
JOIN instancia_de_item inst 
    ON inst.fk_id_inventario = inv.id_inventario
JOIN item it 
    ON it.id_item = inst.fk_id_item

LEFT JOIN mineral 
    ON mineral.fk_id_item = it.id_item
   AND it.tipo_item = 'mineral'

LEFT JOIN ferramenta
    ON ferramenta.fk_id_item = it.id_item
   AND it.tipo_item = 'ferramenta'

LEFT JOIN arma
    ON arma.fk_id_item = it.id_item
   AND it.tipo_item = 'arma'

LEFT JOIN consumivel
    ON consumivel.fk_id_item = it.id_item
   AND it.tipo_item = 'consumivel'

LEFT JOIN recurso
    ON recurso.fk_id_item = it.id_item
   AND it.tipo_item = 'recurso'

GROUP BY j.id_jogador,  inst.fk_id_item, it.tipo_item, 
         mineral.nome, ferramenta.nome, arma.nome, consumivel.nome, recurso.nome,
         mineral.preco, ferramenta.preco, arma.preco, consumivel.preco, recurso.preco;

```

### vw_catalogo_loja

Essa view exibe os itens disponíveis nas lojas, listando seus preços e categorias.

```sql
CREATE OR REPLACE VIEW vw_catalogo_loja AS
SELECT
    e.fk_id_loja,
    e.fk_id_item,
    it.tipo_item,

    CASE
        WHEN it.tipo_item = 'mineral'     THEN mineral.nome
        WHEN it.tipo_item = 'ferramenta'  THEN ferramenta.nome
        WHEN it.tipo_item = 'arma'        THEN arma.nome
        WHEN it.tipo_item = 'consumivel'  THEN consumivel.nome
        WHEN it.tipo_item = 'recurso'     THEN recurso.nome
    END AS nome_item,

    CASE
        WHEN it.tipo_item = 'mineral'     THEN mineral.preco
        WHEN it.tipo_item = 'ferramenta'  THEN ferramenta.preco
        WHEN it.tipo_item = 'arma'        THEN arma.preco
        WHEN it.tipo_item = 'consumivel'  THEN consumivel.preco
        WHEN it.tipo_item = 'recurso'     THEN recurso.preco
    END AS preco_item

FROM estoque e
JOIN item it 
    ON it.id_item = e.fk_id_item

LEFT JOIN mineral 
    ON mineral.fk_id_item = it.id_item
   AND it.tipo_item = 'mineral'

LEFT JOIN ferramenta
    ON ferramenta.fk_id_item = it.id_item
   AND it.tipo_item = 'ferramenta'

LEFT JOIN arma
    ON arma.fk_id_item = it.id_item
   AND it.tipo_item = 'arma'

LEFT JOIN consumivel
    ON consumivel.fk_id_item = it.id_item
   AND it.tipo_item = 'consumivel'

LEFT JOIN recurso
    ON recurso.fk_id_item = it.id_item
   AND it.tipo_item = 'recurso'
```


---

| Data       | Versão | Autor                                             | Alterações                   |
|------------|--------|---------------------------------------------------|------------------------------|
| 10/02/2025 | `1.0`  | [Manuella Valadares](https://github.com/manuvaladares)         | Criação do documento         |
| 10/02/2025 | `1.1`  | [Gabriel Zaranza](https://github.com/GZaranza)         | Adiciona os view |