-- ---------------------------------------------------------------------------------------------------------------
-- Data de Criação ........: 03/02/2025                                                                         --
-- Autor(es) ..............: Gabriel Silva, Gabriel Zaranza, Isaac Batista, Manuella Valadares, Marcos Marinho  --
-- Versão .................: 1.2                                                                                --
-- Banco de Dados .........: PostgreSQL                                                                         --
-- Descrição ..............: SELECTs utilizados no projeto                                                      --
-- ---------------------------------------------------------------------------------------------------------------

--Listar os personagens criados no jogo
SELECT id_jogador, nome 
FROM Jogador;

--Retornar os atributos de um jogador pelo id(%s)
SELECT * 
FROM Jogador 
WHERE id_jogador = <id_Jogador>;

--Retornar o ambiente que um jogador se encontra pelo id(%s)
SELECT * 
FROM Ambiente 
WHERE fk_jogador_id = <id_Jogador>;

--Retornar os atributos de um ambiente pelo id(%s)
SELECT * 
FROM Ambiente 
WHERE id_ambiente = <id_ambiente>;

--Retornar atributos da habilidade de mineração do jogador(%s)
SELECT 
    fk_Habilidade_id, 
    nivel, 
    reducaoEnergiaMinera,
    minerioBonus,
    xpMin,
    xpMax 
FROM habMineracao 
WHERE fk_Habilidade_id = <id_habilidade>;

--Retornar atributos da habilidade de combate do jogador(%s)
SELECT 
    fk_Habilidade_id, 
    nivel, 
    vidaBonus,
    danoBonus,
    xpMin,
    xpMax 
FROM habCombate 
WHERE fk_Habilidade_id = <id_habilidade>;

--Retornar atributos da habilidade de cultivo do jogador(%s)
SELECT 
    fk_Habilidade_id, 
    nivel, 
    cultivoBonus,
    reducaoEnergiaCultiva,
    xpMin,
    xpMax 
FROM habCultivo 
WHERE fk_Habilidade_id = <id_habilidade>;

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
    l.nome = 'Armazém do Pierre' AND i.tipo_item = 'recurso' ;

--retornar os atributos de um inimigo pelo id(%s)
SELECT *
FROM inimigo
WHERE nome = <nome_inimigo>;

SELECT *
FROM Animal
WHERE id_animal = <id_animal>
-- Listar os itens de um inventário específico
SELECT i.id_item, i.tipo_item, i.fk_inventario_id
FROM item i
JOIN inventario inv ON i.fk_inventario_id = inv.id_inventario
WHERE inv.fk_id_jogador = 0;

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

SELECT ins.id_instancia_de_animal, ins.nome_animal, hpp.preco FROM Instancia_de_Animal ins INNER JOIN Animal hpp ON ins.fk_animal_id = hpp.id_animal WHERE fk_jogador_id = <id_jogador>;

SELECT ia.id_instancia_de_animal, ia.nome_animal, ia.prontoDropa, a.diasTotalDropar, ia.fk_animal_id 
FROM Instancia_de_Animal ia
JOIN Animal a ON ia.fk_animal_id = a.id_animal
WHERE ia.fk_Jogador_id = <id_jogador> AND a.diasTotalDropar > 0;

SELECT id_instancia_de_planta, nome, prontoColher, diaAtual FROM Instancia_de_Planta WHERE fk_id_jogador = <id_jogador>;

SELECT ins.id_instancia_de_planta, ins.nome, pp.preco 
FROM Instancia_de_Planta ins 
INNER JOIN Planta pp ON ins.fk_id_planta = pp.id_planta 
WHERE ins.fk_id_jogador = <id_jogador>;

