--Listar os personagens criados no jogo
SELECT id_jogador, nome 
FROM Jogador

--Retornar os atributos de um jogador pelo id(%s)
SELECT * 
FROM Jogador 
WHERE id_jogador = %s

--Retornar o ambiente que um jogador se encontra pelo id(%s)
SELECT * 
FROM Ambiente 
WHERE fk_jogador_id = %s 

--Retornar os atributos de um ambiente pelo id(%s)
SELECT * 
FROM Ambiente 
WHERE id_ambiente = %s

--Listar as habilidades do jogador atravez do fk_habilidade_id(%s)
SELECT * 
FROM Habilidade 
WHERE id_habilidade in (%s,%s,%s)

--Retornar atributos da habilidade de mineração do jogador(%s)
SELECT 
    fk_Habilidade_id, 
    nivel, 
    reducaoEnergiaMinera,
    minerioBonus,
    xpMin,
    xpMax 
FROM habMineracao 
WHERE fk_Habilidade_id = %s

--Retornar atributos da habilidade de combate do jogador(%s)
SELECT 
    fk_Habilidade_id, 
    nivel, 
    vidaBonus,
    danoBonus,
    xpMin,
    xpMax 
FROM habCombate 
WHERE fk_Habilidade_id = %s

--Retornar atributos da habilidade de cultivo do jogador(%s)
SELECT 
    fk_Habilidade_id, 
    nivel, 
    cultivoBonus,
    reducaoEnergiaCultiva,
    xpMin,
    xpMax 
FROM habCultivo 
WHERE fk_Habilidade_id = %s

--Retornar estoque de uma loja específica.
SELECT 
    l.nome,
    i.id_item,
    i.tipo_item
FROM 
    loja l
JOIN 
    estoque e ON l.fk_id_estoque = e.id_estoque
JOIN 
    item i ON i.fk_estoque = e.id_estoque
WHERE 
    l.nome = 'Armazém do Pierre' AND i.tipo_item = 'recurso'; 

--retornar os atributos de um inimigo pelo id(%s)
SELECT *
FROM inimigo
WHERE nome = %s

SELECT *
FROM Animal
WHERE id_animal = %s

-- Listar os itens de um inventário específico
SELECT i.id_item, i.tipo_item, i.fk_inventario_id
FROM item i
JOIN inventario inv ON i.fk_inventario_id = inv.id_inventario
WHERE inv.fk_id_jogador = 0

-- Esta consulta SQL seleciona o nome do jogador e os níveis de habilidades de mineração, combate e cultivo.
SELECT 
    j.nome AS jogador_nome,
    hm.nivel AS nivel_mineracao,
    hc.nivel AS nivel_combate,
    hcu.nivel AS nivel_cultivo
FROM 
    Jogador j
JOIN 
    habMineracao hm ON j.fk_habMineracao_fk_Habilidade_id = hm.fk_Habilidade_id
JOIN 
    habCombate hc ON j.fk_habCombate_fk_Habilidade_id = hc.fk_Habilidade_id
JOIN 
    habCultivo hcu ON j.fk_habCultivo_fk_Habilidade_id = hcu.fk_Habilidade_id;