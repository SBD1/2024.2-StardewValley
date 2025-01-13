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