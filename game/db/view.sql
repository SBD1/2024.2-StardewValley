CREATE OR REPLACE VIEW vw_inventario_jogador AS
SELECT
    j.id_jogador,
    j.nome                  AS nome_jogador,
    inv.id_inventario,
    inst.fk_id_item,
    it.tipo_item,

    -- Aqui, usamos CASE para decidir de qual tabela especializada pegamos o nome
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

FROM Jogador j
JOIN inventario inv 
    ON j.id_jogador = inv.fk_id_jogador
JOIN instancia_de_item inst 
    ON inst.fk_id_inventario = inv.id_inventario
JOIN item it 
    ON it.id_item = inst.fk_id_item

-- Joins condicionais (cada tipo em um LEFT JOIN)
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
   AND it.tipo_item = 'recurso';
